import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:trace_bench_viewer/app/app.dart';
import 'package:trace_bench_viewer/features/components/screens/edit_component_screen.dart';
import 'package:trace_bench_viewer/features/components/services/v2_edit_component_writer.dart';
import 'package:trace_bench_viewer/shared/models/known_facts.dart';
import 'package:trace_bench_viewer/shared/models/project_manifest.dart';
import 'package:trace_bench_viewer/shared/models/project_state.dart';
import 'package:trace_bench_viewer/shared/models/trace_bench_event.dart';

class _FakeEditComponentWriter implements V2EditComponentWriter {
  _FakeEditComponentWriter({
    this.status = V2EditComponentWriteStatus.appended,
    this.failureKind,
    this.eventId = 'evt_000200',
  });

  final V2EditComponentWriteStatus status;
  final V2EditComponentFailureKind? failureKind;
  final String eventId;
  final List<V2EditComponentRequest> requests = <V2EditComponentRequest>[];

  @override
  Future<V2EditComponentResult> editComponent({
    required ProjectState projectState,
    required V2EditComponentRequest request,
  }) async {
    requests.add(request);
    final failure = failureKind;
    if (failure != null) {
      throw V2EditComponentException(failure, 'fake writer failure');
    }
    return V2EditComponentResult(
      status: status,
      event: _componentUpdatedEvent(
        eventId: eventId,
        projectId: projectState.manifest.projectId,
        request: request,
      ),
      appended: status == V2EditComponentWriteStatus.appended,
    );
  }
}

ProjectState _inlineProjectState({
  List<TraceBenchEvent> events = const [],
  bool includeComponents = true,
}) {
  return ProjectState(
    manifest: const ProjectManifest(
      projectId: 'edit_component_project',
      schemaVersion: '1.0',
      createdAt: '2026-05-22T00:00:00Z',
      deviceType: 'bench_board',
      model: 'PV20',
      symptom: 'not_provided',
    ),
    knownFacts: KnownFacts.fromJson({
      'project_id': 'edit_component_project',
      'components': includeComponents
          ? [
              {
                'component_id': 'Q2',
                'designator': 'Q2',
                'type': 'unknown',
                'package': 'SOT-23',
                'status': 'unknown',
              },
            ]
          : const [],
      'pins': const [],
      'measurements': const [],
      'component_pin_index': const <String, dynamic>{},
    }),
    events: events,
    customerReport: 'Inline report',
    projectDirectory: 'C:\\tracebench_fake_project',
  );
}

Map<String, dynamic> _componentUpdatedEvent({
  required String eventId,
  required String projectId,
  required V2EditComponentRequest request,
}) {
  return {
    'schema_version': '2.0-draft',
    'event_id': eventId,
    'event_type': 'component_updated',
    'created_at': '2026-06-09T11:00:00.000Z',
    'project_id': projectId,
    'client_operation_id': request.clientOperationId,
    'actor': {'type': 'human', 'id': 'local_operator'},
    'source': {
      'type': 'explicit_user_confirmation',
      'surface': 'edit_component',
      'action': 'edit_component',
    },
    'confirmation': {'confirmed': true},
    'payload': {
      'component_id': request.componentId,
      'edit_reason': request.editReason,
      'changes': request.changes.map((change) => change.toJson()).toList(),
    },
  };
}

Future<ProviderContainer> _pumpEditComponentScreen(
  WidgetTester tester, {
  ProjectState? projectState,
  _FakeEditComponentWriter? writer,
}) async {
  final container = ProviderContainer(
    overrides: [
      projectStateProvider
          .overrideWith((_) => projectState ?? _inlineProjectState()),
      v2EditComponentWriterProvider
          .overrideWithValue(writer ?? _FakeEditComponentWriter()),
    ],
  );
  addTearDown(container.dispose);

  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: const MaterialApp(home: EditComponentScreen()),
    ),
  );
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 100));
  return container;
}

ElevatedButton _editButton(WidgetTester tester) {
  return tester.widget<ElevatedButton>(
      find.byKey(const ValueKey('edit-component-button')));
}

Future<void> _selectQ2(WidgetTester tester) async {
  await tester
      .tap(find.byKey(const ValueKey('edit-component-select-dropdown')));
  await tester.pumpAndSettle();
  await tester.tap(find.text('Q2').last);
  await tester.pump();
}

Future<void> _fillConfirmedLabelChange(WidgetTester tester) async {
  await _selectQ2(tester);
  await tester.enterText(
      find.byKey(const ValueKey('edit-component-label-field')),
      'Q2 transistor');
  await _confirmEdit(tester);
}

Future<void> _confirmEdit(WidgetTester tester) async {
  final checkbox = tester.widget<CheckboxListTile>(
    find.byKey(const ValueKey('edit-component-confirm-checkbox')),
  );
  expect(checkbox.onChanged, isNotNull);
  checkbox.onChanged!(true);
  await tester.pump();
}

Future<void> _tapEditComponentButton(WidgetTester tester) async {
  final onPressed = _editButton(tester).onPressed;
  expect(onPressed, isNotNull);
  onPressed!();
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 100));
}

