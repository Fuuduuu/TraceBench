import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:trace_bench_viewer/app/app.dart';
import 'package:trace_bench_viewer/features/measure_sheet/screens/measure_sheet_screen.dart';
import 'package:trace_bench_viewer/shared/models/known_facts.dart';
import 'package:trace_bench_viewer/shared/models/project_manifest.dart';
import 'package:trace_bench_viewer/shared/models/project_state.dart';

ProjectState _inlineProjectState() {
  return ProjectState(
    manifest: ProjectManifest.fromJson({
      'project_id': 'measure_sheet_project',
      'schema_version': '1.0',
      'created_at': '2026-05-22T00:00:00Z',
      'device_type': 'bench_board',
      'model': 'PV20',
      'symptom': 'not_provided',
    }),
    knownFacts: KnownFacts.fromJson({
      'project_id': 'measure_sheet_project',
      'components': [
        {'component_id': 'Q2', 'status': 'identified', 'designator': 'Q2'},
      ],
      'pins': [
        {'component_id': 'Q2', 'pin_id': 'Q2.1'},
      ],
      'measurements': [
        {
          'measurement_id': 'M001',
          'mode': 'continuity',
          'from': 'Q2.1',
          'to': 'R17.1',
          'reading': {'kind': 'numeric', 'value': 1, 'unit': 'ohm'},
          'power_state': 'off',
          'origin_event_id': 'evt_000001',
          'validity_status': 'active',
        },
      ],
      'component_pin_index': {
        'Q2': ['Q2.1'],
      },
    }),
    events: const [],
    customerReport: 'Inline sample report',
  );
}

Widget _harness(ProjectState? projectState) {
  return ProviderScope(
    overrides: [
      projectStateProvider.overrideWith((_) => projectState),
    ],
    child: const MaterialApp(home: MeasureSheetScreen()),
  );
}

