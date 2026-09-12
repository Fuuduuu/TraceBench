import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trace_bench_viewer/features/photos/logic/photo_event_read_model.dart';
import 'package:trace_bench_viewer/shared/models/known_facts.dart';
import 'package:trace_bench_viewer/shared/models/project_manifest.dart';
import 'package:trace_bench_viewer/shared/models/project_state.dart';
import 'package:trace_bench_viewer/shared/models/trace_bench_event.dart';
import 'package:trace_bench_viewer/shared/session/project_session.dart';

TraceBenchEvent _event({
  required String eventId,
  int? sequence,
  String eventType = 'photo_added',
  String status = 'accepted',
  Map<String, dynamic>? payload,
}) {
  return TraceBenchEvent(
    schemaVersion: '1.0',
    eventId: eventId,
    projectId: 'prj_photo_read_model',
    sequence: sequence ?? int.parse(eventId.substring(eventId.length - 6)),
    createdAt: '2026-08-26T10:00:00Z',
    actor: const <String, dynamic>{'type': 'user', 'id': 'local_operator'},
    eventType: eventType,
    status: status,
    payload: payload ??
        const <String, dynamic>{
          'photo_id': 'photo_default',
          'mode': 'normal',
          'path': 'photos/photo_default.jpg',
        },
  );
}

ProjectState _projectState({List<TraceBenchEvent> events = const []}) {
  return ProjectState(
    manifest: const ProjectManifest(
      projectId: 'prj_photo_read_model',
      schemaVersion: '1.0',
      createdAt: '2026-08-26T09:00:00Z',
      deviceType: 'board',
      model: 'test',
      symptom: 'test',
    ),
    knownFacts: KnownFacts.fromJson(<String, dynamic>{
      'project_id': 'prj_photo_read_model',
      'components': const <dynamic>[],
      'pins': const <dynamic>[],
      'measurements': const <dynamic>[],
      'photos': const <dynamic>[],
      'component_pin_index': const <String, dynamic>{},
    }),
    events: events,
    customerReport: '',
    projectionFreshness: ProjectionFreshness.fresh,
  );
}

class _SeededProjectSession extends ProjectSession {
  _SeededProjectSession(this.initialState);

  final ProjectState initialState;

  @override
  ProjectState? build() {
    super.build();
    return initialState;
  }
}

