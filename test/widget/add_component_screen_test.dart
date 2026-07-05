import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:trace_bench_viewer/app/app.dart';
import 'package:trace_bench_viewer/features/components/screens/add_component_screen.dart';
import 'package:trace_bench_viewer/features/components/services/v2_add_component_writer.dart';
import 'package:trace_bench_viewer/shared/models/known_facts.dart';
import 'package:trace_bench_viewer/shared/models/project_manifest.dart';
import 'package:trace_bench_viewer/shared/models/project_state.dart';
import 'package:trace_bench_viewer/shared/models/trace_bench_event.dart';

class _FakeAddComponentWriter implements V2AddComponentWriter {
  _FakeAddComponentWriter({
    this.status = V2AddComponentWriteStatus.appended,
    this.failureKind,
    this.eventId = 'evt_000100',
  });

  final V2AddComponentWriteStatus status;
  final V2AddComponentFailureKind? failureKind;
  final String eventId;
  final List<V2AddComponentRequest> requests = <V2AddComponentRequest>[];

  @override
  Future<V2AddComponentResult> addComponent({
    required ProjectState projectState,
    required V2AddComponentRequest request,
  }) async {
    requests.add(request);
    final failure = failureKind;
    if (failure != null) {
      throw V2AddComponentException(failure, 'fake writer failure');
    }
    return V2AddComponentResult(
      status: status,
      event: _componentCreatedEvent(
        eventId: eventId,
        projectId: projectState.manifest.projectId,
        request: request,
      ),
      appended: status == V2AddComponentWriteStatus.appended,
    );
  }
}

ProjectState _inlineProjectState({
  List<TraceBenchEvent> events = const [],
  String? projectDirectory,
}) {
  return ProjectState(
    manifest: const ProjectManifest(
      projectId: 'add_component_project',
      schemaVersion: '1.0',
      createdAt: '2026-05-22T00:00:00Z',
      deviceType: 'bench_board',
      model: 'PV20',
      symptom: 'not_provided',
    ),
    knownFacts: KnownFacts.fromJson({
      'project_id': 'add_component_project',
      'components': const [],
      'pins': const [],
      'measurements': const [],
      'component_pin_index': const <String, dynamic>{},
    }),
    events: events,
    customerReport: 'Inline report',
    projectDirectory: projectDirectory ?? 'C:\\tracebench_fake_project',
  );
}

Map<String, dynamic> _componentCreatedEvent({
  required String eventId,
  required String projectId,
  required V2AddComponentRequest request,
}) {
  final payload = <String, dynamic>{
    'component_id': request.componentId,
    'label': request.label,
    'component_kind': request.componentKind,
    'created_context': 'human_entered',
  };
  if (request.referenceDesignator != null) {
    payload['reference_designator'] = request.referenceDesignator;
  }
  if (request.packageHint != null) {
    payload['package_hint'] = request.packageHint;
  }
  if (request.footprintHint != null) {
    payload['footprint_hint'] = request.footprintHint;
  }
  if (request.templateIdHint != null) {
    payload['template_id_hint'] = request.templateIdHint;
  }
  if (request.humanNote != null) {
    payload['human_note'] = request.humanNote;
  }
  return {
    'schema_version': '2.0-draft',
    'event_id': eventId,
    'event_type': 'component_created',
    'created_at': '2026-06-09T10:00:00.000Z',
    'project_id': projectId,
    'client_operation_id': request.clientOperationId,
    'actor': {'type': 'human', 'id': 'local_operator'},
    'source': {
      'type': 'explicit_user_confirmation',
      'surface': 'add_component',
      'action': 'add_component',
    },
    'confirmation': {'confirmed': true},
    'payload': payload,
  };
}

Future<ProviderContainer> _pumpAddComponentScreen(
  WidgetTester tester, {
  ProjectState? projectState,
  _FakeAddComponentWriter? writer,
}) async {
  final container = ProviderContainer(
    overrides: [
      projectStateProvider.overrideWith(
        (_) => projectState ?? _inlineProjectState(),
      ),
      v2AddComponentWriterProvider.overrideWithValue(
        writer ?? _FakeAddComponentWriter(),
      ),
    ],
  );
  addTearDown(container.dispose);

  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: const MaterialApp(home: AddComponentScreen()),
    ),
  );
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 100));
  return container;
}

ElevatedButton _addButton(WidgetTester tester) {
  return tester.widget<ElevatedButton>(
    find.byKey(const ValueKey('add-component-button')),
  );
}