void main() {
  testWidgets('renders Edit Component safety copy and starts disabled',
      (tester) async {
    await _pumpEditComponentScreen(tester);

    expect(find.text('Edit Component'), findsAtLeastNWidgets(1));
    expect(find.text('Human is the sensor. AI is the graph engine.'),
        findsOneWidget);
    expect(
        find.text(
            'Creates component_updated only after explicit human confirmation.'),
        findsOneWidget);
    expect(
        find.text(
            'Edits existing components only; no new component is created.'),
        findsOneWidget);
    await tester.drag(find.byType(ListView), const Offset(0, -600));
    await tester.pump();
    expect(find.textContaining('hint/context only'), findsOneWidget);
    expect(find.textContaining('do not confirm component identity'),
        findsOneWidget);
    expect(_editButton(tester).onPressed, isNull);
  });

  testWidgets(
      'Edit button is disabled until existing component and confirmed changes exist',
      (tester) async {
    await _pumpEditComponentScreen(tester);

    expect(_editButton(tester).onPressed, isNull);
    await _selectQ2(tester);
    expect(_editButton(tester).onPressed, isNull);
    await tester.enterText(
        find.byKey(const ValueKey('edit-component-label-field')),
        'Q2 transistor');
    await tester.pump();
    expect(_editButton(tester).onPressed, isNull);
    await _confirmEdit(tester);
    expect(_editButton(tester).onPressed, isNotNull);
  });

  testWidgets('valid Edit Component calls writer once and appends local event',
      (tester) async {
    final writer = _FakeEditComponentWriter(eventId: 'evt_000200');
    final container = await _pumpEditComponentScreen(tester, writer: writer);

    await _selectQ2(tester);
    await tester.enterText(
        find.byKey(const ValueKey('edit-component-label-field')),
        'Q2 transistor');
    await tester.enterText(
        find.byKey(const ValueKey('edit-component-reference-field')), 'Q2A');
    await tester.enterText(
        find.byKey(const ValueKey('edit-component-reason-field')),
        'human_label_clarity');
    await _confirmEdit(tester);
    await _tapEditComponentButton(tester);

    expect(writer.requests, hasLength(1));
    final request = writer.requests.single;
    expect(request.componentId, 'Q2');
    expect(request.editReason, 'human_label_clarity');
    expect(request.clientOperationId, startsWith('edit_component_Q2'));
    expect(request.changes.map((change) => change.field),
        containsAll(['label', 'reference_designator']));
    expect(request.changes.map((change) => change.changeKind).toSet(),
        {'replace'});

    final updatedState = container.read(projectStateProvider);
    expect(updatedState?.events, hasLength(1));
    expect(updatedState?.events.single.eventType, 'component_updated');
    expect(updatedState?.isProjectionStale, isTrue);
    expect(find.text('Edited component saved to events.jsonl'), findsOneWidget);
  });

  testWidgets('writer validation failure shows not-saved outcome',
      (tester) async {
    await _pumpEditComponentScreen(
      tester,
      writer: _FakeEditComponentWriter(
          failureKind: V2EditComponentFailureKind.validation),
    );

    await _fillConfirmedLabelChange(tester);
    await _tapEditComponentButton(tester);

    expect(find.text('Not saved: validation failed.'), findsOneWidget);
  });

  testWidgets('writer append path and lock failures show not-saved outcomes',
      (tester) async {
    for (final entry in <V2EditComponentFailureKind, String>{
      V2EditComponentFailureKind.append: 'Not saved: writer append failed.',
      V2EditComponentFailureKind.invalidProjectDirectory:
          'Not saved: project path is invalid.',
      V2EditComponentFailureKind.lockConflict:
          'Not saved: writer is busy, retry.',
    }.entries) {
      await _pumpEditComponentScreen(
        tester,
        writer: _FakeEditComponentWriter(failureKind: entry.key),
      );
      await _fillConfirmedLabelChange(tester);
      await _tapEditComponentButton(tester);
      expect(find.text(entry.value), findsOneWidget);
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();
    }
  });

  testWidgets('idempotent existing result does not duplicate local events',
      (tester) async {
    const existing = TraceBenchEvent(
      schemaVersion: '2.0-draft',
      eventId: 'evt_000200',
      projectId: 'edit_component_project',
      sequence: 0,
      createdAt: '2026-06-09T11:00:00.000Z',
      actor: {'type': 'human', 'id': 'local_operator'},
      eventType: 'component_updated',
      status: 'accepted',
      payload: {
        'component_id': 'Q2',
        'edit_reason': 'human_label_clarity',
        'changes': [],
      },
    );
    final container = await _pumpEditComponentScreen(
      tester,
      projectState: _inlineProjectState(events: const [existing]),
      writer:
          _FakeEditComponentWriter(status: V2EditComponentWriteStatus.existing),
    );

    await _fillConfirmedLabelChange(tester);
    await _tapEditComponentButton(tester);

    final updatedState = container.read(projectStateProvider);
    expect(updatedState?.events, hasLength(1));
    expect(
        find.text(
            'Edited component saved to events.jsonl (existing idempotent retry).'),
        findsOneWidget);
  });

  testWidgets('forbidden wording and unrelated write paths are absent',
      (tester) async {
    await _pumpEditComponentScreen(tester);

    for (final label in const [
      'Run AI',
      'Detect',
      'Promote',
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

    final source =
        File('lib/features/components/screens/edit_component_screen.dart')
            .readAsStringSync();
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
      expect(source.contains(forbiddenSource), isFalse,
          reason: 'Unexpected source token $forbiddenSource');
    }
  });
}
