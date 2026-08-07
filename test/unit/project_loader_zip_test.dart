import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trace_bench_viewer/shared/models/wizard_intake.dart';
import 'package:trace_bench_viewer/shared/services/project_loader.dart';

const String _wizardIntakeWarning =
    'Projekti visuaalset Wizardi alusinfot ei saanud laadida. Projekt ise '
    'avati ja kinnitatud projektiteave jäi puutumata.';
const String _legacyWizardIntakeWarning =
    'Selle projekti Wizardi aluskaadri kuvasuhe puudub. Kasutatakse '
    'legacy-ruutkaadrit; foto, kontuuri ja kandidaatide täpset joondust ei saa '
    'kinnitada. Täpne joondus nõuab migratsiooni või projekti uuesti loomist.';
const String _debugSentinel = 'WIZARD_INTAKE_PRIVATE_SENTINEL';
const Object _absentIntake = Object();

Map<String, dynamic> _validWizardIntakeJson({
  String schemaVersion = '1.0',
  String coordinateSpace = 'wizard_normalized',
  String description = 'Power cycles under load',
  double? referenceFrameAspectRatio = 1.6,
}) {
  return <String, dynamic>{
    'schema_version': schemaVersion,
    'coordinate_space': coordinateSpace,
    if (referenceFrameAspectRatio != null)
      'reference_frame_aspect_ratio': referenceFrameAspectRatio,
    'problem_description': <String, dynamic>{
      'description': description,
      'occurrence': 'intermittent',
      'when_occurs': 'Under load',
      'symptoms': 'Display resets',
      'attempts': '',
    },
    'contour': <String, dynamic>{
      'closed': true,
      'points': <dynamic>[
        <String, dynamic>{'x': 0.1, 'y': 0.2},
        <String, dynamic>{'x': 0.8, 'y': 0.2},
        <String, dynamic>{'x': 0.8, 'y': 0.7},
      ],
    },
    'background_photo': null,
    'visual_candidates': <dynamic>[
      <String, dynamic>{
        'draft_key': 1,
        'position': <String, dynamic>{'x': 0.4, 'y': 0.5},
        'shape': 'circle',
        'size_scale': 1.0,
        'rotation_radians': 0.0,
      },
    ],
  };
}

String _joinTestPath(String base, String relativePath) {
  return '$base${Platform.pathSeparator}'
      '${relativePath.replaceAll('/', Platform.pathSeparator)}';
}

Future<File> _writeWizardIntake(
  Directory directory,
  Object intake,
) async {
  final file = File(_joinTestPath(directory.path, 'notes/wizard_intake.json'));
  await file.parent.create(recursive: true);
  if (intake is List<int>) {
    return file.writeAsBytes(intake, flush: true);
  }
  if (intake is String) {
    return file.writeAsString(intake, flush: true);
  }
  return file.writeAsString(jsonEncode(intake), flush: true);
}

String _manifestJson() => jsonEncode(<String, dynamic>{
      'project_id': 'inline_project',
      'schema_version': '1.0',
      'created_at': '2026-05-22T00:00:00Z',
      'device_type': 'pelle',
      'model': 'PV20',
      'symptom': 'not_provided',
    });

