import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:trace_bench_viewer/app/app.dart';
import 'package:trace_bench_viewer/app/router.dart';
import 'package:trace_bench_viewer/features/project/screens/project_overview_screen.dart';
import 'package:trace_bench_viewer/shared/models/known_facts.dart';
import 'package:trace_bench_viewer/shared/models/project_manifest.dart';
import 'package:trace_bench_viewer/shared/models/project_state.dart';
import 'package:trace_bench_viewer/shared/models/trace_bench_event.dart';
import 'package:trace_bench_viewer/shared/widgets/projection_stale_banner.dart';

ProjectState _inlineProjectState({
  bool isProjectionStale = false,
  List<TraceBenchEvent> events = const [],
}) {
  return ProjectState(
    manifest: ProjectManifest.fromJson({
      'project_id': 'inline_project',
      'schema_version': '1.0',
      'created_at': '2026-05-22T00:00:00Z',
      'device_type': 'pelle',
      'model': 'PV20',
      'symptom': 'not_provided',
    }),
    knownFacts: KnownFacts.fromJson({
      'project_id': 'inline_project',
      'components': [
        {'component_id': 'Q2', 'status': 'identified', 'designator': 'Q2'},
      ],
      'pins': [
        {'component_id': 'Q2', 'pin_id': 'Q2.1'},
      ],
      'measurements': [
        {
          'measurement_id': 'M001',
          'mode': 'continuity',
          'from': 'Q2.1',
          'to': 'R17.1',
          'reading': {'kind': 'numeric', 'value': 1, 'unit': 'ohm'},
          'power_state': 'off',
          'origin_event_id': 'evt_000001',
          'validity_status': 'active',
        },
      ],
      'component_pin_index': {
        'Q2': ['Q2.1'],
      },
    }),
    events: events,
    customerReport: 'Inline sample report',
  ).copyWith(isProjectionStale: isProjectionStale);
}

Future<ProviderContainer> _pumpProjectOverview(
  WidgetTester tester, {
  required ProjectState projectState,
  String initialLocation = '/project',
  bool useRouter = true,
}) async {
  final container = ProviderContainer();
  container.read(projectStateProvider.notifier).state = projectState;
  container.read(beginnerModeProvider.notifier).state = false;

  final Widget app = useRouter
      ? MaterialApp.router(
          routerConfig: buildTraceBenchRouter(initialLocation: initialLocation),
        )
      : const MaterialApp(home: ProjectOverviewScreen());

  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: app,
    ),
  );
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 100));

  return container;
}

