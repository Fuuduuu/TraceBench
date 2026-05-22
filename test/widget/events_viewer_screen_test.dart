import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:trace_bench_viewer/app/app.dart';
import 'package:trace_bench_viewer/features/events/screens/events_viewer_screen.dart';
import 'package:trace_bench_viewer/shared/services/project_loader.dart';

Future<void> _pumpEventsScreen(
  WidgetTester tester,
  bool beginnerMode,
) async {
  final projectState = await ProjectLoader.loadFromAssets();

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        projectStateProvider.overrideWith((_) => projectState),
        beginnerModeProvider.overrideWith((_) => beginnerMode),
      ],
      child: const MaterialApp(home: EventsViewerScreen()),
    ),
  );
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 100));
}

void main() {
  testWidgets(
    'advanced users can view event ids in the events screen',
    (tester) async {
      await _pumpEventsScreen(tester, false);

      expect(find.textContaining('evt_'), findsAtLeast(1));
      expect(find.textContaining('project_created'), findsOneWidget);
      expect(find.textContaining('event_id'), findsOneWidget);
    },
  );

  testWidgets('beginner mode blocks advanced events details', (tester) async {
    await _pumpEventsScreen(tester, true);

    expect(find.text('Advanced režiim vajalik'), findsOneWidget);
    expect(find.textContaining('evt_'), findsNothing);
    expect(find.text('project_created'), findsNothing);
    expect(find.byType(ExpansionTile), findsNothing);
  });
}
