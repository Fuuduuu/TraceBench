import 'dart:convert';
import 'dart:io';
import 'dart:math';

import '../models/known_facts.dart';
import '../models/project_manifest.dart';
import '../models/project_state.dart';
import 'project_loader.dart';
import 'python_runner.dart';

const Map<String, String> _schemaVersionsV1 = {
  'events_schema': '1.0',
  'known_facts_schema': '1.0',
  'project_manifest_schema': '1.0',
  'project_zip_contract': '1.0',
};

const String _defaultReportTemplate = '''
# TraceBench Project Report

Project: {project_id}

No customer report evidence has been recorded yet.
''';

final RegExp _projectIdPattern = RegExp(r'^prj_[a-f0-9]{8}$');

class ProjectCreationRequest {
  const ProjectCreationRequest({
    required this.destinationParentPath,
    required this.deviceType,
    required this.model,
    required this.symptom,
  });

  final String destinationParentPath;
  final String deviceType;
  final String model;
  final String symptom;
}

sealed class ProjectCreationResult {
  const ProjectCreationResult();
}

class ProjectCreationSuccess extends ProjectCreationResult {
  const ProjectCreationSuccess(this.projectState);

  final ProjectState projectState;
}

class ProjectCreationMobilePlaceholder extends ProjectCreationResult {
  const ProjectCreationMobilePlaceholder();
}

class ProjectCreationCollision extends ProjectCreationResult {
  const ProjectCreationCollision();
}

class ProjectCreationInvalidDestination extends ProjectCreationResult {
  const ProjectCreationInvalidDestination();
}

class ProjectCreationPythonNotFound extends ProjectCreationResult {
  const ProjectCreationPythonNotFound();
}

class ProjectCreationMaterializerFailed extends ProjectCreationResult {
  const ProjectCreationMaterializerFailed({
    required this.sanitizedMessage,
    required this.rawDetail,
  });

  final String sanitizedMessage;
  final String rawDetail;
}

class ProjectCreationFailed extends ProjectCreationResult {
  const ProjectCreationFailed({
    required this.sanitizedMessage,
    this.rawDetail,
  });

  final String sanitizedMessage;
  final String? rawDetail;
}

class ProjectCreator {
  ProjectCreator({
    PythonRunner? pythonRunner,
    ProcessRunner? processRunner,
    PlatformInfo? platformInfo,
    String? repoRootPath,
    String Function()? projectIdGenerator,
    DateTime Function()? now,
  })  : _pythonRunner = pythonRunner ??
            PythonRunner(
              processRunner: processRunner,
              platformInfo: platformInfo,
              repoRootPath: repoRootPath,
            ),
        _projectIdGenerator = projectIdGenerator ?? _defaultProjectIdGenerator,
        _now = now ?? DateTime.now;

  final PythonRunner _pythonRunner;
  final String Function() _projectIdGenerator;
  final DateTime Function() _now;

  static String _defaultProjectIdGenerator() {
    final random = Random.secure();
    final hex = random.nextInt(0x100000000).toRadixString(16).padLeft(8, '0');
    return 'prj_$hex';
  }

  String generateProjectId() {
    final generated = _projectIdGenerator().trim().toLowerCase();
    if (_projectIdPattern.hasMatch(generated)) {
      return generated;
    }
    return _defaultProjectIdGenerator();
  }

  Future<ProjectCreationResult> createProject(
    ProjectCreationRequest request,
  ) async {
    if (_pythonRunner.platformInfo.isMobile) {
      return const ProjectCreationMobilePlaceholder();
    }

    final destinationParentPath = request.destinationParentPath.trim();
    if (destinationParentPath.isEmpty) {
      return const ProjectCreationInvalidDestination();
    }

    final parent = Directory(destinationParentPath);
    if (!await parent.exists()) {
      return const ProjectCreationInvalidDestination();
    }

    final projectId = generateProjectId();
    final projectDirectory = Directory(
      '${parent.path}${Platform.pathSeparator}$projectId',
    );

    if (await projectDirectory.exists()) {
      return const ProjectCreationCollision();
    }

    var created = false;
    try {
      await _createSkeleton(
        projectDirectory: projectDirectory,
        request: request,
        projectId: projectId,
      );
      created = true;

      final python = await _pythonRunner.discoverPythonCommand();
      if (python == null) {
        await _cleanup(projectDirectory);
        return const ProjectCreationPythonNotFound();
      }

      final materializerResult = await _pythonRunner.run(
        command: [
          ...python,
          'tools/materialize_known_facts.py',
          '${projectDirectory.path}${Platform.pathSeparator}events.jsonl',
          '${projectDirectory.path}${Platform.pathSeparator}known_facts.json',
        ],
      );

      if (materializerResult.exitCode != 0) {
        await _cleanup(projectDirectory);
        return ProjectCreationMaterializerFailed(
          sanitizedMessage:
              'Materialiseerimine ebaõnnestus. Kontrolli projekti sündmuste faili.',
          rawDetail:
              _summarizeFailure(materializerResult, 'Materializer failed'),
        );
      }

      final projectState = await _loadCreatedProject(projectDirectory.path);
      return ProjectCreationSuccess(projectState);
    } catch (error) {
      if (created) {
        await _cleanup(projectDirectory);
      }
      return ProjectCreationFailed(
        sanitizedMessage: 'Projekti loomine ebaõnnestus.',
        rawDetail: error.toString(),
      );
    }
  }

