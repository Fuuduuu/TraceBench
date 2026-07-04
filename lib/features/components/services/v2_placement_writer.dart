import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/models/project_state.dart';
import '../../../shared/services/python_runner.dart';

final Provider<V2PlacementWriter> v2PlacementWriterProvider =
    Provider<V2PlacementWriter>((_) => V2PlacementService());

abstract class V2PlacementWriter {
  Future<V2PlacementWriterResult> confirmPlacement({
    required ProjectState projectState,
    required V2PlacementWriterRequest request,
  });
}

enum V2PlacementWriteStatus {
  appended,
  existing,
}

enum V2PlacementFailureKind {
  validation,
  append,
  lockConflict,
  pythonUnavailable,
  noProjectDirectory,
  invalidProjectDirectory,
  unknownComponent,
}

class V2PlacementWriterException implements Exception {
  const V2PlacementWriterException(this.kind, this.message);

  final V2PlacementFailureKind kind;
  final String message;

  @override
  String toString() => 'V2PlacementWriterException: $message';
}

class V2PlacementWriterRequest {
  const V2PlacementWriterRequest({
    required this.componentId,
    required this.coordinateSpace,
    required this.boardSide,
    required this.centerX,
    required this.centerY,
    required this.rotationDeg,
    required this.width,
    required this.height,
    required this.clientOperationId,
    this.templateId,
    this.sourcePhotoId,
    this.notes,
  });

  final String componentId;
  final String coordinateSpace;
  final String boardSide;
  final num centerX;
  final num centerY;
  final num rotationDeg;
  final num width;
  final num height;
  final String clientOperationId;
  final String? templateId;
  final String? sourcePhotoId;
  final String? notes;
}

class V2PlacementWriterResult {
  const V2PlacementWriterResult({
    required this.status,
    required this.event,
    required this.appended,
  });

  final V2PlacementWriteStatus status;
  final Map<String, dynamic> event;
  final bool appended;
}

