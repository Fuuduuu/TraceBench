import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:trace_bench_viewer/shared/models/known_facts.dart';
import 'package:trace_bench_viewer/shared/models/project_manifest.dart';
import 'package:trace_bench_viewer/shared/models/project_state.dart';
import 'package:trace_bench_viewer/shared/models/trace_bench_event.dart';
import 'package:trace_bench_viewer/shared/services/project_projection_refresher.dart';
import 'package:trace_bench_viewer/shared/services/python_runner.dart';

TraceBenchEvent _event(String id, {int value = 1}) => TraceBenchEvent.fromJson({
      'schema_version': '2.0',
      'event_id': id,
      'project_id': 'refresh-test',
      'created_at': '2026-10-29T00:00:00Z',
      'actor': {'source': 'human'},
      'event_type': 'measurement_recorded',
      'status': 'accepted',
      'payload': {
        'reading': {'value': value, 'unit': 'V'},
      },
    });

ProjectState _project({
  String id = 'refresh-test',
  String? directory = '/local/refresh-test',
  ProjectionFreshness freshness = ProjectionFreshness.stale,
  List<TraceBenchEvent>? events,
}) =>
    ProjectState(
      manifest: ProjectManifest(
        projectId: id,
        schemaVersion: '1.0',
        createdAt: '2026-10-29T00:00:00Z',
        deviceType: 'board',
        model: 'test',
        symptom: 'test',
      ),
      knownFacts: KnownFacts.fromJson({'project_id': id}),
      events: events ?? [_event('saved-before-refresh')],
      customerReport: '',
      projectDirectory: directory,
      projectionFreshness: freshness,
    );

class _Platform extends PlatformInfo {
  const _Platform({this.mobile = false});
  final bool mobile;
  @override
  bool get isMobile => mobile;
}

class _Runner extends ProcessRunner {
  final calls = <List<String>>[];
  bool missingPython = false;
  bool processThrows = false;
  int materializerExit = 0;

  @override
  Future<ProcessResult> run({
    required List<String> command,
    required String workingDirectory,
    required Duration timeout,
  }) async {
    calls.add(List.of(command));
    if (command.last == '--version') {
      return ProcessResult(0, missingPython ? 1 : 0, '', '');
    }
    if (processThrows) {
      throw const ProcessException('python', [], 'private path');
    }
    return ProcessResult(0, materializerExit, '', 'private process detail');
  }
}

Matcher _failure(ProjectionRefreshFailure reason) =>
    throwsA(isA<ProjectionRefreshException>()
        .having((e) => e.failure, 'failure', reason));

