import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:trace_bench_viewer/shared/event_write/measurement_event_writer.dart';
import 'package:trace_bench_viewer/shared/models/known_facts.dart';
import 'package:trace_bench_viewer/shared/models/project_manifest.dart';
import 'package:trace_bench_viewer/shared/models/project_state.dart';
import 'package:trace_bench_viewer/shared/models/trace_bench_event.dart';
import 'package:trace_bench_viewer/shared/services/project_loader.dart';

TraceBenchEvent _decodeLastLine(String rawLines) {
  final parsed = jsonDecode(rawLines.trim().split('\n').last);
  return TraceBenchEvent.fromJson(parsed as Map<String, dynamic>);
}

ProjectState _buildProjectState({
  required Directory projectDirectory,
  required String eventsRaw,
}) {
  final manifestRaw = File('assets/samples/pelle_pv20_minimal/manifest.json')
      .readAsStringSync();
  final knownFactsRaw =
      File('assets/samples/pelle_pv20_minimal/known_facts.json')
          .readAsStringSync();
  final reportRaw =
      File('assets/samples/pelle_pv20_minimal/exports/customer_report.md')
          .readAsStringSync();

  return ProjectState(
    manifest: ProjectManifest.fromJson(jsonDecode(manifestRaw)),
    knownFacts: KnownFacts.fromJson(jsonDecode(knownFactsRaw)),
    events: ProjectLoader.parseEvents(eventsRaw),
    customerReport: reportRaw,
    projectDirectory: projectDirectory.path,
  );
}

Directory _writeProjectWithEvents(
  String eventsRaw,
  List<Directory> trackedDirectories,
) {
  final directory = Directory.systemTemp.createTempSync(
    'tracebench-measurement-writer-test-',
  );
  trackedDirectories.add(directory);

  final manifestFile = File('assets/samples/pelle_pv20_minimal/manifest.json');
  final knownFactsFile =
      File('assets/samples/pelle_pv20_minimal/known_facts.json');
  final reportFile =
      File('assets/samples/pelle_pv20_minimal/exports/customer_report.md');
  final exportsDir = Directory('${directory.path}/exports');
  exportsDir.createSync(recursive: true);

  manifestFile.copySync('${directory.path}/manifest.json');
  knownFactsFile.copySync('${directory.path}/known_facts.json');
  reportFile.copySync('${directory.path}/exports/customer_report.md');
  File('${directory.path}/events.jsonl').writeAsStringSync(eventsRaw);

  return directory;
}

String _minEventLine({
  required String eventId,
  required int sequence,
}) {
  return jsonEncode({
    'schema_version': '1.0',
    'event_id': eventId,
    'project_id': 'prj_pelle_pv20_001',
    'sequence': sequence,
    'created_at': '2026-05-24T10:00:00Z',
    'actor': {'type': 'user', 'id': 'tester'},
    'event_type': 'project_created',
    'status': 'accepted',
    'payload': {'status': 'created'},
  });
}

String _missingSequenceEventLine({
  required String eventId,
}) {
  return jsonEncode({
    'schema_version': '1.0',
    'event_id': eventId,
    'project_id': 'prj_pelle_pv20_001',
    'created_at': '2026-05-24T10:00:00Z',
    'actor': {'type': 'user', 'id': 'tester'},
    'event_type': 'project_created',
    'status': 'accepted',
    'payload': {'status': 'created'},
  });
}

MeasurementWriteRequest _validRequest() => const MeasurementWriteRequest(
      value: 12.5,
      unit: 'V',
      fromTarget: 'TP1',
      toTarget: 'TP2',
    );

