import 'dart:convert';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:flutter/services.dart';

import '../models/known_facts.dart';
import '../models/project_manifest.dart';
import '../models/project_state.dart';
import '../models/trace_bench_event.dart';
import '../models/wizard_intake.dart';

class ProjectLoadException implements Exception {
  const ProjectLoadException(this.message);

  final String message;

  @override
  String toString() => 'ProjectLoadException: $message';
}

class ProjectLoader {
  ProjectLoader._();

  static const String _manifestPath = 'manifest.json';
  static const String _eventsPath = 'events.jsonl';
  static const String _knownFactsPath = 'known_facts.json';
  static const String _customerReportPath = 'exports/customer_report.md';
  static const String _schemaVersionsPath = 'metadata/schema_versions.json';
  static const String _wizardIntakePath = 'notes/wizard_intake.json';
  static const String _wizardIntakeWarning =
      'Projekti visuaalset Wizardi alusinfot ei saanud laadida. Projekt ise '
      'avati ja kinnitatud projektiteave jäi puutumata.';
  static const String _legacyWizardIntakeWarning =
      'Selle projekti Wizardi aluskaadri kuvasuhe puudub. Kasutatakse '
      'legacy-ruutkaadrit; foto, kontuuri ja kandidaatide täpset joondust ei '
      'saa kinnitada. Täpne joondus nõuab migratsiooni või projekti uuesti '
      'loomist.';
  static const String _assetManifestPath =
      'assets/samples/pelle_pv20_minimal/manifest.json';
  static const String _assetEventsPath =
      'assets/samples/pelle_pv20_minimal/events.jsonl';
  static const String _assetKnownFactsPath =
      'assets/samples/pelle_pv20_minimal/known_facts.json';
  static const String _assetReportPath =
      'assets/samples/pelle_pv20_minimal/exports/customer_report.md';

  static Future<ProjectState> loadFromAssets() async {
    final manifestRaw = await rootBundle.loadString(_assetManifestPath);
    final eventsRaw = await rootBundle.loadString(_assetEventsPath);
    final knownFactsRaw = await rootBundle.loadString(_assetKnownFactsPath);
    final reportRaw = await rootBundle.loadString(_assetReportPath);

    return _buildProjectState(
      manifestRaw: manifestRaw,
      eventsRaw: eventsRaw,
      knownFactsRaw: knownFactsRaw,
      reportRaw: reportRaw,
      schemaVersionsRaw: null,
      wizardIntake: null,
      wizardIntakeWarning: null,
    );
  }

  static Future<ProjectState> loadFromZipBytes(Uint8List zipBytes) async {
    final archive = ZipDecoder().decodeBytes(zipBytes, verify: true);

    final manifestFile = _findRequiredFile(archive, _manifestPath);
    final eventsFile = _findRequiredFile(archive, _eventsPath);
    final knownFactsFile = _findRequiredFile(archive, _knownFactsPath);
    final customerReportFile = _findRequiredFile(archive, _customerReportPath);
    final schemaVersionsFile = archive.findFile(_schemaVersionsPath);
    final wizardIntakeResult = _loadWizardIntakeFromArchive(archive);

    final manifestRaw = _fileContentAsString(manifestFile);
    final eventsRaw = _fileContentAsString(eventsFile);
    final knownFactsRaw = _fileContentAsString(knownFactsFile);
    final customerReportRaw = _fileContentAsString(customerReportFile);
    final schemaVersionsRaw = schemaVersionsFile == null
        ? null
        : _fileContentAsString(schemaVersionsFile);

    return _buildProjectState(
      manifestRaw: manifestRaw,
      eventsRaw: eventsRaw,
      knownFactsRaw: knownFactsRaw,
      reportRaw: customerReportRaw,
      schemaVersionsRaw: schemaVersionsRaw,
      wizardIntake: wizardIntakeResult.intake,
      wizardIntakeWarning: wizardIntakeResult.warning,
    );
  }

