import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:trace_bench_viewer/app/app.dart';
import 'package:trace_bench_viewer/app/router.dart';
import 'package:trace_bench_viewer/features/board_canvas/screens/board_canvas_screen.dart';
import 'package:trace_bench_viewer/features/components/services/v2_add_component_writer.dart';
import 'package:trace_bench_viewer/features/components/services/v2_edit_component_writer.dart';
import 'package:trace_bench_viewer/features/components/services/v2_placement_writer.dart';
import 'package:trace_bench_viewer/features/measure_sheet/services/v2_save_measurement_writer.dart';
import 'package:trace_bench_viewer/features/project/widgets/workbench_shell.dart';
import 'package:trace_bench_viewer/shared/models/known_facts.dart';
import 'package:trace_bench_viewer/shared/models/project_manifest.dart';
import 'package:trace_bench_viewer/shared/models/project_state.dart';
import 'package:trace_bench_viewer/shared/models/trace_bench_event.dart';
import 'package:trace_bench_viewer/shared/theme/app_theme.dart';

const _expectedDestinationPaths = <String>[
  '/project',
  '/project/overview',
  '/project/components',
  '/project/measurements',
  '/project/pins',
  '/project/not-populated',
  '/project/photos',
  '/project/reference-images',
  '/project/graph',
  '/project/events',
  '/project/known-facts',
  '/project/report',
];

ProjectState _loadedProject({required String projectDirectory}) {
  return ProjectState(
    manifest: const ProjectManifest(
      projectId: 'workbench_shell_test',
      schemaVersion: '1.0.0',
      createdAt: '2026-08-19T00:00:00Z',
      deviceType: 'board',
      model: 'shell test',
      symptom: 'test',
    ),
    knownFacts: const KnownFacts(
      projectId: 'workbench_shell_test',
      components: [],
      pins: [],
      measurements: [],
      nets: [],
      excludedFromFaultCandidates: [],
      componentPinIndex: {},
      photos: [],
      damageRegions: [],
      suspectRegions: [],
      visualTraces: [],
    ),
    events: const [
      TraceBenchEvent(
        schemaVersion: '2.0.0',
        eventId: 'evt-workbench-shell-readonly',
        projectId: 'workbench_shell_test',
        sequence: 1,
        createdAt: '2026-08-19T00:00:00Z',
        actor: {'source': 'workbench-shell-test'},
        eventType: 'measurement_recorded',
        status: 'accepted',
        payload: {},
      ),
    ],
    customerReport: 'Shell test report',
    projectDirectory: projectDirectory,
    projectionFreshness: ProjectionFreshness.fresh,
  );
}

class _RouterSession {
  const _RouterSession({
    required this.addWriter,
    required this.container,
    required this.editWriter,
    required this.router,
    required this.loadedProject,
    required this.measurementWriter,
    required this.placementWriter,
    required this.projectDirectory,
  });

  final _UnexpectedAddComponentWriter addWriter;
  final ProviderContainer container;
  final _UnexpectedEditComponentWriter editWriter;
  final GoRouter router;
  final ProjectState loadedProject;
  final _UnexpectedSaveMeasurementWriter measurementWriter;
  final _UnexpectedPlacementWriter placementWriter;
  final Directory projectDirectory;
}

class _UnexpectedAddComponentWriter implements V2AddComponentWriter {
  var calls = 0;

  @override
  Future<V2AddComponentResult> addComponent({
    required ProjectState projectState,
    required V2AddComponentRequest request,
  }) async {
    calls += 1;
    throw StateError('Shared shell must not add components.');
  }
}

class _UnexpectedEditComponentWriter implements V2EditComponentWriter {
  var calls = 0;

  @override
  Future<V2EditComponentResult> editComponent({
    required ProjectState projectState,
    required V2EditComponentRequest request,
  }) async {
    calls += 1;
    throw StateError('Shared shell must not edit components.');
  }
}

class _UnexpectedPlacementWriter implements V2PlacementWriter {
  var calls = 0;

  @override
  Future<V2PlacementWriterResult> confirmPlacement({
    required ProjectState projectState,
    required V2PlacementWriterRequest request,
  }) async {
    calls += 1;
    throw StateError('Shared shell must not confirm placements.');
  }
}

