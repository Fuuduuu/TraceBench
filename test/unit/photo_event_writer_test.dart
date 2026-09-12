import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:trace_bench_viewer/features/photos/logic/photo_alignment_transform.dart';
import 'package:trace_bench_viewer/features/photos/services/photo_event_writer.dart';
import 'package:trace_bench_viewer/shared/models/known_facts.dart';
import 'package:trace_bench_viewer/shared/models/project_manifest.dart';
import 'package:trace_bench_viewer/shared/models/project_state.dart';
import 'package:trace_bench_viewer/shared/models/trace_bench_event.dart';
import 'package:trace_bench_viewer/shared/services/python_runner.dart';

typedef _ProcessHandler = FutureOr<ProcessResult> Function(
  List<String> command,
  Map<String, dynamic>? candidate,
);

class _FakeProcessRunner extends ProcessRunner {
  _FakeProcessRunner(this.handler);

  final _ProcessHandler handler;
  final List<List<String>> calls = <List<String>>[];
  final List<Map<String, dynamic>> candidates = <Map<String, dynamic>>[];

  @override
  Future<ProcessResult> run({
    required List<String> command,
    required String workingDirectory,
    required Duration timeout,
  }) async {
    calls.add(List<String>.from(command));
    Map<String, dynamic>? candidate;
    if (command.any((part) => part.endsWith('event_writer_service.py'))) {
      candidate = Map<String, dynamic>.from(
        jsonDecode(await File(command.last).readAsString()) as Map,
      );
      candidates.add(candidate);
    }
    return await handler(command, candidate);
  }
}

TraceBenchEvent _event({
  String eventId = 'evt_000001',
  int sequence = 1,
  String schemaVersion = '1.0',
  String eventType = 'project_created',
  Map<String, dynamic> payload = const <String, dynamic>{'name': 'Project'},
}) {
  return TraceBenchEvent(
    schemaVersion: schemaVersion,
    eventId: eventId,
    projectId: 'prj_photo_writer',
    sequence: sequence,
    createdAt: '2026-08-26T09:00:00Z',
    actor: const <String, dynamic>{'type': 'user', 'id': 'tester'},
    eventType: eventType,
    status: 'accepted',
    payload: payload,
  );
}

ProjectState _projectState(
  Directory directory, {
  List<TraceBenchEvent>? events,
  String? projectDirectory,
  bool directoryBacked = true,
}) {
  return ProjectState(
    manifest: const ProjectManifest(
      projectId: 'prj_photo_writer',
      schemaVersion: '1.0',
      createdAt: '2026-08-26T09:00:00Z',
      deviceType: 'board',
      model: 'test',
      symptom: 'test',
    ),
    knownFacts: KnownFacts.fromJson(<String, dynamic>{
      'project_id': 'prj_photo_writer',
      'components': const <dynamic>[],
      'pins': const <dynamic>[],
      'measurements': const <dynamic>[],
      'component_pin_index': const <String, dynamic>{},
    }),
    events: events ?? <TraceBenchEvent>[_event()],
    customerReport: '',
    projectDirectory:
        directoryBacked ? projectDirectory ?? directory.path : null,
  );
}

PhotoEventWriteRequest _request({
  String photoId = 'photo_import_001',
  String layer = 'top',
}) {
  return PhotoEventWriteRequest(
    photoId: photoId,
    mode: 'backlight',
    path: 'photos/$photoId.jpeg',
    sha256: '0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef',
    layer: layer,
  );
}

TraceBenchEvent _photoAddedEvent({
  String eventId = 'evt_000001',
  int sequence = 1,
  String photoId = 'photo_alignment_source',
  String? path,
  String? sha256,
}) {
  return _event(
    eventId: eventId,
    sequence: sequence,
    eventType: 'photo_added',
    payload: <String, dynamic>{
      'photo_id': photoId,
      'mode': 'normal',
      'path': path ?? 'photos/$photoId.jpg',
      if (sha256 != null) 'sha256': sha256,
    },
  );
}

PrimaryPhotoEventWriteRequest _primaryRequest({
  String path = 'photos/wizard_background.png',
  String sha256 =
      '0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef',
}) {
  return PrimaryPhotoEventWriteRequest(path: path, sha256: sha256);
}

