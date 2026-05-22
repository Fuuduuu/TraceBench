import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:trace_bench_viewer/app/app.dart';
import 'package:trace_bench_viewer/features/project/screens/project_overview_screen.dart';

void main() {
  testWidgets('loads board graph from bundled sample end-to-end', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: TraceBenchApp()),
    );

    await tester.pumpAndSettle();
    expect(find.text('TraceBench Viewer'), findsOneWidget);

    await tester.tap(find.text('Ava näidisprojekt'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Ava projekt'));
    await tester.pumpAndSettle();

    expect(find.text('Project overview'), findsOneWidget);
    expect(find.byKey(const ValueKey('overview-board-graph-button')), findsOneWidget);

    final overviewContext = tester.element(find.byType(ProjectOverviewScreen));
    GoRouter.of(overviewContext).go('/project/graph');
    await tester.pumpAndSettle();

    expect(find.text('Board graph'), findsAtLeast(1));
    expect(find.textContaining('Q2'), findsAtLeast(1));
    expect(find.textContaining('measured nets'), findsOneWidget);
  });
}
