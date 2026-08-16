import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:trace_bench_viewer/app/app.dart';
import 'package:trace_bench_viewer/app/router.dart';
import 'package:trace_bench_viewer/features/board_canvas/screens/board_canvas_screen.dart';
import 'package:trace_bench_viewer/features/board_graph/screens/board_graph_screen.dart';
import 'package:trace_bench_viewer/features/components/screens/add_component_screen.dart';
import 'package:trace_bench_viewer/features/components/screens/edit_component_screen.dart';
import 'package:trace_bench_viewer/features/components/services/v2_add_component_writer.dart';
import 'package:trace_bench_viewer/features/events/screens/events_viewer_screen.dart';
import 'package:trace_bench_viewer/features/known_facts/screens/component_list_screen.dart';
import 'package:trace_bench_viewer/features/known_facts/screens/known_facts_viewer_screen.dart';
import 'package:trace_bench_viewer/features/known_facts/screens/measurement_list_screen.dart';
import 'package:trace_bench_viewer/features/known_facts/screens/not_populated_screen.dart';
import 'package:trace_bench_viewer/features/known_facts/screens/pin_list_screen.dart';
import 'package:trace_bench_viewer/features/measure_sheet/screens/measure_sheet_screen.dart';
import 'package:trace_bench_viewer/features/photos/screens/photo_list_screen.dart';
import 'package:trace_bench_viewer/features/project/screens/home_screen.dart';
import 'package:trace_bench_viewer/features/project/screens/project_overview_screen.dart';
import 'package:trace_bench_viewer/features/project/widgets/project_gate.dart';
import 'package:trace_bench_viewer/features/reference_images/screens/reference_images_screen.dart';
import 'package:trace_bench_viewer/features/report/screens/customer_report_screen.dart';
import 'package:trace_bench_viewer/shared/models/known_facts.dart';
import 'package:trace_bench_viewer/shared/models/project_manifest.dart';
import 'package:trace_bench_viewer/shared/models/project_state.dart';
import 'package:trace_bench_viewer/shared/services/project_loader.dart';
import 'package:trace_bench_viewer/shared/theme/app_theme.dart';

const _projectDestinations = <({String path, Type childType})>[
  (path: '/project', childType: BoardCanvasScreen),
  (path: '/project/overview', childType: ProjectOverviewScreen),
  (path: '/project/components', childType: ComponentListScreen),
  (path: '/project/components/add', childType: AddComponentScreen),
  (path: '/project/components/edit', childType: EditComponentScreen),
  (path: '/project/measurements', childType: MeasurementListScreen),
  (path: '/project/measure-sheet', childType: MeasureSheetScreen),
  (path: '/project/not-populated', childType: NotPopulatedScreen),
  (path: '/project/pins', childType: PinListScreen),
  (path: '/project/events', childType: EventsViewerScreen),
  (path: '/project/graph', childType: BoardGraphScreen),
  (path: '/project/known-facts', childType: KnownFactsViewerScreen),
  (path: '/project/photos', childType: PhotoListScreen),
  (path: '/project/reference-images', childType: ReferenceImagesScreen),
  (path: '/project/report', childType: CustomerReportScreen),
];

