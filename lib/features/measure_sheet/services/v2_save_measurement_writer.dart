import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/models/project_state.dart';
import '../../../shared/services/python_runner.dart';

final Provider<V2SaveMeasurementWriter> v2SaveMeasurementWriterProvider =
    Provider<V2SaveMeasurementWriter>((_) => V2SaveMeasurementService());

abstract class V2SaveMeasurementWriter {
  Future<V2SaveMeasurementResult> saveMeasurement({
    required ProjectState projectState,
    required V2SaveMeasurementRequest request,
  });
}

enum V2SaveMeasurementWriteStatus {
  appended,
  existing,
}

enum V2SaveMeasurementFailureKind {
  validation,
  append,
  lockConflict,
  pythonUnavailable,
  noProjectDirectory,
}

class V2SaveMeasurementException implements Exception {
  const V2SaveMeasurementException(this.kind, this.message);

  final V2SaveMeasurementFailureKind kind;
  final String message;

  @override
  String toString() => 'V2SaveMeasurementException: $message';
}

class V2SaveMeasurementRequest {
  const V2SaveMeasurementRequest({
    required this.value,
    required this.valueText,
    required this.displayValue,
    required this.unitLabel,
    required this.schemaUnit,
    required this.mode,
    required this.targetKey,
    required this.displayLabel,
    required this.componentId,
    required this.pinId,
    required this.valueProvenance,
    required this.clientOperationId,
    this.eventType = 'measurement_recorded',
    this.actorType = 'human',
    this.sourceType = 'explicit_user_confirmation',
    this.confirmed = true,
  });

  final Object value;
  final String valueText;
  final String displayValue;
  final String unitLabel;
  final String schemaUnit;
  final String mode;
  final String targetKey;
  final String displayLabel;
  final String? componentId;
  final String? pinId;
  final String valueProvenance;
  final String clientOperationId;
  final String eventType;
  final String actorType;
  final String sourceType;
  final bool confirmed;

  String get targetKind {
    if (componentId != null && pinId != null) {
      return 'component_pin';
    }
    if (componentId != null) {
      return 'component';
    }
    return 'unknown';
  }
}

class V2SaveMeasurementResult {
  const V2SaveMeasurementResult({
    required this.status,
    required this.event,
    required this.appended,
  });

  final V2SaveMeasurementWriteStatus status;
  final Map<String, dynamic> event;
  final bool appended;
}

class V2SaveMeasurementService implements V2SaveMeasurementWriter {
  V2SaveMeasurementService({
    PythonRunner? pythonRunner,
    ProcessRunner? processRunner,
    PlatformInfo? platformInfo,
    String? repoRootPath,
    DateTime Function()? now,
    String Function()? eventIdGenerator,
    String Function()? measurementIdGenerator,
  })  : _pythonRunner = pythonRunner ??
            PythonRunner(
              processRunner: processRunner,
              platformInfo: platformInfo,
              repoRootPath: repoRootPath,
            ),
        _now = now ?? DateTime.now,
        _eventIdGenerator = eventIdGenerator,
        _measurementIdGenerator = measurementIdGenerator;

  static const String _schemaVersion = '2.0-draft';
  static const String _measurementRecordedEventType = 'measurement_recorded';
  static const String _eventsFileName = 'events.jsonl';
  static final RegExp _eventIdPattern = RegExp(r'^evt_([0-9]{6})$');
  static final RegExp _measurementIdPattern = RegExp(r'^M([0-9]+)$');

  final PythonRunner _pythonRunner;
  final DateTime Function() _now;
  final String Function()? _eventIdGenerator;
  final String Function()? _measurementIdGenerator;

