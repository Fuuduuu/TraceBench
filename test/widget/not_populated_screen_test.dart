import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:trace_bench_viewer/app/app.dart';
import 'package:trace_bench_viewer/features/known_facts/screens/not_populated_screen.dart';
import 'package:trace_bench_viewer/shared/services/project_loader.dart';
import 'package:trace_bench_viewer/shared/widgets/projection_stale_banner.dart';

void main() {
  testWidgets('shows excluded footprints', (tester) async {
    final projectState = (await ProjectLoader.loadFromAssets())
        .copyWith(isProjectionStale: true);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          projectStateProvider.overrideWith((_) => projectState),
        ],
        child: const MaterialApp(home: NotPopulatedScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('K1'), findsOneWidget);
    expect(find.text('K2'), findsOneWidget);
    expect(find.text('K3'), findsOneWidget);
    expect(find.text(ProjectionStaleBanner.stalePrimaryText), findsOneWidget);
  });
}
