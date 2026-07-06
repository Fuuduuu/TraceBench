import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trace_bench_viewer/features/home/screens/benchbeep_splash_screen.dart';

void main() {
  testWidgets('renders BenchBeep startup identity', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BenchBeepSplashScreen(
          total: const Duration(milliseconds: 40),
          onComplete: () {},
        ),
      ),
    );

    expect(
        find.byKey(const ValueKey('benchbeep_startup_intro')), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (widget) => widget is RichText && widget.text.toPlainText() == 'bench',
      ),
      findsOneWidget,
    );
    expect(
      find.byWidgetPredicate(
        (widget) => widget is RichText && widget.text.toPlainText() == 'beep',
      ),
      findsOneWidget,
    );
    expect(find.text('MEASUREMENT DATA VISUALIZATION'), findsOneWidget);
    expect(find.text('INITIALISING TRACEBENCH PLATFORM'), findsOneWidget);
    expect(
        find.byKey(const ValueKey('benchbeep_startup_meter')), findsOneWidget);
  });

  testWidgets('calls onComplete once after configured duration',
      (tester) async {
    var completeCount = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: BenchBeepSplashScreen(
          total: const Duration(milliseconds: 30),
          onComplete: () => completeCount += 1,
        ),
      ),
    );

    expect(completeCount, 0);

    await tester.pump(const Duration(milliseconds: 40));
    await tester.pump();

    expect(completeCount, 1);

    await tester.pump(const Duration(milliseconds: 120));
    await tester.pump();

    expect(completeCount, 1);
  });

  test('app wires splash before launcher without a splash route', () {
    final appSource = File('lib/app/app.dart').readAsStringSync();
    final routerSource = File('lib/app/router.dart').readAsStringSync();

    expect(
      appSource,
      contains("features/home/screens/benchbeep_splash_screen.dart"),
    );
    expect(appSource, contains('BenchBeepSplashScreen'));
    expect(appSource, contains('_showStartupIntro'));
    expect(appSource, isNot(contains("'/splash'")));
    expect(routerSource, isNot(contains("'/splash'")));
  });

  test('splash stays presentation-only', () {
    final splashSource = File(
      'lib/features/home/screens/benchbeep_splash_screen.dart',
    ).readAsStringSync();

    expect(splashSource, contains('assets/brand/benchbeep_mark.png'));
    expect(splashSource, contains('ExactAssetImage'));
    expect(splashSource, isNot(contains('_incoming')));
    expect(splashSource, isNot(contains("'/splash'")));
    expect(splashSource, isNot(contains('screenAnchor')));
    expect(splashSource, isNot(contains('Icons.memory')));
    expect(splashSource, isNot(contains('Icons.bolt')));
    expect(splashSource, isNot(contains('Icons.developer_board')));
    expect(splashSource, isNot(contains('placeholder logo')));
    expect(splashSource, isNot(contains('events.jsonl')));
    expect(splashSource, isNot(contains('known_facts.json')));
    expect(splashSource, isNot(contains('component_created')));
    expect(splashSource, isNot(contains('component_updated')));
    expect(splashSource, isNot(contains('measurement_recorded')));
    expect(splashSource, isNot(contains('Komponendid')));
    expect(splashSource, isNot(contains('Uus komponent')));
    expect(splashSource, isNot(contains('Muuda andmeid')));
    expect(splashSource, isNot(contains('Mõõda')));
  });
}
