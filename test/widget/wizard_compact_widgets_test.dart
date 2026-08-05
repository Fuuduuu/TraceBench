import 'dart:ui' show SemanticsAction;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:trace_bench_viewer/features/project/widgets/wizard_compact_tokens.dart';
import 'package:trace_bench_viewer/features/project/widgets/wizard_compact_widgets.dart';

Widget _app(
  Widget child, {
  double textScale = 1,
  bool disableAnimations = false,
}) {
  return MaterialApp(
    theme: ThemeData(useMaterial3: true),
    home: Builder(
      builder: (context) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(textScale),
            disableAnimations: disableAnimations,
          ),
          child: Scaffold(
            backgroundColor: WizardCompactTokens.background,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: child,
              ),
            ),
          ),
        );
      },
    ),
  );
}

Future<void> _focusAndActivate(
  WidgetTester tester,
  FocusNode node,
  LogicalKeyboardKey key,
) async {
  node.requestFocus();
  await tester.pump();
  await tester.sendKeyEvent(key);
  await tester.pump();
}

void main() {
  test('compact tokens are immutable values and pure helpers', () {
    expect(WizardCompactTokens.space8, 8);
    expect(WizardCompactTokens.minimumTapTarget, 44);
    expect(WizardCompactTokens.headerMinimumHeight, 40);
    expect(WizardCompactTokens.popoverMaximumWidth, 372);
    expect(
      WizardCompactTokens.motionDuration(disableAnimations: true),
      Duration.zero,
    );
    expect(
      WizardCompactTokens.motionDuration(disableAnimations: false),
      WizardCompactTokens.fastMotion,
    );

    final first = WizardCompactTokens.panelDecoration();
    final second = WizardCompactTokens.panelDecoration();
    expect(first, second);
    expect(first.color, WizardCompactTokens.panel);
  });

  testWidgets(
    'icon actions expose tooltip semantics keyboard activation and disabled state',
    (tester) async {
      final enabledFocus = FocusNode();
      final disabledFocus = FocusNode();
      addTearDown(enabledFocus.dispose);
      addTearDown(disabledFocus.dispose);
      var activations = 0;

      await tester.pumpWidget(
        _app(
          Row(
            children: <Widget>[
              WizardCompactIconAction(
                key: const ValueKey('enabled-action'),
                label: 'Suurenda fotot',
                icon: Icons.zoom_in,
                focusNode: enabledFocus,
                onPressed: () => activations += 1,
              ),
              WizardCompactIconAction(
                key: const ValueKey('destructive-action'),
                label: 'Eemalda foto',
                icon: Icons.delete_outline,
                tone: WizardCompactActionTone.destructive,
                focusNode: disabledFocus,
                onPressed: null,
              ),
            ],
          ),
        ),
      );

      expect(tester.getSize(find.byKey(const ValueKey('enabled-action'))),
          const Size(44, 44));
      expect(find.byTooltip('Suurenda fotot'), findsOneWidget);
      expect(find.bySemanticsLabel('Suurenda fotot'), findsOneWidget);
      expect(
        find.bySemanticsLabel('Eemalda foto, hävitav toiming'),
        findsOneWidget,
      );

      await _focusAndActivate(tester, enabledFocus, LogicalKeyboardKey.enter);
      await _focusAndActivate(tester, enabledFocus, LogicalKeyboardKey.space);
      expect(activations, 2);

      final disabledSemantics = tester.getSemantics(
        find.bySemanticsLabel('Eemalda foto, hävitav toiming'),
      );
      expect(
          disabledSemantics.getSemanticsData().hasAction(
                SemanticsAction.tap,
              ),
          isFalse);
      enabledFocus.unfocus();
      await tester.pump();
      await _focusAndActivate(tester, disabledFocus, LogicalKeyboardKey.enter);
      expect(activations, 2);
    },
  );

  testWidgets('controlled disclosure emits once and never owns expansion',
      (tester) async {
    var expanded = false;
    var callbacks = 0;

    Widget build() {
      return _app(
        StatefulBuilder(
          builder: (context, setState) {
            return WizardCompactDisclosure(
              key: const ValueKey('disclosure'),
              label: 'Täpsemalt',
              expanded: expanded,
              onChanged: (next) {
                callbacks += 1;
                setState(() => expanded = next);
              },
              child: const Text('Täielik abitekst'),
            );
          },
        ),
        disableAnimations: true,
      );
    }

    await tester.pumpWidget(build());
    expect(find.text('Täielik abitekst'), findsNothing);
    await tester.tap(find.byKey(const ValueKey('disclosure')));
    await tester.pump();
    expect(callbacks, 1);
    expect(find.text('Täielik abitekst'), findsOneWidget);
    expect(find.byType(AnimatedSize), findsNothing);

    await tester.pumpWidget(build());
    await tester.pump();
    expect(callbacks, 1);
    expect(find.text('Täielik abitekst'), findsOneWidget);
  });

  testWidgets('slider and numeric input pass controlled values through once',
      (tester) async {
    var sliderValue = 0.4;
    var sliderCallbacks = 0;
    var numericCallbacks = 0;
    final controller = TextEditingController(text: '15');
    addTearDown(controller.dispose);

    await tester.pumpWidget(
      _app(
        Column(
          children: <Widget>[
            WizardCompactSlider(
              key: const ValueKey('controlled-slider'),
              label: 'Läbipaistvus',
              valueLabel: '40%',
              value: sliderValue,
              min: 0,
              max: 1,
              divisions: 100,
              onChanged: (value) {
                sliderCallbacks += 1;
                sliderValue = value;
              },
            ),
            WizardCompactNumericInput(
              key: const ValueKey('numeric-input'),
              label: 'Pööre',
              controller: controller,
              suffixText: '°',
              onChanged: (_) => numericCallbacks += 1,
            ),
          ],
        ),
      ),
    );

    tester
        .widget<Slider>(find.byKey(const ValueKey('controlled-slider-control')))
        .onChanged!(0.7);
    await tester.pump();
    expect(sliderValue, 0.7);
    expect(sliderCallbacks, 1);
    expect(
      tester
          .widget<Slider>(
            find.byKey(const ValueKey('controlled-slider-control')),
          )
          .value,
      0.4,
      reason: 'The caller remains the value owner until it rebuilds.',
    );

    await tester.enterText(
      find.byKey(const ValueKey('numeric-input-control')),
      '30',
    );
    await tester.pump();
    expect(controller.text, '30');
    expect(numericCallbacks, 1);
  });

  testWidgets('information popover clamps scrolls and Escape restores focus',
      (tester) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(390, 300);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(
      _app(
        Align(
          alignment: Alignment.topLeft,
          child: WizardCompactInfoPopover(
            label: 'Mida see tähendab?',
            triggerKey: const ValueKey('info-trigger'),
            popoverKey: const ValueKey('info-popover'),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Text('Täielik selgitus'),
                for (var index = 0; index < 30; index += 1)
                  Text('Lisarea $index'),
              ],
            ),
          ),
        ),
      ),
    );

    expect(
      MediaQuery.sizeOf(
        tester.element(find.byKey(const ValueKey('info-trigger'))),
      ),
      const Size(390, 300),
    );

    await tester.tap(find.byKey(const ValueKey('info-trigger')));
    await tester.pump();

    final popover = find.byKey(const ValueKey('info-popover'));
    expect(popover, findsOneWidget);
    final size = tester.getSize(popover);
    expect(size.width, lessThanOrEqualTo(358));
    expect(size.height, lessThanOrEqualTo(268));
    expect(
      find.descendant(
          of: popover, matching: find.byType(SingleChildScrollView)),
      findsOneWidget,
    );
    expect(find.text('Täielik selgitus'), findsOneWidget);

    await tester.sendKeyEvent(LogicalKeyboardKey.escape);
    await tester.pump();
    expect(popover, findsNothing);
    expect(
      tester
          .widget<FocusableActionDetector>(
            find.byKey(const ValueKey('info-trigger-button')),
          )
          .focusNode!
          .hasFocus,
      isTrue,
    );
  });

  testWidgets(
    'reserved compact primitives render at 200 percent in unbounded narrow layout',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 760));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      var selected = 'circle';
      var navigationCalls = 0;

      await tester.pumpWidget(
        _app(
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const WizardCompactStepHeader(
                eyebrow: 'Samm 3 / 7',
                title: 'Väga pikk sisu järgi kasvav sammu pealkiri',
                description:
                    'Kogu kirjeldus peab jääma nähtavaks ka suure tekstiga.',
                requiredField: true,
              ),
              WizardCompactToolbar(
                label: 'Tööriistariba',
                children: <Widget>[
                  for (var index = 0; index < 6; index += 1)
                    WizardCompactIconAction(
                      label: 'Toiming $index',
                      icon: Icons.tune,
                      onPressed: () {},
                    ),
                ],
              ),
              WizardCompactControlGroup(
                label: 'Juhikud',
                children: <Widget>[
                  Text('Täielik juhiku väärtus',
                      style: WizardCompactTokens.bodyStyle()),
                ],
              ),
              WizardCompactFieldSection(
                label: 'Probleemi põhikirjeldus',
                requiredField: true,
                child: TextField(
                  decoration: WizardCompactTokens.inputDecoration(
                    hintText: 'Kirjelda tähelepanekut',
                  ),
                ),
              ),
              WizardCompactPanel(
                title: 'Inspektor',
                child: WizardCompactTileSelector<String>(
                  label: 'Kuju',
                  value: selected,
                  onChanged: (value) => selected = value,
                  tiles: const <WizardCompactTile<String>>[
                    WizardCompactTile(
                      value: 'circle',
                      label: 'Ümar',
                      icon: Icons.circle_outlined,
                    ),
                    WizardCompactTile(
                      value: 'square',
                      label: 'Ruut',
                      icon: Icons.square_outlined,
                    ),
                    WizardCompactTile(
                      value: 'rectangle',
                      label: 'Ristkülik',
                      icon: Icons.rectangle_outlined,
                    ),
                    WizardCompactTile(
                      value: 'rounded',
                      label: 'Ümardatud ristkülik',
                      icon: Icons.rounded_corner,
                    ),
                  ],
                ),
              ),
              const WizardCompactWorkspace(
                stacked: true,
                workspace: SizedBox(height: 80, child: Text('Lõuend')),
                inspector: Text('Külgpaneel'),
              ),
              WizardCompactReviewSection(
                title: 'Täielik kontrolliosa',
                onEdit: () {},
                children: const <Widget>[
                  Text('Mitmerealine väärtus, mida ei lühendata punktidega.'),
                ],
              ),
              WizardCompactSuccessCard(
                title: 'Projekt loodud',
                message: 'Projekt on valmis avamiseks.',
                details: const <Widget>[
                  Text('prj_a1b2c3d4'),
                  Text('C:/projects/prj_a1b2c3d4'),
                ],
                actions: <Widget>[
                  FilledButton(
                      onPressed: () {}, child: const Text('Ava projekt')),
                ],
              ),
              WizardCompactShell(
                compact: true,
                navigation: WizardCompactNavigation(
                  compact: true,
                  items: <WizardCompactNavigationItem>[
                    WizardCompactNavigationItem(
                      label: 'Projekti andmed',
                      detail: 'Valmis',
                      state: WizardCompactStepState.complete,
                      onPressed: () => navigationCalls += 1,
                    ),
                    const WizardCompactNavigationItem(
                      label: 'Foto ja joondamine',
                      detail: 'Praegune',
                      state: WizardCompactStepState.current,
                    ),
                  ],
                ),
                footer: const Text('Navigeerimistoimingud'),
                child: const Text('Sammu sisu'),
              ),
            ],
          ),
          textScale: 2,
        ),
      );
      await tester.pump();

      expect(
          find.text('Kogu kirjeldus peab jääma nähtavaks ka suure tekstiga.'),
          findsOneWidget);
      expect(find.text('Ava projekt'), findsOneWidget);
      expect(find.text('Navigeerimistoimingud'), findsOneWidget);
      expect(find.byKey(const ValueKey('wizard-compact-shell-compact')),
          findsOneWidget);
      expect(tester.takeException(), isNull);

      await tester.ensureVisible(find.text('Projekti andmed'));
      await tester.tap(find.text('Projekti andmed'));
      await tester.pump();
      expect(navigationCalls, 1);
    },
  );

  testWidgets('wide shell and workspace keep caller-selected presentation',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(1440, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      _app(
        const WizardCompactShell(
          compact: false,
          navigation: SizedBox(width: 220, child: Text('Nav')),
          child: WizardCompactWorkspace(
            stacked: false,
            workspace: SizedBox(height: 200, child: Text('Workspace')),
            inspector: Text('Inspector'),
          ),
        ),
      ),
    );

    expect(find.byKey(const ValueKey('wizard-compact-shell-wide')),
        findsOneWidget);
    expect(find.byKey(const ValueKey('wizard-compact-workspace-wide')),
        findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
