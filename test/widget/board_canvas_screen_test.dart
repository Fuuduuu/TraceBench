import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trace_bench_viewer/app/app.dart';
import 'package:trace_bench_viewer/features/board_canvas/screens/board_canvas_screen.dart';
import 'package:trace_bench_viewer/shared/models/known_facts.dart';
import 'package:trace_bench_viewer/shared/models/project_manifest.dart';
import 'package:trace_bench_viewer/shared/models/project_state.dart';

ProjectState _inlineProjectState({
  required List<ComponentFact> components,
  required List<ComponentVisualPlacementFact> placements,
  List<MeasurementFact> measurements = const [],
  List<VisualTraceFact> visualTraces = const [],
  List<PhotoToBoardAlignmentFact> photoToBoardAlignments = const [],
}) {
  return ProjectState(
    manifest: const ProjectManifest(
      projectId: 'proj_001',
      schemaVersion: '1.0.0',
      createdAt: '2026-01-01T00:00:00Z',
      deviceType: 'board',
      model: 'test',
      symptom: 'test',
    ),
    knownFacts: KnownFacts(
      projectId: 'proj_001',
      components: components,
      pins: const [],
      measurements: measurements,
      nets: const [],
      excludedFromFaultCandidates: const [],
      componentPinIndex: const {},
      photos: const [],
      damageRegions: const [],
      suspectRegions: const [],
      visualTraces: visualTraces,
      componentVisualPlacements: placements,
      photoToBoardAlignments: photoToBoardAlignments,
    ),
    events: const [],
    customerReport: '',
  );
}

Widget _harness({required ProjectState? projectState, Key? boardCanvasKey}) {
  return ProviderScope(
    overrides: [
      projectStateProvider.overrideWith((_) => projectState),
    ],
    child: MaterialApp(home: BoardCanvasScreen(key: boardCanvasKey)),
  );
}

Future<void> _selectPlacement(WidgetTester tester, String label) async {
  final chip = find.widgetWithText(ChoiceChip, label);
  if (chip.evaluate().isEmpty) {
    final placementDisclosureFinder =
        find.byKey(const Key('board_canvas_placement_selector_disclosure'));
    if (placementDisclosureFinder.evaluate().isNotEmpty) {
      await tester.tap(placementDisclosureFinder);
    } else {
      final railPlacementFinder =
          find.byKey(const Key('board_canvas_rail_placements_tool'));
      if (railPlacementFinder.evaluate().isNotEmpty) {
        await tester.tap(railPlacementFinder);
      }
    }
    await tester.pumpAndSettle();
    final reopenedChip = find.widgetWithText(ChoiceChip, label);
    if (reopenedChip.evaluate().isEmpty) {
      throw StateError('Placement chip "$label" not found after opening disclosure.');
    }
    await tester.ensureVisible(reopenedChip.first);
    await tester.pump();
    await tester.tap(reopenedChip.first);
    await tester.pump(const Duration(milliseconds: 16));
    return;
  }
  await tester.ensureVisible(chip.first);
  await tester.tap(chip.first);
  await tester.pump(const Duration(milliseconds: 16));
}

Future<void> _openSafetyEvidence(WidgetTester tester) async {
  final disclosureFinder =
      find.byKey(const Key('board_canvas_safety_evidence_disclosure'));
  if (disclosureFinder.evaluate().isEmpty) {
    final railSafetyFinder =
        find.byKey(const Key('board_canvas_rail_safety_evidence_tool'));
    if (railSafetyFinder.evaluate().isNotEmpty) {
      await tester.tap(railSafetyFinder);
      await tester.pumpAndSettle();
    }
  }

  final openDisclosure = find.byKey(const Key('board_canvas_safety_evidence_disclosure'));
  if (openDisclosure.evaluate().isNotEmpty &&
      find.text('Body outline').evaluate().isEmpty) {
    await tester.tap(openDisclosure);
    await tester.pumpAndSettle();
  }
}

Future<void> _openWideContextMode(WidgetTester tester, {required bool placements}) async {
  final placementsFinder = find.byKey(const Key('board_canvas_rail_placements_tool'));
  final safetyFinder = find.byKey(const Key('board_canvas_rail_safety_evidence_tool'));
  final target = placements ? placementsFinder : safetyFinder;
  if (target.evaluate().isEmpty) {
    throw StateError('Workbench rail tool not available in current layout');
  }
  await tester.tap(target);
  await tester.pump(const Duration(milliseconds: 16));
}

Future<void> _tapCanvasAtNormalized(
  WidgetTester tester, {
  required double x,
  required double y,
}) async {
  final painterFinder = find.byKey(const Key('board_canvas_painter'));
  final painterTopLeft = tester.getTopLeft(painterFinder);
  final painterSize = tester.getSize(painterFinder);
  await tester.tapAt(
    painterTopLeft + Offset(painterSize.width * x, painterSize.height * y),
  );
  await tester.pump(const Duration(milliseconds: 16));
}

