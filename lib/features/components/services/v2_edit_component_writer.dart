import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/models/project_state.dart';
import '../../../shared/services/python_runner.dart';

final Provider<V2EditComponentWriter> v2EditComponentWriterProvider =
    Provider<V2EditComponentWriter>((_) => V2EditComponentService());

abstract class V2EditComponentWriter {
  Future<V2EditComponentResult> editComponent({
    required ProjectState projectState,
    required V2EditComponentRequest request,
  });
}

enum V2EditComponentWriteStatus {
  appended,
  existing,
}

enum V2EditComponentFailureKind {
  validation,
  append,
  lockConflict,
  pythonUnavailable,
  noProjectDirectory,
  invalidProjectDirectory,
  unknownComponent,
}

class V2EditComponentException implements Exception {
  const V2EditComponentException(this.kind, this.message);

  final V2EditComponentFailureKind kind;
  final String message;

  @override
  String toString() => 'V2EditComponentException: $message';
}

class V2ComponentChange {
  const V2ComponentChange({
    required this.field,
    required this.oldValueObserved,
    required this.newValue,
    required this.changeKind,
  });

  final String field;
  final String oldValueObserved;
  final String newValue;
  final String changeKind;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'field': field,
        'old_value_observed': oldValueObserved,
        'new_value': newValue,
        'change_kind': changeKind,
      };
}

class V2EditComponentRequest {
  const V2EditComponentRequest({
    required this.componentId,
    required this.changes,
    required this.editReason,
    required this.clientOperationId,
  });

  final String componentId;
  final List<V2ComponentChange> changes;
  final String editReason;
  final String clientOperationId;
}

class V2EditComponentResult {
  const V2EditComponentResult({
    required this.status,
    required this.event,
    required this.appended,
  });

  final V2EditComponentWriteStatus status;
  final Map<String, dynamic> event;
  final bool appended;
}

class V2EditComponentService implements V2EditComponentWriter {
  V2EditComponentService({
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
  static const String _componentUpdatedEventType = 'component_updated';
  static const String _eventsFileName = 'events.jsonl';
  static final RegExp _eventIdPattern = RegExp(r'^evt_([0-9]{6})$');

  final PythonRunner _pythonRunner;
  final DateTime Function() _now;
  final String Function()? _eventIdGenerator;

  @override
  Future<V2EditComponentResult> editComponent({
    required ProjectState projectState,
    required V2EditComponentRequest request,
  }) async {
    if (!_hasKnownComponent(projectState, request.componentId)) {
      throw V2EditComponentException(
        V2EditComponentFailureKind.unknownComponent,
        'Component ${request.componentId} must exist before it can be edited.',
      );
    }
    if (request.changes.isEmpty) {
      throw const V2EditComponentException(
        V2EditComponentFailureKind.validation,
        'Edit Component requires at least one human-confirmed change.',
      );
    }

    final projectDirectory = projectState.projectDirectory;
    if (projectDirectory == null || projectDirectory.trim().isEmpty) {
      throw const V2EditComponentException(
        V2EditComponentFailureKind.noProjectDirectory,
        'Project must be loaded from a local folder before editing a component.',
      );
    }

    final eventsPath = _resolveEventsPath(projectDirectory);
    final python = await _discoverPython();
    if (python == null) {
      throw const V2EditComponentException(
        V2EditComponentFailureKind.pythonUnavailable,
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
        await Directory.systemTemp.createTemp('tracebench-v2-component-edit-');
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
      return V2EditComponentResult(
        status: status,
        event: writtenEvent,
        appended: status == V2EditComponentWriteStatus.appended,
      );
    } finally {
      if (await tempDir.exists()) {
        await tempDir.delete(recursive: true);
      }
    }
  }

  bool _hasKnownComponent(ProjectState projectState, String componentId) {
    return projectState.knownFacts.components
        .any((component) => component.componentId == componentId);
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
    required V2EditComponentRequest request,
    required String eventId,
    required String timestamp,
  }) {
    return <String, dynamic>{
      'schema_version': _schemaVersion,
      'event_id': eventId,
      'event_type': _componentUpdatedEventType,
      'created_at': timestamp,
      'project_id': projectState.manifest.projectId,
      'client_operation_id': request.clientOperationId,
      'actor': const <String, dynamic>{
        'type': 'human',
        'id': 'local_operator',
      },
      'source': const <String, dynamic>{
        'type': 'explicit_user_confirmation',
        'surface': 'edit_component',
        'action': 'edit_component',
      },
      'confirmation': <String, dynamic>{
        'confirmed': true,
        'confirmed_at': timestamp,
      },
      'payload': <String, dynamic>{
        'component_id': request.componentId,
        'changes': request.changes.map((change) => change.toJson()).toList(),
        'edit_reason': request.editReason,
      },
    };
  }

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

  V2EditComponentWriteStatus _statusFromStdout(String stdout) {
    if (stdout.contains('[OK] existing')) {
      return V2EditComponentWriteStatus.existing;
    }
    return V2EditComponentWriteStatus.appended;
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

  V2EditComponentException _exceptionForFailure(String detail) {
    final normalized = detail.toLowerCase();
    if (normalized.contains('lock is already held') ||
        normalized.contains('lock conflict')) {
      return V2EditComponentException(
        V2EditComponentFailureKind.lockConflict,
        detail,
      );
    }
    if (normalized.contains('append') || normalized.contains('readback')) {
      return V2EditComponentException(
        V2EditComponentFailureKind.append,
        detail,
      );
    }
    return V2EditComponentException(
      V2EditComponentFailureKind.validation,
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
      throw const V2EditComponentException(
        V2EditComponentFailureKind.invalidProjectDirectory,
        'Project directory path must be an absolute local path.',
      );
    }
    if (_containsNavigationSegment(trimmedProjectDirectory)) {
      throw const V2EditComponentException(
        V2EditComponentFailureKind.invalidProjectDirectory,
        'Project directory path must not contain navigation segments.',
      );
    }

    final canonicalProjectDirectory =
        _canonicalProjectDirectory(trimmedProjectDirectory);
    if (!_sameCanonicalPath(
      Directory(trimmedProjectDirectory).absolute.path,
      canonicalProjectDirectory,
    )) {
      throw const V2EditComponentException(
        V2EditComponentFailureKind.invalidProjectDirectory,
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
      throw const V2EditComponentException(
        V2EditComponentFailureKind.invalidProjectDirectory,
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
        throw const V2EditComponentException(
          V2EditComponentFailureKind.invalidProjectDirectory,
          'events.jsonl must stay inside the selected project directory.',
        );
      }
    } on V2EditComponentException {
      rethrow;
    } on FileSystemException catch (error) {
      throw V2EditComponentException(
        V2EditComponentFailureKind.invalidProjectDirectory,
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
        throw const V2EditComponentException(
          V2EditComponentFailureKind.invalidProjectDirectory,
          'Project directory path must resolve to an existing directory.',
        );
      }
      return Directory(projectDirectory).resolveSymbolicLinksSync();
    } on V2EditComponentException {
      rethrow;
    } on FileSystemException catch (error) {
      throw V2EditComponentException(
        V2EditComponentFailureKind.invalidProjectDirectory,
        'Project directory path could not be resolved: ${error.message}',
      );
    } on ArgumentError catch (error) {
      throw V2EditComponentException(
        V2EditComponentFailureKind.invalidProjectDirectory,
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
