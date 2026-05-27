import 'dart:convert';
import 'dart:io';

import 'package:trace_bench_viewer/shared/models/project_state.dart';
import 'package:trace_bench_viewer/shared/models/trace_bench_event.dart';

class MeasurementWriteException implements Exception {
  const MeasurementWriteException(this.message);

  final String message;

  @override
  String toString() => 'MeasurementWriteException: $message';
}

class MeasurementWriteRequest {
  const MeasurementWriteRequest({
    required this.value,
    required this.unit,
    required this.fromTarget,
    required this.toTarget,
    this.mode = 'continuity',
    this.actorType = 'user',
    this.actorId = 'flutter_operator',
    this.powerState = 'unknown',
  });

  final num? value;
  final String unit;
  final String fromTarget;
  final String toTarget;
  final String mode;
  final String actorType;
  final String actorId;
  final String powerState;
}

class MeasurementWriteResult {
  const MeasurementWriteResult({
    required this.updatedProjectState,
    required this.writtenEvent,
  });

  final ProjectState updatedProjectState;
  final TraceBenchEvent writtenEvent;
}

class MeasurementEventWriter {
  MeasurementEventWriter({
    String Function()? eventIdGenerator,
    String Function()? measurementIdGenerator,
    DateTime Function()? now,
  })  : _eventIdGenerator = eventIdGenerator,
        _measurementIdGenerator =
            measurementIdGenerator ?? _defaultMeasurementIdGenerator,
        _now = now ?? DateTime.now;

  static const String _eventsFileName = 'events.jsonl';
  static const String _createdAtPattern =
      r'^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(?:\.\d+)?Z$';
  static final RegExp _validEventIdPattern = RegExp(r'^evt_[0-9]{6}$');

  final String Function()? _eventIdGenerator;
  final String Function() _measurementIdGenerator;
  final DateTime Function() _now;

  static String _defaultMeasurementIdGenerator() {
    return 'M${DateTime.now().toUtc().millisecondsSinceEpoch}';
  }

  Future<MeasurementWriteResult> writeMeasurement({
    required ProjectState projectState,
    required MeasurementWriteRequest request,
  }) async {
    _validateRequest(request);
    final projectDirectory = projectState.projectDirectory;
    if (projectDirectory == null || projectDirectory.trim().isEmpty) {
      throw const MeasurementWriteException(
        'Project must be loaded from a local unpacked folder to append events.',
      );
    }

    final eventsFile = File('$projectDirectory/$_eventsFileName');
    final existing = await _loadExistingEvents(eventsFile);
    final sequence = _nextSequence(existing.sequences);
    final eventId = _generateUniqueEventId(
      existing.eventIds,
      sequence: sequence,
    );
    final measurementId = _generateMeasurementId(existing.measurementIds);

    final envelope = _buildMeasurementEvent(
      projectState: projectState,
      request: request,
      eventId: eventId,
      measurementId: measurementId,
      sequence: sequence,
      createdAt: _now().toUtc().toIso8601String(),
    );
    _validateEventEnvelope(envelope, eventIdSet: existing.eventIds);

    final encodedEvent = jsonEncode(envelope);
    final allLines = List<String>.from(existing.lines)..add(encodedEvent);
    await _appendLines(eventsFile, allLines);

    final writtenEvent = TraceBenchEvent.fromJson(envelope);
    final updatedEvents = List<TraceBenchEvent>.from(projectState.events)
      ..add(writtenEvent);
    final updatedProjectState = projectState.copyWith(
      projectDirectory: projectDirectory,
      isProjectionStale: true,
      events: updatedEvents,
    );

    return MeasurementWriteResult(
      updatedProjectState: updatedProjectState,
      writtenEvent: writtenEvent,
    );
  }

