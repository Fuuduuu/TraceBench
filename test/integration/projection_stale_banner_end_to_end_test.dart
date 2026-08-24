import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:trace_bench_viewer/shared/session/project_session.dart';

import '../helpers/seeded_project_session.dart';
import 'package:trace_bench_viewer/app/router.dart';
import 'package:trace_bench_viewer/features/board_canvas/screens/board_canvas_screen.dart';
import 'package:trace_bench_viewer/features/board_graph/screens/board_graph_screen.dart';
import 'package:trace_bench_viewer/features/components/screens/edit_component_screen.dart';
import 'package:trace_bench_viewer/features/known_facts/screens/component_list_screen.dart';
import 'package:trace_bench_viewer/features/known_facts/screens/known_facts_viewer_screen.dart';
import 'package:trace_bench_viewer/features/known_facts/screens/measurement_list_screen.dart';
import 'package:trace_bench_viewer/features/known_facts/screens/not_populated_screen.dart';
import 'package:trace_bench_viewer/features/known_facts/screens/pin_list_screen.dart';
import 'package:trace_bench_viewer/features/measure_sheet/screens/measure_sheet_screen.dart';
import 'package:trace_bench_viewer/features/photos/screens/photo_list_screen.dart';
import 'package:trace_bench_viewer/features/project/screens/project_overview_screen.dart';
import 'package:trace_bench_viewer/features/report/screens/customer_report_screen.dart';
import 'package:trace_bench_viewer/shared/models/project_state.dart';
import 'package:trace_bench_viewer/shared/services/project_loader.dart';
import 'package:trace_bench_viewer/shared/widgets/projection_stale_banner.dart';

void main() {
  testWidgets('stale banner appears exactly once on all twelve derived views',
      (tester) async {
    final loaded = await ProjectLoader.loadFromAssets();
    expect(loaded.projectionFreshness, ProjectionFreshness.fresh);
    final projectState = loaded.copyWith(isProjectionStale: true);
    expect(projectState.projectionFreshness, ProjectionFreshness.stale);
    final router = buildTraceBenchRouter(
      initialLocation: '/project/overview',
      homeBuilder: (_) => const SizedBox.shrink(),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          projectStateProvider.overrideWith(
            () => SeededProjectSession(projectState),
          ),
        ],
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    addTearDown(router.dispose);

    final cases = <(String, Finder)>[
      ('/project', find.byType(BoardCanvasScreen)),
      ('/project/overview', find.byType(ProjectOverviewScreen)),
      ('/project/components', find.byType(ComponentListScreen)),
      ('/project/components/edit', find.byType(EditComponentScreen)),
      ('/project/measurements', find.byType(MeasurementListScreen)),
      ('/project/measure-sheet', find.byType(MeasureSheetScreen)),
      ('/project/not-populated', find.byType(NotPopulatedScreen)),
      ('/project/pins', find.byType(PinListScreen)),
      ('/project/graph', find.byType(BoardGraphScreen)),
      ('/project/known-facts', find.byType(KnownFactsViewerScreen)),
      ('/project/photos', find.byType(PhotoListScreen)),
      ('/project/report', find.byType(CustomerReportScreen)),
    ];

    for (final (path, screenFinder) in cases) {
      router.go(path);
      await tester.pumpAndSettle();

      expect(screenFinder, findsOneWidget, reason: path);
      expect(find.byType(ProjectionStaleBanner), findsOneWidget, reason: path);
      expect(
        find.text(ProjectionStaleBanner.stalePrimaryText),
        findsOneWidget,
        reason: path,
      );
    }

    expect(find.text('Export now'), findsNothing);
    expect(find.text('Ekspordi kohe'), findsNothing);
    expect(find.text('Run materializer'), findsNothing);
    expect(find.text('Käivita materializer'), findsNothing);
  });
}
