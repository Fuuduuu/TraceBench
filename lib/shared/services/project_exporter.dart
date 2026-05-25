import 'dart:io';

import '../models/project_state.dart';
import 'python_runner.dart';
export 'python_runner.dart' show PlatformInfo, ProcessRunner;

sealed class ExportResult {
  const ExportResult();
}

class ExportSuccess extends ExportResult {
  const ExportSuccess(this.zipPath);

  final String zipPath;
}

class ExportMobilePlaceholder extends ExportResult {
  const ExportMobilePlaceholder();
}

class ExportNoDirectory extends ExportResult {
  const ExportNoDirectory();
}

class ExportPythonNotFound extends ExportResult {
  const ExportPythonNotFound();
}

class ExportMaterializerFailed extends ExportResult {
  const ExportMaterializerFailed({
    required this.sanitizedMessage,
    required this.rawDetail,
  });

  final String sanitizedMessage;
  final String rawDetail;
}

class ExportExportFailed extends ExportResult {
  const ExportExportFailed({
    required this.sanitizedMessage,
    required this.rawDetail,
  });

  final String sanitizedMessage;
  final String rawDetail;
}

class ProjectExporter {
  ProjectExporter({
    PythonRunner? pythonRunner,
    ProcessRunner? processRunner,
    PlatformInfo? platformInfo,
    String? repoRootPath,
  }) : _pythonRunner = pythonRunner ??
            PythonRunner(
              processRunner: processRunner,
              platformInfo: platformInfo,
              repoRootPath: repoRootPath,
            );

  final PythonRunner _pythonRunner;

  Future<ExportResult> exportProjectZip(ProjectState projectState) async {
    if (_pythonRunner.platformInfo.isMobile) {
      return const ExportMobilePlaceholder();
    }

    final projectDirectory = projectState.projectDirectory;
    if (projectDirectory == null || projectDirectory.trim().isEmpty) {
      return const ExportNoDirectory();
    }

    final python = await _discoverPython();
    if (python == null) {
      return const ExportPythonNotFound();
    }

    final materializerCommand = [
      ...python,
      'tools/materialize_known_facts.py',
      _joinPath(projectDirectory, 'events.jsonl'),
      _joinPath(projectDirectory, 'known_facts.json'),
    ];

    final materializerResult = await _runCommand(materializerCommand);
    if (materializerResult.exitCode != 0) {
      return ExportMaterializerFailed(
        sanitizedMessage:
            'Materialiseerimine ebaõnnestus. Kontrolli projekti sündmuste faili.',
        rawDetail: _summarizeFailure(materializerResult, 'Materializer failed'),
      );
    }

    final zipPath =
        _buildExportZipPath(projectDirectory, projectState.manifest.projectId);
    final exportCommand = [
      ...python,
      'tools/export_project_zip.py',
      projectDirectory,
      zipPath,
    ];

    final exportResult = await _runCommand(exportCommand);
    if (exportResult.exitCode != 0) {
      return ExportExportFailed(
        sanitizedMessage: 'ZIP pakkimine ebaõnnestus.',
        rawDetail: _summarizeFailure(exportResult, 'Export failed'),
      );
    }

    return ExportSuccess(zipPath);
  }

  Future<List<String>?> _discoverPython() async {
    try {
      return await _pythonRunner.discoverPythonCommand();
    } on PythonDiscoveryException {
      return null;
    }
  }

  Future<ProcessResult> _runCommand(
    List<String> command,
  ) async {
    try {
      return await _pythonRunner.run(command: command);
    } on PythonDiscoveryException catch (error) {
      return ProcessResult(0, 1, '', error.toString());
    }
  }

  String _buildExportZipPath(String projectDirectory, String projectId) {
    final projectDir = Directory(projectDirectory);
    final parent = projectDir.parent.path;
    final normalizedPath = projectDir.path.replaceAll('\\', '/');
    final segments = normalizedPath
        .split('/')
        .where((segment) => segment.isNotEmpty)
        .toList();
    final folderName = segments.isNotEmpty ? segments.last : 'project';
    final preferred =
        projectId.trim().isNotEmpty ? projectId.trim() : folderName;
    final safeBase = _sanitizeName(preferred);
    return _joinPath(parent, '${safeBase}_export.zip');
  }

  String _joinPath(String base, String child) {
    if (base.endsWith('/') || base.endsWith('\\')) {
      return '$base$child';
    }
    return '$base${Platform.pathSeparator}$child';
  }

  String _sanitizeName(String value) {
    final sanitized = value
        .replaceAll(RegExp(r'[\\/]'), '_')
        .replaceAll(RegExp(r'[\*\?:"<>\\|]'), '_')
        .replaceAll(RegExp(r'\s+'), '_')
        .trim();
    return sanitized.isEmpty ? 'project' : sanitized;
  }

  String _summarizeFailure(ProcessResult result, String fallback) {
    final combined = '${result.stdout}\n${result.stderr}'.trim();
    final message = combined.isEmpty ? fallback : combined;
    return message.length > 400 ? '${message.substring(0, 400)}…' : message;
  }
}
