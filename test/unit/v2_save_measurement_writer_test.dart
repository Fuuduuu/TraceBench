import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:trace_bench_viewer/features/measure_sheet/services/v2_save_measurement_writer.dart';
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

ProjectState _projectState(Directory directory) {
  return ProjectState(
    manifest: const ProjectManifest(
      projectId: 'measure_sheet_project',
      schemaVersion: '1.0',
      createdAt: '2026-05-22T00:00:00Z',
      deviceType: 'bench_board',
      model: 'PV20',
      symptom: 'not_provided',
    ),
    knownFacts: KnownFacts.fromJson({
      'project_id': 'measure_sheet_project',
      'components': [
        {'component_id': 'Q2', 'status': 'identified', 'designator': 'Q2'},
      ],
      'pins': [
        {'component_id': 'Q2', 'pin_id': 'Q2.1'},
      ],
      'measurements': const [],
      'component_pin_index': {
        'Q2': ['Q2.1'],
      },
    }),
    events: const [
      TraceBenchEvent(
        schemaVersion: '1.0',
        eventId: 'evt_000001',
        projectId: 'measure_sheet_project',
        sequence: 1,
        createdAt: '2026-05-22T00:00:00Z',
        actor: {'type': 'user', 'id': 'tester'},
        eventType: 'project_created',
        status: 'accepted',
        payload: {'status': 'created'},
      ),
    ],
    customerReport: 'Inline report',
    projectDirectory: directory.path,
  );
}

V2SaveMeasurementRequest _request() {
  return const V2SaveMeasurementRequest(
    value: 1.23,
    valueText: '1.23',
    displayValue: '1.23 V',
    unitLabel: 'V',
    schemaUnit: 'V',
    mode: 'voltage',
    targetKey: 'Q2.1',
    displayLabel: 'Q2 · Q2.1',
    componentId: 'Q2',
    pinId: 'Q2.1',
    valueProvenance: 'human_entered',
    clientOperationId: 'op_measure_sheet_Q2_1_1_23_V',
    eventType: 'measurement_recorded',
    actorType: 'human',
    sourceType: 'explicit_user_confirmation',
    confirmed: true,
  );
}

