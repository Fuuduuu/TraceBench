import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:trace_bench_viewer/app/app.dart';
import 'package:trace_bench_viewer/features/board_canvas/screens/board_canvas_screen.dart';

void main() {
  testWidgets('opens photo list from bundled sample end-to-end',
      (tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: TraceBenchApp()),
    );
    await tester.pumpAndSettle();
    expect(
      find.byKey(const ValueKey('benchbeep_home_launcher')),
      findsOneWidget,
    );
    expect(find.text('Visuaalne remonditöölaud').hitTestable(), findsOneWidget);

    final sampleAction = find.text('Ava näidisprojekt');
    await tester.ensureVisible(sampleAction);
    await tester.tap(sampleAction);
    await tester.pumpAndSettle();

    expect(find.text('Projekt avatud'), findsOneWidget);

    final continueAction = find.text('Jätka avatud projektiga');
    expect(continueAction.hitTestable(), findsOneWidget);
    await tester.ensureVisible(continueAction);
    await tester.tap(continueAction);
    await tester.pumpAndSettle();

    expect(find.byType(BoardCanvasScreen), findsOneWidget);

    GoRouter.of(tester.element(find.byType(BoardCanvasScreen)))
        .go('/project/photos');
    await tester.pumpAndSettle();

    expect(find.text('Foto tõendid'), findsAtLeast(1));
    expect(find.text('Foto ID: photo_top_backlight_001'), findsNothing);
    expect(find.text('Fail: photos/top_backlight_001.jpg'), findsOneWidget);
    expect(find.text('Kahjustuse piirkondi: 1'), findsOneWidget);
  });
}