  Future<void> _createSkeleton({
    required Directory projectDirectory,
    required ProjectCreationRequest request,
    required String projectId,
  }) async {
    await projectDirectory.create(recursive: true);
    await Directory(
      '${projectDirectory.path}${Platform.pathSeparator}exports',
    ).create(recursive: true);
    await Directory(
      '${projectDirectory.path}${Platform.pathSeparator}metadata',
    ).create(recursive: true);
    await Directory(
      '${projectDirectory.path}${Platform.pathSeparator}photos',
    ).create(recursive: true);
    await Directory(
      '${projectDirectory.path}${Platform.pathSeparator}notes',
    ).create(recursive: true);
    await Directory(
      '${projectDirectory.path}${Platform.pathSeparator}device_profiles',
    ).create(recursive: true);

    final manifest = {
      'project_id': projectId,
      'schema_version': '1.0',
      'created_at': _now().toUtc().toIso8601String(),
      'device_type': _normalizeOr(request.deviceType, 'unknown'),
      'model': _normalizeOr(request.model, 'unknown'),
      'symptom': _normalizeOr(request.symptom, 'not_provided'),
    };

    await File(
      '${projectDirectory.path}${Platform.pathSeparator}manifest.json',
    ).writeAsString(
      const JsonEncoder.withIndent('  ').convert(manifest),
      flush: true,
    );
    await File(
      '${projectDirectory.path}${Platform.pathSeparator}events.jsonl',
    ).writeAsString(
      '',
      flush: true,
    );
    await File(
      '${projectDirectory.path}${Platform.pathSeparator}metadata${Platform.pathSeparator}schema_versions.json',
    ).writeAsString(
      const JsonEncoder.withIndent('  ').convert(_schemaVersionsV1),
      flush: true,
    );
    await File(
      '${projectDirectory.path}${Platform.pathSeparator}exports${Platform.pathSeparator}customer_report.md',
    ).writeAsString(
      _defaultReportTemplate.replaceAll('{project_id}', projectId),
      flush: true,
    );
    await File(
      '${projectDirectory.path}${Platform.pathSeparator}device_profiles${Platform.pathSeparator}default.json',
    ).writeAsString(
      '{}\n',
      flush: true,
    );
  }

  Future<ProjectState> _loadCreatedProject(String projectPath) async {
    final manifestJson = jsonDecode(
      await File('$projectPath${Platform.pathSeparator}manifest.json')
          .readAsString(),
    ) as Map<String, dynamic>;
    final knownFactsJson = jsonDecode(
      await File('$projectPath${Platform.pathSeparator}known_facts.json')
          .readAsString(),
    ) as Map<String, dynamic>;
    final schemaVersionsJson = jsonDecode(
      await File(
        '$projectPath${Platform.pathSeparator}metadata${Platform.pathSeparator}schema_versions.json',
      ).readAsString(),
    ) as Map<String, dynamic>;
    final eventsRaw =
        await File('$projectPath${Platform.pathSeparator}events.jsonl')
            .readAsString();
    final customerReport = await File(
      '$projectPath${Platform.pathSeparator}exports${Platform.pathSeparator}customer_report.md',
    ).readAsString();

    return ProjectState(
      manifest: ProjectManifest.fromJson(manifestJson),
      knownFacts: KnownFacts.fromJson(knownFactsJson),
      events: ProjectLoader.parseEvents(eventsRaw),
      customerReport: customerReport,
      schemaVersions: schemaVersionsJson,
      projectDirectory: projectPath,
      isProjectionStale: false,
    );
  }

  Future<void> _cleanup(Directory projectDirectory) async {
    try {
      if (await projectDirectory.exists()) {
        await projectDirectory.delete(recursive: true);
      }
    } catch (_) {
      // Best-effort cleanup only.
    }
  }

  String _summarizeFailure(ProcessResult result, String fallback) {
    final combined = '${result.stdout}\n${result.stderr}'.trim();
    final message = combined.isEmpty ? fallback : combined;
    return message.length > 400 ? '${message.substring(0, 400)}...' : message;
  }
}

String _normalizeOr(String value, String fallback) {
  final trimmed = value.trim();
  return trimmed.isEmpty ? fallback : trimmed;
}
