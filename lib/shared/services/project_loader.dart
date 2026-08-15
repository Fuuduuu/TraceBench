import 'dart:convert';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:crypto/crypto.dart';
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
  static final RegExp _lowercaseSha256 = RegExp(r'^[0-9a-f]{64}$');

  static Future<ProjectState> loadFromAssets({AssetBundle? assetBundle}) async {
    final bundle = assetBundle ?? rootBundle;
    final manifestRaw = await bundle.loadString(_assetManifestPath);
    final eventsData = await bundle.load(_assetEventsPath);
    final eventsBytes = Uint8List.fromList(
      eventsData.buffer.asUint8List(
        eventsData.offsetInBytes,
        eventsData.lengthInBytes,
      ),
    );
    final knownFactsRaw = await bundle.loadString(_assetKnownFactsPath);
    final reportRaw = await bundle.loadString(_assetReportPath);

    return _buildProjectState(
      manifestRaw: manifestRaw,
      eventsBytes: eventsBytes,
      knownFactsRaw: knownFactsRaw,
      reportRaw: reportRaw,
      schemaVersionsRaw: null,
      wizardIntake: null,
      wizardIntakeWarning: null,
    );
  }

  static Future<ProjectState> loadFromZipBytes(
    Uint8List zipBytes, {
    Archive Function(Uint8List zipBytes)? archiveDecoder,
  }) async {
    final archive = archiveDecoder?.call(zipBytes) ??
        ZipDecoder().decodeBytes(zipBytes, verify: true);

    final manifestFile = _findRequiredFile(archive, _manifestPath);
    final eventsFile = _findRequiredFile(archive, _eventsPath);
    final knownFactsFile = _findRequiredFile(archive, _knownFactsPath);
    final customerReportFile = _findRequiredFile(archive, _customerReportPath);
    final schemaVersionsFile = archive.findFile(_schemaVersionsPath);
    final wizardIntakeResult = _loadWizardIntakeFromArchive(archive);

    final manifestRaw = _fileContentAsString(manifestFile);
    final eventsBytes = _fileContentAsBytes(eventsFile);
    final knownFactsRaw = _fileContentAsString(knownFactsFile);
    final customerReportRaw = _fileContentAsString(customerReportFile);
    final schemaVersionsRaw = schemaVersionsFile == null
        ? null
        : _fileContentAsString(schemaVersionsFile);

    return _buildProjectState(
      manifestRaw: manifestRaw,
      eventsBytes: eventsBytes,
      knownFactsRaw: knownFactsRaw,
      reportRaw: customerReportRaw,
      schemaVersionsRaw: schemaVersionsRaw,
      wizardIntake: wizardIntakeResult.intake,
      wizardIntakeWarning: wizardIntakeResult.warning,
    );
  }

  static Future<ProjectState> loadFromDirectory(
    String projectDirectory, {
    Future<Uint8List> Function(File file)? eventsByteReader,
  }) async {
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
    final eventsBytes = await _readRequiredLocalFileBytes(
      trimmedDirectory,
      _eventsPath,
      byteReader: eventsByteReader,
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
      eventsBytes: eventsBytes,
      knownFactsRaw: knownFactsRaw,
      reportRaw: customerReportRaw,
      schemaVersionsRaw: schemaVersionsRaw,
      wizardIntake: wizardIntakeResult.intake,
      wizardIntakeWarning: wizardIntakeResult.warning,
    ).copyWith(projectDirectory: trimmedDirectory);
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
    } on ProjectLoadException {
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
    return utf8.decode(_fileContentAsBytes(file));
  }

  static Uint8List _fileContentAsBytes(ArchiveFile file) {
    final content = file.content;
    if (content is List<int>) {
      return Uint8List.fromList(content);
    }
    throw ProjectLoadException('Invalid file content in ZIP: ${file.name}');
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

  static Future<Uint8List> _readRequiredLocalFileBytes(
    String projectDirectory,
    String relativePath, {
    Future<Uint8List> Function(File file)? byteReader,
  }) async {
    final file = File(_joinPath(projectDirectory, relativePath));
    if (!await file.exists()) {
      throw ProjectLoadException(
        'Required file missing in project directory: $relativePath',
      );
    }

    try {
      return await (byteReader?.call(file) ?? file.readAsBytes());
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
    required Uint8List eventsBytes,
    required String knownFactsRaw,
    required String reportRaw,
    required String? schemaVersionsRaw,
    required WizardIntake? wizardIntake,
    required String? wizardIntakeWarning,
  }) {
    final manifest = ProjectManifest.fromJson(
      _decodeJsonObject(manifestRaw, _manifestPath),
    );
    final knownFactsJson = _decodeJsonObject(knownFactsRaw, _knownFactsPath);
    final knownFacts = KnownFacts.fromJson(knownFactsJson);
    final events = parseEvents(utf8.decode(eventsBytes));
    final projectionFreshness = _classifyProjectionFreshness(
      knownFactsJson,
      eventsBytes,
    );
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
      projectionFreshness: projectionFreshness,
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

  static ProjectionFreshness _classifyProjectionFreshness(
    Map<String, dynamic> knownFactsJson,
    Uint8List eventsBytes,
  ) {
    final provenance = knownFactsJson['projection_provenance'];
    if (provenance is! Map<String, dynamic>) {
      return ProjectionFreshness.unknown;
    }

    final version = provenance['projection_contract_version'];
    final expectedDigest = provenance['events_sha256'];
    if (version != '1.0' ||
        expectedDigest is! String ||
        !_lowercaseSha256.hasMatch(expectedDigest)) {
      return ProjectionFreshness.unknown;
    }

    final actualDigest = sha256.convert(eventsBytes).toString();
    return actualDigest == expectedDigest
        ? ProjectionFreshness.fresh
        : ProjectionFreshness.stale;
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