  @override
  Future<V2SaveMeasurementResult> saveMeasurement({
    required ProjectState projectState,
    required V2SaveMeasurementRequest request,
  }) async {
    final projectDirectory = projectState.projectDirectory;
    if (projectDirectory == null || projectDirectory.trim().isEmpty) {
      throw const V2SaveMeasurementException(
        V2SaveMeasurementFailureKind.noProjectDirectory,
        'Project must be loaded from a local folder before saving.',
      );
    }

    final python = await _discoverPython();
    if (python == null) {
      throw const V2SaveMeasurementException(
        V2SaveMeasurementFailureKind.pythonUnavailable,
        'Python runtime is required for the accepted event writer service.',
      );
    }

    final timestamp = _now().toUtc().toIso8601String();
    final eventsPath = _joinPath(projectDirectory, _eventsFileName);
    final candidate = _buildCandidateEvent(
      projectState: projectState,
      request: request,
      eventId: _eventIdGenerator?.call() ?? _nextEventId(projectState),
      measurementId:
          _measurementIdGenerator?.call() ?? _nextMeasurementId(projectState),
      timestamp: timestamp,
    );

    final tempDir =
        await Directory.systemTemp.createTemp('tracebench-v2-event-');
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
      return V2SaveMeasurementResult(
        status: status,
        event: writtenEvent,
        appended: status == V2SaveMeasurementWriteStatus.appended,
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
    required V2SaveMeasurementRequest request,
    required String eventId,
    required String measurementId,
    required String timestamp,
  }) {
    return <String, dynamic>{
      'schema_version': _schemaVersion,
      'event_id': eventId,
      'event_type': _measurementRecordedEventType,
      'created_at': timestamp,
      'project_id': projectState.manifest.projectId,
      'client_operation_id': request.clientOperationId,
      'actor': const <String, dynamic>{
        'type': 'human',
        'id': 'local_operator',
      },
      'source': const <String, dynamic>{
        'type': 'explicit_user_confirmation',
        'surface': 'measure_sheet',
        'action': 'save_measurement',
      },
      'confirmation': <String, dynamic>{
        'confirmed': true,
        'confirmed_at': timestamp,
      },
      'payload': <String, dynamic>{
        'measurement_id': measurementId,
        'measured_at': timestamp,
        'target': _targetPayload(request),
        'reading': <String, dynamic>{
          'mode': request.mode,
          'value': request.value,
          'unit': request.schemaUnit,
          'display_value': request.displayValue,
        },
        'value_provenance': const <String, dynamic>{
          'measured_value_source': 'human_entered',
          'context_values_visible': <Map<String, dynamic>>[
            <String, dynamic>{
              'context_type': 'reference_value',
              'used_as_measured_value': false,
            },
            <String, dynamic>{
              'context_type': 'candidate_value',
              'used_as_measured_value': false,
            },
            <String, dynamic>{
              'context_type': 'helper_suggestion',
              'used_as_measured_value': false,
            },
          ],
        },
      },
    };
  }

  Map<String, dynamic> _targetPayload(V2SaveMeasurementRequest request) {
    return <String, dynamic>{
      'target_kind': request.targetKind,
      'target_key': request.targetKey,
      'display_label': request.displayLabel,
      if (request.componentId != null) 'component_id': request.componentId,
      if (request.pinId != null) 'pin_id': request.pinId,
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

  String _nextMeasurementId(ProjectState projectState) {
    final injected = _measurementIdGenerator;
    if (injected != null) {
      return injected();
    }
    var max = 0;
    for (final measurement in projectState.knownFacts.measurements) {
      final match = _measurementIdPattern.firstMatch(measurement.measurementId);
      if (match == null) {
        continue;
      }
      final value = int.tryParse(match.group(1)!);
      if (value != null && value > max) {
        max = value;
      }
    }
    for (final event in projectState.events) {
      final measurementId = event.payload['measurement_id'];
      if (measurementId is! String) {
        continue;
      }
      final match = _measurementIdPattern.firstMatch(measurementId);
      if (match == null) {
        continue;
      }
      final value = int.tryParse(match.group(1)!);
      if (value != null && value > max) {
        max = value;
      }
    }
    return 'M${max + 1}';
  }

  V2SaveMeasurementWriteStatus _statusFromStdout(String stdout) {
    if (stdout.contains('[OK] existing')) {
      return V2SaveMeasurementWriteStatus.existing;
    }
    return V2SaveMeasurementWriteStatus.appended;
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

  V2SaveMeasurementException _exceptionForFailure(String detail) {
    final normalized = detail.toLowerCase();
    if (normalized.contains('lock is already held') ||
        normalized.contains('lock conflict')) {
      return V2SaveMeasurementException(
        V2SaveMeasurementFailureKind.lockConflict,
        detail,
      );
    }
    if (normalized.contains('append') || normalized.contains('readback')) {
      return V2SaveMeasurementException(
        V2SaveMeasurementFailureKind.append,
        detail,
      );
    }
    return V2SaveMeasurementException(
      V2SaveMeasurementFailureKind.validation,
      detail,
    );
  }

  String _combinedOutput(ProcessResult result) {
    final combined = '${result.stdout}\n${result.stderr}'.trim();
    return combined.isEmpty ? 'event writer service failed' : combined;
  }

  String _joinPath(String base, String child) {
    if (base.endsWith('/') || base.endsWith('\\')) {
      return '$base$child';
    }
    return '$base${Platform.pathSeparator}$child';
  }
}
