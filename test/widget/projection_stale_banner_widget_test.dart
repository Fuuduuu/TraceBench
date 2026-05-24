import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:trace_bench_viewer/shared/widgets/projection_stale_banner.dart';

void main() {
  testWidgets('compact mode hides secondary text but keeps primary and tag',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ProjectionStaleBanner(
            isStale: true,
            compact: true,
          ),
        ),
      ),
    );
    await tester.pump();

    expect(find.text(ProjectionStaleBanner.primaryText), findsOneWidget);
    expect(find.text(ProjectionStaleBanner.passiveTagText), findsOneWidget);
    expect(find.text(ProjectionStaleBanner.secondaryText), findsNothing);
  });

  testWidgets('compact mode keeps banner when stale and hides on fresh state',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ProjectionStaleBanner(isStale: false, compact: true),
        ),
      ),
    );
    await tester.pump();

    expect(find.text(ProjectionStaleBanner.primaryText), findsNothing);
    expect(find.text(ProjectionStaleBanner.passiveTagText), findsNothing);
    expect(find.byType(Icon), findsNothing);
  });

  testWidgets('forbidden action texts are not present on banner',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ProjectionStaleBanner(
            isStale: true,
          ),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('Refresh'), findsNothing);
    expect(find.text('Värskenda'), findsNothing);
    expect(find.text('Export now'), findsNothing);
    expect(find.text('Ekspordi kohe'), findsNothing);
    expect(find.text('Run materializer'), findsNothing);
    expect(find.text('Käivita materializer'), findsNothing);
    expect(find.text('Uuenda nüüd'), findsNothing);
  });
}