void main() {
  testWidgets('renders technician-first read-only flow labels', (tester) async {
    await tester.pumpWidget(_harness(_inlineProjectState()));
    await tester.pump(const Duration(milliseconds: 16));

    expect(find.text('Measure Sheet'), findsOneWidget);
    expect(find.text('Technician-first Measure Sheet'), findsOneWidget);
    expect(find.text('Koht -> Väärtus -> Ühik -> Salvesta'), findsOneWidget);
    expect(find.text('Koht'), findsOneWidget);
    expect(find.text('Väärtus'), findsOneWidget);
    expect(find.text('Ühik'), findsOneWidget);
    expect(find.text('Q2 · Q2.1'), findsAtLeastNWidgets(1));
    expect(find.text('1 ohm'), findsAtLeastNWidgets(1));
    expect(find.text('Human is the sensor. AI is the graph engine.'), findsOneWidget);
    expect(find.text('renderer writes: none'), findsOneWidget);
  });

  testWidgets('save-looking affordance is disabled and clearly non-writing',
      (tester) async {
    await tester.pumpWidget(_harness(_inlineProjectState()));
    await tester.pump(const Duration(milliseconds: 16));

    final button = tester.widget<ElevatedButton>(
      find.byKey(const ValueKey('measure-sheet-disabled-save-button')),
    );
    expect(button.onPressed, isNull);
    expect(find.text('Salvesta (välja lülitatud — ei kirjuta)'), findsOneWidget);
    expect(find.text('Näidisnupp on mitteaktiivne ja ei muuda projekti.'), findsOneWidget);
  });

  testWidgets('forbidden inference copy and write actions are absent',
      (tester) async {
    await tester.pumpWidget(_harness(_inlineProjectState()));
    await tester.pump(const Duration(milliseconds: 16));

    const forbiddenCopy = [
      'automaatne',
      'tuvastatud',
      'kinnitatud',
      'confirmed',
      'correct',
      'diagnosed',
      'korras',
      'verified',
      'good',
      'AI found',
      'app detected',
      'pin is good',
      'net confirmed',
      'component identified',
      'fault diagnosed',
      'fault probability',
    ];

    for (final text in forbiddenCopy) {
      expect(find.textContaining(text), findsNothing, reason: 'Unexpected copy: $text');
    }
  });

  testWidgets('recorded-reading status is neutral evidence copy', (tester) async {
    await tester.pumpWidget(_harness(_inlineProjectState()));
    await tester.pump(const Duration(milliseconds: 16));

    expect(find.text('lugem olemas'), findsOneWidget);
    expect(
      find.text('recorded reading marker means only that a reading exists.'),
      findsOneWidget,
    );
    expect(find.textContaining('verified'), findsNothing);
    expect(find.textContaining('good'), findsNothing);
  });

  testWidgets('reference values panel renders display-only categories',
      (tester) async {
    await tester.pumpWidget(_harness(_inlineProjectState()));
    await tester.pump(const Duration(milliseconds: 16));

    expect(find.text('Reference Values Panel'), findsOneWidget);
    expect(
      find.text('Display only: reads the current projection and writes nothing.'),
      findsOneWidget,
    );
    expect(find.text('Mõõdetud'), findsOneWidget);
    expect(find.text('1 ohm'), findsAtLeastNWidgets(1));
    expect(find.text('human reading, visually dominant'), findsOneWidget);
    expect(find.text('Viide / Allikas'), findsOneWidget);
    expect(find.text('viiteväärtus puudub'), findsOneWidget);
    expect(
      find.text('secondary context; not a measurement; non-canonical'),
      findsOneWidget,
    );
    expect(find.text('Kandidaat'), findsOneWidget);
    expect(find.text('kandidaati pole'), findsOneWidget);
    expect(find.text('tentative context only; not proof'), findsOneWidget);
    expect(find.text('Märkus'), findsOneWidget);
    expect(find.text('märkus puudub'), findsOneWidget);
    expect(find.text('context only; does not create facts'), findsOneWidget);
    expect(
      find.text(
        'Reference/source, candidate, and note rows are context only and are not promoted to measured values.',
      ),
      findsOneWidget,
    );
  });

  testWidgets('reference values panel keeps non-measured rows subordinate',
      (tester) async {
    await tester.pumpWidget(_harness(_inlineProjectState()));
    await tester.pump(const Duration(milliseconds: 16));

    expect(find.text('Mõõdetud'), findsOneWidget);
    expect(find.text('human reading, visually dominant'), findsOneWidget);
    expect(
      find.text('secondary context; not a measurement; non-canonical'),
      findsOneWidget,
    );
    expect(find.text('tentative context only; not proof'), findsOneWidget);
    expect(find.text('context only; does not create facts'), findsOneWidget);

    expect(find.textContaining('not promoted to measured values'), findsOneWidget);
    expect(find.textContaining('verified'), findsNothing);
    expect(find.textContaining('confirmed'), findsNothing);
    expect(find.textContaining('correct'), findsNothing);
    expect(find.textContaining('diagnosed'), findsNothing);
    expect(find.textContaining('fault probability'), findsNothing);
  });

  testWidgets('guided measurement helper renders read-only neutral prompts',
      (tester) async {
    await tester.pumpWidget(_harness(_inlineProjectState()));
    await tester.pump(const Duration(milliseconds: 16));

    expect(find.text('Guided Measurement Helper'), findsOneWidget);
    expect(
      find.text(
        'Read-only helper: suggests neutral next checks and writes nothing.',
      ),
      findsOneWidget,
    );
    expect(find.text('Human technician measures and decides.'), findsOneWidget);
    expect(
      find.text('Mõõda järgmisena Q2 · Q2.1 seotud ots või testpunkt.'),
      findsOneWidget,
    );
    expect(find.text('Lugem puudub? Mõõda enne järeldust.'), findsOneWidget);
    expect(
      find.text('Kaks lugemit erinevad? Kontrolli uuesti enne järeldust.'),
      findsOneWidget,
    );
    expect(
      find.text('Viide / Allikas on kontekst, mitte mõõtmine.'),
      findsOneWidget,
    );
    expect(
      find.text('Kandidaat on oletuslik kontekst, mitte tõend.'),
      findsOneWidget,
    );
    expect(
      find.text('Helper does not create canonical facts or change project data.'),
      findsOneWidget,
    );
  });

  testWidgets('guided measurement helper avoids inference and write affordances',
      (tester) async {
    await tester.pumpWidget(_harness(_inlineProjectState()));
    await tester.pump(const Duration(milliseconds: 16));

    expect(find.text('suggestion only; technician must measure'), findsOneWidget);
    expect(find.text('prompt only; no conclusion'), findsOneWidget);
    expect(find.text('surface the gap; technician decides'), findsOneWidget);
    expect(find.text('context only; not a project fact'), findsOneWidget);

    const forbiddenHelperCopy = [
      'Rike on',
      'Tõenäoline rike',
      'Kahtlusalune komponent',
      'Net on kinnitatud',
      'Komponent tuvastatud',
      'AI leidis',
      'Süsteem kinnitas',
      'Korras',
      'Verified',
      'Confirmed',
      'Correct',
      'Good',
      'Fault probability',
      'Confidence',
      'likely fault',
      'probable',
      'diagnosis',
    ];

    for (final text in forbiddenHelperCopy) {
      expect(find.textContaining(text), findsNothing, reason: 'Unexpected copy: $text');
    }
  });

  testWidgets('narrow layout keeps selected Koht context visible', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 720));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(_harness(_inlineProjectState()));
    await tester.pump(const Duration(milliseconds: 16));

    expect(find.text('Board context hidden on narrow width'), findsOneWidget);
    expect(find.text('Selected Koht: Q2 · Q2.1'), findsOneWidget);
    expect(find.text('Koht -> Väärtus -> Ühik -> Salvesta'), findsOneWidget);
  });

  testWidgets('shows no-project state when project is missing', (tester) async {
    await tester.pumpWidget(_harness(null));
    await tester.pump(const Duration(milliseconds: 16));

    expect(find.text('No project loaded'), findsOneWidget);
  });

  test('measure sheet source keeps read-only shell boundaries', () {
    final source = File(
      'lib/features/measure_sheet/screens/measure_sheet_screen.dart',
    ).readAsStringSync();

    expect(source, isNot(contains('MeasurementEventWriter')));
    expect(source, isNot(contains('writeMeasurement')));
    expect(source, isNot(contains('ProjectExporter')));
    expect(source, isNot(contains('ProjectCreator')));
    expect(source, isNot(contains('jsonDecode')));
    expect(source, isNot(contains('writeAsString')));
    expect(source, isNot(contains('events.jsonl')));
    expect(source, isNot(contains('known_facts.json')));
    expect(source, isNot(contains('board_graph.json')));
    expect(source, isNot(contains('view_state.json')));
    expect(source, isNot(contains('localStorage')));
    expect(source, isNot(contains('/project/measurements/new')));
    expect(source, isNot(contains('Add Component')));
    expect(source, isNot(contains('Edit Component')));
    expect(source, isNot(contains('Run AI')));
    expect(source, isNot(contains('Detect')));
    expect(source, isNot(contains('Upload')));
    expect(source, isNot(contains('fault probability')));
    expect(source, isNot(contains('confidence')));
    expect(source, isNot(contains('likely fault')));
    expect(source, isNot(contains('probable')));
    expect(source, isNot(contains('diagnosis')));
    expect(source, isNot(contains('Save Measurement')));
    expect(source, isNot(contains('event-writing')));
    expect(source, isNot(contains('persistence')));
  });
}
