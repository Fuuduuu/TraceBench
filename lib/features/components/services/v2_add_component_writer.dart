import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/models/project_state.dart';
import '../../../shared/services/python_runner.dart';

final Provider<V2AddComponentWriter> v2AddComponentWriterProvider =
    Provider<V2AddComponentWriter>((_) => V2AddComponentService());

abstract class V2AddComponentWriter {
  Future<V2AddComponentResult> addComponent({
    required ProjectState projectState,
    required V2AddComponentRequest request,
  });
}

enum V2AddComponentWriteStatus {
  appended,
  existing,
}

enum V2AddComponentFailureKind {
  validation,
  append,
  lockConflict,
  pythonUnavailable,
  noProjectDirectory,
  invalidProjectDirectory,
}

class V2AddComponentException implements Exception {
  const V2AddComponentException(this.kind, this.message);

  final V2AddComponentFailureKind kind;
  final String message;

  @override
  String toString() => 'V2AddComponentException: $message';
}

class V2AddComponentRequest {
  const V2AddComponentRequest({
    required this.componentId,
    required this.label,
    required this.componentKind,
    required this.clientOperationId,
    this.referenceDesignator,
    this.packageHint,
    this.footprintHint,
    this.templateIdHint,
    this.humanNote,
  });

  final String componentId;
  final String label;
  final String componentKind;
  final String clientOperationId;
  final String? referenceDesignator;
  final String? packageHint;
  final String? footprintHint;
  final String? templateIdHint;
  final String? humanNote;
}

class V2AddComponentResult {
  const V2AddComponentResult({
    required this.status,
    required this.event,
    required this.appended,
  });

  final V2AddComponentWriteStatus status;
  final Map<String, dynamic> event;
  final bool appended;
}

class V2AddComponentService implements V2AddComponentWriter {
  V2AddComponentService({
    PythonRunner? pythonRunner,
    ProcessRunner? processRunner,
    PlatformInfo? platformInfo,
    String? repoRootPath,
    DateTime Function()? now,
    String Function()? eventIdGenerator,
  })  : _pythonRunner = pythonRunner ??
            PythonRunner(
              processRunner: processRunner,
              platformInfo: platformInfo,
              repoRootPath: repoRootPath,
            ),
        _now = now ?? DateTime.now,
        _eventIdGenerator = eventIdGenerator;

  static const String _schemaVersion = '2.0-draft';
  static const String _componentCreatedEventType = 'component_created';
  static const String _eventsFileName = 'events.jsonl';
  static final RegExp _eventIdPattern = RegExp(r'^evt_([0-9]{6})$');

  final PythonRunner _pythonRunner;
  final DateTime Function() _now;
  final String Function()? _eventIdGenerator;

  @override
  Future<V2AddComponentResult> addComponent({
    required ProjectState projectState,
    required V2AddComponentRequest request,
  }) async {
    final projectDirectory = projectState.projectDirectory;
    if (projectDirectory == null || projectDirectory.trim().isEmpty) {
      throw const V2AddComponentException(
        V2AddComponentFailureKind.noProjectDirectory,
        'Project must be loaded from a local folder before adding a component.',
      );
    }

    final eventsPath = _resolveEventsPath(projectDirectory);
    final python = await _discoverPython();
    if (python == null) {
      throw const V2AddComponentException(
        V2AddComponentFailureKind.pythonUnavailable,
        'Python runtime is required for the accepted event writer service.',
      );
    }

    final timestamp = _now().toUtc().toIso8601String();
    final candidate = _buildCandidateEvent(
      projectState: projectState,
      request: request,
      eventId: _eventIdGenerator?.call() ?? _nextEventId(projectState),
      timestamp: timestamp,
    );

    final tempDir =
        await Directory.systemTemp.createTemp('tracebench-v2-component-');
    final candidateFile = File(_joinPath(tempDir.path, 'candidate_event.json'));
    try {
      await candidateFile.writeAsString(jsonEncode(candidate), flush: true);
      final result = await _runWriter(
        <String>[
          ...python,
          'tools/event_writer_service.py',
          eventsPath,
          candidateFile.path,
        ],
      );
      if (result.exitCode != 0) {
        throw _exceptionForFailure(_combinedOutput(result));
      }

      final status = _statusFromStdout(result.stdout.toString());
      final writtenEvent =
          _eventForOperation(eventsPath, request.clientOperationId) ??
              candidate;
      return V2AddComponentResult(
        status: status,
        event: writtenEvent,
        appended: status == V2AddComponentWriteStatus.appended,
      );
    } finally {
      if (await tempDir.exists()) {
        await tempDir.delete(recursive: true);
      }
    }
  }