class V2PlacementService implements V2PlacementWriter {
  V2PlacementService({
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
  static const String _placementConfirmedEventType =
      'component_visual_placement_confirmed';
  static const String _eventsFileName = 'events.jsonl';
  static final RegExp _eventIdPattern = RegExp(r'^evt_([0-9]{6})$');

  final PythonRunner _pythonRunner;
  final DateTime Function() _now;
  final String Function()? _eventIdGenerator;

  @override
  Future<V2PlacementWriterResult> confirmPlacement({
    required ProjectState projectState,
    required V2PlacementWriterRequest request,
  }) async {
    _validateRequest(projectState, request);

    final projectDirectory = projectState.projectDirectory;
    if (projectDirectory == null || projectDirectory.trim().isEmpty) {
      throw const V2PlacementWriterException(
        V2PlacementFailureKind.noProjectDirectory,
        'Project must be loaded from a local folder before confirming placement.',
      );
    }

    final eventsPath = _resolveEventsPath(projectDirectory);
    final python = await _discoverPython();
    if (python == null) {
      throw const V2PlacementWriterException(
        V2PlacementFailureKind.pythonUnavailable,
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
        await Directory.systemTemp.createTemp('tracebench-v2-placement-');
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
      return V2PlacementWriterResult(
        status: status,
        event: writtenEvent,
        appended: status == V2PlacementWriteStatus.appended,
      );
    } finally {
      if (await tempDir.exists()) {
        await tempDir.delete(recursive: true);
      }
    }
  }

  void _validateRequest(
    ProjectState projectState,
    V2PlacementWriterRequest request,
  ) {
    if (!_hasText(request.clientOperationId)) {
      throw const V2PlacementWriterException(
        V2PlacementFailureKind.validation,
        'client_operation_id is required for placement confirmation.',
      );
    }
    if (!_hasText(request.componentId)) {
      throw const V2PlacementWriterException(
        V2PlacementFailureKind.validation,
        'component_id is required for placement confirmation.',
      );
    }
    if (!_hasKnownComponent(projectState, request.componentId.trim())) {
      throw V2PlacementWriterException(
        V2PlacementFailureKind.unknownComponent,
        'Component ${request.componentId.trim()} must exist before placement can be confirmed.',
      );
    }
    if (!_hasText(request.coordinateSpace)) {
      throw const V2PlacementWriterException(
        V2PlacementFailureKind.validation,
        'coordinate_space is required for placement confirmation.',
      );
    }
    if (!_hasText(request.boardSide)) {
      throw const V2PlacementWriterException(
        V2PlacementFailureKind.validation,
        'board_side is required for placement confirmation.',
      );
    }
    _validateFinite('center_x', request.centerX);
    _validateFinite('center_y', request.centerY);
    _validateFinite('rotation_deg', request.rotationDeg);
    _validatePositive('width', request.width);
    _validatePositive('height', request.height);
  }

  bool _hasKnownComponent(ProjectState projectState, String componentId) {
    return projectState.knownFacts.components
        .any((component) => component.componentId == componentId);
  }

  void _validateFinite(String field, num value) {
    if (!value.isFinite) {
      throw V2PlacementWriterException(
        V2PlacementFailureKind.validation,
        '$field must be finite for placement confirmation.',
      );
    }
  }

  void _validatePositive(String field, num value) {
    _validateFinite(field, value);
    if (value <= 0) {
      throw V2PlacementWriterException(
        V2PlacementFailureKind.validation,
        '$field must be positive for placement confirmation.',
      );
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
    required V2PlacementWriterRequest request,
    required String eventId,
    required String timestamp,
  }) {
    final payload = <String, dynamic>{
      'component_id': request.componentId.trim(),
      'coordinate_space': request.coordinateSpace.trim(),
      'board_side': request.boardSide.trim(),
      'center_x': request.centerX,
      'center_y': request.centerY,
      'rotation_deg': _normalizeRotationDeg(request.rotationDeg),
      'width': request.width,
      'height': request.height,
      if (_hasText(request.templateId))
        'template_id': request.templateId!.trim(),
      if (_hasText(request.sourcePhotoId))
        'source_photo_id': request.sourcePhotoId!.trim(),
      if (_hasText(request.notes)) 'notes': request.notes!.trim(),
    };

    return <String, dynamic>{
      'schema_version': _schemaVersion,
      'event_id': eventId,
      'event_type': _placementConfirmedEventType,
      'created_at': timestamp,
      'project_id': projectState.manifest.projectId,
      'client_operation_id': request.clientOperationId.trim(),
      'actor': const <String, dynamic>{
        'type': 'human',
        'id': 'local_operator',
      },
      'source': const <String, dynamic>{
        'type': 'explicit_user_confirmation',
        'surface': 'board_canvas',
        'action': 'confirm_visual_placement',
      },
      'confirmation': <String, dynamic>{
        'confirmed': true,
        'confirmed_at': timestamp,
      },
      'payload': payload,
    };
  }

  num _normalizeRotationDeg(num rotationDeg) {
    final normalized = (rotationDeg + 180) % 360 - 180;
    return normalized == 0 ? 0 : normalized;
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

  V2PlacementWriteStatus _statusFromStdout(String stdout) {
    if (stdout.contains('[OK] existing')) {
      return V2PlacementWriteStatus.existing;
    }
    return V2PlacementWriteStatus.appended;
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

  V2PlacementWriterException _exceptionForFailure(String detail) {
    final normalized = detail.toLowerCase();
    if (normalized.contains('lock is already held') ||
        normalized.contains('lock conflict')) {
      return V2PlacementWriterException(
        V2PlacementFailureKind.lockConflict,
        detail,
      );
    }
    if (normalized.contains('append') || normalized.contains('readback')) {
      return V2PlacementWriterException(
        V2PlacementFailureKind.append,
        detail,
      );
    }
    return V2PlacementWriterException(
      V2PlacementFailureKind.validation,
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
      throw const V2PlacementWriterException(
        V2PlacementFailureKind.invalidProjectDirectory,
        'Project directory path must be an absolute local path.',
      );
    }
    if (_containsNavigationSegment(trimmedProjectDirectory)) {
      throw const V2PlacementWriterException(
        V2PlacementFailureKind.invalidProjectDirectory,
        'Project directory path must not contain navigation segments.',
      );
    }

    final canonicalProjectDirectory =
        _canonicalProjectDirectory(trimmedProjectDirectory);
    if (!_sameCanonicalPath(
      Directory(trimmedProjectDirectory).absolute.path,
      canonicalProjectDirectory,
    )) {
      throw const V2PlacementWriterException(
        V2PlacementFailureKind.invalidProjectDirectory,
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
      throw const V2PlacementWriterException(
        V2PlacementFailureKind.invalidProjectDirectory,
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
        throw const V2PlacementWriterException(
          V2PlacementFailureKind.invalidProjectDirectory,
          'events.jsonl must stay inside the selected project directory.',
        );
      }
    } on V2PlacementWriterException {
      rethrow;
    } on FileSystemException catch (error) {
      throw V2PlacementWriterException(
        V2PlacementFailureKind.invalidProjectDirectory,
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
        throw const V2PlacementWriterException(
          V2PlacementFailureKind.invalidProjectDirectory,
          'Project directory path must resolve to an existing directory.',
        );
      }
      return Directory(projectDirectory).resolveSymbolicLinksSync();
    } on V2PlacementWriterException {
      rethrow;
    } on FileSystemException catch (error) {
      throw V2PlacementWriterException(
        V2PlacementFailureKind.invalidProjectDirectory,
        'Project directory path could not be resolved: ${error.message}',
      );
    } on ArgumentError catch (error) {
      throw V2PlacementWriterException(
        V2PlacementFailureKind.invalidProjectDirectory,
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
