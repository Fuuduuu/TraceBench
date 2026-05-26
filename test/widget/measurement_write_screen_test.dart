import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:trace_bench_viewer/app/app.dart';
import 'package:trace_bench_viewer/features/measurements/screens/measurement_record_screen.dart';
import 'package:trace_bench_viewer/shared/models/known_facts.dart';
import 'package:trace_bench_viewer/shared/models/project_manifest.dart';
import 'package:trace_bench_viewer/shared/models/project_state.dart';
import 'package:trace_bench_viewer/shared/services/project_loader.dart';

ProjectState _buildProjectState(Directory directory) {
  final manifestRaw =
      File('${directory.path}/manifest.json').readAsStringSync();
  final knownFactsRaw =
      File('${directory.path}/known_facts.json').readAsStringSync();
  final eventsRaw = File('${directory.path}/events.jsonl').readAsStringSync();
  final reportRaw =
      File('${directory.path}/exports/customer_report.md').readAsStringSync();

  return ProjectState(
    manifest: ProjectManifest.fromJson(jsonDecode(manifestRaw)),
    knownFacts: KnownFacts.fromJson(jsonDecode(knownFactsRaw)),
    events: ProjectLoader.parseEvents(eventsRaw),
    customerReport: reportRaw,
    projectDirectory: directory.path,
  );
}

Directory _createSampleProject(List<Directory> tracked) {
  final directory = Directory.systemTemp.createTempSync(
    'tracebench-measurement-widget-',
  );
  final exportsDir = Directory('${directory.path}/exports');
  exportsDir.createSync(recursive: true);

  File('assets/samples/pelle_pv20_minimal/manifest.json')
      .copySync('${directory.path}/manifest.json');
  File('assets/samples/pelle_pv20_minimal/known_facts.json')
      .copySync('${directory.path}/known_facts.json');
  File('assets/samples/pelle_pv20_minimal/events.jsonl')
      .copySync('${directory.path}/events.jsonl');
  File('assets/samples/pelle_pv20_minimal/exports/customer_report.md')
      .copySync('${directory.path}/exports/customer_report.md');

  tracked.add(directory);
  return directory;
}

int _measurementRecordedEventCount(Directory directory) {
  final eventsRaw = File('${directory.path}/events.jsonl').readAsStringSync();
  final events = ProjectLoader.parseEvents(eventsRaw);
  return events.where((event) => event.eventType == 'measurement_recorded').length;
}

Future<void> _fillValidMeasurementForm(
  WidgetTester tester, {
  String fromTarget = 'TP1',
  String toTarget = 'TP2',
  String value = '9.9',
}) async {
  await tester.enterText(
    find.byKey(const ValueKey('measurement-from-field')),
    fromTarget,
  );
  await tester.enterText(
    find.byKey(const ValueKey('measurement-to-field')),
    toTarget,
  );
  await tester.enterText(
    find.byKey(const ValueKey('measurement-value-field')),
    value,
  );
  await tester.tap(find.byKey(const ValueKey('measurement-unit-dropdown')));
  await tester.pumpAndSettle();
  await tester.tap(find.text('V').last);
  await tester.pump();
}

Future<void> _submitAndWait(WidgetTester tester) async {
  await tester.runAsync(() async {
    await tester.tap(find.byKey(const ValueKey('measurement-submit-button')));
    await Future.delayed(const Duration(seconds: 1));
  });
  await tester.pumpAndSettle();
}

