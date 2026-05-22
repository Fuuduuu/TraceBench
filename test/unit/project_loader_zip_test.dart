import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trace_bench_viewer/shared/services/project_loader.dart';

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
}