class _UnexpectedSaveMeasurementWriter implements V2SaveMeasurementWriter {
  var calls = 0;

  @override
  Future<V2SaveMeasurementResult> saveMeasurement({
    required ProjectState projectState,
    required V2SaveMeasurementRequest request,
  }) async {
    calls += 1;
    throw StateError('Shared shell must not save measurements.');
  }
}

Future<_RouterSession> _pumpRouter(
  WidgetTester tester, {
  String initialLocation = '/project/overview',
  Size surfaceSize = const Size(1500, 800),
}) async {
  await tester.binding.setSurfaceSize(surfaceSize);
  addTearDown(() => tester.binding.setSurfaceSize(null));

  final projectDirectory =
      Directory.systemTemp.createTempSync('workbench_shell_test_');
  File('${projectDirectory.path}${Platform.pathSeparator}fixture.txt')
      .writeAsStringSync('unchanged');
  final loadedProject = _loadedProject(
    projectDirectory: projectDirectory.path,
  );
  final addWriter = _UnexpectedAddComponentWriter();
  final editWriter = _UnexpectedEditComponentWriter();
  final placementWriter = _UnexpectedPlacementWriter();
  final measurementWriter = _UnexpectedSaveMeasurementWriter();
  final container = ProviderContainer(
    overrides: [
      projectStateProvider.overrideWith((_) => loadedProject),
      beginnerModeProvider.overrideWith((_) => true),
      v2AddComponentWriterProvider.overrideWithValue(addWriter),
      v2EditComponentWriterProvider.overrideWithValue(editWriter),
      v2PlacementWriterProvider.overrideWithValue(placementWriter),
      v2SaveMeasurementWriterProvider.overrideWithValue(measurementWriter),
    ],
  );
  final router = buildTraceBenchRouter(
    initialLocation: initialLocation,
    homeBuilder: (_) => const Scaffold(
      key: ValueKey('workbench-test-home'),
      body: Center(child: Text('Workbench test Home')),
    ),
  );
  addTearDown(() {
    router.dispose();
    container.dispose();
    if (projectDirectory.existsSync()) {
      projectDirectory.deleteSync(recursive: true);
    }
  });

  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: MaterialApp.router(
        theme: buildTheme(),
        routerConfig: router,
      ),
    ),
  );
  await tester.pumpAndSettle();

  return _RouterSession(
    addWriter: addWriter,
    container: container,
    editWriter: editWriter,
    router: router,
    loadedProject: loadedProject,
    measurementWriter: measurementWriter,
    placementWriter: placementWriter,
    projectDirectory: projectDirectory,
  );
}

Future<void> _pumpUntilRouterPath(
  WidgetTester tester,
  GoRouter router,
  String expectedPath,
) async {
  for (var attempt = 0; attempt < 30; attempt += 1) {
    await tester.pump(const Duration(milliseconds: 16));
    if (router.routeInformationProvider.value.uri.path == expectedPath) {
      await tester.pump(const Duration(milliseconds: 300));
      return;
    }
  }
  expect(router.routeInformationProvider.value.uri.path, expectedPath);
}

