import 'dart:async';
import 'dart:convert';
import 'dart:io';

import '../models/project_state.dart';

const Duration _defaultCommandTimeout = Duration(seconds: 30);
const Duration _pythonProbeTimeout = Duration(seconds: 5);

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
  const ExportMaterializerFailed(this.message);

  final String message;
}

class ExportExportFailed extends ExportResult {
  const ExportExportFailed(this.message);

  final String message;
}

class _PythonCandidate {
  const _PythonCandidate(this.executable, [this.initialArgs = const []]);

  final String executable;
  final List<String> initialArgs;

  @override
  String toString() {
    if (initialArgs.isEmpty) {
      return executable;
    }
    return '$executable ${initialArgs.join(' ')}';
  }
}

abstract class ProcessRunner {
  const ProcessRunner();

  Future<ProcessResult> run({
    required List<String> command,
    required String workingDirectory,
    required Duration timeout,
  });
}

class DefaultProcessRunner extends ProcessRunner {
  const DefaultProcessRunner();

  @override
  Future<ProcessResult> run({
    required List<String> command,
    required String workingDirectory,
    required Duration timeout,
  }) async {
    return Process.run(
      command.first,
      command.sublist(1),
      workingDirectory: workingDirectory,
      runInShell: false,
      stdoutEncoding: utf8,
      stderrEncoding: utf8,
    ).timeout(timeout);
  }
}

abstract class PlatformInfo {
  const PlatformInfo();

  bool get isMobile;
}

class DefaultPlatformInfo extends PlatformInfo {
  const DefaultPlatformInfo();

  @override
  bool get isMobile => Platform.isAndroid || Platform.isIOS;
}

class ProjectExporter {
  ProjectExporter({
    ProcessRunner? processRunner,
    PlatformInfo? platformInfo,
    String? repoRootPath,
  })  : _processRunner = processRunner ?? const DefaultProcessRunner(),
        _platformInfo = platformInfo ?? const DefaultPlatformInfo(),
        _repoRootPath = repoRootPath;

  static const List<_PythonCandidate> _pythonCandidates = [
    _PythonCandidate('py', ['-3']),
    _PythonCandidate('python3'),
    _PythonCandidate('python'),
  ];

  final ProcessRunner _processRunner;
  final PlatformInfo _platformInfo;
  final String? _repoRootPath;

  String get _repoRoot => _repoRootPath ?? Directory.current.path;

  Future<ExportResult> exportProjectZip(ProjectState projectState) async {
    if (_platformInfo.isMobile) {
      return const ExportMobilePlaceholder();
    }

    final projectDirectory = projectState.projectDirectory;
    if (projectDirectory == null || projectDirectory.trim().isEmpty) {
      return const ExportNoDirectory();
    }

    final python = await _discoverPythonCandidate();
    if (python == null) {
      return const ExportPythonNotFound();
    }

    final materializerCommand = [
      ...pythonCommand(python),
      'tools/materialize_known_facts.py',
      _joinPath(projectDirectory, 'events.jsonl'),
      _joinPath(projectDirectory, 'known_facts.json'),
    ];

    final materializerResult = await _runCommand(materializerCommand);
    if (materializerResult.exitCode != 0) {
      return ExportMaterializerFailed(
        _summarizeFailure(
          materializerResult,
          'Materializer failed',
        ),
      );
    }

    final zipPath =
        _buildExportZipPath(projectDirectory, projectState.manifest.projectId);
    final exportCommand = [
      ...pythonCommand(python),
      'tools/export_project_zip.py',
      projectDirectory,
      zipPath,
    ];

    final exportResult = await _runCommand(exportCommand);
    if (exportResult.exitCode != 0) {
      return ExportExportFailed(
        _summarizeFailure(exportResult, 'Export failed'),
      );
    }

    return ExportSuccess(zipPath);
  }

  Future<_PythonCandidate?> _discoverPythonCandidate() async {
    for (final candidate in _pythonCandidates) {
      final versionCommand = [
        candidate.executable,
        ...candidate.initialArgs,
        '--version',
      ];
      final versionResult = await _runCommand(
        versionCommand,
        timeout: _pythonProbeTimeout,
      );
      if (versionResult.exitCode == 0) {
        return candidate;
      }
    }
    return null;
  }

  List<String> pythonCommand(_PythonCandidate candidate) {
    return [candidate.executable, ...candidate.initialArgs];
  }

  Future<ProcessResult> _runCommand(
    List<String> command, {
    Duration timeout = _defaultCommandTimeout,
  }) async {
    try {
      return await _processRunner.run(
        command: command,
        workingDirectory: _repoRoot,
        timeout: timeout,
      );
    } on TimeoutException {
      return ProcessResult(
        0,
        124,
        '',
        'Command timed out: ${command.join(' ')}',
      );
    } on ProcessException catch (error) {
      return ProcessResult(
        0,
        127,
        '',
        'Command failed to start: ${error.message}',
      );
    } on Exception catch (error) {
      return ProcessResult(
        0,
        1,
        '',
        'Command failed: $error',
      );
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
        .replaceAll(RegExp(r'[\*\?:"<>\|]'), '_')
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
