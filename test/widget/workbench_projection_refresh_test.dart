import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trace_bench_viewer/app/router.dart';
import 'package:trace_bench_viewer/shared/models/known_facts.dart';
import 'package:trace_bench_viewer/shared/models/project_manifest.dart';
import 'package:trace_bench_viewer/shared/models/project_state.dart';
import 'package:trace_bench_viewer/shared/session/project_session.dart';
import 'package:trace_bench_viewer/shared/services/project_projection_refresher.dart';
import 'package:trace_bench_viewer/shared/services/python_runner.dart';
import 'package:trace_bench_viewer/shared/widgets/workbench_projection_refresh.dart';

import '../helpers/seeded_project_session.dart';

ProjectState _project({bool stale = true}) => ProjectState(
      manifest: const ProjectManifest(
        projectId: 'refresh-test',
        schemaVersion: '1.0',
        createdAt: '2026-10-29T00:00:00Z',
        deviceType: 'board',
        model: 'test',
        symptom: 'test',
      ),
      knownFacts: KnownFacts.fromJson({'project_id': 'refresh-test'}),
      events: const [],
      customerReport: '',
      projectDirectory: '/local/refresh-test',
      projectionFreshness:
          stale ? ProjectionFreshness.stale : ProjectionFreshness.fresh,
    );

Future<ProviderContainer> _pump(
  WidgetTester tester, {
  ProjectState? project,
  ProjectProjectionRefresher? refresher,
  String location = '/project/components',
  double textScale = 1,
}) async {
  final container = ProviderContainer(overrides: [
    projectStateProvider.overrideWith(() => SeededProjectSession(project)),
    if (refresher != null)
      projectProjectionRefresherProvider.overrideWithValue(refresher),
  ]);
  final router = buildTraceBenchRouter(
    initialLocation: location,
    homeBuilder: (_) => const Scaffold(body: Text('Home')),
  );
  addTearDown(container.dispose);
  addTearDown(router.dispose);
  await tester.pumpWidget(UncontrolledProviderScope(
    container: container,
    child: MaterialApp.router(
      routerConfig: router,
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaler: TextScaler.linear(textScale),
        ),
        child: child!,
      ),
    ),
  ));
  await tester.pumpAndSettle();
  return container;
}

class _Runner extends ProcessRunner {
  Future<ProcessResult> Function() materialize =
      () async => ProcessResult(0, 0, '', '');
  bool missingPython = false;
  int materializations = 0;

  @override
  Future<ProcessResult> run({
    required List<String> command,
    required String workingDirectory,
    required Duration timeout,
  }) async {
    if (command.last == '--version') {
      return ProcessResult(0, missingPython ? 1 : 0, '', '');
    }
    materializations++;
    return materialize();
  }
}

ProjectProjectionRefresher _service(
  _Runner runner,
  Future<ProjectState> Function(String) load,
) =>
    ProjectProjectionRefresher(
      pythonRunner: PythonRunner(processRunner: runner),
      directoryLoader: load,
    );

Future<void> _start(WidgetTester tester) async {
  await tester.tap(find.byKey(const Key('workbench-refresh-button')));
  await tester.pump();
}

Map<String, dynamic> _newEvent() => {
      'schema_version': '2.0-draft',
      'event_id': 'newer-event',
      'project_id': 'refresh-test',
      'event_type': 'component_created',
      'status': 'accepted',
      'created_at': '2026-10-29T00:00:00Z',
      'actor': {'type': 'human'},
      'payload': {'component_id': 'C-new', 'client_operation_id': 'newer-op'},
    };