void main() {
  final directories = <Directory>[];

  setUp(() {
    directories.clear();
  });

  tearDown(() {
    for (final directory in directories) {
      directory.deleteSync(recursive: true);
    }
  });

  testWidgets(
    'submit is disabled until manual value unit and target are present',
    (tester) async {
      final directory = _createSampleProject(directories);
      final projectState = _buildProjectState(directory);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [projectStateProvider.overrideWith((_) => projectState)],
          child: const MaterialApp(home: MeasurementRecordScreen()),
        ),
      );
      await tester.pump();

      final disabledButton = tester.widget<ElevatedButton>(
        find.byKey(const ValueKey('measurement-submit-button')),
      );
      expect(disabledButton.onPressed, isNull);

      await tester.enterText(
        find.byKey(const ValueKey('measurement-from-field')),
        'TP1',
      );
      await tester.enterText(
        find.byKey(const ValueKey('measurement-to-field')),
        'TP2',
      );
      await tester.enterText(
        find.byKey(const ValueKey('measurement-value-field')),
        '12.3',
      );
      final noUnitButton = tester.widget<ElevatedButton>(
        find.byKey(const ValueKey('measurement-submit-button')),
      );
      expect(noUnitButton.onPressed, isNull);

      await tester.tap(find.byKey(const ValueKey('measurement-unit-dropdown')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('V').last);
      await tester.pump();

      final enabledButton = tester.widget<ElevatedButton>(
        find.byKey(const ValueKey('measurement-submit-button')),
      );
      expect(enabledButton.onPressed, isNotNull);
    },
  );

  testWidgets('no camera/import/BLE controls are visible', (tester) async {
    final directory = _createSampleProject(directories);
    final projectState = _buildProjectState(directory);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [projectStateProvider.overrideWith((_) => projectState)],
        child: const MaterialApp(home: MeasurementRecordScreen()),
      ),
    );
    await tester.pump();

    expect(find.byType(TextField), findsWidgets);
    expect(find.text('Import Project ZIP'), findsNothing);
    expect(find.byIcon(Icons.camera_alt), findsNothing);
    expect(find.text('BLE'), findsNothing);
  });

  testWidgets(
    'shows success and stale refresh message after saving measurement',
    (tester) async {
      final directory = _createSampleProject(directories);
      final projectState = _buildProjectState(directory);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [projectStateProvider.overrideWith((_) => projectState)],
          child: const MaterialApp(home: MeasurementRecordScreen()),
        ),
      );
      await tester.pump();

      await _fillValidMeasurementForm(tester);
      final buttonAfterSelect = tester.widget<ElevatedButton>(
        find.byKey(const ValueKey('measurement-submit-button')),
      );
      expect(buttonAfterSelect.onPressed, isNotNull);

      await _submitAndWait(tester);

      final successFinder =
          find.byKey(const ValueKey('measurement-success-message'));
      final errorFinder =
          find.byKey(const ValueKey('measurement-error-message'));
      expect(successFinder.evaluate().isNotEmpty, isTrue);

      expect(
        find.text(
          'Measurement event saved. Known facts projection must be refreshed before derived views update.',
        ),
        findsOneWidget,
      );
    },
  );

  testWidgets('rapid double tap appends only one new measurement event',
      (tester) async {
    final directory = _createSampleProject(directories);
    final projectState = _buildProjectState(directory);
    final initialMeasurementEvents = _measurementRecordedEventCount(directory);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [projectStateProvider.overrideWith((_) => projectState)],
        child: const MaterialApp(home: MeasurementRecordScreen()),
      ),
    );
    await tester.pump();

    await _fillValidMeasurementForm(tester);

    await tester.runAsync(() async {
      await tester.tap(find.byKey(const ValueKey('measurement-submit-button')));
      await tester.tap(find.byKey(const ValueKey('measurement-submit-button')));
      await Future.delayed(const Duration(seconds: 1));
    });
    await tester.pumpAndSettle();

    expect(
      _measurementRecordedEventCount(directory),
      initialMeasurementEvents + 1,
    );
  });

  testWidgets('unchanged form cannot be submitted twice after success',
      (tester) async {
    final directory = _createSampleProject(directories);
    final projectState = _buildProjectState(directory);
    final initialMeasurementEvents = _measurementRecordedEventCount(directory);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [projectStateProvider.overrideWith((_) => projectState)],
        child: const MaterialApp(home: MeasurementRecordScreen()),
      ),
    );
    await tester.pump();

    await _fillValidMeasurementForm(tester);

    await _submitAndWait(tester);

    expect(
      _measurementRecordedEventCount(directory),
      initialMeasurementEvents + 1,
    );

    final disabledButtonAfterSuccess = tester.widget<ElevatedButton>(
      find.byKey(const ValueKey('measurement-submit-button')),
    );
    expect(disabledButtonAfterSuccess.onPressed, isNull);

    await tester.tap(
      find.byKey(const ValueKey('measurement-submit-button')),
      warnIfMissed: false,
    );
    await tester.pumpAndSettle();

    expect(
      _measurementRecordedEventCount(directory),
      initialMeasurementEvents + 1,
    );
  });

  testWidgets('editing form after success re-enables submit for one new event',
      (tester) async {
    final directory = _createSampleProject(directories);
    final projectState = _buildProjectState(directory);
    final initialMeasurementEvents = _measurementRecordedEventCount(directory);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [projectStateProvider.overrideWith((_) => projectState)],
        child: const MaterialApp(home: MeasurementRecordScreen()),
      ),
    );
    await tester.pump();

    await _fillValidMeasurementForm(tester, value: '9.9');

    await _submitAndWait(tester);

    expect(
      _measurementRecordedEventCount(directory),
      initialMeasurementEvents + 1,
    );

    final disabledButtonAfterSuccess = tester.widget<ElevatedButton>(
      find.byKey(const ValueKey('measurement-submit-button')),
    );
    expect(disabledButtonAfterSuccess.onPressed, isNull);

    await tester.enterText(
      find.byKey(const ValueKey('measurement-value-field')),
      '10.1',
    );
    await tester.pump();

    final reenabledButton = tester.widget<ElevatedButton>(
      find.byKey(const ValueKey('measurement-submit-button')),
    );
    expect(reenabledButton.onPressed, isNotNull);

    await _submitAndWait(tester);

    expect(
      _measurementRecordedEventCount(directory),
      initialMeasurementEvents + 2,
    );
  });
}