void main() {
  late _Runner runner;
  late ProjectState loaded;
  late int loads;
  late ProjectProjectionRefresher refresher;

  setUp(() {
    runner = _Runner();
    loaded = _project(freshness: ProjectionFreshness.fresh);
    loads = 0;
    refresher = ProjectProjectionRefresher(
      pythonRunner: PythonRunner(
        processRunner: runner,
        platformInfo: const _Platform(),
      ),
      directoryLoader: (path) async {
        expect(path, '/local/refresh-test');
        loads++;
        return loaded;
      },
    );
  });

  test('materializes existing directory and reloads without any ZIP command',
      () async {
    final snapshot = _project();
    final result = await refresher.refresh(snapshot);
    expect(result.projectDirectory, snapshot.projectDirectory);
    expect(result.manifest.projectId, 'refresh-test');
    expect(result.isProjectionStale, isFalse);
    expect(result.events.single.eventId, 'saved-before-refresh');
    expect(loads, 1);
    final command = runner.calls.last;
    expect(command, [
      'py',
      '-3',
      '-X',
      'utf8',
      '-B',
      'tools/materialize_known_facts.py',
      '/local/refresh-test${Platform.pathSeparator}events.jsonl',
      '/local/refresh-test${Platform.pathSeparator}known_facts.json',
    ]);
    expect(runner.calls.length, 2);
  });

  for (final directory in <String?>[null, '', '  ']) {
    test('missing local directory rejects before process or loader: $directory',
        () async {
      await expectLater(refresher.refresh(_project(directory: directory)),
          _failure(ProjectionRefreshFailure.noDirectory));
      expect(runner.calls, isEmpty);
      expect(loads, 0);
    });
  }

  test('missing Python leaves projection unchanged and does not reload',
      () async {
    runner.missingPython = true;
    final snapshot = _project();
    await expectLater(refresher.refresh(snapshot),
        _failure(ProjectionRefreshFailure.pythonUnavailable));
    expect(loads, 0);
    expect(snapshot.isProjectionStale, isTrue);
    expect(snapshot.events.single.eventId, 'saved-before-refresh');
  });

  for (final throwsProcess in [false, true]) {
    test('materializer failure never loads a result (throws=$throwsProcess)',
        () async {
      runner.materializerExit = 1;
      runner.processThrows = throwsProcess;
      await expectLater(refresher.refresh(_project()),
          _failure(ProjectionRefreshFailure.materializerFailed));
      expect(loads, 0);
    });
  }

  test('reload exception is sanitized and permits a later retry', () async {
    var fail = true;
    final service = ProjectProjectionRefresher(
      pythonRunner: PythonRunner(processRunner: runner),
      directoryLoader: (_) async {
        if (fail) throw const FormatException('private damaged file path');
        return loaded;
      },
    );
    await expectLater(service.refresh(_project()),
        _failure(ProjectionRefreshFailure.reloadFailed));
    fail = false;
    expect((await service.refresh(_project())).isProjectionStale, isFalse);
  });

  test('mobile does not attempt a local Python process', () async {
    final service = ProjectProjectionRefresher(
      pythonRunner: PythonRunner(
        processRunner: runner,
        platformInfo: const _Platform(mobile: true),
      ),
    );
    await expectLater(service.refresh(_project()),
        _failure(ProjectionRefreshFailure.unsupportedPlatform));
    expect(runner.calls, isEmpty);
  });

  for (final wrongDirectory in [false, true]) {
    test('rejects another project identity or directory ($wrongDirectory)',
        () async {
      loaded = wrongDirectory
          ? _project(
              directory: '/local/another', freshness: ProjectionFreshness.fresh)
          : _project(
              id: 'another-project', freshness: ProjectionFreshness.fresh);
      await expectLater(refresher.refresh(_project()),
          _failure(ProjectionRefreshFailure.projectMismatch));
    });
  }

  test('rejects a mismatching known-facts project identity', () async {
    loaded = loaded.copyWith(
        knownFacts: KnownFacts.fromJson({'project_id': 'another-project'}));
    await expectLater(refresher.refresh(_project()),
        _failure(ProjectionRefreshFailure.projectMismatch));
  });

  for (final changedPayload in [false, true]) {
    test('never drops or mutates a pending accepted event ($changedPayload)',
        () async {
      loaded = loaded.copyWith(
          events: changedPayload
              ? [_event('saved-before-refresh', value: 999)]
              : []);
      await expectLater(refresher.refresh(_project()),
          _failure(ProjectionRefreshFailure.eventsChanged));
    });
  }

  for (final freshness in [
    ProjectionFreshness.stale,
    ProjectionFreshness.unknown
  ]) {
    test('does not accept a reload without fresh provenance: $freshness',
        () async {
      loaded = _project(freshness: freshness);
      await expectLater(refresher.refresh(_project()),
          _failure(ProjectionRefreshFailure.notFresh));
    });
  }

  test('accepts a fresh disk event superset without losing prior accepted data',
      () async {
    loaded = loaded.copyWith(events: [
      _event('saved-before-refresh'),
      _event('additional-disk-event'),
    ]);
    final result = await refresher.refresh(_project());
    expect(result.events.map((e) => e.eventId),
        ['saved-before-refresh', 'additional-disk-event']);
  });
}
