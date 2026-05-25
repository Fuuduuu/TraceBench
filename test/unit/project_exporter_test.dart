import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;
import 'package:trace_bench_viewer/shared/models/known_facts.dart';
import 'package:trace_bench_viewer/shared/models/project_manifest.dart';
import 'package:trace_bench_viewer/shared/models/project_state.dart';
import 'package:trace_bench_viewer/shared/services/project_exporter.dart';

ProjectState _inlineProjectState({
  required String projectDirectory,
  String projectId = 'inline_project',
}) {
  return ProjectState(
    manifest: ProjectManifest.fromJson({
      'project_id': projectId,
      'schema_version': '1.0',
      'created_at': '2026-05-22T00:00:00Z',
      'device_type': 'pelle',
      'model': 'PV20',
      'symptom': 'not_provided',
    }),
    knownFacts: KnownFacts.fromJson({
      'project_id': projectId,
      'components': [
        {'component_id': 'Q2', 'status': 'identified', 'designator': 'Q2'},
      ],
      'pins': [
        {'component_id': 'Q2', 'pin_id': 'Q2.1'},
      ],
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
      'component_pin_index': {
        'Q2': ['Q2.1'],
      },
    }),
    events: const [],
    customerReport: 'Inline sample report',
    projectDirectory: projectDirectory,
  );
}

class _TestPlatformInfo extends PlatformInfo {
  const _TestPlatformInfo(this._isMobile);

  final bool _isMobile;

  @override
  bool get isMobile => _isMobile;
}

class _TestProcessRunner extends ProcessRunner {
  _TestProcessRunner({required this.behavior});

  final ProcessResult Function(List<String> command) behavior;
  final List<List<String>> calls = <List<String>>[];

  @override
  Future<ProcessResult> run({
    required List<String> command,
    required String workingDirectory,
    required Duration timeout,
  }) async {
    calls.add(List<String>.from(command));
    return behavior(command);
  }
}

ProcessResult _success([String output = '']) => ProcessResult(0, 0, output, '');

ProcessResult _failure([String output = 'failed', int exitCode = 1]) =>
    ProcessResult(0, exitCode, '', output);

bool _containsScript(List<String> command, String script) {
  return command.any((part) => part.contains(script));
}

Future<Directory> _createProjectDirectory({
  bool withEvents = true,
  bool withKnownFacts = true,
}) async {
  final dir =
      await Directory.systemTemp.createTemp('tracebench-exporter-test-');
  if (withEvents) {
    await File('${dir.path}/events.jsonl').writeAsString('');
  }
  if (withKnownFacts) {
    await File('${dir.path}/known_facts.json')
        .writeAsString(jsonEncode({'project_id': 'inline_project'}));
  }
  await File('${dir.path}/manifest.json').writeAsString('''
{
  "project_id": "inline_project",
  "schema_version": "1.0",
  "created_at": "2026-05-22T00:00:00Z",
  "device_type": "pelle",
  "model": "PV20",
  "symptom": "not_provided"
}
''');
  return dir;
}

