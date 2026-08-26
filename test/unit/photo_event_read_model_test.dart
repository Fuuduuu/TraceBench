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
  String eventType = 'photo_added',
  String status = 'accepted',
  Map<String, dynamic>? payload,
}) {
  return TraceBenchEvent(
    schemaVersion: '1.0',
    eventId: eventId,
    projectId: 'prj_photo_read_model',
    sequence: int.parse(eventId.substring(eventId.length - 6)),
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
}