  static Future<ProjectState> loadFromDirectory(String projectDirectory) async {
    final trimmedDirectory = projectDirectory.trim();
    if (trimmedDirectory.isEmpty) {
      throw const ProjectLoadException('Project directory path is empty');
    }

    final directory = Directory(trimmedDirectory);
    if (!await directory.exists()) {
      throw ProjectLoadException(
        'Project directory does not exist: $trimmedDirectory',
      );
    }

    final manifestRaw = await _readRequiredLocalFile(
      trimmedDirectory,
      _manifestPath,
    );
    final eventsRaw = await _readRequiredLocalFile(
      trimmedDirectory,
      _eventsPath,
    );
    final knownFactsRaw = await _readRequiredLocalFile(
      trimmedDirectory,
      _knownFactsPath,
    );
    final customerReportRaw = await _readRequiredLocalFile(
      trimmedDirectory,
      _customerReportPath,
    );
    final schemaVersionsRaw = await _readOptionalLocalFile(
      trimmedDirectory,
      _schemaVersionsPath,
    );
    final wizardIntakeResult = await _loadWizardIntakeFromDirectory(
      trimmedDirectory,
    );

    return _buildProjectState(
      manifestRaw: manifestRaw,
      eventsRaw: eventsRaw,
      knownFactsRaw: knownFactsRaw,
      reportRaw: customerReportRaw,
      schemaVersionsRaw: schemaVersionsRaw,
      wizardIntake: wizardIntakeResult.intake,
      wizardIntakeWarning: wizardIntakeResult.warning,
    ).copyWith(
      projectDirectory: trimmedDirectory,
      isProjectionStale: false,
    );
  }

  static ArchiveFile _findRequiredFile(Archive archive, String relativePath) {
    final target = relativePath.replaceAll('\\', '/');
    for (final file in archive.files) {
      final normalizedName = file.name.replaceAll('\\', '/');
      if (normalizedName == target || normalizedName.endsWith('/$target')) {
        return file;
      }
    }
    throw ProjectLoadException('Required file missing in ZIP: $relativePath');
  }

  static ArchiveFile? _findOptionalFile(
    Archive archive,
    String relativePath,
  ) {
    final target = relativePath.replaceAll('\\', '/');
    for (final file in archive.files) {
      final normalizedName = file.name.replaceAll('\\', '/');
      if (normalizedName == target || normalizedName.endsWith('/$target')) {
        return file;
      }
    }
    return null;
  }

  static _WizardIntakeLoadResult _loadWizardIntakeFromArchive(
    Archive archive,
  ) {
    final file = _findOptionalFile(archive, _wizardIntakePath);
    if (file == null) {
      return const _WizardIntakeLoadResult();
    }

    try {
      return _parseWizardIntake(_fileContentAsString(file));
    } on FormatException {
      return const _WizardIntakeLoadResult(
        warning: _wizardIntakeWarning,
      );
    }
  }

  static Future<_WizardIntakeLoadResult> _loadWizardIntakeFromDirectory(
    String projectDirectory,
  ) async {
    final file = File(_joinPath(projectDirectory, _wizardIntakePath));

    try {
      if (!await file.exists()) {
        return const _WizardIntakeLoadResult();
      }
      return _parseWizardIntake(await file.readAsString());
    } on FileSystemException {
      return const _WizardIntakeLoadResult(
        warning: _wizardIntakeWarning,
      );
    } on FormatException {
      return const _WizardIntakeLoadResult(
        warning: _wizardIntakeWarning,
      );
    }
  }

