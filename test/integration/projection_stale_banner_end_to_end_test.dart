import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:trace_bench_viewer/app/app.dart';
import 'package:trace_bench_viewer/app/router.dart';
import 'package:trace_bench_viewer/features/board_graph/screens/board_graph_screen.dart';
import 'package:trace_bench_viewer/features/known_facts/screens/measurement_list_screen.dart';
import 'package:trace_bench_viewer/features/photos/screens/photo_list_screen.dart';
import 'package:trace_bench_viewer/features/project/screens/project_overview_screen.dart';
import 'package:trace_bench_viewer/features/report/screens/customer_report_screen.dart';
import 'package:trace_bench_viewer/shared/services/project_loader.dart';
import 'package:trace_bench_viewer/shared/widgets/projection_stale_banner.dart';

void main() {
  testWidgets('stale banner is visible across derived views and navigation',
      (tester) async {
    final projectState = (await ProjectLoader.loadFromAssets())
        .copyWith(isProjectionStale: true);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [projectStateProvider.overrideWith((_) => projectState)],
        child: MaterialApp.router(
          routerConfig:
              buildTraceBenchRouter(initialLocation: '/project/overview'),
        ),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.byType(ProjectOverviewScreen), findsOneWidget);
    expect(find.text(ProjectionStaleBanner.primaryText), findsAtLeast(1));
    expect(find.text('Kõik komponendid'), findsOneWidget);

    GoRouter.of(tester.element(find.byType(ProjectOverviewScreen))).go(
      '/project/measurements',
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.byType(MeasurementListScreen), findsOneWidget);
    expect(find.text(ProjectionStaleBanner.primaryText), findsAtLeast(1));
    expect(find.text('Mõõtmised'), findsAtLeast(1));

    GoRouter.of(tester.element(find.byType(MeasurementListScreen))).go(
      '/project/graph',
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.byType(BoardGraphScreen), findsOneWidget);
    expect(find.text(ProjectionStaleBanner.primaryText), findsAtLeast(1));
    expect(find.text('Board graph'), findsOneWidget);

    GoRouter.of(tester.element(find.byType(BoardGraphScreen)))
        .go('/project/photos');
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.byType(PhotoListScreen), findsOneWidget);
    expect(find.text(ProjectionStaleBanner.primaryText), findsAtLeast(1));
    expect(find.text('Foto tõendid'), findsAtLeastNWidgets(1));

    GoRouter.of(tester.element(find.byType(PhotoListScreen)))
        .go('/project/report');
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.byType(CustomerReportScreen), findsOneWidget);
    expect(find.text(ProjectionStaleBanner.primaryText), findsAtLeast(1));
    expect(find.text('Kliendiraport'), findsOneWidget);
    expect(find.text('Export now'), findsNothing);
    expect(find.text('Ekspordi kohe'), findsNothing);
    expect(find.text('Run materializer'), findsNothing);
    expect(find.text('Käivita materializer'), findsNothing);
  });
}
