import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:trace_bench_viewer/app/app.dart';
import 'package:trace_bench_viewer/features/measure_sheet/screens/measure_sheet_screen.dart';
import 'package:trace_bench_viewer/features/measure_sheet/services/v2_save_measurement_writer.dart';
import 'package:trace_bench_viewer/shared/models/known_facts.dart';
import 'package:trace_bench_viewer/shared/models/project_manifest.dart';
import 'package:trace_bench_viewer/shared/models/project_state.dart';
import 'package:trace_bench_viewer/shared/models/trace_bench_event.dart';

ProjectState _inlineProjectState({
  String? projectDirectory,
  List<Map<String, dynamic>>? components,
  List<Map<String, dynamic>>? pins,
  List<Map<String, dynamic>>? measurements,
}) {
  final componentsJson = components ??
      const [
        {'component_id': 'Q2', 'status': 'identified', 'designator': 'Q2'},
      ];
  final pinsJson = pins ??
      const [
        {'component_id': 'Q2', 'pin_id': 'Q2.1'},
      ];
  final measurementsJson = measurements ??
      const [
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
      ];

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
      'components': componentsJson,
      'pins': pinsJson,
      'measurements': measurementsJson,
      'component_pin_index': _buildComponentPinIndex(
        componentsJson: componentsJson,
        pinsJson: pinsJson,
      ),
    }),
    events: const [],
    customerReport: 'Inline sample report',
    projectDirectory: projectDirectory,
  );
}

Map<String, List<String>> _buildComponentPinIndex({
  required List<Map<String, dynamic>> componentsJson,
  required List<Map<String, dynamic>> pinsJson,
}) {
  final index = <String, Set<String>>{};
  final componentIds = {
    for (final component in componentsJson)
      component['component_id']?.toString() ?? '',
  };
  for (final pin in pinsJson) {
    final componentId = pin['component_id']?.toString();
    final pinId = pin['pin_id']?.toString();
    if (componentId == null ||
        componentId.isEmpty ||
        pinId == null ||
        pinId.isEmpty ||
        !componentIds.contains(componentId)) {
      continue;
    }
    (index[componentId] ??= <String>{}).add(pinId);
  }
  return {
    for (final entry in index.entries)
      entry.key: entry.value.toList(growable: false),
  };
}

class _FakeSaveMeasurementWriter implements V2SaveMeasurementWriter {
  _FakeSaveMeasurementWriter({
    this.failure,
    this.status = V2SaveMeasurementWriteStatus.appended,
    this.eventId = 'evt_000010',
  });

  final V2SaveMeasurementException? failure;
  final V2SaveMeasurementWriteStatus status;
  final String eventId;
  final List<V2SaveMeasurementRequest> requests = <V2SaveMeasurementRequest>[];

  int get calls => requests.length;

  @override
  Future<V2SaveMeasurementResult> saveMeasurement({
    required ProjectState projectState,
    required V2SaveMeasurementRequest request,
  }) async {
    requests.add(request);
    if (failure != null) {
      throw failure!;
    }
    return V2SaveMeasurementResult(
      status: status,
      event: <String, dynamic>{
        'schema_version': '2.0-draft',
        'event_id': eventId,
        'event_type': 'measurement_recorded',
        'created_at': '2026-06-08T10:00:00Z',
        'project_id': projectState.manifest.projectId,
        'client_operation_id': request.clientOperationId,
        'actor': const {'type': 'human'},
        'source': const {'type': 'explicit_user_confirmation'},
        'confirmation': const {'confirmed': true},
        'payload': {
          'measurement_id': 'M10',
          'measured_at': '2026-06-08T10:00:00Z',
          'target': {
            'target_kind': 'component_pin',
            'target_key': request.targetKey,
            'display_label': request.displayLabel,
            'component_id': request.componentId,
            'pin_id': request.pinId,
          },
          'reading': {
            'mode': request.mode,
            'value': request.value,
            'unit': request.schemaUnit,
            'display_value': request.displayValue,
          },
          'value_provenance': {
            'measured_value_source': request.valueProvenance,
          },
        },
      },
      appended: status == V2SaveMeasurementWriteStatus.appended,
    );
  }
}