  Future<_ParsedEvents> _loadExistingEvents(File eventsFile) async {
    if (!await eventsFile.exists()) {
      return const _ParsedEvents(
        lines: <String>[],
        eventIds: <String>{},
        measurementIds: <String>{},
        sequences: <int>[],
      );
    }

    final raw = await eventsFile.readAsString();
    if (raw.trim().isEmpty) {
      return const _ParsedEvents(
        lines: <String>[],
        eventIds: <String>{},
        measurementIds: <String>{},
        sequences: <int>[],
      );
    }

    final lines = <String>[];
    final eventIds = <String>{};
    final measurementIds = <String>{};
    final sequences = <int>[];
    var lastSequence = 0;

    for (final rawLine in const LineSplitter().convert(raw)) {
      final normalized = rawLine.trimRight();
      if (normalized.isEmpty) {
        continue;
      }

      final decoded = _decodeEventLine(normalized);
      final sequence = decoded['sequence'];
      final eventId = decoded['event_id'];
      final payload = decoded['payload'];

      if (eventId is! String || eventId.trim().isEmpty) {
        throw const MeasurementWriteException(
          'Existing events must contain a valid event_id.',
        );
      }
      if (!eventIds.add(eventId)) {
        throw const MeasurementWriteException(
          'Existing events contain duplicate event_id values.',
        );
      }

      if (sequence is! int) {
        throw const MeasurementWriteException(
          'Existing events contain missing or non-integer sequence.',
        );
      }
      if (sequence <= 0) {
        throw const MeasurementWriteException(
          'Existing events contain non-positive sequence.',
        );
      }
      if (sequence <= lastSequence) {
        throw const MeasurementWriteException(
          'Existing events are not ordered by ascending sequence.',
        );
      }
      lastSequence = sequence;
      sequences.add(sequence);

      if (payload is Map<String, dynamic>) {
        final measurementId = payload['measurement_id'];
        if (measurementId is String && measurementId.trim().isNotEmpty) {
          measurementIds.add(measurementId.trim());
        }
      }

      lines.add(normalized);
    }

    return _ParsedEvents(
      lines: lines,
      eventIds: eventIds,
      measurementIds: measurementIds,
      sequences: sequences,
    );
  }

  Map<String, dynamic> _decodeEventLine(String rawLine) {
    try {
      final decoded = jsonDecode(rawLine);
      if (decoded is Map<String, dynamic>) {
        return decoded;
      }
      throw const MeasurementWriteException(
        'Existing event line is not a JSON object.',
      );
    } catch (error) {
      if (error is MeasurementWriteException) {
        rethrow;
      }
      throw const MeasurementWriteException(
        'Existing events contain invalid JSON.',
      );
    }
  }

  void _validateRequest(MeasurementWriteRequest request) {
    if (request.value == null) {
      throw const MeasurementWriteException('measurement value is required.');
    }
    if (!request.value!.isFinite) {
      throw const MeasurementWriteException(
          'measurement value must be finite.');
    }
    if (request.unit.trim().isEmpty) {
      throw const MeasurementWriteException('measurement unit is required.');
    }
    if (request.fromTarget.trim().isEmpty) {
      throw const MeasurementWriteException(
        'measurement target "from" is required.',
      );
    }
    if (request.toTarget.trim().isEmpty) {
      throw const MeasurementWriteException(
        'measurement target "to" is required.',
      );
    }
    if (request.actorType.trim().toLowerCase() == 'ai') {
      throw const MeasurementWriteException(
        'actor.type cannot be "ai" for measurement writes.',
      );
    }
    if (request.actorId.trim().isEmpty) {
      throw const MeasurementWriteException('actor.id is required.');
    }
  }

  int _nextSequence(List<int> sequences) {
    if (sequences.isEmpty) {
      return 1;
    }
    var max = 0;
    for (final sequence in sequences) {
      if (sequence > max) {
        max = sequence;
      }
    }
    return max + 1;
  }

  String _generateUniqueEventId(
    Set<String> existingEventIds, {
    required int sequence,
  }) {
    final injectedGenerator = _eventIdGenerator;
    if (injectedGenerator != null) {
      for (var attempt = 0; attempt < 25; attempt++) {
        final eventId = injectedGenerator().trim();
        if (!_validEventIdPattern.hasMatch(eventId)) {
          continue;
        }
        if (!existingEventIds.contains(eventId)) {
          return eventId;
        }
      }
    }

    var candidate = sequence;
    while (candidate <= 999999) {
      final eventId = 'evt_${candidate.toString().padLeft(6, '0')}';
      if (!existingEventIds.contains(eventId)) {
        return eventId;
      }
      candidate += 1;
    }
    throw const MeasurementWriteException(
      'Could not generate a unique schema-compatible event_id.',
    );
  }

  String _generateMeasurementId(Set<String> existingMeasurementIds) {
    for (var attempt = 0; attempt < 30; attempt++) {
      final candidate = _measurementIdGenerator().trim();
      final normalizedCandidate =
          candidate.startsWith('M') ? candidate : 'M$candidate';
      if (existingMeasurementIds.contains(normalizedCandidate)) {
        continue;
      }
      if (RegExp(r'^M[0-9]+$').hasMatch(normalizedCandidate)) {
        return normalizedCandidate;
      }
    }
    return 'M${DateTime.now().toUtc().millisecondsSinceEpoch}';
  }

  Map<String, dynamic> _buildMeasurementEvent({
    required ProjectState projectState,
    required MeasurementWriteRequest request,
    required String eventId,
    required String measurementId,
    required int sequence,
    required String createdAt,
  }) {
    return {
      'schema_version': projectState.manifest.schemaVersion,
      'event_id': eventId,
      'project_id': projectState.manifest.projectId,
      'sequence': sequence,
      'created_at': createdAt,
      'actor': {
        'type': request.actorType,
        'id': request.actorId,
      },
      'event_type': 'measurement_recorded',
      'status': 'accepted',
      'payload': {
        'measurement_id': measurementId,
        'mode': request.mode,
        'from': request.fromTarget.trim(),
        'to': request.toTarget.trim(),
        'reading': {
          'kind': 'numeric',
          'value': request.value!,
          'unit': request.unit.trim(),
        },
        'power_state': request.powerState,
      },
    };
  }

