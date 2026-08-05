import 'dart:ui' show Tristate;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:trace_bench_viewer/features/project/widgets/new_project_wizard_problem_description.dart';

class _ProblemEditorHarness extends StatefulWidget {
  const _ProblemEditorHarness({
    super.key,
    this.initialValue = const NewProjectWizardProblemDescriptionDraft(),
    this.compact = false,
  });

  final NewProjectWizardProblemDescriptionDraft initialValue;
  final bool compact;

  @override
  State<_ProblemEditorHarness> createState() => _ProblemEditorHarnessState();
}

class _ProblemEditorHarnessState extends State<_ProblemEditorHarness> {
  late NewProjectWizardProblemDescriptionDraft value = widget.initialValue;
  final List<NewProjectWizardProblemDescriptionDraft> emissions =
      <NewProjectWizardProblemDescriptionDraft>[];

  void setExternal(NewProjectWizardProblemDescriptionDraft next) {
    setState(() {
      value = next;
    });
  }

  @override
  Widget build(BuildContext context) {
    return NewProjectWizardProblemDescription(
      value: value,
      onChanged: (next) {
        emissions.add(next);
        setState(() {
          value = next;
        });
      },
      compact: widget.compact,
    );
  }
}

Widget _buildEditorApp(
  GlobalKey<_ProblemEditorHarnessState> harnessKey, {
  NewProjectWizardProblemDescriptionDraft initialValue =
      const NewProjectWizardProblemDescriptionDraft(),
  bool compact = false,
  double textScale = 1,
}) {
  return MaterialApp(
    theme: ThemeData(useMaterial3: true),
    home: MediaQuery(
      data: MediaQueryData(textScaler: TextScaler.linear(textScale)),
      child: Scaffold(
        backgroundColor: const Color(0xFF080808),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: _ProblemEditorHarness(
              key: harnessKey,
              initialValue: initialValue,
              compact: compact,
            ),
          ),
        ),
      ),
    ),
  );
}

TextEditingController _controller(WidgetTester tester, String key) {
  return tester
      .widget<TextField>(find.byKey(ValueKey<String>(key)))
      .controller!;
}

Future<void> _tapKey(WidgetTester tester, String key) async {
  final finder = find.byKey(ValueKey<String>(key));
  await tester.ensureVisible(finder);
  await tester.tap(finder);
  await tester.pump();
}

bool _focusIsWithin(WidgetTester tester, Finder target) {
  final targetElement = tester.element(target);
  final focusContext = FocusManager.instance.primaryFocus?.context;
  if (focusContext == null) {
    return false;
  }
  if (identical(focusContext, targetElement)) {
    return true;
  }
  var found = false;
  (focusContext as Element).visitAncestorElements((element) {
    if (identical(element, targetElement)) {
      found = true;
      return false;
    }
    return true;
  });
  return found;
}

