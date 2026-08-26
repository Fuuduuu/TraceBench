import 'dart:convert';
import 'dart:io';

import '../../../shared/models/project_state.dart';
import '../../../shared/services/python_runner.dart';
import '../logic/photo_event_read_model.dart';

abstract interface class PhotoEventWriter {
  Future<PhotoEventWriteResult> writePhotoAdded({
    required ProjectState projectState,
    required PhotoEventWriteRequest request,
  });
}

enum PhotoEventWriteStatus {
  appended,
  recoveredDurable,
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

class PhotoEventWriterService implements PhotoEventWriter {
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
