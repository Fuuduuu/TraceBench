import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:trace_bench_viewer/shared/models/known_facts.dart';
import 'package:trace_bench_viewer/shared/models/project_manifest.dart';
import 'package:trace_bench_viewer/shared/models/project_state.dart';
import 'package:trace_bench_viewer/shared/models/trace_bench_event.dart';
import 'package:trace_bench_viewer/shared/session/project_session.dart';

void main() {
  ProviderContainer createContainer() {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    return container;
  }

  test('provider starts with null state and generation zero', () {
    final container = createContainer();

    expect(container.read(projectStateProvider), isNull);
    expect(container.read(projectStateProvider.notifier).generation, 0);
  });

  test('matching-generation open succeeds and advances once', () {
    final container = createContainer();
    final session = container.read(projectStateProvider.notifier);
    final project = _project('opened');

    expect(session.openProject(project, generation: 0), isTrue);
    expect(container.read(projectStateProvider), same(project));
    expect(session.generation, 1);
  });

  test('close clears state and dedup sidecar and advances once', () {
    final container = createContainer();
    final session = container.read(projectStateProvider.notifier);
    final project = _project('first');

    expect(session.openProject(project, generation: 0), isTrue);
    expect(
      session.applyCanonicalEvent(
        _rawEvent(eventId: 'event-close', operationId: 'operation-close'),
        generation: 1,
      ),
      isTrue,
    );

    session.closeProject();

    expect(container.read(projectStateProvider), isNull);
    expect(session.generation, 2);

    final reopened = _project('second');
    expect(session.openProject(reopened, generation: 2), isTrue);
    expect(
      session.applyCanonicalEvent(
        _rawEvent(eventId: 'event-close', operationId: 'operation-close'),
        generation: 3,
      ),
      isTrue,
    );
  });

  test('two distinct same-generation returned events both survive', () {
    final container = createContainer();
    final session = container.read(projectStateProvider.notifier);
    expect(session.openProject(_project('compose'), generation: 0), isTrue);
    final generation = session.generation;

    expect(
      session.applyCanonicalEvent(
        _rawEvent(eventId: 'event-a', operationId: 'operation-a'),
        generation: generation,
      ),
      isTrue,
    );
    expect(
      session.applyCanonicalEvent(
        _rawEvent(eventId: 'event-b', operationId: 'operation-b'),
        generation: generation,
      ),
      isTrue,
    );

    expect(
      container
          .read(projectStateProvider)!
          .events
          .map((event) => event.eventId),
      ['event-a', 'event-b'],
    );
    expect(session.generation, generation);
  });

  test('duplicate event_id is not appended twice', () {
    final container = createContainer();
    final session = container.read(projectStateProvider.notifier);
    expect(session.openProject(_project('event-dedup'), generation: 0), isTrue);

    expect(
      session.applyCanonicalEvent(
        _rawEvent(eventId: 'same-event', operationId: 'operation-a'),
        generation: 1,
      ),
      isTrue,
    );
    expect(
      session.applyCanonicalEvent(
        _rawEvent(eventId: 'same-event', operationId: 'operation-b'),
        generation: 1,
      ),
      isFalse,
    );

    expect(container.read(projectStateProvider)!.events, hasLength(1));
  });

  test('duplicate client_operation_id is not appended twice', () {
    final container = createContainer();
    final session = container.read(projectStateProvider.notifier);
    expect(
      session.openProject(_project('operation-dedup'), generation: 0),
      isTrue,
    );

    expect(
      session.applyCanonicalEvent(
        _rawEvent(eventId: 'event-a', operationId: 'same-operation'),
        generation: 1,
      ),
      isTrue,
    );
    expect(
      session.applyCanonicalEvent(
        _rawEvent(eventId: 'event-b', operationId: 'same-operation'),
        generation: 1,
      ),
      isFalse,
    );

    expect(container.read(projectStateProvider)!.events, hasLength(1));
  });

  test('accepted event promotes projection freshness to stale', () {
    final container = createContainer();
    final session = container.read(projectStateProvider.notifier);
    expect(
      session.openProject(
        _project('fresh', freshness: ProjectionFreshness.fresh),
        generation: 0,
      ),
      isTrue,
    );

    expect(
      session.applyCanonicalEvent(
        _rawEvent(eventId: 'event-stale', operationId: 'operation-stale'),
        generation: 1,
      ),
      isTrue,
    );

    final current = container.read(projectStateProvider)!;
    expect(current.projectionFreshness, ProjectionFreshness.stale);
    expect(current.isProjectionStale, isTrue);
  });

  test('stale generation cannot apply an event or mutate dedup', () {
    final container = createContainer();
    final session = container.read(projectStateProvider.notifier);
    expect(session.openProject(_project('old'), generation: 0), isTrue);
    final staleGeneration = session.generation;
    expect(
      session.openProject(_project('new'), generation: staleGeneration),
      isTrue,
    );

    final event = _rawEvent(
      eventId: 'stale-event',
      operationId: 'stale-operation',
    );
    expect(
      session.applyCanonicalEvent(event, generation: staleGeneration),
      isFalse,
    );
    expect(container.read(projectStateProvider)!.events, isEmpty);
    expect(
      session.applyCanonicalEvent(event, generation: session.generation),
      isTrue,
    );
  });

  test('matching-generation reload replaces state and advances once', () {
    final container = createContainer();
    final session = container.read(projectStateProvider.notifier);
    expect(
        session.openProject(_project('before-reload'), generation: 0), isTrue);
    final reloaded = _project('after-reload');

    expect(
      session.replaceWithReloaded(reloaded, generation: 1),
      isTrue,
    );
    expect(container.read(projectStateProvider), same(reloaded));
    expect(session.generation, 2);
  });

  test('stale reload cannot overwrite a newer session', () {
    final container = createContainer();
    final session = container.read(projectStateProvider.notifier);
    expect(session.openProject(_project('old'), generation: 0), isTrue);
    final staleGeneration = session.generation;
    session.closeProject();
    final newer = _project('newer');
    expect(
      session.openProject(newer, generation: session.generation),
      isTrue,
    );

    expect(
      session.replaceWithReloaded(
        _project('late-reload'),
        generation: staleGeneration,
      ),
      isFalse,
    );
    expect(container.read(projectStateProvider), same(newer));
    expect(session.generation, 3);
  });

  test('null-session event apply and reload are no-ops', () {
    final container = createContainer();
    final session = container.read(projectStateProvider.notifier);

    expect(
      session.applyCanonicalEvent(
        _rawEvent(eventId: 'event-null', operationId: 'operation-null'),
        generation: 0,
      ),
      isFalse,
    );
    expect(
      session.replaceWithReloaded(_project('reload-null'), generation: 0),
      isFalse,
    );
    expect(container.read(projectStateProvider), isNull);
    expect(session.generation, 0);
  });

  test('stale open is rejected without mutation', () {
    final container = createContainer();
    final session = container.read(projectStateProvider.notifier);

    expect(session.openProject(_project('stale-open'), generation: 1), isFalse);
    expect(container.read(projectStateProvider), isNull);
    expect(session.generation, 0);
  });

  test('full replacement resets and reseeds session dedup', () {
    final container = createContainer();
    final session = container.read(projectStateProvider.notifier);
    final seeded = _project(
      'seeded',
      events: [
        _storedEvent(
          eventId: 'seed-event',
          payloadOperationId: 'seed-operation',
        ),
      ],
    );
    expect(session.openProject(seeded, generation: 0), isTrue);

    expect(
      session.applyCanonicalEvent(
        _rawEvent(eventId: 'seed-event', operationId: 'new-operation'),
        generation: 1,
      ),
      isFalse,
    );
    expect(
      session.applyCanonicalEvent(
        _rawEvent(eventId: 'new-event', operationId: 'seed-operation'),
        generation: 1,
      ),
      isFalse,
    );

    expect(
      session.replaceWithReloaded(_project('replacement'), generation: 1),
      isTrue,
    );
    expect(
      session.applyCanonicalEvent(
        _rawEvent(eventId: 'seed-event', operationId: 'seed-operation'),
        generation: 2,
      ),
      isTrue,
    );
  });
}