Widget _harness(
  ProjectState? projectState, {
  V2SaveMeasurementWriter? writer,
}) {
  return ProviderScope(
    overrides: [
      projectStateProvider.overrideWith((_) => projectState),
      if (writer != null)
        v2SaveMeasurementWriterProvider.overrideWithValue(writer),
    ],
    child: const MaterialApp(home: MeasureSheetScreen()),
  );
}

Future<void> _enterSaveMeasurement(
  WidgetTester tester, {
  String value = '1.23',
  String unit = 'V',
}) async {
  await tester.enterText(
    find.byKey(const ValueKey('measure-sheet-value-field')),
    value,
  );
  await tester
      .ensureVisible(find.byKey(const ValueKey('measure-sheet-unit-dropdown')));
  await tester.tap(find.byKey(const ValueKey('measure-sheet-unit-dropdown')));
  await tester.pumpAndSettle();
  await tester.tap(find.text(unit).last);
  await tester.pump();
}

Future<void> _selectMeasurementTarget(
  WidgetTester tester,
  String menuLabel, {
  bool warnIfMissed = true,
}) async {
  final dropdown = find.byKey(const ValueKey('measure-sheet-target-dropdown'));
  await tester.ensureVisible(dropdown);
  await tester.tap(dropdown, warnIfMissed: warnIfMissed);
  await tester.pumpAndSettle();
  await tester.tap(find.text(menuLabel).last);
  await tester.pumpAndSettle();
}

Future<void> _tapSaveMeasurement(
  WidgetTester tester, {
  bool warnIfMissed = true,
}) async {
  final finder = find.byKey(const ValueKey('measure-sheet-save-button'));
  await tester.ensureVisible(finder);
  await tester.tap(finder, warnIfMissed: warnIfMissed);
}

