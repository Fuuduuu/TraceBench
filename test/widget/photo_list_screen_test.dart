import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:trace_bench_viewer/app/app.dart';
import 'package:trace_bench_viewer/features/photos/screens/photo_list_screen.dart';
import 'package:trace_bench_viewer/shared/models/known_facts.dart';
import 'package:trace_bench_viewer/shared/models/project_manifest.dart';
import 'package:trace_bench_viewer/shared/models/project_state.dart';
import 'package:trace_bench_viewer/shared/widgets/projection_stale_banner.dart';

ProjectState _inlineProjectState({
  required List<Map<String, dynamic>> photos,
  required List<Map<String, dynamic>> damageRegions,
  required List<Map<String, dynamic>> suspectRegions,
  required List<Map<String, dynamic>> visualTraces,
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
      'components': [],
      'pins': [],
      'measurements': [],
      'nets': [],
      'excluded_from_fault_candidates': [],
      'photos': photos,
      'damage_regions': damageRegions,
      'suspect_regions': suspectRegions,
      'visual_traces': visualTraces,
    }),
    events: const [],
    customerReport: 'Inline photo report',
  );
}

void main() {
  testWidgets('shows stale projection banner when stale', (tester) async {
    final projectState = _inlineProjectState(
      photos: const [
        {
          'photo_id': 'photo_inline_001',
          'mode': 'macro',
          'path': 'photos/macro_1.jpg',
          'layer': 'top',
        },
      ],
      damageRegions: const [],
      suspectRegions: const [],
      visualTraces: const [],
    ).copyWith(isProjectionStale: true);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          projectStateProvider.overrideWith((_) => projectState),
          beginnerModeProvider.overrideWith((_) => false),
        ],
        child: const MaterialApp(home: PhotoListScreen()),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text(ProjectionStaleBanner.primaryText), findsOneWidget);
    expect(find.text(ProjectionStaleBanner.passiveTagText), findsOneWidget);
    expect(find.text('Režiim: macro'), findsOneWidget);
  });

  testWidgets('empty state when no photos exist', (tester) async {
    final projectState = _inlineProjectState(
      photos: const [],
      damageRegions: const [],
      suspectRegions: const [],
      visualTraces: const [],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          projectStateProvider.overrideWith((_) => projectState),
          beginnerModeProvider.overrideWith((_) => true),
        ],
        child: const MaterialApp(home: PhotoListScreen()),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('Fotosid ei leitud'), findsOneWidget);
    expect(find.text(ProjectionStaleBanner.primaryText), findsNothing);
    expect(find.byType(Card), findsNothing);
  });

  testWidgets('beginner mode shows summary and hides raw ids/coordinates', (
    tester,
  ) async {
    final projectState = _inlineProjectState(
      photos: const [
        {
          'photo_id': 'photo_inline_001',
          'mode': 'macro',
          'path': 'photos/macro_1.jpg'
        },
      ],
      damageRegions: const [
        {
          'region_id': 'DMG001',
          'photo_id': 'photo_inline_001',
          'bbox': {'x': 10, 'y': 20, 'width': 5, 'height': 6},
          'damage_type': 'burn',
        },
      ],
      suspectRegions: const [
        {
          'region_id': 'SMG001',
          'photo_id': 'photo_inline_001',
          'bbox': {'x': 30, 'y': 40, 'width': 1, 'height': 2},
          'reason': 'discolor',
        },
      ],
      visualTraces: const [
        {
          'trace_id': 'VT001',
          'photo_id': 'photo_inline_001',
          'evidence_type': 'visual_trace'
        },
      ],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          projectStateProvider.overrideWith((_) => projectState),
          beginnerModeProvider.overrideWith((_) => true),
        ],
        child: const MaterialApp(home: PhotoListScreen()),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('Režiim: macro'), findsOneWidget);
    expect(find.text('Kahjustuse piirkondi: 1'), findsOneWidget);
    expect(find.text('Kahtlaste piirkondi: 1'), findsOneWidget);
    expect(find.text('Visuaalseid jälgi: 1'), findsOneWidget);
    expect(find.textContaining('photo_inline_001'), findsNothing);
    expect(find.textContaining('x=10'), findsNothing);
    expect(find.textContaining('x=30'), findsNothing);
    expect(find.text('Fail: photos/macro_1.jpg'), findsOneWidget);
  });

  testWidgets('advanced mode shows raw details and visual evidence wording',
      (tester) async {
    final projectState = _inlineProjectState(
      photos: const [
        {
          'photo_id': 'photo_inline_001',
          'mode': 'macro',
          'path': 'photos/macro_1.jpg',
          'layer': 'top'
        },
      ],
      damageRegions: const [
        {
          'region_id': 'DMG001',
          'photo_id': 'photo_inline_001',
          'bbox': {'x': 10, 'y': 20, 'width': 5, 'height': 6},
          'damage_type': 'burn',
        },
      ],
      suspectRegions: const [
        {
          'region_id': 'SMG001',
          'photo_id': 'photo_inline_001',
          'bbox': {'x': 30, 'y': 40, 'width': 1, 'height': 2},
          'reason': 'discolor',
          'priority': 'low',
        },
      ],
      visualTraces: const [
        {
          'trace_id': 'VT001',
          'photo_id': 'photo_inline_001',
          'evidence_type': 'visual_trace',
          'from_component': 'Q2',
          'to_component': 'R1',
          'confidence': 'high',
        },
      ],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          projectStateProvider.overrideWith((_) => projectState),
          beginnerModeProvider.overrideWith((_) => false),
        ],
        child: const MaterialApp(home: PhotoListScreen()),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('Foto ID: photo_inline_001'), findsOneWidget);
    expect(find.textContaining('x=10'), findsOneWidget);
    expect(find.textContaining('x=30'), findsOneWidget);
    expect(find.textContaining('Kiht: top'), findsOneWidget);
    expect(find.textContaining('DMG001'), findsOneWidget);
    expect(find.textContaining('SMG001'), findsOneWidget);
    expect(find.textContaining('Visuaalsed tõendid (visual evidence only):'),
        findsOneWidget);
    expect(find.textContaining('VT001'), findsOneWidget);
    expect(find.textContaining('visual_trace'), findsOneWidget);
    expect(find.byIcon(Icons.camera_alt), findsNothing);
    expect(find.byIcon(Icons.add_a_photo), findsNothing);
  });
}