void main() {
  testWidgets('stale Workbench offers explicit refresh without ZIP export',
      (tester) async {
    await _pump(tester, project: _project());
    expect(find.text('Värskenda andmeid'), findsOneWidget);
    expect(find.text('Export ZIP'), findsNothing);
  });

  testWidgets('fresh Workbench does not offer unnecessary refresh',
      (tester) async {
    await _pump(tester, project: _project(stale: false));
    expect(find.text('Värskenda andmeid'), findsNothing);
  });

  testWidgets('refresh updates visible facts and hides the stale action',
      (tester) async {
    final snapshot = _project();
    final runner = _Runner();
    final loaded = snapshot.copyWith(
      projectionFreshness: ProjectionFreshness.fresh,
      knownFacts: KnownFacts.fromJson({
        'project_id': 'refresh-test',
        'components': [
          {'component_id': 'C-refreshed', 'status': 'identified'}
        ],
      }),
    );
    final container = await _pump(tester,
        project: snapshot, refresher: _service(runner, (_) async => loaded));
    expect(runner.materializations, 0);
    expect(find.text('C-refreshed'), findsNothing);
    await _start(tester);
    await tester.pumpAndSettle();
    expect(find.text('C-refreshed'), findsOneWidget);
    expect(find.text('Värskenda andmeid'), findsNothing);
    expect(container.read(projectStateProvider)?.projectDirectory,
        '/local/refresh-test');
    expect(container.read(projectStateProvider.notifier).generation, 0);
  });

  testWidgets('double activation is disabled while the materializer is pending',
      (tester) async {
    final snapshot = _project();
    final pending = Completer<ProcessResult>();
    final runner = _Runner()..materialize = () => pending.future;
    await _pump(tester,
        project: snapshot,
        refresher: _service(
            runner,
            (_) async => snapshot.copyWith(
                projectionFreshness: ProjectionFreshness.fresh)));
    await _start(tester);
    expect(
        tester
            .widget<FilledButton>(
                find.byKey(const Key('workbench-refresh-button')))
            .onPressed,
        isNull);
    await _start(tester);
    expect(runner.materializations, 1);
    pending.complete(ProcessResult(0, 0, '', ''));
    await tester.pumpAndSettle();
    expect(find.text('Värskenda andmeid'), findsNothing);
  });

  for (final failure in ['python', 'materializer', 'reload', 'directory']) {
    testWidgets('$failure failure preserves old state and offers retry',
        (tester) async {
      final original = _project();
      final snapshot = failure == 'directory'
          ? ProjectState(
              manifest: original.manifest,
              knownFacts: original.knownFacts,
              events: original.events,
              customerReport: '',
              projectionFreshness: ProjectionFreshness.stale)
          : original;
      final runner = _Runner()..missingPython = failure == 'python';
      var failing = true;
      runner.materialize = () async => ProcessResult(0,
          failing && failure == 'materializer' ? 1 : 0, '', 'PRIVATE-DETAIL');
      final container = await _pump(tester,
          project: snapshot,
          refresher: _service(runner, (_) async {
            if (failing && failure == 'reload') {
              throw StateError('PRIVATE-DETAIL');
            }
            return snapshot.copyWith(
                projectionFreshness: ProjectionFreshness.fresh);
          }));
      await _start(tester);
      await tester.pumpAndSettle();
      expect(container.read(projectStateProvider), same(snapshot));
      expect(container.read(projectStateProvider)!.isProjectionStale, isTrue);
      expect(find.textContaining('PRIVATE-DETAIL'), findsNothing);
      expect(
          tester
              .widget<FilledButton>(
                  find.byKey(const Key('workbench-refresh-button')))
              .onPressed,
          isNotNull);
      if (failure == 'directory') {
        expect(find.textContaining('kohalikust kaustast'), findsOneWidget);
      } else {
        failing = false;
        runner.missingPython = false;
        await _start(tester);
        await tester.pumpAndSettle();
        expect(
            container.read(projectStateProvider)!.isProjectionStale, isFalse);
      }
    });
  }

  for (final lateFailure in [false, true]) {
    testWidgets(
        'late result never replaces or reports errors on another project ($lateFailure)',
        (tester) async {
      final snapshot = _project();
      final pending = Completer<ProcessResult>();
      final runner = _Runner()..materialize = () => pending.future;
      final container = await _pump(tester,
          project: snapshot,
          refresher: _service(
              runner,
              (_) async => snapshot.copyWith(
                  projectionFreshness: ProjectionFreshness.fresh)));
      await _start(tester);
      final session = container.read(projectStateProvider.notifier);
      final other =
          snapshot.copyWith(projectDirectory: '/local/another-project');
      session.openProject(other, generation: session.generation);
      await tester.pump();
      pending.complete(
          ProcessResult(0, lateFailure ? 1 : 0, '', 'PRIVATE-DETAIL'));
      await tester.pumpAndSettle();
      expect(container.read(projectStateProvider), same(other));
      expect(find.textContaining('ebaõnnestus'), findsNothing);
      expect(session.generation, 1);
    });
  }

  testWidgets('close during refresh cannot resurrect the project',
      (tester) async {
    final snapshot = _project();
    final pending = Completer<ProcessResult>();
    final runner = _Runner()..materialize = () => pending.future;
    final container = await _pump(tester,
        project: snapshot,
        refresher: _service(
            runner,
            (_) async => snapshot.copyWith(
                projectionFreshness: ProjectionFreshness.fresh)));
    await _start(tester);
    container.read(projectStateProvider.notifier).closeProject();
    await tester.pump();
    pending.complete(ProcessResult(0, 0, '', ''));
    await tester.pumpAndSettle();
    expect(container.read(projectStateProvider), isNull);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
      'newer same-generation accepted event invalidates reload and survives retry',
      (tester) async {
    final snapshot = _project();
    final pending = Completer<ProcessResult>();
    final runner = _Runner()..materialize = () => pending.future;
    var disk =
        snapshot.copyWith(projectionFreshness: ProjectionFreshness.fresh);
    final container = await _pump(tester,
        project: snapshot, refresher: _service(runner, (_) async => disk));
    await _start(tester);
    final session = container.read(projectStateProvider.notifier);
    expect(
        session.applyCanonicalEvent(_newEvent(),
            generation: session.generation),
        isTrue);
    final newer = container.read(projectStateProvider)!;
    expect(session.generation, 0);
    pending.complete(ProcessResult(0, 0, '', ''));
    await tester.pumpAndSettle();
    expect(container.read(projectStateProvider), same(newer));
    expect(newer.events.single.eventId, 'newer-event');
    expect(newer.isProjectionStale, isTrue);
    expect(find.textContaining('Vahepeal salvestati'), findsOneWidget);
    runner.materialize = () async => ProcessResult(0, 0, '', '');
    disk = newer.copyWith(projectionFreshness: ProjectionFreshness.fresh);
    await _start(tester);
    await tester.pumpAndSettle();
    expect(container.read(projectStateProvider)!.events.single.eventId,
        'newer-event');
    expect(
        session.applyCanonicalEvent(_newEvent(),
            generation: session.generation),
        isFalse);
    expect(container.read(projectStateProvider)!.isProjectionStale, isFalse);
  });

  testWidgets(
      'late in-flight save makes a successfully refreshed Workbench stale again',
      (tester) async {
    final snapshot = _project();
    final materializer = Completer<ProcessResult>();
    final writer = Completer<Map<String, dynamic>>();
    final runner = _Runner()..materialize = () => materializer.future;
    var disk =
        snapshot.copyWith(projectionFreshness: ProjectionFreshness.fresh);
    final container = await _pump(tester,
        project: snapshot, refresher: _service(runner, (_) async => disk));
    final session = container.read(projectStateProvider.notifier);
    await _start(tester);
    final originalGeneration = session.generation;
    final pendingSave = writer.future.then((event) =>
        session.applyCanonicalEvent(event, generation: originalGeneration));
    materializer.complete(ProcessResult(0, 0, '', ''));
    await tester.pumpAndSettle();
    expect(find.text('Värskenda andmeid'), findsNothing);
    writer.complete(_newEvent());
    await tester.pumpAndSettle();
    expect(await pendingSave, isTrue);
    expect(container.read(projectStateProvider)!.events.single.eventId,
        'newer-event');
    expect(container.read(projectStateProvider)!.isProjectionStale, isTrue);
    expect(find.text('Värskenda andmeid'), findsOneWidget);
    expect(session.generation, originalGeneration);
    final next = _newEvent()..['event_id'] = 'next-distinct-event';
    next['payload'] = {
      'component_id': 'C-next',
      'client_operation_id': 'next-op'
    };
    expect(session.applyCanonicalEvent(next, generation: originalGeneration),
        isTrue);
    disk = container
        .read(projectStateProvider)!
        .copyWith(projectionFreshness: ProjectionFreshness.fresh);
    runner.materialize = () async => ProcessResult(0, 0, '', '');
    await tester.pump();
    await _start(tester);
    await tester.pumpAndSettle();
    expect(container.read(projectStateProvider)!.isProjectionStale, isFalse);
    expect(container.read(projectStateProvider)!.events, hasLength(2));
    expect(session.generation, originalGeneration);
  });

  testWidgets('same-project reopen still rejects the old generation result',
      (tester) async {
    final snapshot = _project();
    final pending = Completer<ProcessResult>();
    final runner = _Runner()..materialize = () => pending.future;
    final container = await _pump(tester,
        project: snapshot,
        refresher: _service(
            runner,
            (_) async => snapshot.copyWith(
                projectionFreshness: ProjectionFreshness.fresh)));
    await _start(tester);
    final session = container.read(projectStateProvider.notifier);
    session.closeProject();
    session.openProject(snapshot, generation: session.generation);
    pending.complete(ProcessResult(0, 0, '', ''));
    await tester.pumpAndSettle();
    expect(container.read(projectStateProvider), same(snapshot));
    expect(session.generation, 2);
  });

  testWidgets('refresh is reachable on actual Canvas with compact large text',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(600, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final snapshot = _project();
    final runner = _Runner();
    await _pump(tester,
        project: snapshot,
        location: '/project',
        textScale: 1.5,
        refresher: _service(
            runner,
            (_) async => snapshot.copyWith(
                projectionFreshness: ProjectionFreshness.fresh)));
    expect(
        find.byKey(const Key('board_canvas_instrument_bar')), findsOneWidget);
    expect(find.byKey(const Key('workbench-shell-app-bar')), findsNothing);
    expect(find.text('Värskenda andmeid'), findsOneWidget);
    var refreshFocused = false;
    for (var step = 0; step < 40 && !refreshFocused; step++) {
      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.pump();
      refreshFocused = FocusManager.instance.primaryFocus?.context
              ?.findAncestorWidgetOfExactType<FilledButton>()
              ?.key ==
          const Key('workbench-refresh-button');
    }
    expect(refreshFocused, isTrue,
        reason:
            'Refresh must remain reachable in the existing Canvas Tab order');
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.pumpAndSettle();
    expect(runner.materializations, 1);
    expect(find.text('Värskenda andmeid'), findsNothing);
    expect(tester.takeException(), isNull);
  });
}
