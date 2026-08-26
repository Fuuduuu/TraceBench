import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:math';

import 'package:crypto/crypto.dart';

import '../../../shared/models/project_state.dart';
import 'photo_event_writer.dart';

typedef PhotoAtomicFinalizer = Future<void> Function(
  File temporaryFile,
  File finalFile,
);
typedef PhotoOwnedFileDeleter = Future<void> Function(File file);

abstract interface class PhotoImportService {
  Future<PhotoImportResult> importPhoto({
    required ProjectState projectState,
    required PhotoImportRequest request,
  });
}

class PhotoImportRequest {
  const PhotoImportRequest({
    required this.sourcePath,
    required this.mode,
    this.layer,
  });

  final String sourcePath;
  final String mode;
  final String? layer;
}

class PhotoImportResult {
  const PhotoImportResult({
    required this.photoId,
    required this.path,
    required this.absolutePath,
    required this.sha256,
    required this.event,
  });

  final String photoId;
  final String path;
  final String absolutePath;
  final String sha256;
  final Map<String, dynamic> event;
}

enum PhotoImportFailureKind {
  validation,
  noProjectDirectory,
  invalidProjectDirectory,
  invalidPhotosDirectory,
  invalidSource,
  unsupportedSource,
  allocationFailed,
  copyFailed,
  finalizationFailed,
  writerRejected,
  writerUncertain,
  cleanupFailed,
}

class PhotoImportException implements Exception {
  const PhotoImportException(
    this.kind,
    this.message, {
    this.copyPreserved = false,
  });

  final PhotoImportFailureKind kind;
  final String message;
  final bool copyPreserved;

  @override
  String toString() => 'PhotoImportException: $message';
}

class LocalPhotoImportService implements PhotoImportService {
  LocalPhotoImportService({
    required PhotoEventWriter eventWriter,
    String Function()? photoIdGenerator,
    PhotoAtomicFinalizer? atomicFinalizer,
    PhotoOwnedFileDeleter? ownedFileDeleter,
  })  : _eventWriter = eventWriter,
        _photoIdGenerator = photoIdGenerator ?? _defaultPhotoId,
        _atomicFinalizer = atomicFinalizer ?? _atomicFinalizeNoReplace,
        _ownedFileDeleter = ownedFileDeleter ?? _deleteOwnedFile;

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
  static const Set<String> _extensions = <String>{
    'jpg',
    'jpeg',
    'png',
    'webp',
  };
  static final RegExp _photoIdPattern = RegExp(r'^photo_[a-z0-9_]+$');

  final PhotoEventWriter _eventWriter;
  final String Function() _photoIdGenerator;
  final PhotoAtomicFinalizer _atomicFinalizer;
  final PhotoOwnedFileDeleter _ownedFileDeleter;

