import 'dart:io';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trace_bench_viewer/app/app.dart';
import 'package:trace_bench_viewer/app/router.dart';
import 'package:trace_bench_viewer/features/board_canvas/screens/board_canvas_screen.dart';
import 'package:trace_bench_viewer/shared/models/known_facts.dart';
import 'package:trace_bench_viewer/shared/models/project_manifest.dart';
import 'package:trace_bench_viewer/shared/models/project_state.dart';
import 'package:trace_bench_viewer/shared/theme/app_theme.dart';

ProjectState _inlineProjectState({
  required List<ComponentFact> components,
  required List<ComponentVisualPlacementFact> placements,
  List<PinFact> pins = const [],
  Map<String, List<String>> componentPinIndex = const {},
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
      pins: pins,
      measurements: measurements,
      nets: const [],
      excludedFromFaultCandidates: const [],
      componentPinIndex: componentPinIndex,
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

Widget _routerHarness({
  required ProjectState? projectState,
  String initialLocation = '/project/board-canvas',
}) {
  return ProviderScope(
    overrides: [
      projectStateProvider.overrideWith((_) => projectState),
    ],
    child: MaterialApp.router(
      routerConfig: buildTraceBenchRouter(initialLocation: initialLocation),
    ),
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
      throw StateError(
          'Placement chip "$label" not found after opening disclosure.');
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

  final openDisclosure =
      find.byKey(const Key('board_canvas_safety_evidence_disclosure'));
  if (openDisclosure.evaluate().isNotEmpty &&
      find.text('Body outline').evaluate().isEmpty) {
    await tester.tap(openDisclosure);
    await tester.pumpAndSettle();
  }
}

Future<void> _openWideContextMode(WidgetTester tester,
    {required bool placements}) async {
  final placementsFinder =
      find.byKey(const Key('board_canvas_rail_placements_tool'));
  final safetyFinder =
      find.byKey(const Key('board_canvas_rail_safety_evidence_tool'));
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

Future<void> _tapWidgetByKey(WidgetTester tester, Key key) async {
  final finder = find.byKey(key);
  await tester.ensureVisible(finder);
  await tester.pump();
  await tester.tap(finder);
  await tester.pump(const Duration(milliseconds: 16));
}

double _previewCenterSlotDx(WidgetTester tester) {
  return tester
      .getRect(
        find.byKey(const Key('board_canvas_measure_component_center_slot')),
      )
      .center
      .dx;
}

void _expectStableComponentPreviewGeometry(WidgetTester tester) {
  final stageFinder =
      find.byKey(const Key('board_canvas_measure_component_visual_stage'));
  final leftGutterFinder =
      find.byKey(const Key('board_canvas_measure_component_left_gutter'));
  final centerSlotFinder =
      find.byKey(const Key('board_canvas_measure_component_center_slot'));
  final rightGutterFinder =
      find.byKey(const Key('board_canvas_measure_component_right_gutter'));

  expect(stageFinder, findsOneWidget);
  expect(leftGutterFinder, findsOneWidget);
  expect(centerSlotFinder, findsOneWidget);
  expect(rightGutterFinder, findsOneWidget);

  final stageRect = tester.getRect(stageFinder);
  final leftGutterRect = tester.getRect(leftGutterFinder);
  final centerSlotRect = tester.getRect(centerSlotFinder);
  final rightGutterRect = tester.getRect(rightGutterFinder);

  expect(leftGutterRect.width, rightGutterRect.width);
  expect(centerSlotRect.center.dx, closeTo(stageRect.center.dx, 0.5));
}

void main() {
  test('buildTheme exposes BenchBeep semantic visual tokens', () {
    final theme = buildTheme();
    final tokens = theme.extension<BenchBeepVisualTokens>();

    expect(tokens, isNotNull);
    expect(tokens!.surface, const Color(0xFF101A17));
    expect(tokens.panel, const Color(0xFF172722));
    expect(tokens.rule, const Color(0xFF325247));
    expect(tokens.textPrimary, const Color(0xFFE7EFE9));
    expect(tokens.textSecondary, const Color(0xFFB6C8BD));
    expect(tokens.textMuted, const Color(0xFF7C9086));
    expect(tokens.selectedConfirmedSave, const Color(0xFF2DD4BF));
    expect(tokens.selectedConfirmedSaveAccent, const Color(0xFFC47A35));
    expect(tokens.measuringArmedMeasured, const Color(0xFFF3A712));
    expect(tokens.draftUnsavedUnknown, const Color(0xFF7B3FF2));
    expect(tokens.draftUnsavedUnknownStrong, const Color(0xFF5E35B1));
    expect(tokens.draftUnsavedUnknownFill, const Color(0x227B3FF2));
  });

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
      find.text('Ohutus / tõendid'),
      findsOneWidget,
    );
    expect(find.text('No confirmed visual placements yet.'), findsNothing);
    expect(find.text('renderer writes: none'), findsOneWidget);
  });

  testWidgets('renders visual footprint forms for board placements',
      (tester) async {
    const chipPlacement = ComponentVisualPlacementFact(
      componentId: 'cmp_u1',
      coordinateSpace: 'board_normalized',
      boardSide: 'top',
      centerX: 0.2,
      centerY: 0.28,
      rotationDeg: 0,
      width: 0.12,
      height: 0.08,
      templateId: 'soic_8',
      sourceEventId: 'evt_fp_chip',
      status: 'user_confirmed_visual',
    );
    const resistorPlacement = ComponentVisualPlacementFact(
      componentId: 'cmp_r1',
      coordinateSpace: 'board_normalized',
      boardSide: 'top',
      centerX: 0.42,
      centerY: 0.38,
      rotationDeg: 0,
      width: 0.08,
      height: 0.03,
      sourceEventId: 'evt_fp_resistor',
      status: 'user_confirmed_visual',
    );
    const capacitorPlacement = ComponentVisualPlacementFact(
      componentId: 'cmp_c1',
      coordinateSpace: 'board_normalized',
      boardSide: 'top',
      centerX: 0.62,
      centerY: 0.48,
      rotationDeg: 90,
      width: 0.06,
      height: 0.04,
      sourceEventId: 'evt_fp_capacitor',
      status: 'user_confirmed_visual',
    );
    const connectorPlacement = ComponentVisualPlacementFact(
      componentId: 'cmp_jp1',
      coordinateSpace: 'board_normalized',
      boardSide: 'top',
      centerX: 0.78,
      centerY: 0.62,
      rotationDeg: 0,
      width: 0.1,
      height: 0.03,
      templateId: 'pin_header_4',
      sourceEventId: 'evt_fp_connector',
      status: 'user_confirmed_visual',
    );
    const genericPlacement = ComponentVisualPlacementFact(
      componentId: 'cmp_x9',
      coordinateSpace: 'board_normalized',
      boardSide: 'top',
      centerX: 0.32,
      centerY: 0.72,
      rotationDeg: 0,
      width: 0.02,
      height: 0.02,
      sourceEventId: 'evt_fp_generic',
      status: 'user_confirmed_visual',
    );
    const diodePlacement = ComponentVisualPlacementFact(
      componentId: 'cmp_d1',
      coordinateSpace: 'board_normalized',
      boardSide: 'top',
      centerX: 0.5,
      centerY: 0.72,
      rotationDeg: 180,
      width: 0.05,
      height: 0.02,
      sourceEventId: 'evt_fp_diode',
      status: 'user_confirmed_visual',
    );
    const transistorPlacement = ComponentVisualPlacementFact(
      componentId: 'cmp_q1',
      coordinateSpace: 'board_normalized',
      boardSide: 'top',
      centerX: 0.68,
      centerY: 0.25,
      rotationDeg: 45,
      width: 0.04,
      height: 0.04,
      sourceEventId: 'evt_fp_transistor',
      status: 'user_confirmed_visual',
    );
    const testPointPlacement = ComponentVisualPlacementFact(
      componentId: 'cmp_tp1',
      coordinateSpace: 'board_normalized',
      boardSide: 'top',
      centerX: 0.18,
      centerY: 0.62,
      rotationDeg: 270,
      width: 0.01,
      height: 0.01,
      sourceEventId: 'evt_fp_testpoint',
      status: 'user_confirmed_visual',
    );

    await tester.pumpWidget(
      _harness(
        projectState: _inlineProjectState(
          components: const [
            ComponentFact(componentId: 'cmp_u1', designator: 'U1'),
            ComponentFact(componentId: 'cmp_r1', designator: 'R1'),
            ComponentFact(componentId: 'cmp_c1', designator: 'C1'),
            ComponentFact(componentId: 'cmp_jp1', designator: 'JP1'),
            ComponentFact(componentId: 'cmp_x9', designator: 'X9'),
            ComponentFact(componentId: 'cmp_d1', designator: 'D1'),
            ComponentFact(componentId: 'cmp_q1', designator: 'Q1'),
            ComponentFact(componentId: 'cmp_tp1', designator: 'TP1'),
          ],
          placements: const [
            chipPlacement,
            resistorPlacement,
            capacitorPlacement,
            connectorPlacement,
            genericPlacement,
            diodePlacement,
            transistorPlacement,
            testPointPlacement,
          ],
        ),
      ),
    );

    final painterFinder = find.byKey(const Key('board_canvas_painter'));
    expect(painterFinder, findsOneWidget);
    final customPaint = tester.widget<CustomPaint>(painterFinder);
    final semanticsBuilder = customPaint.painter?.semanticsBuilder;
    expect(semanticsBuilder, isNotNull);
    final semanticsEntries = semanticsBuilder!(tester.getSize(painterFinder));
    final footprintLabels =
        semanticsEntries.map((entry) => entry.properties.label).toSet();
    final rectsByLabel = <String, Rect>{
      for (final entry in semanticsEntries)
        if (entry.properties.label != null) entry.properties.label!: entry.rect,
    };
    const chipLabel =
        'Board Canvas footprint visual U1 (cmp_u1): IC / dual-side package footprint, visual only; contacts not added';
    const resistorLabel =
        'Board Canvas footprint visual R1 (cmp_r1): passive 2-terminal footprint, visual only; contacts not added';
    const capacitorLabel =
        'Board Canvas footprint visual C1 (cmp_c1): capacitor footprint, visual only; contacts not added';
    const connectorLabel =
        'Board Canvas footprint visual JP1 (cmp_jp1): connector / header footprint, visual only; contacts not added';
    const genericLabel =
        'Board Canvas footprint visual X9 (cmp_x9): generic component footprint, visual only; contacts not added';
    const diodeLabel =
        'Board Canvas footprint visual D1 (cmp_d1): diode footprint, visual only; contacts not added';
    const transistorLabel =
        'Board Canvas footprint visual Q1 (cmp_q1): transistor 3-terminal footprint, visual only; contacts not added';
    const testPointLabel =
        'Board Canvas footprint visual TP1 (cmp_tp1): test point / ground footprint, visual only; contacts not added';
    expect(
        footprintLabels,
        containsAll(<String>{
          chipLabel,
          resistorLabel,
          capacitorLabel,
          connectorLabel,
          genericLabel,
          diodeLabel,
          transistorLabel,
          testPointLabel,
        }));
    expect(
      rectsByLabel[chipLabel]!.width,
      greaterThanOrEqualTo(56),
    );
    expect(
      rectsByLabel[resistorLabel]!.height,
      greaterThanOrEqualTo(18),
    );
    expect(
      rectsByLabel[capacitorLabel]!.height,
      greaterThanOrEqualTo(40),
    );
    expect(
      rectsByLabel[connectorLabel]!.width,
      greaterThanOrEqualTo(60),
    );
    expect(
      rectsByLabel[diodeLabel]!.width,
      greaterThanOrEqualTo(44),
    );
    expect(
      rectsByLabel[transistorLabel]!.height,
      greaterThanOrEqualTo(40),
    );
    expect(
      rectsByLabel[testPointLabel]!.width,
      greaterThanOrEqualTo(22),
    );
    expect(
      rectsByLabel[genericLabel]!.width,
      greaterThanOrEqualTo(32),
    );
    expect(find.text('renderer writes: none'), findsOneWidget);
  });

  testWidgets('footprint pin visuals stay faithful to projected pin sources',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(1400, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    const onePinPlacement = ComponentVisualPlacementFact(
      componentId: 'cmp_gnd',
      coordinateSpace: 'board_normalized',
      boardSide: 'top',
      centerX: 0.18,
      centerY: 0.3,
      rotationDeg: 0,
      templateId: 'sot23_3',
      sourceEventId: 'evt_pin_one',
      status: 'user_confirmed_visual',
    );
    const twoPinPlacement = ComponentVisualPlacementFact(
      componentId: 'cmp_r2',
      coordinateSpace: 'board_normalized',
      boardSide: 'top',
      centerX: 0.42,
      centerY: 0.42,
      rotationDeg: 0,
      width: 0.08,
      height: 0.03,
      sourceEventId: 'evt_pin_two',
      status: 'user_confirmed_visual',
    );
    const unknownPlacement = ComponentVisualPlacementFact(
      componentId: 'cmp_unknown_pins',
      coordinateSpace: 'board_normalized',
      boardSide: 'top',
      centerX: 0.64,
      centerY: 0.54,
      rotationDeg: 0,
      width: 0.08,
      height: 0.04,
      sourceEventId: 'evt_pin_unknown',
      status: 'user_confirmed_visual',
    );
    const multiPinPlacement = ComponentVisualPlacementFact(
      componentId: 'cmp_u8',
      coordinateSpace: 'board_normalized',
      boardSide: 'top',
      centerX: 0.78,
      centerY: 0.66,
      rotationDeg: 0,
      width: 0.1,
      height: 0.05,
      sourceEventId: 'evt_pin_multi',
      status: 'user_confirmed_visual',
    );
    const onePinMeasurement = MeasurementFact(
      measurementId: 'M_pin_gnd',
      mode: 'continuity',
      from: 'cmp_gnd.1',
      to: 'GND',
      reading: 'true',
      validityStatus: 'active',
      powerState: 'off',
      unit: 'Beep',
      originEventId: 'evt_pin_measure',
    );

    await tester.pumpWidget(
      _harness(
        projectState: _inlineProjectState(
          components: const [
            ComponentFact(componentId: 'cmp_gnd', designator: 'GND'),
            ComponentFact(componentId: 'cmp_r2', designator: 'R2'),
            ComponentFact(componentId: 'cmp_unknown_pins', designator: 'X1'),
            ComponentFact(componentId: 'cmp_u8', designator: 'U8'),
          ],
          placements: const [
            onePinPlacement,
            twoPinPlacement,
            unknownPlacement,
            multiPinPlacement,
          ],
          pins: const [
            PinFact(componentId: 'cmp_gnd', pinId: 'cmp_gnd.1'),
            PinFact(componentId: 'cmp_r2', pinId: 'cmp_r2.1'),
            PinFact(componentId: 'cmp_r2', pinId: 'cmp_r2.2'),
            PinFact(componentId: 'cmp_u8', pinId: 'cmp_u8.1'),
            PinFact(componentId: 'cmp_u8', pinId: 'cmp_u8.2'),
            PinFact(componentId: 'cmp_u8', pinId: 'cmp_u8.3'),
            PinFact(componentId: 'cmp_u8', pinId: 'cmp_u8.4'),
            PinFact(componentId: 'cmp_u8', pinId: 'cmp_u8.5'),
            PinFact(componentId: 'cmp_u8', pinId: 'cmp_u8.6'),
            PinFact(componentId: 'cmp_u8', pinId: 'cmp_u8.7'),
            PinFact(componentId: 'cmp_u8', pinId: 'cmp_u8.8'),
          ],
          componentPinIndex: const {
            'cmp_gnd': ['cmp_gnd.1'],
            'cmp_r2': ['cmp_r2.1', 'cmp_r2.2'],
            'cmp_u8': [
              'cmp_u8.1',
              'cmp_u8.2',
              'cmp_u8.3',
              'cmp_u8.4',
              'cmp_u8.5',
              'cmp_u8.6',
              'cmp_u8.7',
              'cmp_u8.8',
            ],
          },
          measurements: const [onePinMeasurement],
        ),
      ),
    );
    await tester.pumpAndSettle();

    final painterFinder = find.byKey(const Key('board_canvas_painter'));
    final customPaint = tester.widget<CustomPaint>(painterFinder);
    final semanticsBuilder = customPaint.painter?.semanticsBuilder;
    expect(semanticsBuilder, isNotNull);
    final labels = semanticsBuilder!(tester.getSize(painterFinder))
        .map((entry) => entry.properties.label)
        .whereType<String>()
        .toSet();

    expect(
      labels,
      contains(
        'Board Canvas footprint visual GND (cmp_gnd): test point / ground footprint, visual only; 1 known pin identity listed separately; contacts not added',
      ),
    );
    expect(
      labels,
      contains(
        'Board Canvas footprint visual R2 (cmp_r2): passive 2-terminal footprint, visual only; 2 known pin identities listed separately; contacts not added',
      ),
    );
    expect(
      labels,
      contains(
        'Board Canvas footprint visual X1 (cmp_unknown_pins): generic component footprint, visual only; contacts not added',
      ),
    );
    expect(
      labels,
      contains(
        'Board Canvas footprint visual U8 (cmp_u8): IC / dual-side package footprint, visual only; 8 known pin identities listed separately; contacts not added',
      ),
    );
    expect(find.text('renderer writes: none'), findsOneWidget);

    final measureSheetAction = find.byKey(
      const Key('board_canvas_measure_sheet_button'),
    );
    expect(measureSheetAction, findsOneWidget);
    await tester.tap(measureSheetAction);
    await tester.pumpAndSettle();

    expect(
      find.byKey(
        const Key('board_canvas_measure_component_footprint_preview'),
      ),
      findsOneWidget,
    );
    _expectStableComponentPreviewGeometry(tester);
    expect(
      find.bySemanticsLabel(
        'Component preview footprint visual GND (cmp_gnd): test point / ground footprint, visual only; 1 known pin identity listed separately; contacts not added',
      ),
      findsOneWidget,
    );
    expect(find.text('selected Pin 1'), findsOneWidget);
    expect(
      find.byKey(
        const Key('board_canvas_measure_component_contacts_not_added'),
      ),
      findsOneWidget,
    );
    expect(find.text('Visual only; contacts not added.'), findsOneWidget);
    expect(
      find.byKey(const Key('board_canvas_component_visual_edit_button')),
      findsNothing,
    );
    expect(find.text('Confirm'), findsNothing);
    expect(find.text('Edit Layout'), findsNothing);
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

    expect(appBarSize.height, lessThanOrEqualTo(40));
    expect(find.text('Board Canvas'), findsOneWidget);
    expect(
      find.byKey(const Key('board_canvas_read_only_status_pill')),
      findsOneWidget,
    );
    expect(find.text('Ainult vaatamine · kirjutusi pole'), findsOneWidget);
    expect(find.text('Read-only · no writes'), findsNothing);
    expect(find.text('Plaadi projektsioonivaade'), findsOneWidget);
    expect(find.text('Board projection canvas'), findsNothing);
    expect(
      find.text('Ainult olemasolevad plaadinormaliseeritud paigutused'),
      findsOneWidget,
    );
    expect(
        find.text('Existing board-normalized placements only'), findsNothing);
    expect(find.byKey(const Key('board_canvas_status_bar')), findsOneWidget);
    expect(find.text('Valmis'), findsOneWidget);
    expect(find.text('Ready'), findsNothing);
    expect(find.text('BenchBeep · TraceBench platform'), findsOneWidget);
    expect(find.text('renderer writes: none'), findsOneWidget);
  });

  testWidgets('Board Canvas measurement action opens non-writing panel shell',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(1400, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    const linkedTrace = VisualTraceFact(
      traceId: 'tr_measure_r101',
      photoId: 'ph_measure_r101',
      evidenceType: 'visual_trace',
      fromComponent: 'cmp_r101',
      toComponent: 'cmp_u1',
      fromPin: 'cmp_r101.2',
      toPin: 'cmp_u1.2',
      confidence: 'medium',
      layer: 'top',
      notes: 'visible copper near selected component',
    );
    const linkedMeasurement = MeasurementFact(
      measurementId: 'M_measure_r101',
      mode: 'dc_voltage',
      from: 'cmp_r101.1',
      to: 'GND',
      reading: 'numeric',
      validityStatus: 'active',
      powerState: 'on',
      value: 5.01,
      unit: 'V',
      originEventId: 'evt_measure_r101',
    );
    const continuityMeasurement = MeasurementFact(
      measurementId: 'M_measure_r101_beep',
      mode: 'continuity',
      from: 'cmp_r101.3',
      to: 'GND',
      reading: 'true',
      validityStatus: 'active',
      powerState: 'off',
      unit: 'Beep',
      originEventId: 'evt_measure_r101_beep',
    );
    final state = _inlineProjectState(
      components: const [
        ComponentFact(componentId: 'cmp_r101', designator: 'R101'),
        ComponentFact(componentId: 'cmp_u1'),
      ],
      placements: const [boardPlacement, boardPlacementWidthHeight],
      measurements: const [linkedMeasurement, continuityMeasurement],
      visualTraces: const [linkedTrace],
    );

    await tester.pumpWidget(_harness(projectState: state));
    await tester.pumpAndSettle();

    final measureSheetAction = find.byKey(
      const Key('board_canvas_measure_sheet_button'),
    );
    expect(measureSheetAction, findsOneWidget);
    await tester.tap(measureSheetAction);
    await tester.pumpAndSettle();

    expect(find.byType(BoardCanvasScreen), findsOneWidget);
    expect(find.byKey(const Key('board_canvas_painter')), findsOneWidget);
    expect(find.byKey(const Key('board_canvas_context_panel')), findsOneWidget);
    expect(
      find.byKey(const Key('board_canvas_integrated_measure_panel')),
      findsOneWidget,
    );
    final measurePanel = find.byKey(
      const Key('board_canvas_integrated_measure_panel'),
    );
    expect(
      find.descendant(of: measurePanel, matching: find.byType(Card)),
      findsNothing,
    );
    expect(
      find.byKey(const Key('board_canvas_measure_panel_surface')),
      findsOneWidget,
    );
    expect(
      find.byKey(const Key('board_canvas_measure_panel_header')),
      findsOneWidget,
    );
    expect(
      find.byKey(const Key('board_canvas_measure_values_section')),
      findsOneWidget,
    );
    expect(
      find.byKey(const Key('board_canvas_measure_visual_section')),
      findsOneWidget,
    );
    expect(
      find.byKey(const Key('board_canvas_measure_context_section')),
      findsOneWidget,
    );
    expect(
      find.byKey(const Key('board_canvas_measure_advanced_section')),
      findsOneWidget,
    );
    expect(
      find.byKey(const Key('board_canvas_rail_measure_active')),
      findsOneWidget,
    );
    expect(find.text('Mõõtmine'), findsAtLeastNWidgets(1));
    expect(find.text('Measure'), findsNothing);
    expect(find.text('Component focus'), findsNothing);
    expect(find.text('component'), findsNothing);
    expect(find.text('read-only · local'), findsNothing);
    expect(find.text('local · no write'), findsOneWidget);
    expect(find.text('R101 (cmp_r101)'), findsOneWidget);
    expect(
      find.byKey(const Key('board_canvas_measure_canvas_focus_text')),
      findsNothing,
    );
    expect(
      find.text('No project data is written from this panel.'),
      findsNothing,
    );
    expect(find.text('Mõõdetud väärtused'), findsOneWidget);
    expect(find.text('Measured values'), findsNothing);
    expect(
      find.text('rea väärtused · kohalikud mustandid'),
      findsOneWidget,
    );
    expect(find.text('inline values · local drafts'), findsNothing);
    expect(
      find.byKey(const Key('board_canvas_measure_values_count')),
      findsOneWidget,
    );
    final measuredRow = find.byKey(
      const Key('board_canvas_measure_target_row_cmp_r101.1'),
    );
    expect(measuredRow, findsOneWidget);
    expect(
      find.descendant(
        of: measuredRow,
        matching: find.text('Pin 1 · R101.1'),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(of: measuredRow, matching: find.text('cmp_r101.1')),
      findsNothing,
    );
    expect(
      find.descendant(
        of: measuredRow,
        matching: find.text('cmp_r101.1 -> GND'),
      ),
      findsNothing,
    );
    expect(
      find.byKey(
        const Key('board_canvas_measure_row_existing_value_cmp_r101.1'),
      ),
      findsOneWidget,
    );
    expect(
      find.byKey(
        const Key('board_canvas_measure_row_existing_unit_cmp_r101.1'),
      ),
      findsOneWidget,
    );
    expect(find.text('5.01 V'), findsNothing);
    final beepRow = find.byKey(
      const Key('board_canvas_measure_target_row_cmp_r101.3'),
    );
    expect(beepRow, findsOneWidget);
    expect(
      find.descendant(
        of: beepRow,
        matching: find.text('Pin 3 · R101.3'),
      ),
      findsOneWidget,
    );
    expect(
      find.byKey(
        const Key('board_canvas_measure_row_existing_value_cmp_r101.3'),
      ),
      findsOneWidget,
    );
    expect(
      find.byKey(
        const Key('board_canvas_measure_row_existing_unit_cmp_r101.3'),
      ),
      findsNothing,
    );
    expect(
      find.descendant(of: beepRow, matching: find.text('Beep')),
      findsOneWidget,
    );
    expect(
      find.descendant(of: beepRow, matching: find.text('true')),
      findsNothing,
    );
    expect(
      find.byKey(const Key('board_canvas_measure_target_row_cmp_r101.2')),
      findsOneWidget,
    );
    final draftRow = find.byKey(
      const Key('board_canvas_measure_target_row_cmp_r101.2'),
    );
    expect(
      find.descendant(
        of: draftRow,
        matching: find.text('Pin 2 · R101.2'),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(of: draftRow, matching: find.text('cmp_r101.2')),
      findsNothing,
    );
    expect(
      find.descendant(
        of: draftRow,
        matching: find.text('cmp_r101.2 -> cmp_u1.2'),
      ),
      findsNothing,
    );
    expect(
      find.byKey(
        const Key('board_canvas_measure_row_value_input_cmp_r101.2'),
      ),
      findsOneWidget,
    );
    expect(
      find.byKey(
        const Key('board_canvas_measure_row_unit_select_cmp_r101.2'),
      ),
      findsOneWidget,
    );
    expect(find.text('lisa väärtus'), findsOneWidget);
    expect(find.text('Quick local capture'), findsNothing);
    expect(find.text('Pin/leg'), findsNothing);
    expect(find.byKey(const Key('board_canvas_measure_pin_target_select')),
        findsNothing);
    expect(find.byKey(const Key('board_canvas_measure_draft_value_input')),
        findsNothing);
    expect(find.byKey(const Key('board_canvas_measure_draft_unit_select')),
        findsNothing);
    expect(find.text('Salvesta placeholder'), findsNothing);
    expect(find.text('Local only'), findsNothing);
    expect(find.text('Komponendi vaade'), findsOneWidget);
    expect(find.text('Component visual'), findsNothing);
    expect(
      find.byKey(const Key('board_canvas_measure_component_visual_stage')),
      findsOneWidget,
    );
    expect(
      find.byKey(
        const Key('board_canvas_measure_component_footprint_preview'),
      ),
      findsOneWidget,
    );
    final previewSizeBeforePinSelection = tester.getSize(
      find.byKey(
        const Key('board_canvas_measure_component_footprint_preview'),
      ),
    );
    _expectStableComponentPreviewGeometry(tester);
    final previewCenterSlotDxBeforePinSelection = _previewCenterSlotDx(tester);
    expect(
      find.byKey(const Key('board_canvas_component_visual_edit_button')),
      findsNothing,
    );
    expect(find.text('Edit'), findsNothing);
    expect(find.text('Edit Layout'), findsNothing);
    expect(find.text('Local visual selector'), findsNothing);
    expect(
      find.byKey(const Key('board_canvas_measure_visual_selector')),
      findsNothing,
    );
    expect(
      find.byKey(
        const Key('board_canvas_measure_visual_selector_target_cmp_r101.1'),
      ),
      findsNothing,
    );
    expect(
      find.byKey(
        const Key('board_canvas_measure_visual_selector_selected_cmp_r101.1'),
      ),
      findsNothing,
    );
    expect(
      find.byKey(const Key('board_canvas_measure_visual_pad_cmp_r101.2')),
      findsOneWidget,
    );
    expect(
      find.byKey(
        const Key('board_canvas_measure_visual_target_cmp_r101.2'),
      ),
      findsOneWidget,
    );
    expect(
      find.byKey(
        const Key('board_canvas_measure_visual_target_selected_cmp_r101.2'),
      ),
      findsNothing,
    );
    expect(
      find.byKey(
        const Key('board_canvas_measure_visual_selector_selected_cmp_r101.2'),
      ),
      findsNothing,
    );
    final draftVisualTarget = find.byKey(
      const Key('board_canvas_measure_visual_target_cmp_r101.2'),
    );
    await tester.ensureVisible(draftVisualTarget);
    await tester.tap(draftVisualTarget);
    await tester.pumpAndSettle();
    expect(
      find.byKey(
        const Key('board_canvas_measure_target_row_selected_cmp_r101.2'),
      ),
      findsOneWidget,
    );
    final existingRow = find.byKey(
      const Key('board_canvas_measure_target_row_cmp_r101.1'),
    );
    await tester.ensureVisible(existingRow);
    await tester.pumpAndSettle();
    tester.binding.handlePointerEvent(
      PointerHoverEvent(
        position: tester.getCenter(existingRow),
        kind: PointerDeviceKind.mouse,
      ),
    );
    await tester.pumpAndSettle();
    _expectStableComponentPreviewGeometry(tester);
    expect(
      _previewCenterSlotDx(tester),
      closeTo(previewCenterSlotDxBeforePinSelection, 0.5),
    );
    expect(
      tester.getSize(
        find.byKey(
          const Key('board_canvas_measure_component_footprint_preview'),
        ),
      ),
      previewSizeBeforePinSelection,
    );
    expect(
      find.byKey(
        const Key('board_canvas_measure_visual_target_selected_cmp_r101.2'),
      ),
      findsOneWidget,
    );
    expect(
      find.byKey(
        const Key('board_canvas_measure_visual_target_selected_cmp_r101.1'),
      ),
      findsNothing,
    );
    expect(
      find.byKey(
        const Key('board_canvas_measure_target_row_selected_cmp_r101.1'),
      ),
      findsNothing,
    );
    expect(
      find.byKey(
        const Key('board_canvas_measure_visual_selector_selected_cmp_r101.2'),
      ),
      findsNothing,
    );
    expect(find.text('selected Pin 2'), findsOneWidget);
    expect(find.text('Visual only; no connectivity proof.'),
        findsAtLeastNWidgets(1));
    expect(find.text('Visual only; contacts not added.'), findsOneWidget);
    final leftVisualTarget = find.byKey(
      const Key('board_canvas_measure_visual_target_cmp_r101.1'),
    );
    await tester.ensureVisible(leftVisualTarget);
    await tester.tap(leftVisualTarget);
    await tester.pumpAndSettle();
    _expectStableComponentPreviewGeometry(tester);
    expect(
      _previewCenterSlotDx(tester),
      closeTo(previewCenterSlotDxBeforePinSelection, 0.5),
    );
    expect(find.text('selected Pin 1'), findsOneWidget);
    expect(find.text('renderer writes: none'), findsAtLeastNWidgets(1));
    expect(find.text('From -> To context'), findsOneWidget);
    expect(
      find.text('Display only; no confirmed connectivity.'),
      findsOneWidget,
    );
    expect(find.text('cmp_r101.1 -> GND'), findsOneWidget);
    expect(find.text('cmp_r101.2 -> cmp_u1.2'), findsOneWidget);
    expect(find.textContaining('visual-only context'), findsAtLeastNWidgets(1));
    expect(find.text('Tehnilised detailid'), findsOneWidget);
    expect(find.text('Advanced technical details'), findsNothing);
    expect(find.textContaining('Trace ID: tr_measure_r101'), findsNothing);

    final componentTop = tester.getTopLeft(find.text('R101 (cmp_r101)')).dy;
    final visualTop = tester.getTopLeft(find.text('Komponendi vaade')).dy;
    final valuesTop = tester.getTopLeft(find.text('Mõõdetud väärtused')).dy;
    final contextTop = tester.getTopLeft(find.text('From -> To context')).dy;
    final advancedTop = tester.getTopLeft(find.text('Tehnilised detailid')).dy;
    expect(componentTop, lessThan(visualTop));
    expect(visualTop, lessThan(valuesTop));
    expect(valuesTop, lessThan(contextTop));
    expect(contextTop, lessThan(advancedTop));

    await tester.ensureVisible(find.text('Tehnilised detailid'));
    await tester.tap(find.text('Tehnilised detailid'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Trace ID: tr_measure_r101'), findsOneWidget);
    expect(find.textContaining('Photo ID: ph_measure_r101'), findsOneWidget);
    expect(find.textContaining('From component: cmp_r101'),
        findsAtLeastNWidgets(1));
    expect(
        find.textContaining('To component: cmp_u1'), findsAtLeastNWidgets(1));
    expect(
        find.textContaining('From pin: cmp_r101.2'), findsAtLeastNWidgets(1));
    expect(find.textContaining('To pin: cmp_u1.2'), findsAtLeastNWidgets(1));
    expect(
      find.textContaining('Measurement ID: M_measure_r101'),
      findsAtLeastNWidgets(1),
    );
    expect(
        find.textContaining('From -> To: cmp_r101.1 -> GND'), findsOneWidget);
    expect(
      find.text('Origin event ID: evt_measure_r101'),
      findsOneWidget,
    );
    expect(find.textContaining('Confidence: medium'), findsOneWidget);
    expect(
      find.textContaining('Notes: visible copper near selected component'),
      findsOneWidget,
    );

    expect(find.text('Measure Sheet'), findsNothing);
    expect(find.text('Koht → Väärtus → Ühik → Salvesta'), findsNothing);
    expect(state.events, isEmpty);

    await _tapCanvasAtNormalized(tester, x: 0.52, y: 0.61);
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('board_canvas_painter')), findsOneWidget);
    expect(
      find.byKey(const Key('board_canvas_integrated_measure_panel')),
      findsOneWidget,
    );
    expect(find.text('cmp_u1'), findsOneWidget);
    expect(state.events, isEmpty);
  });

  testWidgets(
      'integrated Measure panel target selection and draft capture stay local',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(1400, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    const linkedTrace = VisualTraceFact(
      traceId: 'tr_measure_r101',
      photoId: 'ph_measure_r101',
      evidenceType: 'visual_trace',
      fromComponent: 'cmp_r101',
      toComponent: 'cmp_u1',
      fromPin: 'cmp_r101.2',
      toPin: 'cmp_u1.2',
      confidence: 'medium',
      layer: 'top',
    );
    const linkedMeasurement = MeasurementFact(
      measurementId: 'M_measure_r101',
      mode: 'dc_voltage',
      from: 'cmp_r101.1',
      to: 'GND',
      reading: 'numeric',
      validityStatus: 'active',
      powerState: 'on',
      value: 5.01,
      unit: 'V',
      originEventId: 'evt_measure_r101',
    );
    final state = _inlineProjectState(
      components: const [
        ComponentFact(componentId: 'cmp_r101', designator: 'R101'),
        ComponentFact(componentId: 'cmp_u1'),
      ],
      placements: const [boardPlacement, boardPlacementWidthHeight],
      measurements: const [linkedMeasurement],
      visualTraces: const [linkedTrace],
    );

    await tester.pumpWidget(_harness(projectState: state));
    await tester.pumpAndSettle();
    await tester.tap(
      find.byKey(const Key('board_canvas_measure_sheet_button')),
    );
    await tester.pumpAndSettle();

    final targetRow =
        find.byKey(const Key('board_canvas_measure_target_row_cmp_r101.2'));
    await tester.ensureVisible(targetRow);
    await tester.tap(targetRow);
    await tester.pumpAndSettle();

    expect(
      find.byKey(
        const Key('board_canvas_measure_target_row_selected_cmp_r101.2'),
      ),
      findsOneWidget,
    );
    expect(find.text('Selected target: cmp_r101.2'), findsNothing);
    expect(find.text('Canvas focus: R101 / cmp_r101.2'), findsNothing);
    expect(
      find.byKey(const Key('board_canvas_measure_canvas_focus_text')),
      findsNothing,
    );
    expect(
      find.byKey(
        const Key('board_canvas_measure_visual_target_selected_cmp_r101.2'),
      ),
      findsOneWidget,
    );
    expect(
      find.byKey(
        const Key('board_canvas_measure_visual_selector_selected_cmp_r101.2'),
      ),
      findsNothing,
    );

    final existingTargetRow =
        find.byKey(const Key('board_canvas_measure_target_row_cmp_r101.1'));
    await tester.ensureVisible(existingTargetRow);
    await tester.tap(existingTargetRow);
    await tester.pumpAndSettle();
    expect(
      find.byKey(
        const Key('board_canvas_measure_target_row_selected_cmp_r101.1'),
      ),
      findsOneWidget,
    );
    expect(
      find.byKey(
        const Key('board_canvas_measure_visual_target_selected_cmp_r101.1'),
      ),
      findsOneWidget,
    );
    expect(
      find.byKey(
        const Key('board_canvas_measure_target_row_selected_cmp_r101.2'),
      ),
      findsNothing,
    );
    expect(
      find.byKey(
        const Key('board_canvas_measure_visual_target_selected_cmp_r101.2'),
      ),
      findsNothing,
    );

    await tester.ensureVisible(targetRow);
    await tester.tap(targetRow);
    await tester.pumpAndSettle();
    expect(
      find.byKey(
        const Key('board_canvas_measure_target_row_selected_cmp_r101.2'),
      ),
      findsOneWidget,
    );
    expect(
      find.byKey(
        const Key('board_canvas_measure_visual_target_selected_cmp_r101.2'),
      ),
      findsOneWidget,
    );
    expect(
      find.byKey(
        const Key('board_canvas_measure_target_row_selected_cmp_r101.1'),
      ),
      findsNothing,
    );
    expect(
      find.byKey(
        const Key('board_canvas_measure_visual_target_selected_cmp_r101.1'),
      ),
      findsNothing,
    );

    final valueInput = find.byKey(
      const Key('board_canvas_measure_row_value_input_cmp_r101.2'),
    );
    await tester.ensureVisible(valueInput);
    await tester.enterText(valueInput, '1.23');
    await tester.pumpAndSettle();

    final unitSelect = find.byKey(
      const Key('board_canvas_measure_row_unit_select_cmp_r101.2'),
    );
    await tester.ensureVisible(unitSelect);
    await tester.tap(unitSelect);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Ω').last);
    await tester.pumpAndSettle();

    expect(
      find.byKey(
        const Key('board_canvas_measure_local_draft_summary_cmp_r101.2'),
      ),
      findsOneWidget,
    );
    expect(
      find.text('Draft: Pin 2 · R101.2 = 1.23 Ω'),
      findsOneWidget,
    );
    expect(find.text('Draft: cmp_r101.2 -> cmp_u1.2 = 1.23 Ω'), findsNothing);
    expect(find.text('Local draft only — not saved to project.'), findsNothing);
    expect(find.text('Quick local capture'), findsNothing);
    expect(find.byKey(const Key('board_canvas_measure_pin_target_select')),
        findsNothing);
    expect(find.byKey(const Key('board_canvas_measure_save_placeholder')),
        findsNothing);
    expect(state.events, isEmpty);
  });

  testWidgets(
      'integrated Measure panel visual selector degrades without pin data',
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
    await tester.tap(
      find.byKey(const Key('board_canvas_measure_sheet_button')),
    );
    await tester.pumpAndSettle();

    expect(find.text('Local visual selector'), findsNothing);
    expect(
      find.byKey(
        const Key('board_canvas_measure_visual_target_selected_cmp_r101'),
      ),
      findsOneWidget,
    );
    expect(
      find.byKey(
        const Key('board_canvas_measure_visual_selector_selected_cmp_r101'),
      ),
      findsNothing,
    );
    expect(find.text('selected Component'), findsOneWidget);
    expect(find.text('Pin 1'), findsNothing);
    expect(
      find.byKey(
        const Key('board_canvas_measure_visual_selector_target_cmp_r101.1'),
      ),
      findsNothing,
    );
    expect(find.text('Visual only; no connectivity proof.'),
        findsAtLeastNWidgets(1));
    expect(state.events, isEmpty);
  });

  testWidgets('integrated Measure panel density keeps medium rows compact',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(1000, 760));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    const linkedTrace = VisualTraceFact(
      traceId: 'tr_measure_r101',
      photoId: 'ph_measure_r101',
      evidenceType: 'visual_trace',
      fromComponent: 'cmp_r101',
      toComponent: 'cmp_u1',
      fromPin: 'cmp_r101.2',
      toPin: 'cmp_u1.2',
      confidence: 'medium',
      layer: 'top',
    );
    const linkedMeasurement = MeasurementFact(
      measurementId: 'M_measure_r101',
      mode: 'dc_voltage',
      from: 'cmp_r101.1',
      to: 'GND',
      reading: 'numeric',
      validityStatus: 'active',
      powerState: 'on',
      value: 5.01,
      unit: 'V',
      originEventId: 'evt_measure_r101',
    );
    final state = _inlineProjectState(
      components: const [
        ComponentFact(componentId: 'cmp_r101', designator: 'R101'),
        ComponentFact(componentId: 'cmp_u1'),
      ],
      placements: const [boardPlacement, boardPlacementWidthHeight],
      measurements: const [linkedMeasurement],
      visualTraces: const [linkedTrace],
    );

    await tester.pumpWidget(_harness(projectState: state));
    await tester.pumpAndSettle();
    await tester.tap(
      find.byKey(const Key('board_canvas_measure_sheet_button')),
    );
    await tester.pumpAndSettle();

    final contextPanel = find.byKey(const Key('board_canvas_context_panel'));
    expect(contextPanel, findsOneWidget);
    expect(tester.getSize(contextPanel).width, 280);
    final measurePanelSurface = tester.widget<DecoratedBox>(
      find.byKey(const Key('board_canvas_measure_panel_surface')),
    );
    final panelDecoration = measurePanelSurface.decoration as BoxDecoration;
    expect(panelDecoration.color, const Color(0xFF161B22));

    expect(find.text('Pin 1 · R101.1'), findsOneWidget);
    expect(find.text('Pin 2 · R101.2'), findsOneWidget);
    expect(find.text('Pin 1 · cmp_r101.1'), findsNothing);
    expect(find.text('Pin 2 · cmp_r101.2'), findsNothing);

    final draftRow =
        find.byKey(const Key('board_canvas_measure_target_row_cmp_r101.2'));
    await tester.ensureVisible(draftRow);
    await tester.pumpAndSettle();

    final draftRowSize = tester.getSize(draftRow);
    expect(draftRowSize.height, lessThanOrEqualTo(74));

    final valueInput = find.byKey(
      const Key('board_canvas_measure_row_value_input_cmp_r101.2'),
    );
    final unitSelect = find.byKey(
      const Key('board_canvas_measure_row_unit_select_cmp_r101.2'),
    );
    expect(tester.getSize(valueInput).width, lessThanOrEqualTo(96));
    expect(tester.getSize(valueInput).height, lessThanOrEqualTo(34));
    expect(tester.getSize(unitSelect).width, lessThanOrEqualTo(56));
    expect(tester.getSize(unitSelect).height, lessThanOrEqualTo(34));

    expect(find.text('Quick local capture'), findsNothing);
    expect(find.byKey(const Key('board_canvas_measure_pin_target_select')),
        findsNothing);
    expect(find.text('From -> To context'), findsOneWidget);
    expect(find.text('Tehnilised detailid'), findsOneWidget);
    expect(find.text('Trace ID: tr_measure_r101'), findsNothing);
    expect(find.byKey(const Key('board_canvas_measure_continue_sheet_button')),
        findsOneWidget);
    expect(state.events, isEmpty);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
      'integrated Measure panel continue action opens existing Measure Sheet route',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(1400, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final state = _inlineProjectState(
      components: const [
        ComponentFact(componentId: 'cmp_r101', designator: 'R101'),
      ],
      placements: const [boardPlacement],
    );

    await tester.pumpWidget(_routerHarness(projectState: state));
    await tester.pumpAndSettle();
    await tester.tap(
      find.byKey(const Key('board_canvas_measure_sheet_button')),
    );
    await tester.pumpAndSettle();
    await tester.ensureVisible(
      find.byKey(const Key('board_canvas_measure_continue_sheet_button')),
    );
    await tester.tap(
      find.byKey(const Key('board_canvas_measure_continue_sheet_button')),
    );
    await tester.pumpAndSettle();

    expect(find.text('Measure Sheet'), findsAtLeastNWidgets(1));
    expect(find.text('Koht → Väärtus → Ühik → Salvesta'), findsOneWidget);
    expect(state.events, isEmpty);
  });

  testWidgets('direct Measure Sheet route remains compatible', (tester) async {
    final state = _inlineProjectState(
      components: const [
        ComponentFact(componentId: 'cmp_r101', designator: 'R101'),
      ],
      placements: const [boardPlacement],
    );

    await tester.pumpWidget(
      _routerHarness(
        projectState: state,
        initialLocation: '/project/measure-sheet',
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Measure Sheet'), findsAtLeastNWidgets(1));
    expect(find.text('Koht → Väärtus → Ühik → Salvesta'), findsOneWidget);
    expect(find.byType(BoardCanvasScreen), findsNothing);
    expect(state.events, isEmpty);
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
    expect(find.text('Paigutused'), findsOneWidget);
    expect(find.text('Placements'), findsNothing);
    expect(find.text('1 paigutus saadaval'), findsOneWidget);
    expect(find.text('1 placement available'), findsNothing);
    expect(find.text('Ohutus / tõendid'), findsOneWidget);
    expect(find.text('Safety / Evidence'), findsNothing);
    expect(find.textContaining('read-only'), findsAtLeastNWidgets(1));
    expect(find.widgetWithText(ChoiceChip, 'R101 (cmp_r101)'), findsNothing);
    expect(find.text('renderer writes: none'), findsOneWidget);
    expect(state.events, isEmpty);
  });

  testWidgets(
      'wide Workbench hides top disclosures and uses rail panel toggles',
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
      find.byKey(const Key('board_canvas_focus_toggle_button')),
      findsOneWidget,
    );
    expect(find.text('renderer writes: none'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
      'wide Workbench exposes contextual panel-mode rail and keeps focus on canvas',
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
    Finder railText(String text) =>
        find.descendant(of: railFinder, matching: find.text(text));
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
    expect(find.byKey(const Key('board_canvas_context_panel')), findsNothing);
    expect(
      find.byKey(const Key('board_canvas_rail_placements_tool')),
      findsOneWidget,
    );
    expect(
      find.byKey(const Key('board_canvas_rail_add_component_tool')),
      findsOneWidget,
    );
    expect(
      find.byKey(const Key('board_canvas_rail_safety_evidence_tool')),
      findsOneWidget,
    );
    expect(
      find.byKey(const Key('board_canvas_rail_inspector_tool')),
      findsOneWidget,
    );
    expect(find.text('renderer writes: none'), findsOneWidget);

    final futureTraceTool = tester.widget<IconButton>(
      find.byKey(const Key('board_canvas_rail_future_trace_tool')),
    );
    final futureMapTool = tester.widget<IconButton>(
      find.byKey(const Key('board_canvas_rail_future_repair_map_tool')),
    );
    final addComponentTool = tester.widget<IconButton>(
      find.byKey(const Key('board_canvas_rail_add_component_tool')),
    );
    final focusButton = tester.widget<IconButton>(
      find.byKey(const Key('board_canvas_focus_toggle_button')),
    );

    expect(futureTraceTool.onPressed, isNull);
    expect(futureMapTool.onPressed, isNull);
    expect(futureTraceTool.tooltip,
        'Rajakaart (tulekul/ainult vaatamine) - passiivne');
    expect(futureMapTool.tooltip, 'Paranduskaart (tulekul) - passiivne');
    expect(addComponentTool.tooltip, 'Ava komponendi lisamise malliloend');
    expect(focusButton.onPressed, isNotNull);
    expect(focusButton.tooltip, 'Fookusta plaat');
    expect(
      find.descendant(
        of: railFinder,
        matching: find.byKey(const Key('board_canvas_focus_toggle_button')),
      ),
      findsNothing,
    );
    expect(find.byKey(const Key('board_canvas_focus_toggle_button')),
        findsOneWidget);
    expect(railText('Paneelid'), findsNothing);
    expect(railText('Tulekul'), findsNothing);
    expect(railText('Tulevased tööriistad'), findsNothing);
    expect(find.text('Pa...'), findsNothing);
    expect(find.text('Tul...'), findsNothing);
    expect(find.text('Future tools'), findsNothing);
    expect(railText('Lisa'), findsOneWidget);
    expect(railText('Lisa komponent'), findsNothing);
    expect(find.text('Add Component'), findsNothing);
    expect(railText('Paigutused'), findsOneWidget);
    expect(find.text('Placements'), findsNothing);
    expect(railText('Ohutus'), findsOneWidget);
    expect(find.text('Safety'), findsNothing);
    expect(railText('Inspektor'), findsOneWidget);
    expect(find.text('Inspector'), findsNothing);
    expect(railText('Rajad'), findsOneWidget);
    expect(railText('Rajakaart'), findsNothing);
    expect(find.text('Trace'), findsNothing);
    expect(railText('Parandus'), findsOneWidget);
    expect(railText('Paranduskaart'), findsNothing);
    expect(find.text('Repair map'), findsNothing);

    final railSemanticsLabels = tester
        .widgetList<Semantics>(
          find.descendant(of: railFinder, matching: find.byType(Semantics)),
        )
        .map((widget) => widget.properties.label)
        .whereType<String>()
        .toList();
    expect(railSemanticsLabels, contains('Paneelid'));
    expect(railSemanticsLabels, contains('Tulevased tööriistad'));
    expect(railSemanticsLabels, contains('Lisa komponent panel mode'));
    await tester
        .tap(find.byKey(const Key('board_canvas_rail_safety_evidence_tool')));
    await tester.pump(const Duration(milliseconds: 16));
    expect(
      find.byKey(const Key('board_canvas_rail_safety_active')),
      findsOneWidget,
    );
    final selectedSafetyTileFinder =
        find.byKey(const Key('board_canvas_rail_safety_tile'));
    final addComponentTileFinder =
        find.byKey(const Key('board_canvas_rail_add_component_tile'));
    expect(selectedSafetyTileFinder, findsOneWidget);
    expect(addComponentTileFinder, findsOneWidget);
    final selectedSafetyTileSize = tester.getSize(selectedSafetyTileFinder);
    final addComponentTileSize = tester.getSize(addComponentTileFinder);
    expect(selectedSafetyTileSize.width, lessThan(railSize.width * 0.6));
    expect(
        selectedSafetyTileSize.width, closeTo(addComponentTileSize.width, 1));
    expect(
      selectedSafetyTileSize.height,
      closeTo(addComponentTileSize.height, 1),
    );
    final selectedSafetyTile =
        tester.widget<Container>(selectedSafetyTileFinder);
    final selectedSafetyDecoration =
        selectedSafetyTile.decoration as BoxDecoration;
    expect(selectedSafetyDecoration.boxShadow, isNotEmpty);
    expect(
      find.byKey(const Key('board_canvas_rail_inspector_active')),
      findsNothing,
    );
    expect(
      find.byKey(const Key('board_canvas_rail_placements_active')),
      findsNothing,
    );
    expect(
      find.byKey(const Key('board_canvas_rail_placements_tool')),
      findsOneWidget,
    );
    expect(railSize.width, lessThan(120));
    expect(state.events, isEmpty);
  });

  testWidgets('wide Workbench opens Add Component template-list panel',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(1400, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final state = _inlineProjectState(
      components: const [
        ComponentFact(componentId: 'cmp_r101', designator: 'R101'),
        ComponentFact(componentId: 'cmp_u1', designator: 'U1'),
      ],
      placements: const [boardPlacement, boardPlacementWidthHeight],
    );

    await tester.pumpWidget(_harness(projectState: state));
    await tester.pumpAndSettle();

    await tester.tap(
      find.byKey(const Key('board_canvas_rail_add_component_tool')),
    );
    await tester.pump(const Duration(milliseconds: 16));

    expect(
      find.byKey(const Key('board_canvas_context_panel')),
      findsOneWidget,
    );
    expect(
      find.byKey(const Key('board_canvas_add_component_template_list')),
      findsOneWidget,
    );
    expect(
      find.text('Visuaalsed algmallid'),
      findsOneWidget,
    );
    expect(
      find.byKey(const Key('board_canvas_add_component_template_picker_label')),
      findsOneWidget,
    );
    expect(find.text('Pick a footprint'), findsOneWidget);
    const forbiddenTemplateText = [
      'SOT-23',
      'SOIC',
      'QFN',
      'DIP',
    ];
    for (final forbidden in forbiddenTemplateText) {
      expect(find.textContaining(forbidden), findsNothing);
    }
    expect(
      find.byKey(
        const Key(
          'board_canvas_add_component_template_template_family_rect_2_top_bottom',
        ),
      ),
      findsOneWidget,
    );
    expect(
      find.byKey(
        const Key(
          'board_canvas_add_component_template_shape_template_family_rect_2_top_bottom',
        ),
      ),
      findsOneWidget,
    );
    expect(
      find.byKey(
        const Key(
          'board_canvas_add_component_template_shape_template_family_rect_4_perimeter',
        ),
      ),
      findsOneWidget,
    );
    expect(
      find.byKey(
        const Key(
          'board_canvas_add_component_template_shape_template_family_rect_6_edge_balance',
        ),
      ),
      findsOneWidget,
    );
    expect(
      find.byKey(
        const Key(
          'board_canvas_add_component_template_shape_template_family_small_3_side_package',
        ),
      ),
      findsOneWidget,
    );
    expect(
      find.byKey(
        const Key(
          'board_canvas_add_component_template_shape_template_family_connector_strip',
        ),
      ),
      findsOneWidget,
    );
    expect(
      find.byKey(
        const Key(
          'board_canvas_add_component_template_shape_template_family_radial_round',
        ),
      ),
      findsOneWidget,
    );
    expect(
      find.byKey(
        const Key(
          'board_canvas_add_component_template_shape_template_family_generic_blank',
        ),
      ),
      findsOneWidget,
    );
    expect(
      find.byKey(
        const Key(
            'board_canvas_add_component_template_template_family_small_3_side_package'),
      ),
      findsOneWidget,
    );
    expect(
      find.byKey(
        const Key(
            'board_canvas_add_component_template_shape_template_family_small_3_side_package'),
      ),
      findsOneWidget,
    );
    expect(
      find.byKey(
        const Key(
            'board_canvas_add_component_template_template_family_connector_strip'),
      ),
      findsOneWidget,
    );
    expect(
      find.byKey(
        const Key(
            'board_canvas_add_component_template_shape_template_family_connector_strip'),
      ),
      findsOneWidget,
    );
    expect(
      find.byKey(
        const Key(
            'board_canvas_add_component_template_template_family_radial_round'),
      ),
      findsOneWidget,
    );
    expect(
      find.byKey(
        const Key(
            'board_canvas_add_component_template_shape_template_family_radial_round'),
      ),
      findsOneWidget,
    );
    expect(
      find.byKey(
        const Key(
            'board_canvas_add_component_template_template_family_generic_blank'),
      ),
      findsOneWidget,
    );
    expect(
      find.byKey(
        const Key(
            'board_canvas_add_component_template_shape_template_family_generic_blank'),
      ),
      findsOneWidget,
    );

    expect(find.text('Rectangular chip'), findsOneWidget);
    expect(find.text('Small 3-side package'), findsOneWidget);
    expect(find.text('Dual-row package'), findsOneWidget);
    expect(find.text('Quad-row package'), findsOneWidget);
    expect(find.text('Connector strip'), findsOneWidget);
    expect(find.text('Radial / round'), findsOneWidget);
    expect(find.text('Generic blank'), findsOneWidget);
    expect(find.text('2 contacts'), findsWidgets);
    expect(find.text('4 contacts'), findsWidgets);
    expect(find.text('8 contacts'), findsWidgets);
    expect(find.text('3 contacts'), findsWidgets);
    expect(find.text('0 contacts'), findsWidgets);
    expect(find.textContaining('template family'), findsNothing);
    expect(find.textContaining('rectangular-perimeter geometry'), findsNothing);
    expect(find.textContaining('visual contacts'), findsNothing);
    expect(find.textContaining('template shape'), findsNothing);
    expect(
      find.byKey(const Key('board_canvas_rail_add_component_active')),
      findsOneWidget,
    );
    expect(state.events, isEmpty);

    await tester.tap(
      find.byKey(
        const Key(
          'board_canvas_add_component_template_template_family_rect_2_top_bottom',
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 16));
    expect(
      find.byKey(
        const Key(
          'board_canvas_add_component_template_template_family_rect_2_top_bottom_selected',
        ),
      ),
      findsOneWidget,
    );
    expect(
      find.byKey(const Key('board_canvas_add_component_template_summary')),
      findsOneWidget,
    );
    expect(
      find.byKey(
          const Key('board_canvas_add_component_template_summary_shape')),
      findsOneWidget,
    );
    expect(
      find.byKey(const Key('board_canvas_add_component_builder_visual_body')),
      findsOneWidget,
    );
    expect(
        find.byKey(
            const Key('board_canvas_add_component_template_builder_top_value')),
        findsOneWidget);
    expect(state.events, isEmpty);
  });

  testWidgets('template cards are compact and visual in browse mode',
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

    await tester.tap(
      find.byKey(const Key('board_canvas_rail_add_component_tool')),
    );
    await tester.pump(const Duration(milliseconds: 16));

    expect(find.textContaining('template family'), findsNothing);
    expect(find.textContaining('rectangular-perimeter geometry'), findsNothing);

    expect(
      find.byKey(const Key('board_canvas_add_component_template_list_rows')),
      findsOneWidget,
    );
    expect(
      find.byKey(
        const Key(
          'board_canvas_add_component_template_shape_template_family_rect_2_top_bottom',
        ),
      ),
      findsOneWidget,
    );
    expect(
      find.byKey(
        const Key(
          'board_canvas_add_component_template_shape_template_family_rect_4_perimeter',
        ),
      ),
      findsOneWidget,
    );
    expect(
      find.byKey(
        const Key(
          'board_canvas_add_component_template_shape_template_family_rect_6_edge_balance',
        ),
      ),
      findsOneWidget,
    );

    final firstTemplateBounds = tester.getRect(
      find.byKey(
        const Key(
          'board_canvas_add_component_template_template_family_rect_2_top_bottom',
        ),
      ),
    );
    final secondTemplateBounds = tester.getRect(
      find.byKey(
        const Key(
          'board_canvas_add_component_template_template_family_rect_4_perimeter',
        ),
      ),
    );
    final thirdTemplateBounds = tester.getRect(
      find.byKey(
        const Key(
          'board_canvas_add_component_template_template_family_rect_6_edge_balance',
        ),
      ),
    );
    final fourthTemplateBounds = tester.getRect(
      find.byKey(
        const Key(
          'board_canvas_add_component_template_template_family_small_3_side_package',
        ),
      ),
    );
    expect(firstTemplateBounds.height, lessThanOrEqualTo(60));
    expect(secondTemplateBounds.height, lessThanOrEqualTo(60));
    expect(thirdTemplateBounds.height, lessThanOrEqualTo(60));
    expect(firstTemplateBounds.width, lessThan(700));
    expect(secondTemplateBounds.width, lessThan(700));
    expect(thirdTemplateBounds.width, lessThan(700));
    expect(fourthTemplateBounds.height, lessThanOrEqualTo(60));
    expect(fourthTemplateBounds.width, lessThan(700));

    expect(find.text('2 contacts'), findsWidgets);
    expect(find.text('4 contacts'), findsWidgets);
    expect(find.text('8 contacts'), findsWidgets);
    expect(find.text('3 contacts'), findsWidgets);
    expect(find.text('0 contacts'), findsWidgets);
    expect(state.events, isEmpty);
  });

  testWidgets(
      'Add Component template selection is local volatile in-memory state only',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(1400, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final state = _inlineProjectState(
      components: const [
        ComponentFact(componentId: 'cmp_r101', designator: 'R101'),
      ],
      placements: const [boardPlacement],
    );

    await tester.pumpWidget(
      _harness(projectState: state, boardCanvasKey: const ValueKey('first')),
    );
    await tester.pumpAndSettle();

    await tester
        .tap(find.byKey(const Key('board_canvas_rail_add_component_tool')));
    await tester.pump(const Duration(milliseconds: 16));
    await tester.tap(
      find.byKey(
        const Key(
          'board_canvas_add_component_template_template_family_rect_2_top_bottom',
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 16));

    expect(
      find.byKey(
        const Key(
          'board_canvas_add_component_template_template_family_rect_2_top_bottom_selected',
        ),
      ),
      findsOneWidget,
    );

    await tester.pumpWidget(
      _harness(projectState: state, boardCanvasKey: const ValueKey('second')),
    );
    await tester.pumpAndSettle();
    expect(
      find.byKey(
        const Key(
          'board_canvas_add_component_template_template_family_rect_2_top_bottom_selected',
        ),
      ),
      findsNothing,
    );
    expect(state.events, isEmpty);
  });

  testWidgets(
      'Select Add Component template opens right-panel visual-contact builder',
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

    await tester.tap(
      find.byKey(const Key('board_canvas_rail_add_component_tool')),
    );
    await tester.pump(const Duration(milliseconds: 16));
    await tester.tap(
      find.byKey(
        const Key(
          'board_canvas_add_component_template_template_family_rect_2_top_bottom',
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 16));

    expect(
      find.byKey(const Key('board_canvas_add_component_template_builder')),
      findsOneWidget,
    );
    expect(
      find.byKey(const Key('board_canvas_add_component_template_summary')),
      findsOneWidget,
    );
    expect(
      find.byKey(
        const Key('board_canvas_add_component_template_summary_shape'),
      ),
      findsOneWidget,
    );
    expect(
      find.byKey(const Key('board_canvas_add_component_builder_card')),
      findsOneWidget,
    );
    expect(
      find.byKey(const Key('board_canvas_add_component_change_template')),
      findsOneWidget,
    );
    expect(
      find.byKey(const Key('board_canvas_add_component_builder_visual_body')),
      findsOneWidget,
    );
    expect(
      find.byKey(const Key('board_canvas_add_component_template_list_rows')),
      findsNothing,
    );
    expect(
      find.byKey(const Key('board_canvas_add_component_builder_preview')),
      findsOneWidget,
    );
    expect(
      find.text('UI-local marker draft'),
      findsOneWidget,
    );
    expect(
      find.text('Per-side markers are UI-local; not confirmed contacts.'),
      findsOneWidget,
    );
    expect(find.textContaining('template family'), findsNothing);
    expect(
      find.byKey(
        const Key(
          'board_canvas_add_component_template_builder_top_value',
        ),
      ),
      findsOneWidget,
    );
    expect(state.events, isEmpty);
  });

  testWidgets(
      'visual-contact builder panel uses compact layout and shared contact marker context',
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

    await tester.tap(
      find.byKey(const Key('board_canvas_rail_add_component_tool')),
    );
    await tester.pump(const Duration(milliseconds: 16));
    await tester.tap(
      find.byKey(
        const Key(
          'board_canvas_add_component_template_template_family_rect_2_top_bottom',
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 16));

    expect(find.text('UI-local markers'), findsOneWidget);
    expect(
      find.text('Per-side markers are UI-local; not confirmed contacts.'),
      findsOneWidget,
    );
    expect(find.text('Top contact marker'), findsNothing);
    expect(find.text('Right contact marker'), findsNothing);
    expect(find.text('Bottom contact marker'), findsNothing);
    expect(find.text('Left contact marker'), findsNothing);

    expect(
      find.byKey(
        const Key('board_canvas_add_component_builder_top_control'),
      ),
      findsOneWidget,
    );
    expect(
      find.byKey(
        const Key('board_canvas_add_component_builder_right_control'),
      ),
      findsOneWidget,
    );
    expect(
      find.byKey(
        const Key('board_canvas_add_component_builder_bottom_control'),
      ),
      findsOneWidget,
    );
    expect(
      find.byKey(
        const Key('board_canvas_add_component_builder_left_control'),
      ),
      findsOneWidget,
    );
    expect(
      find.byKey(
        const Key(
          'board_canvas_add_component_builder_reset_to_defaults',
        ),
      ),
      findsOneWidget,
    );

    final previewSize = tester.getSize(
      find.byKey(const Key('board_canvas_add_component_builder_preview')),
    );
    expect(
      find.byKey(
        const Key('board_canvas_add_component_builder_visual_body'),
      ),
      findsOneWidget,
    );
    expect(previewSize.height, lessThan(170));
    expect(previewSize.width, greaterThan(previewSize.height));
    expect(state.events, isEmpty);
  });

  testWidgets(
      'visual-contact builder controls are spatially attached to the rectangular preview',
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

    await tester.tap(
      find.byKey(const Key('board_canvas_rail_add_component_tool')),
    );
    await tester.pump(const Duration(milliseconds: 16));
    await tester.tap(
      find.byKey(
        const Key(
          'board_canvas_add_component_template_template_family_rect_2_top_bottom',
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 16));

    final topRect = tester.getRect(
      find.byKey(const Key('board_canvas_add_component_builder_top_control')),
    );
    final rightRect = tester.getRect(
      find.byKey(const Key('board_canvas_add_component_builder_right_control')),
    );
    final bottomRect = tester.getRect(
      find.byKey(
        const Key('board_canvas_add_component_builder_bottom_control'),
      ),
    );
    final leftRect = tester.getRect(
      find.byKey(const Key('board_canvas_add_component_builder_left_control')),
    );
    final bodyRect = tester.getRect(
      find.byKey(const Key('board_canvas_add_component_builder_preview')),
    );

    expect(topRect.center.dy, lessThan(bodyRect.top));
    expect(topRect.bottom, lessThan(bodyRect.top));
    expect(bottomRect.center.dy, greaterThan(bodyRect.bottom));
    expect(bottomRect.top, greaterThan(bodyRect.bottom));
    expect(leftRect.center.dx, lessThan(bodyRect.left));
    expect(leftRect.right, lessThan(bodyRect.left));
    expect(rightRect.center.dx, greaterThan(bodyRect.right));
    expect(rightRect.left, greaterThan(bodyRect.right));
    expect(topRect, isNot(equals(bodyRect)));
    expect(state.events, isEmpty);
  });

  testWidgets(
      'selected template summary is primary and change-template restores template list',
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

    await tester
        .tap(find.byKey(const Key('board_canvas_rail_add_component_tool')));
    await tester.pump(const Duration(milliseconds: 16));
    await tester.tap(
      find.byKey(
        const Key(
          'board_canvas_add_component_template_template_family_rect_4_perimeter',
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 16));

    final summaryTop = tester.getTopLeft(
      find.byKey(const Key('board_canvas_add_component_template_summary')),
    );
    final builderTop = tester.getTopLeft(
      find.byKey(const Key('board_canvas_add_component_template_builder')),
    );
    expect(builderTop.dy, greaterThan(summaryTop.dy));
    expect(
      find.textContaining('template family'),
      findsNothing,
    );
    expect(
      find.byKey(
          const Key('board_canvas_add_component_template_summary_shape')),
      findsOneWidget,
    );
    expect(
      find.byKey(const Key('board_canvas_add_component_builder_visual_body')),
      findsOneWidget,
    );

    expect(
      find.byKey(const Key('board_canvas_add_component_template_list_rows')),
      findsNothing,
    );
    expect(
      find.byKey(const Key('board_canvas_add_component_change_template')),
      findsOneWidget,
    );

    await _tapWidgetByKey(
      tester,
      const Key('board_canvas_add_component_change_template'),
    );
    await tester.pump(const Duration(milliseconds: 16));

    expect(
      find.byKey(const Key('board_canvas_add_component_template_list_rows')),
      findsOneWidget,
    );
    expect(
      find.byKey(const Key('board_canvas_add_component_template_builder')),
      findsNothing,
    );
    await tester.tap(
      find.byKey(
        const Key(
          'board_canvas_add_component_template_template_family_rect_2_top_bottom',
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 16));
    expect(state.events, isEmpty);
  });

  testWidgets(
      'visual-contact builder top/right/bottom/left counts are editable locally',
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

    await tester.tap(
      find.byKey(const Key('board_canvas_rail_add_component_tool')),
    );
    await tester.pump(const Duration(milliseconds: 16));
    await tester.tap(
      find.byKey(
        const Key(
          'board_canvas_add_component_template_template_family_rect_2_top_bottom',
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 16));

    String topCountText() => tester
        .widget<Text>(
          find.byKey(
            const Key('board_canvas_add_component_template_builder_top_value'),
          ),
        )
        .data!;

    String rightCountText() => tester
        .widget<Text>(
          find.byKey(
            const Key(
                'board_canvas_add_component_template_builder_right_value'),
          ),
        )
        .data!;

    String bottomCountText() => tester
        .widget<Text>(
          find.byKey(
            const Key(
                'board_canvas_add_component_template_builder_bottom_value'),
          ),
        )
        .data!;

    String leftCountText() => tester
        .widget<Text>(
          find.byKey(
            const Key('board_canvas_add_component_template_builder_left_value'),
          ),
        )
        .data!;

    expect(topCountText(), '1');
    expect(rightCountText(), '0');
    expect(bottomCountText(), '1');
    expect(leftCountText(), '0');

    await _tapWidgetByKey(
      tester,
      const Key('board_canvas_add_component_template_builder_top_increment'),
    );
    await tester.pump(const Duration(milliseconds: 16));
    await _tapWidgetByKey(
      tester,
      const Key('board_canvas_add_component_template_builder_right_increment'),
    );
    await tester.pump(const Duration(milliseconds: 16));
    await _tapWidgetByKey(
      tester,
      const Key('board_canvas_add_component_template_builder_bottom_increment'),
    );
    await tester.pump(const Duration(milliseconds: 16));
    await _tapWidgetByKey(
      tester,
      const Key('board_canvas_add_component_template_builder_left_increment'),
    );
    await tester.pump(const Duration(milliseconds: 16));

    expect(topCountText(), '2');
    expect(rightCountText(), '1');
    expect(bottomCountText(), '2');
    expect(leftCountText(), '1');
    expect(state.events, isEmpty);
  });

  testWidgets(
      'template selection reseeds builder counts from template defaults',
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

    await tester
        .tap(find.byKey(const Key('board_canvas_rail_add_component_tool')));
    await tester.pump(const Duration(milliseconds: 16));
    await _tapWidgetByKey(
      tester,
      const Key(
        'board_canvas_add_component_template_template_family_rect_2_top_bottom',
      ),
    );
    await tester.pump(const Duration(milliseconds: 16));

    expect(
      tester
          .widget<Text>(
            find.byKey(const Key(
                'board_canvas_add_component_template_builder_top_value')),
          )
          .data,
      '1',
    );
    expect(
      tester
          .widget<Text>(
            find.byKey(
              const Key(
                  'board_canvas_add_component_template_builder_right_value'),
            ),
          )
          .data,
      '0',
    );
    expect(
      tester
          .widget<Text>(
            find.byKey(
              const Key(
                  'board_canvas_add_component_template_builder_bottom_value'),
            ),
          )
          .data,
      '1',
    );
    expect(
      tester
          .widget<Text>(
            find.byKey(
              const Key(
                  'board_canvas_add_component_template_builder_left_value'),
            ),
          )
          .data,
      '0',
    );

    await _tapWidgetByKey(
      tester,
      const Key('board_canvas_add_component_template_builder_top_increment'),
    );
    await tester.pump(const Duration(milliseconds: 16));
    await _tapWidgetByKey(
      tester,
      const Key('board_canvas_add_component_template_builder_right_increment'),
    );
    await tester.pump(const Duration(milliseconds: 16));
    await _tapWidgetByKey(
      tester,
      const Key('board_canvas_add_component_template_builder_top_increment'),
    );
    await tester.pump(const Duration(milliseconds: 16));
    expect(
      tester
          .widget<Text>(
            find.byKey(const Key(
                'board_canvas_add_component_template_builder_top_value')),
          )
          .data,
      '3',
    );
    expect(
      tester
          .widget<Text>(
            find.byKey(
              const Key(
                  'board_canvas_add_component_template_builder_right_value'),
            ),
          )
          .data,
      '1',
    );

    await _tapWidgetByKey(
      tester,
      const Key('board_canvas_add_component_change_template'),
    );
    await tester.pump(const Duration(milliseconds: 16));
    await tester.tap(
      find.byKey(
        const Key(
          'board_canvas_add_component_template_template_family_rect_4_perimeter',
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 16));

    expect(
      tester
          .widget<Text>(
            find.byKey(const Key(
                'board_canvas_add_component_template_builder_top_value')),
          )
          .data,
      '0',
    );
    expect(
      tester
          .widget<Text>(
            find.byKey(
              const Key(
                  'board_canvas_add_component_template_builder_right_value'),
            ),
          )
          .data,
      '4',
    );
    expect(
      tester
          .widget<Text>(
            find.byKey(
              const Key(
                  'board_canvas_add_component_template_builder_bottom_value'),
            ),
          )
          .data,
      '0',
    );
    expect(
      tester
          .widget<Text>(
            find.byKey(
              const Key(
                  'board_canvas_add_component_template_builder_left_value'),
            ),
          )
          .data,
      '4',
    );
    expect(
      find.byKey(
          const Key('board_canvas_add_component_builder_zero_markers_hint')),
      findsNothing,
    );
    expect(state.events, isEmpty);
  });

  testWidgets(
      'each visual template opens and reseeds builder and ghost body shape',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(1400, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final state = _inlineProjectState(
      components: const [
        ComponentFact(componentId: 'cmp_r101', designator: 'R101'),
      ],
      placements: const [boardPlacement],
    );

    const templateDefaults = <String, List<int>>{
      'template_family_rect_2_top_bottom': [1, 0, 1, 0],
      'template_family_rect_4_perimeter': [0, 4, 0, 4],
      'template_family_rect_6_edge_balance': [2, 2, 2, 2],
      'template_family_small_3_side_package': [1, 1, 1, 0],
      'template_family_connector_strip': [4, 0, 0, 0],
      'template_family_radial_round': [1, 0, 1, 0],
      'template_family_generic_blank': [0, 0, 0, 0],
    };
    const templateBodyRatios = <String, double>{
      'template_family_rect_2_top_bottom': 2.4,
      'template_family_rect_4_perimeter': 1.65,
      'template_family_rect_6_edge_balance': 1.2,
      'template_family_small_3_side_package': 1.35,
      'template_family_connector_strip': 4.0,
      'template_family_radial_round': 1.0,
      'template_family_generic_blank': 2.0,
    };
    final orderedTemplates = templateDefaults.keys.toList();

    await tester.pumpWidget(_harness(projectState: state));
    await tester.pumpAndSettle();

    await tester.tap(
      find.byKey(const Key('board_canvas_rail_add_component_tool')),
    );
    await tester.pump(const Duration(milliseconds: 16));

    for (final templateId in orderedTemplates) {
      if (templateId != orderedTemplates.first) {
        await _tapWidgetByKey(
          tester,
          const Key('board_canvas_add_component_change_template'),
        );
        await tester.pump(const Duration(milliseconds: 16));
      }

      await tester.tap(
        find.byKey(Key('board_canvas_add_component_template_$templateId')),
      );
      await tester.pump(const Duration(milliseconds: 16));

      final defaults = templateDefaults[templateId]!;
      final ratio = templateBodyRatios[templateId]!;
      expect(
        tester
            .widget<Text>(
              find.byKey(const Key(
                  'board_canvas_add_component_template_builder_top_value')),
            )
            .data,
        '${defaults[0]}',
      );
      expect(
        tester
            .widget<Text>(
              find.byKey(const Key(
                  'board_canvas_add_component_template_builder_right_value')),
            )
            .data,
        '${defaults[1]}',
      );
      expect(
        tester
            .widget<Text>(
              find.byKey(const Key(
                  'board_canvas_add_component_template_builder_bottom_value')),
            )
            .data,
        '${defaults[2]}',
      );
      expect(
        tester
            .widget<Text>(
              find.byKey(const Key(
                  'board_canvas_add_component_template_builder_left_value')),
            )
            .data,
        '${defaults[3]}',
      );
      final previewRect = tester.getRect(
        find.byKey(Key(
          'board_canvas_add_component_builder_preview_$templateId',
        )),
      );
      expect(
        previewRect.width / previewRect.height,
        closeTo(ratio, 0.45),
      );
      final ghostRect = tester.getRect(
        find.byKey(
          Key('board_canvas_add_component_template_ghost_preview_body_$templateId'),
        ),
      );
      expect(
        ghostRect.width / ghostRect.height,
        closeTo(ratio, 0.45),
      );
      expect(
        find.byKey(
          Key('board_canvas_add_component_template_ghost_preview_body_$templateId'),
        ),
        findsOneWidget,
      );
      expect(state.events, isEmpty);
    }
  });

  testWidgets('builder warning states expose zero/excessive hint UI only',
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

    await tester
        .tap(find.byKey(const Key('board_canvas_rail_add_component_tool')));
    await tester.pump(const Duration(milliseconds: 16));
    await _tapWidgetByKey(
      tester,
      const Key(
          'board_canvas_add_component_template_template_family_radial_round'),
    );
    await tester.pump(const Duration(milliseconds: 16));

    await _tapWidgetByKey(
      tester,
      const Key('board_canvas_add_component_template_builder_top_decrement'),
    );
    await tester.pump(const Duration(milliseconds: 16));
    await _tapWidgetByKey(
      tester,
      const Key('board_canvas_add_component_template_builder_right_decrement'),
    );
    await tester.pump(const Duration(milliseconds: 16));
    await _tapWidgetByKey(
      tester,
      const Key('board_canvas_add_component_template_builder_bottom_decrement'),
    );
    await tester.pump(const Duration(milliseconds: 16));
    await _tapWidgetByKey(
      tester,
      const Key('board_canvas_add_component_template_builder_left_decrement'),
    );
    await tester.pump(const Duration(milliseconds: 16));

    expect(
      tester
          .widget<Text>(
            find.byKey(const Key(
                'board_canvas_add_component_template_builder_top_value')),
          )
          .data,
      '0',
    );
    expect(
      tester
          .widget<Text>(
            find.byKey(
              const Key(
                  'board_canvas_add_component_template_builder_right_value'),
            ),
          )
          .data,
      '0',
    );
    expect(
      tester
          .widget<Text>(
            find.byKey(
              const Key(
                  'board_canvas_add_component_template_builder_bottom_value'),
            ),
          )
          .data,
      '0',
    );
    expect(
      tester
          .widget<Text>(
            find.byKey(
              const Key(
                  'board_canvas_add_component_template_builder_left_value'),
            ),
          )
          .data,
      '0',
    );
    expect(
      find.byKey(
          const Key('board_canvas_add_component_builder_zero_markers_hint')),
      findsOneWidget,
    );

    for (var i = 0; i < 9; i++) {
      await _tapWidgetByKey(
        tester,
        const Key('board_canvas_add_component_template_builder_top_increment'),
      );
      await tester.pump(const Duration(milliseconds: 16));
    }

    expect(
      tester
          .widget<Text>(
            find.byKey(const Key(
                'board_canvas_add_component_template_builder_top_value')),
          )
          .data,
      '9',
    );
    expect(
      find.byKey(
        const Key('board_canvas_add_component_builder_excessive_markers_hint'),
      ),
      findsOneWidget,
    );
    expect(state.events, isEmpty);
  });

  testWidgets('visual-contact builder reset returns template defaults',
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

    await tester.tap(
      find.byKey(const Key('board_canvas_rail_add_component_tool')),
    );
    await tester.pump(const Duration(milliseconds: 16));
    await tester.tap(
      find.byKey(
        const Key(
          'board_canvas_add_component_template_template_family_rect_4_perimeter',
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 16));

    await _tapWidgetByKey(
      tester,
      const Key('board_canvas_add_component_template_builder_top_increment'),
    );
    await tester.pump(const Duration(milliseconds: 16));
    await _tapWidgetByKey(
      tester,
      const Key('board_canvas_add_component_template_builder_right_increment'),
    );
    await tester.pump(const Duration(milliseconds: 16));

    expect(
      tester
          .widget<Text>(
            find.byKey(
              const Key(
                'board_canvas_add_component_template_builder_top_value',
              ),
            ),
          )
          .data,
      '1',
    );
    expect(
      tester
          .widget<Text>(
            find.byKey(
              const Key(
                'board_canvas_add_component_template_builder_right_value',
              ),
            ),
          )
          .data,
      '5',
    );

    await _tapWidgetByKey(
      tester,
      const Key('board_canvas_add_component_builder_reset_to_defaults'),
    );
    await tester.pump(const Duration(milliseconds: 16));

    expect(
      tester
          .widget<Text>(
            find.byKey(
              const Key(
                'board_canvas_add_component_template_builder_top_value',
              ),
            ),
          )
          .data,
      '0',
    );
    expect(
      tester
          .widget<Text>(
            find.byKey(
              const Key(
                'board_canvas_add_component_template_builder_right_value',
              ),
            ),
          )
          .data,
      '4',
    );
    expect(state.events, isEmpty);
  });

  testWidgets('visual-contact builder mode has no write/placement controls',
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

    await tester.tap(
      find.byKey(const Key('board_canvas_rail_add_component_tool')),
    );
    await tester.pump(const Duration(milliseconds: 16));
    await tester.tap(
      find.byKey(
        const Key(
          'board_canvas_add_component_template_template_family_rect_2_top_bottom',
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 16));

    expect(
      find.byKey(const Key('board_canvas_add_component_builder_confirm')),
      findsNothing,
    );
    expect(
      find.byKey(const Key('board_canvas_add_component_builder_place')),
      findsNothing,
    );
    expect(
      find.byKey(const Key('board_canvas_add_component_builder_rotation')),
      findsNothing,
    );
    expect(find.textContaining('Confirm'), findsNothing);
    expect(state.events, isEmpty);
  });

  testWidgets(
      'local Add Component template ghost preview appears only when builder is active',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(1400, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    const measurement = MeasurementFact(
      measurementId: 'M990',
      mode: 'dc_voltage',
      from: 'cmp_r101',
      to: 'GND',
      reading: 'numeric',
      validityStatus: 'active',
      powerState: 'on',
      value: 9.9,
      unit: 'V',
    );
    final state = _inlineProjectState(
      components: const [
        ComponentFact(componentId: 'cmp_r101', designator: 'R101')
      ],
      placements: const [boardPlacement],
      measurements: const [measurement],
    );

    await tester.pumpWidget(_harness(projectState: state));
    await tester.pumpAndSettle();

    await tester.tap(
      find.byKey(const Key('board_canvas_rail_add_component_tool')),
    );
    await tester.pump(const Duration(milliseconds: 16));

    expect(
      find.byKey(
          const Key('board_canvas_add_component_template_ghost_preview')),
      findsNothing,
    );

    await tester.tap(
      find.byKey(
        const Key(
          'board_canvas_add_component_template_template_family_rect_4_perimeter',
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 16));

    expect(
      find.byKey(
          const Key('board_canvas_add_component_template_ghost_preview')),
      findsOneWidget,
    );
    expect(
      find.byKey(
        const Key(
          'board_canvas_add_component_template_ghost_preview_body',
        ),
      ),
      findsOneWidget,
    );
    expect(
      find.byKey(
        const Key(
          'board_canvas_add_component_template_draft_label_input',
        ),
      ),
      findsOneWidget,
    );
    expect(
      find.byKey(
        const Key(
          'board_canvas_add_component_template_ghost_preview_status',
        ),
      ),
      findsOneWidget,
    );
    expect(find.textContaining('Draft / unsaved'), findsOneWidget);
    final ghostPaint = tester.widget<CustomPaint>(
      find.byKey(
        const Key('board_canvas_add_component_template_ghost_preview_body'),
      ),
    );
    final ghostPainter = ghostPaint.painter as dynamic;
    expect(ghostPainter.boundaryColor, const Color(0xFF7B3FF2));
    expect(ghostPainter.markerColor, const Color(0xFF5E35B1));
    expect(ghostPainter.fillColor, const Color(0x227B3FF2));
    await tester.enterText(
      find.byKey(
        const Key('board_canvas_add_component_template_draft_label_input'),
      ),
      'AGH789',
    );
    await tester.pump(const Duration(milliseconds: 16));
    expect(
      find.descendant(
        of: find.byKey(
          const Key('board_canvas_add_component_template_ghost_preview'),
        ),
        matching: find.text('AGH789'),
      ),
      findsOneWidget,
    );
    final statusRect = tester.getRect(
      find.byKey(
        const Key('board_canvas_add_component_template_ghost_preview_status'),
      ),
    );
    final bodyRect = tester.getRect(
      find.byKey(
        const Key('board_canvas_add_component_template_ghost_preview_body'),
      ),
    );
    expect(statusRect.top, lessThan(bodyRect.top));

    await _tapWidgetByKey(
      tester,
      const Key('board_canvas_measurement_value_badge_global_toggle'),
    );
    await tester.pump(const Duration(milliseconds: 16));
    expect(
      find.byKey(const Key('board_canvas_measurement_value_badge_M990')),
      findsOneWidget,
    );

    await _tapWidgetByKey(
      tester,
      const Key('board_canvas_add_component_change_template'),
    );
    await tester.pump(const Duration(milliseconds: 16));
    expect(
      find.byKey(
          const Key('board_canvas_add_component_template_ghost_preview')),
      findsNothing,
    );
    expect(state.events, isEmpty);
  });

  testWidgets(
      'clicking board canvas moves Add Component ghost as local draft only',
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

    await tester.tap(
      find.byKey(const Key('board_canvas_rail_add_component_tool')),
    );
    await tester.pump(const Duration(milliseconds: 16));
    await _tapWidgetByKey(
      tester,
      const Key(
        'board_canvas_add_component_template_template_family_rect_4_perimeter',
      ),
    );

    final ghostBodyFinder = find.byKey(
      const Key('board_canvas_add_component_template_ghost_preview_body'),
    );
    expect(ghostBodyFinder, findsOneWidget);
    final defaultGhostBodyRect = tester.getRect(ghostBodyFinder);

    final painterFinder = find.byKey(const Key('board_canvas_painter'));
    final painterTopLeft = tester.getTopLeft(painterFinder);
    final painterSize = tester.getSize(painterFinder);
    await tester.tapAt(
      painterTopLeft +
          Offset(painterSize.width * 0.72, painterSize.height * 0.28),
    );
    await tester.pump(const Duration(milliseconds: 16));

    expect(
      find.byKey(
        const Key('board_canvas_add_component_template_ghost_draft_position'),
      ),
      findsOneWidget,
    );
    final movedGhostBodyRect = tester.getRect(ghostBodyFinder);
    expect(
      movedGhostBodyRect.center.dx,
      greaterThan(defaultGhostBodyRect.center.dx + 80),
    );
    expect(
      movedGhostBodyRect.center.dy,
      lessThan(defaultGhostBodyRect.center.dy - 50),
    );
    expect(state.events, isEmpty);
    expect(
      find.byKey(const Key('board_canvas_add_component_builder_confirm')),
      findsNothing,
    );
    expect(
      find.byKey(const Key('board_canvas_add_component_builder_place')),
      findsNothing,
    );
    expect(
      find.byKey(const Key('board_canvas_add_component_builder_rotation')),
      findsNothing,
    );

    await _tapWidgetByKey(
      tester,
      const Key('board_canvas_add_component_builder_reset_to_defaults'),
    );
    final resetGhostBodyRect = tester.getRect(ghostBodyFinder);
    expect(
      resetGhostBodyRect.center.dx,
      lessThan(movedGhostBodyRect.center.dx - 80),
    );
    expect(
      resetGhostBodyRect.center.dy,
      greaterThan(movedGhostBodyRect.center.dy + 50),
    );

    await _tapWidgetByKey(
      tester,
      const Key('board_canvas_add_component_change_template'),
    );
    expect(ghostBodyFinder, findsNothing);
    expect(state.events, isEmpty);
  });

  testWidgets('dragging Add Component ghost updates local draft position only',
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

    await tester.tap(
      find.byKey(const Key('board_canvas_rail_add_component_tool')),
    );
    await tester.pump(const Duration(milliseconds: 16));
    await _tapWidgetByKey(
      tester,
      const Key(
        'board_canvas_add_component_template_template_family_rect_4_perimeter',
      ),
    );

    final ghostBodyFinder = find.byKey(
      const Key('board_canvas_add_component_template_ghost_preview_body'),
    );
    expect(ghostBodyFinder, findsOneWidget);
    final beforeDragRect = tester.getRect(ghostBodyFinder);

    final dragStart = tester.getCenter(
      find.byKey(
        const Key('board_canvas_add_component_template_ghost_drag_handle'),
      ),
    );
    const fastDragDelta = Offset(260, 120);
    final gesture = await tester.startGesture(dragStart);
    await gesture.moveBy(fastDragDelta);
    await tester.pump(const Duration(milliseconds: 16));
    await gesture.up();
    await tester.pump(const Duration(milliseconds: 16));

    expect(
      find.byKey(
        const Key('board_canvas_add_component_template_ghost_draft_position'),
      ),
      findsOneWidget,
    );
    final afterDragRect = tester.getRect(ghostBodyFinder);
    expect(
      afterDragRect.center.dx,
      closeTo(beforeDragRect.center.dx + fastDragDelta.dx, 12),
    );
    expect(
      afterDragRect.center.dy,
      closeTo(beforeDragRect.center.dy + fastDragDelta.dy, 12),
    );
    expect(state.events, isEmpty);
    expect(
      find.byKey(const Key('board_canvas_add_component_builder_confirm')),
      findsNothing,
    );
    expect(
      find.byKey(const Key('board_canvas_add_component_builder_place')),
      findsNothing,
    );
    expect(
      find.byKey(const Key('board_canvas_add_component_builder_rotation')),
      findsNothing,
    );
    expect(find.textContaining('Edit Layout'), findsNothing);
    expect(find.textContaining('Resize'), findsNothing);
    expect(find.textContaining('Snap'), findsNothing);
    expect(find.textContaining('Grid'), findsNothing);
    expect(find.textContaining('Magnet'), findsNothing);
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
    final contextPanelFinder =
        find.byKey(const Key('board_canvas_context_panel'));
    expect(contextPanelFinder, findsOneWidget);
    expect(
      find.descendant(
        of: contextPanelFinder,
        matching: find.text('Paigutused'),
      ),
      findsOneWidget,
    );
    expect(find.widgetWithText(ChoiceChip, 'R101 (cmp_r101)'), findsOneWidget);
    expect(
      find.byKey(const Key('board_canvas_rail_placements_active')),
      findsOneWidget,
    );

    await _openWideContextMode(tester, placements: false);
    expect(contextPanelFinder, findsOneWidget);
    expect(
      find.descendant(
        of: contextPanelFinder,
        matching: find.text('Ohutus / tõendid'),
      ),
      findsOneWidget,
    );
    expect(find.text('Body outline'), findsOneWidget);
    expect(
      find.byKey(const Key('board_canvas_rail_safety_active')),
      findsOneWidget,
    );
    expect(
      find.byKey(const Key('board_canvas_rail_placements_active')),
      findsNothing,
    );
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

  testWidgets(
      'wide Workbench shows inspector in right context when selecting placement',
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
    expect(
      find.byKey(const Key('board_canvas_rail_inspector_active')),
      findsOneWidget,
    );
    expect(find.textContaining('Component ID: cmp_r101'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
      'focus canvas hides rail canvas chrome and restores read-only panel',
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
    expect(find.byKey(const Key('board_canvas_context_panel')), findsOneWidget);
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
    expect(find.byTooltip('Sobita / taasta vaade'), findsOneWidget);
    expect(
      find.descendant(
        of: find.byKey(const Key('board_canvas_fit_view_button')),
        matching: find.text('Sobita'),
      ),
      findsOneWidget,
    );
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

  test('measurement badge count supports multiple related measurements (M3)',
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

  testWidgets(
      'measurement value badge controls are discoverable and hidden by default',
      (tester) async {
    const measurement = MeasurementFact(
      measurementId: 'M900',
      mode: 'dc_voltage',
      from: 'cmp_r101',
      to: 'GND',
      reading: 'numeric',
      validityStatus: 'active',
      powerState: 'on',
      value: 4.987,
      unit: 'V',
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
    await tester.pump(const Duration(milliseconds: 16));

    expect(
      find.byKey(
          const Key('board_canvas_measurement_value_badge_global_toggle')),
      findsOneWidget,
    );
    expect(find.text('Näita kõiki'), findsOneWidget);
    expect(
      find.byKey(const Key('board_canvas_measurement_value_badge_M900')),
      findsNothing,
    );

    await _selectPlacement(tester, 'cmp_r101');

    expect(
      find.byKey(
        const Key('board_canvas_selected_measurement_value_badge_toggle'),
      ),
      findsOneWidget,
    );
    expect(find.text('Show measurement badge'), findsOneWidget);
    expect(find.text('renderer writes: none'), findsOneWidget);
  });

  testWidgets(
      'selected component measurement value toggle shows and hides only that component',
      (tester) async {
    const r101Measurement = MeasurementFact(
      measurementId: 'M901',
      mode: 'dc_voltage',
      from: 'cmp_r101',
      to: 'GND',
      reading: 'numeric',
      validityStatus: 'active',
      powerState: 'on',
      value: 1.1,
      unit: 'V',
    );
    const u1Measurement = MeasurementFact(
      measurementId: 'M902',
      mode: 'dc_voltage',
      from: 'cmp_u1',
      to: 'GND',
      reading: 'numeric',
      validityStatus: 'active',
      powerState: 'on',
      value: 2.2,
      unit: 'V',
    );
    final state = _inlineProjectState(
      components: const [
        ComponentFact(componentId: 'cmp_r101', designator: 'R101'),
        ComponentFact(componentId: 'cmp_u1', designator: 'U1'),
      ],
      placements: const [boardPlacement, boardPlacementWidthHeight],
      measurements: const [r101Measurement, u1Measurement],
    );

    await tester.pumpWidget(_harness(projectState: state));
    await _selectPlacement(tester, 'R101 (cmp_r101)');
    await _tapWidgetByKey(
      tester,
      const Key('board_canvas_selected_measurement_value_badge_toggle'),
    );

    expect(
      find.byKey(const Key('board_canvas_measurement_value_badge_M901')),
      findsOneWidget,
    );
    expect(
      find.byKey(const Key('board_canvas_measurement_value_badge_M902')),
      findsNothing,
    );
    expect(find.text('Hide measurement badge'), findsOneWidget);

    await _tapWidgetByKey(
      tester,
      const Key('board_canvas_selected_measurement_value_badge_toggle'),
    );

    expect(
      find.byKey(const Key('board_canvas_measurement_value_badge_M901')),
      findsNothing,
    );
    expect(
      find.byKey(const Key('board_canvas_measurement_value_badge_M902')),
      findsNothing,
    );
    expect(state.events, isEmpty);
  });

  testWidgets('global measurement value toggle shows and hides all badges',
      (tester) async {
    const r101Measurement = MeasurementFact(
      measurementId: 'M903',
      mode: 'dc_voltage',
      from: 'cmp_r101',
      to: 'GND',
      reading: 'numeric',
      validityStatus: 'active',
      powerState: 'on',
      value: 3.3,
      unit: 'V',
    );
    const u1Measurement = MeasurementFact(
      measurementId: 'M904',
      mode: 'dc_voltage',
      from: 'cmp_u1',
      to: 'GND',
      reading: 'numeric',
      validityStatus: 'active',
      powerState: 'on',
      value: 4.4,
      unit: 'V',
    );
    final state = _inlineProjectState(
      components: const [
        ComponentFact(componentId: 'cmp_r101', designator: 'R101'),
        ComponentFact(componentId: 'cmp_u1', designator: 'U1'),
      ],
      placements: const [boardPlacement, boardPlacementWidthHeight],
      measurements: const [r101Measurement, u1Measurement],
    );

    await tester.pumpWidget(_harness(projectState: state));
    await _tapWidgetByKey(
      tester,
      const Key('board_canvas_measurement_value_badge_global_toggle'),
    );

    expect(find.text('Peida kõik'), findsOneWidget);
    expect(
      find.byKey(const Key('board_canvas_measurement_value_badge_M903')),
      findsOneWidget,
    );
    expect(
      find.byKey(const Key('board_canvas_measurement_value_badge_M904')),
      findsOneWidget,
    );
    expect(find.text('3.3 V'), findsOneWidget);
    expect(find.text('4.4 V'), findsOneWidget);

    await _tapWidgetByKey(
      tester,
      const Key('board_canvas_measurement_value_badge_global_toggle'),
    );

    expect(find.text('Näita kõiki'), findsOneWidget);
    expect(
      find.byKey(const Key('board_canvas_measurement_value_badge_M903')),
      findsNothing,
    );
    expect(
      find.byKey(const Key('board_canvas_measurement_value_badge_M904')),
      findsNothing,
    );
    expect(state.events, isEmpty);
  });

  testWidgets(
      'multiple measurement value badges stack deterministically without aggregation',
      (tester) async {
    const measurements = [
      MeasurementFact(
        measurementId: 'M912',
        mode: 'dc_voltage',
        from: 'cmp_r101',
        to: 'GND',
        reading: 'numeric',
        validityStatus: 'active',
        powerState: 'on',
        value: 2.0,
        unit: 'V',
      ),
      MeasurementFact(
        measurementId: 'M911',
        mode: 'dc_voltage',
        from: 'cmp_r101.1',
        to: 'GND',
        reading: 'numeric',
        validityStatus: 'active',
        powerState: 'on',
        value: 1.0,
        unit: 'V',
      ),
    ];

    await tester.pumpWidget(
      _harness(
        projectState: _inlineProjectState(
          components: const [ComponentFact(componentId: 'cmp_r101')],
          placements: const [boardPlacement],
          measurements: measurements,
        ),
      ),
    );
    await _tapWidgetByKey(
      tester,
      const Key('board_canvas_measurement_value_badge_global_toggle'),
    );

    final firstTop = tester.getTopLeft(
      find.byKey(const Key('board_canvas_measurement_value_badge_M911')),
    );
    final secondTop = tester.getTopLeft(
      find.byKey(const Key('board_canvas_measurement_value_badge_M912')),
    );

    expect(firstTop.dy, lessThan(secondTop.dy));
    expect(find.text('1.0 V'), findsOneWidget);
    expect(find.text('2.0 V'), findsOneWidget);
    expect(find.text('3.0 V'), findsNothing);
  });

  testWidgets(
      'stale suspect and invalid measurement value badges are not fresh authoritative',
      (tester) async {
    const measurements = [
      MeasurementFact(
        measurementId: 'M920',
        mode: 'dc_voltage',
        from: 'cmp_r101',
        to: 'GND',
        reading: 'numeric',
        validityStatus: 'stale_after_repair',
        powerState: 'off',
        value: 3.3,
        unit: 'V',
      ),
      MeasurementFact(
        measurementId: 'M921',
        mode: 'dc_voltage',
        from: 'cmp_r101.1',
        to: 'GND',
        reading: 'numeric',
        validityStatus: 'suspect',
        powerState: 'off',
        value: 3.4,
        unit: 'V',
      ),
      MeasurementFact(
        measurementId: 'M922',
        mode: 'dc_voltage',
        from: 'cmp_r101.2',
        to: 'GND',
        reading: 'numeric',
        validityStatus: 'invalid',
        powerState: 'off',
        value: 3.5,
        unit: 'V',
      ),
    ];

    await tester.pumpWidget(
      _harness(
        projectState: _inlineProjectState(
          components: const [ComponentFact(componentId: 'cmp_r101')],
          placements: const [boardPlacement],
          measurements: measurements,
        ),
      ),
    );
    await _tapWidgetByKey(
      tester,
      const Key('board_canvas_measurement_value_badge_global_toggle'),
    );

    expect(
      find.byKey(const Key('board_canvas_measurement_value_badge_M920')),
      findsOneWidget,
    );
    expect(
      find.byKey(const Key('board_canvas_measurement_value_badge_M921')),
      findsOneWidget,
    );
    expect(
      find.byKey(const Key('board_canvas_measurement_value_badge_M922')),
      findsOneWidget,
    );
    expect(
      find.byKey(
        const Key('board_canvas_measurement_value_badge_status_M920'),
      ),
      findsOneWidget,
    );
    expect(
      find.byKey(
        const Key('board_canvas_measurement_value_badge_status_M921'),
      ),
      findsOneWidget,
    );
    expect(
      find.byKey(
        const Key('board_canvas_measurement_value_badge_status_M922'),
      ),
      findsOneWidget,
    );
    expect(
      find.byTooltip(
        'stale_after_repair - not fresh authoritative value',
      ),
      findsOneWidget,
    );
    expect(
      find.byTooltip('suspect - not fresh authoritative value'),
      findsOneWidget,
    );
    expect(
      find.byTooltip('invalid - not fresh authoritative value'),
      findsOneWidget,
    );
  });

  testWidgets(
      'incomplete measurement value badge eligibility renders no overlay control',
      (tester) async {
    const missingValue = MeasurementFact(
      measurementId: 'M930',
      mode: 'dc_voltage',
      from: 'cmp_r101',
      to: 'GND',
      reading: 'numeric',
      validityStatus: 'active',
      powerState: 'on',
      unit: 'V',
    );
    const missingUnit = MeasurementFact(
      measurementId: 'M931',
      mode: 'dc_voltage',
      from: 'cmp_r101',
      to: 'GND',
      reading: 'numeric',
      validityStatus: 'active',
      powerState: 'on',
      value: 1.2,
    );
    const missingAssociation = MeasurementFact(
      measurementId: 'M932',
      mode: 'dc_voltage',
      from: 'floating_node',
      to: 'GND',
      reading: 'numeric',
      validityStatus: 'active',
      powerState: 'on',
      value: 1.3,
      unit: 'V',
    );
    const photoOnlyAnchor = MeasurementFact(
      measurementId: 'M933',
      mode: 'dc_voltage',
      from: 'cmp_photo',
      to: 'GND',
      reading: 'numeric',
      validityStatus: 'active',
      powerState: 'on',
      value: 1.4,
      unit: 'V',
    );

    await tester.pumpWidget(
      _harness(
        projectState: _inlineProjectState(
          components: const [
            ComponentFact(componentId: 'cmp_r101'),
            ComponentFact(componentId: 'cmp_photo'),
          ],
          placements: const [boardPlacement, photoLocalPlacement],
          measurements: const [
            missingValue,
            missingUnit,
            missingAssociation,
            photoOnlyAnchor,
          ],
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 16));

    expect(
      find.byKey(
          const Key('board_canvas_measurement_value_badge_global_toggle')),
      findsNothing,
    );
    expect(
      find.byKey(const Key('board_canvas_measurement_value_badge_M930')),
      findsNothing,
    );
    expect(
      find.byKey(const Key('board_canvas_measurement_value_badge_M931')),
      findsNothing,
    );
    expect(
      find.byKey(const Key('board_canvas_measurement_value_badge_M932')),
      findsNothing,
    );
    expect(
      find.byKey(const Key('board_canvas_measurement_value_badge_M933')),
      findsNothing,
    );
  });

  testWidgets('measurement value badge visibility is volatile widget state',
      (tester) async {
    const measurement = MeasurementFact(
      measurementId: 'M940',
      mode: 'dc_voltage',
      from: 'cmp_r101',
      to: 'GND',
      reading: 'numeric',
      validityStatus: 'active',
      powerState: 'on',
      value: 4.0,
      unit: 'V',
    );
    final state = _inlineProjectState(
      components: const [ComponentFact(componentId: 'cmp_r101')],
      placements: const [boardPlacement],
      measurements: const [measurement],
    );

    await tester.pumpWidget(
      _harness(projectState: state, boardCanvasKey: const ValueKey('first')),
    );
    await _tapWidgetByKey(
      tester,
      const Key('board_canvas_measurement_value_badge_global_toggle'),
    );
    expect(
      find.byKey(const Key('board_canvas_measurement_value_badge_M940')),
      findsOneWidget,
    );

    await tester.pumpWidget(
      _harness(projectState: state, boardCanvasKey: const ValueKey('second')),
    );
    await tester.pump(const Duration(milliseconds: 16));

    expect(
      find.byKey(const Key('board_canvas_measurement_value_badge_M940')),
      findsNothing,
    );
    expect(state.events, isEmpty);
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

  testWidgets(
      'placement editor shell exposes session-only draft controls without writes',
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

    expect(
      find.byKey(const Key('board_canvas_placement_editor_shell')),
      findsOneWidget,
    );
    expect(find.text('Placement draft'), findsOneWidget);
    expect(find.text('unsaved/session-only'), findsOneWidget);
    expect(find.text('Draft changes stay in memory only.'), findsOneWidget);
    expect(
        find.text('Canonical projection remains unchanged.'), findsOneWidget);
    expect(
      find.text('Selected component: R101 (cmp_r101)'),
      findsOneWidget,
    );
    expect(find.text('Board side draft: top'), findsOneWidget);
    expect(find.text('Shape/template draft: sot23_3'), findsOneWidget);
    expect(find.text('Rotation draft: 15 deg'), findsOneWidget);
    expect(find.text('Width draft: 1.00'), findsOneWidget);
    expect(find.text('Height draft: 0.60'), findsOneWidget);
    expect(find.textContaining('Component ID: cmp_r101'), findsOneWidget);
    expect(find.textContaining('Board side: top'), findsOneWidget);
    expect(find.textContaining('Rotation (deg): 15'), findsOneWidget);

    await _tapWidgetByKey(
      tester,
      const Key('board_canvas_placement_draft_side_toggle'),
    );
    await _tapWidgetByKey(
      tester,
      const Key('board_canvas_placement_draft_rotation_increment'),
    );
    await _tapWidgetByKey(
      tester,
      const Key('board_canvas_placement_draft_width_increment'),
    );
    await _tapWidgetByKey(
      tester,
      const Key('board_canvas_placement_draft_height_increment'),
    );

    expect(find.text('Board side draft: bottom'), findsOneWidget);
    expect(find.text('Rotation draft: 30 deg'), findsOneWidget);
    expect(find.text('Width draft: 1.10'), findsOneWidget);
    expect(find.text('Height draft: 0.70'), findsOneWidget);
    expect(find.textContaining('Board side: top'), findsOneWidget);
    expect(find.textContaining('Rotation (deg): 15'), findsOneWidget);
    expect(find.text('Confirm'), findsNothing);
    expect(find.text('Save'), findsNothing);
    expect(find.text('Edit'), findsNothing);
    expect(find.text('Edit Layout'), findsNothing);
    expect(state.events, isEmpty);

    await _tapWidgetByKey(
      tester,
      const Key('board_canvas_placement_draft_reset'),
    );
    expect(find.text('Board side draft: top'), findsOneWidget);
    expect(find.text('Rotation draft: 15 deg'), findsOneWidget);
    expect(find.text('Width draft: 1.00'), findsOneWidget);
    expect(find.text('Height draft: 0.60'), findsOneWidget);

    await _tapWidgetByKey(
      tester,
      const Key('board_canvas_placement_draft_width_increment'),
    );
    expect(find.text('Width draft: 1.10'), findsOneWidget);
    await _tapWidgetByKey(
      tester,
      const Key('board_canvas_placement_draft_discard'),
    );
    expect(find.text('Width draft: 1.00'), findsOneWidget);
    expect(find.text('Height draft: 0.60'), findsOneWidget);
    expect(state.events, isEmpty);
  });

  testWidgets('placement draft state is selection-scoped and volatile',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(1400, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final state = _inlineProjectState(
      components: const [
        ComponentFact(componentId: 'cmp_r101', designator: 'R101'),
        ComponentFact(componentId: 'cmp_u1', designator: 'U1'),
      ],
      placements: const [boardPlacement, boardPlacementWidthHeight],
    );

    await tester.pumpWidget(
      _harness(projectState: state, boardCanvasKey: const ValueKey('first')),
    );
    await tester.pumpAndSettle();
    await _selectPlacement(tester, 'R101 (cmp_r101)');
    await _tapWidgetByKey(
      tester,
      const Key('board_canvas_placement_draft_width_increment'),
    );
    expect(find.text('Width draft: 1.10'), findsOneWidget);

    await _selectPlacement(tester, 'U1 (cmp_u1)');
    expect(find.text('Width draft: 1.50'), findsOneWidget);
    expect(find.text('Height draft: 0.80'), findsOneWidget);
    expect(find.text('Width draft: 1.10'), findsNothing);

    await tester.pumpWidget(
      _harness(projectState: state, boardCanvasKey: const ValueKey('second')),
    );
    await tester.pump(const Duration(milliseconds: 16));
    await _selectPlacement(tester, 'R101 (cmp_r101)');
    expect(find.text('Width draft: 1.00'), findsOneWidget);
    expect(find.text('Width draft: 1.10'), findsNothing);
    expect(state.events, isEmpty);
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
    expect(source, contains('_footprintVisualKind('));
    expect(source, contains('knownFacts.pins'));
    expect(source, contains('knownFacts.componentPinIndex'));
    expect(source, contains('_knownPinVisualRefsByComponentId'));
    expect(source, contains('_footprintPinRenderPlan'));
    expect(source, contains('_FootprintPinRenderMode.templateGeometry'));
    expect(source, contains('_FootprintPinRenderMode.knownPinList'));
    expect(source, contains('_FootprintPinRenderMode.none'));
    expect(source, contains('_drawDecorativePackagePads'));
    expect(source, isNot(contains('_drawLogicalPinTokens')));
    expect(source, isNot(contains('_drawLogicalPinToken')));
    expect(source, isNot(contains('_drawLogicalPinCountCue')));
    expect(source, isNot(contains('_logicalPinTokenLayout')));
    expect(source, isNot(contains('_logicalPinTokenLabel')));
    expect(source, contains('_renderedFootprintVisualSize'));
    expect(source, contains('_minimumFootprintVisualEnvelope'));
    expect(source, contains('return const Size(56, 40);'));
    expect(source, contains('return const Size(44, 18);'));
    expect(source, contains('return const Size(40, 40);'));
    expect(source, contains('return const Size(52, 40);'));
    expect(source, contains('return const Size(44, 22);'));
    expect(source, contains('return const Size(22, 22);'));
    expect(source, contains('return const Size(32, 22);'));
    expect(source, contains('_drawFootprintSurfaceDetails'));
    expect(source, isNot(contains('_drawFallbackPads')));
    expect(source, contains('_drawSelectionRing'));
    expect(source, contains('_drawDashedRRect'));
    expect(source, contains('selectedEntry: widget.selectedEntry'));
    expect(source, contains('_FootprintPreviewPainter'));
    expect(source, contains('_reservedPinControlGutterWidth'));
    expect(source, contains('_kPreviewFootprintVerticalCenterOffset'));
    expect(source, contains('board_canvas_measure_component_left_gutter'));
    expect(source, contains('board_canvas_measure_component_center_slot'));
    expect(source, contains('board_canvas_measure_component_right_gutter'));
    expect(source, contains('_previewFootprintBodyRect'));
    expect(source, contains('fixedSlotBodyRect'));
    expect(
        source, contains('board_canvas_measure_component_footprint_preview'));
    expect(source, contains('Component preview footprint visual'));
    expect(source, contains('_footprintVisualKind(entry!)'));
    expect(source, contains('_BoardPlacementPainter._drawFootprintBody'));
    expect(source,
        contains('_BoardPlacementPainter._drawFootprintSurfaceDetails'));
    expect(
        source, contains('_BoardPlacementPainter._drawDecorativePackagePads'));
    expect(source, contains('_ContactVisibilityState'));
    expect(source, contains('_ContactVisibilityState.bodyOnly'));
    expect(source, contains('_contactVisibilityStateForEntry'));
    expect(source, contains('_shouldDrawFootprintContacts'));
    expect(source, contains('confirmedVisualContacts'));
    expect(source, contains('return _ContactVisibilityState.bodyOnly;'));
    expect(source, contains('_FootprintVisualKind.transistor3'));
    expect(source, contains('_FootprintVisualKind.testPoint'));
    expect(source, contains('transistor 3-terminal footprint'));
    expect(source, contains('test point / ground footprint'));
    expect(source, contains('Visual only; contacts not added.'));
    expect(source, contains('contacts not added'));
    expect(source, contains('Visual only; no connectivity proof.'));
    expect(source, isNot(contains('Visual only; pin locations not verified.')));
    expect(source, isNot(contains('visual package pads are decorative')));
    expect(source, isNot(contains('logical pin token')));
    expect(source, contains('_templatePinMatchesTarget'));
    expect(
      source,
      contains(
        'Component visual editing entry is deferred to a later explicit scope.',
      ),
    );
    expect(
        source, isNot(contains('board_canvas_component_visual_edit_button')));
    expect(source, contains('_kFootprintCopper'));
    expect(
      source,
      contains(
        'Rotation visual support is intentionally deferred to a later explicit rotation scope.',
      ),
    );
    expect(source, isNot(contains('canvas.rotate(')));
    expect(source, isNot(contains('_paintMeasurementPresenceBadge')));
    expect(
      source,
      isNot(contains(r"final badgeText = measurementCount == 1 ? 'm'")),
    );
    expect(source, isNot(contains('badgeCenter')));
    expect(source, isNot(contains('canvas.drawRRect(badgeRect')));
    expect(
      source,
      isNot(contains(
          r"final badgeText = measurementCount == 1 ? 'M' : 'M$measurementCount';")),
    );
    expect(source, contains('CustomPainterSemantics'));
    expect(source, contains('SemanticsProperties'));
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
    expect(source, isNot(contains('v2_save_measurement_' 'writer')));
    expect(source, isNot(contains('V2SaveMeasurementWriter')));
    expect(source, isNot(contains('v2SaveMeasurementWriter')));
    expect(source, isNot(contains('ProjectExporter')));
    expect(source, isNot(contains('ProjectCreator')));
    expect(source, isNot(contains('ProjectOverviewScreen')));
    expect(source, isNot(contains('jsonDecode(')));
    expect(source, isNot(contains('known_facts.json')));
    expect(source, isNot(contains('events.jsonl')));
    expect(source, isNot(contains('board_graph.json')));
    expect(source, isNot(contains('view_state.json')));
    expect(source, contains('_PlacementEditorDraftState'));
    expect(source, contains('board_canvas_placement_editor_shell'));
    expect(source, contains('unsaved/session-only'));
    expect(source, contains('Draft changes stay in memory only.'));
    expect(source, contains('Canonical projection remains unchanged.'));
    expect(source,
        contains('Per-side markers are UI-local; not confirmed contacts.'));
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
