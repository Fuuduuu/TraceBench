import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:trace_bench_viewer/shared/models/project_manifest.dart';
import 'package:trace_bench_viewer/shared/models/wizard_intake.dart';
import 'package:trace_bench_viewer/shared/services/project_creator.dart';
import 'package:trace_bench_viewer/shared/services/project_loader.dart';
import 'package:trace_bench_viewer/shared/services/python_runner.dart';

class _TestPlatformInfo extends PlatformInfo {
  const _TestPlatformInfo(this._isMobile);

  final bool _isMobile;

  @override
  bool get isMobile => _isMobile;
}

class _CallRecord {
  const _CallRecord(this.command, this.workingDirectory);

  final List<String> command;
  final String workingDirectory;
}

class _FakeProcessRunner extends ProcessRunner {
  _FakeProcessRunner({required this.behavior});

  final ProcessResult Function(List<String> command, String workingDirectory)
      behavior;
  final List<_CallRecord> calls = <_CallRecord>[];

  @override
  Future<ProcessResult> run({
    required List<String> command,
    required String workingDirectory,
    required Duration timeout,
    bool runInShell = false,
  }) async {
    calls.add(_CallRecord(List<String>.from(command), workingDirectory));
    return behavior(command, workingDirectory);
  }
}

ProcessResult _ok([String stdout = 'ok']) => ProcessResult(0, 0, stdout, '');
ProcessResult _fail([String stderr = 'failed']) =>
    ProcessResult(0, 2, '', stderr);

void _writeMaterializedKnownFacts(String path, String projectId) {
  final knownFacts = <String, dynamic>{
    'project_id': projectId,
    'components': <dynamic>[],
    'pins': <dynamic>[],
    'measurements': <dynamic>[],
    'nets': <dynamic>[],
    'photos': <dynamic>[],
    'damage_regions': <dynamic>[],
    'suspect_regions': <dynamic>[],
    'visual_traces': <dynamic>[],
    'excluded_from_fault_candidates': <dynamic>[],
    'component_pin_index': <String, dynamic>{},
  };
  File(path).writeAsStringSync(
    const JsonEncoder.withIndent('  ').convert(knownFacts),
    flush: true,
  );
}

WizardIntake _wizardIntake({
  String description = '  Human problem\nkept verbatim  ',
  bool includePhoto = false,
}) {
  return WizardIntake(
    schemaVersion: '1.0',
    coordinateSpace: 'wizard_normalized',
    problemDescription: WizardProblemDescription(
      description: description,
      occurrence: WizardProblemOccurrence.intermittent,
      whenOccurs: '  After warming up  ',
      symptoms: 'Display flickers\nthen dims',
      attempts: 'Reseated cable',
    ),
    contour: WizardContour(
      closed: true,
      points: const <WizardPoint>[
        WizardPoint(x: 0.1, y: 0.2),
        WizardPoint(x: 0.9, y: 0.2),
        WizardPoint(x: 0.8, y: 0.85),
      ],
    ),
    backgroundPhoto: includePhoto
        ? const WizardBackgroundPhoto(
            relativePath: 'photos/draft-source.JPG',
            transform: WizardPhotoTransform(
              translation: WizardPoint(x: -0.2, y: 0.3),
              scale: 1.4,
              rotationRadians: 0.45,
              opacity: 0.7,
            ),
          )
        : null,
    visualCandidates: const <WizardVisualCandidate>[
      WizardVisualCandidate(
        draftKey: 7,
        position: WizardPoint(x: 0.35, y: 0.55),
        shape: WizardVisualCandidateShape.roundedRectangle,
        sizeScale: 1.6,
        rotationRadians: -0.4,
      ),
      WizardVisualCandidate(
        draftKey: 2,
        position: WizardPoint(x: 0.75, y: 0.4),
        shape: WizardVisualCandidateShape.circle,
        sizeScale: 0.8,
        rotationRadians: 0.2,
      ),
    ],
  );
}

ProjectCreationRequest _request({
  required String destinationParentPath,
  String projectName = '  Human project  ',
  String deviceName = '  Bench unit  ',
  String additionalInfo = 'line one\nline two',
  String deviceType = '  controller  ',
  String manufacturer = '  Maker  ',
  String model = '  Model X  ',
  String revision = '  Rev B  ',
  WizardIntake? wizardIntake,
  String? sourcePhotoPath,
}) {
  return ProjectCreationRequest(
    destinationParentPath: destinationParentPath,
    projectName: projectName,
    deviceName: deviceName,
    additionalInfo: additionalInfo,
    deviceType: deviceType,
    manufacturer: manufacturer,
    model: model,
    revision: revision,
    wizardIntake:
        wizardIntake ?? _wizardIntake(includePhoto: sourcePhotoPath != null),
    sourcePhotoPath: sourcePhotoPath,
  );
}