  @override
  Future<PhotoImportResult> importPhoto({
    required ProjectState projectState,
    required PhotoImportRequest request,
  }) async {
    _validateDraft(request);
    final projectRoot = _resolveProjectRoot(projectState.projectDirectory);
    final source = _resolveSource(request.sourcePath);
    final extension = _sourceExtension(source.path);
    final photosDirectory = await _resolvePhotosDirectory(projectRoot);
    final usedPhotoIds = <String>{
      for (final event in projectState.events)
        if (event.eventType == 'photo_added' &&
            event.payload['photo_id'] is String)
          event.payload['photo_id'] as String,
    };

    for (var attempt = 0; attempt < 100; attempt += 1) {
      final allocation = _allocateDestination(
        photosDirectory: photosDirectory,
        extension: extension,
        usedPhotoIds: usedPhotoIds,
      );
      if (allocation == null) {
        continue;
      }
      usedPhotoIds.add(allocation.photoId);

      File? temporaryFile;
      try {
        final copied = await _copyAndHash(
          source: source,
          photosDirectory: photosDirectory,
        );
        temporaryFile = copied.file;
        try {
          await _atomicFinalizer(temporaryFile, allocation.finalFile);
        } on _DestinationCollisionException {
          await _cleanupTemporary(temporaryFile);
          continue;
        } on Exception catch (error) {
          await _cleanupTemporary(temporaryFile);
          throw PhotoImportException(
            PhotoImportFailureKind.finalizationFailed,
            'Could not finalize the project-local photo copy: $error',
          );
        }
        temporaryFile = null;

        final relativePath = 'photos/${allocation.fileName}';
        try {
          final written = await _eventWriter.writePhotoAdded(
            projectState: projectState,
            request: PhotoEventWriteRequest(
              photoId: allocation.photoId,
              mode: request.mode,
              path: relativePath,
              sha256: copied.sha256,
              layer: request.layer,
            ),
          );
          if (written.durability != PhotoEventDurability.durable) {
            throw const PhotoImportException(
              PhotoImportFailureKind.writerUncertain,
              'The canonical event writer did not prove a durable event.',
              copyPreserved: true,
            );
          }
          return PhotoImportResult(
            photoId: allocation.photoId,
            path: relativePath,
            absolutePath: allocation.finalFile.path,
            sha256: copied.sha256,
            event: written.event,
          );
        } on PhotoEventWriteException catch (error) {
          if (error.durability == PhotoEventDurability.provenNoEvent) {
            try {
              await _ownedFileDeleter(allocation.finalFile);
            } on Exception catch (cleanupError) {
              throw PhotoImportException(
                PhotoImportFailureKind.cleanupFailed,
                'The event was not written, but the exact imported copy could not be removed: $cleanupError',
                copyPreserved: true,
              );
            }
            throw PhotoImportException(
              PhotoImportFailureKind.writerRejected,
              error.message,
            );
          }
          throw PhotoImportException(
            PhotoImportFailureKind.writerUncertain,
            error.message,
            copyPreserved: true,
          );
        } on PhotoImportException {
          rethrow;
        } on Exception catch (error) {
          throw PhotoImportException(
            PhotoImportFailureKind.writerUncertain,
            'The canonical event writer outcome is uncertain: $error',
            copyPreserved: true,
          );
        }
      } on PhotoImportException {
        rethrow;
      } on Exception catch (error) {
        if (temporaryFile != null) {
          await _cleanupTemporary(temporaryFile);
        }
        throw PhotoImportException(
          PhotoImportFailureKind.copyFailed,
          'Could not copy and hash the selected photo: $error',
        );
      }
    }

    throw const PhotoImportException(
      PhotoImportFailureKind.allocationFailed,
      'Could not allocate an unused project-local photo ID and path.',
    );
  }

  void _validateDraft(PhotoImportRequest request) {
    if (!_modes.contains(request.mode) ||
        (request.layer != null && !_layers.contains(request.layer))) {
      throw const PhotoImportException(
        PhotoImportFailureKind.validation,
        'Photo mode or layer is not supported.',
      );
    }
  }

  String _resolveProjectRoot(String? projectDirectory) {
    if (projectDirectory == null || projectDirectory.trim().isEmpty) {
      throw const PhotoImportException(
        PhotoImportFailureKind.noProjectDirectory,
        'Photo import requires a project opened from a local folder.',
      );
    }
    if (!_isAbsolute(projectDirectory) ||
        _containsDotSegment(projectDirectory)) {
      throw const PhotoImportException(
        PhotoImportFailureKind.invalidProjectDirectory,
        'Project directory must be an absolute, normalized local directory.',
      );
    }
    try {
      final directory = Directory(projectDirectory);
      if (!directory.existsSync()) {
        throw const FileSystemException('Project directory does not exist.');
      }
      final resolved = directory.resolveSymbolicLinksSync();
      if (FileSystemEntity.typeSync(resolved, followLinks: true) !=
          FileSystemEntityType.directory) {
        throw const FileSystemException('Project path is not a directory.');
      }
      return resolved;
    } on FileSystemException catch (error) {
      throw PhotoImportException(
        PhotoImportFailureKind.invalidProjectDirectory,
        'Project directory is not usable: ${error.message}',
      );
    }
  }

