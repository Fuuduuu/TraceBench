import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:trace_bench_viewer/app/app.dart';
import 'package:trace_bench_viewer/app/router.dart';
import 'package:trace_bench_viewer/features/board_canvas/screens/board_canvas_screen.dart';
import 'package:trace_bench_viewer/shared/models/known_facts.dart';
import 'package:trace_bench_viewer/shared/models/project_manifest.dart';
import 'package:trace_bench_viewer/shared/models/project_state.dart';

ProjectState _inlineProjectState({
  required List<Map<String, dynamic>> components,
  required List<Map<String, dynamic>> placements,
}) {
  return ProjectState(
    manifest: ProjectManifest.fromJson({
      'project_id': 'inline_project',
      'schema_version': '1.0',
      'created_at': '2026-05-27T00:00:00Z',
      'device_type': 'pelle',
      'model': 'PV20',
      'symptom': 'not_provided',
    }),
    knownFacts: KnownFacts.fromJson({
      'project_id': 'inline_project',
      'components': components,
      'component_visual_placements': placements,
    }),
    events: const [],
    customerReport: 'Inline report',
  );
}

Future<void> _pumpScreen(
  WidgetTester tester, {
  required ProjectState? projectState,
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        projectStateProvider.overrideWith((_) => projectState),
      ],
      child: const MaterialApp(home: BoardCanvasScreen()),
    ),
  );
  await tester.pump();
}

void _expectNoActionAffordanceLabels() {
  const blockedLabels = <String>[
    'Add component',
    'Detect',
    'Run AI',
    'Confirm',
    'Save',
    'Export',
    'Suggest',
    'Identify',
    'Promote',
    'Change template',
    'Upload photo',
    'Start placement',
  ];
  for (final label in blockedLabels) {
    expect(find.text(label), findsNothing);
  }
}

Map<String, dynamic> _boardNormalizedPlacement({
  required String componentId,
  String? templateId,
  num centerX = 0.5,
  num centerY = 0.5,
}) {
  return {
    'component_id': componentId,
    'coordinate_space': 'board_normalized',
    'board_side': 'top',
    'center_x': centerX,
    'center_y': centerY,
    'rotation_deg': 0,
    'scale': 1.0,
    'source_event_id': 'evt_000010',
    'status': 'user_confirmed_visual',
    if (templateId != null) 'template_id': templateId,
  };
}

Map<String, dynamic> _photoLocalPlacement({
  required String componentId,
}) {
  return {
    'component_id': componentId,
    'coordinate_space': 'photo_local',
    'board_side': 'top',
    'center_x': 120,
    'center_y': 80,
    'rotation_deg': 0,
    'scale': 1.0,
    'source_photo_id': 'photo_001',
    'source_event_id': 'evt_000011',
    'status': 'user_confirmed_visual',
  };
}

