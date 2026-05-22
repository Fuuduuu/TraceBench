import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    expect(find.text('Komponendid'), findsOneWidget);

    await tester.tap(find.text('Komponendid'));
    await tester.pumpAndSettle();

    expect(find.text('Q2'), findsOneWidget);
  });
}