void main() {
  group('ProjectExporter', () {
    test('returns noDirectory when projectDirectory is null', () async {
      final exporter = ProjectExporter(
        processRunner: _TestProcessRunner(behavior: (command) => _success()),
        platformInfo: const _TestPlatformInfo(false),
        repoRootPath: Directory.systemTemp.path,
      );

      final result = await exporter.exportProjectZip(
        ProjectState(
          manifest: const ProjectManifest(
            projectId: 'inline_project',
            schemaVersion: '1.0',
            createdAt: '2026-05-22T00:00:00Z',
            deviceType: 'pelle',
            model: 'PV20',
            symptom: 'not_provided',
          ),
          knownFacts: const KnownFacts(
            projectId: 'inline_project',
            components: [],
            pins: [],
            measurements: [],
            nets: [],
            photos: [],
            damageRegions: [],
            suspectRegions: [],
            visualTraces: [],
            excludedFromFaultCandidates: [],
            componentPinIndex: {},
          ),
          events: const [],
          customerReport: 'Inline report',
          projectDirectory: null,
        ),
      );

      expect(result, isA<ExportNoDirectory>());
    });

    test('returns mobilePlaceholder on mobile platform', () async {
      final dir = await _createProjectDirectory();
      addTearDown(() async => dir.delete(recursive: true));

      final result = await ProjectExporter(
        processRunner: _TestProcessRunner(behavior: (command) => _success()),
        platformInfo: const _TestPlatformInfo(true),
        repoRootPath: Directory.systemTemp.path,
      ).exportProjectZip(_inlineProjectState(projectDirectory: dir.path));

      expect(result, isA<ExportMobilePlaceholder>());
    });

    test('discovers py -3 before python3/python when available', () async {
      final dir = await _createProjectDirectory();
      addTearDown(() async => dir.delete(recursive: true));

      final runner = _TestProcessRunner(
        behavior: (command) {
          if (command.last == '--version' && command.first == 'py') {
            return _success('Python 3.12.0');
          }
          if (command.last == '--version') {
            return _failure();
          }
          return _success();
        },
      );

      final result = await ProjectExporter(
        processRunner: runner,
        platformInfo: const _TestPlatformInfo(false),
        repoRootPath: Directory.systemTemp.path,
      ).exportProjectZip(_inlineProjectState(projectDirectory: dir.path));

      expect(result, isA<ExportSuccess>());
      expect(runner.calls.first, equals(<String>['py', '-3', '--version']));
      expect(
        runner.calls.any(
          (call) => call.first == 'python3' && call.last == '--version',
        ),
        isFalse,
      );
      expect(
        runner.calls.any(
          (call) => call.first == 'python' && call.last == '--version',
        ),
        isFalse,
      );
    });

    test('falls back to python3/python when earlier candidates fail', () async {
      final dir = await _createProjectDirectory();
      addTearDown(() async => dir.delete(recursive: true));

      final runner = _TestProcessRunner(
        behavior: (command) {
          if (command.last == '--version') {
            if (command.first == 'py') {
              return _failure('', 1);
            }
            if (command.first == 'python3') {
              return _failure('', 1);
            }
            return _success('Python 3.11');
          }
          return _success();
        },
      );

      final result = await ProjectExporter(
        processRunner: runner,
        platformInfo: const _TestPlatformInfo(false),
        repoRootPath: Directory.systemTemp.path,
      ).exportProjectZip(_inlineProjectState(projectDirectory: dir.path));

      expect(result, isA<ExportSuccess>());
      expect(
        runner.calls.any(
          (call) =>
              call.first == 'python' &&
              !_containsScript(call, '-3') &&
              _containsScript(call, 'materialize_known_facts.py'),
        ),
        isTrue,
      );
      expect(
        runner.calls.any(
          (call) =>
              call.first == 'python' && _containsScript(call, '--version'),
        ),
        isTrue,
      );
    });

    test('returns pythonNotFound when none available', () async {
      final dir = await _createProjectDirectory();
      addTearDown(() async => dir.delete(recursive: true));

      final result = await ProjectExporter(
        processRunner: _TestProcessRunner(
          behavior: (_) => throw Exception('not found'),
        ),
        platformInfo: const _TestPlatformInfo(false),
        repoRootPath: Directory.systemTemp.path,
      ).exportProjectZip(_inlineProjectState(projectDirectory: dir.path));

      expect(result, isA<ExportPythonNotFound>());
    });

    test('calls materializer before export', () async {
      final dir = await _createProjectDirectory();
      addTearDown(() async => dir.delete(recursive: true));

      final runner = _TestProcessRunner(
        behavior: (command) {
          if (command.last == '--version') {
            return _success('Python');
          }
          if (_containsScript(command, 'materialize_known_facts.py')) {
            return _success('materialized');
          }
          if (_containsScript(command, 'export_project_zip.py')) {
            return _success('exported');
          }
          return _success();
        },
      );

      final result = await ProjectExporter(
        processRunner: runner,
        platformInfo: const _TestPlatformInfo(false),
        repoRootPath: Directory.systemTemp.path,
      ).exportProjectZip(_inlineProjectState(projectDirectory: dir.path));

      expect(result, isA<ExportSuccess>());

      final materializeIndex = runner.calls.indexWhere(
        (call) => _containsScript(call, 'materialize_known_facts.py'),
      );
      final exportIndex = runner.calls.indexWhere(
        (call) => _containsScript(call, 'export_project_zip.py'),
      );
      expect(materializeIndex, isNonNegative);
      expect(exportIndex, isNonNegative);
      expect(materializeIndex, lessThan(exportIndex));
    });

    test('aborts export if materializer fails', () async {
      final dir = await _createProjectDirectory();
      addTearDown(() async => dir.delete(recursive: true));

      final runner = _TestProcessRunner(
        behavior: (command) {
          if (command.last == '--version') {
            return _success('Python');
          }
          if (_containsScript(command, 'materialize_known_facts.py')) {
            return _failure('materializer failed', 2);
          }
          return _success();
        },
      );

      final result = await ProjectExporter(
        processRunner: runner,
        platformInfo: const _TestPlatformInfo(false),
        repoRootPath: Directory.systemTemp.path,
      ).exportProjectZip(_inlineProjectState(projectDirectory: dir.path));

      expect(result, isA<ExportMaterializerFailed>());
      final failure = result as ExportMaterializerFailed;
      expect(
        failure.sanitizedMessage,
        'Materialiseerimine ebaõnnestus. Kontrolli projekti sündmuste faili.',
      );
      expect(failure.rawDetail, contains('materializer failed'));
      expect(
        failure.sanitizedMessage,
        isNot(contains('/Users/')),
      );
      expect(
        failure.sanitizedMessage,
        isNot(contains('C:\\\\Users\\\\')),
      );
      expect(
        failure.sanitizedMessage,
        isNot(contains('\\tools\\')),
      );
      expect(
        failure.sanitizedMessage,
        isNot(contains('Traceback')),
      );
      expect(
        failure.sanitizedMessage,
        isNot(contains('materialize_known_facts.py')),
      );
      expect(
        runner.calls
            .any((call) => _containsScript(call, 'export_project_zip.py')),
        isFalse,
      );
    });

    test('returns exportFailed if export_project_zip.py fails', () async {
      final dir = await _createProjectDirectory();
      addTearDown(() async => dir.delete(recursive: true));

      final runner = _TestProcessRunner(
        behavior: (command) {
          if (command.last == '--version') {
            return _success('Python');
          }
          if (_containsScript(command, 'materialize_known_facts.py')) {
            return _success('ok');
          }
          if (_containsScript(command, 'export_project_zip.py')) {
            return _failure('export failed hard', 2);
          }
          return _success();
        },
      );

      final result = await ProjectExporter(
        processRunner: runner,
        platformInfo: const _TestPlatformInfo(false),
        repoRootPath: Directory.systemTemp.path,
      ).exportProjectZip(_inlineProjectState(projectDirectory: dir.path));

      expect(result, isA<ExportExportFailed>());
      final failure = result as ExportExportFailed;
      expect(failure.sanitizedMessage, 'ZIP pakkimine ebaõnnestus.');
      expect(failure.rawDetail, contains('export failed hard'));
      expect(
        failure.sanitizedMessage,
        isNot(contains('Traceback')),
      );
      expect(
        failure.sanitizedMessage,
        isNot(contains('/Users/')),
      );
      expect(
        failure.sanitizedMessage,
        isNot(contains('C:\\\\Users\\\\')),
      );
      expect(
        failure.sanitizedMessage,
        isNot(contains('materialize_known_facts.py')),
      );
      expect(
        failure.sanitizedMessage,
        isNot(contains('export_project_zip.py')),
      );
    });

    test('success returns zip path', () async {
      final dir = await _createProjectDirectory();
      addTearDown(() async => dir.delete(recursive: true));
      final state = _inlineProjectState(projectDirectory: dir.path);

      final runner = _TestProcessRunner(
        behavior: (command) {
          if (command.last == '--version') {
            return _success('Python');
          }
          if (_containsScript(command, 'materialize_known_facts.py') ||
              _containsScript(command, 'export_project_zip.py')) {
            return _success('ok');
          }
          return _success();
        },
      );

      final result = await ProjectExporter(
        processRunner: runner,
        platformInfo: const _TestPlatformInfo(false),
        repoRootPath: Directory.systemTemp.path,
      ).exportProjectZip(state);

      expect(result, isA<ExportSuccess>());
      expect((result as ExportSuccess).zipPath,
          endsWith('inline_project_export.zip'));
      expect(result.zipPath, contains(dir.parent.path));
    });

    test('output zip path is sibling to project directory and sanitized',
        () async {
      final dir = await _createProjectDirectory();
      addTearDown(() async => dir.delete(recursive: true));

      final runner = _TestProcessRunner(
        behavior: (command) {
          if (command.last == '--version') {
            return _success('Python');
          }
          if (_containsScript(command, 'materialize_known_facts.py') ||
              _containsScript(command, 'export_project_zip.py')) {
            return _success();
          }
          return _success();
        },
      );

      const projectId = 'proj/../bad\\name:sample';
      final state = _inlineProjectState(
        projectDirectory: dir.path,
        projectId: projectId,
      );
      final result = await ProjectExporter(
        processRunner: runner,
        platformInfo: const _TestPlatformInfo(false),
        repoRootPath: Directory.systemTemp.path,
      ).exportProjectZip(state);

      final zipPath = (result as ExportSuccess).zipPath;
      expect(p.dirname(zipPath), equals(Directory(dir.path).parent.path));
      expect(p.basename(zipPath), equals('proj_.._bad_name_sample_export.zip'));
      expect(zipPath, isNot(contains('..${Platform.pathSeparator}')));
    });

    test('no direct known_facts mutation is performed by Dart service',
        () async {
      final dir = await _createProjectDirectory();
      addTearDown(() async => dir.delete(recursive: true));
      final knownFactsPath = File('${dir.path}/known_facts.json');
      final eventsPath = File('${dir.path}/events.jsonl');
      final originalKnownFacts = knownFactsPath.readAsStringSync();
      final originalEvents = eventsPath.readAsStringSync();

      final runner = _TestProcessRunner(
        behavior: (command) {
          if (command.last == '--version') {
            return _success('Python');
          }
          if (_containsScript(command, 'materialize_known_facts.py') ||
              _containsScript(command, 'export_project_zip.py')) {
            return _success();
          }
          return _success();
        },
      );

      await ProjectExporter(
        processRunner: runner,
        platformInfo: const _TestPlatformInfo(false),
        repoRootPath: Directory.systemTemp.path,
      ).exportProjectZip(_inlineProjectState(projectDirectory: dir.path));

      expect(knownFactsPath.readAsStringSync(), originalKnownFacts);
      expect(eventsPath.readAsStringSync(), originalEvents);
    });

    test('no event write is performed by Dart service', () async {
      final dir = await _createProjectDirectory();
      addTearDown(() async => dir.delete(recursive: true));

      final eventsPath = File('${dir.path}/events.jsonl');
      final originalEvents = eventsPath.readAsStringSync();

      final runner = _TestProcessRunner(
        behavior: (command) {
          if (command.last == '--version') {
            return _success('Python');
          }
          if (_containsScript(command, 'materialize_known_facts.py') ||
              _containsScript(command, 'export_project_zip.py')) {
            return _success();
          }
          return _success();
        },
      );

      await ProjectExporter(
        processRunner: runner,
        platformInfo: const _TestPlatformInfo(false),
        repoRootPath: Directory.systemTemp.path,
      ).exportProjectZip(_inlineProjectState(projectDirectory: dir.path));

      expect(eventsPath.readAsStringSync(), originalEvents);
    });
  });
}