  void _validateEventEnvelope(
    Map<String, dynamic> event, {
    required Set<String> eventIdSet,
  }) {
    const requiredTopLevel = <String>[
      'schema_version',
      'event_id',
      'project_id',
      'sequence',
      'created_at',
      'actor',
      'event_type',
      'status',
      'payload',
    ];
    for (final field in requiredTopLevel) {
      if (!event.containsKey(field)) {
        throw const MeasurementWriteException(
          'Event envelope missing required field.',
        );
      }
    }

    final eventId = event['event_id'];
    if (eventId is! String || !_validEventIdPattern.hasMatch(eventId)) {
      throw const MeasurementWriteException('Event id format is invalid.');
    }
    if (eventIdSet.contains(eventId)) {
      throw const MeasurementWriteException('Event id is not unique.');
    }

    final createdAt = event['created_at'];
    if (createdAt is! String ||
        !RegExp(_createdAtPattern).hasMatch(createdAt) ||
        DateTime.tryParse(createdAt) == null) {
      throw const MeasurementWriteException(
        'created_at must be a valid timestamp.',
      );
    }

    final sequence = event['sequence'];
    if (sequence is! int || sequence <= 0) {
      throw const MeasurementWriteException(
        'sequence must be a positive integer.',
      );
    }

    final actor = event['actor'];
    if (actor is! Map<String, dynamic>) {
      throw const MeasurementWriteException('actor must be an object.');
    }
    if (actor['type'] is! String || actor['type'].toString().trim().isEmpty) {
      throw const MeasurementWriteException('actor.type must be present.');
    }
    if (actor['type'].toString().toLowerCase() == 'ai') {
      throw const MeasurementWriteException('actor.type cannot be "ai".');
    }
    if (actor['id'] is! String || actor['id'].toString().trim().isEmpty) {
      throw const MeasurementWriteException('actor.id must be present.');
    }

    if (event['event_type'] != 'measurement_recorded') {
      throw const MeasurementWriteException(
        'Only measurement_recorded events are writable in this pass.',
      );
    }

    final payload = event['payload'];
    if (payload is! Map<String, dynamic>) {
      throw const MeasurementWriteException('payload must be an object.');
    }
    final reading = payload['reading'];
    final readingMap = reading is Map<String, dynamic> ? reading : null;
    if (payload['measurement_id'] is! String ||
        payload['measurement_id'].toString().trim().isEmpty) {
      throw const MeasurementWriteException('measurement_id is required.');
    }
    if (payload['from'] == null ||
        payload['from'].toString().trim().isEmpty ||
        payload['to'] == null ||
        payload['to'].toString().trim().isEmpty) {
      throw const MeasurementWriteException(
          'both from/to targets are required.');
    }
    if (readingMap == null ||
        !readingMap.containsKey('value') ||
        !readingMap.containsKey('unit')) {
      throw const MeasurementWriteException(
        'reading.value and reading.unit are required.',
      );
    }
    if (readingMap['unit'] == null ||
        readingMap['unit'].toString().trim().isEmpty) {
      throw const MeasurementWriteException('measurement unit is required.');
    }
  }

  Future<void> _appendLines(File eventsFile, List<String> lines) async {
    await eventsFile.parent.create(recursive: true);

    final temp = File('${eventsFile.path}.tmp');
    final backup = File('${eventsFile.path}.bak');
    final output = '${lines.join('\n')}\n';
    final hadExisting = await eventsFile.exists();

    if (hadExisting) {
      if (await backup.exists()) {
        await backup.delete();
      }
      await eventsFile.copy(backup.path);
    }

    try {
      await temp.writeAsString(output, flush: true);
      if (hadExisting) {
        await eventsFile.delete();
      }
      await temp.rename(eventsFile.path);
      if (await backup.exists()) {
        await backup.delete();
      }
    } catch (error) {
      if (await backup.exists()) {
        if (await eventsFile.exists()) {
          await eventsFile.delete();
        }
        await backup.rename(eventsFile.path);
      }
      if (await temp.exists()) {
        await temp.delete();
      }
      throw MeasurementWriteException(
          'Failed to append measurement event: $error');
    }
  }
}

class _ParsedEvents {
  const _ParsedEvents({
    required this.lines,
    required this.eventIds,
    required this.measurementIds,
    required this.sequences,
  });

  final List<String> lines;
  final Set<String> eventIds;
  final Set<String> measurementIds;
  final List<int> sequences;
}
