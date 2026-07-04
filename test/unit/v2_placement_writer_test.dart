import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:trace_bench_viewer/features/components/services/v2_placement_writer.dart';
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

ProjectState _projectState(
  Directory directory, {
  String? projectDirectory,
  bool includeComponent = true,
}) {
  return ProjectState(
    manifest: const ProjectManifest(
      projectId: 'placement_project',
      schemaVersion: '1.0',
      createdAt: '2026-05-22T00:00:00Z',
      deviceType: 'bench_board',
      model: 'PV20',
      symptom: 'not_provided',
    ),
    knownFacts: KnownFacts.fromJson({
      'project_id': 'placement_project',
      'components': includeComponent
          ? [
              {
                'component_id': 'cmp_r101',
                'designator': 'R101',
                'type': 'unknown',
                'status': 'unknown',
              }
            ]
          : const [],
      'pins': const [],
      'measurements': const [],
      'component_pin_index': const <String, dynamic>{},
    }),
    events: const [
      TraceBenchEvent(
        schemaVersion: '2.0-draft',
        eventId: 'evt_000001',
        projectId: 'placement_project',
        sequence: 1,
        createdAt: '2026-06-09T09:00:00.000Z',
        actor: {'type': 'human', 'id': 'local_operator'},
        eventType: 'component_created',
        status: 'accepted',
        payload: {
          'component_id': 'cmp_r101',
          'label': 'R101',
          'component_kind': 'unknown',
          'created_context': 'human_entered',
        },
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

V2PlacementWriterRequest _request({
  String componentId = 'cmp_r101',
  String clientOperationId = 'op_place_cmp_r101',
  num rotationDeg = 90,
}) {
  return V2PlacementWriterRequest(
    componentId: componentId,
    coordinateSpace: 'board_normalized',
    boardSide: 'top',
    centerX: 0.42,
    centerY: 0.58,
    rotationDeg: rotationDeg,
    width: 1.2,
    height: 0.7,
    templateId: 'template_family_rect_2_top_bottom',
    sourcePhotoId: 'photo_top',
    notes: 'visual placement only',
    clientOperationId: clientOperationId,
  );
}

void main() {
  group('V2PlacementService', () {
    test('builds V2 human-confirmed component_visual_placement_confirmed event',
        () async {
      final directory =
          Directory.systemTemp.createTempSync('tracebench-v2-place-test-');
      addTearDown(() => directory.deleteSync(recursive: true));
      File('${directory.path}/events.jsonl').writeAsStringSync('');

      final runner = _FakeProcessRunner((command) {
        if (command.last == '--version') {
          return _success('Python 3.12.0');
        }
        return _success('[OK] appended: evt_000002');
      });
      final service = V2PlacementService(
        processRunner: runner,
        repoRootPath: Directory.current.path,
        now: () => DateTime.utc(2026, 6, 10, 12),
        eventIdGenerator: () => 'evt_000002',
      );

      final result = await service.confirmPlacement(
        projectState: _projectState(directory),
        request: _request(),
      );

      expect(result.status, V2PlacementWriteStatus.appended);
      expect(runner.candidates, hasLength(1));
      final candidate = runner.candidates.single;
      expect(candidate['schema_version'], '2.0-draft');
      expect(candidate['event_id'], 'evt_000002');
      expect(candidate['event_type'], 'component_visual_placement_confirmed');
      expect(candidate['event_type'], isNot('component_created'));
      expect(candidate['event_type'], isNot('component_updated'));
      expect(candidate['project_id'], 'placement_project');
      expect(candidate['client_operation_id'], 'op_place_cmp_r101');
      expect(candidate['actor'], {'type': 'human', 'id': 'local_operator'});
      expect(candidate['source'], {
        'type': 'explicit_user_confirmation',
        'surface': 'board_canvas',
        'action': 'confirm_visual_placement',
      });
      expect(candidate['confirmation'], {
        'confirmed': true,
        'confirmed_at': '2026-06-10T12:00:00.000Z',
      });

      final payload = candidate['payload'] as Map<String, dynamic>;
      expect(payload, {
        'component_id': 'cmp_r101',
        'coordinate_space': 'board_normalized',
        'board_side': 'top',
        'center_x': 0.42,
        'center_y': 0.58,
        'rotation_deg': 90,
        'width': 1.2,
        'height': 0.7,
        'template_id': 'template_family_rect_2_top_bottom',
        'source_photo_id': 'photo_top',
        'notes': 'visual placement only',
      });
      for (final forbidden in const [
        'component_created',
        'component_updated',
        'pins',
        'pin_id',
        'contacts',
        'pads',
        'nets',
        'traces',
        'electrical_facts',
        'measurements',
        'visual_contact_layout',
        'ai_facts',
        'repair_conclusions',
        'scale',
      ]) {
        expect(payload.containsKey(forbidden), isFalse, reason: forbidden);
      }
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

    test('normalizes rotation_deg into the canonical half-open range',
        () async {
      final directory =
          Directory.systemTemp.createTempSync('tracebench-v2-place-test-');
      addTearDown(() => directory.deleteSync(recursive: true));
      File('${directory.path}/events.jsonl').writeAsStringSync('');
      var eventIndex = 2;
      final runner = _FakeProcessRunner((command) {
        if (command.last == '--version') {
          return _success('Python 3.12.0');
        }
        return _success('[OK] appended: evt_000002');
      });
      final service = V2PlacementService(
        processRunner: runner,
        repoRootPath: Directory.current.path,
        now: () => DateTime.utc(2026, 6, 10, 12),
        eventIdGenerator: () =>
            'evt_${(eventIndex++).toString().padLeft(6, '0')}',
      );

      final cases = <num, num>{
        0: 0,
        90: 90,
        180: -180,
        270: -90,
        360: 0,
        -181: 179,
        -270: 90,
        540: -180,
      };

      for (final entry in cases.entries) {
        await service.confirmPlacement(
          projectState: _projectState(directory),
          request: _request(
            rotationDeg: entry.key,
            clientOperationId: 'op_place_cmp_r101_${entry.key}',
          ),
        );
      }

      expect(runner.candidates, hasLength(cases.length));
      for (var index = 0; index < cases.length; index++) {
        final input = cases.keys.elementAt(index);
        final expected = cases.values.elementAt(index);
        final candidate = runner.candidates[index];
        expect(candidate['event_type'], 'component_visual_placement_confirmed');
        final payload = candidate['payload'] as Map<String, dynamic>;
        final rotationDeg = payload['rotation_deg'] as num;
        expect(rotationDeg, expected, reason: '$input');
        expect(rotationDeg >= -180, isTrue, reason: '$input');
        expect(rotationDeg < 180, isTrue, reason: '$input');
      }
    });

    test('requires client_operation_id before writer invocation', () async {
      final directory =
          Directory.systemTemp.createTempSync('tracebench-v2-place-test-');
      addTearDown(() => directory.deleteSync(recursive: true));
      File('${directory.path}/events.jsonl').writeAsStringSync('');
      final runner = _FakeProcessRunner((command) {
        if (command.last == '--version') {
          return _success('Python 3.12.0');
        }
        return _success('[OK] appended: evt_000002');
      });
      final service = V2PlacementService(
        processRunner: runner,
        repoRootPath: Directory.current.path,
      );

      await expectLater(
        service.confirmPlacement(
          projectState: _projectState(directory),
          request: _request(clientOperationId: ' '),
        ),
        throwsA(
          isA<V2PlacementWriterException>().having(
            (error) => error.kind,
            'kind',
            V2PlacementFailureKind.validation,
          ),
        ),
      );
      expect(runner.calls, isEmpty);
      expect(_writerWasCalled(runner), isFalse);
    });

    test('rejects unknown component before writer invocation', () async {
      final directory =
          Directory.systemTemp.createTempSync('tracebench-v2-place-test-');
      addTearDown(() => directory.deleteSync(recursive: true));
      File('${directory.path}/events.jsonl').writeAsStringSync('');
      final runner = _FakeProcessRunner((command) {
        if (command.last == '--version') {
          return _success('Python 3.12.0');
        }
        return _success('[OK] appended: evt_000002');
      });
      final service = V2PlacementService(
        processRunner: runner,
        repoRootPath: Directory.current.path,
      );

      await expectLater(
        service.confirmPlacement(
          projectState: _projectState(directory, includeComponent: false),
          request: _request(),
        ),
        throwsA(
          isA<V2PlacementWriterException>().having(
            (error) => error.kind,
            'kind',
            V2PlacementFailureKind.unknownComponent,
          ),
        ),
      );
      expect(runner.calls, isEmpty);
      expect(_writerWasCalled(runner), isFalse);
    });

    test('canonicalizes project directory before writer invocation', () async {
      final directory =
          Directory.systemTemp.createTempSync('tracebench-v2-place-test-');
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
      final service = V2PlacementService(
        processRunner: runner,
        repoRootPath: Directory.current.path,
        eventIdGenerator: () => 'evt_000002',
      );

      await service.confirmPlacement(
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

    test('rejects traversal-like project directory before writer invocation',
        () async {
      final parent =
          Directory.systemTemp.createTempSync('tracebench-v2-place-test-');
      final selected = Directory(_joinPathForTest(parent.path, 'selected'))
        ..createSync();
      final escaped = Directory(_joinPathForTest(parent.path, 'escaped'))
        ..createSync();
      File(_joinPathForTest(selected.path, 'events.jsonl'))
          .writeAsStringSync('');
      addTearDown(() => parent.deleteSync(recursive: true));
      final escapedName = escaped.path.split(RegExp(r'[\\/]+')).last;
      final traversalPath =
          [selected.path, '..', escapedName].join(Platform.pathSeparator);
      final runner = _FakeProcessRunner((command) {
        if (command.last == '--version') {
          return _success('Python 3.12.0');
        }
        return _success('[OK] appended: evt_000002');
      });
      final service = V2PlacementService(
        processRunner: runner,
        repoRootPath: Directory.current.path,
      );

      await expectLater(
        service.confirmPlacement(
          projectState: _projectState(
            selected,
            projectDirectory: traversalPath,
          ),
          request: _request(),
        ),
        throwsA(
          isA<V2PlacementWriterException>().having(
            (error) => error.kind,
            'kind',
            V2PlacementFailureKind.invalidProjectDirectory,
          ),
        ),
      );
      expect(runner.calls, isEmpty);
      expect(_writerWasCalled(runner), isFalse);
    });

    test('returns existing status when writer reports existing', () async {
      final directory =
          Directory.systemTemp.createTempSync('tracebench-v2-place-test-');
      addTearDown(() => directory.deleteSync(recursive: true));
      File('${directory.path}/events.jsonl').writeAsStringSync('');

      final runner = _FakeProcessRunner((command) {
        if (command.last == '--version') {
          return _success('Python 3.12.0');
        }
        return _success('[OK] existing: evt_000002');
      });
      final service = V2PlacementService(
        processRunner: runner,
        repoRootPath: Directory.current.path,
        now: () => DateTime.utc(2026, 6, 10, 12),
        eventIdGenerator: () => 'evt_000002',
      );

      final result = await service.confirmPlacement(
        projectState: _projectState(directory),
        request: _request(),
      );

      expect(result.status, V2PlacementWriteStatus.existing);
      expect(
          result.event['event_type'], 'component_visual_placement_confirmed');
    });

    test('maps writer validation append and lock failures', () async {
      for (final entry in <String, V2PlacementFailureKind>{
        '[ERROR] candidate event failed validation':
            V2PlacementFailureKind.validation,
        '[ERROR] readback failed after append': V2PlacementFailureKind.append,
        '[ERROR] event writer lock is already held':
            V2PlacementFailureKind.lockConflict,
      }.entries) {
        final directory =
            Directory.systemTemp.createTempSync('tracebench-v2-place-test-');
        addTearDown(() => directory.deleteSync(recursive: true));
        File('${directory.path}/events.jsonl').writeAsStringSync('');
        final runner = _FakeProcessRunner((command) {
          if (command.last == '--version') {
            return _success('Python 3.12.0');
          }
          return _failure(entry.key);
        });
        final service = V2PlacementService(
          processRunner: runner,
          repoRootPath: Directory.current.path,
          now: () => DateTime.utc(2026, 6, 10, 12),
        );

        await expectLater(
          service.confirmPlacement(
            projectState: _projectState(directory),
            request: _request(),
          ),
          throwsA(
            isA<V2PlacementWriterException>().having(
              (error) => error.kind,
              'kind',
              entry.value,
            ),
          ),
        );
      }
    });
  });
}
