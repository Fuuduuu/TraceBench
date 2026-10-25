import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:trace_bench_viewer/shared/session/beginner_mode_provider.dart';
import 'package:trace_bench_viewer/shared/session/project_session.dart';

import '../helpers/seeded_project_session.dart';
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
  ProjectionFreshness projectionFreshness = ProjectionFreshness.fresh,
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
    projectionFreshness: projectionFreshness,
  );
}

void main() {
  testWidgets('Photo records group counters without splitting plain path copy',
      (tester) async {
    final state = _inlineProjectState(
        photos: const [
          {'photo_id': 'p1', 'mode': 'macro', 'path': 'photos/one.png'}
        ],
        damageRegions: const [],
        suspectRegions: const [],
        visualTraces: const []);
    await tester.pumpWidget(ProviderScope(overrides: [
      projectStateProvider.overrideWith(() => SeededProjectSession(state)),
      beginnerModeProvider.overrideWith((_) => false),
    ], child: const MaterialApp(home: PhotoListScreen())));
    final summary = find.byKey(const ValueKey('photo-summary-p1'));
    expect(summary, findsOneWidget);
    expect(tester.widget(summary), isA<Wrap>());
    expect(
        find.descendant(
            of: summary, matching: find.text('Kahjustuse piirkondi: 0')),
        findsOneWidget);
    expect(find.text('Fail: photos/one.png'), findsOneWidget);
    expect(find.text('Foto ID: p1'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

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
          projectStateProvider.overrideWith(
            () => SeededProjectSession(projectState),
          ),
          beginnerModeProvider.overrideWith((_) => false),
        ],
        child: const MaterialApp(home: PhotoListScreen()),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text(ProjectionStaleBanner.stalePrimaryText), findsOneWidget);
    expect(find.text(ProjectionStaleBanner.staleTagText), findsOneWidget);
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
          projectStateProvider.overrideWith(
            () => SeededProjectSession(projectState),
          ),
          beginnerModeProvider.overrideWith((_) => true),
        ],
        child: const MaterialApp(home: PhotoListScreen()),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('Fotosid ei leitud'), findsOneWidget);
    expect(find.text(ProjectionStaleBanner.stalePrimaryText), findsNothing);
    expect(find.text(ProjectionStaleBanner.unknownPrimaryText), findsNothing);
    expect(find.byType(Card), findsNothing);
  });

  testWidgets('empty photos show exactly one stale warning', (tester) async {
    final projectState = _inlineProjectState(
      photos: const [],
      damageRegions: const [],
      suspectRegions: const [],
      visualTraces: const [],
      projectionFreshness: ProjectionFreshness.stale,
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          projectStateProvider.overrideWith(
            () => SeededProjectSession(projectState),
          ),
          beginnerModeProvider.overrideWith((_) => true),
        ],
        child: const MaterialApp(home: PhotoListScreen()),
      ),
    );
    await tester.pump();

    expect(find.text(ProjectionStaleBanner.stalePrimaryText), findsOneWidget);
    expect(find.text('Fotosid ei leitud'), findsOneWidget);
  });

  testWidgets('unknown photo freshness uses distinct warning', (tester) async {
    final projectState = _inlineProjectState(
      photos: const [],
      damageRegions: const [],
      suspectRegions: const [],
      visualTraces: const [],
      projectionFreshness: ProjectionFreshness.unknown,
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          projectStateProvider.overrideWith(
            () => SeededProjectSession(projectState),
          ),
          beginnerModeProvider.overrideWith((_) => true),
        ],
        child: const MaterialApp(home: PhotoListScreen()),
      ),
    );
    await tester.pump();

    expect(find.text(ProjectionStaleBanner.unknownPrimaryText), findsOneWidget);
    expect(find.text(ProjectionStaleBanner.stalePrimaryText), findsNothing);
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
          projectStateProvider.overrideWith(
            () => SeededProjectSession(projectState),
          ),
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
          projectStateProvider.overrideWith(
            () => SeededProjectSession(projectState),
          ),
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
  testWidgets(
    'Photos opts into dark presentation without changing its parent',
    (tester) async {
      final state = _inlineProjectState(
        photos: const [],
        damageRegions: const [],
        suspectRegions: const [],
        visualTraces: const [],
      );
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            projectStateProvider.overrideWith(
              () => SeededProjectSession(state),
            ),
          ],
          child: const MaterialApp(
            home: Column(
              children: [
                Text('outside Photos'),
                Expanded(child: PhotoListScreen()),
              ],
            ),
          ),
        ),
      );
      expect(
        Theme.of(tester.element(find.text('Fotosid ei leitud'))).brightness,
        Brightness.dark,
      );
      expect(
        Theme.of(tester.element(find.text('outside Photos'))).brightness,
        Brightness.light,
      );
      expect(find.byType(AppBar), findsNothing);
      expect(find.byType(Scaffold), findsNothing);
    },
  );

  testWidgets('no project keeps its recovery meaning inside the local frame', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          projectStateProvider.overrideWith(() => SeededProjectSession(null)),
        ],
        child: const MaterialApp(home: PhotoListScreen()),
      ),
    );
    expect(find.text('No project loaded'), findsOneWidget);
    expect(find.byType(AppBar), findsNothing);
    expect(find.byType(ProjectionStaleBanner), findsNothing);
  });

  for (final width in [400.0, 800.0, 1227.0, 1228.0]) {
    for (final beginner in [true, false]) {
      testWidgets(
        'Photos wraps and scrolls at 1.5x, width $width, beginner $beginner',
        (tester) async {
          tester.view.physicalSize = Size(width, 700);
          tester.view.devicePixelRatio = 1;
          addTearDown(tester.view.resetPhysicalSize);
          addTearDown(tester.view.resetDevicePixelRatio);
          final longPath = 'photos/${'long_directory_name/' * 10}macro_1.jpg';
          final state = _inlineProjectState(
            photos: [
              {
                'photo_id': 'first',
                'mode': 'macro',
                'path': longPath,
                'layer': 'top',
                'source_device': 'microscope',
              },
              {'photo_id': 'second', 'mode': 'overview', 'path': ''},
            ],
            damageRegions: const [
              {
                'photo_id': 'first',
                'region_id': 'D1',
                'damage_type': 'burn',
                'bbox': {'x': 10, 'y': 20, 'width': 5, 'height': 6},
                'notes': 'damage note',
                'affects_components': ['U1', 'R2'],
              },
              {
                'photo_id': 'other',
                'region_id': 'excluded',
                'damage_type': 'burn',
              },
            ],
            suspectRegions: const [
              {
                'photo_id': 'first',
                'region_id': 'S1',
                'reason': 'discolor',
                'bbox': {'x': 30, 'y': 40, 'width': 1, 'height': 2},
                'notes': 'suspect note',
                'affects_components': ['C3'],
                'priority': 'low',
              },
            ],
            visualTraces: const [
              {
                'photo_id': 'first',
                'trace_id': 'T1',
                'evidence_type': 'visual_trace',
              },
            ],
            projectionFreshness: ProjectionFreshness.unknown,
          );
          await tester.pumpWidget(
            ProviderScope(
              overrides: [
                projectStateProvider.overrideWith(
                  () => SeededProjectSession(state),
                ),
                beginnerModeProvider.overrideWith((_) => beginner),
              ],
              child: MaterialApp(
                builder: (context, child) => MediaQuery(
                  data: MediaQuery.of(
                    context,
                  ).copyWith(textScaler: const TextScaler.linear(1.5)),
                  child: child!,
                ),
                home: const PhotoListScreen(),
              ),
            ),
          );
          await tester.pumpAndSettle();
          expect(tester.takeException(), isNull);
          expect(
            find.byType(ProjectionStaleBanner, skipOffstage: false),
            findsOneWidget,
          );
          expect(
            find.text(ProjectionStaleBanner.unknownPrimaryText),
            findsOneWidget,
          );
          await tester.scrollUntilVisible(
            find.text('Fail: $longPath'),
            250,
            scrollable: find.byType(Scrollable),
          );
          expect(find.text('Fail: $longPath'), findsOneWidget);
          expect(
            tester.widget<Text>(find.text('Fail: $longPath')).data,
            'Fail: $longPath',
          );
          expect(find.text('Kahjustuse piirkondi: 1'), findsOneWidget);
          expect(find.text('Visuaalseid jälgi: 1'), findsOneWidget);
          expect(find.textContaining('excluded'), findsNothing);
          if (beginner) {
            expect(find.text('Kahtlaste piirkondi: 1'), findsOneWidget);
            expect(find.textContaining('Foto ID:'), findsNothing);
            expect(find.textContaining('damage note'), findsNothing);
            expect(find.textContaining('microscope'), findsNothing);
          } else {
            expect(find.text('Foto ID: first'), findsOneWidget);
            expect(find.text('Kahtlasi piirkondi: 1'), findsOneWidget);
            expect(find.text('Allikas: microscope'), findsOneWidget);
            for (final text in [
              'Kiht: top',
              '  Märkus: damage note',
              '  Mõjutatud komponendid: U1, R2',
              '  Märkus: suspect note',
              '  Mõjutatud komponendid: C3',
              '  Prioriteet: low',
              'D1: burn · x=10, y=20, w=5, h=6',
              'S1: discolor · x=30, y=40, w=1, h=2',
              'Visuaalsed tõendid (visual evidence only):',
              'T1: visual_trace',
            ]) {
              expect(find.text(text), findsOneWidget);
            }
          }
          final missingPath = find.text(
            beginner ? 'Fail puudub' : 'Fail: Puudub',
          );
          await tester.scrollUntilVisible(
            missingPath,
            250,
            scrollable: find.byType(Scrollable),
          );
          expect(missingPath, findsOneWidget);
          expect(find.text('Režiim: overview'), findsOneWidget);
          expect(tester.takeException(), isNull);
          final container = ProviderScope.containerOf(
            tester.element(find.byType(PhotoListScreen)),
          );
          expect(
            identical(container.read(projectStateProvider), state),
            isTrue,
          );
          expect(state.events, isEmpty);
        },
      );
    }
  }

  for (final freshness in ProjectionFreshness.values) {
    testWidgets('empty Photos keeps all freshness copy at 1.5x: $freshness', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(400, 700);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final state = _inlineProjectState(
        photos: const [],
        damageRegions: const [],
        suspectRegions: const [],
        visualTraces: const [],
        projectionFreshness: freshness,
      );
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            projectStateProvider.overrideWith(
              () => SeededProjectSession(state),
            ),
          ],
          child: MaterialApp(
            builder: (context, child) => MediaQuery(
              data: MediaQuery.of(
                context,
              ).copyWith(textScaler: const TextScaler.linear(1.5)),
              child: child!,
            ),
            home: const PhotoListScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      expect(
        find.byType(ProjectionStaleBanner, skipOffstage: false),
        findsOneWidget,
      );
      await tester.scrollUntilVisible(
        find.text('Fotosid ei leitud'),
        250,
        scrollable: find.byType(Scrollable),
      );
      expect(find.text('Fotosid ei leitud'), findsOneWidget);
      expect(tester.takeException(), isNull);
      if (freshness == ProjectionFreshness.fresh) {
        expect(find.byType(Card), findsNothing);
      }
    });
  }
}