void main() {
  testWidgets('renders technician-first read-only flow labels', (tester) async {
    await tester.pumpWidget(_harness(_inlineProjectState()));
    await tester.pump(const Duration(milliseconds: 16));

    expect(find.text('Measure Sheet'), findsOneWidget);
    expect(find.text('Technician-first Measure Sheet'), findsOneWidget);
    expect(find.text('Koht → Väärtus → Ühik → Salvesta'), findsOneWidget);
    expect(find.text('Koht'), findsOneWidget);
    expect(find.text('Väärtus'), findsOneWidget);
    expect(find.text('Ühik'), findsAtLeastNWidgets(1));
    expect(find.text('Vali mõõtmise koht'), findsAtLeastNWidgets(1));
    expect(find.text('1 ohm'), findsAtLeastNWidgets(1));
    expect(find.text('Human is the sensor. AI is the graph engine.'),
        findsOneWidget);
    expect(find.text('renderer writes: none'), findsOneWidget);
    expect(
      find.text('Save Measurement writes only after explicit human action.'),
      findsOneWidget,
    );
    expect(find.text('Tehnilised detailid'), findsOneWidget);
  });

  testWidgets('shows measure-sheet-unit-dropdown as the only unit UI affordance',
      (tester) async {
    await tester.pumpWidget(_harness(_inlineProjectState()));
    await tester.pump(const Duration(milliseconds: 16));

    final unitDropdown = find.byKey(const ValueKey('measure-sheet-unit-dropdown'));
    expect(unitDropdown, findsOneWidget);
    expect(find.text('Ühik'), findsOneWidget);

    expect(find.widgetWithText(Chip, 'V'), findsNothing);
    expect(find.widgetWithText(Chip, 'Ω'), findsNothing);
    expect(find.widgetWithText(Chip, 'Diode'), findsNothing);
    expect(find.widgetWithText(Chip, 'Beep'), findsNothing);
  });

  testWidgets('selected unit is shown in dropdown before save', (tester) async {
    await tester.pumpWidget(_harness(_inlineProjectState()));
    await tester.pump(const Duration(milliseconds: 16));

    await _enterSaveMeasurement(tester, unit: 'Diode');

    final unitDropdown = find.byKey(const ValueKey('measure-sheet-unit-dropdown'));
    expect(
      find.descendant(
        of: unitDropdown,
        matching: find.text('Diode'),
      ),
      findsOneWidget,
    );

    final saveButton = tester.widget<ElevatedButton>(
      find.byKey(const ValueKey('measure-sheet-save-button')),
    );
    expect(saveButton.onPressed, isNull);
  });

  testWidgets('save affordance starts disabled before human entry',
      (tester) async {
    await tester.pumpWidget(_harness(_inlineProjectState()));
    await tester.pump(const Duration(milliseconds: 16));

    final button = tester.widget<ElevatedButton>(
      find.byKey(const ValueKey('measure-sheet-save-button')),
    );
    expect(button.onPressed, isNull);
    expect(find.text('Salvesta mõõtmine'), findsOneWidget);
  });

  testWidgets(
    'save button remains disabled without explicit target, even with value and unit',
    (tester) async {
      final writer = _FakeSaveMeasurementWriter();
      await tester.pumpWidget(_harness(_inlineProjectState(), writer: writer));
      await tester.pump(const Duration(milliseconds: 16));

      final initialButton = tester.widget<ElevatedButton>(
        find.byKey(const ValueKey('measure-sheet-save-button')),
      );
      expect(initialButton.onPressed, isNull);

      await tester.enterText(
        find.byKey(const ValueKey('measure-sheet-value-field')),
        '1.23',
      );
      await tester.pump();

      final valueOnlyButton = tester.widget<ElevatedButton>(
        find.byKey(const ValueKey('measure-sheet-save-button')),
      );
      expect(valueOnlyButton.onPressed, isNull);

      await tester.ensureVisible(
        find.byKey(const ValueKey('measure-sheet-unit-dropdown')),
      );
      await tester
          .tap(find.byKey(const ValueKey('measure-sheet-unit-dropdown')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('V').last);
      await tester.pump();

      final enabledButton = tester.widget<ElevatedButton>(
        find.byKey(const ValueKey('measure-sheet-save-button')),
      );
      expect(enabledButton.onPressed, isNull);

      await _selectMeasurementTarget(tester, 'Komponent: Q2');
      await tester.pump();

      final enabledAfterTarget = tester.widget<ElevatedButton>(
        find.byKey(const ValueKey('measure-sheet-save-button')),
      );
      expect(enabledAfterTarget.onPressed, isNotNull);
    },
  );

  testWidgets(
    'save target must be explicitly selected before writer call',
    (tester) async {
      final writer = _FakeSaveMeasurementWriter();
      await tester.pumpWidget(_harness(_inlineProjectState(), writer: writer));
      await tester.pump(const Duration(milliseconds: 16));

      await _enterSaveMeasurement(tester);
      await _tapSaveMeasurement(tester, warnIfMissed: false);
      await tester.pump();

      expect(writer.calls, 0);

      await _selectMeasurementTarget(tester, 'Komponent: Q2');
      await _tapSaveMeasurement(tester);
      await tester.pumpAndSettle();

      expect(writer.calls, 1);
      expect(writer.requests.single.targetKey, 'Q2');
      expect(writer.requests.single.displayLabel, 'Q2');
      expect(writer.requests.single.componentId, 'Q2');
      expect(writer.requests.single.pinId, isNull);
    },
  );

  testWidgets(
    'selecting a pin target saves selected pin metadata in the writer request',
    (tester) async {
      final writer = _FakeSaveMeasurementWriter();
      await tester.pumpWidget(_harness(_inlineProjectState(), writer: writer));
      await tester.pump(const Duration(milliseconds: 16));

      await _enterSaveMeasurement(tester);
      await _selectMeasurementTarget(tester, 'Piin: Q2 · Q2.1');
      await _tapSaveMeasurement(tester);
      await tester.pumpAndSettle();

      expect(writer.calls, 1);
      expect(writer.requests.single.targetKey, 'Q2.1');
      expect(writer.requests.single.displayLabel, 'Q2 · Q2.1');
      expect(writer.requests.single.componentId, 'Q2');
      expect(writer.requests.single.pinId, 'Q2.1');
    },
  );

  testWidgets(
    'no components/pins shows explicit no-target guidance and keeps save disabled',
    (tester) async {
      await tester.pumpWidget(
        _harness(
          _inlineProjectState(
            components: const [],
            pins: const [],
            measurements: const [],
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 16));

      expect(
        find.text(
          'Komponente või jalgusid pole saadaval. Vali mõõtmise koht enne salvestamist.',
        ),
        findsOneWidget,
      );
      expect(find.text('Vali mõõtmise koht'), findsAtLeastNWidgets(1));
      expect(find.byKey(const ValueKey('measure-sheet-target-dropdown')),
          findsNothing);

      await tester.enterText(
        find.byKey(const ValueKey('measure-sheet-value-field')),
        '1.23',
      );
      await tester.pump();
      await tester.ensureVisible(find.byKey(const ValueKey('measure-sheet-unit-dropdown')));
      await tester.tap(find.byKey(const ValueKey('measure-sheet-unit-dropdown')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('V').last);
      await tester.pump();

      final disabledButton = tester.widget<ElevatedButton>(
        find.byKey(const ValueKey('measure-sheet-save-button')),
      );
      expect(disabledButton.onPressed, isNull);
    },
  );

  testWidgets(
    'helper reference and candidate values do not auto-fill measured value',
    (tester) async {
      await tester.pumpWidget(_harness(_inlineProjectState()));
      await tester.pump(const Duration(milliseconds: 16));

      final valueField = tester.widget<TextField>(
        find.byKey(const ValueKey('measure-sheet-value-field')),
      );
      expect(valueField.controller?.text, isEmpty);
      expect(find.text('1 ohm'), findsAtLeastNWidgets(1));

      final button = tester.widget<ElevatedButton>(
        find.byKey(const ValueKey('measure-sheet-save-button')),
      );
      expect(button.onPressed, isNull);
      expect(find.textContaining('Kasuta viidet'), findsNothing);
      expect(find.textContaining('Kasuta kandidaati'), findsNothing);
      expect(find.textContaining('Use reference'), findsNothing);
      expect(find.textContaining('Use candidate'), findsNothing);
    },
  );

testWidgets('valid Save Measurement calls writer once and keeps Koht',
      (tester) async {
    final writer = _FakeSaveMeasurementWriter();
    await tester.pumpWidget(_harness(_inlineProjectState(), writer: writer));
    await tester.pump(const Duration(milliseconds: 16));

    await _selectMeasurementTarget(tester, 'Komponent: Q2');
    await _enterSaveMeasurement(tester);

    await _tapSaveMeasurement(tester);
    await tester.pumpAndSettle();

    expect(writer.calls, 1);
    expect(writer.requests.single.eventType, 'measurement_recorded');
    expect(writer.requests.single.actorType, 'human');
    expect(writer.requests.single.sourceType, 'explicit_user_confirmation');
    expect(writer.requests.single.confirmed, isTrue);
    expect(writer.requests.single.valueProvenance, 'human_entered');
    expect(writer.requests.single.displayLabel, 'Q2');
    expect(writer.requests.single.componentId, 'Q2');
    expect(writer.requests.single.pinId, isNull);
    expect(find.text('Salvestatud.'), findsOneWidget);
    expect(find.text('Projection stale until refresh.'), findsOneWidget);
    expect(find.text('Q2'), findsAtLeastNWidgets(1));
  });

testWidgets('rapid double tap does not duplicate writer calls',
      (tester) async {
    final writer = _FakeSaveMeasurementWriter();
    await tester.pumpWidget(_harness(_inlineProjectState(), writer: writer));
    await tester.pump(const Duration(milliseconds: 16));

    await _selectMeasurementTarget(tester, 'Piin: Q2 · Q2.1');
    await _enterSaveMeasurement(tester);

    await _tapSaveMeasurement(tester);
    await _tapSaveMeasurement(tester, warnIfMissed: false);
    await tester.pumpAndSettle();

    expect(writer.calls, 1);
  });

  testWidgets('writer validation failure shows not saved', (tester) async {
    final writer = _FakeSaveMeasurementWriter(
      failure: const V2SaveMeasurementException(
        V2SaveMeasurementFailureKind.validation,
        'candidate event failed validation',
      ),
    );
    await tester.pumpWidget(_harness(_inlineProjectState(), writer: writer));
    await tester.pump(const Duration(milliseconds: 16));

    await _selectMeasurementTarget(tester, 'Piin: Q2 · Q2.1');
    await _enterSaveMeasurement(tester);
    await _tapSaveMeasurement(tester);
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('measure-sheet-error-message')),
        findsOneWidget);
    expect(find.textContaining('Not saved: validation failed'), findsOneWidget);
    expect(find.text('Saved to events.jsonl'), findsNothing);
  });

  testWidgets('writer append failure shows not saved', (tester) async {
    final writer = _FakeSaveMeasurementWriter(
      failure: const V2SaveMeasurementException(
        V2SaveMeasurementFailureKind.append,
        'failed to append event',
      ),
    );
    await tester.pumpWidget(_harness(_inlineProjectState(), writer: writer));
    await tester.pump(const Duration(milliseconds: 16));

    await _selectMeasurementTarget(tester, 'Piin: Q2 · Q2.1');
    await _enterSaveMeasurement(tester);
    await _tapSaveMeasurement(tester);
    await tester.pumpAndSettle();

    expect(
        find.textContaining('Not saved: writer append failed'), findsOneWidget);
    expect(find.text('Saved to events.jsonl'), findsNothing);
  });

  testWidgets('invalid project directory failure shows not saved',
      (tester) async {
    final writer = _FakeSaveMeasurementWriter(
      failure: const V2SaveMeasurementException(
        V2SaveMeasurementFailureKind.invalidProjectDirectory,
        'Project directory path must be an absolute local path.',
      ),
    );
    await tester.pumpWidget(_harness(_inlineProjectState(), writer: writer));
    await tester.pump(const Duration(milliseconds: 16));

    await _selectMeasurementTarget(tester, 'Piin: Q2 · Q2.1');
    await _enterSaveMeasurement(tester);
    await _tapSaveMeasurement(tester);
    await tester.pumpAndSettle();

    expect(
      find.textContaining('Not saved: project path is invalid'),
      findsOneWidget,
    );
    expect(find.text('Saved to events.jsonl'), findsNothing);
  });

  testWidgets('lock conflict shows retryable not-saved error', (tester) async {
    final writer = _FakeSaveMeasurementWriter(
      failure: const V2SaveMeasurementException(
        V2SaveMeasurementFailureKind.lockConflict,
        'event writer lock is already held',
      ),
    );
    await tester.pumpWidget(_harness(_inlineProjectState(), writer: writer));
    await tester.pump(const Duration(milliseconds: 16));

    await _selectMeasurementTarget(tester, 'Komponent: Q2');
    await _enterSaveMeasurement(tester);
    await _tapSaveMeasurement(tester);
    await tester.pumpAndSettle();

    expect(find.textContaining('Not saved: writer is busy, retry'),
        findsOneWidget);
    expect(find.text('Saved to events.jsonl'), findsNothing);
  });

  testWidgets('idempotent duplicate retry reports existing and no duplicate',
      (tester) async {
    final writer = _FakeSaveMeasurementWriter();
    await tester.pumpWidget(_harness(_inlineProjectState(), writer: writer));
    await tester.pump(const Duration(milliseconds: 16));

    await _selectMeasurementTarget(tester, 'Komponent: Q2');
    await _enterSaveMeasurement(tester);
    await _tapSaveMeasurement(tester);
    await tester.pumpAndSettle();

    final disabledAfterSuccess = tester.widget<ElevatedButton>(
      find.byKey(const ValueKey('measure-sheet-save-button')),
    );
    expect(disabledAfterSuccess.onPressed, isNull);

    await _tapSaveMeasurement(tester, warnIfMissed: false);
    await tester.pumpAndSettle();

    expect(writer.calls, 1);
  });

  testWidgets('existing writer result does not duplicate local events',
      (tester) async {
    const clientOperationId = 'measure_sheet_Q2_voltage_V_1_23_human_entered';
    const existingEvent = TraceBenchEvent(
      schemaVersion: '2.0-draft',
      eventId: 'evt_000010',
      projectId: 'measure_sheet_project',
      sequence: 0,
      createdAt: '2026-06-08T10:00:00Z',
      actor: {'type': 'human'},
      eventType: 'measurement_recorded',
      status: 'accepted',
      payload: {
        'client_operation_id': clientOperationId,
        'measurement_id': 'M10',
      },
    );
    final projectState =
        _inlineProjectState().copyWith(events: const [existingEvent]);
    final writer = _FakeSaveMeasurementWriter(
      status: V2SaveMeasurementWriteStatus.existing,
      eventId: 'evt_000011',
    );
    final container = ProviderContainer(
      overrides: [
        projectStateProvider.overrideWith((_) => projectState),
        v2SaveMeasurementWriterProvider.overrideWithValue(writer),
      ],
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(home: MeasureSheetScreen()),
      ),
    );
    await tester.pump(const Duration(milliseconds: 16));

    await _selectMeasurementTarget(tester, 'Komponent: Q2');
    await _enterSaveMeasurement(tester);
    await _tapSaveMeasurement(tester);
    await tester.pumpAndSettle();

    final updatedState = container.read(projectStateProvider);
    expect(writer.requests.single.clientOperationId, clientOperationId);
    expect(updatedState?.events, hasLength(1));
    expect(updatedState?.events.single.eventId, 'evt_000010');
    expect(
      find.text('Salvestatud (idempotentne kordus).'),
      findsOneWidget,
    );
  });

  testWidgets('technical details disclose writer and event type',
      (tester) async {
    await tester.pumpWidget(_harness(_inlineProjectState()));
    await tester.pump(const Duration(milliseconds: 16));

    await tester.ensureVisible(find.text('Tehnilised detailid'));
    await tester.pump();
    await tester.tap(find.text('Tehnilised detailid'));
    await tester.pumpAndSettle();

    expect(
      find.text('Save uses the accepted V2 writer service.'),
      findsOneWidget,
    );
    expect(find.text('Event type: measurement_recorded'), findsOneWidget);
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
      expect(find.textContaining(text), findsNothing,
          reason: 'Unexpected copy: $text');
    }
  });

  testWidgets('recorded-reading status is neutral evidence copy',
      (tester) async {
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
      find.text(
          'Display only: reads the current projection and writes nothing.'),
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

    expect(
        find.textContaining('not promoted to measured values'), findsOneWidget);
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
      find.text(
          'Helper does not create canonical facts or change project data.'),
      findsOneWidget,
    );
  });

  testWidgets(
      'guided measurement helper avoids inference and write affordances',
      (tester) async {
    await tester.pumpWidget(_harness(_inlineProjectState()));
    await tester.pump(const Duration(milliseconds: 16));

    expect(
        find.text('suggestion only; technician must measure'), findsOneWidget);
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
      expect(find.textContaining(text), findsNothing,
          reason: 'Unexpected copy: $text');
    }
  });

  testWidgets('narrow layout keeps selected Koht context visible',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 720));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(_harness(_inlineProjectState()));
    await tester.pump(const Duration(milliseconds: 16));

    expect(find.text('Board context hidden on narrow width'), findsOneWidget);
    expect(find.text('Selected Koht: Vali mõõtmise koht'), findsOneWidget);
    expect(find.text('Koht → Väärtus → Ühik → Salvesta'), findsOneWidget);
  });

  testWidgets('shows no-project state when project is missing', (tester) async {
    await tester.pumpWidget(_harness(null));
    await tester.pump(const Duration(milliseconds: 16));

    expect(find.text('No project loaded'), findsOneWidget);
  });

  test('measure sheet source keeps V2 writer boundary', () {
    final source = File(
      'lib/features/measure_sheet/screens/measure_sheet_screen.dart',
    ).readAsStringSync();

    expect(source, isNot(contains('MeasurementEventWriter')));
    expect(source, isNot(contains('writeMeasurement')));
    expect(source, contains('v2SaveMeasurementWriterProvider'));
    expect(source, isNot(contains('ProjectExporter')));
    expect(source, isNot(contains('ProjectCreator')));
    expect(source, isNot(contains('jsonDecode')));
    expect(source, isNot(contains('writeAsString')));
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
    expect(source, isNot(contains('\"sequence\"')));
    expect(source, isNot(contains('event-writing')));
    expect(source, isNot(contains('persistence')));
  });
}