void main() {
  testWidgets('board canvas route loads without error', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          projectStateProvider.overrideWith((_) => null),
        ],
        child: MaterialApp.router(
          routerConfig:
              buildTraceBenchRouter(initialLocation: '/project/board-canvas'),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(BoardCanvasScreen), findsOneWidget);
    expect(find.text('Board canvas'), findsOneWidget);
  });

  testWidgets('no project loaded shows no-project empty state', (tester) async {
    await _pumpScreen(tester, projectState: null);

    expect(find.text(BoardCanvasScreen.noProjectText), findsOneWidget);
    expect(find.text(BoardCanvasScreen.rendererWritesNoneText), findsOneWidget);
  });

  testWidgets('no components shows no-components empty state', (tester) async {
    await _pumpScreen(
      tester,
      projectState: _inlineProjectState(
        components: const [],
        placements: const [],
      ),
    );

    expect(find.text(BoardCanvasScreen.noComponentsText), findsOneWidget);
    expect(find.text(BoardCanvasScreen.rendererWritesNoneText), findsOneWidget);
  });

  testWidgets(
      'components without placements shows no-placements empty state',
      (tester) async {
    await _pumpScreen(
      tester,
      projectState: _inlineProjectState(
        components: const [
          {'component_id': 'Q2', 'status': 'identified'},
        ],
        placements: const [],
      ),
    );

    expect(find.text(BoardCanvasScreen.noPlacementsText), findsOneWidget);
    expect(find.text(BoardCanvasScreen.noPlacementsSupportText), findsOneWidget);
    expect(find.text(BoardCanvasScreen.rendererWritesNoneText), findsOneWidget);
  });

  testWidgets('empty states expose no CTA action buttons', (tester) async {
    await _pumpScreen(tester, projectState: null);

    expect(find.byType(ElevatedButton), findsNothing);
    expect(find.byType(OutlinedButton), findsNothing);
    expect(find.byType(TextButton), findsNothing);
    expect(find.byType(FilledButton), findsNothing);
    _expectNoActionAffordanceLabels();
  });

  testWidgets('screen has no forbidden action labels', (tester) async {
    await _pumpScreen(
      tester,
      projectState: _inlineProjectState(
        components: const [
          {'component_id': 'Q2'},
        ],
        placements: const [],
      ),
    );

    _expectNoActionAffordanceLabels();
  });

  testWidgets('board canvas renders board_normalized placement without error',
      (tester) async {
    await _pumpScreen(
      tester,
      projectState: _inlineProjectState(
        components: const [
          {'component_id': 'Q2', 'designator': 'Q2'},
        ],
        placements: [
          _boardNormalizedPlacement(componentId: 'Q2', templateId: 'soic_8'),
        ],
      ),
    );

    expect(find.byKey(const ValueKey('board-canvas-placement-surface')),
        findsOneWidget);
    expect(find.text(BoardCanvasScreen.noPlacementsText), findsNothing);
  });

  testWidgets('renderer writes none remains visible when placements render',
      (tester) async {
    await _pumpScreen(
      tester,
      projectState: _inlineProjectState(
        components: const [
          {'component_id': 'U1'},
        ],
        placements: [
          _boardNormalizedPlacement(componentId: 'U1', templateId: 'chip_0805'),
        ],
      ),
    );

    expect(find.text(BoardCanvasScreen.rendererWritesNoneText), findsOneWidget);
  });

  testWidgets('missing templateId uses safe fallback without crash',
      (tester) async {
    await _pumpScreen(
      tester,
      projectState: _inlineProjectState(
        components: const [
          {'component_id': 'R1'},
        ],
        placements: [
          _boardNormalizedPlacement(componentId: 'R1'),
        ],
      ),
    );

    expect(find.byKey(const ValueKey('board-canvas-placement-surface')),
        findsOneWidget);
  });

  testWidgets('unknown templateId uses safe fallback without crash',
      (tester) async {
    await _pumpScreen(
      tester,
      projectState: _inlineProjectState(
        components: const [
          {'component_id': 'C1'},
        ],
        placements: [
          _boardNormalizedPlacement(
            componentId: 'C1',
            templateId: 'not_in_registry',
          ),
        ],
      ),
    );

    expect(find.byKey(const ValueKey('board-canvas-placement-surface')),
        findsOneWidget);
  });

  testWidgets('unknown_* templates render without crash when referenced',
      (tester) async {
    const unknownTemplates = <String>[
      'unknown_rect',
      'unknown_2pin',
      'unknown_3pin',
      'unknown_multi_pin',
    ];

    for (final templateId in unknownTemplates) {
      await _pumpScreen(
        tester,
        projectState: _inlineProjectState(
          components: const [
            {'component_id': 'X1'},
          ],
          placements: [
            _boardNormalizedPlacement(
              componentId: 'X1',
              templateId: templateId,
            ),
          ],
        ),
      );
      await tester.pump();

      expect(find.byKey(const ValueKey('board-canvas-placement-surface')),
          findsOneWidget);
    }
  });

  testWidgets(
      'photo_local placement is not rendered on board and shows safe message',
      (tester) async {
    await _pumpScreen(
      tester,
      projectState: _inlineProjectState(
        components: const [
          {'component_id': 'Q2'},
        ],
        placements: [
          _photoLocalPlacement(componentId: 'Q2'),
        ],
      ),
    );

    expect(
      find.text(BoardCanvasScreen.noBoardNormalizedPlacementsText),
      findsOneWidget,
    );
    expect(find.byKey(const ValueKey('board-canvas-placement-surface')),
        findsNothing);
  });

  testWidgets('designator is shown only when present in knownFacts component',
      (tester) async {
    await _pumpScreen(
      tester,
      projectState: _inlineProjectState(
        components: const [
          {'component_id': 'Q2', 'designator': 'Q2'},
          {'component_id': 'R1'},
        ],
        placements: [
          _boardNormalizedPlacement(componentId: 'Q2', centerX: 0.3, centerY: 0.3),
          _boardNormalizedPlacement(componentId: 'R1', centerX: 0.7, centerY: 0.7),
        ],
      ),
    );

    expect(find.text('Q2'), findsOneWidget);
    expect(find.byKey(const ValueKey('board-canvas-label-Q2')), findsOneWidget);
    expect(find.byKey(const ValueKey('board-canvas-label-R1')), findsNothing);
  });

  testWidgets('templateId does not render forbidden electrical identity words',
      (tester) async {
    await _pumpScreen(
      tester,
      projectState: _inlineProjectState(
        components: const [
          {'component_id': 'U2'},
        ],
        placements: [
          _boardNormalizedPlacement(componentId: 'U2', templateId: 'sot23_3'),
        ],
      ),
    );

    const forbiddenIdentityWords = <String>[
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
    for (final word in forbiddenIdentityWords) {
      expect(find.text(word), findsNothing);
    }
  });

  test('board canvas source does not use event writer classes', () {
    final source = File(
      'lib/features/board_canvas/screens/board_canvas_screen.dart',
    ).readAsStringSync();

    expect(source.contains('MeasurementEventWriter'), isFalse);
    expect(source.contains('event_write'), isFalse);
  });

  test('board canvas source introduces no file artifact writes', () {
    final source = File(
      'lib/features/board_canvas/screens/board_canvas_screen.dart',
    ).readAsStringSync();

    expect(source.contains('events.jsonl'), isFalse);
    expect(source.contains('known_facts.json'), isFalse);
    expect(source.contains('board_graph.json'), isFalse);
    expect(source.contains('view_state.json'), isFalse);
    expect(source.contains('dart:io'), isFalse);
  });

  test('board canvas source avoids raw JSON parsing and editing gestures', () {
    final source = File(
      'lib/features/board_canvas/screens/board_canvas_screen.dart',
    ).readAsStringSync();

    expect(source.contains('dart:ui'), isFalse);
    expect(source.contains('jsonDecode('), isFalse);
    expect(source.contains('GestureDetector'), isFalse);
    expect(source.contains('onPan'), isFalse);
    expect(source.contains('onScale'), isFalse);
    expect(source.contains('onLongPress'), isFalse);
  });

  test('board canvas source avoids visual trace and net promotion behavior', () {
    final source = File(
      'lib/features/board_canvas/screens/board_canvas_screen.dart',
    ).readAsStringSync();

    expect(source.contains('visual_trace'), isFalse);
    expect(source.contains('net_connection_confirmed'), isFalse);
    expect(source.contains('promote'), isFalse);
  });
}