  File _resolveSource(String sourcePath) {
    if (sourcePath.trim().isEmpty || !_isAbsolute(sourcePath)) {
      throw const PhotoImportException(
        PhotoImportFailureKind.invalidSource,
        'Selected photo must be an absolute local file path.',
      );
    }
    final extension = _sourceExtension(sourcePath);
    if (!_extensions.contains(extension)) {
      throw const PhotoImportException(
        PhotoImportFailureKind.unsupportedSource,
        'Selected photo type is not supported.',
      );
    }
    try {
      if (FileSystemEntity.typeSync(sourcePath, followLinks: true) !=
          FileSystemEntityType.file) {
        throw const FileSystemException('Selected path is not a regular file.');
      }
      final resolved = File(sourcePath).resolveSymbolicLinksSync();
      if (FileSystemEntity.typeSync(resolved, followLinks: true) !=
          FileSystemEntityType.file) {
        throw const FileSystemException('Selected path is not a regular file.');
      }
      return File(resolved);
    } on FileSystemException catch (error) {
      throw PhotoImportException(
        PhotoImportFailureKind.invalidSource,
        'Selected photo is not readable: ${error.message}',
      );
    }
  }

  Future<Directory> _resolvePhotosDirectory(String projectRoot) async {
    final path = _join(projectRoot, 'photos');
    try {
      final initialType = FileSystemEntity.typeSync(path, followLinks: false);
      if (initialType == FileSystemEntityType.notFound) {
        await Directory(path).create();
      } else if (initialType != FileSystemEntityType.directory) {
        throw const FileSystemException('photos path is not a directory.');
      }
      final resolved = Directory(path).resolveSymbolicLinksSync();
      if (!_isContained(projectRoot, resolved) ||
          FileSystemEntity.typeSync(resolved, followLinks: true) !=
              FileSystemEntityType.directory) {
        throw const FileSystemException(
            'photos directory escapes project root.');
      }
      return Directory(resolved);
    } on FileSystemException catch (error) {
      throw PhotoImportException(
        PhotoImportFailureKind.invalidPhotosDirectory,
        'Project photos directory is not safe: ${error.message}',
      );
    }
  }

  _DestinationAllocation? _allocateDestination({
    required Directory photosDirectory,
    required String extension,
    required Set<String> usedPhotoIds,
  }) {
    final photoId = _photoIdGenerator();
    if (!_photoIdPattern.hasMatch(photoId)) {
      throw const PhotoImportException(
        PhotoImportFailureKind.allocationFailed,
        'Generated photo ID is not canonical.',
      );
    }
    if (usedPhotoIds.contains(photoId)) {
      return null;
    }
    final fileName = '$photoId.$extension';
    final finalFile = File(_join(photosDirectory.path, fileName));
    if (!_isContained(photosDirectory.path, finalFile.path) ||
        FileSystemEntity.typeSync(finalFile.path, followLinks: false) !=
            FileSystemEntityType.notFound) {
      return null;
    }
    return _DestinationAllocation(
      photoId: photoId,
      fileName: fileName,
      finalFile: finalFile,
    );
  }

