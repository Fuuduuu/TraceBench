import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;
import 'package:trace_bench_viewer/app/router.dart';
import 'package:trace_bench_viewer/features/components/services/v2_add_component_writer.dart';
import 'package:trace_bench_viewer/features/components/services/v2_placement_writer.dart';
import 'package:trace_bench_viewer/features/measure_sheet/services/v2_save_measurement_writer.dart';
import 'package:trace_bench_viewer/shared/models/project_state.dart';
import 'package:trace_bench_viewer/shared/services/project_loader.dart';
import 'package:trace_bench_viewer/shared/services/project_projection_refresher.dart';
import 'package:trace_bench_viewer/shared/services/python_runner.dart';
import 'package:trace_bench_viewer/shared/widgets/workbench_projection_refresh.dart';
import 'package:trace_bench_viewer/shared/session/project_session.dart';
import 'package:trace_bench_viewer/shared/session/beginner_mode_provider.dart';

import '../helpers/seeded_project_session.dart';

Future<Directory> _copyProject() async {
  final temp = await Directory.systemTemp.createTemp('tracebench-refresh-e2e-');
  final source = Directory('assets/samples/board_canvas_positive_smoke');
  for (final entity in await source.list(recursive: true).toList()) {
    if (entity is! File) continue;
    final target =
        File(p.join(temp.path, p.relative(entity.path, from: source.path)));
    await target.parent.create(recursive: true);
    await entity.copy(target.path);
  }
  return temp;
}

Future<void> _clickRefresh(
  WidgetTester tester,
  ProviderContainer container,
  Directory project,
) async {
  final preserved = <String, List<int>>{};
  await tester.runAsync(() async {
    for (final entity in await project.list(recursive: true).toList()) {
      if (entity is File && p.basename(entity.path) != 'known_facts.json') {
        preserved[entity.path] = await entity.readAsBytes();
      }
    }
    await tester.tap(find.byKey(const Key('workbench-refresh-button')));
    final deadline = DateTime.now().add(const Duration(seconds: 25));
    while (container.read(projectStateProvider)!.isProjectionStale &&
        DateTime.now().isBefore(deadline)) {
      await Future<void>.delayed(const Duration(milliseconds: 30));
    }
  });
  await tester.pumpAndSettle();
  expect(container.read(projectStateProvider)!.projectionFreshness,
      ProjectionFreshness.fresh);
  expect(find.text('Värskenda andmeid'), findsNothing);
  await tester.runAsync(() async {
    for (final entry in preserved.entries) {
      expect(await File(entry.key).readAsBytes(), entry.value,
          reason: entry.key);
    }
    expect(
        await project
            .list(recursive: true)
            .where((e) => e.path.endsWith('.zip'))
            .toList(),
        isEmpty);
  });
}

// Only ordering is controlled. Discovery, materialization and the actual
// canonical append still run through the production process runner/writer.
class _CommandGate extends ProcessRunner {
  _CommandGate(this.script);

  final String script;
  final reached = Completer<void>();
  final release = Completer<void>();

  @override
  Future<ProcessResult> run({
    required List<String> command,
    required String workingDirectory,
    required Duration timeout,
  }) async {
    if (command.any((part) => part.endsWith(script)) && !reached.isCompleted) {
      reached.complete();
      await release.future;
    }
    return const DefaultProcessRunner().run(
      command: command,
      workingDirectory: workingDirectory,
      timeout: timeout,
    );
  }
}

