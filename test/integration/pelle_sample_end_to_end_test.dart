import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'package:trace_bench_viewer/app/app.dart';
import 'package:trace_bench_viewer/features/board_canvas/screens/board_canvas_screen.dart';

void main() {
  testWidgets('loads bundled Pelle sample and shows known facts',
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
        .go('/project/components');
    await tester.pumpAndSettle();

    expect(find.text('Q2'), findsOneWidget);
  });
}