  Future<_CopiedPhoto> _copyAndHash({
    required File source,
    required Directory photosDirectory,
  }) async {
    RandomAccessFile? target;
    File? temporaryFile;
    for (var attempt = 0; attempt < 20 && target == null; attempt += 1) {
      final token = '${DateTime.now().microsecondsSinceEpoch}_'
          '${Random.secure().nextInt(0x7fffffff)}';
      final candidate = File(
        _join(photosDirectory.path, '.tracebench-photo-$token.tmp'),
      );
      var candidateOwned = false;
      try {
        await candidate.create(exclusive: true);
        candidateOwned = true;
        target = await candidate.open(mode: FileMode.write);
        temporaryFile = candidate;
      } on FileSystemException {
        if (candidateOwned) {
          await _cleanupTemporary(candidate);
        }
        continue;
      }
    }
    if (target == null || temporaryFile == null) {
      throw const PhotoImportException(
        PhotoImportFailureKind.allocationFailed,
        'Could not allocate an invocation-owned photo temporary file.',
      );
    }

    final digestSink = _DigestSink();
    final hashSink = sha256.startChunkedConversion(digestSink);
    var hashClosed = false;
    var completed = false;
    try {
      await for (final chunk in source.openRead()) {
        hashSink.add(chunk);
        await target.writeFrom(chunk);
      }
      hashSink.close();
      hashClosed = true;
      await target.flush();
      await target.close();
      target = null;
      final digest = digestSink.value;
      if (digest == null) {
        throw StateError('SHA-256 digest was not produced.');
      }
      completed = true;
      return _CopiedPhoto(file: temporaryFile, sha256: digest.toString());
    } finally {
      Object? closeError;
      if (!hashClosed) {
        try {
          hashSink.close();
        } on Object catch (error) {
          closeError = error;
        }
      }
      if (target != null) {
        try {
          await target.close();
        } on Object catch (error) {
          closeError ??= error;
        }
      }
      if (!completed) {
        await _cleanupTemporary(temporaryFile);
      }
      if (closeError != null) {
        throw closeError;
      }
    }
  }
}

class _DestinationAllocation {
  const _DestinationAllocation({
    required this.photoId,
    required this.fileName,
    required this.finalFile,
  });

  final String photoId;
  final String fileName;
  final File finalFile;
}

class _CopiedPhoto {
  const _CopiedPhoto({required this.file, required this.sha256});

  final File file;
  final String sha256;
}

class _DigestSink implements Sink<Digest> {
  Digest? value;

  @override
  void add(Digest data) {
    if (value != null) {
      throw StateError('SHA-256 produced more than one digest.');
    }
    value = data;
  }

  @override
  void close() {}
}

class _DestinationCollisionException implements Exception {
  const _DestinationCollisionException();
}

Future<void> _deleteOwnedFile(File file) => file.delete();

Future<void> _deleteIfPresent(File file) async {
  if (await file.exists()) {
    await file.delete();
  }
}

Future<void> _cleanupTemporary(File file) async {
  try {
    await _deleteIfPresent(file);
  } on Exception catch (error) {
    throw PhotoImportException(
      PhotoImportFailureKind.cleanupFailed,
      'The invocation-owned photo temporary file could not be removed: $error',
    );
  }
}

String _defaultPhotoId() {
  final micros = DateTime.now().toUtc().microsecondsSinceEpoch;
  final random = Random.secure().nextInt(0x7fffffff);
  return 'photo_${micros}_$random';
}

Future<void> _atomicFinalizeNoReplace(
  File temporaryFile,
  File finalFile,
) async {
  if (Platform.isWindows) {
    _moveFileNoReplaceWindows(temporaryFile.path, finalFile.path);
    return;
  }
  _linkNoReplacePosix(temporaryFile.path, finalFile.path);
  await temporaryFile.delete();
}

typedef _MoveFileExWNative = Int32 Function(
  Pointer<Uint16>,
  Pointer<Uint16>,
  Uint32,
);
typedef _MoveFileExWDart = int Function(
  Pointer<Uint16>,
  Pointer<Uint16>,
  int,
);
typedef _LocalAllocNative = Pointer<Void> Function(Uint32, IntPtr);
typedef _LocalAllocDart = Pointer<Void> Function(int, int);
typedef _LocalFreeNative = Pointer<Void> Function(Pointer<Void>);
typedef _LocalFreeDart = Pointer<Void> Function(Pointer<Void>);
typedef _GetLastErrorNative = Uint32 Function();
typedef _GetLastErrorDart = int Function();