_FakeProcessRunner _successfulProcessRunner() {
  return _FakeProcessRunner(
    behavior: (command, _) {
      if (command.last == '--version') {
        return _ok('Python 3.11');
      }
      if (command.contains('tools/materialize_known_facts.py')) {
        final output = File(command.last);
        final projectId = output.parent.path.split(Platform.pathSeparator).last;
        _writeMaterializedKnownFacts(output.path, projectId);
        return _ok('materialized');
      }
      return _ok();
    },
  );
}

void main() {
  group('ProjectManifest compatibility', () {
    test('old manifests and constructor calls keep working', () {
      const constructed = ProjectManifest(
        projectId: 'prj_01020304',
        schemaVersion: '1.0',
        createdAt: '2026-08-03T10:00:00.000Z',
        deviceType: 'board',
        model: 'legacy',
        symptom: 'legacy symptom',
      );
      final parsed = ProjectManifest.fromJson(<String, dynamic>{
        'project_id': 'prj_01020304',
        'schema_version': '1.0',
        'created_at': '2026-08-03T10:00:00.000Z',
        'device_type': 'board',
        'model': 'legacy',
        'symptom': 'legacy symptom',
      });

      expect(constructed.projectName, isNull);
      expect(parsed.projectName, isNull);
      expect(parsed.deviceName, isNull);
      expect(parsed.additionalInfo, isNull);
      expect(parsed.manufacturer, isNull);
      expect(parsed.revision, isNull);
      expect(
        parsed.toJson(),
        isNot(containsPair('project_name', anything)),
      );
    });

    test('new optional display metadata parses and serializes verbatim', () {
      const manifest = ProjectManifest(
        projectId: 'prj_a1b2c3d4',
        schemaVersion: '1.0',
        createdAt: '2026-08-03T10:00:00.000Z',
        projectName: '  Human project  ',
        deviceName: '  Bench unit  ',
        additionalInfo: 'line one\nline two',
        deviceType: '  controller  ',
        manufacturer: '  Maker  ',
        model: '  Model X  ',
        revision: '  Rev B  ',
        symptom: '  Exact symptom\ntext  ',
      );

      final encoded = manifest.toJson();
      final parsed = ProjectManifest.fromJson(encoded);

      expect(encoded['project_name'], '  Human project  ');
      expect(encoded['device_name'], '  Bench unit  ');
      expect(encoded['additional_info'], 'line one\nline two');
      expect(encoded['manufacturer'], '  Maker  ');
      expect(encoded['revision'], '  Rev B  ');
      expect(parsed.projectName, manifest.projectName);
      expect(parsed.deviceName, manifest.deviceName);
      expect(parsed.additionalInfo, manifest.additionalInfo);
      expect(parsed.manufacturer, manifest.manufacturer);
      expect(parsed.revision, manifest.revision);
      expect(parsed.symptom, '  Exact symptom\ntext  ');
    });

    test('schema keeps v1 requirements and allows the five optional strings',
        () {
      final schema = jsonDecode(
        File('schemas/project_manifest.schema.json').readAsStringSync(),
      ) as Map<String, dynamic>;
      final properties = schema['properties']! as Map<String, dynamic>;

      expect(schema['required'], <dynamic>[
        'project_id',
        'schema_version',
        'created_at',
      ]);
      expect(schema['additionalProperties'], isTrue);
      for (final key in <String>[
        'project_name',
        'device_name',
        'additional_info',
        'manufacturer',
        'revision',
      ]) {
        expect(properties[key], <String, dynamic>{'type': 'string'});
      }
      expect(properties['schema_version'], <String, dynamic>{'const': '1.0'});
    });
  });

  group('ProjectCreator', () {
    test('project_id follows wizard regex format', () {
      final creator = ProjectCreator(
        platformInfo: const _TestPlatformInfo(false),
      );
      final projectId = creator.generateProjectId();
      expect(RegExp(r'^prj_[a-f0-9]{8}$').hasMatch(projectId), isTrue);
    });

    test('project_id is unique across repeated generation', () {
      final creator = ProjectCreator(
        platformInfo: const _TestPlatformInfo(false),
      );
      final ids = <String>{};
      for (var i = 0; i < 64; i++) {
        ids.add(creator.generateProjectId());
      }
      expect(ids.length, 64);
    });

    test('collision returns collision', () async {
      final parentDir = await Directory.systemTemp.createTemp('tb-creator-');
      addTearDown(() => parentDir.delete(recursive: true));

      const projectId = 'prj_deadbeef';
      final collision = await Directory(
        '${parentDir.path}${Platform.pathSeparator}$projectId',
      ).create(recursive: true);
      final marker = File(
        '${collision.path}${Platform.pathSeparator}keep.txt',
      );
      await marker.writeAsString('unchanged');

      final creator = ProjectCreator(
        platformInfo: const _TestPlatformInfo(false),
        projectIdGenerator: () => projectId,
      );

      final result = await creator.createProject(
        _request(
          destinationParentPath: parentDir.path,
        ),
      );

      expect(result, isA<ProjectCreationCollision>());
      expect(await marker.readAsString(), 'unchanged');
    });

    test('mobile returns mobilePlaceholder', () async {
      final creator = ProjectCreator(
        platformInfo: const _TestPlatformInfo(true),
      );

      final result = await creator.createProject(
        _request(
          destinationParentPath: '/tmp',
        ),
      );

      expect(result, isA<ProjectCreationMobilePlaceholder>());
    });

    test(
        'creates manifest defaults, empty events, metadata and placeholder report',
        () async {
      final parentDir = await Directory.systemTemp.createTemp('tb-creator-');
      addTearDown(() => parentDir.delete(recursive: true));

      const projectId = 'prj_a1b2c3d4';
      final now = DateTime.utc(2026, 5, 25, 10, 0, 0);
      final processRunner = _successfulProcessRunner();
      final loadedPaths = <String>[];

      final creator = ProjectCreator(
        processRunner: processRunner,
        platformInfo: const _TestPlatformInfo(false),
        repoRootPath: Directory.current.path,
        projectIdGenerator: () => projectId,
        now: () => now,
        projectLoader: (path) {
          loadedPaths.add(path);
          return ProjectLoader.loadFromDirectory(path);
        },
      );

      const rawSymptom = '  Exact Step 5 problem\nkept verbatim  ';
      final result = await creator.createProject(
        _request(
          destinationParentPath: parentDir.path,
          wizardIntake: _wizardIntake(description: rawSymptom),
        ),
      );

      expect(result, isA<ProjectCreationSuccess>());
      final state = (result as ProjectCreationSuccess).projectState;
      final projectPath = state.projectDirectory!;
      final knownFactsFile =
          File('$projectPath${Platform.pathSeparator}known_facts.json');
      expect(knownFactsFile.existsSync(), isTrue);

      expect(state.manifest.projectId, projectId);
      expect(state.manifest.schemaVersion, '1.0');
      expect(state.manifest.createdAt, now.toIso8601String());
      expect(state.manifest.projectName, '  Human project  ');
      expect(state.manifest.deviceName, '  Bench unit  ');
      expect(state.manifest.additionalInfo, 'line one\nline two');
      expect(state.manifest.deviceType, 'controller');
      expect(state.manifest.manufacturer, '  Maker  ');
      expect(state.manifest.model, 'Model X');
      expect(state.manifest.revision, '  Rev B  ');
      expect(state.manifest.symptom, rawSymptom);

      final eventsFile =
          File('$projectPath${Platform.pathSeparator}events.jsonl');
      final eventsContent = await eventsFile.readAsString();
      expect(eventsContent, isEmpty);
      expect(eventsContent.contains('project_created'), isFalse);
      expect(eventsContent.contains('measurement_recorded'), isFalse);
      expect(eventsContent.contains('component_created'), isFalse);
      expect(eventsContent.contains('pin_defined'), isFalse);
      expect(eventsContent.contains('repair_action_recorded'), isFalse);

      final intakeFile = File(
        '$projectPath${Platform.pathSeparator}notes${Platform.pathSeparator}wizard_intake.json',
      );
      expect(await intakeFile.exists(), isTrue);
      final intakeJson =
          jsonDecode(await intakeFile.readAsString()) as Map<String, dynamic>;
      expect(intakeJson['background_photo'], isNull);
      expect(
          await intakeFile.readAsString(), state.wizardIntake!.toJsonString());

      final schemaVersions = jsonDecode(
        await File(
          '$projectPath${Platform.pathSeparator}metadata${Platform.pathSeparator}schema_versions.json',
        ).readAsString(),
      ) as Map<String, dynamic>;
      expect(
        schemaVersions,
        equals(<String, dynamic>{
          'events_schema': '1.0',
          'known_facts_schema': '1.0',
          'project_manifest_schema': '1.0',
          'project_zip_contract': '1.0',
        }),
      );

      final report = await File(
        '$projectPath${Platform.pathSeparator}exports${Platform.pathSeparator}customer_report.md',
      ).readAsString();
      expect(report, contains('# TraceBench Project Report'));
      expect(report, contains('Project: $projectId'));
      expect(report,
          contains('No customer report evidence has been recorded yet.'));
      expect(report.toLowerCase().contains('diagnosis'), isFalse);
      expect(report.toLowerCase().contains('probability'), isFalse);

      final defaultProfile = File(
        '$projectPath${Platform.pathSeparator}device_profiles${Platform.pathSeparator}default.json',
      );
      expect(defaultProfile.existsSync(), isTrue);
      expect(defaultProfile.readAsStringSync(), '{}\n');

      expect(
        processRunner.calls.any(
          (call) => call.command.contains('tools/materialize_known_facts.py'),
        ),
        isTrue,
      );

      expect(state.knownFacts.components, isEmpty);
      expect(state.knownFacts.pins, isEmpty);
      expect(state.knownFacts.measurements, isEmpty);
      expect(state.knownFacts.nets, isEmpty);
      expect(state.knownFacts.photos, isEmpty);
      expect(state.knownFacts.damageRegions, isEmpty);
      expect(state.knownFacts.suspectRegions, isEmpty);
      expect(state.knownFacts.visualTraces, isEmpty);
      expect(state.knownFacts.excludedFromFaultCandidates, isEmpty);
      expect(state.knownFacts.componentPinIndex, isEmpty);
      expect(state.events, isEmpty);
      expect(state.isProjectionStale, isFalse);
      expect(state.projectDirectory, projectPath);
      expect(state.wizardIntake, isNotNull);
      expect(state.wizardIntake!.toJson(), intakeJson);
      expect(state.wizardIntakeWarning, isNull);
      expect(loadedPaths, <String>[projectPath]);
    });

    test('copies every supported mixed-case photo extension byte-for-byte',
        () async {
      final parentDir = await Directory.systemTemp.createTemp('tb-creator-');
      addTearDown(() => parentDir.delete(recursive: true));
      final sourceDir = await Directory.systemTemp.createTemp('tb-source-');
      addTearDown(() => sourceDir.delete(recursive: true));
      final ids = <String>[
        'prj_00000001',
        'prj_00000002',
        'prj_00000003',
        'prj_00000004',
      ].iterator;
      final creator = ProjectCreator(
        processRunner: _successfulProcessRunner(),
        platformInfo: const _TestPlatformInfo(false),
        repoRootPath: Directory.current.path,
        projectIdGenerator: () {
          ids.moveNext();
          return ids.current;
        },
      );

      for (final entry in <(String, String)>[
        ('JpG', 'jpg'),
        ('JPEG', 'jpeg'),
        ('PnG', 'png'),
        ('WeBp', 'webp'),
      ]) {
        final source = File(
          '${sourceDir.path}${Platform.pathSeparator}board.${entry.$1}',
        );
        final originalBytes = <int>[0, 1, 2, entry.$1.length, 254, 255];
        await source.writeAsBytes(originalBytes, flush: true);
        final originalPath = source.path;

        final result = await creator.createProject(
          _request(
            destinationParentPath: parentDir.path,
            sourcePhotoPath: source.path,
          ),
        );

        expect(result, isA<ProjectCreationSuccess>());
        final state = (result as ProjectCreationSuccess).projectState;
        final copied = File(
          '${state.projectDirectory}${Platform.pathSeparator}photos${Platform.pathSeparator}wizard_background.${entry.$2}',
        );
        expect(await copied.readAsBytes(), originalBytes);
        expect(await source.readAsBytes(), originalBytes);
        expect(source.path, originalPath);
        expect(await source.exists(), isTrue);
        expect(
          state.wizardIntake!.backgroundPhoto!.relativePath,
          'photos/wizard_background.${entry.$2}',
        );
        expect(
          state.wizardIntake!.backgroundPhoto!.transform.rotationRadians,
          0.45,
        );
      }
    });

    test(
        'invalid selected photos fail safely and clean only generated children',
        () async {
      final parentDir = await Directory.systemTemp.createTemp('tb-creator-');
      addTearDown(() => parentDir.delete(recursive: true));
      final sourceDir = await Directory.systemTemp.createTemp('tb-source-');
      addTearDown(() => sourceDir.delete(recursive: true));
      final sibling = File(
        '${parentDir.path}${Platform.pathSeparator}keep.txt',
      );
      await sibling.writeAsString('keep');
      final directorySource = await Directory(
        '${sourceDir.path}${Platform.pathSeparator}not-a-file.png',
      ).create();
      final unsupportedSource = File(
        '${sourceDir.path}${Platform.pathSeparator}board.gif',
      );
      await unsupportedSource.writeAsBytes(<int>[1, 2, 3]);
      final ids = <String>[
        'prj_10000001',
        'prj_10000002',
        'prj_10000003',
        'prj_10000004',
      ];
      final sources = <String>[
        '${sourceDir.path}${Platform.pathSeparator}missing.jpg',
        directorySource.path,
        unsupportedSource.path,
        '',
      ];

      for (var index = 0; index < sources.length; index += 1) {
        final creator = ProjectCreator(
          processRunner: _successfulProcessRunner(),
          platformInfo: const _TestPlatformInfo(false),
          repoRootPath: Directory.current.path,
          projectIdGenerator: () => ids[index],
        );

        final result = await creator.createProject(
          _request(
            destinationParentPath: parentDir.path,
            sourcePhotoPath: sources[index],
          ),
        );

        expect(result, isA<ProjectCreationPhotoFailed>());
        final failure = result as ProjectCreationPhotoFailed;
        expect(
            failure.sanitizedMessage, 'Taustafoto salvestamine ebaõnnestus.');
        expect(failure.sanitizedMessage.contains(sourceDir.path), isFalse);
        expect(failure.rawDetail, isNotEmpty);
        expect(
          await Directory(
            '${parentDir.path}${Platform.pathSeparator}${ids[index]}',
          ).exists(),
          isFalse,
        );
        expect(await sibling.readAsString(), 'keep');
      }
      expect(await unsupportedSource.readAsBytes(), <int>[1, 2, 3]);
      expect(await directorySource.exists(), isTrue);
    });

    test('copy failure is sanitized and preserves source, parent, and sibling',
        () async {
      final parentDir = await Directory.systemTemp.createTemp('tb-creator-');
      addTearDown(() => parentDir.delete(recursive: true));
      final sourceDir = await Directory.systemTemp.createTemp('tb-source-');
      addTearDown(() => sourceDir.delete(recursive: true));
      final source = File(
        '${sourceDir.path}${Platform.pathSeparator}board.PNG',
      );
      const originalBytes = <int>[4, 8, 15, 16, 23, 42];
      await source.writeAsBytes(originalBytes, flush: true);
      final sibling = File(
        '${parentDir.path}${Platform.pathSeparator}sibling.txt',
      );
      await sibling.writeAsString('sibling');

      final creator = ProjectCreator(
        processRunner: _successfulProcessRunner(),
        platformInfo: const _TestPlatformInfo(false),
        repoRootPath: Directory.current.path,
        projectIdGenerator: () => 'prj_c0ffee00',
        photoCopier: (_, __) => throw const FileSystemException(
          'raw copy failure C:\\Users\\demo\\board.PNG',
        ),
      );

      final result = await creator.createProject(
        _request(
          destinationParentPath: parentDir.path,
          sourcePhotoPath: source.path,
        ),
      );

      expect(result, isA<ProjectCreationPhotoFailed>());
      final failure = result as ProjectCreationPhotoFailed;
      expect(failure.sanitizedMessage, 'Taustafoto salvestamine ebaõnnestus.');
      expect(failure.sanitizedMessage.contains('C:\\Users\\'), isFalse);
      expect(failure.rawDetail, contains('raw copy failure'));
      expect(await source.readAsBytes(), originalBytes);
      expect(await sibling.readAsString(), 'sibling');
      expect(await parentDir.exists(), isTrue);
      expect(
        await Directory(
          '${parentDir.path}${Platform.pathSeparator}prj_c0ffee00',
        ).exists(),
        isFalse,
      );
    });

    test('directory-loader failure cleans the owned generated child', () async {
      final parentDir = await Directory.systemTemp.createTemp('tb-creator-');
      addTearDown(() => parentDir.delete(recursive: true));
      final sibling = File(
        '${parentDir.path}${Platform.pathSeparator}sibling.txt',
      );
      await sibling.writeAsString('sibling');
      final creator = ProjectCreator(
        processRunner: _successfulProcessRunner(),
        platformInfo: const _TestPlatformInfo(false),
        repoRootPath: Directory.current.path,
        projectIdGenerator: () => 'prj_1234abcd',
        projectLoader: (_) => throw const ProjectLoadException(
          'raw hydration failure',
        ),
      );

      final result = await creator.createProject(
        _request(destinationParentPath: parentDir.path),
      );

      expect(result, isA<ProjectCreationFailed>());
      expect(
        (result as ProjectCreationFailed).sanitizedMessage,
        'Projekti loomine ebaõnnestus.',
      );
      expect(
        await Directory(
          '${parentDir.path}${Platform.pathSeparator}prj_1234abcd',
        ).exists(),
        isFalse,
      );
      expect(await sibling.readAsString(), 'sibling');
    });

    test('invalid destination stays non-destructive', () async {
      final root = await Directory.systemTemp.createTemp('tb-creator-');
      addTearDown(() => root.delete(recursive: true));
      final missing = Directory(
        '${root.path}${Platform.pathSeparator}missing-parent',
      );
      final creator = ProjectCreator(
        platformInfo: const _TestPlatformInfo(false),
      );

      final result = await creator.createProject(
        _request(destinationParentPath: missing.path),
      );

      expect(result, isA<ProjectCreationInvalidDestination>());
      expect(await missing.exists(), isFalse);
      expect(await root.exists(), isTrue);
    });

    test('materializer failure is sanitized and cleanup is attempted',
        () async {
      final parentDir = await Directory.systemTemp.createTemp('tb-creator-');
      addTearDown(() => parentDir.delete(recursive: true));

      const projectId = 'prj_badc0de1';
      final processRunner = _FakeProcessRunner(
        behavior: (command, _) {
          if (command.last == '--version') {
            return _ok('Python 3.11');
          }
          if (command.contains('tools/materialize_known_facts.py')) {
            return _fail(
              'Traceback in C:\\Users\\demo\\materialize_known_facts.py',
            );
          }
          return _ok();
        },
      );

      final creator = ProjectCreator(
        processRunner: processRunner,
        platformInfo: const _TestPlatformInfo(false),
        repoRootPath: Directory.current.path,
        projectIdGenerator: () => projectId,
      );

      final result = await creator.createProject(
        _request(
          destinationParentPath: parentDir.path,
        ),
      );

      expect(result, isA<ProjectCreationMaterializerFailed>());
      final failure = result as ProjectCreationMaterializerFailed;
      expect(
        failure.sanitizedMessage,
        'Materialiseerimine ebaõnnestus. Kontrolli projekti sündmuste faili.',
      );
      expect(failure.sanitizedMessage.contains('/Users/'), isFalse);
      expect(failure.sanitizedMessage.contains('C:\\Users\\'), isFalse);
      expect(failure.sanitizedMessage.contains('Traceback'), isFalse);

      final createdDir =
          Directory('${parentDir.path}${Platform.pathSeparator}$projectId');
      expect(await createdDir.exists(), isFalse);
    });

    test('pythonNotFound is returned when discovery fails', () async {
      final parentDir = await Directory.systemTemp.createTemp('tb-creator-');
      addTearDown(() => parentDir.delete(recursive: true));

      final processRunner = _FakeProcessRunner(
        behavior: (_, __) => throw const ProcessException('python', <String>[]),
      );

      final creator = ProjectCreator(
        processRunner: processRunner,
        platformInfo: const _TestPlatformInfo(false),
        repoRootPath: Directory.current.path,
        projectIdGenerator: () => 'prj_abcddcba',
      );

      final result = await creator.createProject(
        _request(
          destinationParentPath: parentDir.path,
        ),
      );

      expect(result, isA<ProjectCreationPythonNotFound>());
      expect(
        await Directory(
          '${parentDir.path}${Platform.pathSeparator}prj_abcddcba',
        ).exists(),
        isFalse,
      );
    });
  });
}
