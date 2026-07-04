import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:trace_bench_viewer/app/app.dart';
import 'package:trace_bench_viewer/features/project/screens/home_screen.dart';
import 'package:trace_bench_viewer/shared/models/known_facts.dart';
import 'package:trace_bench_viewer/shared/models/project_manifest.dart';
import 'package:trace_bench_viewer/shared/models/project_state.dart';
import 'package:trace_bench_viewer/shared/services/project_loader.dart';

class _FakeFilePicker extends FilePicker {
  _FakeFilePicker(this.result);

  final FilePickerResult? result;
  var pickCount = 0;
  var directoryPickCount = 0;
  FileType? requestedType;
  List<String>? requestedExtensions;
  bool? requestedWithData;
  bool? requestedAllowMultiple;
  String? requestedDirectoryDialogTitle;
  String? requestedDirectoryInitialDirectory;
  bool? requestedDirectoryLockParentWindow;

  @override
  Future<FilePickerResult?> pickFiles({
    String? dialogTitle,
    String? initialDirectory,
    FileType type = FileType.any,
    List<String>? allowedExtensions,
    Function(FilePickerStatus)? onFileLoading,
    bool allowCompression = true,
    int compressionQuality = 30,
    bool allowMultiple = false,
    bool withData = false,
    bool withReadStream = false,
    bool lockParentWindow = false,
    bool readSequential = false,
  }) async {
    pickCount += 1;
    requestedType = type;
    requestedExtensions = allowedExtensions;
    requestedWithData = withData;
    requestedAllowMultiple = allowMultiple;
    return result;
  }

  @override
  Future<String?> getDirectoryPath({
    String? dialogTitle,
    String? initialDirectory,
    bool lockParentWindow = false,
  }) async {
    directoryPickCount += 1;
    requestedDirectoryDialogTitle = dialogTitle;
    requestedDirectoryInitialDirectory = initialDirectory;
    requestedDirectoryLockParentWindow = lockParentWindow;
    return null;
  }
}