void main() {
  testWidgets(
      'real writers -> explicit Workbench refresh -> visible component placement and measurement',
      (tester) async {
    final project = (await tester.runAsync(_copyProject))!;
    addTearDown(() async => project.delete(recursive: true));
    final initial = (await tester
        .runAsync(() => ProjectLoader.loadFromDirectory(project.path)))!;
    expect(initial.wizardIntake, isNull,
        reason: 'Non-Wizard projects remain supported');
    final container = ProviderContainer(overrides: [
      projectStateProvider.overrideWith(() => SeededProjectSession(initial)),
    ]);
    addTearDown(container.dispose);
    final session = container.read(projectStateProvider.notifier);
    final router = buildTraceBenchRouter(
        initialLocation: '/project/components',
        homeBuilder: (_) => const Scaffold(body: Text('Home')));
    addTearDown(router.dispose);
    await tester.pumpWidget(UncontrolledProviderScope(
      container: container,
      child: MaterialApp.router(routerConfig: router),
    ));
    await tester.pumpAndSettle();

    await tester.runAsync(() async {
      final result = await V2AddComponentService().addComponent(
        projectState: container.read(projectStateProvider)!,
        request: const V2AddComponentRequest(
          componentId: 'REFRESH_U10',
          label: 'Refresh U10',
          componentKind: 'unknown',
          referenceDesignator: 'U10',
          clientOperationId: 'refresh-e2e-add',
        ),
      );
      expect(
          session.applyCanonicalEvent(result.event,
              generation: session.generation),
          isTrue);
    });
    await tester.pumpAndSettle();
    expect(find.text('REFRESH_U10'), findsNothing);
    await _clickRefresh(tester, container, project);
    expect(find.text('REFRESH_U10'), findsOneWidget);
    expect(
        container
            .read(projectStateProvider)!
            .knownFacts
            .components
            .any((c) => c.componentId == 'REFRESH_U10'),
        isTrue);

    router.go('/project');
    await tester.pumpAndSettle();
    await tester.runAsync(() async {
      final result = await V2PlacementService().confirmPlacement(
        projectState: container.read(projectStateProvider)!,
        request: const V2PlacementWriterRequest(
          componentId: 'REFRESH_U10',
          coordinateSpace: 'board_normalized',
          boardSide: 'top',
          centerX: 0.42,
          centerY: 0.58,
          rotationDeg: 30,
          width: 0.12,
          height: 0.07,
          clientOperationId: 'refresh-e2e-place',
        ),
      );
      expect(
          session.applyCanonicalEvent(result.event,
              generation: session.generation),
          isTrue);
    });
    await tester.pumpAndSettle();
    expect(
        container
            .read(projectStateProvider)!
            .knownFacts
            .componentVisualPlacements
            .where((placement) => placement.componentId == 'REFRESH_U10'),
        isEmpty);
    await _clickRefresh(tester, container, project);
    final placement = container
        .read(projectStateProvider)!
        .knownFacts
        .componentVisualPlacements
        .singleWhere((placement) => placement.componentId == 'REFRESH_U10');
    expect(placement.centerX, 0.42);
    expect(placement.centerY, 0.58);
    expect(placement.rotationDeg, 30);
    expect(find.byKey(const Key('board_canvas_projection_overlay')),
        findsOneWidget);

    router.go('/project/measurements');
    await tester.pumpAndSettle();
    final previousMeasurements =
        container.read(projectStateProvider)!.measurementCount;
    await tester.runAsync(() async {
      final result = await V2SaveMeasurementService().saveMeasurement(
        projectState: container.read(projectStateProvider)!,
        request: const V2SaveMeasurementRequest(
          value: 3.37,
          valueText: '3.37',
          displayValue: '3.37 V',
          unitLabel: 'V',
          schemaUnit: 'V',
          mode: 'voltage',
          targetKey: 'REFRESH_U10',
          displayLabel: 'U10',
          componentId: 'REFRESH_U10',
          pinId: null,
          valueProvenance: 'human_entered',
          clientOperationId: 'refresh-e2e-measure',
        ),
      );
      expect(
          session.applyCanonicalEvent(result.event,
              generation: session.generation),
          isTrue);
    });
    await tester.pumpAndSettle();
    expect(container.read(projectStateProvider)!.measurementCount,
        previousMeasurements);
    await _clickRefresh(tester, container, project);
    final current = container.read(projectStateProvider)!;
    expect(current.measurementCount, previousMeasurements + 1);
    expect(
        current.knownFacts.measurements
            .any((m) => m.value == 3.37 && m.unit == 'V'),
        isTrue);
    container.read(beginnerModeProvider.notifier).state = false;
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(find.text('3.37 V'), 200,
        scrollable: find.byType(Scrollable).first);
    expect(find.text('3.37 V'), findsOneWidget);
    expect(current.manifest.projectId, initial.manifest.projectId);
    expect(current.projectDirectory, project.path);
    expect(current.events.length, initial.events.length + 3);
    expect(session.generation, 0);
    expect(tester.takeException(), isNull);
  }, timeout: const Timeout(Duration(minutes: 2)));

  testWidgets(
      'real in-flight append after refresh remains accepted in the original generation',
      (tester) async {
    final project = (await tester.runAsync(_copyProject))!;
    addTearDown(() async => project.delete(recursive: true));
    final initial = (await tester
            .runAsync(() => ProjectLoader.loadFromDirectory(project.path)))!
        .copyWith(isProjectionStale: true);
    // The barriers belong to the real async zone used by process I/O, not
    // WidgetTester's fake timer zone.
    final gates = (await tester.runAsync(() async => (
          _CommandGate('materialize_known_facts.py'),
          _CommandGate('event_writer_service.py'),
        )))!;
    final refreshGate = gates.$1;
    final saveGate = gates.$2;
    addTearDown(() {
      if (!refreshGate.release.isCompleted) refreshGate.release.complete();
      if (!saveGate.release.isCompleted) saveGate.release.complete();
    });
    final container = ProviderContainer(overrides: [
      projectStateProvider.overrideWith(() => SeededProjectSession(initial)),
      projectProjectionRefresherProvider.overrideWithValue(
        ProjectProjectionRefresher(
          pythonRunner: PythonRunner(processRunner: refreshGate),
        ),
      ),
    ]);
    addTearDown(container.dispose);
    final session = container.read(projectStateProvider.notifier);
    final originalGeneration = session.generation;
    final router = buildTraceBenchRouter(
        initialLocation: '/project/components',
        homeBuilder: (_) => const Scaffold(body: Text('Home')));
    addTearDown(router.dispose);
    await tester.pumpWidget(UncontrolledProviderScope(
      container: container,
      child: MaterialApp.router(routerConfig: router),
    ));
    await tester.pumpAndSettle();

    await tester.runAsync(() async {
      await tester.tap(find.byKey(const Key('workbench-refresh-button')));
      await refreshGate.reached.future.timeout(const Duration(seconds: 15));
      final pendingSave = V2AddComponentService(
        pythonRunner: PythonRunner(processRunner: saveGate),
      ).addComponent(
        projectState: initial,
        request: const V2AddComponentRequest(
          componentId: 'RACE_A',
          label: 'Race A',
          componentKind: 'unknown',
          clientOperationId: 'refresh-race-first',
        ),
      );
      await saveGate.reached.future.timeout(const Duration(seconds: 15));
      refreshGate.release.complete();
      final deadline = DateTime.now().add(const Duration(seconds: 25));
      while (container.read(projectStateProvider)!.isProjectionStale &&
          DateTime.now().isBefore(deadline)) {
        await Future<void>.delayed(const Duration(milliseconds: 20));
      }
      expect(container.read(projectStateProvider)!.isProjectionStale, isFalse);
      expect(saveGate.release.isCompleted, isFalse,
          reason: 'Refresh must be installed before the writer can append');

      saveGate.release.complete();
      final saved = await pendingSave;
      final diskEvents =
          (await File(p.join(project.path, 'events.jsonl')).readAsLines())
              .where((line) => line.trim().isNotEmpty)
              .map(jsonDecode);
      expect(
          diskEvents
              .any((event) => event['event_id'] == saved.event['event_id']),
          isTrue);
      expect(
          session.applyCanonicalEvent(saved.event,
              generation: originalGeneration),
          isTrue,
          reason:
              'An actually appended same-project event must survive refresh');
      final afterLateSave = container.read(projectStateProvider)!;
      expect(afterLateSave.events.last.eventId, saved.event['event_id']);
      expect(afterLateSave.isProjectionStale, isTrue);
      expect(session.generation, originalGeneration);

      final next = await V2AddComponentService().addComponent(
        projectState: afterLateSave,
        request: const V2AddComponentRequest(
          componentId: 'RACE_B',
          label: 'Race B',
          componentKind: 'unknown',
          clientOperationId: 'refresh-race-next',
        ),
      );
      expect(
          session.applyCanonicalEvent(next.event,
              generation: originalGeneration),
          isTrue);
      expect(container.read(projectStateProvider)!.events.length,
          initial.events.length + 2);
      expect(container.read(projectStateProvider)!.isProjectionStale, isTrue);
    });
    expect(tester.takeException(), isNull);
    await tester.pumpAndSettle();
    await _clickRefresh(tester, container, project);
    final finalState = container.read(projectStateProvider)!;
    expect(finalState.knownFacts.components.map((c) => c.componentId),
        containsAll(['RACE_A', 'RACE_B']));
    expect(finalState.events.length, initial.events.length + 2);
    expect(session.generation, originalGeneration);
  }, timeout: const Timeout(Duration(minutes: 2)));
}