void main() {
  const boardPlacement = ComponentVisualPlacementFact(
    componentId: 'cmp_r101',
    coordinateSpace: 'board_normalized',
    boardSide: 'top',
    centerX: 0.25,
    centerY: 0.45,
    rotationDeg: 15,
    scale: 1.2,
    templateId: 'sot23_3',
    sourceEventId: 'evt_000101',
    status: 'user_confirmed_visual',
  );

  const boardPlacementWidthHeight = ComponentVisualPlacementFact(
    componentId: 'cmp_u1',
    coordinateSpace: 'board_normalized',
    boardSide: 'bottom',
    centerX: 0.52,
    centerY: 0.61,
    rotationDeg: 90,
    width: 1.5,
    height: 0.8,
    templateId: 'unknown_rect',
    sourceEventId: 'evt_000102',
    status: 'user_confirmed_visual',
  );

  const photoLocalPlacement = ComponentVisualPlacementFact(
    componentId: 'cmp_photo',
    coordinateSpace: 'photo_local',
    boardSide: 'top',
    centerX: 140,
    centerY: 280,
    rotationDeg: 0,
    sourcePhotoId: 'ph_01',
    sourceEventId: 'evt_000103',
    status: 'user_confirmed_visual',
  );

  const q2Placement = ComponentVisualPlacementFact(
    componentId: 'Q2',
    coordinateSpace: 'board_normalized',
    boardSide: 'top',
    centerX: 0.12,
    centerY: 0.25,
    rotationDeg: 0,
    sourceEventId: 'evt_000200',
    status: 'user_confirmed_visual',
  );

  const readinessAlignment = PhotoToBoardAlignmentFact(
    alignmentId: 'ALN1001',
    sourcePhotoId: 'photo_top_001',
    boardSide: 'top',
    coordinateSpaceFrom: 'photo_local',
    coordinateSpaceTo: 'board_normalized',
    referencePointsPhoto: [
      AlignmentPointFact(x: 123.456, y: 789.123),
      AlignmentPointFact(x: 456.789, y: 321.987),
    ],
    referencePointsBoard: [
      AlignmentPointFact(x: 0.12, y: 0.34),
      AlignmentPointFact(x: 0.56, y: 0.78),
    ],
    transformType: 'similarity',
    alignmentQualityLabel: 'manual_reference_verified',
    sourceEventId: 'evt_alignment_001',
    status: 'user_confirmed_alignment',
  );
  const readinessAlignmentTwo = PhotoToBoardAlignmentFact(
    alignmentId: 'ALN1002',
    sourcePhotoId: 'photo_bottom_002',
    boardSide: 'bottom',
    coordinateSpaceFrom: 'photo_local',
    coordinateSpaceTo: 'board_normalized',
    referencePointsPhoto: [
      AlignmentPointFact(x: 654.321, y: 111.222),
      AlignmentPointFact(x: 333.444, y: 555.666),
      AlignmentPointFact(x: 777.888, y: 999.111),
    ],
    referencePointsBoard: [
      AlignmentPointFact(x: 0.11, y: 0.22),
      AlignmentPointFact(x: 0.33, y: 0.44),
      AlignmentPointFact(x: 0.55, y: 0.66),
    ],
    transformType: 'affine',
    alignmentQualityLabel: 'manual_reference_checked',
    sourceEventId: 'evt_alignment_002',
    status: 'user_confirmed_alignment',
  );

  testWidgets('shows no-project state when project is not loaded',
      (tester) async {
    await tester.pumpWidget(_harness(projectState: null));

    expect(find.text('Open a project to view its board.'), findsOneWidget);
    expect(find.text('renderer writes: none'), findsOneWidget);
  });

  testWidgets('shows no-components state when known facts have no components',
      (tester) async {
    await tester.pumpWidget(
      _harness(
        projectState:
            _inlineProjectState(components: const [], placements: const []),
      ),
    );

    expect(
      find.text('No components recorded for this project.'),
      findsOneWidget,
    );
  });

  testWidgets(
      'shows no-placements state when project has components but no placements',
      (tester) async {
    await tester.pumpWidget(
      _harness(
        projectState: _inlineProjectState(
          components: const [
            ComponentFact(componentId: 'cmp_r101', designator: 'R101'),
          ],
          placements: const [],
        ),
      ),
    );

    expect(find.text('No confirmed visual placements yet.'), findsOneWidget);
    expect(
      find.text(
        'Board canvas is read-only in V1. Placement workflow is a future step.',
      ),
      findsOneWidget,
    );
  });

  testWidgets(
      'renders board-normalized placement path and keeps read-only chrome',
      (tester) async {
    await tester.pumpWidget(
      _harness(
        projectState: _inlineProjectState(
          components: const [
            ComponentFact(componentId: 'cmp_r101', designator: 'R101'),
          ],
          placements: const [boardPlacement],
        ),
      ),
    );

    expect(find.byType(BoardCanvasScreen), findsOneWidget);
    expect(find.byKey(const Key('board_canvas_painter')), findsOneWidget);
    expect(find.byKey(const Key('board_canvas_control_band')), findsOneWidget);
    expect(
      find.text('Safety / Evidence'),
      findsOneWidget,
    );
    expect(find.text('No confirmed visual placements yet.'), findsNothing);
    expect(find.text('renderer writes: none'), findsOneWidget);
  });

  testWidgets('Board Canvas app bar keeps compact title chrome',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(1400, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      _harness(
        projectState: _inlineProjectState(
          components: const [
            ComponentFact(componentId: 'cmp_r101', designator: 'R101'),
          ],
          placements: const [boardPlacement],
        ),
      ),
    );

    final appBarSize = tester.getSize(find.byType(AppBar));

    expect(appBarSize.height, lessThanOrEqualTo(36));
    expect(find.text('Board Canvas'), findsOneWidget);
    expect(find.text('renderer writes: none'), findsOneWidget);
  });

  testWidgets('collapsed top control band stays compact and read-only',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(700, 700));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final state = _inlineProjectState(
      components: const [
        ComponentFact(componentId: 'cmp_r101', designator: 'R101'),
      ],
      placements: const [boardPlacement],
    );

    await tester.pumpWidget(_harness(projectState: state));
    await tester.pump(const Duration(milliseconds: 16));

    final controlBandSize =
        tester.getSize(find.byKey(const Key('board_canvas_control_band')));

    expect(controlBandSize.height, lessThanOrEqualTo(88));
    expect(find.text('Placements'), findsOneWidget);
    expect(find.text('1 placement available'), findsOneWidget);
    expect(find.text('Safety / Evidence'), findsOneWidget);
    expect(find.textContaining('read-only'), findsAtLeastNWidgets(1));
    expect(find.widgetWithText(ChoiceChip, 'R101 (cmp_r101)'), findsNothing);
    expect(find.text('renderer writes: none'), findsOneWidget);
    expect(state.events, isEmpty);
  });

  testWidgets('wide Workbench hides top disclosures and uses rail panel toggles',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(1400, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      _harness(
        projectState: _inlineProjectState(
          components: const [
            ComponentFact(componentId: 'cmp_r101', designator: 'R101'),
          ],
          placements: const [boardPlacement],
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 16));

    expect(find.byKey(const Key('board_canvas_painter')), findsOneWidget);
    expect(find.byKey(const Key('board_canvas_control_band')), findsNothing);
    expect(
      find.byKey(const Key('board_canvas_placement_selector_disclosure')),
      findsNothing,
    );
    expect(
      find.byKey(const Key('board_canvas_safety_evidence_disclosure')),
      findsNothing,
    );
    expect(
      find.byKey(const Key('board_canvas_inspector_toggle_button')),
      findsOneWidget,
    );
    expect(find.text('renderer writes: none'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
      'wide Workbench exposes left rail and shows context panel on disclosure mode',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(1400, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final state = _inlineProjectState(
      components: const [
        ComponentFact(componentId: 'cmp_r101', designator: 'R101'),
      ],
      placements: const [boardPlacement],
    );

    await tester.pumpWidget(_harness(projectState: state));
    await tester.pump(const Duration(milliseconds: 16));

    final shellFinder = find.byKey(const Key('board_canvas_workbench_shell'));
    final railFinder = find.byKey(const Key('board_canvas_workbench_rail'));
    final canvasZoneFinder =
        find.byKey(const Key('board_canvas_workbench_canvas_zone'));
    final contextFinder = find.byKey(const Key('board_canvas_context_panel'));

    expect(shellFinder, findsOneWidget);
    expect(railFinder, findsOneWidget);
    expect(canvasZoneFinder, findsOneWidget);
    expect(contextFinder, findsNothing);

    final railSize = tester.getSize(railFinder);
    final canvasZoneSize = tester.getSize(canvasZoneFinder);
    expect(canvasZoneSize.width, greaterThan(railSize.width * 4));
    expect(find.byKey(const Key('board_canvas_painter')), findsOneWidget);
    expect(find.byKey(const Key('board_canvas_context_panel')),
        findsNothing);
    expect(
      find.byKey(const Key('board_canvas_rail_placements_tool')),
      findsOneWidget,
    );
    expect(
      find.byKey(const Key('board_canvas_rail_safety_evidence_tool')),
      findsOneWidget,
    );
    expect(find.text('renderer writes: none'), findsOneWidget);

    final futureTraceTool = tester.widget<IconButton>(
      find.byKey(const Key('board_canvas_rail_future_trace_tool')),
    );
    final futureMapTool = tester.widget<IconButton>(
      find.byKey(const Key('board_canvas_rail_future_repair_map_tool')),
    );
    final focusButton = tester.widget<IconButton>(
      find.byKey(const Key('board_canvas_focus_toggle_button')),
    );
    final inspectorButton = tester.widget<IconButton>(
      find.byKey(const Key('board_canvas_inspector_toggle_button')),
    );

    expect(futureTraceTool.onPressed, isNull);
    expect(futureMapTool.onPressed, isNull);
    expect(futureTraceTool.tooltip, 'Trace map (future/readonly) - inactive');
    expect(futureMapTool.tooltip, 'Repair map (future) - inactive');
    expect(focusButton.onPressed, isNotNull);
    expect(focusButton.tooltip, 'Focus canvas');
    expect(
      find.descendant(
        of: railFinder,
        matching: find.byKey(const Key('board_canvas_focus_toggle_button')),
      ),
      findsNothing,
    );
    expect(find.byKey(const Key('board_canvas_focus_toggle_button')),
        findsOneWidget);
    expect(inspectorButton.onPressed, isNotNull);
    expect(find.text('Workbench tools'), findsOneWidget);
    expect(find.text('Future tools'), findsOneWidget);
    expect(find.text('Placements'), findsOneWidget);
    expect(find.text('Safety / Evidence'), findsOneWidget);
    expect(find.text('Trace'), findsOneWidget);
    expect(find.text('Repair map'), findsOneWidget);
    expect(railSize.width, lessThan(120));
    expect(state.events, isEmpty);
  });

  testWidgets('wide Workbench starts with hidden right context panel',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(1400, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final state = _inlineProjectState(
      components: const [
        ComponentFact(componentId: 'cmp_r101', designator: 'R101'),
      ],
      placements: const [boardPlacement],
    );

    await tester.pumpWidget(_harness(projectState: state));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('board_canvas_context_panel')), findsNothing);
    expect(state.events, isEmpty);
  });

  testWidgets(
      'wide Workbench rail opens placement and safety/evidence right panel modes',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(1400, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      _harness(
        projectState: _inlineProjectState(
          components: const [
            ComponentFact(componentId: 'cmp_r101', designator: 'R101'),
          ],
          placements: const [boardPlacement],
        ),
      ),
    );
    await tester.pumpAndSettle();

    await _openWideContextMode(tester, placements: true);
    final contextPanelFinder = find.byKey(const Key('board_canvas_context_panel'));
    expect(contextPanelFinder, findsOneWidget);
    expect(
      find.descendant(
        of: contextPanelFinder,
        matching: find.text('Placements'),
      ),
      findsOneWidget,
    );
    expect(find.widgetWithText(ChoiceChip, 'R101 (cmp_r101)'), findsOneWidget);

    await _openWideContextMode(tester, placements: false);
    expect(contextPanelFinder, findsOneWidget);
    expect(
      find.descendant(
        of: contextPanelFinder,
        matching: find.text('Safety / Evidence'),
      ),
      findsOneWidget,
    );
    expect(find.text('Body outline'), findsOneWidget);
  });

  testWidgets(
      'wide Workbench empty-canvas tap clears local selection and hides context',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(1400, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final state = _inlineProjectState(
      components: const [
        ComponentFact(componentId: 'cmp_r101', designator: 'R101'),
      ],
      placements: const [boardPlacement],
    );

    await tester.pumpWidget(_harness(projectState: state));
    await tester.pumpAndSettle();

    await _openWideContextMode(tester, placements: true);
    await _selectPlacement(tester, 'R101 (cmp_r101)');

    expect(find.text('Placement inspector (read-only)'), findsOneWidget);
    expect(find.byKey(const Key('board_canvas_context_panel')), findsOneWidget);

    await _tapCanvasAtNormalized(tester, x: 0.95, y: 0.95);

    expect(find.text('Placement inspector (read-only)'), findsNothing);
    expect(find.byKey(const Key('board_canvas_context_panel')), findsNothing);
    expect(find.text('renderer writes: none'), findsOneWidget);
    expect(state.events, isEmpty);
  });

  testWidgets('wide Workbench shows inspector in right context when selecting placement',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(1400, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      _harness(
        projectState: _inlineProjectState(
          components: const [
            ComponentFact(componentId: 'cmp_r101', designator: 'R101'),
          ],
          placements: const [boardPlacement],
        ),
      ),
    );
    await tester.pumpAndSettle();

    await _openWideContextMode(tester, placements: true);
    await _selectPlacement(tester, 'R101 (cmp_r101)');
    expect(find.text('Placement inspector (read-only)'), findsOneWidget);
    expect(
      find.byKey(const Key('board_canvas_context_panel')),
      findsOneWidget,
    );
    final visibleCanvasSize =
        tester.getSize(find.byKey(const Key('board_canvas_painter')));

    await tester
        .tap(find.byKey(const Key('board_canvas_inspector_toggle_button')));
    await tester.pumpAndSettle();

    expect(find.text('Placement inspector (read-only)'), findsNothing);
    final hiddenCanvasSize =
        tester.getSize(find.byKey(const Key('board_canvas_painter')));
    expect(hiddenCanvasSize.width, greaterThan(visibleCanvasSize.width));
    expect(find.text('renderer writes: none'), findsOneWidget);

    await tester
        .tap(find.byKey(const Key('board_canvas_inspector_toggle_button')));
    await tester.pumpAndSettle();

    expect(find.text('Placement inspector (read-only)'), findsOneWidget);
    expect(find.textContaining('Component ID: cmp_r101'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('focus canvas hides rail canvas chrome and restores read-only panel',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(1400, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final state = _inlineProjectState(
      components: const [
        ComponentFact(componentId: 'cmp_r101', designator: 'R101'),
      ],
      placements: const [boardPlacement],
    );

    await tester.pumpWidget(_harness(projectState: state));
    await tester.pumpAndSettle();

    await _selectPlacement(tester, 'R101 (cmp_r101)');
    expect(find.text('Placement inspector (read-only)'), findsOneWidget);
    expect(find.byKey(const Key('board_canvas_control_band')), findsNothing);
    expect(find.byKey(const Key('board_canvas_context_panel')),
        findsOneWidget);
    final normalCanvasSize =
        tester.getSize(find.byKey(const Key('board_canvas_painter')));

    await tester.tap(find.byKey(const Key('board_canvas_focus_toggle_button')));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('board_canvas_control_band')), findsNothing);
    expect(find.byKey(const Key('board_canvas_focus_restore_bar')),
        findsOneWidget);
    expect(find.text('Show controls'), findsOneWidget);
    expect(find.text('Placement inspector (read-only)'), findsNothing);
    expect(find.text('renderer writes: none'), findsOneWidget);
    expect(state.events, isEmpty);
    final focusedCanvasSize =
        tester.getSize(find.byKey(const Key('board_canvas_painter')));
    expect(focusedCanvasSize.width, greaterThan(normalCanvasSize.width));

    await tester.tap(
      find.byKey(const Key('board_canvas_focus_restore_button')),
    );
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('board_canvas_control_band')), findsNothing);
    expect(
        find.byKey(const Key('board_canvas_focus_restore_bar')), findsNothing);
    expect(find.byKey(const Key('board_canvas_context_panel')), findsOneWidget);
    expect(find.text('Placement inspector (read-only)'), findsOneWidget);
    expect(find.textContaining('Component ID: cmp_r101'), findsOneWidget);
    expect(find.text('renderer writes: none'), findsOneWidget);
    expect(state.events, isEmpty);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
      'multi-measurement badge scenarios stay component-level in legend and inspector',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(1400, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      _harness(
        projectState: _inlineProjectState(
          components: const [
            ComponentFact(componentId: 'cmp_r101', designator: 'R101'),
            ComponentFact(componentId: 'cmp_u1', designator: 'U1'),
          ],
          placements: const [boardPlacement, boardPlacementWidthHeight],
          measurements: const [
            MeasurementFact(
              measurementId: 'M101',
              mode: 'continuity',
              from: 'cmp_r101',
              to: 'GND',
              reading: 'beep',
              validityStatus: 'active',
              powerState: 'on',
            ),
            MeasurementFact(
              measurementId: 'M102',
              mode: 'continuity',
              from: 'cmp_r101.1',
              to: 'cmp_u1.3',
              reading: 'beep',
              validityStatus: 'active',
              powerState: 'on',
            ),
            MeasurementFact(
              measurementId: 'M103',
              mode: 'dc_voltage',
              from: 'Q2',
              to: 'cmp_u1',
              reading: 'numeric',
              validityStatus: 'active',
              powerState: 'off',
            ),
          ],
        ),
      ),
    );
    await tester.pump();

    await _openSafetyEvidence(tester);

    expect(find.text('Measurement badge'), findsOneWidget);
    expect(
      find.text('Measurement badge: component has related measurement(s).'),
      findsOneWidget,
    );
    expect(
      find.text('Does not create or confirm a net.'),
      findsOneWidget,
    );

    await _selectPlacement(tester, 'R101 (cmp_r101)');

    expect(find.text('Placement inspector (read-only)'), findsOneWidget);
    final finderR101Summary = find.text('Measurement — read-only summary');
    expect(finderR101Summary, findsOneWidget);
    expect(find.text('Related measurements: 2'), findsOneWidget);
    expect(find.textContaining('Measurement ID: M101'), findsOneWidget);
    expect(find.textContaining('Measurement ID: M102'), findsOneWidget);
    expect(
      find.textContaining('No related measurements for selected component.'),
      findsNothing,
    );
    expect(find.text('No board coordinate available'), findsOneWidget);
    expect(
      find.text('Does not create or confirm a net.'),
      findsAtLeastNWidgets(1),
    );

    await _selectPlacement(tester, 'U1 (cmp_u1)');

    expect(find.text('Placement inspector (read-only)'), findsOneWidget);
    expect(find.text('Measurement — read-only summary'), findsOneWidget);
    expect(find.text('Related measurements: 2'), findsOneWidget);
    expect(find.textContaining('Measurement ID: M103'), findsOneWidget);
    expect(
      find.textContaining('No related measurements for selected component.'),
      findsNothing,
    );
    expect(find.text('No board coordinate available'), findsOneWidget);
    expect(
      find.text('Does not create or confirm a net.'),
      findsAtLeastNWidgets(1),
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets(
      'board canvas supports pan/zoom affordances with fit reset and stays read-only',
      (tester) async {
    await tester.pumpWidget(
      _harness(
        projectState: _inlineProjectState(
          components: const [
            ComponentFact(componentId: 'cmp_r101', designator: 'R101'),
          ],
          placements: const [boardPlacement],
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('board_canvas_interactive_viewer')),
        findsOneWidget);
    expect(
        find.byKey(const Key('board_canvas_fit_view_button')), findsOneWidget);
    expect(find.byKey(const Key('board_canvas_painter')), findsOneWidget);

    expect(
      find.text('Select a placement to view read-only details.'),
      findsOneWidget,
    );
    await tester.drag(
      find.byKey(const Key('board_canvas_interactive_viewer')),
      const Offset(40, 24),
    );
    await tester.pump();
    expect(find.byKey(const Key('board_canvas_painter')), findsOneWidget);
    expect(
      find.text('Select a placement to view read-only details.'),
      findsOneWidget,
    );
    expect(find.text('Placement inspector (read-only)'), findsNothing);
    expect(find.text('renderer writes: none'), findsOneWidget);

    await tester.tap(find.byKey(const Key('board_canvas_fit_view_button')));
    await tester.pump();
    expect(find.byKey(const Key('board_canvas_painter')), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
      'pan/zoom transforms keep measurement badge anchored to rendered component',
      (tester) async {
    await tester.pumpWidget(
      _harness(
        projectState: _inlineProjectState(
          components: const [ComponentFact(componentId: 'cmp_r101')],
          placements: const [boardPlacement],
          measurements: const [
            MeasurementFact(
              measurementId: 'M200',
              mode: 'dc_voltage',
              from: 'cmp_r101',
              to: 'GND',
              reading: 'numeric',
              validityStatus: 'active',
              powerState: 'off',
            ),
          ],
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.drag(
      find.byKey(const Key('board_canvas_interactive_viewer')),
      const Offset(30, 20),
    );
    await tester.pump();
    await tester.tap(find.byKey(const Key('board_canvas_fit_view_button')));
    await tester.pump();

    expect(find.byKey(const Key('board_canvas_painter')), findsOneWidget);
    expect(find.text('renderer writes: none'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('renders scale-mode placement without error', (tester) async {
    await tester.pumpWidget(
      _harness(
        projectState: _inlineProjectState(
          components: const [
            ComponentFact(componentId: 'cmp_r101', designator: 'R101'),
          ],
          placements: const [boardPlacement],
        ),
      ),
    );

    expect(find.byKey(const Key('board_canvas_painter')), findsOneWidget);
    expect(find.text('renderer writes: none'), findsOneWidget);
  });

  testWidgets('renders width-height mode placement without error',
      (tester) async {
    await tester.pumpWidget(
      _harness(
        projectState: _inlineProjectState(
          components: const [ComponentFact(componentId: 'cmp_u1')],
          placements: const [boardPlacementWidthHeight],
        ),
      ),
    );

    expect(find.byKey(const Key('board_canvas_painter')), findsOneWidget);
    expect(find.text('renderer writes: none'), findsOneWidget);
  });

  testWidgets('missing scale-width-height falls back safely', (tester) async {
    const noSizingPlacement = ComponentVisualPlacementFact(
      componentId: 'cmp_no_size',
      coordinateSpace: 'board_normalized',
      boardSide: 'top',
      centerX: 0.33,
      centerY: 0.66,
      rotationDeg: 0,
      sourceEventId: 'evt_000106',
      status: 'user_confirmed_visual',
    );

    await tester.pumpWidget(
      _harness(
        projectState: _inlineProjectState(
          components: const [ComponentFact(componentId: 'cmp_no_size')],
          placements: const [noSizingPlacement],
        ),
      ),
    );

    expect(find.byKey(const Key('board_canvas_painter')), findsOneWidget);
  });

  testWidgets('missing template_id fallback renders without crash',
      (tester) async {
    const missingTemplate = ComponentVisualPlacementFact(
      componentId: 'cmp_missing_template_render',
      coordinateSpace: 'board_normalized',
      boardSide: 'top',
      centerX: 0.4,
      centerY: 0.4,
      rotationDeg: 0,
      sourceEventId: 'evt_000107',
      status: 'user_confirmed_visual',
    );

    await tester.pumpWidget(
      _harness(
        projectState: _inlineProjectState(
          components: const [
            ComponentFact(componentId: 'cmp_missing_template_render'),
          ],
          placements: const [missingTemplate],
        ),
      ),
    );

    expect(find.byKey(const Key('board_canvas_painter')), findsOneWidget);
  });

  testWidgets('unknown template_id fallback renders without crash',
      (tester) async {
    const unknownTemplate = ComponentVisualPlacementFact(
      componentId: 'cmp_unknown_template_render',
      coordinateSpace: 'board_normalized',
      boardSide: 'top',
      centerX: 0.6,
      centerY: 0.25,
      rotationDeg: 0,
      templateId: 'unknown_not_in_registry',
      sourceEventId: 'evt_000108',
      status: 'user_confirmed_visual',
    );

    await tester.pumpWidget(
      _harness(
        projectState: _inlineProjectState(
          components: const [
            ComponentFact(componentId: 'cmp_unknown_template_render'),
          ],
          placements: const [unknownTemplate],
        ),
      ),
    );

    expect(find.byKey(const Key('board_canvas_painter')), findsOneWidget);
  });

  testWidgets('does not render photo_local placements on board canvas',
      (tester) async {
    await tester.pumpWidget(
      _harness(
        projectState: _inlineProjectState(
          components: const [ComponentFact(componentId: 'cmp_photo')],
          placements: const [photoLocalPlacement],
        ),
      ),
    );

    expect(
      find.text(
        'No board-normalized placements available for this read-only canvas.',
      ),
      findsOneWidget,
    );
  });

  testWidgets('inspector shows placeholder before selection detail panel',
      (tester) async {
    await tester.pumpWidget(
      _harness(
        projectState: _inlineProjectState(
          components: const [
            ComponentFact(componentId: 'cmp_r101', designator: 'R101'),
          ],
          placements: const [boardPlacement],
        ),
      ),
    );

    expect(
      find.text('Select a placement to view read-only details.'),
      findsOneWidget,
    );
  });

  testWidgets(
      'inspector shows non-identity template and identity-copy safeguards',
      (tester) async {
    await tester.pumpWidget(
      _harness(
        projectState: _inlineProjectState(
          components: const [ComponentFact(componentId: 'cmp_r101')],
          placements: const [boardPlacement],
        ),
      ),
    );

    await _selectPlacement(tester, 'cmp_r101');

    expect(find.text('template family — not a part identity'), findsOneWidget);
    expect(
        find.text('identity not confirmed in this projection'), findsOneWidget);
  });

  testWidgets(
      'readiness panel appears when photoToBoardAlignments is non-empty',
      (tester) async {
    await tester.pumpWidget(
      _harness(
        projectState: _inlineProjectState(
          components: const [ComponentFact(componentId: 'cmp_r101')],
          placements: const [boardPlacement],
          photoToBoardAlignments: const [readinessAlignment],
        ),
      ),
    );
    expect(tester.takeException(), isNull);

    expect(
        find.text('Photo alignment readiness — metadata only'), findsOneWidget);
    expect(find.text('READINESS'), findsOneWidget);
    expect(
        find.text('Stores alignment reference points only.'), findsOneWidget);
    expect(
      find.text('Does not confirm identity, nets, measurements, or faults.'),
      findsOneWidget,
    );
    expect(
      find.text('No photo-local evidence is rendered on board canvas.'),
      findsOneWidget,
    );
    expect(find.text('No transform is computed.'), findsOneWidget);
    expect(find.text('Not electrical proof.'), findsOneWidget);
    expect(find.text('renderer writes: none'), findsOneWidget);
  });

  testWidgets('readiness panel is absent when photoToBoardAlignments is empty',
      (tester) async {
    await tester.pumpWidget(
      _harness(
        projectState: _inlineProjectState(
          components: const [ComponentFact(componentId: 'cmp_r101')],
          placements: const [boardPlacement],
        ),
      ),
    );

    expect(
        find.text('Photo alignment readiness — metadata only'), findsNothing);
  });

  testWidgets(
      'readiness panel shows allowed metadata and reference pair count only',
      (tester) async {
    await tester.pumpWidget(
      _harness(
        projectState: _inlineProjectState(
          components: const [ComponentFact(componentId: 'cmp_r101')],
          placements: const [boardPlacement],
          photoToBoardAlignments: const [readinessAlignment],
        ),
      ),
    );
    expect(tester.takeException(), isNull);

    expect(find.textContaining('Alignment ID: ALN1001'), findsOneWidget);
    expect(
        find.textContaining('Source photo ID: photo_top_001'), findsOneWidget);
    expect(find.textContaining('Board side: top'), findsOneWidget);
    expect(find.textContaining('Coordinate space from: photo_local'),
        findsOneWidget);
    expect(
      find.textContaining('Coordinate space to: board_normalized'),
      findsOneWidget,
    );
    expect(find.textContaining('Reference pairs: 2'), findsOneWidget);
    expect(
      find.textContaining('declared type — not computed: similarity'),
      findsOneWidget,
    );
    expect(
      find.textContaining(
        'Alignment quality label: manual_reference_verified',
      ),
      findsOneWidget,
    );
    expect(
      find.textContaining('Source event ID: evt_alignment_001'),
      findsOneWidget,
    );
    expect(
      find.textContaining('Status: user_confirmed_alignment'),
      findsOneWidget,
    );
    expect(find.textContaining('123.456'), findsNothing);
    expect(find.textContaining('789.123'), findsNothing);
    expect(find.textContaining('456.789'), findsNothing);
    expect(find.textContaining('321.987'), findsNothing);
  });

  testWidgets(
      'readiness panel renders multiple alignments with stable ordering and no raw coordinates',
      (tester) async {
    await tester.pumpWidget(
      _harness(
        projectState: _inlineProjectState(
          components: const [ComponentFact(componentId: 'cmp_r101')],
          placements: const [boardPlacement],
          photoToBoardAlignments: const [
            readinessAlignment,
            readinessAlignmentTwo
          ],
        ),
      ),
    );
    expect(tester.takeException(), isNull);

    expect(find.textContaining('Alignment ID: ALN1001'), findsOneWidget);
    expect(find.textContaining('Alignment ID: ALN1002'), findsOneWidget);
    expect(
        find.textContaining('Source photo ID: photo_top_001'), findsOneWidget);
    expect(find.textContaining('Source photo ID: photo_bottom_002'),
        findsOneWidget);
    expect(find.textContaining('Reference pairs: 2'), findsOneWidget);
    expect(find.textContaining('Reference pairs: 3'), findsOneWidget);
    expect(
      find.textContaining('declared type — not computed: similarity'),
      findsOneWidget,
    );
    expect(
      find.textContaining('declared type — not computed: affine'),
      findsOneWidget,
    );
    expect(
        find.text('Photo alignment readiness — metadata only'), findsOneWidget);
    expect(
        find.text('Stores alignment reference points only.'), findsOneWidget);
    expect(
      find.text('No photo-local evidence is rendered on board canvas.'),
      findsOneWidget,
    );
    expect(find.text('No transform is computed.'), findsOneWidget);
    expect(find.text('Not electrical proof.'), findsOneWidget);
    expect(find.textContaining('123.456'), findsNothing);
    expect(find.textContaining('789.123'), findsNothing);
    expect(find.textContaining('654.321'), findsNothing);
    expect(find.textContaining('111.222'), findsNothing);
    expect(find.textContaining('999.111'), findsNothing);

    const forbiddenActions = [
      'Confirm alignment',
      'Add reference point',
      'Apply to schematic',
      'Save',
    ];
    for (final action in forbiddenActions) {
      expect(find.text(action), findsNothing,
          reason: 'Unexpected action label: $action');
    }

    final firstAlignmentDy =
        tester.getTopLeft(find.textContaining('Alignment ID: ALN1001')).dy;
    final secondAlignmentDy =
        tester.getTopLeft(find.textContaining('Alignment ID: ALN1002')).dy;
    expect(firstAlignmentDy < secondAlignmentDy, isTrue);
  });

  testWidgets(
      'readiness panel remains project-level metadata with selection, inspector, measurement, and visual trace state',
      (tester) async {
    const linkedMeasurement = MeasurementFact(
      measurementId: 'M900',
      mode: 'dc_voltage',
      from: 'cmp_r101.1',
      to: 'GND',
      reading: 'numeric',
      validityStatus: 'active',
      powerState: 'on',
      value: 5.01,
      unit: 'V',
      originEventId: 'evt_m900',
    );
    const linkedTrace = VisualTraceFact(
      traceId: 'tr_900',
      photoId: 'ph_900',
      evidenceType: 'visual_trace',
      fromComponent: 'cmp_r101',
      toComponent: 'cmp_u1',
      fromPin: 'cmp_r101.1',
      toPin: 'cmp_u1.2',
      confidence: 'medium',
      layer: 'top',
      notes: 'route near edge',
    );

    await tester.pumpWidget(
      _harness(
        projectState: _inlineProjectState(
          components: const [
            ComponentFact(componentId: 'cmp_r101', designator: 'R101'),
            ComponentFact(componentId: 'cmp_u1'),
          ],
          placements: const [boardPlacement, boardPlacementWidthHeight],
          measurements: const [linkedMeasurement],
          visualTraces: const [linkedTrace],
          photoToBoardAlignments: const [readinessAlignment],
        ),
      ),
    );
    expect(tester.takeException(), isNull);

    expect(
        find.text('Photo alignment readiness — metadata only'), findsOneWidget);
    expect(find.textContaining('Alignment ID: ALN1001'), findsOneWidget);
    expect(
        find.textContaining('Source photo ID: photo_top_001'), findsOneWidget);
    expect(find.textContaining('Reference pairs: 2'), findsOneWidget);
    expect(
      find.textContaining('declared type — not computed: similarity'),
      findsOneWidget,
    );
    expect(find.text('renderer writes: none'), findsOneWidget);

    await _selectPlacement(tester, 'R101 (cmp_r101)');

    expect(find.text('Placement inspector (read-only)'), findsOneWidget);
    expect(find.textContaining('Component ID: cmp_r101'), findsOneWidget);
    expect(find.text('Measurement — read-only summary'), findsOneWidget);
    expect(find.textContaining('Measurement ID: M900'), findsOneWidget);
    expect(find.text('Visual trace — read-only metadata'), findsOneWidget);
    expect(find.textContaining('Trace ID: tr_900'), findsOneWidget);
    expect(
        find.text('Photo alignment readiness — metadata only'), findsOneWidget);
    expect(find.textContaining('Alignment ID: ALN1001'), findsOneWidget);

    await _selectPlacement(tester, 'cmp_u1');

    expect(find.textContaining('Component ID: cmp_u1'), findsOneWidget);
    expect(find.text('No related measurements for selected component.'),
        findsOneWidget);
    expect(find.textContaining('Trace ID: tr_900'), findsOneWidget);
    expect(
        find.text('Photo alignment readiness — metadata only'), findsOneWidget);
    expect(find.textContaining('Alignment ID: ALN1001'), findsOneWidget);
    expect(find.textContaining('123.456'), findsNothing);
    expect(find.textContaining('789.123'), findsNothing);

    const forbiddenActions = [
      'Show photo',
      'Render overlay',
      'Compute transform',
      'Confirm alignment',
      'Add reference point',
      'Apply to schematic',
      'Save',
    ];
    for (final action in forbiddenActions) {
      expect(find.text(action), findsNothing,
          reason: 'Unexpected action label: $action');
    }
  });

  testWidgets('readiness panel avoids layout overflow on constrained viewport',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(800, 520));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      _harness(
        projectState: _inlineProjectState(
          components: const [ComponentFact(componentId: 'cmp_r101')],
          placements: const [boardPlacement],
          photoToBoardAlignments: const [readinessAlignment],
        ),
      ),
    );
    await tester.pump();

    expect(tester.takeException(), isNull);
    expect(
        find.text('Photo alignment readiness — metadata only'), findsOneWidget);
  });

  testWidgets(
      'selecting placement from dropdown shows read-only inspector details',
      (tester) async {
    await tester.pumpWidget(
      _harness(
        projectState: _inlineProjectState(
          components: const [
            ComponentFact(componentId: 'cmp_r101', designator: 'R101'),
          ],
          placements: const [boardPlacement],
        ),
      ),
    );

    await _selectPlacement(tester, 'R101 (cmp_r101)');

    expect(find.textContaining('Component ID: cmp_r101'), findsOneWidget);
    expect(find.textContaining('Designator: R101'), findsOneWidget);
    expect(find.textContaining('Source event ID: evt_000101'), findsOneWidget);
    expect(find.textContaining('Coordinate space: board_normalized'),
        findsOneWidget);
    expect(find.textContaining('Board side: top'), findsOneWidget);
    expect(find.textContaining('Center X: 0.25'), findsOneWidget);
    expect(find.textContaining('Center Y: 0.45'), findsOneWidget);
    expect(find.textContaining('Rotation (deg): 15'), findsOneWidget);
    expect(find.textContaining('Scale: 1.2'), findsOneWidget);
    expect(
      find.text('Template does not prove electrical identity.'),
      findsOneWidget,
    );
    expect(find.text('renderer writes: none'), findsOneWidget);
  });

  testWidgets(
      'inspector preserves width-height mode when placement uses width and height',
      (tester) async {
    await tester.pumpWidget(
      _harness(
        projectState: _inlineProjectState(
          components: const [ComponentFact(componentId: 'cmp_u1')],
          placements: const [boardPlacementWidthHeight],
        ),
      ),
    );

    await _selectPlacement(tester, 'cmp_u1');

    expect(find.textContaining('Width: 1.5'), findsOneWidget);
    expect(find.textContaining('Height: 0.8'), findsOneWidget);
    expect(find.textContaining('Scale:'), findsNothing);
  });

  testWidgets('inspector displays package geometry when template exists',
      (tester) async {
    await tester.pumpWidget(
      _harness(
        projectState: _inlineProjectState(
          components: const [ComponentFact(componentId: 'cmp_r101')],
          placements: const [boardPlacement],
        ),
      ),
    );

    await _selectPlacement(tester, 'cmp_r101');

    expect(
      find.textContaining('Package: SOT-23 (3-pin package) (package geometry)'),
      findsOneWidget,
    );
  });

  testWidgets('inspector handles missing template_id safely', (tester) async {
    const missingTemplate = ComponentVisualPlacementFact(
      componentId: 'cmp_missing_template',
      coordinateSpace: 'board_normalized',
      boardSide: 'top',
      centerX: 0.1,
      centerY: 0.1,
      rotationDeg: 0,
      sourceEventId: 'evt_000104',
      status: 'user_confirmed_visual',
    );

    await tester.pumpWidget(
      _harness(
        projectState: _inlineProjectState(
          components: const [
            ComponentFact(componentId: 'cmp_missing_template')
          ],
          placements: const [missingTemplate],
        ),
      ),
    );

    await _selectPlacement(tester, 'cmp_missing_template');

    expect(find.textContaining('Template ID: not provided'), findsOneWidget);
    expect(find.textContaining('Package: Unknown package geometry'),
        findsOneWidget);
  });

  testWidgets('inspector handles unknown template_id safely', (tester) async {
    const unknownTemplate = ComponentVisualPlacementFact(
      componentId: 'cmp_unknown_template',
      coordinateSpace: 'board_normalized',
      boardSide: 'top',
      centerX: 0.2,
      centerY: 0.2,
      rotationDeg: 0,
      templateId: 'unknown_not_in_registry',
      sourceEventId: 'evt_000105',
      status: 'user_confirmed_visual',
    );

    await tester.pumpWidget(
      _harness(
        projectState: _inlineProjectState(
          components: const [
            ComponentFact(componentId: 'cmp_unknown_template')
          ],
          placements: const [unknownTemplate],
        ),
      ),
    );

    await _selectPlacement(tester, 'cmp_unknown_template');

    expect(find.textContaining('Template ID: unknown_not_in_registry'),
        findsOneWidget);
    expect(find.textContaining('Package: Unknown package geometry'),
        findsOneWidget);
  });

  testWidgets('unknown fallback templates render without crash',
      (tester) async {
    const placements = [
      ComponentVisualPlacementFact(
        componentId: 'cmp_u_rect',
        coordinateSpace: 'board_normalized',
        boardSide: 'top',
        centerX: 0.1,
        centerY: 0.1,
        rotationDeg: 0,
        templateId: 'unknown_rect',
        sourceEventId: 'evt_000110',
        status: 'user_confirmed_visual',
      ),
      ComponentVisualPlacementFact(
        componentId: 'cmp_u_2pin',
        coordinateSpace: 'board_normalized',
        boardSide: 'top',
        centerX: 0.2,
        centerY: 0.2,
        rotationDeg: 0,
        templateId: 'unknown_2pin',
        sourceEventId: 'evt_000111',
        status: 'user_confirmed_visual',
      ),
      ComponentVisualPlacementFact(
        componentId: 'cmp_u_3pin',
        coordinateSpace: 'board_normalized',
        boardSide: 'top',
        centerX: 0.3,
        centerY: 0.3,
        rotationDeg: 0,
        templateId: 'unknown_3pin',
        sourceEventId: 'evt_000112',
        status: 'user_confirmed_visual',
      ),
      ComponentVisualPlacementFact(
        componentId: 'cmp_u_multi',
        coordinateSpace: 'board_normalized',
        boardSide: 'top',
        centerX: 0.4,
        centerY: 0.4,
        rotationDeg: 0,
        templateId: 'unknown_multi_pin',
        sourceEventId: 'evt_000113',
        status: 'user_confirmed_visual',
      ),
    ];

    await tester.pumpWidget(
      _harness(
        projectState: _inlineProjectState(
          components: const [
            ComponentFact(componentId: 'cmp_u_rect'),
            ComponentFact(componentId: 'cmp_u_2pin'),
            ComponentFact(componentId: 'cmp_u_3pin'),
            ComponentFact(componentId: 'cmp_u_multi'),
          ],
          placements: placements,
        ),
      ),
    );

    expect(find.byKey(const Key('board_canvas_painter')), findsOneWidget);
  });

  testWidgets('designator appears only when present in known facts',
      (tester) async {
    await tester.pumpWidget(
      _harness(
        projectState: _inlineProjectState(
          components: const [
            ComponentFact(componentId: 'cmp_r101', designator: 'R101'),
            ComponentFact(componentId: 'cmp_no_designator'),
          ],
          placements: const [
            boardPlacement,
            ComponentVisualPlacementFact(
              componentId: 'cmp_no_designator',
              coordinateSpace: 'board_normalized',
              boardSide: 'top',
              centerX: 0.7,
              centerY: 0.7,
              rotationDeg: 0,
              sourceEventId: 'evt_000120',
              status: 'user_confirmed_visual',
            ),
          ],
        ),
      ),
    );

    await _selectPlacement(tester, 'cmp_no_designator');

    expect(find.textContaining('Designator:'), findsNothing);
  });

  testWidgets('forbidden action labels are absent', (tester) async {
    await tester.pumpWidget(
      _harness(
        projectState: _inlineProjectState(
          components: const [ComponentFact(componentId: 'cmp_r101')],
          placements: const [boardPlacement],
        ),
      ),
    );

    const forbiddenActions = [
      'Confirm',
      'Confirm net',
      'Confirm measurement',
      'Edit',
      'Edit measurement',
      'Change template',
      'Promote',
      'Promote to net',
      'Delete',
      'Identify with AI',
      'Measure',
      'Re-measure',
      'Apply to schematic',
      'Confirm fault',
      'Probability',
      'Save',
      'Export',
      'Upload photo',
      'Show photo',
      'Render overlay',
      'Compute transform',
      'Edit alignment',
      'Confirm alignment',
      'Add reference point',
      'Run AI',
      'Detect components',
      'Add component',
    ];

    for (final action in forbiddenActions) {
      expect(find.text(action), findsNothing,
          reason: 'Unexpected action label: $action');
    }
  });

  testWidgets(
      'measurement summary includes measurement when from equals componentId',
      (tester) async {
    const measurement = MeasurementFact(
      measurementId: 'M001',
      mode: 'dc_voltage',
      from: 'cmp_r101',
      to: 'GND',
      reading: 'numeric',
      validityStatus: 'active',
      powerState: 'on',
      value: 5.02,
      unit: 'V',
      originEventId: 'evt_800001',
    );

    await tester.pumpWidget(
      _harness(
        projectState: _inlineProjectState(
          components: const [ComponentFact(componentId: 'cmp_r101')],
          placements: const [boardPlacement],
          measurements: const [measurement],
        ),
      ),
    );

    await _selectPlacement(tester, 'cmp_r101');

    expect(find.text('Related measurement: 1'), findsOneWidget);
    expect(find.textContaining('Measurement ID: M001'), findsOneWidget);
    expect(find.text('Measurement — read-only summary'), findsOneWidget);
    expect(find.text('Value shown verbatim'), findsOneWidget);
  });

  testWidgets(
      'measurement summary includes measurement when to equals componentId',
      (tester) async {
    const measurement = MeasurementFact(
      measurementId: 'M002',
      mode: 'dc_voltage',
      from: 'GND',
      to: 'cmp_r101',
      reading: 'numeric',
      validityStatus: 'active',
      powerState: 'off',
      value: 3.3,
      unit: 'V',
      originEventId: 'evt_800002',
    );

    await tester.pumpWidget(
      _harness(
        projectState: _inlineProjectState(
          components: const [ComponentFact(componentId: 'cmp_r101')],
          placements: const [boardPlacement],
          measurements: const [measurement],
        ),
      ),
    );

    await _selectPlacement(tester, 'cmp_r101');

    expect(find.textContaining('Measurement ID: M002'), findsOneWidget);
  });

  testWidgets(
      'measurement summary includes measurement when from starts with componentId dot',
      (tester) async {
    const measurement = MeasurementFact(
      measurementId: 'M003',
      mode: 'continuity',
      from: 'cmp_r101.1',
      to: 'GND',
      reading: 'beep',
      validityStatus: 'active',
      powerState: 'off',
      originEventId: 'evt_800003',
    );

    await tester.pumpWidget(
      _harness(
        projectState: _inlineProjectState(
          components: const [ComponentFact(componentId: 'cmp_r101')],
          placements: const [boardPlacement],
          measurements: const [measurement],
        ),
      ),
    );

    await _selectPlacement(tester, 'cmp_r101');

    expect(find.textContaining('Measurement ID: M003'), findsOneWidget);
  });

  testWidgets(
      'measurement summary includes measurement when to starts with componentId dot',
      (tester) async {
    const measurement = MeasurementFact(
      measurementId: 'M004',
      mode: 'continuity',
      from: 'GND',
      to: 'cmp_r101.2',
      reading: 'beep',
      validityStatus: 'active',
      powerState: 'off',
      originEventId: 'evt_800004',
    );

    await tester.pumpWidget(
      _harness(
        projectState: _inlineProjectState(
          components: const [ComponentFact(componentId: 'cmp_r101')],
          placements: const [boardPlacement],
          measurements: const [measurement],
        ),
      ),
    );

    await _selectPlacement(tester, 'cmp_r101');

    expect(find.textContaining('Measurement ID: M004'), findsOneWidget);
  });

  testWidgets('Q2 does not match Q20 in measurement association',
      (tester) async {
    const measurement = MeasurementFact(
      measurementId: 'M005',
      mode: 'dc_voltage',
      from: 'Q20.1',
      to: 'GND',
      reading: 'numeric',
      validityStatus: 'active',
      powerState: 'on',
      value: 12.0,
      unit: 'V',
      originEventId: 'evt_800005',
    );

    await tester.pumpWidget(
      _harness(
        projectState: _inlineProjectState(
          components: const [ComponentFact(componentId: 'Q2')],
          placements: const [q2Placement],
          measurements: const [measurement],
        ),
      ),
    );

    await _selectPlacement(tester, 'Q2');

    expect(find.textContaining('Measurement ID: M005'), findsNothing);
    expect(find.text('Related measurements:'), findsNothing);
    expect(find.text('No related measurements for selected component.'),
        findsOneWidget);
  });

  testWidgets('tapping a rendered placement selects it in the inspector',
      (tester) async {
    await tester.pumpWidget(
      _harness(
        projectState: _inlineProjectState(
          components: const [ComponentFact(componentId: 'cmp_r101')],
          placements: const [boardPlacement],
        ),
      ),
    );

    expect(
      find.text('Select a placement to view read-only details.'),
      findsOneWidget,
    );
    await _tapCanvasAtNormalized(tester, x: 0.25, y: 0.45);

    expect(find.text('Placement inspector (read-only)'), findsOneWidget);
    expect(find.textContaining('Component ID: cmp_r101'), findsOneWidget);
    expect(find.text('renderer writes: none'), findsOneWidget);
  });

  testWidgets('tapping one rendered placement then another updates inspector',
      (tester) async {
    await tester.pumpWidget(
      _harness(
        projectState: _inlineProjectState(
          components: const [
            ComponentFact(componentId: 'cmp_r101', designator: 'R101'),
            ComponentFact(componentId: 'cmp_u1', designator: 'U1'),
          ],
          placements: const [boardPlacement, boardPlacementWidthHeight],
        ),
      ),
    );

    await _tapCanvasAtNormalized(tester, x: 0.25, y: 0.45);

    expect(find.text('Placement inspector (read-only)'), findsOneWidget);
    expect(find.textContaining('Component ID: cmp_r101'), findsOneWidget);
    expect(find.textContaining('Component ID: cmp_u1'), findsNothing);

    await _tapCanvasAtNormalized(tester, x: 0.52, y: 0.61);

    expect(find.text('Placement inspector (read-only)'), findsOneWidget);
    expect(find.textContaining('Component ID: cmp_u1'), findsOneWidget);
    expect(find.textContaining('Component ID: cmp_r101'), findsNothing);
  });

  testWidgets('chip selector still changes selection after canvas tap',
      (tester) async {
    await tester.pumpWidget(
      _harness(
        projectState: _inlineProjectState(
          components: const [
            ComponentFact(componentId: 'cmp_r101', designator: 'R101'),
            ComponentFact(componentId: 'cmp_u1', designator: 'U1'),
          ],
          placements: const [boardPlacement, boardPlacementWidthHeight],
        ),
      ),
    );

    await _tapCanvasAtNormalized(tester, x: 0.25, y: 0.45);
    expect(find.textContaining('Component ID: cmp_r101'), findsOneWidget);

    await _selectPlacement(tester, 'U1 (cmp_u1)');

    expect(find.textContaining('Component ID: cmp_u1'), findsOneWidget);
    expect(find.textContaining('Component ID: cmp_r101'), findsNothing);
  });

  testWidgets('tap selection stays aligned after canvas transform',
      (tester) async {
    await tester.pumpWidget(
      _harness(
        projectState: _inlineProjectState(
          components: const [ComponentFact(componentId: 'cmp_r101')],
          placements: const [boardPlacement],
        ),
      ),
    );
    await tester.pumpAndSettle();

    final viewer = tester.widget<InteractiveViewer>(
      find.byKey(const Key('board_canvas_interactive_viewer')),
    );
    viewer.transformationController!.value = Matrix4.identity()
      ..translate(32.0, 20.0);
    await tester.pump();

    await _tapCanvasAtNormalized(
      tester,
      x: 0.25,
      y: 0.45,
    );

    expect(find.text('Placement inspector (read-only)'), findsOneWidget);
    expect(find.textContaining('Component ID: cmp_r101'), findsOneWidget);

    await tester.tap(find.byKey(const Key('board_canvas_fit_view_button')));
    await tester.pump();
    expect(find.byKey(const Key('board_canvas_painter')), findsOneWidget);
  });

  testWidgets('tap-to-select leaves project state canonical data unchanged',
      (tester) async {
    final state = _inlineProjectState(
      components: const [ComponentFact(componentId: 'cmp_r101')],
      placements: const [boardPlacement],
    );

    await tester.pumpWidget(_harness(projectState: state));
    await _tapCanvasAtNormalized(tester, x: 0.25, y: 0.45);

    expect(find.text('Placement inspector (read-only)'), findsOneWidget);
    expect(state.events, isEmpty);
    expect(state.knownFacts.componentVisualPlacements, const [boardPlacement]);
    expect(state.knownFacts.measurements, isEmpty);
    expect(find.text('renderer writes: none'), findsOneWidget);
  });

  test(
    'measurement badge count is present when measurement from matches componentId',
    () {
      const measurement = MeasurementFact(
        measurementId: 'M001',
        mode: 'dc_voltage',
        from: 'cmp_r101',
        to: 'GND',
        reading: 'numeric',
        validityStatus: 'active',
        powerState: 'off',
      );

      final counts = measurementCountForComponent(
        measurements: const [measurement],
        componentId: 'cmp_r101',
      );

      expect(counts, equals(1));
    },
  );

  test(
    'measurement badge count is present when measurement to matches componentId',
    () {
      const measurement = MeasurementFact(
        measurementId: 'M002',
        mode: 'dc_voltage',
        from: 'GND',
        to: 'cmp_r101',
        reading: 'numeric',
        validityStatus: 'active',
        powerState: 'off',
      );

      final counts = measurementCountForComponent(
        measurements: const [measurement],
        componentId: 'cmp_r101',
      );

      expect(counts, equals(1));
    },
  );

  test(
    'measurement badge count is present when endpoint uses component prefix match',
    () {
      const measurement = MeasurementFact(
        measurementId: 'M003',
        mode: 'continuity',
        from: 'cmp_r101.1',
        to: 'GND',
        reading: 'beep',
        validityStatus: 'active',
        powerState: 'off',
      );

      final counts = measurementCountForComponent(
        measurements: const [measurement],
        componentId: 'cmp_r101',
      );

      expect(counts, equals(1));
      expect(measurementEndpointMatchesComponent('cmp_r101.1', 'cmp_r101'),
          isTrue);
    },
  );

  test('Q2 does not match Q20 in badge endpoint association', () {
    const measurement = MeasurementFact(
      measurementId: 'M005',
      mode: 'dc_voltage',
      from: 'Q20.1',
      to: 'GND',
      reading: 'numeric',
      validityStatus: 'active',
      powerState: 'off',
    );

    final counts = measurementCountForComponent(
      measurements: const [measurement],
      componentId: 'Q2',
    );

    expect(counts, equals(0));
    expect(measurementEndpointMatchesComponent('Q20.1', 'Q2'), isFalse);
  });

  test(
    'component without board-normalized placement does not get badge count from measurements',
    () {
      const measurement = MeasurementFact(
        measurementId: 'M006',
        mode: 'dc_voltage',
        from: 'cmp_r101',
        to: 'GND',
        reading: 'numeric',
        validityStatus: 'active',
        powerState: 'off',
      );

      final counts = measurementCountsByComponents(
        measurements: const [measurement],
        componentIds: const <String>{},
      );

      expect(counts, isEmpty);
    },
  );

  test(
      'component with placement but no matching measurement shows no badge count',
      () {
    const measurement = MeasurementFact(
      measurementId: 'M007',
      mode: 'dc_voltage',
      from: 'GND',
      to: 'VCC',
      reading: 'numeric',
      validityStatus: 'active',
      powerState: 'off',
    );

    final counts = measurementCountsByComponents(
      measurements: const [measurement],
      componentIds: const {'cmp_r101'},
    );

    expect(counts, isEmpty);
  });

  test('measurement badge count supports multi-measurement aggregation (M3)',
      () {
    const measurements = [
      MeasurementFact(
        measurementId: 'M201',
        mode: 'continuity',
        from: 'cmp_r101',
        to: 'GND',
        reading: 'beep',
        validityStatus: 'active',
        powerState: 'on',
      ),
      MeasurementFact(
        measurementId: 'M202',
        mode: 'continuity',
        from: 'cmp_r101.1',
        to: 'CMP_U1',
        reading: 'beep',
        validityStatus: 'active',
        powerState: 'on',
      ),
      MeasurementFact(
        measurementId: 'M203',
        mode: 'dc_voltage',
        from: 'V1',
        to: 'cmp_r101.3',
        reading: 'numeric',
        value: 1.2,
        unit: 'V',
        validityStatus: 'active',
        powerState: 'off',
      ),
    ];

    final counts = measurementCountsByComponents(
      measurements: measurements,
      componentIds: const {'cmp_r101'},
    );

    expect(counts['cmp_r101'], equals(3));
    expect(counts.length, equals(1));
  });

  test(
    'two-component measurement contributes badge count to both endpoints safely',
    () {
      const measurement = MeasurementFact(
        measurementId: 'M008',
        mode: 'continuity',
        from: 'cmp_r101.1',
        to: 'cmp_u1.2',
        reading: 'beep',
        validityStatus: 'active',
        powerState: 'off',
      );

      final counts = measurementCountsByComponents(
        measurements: const [measurement],
        componentIds: const {'cmp_r101', 'cmp_u1'},
      );

      expect(counts['cmp_r101'], equals(1));
      expect(counts['cmp_u1'], equals(1));
      expect(counts.length, equals(2));
    },
  );

  testWidgets('measurement summary shows safe copy and verbatim value',
      (tester) async {
    const measurement = MeasurementFact(
      measurementId: 'M006',
      mode: 'dc_voltage',
      from: 'cmp_r101.1',
      to: 'GND',
      reading: 'numeric',
      validityStatus: 'active',
      powerState: 'on',
      value: 4.987,
      unit: 'V',
      originEventId: 'evt_800006',
    );

    await tester.pumpWidget(
      _harness(
        projectState: _inlineProjectState(
          components: const [ComponentFact(componentId: 'cmp_r101')],
          placements: const [boardPlacement],
          measurements: const [measurement],
        ),
      ),
    );

    await _selectPlacement(tester, 'cmp_r101');

    expect(find.text('Measurement — read-only summary'), findsOneWidget);
    expect(find.text('MEASURED'), findsOneWidget);
    expect(find.text('Value shown verbatim'), findsOneWidget);
    expect(find.text('Does not create or confirm a net'), findsOneWidget);
    expect(find.text('No board coordinate available'), findsOneWidget);
    expect(find.textContaining('Value: 4.987 V'), findsOneWidget);
  });

  testWidgets('stale measurement shows stale after repair label',
      (tester) async {
    const measurement = MeasurementFact(
      measurementId: 'M007',
      mode: 'dc_voltage',
      from: 'cmp_r101',
      to: 'GND',
      reading: 'numeric',
      validityStatus: 'stale_after_repair',
      powerState: 'off',
      value: 3.3,
      unit: 'V',
      originEventId: 'evt_800007',
      validUntilEventId: 'evt_800008',
    );

    await tester.pumpWidget(
      _harness(
        projectState: _inlineProjectState(
          components: const [ComponentFact(componentId: 'cmp_r101')],
          placements: const [boardPlacement],
          measurements: const [measurement],
        ),
      ),
    );

    await _selectPlacement(tester, 'cmp_r101');

    expect(find.text('Stale after repair'), findsOneWidget);
    expect(find.textContaining('Valid until event ID: evt_800008'),
        findsOneWidget);
  });

  testWidgets('template_id does not render forbidden electrical identity words',
      (tester) async {
    await tester.pumpWidget(
      _harness(
        projectState: _inlineProjectState(
          components: const [ComponentFact(componentId: 'cmp_r101')],
          placements: const [boardPlacement],
        ),
      ),
    );

    const forbiddenWords = [
      'MOSFET',
      'regulator',
      'diode',
      'opamp',
      'transistor',
      'EEPROM',
      'microcontroller',
      '5V regulator',
      'power supply',
    ];

    for (final word in forbiddenWords) {
      expect(find.textContaining(word), findsNothing,
          reason: 'Template-derived identity leakage: $word');
    }
  });

  testWidgets(
      'visual trace summary includes trace when fromComponent equals componentId',
      (tester) async {
    const trace = VisualTraceFact(
      traceId: 'tr_001',
      photoId: 'ph_001',
      evidenceType: 'visual_trace',
      fromComponent: 'cmp_r101',
      toComponent: 'cmp_u1',
    );

    await tester.pumpWidget(
      _harness(
        projectState: _inlineProjectState(
          components: const [ComponentFact(componentId: 'cmp_r101')],
          placements: const [boardPlacement],
          visualTraces: const [trace],
        ),
      ),
    );

    await _selectPlacement(tester, 'cmp_r101');

    expect(find.textContaining('Trace ID: tr_001'), findsOneWidget);
  });

  testWidgets(
      'visual trace summary includes trace when toComponent equals componentId',
      (tester) async {
    const trace = VisualTraceFact(
      traceId: 'tr_002',
      photoId: 'ph_002',
      evidenceType: 'visual_trace',
      fromComponent: 'cmp_u1',
      toComponent: 'cmp_r101',
    );

    await tester.pumpWidget(
      _harness(
        projectState: _inlineProjectState(
          components: const [ComponentFact(componentId: 'cmp_r101')],
          placements: const [boardPlacement],
          visualTraces: const [trace],
        ),
      ),
    );

    await _selectPlacement(tester, 'cmp_r101');

    expect(find.textContaining('Trace ID: tr_002'), findsOneWidget);
  });

  testWidgets(
      'visual trace summary includes trace when fromPin starts with componentId dot',
      (tester) async {
    const trace = VisualTraceFact(
      traceId: 'tr_003',
      photoId: 'ph_003',
      evidenceType: 'visual_trace',
      fromPin: 'cmp_r101.1',
      toPin: 'cmp_u1.2',
    );

    await tester.pumpWidget(
      _harness(
        projectState: _inlineProjectState(
          components: const [ComponentFact(componentId: 'cmp_r101')],
          placements: const [boardPlacement],
          visualTraces: const [trace],
        ),
      ),
    );

    await _selectPlacement(tester, 'cmp_r101');

    expect(find.textContaining('Trace ID: tr_003'), findsOneWidget);
  });

  testWidgets(
      'visual trace summary includes trace when toPin starts with componentId dot',
      (tester) async {
    const trace = VisualTraceFact(
      traceId: 'tr_004',
      photoId: 'ph_004',
      evidenceType: 'visual_trace',
      fromPin: 'cmp_u1.1',
      toPin: 'cmp_r101.2',
    );

    await tester.pumpWidget(
      _harness(
        projectState: _inlineProjectState(
          components: const [ComponentFact(componentId: 'cmp_r101')],
          placements: const [boardPlacement],
          visualTraces: const [trace],
        ),
      ),
    );

    await _selectPlacement(tester, 'cmp_r101');

    expect(find.textContaining('Trace ID: tr_004'), findsOneWidget);
  });

  testWidgets('Q2 does not match Q20 in visual trace association',
      (tester) async {
    const trace = VisualTraceFact(
      traceId: 'tr_005',
      photoId: 'ph_005',
      evidenceType: 'visual_trace',
      fromPin: 'Q20.1',
      toPin: 'GND.1',
    );

    await tester.pumpWidget(
      _harness(
        projectState: _inlineProjectState(
          components: const [ComponentFact(componentId: 'Q2')],
          placements: const [q2Placement],
          visualTraces: const [trace],
        ),
      ),
    );

    await _selectPlacement(tester, 'Q2');

    expect(find.textContaining('Trace ID: tr_005'), findsNothing);
    expect(find.text('No related visual traces for selected component.'),
        findsOneWidget);
  });

  testWidgets('visual trace summary shows safe copy and metadata fields',
      (tester) async {
    const trace = VisualTraceFact(
      traceId: 'tr_006',
      photoId: 'ph_006',
      evidenceType: 'visual_trace',
      fromComponent: 'cmp_r101',
      toComponent: 'cmp_u2',
      fromPin: 'cmp_r101.1',
      toPin: 'cmp_u2.3',
      confidence: 'medium',
      layer: 'top',
      notes: 'visible copper path near edge',
    );

    await tester.pumpWidget(
      _harness(
        projectState: _inlineProjectState(
          components: const [ComponentFact(componentId: 'cmp_r101')],
          placements: const [boardPlacement],
          visualTraces: const [trace],
        ),
      ),
    );

    await _selectPlacement(tester, 'cmp_r101');

    expect(find.text('Visual trace — read-only metadata'), findsOneWidget);
    expect(find.text('VISUAL'), findsOneWidget);
    expect(
      find.text('Visual trace is not a confirmed electrical net'),
      findsOneWidget,
    );
    expect(
      find.text('Photo-local evidence; no board coordinate available'),
      findsOneWidget,
    );
    expect(
        find.text('Does not create or confirm connectivity'), findsOneWidget);
    expect(find.textContaining('Trace ID: tr_006'), findsOneWidget);
    expect(find.textContaining('Photo ID: ph_006'), findsOneWidget);
    expect(find.textContaining('Evidence type: visual_trace'), findsOneWidget);
    expect(find.textContaining('From component: cmp_r101'), findsOneWidget);
    expect(find.textContaining('To component: cmp_u2'), findsOneWidget);
    expect(find.textContaining('From pin: cmp_r101.1'), findsOneWidget);
    expect(find.textContaining('To pin: cmp_u2.3'), findsOneWidget);
    expect(find.textContaining('Confidence: medium'), findsOneWidget);
    expect(find.textContaining('Layer: top'), findsOneWidget);
    expect(
      find.textContaining('Notes: visible copper path near edge'),
      findsOneWidget,
    );
  });

  testWidgets('selection state is volatile in memory only', (tester) async {
    final state = _inlineProjectState(
      components: const [
        ComponentFact(componentId: 'cmp_r101', designator: 'R101'),
      ],
      placements: const [boardPlacement],
    );

    await tester.pumpWidget(
      _harness(projectState: state, boardCanvasKey: const ValueKey('first')),
    );
    await _selectPlacement(tester, 'R101 (cmp_r101)');
    expect(find.textContaining('Component ID: cmp_r101'), findsOneWidget);

    await tester.pumpWidget(
      _harness(projectState: state, boardCanvasKey: const ValueKey('second')),
    );
    await tester.pump(const Duration(milliseconds: 16));

    expect(
      find.text('Select a placement to view read-only details.'),
      findsOneWidget,
    );
  });

  test('board canvas source keeps read-only data-path boundaries', () {
    final source = File(
      'lib/features/board_canvas/screens/board_canvas_screen.dart',
    ).readAsStringSync();

    expect(source, isNot(contains('template.toMap(')));
    expect(source, isNot(contains('oldDelegate.entries != entries')));
    expect(source, contains('_entriesEquivalent('));
    expect(source, contains('template.pinAnchors'));
    expect(source, contains('template.orientationMarker'));
    expect(source, isNot(contains('width: 260')));
    expect(source, contains('_BoardCanvasControlBand'));
    expect(source, contains('_BoardCanvasSafetyEvidenceDisclosure'));
    expect(source, contains('_InspectorChromeToggle'));
    expect(source, contains('_CanvasStatusPill'));
    expect(source, contains('board_canvas_control_band'));
    expect(source, contains('board_canvas_placement_selector_disclosure'));
    expect(source, contains('board_canvas_safety_evidence_disclosure'));
    expect(source, contains('board_canvas_inspector_toggle_button'));
    expect(source, isNot(contains('MeasurementEventWriter')));
    expect(source, isNot(contains('ProjectExporter')));
    expect(source, isNot(contains('ProjectCreator')));
    expect(source, isNot(contains('ProjectOverviewScreen')));
    expect(source, isNot(contains('jsonDecode(')));
    expect(source, isNot(contains('known_facts.json')));
    expect(source, isNot(contains('events.jsonl')));
    expect(source, isNot(contains('board_graph.json')));
    expect(source, isNot(contains('view_state.json')));
    expect(source, contains('knownFacts.visualTraces'));
    expect(source, contains('knownFacts.photoToBoardAlignments'));
    expect(source, isNot(contains('knownFacts.damageRegions')));
    expect(source, isNot(contains('knownFacts.suspectRegions')));
    expect(source, isNot(contains('knownFacts.nets')));
    expect(source, isNot(contains('from_point')));
    expect(source, isNot(contains('to_point')));
    expect(source, isNot(contains('referencePointsPhoto[')));
    expect(source, isNot(contains('referencePointsBoard[')));
    expect(source, isNot(contains('Image(')));
    expect(source, isNot(contains('DecorationImage(')));
    expect(source, isNot(contains('RawImage(')));
    expect(source, isNot(contains('Promote to net')));
    expect(source, isNot(contains('drawMeasurement')));
    expect(source, isNot(contains('measurementOverlay')));
    expect(source, isNot(contains('measurementAnchor')));
    expect(source, isNot(contains('measurementCoordinate')));
    expect(source, isNot(contains('drawMeasurementBadge')));
    expect(source, isNot(contains('visualTracePath')));
    expect(source, isNot(contains('damagePath')));
    expect(source, isNot(contains('suspectPath')));
    expect(source, isNot(contains('measurementPath')));
    expect(source, isNot(contains('photoLocalPath')));
    expect(source, isNot(contains('drawVisualTrace')));
    expect(source, isNot(contains('drawDamage')));
    expect(source, isNot(contains('drawSuspect')));
    expect(source, isNot(contains('drawMeasurementPath')));
    expect(source, isNot(contains('drawMeasurementOverlay')));
    expect(source, isNot(contains('drawPhotoLocal')));
    expect(source, isNot(contains('drawPhotoOverlay')));
    expect(source, contains('InteractiveViewer('));
    expect(source,
        contains('transformationController: _transformationController'));
    expect(source, contains('minScale: _kMinZoom'));
    expect(source, contains('maxScale: _kMaxZoom'));
    expect(source, contains('GestureDetector('));
    expect(source, contains('board_canvas_tap_layer'));
    expect(source, contains('onPlacementSelected'));
    expect(source, contains('_renderedPlacementContains('));
    expect(source, isNot(contains('Confirm net')));
    expect(source, isNot(contains('Show photo')));
    expect(source, isNot(contains('Render overlay')));
    expect(source, isNot(contains('Compute transform')));
  });
}
