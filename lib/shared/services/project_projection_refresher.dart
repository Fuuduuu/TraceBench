import 'dart:io';

import '../models/project_state.dart';
import 'project_loader.dart';
import 'python_runner.dart';

enum ProjectionRefreshFailure {
  noDirectory,
  unsupportedPlatform,
  pythonUnavailable,
  materializerFailed,
  reloadFailed,
  projectMismatch,
  eventsChanged,
  notFresh,
}

class ProjectionRefreshException implements Exception {
  const ProjectionRefreshException(this.failure);

  final ProjectionRefreshFailure failure;

  String get message => switch (failure) {
        ProjectionRefreshFailure.noDirectory =>
          'Värskendamiseks ava projekt kohalikust kaustast.',
        ProjectionRefreshFailure.unsupportedPlatform =>
          'Andmete värskendamine on saadaval arvutis.',
        ProjectionRefreshFailure.pythonUnavailable =>
          'Pythonit ei leitud. Kontrolli Pythoni seadistust ja proovi uuesti.',
        ProjectionRefreshFailure.materializerFailed =>
          'Andmete koostamine ebaõnnestus. Vana vaade on alles. Proovi uuesti.',
        ProjectionRefreshFailure.reloadFailed =>
          'Värskendatud andmete laadimine ebaõnnestus. Proovi uuesti.',
        ProjectionRefreshFailure.projectMismatch =>
          'Laaditud andmed ei vasta avatud projektile. Vana vaade on alles.',
        ProjectionRefreshFailure.eventsChanged =>
          'Kõik salvestatud muudatused ei ole laaditud andmetes. Proovi uuesti.',
        ProjectionRefreshFailure.notFresh =>
          'Laaditud andmed pole veel ajakohased. Proovi uuesti.',
      };
}

/// Explicitly rebuilds the existing derived projection, without exporting or
/// writing canonical events. The caller owns guarded installation in Session.
class ProjectProjectionRefresher {
  ProjectProjectionRefresher({
    PythonRunner? pythonRunner,
    Future<ProjectState> Function(String)? directoryLoader,
  })  : _pythonRunner = pythonRunner ?? PythonRunner(),
        _directoryLoader = directoryLoader ?? ProjectLoader.loadFromDirectory;

  final PythonRunner _pythonRunner;
  final Future<ProjectState> Function(String) _directoryLoader;

  Future<ProjectState> refresh(ProjectState snapshot) async {
    final directory = snapshot.projectDirectory;
    if (directory == null || directory.trim().isEmpty) {
      throw const ProjectionRefreshException(
          ProjectionRefreshFailure.noDirectory);
    }
    if (_pythonRunner.platformInfo.isMobile) {
      throw const ProjectionRefreshException(
          ProjectionRefreshFailure.unsupportedPlatform);
    }

    List<String>? python;
    try {
      python = await _pythonRunner.discoverPythonCommand();
    } catch (_) {
      throw const ProjectionRefreshException(
          ProjectionRefreshFailure.pythonUnavailable);
    }
    if (python == null || python.isEmpty) {
      throw const ProjectionRefreshException(
          ProjectionRefreshFailure.pythonUnavailable);
    }

    try {
      final result = await _pythonRunner.run(command: [
        ...python,
        '-X',
        'utf8',
        '-B',
        'tools/materialize_known_facts.py',
        _joinPath(directory.trim(), 'events.jsonl'),
        _joinPath(directory.trim(), 'known_facts.json'),
      ]);
      if (result.exitCode != 0) {
        throw const ProjectionRefreshException(
            ProjectionRefreshFailure.materializerFailed);
      }
    } catch (_) {
      throw const ProjectionRefreshException(
          ProjectionRefreshFailure.materializerFailed);
    }

    final ProjectState loaded;
    try {
      loaded = await _directoryLoader(directory.trim());
    } catch (_) {
      throw const ProjectionRefreshException(
          ProjectionRefreshFailure.reloadFailed);
    }
    if (loaded.manifest.projectId != snapshot.manifest.projectId ||
        loaded.knownFacts.projectId != snapshot.manifest.projectId ||
        loaded.projectDirectory == null ||
        _directoryIdentity(loaded.projectDirectory!) !=
            _directoryIdentity(directory.trim())) {
      throw const ProjectionRefreshException(
          ProjectionRefreshFailure.projectMismatch);
    }
    // The reloaded canonical history must contain the entire captured prefix,
    // including accepted events that have not appeared in known_facts yet.
    if (loaded.events.length < snapshot.events.length) {
      throw const ProjectionRefreshException(
          ProjectionRefreshFailure.eventsChanged);
    }
    for (var i = 0; i < snapshot.events.length; i++) {
      if (!_sameJson(snapshot.events[i].toJson(), loaded.events[i].toJson())) {
        throw const ProjectionRefreshException(
            ProjectionRefreshFailure.eventsChanged);
      }
    }
    if (loaded.projectionFreshness != ProjectionFreshness.fresh) {
      throw const ProjectionRefreshException(ProjectionRefreshFailure.notFresh);
    }
    return loaded.copyWith(projectDirectory: directory);
  }

  static String _joinPath(String directory, String file) =>
      directory.endsWith('/') || directory.endsWith('\\')
          ? '$directory$file'
          : '$directory${Platform.pathSeparator}$file';

  static String _directoryIdentity(String path) {
    final uri = Directory(path).absolute.uri.normalizePath().toString();
    return Platform.isWindows ? uri.toLowerCase() : uri;
  }

  // JSON object key order is not event meaning; nested values and list order are.
  static bool _sameJson(Object? a, Object? b) {
    if (a is Map && b is Map) {
      return a.length == b.length &&
          a.keys
              .every((key) => b.containsKey(key) && _sameJson(a[key], b[key]));
    }
    if (a is List && b is List) {
      if (a.length != b.length) return false;
      for (var i = 0; i < a.length; i++) {
        if (!_sameJson(a[i], b[i])) return false;
      }
      return true;
    }
    return a == b;
  }
}
