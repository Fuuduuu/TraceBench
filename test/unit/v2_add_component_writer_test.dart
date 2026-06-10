import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:trace_bench_viewer/features/components/services/v2_add_component_writer.dart';
import 'package:trace_bench_viewer/shared/models/known_facts.dart';
import 'package:trace_bench_viewer/shared/models/project_manifest.dart';
import 'package:trace_bench_viewer/shared/models/project_state.dart';
import 'package:trace_bench_viewer/shared/models/trace_bench_event.dart';
import 'package:trace_bench_viewer/shared/services/python_runner.dart';

class _RunCall {
  const _RunCall({
    required this.command,
    required this.workingDirectory,
  });

  final List<String> command;
  final String workingDirectory;
}

class _FakeProcessRunner extends ProcessRunner {
  _FakeProcessRunner(this._handler);

  final ProcessResult Function(List<String> command) _handler;
  final List<_RunCall> calls = <_RunCall>[];
  final List<Map<String, dynamic>> candidates = <Map<String, dynamic>>[];

  @override
  Future<ProcessResult> run({
    required List<String> command,
    required String workingDirectory,
    required Duration timeout,
  }) async {
    calls.add(
      _RunCall(
        command: List<String>.from(command),
        workingDirectory: workingDirectory,
      ),
    );
    if (command.any((part) => part.contains('event_writer_service.py'))) {
      final candidatePath = command.last;
      candidates.add(
        jsonDecode(File(candidatePath).readAsStringSync())
            as Map<String, dynamic>,
      );
    }
    return _handler(command);
  }
}

ProcessResult _success([String stdout = 'ok']) =>
    ProcessResult(0, 0, stdout, '');

ProcessResult _failure(String stderr) => ProcessResult(0, 1, '', stderr);

ProjectState _projectState(Directory directory, {String? projectDirectory}) {
  return ProjectState(
    manifest: const ProjectManifest(
      projectId: 'add_component_project',
      schemaVersion: '1.0',
      createdAt: '2026-05-22T00:00:00Z',
      deviceType: 'bench_board',
      model: 'PV20',
      symptom: 'not_provided',
    ),
    knownFacts: KnownFacts.fromJson({
      'project_id': 'add_component_project',
      'components': const [],
      'pins': const [],
      'measurements': const [],
      'component_pin_index': const <String, dynamic>{},
    }),
    events: const [
      TraceBenchEvent(
        schemaVersion: '1.0',
        eventId: 'evt_000001',
        projectId: 'add_component_project',
        sequence: 1,
        createdAt: '2026-05-22T00:00:00Z',
        actor: {'type': 'user', 'id': 'tester'},
        eventType: 'project_created',
        status: 'accepted',
        payload: {'status': 'created'},
      ),
    ],
    customerReport: 'Inline report',
    projectDirectory: projectDirectory ?? directory.path,
  );
}

String _joinPathForTest(String base, String child) {
  if (base.endsWith('/') || base.endsWith('\\')) {
    return '$base$child';
  }
  return '$base${Platform.pathSeparator}$child';
}

List<String> _writerCommand(_FakeProcessRunner runner) {
  return runner.calls.map((call) => call.command).firstWhere(
        (command) =>
            command.any((part) => part.contains('event_writer_service.py')),
      );
}

bool _writerWasCalled(_FakeProcessRunner runner) {
  return runner.calls.any(
    (call) =>
        call.command.any((part) => part.contains('event_writer_service.py')),
  );
}

V2AddComponentRequest _request() {
  return const V2AddComponentRequest(
    componentId: 'U10',
    label: 'U10',
    componentKind: 'unknown',
    referenceDesignator: 'U10',
    packageHint: 'SOIC-8',
    footprintHint: 'SOIC',
    templateIdHint: 'tpl_soic_8',
    humanNote: 'visual package hint only',
    clientOperationId: 'op_add_component_u10_unknown',
  );
}

