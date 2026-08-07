import 'dart:convert';
import 'dart:io';
import 'dart:math';

import '../models/project_manifest.dart';
import '../models/project_state.dart';
import '../models/wizard_intake.dart';
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
    required this.projectName,
    required this.deviceName,
    required this.additionalInfo,
    required this.deviceType,
    required this.manufacturer,
    required this.model,
    required this.revision,
    required this.wizardIntake,
    this.sourcePhotoPath,
  });

  final String destinationParentPath;
  final String projectName;
  final String deviceName;
  final String additionalInfo;
  final String deviceType;
  final String manufacturer;
  final String model;
  final String revision;
  final WizardIntake wizardIntake;
  final String? sourcePhotoPath;
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

class ProjectCreationPhotoFailed extends ProjectCreationResult {
  const ProjectCreationPhotoFailed({
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
    Future<ProjectState> Function(String projectDirectory)? projectLoader,
    Future<void> Function(File source, File destination)? photoCopier,
  })  : _pythonRunner = pythonRunner ??
            PythonRunner(
              processRunner: processRunner,
              platformInfo: platformInfo,
              repoRootPath: repoRootPath,
            ),
        _projectIdGenerator = projectIdGenerator ?? _defaultProjectIdGenerator,
        _now = now ?? DateTime.now,
        _projectLoader = projectLoader ?? ProjectLoader.loadFromDirectory,
        _photoCopier = photoCopier ?? _copyPhoto;

  final PythonRunner _pythonRunner;
  final String Function() _projectIdGenerator;
  final DateTime Function() _now;
  final Future<ProjectState> Function(String projectDirectory) _projectLoader;
  final Future<void> Function(File source, File destination) _photoCopier;

  static Future<void> _copyPhoto(File source, File destination) async {
    await source.copy(destination.path);
  }

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

    final existingType = await FileSystemEntity.type(
      projectDirectory.path,
      followLinks: false,
    );
    if (existingType != FileSystemEntityType.notFound) {
      return const ProjectCreationCollision();
    }