void main() {
  test('draft defaults, copyWith, equality, and occurrence values are exact',
      () {
    expect(
      NewProjectWizardProblemOccurrence.values,
      const <NewProjectWizardProblemOccurrence>[
        NewProjectWizardProblemOccurrence.unknown,
        NewProjectWizardProblemOccurrence.continuous,
        NewProjectWizardProblemOccurrence.intermittent,
      ],
    );

    const empty = NewProjectWizardProblemDescriptionDraft();
    expect(empty.description, '');
    expect(empty.occurrence, NewProjectWizardProblemOccurrence.unknown);
    expect(empty.whenOccurs, '');
    expect(empty.symptoms, '');
    expect(empty.attempts, '');

    final complete = empty.copyWith(
      description: '  Ei käivitu.\n ',
      occurrence: NewProjectWizardProblemOccurrence.continuous,
      whenOccurs: ' Pärast soojenemist ',
      symptoms: ' Klõps\nja vaikus ',
      attempts: ' Kaabel vahetatud ',
    );
    const expected = NewProjectWizardProblemDescriptionDraft(
      description: '  Ei käivitu.\n ',
      occurrence: NewProjectWizardProblemOccurrence.continuous,
      whenOccurs: ' Pärast soojenemist ',
      symptoms: ' Klõps\nja vaikus ',
      attempts: ' Kaabel vahetatud ',
    );
    expect(complete, expected);
    expect(complete.hashCode, expected.hashCode);
    expect(complete.copyWith(), same(complete));
  });

  testWidgets('exact fields, keys, visible status copy, and semantics render',
      (tester) async {
    final harnessKey = GlobalKey<_ProblemEditorHarnessState>();
    await tester.pumpWidget(_buildEditorApp(harnessKey));
    await tester.pump();

    expect(
      find.byKey(const ValueKey('wizard-problem-editor')),
      findsOneWidget,
    );
    expect(find.text('Probleemi põhikirjeldus'), findsOneWidget);
    expect(find.text('* nõutav'), findsOneWidget);
    expect(find.text('Millal probleem ilmneb?'), findsOneWidget);
    expect(find.text('Nähtavad või kuuldavad sümptomid'), findsOneWidget);
    expect(find.text('Mida on juba proovitud?'), findsOneWidget);
    expect(find.text('valikuline'), findsNWidgets(3));
    expect(find.text('Esinemine'), findsOneWidget);
    expect(find.text('Pidev'), findsOneWidget);
    expect(find.text('Vahelduv'), findsOneWidget);
    expect(find.text('Teadmata'), findsOneWidget);

    for (final key in const <String>[
      'wizard-problem-description',
      'wizard-problem-when',
      'wizard-problem-symptoms',
      'wizard-problem-attempts',
      'wizard-problem-occurrence-continuous',
      'wizard-problem-occurrence-intermittent',
      'wizard-problem-occurrence-unknown',
      'wizard-problem-boundary-note',
    ]) {
      expect(find.byKey(ValueKey<String>(key)), findsOneWidget);
    }

    expect(
      find.bySemanticsLabel('Probleemi kirjelduse redaktor'),
      findsOneWidget,
    );
    expect(
      find.bySemanticsLabel('Probleemi põhikirjeldus, nõutav'),
      findsOneWidget,
    );
    expect(
      find.bySemanticsLabel('Esinemine'),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('wizard-problem-occurrence-grid')),
      findsOneWidget,
    );
    for (final label in const <String>[
      'Esinemine: Pidev',
      'Esinemine: Vahelduv',
      'Esinemine: Teadmata',
      'Millal probleem ilmneb?, valikuline',
      'Nähtavad või kuuldavad sümptomid, valikuline',
      'Mida on juba proovitud?, valikuline',
    ]) {
      expect(find.bySemanticsLabel(label), findsOneWidget);
    }
    expect(
      tester
          .widget<Semantics>(
            find.byKey(const ValueKey('wizard-problem-boundary-note')),
          )
          .properties
          .label,
      'Sisesta ainult enda teada olevaid tähelepanekuid. '
      'See redaktor ei diagnoosi põhjust ega tuvasta komponente või '
      'elektrilisi seoseid. Andmed jäävad ainult selle Wizardi lokaalsesse '
      'mustandisse.',
    );
    expect(find.text('Diagnoos'), findsNothing);
    expect(find.text('Salvesta'), findsNothing);
    expect(find.text('Loo projekt'), findsNothing);
  });

  testWidgets('raw multiline and whitespace-only text are preserved',
      (tester) async {
    final harnessKey = GlobalKey<_ProblemEditorHarnessState>();
    await tester.pumpWidget(_buildEditorApp(harnessKey));
    await tester.pump();

    const rawDescription = '  Katkeb\nvahel.  ';
    await tester.enterText(
      find.byKey(const ValueKey('wizard-problem-description')),
      rawDescription,
    );
    await tester.pump();
    expect(harnessKey.currentState!.value.description, rawDescription);
    expect(
        harnessKey.currentState!.emissions.single.description, rawDescription);

    const whitespaceOnly = '  \n  ';
    await tester.enterText(
      find.byKey(const ValueKey('wizard-problem-description')),
      whitespaceOnly,
    );
    await tester.pump();
    expect(harnessKey.currentState!.value.description, whitespaceOnly);
    expect(harnessKey.currentState!.emissions.last.description, whitespaceOnly);
  });

  testWidgets('each effective edit emits one complete isolated draft',
      (tester) async {
    final harnessKey = GlobalKey<_ProblemEditorHarnessState>();
    await tester.pumpWidget(_buildEditorApp(harnessKey));
    await tester.pump();

    await tester.enterText(
      find.byKey(const ValueKey('wizard-problem-description')),
      'Ei käivitu',
    );
    await tester.pump();
    expect(harnessKey.currentState!.emissions, hasLength(1));

    await tester.enterText(
      find.byKey(const ValueKey('wizard-problem-when')),
      'Külmalt',
    );
    await tester.pump();
    expect(harnessKey.currentState!.emissions, hasLength(2));
    expect(harnessKey.currentState!.value.description, 'Ei käivitu');

    await tester.enterText(
      find.byKey(const ValueKey('wizard-problem-symptoms')),
      'LED vilgub',
    );
    await tester.pump();
    expect(harnessKey.currentState!.emissions, hasLength(3));

    await tester.enterText(
      find.byKey(const ValueKey('wizard-problem-attempts')),
      'Kaabel vahetatud',
    );
    await tester.pump();
    expect(harnessKey.currentState!.emissions, hasLength(4));

    await _tapKey(tester, 'wizard-problem-occurrence-continuous');
    expect(harnessKey.currentState!.emissions, hasLength(5));
    expect(
      harnessKey.currentState!.value,
      const NewProjectWizardProblemDescriptionDraft(
        description: 'Ei käivitu',
        occurrence: NewProjectWizardProblemOccurrence.continuous,
        whenOccurs: 'Külmalt',
        symptoms: 'LED vilgub',
        attempts: 'Kaabel vahetatud',
      ),
    );
  });

  testWidgets('identical text and repeated occurrence emit no mutation',
      (tester) async {
    final harnessKey = GlobalKey<_ProblemEditorHarnessState>();
    const initial = NewProjectWizardProblemDescriptionDraft(
      description: 'Ei käivitu',
    );
    await tester.pumpWidget(
      _buildEditorApp(harnessKey, initialValue: initial),
    );
    await tester.pump();

    final description = tester.widget<TextField>(
      find.byKey(const ValueKey('wizard-problem-description')),
    );
    description.onChanged!('Ei käivitu');
    await tester.pump();
    await _tapKey(tester, 'wizard-problem-occurrence-unknown');

    expect(harnessKey.currentState!.emissions, isEmpty);
    expect(harnessKey.currentState!.value, initial);
  });

  testWidgets('external values synchronize without callbacks', (tester) async {
    final harnessKey = GlobalKey<_ProblemEditorHarnessState>();
    await tester.pumpWidget(_buildEditorApp(harnessKey));
    await tester.pump();

    harnessKey.currentState!.setExternal(
      const NewProjectWizardProblemDescriptionDraft(
        description: 'Väline kirjeldus',
        occurrence: NewProjectWizardProblemOccurrence.intermittent,
        whenOccurs: 'Koormuse all',
        symptoms: 'Sumin',
        attempts: 'Pistik puhastatud',
      ),
    );
    await tester.pump();

    expect(
      _controller(tester, 'wizard-problem-description').text,
      'Väline kirjeldus',
    );
    expect(_controller(tester, 'wizard-problem-when').text, 'Koormuse all');
    expect(_controller(tester, 'wizard-problem-symptoms').text, 'Sumin');
    expect(
      _controller(tester, 'wizard-problem-attempts').text,
      'Pistik puhastatud',
    );
    expect(harnessKey.currentState!.emissions, isEmpty);
    expect(
      tester
          .widget<ChoiceChip>(
            find.byKey(
              const ValueKey('wizard-problem-occurrence-intermittent'),
            ),
          )
          .selected,
      isTrue,
    );
  });

  testWidgets(
      'same-value parent update preserves selection and emits no callback',
      (tester) async {
    final harnessKey = GlobalKey<_ProblemEditorHarnessState>();
    const initial = NewProjectWizardProblemDescriptionDraft(
      description: 'abcdef',
    );
    await tester.pumpWidget(
      _buildEditorApp(harnessKey, initialValue: initial),
    );
    await tester.pump();

    final controller = _controller(tester, 'wizard-problem-description');
    controller.selection = const TextSelection(baseOffset: 2, extentOffset: 5);
    harnessKey.currentState!.setExternal(initial.copyWith());
    await tester.pump();

    expect(
      _controller(tester, 'wizard-problem-description').selection,
      const TextSelection(baseOffset: 2, extentOffset: 5),
    );
    expect(harnessKey.currentState!.emissions, isEmpty);
  });

  testWidgets('all three occurrence choices work and preserve text',
      (tester) async {
    final harnessKey = GlobalKey<_ProblemEditorHarnessState>();
    const initial = NewProjectWizardProblemDescriptionDraft(
      description: 'Katkeb',
    );
    await tester.pumpWidget(
      _buildEditorApp(harnessKey, initialValue: initial),
    );
    await tester.pump();

    await _tapKey(tester, 'wizard-problem-occurrence-continuous');
    expect(
      harnessKey.currentState!.value.occurrence,
      NewProjectWizardProblemOccurrence.continuous,
    );
    await _tapKey(tester, 'wizard-problem-occurrence-intermittent');
    expect(
      harnessKey.currentState!.value.occurrence,
      NewProjectWizardProblemOccurrence.intermittent,
    );
    await _tapKey(tester, 'wizard-problem-occurrence-unknown');
    expect(
      harnessKey.currentState!.value.occurrence,
      NewProjectWizardProblemOccurrence.unknown,
    );
    expect(harnessKey.currentState!.value.description, 'Katkeb');
    expect(harnessKey.currentState!.emissions, hasLength(3));
  });

  testWidgets('keyboard reaches occurrence choices and activates once',
      (tester) async {
    final harnessKey = GlobalKey<_ProblemEditorHarnessState>();
    await tester.pumpWidget(_buildEditorApp(harnessKey));
    await tester.pump();

    final continuous = find.byKey(
      const ValueKey('wizard-problem-occurrence-continuous'),
    );
    for (var index = 0;
        index < 12 && !_focusIsWithin(tester, continuous);
        index += 1) {
      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.pump();
    }
    expect(_focusIsWithin(tester, continuous), isTrue);
    await tester.sendKeyEvent(LogicalKeyboardKey.space);
    await tester.pump();

    expect(
      harnessKey.currentState!.value.occurrence,
      NewProjectWizardProblemOccurrence.continuous,
    );
    expect(harnessKey.currentState!.emissions, hasLength(1));
    expect(
      tester
          .getSemantics(
            find.bySemanticsLabel('Esinemine: Pidev'),
          )
          .getSemanticsData()
          .flagsCollection
          .isSelected,
      Tristate.isTrue,
    );
  });

  testWidgets('wide and compact layouts stay operable without dependencies',
      (tester) async {
    final harnessKey = GlobalKey<_ProblemEditorHarnessState>();
    addTearDown(() => tester.binding.setSurfaceSize(null));
    for (final size in const <Size>[
      Size(390, 760),
      Size(519, 800),
      Size(559, 800),
      Size(599, 800),
      Size(779, 800),
      Size(819, 800),
      Size(1049, 800),
      Size(1440, 900),
    ]) {
      await tester.binding.setSurfaceSize(size);
      await tester.pumpWidget(
        _buildEditorApp(
          harnessKey,
          compact: size.width < 820,
          textScale: size.width == 390 ? 2 : 1,
        ),
      );
      await tester.pump();

      expect(
        find.byKey(
          ValueKey<String>(
            size.width < 820
                ? 'wizard-problem-compact-layout'
                : 'wizard-problem-wide-layout',
          ),
        ),
        findsOneWidget,
      );
      expect(
        find.byKey(const ValueKey('wizard-problem-boundary-note')),
        findsOneWidget,
      );
      expect(
        find.textContaining('ainult enda teada olevaid tähelepanekuid'),
        findsOneWidget,
      );
      expect(find.text('Mida on juba proovitud?'), findsOneWidget);
      expect(tester.takeException(), isNull, reason: 'viewport $size');
    }
  });
}
