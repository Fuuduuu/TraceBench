import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:trace_bench_viewer/shared/models/project_manifest.dart';

void main() {
  test('valid manifest parses', () {
    final raw = File(
      'assets/samples/pelle_pv20_minimal/manifest.json',
    ).readAsStringSync();
    final parsed = ProjectManifest.fromJson(jsonDecode(raw) as Map<String, dynamic>);

    expect(parsed.projectId, 'prj_pelle_pv20_001');
    expect(parsed.deviceType, 'burner_controller');
    expect(parsed.model, 'Pelle PV20');
  });

  test('missing optional fields fallback to defaults', () {
    final manifest = ProjectManifest.fromJson(const {
      'project_id': 'x',
      'schema_version': '1.0',
      'created_at': '2026-01-01T00:00:00Z',
    });

    expect(manifest.deviceType, 'unknown');
    expect(manifest.model, 'unknown');
    expect(manifest.symptom, 'not_provided');
  });

  test('invalid json throws', () {
    expect(
      () => jsonDecode('{ this is not json }'),
      throwsException,
    );
  });
}
