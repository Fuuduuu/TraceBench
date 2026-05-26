import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trace_bench_viewer/shared/services/project_loader.dart';

Future<Directory> _createLocalProjectDirectoryForLoaderTest() async {
  final directory =
      await Directory.systemTemp.createTemp('tracebench-loader-test-');

  await File('${directory.path}${Platform.pathSeparator}manifest.json')
      .writeAsString(
    jsonEncode({
      'project_id': 'inline_project',
      'schema_version': '1.0',
      'created_at': '2026-05-22T00:00:00Z',
      'device_type': 'pelle',
      'model': 'PV20',
      'symptom': 'not_provided',
    }),
  );

  await File('${directory.path}${Platform.pathSeparator}events.jsonl')
      .writeAsString('');

  await File('${directory.path}${Platform.pathSeparator}known_facts.json')
      .writeAsString(
    jsonEncode({
      'project_id': 'inline_project',
      'components': <dynamic>[],
      'pins': <dynamic>[],
      'measurements': [
        {
          'measurement_id': 'M001',
          'mode': 'continuity',
          'from': 'Q2.1',
          'to': 'R17.1',
          'reading': {'kind': 'numeric', 'value': 1, 'unit': 'ohm'},
          'power_state': 'off',
          'origin_event_id': 'evt_000001',
          'validity_status': 'active',
        },
      ],
      'nets': <dynamic>[],
      'excluded_from_fault_candidates': <dynamic>[],
      'component_pin_index': <String, dynamic>{},
      'photos': <dynamic>[],
      'damage_regions': <dynamic>[],
      'suspect_regions': <dynamic>[],
      'visual_traces': <dynamic>[],
    }),
  );

  await Directory(
    '${directory.path}${Platform.pathSeparator}metadata',
  ).create(recursive: true);
  await File(
    '${directory.path}${Platform.pathSeparator}metadata${Platform.pathSeparator}schema_versions.json',
  ).writeAsString(
    jsonEncode({
      'events_schema': '1.0',
      'known_facts_schema': '1.0',
      'project_manifest_schema': '1.0',
      'project_zip_contract': '1.0',
    }),
  );

  await Directory(
    '${directory.path}${Platform.pathSeparator}exports',
  ).create(recursive: true);
  await File(
    '${directory.path}${Platform.pathSeparator}exports${Platform.pathSeparator}customer_report.md',
  ).writeAsString('# Inline report\n');

  return directory;
}

void main() {
  test('loadFromZipBytes rejects ZIP missing manifest.json', () async {
    const projectId = 'prj_pelle_pv20_001';
    const eventsJsonl = '''
{"schema_version":"1.0","event_id":"evt_000000","project_id":"$projectId","sequence":1,"created_at":"2026-05-22T00:00:00Z","actor":{"type":"user","id":"u1"},"event_type":"project_created","status":"accepted","payload":{"status":"created"}}
''';
    const knownFactsJson = '{"project_id":"$projectId","components":[],"pins":[],"measurements":[],"nets":[],"excluded_from_fault_candidates":[]}';
    const reportMarkdown = '# TraceBench sample';

    final archive = Archive()
      ..addFile(
        ArchiveFile(
          'events.jsonl',
          utf8.encode(eventsJsonl).length,
          utf8.encode(eventsJsonl),
        ),
      )
      ..addFile(
        ArchiveFile(
          'known_facts.json',
          utf8.encode(knownFactsJson).length,
          utf8.encode(knownFactsJson),
        ),
      )
      ..addFile(
        ArchiveFile(
          'exports/customer_report.md',
          utf8.encode(reportMarkdown).length,
          utf8.encode(reportMarkdown),
        ),
      );

    final encodedZip = ZipEncoder().encode(archive);
    if (encodedZip == null) {
      fail('Failed to encode test ZIP');
    }

    final zipBytes = Uint8List.fromList(encodedZip);

    expect(
      () => ProjectLoader.loadFromZipBytes(zipBytes),
      throwsA(isA<ProjectLoadException>()),
    );
  });

  test('loadFromDirectory preserves projectDirectory and fresh disk state',
      () async {
    final directory = await _createLocalProjectDirectoryForLoaderTest();
    addTearDown(() => directory.delete(recursive: true));

    final loaded = await ProjectLoader.loadFromDirectory(directory.path);

    expect(loaded.projectDirectory, directory.path);
    expect(loaded.manifest.projectId, 'inline_project');
    expect(loaded.measurementCount, 1);
    expect(loaded.customerReport, '# Inline report\n');
    expect(loaded.isProjectionStale, isFalse);
  });

  test('loadFromDirectory does not write known_facts.json or events.jsonl',
      () async {
    final directory = await _createLocalProjectDirectoryForLoaderTest();
    addTearDown(() => directory.delete(recursive: true));

    final knownFactsFile =
        File('${directory.path}${Platform.pathSeparator}known_facts.json');
    final eventsFile =
        File('${directory.path}${Platform.pathSeparator}events.jsonl');
    final beforeKnownFacts = await knownFactsFile.readAsString();
    final beforeEvents = await eventsFile.readAsString();

    await ProjectLoader.loadFromDirectory(directory.path);

    expect(await knownFactsFile.readAsString(), beforeKnownFacts);
    expect(await eventsFile.readAsString(), beforeEvents);
  });
}
