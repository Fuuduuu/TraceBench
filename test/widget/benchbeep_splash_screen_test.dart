import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:trace_bench_viewer/app/app.dart';
import 'package:trace_bench_viewer/features/home/screens/benchbeep_home_screen.dart';
import 'package:trace_bench_viewer/features/home/screens/benchbeep_splash_screen.dart';
import 'package:trace_bench_viewer/features/project/screens/new_project_wizard_screen.dart';

int _matchCount(String source, RegExp pattern) =>
    pattern.allMatches(source).length;

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

  testWidgets(
      'app keeps one router while the 3200 ms splash completes over launcher',
      (tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: TraceBenchApp()),
    );

    expect(
      find.byKey(const ValueKey('benchbeep_workbench_router')),
      findsOneWidget,
    );
    final launcher = find.byType(BenchBeepHomeScreen);
    final intro = find.byKey(const ValueKey('benchbeep_startup_intro'));
    expect(launcher, findsOneWidget);
    expect(intro, findsOneWidget);

    final router = GoRouter.of(tester.element(launcher));
    expect(router.routeInformationProvider.value.uri.path, '/');
    final ignorePointer = find.ancestor(
      of: intro,
      matching: find.byWidgetPredicate(
        (widget) => widget is IgnorePointer && widget.ignoring,
      ),
    );
    expect(ignorePointer, findsOneWidget);
    expect(tester.widget<IgnorePointer>(ignorePointer).ignoring, isTrue);
    expect(
      find.ancestor(of: ignorePointer, matching: find.byType(Stack)),
      findsAtLeastNWidgets(1),
    );

    await tester.pump(const Duration(milliseconds: 3199));
    expect(intro, findsOneWidget);
    expect(
      GoRouter.of(tester.element(launcher)),
      same(router),
    );

    await tester.pump(const Duration(milliseconds: 2));
    await tester.pump();

    expect(intro, findsNothing);
    final revealedLauncher = find.byType(BenchBeepHomeScreen);
    expect(revealedLauncher, findsOneWidget);
    expect(
      GoRouter.of(tester.element(revealedLauncher)),
      same(router),
    );

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
    expect(tester.takeException(), isNull);
  });

  testWidgets(
      'early pointer-through navigation latches splash complete for Home return',
      (tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: TraceBenchApp()),
    );

    final launcher = find.byType(BenchBeepHomeScreen);
    final intro = find.byKey(const ValueKey('benchbeep_startup_intro'));
    expect(launcher, findsOneWidget);
    expect(intro, findsOneWidget);
    final router = GoRouter.of(tester.element(launcher));

    final action = find.byKey(
      const ValueKey('benchbeep_home_new_project_deferred'),
    );
    await tester.ensureVisible(action);
    await tester.tap(action);
    await tester.pumpAndSettle();

    final wizard = find.byType(NewProjectWizardScreen);
    expect(wizard, findsOneWidget);
    expect(intro, findsNothing);
    expect(GoRouter.of(tester.element(wizard)), same(router));
    expect(router.routeInformationProvider.value.uri.path, '/new-project');

    await tester.tap(find.byKey(const ValueKey('wizard-cancel')));
    await tester.pumpAndSettle();

    final returnedLauncher = find.byType(BenchBeepHomeScreen);
    expect(returnedLauncher, findsOneWidget);
    expect(intro, findsNothing);
    expect(
      GoRouter.of(tester.element(returnedLauncher)),
      same(router),
    );
    expect(router.routeInformationProvider.value.uri.path, '/');

    await tester.pump(const Duration(milliseconds: 3200));
    await tester.pump();
    expect(intro, findsNothing);
    expect(
      GoRouter.of(tester.element(returnedLauncher)),
      same(router),
    );
  });

  test('app owns one lifetime router and wires splash without a route', () {
    final appSource = File('lib/app/app.dart').readAsStringSync();
    final routerSource = File('lib/app/router.dart').readAsStringSync();

    expect(
      appSource,
      contains("features/home/screens/benchbeep_splash_screen.dart"),
    );
    expect(appSource, contains('BenchBeepSplashScreen'));
    expect(appSource, contains('_showStartupIntro'));
    expect(appSource, contains('late final GoRouter _router;'));
    expect(appSource, contains('void initState()'));
    expect(appSource, contains('homeBuilder: _buildLauncherShell'));
    expect(appSource, contains("initialLocation: '/'"));
    expect(appSource, contains('_router.go(initialLocation);'));
    expect(appSource, isNot(contains('_showLauncher')));
    expect(appSource, isNot(contains('_workbenchRouter')));
    expect(appSource, isNot(contains('.push(')));
    expect(
      _matchCount(appSource, RegExp(r'buildTraceBenchRouter\(')),
      1,
    );
    expect(
      _matchCount(appSource, RegExp(r'MaterialApp\.router\(')),
      1,
    );
    expect(
      _matchCount(appSource, RegExp(r'\bMaterialApp\(')),
      0,
    );
    expect(
      _matchCount(appSource, RegExp(r'_router\.dispose\(\);')),
      1,
    );
    expect(appSource, isNot(contains("'/splash'")));
    expect(routerSource, isNot(contains("'/splash'")));
  });

  test('splash stays presentation-only', () {
    final splashSource = File(
      'lib/features/home/screens/benchbeep_splash_screen.dart',
    ).readAsStringSync();

    expect(splashSource, contains('Duration(milliseconds: 3200)'));
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
