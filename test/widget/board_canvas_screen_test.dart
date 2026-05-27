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

  test('board canvas source avoids drawing and raw JSON parsing APIs', () {
    final source = File(
      'lib/features/board_canvas/screens/board_canvas_screen.dart',
    ).readAsStringSync();

    expect(source.contains('CustomPainter'), isFalse);
    expect(source.contains('Canvas('), isFalse);
    expect(source.contains('Scene'), isFalse);
    expect(source.contains('dart:ui'), isFalse);
    expect(source.contains('jsonDecode('), isFalse);
  });
}
