import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:trace_bench_viewer/app/app.dart';
import 'package:trace_bench_viewer/features/project/screens/project_overview_screen.dart';

void main() {
  testWidgets('opens photo list from bundled sample end-to-end',
      (tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: TraceBenchApp()),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('TraceBench Viewer'), findsOneWidget);

    await tester.tap(find.text('Ava näidisprojekt'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('Ava projekt'), findsOneWidget);

    await tester.tap(find.text('Ava projekt'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('Project overview'), findsOneWidget);
    expect(
        find.byKey(const ValueKey('overview-photos-button')), findsOneWidget);

    final overviewContext = tester.element(find.byType(ProjectOverviewScreen));
    GoRouter.of(overviewContext).go('/project/photos');
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('Foto tõendid'), findsAtLeast(1));
    expect(find.text('Foto ID: photo_top_backlight_001'), findsNothing);
    expect(find.text('Fail: photos/top_backlight_001.jpg'), findsOneWidget);
    expect(find.text('Kahjustuse piirkondi: 1'), findsOneWidget);
  });
}
