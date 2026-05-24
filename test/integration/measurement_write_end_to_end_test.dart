import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:trace_bench_viewer/shared/event_write/measurement_event_writer.dart';
import 'package:trace_bench_viewer/shared/models/known_facts.dart';
import 'package:trace_bench_viewer/shared/models/project_manifest.dart';
import 'package:trace_bench_viewer/shared/models/project_state.dart';
import 'package:trace_bench_viewer/shared/services/project_loader.dart';

ProjectState _buildProjectState({
  required Directory directory,
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
    projectDirectory: directory.path,
  );
}

Directory _createProjectFolder(String eventsRaw, List<Directory> tracked) {
  final directory = Directory.systemTemp.createTempSync(
    'tracebench-measurement-integration-',
  );
  tracked.add(directory);

  final exportsDir = Directory('${directory.path}/exports');
  exportsDir.createSync(recursive: true);
  File('assets/samples/pelle_pv20_minimal/manifest.json')
      .copySync('${directory.path}/manifest.json');
  File('assets/samples/pelle_pv20_minimal/known_facts.json')
      .copySync('${directory.path}/known_facts.json');
  File('assets/samples/pelle_pv20_minimal/exports/customer_report.md')
      .copySync('${directory.path}/exports/customer_report.md');
  File('${directory.path}/events.jsonl').writeAsStringSync(eventsRaw);

  return directory;
}

String _baseEventLine() => jsonEncode({
      'schema_version': '1.0',
      'event_id': 'evt_000001',
      'project_id': 'prj_pelle_pv20_001',
      'sequence': 1,
      'created_at': '2026-05-24T10:00:00Z',
      'actor': {'type': 'user', 'id': 'tester'},
      'event_type': 'project_created',
      'status': 'accepted',
      'payload': {'status': 'created'},
    });

void main() {
  group('measurement measurement write end-to-end', () {
    final directories = <Directory>[];

    setUp(() {
      directories.clear();
    });

    tearDown(() {
      for (final directory in directories) {
        directory.deleteSync(recursive: true);
      }
    });

    test('appends one measurement_recorded event to local project folder',
        () async {
      final beforeEvents = [_baseEventLine()];
      final directory =
          _createProjectFolder(beforeEvents.join('\n'), directories);
      final beforeKnownFacts =
          File('${directory.path}/known_facts.json').readAsStringSync();
      final writer = MeasurementEventWriter(
        eventIdGenerator: () => 'evt_flutter_integration',
        measurementIdGenerator: () => 'M100',
        now: () => DateTime.utc(2026, 5, 24),
      );

      final state = _buildProjectState(
        directory: directory,
        eventsRaw: beforeEvents.join('\n'),
      );
      await writer.writeMeasurement(
        projectState: state,
        request: const MeasurementWriteRequest(
          value: 7.2,
          unit: 'V',
          fromTarget: 'TP1',
          toTarget: 'TP2',
        ),
      );

      final afterEventsRaw =
          File('${directory.path}/events.jsonl').readAsStringSync();
      final afterLines = afterEventsRaw.trim().split('\n');
      expect(afterLines.length, beforeEvents.length + 1);

      final parsedAfter = ProjectLoader.parseEvents(afterEventsRaw);
      expect(parsedAfter.last.eventType, 'measurement_recorded');

      expect(
        parsedAfter
            .any((event) => event.eventType == 'net_connection_confirmed'),
        false,
      );
      expect(parsedAfter.any((event) => event.eventType == 'component_created'),
          false);
      expect(
          parsedAfter.any((event) => event.eventType == 'pin_defined'), false);

      final afterKnownFacts =
          File('${directory.path}/known_facts.json').readAsStringSync();
      expect(afterKnownFacts, beforeKnownFacts);
    });
  });
}