void main() {
  testWidgets('shows stale projection banner when stale', (tester) async {
    final projectState = _inlineProjectState(isProjectionStale: true);
    await _pumpProjectOverview(
      tester,
      projectState: projectState,
      useRouter: false,
    );

    expect(find.text(ProjectionStaleBanner.primaryText), findsOneWidget);
    expect(find.text(ProjectionStaleBanner.passiveTagText), findsOneWidget);
    expect(find.text(ProjectionStaleBanner.secondaryText), findsOneWidget);
    expect(find.text('Kokkuvõte'), findsNothing);
  });

  testWidgets('renders PCB-first shell hierarchy and primary action', (tester) async {
    final projectState = _inlineProjectState(isProjectionStale: false);
    await _pumpProjectOverview(
      tester,
      projectState: projectState,
      useRouter: false,
    );

    final primaryMeasurementAction = find.byKey(
      const ValueKey('overview-measurement-record-button'),
    );
    final addComponentAction = find.byKey(
      const ValueKey('overview-add-component-button'),
    );

    expect(primaryMeasurementAction, findsOneWidget);
    expect(addComponentAction, findsOneWidget);
    expect(find.text('PCB-first context'), findsOneWidget);
    expect(find.text('Lisa mõõtmine'), findsOneWidget);
    expect(find.text('Quick actions'), findsOneWidget);

    expect(
      tester.getTopLeft(primaryMeasurementAction).dy,
      lessThan(tester.getTopLeft(addComponentAction).dy),
      reason:
          'Primary Lisa mõõtmine action must be visually above secondary Add Component action.',
    );
    expect(tester.widget<OutlinedButton>(addComponentAction), isA<OutlinedButton>());
    expect(tester.widget<OutlinedButton>(
        find.byKey(const ValueKey('overview-edit-component-button'))),
      isA<OutlinedButton>(),
    );
  });

  testWidgets('renders key project overview fields', (tester) async {
    final projectState = _inlineProjectState(isProjectionStale: false);
    await _pumpProjectOverview(
      tester,
      projectState: projectState,
      useRouter: false,
    );

    expect(
      find.textContaining(
        '${projectState.manifest.deviceType} · ${projectState.manifest.model}',
      ),
      findsOneWidget,
    );
    expect(
      find.textContaining(projectState.manifest.projectId),
      findsOneWidget,
    );
    expect(find.text(ProjectionStaleBanner.primaryText), findsNothing);
    expect(find.text('PCB-first context'), findsOneWidget);
    expect(find.text('Lisa mõõtmine'), findsOneWidget);
    expect(find.text('Add Component'), findsOneWidget);
    expect(find.text('Edit Component'), findsOneWidget);
    expect(find.byKey(const ValueKey('overview-reference-images-button')), findsOneWidget);
    expect(find.byKey(const ValueKey('overview-measurement-record-button')), findsOneWidget);
    expect(find.byKey(const ValueKey('overview-measure-sheet-button')), findsOneWidget);
    expect(find.byKey(const ValueKey('overview-add-component-button')), findsOneWidget);
    expect(find.byKey(const ValueKey('overview-edit-component-button')), findsOneWidget);
    expect(find.byKey(const ValueKey('overview-photos-button')), findsOneWidget);
    expect(find.byKey(const ValueKey('overview-board-canvas-button')), findsOneWidget);
  });

  testWidgets('overview has Add Component action and navigates to Add Component screen', (tester) async {
    final projectState = _inlineProjectState(isProjectionStale: false);
    await _pumpProjectOverview(
      tester,
      projectState: projectState,
      initialLocation: '/project',
      useRouter: true,
    );
    await tester.pumpAndSettle();

    final addComponentAction = find.byKey(
      const ValueKey('overview-add-component-button'),
    );
    expect(addComponentAction, findsOneWidget);
    await tester.ensureVisible(addComponentAction);
    await tester.tap(addComponentAction);
    await tester.pumpAndSettle();

    expect(find.text('Add Component'), findsAtLeastNWidgets(1));
    expect(
      find.text('Creates component_created only after explicit human action.'),
      findsOneWidget,
    );
  });

  testWidgets('overview has Edit Component action and navigates to Edit Component screen', (tester) async {
    final projectState = _inlineProjectState(isProjectionStale: false);
    await _pumpProjectOverview(
      tester,
      projectState: projectState,
      initialLocation: '/project',
      useRouter: true,
    );
    await tester.pumpAndSettle();

    final editComponentAction = find.byKey(
      const ValueKey('overview-edit-component-button'),
    );
    expect(editComponentAction, findsOneWidget);
    await tester.ensureVisible(editComponentAction);
    await tester.tap(editComponentAction);
    await tester.pumpAndSettle();

    expect(find.text('Edit Component'), findsAtLeastNWidgets(1));
    expect(
      find.text('Creates component_updated only after explicit human action.'),
      findsOneWidget,
    );
    expect(
      find.text('Edits existing components only; no new component is created.'),
      findsOneWidget,
    );
  });

  testWidgets('overview has Board Canvas action and navigates to Board Canvas screen', (tester) async {
    final projectState = _inlineProjectState(isProjectionStale: false);
    await _pumpProjectOverview(
      tester,
      projectState: projectState,
      initialLocation: '/project',
      useRouter: true,
    );
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('overview-board-canvas-button')), findsOneWidget);
    expect(find.byKey(const ValueKey('overview-reference-images-button')), findsOneWidget);
    expect(find.text('Board Canvas'), findsOneWidget);
    expect(find.text('Reference Images'), findsOneWidget);

    const forbiddenActions = [
      'Confirm',
      'Save',
      'Apply',
      'Edit alignment',
      'Confirm alignment',
      'Add reference point',
      'Run AI',
    ];
    for (final action in forbiddenActions) {
      expect(find.text(action), findsNothing, reason: 'Unexpected label: $action');
    }

    final boardCanvasAction = find.byKey(
      const ValueKey('overview-board-canvas-button'),
    );
    await tester.dragUntilVisible(
      boardCanvasAction,
      find.byType(Scrollable).last,
      const Offset(0, -300),
    );
    await tester.tap(boardCanvasAction, warnIfMissed: false);
    await tester.pumpAndSettle();

    expect(find.text('Board Canvas'), findsAtLeastNWidgets(1));
  });

  testWidgets('overview has Reference Images action and navigates to Reference Images screen', (tester) async {
    final projectState = _inlineProjectState(isProjectionStale: false);
    await _pumpProjectOverview(
      tester,
      projectState: projectState,
      initialLocation: '/project',
      useRouter: true,
    );
    await tester.pumpAndSettle();

    final referenceImagesAction = find.byKey(
      const ValueKey('overview-reference-images-button'),
    );
    expect(referenceImagesAction, findsOneWidget);
    await tester.ensureVisible(referenceImagesAction);
    await tester.tap(referenceImagesAction);
    await tester.pumpAndSettle();

    expect(find.text('Reference Images'), findsAtLeastNWidgets(1));
    expect(find.text('reference only'), findsOneWidget);
  });

  testWidgets('overview has Measure Sheet action and navigates to read-only shell', (tester) async {
    final projectState = _inlineProjectState(isProjectionStale: false);
    await _pumpProjectOverview(
      tester,
      projectState: projectState,
      initialLocation: '/project',
      useRouter: true,
    );
    await tester.pumpAndSettle();

    final measureSheetAction = find.byKey(
      const ValueKey('overview-measure-sheet-button'),
    );
    expect(measureSheetAction, findsOneWidget);
    await tester.ensureVisible(measureSheetAction);
    await tester.tap(measureSheetAction);
    await tester.pumpAndSettle();

    expect(find.text('Measure Sheet'), findsAtLeastNWidgets(1));
    expect(find.text('Koht → Väärtus → Ühik → Salvesta'), findsOneWidget);
    expect(find.text('renderer writes: none'), findsOneWidget);
  });

  testWidgets('legacy "Lisa mõõtmine" action navigates to Measure Sheet path', (tester) async {
    final projectState = _inlineProjectState(isProjectionStale: false);
    await _pumpProjectOverview(
      tester,
      projectState: projectState,
      initialLocation: '/project',
      useRouter: true,
    );
    await tester.pumpAndSettle();

    final legacyMeasurementAction = find.byKey(
      const ValueKey('overview-measurement-record-button'),
    );
    expect(legacyMeasurementAction, findsOneWidget);
    await tester.ensureVisible(legacyMeasurementAction);
    await tester.tap(legacyMeasurementAction);
    await tester.pumpAndSettle();

    expect(find.text('Measure Sheet'), findsAtLeastNWidgets(1));
    expect(find.text('Koht → Väärtus → Ühik → Salvesta'), findsOneWidget);
    expect(find.byKey(const ValueKey('measurement-from-field')), findsNothing);
    expect(find.byKey(const ValueKey('measurement-to-field')), findsNothing);
  });

  testWidgets(
      'legacy route /project/measurements/new redirects to Measure Sheet', (tester) async {
    final projectState = _inlineProjectState(isProjectionStale: false);
    await _pumpProjectOverview(
      tester,
      projectState: projectState,
      initialLocation: '/project/measurements/new',
      useRouter: true,
    );
    await tester.pumpAndSettle();

    expect(find.text('Measure Sheet'), findsOneWidget);
    expect(
      find.text('Koht → Väärtus → Ühik → Salvesta'),
      findsAtLeastNWidgets(1),
    );
    expect(
      find.byKey(const ValueKey('measurement-submit-button')),
      findsNothing,
    );
    expect(find.text('Salvesta sündmus'), findsNothing);
  });

  testWidgets(
      'overview shell rendering and Measure Sheet navigation does not mutate project events', (
    tester,
  ) async {
    final seededEvent = TraceBenchEvent(
      schemaVersion: '2.0.0',
      eventId: 'evt-overview-readonly',
      projectId: 'inline_project',
      sequence: 1,
      createdAt: '2026-05-22T00:00:00Z',
      actor: const {'source': 'overview-readonly-test'},
      eventType: 'measurement_recorded',
      status: 'accepted',
      payload: const {},
    );
    final projectState = _inlineProjectState(
      isProjectionStale: false,
      events: [seededEvent],
    );
    final container = await _pumpProjectOverview(
      tester,
      projectState: projectState,
      initialLocation: '/project',
      useRouter: true,
    );
    await tester.pumpAndSettle();

    final initialEvents = List<TraceBenchEvent>.from(
      container.read(projectStateProvider)!.events,
    );

    final measureSheetAction = find.byKey(
      const ValueKey('overview-measurement-record-button'),
    );
    expect(measureSheetAction, findsOneWidget);
    await tester.ensureVisible(measureSheetAction);
    await tester.tap(measureSheetAction);
    await tester.pumpAndSettle();

    expect(container.read(projectStateProvider)!.events, equals(initialEvents));
  });
}