  Future<List<String>?> _discoverPython() async {
    try {
      return await _pythonRunner.discoverPythonCommand();
    } on PythonDiscoveryException {
      return null;
    }
  }

  Future<ProcessResult> _runWriter(List<String> command) async {
    try {
      return await _pythonRunner.run(command: command);
    } on PythonDiscoveryException catch (error) {
      return ProcessResult(0, 1, '', error.toString());
    }
  }

  Map<String, dynamic> _buildCandidateEvent({
    required ProjectState projectState,
    required V2AddComponentRequest request,
    required String eventId,
    required String timestamp,
  }) {
    final payload = <String, dynamic>{
      'component_id': request.componentId,
      'label': request.label,
      'component_kind': request.componentKind,
      'created_context': 'human_entered',
      if (_hasText(request.referenceDesignator))
        'reference_designator': request.referenceDesignator!.trim(),
      if (_hasText(request.packageHint))
        'package_hint': request.packageHint!.trim(),
      if (_hasText(request.footprintHint))
        'footprint_hint': request.footprintHint!.trim(),
      if (_hasText(request.templateIdHint))
        'template_id_hint': request.templateIdHint!.trim(),
      if (_hasText(request.humanNote)) 'human_note': request.humanNote!.trim(),
    };

    return <String, dynamic>{
      'schema_version': _schemaVersion,
      'event_id': eventId,
      'event_type': _componentCreatedEventType,
      'created_at': timestamp,
      'project_id': projectState.manifest.projectId,
      'client_operation_id': request.clientOperationId,
      'actor': const <String, dynamic>{
        'type': 'human',
        'id': 'local_operator',
      },
      'source': const <String, dynamic>{
        'type': 'explicit_user_confirmation',
        'surface': 'add_component',
        'action': 'add_component',
      },
      'confirmation': <String, dynamic>{
        'confirmed': true,
        'confirmed_at': timestamp,
      },
      'payload': payload,
    };
  }

  bool _hasText(String? value) => value != null && value.trim().isNotEmpty;

  String _nextEventId(ProjectState projectState) {
    var max = 0;
    for (final event in projectState.events) {
      final match = _eventIdPattern.firstMatch(event.eventId);
      if (match == null) {
        continue;
      }
      final value = int.tryParse(match.group(1)!);
      if (value != null && value > max) {
        max = value;
      }
    }
    return 'evt_${(max + 1).toString().padLeft(6, '0')}';
  }

  V2AddComponentWriteStatus _statusFromStdout(String stdout) {
    if (stdout.contains('[OK] existing')) {
      return V2AddComponentWriteStatus.existing;
    }
    return V2AddComponentWriteStatus.appended;
  }

  Map<String, dynamic>? _eventForOperation(
    String eventsPath,
    String clientOperationId,
  ) {
    final file = File(eventsPath);
    if (!file.existsSync()) {
      return null;
    }
    for (final line in const LineSplitter().convert(file.readAsStringSync())) {
      if (line.trim().isEmpty) {
        continue;
      }
      final decoded = jsonDecode(line);
      if (decoded is Map<String, dynamic> &&
          decoded['client_operation_id'] == clientOperationId) {
        return decoded;
      }
    }
    return null;
  }

  V2AddComponentException _exceptionForFailure(String detail) {
    final normalized = detail.toLowerCase();
    if (normalized.contains('lock is already held') ||
        normalized.contains('lock conflict')) {
      return V2AddComponentException(
        V2AddComponentFailureKind.lockConflict,
        detail,
      );
    }
    if (normalized.contains('append') || normalized.contains('readback')) {
      return V2AddComponentException(
        V2AddComponentFailureKind.append,
        detail,
      );
    }
    return V2AddComponentException(
      V2AddComponentFailureKind.validation,
      detail,
    );
  }

  String _combinedOutput(ProcessResult result) {
    final combined = '${result.stdout}\n${result.stderr}'.trim();
    return combined.isEmpty ? 'event writer service failed' : combined;
  }