void _moveFileNoReplaceWindows(String source, String destination) {
  final kernel32 = DynamicLibrary.open('kernel32.dll');
  final moveFileEx = kernel32
      .lookupFunction<_MoveFileExWNative, _MoveFileExWDart>('MoveFileExW');
  final localAlloc =
      kernel32.lookupFunction<_LocalAllocNative, _LocalAllocDart>('LocalAlloc');
  final localFree =
      kernel32.lookupFunction<_LocalFreeNative, _LocalFreeDart>('LocalFree');
  final getLastError = kernel32
      .lookupFunction<_GetLastErrorNative, _GetLastErrorDart>('GetLastError');
  final sourcePointer = _allocateUtf16(source, localAlloc);
  final destinationPointer = _allocateUtf16(destination, localAlloc);
  try {
    const moveFileWriteThrough = 0x8;
    if (moveFileEx(sourcePointer, destinationPointer, moveFileWriteThrough) ==
        0) {
      final error = getLastError();
      if (error == 80 || error == 183) {
        throw const _DestinationCollisionException();
      }
      throw FileSystemException(
        'MoveFileExW failed with Windows error $error.',
        destination,
      );
    }
  } finally {
    localFree(sourcePointer.cast<Void>());
    localFree(destinationPointer.cast<Void>());
  }
}

Pointer<Uint16> _allocateUtf16(String value, _LocalAllocDart localAlloc) {
  final pointer = localAlloc(0, (value.codeUnits.length + 1) * 2);
  if (pointer == nullptr) {
    throw const FileSystemException(
      'Could not allocate a Windows path buffer.',
    );
  }
  final typed = pointer.cast<Uint16>().asTypedList(value.codeUnits.length + 1);
  typed.setRange(0, value.codeUnits.length, value.codeUnits);
  typed[value.codeUnits.length] = 0;
  return pointer.cast<Uint16>();
}

typedef _LinkNative = Int32 Function(Pointer<Int8>, Pointer<Int8>);
typedef _LinkDart = int Function(Pointer<Int8>, Pointer<Int8>);

void _linkNoReplacePosix(String source, String destination) {
  final process = DynamicLibrary.process();
  final link = process.lookupFunction<_LinkNative, _LinkDart>('link');
  final sourcePointer = _allocateUtf8(source);
  final destinationPointer = _allocateUtf8(destination);
  try {
    if (link(sourcePointer, destinationPointer) != 0) {
      if (File(destination).existsSync()) {
        throw const _DestinationCollisionException();
      }
      throw FileSystemException(
          'Atomic link finalization failed.', destination);
    }
  } finally {
    _freeNative(sourcePointer.cast<Void>());
    _freeNative(destinationPointer.cast<Void>());
  }
}

Pointer<Int8> _allocateUtf8(String value) {
  final bytes = utf8.encode(value);
  final pointer = _allocateNative(bytes.length + 1).cast<Int8>();
  final typed = pointer.cast<Uint8>().asTypedList(bytes.length + 1);
  typed.setRange(0, bytes.length, bytes);
  typed[bytes.length] = 0;
  return pointer;
}

Pointer<Void> _allocateNative(int length) {
  final allocator = DynamicLibrary.process().lookupFunction<
      Pointer<Void> Function(IntPtr), Pointer<Void> Function(int)>('malloc');
  final pointer = allocator(length);
  if (pointer == nullptr) {
    throw const FileSystemException('Could not allocate a native path buffer.');
  }
  return pointer;
}

void _freeNative(Pointer<Void> pointer) {
  DynamicLibrary.process().lookupFunction<Void Function(Pointer<Void>),
      void Function(Pointer<Void>)>('free')(pointer);
}

String _sourceExtension(String path) {
  final normalized = path.replaceAll('\\', '/');
  final fileName = normalized.split('/').last;
  final dot = fileName.lastIndexOf('.');
  return dot < 0 ? '' : fileName.substring(dot + 1).toLowerCase();
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
