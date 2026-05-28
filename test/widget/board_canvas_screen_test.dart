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
  await tester.tap(find.text(label).first);
  await tester.pumpAndSettle();
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
        projectState: _inlineProjectState(components: const [], placements: const []),
      ),
    );

    expect(
      find.text('No components recorded for this project.'),
      findsOneWidget,
    );
  });

  testWidgets('shows no-placements state when project has components but no placements',
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

  testWidgets('renders board-normalized placement path and keeps read-only chrome',
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
    expect(find.text('No confirmed visual placements yet.'), findsNothing);
    expect(find.text('renderer writes: none'), findsOneWidget);
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

  testWidgets('renders width-height mode placement without error', (tester) async {
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

  testWidgets('missing template_id fallback renders without crash', (tester) async {
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

  testWidgets('unknown template_id fallback renders without crash', (tester) async {
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

  testWidgets('selecting placement from dropdown shows read-only inspector details',
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
    expect(find.textContaining('Coordinate space: board_normalized'), findsOneWidget);
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

  testWidgets('inspector preserves width-height mode when placement uses width and height',
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
          components: const [ComponentFact(componentId: 'cmp_missing_template')],
          placements: const [missingTemplate],
        ),
      ),
    );

    await _selectPlacement(tester, 'cmp_missing_template');

    expect(find.textContaining('Template ID: not provided'), findsOneWidget);
    expect(find.textContaining('Package: Unknown package geometry'), findsOneWidget);
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
          components: const [ComponentFact(componentId: 'cmp_unknown_template')],
          placements: const [unknownTemplate],
        ),
      ),
    );

    await _selectPlacement(tester, 'cmp_unknown_template');

    expect(find.textContaining('Template ID: unknown_not_in_registry'), findsOneWidget);
    expect(find.textContaining('Package: Unknown package geometry'), findsOneWidget);
  });

  testWidgets('unknown fallback templates render without crash', (tester) async {
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

  testWidgets('designator appears only when present in known facts', (tester) async {
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
      'Run AI',
      'Detect components',
      'Add component',
    ];

    for (final action in forbiddenActions) {
      expect(find.text(action), findsNothing, reason: 'Unexpected action label: $action');
    }
  });

  testWidgets('measurement summary includes measurement when from equals componentId',
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

    expect(find.textContaining('Measurement ID: M001'), findsOneWidget);
  });

  testWidgets('measurement summary includes measurement when to equals componentId',
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

  testWidgets('Q2 does not match Q20 in measurement association', (tester) async {
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
    expect(find.text('No related measurements for selected component.'), findsOneWidget);
  });

  testWidgets('measurement summary shows safe copy and verbatim value', (tester) async {
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
    expect(find.text('Value shown verbatim'), findsOneWidget);
    expect(find.text('Does not create or confirm a net'), findsOneWidget);
    expect(find.text('No board coordinate available'), findsOneWidget);
    expect(find.textContaining('Value: 4.987 V'), findsOneWidget);
  });

  testWidgets('stale measurement shows stale after repair label', (tester) async {
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
    expect(find.textContaining('Valid until event ID: evt_800008'), findsOneWidget);
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

  testWidgets('Q2 does not match Q20 in visual trace association', (tester) async {
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
    expect(find.text('No related visual traces for selected component.'), findsOneWidget);
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
    expect(
      find.text('Visual trace is not a confirmed electrical net'),
      findsOneWidget,
    );
    expect(
      find.text('Photo-local evidence; no board coordinate available'),
      findsOneWidget,
    );
    expect(find.text('Does not create or confirm connectivity'), findsOneWidget);
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
    await tester.pumpAndSettle();

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
    expect(source, isNot(contains('MeasurementEventWriter')));
    expect(source, isNot(contains('ProjectExporter')));
    expect(source, isNot(contains('ProjectCreator')));
    expect(source, isNot(contains('jsonDecode(')));
    expect(source, isNot(contains('known_facts.json')));
    expect(source, isNot(contains('events.jsonl')));
    expect(source, isNot(contains('board_graph.json')));
    expect(source, isNot(contains('view_state.json')));
    expect(source, contains('knownFacts.visualTraces'));
    expect(source, isNot(contains('knownFacts.damageRegions')));
    expect(source, isNot(contains('knownFacts.suspectRegions')));
    expect(source, isNot(contains('knownFacts.nets')));
    expect(source, isNot(contains('from_point')));
    expect(source, isNot(contains('to_point')));
    expect(source, isNot(contains('drawLine(')));
    expect(source, isNot(contains('drawPath(')));
    expect(source, isNot(contains('Promote to net')));
    expect(source, isNot(contains('drawMeasurement')));
    expect(source, isNot(contains('measurementOverlay')));
    expect(source, isNot(contains('measurementAnchor')));
    expect(source, isNot(contains('measurementCoordinate')));
    expect(source, isNot(contains('Confirm net')));
  });
}