void main() {
  group('V2AddComponentService', () {
    test('builds V2 component_created event and calls writer service',
        () async {
      final directory =
          Directory.systemTemp.createTempSync('tracebench-v2-add-test-');
      addTearDown(() => directory.deleteSync(recursive: true));
      File('${directory.path}/events.jsonl').writeAsStringSync('');

      final runner = _FakeProcessRunner((command) {
        if (command.last == '--version') {
          return _success('Python 3.12.0');
        }
        return _success('[OK] appended: evt_000002');
      });
      final service = V2AddComponentService(
        processRunner: runner,
        repoRootPath: Directory.current.path,
        now: () => DateTime.utc(2026, 6, 9, 10),
        eventIdGenerator: () => 'evt_000002',
      );

      final result = await service.addComponent(
        projectState: _projectState(directory),
        request: _request(),
      );

      expect(result.status, V2AddComponentWriteStatus.appended);
      expect(runner.candidates, hasLength(1));
      final candidate = runner.candidates.single;
      expect(candidate['schema_version'], '2.0-draft');
      expect(candidate['event_id'], 'evt_000002');
      expect(candidate['event_type'], 'component_created');
      expect(candidate['project_id'], 'add_component_project');
      expect(candidate['client_operation_id'], 'op_add_component_u10_unknown');
      expect(candidate['actor'], {'type': 'human', 'id': 'local_operator'});
      expect(candidate['source'], {
        'type': 'explicit_user_confirmation',
        'surface': 'add_component',
        'action': 'add_component',
      });
      expect(candidate['confirmation'], {
        'confirmed': true,
        'confirmed_at': '2026-06-09T10:00:00.000Z',
      });

      final payload = candidate['payload'] as Map<String, dynamic>;
      expect(payload['component_id'], 'U10');
      expect(payload['label'], 'U10');
      expect(payload['component_kind'], 'unknown');
      expect(payload['created_context'], 'human_entered');
      expect(payload['reference_designator'], 'U10');
      expect(payload['package_hint'], 'SOIC-8');
      expect(payload['footprint_hint'], 'SOIC');
      expect(payload['template_id_hint'], 'tpl_soic_8');
      expect(payload['human_note'], 'visual package hint only');
      expect(payload.containsKey('identity_proof'), isFalse);
      expect(payload.containsKey('net_proof'), isFalse);
      expect(payload.containsKey('measurement_proof'), isFalse);
      expect(payload.containsKey('fault_proof'), isFalse);
      expect(payload.containsKey('confirmed_identity'), isFalse);
      expect(payload.containsKey('photo_proof'), isFalse);
      expect(payload.containsKey('ai_confidence'), isFalse);
      expect(payload.containsKey('probability'), isFalse);
      expect(payload.containsKey('diagnosis'), isFalse);
      expect(candidate.containsKey('sequence'), isFalse);
      expect(candidate.containsKey('status'), isFalse);

      final writerCommand = _writerCommand(runner);
      expect(writerCommand, contains('tools/event_writer_service.py'));
      expect(writerCommand,
          contains('${directory.path}${Platform.pathSeparator}events.jsonl'));
      expect(
        runner.calls.any((call) =>
            call.command.any((part) => part.contains('export_project_zip.py'))),
        isFalse,
      );
      expect(
        runner.calls.any((call) => call.command
            .any((part) => part.contains('materialize_known_facts.py'))),
        isFalse,
      );
    });

    test('canonicalizes project directory before writer invocation', () async {
      final directory =
          Directory.systemTemp.createTempSync('tracebench-v2-add-test-');
      addTearDown(() => directory.deleteSync(recursive: true));
      final canonicalDirectory = directory.resolveSymbolicLinksSync();
      File(_joinPathForTest(canonicalDirectory, 'events.jsonl'))
          .writeAsStringSync('');

      final runner = _FakeProcessRunner((command) {
        if (command.last == '--version') {
          return _success('Python 3.12.0');
        }
        return _success('[OK] appended: evt_000002');
      });
      final service = V2AddComponentService(
        processRunner: runner,
        repoRootPath: Directory.current.path,
        now: () => DateTime.utc(2026, 6, 9, 10),
        eventIdGenerator: () => 'evt_000002',
      );

      await service.addComponent(
        projectState: _projectState(
          directory,
          projectDirectory: directory.path,
        ),
        request: _request(),
      );

      expect(
        _writerCommand(runner),
        contains(_joinPathForTest(canonicalDirectory, 'events.jsonl')),
      );
    });

    test('returns existing status when writer reports existing', () async {
      final directory =
          Directory.systemTemp.createTempSync('tracebench-v2-add-test-');
      addTearDown(() => directory.deleteSync(recursive: true));
      File('${directory.path}/events.jsonl').writeAsStringSync('');

      final runner = _FakeProcessRunner((command) {
        if (command.last == '--version') {
          return _success('Python 3.12.0');
        }
        return _success('[OK] existing: evt_000002');
      });
      final service = V2AddComponentService(
        processRunner: runner,
        repoRootPath: Directory.current.path,
        now: () => DateTime.utc(2026, 6, 9, 10),
        eventIdGenerator: () => 'evt_000002',
      );

      final result = await service.addComponent(
        projectState: _projectState(directory),
        request: _request(),
      );

      expect(result.status, V2AddComponentWriteStatus.existing);
      expect(result.event['event_type'], 'component_created');
    });

    test('rejects missing project directory before writer invocation',
        () async {
      final directory =
          Directory.systemTemp.createTempSync('tracebench-v2-add-test-');
      final missingDirectory =
          Directory(_joinPathForTest(directory.path, 'missing'));
      addTearDown(() => directory.deleteSync(recursive: true));
      final runner = _FakeProcessRunner((command) {
        if (command.last == '--version') {
          return _success('Python 3.12.0');
        }
        return _success('[OK] appended: evt_000002');
      });
      final service = V2AddComponentService(
        processRunner: runner,
        repoRootPath: Directory.current.path,
      );

      await expectLater(
        service.addComponent(
          projectState: _projectState(
            directory,
            projectDirectory: missingDirectory.path,
          ),
          request: _request(),
        ),
        throwsA(
          isA<V2AddComponentException>().having(
            (error) => error.kind,
            'kind',
            V2AddComponentFailureKind.invalidProjectDirectory,
          ),
        ),
      );
      expect(runner.calls, isEmpty);
      expect(_writerWasCalled(runner), isFalse);
    });

    test('rejects relative project directory before writer invocation',
        () async {
      final directory =
          Directory.systemTemp.createTempSync('tracebench-v2-add-test-');
      addTearDown(() => directory.deleteSync(recursive: true));
      final runner = _FakeProcessRunner((command) {
        if (command.last == '--version') {
          return _success('Python 3.12.0');
        }
        return _success('[OK] appended: evt_000002');
      });
      final service = V2AddComponentService(
        processRunner: runner,
        repoRootPath: Directory.current.path,
      );

      await expectLater(
        service.addComponent(
          projectState: _projectState(
            directory,
            projectDirectory: 'relative_project',
          ),
          request: _request(),
        ),
        throwsA(
          isA<V2AddComponentException>().having(
            (error) => error.kind,
            'kind',
            V2AddComponentFailureKind.invalidProjectDirectory,
          ),
        ),
      );
      expect(runner.calls, isEmpty);
      expect(_writerWasCalled(runner), isFalse);
    });

    test(
        'rejects traversal-like project directory so events.jsonl cannot escape',
        () async {
      final parent =
          Directory.systemTemp.createTempSync('tracebench-v2-add-test-');
      final selected = Directory(_joinPathForTest(parent.path, 'selected'))
        ..createSync();
      final escaped = Directory(_joinPathForTest(parent.path, 'escaped'))
        ..createSync();
      File(_joinPathForTest(selected.path, 'events.jsonl'))
          .writeAsStringSync('');
      addTearDown(() => parent.deleteSync(recursive: true));
      final escapedName = escaped.path.split(RegExp(r'[\\/]+')).last;
      final traversalPath = [
        selected.path,
        '..',
        escapedName,
      ].join(Platform.pathSeparator);
      final runner = _FakeProcessRunner((command) {
        if (command.last == '--version') {
          return _success('Python 3.12.0');
        }
        return _success('[OK] appended: evt_000002');
      });
      final service = V2AddComponentService(
        processRunner: runner,
        repoRootPath: Directory.current.path,
      );

      await expectLater(
        service.addComponent(
          projectState: _projectState(
            selected,
            projectDirectory: traversalPath,
          ),
          request: _request(),
        ),
        throwsA(
          isA<V2AddComponentException>().having(
            (error) => error.kind,
            'kind',
            V2AddComponentFailureKind.invalidProjectDirectory,
          ),
        ),
      );
      expect(runner.calls, isEmpty);
      expect(_writerWasCalled(runner), isFalse);
    });

    test('maps validator failure to validation not-saved kind', () async {
      final directory =
          Directory.systemTemp.createTempSync('tracebench-v2-add-test-');
      addTearDown(() => directory.deleteSync(recursive: true));
      File('${directory.path}/events.jsonl').writeAsStringSync('');
      final runner = _FakeProcessRunner((command) {
        if (command.last == '--version') {
          return _success('Python 3.12.0');
        }
        return _failure('[ERROR] candidate event failed validation');
      });

      final service = V2AddComponentService(
        processRunner: runner,
        repoRootPath: Directory.current.path,
        now: () => DateTime.utc(2026, 6, 9, 10),
      );

      expect(
        () => service.addComponent(
          projectState: _projectState(directory),
          request: _request(),
        ),
        throwsA(
          isA<V2AddComponentException>().having(
            (error) => error.kind,
            'kind',
            V2AddComponentFailureKind.validation,
          ),
        ),
      );
    });

    test('maps lock conflict to retryable not-saved kind', () async {
      final directory =
          Directory.systemTemp.createTempSync('tracebench-v2-add-test-');
      addTearDown(() => directory.deleteSync(recursive: true));
      File('${directory.path}/events.jsonl').writeAsStringSync('');
      final runner = _FakeProcessRunner((command) {
        if (command.last == '--version') {
          return _success('Python 3.12.0');
        }
        return _failure('[ERROR] event writer lock is already held');
      });

      final service = V2AddComponentService(
        processRunner: runner,
        repoRootPath: Directory.current.path,
        now: () => DateTime.utc(2026, 6, 9, 10),
      );

      expect(
        () => service.addComponent(
          projectState: _projectState(directory),
          request: _request(),
        ),
        throwsA(
          isA<V2AddComponentException>().having(
            (error) => error.kind,
            'kind',
            V2AddComponentFailureKind.lockConflict,
          ),
        ),
      );
    });
  });
}
