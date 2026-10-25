import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trace_bench_viewer/features/board_canvas/theme/board_canvas_palette.dart';
import 'package:trace_bench_viewer/shared/theme/app_theme.dart';
import 'package:trace_bench_viewer/shared/widgets/workbench_page.dart';

// Fixed pre-extraction oracle: do not replace literals with shared aliases.
const _palette = <String, (Color, Color, int)>{
  'shell': (BoardCanvasPalette.shell, WorkbenchColors.shell, 0xFF0C0C0C),
  'paper': (BoardCanvasPalette.paper, WorkbenchColors.paper, 0xFF1A1916),
  'tile': (BoardCanvasPalette.tile, WorkbenchColors.tile, 0xFF141310),
  'navy': (BoardCanvasPalette.navy, WorkbenchColors.navy, 0xFFF3ECDC),
  'navyDeep': (
    BoardCanvasPalette.navyDeep,
    WorkbenchColors.navyDeep,
    0xFF0A0A0A
  ),
  'muted': (BoardCanvasPalette.muted, WorkbenchColors.muted, 0xFFA89F8C),
  'dim': (BoardCanvasPalette.dim, WorkbenchColors.dim, 0xFF7E776A),
  'signal': (BoardCanvasPalette.signal, WorkbenchColors.signal, 0xFFE7C25A),
  'signalTint': (
    BoardCanvasPalette.signalTint,
    WorkbenchColors.signalTint,
    0xFF2A2416
  ),
  'ready': (BoardCanvasPalette.ready, WorkbenchColors.ready, 0xFF6FCF97),
  'readyTint': (
    BoardCanvasPalette.readyTint,
    WorkbenchColors.readyTint,
    0xFF0E251B
  ),
  'rule': (BoardCanvasPalette.rule, WorkbenchColors.rule, 0xFF332E22),
  'ruleStrong': (
    BoardCanvasPalette.ruleStrong,
    WorkbenchColors.ruleStrong,
    0xFF6B5A30
  ),
};

// Composite before linearization, retaining the unrounded WCAG ratio.
double _contrast(Color foreground, Color background) {
  final opaqueBackground = Color.alphaBlend(background, Colors.black);
  final opaqueForeground = Color.alphaBlend(foreground, opaqueBackground);
  double luminance(Color color) {
    double linear(double channel) => channel <= 0.04045
        ? channel / 12.92
        : math.pow((channel + 0.055) / 1.055, 2.4).toDouble();
    return 0.2126 * linear(color.r) +
        0.7152 * linear(color.g) +
        0.0722 * linear(color.b);
  }

  final a = luminance(opaqueForeground), b = luminance(opaqueBackground);
  return (math.max(a, b) + 0.05) / (math.min(a, b) + 0.05);
}

void _readable(String name, Color foreground, Color background,
    [double minimum = 4.5]) {
  expect(_contrast(foreground, background), greaterThanOrEqualTo(minimum),
      reason: '$name: ${foreground.toARGB32().toRadixString(16)} on '
          '${background.toARGB32().toRadixString(16)}');
}

const _states = <Set<WidgetState>>[
  {},
  {WidgetState.hovered},
  {WidgetState.focused},
  {WidgetState.pressed},
  {WidgetState.selected},
  {WidgetState.disabled},
  {WidgetState.selected, WidgetState.focused},
  {WidgetState.selected, WidgetState.disabled},
  {WidgetState.hovered, WidgetState.focused},
];

