import 'dart:convert';
import 'dart:io';
import 'dart:async';

const Duration _defaultCommandTimeout = Duration(seconds: 30);
const Duration _pythonProbeTimeout = Duration(seconds: 5);

class PythonDiscoveryException implements Exception {
  const PythonDiscoveryException(this.message);

  final String message;

  @override
  String toString() => 'PythonDiscoveryException: $message';
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

  List<String> get command => [executable, ...initialArgs];
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

class PythonRunner {
  PythonRunner({
    ProcessRunner? processRunner,
    String? repoRootPath,
    PlatformInfo? platformInfo,
    Duration commandTimeout = _defaultCommandTimeout,
    Duration probeTimeout = _pythonProbeTimeout,
  })  : _processRunner = processRunner ?? const DefaultProcessRunner(),
        _platformInfo = platformInfo ?? const DefaultPlatformInfo(),
        _repoRootPath = repoRootPath,
        _commandTimeout = commandTimeout,
        _probeTimeout = probeTimeout;

  static const List<_PythonCandidate> pythonCandidates = [
    _PythonCandidate('py', ['-3']),
    _PythonCandidate('python3'),
    _PythonCandidate('python'),
  ];

  final ProcessRunner _processRunner;
  final PlatformInfo _platformInfo;
  final String? _repoRootPath;
  final Duration _commandTimeout;
  final Duration _probeTimeout;

  String get _repoRoot => _repoRootPath ?? Directory.current.path;

  PlatformInfo get platformInfo => _platformInfo;

  Future<List<String>?> discoverPythonCommand() async {
    for (final candidate in pythonCandidates) {
      try {
        final versionResult = await run(
          command: [...candidate.command, '--version'],
          timeout: _probeTimeout,
        );
        if (versionResult.exitCode == 0) {
          return candidate.command;
        }
      } on PythonDiscoveryException {
        continue;
      }
    }
    return null;
  }

  Future<ProcessResult> run({
    required List<String> command,
    String? workingDirectory,
    Duration? timeout,
  }) async {
    final executionDirectory = workingDirectory ?? _repoRoot;
    try {
      return await _processRunner.run(
        command: command,
        workingDirectory: executionDirectory,
        timeout: timeout ?? _commandTimeout,
      );
    } on TimeoutException {
      throw const PythonDiscoveryException('Python command timed out');
    } on ProcessException catch (error) {
      throw PythonDiscoveryException(error.message);
    } on Exception catch (error) {
      throw PythonDiscoveryException(error.toString());
    }
  }
}
