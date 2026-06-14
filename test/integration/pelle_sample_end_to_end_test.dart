import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/widgets.dart';

import 'package:trace_bench_viewer/app/app.dart';

void main() {
  testWidgets('loads bundled Pelle sample and shows known facts', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: TraceBenchApp()),
    );

    await tester.pumpAndSettle();

    expect(find.text('TraceBench Viewer'), findsOneWidget);

    await tester.tap(find.text('Ava näidisprojekt'));
    await tester.pumpAndSettle();

    expect(find.text('Ava projekt'), findsOneWidget);

    await tester.tap(find.text('Ava projekt'));
    await tester.pumpAndSettle();

    expect(find.text('Project overview'), findsOneWidget);
    final otherActions = find.text('Muud tegevused');
    await tester.ensureVisible(otherActions);
    await tester.tap(otherActions);
    await tester.pumpAndSettle();

    final componentsAction = find.byKey(const ValueKey('overview-components-button'));
    expect(componentsAction, findsOneWidget);

    await tester.ensureVisible(componentsAction);
    await tester.tap(componentsAction);
    await tester.pumpAndSettle();

    expect(find.text('Q2'), findsOneWidget);
  });
}
