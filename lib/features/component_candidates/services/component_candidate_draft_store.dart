import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';

import '../models/component_candidate_draft.dart';

class ComponentCandidateDraftSnapshot {
  const ComponentCandidateDraftSnapshot(this.document, this.revision);

  final ComponentCandidateDocument document;
  final String? revision;
}

/// Optional local visual drafts; never writes intake, events or project exports.
class ComponentCandidateDraftStore {
  const ComponentCandidateDraftStore();

  static int _temporarySequence = 0;

  Future<ComponentCandidateDraftSnapshot> load(
    String projectDirectory,
    ComponentCandidateDocument seed,
  ) async {
    final paths = _paths(projectDirectory);
    final snapshot = await _read(paths.file, seed);
    if (snapshot.document.nextDraftKey < seed.nextDraftKey) {
      throw const FormatException(
          'Candidate draft identity high water is below the original intake.');
    }
    return snapshot;
  }

  Future<ComponentCandidateDraftSnapshot> save(
    String projectDirectory,
    ComponentCandidateDocument document, {
    required String? expectedRevision,
  }) async {
    // Validate before creating any local files, including const-created drafts.
    final bytes = utf8.encode(
        '${const JsonEncoder.withIndent('  ').convert(document.toJson())}\n');
    var paths = _paths(projectDirectory);
    await paths.folder.create();
    paths = _paths(projectDirectory);
    final lock = File(
        '${paths.folder.path}${Platform.pathSeparator}component_candidates.lock');
    final token =
        '$pid-${DateTime.now().microsecondsSinceEpoch}-${_temporarySequence++}';
    File? temporary;
    var ownsLock = false;
    var lockTokenWritten = false;
    try {
      try {
        await lock.create(exclusive: true);
        ownsLock = true;
      } on FileSystemException {
        throw const FormatException(
            'Candidate drafts are being saved elsewhere, or the local lock is unavailable.');
      }
      await lock.writeAsString(token, flush: true);
      lockTokenWritten = true;
      paths = _paths(projectDirectory);
      final current = await _read(paths.file, document);
      _checkRevision(current.revision, expectedRevision);
      if (current.revision != null) {
        _checkIdentities(current.document, document);
      }

      temporary = File(
          '${paths.folder.path}${Platform.pathSeparator}component_candidates.$token.tmp');
      await temporary.create(exclusive: true);
      await temporary.writeAsBytes(bytes, flush: true);

      // Recheck both containment and revision just before the atomic replacement.
      paths = _paths(projectDirectory);
      final latest = await _read(paths.file, document);
      _checkRevision(latest.revision, expectedRevision);
      await temporary.rename(paths.file.path);
      temporary = null;
      return ComponentCandidateDraftSnapshot(
          document, sha256.convert(bytes).toString());
    } finally {
      try {
        if (temporary != null && await temporary.exists()) {
          await temporary.delete();
        }
      } finally {
        // A foreign lock is never removed, even if a process replaced ours.
        if (ownsLock &&
            FileSystemEntity.typeSync(lock.path, followLinks: false) ==
                FileSystemEntityType.file) {
          final contents = await lock.readAsString();
          if (contents == token ||
              !lockTokenWritten && token.startsWith(contents)) {
            await lock.delete();
          }
        }
      }
    }
  }

  Future<ComponentCandidateDraftSnapshot> _read(
    File file,
    ComponentCandidateDocument fallback,
  ) async {
    if (!await file.exists()) {
      return ComponentCandidateDraftSnapshot(fallback, null);
    }
    final bytes = await file.readAsBytes();
    final Object? decoded;
    try {
      decoded = jsonDecode(utf8.decode(bytes));
    } on FormatException {
      throw const FormatException(
          'The local component candidate draft is corrupt. Existing bytes were preserved.');
    }
    if (decoded is! Map<String, dynamic>) {
      throw const FormatException(
          'The local component candidate draft must be a JSON object.');
    }
    final document = ComponentCandidateDocument.fromJson(decoded);
    if (!document.sameContext(fallback)) {
      throw const FormatException(
          'The local component candidate draft belongs to a different project, intake or reference frame.');
    }
    return ComponentCandidateDraftSnapshot(
        document, sha256.convert(bytes).toString());
  }

  void _checkRevision(String? actual, String? expected) {
    if (actual != expected) {
      throw const FormatException(
          'Candidate drafts changed since loading. Reopen them before saving.');
    }
  }

  void _checkIdentities(
      ComponentCandidateDocument current, ComponentCandidateDocument next) {
    if (next.nextDraftKey < current.nextDraftKey) {
      throw const FormatException(
          'Candidate draft identity high water cannot decrease.');
    }
    final existingKeys =
        current.candidates.map((candidate) => candidate.draftKey).toSet();
    if (next.candidates.any((candidate) =>
        candidate.draftKey < current.nextDraftKey &&
        !existingKeys.contains(candidate.draftKey))) {
      throw const FormatException(
          'A deleted candidate identity cannot be reused.');
    }
  }

  _DraftPaths _paths(String projectDirectory) {
    final absolute = Platform.isWindows
        ? RegExp(r'^[A-Za-z]:[\\/]').hasMatch(projectDirectory)
        : projectDirectory.startsWith('/');
    if (!absolute ||
        projectDirectory
            .split(RegExp(r'[\\/]+'))
            .any((part) => part == '.' || part == '..')) {
      throw const FormatException(
          'Candidate drafts require an absolute project path without navigation segments.');
    }
    final root = Directory(projectDirectory);
    if (FileSystemEntity.typeSync(root.path, followLinks: false) !=
            FileSystemEntityType.directory ||
        !_samePath(root.absolute.path, root.resolveSymbolicLinksSync())) {
      throw const FormatException(
          'Candidate draft project path must be an existing canonical directory.');
    }
    final folder =
        Directory('${root.path}${Platform.pathSeparator}.tracebench_local');
    final folderType =
        FileSystemEntity.typeSync(folder.path, followLinks: false);
    if (folderType != FileSystemEntityType.notFound &&
        (folderType != FileSystemEntityType.directory ||
            !_samePath(
                folder.absolute.path, folder.resolveSymbolicLinksSync()))) {
      throw const FormatException(
          'The local draft folder must stay inside the project and must not be linked.');
    }
    final file = File(
        '${folder.path}${Platform.pathSeparator}component_candidates.json');
    final fileType = FileSystemEntity.typeSync(file.path, followLinks: false);
    if (fileType != FileSystemEntityType.notFound &&
        (fileType != FileSystemEntityType.file ||
            !_samePath(file.absolute.path, file.resolveSymbolicLinksSync()))) {
      throw const FormatException(
          'The local draft sidecar must be a regular file and must not be linked.');
    }
    return _DraftPaths(folder, file);
  }

  bool _samePath(String left, String right) {
    String normalize(String value) {
      final normalized =
          value.replaceAll('\\', '/').replaceFirst(RegExp(r'/+$'), '');
      return Platform.isWindows ? normalized.toLowerCase() : normalized;
    }

    return normalize(left) == normalize(right);
  }
}

class _DraftPaths {
  const _DraftPaths(this.folder, this.file);
  final Directory folder;
  final File file;
}