ProjectState _project(
  String projectId, {
  List<TraceBenchEvent> events = const [],
  ProjectionFreshness freshness = ProjectionFreshness.unknown,
}) {
  return ProjectState(
    manifest: ProjectManifest(
      projectId: projectId,
      schemaVersion: '1.0',
      createdAt: '2026-08-24T00:00:00Z',
      deviceType: 'bench_board',
      model: 'session-fixture',
      symptom: 'not_provided',
    ),
    knownFacts: KnownFacts.fromJson({
      'project_id': projectId,
      'components': const [],
      'pins': const [],
      'measurements': const [],
      'component_pin_index': const <String, dynamic>{},
    }),
    events: events,
    customerReport: 'Session fixture report',
    projectDirectory: 'C:\\tracebench_session_fixture\\$projectId',
    projectionFreshness: freshness,
  );
}

Map<String, dynamic> _rawEvent({
  required String eventId,
  required String operationId,
}) {
  return {
    'schema_version': '2.0-draft',
    'event_id': eventId,
    'project_id': 'session-project',
    'sequence': 1,
    'created_at': '2026-08-24T00:00:01Z',
    'actor': const {'type': 'human', 'id': 'local_operator'},
    'event_type': 'component_created',
    'status': 'accepted',
    'client_operation_id': operationId,
    'payload': const <String, dynamic>{},
  };
}

TraceBenchEvent _storedEvent({
  required String eventId,
  String? payloadOperationId,
}) {
  return TraceBenchEvent(
    schemaVersion: '2.0-draft',
    eventId: eventId,
    projectId: 'session-project',
    sequence: 1,
    createdAt: '2026-08-24T00:00:01Z',
    actor: const {'type': 'human', 'id': 'local_operator'},
    eventType: 'component_created',
    status: 'accepted',
    payload: {
      if (payloadOperationId != null) 'client_operation_id': payloadOperationId,
    },
  );
}