void main() {
  group('MeasurementEventWriter', () {
    final directories = <Directory>[];

    setUp(() {
      directories.clear();
    });

    tearDown(() {
      for (final directory in directories) {
        directory.deleteSync(recursive: true);
      }
    });

    test('sequence is max(existing)+1', () async {
      final directory = _writeProjectWithEvents(
        [
          _minEventLine(eventId: 'evt_000001', sequence: 1),
          _minEventLine(eventId: 'evt_000002', sequence: 3),
          _minEventLine(eventId: 'evt_000003', sequence: 8),
        ].join('\n'),
        directories,
      );
      final writer = MeasurementEventWriter(
        now: () => DateTime.utc(2026, 5, 24),
        eventIdGenerator: () => 'evt_flutter_test_unique_1',
        measurementIdGenerator: () => 'M1',
      );
      final state = _buildProjectState(
        projectDirectory: directory,
        eventsRaw: [
          _minEventLine(eventId: 'evt_000001', sequence: 1),
          _minEventLine(eventId: 'evt_000002', sequence: 3),
          _minEventLine(eventId: 'evt_000003', sequence: 8),
        ].join('\n'),
      );
      final result = await writer.writeMeasurement(
        projectState: state,
        request: _validRequest(),
      );
      expect(result.writtenEvent.sequence, 9);
    });

    test('sequence starts at 1 when events file is empty', () async {
      final directory = _writeProjectWithEvents('', directories);
      final writer = MeasurementEventWriter(
        now: () => DateTime.utc(2026, 5, 24),
        eventIdGenerator: () => 'evt_flutter_empty_case',
        measurementIdGenerator: () => 'M2',
      );
      final state = _buildProjectState(
        projectDirectory: directory,
        eventsRaw: '',
      );

      final result = await writer.writeMeasurement(
        projectState: state,
        request: _validRequest(),
      );
      expect(result.writtenEvent.sequence, 1);
    });

    test('duplicate existing sequence blocks writing', () async {
      final directory = _writeProjectWithEvents(
        [
          _minEventLine(eventId: 'evt_000001', sequence: 1),
          _minEventLine(eventId: 'evt_000002', sequence: 1),
        ].join('\n'),
        directories,
      );
      final writer = MeasurementEventWriter();
      final state = _buildProjectState(
        projectDirectory: directory,
        eventsRaw: [
          _minEventLine(eventId: 'evt_000001', sequence: 1),
          _minEventLine(eventId: 'evt_000002', sequence: 1),
        ].join('\n'),
      );
      expect(
        () => writer.writeMeasurement(
          projectState: state,
          request: _validRequest(),
        ),
        throwsA(isA<MeasurementWriteException>()),
      );
    });

    test('missing or non-integer sequence blocks writing', () async {
      final directory = _writeProjectWithEvents(
        [
          _missingSequenceEventLine(eventId: 'evt_000001'),
          _minEventLine(eventId: 'evt_000002', sequence: 2).replaceFirst(
            '"sequence":2,',
            '"sequence":2.5,',
          ),
        ].join('\n'),
        directories,
      );
      final writer = MeasurementEventWriter();
      final state = _buildProjectState(
        projectDirectory: directory,
        eventsRaw: [
          _missingSequenceEventLine(eventId: 'evt_000001'),
          _minEventLine(eventId: 'evt_000002', sequence: 2).replaceFirst(
            '"sequence":2,',
            '"sequence":2.5,',
          ),
        ].join('\n'),
      );
      expect(
        () => writer.writeMeasurement(
          projectState: state,
          request: _validRequest(),
        ),
        throwsA(isA<MeasurementWriteException>()),
      );
    });

    test('event_id collision regenerates safely', () async {
      var calls = 0;
      final directory = _writeProjectWithEvents(
        _minEventLine(eventId: 'evt_flutter_collision', sequence: 1),
        directories,
      );
      final writer = MeasurementEventWriter(
        eventIdGenerator: () {
          calls++;
          return calls == 1
              ? 'evt_flutter_collision'
              : 'evt_flutter_collision_safe';
        },
        measurementIdGenerator: () => 'M10',
      );
      final state = _buildProjectState(
        projectDirectory: directory,
        eventsRaw: _minEventLine(eventId: 'evt_flutter_collision', sequence: 1),
      );

      final result = await writer.writeMeasurement(
        projectState: state,
        request: _validRequest(),
      );
      expect(result.writtenEvent.eventId, 'evt_flutter_collision_safe');
    });

    test('actor.type=ai is rejected', () async {
      final directory = _writeProjectWithEvents('', directories);
      final writer = MeasurementEventWriter(
        eventIdGenerator: () => 'evt_flutter_ai_reject',
      );
      final state = _buildProjectState(
        projectDirectory: directory,
        eventsRaw: '',
      );
      expect(
        () => writer.writeMeasurement(
          projectState: state,
          request: const MeasurementWriteRequest(
            value: 1,
            unit: 'V',
            fromTarget: 'TP1',
            toTarget: 'TP2',
            actorType: 'ai',
          ),
        ),
        throwsA(isA<MeasurementWriteException>()),
      );
    });

    test('missing value/unit/target is rejected', () async {
      final directory = _writeProjectWithEvents('', directories);
      final writer = MeasurementEventWriter(
        eventIdGenerator: () => 'evt_flutter_validation',
      );
      final state = _buildProjectState(
        projectDirectory: directory,
        eventsRaw: '',
      );
      expect(
        () => writer.writeMeasurement(
          projectState: state,
          request: const MeasurementWriteRequest(
            value: null,
            unit: 'V',
            fromTarget: 'TP1',
            toTarget: 'TP2',
          ),
        ),
        throwsA(isA<MeasurementWriteException>()),
      );
      expect(
        () => writer.writeMeasurement(
          projectState: state,
          request: const MeasurementWriteRequest(
            value: 1,
            unit: '',
            fromTarget: 'TP1',
            toTarget: 'TP2',
          ),
        ),
        throwsA(isA<MeasurementWriteException>()),
      );
      expect(
        () => writer.writeMeasurement(
          projectState: state,
          request: const MeasurementWriteRequest(
            value: 1,
            unit: 'V',
            fromTarget: '',
            toTarget: 'TP2',
          ),
        ),
        throwsA(isA<MeasurementWriteException>()),
      );
      expect(
        () => writer.writeMeasurement(
          projectState: state,
          request: const MeasurementWriteRequest(
            value: 1,
            unit: 'V',
            fromTarget: 'TP1',
            toTarget: '',
          ),
        ),
        throwsA(isA<MeasurementWriteException>()),
      );
    });

    test(
      'valid measurement event appends exactly one JSONL line and preserves prior lines',
      () async {
        final rawLines = [
          _minEventLine(eventId: 'evt_000001', sequence: 1),
          _minEventLine(eventId: 'evt_000002', sequence: 2),
        ].join('\n');
        final directory = _writeProjectWithEvents(rawLines, directories);
        final writer = MeasurementEventWriter(
          now: () => DateTime.utc(2026, 5, 24),
          eventIdGenerator: () => 'evt_flutter_append',
          measurementIdGenerator: () => 'M20',
        );
        final state = _buildProjectState(
          projectDirectory: directory,
          eventsRaw: rawLines,
        );
        await writer.writeMeasurement(
          projectState: state,
          request: _validRequest(),
        );

        final fileLines =
            File('${directory.path}/events.jsonl').readAsLinesSync();
        expect(fileLines.length, 3);
        expect(fileLines[0], rawLines.split('\n')[0]);
        expect(fileLines[1], rawLines.split('\n')[1]);

        final writtenEvent = _decodeLastLine(
          File('${directory.path}/events.jsonl').readAsStringSync(),
        );
        expect(writtenEvent.eventType, 'measurement_recorded');
      },
    );

    test('known_facts.json is not mutated', () async {
      final directory = _writeProjectWithEvents('', directories);
      final originalKnownFacts =
          File('${directory.path}/known_facts.json').readAsStringSync();
      final writer = MeasurementEventWriter(
        eventIdGenerator: () => 'evt_flutter_no_known_facts',
      );
      final state = _buildProjectState(
        projectDirectory: directory,
        eventsRaw: '',
      );
      await writer.writeMeasurement(
        projectState: state,
        request: _validRequest(),
      );
      final newKnownFacts =
          File('${directory.path}/known_facts.json').readAsStringSync();
      expect(newKnownFacts, originalKnownFacts);
    });

    test('no secondary confirmation/pin/component events are written',
        () async {
      final directory = _writeProjectWithEvents('', directories);
      final writer = MeasurementEventWriter(
        eventIdGenerator: () => 'evt_flutter_single',
      );
      final state = _buildProjectState(
        projectDirectory: directory,
        eventsRaw: '',
      );
      await writer.writeMeasurement(
        projectState: state,
        request: _validRequest(),
      );

      final events = ProjectLoader.parseEvents(
        File('${directory.path}/events.jsonl').readAsStringSync(),
      );
      expect(events.last.eventType, 'measurement_recorded');
      expect(
        events.any((event) => event.eventType == 'net_connection_confirmed'),
        false,
      );
      expect(
        events.any((event) => event.eventType == 'component_created'),
        false,
      );
      expect(events.any((event) => event.eventType == 'pin_defined'), false);
    });
  });
}