  static _WizardIntakeLoadResult _parseWizardIntake(String raw) {
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! Map<String, dynamic>) {
        throw const WizardIntakeFormatException(r'$', 'must be an object');
      }
      final intake = WizardIntake.fromJson(decoded);
      return _WizardIntakeLoadResult(
        intake: intake,
        warning: intake.referenceFrameAspectRatio == null
            ? _legacyWizardIntakeWarning
            : null,
      );
    } on FormatException {
      return const _WizardIntakeLoadResult(
        warning: _wizardIntakeWarning,
      );
    } on WizardIntakeFormatException {
      return const _WizardIntakeLoadResult(
        warning: _wizardIntakeWarning,
      );
    }
  }

  static String _fileContentAsString(ArchiveFile file) {
    final content = file.content;
    if (content is List<int>) {
      return utf8.decode(content);
    }
    return '';
  }

  static Future<String> _readRequiredLocalFile(
    String projectDirectory,
    String relativePath,
  ) async {
    final file = File(_joinPath(projectDirectory, relativePath));
    if (!await file.exists()) {
      throw ProjectLoadException(
        'Required file missing in project directory: $relativePath',
      );
    }

    try {
      return await file.readAsString();
    } on FileSystemException catch (error) {
      throw ProjectLoadException(
        'Failed reading $relativePath: ${error.message}',
      );
    }
  }

  static Future<String?> _readOptionalLocalFile(
    String projectDirectory,
    String relativePath,
  ) async {
    final file = File(_joinPath(projectDirectory, relativePath));
    if (!await file.exists()) {
      return null;
    }

    try {
      return await file.readAsString();
    } on FileSystemException catch (error) {
      throw ProjectLoadException(
        'Failed reading $relativePath: ${error.message}',
      );
    }
  }

  static String _joinPath(String base, String relativePath) {
    final normalizedRelative = relativePath.replaceAll(
      '/',
      Platform.pathSeparator,
    );
    if (base.endsWith('/') || base.endsWith('\\')) {
      return '$base$normalizedRelative';
    }
    return '$base${Platform.pathSeparator}$normalizedRelative';
  }

  static List<TraceBenchEvent> parseEvents(String eventsRaw) {
    final events = <TraceBenchEvent>[];
    for (final line in const LineSplitter().convert(eventsRaw)) {
      final trimmed = line.trim();
      if (trimmed.isEmpty) continue;

      final decoded = jsonDecode(trimmed);
      if (decoded is Map<String, dynamic>) {
        events.add(TraceBenchEvent.fromJson(decoded));
      } else {
        throw const ProjectLoadException('Event line is not a JSON object');
      }
    }
    return events;
  }

  static ProjectState _buildProjectState({
    required String manifestRaw,
    required String eventsRaw,
    required String knownFactsRaw,
    required String reportRaw,
    required String? schemaVersionsRaw,
    required WizardIntake? wizardIntake,
    required String? wizardIntakeWarning,
  }) {
    final manifest = ProjectManifest.fromJson(
      _decodeJsonObject(manifestRaw, _manifestPath),
    );
    final knownFacts = KnownFacts.fromJson(
      _decodeJsonObject(knownFactsRaw, _knownFactsPath),
    );
    final events = parseEvents(eventsRaw);
    final schemaVersions =
        schemaVersionsRaw == null || schemaVersionsRaw.trim().isEmpty
            ? null
            : _decodeJsonObject(schemaVersionsRaw, _schemaVersionsPath);

    return ProjectState(
      manifest: manifest,
      knownFacts: knownFacts,
      events: events,
      customerReport: reportRaw,
      schemaVersions: schemaVersions,
      wizardIntake: wizardIntake,
      wizardIntakeWarning: wizardIntakeWarning,
    );
  }

  static Map<String, dynamic> _decodeJsonObject(String raw, String sourceName) {
    final decoded = jsonDecode(raw);
    if (decoded is Map<String, dynamic>) {
      return decoded;
    }
    throw ProjectLoadException('Invalid JSON object in $sourceName');
  }
}

class _WizardIntakeLoadResult {
  const _WizardIntakeLoadResult({
    this.intake,
    this.warning,
  });

  final WizardIntake? intake;
  final String? warning;
}