ProjectState _directoryBackedProjectState(String projectDirectory) {
  return ProjectState(
    manifest: const ProjectManifest(
      projectId: 'home_open_project',
      schemaVersion: '1.0',
      createdAt: '2026-07-04T00:00:00Z',
      deviceType: 'pelle',
      model: 'PV20',
      symptom: 'not_provided',
    ),
    knownFacts: const KnownFacts(
      projectId: 'home_open_project',
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
    customerReport: '# Home open report\n',
    projectDirectory: projectDirectory,
    isProjectionStale: false,
  );
}

Color _actionBorderColor(WidgetTester tester, Finder action) {
  final container = tester.widget<Container>(
    find.descendant(of: action, matching: find.byType(Container)).first,
  );
  final decoration = container.decoration! as BoxDecoration;
  return (decoration.border! as Border).top.color;
}

void main() {
  testWidgets('BenchBeep Home is a black/gold board-selection launcher', (
    tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: TraceBenchApp()));

    expect(
        find.byKey(const ValueKey('benchbeep_home_launcher')), findsOneWidget);
    final scaffold = tester.widget<Scaffold>(
      find.byKey(const ValueKey('benchbeep_home_launcher')),
    );
    expect(scaffold.backgroundColor, isNotNull);
    expect(scaffold.backgroundColor!.computeLuminance(), lessThan(0.05));

    expect(find.byKey(const ValueKey('benchbeep_home_title')), findsOneWidget);
    expect(find.text('bench'), findsOneWidget);
    expect(find.text('beep'), findsOneWidget);
    expect(
        find.text('Measurement Data Visualization'), findsAtLeastNWidgets(1));
    expect(find.text('TraceBench platform'), findsOneWidget);
    expect(find.text('TraceBench Viewer'), findsOneWidget);
    expect(
      find.image(const AssetImage('assets/brand/benchbeep_mark.png')),
      findsOneWidget,
    );
    expect(
      find.image(const AssetImage('assets/brand/pcb_board.png')),
      findsOneWidget,
    );

    expect(
        find.byKey(const ValueKey('benchbeep_app_menu_bar')), findsOneWidget);
    final menuBar = tester.widget<Container>(
      find.byKey(const ValueKey('benchbeep_app_menu_bar')),
    );
    final menuDecoration = menuBar.decoration! as BoxDecoration;
    expect(menuDecoration.color, isNotNull);
    expect(menuDecoration.color!.computeLuminance(), lessThan(0.12));

    expect(
        find.byKey(const ValueKey('benchbeep_menu_home_item')), findsOneWidget);
    final homePill = tester.widget<Container>(
      find
          .descendant(
            of: find.byKey(const ValueKey('benchbeep_menu_home_item')),
            matching: find.byType(Container),
          )
          .first,
    );
    final homePillDecoration = homePill.decoration! as BoxDecoration;
    expect(
      (homePillDecoration.border! as Border).top.color,
      const Color(0xFF6B5A30),
    );

    expect(
      find.byKey(const ValueKey('benchbeep_menu_workbench_button')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('benchbeep_menu_import_button')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('benchbeep_home_new_project_deferred')),
      findsOneWidget,
    );
    expect(find.text('Start new'), findsAtLeastNWidgets(1));
    final selectedCard = tester.widget<Container>(
      find
          .descendant(
            of: find.byKey(
              const ValueKey('benchbeep_home_open_workbench_button'),
            ),
            matching: find.byType(Container),
          )
          .first,
    );
    final selectedCardDecoration = selectedCard.decoration! as BoxDecoration;
    expect(
      (selectedCardDecoration.border! as Border).top.color,
      const Color(0xFF8A7338),
    );

    expect(find.byKey(const ValueKey('benchbeep_home_board_card')),
        findsOneWidget);
    expect(
      find.byKey(const ValueKey('benchbeep_home_open_workbench_button')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('benchbeep_home_import_project_button')),
      findsOneWidget,
    );
    final importAction = tester.widget<Material>(
      find
          .descendant(
            of: find
                .byKey(const ValueKey('benchbeep_home_import_project_button')),
            matching: find.byType(Material),
          )
          .first,
    );
    expect(importAction.color, isNotNull);
    expect(importAction.color!.computeLuminance(), lessThan(0.12));

    expect(find.text('Import project'), findsAtLeastNWidgets(1));
    expect(find.text('existing ZIP flow'), findsOneWidget);
    expect(find.text('Ava projekt kaustast'), findsAtLeastNWidgets(1));
    expect(
      find.text('existing local folder · writable when valid'),
      findsOneWidget,
    );
    expect(find.text('Ava näidisprojekt'), findsAtLeastNWidgets(1));
    expect(find.text('Ava projekt'), findsNothing);
    expect(find.text('OPEN EXISTING'), findsOneWidget);
    expect(find.text('Board workbench'), findsOneWidget);
    expect(find.text('QUICK START'), findsOneWidget);
    expect(find.text('& TUTORIALS'), findsOneWidget);
    expect(find.byKey(const ValueKey('benchbeep_home_safety_strip')),
        findsNothing);
    expect(find.text('Load sample'), findsNothing);
    expect(find.textContaining('Launcher only'), findsNothing);
    expect(find.text('Bench instrument launcher'), findsNothing);

    expect(find.textContaining('marketing'), findsNothing);
    expect(find.textContaining('Command menu'), findsNothing);
    expect(find.textContaining('Ctrl-K'), findsNothing);
    expect(find.textContaining('Save beep'), findsNothing);
    expect(find.textContaining('Confirm'), findsNothing);
    expect(find.textContaining('Edit Layout'), findsNothing);
  });

  testWidgets('BenchBeep Home wide desktop layout avoids intrinsic crash', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1280, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(const ProviderScope(child: TraceBenchApp()));
    await tester.pump();

    expect(tester.takeException(), isNull);
    expect(
        find.byKey(const ValueKey('benchbeep_home_launcher')), findsOneWidget);
    expect(find.byKey(const ValueKey('benchbeep_home_board_card')),
        findsOneWidget);
    expect(find.text('OPEN EXISTING'), findsOneWidget);
  });

  testWidgets('launcher action hover uses subtle gold accent', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: TraceBenchApp()));

    final importAction =
        find.byKey(const ValueKey('benchbeep_home_import_project_button'));
    await tester.ensureVisible(importAction);
    await tester.pump();
    expect(_actionBorderColor(tester, importAction), const Color(0xFF6B5A30));

    final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
    await gesture.addPointer(location: tester.getCenter(importAction));
    addTearDown(gesture.removePointer);
    await tester.pump();
    await gesture.moveTo(tester.getCenter(importAction));
    await tester.pump(const Duration(milliseconds: 140));

    expect(_actionBorderColor(tester, importAction), const Color(0xFFCDA64C));
  });

  testWidgets('launcher preserves bundled sample project handoff', (
    tester,
  ) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const TraceBenchApp(),
      ),
    );

    final sampleProjectButton =
        find.byKey(const ValueKey('benchbeep_home_sample_project_button'));
    await tester.ensureVisible(sampleProjectButton);
    await tester.pump();
    await tester.tap(sampleProjectButton);
    await tester.pumpAndSettle();

    expect(find.text('Ava projekt'), findsOneWidget);
    expect(container.read(projectStateProvider)!.projectDirectory, isNull);

    final openWorkbenchButton =
        find.byKey(const ValueKey('benchbeep_home_open_workbench_button'));
    await tester.ensureVisible(openWorkbenchButton);
    await tester.pump();
    await tester.tap(openWorkbenchButton);
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('benchbeep_home_launcher')), findsNothing);
    expect(find.byKey(const ValueKey('benchbeep_workbench_router')),
        findsOneWidget);
    expect(find.text('Project overview'), findsOneWidget);
  });

  testWidgets('launcher open folder cancel leaves project state unchanged', (
    tester,
  ) async {
    FilePicker? originalPicker;
    try {
      originalPicker = FilePicker.platform;
    } catch (_) {
      originalPicker = null;
    }
    final fakePicker = _FakeFilePicker(null);
    FilePicker.platform = fakePicker;
    addTearDown(() {
      final pickerToRestore = originalPicker;
      if (pickerToRestore != null) {
        FilePicker.platform = pickerToRestore;
      }
    });

    final container = ProviderContainer();
    addTearDown(container.dispose);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const TraceBenchApp(),
      ),
    );

    final cancelOpenFolderButton = find.text('Ava projekt kaustast');
    await tester.ensureVisible(cancelOpenFolderButton);
    await tester.tap(cancelOpenFolderButton);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 250));

    expect(fakePicker.directoryPickCount, 1);
    expect(
      fakePicker.requestedDirectoryDialogTitle,
      'Ava TraceBenchi projektikaust',
    );
    expect(container.read(projectStateProvider), isNull);
    expect(
      find.byKey(const ValueKey('benchbeep_home_launcher')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('benchbeep_workbench_router')),
      findsNothing,
    );
    expect(
      find.text('Valitud kaust ei ole kehtiv TraceBenchi projekt.'),
      findsNothing,
    );
  });

  testWidgets('open folder invalid selection shows clear error', (
    tester,
  ) async {
    final invalidDirectory =
        '${Directory.systemTemp.path}${Platform.pathSeparator}'
        'tracebench_missing_project_${DateTime.now().microsecondsSinceEpoch}';

    final container = ProviderContainer();
    addTearDown(container.dispose);
    late BuildContext actionContext;
    late WidgetRef actionRef;
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          home: Consumer(
            builder: (context, ref, _) {
              actionContext = context;
              actionRef = ref;
              return const Scaffold(
                body: Text('Folder open action harness'),
              );
            },
          ),
        ),
      ),
    );

    expect(container.read(projectStateProvider), isNull);

    await tester.runAsync(() async {
      await ProjectDirectoryOpenAction.openDirectory(
        context: actionContext,
        ref: actionRef,
        directoryPicker: () async => invalidDirectory,
        projectLoader: (_) async {
          throw const ProjectLoadException('invalid test folder');
        },
      ).timeout(
        const Duration(seconds: 3),
        onTimeout: () => throw TimeoutException(
          'ProjectDirectoryOpenAction.openDirectory did not complete '
          'for invalid folder',
        ),
      );
    });
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 250));

    expect(container.read(projectStateProvider), isNull);
    expect(
      find.text('Valitud kaust ei ole kehtiv TraceBenchi projekt.'),
      findsOneWidget,
    );
  });

  testWidgets('open folder action loads directory-backed project', (
    tester,
  ) async {
    final projectDirectory =
        '${Directory.systemTemp.path}${Platform.pathSeparator}'
        'tracebench_valid_project';
    String? loadedPath;

    final container = ProviderContainer();
    addTearDown(container.dispose);
    late BuildContext actionContext;
    late WidgetRef actionRef;
    var opened = false;
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          home: Consumer(
            builder: (context, ref, _) {
              actionContext = context;
              actionRef = ref;
              return const Scaffold(
                body: Text('Folder open action harness'),
              );
            },
          ),
        ),
      ),
    );

    await tester.runAsync(() async {
      await ProjectDirectoryOpenAction.openDirectory(
        context: actionContext,
        ref: actionRef,
        directoryPicker: () async => projectDirectory,
        projectLoader: (path) async {
          loadedPath = path;
          return _directoryBackedProjectState(path);
        },
        onOpened: () {
          opened = true;
        },
      ).timeout(
        const Duration(seconds: 3),
        onTimeout: () => throw TimeoutException(
          'ProjectDirectoryOpenAction.openDirectory did not complete '
          'for valid folder',
        ),
      );
    });
    await tester.pump();

    final loaded = container.read(projectStateProvider);
    expect(opened, isTrue);
    expect(loadedPath, projectDirectory);
    expect(loaded, isNotNull);
    expect(loaded!.projectDirectory, projectDirectory);
  });

  testWidgets('launcher opens the existing Workbench router', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: TraceBenchApp()));

    await tester.tap(
      find.byKey(const ValueKey('benchbeep_home_open_workbench_button')),
    );
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('benchbeep_home_launcher')), findsNothing);
    expect(find.byKey(const ValueKey('benchbeep_workbench_router')),
        findsOneWidget);

    final workbenchApp = tester.widget<MaterialApp>(
      find.byKey(const ValueKey('benchbeep_workbench_router')),
    );
    (workbenchApp.routerConfig! as GoRouter).go('/');
    await tester.pumpAndSettle();

    expect(
        find.byKey(const ValueKey('benchbeep_home_launcher')), findsOneWidget);
    expect(find.text('bench'), findsOneWidget);
    expect(find.text('beep'), findsOneWidget);
    expect(find.text('Import Project ZIP'), findsNothing);
    expect(find.text('Read-only Project ZIP Viewer'), findsNothing);

    expect(find.textContaining('Command menu'), findsNothing);
    expect(find.textContaining('Ctrl-K'), findsNothing);
    expect(find.textContaining('Save beep'), findsNothing);
    expect(find.textContaining('Confirm'), findsNothing);
    expect(find.textContaining('Edit Layout'), findsNothing);
  });

  testWidgets('launcher menu workbench affordance opens existing router', (
    tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: TraceBenchApp()));

    await tester.tap(
      find.byKey(const ValueKey('benchbeep_menu_workbench_button')),
    );
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('benchbeep_home_launcher')), findsNothing);
    expect(find.byKey(const ValueKey('benchbeep_workbench_router')),
        findsOneWidget);
    expect(find.text('Board Canvas'), findsAtLeastNWidgets(1));

    expect(find.textContaining('Command menu'), findsNothing);
    expect(find.textContaining('Ctrl-K'), findsNothing);
    expect(find.textContaining('Save beep'), findsNothing);
    expect(find.textContaining('Confirm'), findsNothing);
    expect(find.textContaining('Edit Layout'), findsNothing);
  });

  testWidgets('launcher import project invokes existing ZIP flow directly', (
    tester,
  ) async {
    FilePicker? originalPicker;
    try {
      originalPicker = FilePicker.platform;
    } catch (_) {
      originalPicker = null;
    }
    final fakePicker = _FakeFilePicker(null);
    FilePicker.platform = fakePicker;
    addTearDown(() {
      final pickerToRestore = originalPicker;
      if (pickerToRestore != null) {
        FilePicker.platform = pickerToRestore;
      }
    });

    await tester.pumpWidget(const ProviderScope(child: TraceBenchApp()));

    final importButton =
        find.byKey(const ValueKey('benchbeep_home_import_project_button'));
    await tester.ensureVisible(importButton);
    await tester.pump();
    await tester.tap(importButton);
    await tester.pumpAndSettle();

    expect(fakePicker.pickCount, 1);
    expect(fakePicker.requestedType, FileType.custom);
    expect(fakePicker.requestedExtensions, const ['zip']);
    expect(fakePicker.requestedWithData, isTrue);
    expect(fakePicker.requestedAllowMultiple, isFalse);
    expect(
        find.byKey(const ValueKey('benchbeep_home_launcher')), findsOneWidget);
    expect(
        find.byKey(const ValueKey('benchbeep_workbench_router')), findsNothing);
    expect(find.text('Import Project ZIP'), findsNothing);
    expect(find.text('Read-only Project ZIP Viewer'), findsNothing);
    expect(find.text('existing ZIP flow'), findsOneWidget);

    expect(find.textContaining('Command menu'), findsNothing);
    expect(find.textContaining('Ctrl-K'), findsNothing);
    expect(find.textContaining('Save beep'), findsNothing);
    expect(find.textContaining('Confirm'), findsNothing);
    expect(find.textContaining('Edit Layout'), findsNothing);
  });

  testWidgets('launcher menu import invokes existing ZIP flow directly', (
    tester,
  ) async {
    FilePicker? originalPicker;
    try {
      originalPicker = FilePicker.platform;
    } catch (_) {
      originalPicker = null;
    }
    final fakePicker = _FakeFilePicker(null);
    FilePicker.platform = fakePicker;
    addTearDown(() {
      final pickerToRestore = originalPicker;
      if (pickerToRestore != null) {
        FilePicker.platform = pickerToRestore;
      }
    });

    await tester.pumpWidget(const ProviderScope(child: TraceBenchApp()));

    await tester
        .tap(find.byKey(const ValueKey('benchbeep_menu_import_button')));
    await tester.pumpAndSettle();

    expect(fakePicker.pickCount, 1);
    expect(fakePicker.requestedType, FileType.custom);
    expect(fakePicker.requestedExtensions, const ['zip']);
    expect(fakePicker.requestedWithData, isTrue);
    expect(fakePicker.requestedAllowMultiple, isFalse);
    expect(
        find.byKey(const ValueKey('benchbeep_home_launcher')), findsOneWidget);
    expect(
        find.byKey(const ValueKey('benchbeep_workbench_router')), findsNothing);
    expect(find.text('Import Project ZIP'), findsNothing);
    expect(find.text('Read-only Project ZIP Viewer'), findsNothing);

    expect(find.textContaining('Command menu'), findsNothing);
    expect(find.textContaining('Ctrl-K'), findsNothing);
    expect(find.textContaining('Save beep'), findsNothing);
    expect(find.textContaining('Confirm'), findsNothing);
    expect(find.textContaining('Edit Layout'), findsNothing);
  });
}
