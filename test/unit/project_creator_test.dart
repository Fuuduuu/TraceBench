import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:trace_bench_viewer/shared/services/project_creator.dart';
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

void main() {
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
      await Directory('${parentDir.path}${Platform.pathSeparator}$projectId')
          .create(recursive: true);

      final creator = ProjectCreator(
        platformInfo: const _TestPlatformInfo(false),
        projectIdGenerator: () => projectId,
      );

      final result = await creator.createProject(
        ProjectCreationRequest(
          destinationParentPath: parentDir.path,
          deviceType: '',
          model: '',
          symptom: '',
        ),
      );

      expect(result, isA<ProjectCreationCollision>());
    });

    test('mobile returns mobilePlaceholder', () async {
      final creator = ProjectCreator(
        platformInfo: const _TestPlatformInfo(true),
      );

      final result = await creator.createProject(
        const ProjectCreationRequest(
          destinationParentPath: '/tmp',
          deviceType: '',
          model: '',
          symptom: '',
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
      final processRunner = _FakeProcessRunner(
        behavior: (command, _) {
          if (command.last == '--version') {
            return _ok('Python 3.11');
          }
          if (command.contains('tools/materialize_known_facts.py')) {
            _writeMaterializedKnownFacts(command.last, projectId);
            return _ok('materialized');
          }
          return _ok();
        },
      );

      final creator = ProjectCreator(
        processRunner: processRunner,
        platformInfo: const _TestPlatformInfo(false),
        repoRootPath: Directory.current.path,
        projectIdGenerator: () => projectId,
        now: () => now,
      );

      final result = await creator.createProject(
        ProjectCreationRequest(
          destinationParentPath: parentDir.path,
          deviceType: ' ',
          model: '',
          symptom: '   ',
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
      expect(state.manifest.deviceType, 'unknown');
      expect(state.manifest.model, 'unknown');
      expect(state.manifest.symptom, 'not_provided');

      final eventsFile =
          File('$projectPath${Platform.pathSeparator}events.jsonl');
      final eventsContent = await eventsFile.readAsString();
      expect(eventsContent, isEmpty);
      expect(eventsContent.contains('project_created'), isFalse);
      expect(eventsContent.contains('measurement_recorded'), isFalse);
      expect(eventsContent.contains('component_created'), isFalse);
      expect(eventsContent.contains('pin_defined'), isFalse);
      expect(eventsContent.contains('repair_action_recorded'), isFalse);

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
      expect(state.projectDirectory, isNotEmpty);
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
        ProjectCreationRequest(
          destinationParentPath: parentDir.path,
          deviceType: '',
          model: '',
          symptom: '',
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
        ProjectCreationRequest(
          destinationParentPath: parentDir.path,
          deviceType: '',
          model: '',
          symptom: '',
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
