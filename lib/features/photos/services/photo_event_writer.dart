import 'dart:convert';
import 'dart:io';

import '../../../shared/models/project_state.dart';
import '../../../shared/models/trace_bench_event.dart';
import '../../../shared/services/python_runner.dart';
import '../logic/photo_alignment_transform.dart';
import '../logic/photo_event_read_model.dart';

abstract interface class PhotoEventWriter {
  Future<PhotoEventWriteResult> writePhotoAdded({
    required ProjectState projectState,
    required PhotoEventWriteRequest request,
  });
}

abstract interface class PhotoAlignmentEventWriter {
  Future<PhotoEventWriteResult> ensurePrimaryPhotoAdded({
    required ProjectState projectState,
    required PrimaryPhotoEventWriteRequest request,
  });

  Future<PhotoEventWriteResult> confirmAlignment({
    required ProjectState projectState,
    required PhotoAlignmentEventWriteRequest request,
  });
}

enum PhotoEventWriteStatus {
  appended,
  recoveredDurable,
  reusedDurable,
}

enum PhotoEventDurability {
  provenNoEvent,
  uncertain,
  durable,
}

enum PhotoEventWriteFailureKind {
  validation,
  invalidEventHistory,
  append,
  readback,
  lockConflict,
  pythonUnavailable,
  noProjectDirectory,
  invalidProjectDirectory,
}

class PhotoEventWriteException implements Exception {
  const PhotoEventWriteException(
    this.kind,
    this.message, {
    required this.durability,
  });

  final PhotoEventWriteFailureKind kind;
  final String message;
  final PhotoEventDurability durability;

  @override
  String toString() => 'PhotoEventWriteException: $message';
}

class PhotoEventWriteRequest {
  const PhotoEventWriteRequest({
    required this.photoId,
    required this.mode,
    required this.path,
    required this.sha256,
    this.layer,
  });

  final String photoId;
  final String mode;
  final String path;
  final String sha256;
  final String? layer;
}

class PhotoAlignmentEventWriteRequest {
  const PhotoAlignmentEventWriteRequest({
    required this.sourcePhotoId,
    required this.boardSide,
    required this.transformType,
    required this.photoPoints,
    required this.boardPoints,
    required this.photoWidth,
    required this.photoHeight,
  });

  final String sourcePhotoId;
  final String boardSide;
  final PhotoAlignmentTransformType transformType;
  final List<PhotoAlignmentPoint> photoPoints;
  final List<PhotoAlignmentPoint> boardPoints;
  final double photoWidth;
  final double photoHeight;
}

class PrimaryPhotoEventWriteRequest {
  const PrimaryPhotoEventWriteRequest({
    required this.path,
    required this.sha256,
  });

  final String path;
  final String sha256;
}

class PhotoEventWriteResult {
  const PhotoEventWriteResult({
    required this.status,
    required this.durability,
    required this.event,
  });

  final PhotoEventWriteStatus status;
  final PhotoEventDurability durability;
  final Map<String, dynamic> event;
}