void main() {
  group('V2SaveMeasurementService', () {
    test('builds V2 measurement_recorded event and calls writer service',
        () async {
      final directory =
          Directory.systemTemp.createTempSync('tracebench-v2-save-test-');
      addTearDown(() => directory.deleteSync(recursive: true));
      File('${directory.path}/events.jsonl').writeAsStringSync('');

      final runner = _FakeProcessRunner((command) {
        if (command.last == '--version') {
          return _success('Python 3.12.0');
        }
        return _success('[OK] appended: evt_000002');
      });
      final service = V2SaveMeasurementService(
        processRunner: runner,
        repoRootPath: Directory.current.path,
        now: () => DateTime.utc(2026, 6, 8, 10),
        eventIdGenerator: () => 'evt_000002',
        measurementIdGenerator: () => 'M10',
      );

      final result = await service.saveMeasurement(
        projectState: _projectState(directory),
        request: _request(),
      );

      expect(result.status, V2SaveMeasurementWriteStatus.appended);
      expect(runner.candidates, hasLength(1));
      final candidate = runner.candidates.single;
      expect(candidate['schema_version'], '2.0-draft');
      expect(candidate['event_id'], 'evt_000002');
      expect(candidate['event_type'], 'measurement_recorded');
      expect(candidate['project_id'], 'measure_sheet_project');
      expect(candidate['client_operation_id'], 'op_measure_sheet_Q2_1_1_23_V');
      expect(candidate['actor'], {'type': 'human', 'id': 'local_operator'});
      expect(candidate['source'], {
        'type': 'explicit_user_confirmation',
        'surface': 'measure_sheet',
        'action': 'save_measurement',
      });
      expect(candidate['confirmation'], {
        'confirmed': true,
        'confirmed_at': '2026-06-08T10:00:00.000Z',
      });

      final payload = candidate['payload'] as Map<String, dynamic>;
      expect(payload['measurement_id'], 'M10');
      expect(payload['measured_at'], '2026-06-08T10:00:00.000Z');
      expect(payload['target'], {
        'target_kind': 'component_pin',
        'target_key': 'Q2.1',
        'display_label': 'Q2 · Q2.1',
        'component_id': 'Q2',
        'pin_id': 'Q2.1',
      });
      expect(payload['reading'], {
        'mode': 'voltage',
        'value': 1.23,
        'unit': 'V',
        'display_value': '1.23 V',
      });
      expect(payload['value_provenance'], {
        'measured_value_source': 'human_entered',
        'context_values_visible': [
          {'context_type': 'reference_value', 'used_as_measured_value': false},
          {'context_type': 'candidate_value', 'used_as_measured_value': false},
          {
            'context_type': 'helper_suggestion',
            'used_as_measured_value': false
          },
        ],
      });
      expect(candidate.containsKey('sequence'), isFalse);
      expect(candidate.containsKey('status'), isFalse);

      final writerCommand = runner.calls.map((call) => call.command).firstWhere(
          (command) =>
              command.any((part) => part.contains('event_writer_service.py')));
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

    test('event type override still writes measurement_recorded only',
        () async {
      final directory =
          Directory.systemTemp.createTempSync('tracebench-v2-save-test-');
      addTearDown(() => directory.deleteSync(recursive: true));
      File('${directory.path}/events.jsonl').writeAsStringSync('');

      final runner = _FakeProcessRunner((command) {
        if (command.last == '--version') {
          return _success('Python 3.12.0');
        }
        return _success('[OK] appended: evt_000002');
      });
      final service = V2SaveMeasurementService(
        processRunner: runner,
        repoRootPath: Directory.current.path,
        now: () => DateTime.utc(2026, 6, 8, 10),
        eventIdGenerator: () => 'evt_000002',
        measurementIdGenerator: () => 'M10',
      );

      await service.saveMeasurement(
        projectState: _projectState(directory),
        request: const V2SaveMeasurementRequest(
          value: 1.23,
          valueText: '1.23',
          displayValue: '1.23 V',
          unitLabel: 'V',
          schemaUnit: 'V',
          mode: 'voltage',
          targetKey: 'Q2.1',
          displayLabel: 'Q2 · Q2.1',
          componentId: 'Q2',
          pinId: 'Q2.1',
          valueProvenance: 'human_entered',
          clientOperationId: 'op_measure_sheet_Q2_1_1_23_V',
          eventType: 'component_created',
        ),
      );

      expect(runner.candidates, hasLength(1));
      expect(runner.candidates.single['event_type'], 'measurement_recorded');
    });

    test('maps validator failure to validation not-saved kind', () async {
      final directory =
          Directory.systemTemp.createTempSync('tracebench-v2-save-test-');
      addTearDown(() => directory.deleteSync(recursive: true));
      File('${directory.path}/events.jsonl').writeAsStringSync('');
      final runner = _FakeProcessRunner((command) {
        if (command.last == '--version') {
          return _success('Python 3.12.0');
        }
        return _failure('[ERROR] candidate event failed validation');
      });

      final service = V2SaveMeasurementService(
        processRunner: runner,
        repoRootPath: Directory.current.path,
        now: () => DateTime.utc(2026, 6, 8, 10),
      );

      expect(
        () => service.saveMeasurement(
          projectState: _projectState(directory),
          request: _request(),
        ),
        throwsA(
          isA<V2SaveMeasurementException>().having(
            (error) => error.kind,
            'kind',
            V2SaveMeasurementFailureKind.validation,
          ),
        ),
      );
    });

    test('maps lock conflict to retryable not-saved kind', () async {
      final directory =
          Directory.systemTemp.createTempSync('tracebench-v2-save-test-');
      addTearDown(() => directory.deleteSync(recursive: true));
      File('${directory.path}/events.jsonl').writeAsStringSync('');
      final runner = _FakeProcessRunner((command) {
        if (command.last == '--version') {
          return _success('Python 3.12.0');
        }
        return _failure('[ERROR] event writer lock is already held');
      });

      final service = V2SaveMeasurementService(
        processRunner: runner,
        repoRootPath: Directory.current.path,
        now: () => DateTime.utc(2026, 6, 8, 10),
      );

      expect(
        () => service.saveMeasurement(
          projectState: _projectState(directory),
          request: _request(),
        ),
        throwsA(
          isA<V2SaveMeasurementException>().having(
            (error) => error.kind,
            'kind',
            V2SaveMeasurementFailureKind.lockConflict,
          ),
        ),
      );
    });
  });
}