void main() {
  const primaryPath = 'photos/wizard_background.png';
  const primarySha =
      '0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef';

  test('derives accepted photo_added items in stable event order', () {
    final events = <TraceBenchEvent>[
      _event(
        eventId: 'evt_000001',
        payload: const <String, dynamic>{
          'photo_id': 'photo_top',
          'mode': 'backlight',
          'path': 'photos/photo_top.jpeg',
          'sha256':
              '0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef',
          'layer': 'top',
        },
      ),
      _event(
        eventId: 'evt_000002',
        payload: const <String, dynamic>{
          'photo_id': 'photo_detail',
          'mode': 'macro',
          'path': 'photos/detail/photo_detail.webp',
        },
      ),
    ];

    final items = photoEventItemsFromEvents(events);

    expect(items.map((item) => item.eventId), <String>[
      'evt_000001',
      'evt_000002',
    ]);
    expect(items.first.photoId, 'photo_top');
    expect(items.first.mode, 'backlight');
    expect(items.first.path, 'photos/photo_top.jpeg');
    expect(
      items.first.sha256,
      '0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef',
    );
    expect(items.first.layer, 'top');
    expect(items.last.sha256, isNull);
    expect(items.last.layer, isNull);
  });

  test('ignores non-accepted, other, and malformed photo events', () {
    final events = <TraceBenchEvent>[
      _event(eventId: 'evt_000001', status: 'rejected'),
      _event(eventId: 'evt_000002', eventType: 'measurement_recorded'),
      _event(
        eventId: 'evt_000003',
        payload: const <String, dynamic>{
          'photo_id': 'photo_missing_path',
          'mode': 'normal',
        },
      ),
      _event(
        eventId: 'evt_000004',
        payload: const <String, dynamic>{
          'photo_id': 'photo_traversal',
          'mode': 'normal',
          'path': 'photos/../escape.jpg',
        },
      ),
      _event(
        eventId: 'evt_000005',
        payload: const <String, dynamic>{
          'photo_id': 'photo_valid',
          'mode': 'side_light',
          'path': 'photos/photo_valid.png',
          'layer': 'side',
        },
      ),
    ];

    final items = photoEventItemsFromEvents(events);

    expect(items, hasLength(1));
    expect(items.single.photoId, 'photo_valid');
  });

  test('returned event becomes visible immediately without Known Facts change',
      () {
    final initialState = _projectState();
    final container = ProviderContainer(
      overrides: <Override>[
        projectStateProvider.overrideWith(
          () => _SeededProjectSession(initialState),
        ),
      ],
    );
    addTearDown(container.dispose);
    final session = container.read(projectStateProvider.notifier);
    final returnedEvent = _event(
      eventId: 'evt_000001',
      payload: const <String, dynamic>{
        'photo_id': 'photo_just_imported',
        'mode': 'normal',
        'path': 'photos/photo_just_imported.jpg',
        'sha256':
            'abcdef0123456789abcdef0123456789abcdef0123456789abcdef0123456789',
      },
    ).toJson();

    final applied = session.applyCanonicalEvent(
      returnedEvent,
      generation: session.generation,
    );
    final current = container.read(projectStateProvider)!;

    expect(applied, isTrue);
    expect(current.knownFacts.photos, isEmpty);
    expect(current.projectionFreshness, ProjectionFreshness.stale);
    expect(photoEventItemsFromEvents(current.events).single.photoId,
        'photo_just_imported');
  });

  test('derives valid similarity and affine alignments from prior photos', () {
    final events = <TraceBenchEvent>[
      _event(
        eventId: 'evt_000001',
        payload: const <String, dynamic>{
          'photo_id': 'photo_board',
          'mode': 'normal',
          'path': 'photos/photo_board.jpg',
        },
      ),
      _event(
        eventId: 'evt_000002',
        eventType: 'photo_to_board_alignment_confirmed',
        payload: const <String, dynamic>{
          'alignment_id': 'ALN1',
          'source_photo_id': 'photo_board',
          'board_side': 'top',
          'coordinate_space_from': 'photo_local',
          'coordinate_space_to': 'board_normalized',
          'reference_points_photo': <Map<String, double>>[
            <String, double>{'x': 0, 'y': 0},
            <String, double>{'x': 100, 'y': 0},
          ],
          'reference_points_board': <Map<String, double>>[
            <String, double>{'x': 0.1, 'y': 0.2},
            <String, double>{'x': 0.5, 'y': 0.2},
          ],
          'transform_type': 'similarity',
          'alignment_quality_label': 'manual_preview_confirmed',
        },
      ),
      _event(
        eventId: 'evt_000003',
        eventType: 'photo_to_board_alignment_confirmed',
        payload: const <String, dynamic>{
          'alignment_id': 'ALN2',
          'source_photo_id': 'photo_board',
          'board_side': 'bottom',
          'coordinate_space_from': 'photo_local',
          'coordinate_space_to': 'board_normalized',
          'reference_points_photo': <Map<String, double>>[
            <String, double>{'x': 0, 'y': 0},
            <String, double>{'x': 100, 'y': 0},
            <String, double>{'x': 0, 'y': 100},
            <String, double>{'x': 100, 'y': 100},
          ],
          'reference_points_board': <Map<String, double>>[
            <String, double>{'x': 0.1, 'y': 0.1},
            <String, double>{'x': 0.5, 'y': 0.1},
            <String, double>{'x': 0.2, 'y': 0.5},
            <String, double>{'x': 0.6, 'y': 0.5},
          ],
          'transform_type': 'affine',
          'alignment_quality_label': 'manual_preview_confirmed',
        },
      ),
    ];

    final alignments = photoAlignmentEventItemsFromEvents(events);

    expect(alignments, hasLength(2));
    expect(alignments.first.alignmentId, 'ALN1');
    expect(alignments.first.sourcePhoto.photoId, 'photo_board');
    expect(alignments.first.transformType.canonicalName, 'similarity');
    expect(alignments.last.alignmentId, 'ALN2');
    expect(alignments.last.boardSide, 'bottom');
    expect(alignments.last.solution.transform.m01, isNonZero);
    expect(latestPhotoAlignmentEventItem(events)?.alignmentId, 'ALN2');
  });

  test('latest accepted valid alignment uses highest V1 sequence', () {
    final photo = _event(
      eventId: 'evt_000001',
      sequence: 1,
      payload: const <String, dynamic>{
        'photo_id': 'photo_board',
        'mode': 'normal',
        'path': 'photos/photo_board.png',
      },
    );
    TraceBenchEvent alignment(String eventId, int sequence, String id) =>
        _event(
          eventId: eventId,
          sequence: sequence,
          eventType: 'photo_to_board_alignment_confirmed',
          payload: <String, dynamic>{
            'alignment_id': id,
            'source_photo_id': 'photo_board',
            'board_side': 'top',
            'coordinate_space_from': 'photo_local',
            'coordinate_space_to': 'board_normalized',
            'reference_points_photo': const <Map<String, double>>[
              <String, double>{'x': 0, 'y': 0},
              <String, double>{'x': 100, 'y': 0},
            ],
            'reference_points_board': const <Map<String, double>>[
              <String, double>{'x': 0.1, 'y': 0.2},
              <String, double>{'x': 0.5, 'y': 0.2},
            ],
            'transform_type': 'similarity',
            'alignment_quality_label': 'manual_preview_confirmed',
          },
        );
    final events = <TraceBenchEvent>[
      photo,
      alignment('evt_000010', 10, 'ALN10'),
      alignment('evt_000004', 4, 'ALN4'),
    ];

    expect(latestPhotoAlignmentEventItem(events)?.alignmentId, 'ALN10');
  });

  test(
      'primary identity requires exact Wizard path and digest and reuses lowest sequence',
      () {
    final events = <TraceBenchEvent>[
      _event(
        eventId: 'evt_000001',
        sequence: 1,
        payload: const <String, dynamic>{
          'photo_id': 'photo_additional_same_hash',
          'mode': 'normal',
          'path': 'photos/detail.png',
          'sha256': primarySha,
        },
      ),
      _event(
        eventId: 'evt_000004',
        sequence: 4,
        payload: const <String, dynamic>{
          'photo_id': 'photo_primary_later_duplicate',
          'mode': 'normal',
          'path': primaryPath,
          'sha256': primarySha,
        },
      ),
      _event(
        eventId: 'evt_000002',
        sequence: 2,
        payload: const <String, dynamic>{
          'photo_id': 'photo_primary_first',
          'mode': 'normal',
          'path': primaryPath,
          'sha256':
              '0123456789ABCDEF0123456789ABCDEF0123456789ABCDEF0123456789ABCDEF',
        },
      ),
      _event(
        eventId: 'evt_000003',
        sequence: 3,
        payload: const <String, dynamic>{
          'photo_id': 'photo_primary_stale_bytes',
          'mode': 'normal',
          'path': primaryPath,
          'sha256':
              'ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff',
        },
      ),
    ];

    final primary = primaryPhotoEventItemFromEvents(
      events,
      relativePath: primaryPath,
      sha256: primarySha,
    );

    expect(primary?.photoId, 'photo_primary_first');
    expect(primary?.sequence, 2);
    expect(
      primaryPhotoEventItemFromEvents(
        events,
        relativePath: 'photos/../wizard_background.png',
        sha256: primarySha,
      ),
      isNull,
    );
    expect(
      primaryPhotoEventItemFromEvents(
        events,
        relativePath: primaryPath,
        sha256:
            'eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee',
      ),
      isNull,
    );
  });

  test(
      'primary alignment selection ignores additional photos and bounds reopened points',
      () {
    TraceBenchEvent photo({
      required String eventId,
      required int sequence,
      required String photoId,
      required String path,
    }) =>
        _event(
          eventId: eventId,
          sequence: sequence,
          payload: <String, dynamic>{
            'photo_id': photoId,
            'mode': 'normal',
            'path': path,
            'sha256': primarySha,
          },
        );
    TraceBenchEvent alignment({
      required String eventId,
      required int sequence,
      required String alignmentId,
      required String sourcePhotoId,
      String transformType = 'similarity',
      List<Map<String, double>>? photoPoints,
    }) =>
        _event(
          eventId: eventId,
          sequence: sequence,
          eventType: 'photo_to_board_alignment_confirmed',
          payload: <String, dynamic>{
            'alignment_id': alignmentId,
            'source_photo_id': sourcePhotoId,
            'board_side': 'top',
            'coordinate_space_from': 'photo_local',
            'coordinate_space_to': 'board_normalized',
            'reference_points_photo': photoPoints ??
                <Map<String, double>>[
                  <String, double>{'x': 0, 'y': 0},
                  <String, double>{'x': 200, 'y': 0},
                  if (transformType == 'affine')
                    <String, double>{'x': 0, 'y': 200},
                ],
            'reference_points_board': <Map<String, double>>[
              <String, double>{'x': 0.1, 'y': 0.1},
              <String, double>{'x': 0.7, 'y': 0.1},
              if (transformType == 'affine')
                <String, double>{'x': 0.2, 'y': 0.7},
            ],
            'transform_type': transformType,
            'alignment_quality_label': 'manual_preview_confirmed',
          },
        );
    final events = <TraceBenchEvent>[
      photo(
        eventId: 'evt_000001',
        sequence: 1,
        photoId: 'photo_primary',
        path: primaryPath,
      ),
      photo(
        eventId: 'evt_000002',
        sequence: 2,
        photoId: 'photo_additional',
        path: 'photos/detail.png',
      ),
      alignment(
        eventId: 'evt_000003',
        sequence: 3,
        alignmentId: 'ALN1',
        sourcePhotoId: 'photo_primary',
      ),
      alignment(
        eventId: 'evt_000010',
        sequence: 10,
        alignmentId: 'ALN10',
        sourcePhotoId: 'photo_additional',
      ),
      alignment(
        eventId: 'evt_000007',
        sequence: 7,
        alignmentId: 'ALN7',
        sourcePhotoId: 'photo_primary',
        transformType: 'affine',
      ),
      alignment(
        eventId: 'evt_000008',
        sequence: 8,
        alignmentId: 'ALN8',
        sourcePhotoId: 'photo_primary',
        photoPoints: const <Map<String, double>>[
          <String, double>{'x': 0, 'y': 0},
          <String, double>{'x': 401, 'y': 0},
        ],
      ),
    ];

    final alignments = primaryPhotoAlignmentEventItemsFromEvents(
      events,
      relativePath: primaryPath,
      sha256: primarySha,
      photoWidth: 400,
      photoHeight: 300,
    );

    expect(
      alignments.map((alignment) => alignment.alignmentId),
      <String>['ALN1', 'ALN7'],
    );
    expect(
      latestPrimaryPhotoAlignmentEventItem(
        events,
        relativePath: primaryPath,
        sha256: primarySha,
        photoWidth: 400,
        photoHeight: 300,
      )?.alignmentId,
      'ALN7',
    );
  });

  test('ignores malformed, degenerate, forward, and non-accepted alignments',
      () {
    final photo = _event(
      eventId: 'evt_000002',
      payload: const <String, dynamic>{
        'photo_id': 'photo_board',
        'mode': 'normal',
        'path': 'photos/photo_board.webp',
      },
    );
    TraceBenchEvent badAlignment({
      required String eventId,
      required int sequence,
      String status = 'accepted',
      String sourcePhotoId = 'photo_board',
      List<Map<String, double>>? board,
    }) =>
        _event(
          eventId: eventId,
          sequence: sequence,
          status: status,
          eventType: 'photo_to_board_alignment_confirmed',
          payload: <String, dynamic>{
            'alignment_id': 'ALN$sequence',
            'source_photo_id': sourcePhotoId,
            'board_side': 'top',
            'coordinate_space_from': 'photo_local',
            'coordinate_space_to': 'board_normalized',
            'reference_points_photo': const <Map<String, double>>[
              <String, double>{'x': 0, 'y': 0},
              <String, double>{'x': 100, 'y': 0},
            ],
            'reference_points_board': board ??
                const <Map<String, double>>[
                  <String, double>{'x': 0.2, 'y': 0.2},
                  <String, double>{'x': 0.2, 'y': 0.2},
                ],
            'transform_type': 'similarity',
            'alignment_quality_label': 'manual_preview_confirmed',
          },
        );
    final events = <TraceBenchEvent>[
      badAlignment(eventId: 'evt_000001', sequence: 1),
      photo,
      badAlignment(eventId: 'evt_000003', sequence: 3),
      badAlignment(
        eventId: 'evt_000004',
        sequence: 4,
        sourcePhotoId: 'photo_unknown',
      ),
      badAlignment(
        eventId: 'evt_000005',
        sequence: 5,
        status: 'rejected',
        board: const <Map<String, double>>[
          <String, double>{'x': 0.1, 'y': 0.1},
          <String, double>{'x': 0.5, 'y': 0.1},
        ],
      ),
    ];

    expect(photoAlignmentEventItemsFromEvents(events), isEmpty);
  });

  test('ignores alignment payloads with forbidden or malformed extra fields',
      () {
    final photo = _event(
      eventId: 'evt_000001',
      sequence: 1,
      payload: const <String, dynamic>{
        'photo_id': 'photo_board',
        'mode': 'normal',
        'path': 'photos/photo_board.jpg',
      },
    );
    Map<String, dynamic> payload(String alignmentId) => <String, dynamic>{
          'alignment_id': alignmentId,
          'source_photo_id': 'photo_board',
          'board_side': 'unknown',
          'coordinate_space_from': 'photo_local',
          'coordinate_space_to': 'board_normalized',
          'reference_points_photo': const <Map<String, double>>[
            <String, double>{'x': 0, 'y': 0},
            <String, double>{'x': 100, 'y': 0},
          ],
          'reference_points_board': const <Map<String, double>>[
            <String, double>{'x': 0.1, 'y': 0.2},
            <String, double>{'x': 0.5, 'y': 0.2},
          ],
          'transform_type': 'similarity',
          'alignment_quality_label': 'manual_preview_confirmed',
        };
    final forbidden = payload('ALN1')..['component_id'] = 'Q1';
    final malformedNotes = payload('ALN2')..['notes'] = 7;

    expect(
      photoAlignmentEventItemsFromEvents(<TraceBenchEvent>[
        photo,
        _event(
          eventId: 'evt_000002',
          sequence: 2,
          eventType: 'photo_to_board_alignment_confirmed',
          payload: forbidden,
        ),
        _event(
          eventId: 'evt_000003',
          sequence: 3,
          eventType: 'photo_to_board_alignment_confirmed',
          payload: malformedNotes,
        ),
      ]),
      isEmpty,
    );
  });

  test('returned alignment is renderable immediately while projection is stale',
      () {
    final photo = _event(
      eventId: 'evt_000001',
      payload: const <String, dynamic>{
        'photo_id': 'photo_board',
        'mode': 'normal',
        'path': 'photos/photo_board.jpg',
      },
    );
    final initialState = _projectState(events: <TraceBenchEvent>[photo]);
    final container = ProviderContainer(
      overrides: <Override>[
        projectStateProvider.overrideWith(
          () => _SeededProjectSession(initialState),
        ),
      ],
    );
    addTearDown(container.dispose);
    final session = container.read(projectStateProvider.notifier);
    final returned = _event(
      eventId: 'evt_000002',
      eventType: 'photo_to_board_alignment_confirmed',
      payload: const <String, dynamic>{
        'alignment_id': 'ALN1',
        'source_photo_id': 'photo_board',
        'board_side': 'top',
        'coordinate_space_from': 'photo_local',
        'coordinate_space_to': 'board_normalized',
        'reference_points_photo': <Map<String, double>>[
          <String, double>{'x': 0, 'y': 0},
          <String, double>{'x': 100, 'y': 0},
        ],
        'reference_points_board': <Map<String, double>>[
          <String, double>{'x': 0.1, 'y': 0.2},
          <String, double>{'x': 0.5, 'y': 0.2},
        ],
        'transform_type': 'similarity',
        'alignment_quality_label': 'manual_preview_confirmed',
      },
    ).toJson();

    expect(
      session.applyCanonicalEvent(returned, generation: session.generation),
      isTrue,
    );
    final current = container.read(projectStateProvider)!;
    expect(current.projectionFreshness, ProjectionFreshness.stale);
    expect(latestPhotoAlignmentEventItem(current.events)?.alignmentId, 'ALN1');
    expect(current.knownFacts.photoToBoardAlignments, isEmpty);
  });
}