Future<void> _selectUnknownKind(WidgetTester tester) async {
  await tester.tap(find.byKey(const ValueKey('add-component-kind-dropdown')));
  await tester.pumpAndSettle();
  await tester.tap(find.text('unknown').last);
  await tester.pump();
}

Future<void> _fillRequiredFields(WidgetTester tester) async {
  await tester.enterText(
    find.byKey(const ValueKey('add-component-id-field')),
    'U10',
  );
  await tester.enterText(
    find.byKey(const ValueKey('add-component-label-field')),
    'U10',
  );
  await _selectUnknownKind(tester);
}

Future<void> _tapAddComponentButton(WidgetTester tester) async {
  final onPressed = _addButton(tester).onPressed;
  expect(onPressed, isNotNull);
  onPressed!();
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 100));
}

void main() {
  testWidgets('renders Add Component safety copy and starts disabled',
      (tester) async {
    await _pumpAddComponentScreen(tester);

    expect(find.text('Loo komponent'), findsAtLeastNWidgets(1));
    expect(
      find.text('Human is the sensor. AI is the graph engine.'),
      findsOneWidget,
    );
    expect(
      find.text(
        'Loob component_created identiteedi- ja olemasolufakti ainult selge inimkinnituse järel.',
      ),
      findsOneWidget,
    );
    expect(
      find.text('Koht → Väärtus → Ühik → Loo komponent'),
      findsAtLeastNWidgets(1),
    );
    await tester.drag(find.byType(ListView), const Offset(0, -1000));
    await tester.pump();
    expect(find.text('Vihjed on kontekst, mitte tõend.'), findsOneWidget);
    expect(find.textContaining('hint/context only'), findsOneWidget);
    expect(
      find.textContaining('do not confirm component identity'),
      findsOneWidget,
    );
    expect(_addButton(tester).onPressed, isNull);
  });

  testWidgets('Add button is disabled until human-entered fields exist',
      (tester) async {
    await _pumpAddComponentScreen(tester);

    expect(_addButton(tester).onPressed, isNull);
    await tester.enterText(
      find.byKey(const ValueKey('add-component-id-field')),
      'U10',
    );
    await tester.pump();
    expect(_addButton(tester).onPressed, isNull);

    await tester.enterText(
      find.byKey(const ValueKey('add-component-label-field')),
      'U10',
    );
    await tester.pump();
    expect(_addButton(tester).onPressed, isNull);

    await _selectUnknownKind(tester);
    expect(_addButton(tester).onPressed, isNotNull);
  });

  testWidgets('valid Add Component calls writer once and appends local event',
      (tester) async {
    final writer = _FakeAddComponentWriter(eventId: 'evt_000100');
    final container = await _pumpAddComponentScreen(tester, writer: writer);

    await _fillRequiredFields(tester);
    await tester.enterText(
      find.byKey(const ValueKey('add-component-reference-field')),
      'U10',
    );
    await tester.enterText(
      find.byKey(const ValueKey('add-component-package-field')),
      'SOIC-8',
    );
    await tester.enterText(
      find.byKey(const ValueKey('add-component-footprint-field')),
      'SOIC',
    );
    await tester.enterText(
      find.byKey(const ValueKey('add-component-template-field')),
      'tpl_soic_8',
    );
    await tester.enterText(
      find.byKey(const ValueKey('add-component-note-field')),
      'visual package hint only',
    );
    await _tapAddComponentButton(tester);

    expect(writer.requests, hasLength(1));
    final request = writer.requests.single;
    expect(request.componentId, 'U10');
    expect(request.label, 'U10');
    expect(request.componentKind, 'unknown');
    expect(request.referenceDesignator, 'U10');
    expect(request.packageHint, 'SOIC-8');
    expect(request.footprintHint, 'SOIC');
    expect(request.templateIdHint, 'tpl_soic_8');
    expect(request.humanNote, 'visual package hint only');
    expect(
        request.clientOperationId, startsWith('add_component_U10_U10_unknown'));
    expect(request.clientOperationId, contains('SOIC_8'));
    expect(request.clientOperationId, contains('tpl_soic_8'));

    final updatedState = container.read(projectStateProvider);
    expect(updatedState?.events, hasLength(1));
    expect(updatedState?.events.single.eventType, 'component_created');
    expect(updatedState?.isProjectionStale, isTrue);
    expect(find.text('Lisatud.'), findsOneWidget);
    expect(find.text('Projection stale until refresh.'), findsOneWidget);
  });

  testWidgets('technical details disclose writer and component_created type',
      (tester) async {
    await _pumpAddComponentScreen(tester);

    expect(find.text('Tehnilised detailid'), findsOneWidget);
    await tester.ensureVisible(find.text('Tehnilised detailid'));
    await tester.pump();
    await tester.tap(find.text('Tehnilised detailid'));
    await tester.pumpAndSettle();

    expect(
      find.text('Add Component writes component identity/existence only.'),
      findsOneWidget,
    );
    expect(find.text('Event type: component_created'), findsOneWidget);
  });

  testWidgets('writer validation failure shows not-saved outcome',
      (tester) async {
    await _pumpAddComponentScreen(
      tester,
      writer: _FakeAddComponentWriter(
        failureKind: V2AddComponentFailureKind.validation,
      ),
    );

    await _fillRequiredFields(tester);
    await _tapAddComponentButton(tester);

    expect(find.text('Not saved: validation failed.'), findsOneWidget);
  });

  testWidgets('writer append failure shows not-saved outcome', (tester) async {
    await _pumpAddComponentScreen(
      tester,
      writer: _FakeAddComponentWriter(
        failureKind: V2AddComponentFailureKind.append,
      ),
    );

    await _fillRequiredFields(tester);
    await _tapAddComponentButton(tester);

    expect(find.text('Not saved: writer append failed.'), findsOneWidget);
  });

  testWidgets('invalid project path shows not-saved outcome', (tester) async {
    await _pumpAddComponentScreen(
      tester,
      writer: _FakeAddComponentWriter(
        failureKind: V2AddComponentFailureKind.invalidProjectDirectory,
      ),
    );

    await _fillRequiredFields(tester);
    await _tapAddComponentButton(tester);

    expect(find.text('Not saved: project path is invalid.'), findsOneWidget);
  });

  testWidgets('writer lock conflict shows retry not-saved outcome',
      (tester) async {
    await _pumpAddComponentScreen(
      tester,
      writer: _FakeAddComponentWriter(
        failureKind: V2AddComponentFailureKind.lockConflict,
      ),
    );

    await _fillRequiredFields(tester);
    await _tapAddComponentButton(tester);

    expect(find.text('Not saved: writer is busy, retry.'), findsOneWidget);
  });

  testWidgets('idempotent existing result does not duplicate local events',
      (tester) async {
    const existing = TraceBenchEvent(
      schemaVersion: '2.0-draft',
      eventId: 'evt_000100',
      projectId: 'add_component_project',
      sequence: 0,
      createdAt: '2026-06-09T10:00:00.000Z',
      actor: {'type': 'human', 'id': 'local_operator'},
      eventType: 'component_created',
      status: 'accepted',
      payload: {
        'component_id': 'U10',
        'label': 'U10',
        'component_kind': 'unknown',
        'created_context': 'human_entered',
      },
    );
    final container = await _pumpAddComponentScreen(
      tester,
      projectState: _inlineProjectState(events: const [existing]),
      writer: _FakeAddComponentWriter(
        status: V2AddComponentWriteStatus.existing,
      ),
    );

    await _fillRequiredFields(tester);
    await _tapAddComponentButton(tester);

    final updatedState = container.read(projectStateProvider);
    expect(updatedState?.events, hasLength(1));
    expect(
      find.text('Lisatud (idempotentne kordus).'),
      findsOneWidget,
    );
  });

  testWidgets('forbidden wording and unrelated write paths are absent',
      (tester) async {
    await _pumpAddComponentScreen(tester);

    for (final label in const [
      'Run AI',
      'Detect',
      'Promote',
      'Muuda komponendi andmeid',
      'Board Canvas',
      'Reference Images',
      'Activity Timeline',
      'Measure Momentum',
      'verified',
      'good',
      'correct',
      'diagnosis',
      'probability',
      'fault',
    ]) {
      expect(find.text(label), findsNothing, reason: 'Unexpected label $label');
    }

    final source = File(
      'lib/features/components/screens/add_component_screen.dart',
    ).readAsStringSync();
    for (final forbiddenSource in const [
      'writeAsString',
      'known_facts.json',
      'board_graph.json',
      'view_state.json',
      'export_project_zip',
      'materialize_known_facts',
      'runAi',
      'detect',
      'promote',
      'confidence',
      'diagnosis',
    ]) {
      expect(
        source.contains(forbiddenSource),
        isFalse,
        reason: 'Unexpected source token $forbiddenSource',
      );
    }
  });
}
