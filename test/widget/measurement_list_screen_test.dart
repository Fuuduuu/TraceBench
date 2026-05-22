import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:trace_bench_viewer/app/app.dart';
import 'package:trace_bench_viewer/features/known_facts/screens/measurement_list_screen.dart';
import 'package:trace_bench_viewer/shared/services/project_loader.dart';

void main() {
  testWidgets('stale and active human labels are shown', (tester) async {
    final projectState = await ProjectLoader.loadFromAssets();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          projectStateProvider.overrideWith((_) => projectState),
          beginnerModeProvider.overrideWith((_) => true),
        ],
        child: const MaterialApp(home: MeasurementListScreen()),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.textContaining('Aegunud pärast remonti'), findsOneWidget);
    expect(find.textContaining('Aktiivne'), findsOneWidget);
    expect(find.textContaining('evt_'), findsNothing);
  });
}
