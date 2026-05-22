import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:trace_bench_viewer/app/app.dart';
import 'package:trace_bench_viewer/features/board_graph/screens/board_graph_screen.dart';
import 'package:trace_bench_viewer/shared/services/project_loader.dart';

void main() {
  testWidgets('board graph screen renders title and key labels', (tester) async {
    final projectState = await ProjectLoader.loadFromAssets();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          projectStateProvider.overrideWith((_) => projectState),
          beginnerModeProvider.overrideWith((_) => true),
        ],
        child: const MaterialApp(home: BoardGraphScreen()),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('Board graph'), findsOneWidget);
    expect(find.textContaining('Q2'), findsAtLeast(1));
    expect(find.textContaining('components:'), findsOneWidget);
    expect(find.text('Show visual traces'), findsNothing);
  });

  testWidgets('board graph advanced mode exposes history controls', (tester) async {
    final projectState = await ProjectLoader.loadFromAssets();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          projectStateProvider.overrideWith((_) => projectState),
          beginnerModeProvider.overrideWith((_) => false),
        ],
        child: const MaterialApp(home: BoardGraphScreen()),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.textContaining('Show visual traces'), findsOneWidget);
    expect(find.text('Audit/history'), findsOneWidget);
    expect(find.byType(DropdownButton<String>), findsOneWidget);
    expect(find.text('Advanced mode: true'), findsOneWidget);
  });
}