void main() {
  test('captured popup selected text icons and boundaries retain contrast', () {
    final t = buildWorkbenchTheme();
    final popup = t.popupMenuTheme;
    final surface = popup.color!;
    for (final states in _states) {
      final label = popup.labelTextStyle!.resolve(states)!;
      _readable('popup label $states', label.color!, surface);
      for (final overlay in [t.hoverColor, t.focusColor, t.highlightColor]) {
        _readable('popup overlay $states', label.color!,
            Color.alphaBlend(overlay, surface));
      }
    }
    _readable('popup checked icon', t.listTileTheme.iconColor!, surface, 3);
    final side = (popup.shape! as RoundedRectangleBorder).side;
    _readable('popup outline inside', side.color, surface, 3);
    _readable('popup outline outside', side.color, WorkbenchColors.paper, 3);
    for (final pair in [
      (t.colorScheme.onSecondaryContainer, t.colorScheme.secondaryContainer),
      (t.colorScheme.onTertiaryContainer, t.colorScheme.tertiaryContainer),
      (t.colorScheme.onSurface, t.colorScheme.surface),
    ]) {
      _readable('freshness roles', pair.$1, pair.$2);
    }
    _readable(
        'freshness outline', t.colorScheme.outline, t.colorScheme.surface, 3);
  });

  test('every Canvas constant retains its literal and shared const alias', () {
    final source =
        File('lib/features/board_canvas/theme/board_canvas_palette.dart')
            .readAsStringSync();
    final names = RegExp(r'static const Color (\w+) =')
        .allMatches(source)
        .map((m) => m[1]!)
        .toSet();
    expect(names, _palette.keys.toSet());
    expect(names, hasLength(13));
    for (final entry in _palette.entries) {
      expect(entry.value.$1.toARGB32(), entry.value.$3, reason: entry.key);
      expect(entry.value.$1, entry.value.$2, reason: entry.key);
    }
  });

  test(
      'complete dark roles, surfaces and actual freshness pairs are accessible',
      () {
    final theme = buildWorkbenchTheme(), c = theme.colorScheme;
    expect(c.brightness, Brightness.dark);
    final pairs = <String, (Color, Color)>{
      'primary': (c.onPrimary, c.primary),
      'primary container': (c.onPrimaryContainer, c.primaryContainer),
      'primary fixed': (c.onPrimaryFixed, c.primaryFixed),
      'primary fixed dim': (c.onPrimaryFixed, c.primaryFixedDim),
      'primary fixed variant': (c.onPrimaryFixedVariant, c.primaryFixed),
      'primary fixed dim variant': (c.onPrimaryFixedVariant, c.primaryFixedDim),
      'secondary': (c.onSecondary, c.secondary),
      'stale banner': (c.onSecondaryContainer, c.secondaryContainer),
      'secondary fixed': (c.onSecondaryFixed, c.secondaryFixed),
      'secondary fixed dim': (c.onSecondaryFixed, c.secondaryFixedDim),
      'secondary fixed variant': (c.onSecondaryFixedVariant, c.secondaryFixed),
      'secondary fixed dim variant': (
        c.onSecondaryFixedVariant,
        c.secondaryFixedDim
      ),
      'tertiary': (c.onTertiary, c.tertiary),
      'unknown banner': (c.onTertiaryContainer, c.tertiaryContainer),
      'tertiary fixed': (c.onTertiaryFixed, c.tertiaryFixed),
      'tertiary fixed dim': (c.onTertiaryFixed, c.tertiaryFixedDim),
      'tertiary fixed variant': (c.onTertiaryFixedVariant, c.tertiaryFixed),
      'tertiary fixed dim variant': (
        c.onTertiaryFixedVariant,
        c.tertiaryFixedDim
      ),
      'error': (c.onError, c.error),
      'error container': (c.onErrorContainer, c.errorContainer),
      'raised danger': (WorkbenchColors.danger, WorkbenchColors.dangerRaised),
      'inverse': (c.onInverseSurface, c.inverseSurface),
      'snackbar action': (
        theme.snackBarTheme.actionTextColor!,
        c.inverseSurface
      ),
      'freshness tag': (c.onSurface, c.surface),
    };
    for (final p in pairs.entries) {
      _readable(p.key, p.value.$1, p.value.$2);
    }
    final surfaces = <Color>{
      c.surface,
      c.surfaceDim,
      c.surfaceBright,
      c.surfaceContainerLowest,
      c.surfaceContainerLow,
      c.surfaceContainer,
      c.surfaceContainerHigh,
      c.surfaceContainerHighest,
      c.primaryContainer,
      c.secondaryContainer,
      c.tertiaryContainer,
    };
    for (final surface in surfaces) {
      for (final foreground in [
        c.onSurface,
        c.onSurfaceVariant,
        c.primary,
        c.error,
        WorkbenchColors.warning
      ]) {
        _readable(
            'body/secondary/helper/empty/warning/danger', foreground, surface);
      }
      _readable('essential outline', c.outline, surface, 3);
      _readable('essential outline variant', c.outlineVariant, surface, 3);
    }
    // Both sides of the actual freshness tag border, not only its fill.
    for (final surface in [
      c.surface,
      c.secondaryContainer,
      c.tertiaryContainer
    ]) {
      _readable('freshness tag boundary', c.outline, surface, 3);
    }
    expect(c.onPrimary, WorkbenchColors.navyDeep);
    expect(c.secondary, const Color(0xFFF6C453));
    expect(c.error, const Color(0xFFFCA5A5));
    expect(c.onErrorContainer, const Color(0xFFEAA6A6));
    expect(c.errorContainer, const Color(0xFF211417));
    expect(WorkbenchColors.dangerRaised, const Color(0xFF493039));
  });

  test('resolved component states preserve text and essential borders', () {
    final t = buildWorkbenchTheme(), c = t.colorScheme;
    for (final states in _states) {
      for (final style in [
        t.filledButtonTheme.style!,
        t.elevatedButtonTheme.style!,
        t.outlinedButtonTheme.style!,
        t.textButtonTheme.style!,
        t.iconButtonTheme.style!,
        t.menuButtonTheme.style!
      ]) {
        final bg = style.backgroundColor!.resolve(states)!;
        final overlay = style.overlayColor!.resolve(states)!;
        final painted = Color.alphaBlend(overlay, bg);
        _readable(
            'button $states', style.foregroundColor!.resolve(states)!, painted);
        final side = style.side!.resolve(states)!;
        if (side.style != BorderStyle.none) {
          _readable('button inner $states', side.color, painted, 3);
          _readable('button outer $states', side.color, c.surface, 3);
        } else if (style == t.filledButtonTheme.style ||
            style == t.elevatedButtonTheme.style) {
          _readable('filled boundary $states', painted, c.surface, 3);
        }
      }
      final chip = t.chipTheme.color!.resolve(states)!;
      final chipBorder =
          WidgetStateProperty.resolveAs<BorderSide?>(t.chipTheme.side, states)!;
      _readable('chip label $states', t.chipTheme.labelStyle!.color!, chip);
      _readable('chip inside $states', chipBorder.color, chip, 3);
      _readable('chip outside $states', chipBorder.color, c.surface, 3);
      _readable(
          'menu item $states',
          t.popupMenuTheme.labelTextStyle!.resolve(states)!.color!,
          t.popupMenuTheme.color!);
      final checkFill = t.checkboxTheme.fillColor!.resolve(states)!;
      if (states.contains(WidgetState.selected)) {
        _readable('checkbox check $states',
            t.checkboxTheme.checkColor!.resolve(states)!, checkFill, 3);
      }
      _readable(
          'checkbox boundary $states',
          WidgetStateProperty.resolveAs<BorderSide?>(
                  t.checkboxTheme.side, states)!
              .color,
          c.surface,
          3);
      final radioBackground = Color.alphaBlend(
          t.radioTheme.overlayColor!.resolve(states)!, c.surface);
      _readable('radio $states', t.radioTheme.fillColor!.resolve(states)!,
          radioBackground, 3);
      _readable(
          'checkbox after overlay $states',
          WidgetStateProperty.resolveAs<BorderSide?>(
                  t.checkboxTheme.side, states)!
              .color,
          Color.alphaBlend(
              t.checkboxTheme.overlayColor!.resolve(states)!, c.surface),
          3);
      final track = t.switchTheme.trackColor!.resolve(states)!;
      _readable('switch thumb $states',
          t.switchTheme.thumbColor!.resolve(states)!, track, 3);
      final switchBackground = Color.alphaBlend(
          t.switchTheme.overlayColor!.resolve(states)!, c.surface);
      _readable('switch track outline $states',
          t.switchTheme.trackOutlineColor!.resolve(states)!, switchBackground, 3);
      if (states.contains(WidgetState.selected)) {
        // Gold fill supplies the selected track's boundary against the page.
        _readable('selected switch boundary $states', track, switchBackground, 3);
      } else {
        _readable('switch inner boundary $states',
            t.switchTheme.trackOutlineColor!.resolve(states)!, track, 3);
      }
    }
    for (final border in [
      t.inputDecorationTheme.enabledBorder!,
      t.inputDecorationTheme.disabledBorder!,
      t.inputDecorationTheme.focusedBorder!,
      t.inputDecorationTheme.errorBorder!,
      t.inputDecorationTheme.focusedErrorBorder!
    ]) {
      _readable('input inside', border.borderSide.color,
          t.inputDecorationTheme.fillColor!, 3);
      _readable('input outside', border.borderSide.color, c.surface, 3);
    }
    for (final style in [
      t.inputDecorationTheme.labelStyle!,
      t.inputDecorationTheme.hintStyle!,
      t.inputDecorationTheme.helperStyle!,
      t.inputDecorationTheme.errorStyle!,
      t.inputDecorationTheme.floatingLabelStyle!
    ]) {
      _readable('input label/helper/error', style.color!,
          t.inputDecorationTheme.fillColor!);
    }
    for (final bg in [
      t.cardTheme.color!,
      t.dialogTheme.backgroundColor!,
      t.popupMenuTheme.color!,
      t.dropdownMenuTheme.menuStyle!.backgroundColor!.resolve({})!,
      c.surface
    ]) {
      for (final overlay in [
        Colors.transparent,
        t.hoverColor,
        t.focusColor,
        t.highlightColor,
        t.splashColor,
        t.textSelectionTheme.selectionColor!
      ]) {
        _readable('body after alpha overlay', c.onSurface,
            Color.alphaBlend(overlay, bg));
        // Selection applies to normal input text, not disabled/helper copy.
        if (overlay != t.textSelectionTheme.selectionColor) {
          _readable('secondary after alpha overlay', c.onSurfaceVariant,
              Color.alphaBlend(overlay, bg));
        }
      }
    }
    _readable('tooltip', t.tooltipTheme.textStyle!.color!,
        (t.tooltipTheme.decoration! as BoxDecoration).color!);
    _readable('snackbar', t.snackBarTheme.contentTextStyle!.color!,
        t.snackBarTheme.backgroundColor!);
    expect(
        t.outlinedButtonTheme.style!.side!
            .resolve({WidgetState.focused})!.width,
        2);
    expect(
        t.filledButtonTheme.style!.textStyle!
            .resolve({WidgetState.focused})!.decoration,
        TextDecoration.underline);
    expect(t.chipTheme.showCheckmark, isTrue);
  });

  testWidgets(
      '1.5x compact frame actions wrap and keep keyboard labels available',
      (tester) async {
    tester.view.physicalSize = const Size(400, 700);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(MaterialApp(
        builder: (context, child) => MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: const TextScaler.linear(1.5)),
              child: child!,
            ),
        home: WorkbenchPage(
          statusBuilder: (_) => const Text('Presentation status'),
          actions: [
            OutlinedButton(onPressed: () {}, child: const Text('First action')),
            const OutlinedButton(
                onPressed: null, child: Text('Disabled action')),
          ],
          builder: (_) => ListView(children: const [
            TextField(
                decoration:
                    InputDecoration(labelText: 'Input', hintText: 'Hint')),
            TextField(
                enabled: false,
                decoration: InputDecoration(labelText: 'Disabled input')),
            FilterChip(
                label: Text('Selected'), selected: true, onSelected: null),
          ]),
        )));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    expect(find.text('First action'), findsOneWidget);
    expect(find.text('Disabled action'), findsOneWidget);
    expect(find.byType(Scrollable),
        findsNWidgets(3)); // list and two editable fields
  });

  testWidgets(
      'builders and slots inherit local theme; no added navigation chrome',
      (tester) async {
    await tester.pumpWidget(MaterialApp(
        theme: buildTheme(),
        home: Column(children: [
          const Text('root theme'),
          Expanded(
              child: WorkbenchPage(
            maxContentWidth: 480,
            statusBuilder: (context) =>
                Text('status ${Theme.of(context).brightness.name}'),
            actions: [
              OutlinedButton(
                  onPressed: () {}, child: const Text('Local action'))
            ],
            builder: (context) =>
                Text('body ${Theme.of(context).brightness.name}'),
          )),
        ])));
    expect(find.text('status dark'), findsOneWidget);
    expect(find.text('body dark'), findsOneWidget);
    expect(Theme.of(tester.element(find.text('Local action'))).brightness,
        Brightness.dark);
    expect(Theme.of(tester.element(find.text('root theme'))).brightness,
        Brightness.light);
    expect(find.byType(Scaffold), findsNothing);
    expect(find.byType(AppBar), findsNothing);
    expect(
        tester.getSize(find.text('body dark')).width, lessThanOrEqualTo(480));
  });

  testWidgets('empty builder and lazy content retain one scroll owner',
      (tester) async {
    var built = 0;
    await tester.pumpWidget(MaterialApp(
        home: WorkbenchPage(
      builder: (_) => ListView.builder(
          itemCount: 200,
          itemBuilder: (_, i) {
            built++;
            return SizedBox(height: 80, child: Text('row $i'));
          }),
    )));
    expect(find.byType(Scrollable), findsOneWidget);
    expect(built, lessThan(200));
    expect(
        PrimaryScrollController.maybeOf(tester.element(find.byType(ListView))),
        isNull);
    await tester.drag(find.byType(ListView), const Offset(0, -600));
    await tester.pumpAndSettle();
    expect(find.text('row 0'), findsNothing);
    expect(built, lessThan(200));
    await tester.pumpWidget(MaterialApp(
        home: WorkbenchPage(
      isEmpty: true,
      emptyBuilder: (_) => const Center(child: Text('empty')),
      builder: (_) => throw StateError('nonempty content should stay lazy'),
    )));
    expect(find.text('empty'), findsOneWidget);
    expect(find.byType(Card), findsNothing);
  });

  testWidgets('keyboard action, popup and captured dialog keep warm theme',
      (tester) async {
    var count = 0;
    await tester.pumpWidget(MaterialApp(
        theme: buildTheme(),
        home: WorkbenchPage(
          builder: (context) => Column(children: [
            FilledButton(
                onPressed: () => count++, child: const Text('keyboard')),
            PopupMenuButton<String>(
                itemBuilder: (_) => [
                      const PopupMenuItem(
                          value: 'one', child: Text('menu item')),
                      const PopupMenuItem(
                          enabled: false, child: Text('disabled menu')),
                    ]),
            OutlinedButton(
                onPressed: () => showDialog<void>(
                    context: context,
                    builder: (dialogContext) => AlertDialog(
                          title: const Text('dialog'),
                          content:
                              Text(Theme.of(dialogContext).brightness.name),
                        )),
                child: const Text('open dialog')),
          ]),
        )));
    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    await tester.pump();
    expect(Focus.of(tester.element(find.text('keyboard'))).hasFocus, isTrue);
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.pumpAndSettle();
    expect(count, 1);
    await tester.tap(find.byType(PopupMenuButton<String>));
    await tester.pumpAndSettle();
    expect(Theme.of(tester.element(find.text('menu item'))).colorScheme.surface,
        WorkbenchColors.paper);
    await tester.sendKeyEvent(LogicalKeyboardKey.escape);
    await tester.pumpAndSettle();
    await tester.tap(find.text('open dialog'));
    await tester.pumpAndSettle();
    expect(find.text('dark'), findsOneWidget);
    expect(
        Theme.of(tester.element(find.text('dialog')))
            .dialogTheme
            .backgroundColor,
        WorkbenchColors.raised);
  });
}
