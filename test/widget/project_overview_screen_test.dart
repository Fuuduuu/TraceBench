import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:trace_bench_viewer/app/app.dart';
import 'package:trace_bench_viewer/features/project/screens/project_overview_screen.dart';
import 'package:trace_bench_viewer/shared/services/project_loader.dart';

void main() {
  testWidgets('renders project overview fields', (tester) async {
    final projectState = await ProjectLoader.loadFromAssets();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          projectStateProvider.overrideWith((_) => projectState),
        ],
        child: const MaterialApp(home: ProjectOverviewScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.textContaining(projectState.manifest.deviceType), findsOneWidget);
    expect(find.text(projectState.manifest.projectId), findsOneWidget);
    expect(
      find.text(projectState.measurementCount.toString()),
      findsAtLeast(1),
    );
    expect(
      find.text(projectState.componentCount.toString()),
      findsAtLeast(1),
    );
  });
}
