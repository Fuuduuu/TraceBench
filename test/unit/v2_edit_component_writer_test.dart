import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:trace_bench_viewer/features/components/services/v2_edit_component_writer.dart';
import 'package:trace_bench_viewer/shared/models/known_facts.dart';
import 'package:trace_bench_viewer/shared/models/project_manifest.dart';
import 'package:trace_bench_viewer/shared/models/project_state.dart';
import 'package:trace_bench_viewer/shared/models/trace_bench_event.dart';
import 'package:trace_bench_viewer/shared/services/python_runner.dart';

class _RunCall {
  const _RunCall({required this.command, required this.workingDirectory});

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
    calls.add(_RunCall(
        command: List<String>.from(command),
        workingDirectory: workingDirectory));
    if (command.any((part) => part.contains('event_writer_service.py'))) {
      candidates.add(jsonDecode(File(command.last).readAsStringSync())
          as Map<String, dynamic>);
    }
    return _handler(command);
  }
}

ProcessResult _success([String stdout = 'ok']) =>
    ProcessResult(0, 0, stdout, '');
ProcessResult _failure(String stderr) => ProcessResult(0, 1, '', stderr);

ProjectState _projectState(Directory directory,
    {String? projectDirectory, bool includeComponent = true}) {
  return ProjectState(
    manifest: const ProjectManifest(
      projectId: 'edit_component_project',
      schemaVersion: '1.0',
      createdAt: '2026-05-22T00:00:00Z',
      deviceType: 'bench_board',
      model: 'PV20',
      symptom: 'not_provided',
    ),
    knownFacts: KnownFacts.fromJson({
      'project_id': 'edit_component_project',
      'components': includeComponent
          ? [
              {
                'component_id': 'Q2',
                'designator': 'Q2',
                'type': 'unknown',
                'package': 'SOT-23',
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
        projectId: 'edit_component_project',
        sequence: 1,
        createdAt: '2026-06-09T09:00:00.000Z',
        actor: {'type': 'human', 'id': 'local_operator'},
        eventType: 'component_created',
        status: 'accepted',
        payload: {
          'component_id': 'Q2',
          'label': 'Q2',
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

V2EditComponentRequest _request() {
  return const V2EditComponentRequest(
    componentId: 'Q2',
    editReason: 'human_label_clarity',
    clientOperationId: 'edit_component_Q2_label',
    changes: [
      V2ComponentChange(
        field: 'label',
        oldValueObserved: 'Q2',
        newValue: 'Q2 transistor',
        changeKind: 'replace',
      ),
      V2ComponentChange(
        field: 'reference_designator',
        oldValueObserved: 'Q2',
        newValue: 'Q2A',
        changeKind: 'replace',
      ),
    ],
  );
}

void main() {
  group('V2EditComponentService', () {
    test('builds V2 component_updated event and calls writer service',
        () async {
      final directory =
          Directory.systemTemp.createTempSync('tracebench-v2-edit-test-');
      addTearDown(() => directory.deleteSync(recursive: true));
      File('${directory.path}/events.jsonl').writeAsStringSync('');

      final runner = _FakeProcessRunner((command) {
        if (command.last == '--version') {
          return _success('Python 3.12.0');
        }
        return _success('[OK] appended: evt_000002');
      });
      final service = V2EditComponentService(
        processRunner: runner,
        repoRootPath: Directory.current.path,
        now: () => DateTime.utc(2026, 6, 9, 11),
        eventIdGenerator: () => 'evt_000002',
      );

      final result = await service.editComponent(
        projectState: _projectState(directory),
        request: _request(),
      );

      expect(result.status, V2EditComponentWriteStatus.appended);
      expect(runner.candidates, hasLength(1));
      final candidate = runner.candidates.single;
      expect(candidate['schema_version'], '2.0-draft');
      expect(candidate['event_id'], 'evt_000002');
      expect(candidate['event_type'], 'component_updated');
      expect(candidate['event_type'], isNot('component_created'));
      expect(candidate['project_id'], 'edit_component_project');
      expect(candidate['client_operation_id'], 'edit_component_Q2_label');
      expect(candidate['actor'], {'type': 'human', 'id': 'local_operator'});
      expect(candidate['source'], {
        'type': 'explicit_user_confirmation',
        'surface': 'edit_component',
        'action': 'edit_component',
      });
      expect(candidate['confirmation'], {
        'confirmed': true,
        'confirmed_at': '2026-06-09T11:00:00.000Z',
      });

      final payload = candidate['payload'] as Map<String, dynamic>;
      expect(payload['component_id'], 'Q2');
      expect(payload['edit_reason'], 'human_label_clarity');
      expect(payload['changes'], [
        {
          'field': 'label',
          'old_value_observed': 'Q2',
          'new_value': 'Q2 transistor',
          'change_kind': 'replace',
        },
        {
          'field': 'reference_designator',
          'old_value_observed': 'Q2',
          'new_value': 'Q2A',
          'change_kind': 'replace',
        },
      ]);
      for (final forbidden in const [
        'identity_proof',
        'net_proof',
        'measurement_proof',
        'fault_proof',
        'confirmed_identity',
        'photo_proof',
        'ai_confidence',
        'probability',
        'diagnosis',
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

    test('rejects unknown component before writer invocation', () async {
      final directory =
          Directory.systemTemp.createTempSync('tracebench-v2-edit-test-');
      addTearDown(() => directory.deleteSync(recursive: true));
      File('${directory.path}/events.jsonl').writeAsStringSync('');
      final runner = _FakeProcessRunner((command) {
        if (command.last == '--version') {
          return _success('Python 3.12.0');
        }
        return _success('[OK] appended: evt_000002');
      });
      final service = V2EditComponentService(
        processRunner: runner,
        repoRootPath: Directory.current.path,
      );

      await expectLater(
        service.editComponent(
          projectState: _projectState(directory, includeComponent: false),
          request: _request(),
        ),
        throwsA(
          isA<V2EditComponentException>().having(
            (error) => error.kind,
            'kind',
            V2EditComponentFailureKind.unknownComponent,
          ),
        ),
      );
      expect(runner.calls, isEmpty);
      expect(_writerWasCalled(runner), isFalse);
    });

    test('canonicalizes project directory before writer invocation', () async {
      final directory =
          Directory.systemTemp.createTempSync('tracebench-v2-edit-test-');
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
      final service = V2EditComponentService(
        processRunner: runner,
        repoRootPath: Directory.current.path,
        eventIdGenerator: () => 'evt_000002',
      );

      await service.editComponent(
        projectState:
            _projectState(directory, projectDirectory: directory.path),
        request: _request(),
      );

      expect(_writerCommand(runner),
          contains(_joinPathForTest(canonicalDirectory, 'events.jsonl')));
    });

    test('rejects traversal-like project directory before writer invocation',
        () async {
      final parent =
          Directory.systemTemp.createTempSync('tracebench-v2-edit-test-');
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
      final service = V2EditComponentService(
        processRunner: runner,
        repoRootPath: Directory.current.path,
      );

      await expectLater(
        service.editComponent(
          projectState:
              _projectState(selected, projectDirectory: traversalPath),
          request: _request(),
        ),
        throwsA(
          isA<V2EditComponentException>().having(
            (error) => error.kind,
            'kind',
            V2EditComponentFailureKind.invalidProjectDirectory,
          ),
        ),
      );
      expect(runner.calls, isEmpty);
      expect(_writerWasCalled(runner), isFalse);
    });

    test('returns existing status when writer reports existing', () async {
      final directory =
          Directory.systemTemp.createTempSync('tracebench-v2-edit-test-');
      addTearDown(() => directory.deleteSync(recursive: true));
      File('${directory.path}/events.jsonl').writeAsStringSync('');
      final runner = _FakeProcessRunner((command) {
        if (command.last == '--version') {
          return _success('Python 3.12.0');
        }
        return _success('[OK] existing: evt_000002');
      });
      final service = V2EditComponentService(
        processRunner: runner,
        repoRootPath: Directory.current.path,
        eventIdGenerator: () => 'evt_000002',
      );

      final result = await service.editComponent(
        projectState: _projectState(directory),
        request: _request(),
      );

      expect(result.status, V2EditComponentWriteStatus.existing);
      expect(result.event['event_type'], 'component_updated');
    });

    test('maps writer validation append and lock failures', () async {
      for (final entry in <String, V2EditComponentFailureKind>{
        '[ERROR] candidate event failed validation':
            V2EditComponentFailureKind.validation,
        '[ERROR] readback failed after append':
            V2EditComponentFailureKind.append,
        '[ERROR] event writer lock is already held':
            V2EditComponentFailureKind.lockConflict,
      }.entries) {
        final directory =
            Directory.systemTemp.createTempSync('tracebench-v2-edit-test-');
        addTearDown(() => directory.deleteSync(recursive: true));
        File('${directory.path}/events.jsonl').writeAsStringSync('');
        final runner = _FakeProcessRunner((command) {
          if (command.last == '--version') {
            return _success('Python 3.12.0');
          }
          return _failure(entry.key);
        });
        final service = V2EditComponentService(
          processRunner: runner,
          repoRootPath: Directory.current.path,
          now: () => DateTime.utc(2026, 6, 9, 11),
        );

        await expectLater(
          service.editComponent(
              projectState: _projectState(directory), request: _request()),
          throwsA(
            isA<V2EditComponentException>().having(
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