String _knownFactsJson() => jsonEncode(<String, dynamic>{
      'project_id': 'inline_project',
      'components': <dynamic>[],
      'pins': <dynamic>[],
      'measurements': <dynamic>[
        <String, dynamic>{
          'measurement_id': 'M001',
          'mode': 'continuity',
          'from': 'Q2.1',
          'to': 'R17.1',
          'reading': <String, dynamic>{
            'kind': 'numeric',
            'value': 1,
            'unit': 'ohm',
          },
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
    });

String _schemaVersionsJson() => jsonEncode(<String, dynamic>{
      'events_schema': '1.0',
      'known_facts_schema': '1.0',
      'project_manifest_schema': '1.0',
      'project_zip_contract': '1.0',
    });

void _addArchiveBytes(Archive archive, String name, List<int> bytes) {
  archive.addFile(ArchiveFile(name, bytes.length, bytes));
}

void _addArchiveText(Archive archive, String name, String content) {
  _addArchiveBytes(archive, name, utf8.encode(content));
}

Uint8List _createProjectZip({
  String rootPrefix = '',
  bool includeManifest = true,
  String? manifestRaw,
  String? schemaVersionsRaw,
  Object intake = _absentIntake,
}) {
  final normalizedPrefix =
      rootPrefix.isEmpty ? '' : '${rootPrefix.replaceAll(RegExp(r'/+$'), '')}/';
  String path(String relativePath) => '$normalizedPrefix$relativePath';

  final archive = Archive();
  if (includeManifest) {
    _addArchiveText(
      archive,
      path('manifest.json'),
      manifestRaw ?? _manifestJson(),
    );
  }
  _addArchiveText(archive, path('events.jsonl'), '');
  _addArchiveText(archive, path('known_facts.json'), _knownFactsJson());
  _addArchiveText(
    archive,
    path('exports/customer_report.md'),
    '# Inline report\n',
  );
  _addArchiveText(
    archive,
    path('metadata/schema_versions.json'),
    schemaVersionsRaw ?? _schemaVersionsJson(),
  );
  if (!identical(intake, _absentIntake)) {
    final List<int> bytes;
    if (intake is List<int>) {
      bytes = intake;
    } else if (intake is String) {
      bytes = utf8.encode(intake);
    } else {
      bytes = utf8.encode(jsonEncode(intake));
    }
    _addArchiveBytes(archive, path('notes/wizard_intake.json'), bytes);
  }

  final encoded = ZipEncoder().encode(archive);
  if (encoded == null) {
    throw StateError('Failed to encode test ZIP');
  }
  return Uint8List.fromList(encoded);
}

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
    const knownFactsJson =
        '{"project_id":"$projectId","components":[],"pins":[],"measurements":[],"nets":[],"excluded_from_fault_candidates":[]}';
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

  group('directory Wizard intake', () {
    test('loads valid typed intake from the named optional file', () async {
      final directory = await _createLocalProjectDirectoryForLoaderTest();
      addTearDown(() => directory.delete(recursive: true));
      final intake = _validWizardIntakeJson()
        ..['reference_frame_aspect_ratio'] = 1.75;
      await _writeWizardIntake(directory, intake);

      final loaded = await ProjectLoader.loadFromDirectory(directory.path);

      expect(loaded.wizardIntake, isNotNull);
      expect(
        loaded.wizardIntake!.problemDescription.occurrence,
        WizardProblemOccurrence.intermittent,
      );
      expect(loaded.wizardIntake!.visualCandidates.single.draftKey, 1);
      expect(
        loaded.wizardIntake!.toJson()['reference_frame_aspect_ratio'],
        1.75,
      );
      expect(loaded.wizardIntakeWarning, isNull);
    });

    test('loads legacy intake with the exact square-fallback warning',
        () async {
      final directory = await _createLocalProjectDirectoryForLoaderTest();
      addTearDown(() => directory.delete(recursive: true));
      await _writeWizardIntake(
        directory,
        _validWizardIntakeJson(referenceFrameAspectRatio: null),
      );

      final loaded = await ProjectLoader.loadFromDirectory(directory.path);

      expect(loaded.wizardIntake, isNotNull);
      expect(loaded.wizardIntakeWarning, _legacyWizardIntakeWarning);
      expect(
        loaded.wizardIntake!.toJson(),
        isNot(contains('reference_frame_aspect_ratio')),
      );
    });

    test('keeps project load successful for invalid reference-frame metadata',
        () async {
      final directory = await _createLocalProjectDirectoryForLoaderTest();
      addTearDown(() => directory.delete(recursive: true));
      final intake = _validWizardIntakeJson()
        ..['reference_frame_aspect_ratio'] = 0;
      await _writeWizardIntake(directory, intake);

      final loaded = await ProjectLoader.loadFromDirectory(directory.path);

      expect(loaded.manifest.projectId, 'inline_project');
      expect(loaded.wizardIntake, isNull);
      expect(loaded.wizardIntakeWarning, _wizardIntakeWarning);
    });

    test('treats a missing intake file as null and silent', () async {
      final directory = await _createLocalProjectDirectoryForLoaderTest();
      addTearDown(() => directory.delete(recursive: true));

      final loaded = await ProjectLoader.loadFromDirectory(directory.path);

      expect(loaded.wizardIntake, isNull);
      expect(loaded.wizardIntakeWarning, isNull);
    });

    test('keeps project load successful for malformed intake', () async {
      final directory = await _createLocalProjectDirectoryForLoaderTest();
      addTearDown(() => directory.delete(recursive: true));
      await _writeWizardIntake(directory, '{malformed-json');

      final loaded = await ProjectLoader.loadFromDirectory(directory.path);

      expect(loaded.manifest.projectId, 'inline_project');
      expect(loaded.wizardIntake, isNull);
      expect(loaded.wizardIntakeWarning, _wizardIntakeWarning);
      expect(loaded.wizardIntakeWarning, isNot(contains('malformed-json')));
    });

    test('keeps project load successful for unsupported intake version',
        () async {
      final directory = await _createLocalProjectDirectoryForLoaderTest();
      addTearDown(() => directory.delete(recursive: true));
      await _writeWizardIntake(
        directory,
        _validWizardIntakeJson(schemaVersion: '2.0'),
      );

      final loaded = await ProjectLoader.loadFromDirectory(directory.path);

      expect(loaded.manifest.projectId, 'inline_project');
      expect(loaded.wizardIntake, isNull);
      expect(loaded.wizardIntakeWarning, _wizardIntakeWarning);
    });

    test('keeps project load successful for invalid intake UTF-8', () async {
      final directory = await _createLocalProjectDirectoryForLoaderTest();
      addTearDown(() => directory.delete(recursive: true));
      await _writeWizardIntake(directory, <int>[0xC3, 0x28]);

      final loaded = await ProjectLoader.loadFromDirectory(directory.path);

      expect(loaded.manifest.projectId, 'inline_project');
      expect(loaded.wizardIntake, isNull);
      expect(loaded.wizardIntakeWarning, _wizardIntakeWarning);
    });

    test('does not modify any loaded project input', () async {
      final directory = await _createLocalProjectDirectoryForLoaderTest();
      addTearDown(() => directory.delete(recursive: true));
      await _writeWizardIntake(directory, _validWizardIntakeJson());
      final paths = <String>[
        'manifest.json',
        'events.jsonl',
        'known_facts.json',
        'exports/customer_report.md',
        'metadata/schema_versions.json',
        'notes/wizard_intake.json',
      ];
      final before = <String, List<int>>{
        for (final path in paths)
          path: await File(_joinTestPath(directory.path, path)).readAsBytes(),
      };

      await ProjectLoader.loadFromDirectory(directory.path);

      for (final path in paths) {
        expect(
          await File(_joinTestPath(directory.path, path)).readAsBytes(),
          before[path],
          reason: path,
        );
      }
    });
  });

  group('ZIP Wizard intake', () {
    test('loads valid intake at the exact archive path', () async {
      final intake = _validWizardIntakeJson()
        ..['reference_frame_aspect_ratio'] = 1.75;
      final loaded = await ProjectLoader.loadFromZipBytes(
        _createProjectZip(intake: intake),
      );

      expect(loaded.wizardIntake, isNotNull);
      expect(loaded.wizardIntake!.problemDescription.description,
          'Power cycles under load');
      expect(
        loaded.wizardIntake!.toJson()['reference_frame_aspect_ratio'],
        1.75,
      );
      expect(loaded.wizardIntakeWarning, isNull);
    });

    test('loads valid intake beneath an archive root prefix', () async {
      final intake = _validWizardIntakeJson()
        ..['reference_frame_aspect_ratio'] = 1.75;
      final loaded = await ProjectLoader.loadFromZipBytes(
        _createProjectZip(
          rootPrefix: 'outer/project-root',
          intake: intake,
        ),
      );

      expect(loaded.manifest.projectId, 'inline_project');
      expect(loaded.wizardIntake, isNotNull);
      expect(loaded.wizardIntake!.contour.points, hasLength(3));
      expect(
        loaded.wizardIntake!.toJson()['reference_frame_aspect_ratio'],
        1.75,
      );
      expect(loaded.wizardIntakeWarning, isNull);
    });

    test('loads legacy ZIP intake with the exact square-fallback warning',
        () async {
      final loaded = await ProjectLoader.loadFromZipBytes(
        _createProjectZip(
          intake: _validWizardIntakeJson(referenceFrameAspectRatio: null),
        ),
      );

      expect(loaded.wizardIntake, isNotNull);
      expect(loaded.wizardIntakeWarning, _legacyWizardIntakeWarning);
    });

    test('treats a missing intake entry as null and silent', () async {
      final loaded = await ProjectLoader.loadFromZipBytes(_createProjectZip());

      expect(loaded.wizardIntake, isNull);
      expect(loaded.wizardIntakeWarning, isNull);
    });

    test('keeps project load successful for malformed intake', () async {
      final loaded = await ProjectLoader.loadFromZipBytes(
        _createProjectZip(intake: '{malformed-json'),
      );

      expect(loaded.manifest.projectId, 'inline_project');
      expect(loaded.wizardIntake, isNull);
      expect(loaded.wizardIntakeWarning, _wizardIntakeWarning);
      expect(loaded.wizardIntakeWarning, isNot(contains('malformed-json')));
    });

    test('warns for unsupported version or coordinate space', () async {
      final cases = <Map<String, dynamic>>[
        _validWizardIntakeJson(schemaVersion: '2.0'),
        _validWizardIntakeJson(coordinateSpace: 'board_normalized'),
      ];

      for (final intake in cases) {
        final loaded = await ProjectLoader.loadFromZipBytes(
          _createProjectZip(intake: intake),
        );
        expect(loaded.manifest.projectId, 'inline_project');
        expect(loaded.wizardIntake, isNull);
        expect(loaded.wizardIntakeWarning, _wizardIntakeWarning);
      }
    });

    test('keeps project load successful for invalid intake UTF-8', () async {
      final loaded = await ProjectLoader.loadFromZipBytes(
        _createProjectZip(intake: <int>[0xC3, 0x28]),
      );

      expect(loaded.manifest.projectId, 'inline_project');
      expect(loaded.wizardIntake, isNull);
      expect(loaded.wizardIntakeWarning, _wizardIntakeWarning);
    });

    test('does not swallow required manifest or schema failures', () async {
      await expectLater(
        ProjectLoader.loadFromZipBytes(
          _createProjectZip(
            manifestRaw: '[]',
            intake: '{malformed-json',
          ),
        ),
        throwsA(isA<ProjectLoadException>()),
      );
      await expectLater(
        ProjectLoader.loadFromZipBytes(
          _createProjectZip(
            schemaVersionsRaw: '[]',
            intake: '{malformed-json',
          ),
        ),
        throwsA(isA<ProjectLoadException>()),
      );
    });
  });

  group('ProjectState Wizard intake presentation state', () {
    test('debugJson excludes intake names, warning name, and human content',
        () async {
      final loaded = await ProjectLoader.loadFromZipBytes(
        _createProjectZip(
          intake: _validWizardIntakeJson(description: _debugSentinel),
        ),
      );

      expect(loaded.debugJson, isNot(contains('wizardIntake')));
      expect(loaded.debugJson, isNot(contains('wizard_intake')));
      expect(loaded.debugJson, isNot(contains('wizardIntakeWarning')));
      expect(loaded.debugJson, isNot(contains('wizard_intake_warning')));
      expect(loaded.debugJson, isNot(contains(_debugSentinel)));
    });

    test('copyWith preserves intake and warning while adding provenance',
        () async {
      final valid = await ProjectLoader.loadFromZipBytes(
        _createProjectZip(intake: _validWizardIntakeJson()),
      );
      final invalid = await ProjectLoader.loadFromZipBytes(
        _createProjectZip(intake: '{malformed-json'),
      );

      final validCopy = valid.copyWith(projectDirectory: r'C:\project');
      final invalidCopy = invalid.copyWith(projectDirectory: r'C:\project');

      expect(validCopy.wizardIntake, same(valid.wizardIntake));
      expect(validCopy.wizardIntakeWarning, isNull);
      expect(validCopy.projectDirectory, r'C:\project');
      expect(invalidCopy.wizardIntake, isNull);
      expect(invalidCopy.wizardIntakeWarning, _wizardIntakeWarning);
      expect(invalidCopy.projectDirectory, r'C:\project');
    });

    test('preserves existing counters and projection freshness behavior',
        () async {
      final loaded = await ProjectLoader.loadFromZipBytes(
        _createProjectZip(intake: _validWizardIntakeJson()),
      );

      expect(loaded.componentCount, 0);
      expect(loaded.measurementCount, 1);
      expect(loaded.activeMeasurementCount, 1);
      expect(loaded.staleMeasurementCount, 0);
      expect(loaded.isProjectionStale, isFalse);
      expect(
          loaded.copyWith(isProjectionStale: true).isProjectionStale, isTrue);
      expect(
        loaded.copyWith(isProjectionStale: true).wizardIntake,
        same(loaded.wizardIntake),
      );
    });
  });
}
