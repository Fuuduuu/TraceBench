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
  List<Map<String, dynamic>> componentVisualPlacements = const [],
  String projectId = 'inline_project',
  String deviceType = 'pelle',
  String model = 'PV20',
  String symptom = 'not_provided',
}) {
  final Map<String, dynamic> knownFactsJson = {
    'project_id': projectId,
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
  };

  if (componentVisualPlacements.isNotEmpty) {
    knownFactsJson['component_visual_placements'] = componentVisualPlacements;
  }

  return ProjectState(
    manifest: ProjectManifest.fromJson({
      'project_id': projectId,
      'schema_version': '1.0',
      'created_at': '2026-05-22T00:00:00Z',
      'device_type': deviceType,
      'model': model,
      'symptom': symptom,
    }),
    knownFacts: KnownFacts.fromJson(knownFactsJson),
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

List<Map<String, dynamic>> _normalizedPlacementFacts() {
  return const [
    {
      'component_id': 'Q2',
      'coordinate_space': 'board_normalized',
      'board_side': 'top',
      'center_x': 0.42,
      'center_y': 0.56,
      'rotation_deg': 0,
      'status': 'confirmed',
    },
  ];
}

void main() {
  testWidgets('shows stale projection banner when projection is stale',
      (tester) async {
    final projectState = _inlineProjectState(isProjectionStale: true);
    await _pumpProjectOverview(
      tester,
      projectState: projectState,
      useRouter: false,
    );

    expect(find.text(ProjectionStaleBanner.primaryText), findsOneWidget);
    expect(find.text(ProjectionStaleBanner.passiveTagText), findsOneWidget);
    expect(find.text(ProjectionStaleBanner.secondaryText), findsOneWidget);
  });

  testWidgets('renders workbench-first shell with dominant primary action',
      (tester) async {
    final projectState = _inlineProjectState();
    await _pumpProjectOverview(
      tester,
      projectState: projectState,
      useRouter: false,
    );

    final workbenchZone = find.byKey(const ValueKey('overview-workbench-zone'));
    final actionsPanel = find.byKey(const ValueKey('overview-actions-panel'));
    final darkShell = find.byKey(const ValueKey('overview-dark-eda-shell'));
    final primaryMeasurementAction = find.byKey(
      const ValueKey('overview-measurement-record-button'),
    );
    final secondaryAction = find.byKey(
      const ValueKey('overview-add-component-button'),
    );

    expect(workbenchZone, findsOneWidget);
    expect(actionsPanel, findsOneWidget);
    expect(darkShell, findsOneWidget);
    expect(primaryMeasurementAction, findsOneWidget);
    expect(secondaryAction, findsOneWidget);

    final shellWidget = tester.widget<Material>(darkShell);
    expect(shellWidget.color, const Color(0xFF0A0D11));
    final appBar = tester.widget<AppBar>(find.byType(AppBar));
    expect(appBar.backgroundColor, const Color(0xFF161B22));

    expect(
      tester.getTopLeft(actionsPanel).dy,
      greaterThan(tester.getTopLeft(workbenchZone).dy),
    );
    expect(
      tester.getTopLeft(primaryMeasurementAction).dy,
      lessThan(tester.getTopLeft(secondaryAction).dy),
    );
    expect(find.text('BenchBeep Workbench'), findsOneWidget);
    expect(find.text('Töölaud nr 1'), findsOneWidget);
    expect(find.text('Kohalik töölaud · ainult vaatamine'), findsOneWidget);
    expect(find.text('Lisa mõõtmine'), findsOneWidget);
    expect(
        find.byKey(const ValueKey('overview-menu-breadcrumb')), findsOneWidget);
    expect(find.byKey(const ValueKey('overview-home-menu-button')),
        findsOneWidget);
    expect(find.byKey(const ValueKey('overview-menu-disabled-affordance')),
        findsOneWidget);
    expect(find.text('BenchBeep'), findsOneWidget);
    expect(find.text('Töölaud'), findsOneWidget);
    expect(find.text('Ülevaade'), findsOneWidget);
    expect(find.text('Tulevased menüüvalikud väljas'), findsOneWidget);
    expect(find.text('Workbench'), findsNothing);
    expect(find.text('Overview'), findsNothing);
    expect(find.text('Future menu items disabled'), findsNothing);
    expect(find.byKey(const ValueKey('overview-workbench-board-preview')),
        findsNothing);
    expect(find.textContaining('Command menu'), findsNothing);
    expect(find.textContaining('Ctrl-K'), findsNothing);
    expect(find.textContaining('Save beep'), findsNothing);
    expect(find.textContaining('project_id:'), findsNothing);
    expect(find.textContaining('schema_version:'), findsNothing);
    expect(find.textContaining('created_at:'), findsNothing);
    expect(find.textContaining('Read-only projection:'), findsNothing);
    expect(find.text('READ ONLY'), findsNothing);
    expect(find.text('AINULT VAATAMINE'), findsOneWidget);
  });

  testWidgets('renders compact status strip for board statistics',
      (tester) async {
    final projectState = _inlineProjectState(
      componentVisualPlacements: _normalizedPlacementFacts(),
    );
    await _pumpProjectOverview(
      tester,
      projectState: projectState,
      useRouter: false,
    );

    expect(find.byKey(const ValueKey('overview-status-strip')), findsOneWidget);
    expect(find.text('Kõik komponendid'), findsOneWidget);
    expect(find.text('Mõõtmised'), findsOneWidget);
    expect(find.text('Aktiivne'), findsOneWidget);
    expect(find.text('Aegunud'), findsOneWidget);
    expect(find.text('Pole paigaldatud'), findsOneWidget);
  });

  testWidgets('wide layout makes the workbench zone visually dominant',
      (tester) async {
    final projectState = _inlineProjectState(
      componentVisualPlacements: _normalizedPlacementFacts(),
    );
    await tester.binding.setSurfaceSize(const Size(1400, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await _pumpProjectOverview(
      tester,
      projectState: projectState,
      useRouter: false,
    );

    final workbenchZoneRect =
        tester.getRect(find.byKey(const ValueKey('overview-workbench-zone')));
    final actionsPanelRect =
        tester.getRect(find.byKey(const ValueKey('overview-actions-panel')));

    expect(workbenchZoneRect.width, greaterThan(actionsPanelRect.width * 2.0));
  });

  testWidgets('wide density layout gives board preview room and compacts rail',
      (tester) async {
    final projectState = _inlineProjectState(
      componentVisualPlacements: _normalizedPlacementFacts(),
    );
    await tester.binding.setSurfaceSize(const Size(1400, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await _pumpProjectOverview(
      tester,
      projectState: projectState,
      useRouter: false,
    );

    final workbenchZoneRect = tester.getRect(
      find.byKey(const ValueKey('overview-workbench-zone')),
    );
    final actionsPanelRect = tester.getRect(
      find.byKey(const ValueKey('overview-actions-panel')),
    );
    final boardPreviewRect = tester.getRect(
      find.byKey(const ValueKey('overview-workbench-board-preview')),
    );

    expect(actionsPanelRect.width, lessThanOrEqualTo(260));
    expect(workbenchZoneRect.width, greaterThan(actionsPanelRect.width * 4));
    expect(boardPreviewRect.height, greaterThanOrEqualTo(430));
  });

  testWidgets('renders sparse-placement workbench placeholder state',
      (tester) async {
    final projectState = _inlineProjectState();
    await _pumpProjectOverview(
      tester,
      projectState: projectState,
      useRouter: false,
    );

    expect(find.text('PCB/töölaua kohatäide'), findsOneWidget);
    expect(
      find.text(
          'Kinnitatud plaadipaigutusi veel pole. Töölaud ootab foto- või projektitõendeid.'),
      findsOneWidget,
    );
    expect(find.text('Kontekst ja liikumine on säilinud.'), findsOneWidget);
    expect(find.text('PCB/workbench placeholder'), findsNothing);
    expect(
      find.text(
          'No confirmed board placements yet. The workbench is open and awaiting evidence from photo/project evidence capture.'),
      findsNothing,
    );
    expect(
        find.text('Context and route behavior are preserved.'), findsNothing);
    expect(find.textContaining('Read-only projection:'), findsNothing);
    expect(find.byKey(const ValueKey('overview-workbench-board-preview')),
        findsNothing);
  });

  testWidgets(
      'renders read-only board canvas when normalized placements are available',
      (tester) async {
    final projectState = _inlineProjectState(
      componentVisualPlacements: _normalizedPlacementFacts(),
    );
    await _pumpProjectOverview(
      tester,
      projectState: projectState,
      useRouter: false,
    );

    expect(find.byKey(const ValueKey('overview-workbench-board-preview')),
        findsOneWidget);
    expect(find.textContaining('Read-only projection:'), findsNothing);
    expect(find.text('Töölaud nr 1'), findsOneWidget);
    expect(find.text('Plaadi tööala (ainult vaatamine)'), findsOneWidget);
    expect(
      find.text('Paigutuste kokkuvõte on ainult vaatamiseks ja lokaalne.'),
      findsOneWidget,
    );
    expect(find.text('Board workspace (read-only)'), findsNothing);
    expect(find.text('Placement summary is read-only and local only.'),
        findsNothing);
    expect(find.text('PCB/töölaua kohatäide'), findsNothing);
    expect(find.text('renderer writes: none'), findsOneWidget);
  });

  testWidgets('hides raw fixture identifiers from the visible shell',
      (tester) async {
    final projectState = _inlineProjectState(
      projectId: 'prj_board_canvas_smoke_001',
      deviceType: 'board_canvas_smoke_fixture',
      model: 'board_canvas_positive_smoke_rich',
      symptom: 'integrated_measure_panel_manual_smoke',
      componentVisualPlacements: _normalizedPlacementFacts(),
    );
    await _pumpProjectOverview(
      tester,
      projectState: projectState,
      useRouter: false,
    );

    expect(find.text('BenchBeep Workbench'), findsOneWidget);
    expect(find.text('Töölaud nr 1'), findsOneWidget);
    expect(find.byKey(const ValueKey('overview-workbench-board-preview')),
        findsOneWidget);
    expect(find.textContaining('board_canvas_smoke_fixture'), findsNothing);
    expect(
        find.textContaining('board_canvas_positive_smoke_rich'), findsNothing);
    expect(find.textContaining('integrated_measure_panel_manual_smoke'),
        findsNothing);
    expect(find.textContaining('prj_board_canvas_smoke_001'), findsNothing);
    expect(find.textContaining('project_id:'), findsNothing);
    expect(find.textContaining('schema_version:'), findsNothing);
    expect(find.textContaining('created_at:'), findsNothing);
  });

  testWidgets(
      'future tools are collapsed by default and remain inert when restored',
      (tester) async {
    final projectState = _inlineProjectState();
    await _pumpProjectOverview(
      tester,
      projectState: projectState,
      useRouter: false,
    );

    final inertButtons = [
      find.byKey(const ValueKey('overview-future-contour-button')),
      find.byKey(const ValueKey('overview-future-photo-button')),
      find.byKey(const ValueKey('overview-future-layers-button')),
      find.byKey(const ValueKey('overview-future-trace-colors-button')),
    ];

    expect(find.byKey(const ValueKey('overview-future-tools-panel')),
        findsOneWidget);
    expect(find.text('Tulevased tööriistad'), findsOneWidget);
    expect(find.text('Välja lülitatud'), findsOneWidget);
    expect(find.text('Future tools (tulekul)'), findsNothing);
    expect(find.text('Disabled'), findsNothing);
    for (final button in inertButtons) {
      expect(button, findsNothing);
    }

    final futureToolsPanel =
        find.byKey(const ValueKey('overview-future-tools-panel'));
    await tester.ensureVisible(futureToolsPanel);
    await tester.pump();
    await tester.tap(futureToolsPanel);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 250));

    for (final button in inertButtons) {
      expect(button, findsOneWidget);
      final widget = tester.widget<OutlinedButton>(button);
      expect(widget.onPressed, isNull);
    }
    expect(find.text('Kihid'), findsOneWidget);
    expect(find.text('Rajajoone värvid'), findsOneWidget);
    expect(find.text('Layers'), findsNothing);
    expect(find.text('Trace colors'), findsNothing);

    await tester.ensureVisible(futureToolsPanel);
    await tester.pump();
    await tester.tap(futureToolsPanel);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 250));

    for (final button in inertButtons) {
      expect(button, findsNothing);
    }
  });

  testWidgets('shows key action buttons and core metadata', (tester) async {
    final projectState = _inlineProjectState();
    await _pumpProjectOverview(
      tester,
      projectState: projectState,
      useRouter: false,
    );

    expect(find.byKey(const ValueKey('overview-measurement-record-button')),
        findsOneWidget);
    expect(find.text('Lisa mõõtmine'), findsOneWidget);
    expect(find.byKey(const ValueKey('overview-measure-sheet-button')),
        findsOneWidget);
    expect(find.byKey(const ValueKey('overview-add-component-button')),
        findsOneWidget);
    expect(find.byKey(const ValueKey('overview-edit-component-button')),
        findsOneWidget);
    expect(find.byKey(const ValueKey('overview-board-graph-button')),
        findsOneWidget);
    expect(find.byKey(const ValueKey('overview-board-canvas-button')),
        findsOneWidget);
    expect(find.byKey(const ValueKey('overview-reference-images-button')),
        findsOneWidget);
    expect(find.byKey(const ValueKey('overview-project-id')), findsOneWidget);
    expect(find.text('Loo komponent'), findsOneWidget);
    expect(find.text('Muuda komponendi andmeid'), findsOneWidget);
    expect(find.text('Board Canvas · visuaalne paigutus'), findsOneWidget);
    expect(find.text('Advanced graph · projection'), findsOneWidget);
    expect(find.text('Board graph view'), findsNothing);
  });

  testWidgets('uses polished Estonian copy in secondary shell actions',
      (tester) async {
    final projectState = _inlineProjectState();
    await _pumpProjectOverview(
      tester,
      projectState: projectState,
      useRouter: false,
    );

    final secondaryActions = find.text('Muud tegevused');
    expect(secondaryActions, findsOneWidget);
    await tester.ensureVisible(secondaryActions);
    await tester.tap(secondaryActions);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 250));

    expect(find.text('Teadaolevad faktid'), findsOneWidget);
    expect(find.text('Täitamata'), findsOneWidget);
    expect(find.text('Known facts'), findsNothing);
    expect(find.text('Not populated'), findsNothing);
  });

  testWidgets('legacy measurement action routes to measure sheet',
      (tester) async {
    final projectState = _inlineProjectState();
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
  });

  testWidgets(
      'legacy /project/measurements/new route remains compatibility redirect',
      (tester) async {
    final projectState = _inlineProjectState();
    await _pumpProjectOverview(
      tester,
      projectState: projectState,
      initialLocation: '/project/measurements/new',
      useRouter: true,
    );
    await tester.pumpAndSettle();

    expect(find.text('Measure Sheet'), findsAtLeastNWidgets(1));
    expect(
        find.text('Koht → Väärtus → Ühik → Salvesta'), findsAtLeastNWidgets(1));
  });

  testWidgets('/project/measure-sheet route resolves standalone measure sheet',
      (tester) async {
    final projectState = _inlineProjectState();
    await _pumpProjectOverview(
      tester,
      projectState: projectState,
      initialLocation: '/project/measure-sheet',
      useRouter: true,
    );
    await tester.pumpAndSettle();

    expect(find.text('Measure Sheet'), findsAtLeastNWidgets(1));
    expect(
        find.text('Koht → Väärtus → Ühik → Salvesta'), findsAtLeastNWidgets(1));
  });

  testWidgets('Add Component action navigates to add component screen',
      (tester) async {
    final projectState = _inlineProjectState();
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

    expect(find.text('Loo komponent'), findsAtLeastNWidgets(1));
  });

  testWidgets('Edit Component action navigates to edit component screen',
      (tester) async {
    final projectState = _inlineProjectState();
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

    expect(find.text('Muuda komponendi andmeid'), findsAtLeastNWidgets(1));
  });

  testWidgets('Board Canvas action navigates to board canvas screen',
      (tester) async {
    final projectState = _inlineProjectState();
    await _pumpProjectOverview(
      tester,
      projectState: projectState,
      initialLocation: '/project',
      useRouter: true,
    );
    await tester.pumpAndSettle();

    final boardCanvasAction =
        find.byKey(const ValueKey('overview-board-canvas-button'));
    expect(boardCanvasAction, findsOneWidget);

    await tester.ensureVisible(boardCanvasAction);
    await tester.tap(boardCanvasAction);
    await tester.pumpAndSettle();
    expect(find.text('Board Canvas'), findsAtLeastNWidgets(1));
  });

  testWidgets('Board Graph action remains reachable as advanced projection',
      (tester) async {
    final projectState = _inlineProjectState();
    await _pumpProjectOverview(
      tester,
      projectState: projectState,
      initialLocation: '/project',
      useRouter: true,
    );
    await tester.pumpAndSettle();

    final boardGraphAction =
        find.byKey(const ValueKey('overview-board-graph-button'));
    expect(boardGraphAction, findsOneWidget);
    expect(find.text('Advanced graph · projection'), findsOneWidget);

    await tester.ensureVisible(boardGraphAction);
    await tester.tap(boardGraphAction);
    await tester.pumpAndSettle();

    expect(find.text('Board graph'), findsOneWidget);
    expect(
      find.text(
        'Advanced/debug projection inspection · no canonical writes. '
        'Board Canvas is the primary board/workbench surface.',
      ),
      findsOneWidget,
    );
  });

  testWidgets('Board Canvas action does not mutate project events',
      (tester) async {
    const seededEvent = TraceBenchEvent(
      schemaVersion: '2.0.0',
      eventId: 'evt-overview-canvas-readonly',
      projectId: 'inline_project',
      sequence: 1,
      createdAt: '2026-05-22T00:00:00Z',
      actor: {'source': 'overview-canvas-readonly-test'},
      eventType: 'measurement_recorded',
      status: 'accepted',
      payload: {},
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

    final initialEvents = List<String>.from(
      container
          .read(projectStateProvider)!
          .events
          .map((event) => event.eventId),
    );

    final boardCanvasAction =
        find.byKey(const ValueKey('overview-board-canvas-button'));
    expect(boardCanvasAction, findsOneWidget);
    await tester.ensureVisible(boardCanvasAction);
    await tester.tap(boardCanvasAction);
    await tester.pumpAndSettle();

    expect(find.text('Board Canvas'), findsAtLeastNWidgets(1));

    final resultingEvents = List<String>.from(
      container
          .read(projectStateProvider)!
          .events
          .map((event) => event.eventId),
    );
    expect(resultingEvents, equals(initialEvents));
  });

  testWidgets('Reference Images action navigates to reference image screen',
      (tester) async {
    final projectState = _inlineProjectState();
    await _pumpProjectOverview(
      tester,
      projectState: projectState,
      initialLocation: '/project',
      useRouter: true,
    );
    await tester.pumpAndSettle();

    final referenceImagesAction =
        find.byKey(const ValueKey('overview-reference-images-button'));
    expect(referenceImagesAction, findsOneWidget);
    await tester.ensureVisible(referenceImagesAction);
    await tester.tap(referenceImagesAction);
    await tester.pumpAndSettle();
    expect(find.text('Reference Images'), findsAtLeastNWidgets(1));
  });

  testWidgets(
      'overview shell does not mutate project events on render or measurement navigation',
      (tester) async {
    const seededEvent = TraceBenchEvent(
      schemaVersion: '2.0.0',
      eventId: 'evt-overview-readonly',
      projectId: 'inline_project',
      sequence: 1,
      createdAt: '2026-05-22T00:00:00Z',
      actor: {'source': 'overview-readonly-test'},
      eventType: 'measurement_recorded',
      status: 'accepted',
      payload: {},
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

    final initialEvents = List<String>.from(
      container
          .read(projectStateProvider)!
          .events
          .map((event) => event.eventId),
    );

    final measureSheetAction = find.byKey(
      const ValueKey('overview-measurement-record-button'),
    );
    await tester.ensureVisible(measureSheetAction);
    await tester.tap(measureSheetAction);
    await tester.pumpAndSettle();

    final resultingEvents = List<String>.from(
      container
          .read(projectStateProvider)!
          .events
          .map((event) => event.eventId),
    );
    expect(resultingEvents, equals(initialEvents));
  });
}