ProjectState _loadedProject({
  String projectDirectory = r'C:\projects\gate_test',
}) {
  return ProjectState(
    manifest: const ProjectManifest(
      projectId: 'gate_test',
      schemaVersion: '1.0.0',
      createdAt: '2026-08-16T00:00:00Z',
      deviceType: 'board',
      model: 'gate test',
      symptom: 'test',
    ),
    knownFacts: const KnownFacts(
      projectId: 'gate_test',
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
    events: const [],
    customerReport: 'Gate test report',
    projectDirectory: projectDirectory,
    projectionFreshness: ProjectionFreshness.fresh,
  );
}

class _RouterSession {
  const _RouterSession({
    required this.container,
    required this.router,
  });

  final ProviderContainer container;
  final GoRouter router;
}

Future<_RouterSession> _pumpRouter(
  WidgetTester tester, {
  required String initialLocation,
  ProjectState? projectState,
  ProjectGateDirectoryPicker? directoryPicker,
  ProjectGateProjectLoader? projectLoader,
  V2AddComponentWriter? addComponentWriter,
}) async {
  final container = ProviderContainer(
    overrides: [
      projectStateProvider.overrideWith((_) => projectState),
      if (directoryPicker != null)
        projectGateDirectoryPickerProvider.overrideWithValue(directoryPicker),
      if (projectLoader != null)
        projectGateProjectLoaderProvider.overrideWithValue(projectLoader),
      if (addComponentWriter != null)
        v2AddComponentWriterProvider.overrideWithValue(addComponentWriter),
    ],
  );
  final router = buildTraceBenchRouter(initialLocation: initialLocation);
  addTearDown(() {
    router.dispose();
    container.dispose();
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

  return _RouterSession(container: container, router: router);
}

class _RecordingAddComponentWriter implements V2AddComponentWriter {
  final List<V2AddComponentRequest> requests = <V2AddComponentRequest>[];

  @override
  Future<V2AddComponentResult> addComponent({
    required ProjectState projectState,
    required V2AddComponentRequest request,
  }) async {
    requests.add(request);
    return const V2AddComponentResult(
      status: V2AddComponentWriteStatus.existing,
      event: <String, dynamic>{},
      appended: false,
    );
  }
}

void main() {
  testWidgets(
    'null project keeps requested URI and shows shared recovery',
    (tester) async {
      final session = await _pumpRouter(
        tester,
        initialLocation: '/project/known-facts',
      );

      expect(
        session.router.routeInformationProvider.value.uri.path,
        '/project/known-facts',
      );
      expect(find.text('Projekt pole avatud'), findsOneWidget);
      expect(
        find.text('Selle vaate kasutamiseks ava TraceBenchi projekt.'),
        findsOneWidget,
      );
      expect(find.text('Ava projekt'), findsOneWidget);
      expect(find.text('Tagasi avalehele'), findsOneWidget);
      expect(find.byType(KnownFactsViewerScreen), findsNothing);
      expect(session.container.read(projectStateProvider), isNull);

      final gateContext = tester.element(find.byType(ProjectGate));
      final tokens = Theme.of(
        gateContext,
      ).extension<BenchBeepVisualTokens>()!;
      final recoveryScaffold = tester.widget<Scaffold>(
        find.descendant(
          of: find.byType(ProjectGate),
          matching: find.byType(Scaffold),
        ),
      );
      expect(recoveryScaffold.backgroundColor, tokens.surface);

      final recoveryPanel = tester.widget<DecoratedBox>(
        find.byKey(const Key('project_gate_recovery_panel')),
      );
      final panelDecoration = recoveryPanel.decoration as BoxDecoration;
      expect(panelDecoration.color, tokens.panel);
      expect((panelDecoration.border! as Border).top.color, tokens.rule);
    },
  );

  testWidgets('preloaded project renders the requested child immediately',
      (tester) async {
    final loaded = _loadedProject();
    final session = await _pumpRouter(
      tester,
      initialLocation: '/project/known-facts',
      projectState: loaded,
    );

    expect(find.byType(KnownFactsViewerScreen), findsOneWidget);
    expect(find.text('Projekt pole avatud'), findsNothing);
    expect(session.container.read(projectStateProvider), same(loaded));
    expect(
      session.router.routeInformationProvider.value.uri.path,
      '/project/known-facts',
    );
  });

  testWidgets('cancel keeps URI and recovery without invoking the loader',
      (tester) async {
    var pickerCalls = 0;
    var loaderCalls = 0;
    final session = await _pumpRouter(
      tester,
      initialLocation: '/project/known-facts',
      directoryPicker: () async {
        pickerCalls += 1;
        return null;
      },
      projectLoader: (_) async {
        loaderCalls += 1;
        return _loadedProject();
      },
    );

    await tester.tap(find.widgetWithText(FilledButton, 'Ava projekt'));
    await tester.pumpAndSettle();

    expect(pickerCalls, 1);
    expect(loaderCalls, 0);
    expect(session.container.read(projectStateProvider), isNull);
    expect(
      session.router.routeInformationProvider.value.uri.path,
      '/project/known-facts',
    );
    expect(find.text('Projekt pole avatud'), findsOneWidget);
  });

  testWidgets('typed load failure keeps URI, recovery, and existing feedback',
      (tester) async {
    final session = await _pumpRouter(
      tester,
      initialLocation: '/project/known-facts',
      directoryPicker: () async => r'C:\invalid',
      projectLoader: (_) async {
        throw const ProjectLoadException('invalid project');
      },
    );

    await tester.tap(find.widgetWithText(FilledButton, 'Ava projekt'));
    await tester.pumpAndSettle();

    expect(session.container.read(projectStateProvider), isNull);
    expect(
      session.router.routeInformationProvider.value.uri.path,
      '/project/known-facts',
    );
    expect(find.text('Projekt pole avatud'), findsOneWidget);
    expect(
      find.text('Valitud kaust ei ole kehtiv TraceBenchi projekt.'),
      findsOneWidget,
    );
  });

  testWidgets('generic load failure keeps URI, recovery, and existing feedback',
      (tester) async {
    final session = await _pumpRouter(
      tester,
      initialLocation: '/project/known-facts',
      directoryPicker: () async => r'C:\broken',
      projectLoader: (_) async {
        throw StateError('loader exploded');
      },
    );

    await tester.tap(find.widgetWithText(FilledButton, 'Ava projekt'));
    await tester.pumpAndSettle();

    expect(session.container.read(projectStateProvider), isNull);
    expect(
      session.router.routeInformationProvider.value.uri.path,
      '/project/known-facts',
    );
    expect(find.text('Projekt pole avatud'), findsOneWidget);
    expect(
      find.text(
        'Projekti kaustast avamine ebaõnnestus: '
        'Bad state: loader exploded',
      ),
      findsOneWidget,
    );
  });

  testWidgets('successful load reveals child without changing original URI',
      (tester) async {
    final loaded = _loadedProject(projectDirectory: r'C:\valid');
    String? loadedDirectory;
    final session = await _pumpRouter(
      tester,
      initialLocation: '/project/known-facts',
      directoryPicker: () async => r'C:\valid',
      projectLoader: (directory) async {
        loadedDirectory = directory;
        return loaded;
      },
    );

    await tester.tap(find.widgetWithText(FilledButton, 'Ava projekt'));
    await tester.pumpAndSettle();

    expect(loadedDirectory, r'C:\valid');
    expect(session.container.read(projectStateProvider), same(loaded));
    expect(
      session.router.routeInformationProvider.value.uri.path,
      '/project/known-facts',
    );
    expect(find.text('Projekt pole avatud'), findsNothing);
    expect(find.byType(KnownFactsViewerScreen), findsOneWidget);
  });

  testWidgets('home recovery action resolves to the root route',
      (tester) async {
    final session = await _pumpRouter(
      tester,
      initialLocation: '/project/known-facts',
    );

    await tester.tap(find.widgetWithText(TextButton, 'Tagasi avalehele'));
    await tester.pumpAndSettle();

    expect(session.router.routeInformationProvider.value.uri.path, '/');
    expect(find.byType(HomeScreen), findsOneWidget);
  });

  testWidgets('all 15 real project destinations use the shared gate',
      (tester) async {
    final session = await _pumpRouter(
      tester,
      initialLocation: _projectDestinations.first.path,
    );

    for (final destination in _projectDestinations) {
      session.router.go(destination.path);
      await tester.pumpAndSettle();

      expect(
        session.router.routeInformationProvider.value.uri.path,
        destination.path,
        reason: destination.path,
      );
      expect(find.byType(ProjectGate), findsOneWidget,
          reason: destination.path);
      expect(
        find.text('Projekt pole avatud'),
        findsOneWidget,
        reason: destination.path,
      );
      expect(
        find.byType(destination.childType),
        findsNothing,
        reason: destination.path,
      );
    }
  });

  testWidgets('legacy project redirects settle on their frozen destinations',
      (tester) async {
    final session = await _pumpRouter(
      tester,
      initialLocation: '/project/board-canvas',
    );

    expect(session.router.routeInformationProvider.value.uri.path, '/project');
    expect(find.byType(ProjectGate), findsOneWidget);
    expect(find.text('Projekt pole avatud'), findsOneWidget);

    session.router.go('/project/measurements/new');
    await tester.pumpAndSettle();

    expect(
      session.router.routeInformationProvider.value.uri.path,
      '/project/measure-sheet',
    );
    expect(find.byType(ProjectGate), findsOneWidget);
    expect(find.text('Projekt pole avatud'), findsOneWidget);
  });

  testWidgets('write-capable child reveal issues zero component writes',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(1000, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final loaded = _loadedProject(projectDirectory: r'C:\valid');
    final writer = _RecordingAddComponentWriter();
    final session = await _pumpRouter(
      tester,
      initialLocation: '/project/components/add',
      directoryPicker: () async => r'C:\valid',
      projectLoader: (_) async => loaded,
      addComponentWriter: writer,
    );

    expect(find.text('Projekt pole avatud'), findsOneWidget);
    expect(find.byType(AddComponentScreen), findsNothing);
    expect(writer.requests, isEmpty);

    await tester.tap(find.widgetWithText(FilledButton, 'Ava projekt'));
    await tester.pumpAndSettle();

    expect(
      session.router.routeInformationProvider.value.uri.path,
      '/project/components/add',
    );
    expect(session.container.read(projectStateProvider), same(loaded));
    expect(find.byType(AddComponentScreen), findsOneWidget);
    expect(writer.requests, isEmpty);
  });
}