PhotoAlignmentEventWriteRequest _alignmentRequest({
  String sourcePhotoId = 'photo_alignment_source',
  String boardSide = 'top',
  PhotoAlignmentTransformType transformType =
      PhotoAlignmentTransformType.similarity,
  List<PhotoAlignmentPoint>? photoPoints,
  List<PhotoAlignmentPoint>? boardPoints,
  double photoWidth = 400,
  double photoHeight = 300,
}) {
  return PhotoAlignmentEventWriteRequest(
    sourcePhotoId: sourcePhotoId,
    boardSide: boardSide,
    transformType: transformType,
    photoPoints: photoPoints ??
        const <PhotoAlignmentPoint>[
          PhotoAlignmentPoint(x: 10, y: 20),
          PhotoAlignmentPoint(x: 210, y: 20),
        ],
    boardPoints: boardPoints ??
        const <PhotoAlignmentPoint>[
          PhotoAlignmentPoint(x: 0.1, y: 0.2),
          PhotoAlignmentPoint(x: 0.7, y: 0.2),
        ],
    photoWidth: photoWidth,
    photoHeight: photoHeight,
  );
}

Future<void> _writeExistingEvents(
  Directory directory,
  Iterable<TraceBenchEvent> events,
) async {
  final text = events.map((event) => jsonEncode(event.toJson())).join('\n');
  await File('${directory.path}${Platform.pathSeparator}events.jsonl')
      .writeAsString(text.isEmpty ? '' : '$text\n', flush: true);
}

Future<void> _appendCandidate(
  List<String> command,
  Map<String, dynamic> candidate,
) async {
  final eventsFile = File(command[command.length - 2]);
  await eventsFile.writeAsString(
    '${jsonEncode(candidate)}\n',
    mode: FileMode.append,
    flush: true,
  );
}

bool _isWriterCommand(List<String> command) =>
    command.any((part) => part.endsWith('event_writer_service.py'));

