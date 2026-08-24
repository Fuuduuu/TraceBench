import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:trace_bench_viewer/shared/session/beginner_mode_provider.dart';
import 'package:trace_bench_viewer/shared/session/project_session.dart';

import '../helpers/seeded_project_session.dart';
import 'package:trace_bench_viewer/app/router.dart';
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
      components: [
        ComponentFact(
          componentId: 'cmp-shell',
          designator: 'Q1',
          type: 'transistor',
          package: 'SOT-23',
          marking: 'A1',
          status: 'confirmed',
        ),
      ],
      pins: [
        PinFact(
          componentId: 'cmp-shell',
          pinId: 'Q1.1',
          label: 'gate',
          status: 'defined',
        ),
      ],
      measurements: [
        MeasurementFact(
          measurementId: 'm-shell',
          mode: 'voltage_dc',
          from: 'Q1.1',
          to: 'GND',
          reading: '1.2 V',
          validityStatus: 'active',
          powerState: 'powered',
          value: 1.2,
          unit: 'V',
        ),
      ],
      nets: [],
      excludedFromFaultCandidates: [
        ExcludedFootprintFact(
          footprintId: 'R404',
          designator: 'R404',
        ),
      ],
      componentPinIndex: {
        'cmp-shell': ['Q1.1'],
      },
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
      projectStateProvider.overrideWith(
        () => SeededProjectSession(loadedProject),
      ),
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

  testWidgets(
    'read-only routed destinations render one shell AppBar and one destination surface',
    (tester) async {
      final session = await _pumpRouter(tester);
      final shellElement = tester.element(find.byType(WorkbenchShell));
      final shellState = tester.state(find.byType(WorkbenchShell));
      final factsBefore = session.loadedProject.knownFacts;
      final eventsBefore = session.loadedProject.events;
      final filesBefore = session.projectDirectory
          .listSync(recursive: true)
          .map((entry) => entry.path)
          .toList(growable: false);
      const cases = <({
        String caseName,
        String location,
        String destinationId,
        String activeLabel,
        String? removedTitle,
        bool beginnerMode,
      })>[
        (
          caseName: 'components',
          location: '/project/components',
          destinationId: 'components',
          activeLabel: 'Komponendid',
          removedTitle: 'Komponentide nimekiri',
          beginnerMode: false,
        ),
        (
          caseName: 'measurements',
          location: '/project/measurements',
          destinationId: 'measurements',
          activeLabel: 'Mõõtmised',
          removedTitle: null,
          beginnerMode: false,
        ),
        (
          caseName: 'not-populated',
          location: '/project/not-populated',
          destinationId: 'not-populated',
          activeLabel: 'Täitamata',
          removedTitle: 'Puudub populeerimine',
          beginnerMode: false,
        ),
        (
          caseName: 'pins',
          location: '/project/pins',
          destinationId: 'pins',
          activeLabel: 'Pinnid',
          removedTitle: null,
          beginnerMode: false,
        ),
        (
          caseName: 'events-advanced',
          location: '/project/events',
          destinationId: 'events',
          activeLabel: 'Sündmused',
          removedTitle: null,
          beginnerMode: false,
        ),
        (
          caseName: 'events-beginner',
          location: '/project/events',
          destinationId: 'events',
          activeLabel: 'Sündmused',
          removedTitle: null,
          beginnerMode: true,
        ),
        (
          caseName: 'known-facts',
          location: '/project/known-facts',
          destinationId: 'known-facts',
          activeLabel: 'Teadaolevad faktid',
          removedTitle: 'Known facts',
          beginnerMode: false,
        ),
      ];

      for (final testCase in cases) {
        session.container.read(beginnerModeProvider.notifier).state =
            testCase.beginnerMode;
        await tester.pump();
        session.router.go(testCase.location);
        await _pumpUntilRouterPath(
          tester,
          session.router,
          testCase.location,
        );
        await tester.pumpAndSettle();

        final shellAppBar = find.byKey(const Key('workbench-shell-app-bar'));
        final surface = find.byKey(const Key('workbench-destination-surface'));
        final activeControl = find.byKey(
          Key('workbench-destination-${testCase.destinationId}'),
        );
        final breadcrumb = find.byKey(const Key('workbench-breadcrumb'));

        expect(find.byType(WorkbenchShell), findsOneWidget,
            reason: testCase.caseName);
        expect(
          identical(tester.element(find.byType(WorkbenchShell)), shellElement),
          isTrue,
          reason: testCase.caseName,
        );
        expect(
          identical(tester.state(find.byType(WorkbenchShell)), shellState),
          isTrue,
          reason: testCase.caseName,
        );
        expect(shellAppBar, findsOneWidget, reason: testCase.caseName);
        expect(find.byType(AppBar), findsOneWidget, reason: testCase.caseName);
        expect(find.byType(Scaffold), findsOneWidget,
            reason: testCase.caseName);
        expect(surface, findsOneWidget, reason: testCase.caseName);
        expect(
          (tester.widget<AppBar>(shellAppBar).title! as Text).data,
          'BenchBeep Workbench',
          reason: testCase.caseName,
        );
        expect(
          tester.widget<ListTile>(activeControl).selected,
          isTrue,
          reason: testCase.caseName,
        );
        expect(
          find.descendant(
            of: breadcrumb,
            matching: find.text(testCase.activeLabel),
          ),
          findsOneWidget,
          reason: testCase.caseName,
        );
        if (testCase.removedTitle case final removedTitle?) {
          expect(find.text(removedTitle), findsNothing,
              reason: testCase.caseName);
        }

        final surfaceMaterial = tester.widget<Material>(surface);
        final surfaceTheme = Theme.of(tester.element(surface));
        expect(surfaceMaterial.color, WorkbenchShellColors.background,
            reason: testCase.caseName);
        expect(
          surfaceTheme.colorScheme.surface,
          WorkbenchShellColors.background,
          reason: testCase.caseName,
        );
        expect(
          surfaceTheme.colorScheme.onSurface,
          WorkbenchShellColors.text,
          reason: testCase.caseName,
        );
        expect(surfaceTheme.dividerColor, WorkbenchShellColors.rule,
            reason: testCase.caseName);

        switch (testCase.caseName) {
          case 'components':
            expect(
              find.descendant(of: surface, matching: find.text('cmp-shell')),
              findsOneWidget,
            );
          case 'measurements':
            expect(
              find.descendant(
                of: surface,
                matching: find.text('m-shell: Q1.1 → GND'),
              ),
              findsOneWidget,
            );
            expect(
              find.descendant(of: surface, matching: find.text('1.2 V')),
              findsOneWidget,
            );
          case 'not-populated':
            expect(
              find.descendant(of: surface, matching: find.text('R404')),
              findsOneWidget,
            );
            expect(
              find.descendant(of: surface, matching: find.byIcon(Icons.block)),
              findsOneWidget,
            );
          case 'pins':
            expect(
              find.descendant(of: surface, matching: find.text('Q1.1')),
              findsOneWidget,
            );
          case 'events-advanced':
            final eventTile = find.descendant(
              of: surface,
              matching: find.byType(ExpansionTile),
            );
            expect(eventTile, findsOneWidget);
            expect(
              find.descendant(
                of: surface,
                matching: find.text(
                  'event_id: evt-workbench-shell-readonly',
                ),
              ),
              findsOneWidget,
            );
            await tester.tap(eventTile);
            await tester.pumpAndSettle();
            expect(
              find.descendant(of: surface, matching: find.text('{}')),
              findsOneWidget,
            );
          case 'events-beginner':
            expect(
              find.descendant(
                of: surface,
                matching: find.text('Advanced režiim vajalik'),
              ),
              findsOneWidget,
            );
            expect(
              find.descendant(
                of: surface,
                matching: find.byType(ExpansionTile),
              ),
              findsNothing,
            );
          case 'known-facts':
            expect(
              find.descendant(
                of: surface,
                matching: find.textContaining(
                  '"component_id": "cmp-shell"',
                ),
              ),
              findsOneWidget,
            );
        }

        expect(
          session.container.read(projectStateProvider),
          same(session.loadedProject),
          reason: testCase.caseName,
        );
        expect(
          session.container.read(beginnerModeProvider),
          testCase.beginnerMode,
          reason: testCase.caseName,
        );
        expect(session.loadedProject.knownFacts, same(factsBefore),
            reason: testCase.caseName);
        expect(session.loadedProject.events, same(eventsBefore),
            reason: testCase.caseName);
        expect(session.loadedProject.projectionFreshness,
            ProjectionFreshness.fresh,
            reason: testCase.caseName);
        expect(session.addWriter.calls, 0, reason: testCase.caseName);
        expect(session.editWriter.calls, 0, reason: testCase.caseName);
        expect(session.placementWriter.calls, 0, reason: testCase.caseName);
        expect(session.measurementWriter.calls, 0, reason: testCase.caseName);
        expect(
          session.projectDirectory
              .listSync(recursive: true)
              .map((entry) => entry.path),
          orderedEquals(filesBefore),
          reason: testCase.caseName,
        );
      }
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

  testWidgets('Home clears project and preserves beginner mode',
      (tester) async {
    final session = await _pumpRouter(tester);
    session.container.read(beginnerModeProvider.notifier).state = false;
    await tester.pump();

    await tester.tap(find.byKey(const Key('workbench-home-button')));
    await tester.pumpAndSettle();

    expect(session.router.routeInformationProvider.value.uri.path, '/');
    expect(find.byKey(const ValueKey('workbench-test-home')), findsOneWidget);
    expect(session.container.read(projectStateProvider), isNull);
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