class PhotoEventWriterService
    implements PhotoEventWriter, PhotoAlignmentEventWriter {
  PhotoEventWriterService({
    PythonRunner? pythonRunner,
    ProcessRunner? processRunner,
    PlatformInfo? platformInfo,
    String? repoRootPath,
    DateTime Function()? now,
  })  : _pythonRunner = pythonRunner ??
            PythonRunner(
              processRunner: processRunner,
              platformInfo: platformInfo,
              repoRootPath: repoRootPath,
            ),
        _repoRootPath = repoRootPath ?? Directory.current.path,
        _now = now ?? DateTime.now;

  static final RegExp _eventIdPattern = RegExp(r'^evt_([0-9]{6})$');
  static final RegExp _alignmentIdPattern = RegExp(r'^ALN([0-9]+)$');
  static final RegExp _photoIdPattern = RegExp(r'^photo_[a-z0-9_]+$');
  static final RegExp _sha256Pattern = RegExp(r'^[0-9a-f]{64}$');
  static const Set<String> _modes = <String>{
    'normal',
    'backlight',
    'macro',
    'side_light',
  };
  static const Set<String> _layers = <String>{
    'top',
    'bottom',
    'side',
    'detail',
  };
  static const Set<String> _alignmentBoardSides = <String>{
    'top',
    'bottom',
    'unknown',
  };

  final PythonRunner _pythonRunner;
  final String _repoRootPath;
  final DateTime Function() _now;

  @override
  Future<PhotoEventWriteResult> writePhotoAdded({
    required ProjectState projectState,
    required PhotoEventWriteRequest request,
  }) async {
    _validateRequest(projectState, request);
    final eventsPath = _resolvedEventsPath(projectState.projectDirectory);
    final allocation = _allocateEnvelope(projectState);
    final candidate = <String, dynamic>{
      'schema_version': '1.0',
      'event_id': allocation.eventId,
      'project_id': projectState.manifest.projectId,
      'sequence': allocation.sequence,
      'created_at': _now().toUtc().toIso8601String(),
      'actor': const <String, dynamic>{
        'type': 'user',
        'id': 'local_operator',
      },
      'event_type': 'photo_added',
      'status': 'accepted',
      'payload': <String, dynamic>{
        'photo_id': request.photoId,
        'mode': request.mode,
        'path': request.path,
        'sha256': request.sha256,
        if (request.layer != null) 'layer': request.layer,
      },
    };

    return _appendCanonicalCandidate(eventsPath, candidate);
  }

  @override
  Future<PhotoEventWriteResult> ensurePrimaryPhotoAdded({
    required ProjectState projectState,
    required PrimaryPhotoEventWriteRequest request,
  }) async {
    _validatePrimaryPhotoRequest(request);
    final eventsPath = _resolvedEventsPath(projectState.projectDirectory);
    final history = await _readDurableEventHistory(
      eventsPath,
      projectId: projectState.manifest.projectId,
    );
    final durableState = projectState.copyWith(events: history.events);
    final existing = primaryPhotoEventItemFromEvents(
      history.events,
      relativePath: request.path,
      sha256: request.sha256,
    );
    if (existing != null) {
      final event = history.rawEvents.singleWhere(
        (rawEvent) => rawEvent['event_id'] == existing.eventId,
      );
      return PhotoEventWriteResult(
        status: PhotoEventWriteStatus.reusedDurable,
        durability: PhotoEventDurability.durable,
        event: event,
      );
    }

    final allocation = _allocateEnvelope(durableState);
    final photoId = _allocatePrimaryPhotoId(durableState);
    final candidate = <String, dynamic>{
      'schema_version': '1.0',
      'event_id': allocation.eventId,
      'project_id': projectState.manifest.projectId,
      'sequence': allocation.sequence,
      'created_at': _now().toUtc().toIso8601String(),
      'actor': const <String, dynamic>{
        'type': 'user',
        'id': 'local_operator',
      },
      'event_type': 'photo_added',
      'status': 'accepted',
      'payload': <String, dynamic>{
        'photo_id': photoId,
        'mode': 'normal',
        'path': request.path,
        'sha256': request.sha256.toLowerCase(),
      },
    };
    return _appendCanonicalCandidate(eventsPath, candidate);
  }

  @override
  Future<PhotoEventWriteResult> confirmAlignment({
    required ProjectState projectState,
    required PhotoAlignmentEventWriteRequest request,
  }) async {
    final eventsPath = _resolvedEventsPath(projectState.projectDirectory);
    final history = await _readDurableEventHistory(
      eventsPath,
      projectId: projectState.manifest.projectId,
    );
    final durableState = projectState.copyWith(events: history.events);
    _validateAlignmentRequest(durableState, request);
    final allocation = _allocateEnvelope(durableState);
    final alignmentId = _allocateAlignmentId(durableState);
    final candidate = <String, dynamic>{
      'schema_version': '1.0',
      'event_id': allocation.eventId,
      'project_id': projectState.manifest.projectId,
      'sequence': allocation.sequence,
      'created_at': _now().toUtc().toIso8601String(),
      'actor': const <String, dynamic>{
        'type': 'user',
        'id': 'local_operator',
      },
      'event_type': 'photo_to_board_alignment_confirmed',
      'status': 'accepted',
      'payload': <String, dynamic>{
        'alignment_id': alignmentId,
        'source_photo_id': request.sourcePhotoId,
        'board_side': request.boardSide,
        'coordinate_space_from': 'photo_local',
        'coordinate_space_to': 'board_normalized',
        'reference_points_photo': request.photoPoints
            .map((point) => point.toJson())
            .toList(growable: false),
        'reference_points_board': request.boardPoints
            .map((point) => point.toJson())
            .toList(growable: false),
        'transform_type': request.transformType.canonicalName,
        'alignment_quality_label': 'manual_preview_confirmed',
      },
    };
    return _appendCanonicalCandidate(eventsPath, candidate);
  }

  Future<PhotoEventWriteResult> _appendCanonicalCandidate(
    String eventsPath,
    Map<String, dynamic> candidate,
  ) async {
    final python = await _discoverPython();
    if (python == null) {
      throw const PhotoEventWriteException(
        PhotoEventWriteFailureKind.pythonUnavailable,
        'Python runtime is required for the canonical event writer.',
        durability: PhotoEventDurability.provenNoEvent,
      );
    }

    final tempDirectory =
        await Directory.systemTemp.createTemp('tracebench-photo-event-');
    final candidateFile = File(_join(tempDirectory.path, 'candidate.json'));
    var writerInvoked = false;
    try {
      await candidateFile.writeAsString(jsonEncode(candidate), flush: true);
      ProcessResult result;
      try {
        writerInvoked = true;
        result = await _pythonRunner.run(
          command: <String>[
            ...python,
            'tools/event_writer_service.py',
            eventsPath,
            candidateFile.path,
          ],
          workingDirectory: _repoRootPath,
        );
      } on Exception catch (error) {
        final recovered = await _readExactEvent(eventsPath, candidate);
        if (recovered.event != null) {
          return PhotoEventWriteResult(
            status: PhotoEventWriteStatus.recoveredDurable,
            durability: PhotoEventDurability.durable,
            event: recovered.event!,
          );
        }
        throw PhotoEventWriteException(
          PhotoEventWriteFailureKind.append,
          'Canonical event writer did not complete: $error',
          durability: PhotoEventDurability.uncertain,
        );
      }

      final recovered = await _readExactEvent(eventsPath, candidate);
      if (recovered.event != null) {
        final appended = result.exitCode == 0 &&
            result.stdout.toString().contains('[OK] appended:');
        return PhotoEventWriteResult(
          status: appended
              ? PhotoEventWriteStatus.appended
              : PhotoEventWriteStatus.recoveredDurable,
          durability: PhotoEventDurability.durable,
          event: recovered.event!,
        );
      }

      if (result.exitCode == 0 || !recovered.readable) {
        throw const PhotoEventWriteException(
          PhotoEventWriteFailureKind.readback,
          'Canonical event writer outcome could not be proven by readback.',
          durability: PhotoEventDurability.uncertain,
        );
      }

      final output = '${result.stdout}\n${result.stderr}'.trim();
      throw PhotoEventWriteException(
        output.toLowerCase().contains('lock is already held')
            ? PhotoEventWriteFailureKind.lockConflict
            : PhotoEventWriteFailureKind.append,
        output.isEmpty ? 'Canonical event append failed.' : output,
        durability: PhotoEventDurability.provenNoEvent,
      );
    } on PhotoEventWriteException {
      rethrow;
    } on Exception catch (error) {
      throw PhotoEventWriteException(
        PhotoEventWriteFailureKind.append,
        'Could not prepare the canonical photo event: $error',
        durability: writerInvoked
            ? PhotoEventDurability.uncertain
            : PhotoEventDurability.provenNoEvent,
      );
    } finally {
      if (await tempDirectory.exists()) {
        await tempDirectory.delete(recursive: true);
      }
    }
  }

  void _validateRequest(
    ProjectState projectState,
    PhotoEventWriteRequest request,
  ) {
    if (!_photoIdPattern.hasMatch(request.photoId) ||
        !_modes.contains(request.mode) ||
        !isSafePhotoRelativePath(request.path) ||
        !_sha256Pattern.hasMatch(request.sha256) ||
        (request.layer != null && !_layers.contains(request.layer))) {
      throw const PhotoEventWriteException(
        PhotoEventWriteFailureKind.validation,
        'Photo event request contains invalid canonical values.',
        durability: PhotoEventDurability.provenNoEvent,
      );
    }
    for (final event in projectState.events) {
      if (event.eventType == 'photo_added' &&
          event.payload['photo_id'] == request.photoId) {
        throw const PhotoEventWriteException(
          PhotoEventWriteFailureKind.validation,
          'The supplied photo ID is already present in project events.',
          durability: PhotoEventDurability.provenNoEvent,
        );
      }
    }
  }

  void _validatePrimaryPhotoRequest(PrimaryPhotoEventWriteRequest request) {
    if (!isSafePhotoRelativePath(request.path) ||
        !_sha256Pattern.hasMatch(request.sha256.toLowerCase())) {
      throw const PhotoEventWriteException(
        PhotoEventWriteFailureKind.validation,
        'Primary photo handoff contains an invalid path or SHA-256 digest.',
        durability: PhotoEventDurability.provenNoEvent,
      );
    }
  }

  void _validateAlignmentRequest(
    ProjectState projectState,
    PhotoAlignmentEventWriteRequest request,
  ) {
    if (!_photoIdPattern.hasMatch(request.sourcePhotoId) ||
        !_alignmentBoardSides.contains(request.boardSide)) {
      throw const PhotoEventWriteException(
        PhotoEventWriteFailureKind.validation,
        'Alignment request contains invalid canonical identifiers.',
        durability: PhotoEventDurability.provenNoEvent,
      );
    }
    final hasAcceptedSourcePhoto = projectState.events.any(
      (event) =>
          event.schemaVersion == '1.0' &&
          event.status == 'accepted' &&
          event.eventType == 'photo_added' &&
          event.payload['photo_id'] == request.sourcePhotoId,
    );
    if (!hasAcceptedSourcePhoto) {
      throw const PhotoEventWriteException(
        PhotoEventWriteFailureKind.validation,
        'Alignment source must reference a prior accepted photo_added event.',
        durability: PhotoEventDurability.provenNoEvent,
      );
    }
    try {
      solvePhotoAlignment(
        transformType: request.transformType,
        photoPoints: request.photoPoints,
        boardPoints: request.boardPoints,
        photoWidth: request.photoWidth,
        photoHeight: request.photoHeight,
      );
    } on PhotoAlignmentException catch (error) {
      throw PhotoEventWriteException(
        PhotoEventWriteFailureKind.validation,
        error.message,
        durability: PhotoEventDurability.provenNoEvent,
      );
    }
  }

  String _resolvedEventsPath(String? projectDirectory) {
    if (projectDirectory == null || projectDirectory.trim().isEmpty) {
      throw const PhotoEventWriteException(
        PhotoEventWriteFailureKind.noProjectDirectory,
        'Project must be opened from a local folder before importing a photo.',
        durability: PhotoEventDurability.provenNoEvent,
      );
    }
    if (!_isAbsolute(projectDirectory) ||
        _containsDotSegment(projectDirectory)) {
      throw const PhotoEventWriteException(
        PhotoEventWriteFailureKind.invalidProjectDirectory,
        'Project directory must be an absolute, normalized local directory.',
        durability: PhotoEventDurability.provenNoEvent,
      );
    }
    try {
      final root = Directory(projectDirectory);
      if (!root.existsSync()) {
        throw const FileSystemException('Project directory does not exist.');
      }
      final resolvedRoot = root.resolveSymbolicLinksSync();
      if (FileSystemEntity.typeSync(resolvedRoot, followLinks: true) !=
          FileSystemEntityType.directory) {
        throw const FileSystemException('Project path is not a directory.');
      }
      final eventsPath = _join(resolvedRoot, 'events.jsonl');
      final entityType =
          FileSystemEntity.typeSync(eventsPath, followLinks: false);
      if (entityType == FileSystemEntityType.link ||
          entityType == FileSystemEntityType.directory) {
        throw const FileSystemException('events.jsonl is not a regular file.');
      }
      if (entityType == FileSystemEntityType.file &&
          !_isContained(
              resolvedRoot, File(eventsPath).resolveSymbolicLinksSync())) {
        throw const FileSystemException('events.jsonl escapes project root.');
      }
      return eventsPath;
    } on PhotoEventWriteException {
      rethrow;
    } on FileSystemException catch (error) {
      throw PhotoEventWriteException(
        PhotoEventWriteFailureKind.invalidProjectDirectory,
        'Project event path is not safe: ${error.message}',
        durability: PhotoEventDurability.provenNoEvent,
      );
    }
  }

  _EnvelopeAllocation _allocateEnvelope(ProjectState projectState) {
    _validateEventHistory(projectState.events);
    final eventIds = <String>{};
    final v1Sequences = <int>{};
    var maxEventNumber = 0;
    var maxV1Sequence = 0;
    for (final event in projectState.events) {
      final match = _eventIdPattern.firstMatch(event.eventId);
      if (match == null || !eventIds.add(event.eventId)) {
        throw const PhotoEventWriteException(
          PhotoEventWriteFailureKind.invalidEventHistory,
          'Project event IDs are malformed or duplicated.',
          durability: PhotoEventDurability.provenNoEvent,
        );
      }
      final eventNumber = int.parse(match.group(1)!);
      if (eventNumber > maxEventNumber) {
        maxEventNumber = eventNumber;
      }

      if (event.schemaVersion == '1.0') {
        if (event.sequence <= 0 || !v1Sequences.add(event.sequence)) {
          throw const PhotoEventWriteException(
            PhotoEventWriteFailureKind.invalidEventHistory,
            'Project V1 event sequences are non-positive or duplicated.',
            durability: PhotoEventDurability.provenNoEvent,
          );
        }
        if (event.sequence > maxV1Sequence) {
          maxV1Sequence = event.sequence;
        }
      }
    }
    if (maxEventNumber >= 999999) {
      throw const PhotoEventWriteException(
        PhotoEventWriteFailureKind.invalidEventHistory,
        'Project event ID space is exhausted.',
        durability: PhotoEventDurability.provenNoEvent,
      );
    }
    return _EnvelopeAllocation(
      eventId: 'evt_${(maxEventNumber + 1).toString().padLeft(6, '0')}',
      sequence: maxV1Sequence + 1,
    );
  }

  void _validateEventHistory(Iterable<TraceBenchEvent> events) {
    final eventIds = <String>{};
    final v1Sequences = <int>{};
    for (final event in events) {
      if (!_eventIdPattern.hasMatch(event.eventId) ||
          !eventIds.add(event.eventId)) {
        throw const PhotoEventWriteException(
          PhotoEventWriteFailureKind.invalidEventHistory,
          'Project event IDs are malformed or duplicated.',
          durability: PhotoEventDurability.provenNoEvent,
        );
      }
      if (event.schemaVersion == '1.0' &&
          (event.sequence <= 0 || !v1Sequences.add(event.sequence))) {
        throw const PhotoEventWriteException(
          PhotoEventWriteFailureKind.invalidEventHistory,
          'Project V1 event sequences are non-positive or duplicated.',
          durability: PhotoEventDurability.provenNoEvent,
        );
      }
    }
  }

  String _allocateAlignmentId(ProjectState projectState) {
    final alignmentIds = <String>{};
    var maxAlignmentNumber = 0;
    for (final event in projectState.events) {
      if (event.eventType != 'photo_to_board_alignment_confirmed') {
        continue;
      }
      final alignmentId = event.payload['alignment_id'];
      final match = alignmentId is String
          ? _alignmentIdPattern.firstMatch(alignmentId)
          : null;
      if (match == null || !alignmentIds.add(alignmentId as String)) {
        throw const PhotoEventWriteException(
          PhotoEventWriteFailureKind.invalidEventHistory,
          'Project alignment IDs are malformed or duplicated.',
          durability: PhotoEventDurability.provenNoEvent,
        );
      }
      final alignmentNumber = int.parse(match.group(1)!);
      if (alignmentNumber > maxAlignmentNumber) {
        maxAlignmentNumber = alignmentNumber;
      }
    }
    return 'ALN${maxAlignmentNumber + 1}';
  }

  String _allocatePrimaryPhotoId(ProjectState projectState) {
    final usedPhotoIds = <String>{
      for (final event in projectState.events)
        if (event.eventType == 'photo_added' &&
            event.payload['photo_id'] is String)
          event.payload['photo_id'] as String,
    };
    for (var number = 1; number <= 999999; number += 1) {
      final candidate = 'photo_primary_${number.toString().padLeft(3, '0')}';
      if (!usedPhotoIds.contains(candidate)) {
        return candidate;
      }
    }
    throw const PhotoEventWriteException(
      PhotoEventWriteFailureKind.invalidEventHistory,
      'Project primary photo ID space is exhausted.',
      durability: PhotoEventDurability.provenNoEvent,
    );
  }

  Future<List<String>?> _discoverPython() async {
    try {
      return await _pythonRunner.discoverPythonCommand();
    } on PythonDiscoveryException {
      return null;
    }
  }

  Future<_ReadbackResult> _readExactEvent(
    String eventsPath,
    Map<String, dynamic> candidate,
  ) async {
    try {
      final file = File(eventsPath);
      if (!await file.exists()) {
        return const _ReadbackResult(readable: true);
      }
      final candidateCanonical = _canonicalJson(candidate);
      await for (final line in file
          .openRead()
          .transform(utf8.decoder)
          .transform(const LineSplitter())) {
        if (line.trim().isEmpty) {
          continue;
        }
        final decoded = jsonDecode(line);
        if (decoded is! Map) {
          return const _ReadbackResult(readable: false);
        }
        final event = Map<String, dynamic>.from(decoded);
        if (_canonicalJson(event) == candidateCanonical) {
          return _ReadbackResult(readable: true, event: event);
        }
      }
      return const _ReadbackResult(readable: true);
    } on Exception {
      return const _ReadbackResult(readable: false);
    }
  }

  Future<_DurableEventHistory> _readDurableEventHistory(
    String eventsPath, {
    required String projectId,
  }) async {
    try {
      final file = File(eventsPath);
      if (!await file.exists()) {
        return const _DurableEventHistory(
          events: <TraceBenchEvent>[],
          rawEvents: <Map<String, dynamic>>[],
        );
      }
      final events = <TraceBenchEvent>[];
      final rawEvents = <Map<String, dynamic>>[];
      await for (final line in file
          .openRead()
          .transform(utf8.decoder)
          .transform(const LineSplitter())) {
        if (line.trim().isEmpty) {
          continue;
        }
        final decoded = jsonDecode(line);
        if (decoded is! Map) {
          throw const FormatException('Event history row is not an object.');
        }
        final rawEvent = Map<String, dynamic>.from(decoded);
        final event = TraceBenchEvent.fromJson(rawEvent);
        if (event.projectId != projectId) {
          throw const FormatException(
            'Event history contains another project identity.',
          );
        }
        rawEvents.add(rawEvent);
        events.add(event);
      }
      final reconciled = _DurableEventHistory(
        events: List<TraceBenchEvent>.unmodifiable(events),
        rawEvents: List<Map<String, dynamic>>.unmodifiable(rawEvents),
      );
      _validateEventHistory(reconciled.events);
      return reconciled;
    } on PhotoEventWriteException {
      rethrow;
    } on Exception catch (error) {
      throw PhotoEventWriteException(
        PhotoEventWriteFailureKind.invalidEventHistory,
        'Project event history could not be reconciled safely: $error',
        durability: PhotoEventDurability.provenNoEvent,
      );
    }
  }
}

