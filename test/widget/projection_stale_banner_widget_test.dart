import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:trace_bench_viewer/shared/models/project_state.dart';
import 'package:trace_bench_viewer/shared/widgets/projection_stale_banner.dart';

void main() {
  testWidgets('fresh state renders no freshness warning', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ProjectionStaleBanner(
            freshness: ProjectionFreshness.fresh,
          ),
        ),
      ),
    );

    expect(find.byType(Card), findsNothing);
    expect(find.byType(Icon), findsNothing);
    expect(find.text(ProjectionStaleBanner.stalePrimaryText), findsNothing);
    expect(find.text(ProjectionStaleBanner.unknownPrimaryText), findsNothing);
  });

  testWidgets('stale state renders one generic outdated warning',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ProjectionStaleBanner(
            freshness: ProjectionFreshness.stale,
          ),
        ),
      ),
    );

    expect(find.text(ProjectionStaleBanner.stalePrimaryText), findsOneWidget);
    expect(find.text(ProjectionStaleBanner.staleSecondaryText), findsOneWidget);
    expect(find.text(ProjectionStaleBanner.staleTagText), findsOneWidget);
    expect(find.text(ProjectionStaleBanner.unknownPrimaryText), findsNothing);
  });

  testWidgets('unknown state renders one distinct cannot-verify warning',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ProjectionStaleBanner(
            freshness: ProjectionFreshness.unknown,
          ),
        ),
      ),
    );

    expect(find.text(ProjectionStaleBanner.unknownPrimaryText), findsOneWidget);
    expect(
      find.text(ProjectionStaleBanner.unknownSecondaryText),
      findsOneWidget,
    );
    expect(find.text(ProjectionStaleBanner.unknownTagText), findsOneWidget);
    expect(find.text(ProjectionStaleBanner.stalePrimaryText), findsNothing);
  });

  testWidgets(
      'compact mode hides state secondary text but keeps primary and tag',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ProjectionStaleBanner(
            freshness: ProjectionFreshness.stale,
            compact: true,
          ),
        ),
      ),
    );
    await tester.pump();

    expect(find.text(ProjectionStaleBanner.stalePrimaryText), findsOneWidget);
    expect(find.text(ProjectionStaleBanner.staleTagText), findsOneWidget);
    expect(find.text(ProjectionStaleBanner.staleSecondaryText), findsNothing);
  });

  testWidgets('warning text meets contrast targets on light and dark hosts',
      (tester) async {
    for (final brightness in Brightness.values) {
      final theme = ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: brightness,
        ),
      );

      for (final freshness in <ProjectionFreshness>[
        ProjectionFreshness.stale,
        ProjectionFreshness.unknown,
      ]) {
        final primaryText = freshness == ProjectionFreshness.stale
            ? ProjectionStaleBanner.stalePrimaryText
            : ProjectionStaleBanner.unknownPrimaryText;
        final secondaryText = freshness == ProjectionFreshness.stale
            ? ProjectionStaleBanner.staleSecondaryText
            : ProjectionStaleBanner.unknownSecondaryText;

        await tester.pumpWidget(
          MaterialApp(
            theme: theme,
            home: Scaffold(
              body: ProjectionStaleBanner(freshness: freshness),
            ),
          ),
        );

        final card = tester.widget<Card>(find.byType(Card));
        final cardColor = card.color!;
        final primary = tester.widget<Text>(find.text(primaryText));
        final secondary = tester.widget<Text>(find.text(secondaryText));
        final icon = tester.widget<Icon>(find.byIcon(Icons.info_outline));

        expect(cardColor.a, 1.0);
        expect(
          _contrastRatio(primary.style!.color!, cardColor),
          greaterThanOrEqualTo(7.0),
        );
        expect(
          _contrastRatio(secondary.style!.color!, cardColor),
          greaterThanOrEqualTo(4.5),
        );
        expect(
          _contrastRatio(icon.color!, cardColor),
          greaterThanOrEqualTo(4.5),
        );
      }
    }
  });

  testWidgets('forbidden action texts are not present on banner',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ProjectionStaleBanner(
            freshness: ProjectionFreshness.unknown,
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
    expect(find.byType(ButtonStyleButton), findsNothing);
    expect(find.byType(InkWell), findsNothing);
  });
}

double _contrastRatio(Color foreground, Color background) {
  final lighter = foreground.computeLuminance() > background.computeLuminance()
      ? foreground.computeLuminance()
      : background.computeLuminance();
  final darker = foreground.computeLuminance() > background.computeLuminance()
      ? background.computeLuminance()
      : foreground.computeLuminance();
  return (lighter + 0.05) / (darker + 0.05);
}