  String _resolveEventsPath(String projectDirectory) {
    final trimmedProjectDirectory = projectDirectory.trim();
    if (!_isAbsoluteLocalPath(trimmedProjectDirectory)) {
      throw const V2AddComponentException(
        V2AddComponentFailureKind.invalidProjectDirectory,
        'Project directory path must be an absolute local path.',
      );
    }
    if (_containsNavigationSegment(trimmedProjectDirectory)) {
      throw const V2AddComponentException(
        V2AddComponentFailureKind.invalidProjectDirectory,
        'Project directory path must not contain navigation segments.',
      );
    }

    final canonicalProjectDirectory =
        _canonicalProjectDirectory(trimmedProjectDirectory);
    if (!_sameCanonicalPath(
      Directory(trimmedProjectDirectory).absolute.path,
      canonicalProjectDirectory,
    )) {
      throw const V2AddComponentException(
        V2AddComponentFailureKind.invalidProjectDirectory,
        'Project directory path must already be canonical.',
      );
    }
    final eventsFile =
        File(_joinPath(canonicalProjectDirectory, _eventsFileName));
    final eventsType = FileSystemEntity.typeSync(
      eventsFile.path,
      followLinks: false,
    );
    if (eventsType == FileSystemEntityType.link ||
        eventsType == FileSystemEntityType.directory) {
      throw const V2AddComponentException(
        V2AddComponentFailureKind.invalidProjectDirectory,
        'events.jsonl must be a regular file inside the selected project.',
      );
    }

    try {
      final eventsParentDirectory =
          eventsFile.parent.resolveSymbolicLinksSync();
      if (!_sameCanonicalPath(
        eventsParentDirectory,
        canonicalProjectDirectory,
      )) {
        throw const V2AddComponentException(
          V2AddComponentFailureKind.invalidProjectDirectory,
          'events.jsonl must stay inside the selected project directory.',
        );
      }
    } on V2AddComponentException {
      rethrow;
    } on FileSystemException catch (error) {
      throw V2AddComponentException(
        V2AddComponentFailureKind.invalidProjectDirectory,
        'Project directory path could not be resolved: ${error.message}',
      );
    }

    return eventsFile.path;
  }

  String _canonicalProjectDirectory(String projectDirectory) {
    try {
      final type = FileSystemEntity.typeSync(
        projectDirectory,
        followLinks: true,
      );
      if (type != FileSystemEntityType.directory) {
        throw const V2AddComponentException(
          V2AddComponentFailureKind.invalidProjectDirectory,
          'Project directory path must resolve to an existing directory.',
        );
      }
      return Directory(projectDirectory).resolveSymbolicLinksSync();
    } on V2AddComponentException {
      rethrow;
    } on FileSystemException catch (error) {
      throw V2AddComponentException(
        V2AddComponentFailureKind.invalidProjectDirectory,
        'Project directory path could not be resolved: ${error.message}',
      );
    } on ArgumentError catch (error) {
      throw V2AddComponentException(
        V2AddComponentFailureKind.invalidProjectDirectory,
        'Project directory path is malformed: $error',
      );
    }
  }

  bool _isAbsoluteLocalPath(String path) {
    if (Platform.isWindows) {
      return RegExp(r'^[A-Za-z]:[\\/]').hasMatch(path);
    }
    return path.startsWith('/');
  }

  bool _containsNavigationSegment(String path) {
    return path
        .split(RegExp(r'[\\/]+'))
        .any((part) => part == '..' || part == '.');
  }

  bool _sameCanonicalPath(String first, String second) {
    return _normalizedCanonicalPath(first) == _normalizedCanonicalPath(second);
  }

  String _normalizedCanonicalPath(String path) {
    var normalized = path
        .replaceAll('/', Platform.pathSeparator)
        .replaceAll('\\', Platform.pathSeparator);
    final minimumLength = Platform.isWindows ? 3 : 1;
    while (normalized.length > minimumLength &&
        normalized.endsWith(Platform.pathSeparator)) {
      normalized = normalized.substring(0, normalized.length - 1);
    }
    return Platform.isWindows ? normalized.toLowerCase() : normalized;
  }

  String _joinPath(String base, String child) {
    if (base.endsWith('/') || base.endsWith('\\')) {
      return '$base$child';
    }
    return '$base${Platform.pathSeparator}$child';
  }
}