void main() {
  group('PhotoEventWriterService', () {
    test('writes the exact accepted V1 photo_added envelope and reads it back',
        () async {
      final directory =
          await Directory.systemTemp.createTemp('tracebench-photo-writer-');
      addTearDown(() => directory.delete(recursive: true));
      final state = _projectState(directory);
      await _writeExistingEvents(directory, state.events);
      final runner = _FakeProcessRunner((command, candidate) async {
        if (!_isWriterCommand(command)) {
          return ProcessResult(1, 0, 'Python 3.12.0', '');
        }
        await _appendCandidate(command, candidate!);
        return ProcessResult(1, 0, '[OK] appended: evt_000002', '');
      });
      final writer = PhotoEventWriterService(
        processRunner: runner,
        repoRootPath: Directory.current.path,
        now: () => DateTime.utc(2026, 8, 26, 10, 30),
      );

      final result = await writer.writePhotoAdded(
        projectState: state,
        request: _request(),
      );

      expect(result.status, PhotoEventWriteStatus.appended);
      expect(result.durability, PhotoEventDurability.durable);
      expect(runner.candidates, hasLength(1));
      final candidate = runner.candidates.single;
      expect(candidate.keys, <String>[
        'schema_version',
        'event_id',
        'project_id',
        'sequence',
        'created_at',
        'actor',
        'event_type',
        'status',
        'payload',
      ]);
      expect(candidate['schema_version'], '1.0');
      expect(candidate['event_id'], 'evt_000002');
      expect(candidate['project_id'], 'prj_photo_writer');
      expect(candidate['sequence'], 2);
      expect(candidate['created_at'], '2026-08-26T10:30:00.000Z');
      expect(candidate['actor'], <String, dynamic>{
        'type': 'user',
        'id': 'local_operator',
      });
      expect(candidate['event_type'], 'photo_added');
      expect(candidate['status'], 'accepted');
      expect(candidate['payload'], <String, dynamic>{
        'photo_id': 'photo_import_001',
        'mode': 'backlight',
        'path': 'photos/photo_import_001.jpeg',
        'sha256':
            '0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef',
        'layer': 'top',
      });
      expect(result.event, candidate);
      final writerCommand = runner.calls.singleWhere(_isWriterCommand);
      expect(writerCommand, contains('tools/event_writer_service.py'));
      expect(
        writerCommand[writerCommand.length - 2],
        '${directory.resolveSymbolicLinksSync()}${Platform.pathSeparator}events.jsonl',
      );
    });

    test('allocates independent next V1 sequence and global event ID',
        () async {
      final directory =
          await Directory.systemTemp.createTemp('tracebench-photo-writer-');
      addTearDown(() => directory.delete(recursive: true));
      final events = <TraceBenchEvent>[
        _event(eventId: 'evt_000004', sequence: 7),
        _event(
          eventId: 'evt_000009',
          sequence: 0,
          schemaVersion: '2.0-draft',
          eventType: 'component_created',
        ),
      ];
      final state = _projectState(directory, events: events);
      await _writeExistingEvents(directory, events);
      final runner = _FakeProcessRunner((command, candidate) async {
        if (!_isWriterCommand(command)) {
          return ProcessResult(2, 0, 'Python 3.12.0', '');
        }
        await _appendCandidate(command, candidate!);
        return ProcessResult(2, 0, '[OK] appended: evt_000010', '');
      });

      await PhotoEventWriterService(
        processRunner: runner,
        repoRootPath: Directory.current.path,
      ).writePhotoAdded(projectState: state, request: _request());

      expect(runner.candidates.single['event_id'], 'evt_000010');
      expect(runner.candidates.single['sequence'], 8);
    });

    test('rejects malformed or colliding V1 event history before Python',
        () async {
      final directory =
          await Directory.systemTemp.createTemp('tracebench-photo-writer-');
      addTearDown(() => directory.delete(recursive: true));
      final runner = _FakeProcessRunner(
        (command, candidate) => ProcessResult(3, 0, 'Python 3.12.0', ''),
      );
      final cases = <String, List<TraceBenchEvent>>{
        'malformed id': <TraceBenchEvent>[_event(eventId: 'event_bad')],
        'duplicate id': <TraceBenchEvent>[
          _event(),
          _event(sequence: 2),
        ],
        'non-positive sequence': <TraceBenchEvent>[_event(sequence: 0)],
        'duplicate sequence': <TraceBenchEvent>[
          _event(),
          _event(eventId: 'evt_000002'),
        ],
      };

      for (final entry in cases.entries) {
        await expectLater(
          PhotoEventWriterService(
            processRunner: runner,
            repoRootPath: Directory.current.path,
          ).writePhotoAdded(
            projectState: _projectState(directory, events: entry.value),
            request: _request(),
          ),
          throwsA(
            isA<PhotoEventWriteException>()
                .having(
                  (error) => error.kind,
                  '${entry.key} kind',
                  PhotoEventWriteFailureKind.invalidEventHistory,
                )
                .having(
                  (error) => error.durability,
                  '${entry.key} durability',
                  PhotoEventDurability.provenNoEvent,
                ),
          ),
        );
      }
      expect(runner.calls, isEmpty);
    });

    test('rejects a reused supplied photo ID before writer invocation',
        () async {
      final directory =
          await Directory.systemTemp.createTemp('tracebench-photo-writer-');
      addTearDown(() => directory.delete(recursive: true));
      final existingPhoto = _event(
        eventType: 'photo_added',
        payload: const <String, dynamic>{
          'photo_id': 'photo_import_001',
          'mode': 'normal',
          'path': 'photos/existing.jpg',
        },
      );
      final runner = _FakeProcessRunner(
        (command, candidate) => ProcessResult(4, 0, 'Python 3.12.0', ''),
      );

      await expectLater(
        PhotoEventWriterService(
          processRunner: runner,
          repoRootPath: Directory.current.path,
        ).writePhotoAdded(
          projectState: _projectState(directory, events: <TraceBenchEvent>[
            existingPhoto,
          ]),
          request: _request(),
        ),
        throwsA(
          isA<PhotoEventWriteException>().having(
            (error) => error.kind,
            'kind',
            PhotoEventWriteFailureKind.validation,
          ),
        ),
      );
      expect(runner.calls, isEmpty);
    });

    test('classifies completed lock failure with absent event as proven none',
        () async {
      final directory =
          await Directory.systemTemp.createTemp('tracebench-photo-writer-');
      addTearDown(() => directory.delete(recursive: true));
      final state = _projectState(directory);
      await _writeExistingEvents(directory, state.events);
      final runner = _FakeProcessRunner((command, candidate) {
        if (!_isWriterCommand(command)) {
          return ProcessResult(5, 0, 'Python 3.12.0', '');
        }
        return ProcessResult(
          5,
          1,
          '',
          '[ERROR] event writer lock is already held',
        );
      });

      await expectLater(
        PhotoEventWriterService(
          processRunner: runner,
          repoRootPath: Directory.current.path,
        ).writePhotoAdded(projectState: state, request: _request()),
        throwsA(
          isA<PhotoEventWriteException>()
              .having(
                (error) => error.kind,
                'kind',
                PhotoEventWriteFailureKind.lockConflict,
              )
              .having(
                (error) => error.durability,
                'durability',
                PhotoEventDurability.provenNoEvent,
              ),
        ),
      );
    });

    test('returns exact durable event even when process reports readback error',
        () async {
      final directory =
          await Directory.systemTemp.createTemp('tracebench-photo-writer-');
      addTearDown(() => directory.delete(recursive: true));
      final state = _projectState(directory);
      await _writeExistingEvents(directory, state.events);
      final runner = _FakeProcessRunner((command, candidate) async {
        if (!_isWriterCommand(command)) {
          return ProcessResult(6, 0, 'Python 3.12.0', '');
        }
        await _appendCandidate(command, candidate!);
        return ProcessResult(6, 1, '', '[ERROR] readback validation failed');
      });

      final result = await PhotoEventWriterService(
        processRunner: runner,
        repoRootPath: Directory.current.path,
      ).writePhotoAdded(projectState: state, request: _request());

      expect(result.status, PhotoEventWriteStatus.recoveredDurable);
      expect(result.durability, PhotoEventDurability.durable);
      expect(result.event, runner.candidates.single);
    });

    test('classifies launched command uncertainty and missing Python safely',
        () async {
      final directory =
          await Directory.systemTemp.createTemp('tracebench-photo-writer-');
      addTearDown(() => directory.delete(recursive: true));
      final state = _projectState(directory);
      await _writeExistingEvents(directory, state.events);
      final uncertainRunner = _FakeProcessRunner((command, candidate) {
        if (!_isWriterCommand(command)) {
          return ProcessResult(7, 0, 'Python 3.12.0', '');
        }
        throw TimeoutException('writer timed out');
      });

      await expectLater(
        PhotoEventWriterService(
          processRunner: uncertainRunner,
          repoRootPath: Directory.current.path,
        ).writePhotoAdded(projectState: state, request: _request()),
        throwsA(
          isA<PhotoEventWriteException>().having(
            (error) => error.durability,
            'durability',
            PhotoEventDurability.uncertain,
          ),
        ),
      );

      final unavailableRunner = _FakeProcessRunner(
        (command, candidate) => ProcessResult(8, 1, '', 'missing'),
      );
      await expectLater(
        PhotoEventWriterService(
          processRunner: unavailableRunner,
          repoRootPath: Directory.current.path,
        ).writePhotoAdded(projectState: state, request: _request()),
        throwsA(
          isA<PhotoEventWriteException>()
              .having(
                (error) => error.kind,
                'kind',
                PhotoEventWriteFailureKind.pythonUnavailable,
              )
              .having(
                (error) => error.durability,
                'durability',
                PhotoEventDurability.provenNoEvent,
              ),
        ),
      );
    });

    test('rejects missing or invalid project directories before Python',
        () async {
      final directory =
          await Directory.systemTemp.createTemp('tracebench-photo-writer-');
      addTearDown(() => directory.delete(recursive: true));
      final runner = _FakeProcessRunner(
        (command, candidate) => ProcessResult(9, 0, 'Python 3.12.0', ''),
      );
      final writer = PhotoEventWriterService(
        processRunner: runner,
        repoRootPath: Directory.current.path,
      );

      await expectLater(
        writer.writePhotoAdded(
          projectState: _projectState(directory, directoryBacked: false),
          request: _request(),
        ),
        throwsA(
          isA<PhotoEventWriteException>().having(
            (error) => error.kind,
            'missing kind',
            PhotoEventWriteFailureKind.noProjectDirectory,
          ),
        ),
      );
      await expectLater(
        writer.writePhotoAdded(
          projectState: _projectState(
            directory,
            projectDirectory:
                '${directory.path}${Platform.pathSeparator}missing',
          ),
          request: _request(),
        ),
        throwsA(
          isA<PhotoEventWriteException>()
              .having(
                (error) => error.kind,
                'invalid kind',
                PhotoEventWriteFailureKind.invalidProjectDirectory,
              )
              .having(
                (error) => error.durability,
                'durability',
                PhotoEventDurability.provenNoEvent,
              ),
        ),
      );
      expect(runner.calls, isEmpty);
    });
  });

  group('PrimaryPhotoEventWriter', () {
    test('appends exact existing-file primary photo envelope with no layer',
        () async {
      final directory =
          await Directory.systemTemp.createTemp('tracebench-primary-writer-');
      addTearDown(() => directory.delete(recursive: true));
      final state = _projectState(directory);
      await _writeExistingEvents(directory, state.events);
      final runner = _FakeProcessRunner((command, candidate) async {
        if (!_isWriterCommand(command)) {
          return ProcessResult(20, 0, 'Python 3.12.0', '');
        }
        await _appendCandidate(command, candidate!);
        return ProcessResult(20, 0, '[OK] appended: evt_000002', '');
      });

      final result = await PhotoEventWriterService(
        processRunner: runner,
        repoRootPath: Directory.current.path,
        now: () => DateTime.utc(2026, 8, 29, 12),
      ).ensurePrimaryPhotoAdded(
        projectState: state,
        request: _primaryRequest(),
      );

      expect(result.status, PhotoEventWriteStatus.appended);
      expect(result.durability, PhotoEventDurability.durable);
      expect(runner.candidates, hasLength(1));
      final candidate = runner.candidates.single;
      expect(candidate['event_id'], 'evt_000002');
      expect(candidate['sequence'], 2);
      expect(candidate['event_type'], 'photo_added');
      expect(candidate['payload'], <String, dynamic>{
        'photo_id': 'photo_primary_001',
        'mode': 'normal',
        'path': 'photos/wizard_background.png',
        'sha256':
            '0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef',
      });
      expect(result.event, candidate);
    });

    test(
        'allocates primary photo and envelope IDs from reconciled live history',
        () async {
      final directory =
          await Directory.systemTemp.createTemp('tracebench-primary-writer-');
      addTearDown(() => directory.delete(recursive: true));
      final staleState = _projectState(directory);
      final durableEvents = <TraceBenchEvent>[
        _event(eventId: 'evt_000003', sequence: 3),
        _photoAddedEvent(
          eventId: 'evt_000010',
          sequence: 7,
          photoId: 'photo_primary_001',
          path: 'photos/older_primary.png',
          sha256:
              'ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff',
        ),
      ];
      await _writeExistingEvents(directory, durableEvents);
      final runner = _FakeProcessRunner((command, candidate) async {
        if (!_isWriterCommand(command)) {
          return ProcessResult(23, 0, 'Python 3.12.0', '');
        }
        await _appendCandidate(command, candidate!);
        return ProcessResult(23, 0, '[OK] appended: evt_000011', '');
      });

      final result = await PhotoEventWriterService(
        processRunner: runner,
        repoRootPath: Directory.current.path,
      ).ensurePrimaryPhotoAdded(
        projectState: staleState,
        request: _primaryRequest(),
      );

      expect(result.status, PhotoEventWriteStatus.appended);
      expect(result.event['event_id'], 'evt_000011');
      expect(result.event['sequence'], 8);
      expect(
        (result.event['payload'] as Map)['photo_id'],
        'photo_primary_002',
      );
    });

    test('reconciles durable history and reuses lowest matching sequence',
        () async {
      final directory =
          await Directory.systemTemp.createTemp('tracebench-primary-writer-');
      addTearDown(() => directory.delete(recursive: true));
      const sha =
          '0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef';
      final staleState = _projectState(directory);
      final durableEvents = <TraceBenchEvent>[
        ...staleState.events,
        _photoAddedEvent(
          eventId: 'evt_000004',
          sequence: 4,
          photoId: 'photo_primary_later',
          path: 'photos/wizard_background.png',
          sha256: sha,
        ),
        _photoAddedEvent(
          eventId: 'evt_000002',
          sequence: 2,
          photoId: 'photo_primary_first',
          path: 'photos/wizard_background.png',
          sha256: sha.toUpperCase(),
        ),
        _photoAddedEvent(
          eventId: 'evt_000003',
          sequence: 3,
          photoId: 'photo_primary_stale_bytes',
          path: 'photos/wizard_background.png',
          sha256:
              'ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff',
        ),
      ];
      await _writeExistingEvents(directory, durableEvents);
      final runner = _FakeProcessRunner(
        (command, candidate) => ProcessResult(21, 0, 'Python 3.12.0', ''),
      );

      final result = await PhotoEventWriterService(
        processRunner: runner,
        repoRootPath: Directory.current.path,
      ).ensurePrimaryPhotoAdded(
        projectState: staleState,
        request: _primaryRequest(),
      );

      expect(result.status, PhotoEventWriteStatus.reusedDurable);
      expect(result.durability, PhotoEventDurability.durable);
      expect(
          (result.event['payload'] as Map)['photo_id'], 'photo_primary_first');
      expect(result.event['sequence'], 2);
      expect(runner.calls, isEmpty);
    });

    test('retry after uncertain outcome reuses a now-durable primary event',
        () async {
      final directory =
          await Directory.systemTemp.createTemp('tracebench-primary-writer-');
      addTearDown(() => directory.delete(recursive: true));
      final state = _projectState(directory);
      await _writeExistingEvents(directory, state.events);
      final runner = _FakeProcessRunner((command, candidate) {
        if (!_isWriterCommand(command)) {
          return ProcessResult(22, 0, 'Python 3.12.0', '');
        }
        throw ProcessException(
          'python',
          command,
          'writer completion was not observable',
        );
      });
      final writer = PhotoEventWriterService(
        processRunner: runner,
        repoRootPath: Directory.current.path,
      );

      await expectLater(
        writer.ensurePrimaryPhotoAdded(
          projectState: state,
          request: _primaryRequest(),
        ),
        throwsA(
          isA<PhotoEventWriteException>()
              .having(
                (error) => error.durability,
                'durability',
                PhotoEventDurability.uncertain,
              )
              .having(
                (error) => error.kind,
                'kind',
                PhotoEventWriteFailureKind.append,
              ),
        ),
      );
      expect(runner.candidates, hasLength(1));
      final uncertainCandidate = runner.candidates.single;
      await File(
        '${directory.path}${Platform.pathSeparator}events.jsonl',
      ).writeAsString(
        '${jsonEncode(uncertainCandidate)}\n',
        mode: FileMode.append,
        flush: true,
      );

      final retry = await writer.ensurePrimaryPhotoAdded(
        projectState: state,
        request: _primaryRequest(),
      );

      expect(retry.status, PhotoEventWriteStatus.reusedDurable);
      expect(retry.event, uncertainCandidate);
      expect(runner.candidates, hasLength(1));
    });
  });

  group('PhotoAlignmentEventWriter', () {
    test('writes exact accepted V1 alignment envelope and fixed quality label',
        () async {
      final directory =
          await Directory.systemTemp.createTemp('tracebench-alignment-writer-');
      addTearDown(() => directory.delete(recursive: true));
      final photo = _photoAddedEvent();
      final state = _projectState(directory, events: <TraceBenchEvent>[photo]);
      await _writeExistingEvents(directory, state.events);
      final runner = _FakeProcessRunner((command, candidate) async {
        if (!_isWriterCommand(command)) {
          return ProcessResult(10, 0, 'Python 3.12.0', '');
        }
        await _appendCandidate(command, candidate!);
        return ProcessResult(10, 0, '[OK] appended: evt_000002', '');
      });

      final result = await PhotoEventWriterService(
        processRunner: runner,
        repoRootPath: Directory.current.path,
        now: () => DateTime.utc(2026, 8, 28, 9, 15),
      ).confirmAlignment(
        projectState: state,
        request: _alignmentRequest(),
      );

      expect(result.status, PhotoEventWriteStatus.appended);
      expect(result.durability, PhotoEventDurability.durable);
      final candidate = runner.candidates.single;
      expect(candidate['event_id'], 'evt_000002');
      expect(candidate['sequence'], 2);
      expect(candidate['event_type'], 'photo_to_board_alignment_confirmed');
      expect(candidate['actor'], <String, dynamic>{
        'type': 'user',
        'id': 'local_operator',
      });
      expect(candidate['status'], 'accepted');
      expect(candidate['payload'], <String, dynamic>{
        'alignment_id': 'ALN1',
        'source_photo_id': 'photo_alignment_source',
        'board_side': 'top',
        'coordinate_space_from': 'photo_local',
        'coordinate_space_to': 'board_normalized',
        'reference_points_photo': <Map<String, double>>[
          <String, double>{'x': 10, 'y': 20},
          <String, double>{'x': 210, 'y': 20},
        ],
        'reference_points_board': <Map<String, double>>[
          <String, double>{'x': 0.1, 'y': 0.2},
          <String, double>{'x': 0.7, 'y': 0.2},
        ],
        'transform_type': 'similarity',
        'alignment_quality_label': 'manual_preview_confirmed',
      });
      expect(result.event, candidate);
    });

    test('alignment allocation and source validation use reconciled durability',
        () async {
      final directory =
          await Directory.systemTemp.createTemp('tracebench-alignment-writer-');
      addTearDown(() => directory.delete(recursive: true));
      final staleState = _projectState(directory);
      final durableEvents = <TraceBenchEvent>[
        ...staleState.events,
        _photoAddedEvent(eventId: 'evt_000004', sequence: 7),
      ];
      await _writeExistingEvents(directory, durableEvents);
      final runner = _FakeProcessRunner((command, candidate) async {
        if (!_isWriterCommand(command)) {
          return ProcessResult(23, 0, 'Python 3.12.0', '');
        }
        await _appendCandidate(command, candidate!);
        return ProcessResult(23, 0, '[OK] appended: evt_000005', '');
      });

      final result = await PhotoEventWriterService(
        processRunner: runner,
        repoRootPath: Directory.current.path,
      ).confirmAlignment(
        projectState: staleState,
        request: _alignmentRequest(),
      );

      expect(result.status, PhotoEventWriteStatus.appended);
      expect(runner.candidates.single['event_id'], 'evt_000005');
      expect(runner.candidates.single['sequence'], 8);
      expect(
        (runner.candidates.single['payload'] as Map)['source_photo_id'],
        'photo_alignment_source',
      );
    });

    test('allocates alignment IDs independently from event IDs and sequences',
        () async {
      final directory =
          await Directory.systemTemp.createTemp('tracebench-alignment-writer-');
      addTearDown(() => directory.delete(recursive: true));
      final events = <TraceBenchEvent>[
        _photoAddedEvent(eventId: 'evt_000004', sequence: 7),
        _event(
          eventId: 'evt_000009',
          sequence: 8,
          eventType: 'photo_to_board_alignment_confirmed',
          payload: const <String, dynamic>{
            'alignment_id': 'ALN9',
            'source_photo_id': 'photo_alignment_source',
          },
        ),
      ];
      final state = _projectState(directory, events: events);
      await _writeExistingEvents(directory, events);
      final runner = _FakeProcessRunner((command, candidate) async {
        if (!_isWriterCommand(command)) {
          return ProcessResult(11, 0, 'Python 3.12.0', '');
        }
        await _appendCandidate(command, candidate!);
        return ProcessResult(11, 0, '[OK] appended: evt_000010', '');
      });

      await PhotoEventWriterService(
        processRunner: runner,
        repoRootPath: Directory.current.path,
      ).confirmAlignment(
        projectState: state,
        request: _alignmentRequest(),
      );

      expect(runner.candidates.single['event_id'], 'evt_000010');
      expect(runner.candidates.single['sequence'], 9);
      expect(
        (runner.candidates.single['payload'] as Map)['alignment_id'],
        'ALN10',
      );
    });

    test('accepts the canonical unknown board side', () async {
      final directory =
          await Directory.systemTemp.createTemp('tracebench-alignment-writer-');
      addTearDown(() => directory.delete(recursive: true));
      final photo = _photoAddedEvent();
      final state = _projectState(directory, events: <TraceBenchEvent>[photo]);
      await _writeExistingEvents(directory, state.events);
      final runner = _FakeProcessRunner((command, candidate) async {
        if (!_isWriterCommand(command)) {
          return ProcessResult(12, 0, 'Python 3.12.0', '');
        }
        await _appendCandidate(command, candidate!);
        return ProcessResult(12, 0, '[OK] appended: evt_000002', '');
      });

      await PhotoEventWriterService(
        processRunner: runner,
        repoRootPath: Directory.current.path,
      ).confirmAlignment(
        projectState: state,
        request: _alignmentRequest(boardSide: 'unknown'),
      );

      expect(
        (runner.candidates.single['payload'] as Map)['board_side'],
        'unknown',
      );
    });

    test('rejects unknown photos, intrinsic bounds, and degenerate geometry',
        () async {
      final directory =
          await Directory.systemTemp.createTemp('tracebench-alignment-writer-');
      addTearDown(() => directory.delete(recursive: true));
      final state = _projectState(
        directory,
        events: <TraceBenchEvent>[_photoAddedEvent()],
      );
      final runner = _FakeProcessRunner(
        (command, candidate) => ProcessResult(12, 0, 'Python 3.12.0', ''),
      );
      final writer = PhotoEventWriterService(
        processRunner: runner,
        repoRootPath: Directory.current.path,
      );
      final requests = <PhotoAlignmentEventWriteRequest>[
        _alignmentRequest(sourcePhotoId: 'photo_unknown'),
        _alignmentRequest(
          photoPoints: const <PhotoAlignmentPoint>[
            PhotoAlignmentPoint(x: 10, y: 20),
            PhotoAlignmentPoint(x: 401, y: 20),
          ],
        ),
        _alignmentRequest(
          transformType: PhotoAlignmentTransformType.affine,
          photoPoints: const <PhotoAlignmentPoint>[
            PhotoAlignmentPoint(x: 0, y: 0),
            PhotoAlignmentPoint(x: 100, y: 100),
            PhotoAlignmentPoint(x: 200, y: 200),
          ],
          boardPoints: const <PhotoAlignmentPoint>[
            PhotoAlignmentPoint(x: 0.1, y: 0.1),
            PhotoAlignmentPoint(x: 0.4, y: 0.2),
            PhotoAlignmentPoint(x: 0.8, y: 0.7),
          ],
        ),
      ];

      for (final request in requests) {
        await expectLater(
          writer.confirmAlignment(projectState: state, request: request),
          throwsA(
            isA<PhotoEventWriteException>()
                .having(
                  (error) => error.kind,
                  'kind',
                  PhotoEventWriteFailureKind.validation,
                )
                .having(
                  (error) => error.durability,
                  'durability',
                  PhotoEventDurability.provenNoEvent,
                ),
          ),
        );
      }
      expect(runner.calls, isEmpty);
    });

    test('rejects duplicate or malformed prior alignment IDs', () async {
      final directory =
          await Directory.systemTemp.createTemp('tracebench-alignment-writer-');
      addTearDown(() => directory.delete(recursive: true));
      final events = <TraceBenchEvent>[
        _photoAddedEvent(),
        _event(
          eventId: 'evt_000002',
          sequence: 2,
          eventType: 'photo_to_board_alignment_confirmed',
          payload: const <String, dynamic>{'alignment_id': 'alignment_bad'},
        ),
      ];
      await _writeExistingEvents(directory, events);
      final runner = _FakeProcessRunner(
        (command, candidate) => ProcessResult(13, 0, 'Python 3.12.0', ''),
      );

      await expectLater(
        PhotoEventWriterService(
          processRunner: runner,
          repoRootPath: Directory.current.path,
        ).confirmAlignment(
          projectState: _projectState(directory, events: events),
          request: _alignmentRequest(),
        ),
        throwsA(
          isA<PhotoEventWriteException>().having(
            (error) => error.kind,
            'kind',
            PhotoEventWriteFailureKind.invalidEventHistory,
          ),
        ),
      );
      expect(runner.calls, isEmpty);
    });
  });
}