    var ownsGeneratedChild = false;
    try {
      await projectDirectory.create();
      ownsGeneratedChild = true;

      await _createSkeleton(
        projectDirectory: projectDirectory,
        request: request,
        projectId: projectId,
      );
      await _writeWizardIntake(
        projectDirectory: projectDirectory,
        request: request,
      );

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

      final projectState = await _projectLoader(projectDirectory.path);
      return ProjectCreationSuccess(projectState);
    } on _ProjectCreationPhotoException catch (error) {
      if (ownsGeneratedChild) {
        await _cleanup(projectDirectory);
      }
      return ProjectCreationPhotoFailed(
        sanitizedMessage: 'Taustafoto salvestamine ebaõnnestus.',
        rawDetail: error.rawDetail,
      );
    } catch (error) {
      if (ownsGeneratedChild) {
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

    final manifest = ProjectManifest(
      projectId: projectId,
      schemaVersion: '1.0',
      createdAt: _now().toUtc().toIso8601String(),
      projectName: request.projectName,
      deviceName: request.deviceName,
      additionalInfo: request.additionalInfo,
      deviceType: _normalizeOr(request.deviceType, 'unknown'),
      manufacturer: request.manufacturer,
      model: _normalizeOr(request.model, 'unknown'),
      revision: request.revision,
      symptom: request.wizardIntake.problemDescription.description,
    ).toJson();

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

  Future<void> _writeWizardIntake({
    required Directory projectDirectory,
    required ProjectCreationRequest request,
  }) async {
    final intake = await _intakeForStorage(
      projectDirectory: projectDirectory,
      request: request,
    );
    final validatedIntake = WizardIntake.fromJson(intake.toJson());
    await File(
      '${projectDirectory.path}${Platform.pathSeparator}notes${Platform.pathSeparator}wizard_intake.json',
    ).writeAsString(
      validatedIntake.toJsonString(),
      flush: true,
    );
  }

  Future<WizardIntake> _intakeForStorage({
    required Directory projectDirectory,
    required ProjectCreationRequest request,
  }) async {
    final sourcePath = request.sourcePhotoPath;
    if (sourcePath == null) {
      return _copyIntakeWithPhoto(request.wizardIntake, null);
    }

    try {
      if (sourcePath.isEmpty) {
        throw const _ProjectCreationPhotoException(
          'Selected photo path is empty.',
        );
      }

      final extension = _supportedPhotoExtension(sourcePath);
      if (extension == null) {
        throw _ProjectCreationPhotoException(
          'Selected photo has an unsupported extension: $sourcePath',
        );
      }

      final source = File(sourcePath);
      final sourceType = await FileSystemEntity.type(
        source.path,
        followLinks: true,
      );
      if (sourceType != FileSystemEntityType.file) {
        throw _ProjectCreationPhotoException(
          'Selected photo is missing or is not a file: $sourcePath',
        );
      }

      if (_pathIsWithinDirectory(source.absolute.path, projectDirectory.path)) {
        throw _ProjectCreationPhotoException(
          'Selected photo is inside the generated project: $sourcePath',
        );
      }
      final resolvedSource = await source.resolveSymbolicLinks();
      final resolvedProject = await projectDirectory.resolveSymbolicLinks();
      if (_pathIsWithinDirectory(resolvedSource, resolvedProject)) {
        throw _ProjectCreationPhotoException(
          'Selected photo resolves inside the generated project: $sourcePath',
        );
      }

      final inputPhoto = request.wizardIntake.backgroundPhoto;
      if (inputPhoto == null) {
        throw const _ProjectCreationPhotoException(
          'Selected photo has no typed transform.',
        );
      }

      final relativePath = 'photos/wizard_background.$extension';
      final destination = File(
        '${projectDirectory.path}${Platform.pathSeparator}photos${Platform.pathSeparator}wizard_background.$extension',
      );
      await _photoCopier(source, destination);
      final destinationType = await FileSystemEntity.type(
        destination.path,
        followLinks: true,
      );
      if (destinationType != FileSystemEntityType.file) {
        throw const _ProjectCreationPhotoException(
          'Selected photo copy did not produce a file.',
        );
      }

      return _copyIntakeWithPhoto(
        request.wizardIntake,
        WizardBackgroundPhoto(
          relativePath: relativePath,
          transform: inputPhoto.transform,
        ),
      );
    } on _ProjectCreationPhotoException {
      rethrow;
    } catch (error) {
      throw _ProjectCreationPhotoException(error.toString());
    }
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

String? _supportedPhotoExtension(String path) {
  final fileName = path.replaceAll('\\', '/').split('/').last;
  final dotIndex = fileName.lastIndexOf('.');
  if (dotIndex < 0 || dotIndex == fileName.length - 1) {
    return null;
  }
  final extension = fileName.substring(dotIndex + 1).toLowerCase();
  return const <String>{'jpg', 'jpeg', 'png', 'webp'}.contains(extension)
      ? extension
      : null;
}

WizardIntake _copyIntakeWithPhoto(
  WizardIntake source,
  WizardBackgroundPhoto? backgroundPhoto,
) {
  return WizardIntake(
    schemaVersion: source.schemaVersion,
    coordinateSpace: source.coordinateSpace,
    referenceFrameAspectRatio: source.referenceFrameAspectRatio,
    problemDescription: source.problemDescription,
    contour: source.contour,
    backgroundPhoto: backgroundPhoto,
    visualCandidates: source.visualCandidates,
  );
}

bool _pathIsWithinDirectory(String candidatePath, String directoryPath) {
  String normalize(String value) {
    var normalized = File(value).absolute.path.replaceAll('\\', '/');
    while (normalized.length > 1 && normalized.endsWith('/')) {
      normalized = normalized.substring(0, normalized.length - 1);
    }
    return Platform.isWindows ? normalized.toLowerCase() : normalized;
  }

  final candidate = normalize(candidatePath);
  final directory = normalize(directoryPath);
  return candidate == directory || candidate.startsWith('$directory/');
}

class _ProjectCreationPhotoException implements Exception {
  const _ProjectCreationPhotoException(this.rawDetail);

  final String rawDetail;
}

String _normalizeOr(String value, String fallback) {
  final trimmed = value.trim();
  return trimmed.isEmpty ? fallback : trimmed;
}