class _EnvelopeAllocation {
  const _EnvelopeAllocation({required this.eventId, required this.sequence});

  final String eventId;
  final int sequence;
}

class _ReadbackResult {
  const _ReadbackResult({required this.readable, this.event});

  final bool readable;
  final Map<String, dynamic>? event;
}

class _DurableEventHistory {
  const _DurableEventHistory({
    required this.events,
    required this.rawEvents,
  });

  final List<TraceBenchEvent> events;
  final List<Map<String, dynamic>> rawEvents;
}

String _canonicalJson(Object? value) => jsonEncode(_canonicalValue(value));

Object? _canonicalValue(Object? value) {
  if (value is Map) {
    final keys = value.keys.map((key) => key.toString()).toList()..sort();
    return <String, dynamic>{
      for (final key in keys) key: _canonicalValue(value[key]),
    };
  }
  if (value is List) {
    return value.map(_canonicalValue).toList(growable: false);
  }
  return value;
}

String _join(String parent, String child) =>
    '$parent${Platform.pathSeparator}$child';

bool _isAbsolute(String path) => Platform.isWindows
    ? RegExp(r'^[A-Za-z]:[\\/]').hasMatch(path)
    : path.startsWith('/');

bool _containsDotSegment(String path) => path
    .replaceAll('\\', '/')
    .split('/')
    .any((segment) => segment == '.' || segment == '..');

bool _isContained(String root, String candidate) {
  final separator = Platform.pathSeparator;
  final normalizedRoot = root.endsWith(separator) ? root : '$root$separator';
  if (Platform.isWindows) {
    return candidate.toLowerCase().startsWith(normalizedRoot.toLowerCase());
  }
  return candidate.startsWith(normalizedRoot);
}