void main() {
  test('owns the exact ordered top-level destination inventory', () {
    final locations = workbenchDestinations
        .map((destination) => destination.location)
        .toList(growable: false);
    expect(
      locations,
      orderedEquals(_expectedDestinationPaths),
    );
    expect(locations.toSet(), hasLength(12));
    expect(locations, isNot(contains('/')));
    expect(
      workbenchDestinations.map((destination) => destination.location),
      isNot(contains('/project/components/add')),
    );
    expect(
      workbenchDestinations.map((destination) => destination.location),
      isNot(contains('/project/components/edit')),
    );
    expect(
      workbenchDestinations.map((destination) => destination.location),
      isNot(contains('/project/measure-sheet')),
    );
    for (final destination in workbenchDestinations) {
      expect(
        activeWorkbenchDestination(destination.location),
        same(destination),
      );
    }
  });

  test('maps workflow routes to their top-level active destinations', () {
    expect(
      activeWorkbenchDestination('/project/components/add').location,
      '/project/components',
    );
    expect(
      activeWorkbenchDestination('/project/components/edit').location,
      '/project/components',
    );
    expect(
      activeWorkbenchDestination('/project/measure-sheet').location,
      '/project/measurements',
    );
    expect(
      activeWorkbenchDestination('/project').location,
      '/project',
    );
  });

  testWidgets(
    'keeps one shell identity and providers across project leaf navigation',
    (tester) async {
      final session = await _pumpRouter(tester);

      expect(find.byType(WorkbenchShell), findsOneWidget);
      expect(
        find.byType(WorkbenchShell, skipOffstage: false),
        findsOneWidget,
      );
      expect(
        find.byKey(const Key('workbench-wide-navigation')),
        findsOneWidget,
      );
      expect(
        find.byKey(const Key('workbench-compact-navigation')),
        findsNothing,
      );
      final shellElement = tester.element(find.byType(WorkbenchShell));
      final shellState = tester.state(find.byType(WorkbenchShell));
      final eventsBefore = session.loadedProject.events;

      await tester.tap(
        find.byKey(const Key('workbench-beginner-mode-button')),
      );
      await tester.pumpAndSettle();
      expect(session.container.read(beginnerModeProvider), isFalse);

      session.router.go('/project/components');
      await tester.pumpAndSettle();

      expect(find.byType(WorkbenchShell), findsOneWidget);
      expect(
        identical(tester.element(find.byType(WorkbenchShell)), shellElement),
        isTrue,
      );
      expect(
        identical(tester.state(find.byType(WorkbenchShell)), shellState),
        isTrue,
      );
      expect(
        tester
            .widget<ListTile>(
              find.byKey(const Key('workbench-destination-components')),
            )
            .selected,
        isTrue,
      );
      expect(
        session.container.read(projectStateProvider),
        same(session.loadedProject),
      );
      expect(session.container.read(beginnerModeProvider), isFalse);
      expect(
          session.container.read(projectStateProvider)!.events, eventsBefore);
    },
  );

  testWidgets('renders one reachable compact navigation model', (tester) async {
    final session = await _pumpRouter(
      tester,
      surfaceSize: const Size(390, 844),
    );

    expect(find.byType(WorkbenchShell), findsOneWidget);
    expect(
      find.byKey(const Key('workbench-wide-navigation')),
      findsNothing,
    );
    expect(
      find.byKey(
        const Key('workbench-compact-navigation'),
        skipOffstage: false,
      ),
      findsNothing,
    );

    await tester.tap(find.byKey(const Key('workbench-compact-menu-button')));
    await tester.pumpAndSettle();
    expect(
      find.byKey(const Key('workbench-compact-navigation')),
      findsOneWidget,
    );

    await tester.tap(
      find.byKey(const Key('workbench-destination-measurements')),
    );
    await tester.pumpAndSettle();
    expect(
      session.router.routeInformationProvider.value.uri.path,
      '/project/measurements',
    );
    expect(find.byType(WorkbenchShell), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('persistent navigation starts at the safe 1228 width',
      (tester) async {
    await _pumpRouter(
      tester,
      surfaceSize: const Size(959, 800),
    );

    const widths = <({double width, bool persistent})>[
      (width: 959, persistent: false),
      (width: 960, persistent: false),
      (width: 1227, persistent: false),
      (width: 1228, persistent: true),
      (width: 1229, persistent: true),
      (width: 1500, persistent: true),
    ];

    for (final expectation in widths) {
      await tester.binding.setSurfaceSize(Size(expectation.width, 800));
      await tester.pumpAndSettle();

      expect(find.byType(WorkbenchShell), findsOneWidget,
          reason: '${expectation.width} px');
      expect(
        find.byKey(const Key('workbench-wide-navigation')),
        expectation.persistent ? findsOneWidget : findsNothing,
        reason: '${expectation.width} px',
      );
      expect(
        find.byKey(const Key('workbench-compact-menu-button')),
        expectation.persistent ? findsNothing : findsOneWidget,
        reason: '${expectation.width} px',
      );
      expect(tester.takeException(), isNull, reason: '${expectation.width} px');
    }
  });

  testWidgets('Home round trip preserves project and beginner mode',
      (tester) async {
    final session = await _pumpRouter(tester);
    session.container.read(beginnerModeProvider.notifier).state = false;
    await tester.pump();

    await tester.tap(find.byKey(const Key('workbench-home-button')));
    await tester.pumpAndSettle();

    expect(session.router.routeInformationProvider.value.uri.path, '/');
    expect(find.byKey(const ValueKey('workbench-test-home')), findsOneWidget);
    expect(
      session.container.read(projectStateProvider),
      same(session.loadedProject),
    );
    expect(session.container.read(beginnerModeProvider), isFalse);

    session.router.go('/project');
    await tester.pumpAndSettle();

    expect(find.byType(BoardCanvasScreen), findsOneWidget);
    expect(find.byType(WorkbenchShell), findsOneWidget);
    expect(
      session.container.read(projectStateProvider),
      same(session.loadedProject),
    );
    expect(session.container.read(beginnerModeProvider), isFalse);
  });

  testWidgets(
      'shared destination controls navigate exact routes without state writes',
      (tester) async {
    final session = await _pumpRouter(tester);
    final eventsBefore = session.loadedProject.events
        .map((event) => event.eventId)
        .toList(growable: false);
    final filesBefore = session.projectDirectory
        .listSync(recursive: true)
        .map((entry) => entry.path)
        .toList(growable: false);
    final factsBefore = session.loadedProject.knownFacts;
    const destinations = <({String id, String location})>[
      (id: 'board-canvas', location: '/project'),
      (id: 'graph', location: '/project/graph'),
      (id: 'reference-images', location: '/project/reference-images'),
    ];

    for (final destination in destinations) {
      final destinationControl = find.byKey(
        Key('workbench-destination-${destination.id}'),
      );
      await tester.scrollUntilVisible(
        destinationControl,
        160,
        scrollable: find.descendant(
          of: find.byKey(const Key('workbench-wide-navigation')),
          matching: find.byType(Scrollable),
        ),
      );
      await tester.tap(destinationControl);
      await _pumpUntilRouterPath(
        tester,
        session.router,
        destination.location,
      );

      expect(
        session.router.routeInformationProvider.value.uri.path,
        destination.location,
      );
      expect(find.byType(WorkbenchShell), findsOneWidget);
      expect(
        find.byType(WorkbenchShell, skipOffstage: false),
        findsOneWidget,
      );
      expect(
        session.container.read(projectStateProvider),
        same(session.loadedProject),
      );
      expect(
        session.container
            .read(projectStateProvider)!
            .events
            .map((event) => event.eventId),
        orderedEquals(eventsBefore),
      );
      expect(session.container.read(projectStateProvider)!.knownFacts,
          same(factsBefore));
      expect(
        session.container.read(projectStateProvider)!.projectionFreshness,
        ProjectionFreshness.fresh,
      );
      expect(session.addWriter.calls, 0);
      expect(session.editWriter.calls, 0);
      expect(session.placementWriter.calls, 0);
      expect(session.measurementWriter.calls, 0);
      expect(
        session.projectDirectory
            .listSync(recursive: true)
            .map((entry) => entry.path),
        orderedEquals(filesBefore),
      );
    }
  });

  testWidgets('workflow and aliases select one canonical shell destination',
      (tester) async {
    final session = await _pumpRouter(
      tester,
      initialLocation: '/project/components/add',
    );

    expect(find.byType(WorkbenchShell), findsOneWidget);
    expect(
      tester
          .widget<ListTile>(
            find.byKey(const Key('workbench-destination-components')),
          )
          .selected,
      isTrue,
    );

    session.router.go('/project/measurements/new');
    await tester.pumpAndSettle();
    expect(
      session.router.routeInformationProvider.value.uri.path,
      '/project/measure-sheet',
    );
    expect(find.byType(WorkbenchShell), findsOneWidget);
    expect(
      tester
          .widget<ListTile>(
            find.byKey(const Key('workbench-destination-measurements')),
          )
          .selected,
      isTrue,
    );

    session.router.go('/project/board-canvas');
    await tester.pumpAndSettle();
    expect(session.router.routeInformationProvider.value.uri.path, '/project');
    expect(find.byType(WorkbenchShell), findsOneWidget);
    expect(
      tester
          .widget<ListTile>(
            find.byKey(const Key('workbench-destination-board-canvas')),
          )
          .selected,
      isTrue,
    );
  });
}
