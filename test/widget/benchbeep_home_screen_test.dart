import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trace_bench_viewer/app/app.dart';
import 'package:trace_bench_viewer/features/home/screens/benchbeep_home_screen.dart';
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

Widget _homeHarness({
  bool hasProject = false,
  Future<void> Function()? onLoadBundledProject,
  Future<void> Function(BuildContext context)? onImportProject,
  Future<void> Function(BuildContext context)? onOpenProjectFolder,
  VoidCallback? onOpenProject,
  VoidCallback? onOpenWorkbench,
  Future<void> Function()? onExitRequested,
}) {
  return MaterialApp(
    home: BenchBeepHomeScreen(
      hasProject: hasProject,
      onLoadBundledProject: onLoadBundledProject ?? () async {},
      onImportProject: onImportProject ?? (_) async {},
      onOpenProjectFolder: onOpenProjectFolder ?? (_) async {},
      onOpenProject: onOpenProject ?? () {},
      onOpenWorkbench: onOpenWorkbench ?? () {},
      onExitRequested: onExitRequested ?? () async {},
    ),
  );
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
    expect(find.text('bench'), findsAtLeastNWidgets(1));
    expect(find.text('beep'), findsAtLeastNWidgets(1));
    expect(find.text('Alusta tööd'), findsAtLeastNWidgets(1));
    expect(find.text('VISUAL-FIRST TECHNICIAN WORKBENCH'), findsOneWidget);
    expect(find.text('Visuaalne remonditöölaud'), findsOneWidget);
    expect(
      find.text(
        'Foto, markerid, mõõtmised ja inimese kinnitatud tähelepanekud '
        'ühel visuaalsel töölaual.',
      ),
      findsOneWidget,
    );
    expect(find.text('PLAAT JÄÄB KESKSEKS'), findsOneWidget);
    expect(
      find.text(
        'Mõõtmised, markerid ja kinnitused jäävad alati plaadi '
        'visuaalsesse konteksti.',
      ),
      findsOneWidget,
    );
    expect(find.text('TraceBench platform'), findsNothing);
    expect(find.text('TraceBench platvorm'), findsNothing);
    expect(
      find.text('TraceBench Viewer', skipOffstage: false),
      findsNothing,
    );
    expect(
      find.byKey(
        const ValueKey('benchbeep_legacy_viewer_test_anchor'),
        skipOffstage: false,
      ),
      findsNothing,
    );
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
      find.byKey(const ValueKey('benchbeep_home_settings_button')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('benchbeep_home_exit_button')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('benchbeep_home_new_project_deferred')),
      findsOneWidget,
    );
    expect(find.text('Loo projekt nullist'), findsOneWidget);
    expect(find.text('Jätka avatud projektiga'), findsOneWidget);
    expect(find.text('Lae projekt'), findsAtLeastNWidgets(1));
    expect(find.text('Seadista telefon'), findsOneWidget);
    expect(find.text('Tulekul'), findsNWidgets(3));
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
      const Color(0xFF332E22),
    );
    final continueAction = tester.widget<InkWell>(
      find
          .descendant(
            of: find.byKey(
              const ValueKey('benchbeep_home_open_workbench_button'),
            ),
            matching: find.byType(InkWell),
          )
          .first,
    );
    expect(continueAction.onTap, isNull);
    for (final disabledKey in [
      const ValueKey('benchbeep_home_new_project_deferred'),
      const ValueKey('benchbeep_home_phone_setup_deferred'),
    ]) {
      final disabledAction = tester.widget<InkWell>(
        find
            .descendant(
              of: find.byKey(disabledKey),
              matching: find.byType(InkWell),
            )
            .first,
      );
      expect(disabledAction.onTap, isNull);
    }
    final settingsButton = tester.widget<TextButton>(
      find.byKey(const ValueKey('benchbeep_home_settings_button')),
    );
    expect(settingsButton.onPressed, isNull);

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

    expect(find.text('Ava ZIP'), findsOneWidget);
    expect(find.text('Ava kaust'), findsOneWidget);
    expect(find.text('Ava näidisprojekt'), findsOneWidget);
    expect(find.text('Ühtegi projekti pole avatud'), findsOneWidget);
    expect(find.text('ALUSTA'), findsOneWidget);
    expect(find.text('Lae projekt sisse'), findsOneWidget);
    for (final removedCopy in [
      'Instrument menu',
      'Home',
      'Workbench',
      'Import',
      'Start new',
      'OPEN EXISTING',
      'Board workbench',
      'QUICK START',
      '& TUTORIALS',
    ]) {
      expect(find.text(removedCopy), findsNothing);
    }
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

  testWidgets('launcher has no hidden legacy compatibility anchors', (
    tester,
  ) async {
    await tester.pumpWidget(_homeHarness(hasProject: true));

    expect(
      find.byKey(const ValueKey('benchbeep_home_launcher')),
      findsOneWidget,
    );
    expect(find.text('Visuaalne remonditöölaud'), findsOneWidget);
    expect(find.text('Jätka avatud projektiga'), findsOneWidget);
    expect(
      find.byKey(
        const ValueKey('benchbeep_legacy_viewer_test_anchor'),
        skipOffstage: false,
      ),
      findsNothing,
    );
    expect(
      find.text('TraceBench Viewer', skipOffstage: false),
      findsNothing,
    );
    expect(find.text('Ava projekt', skipOffstage: false), findsNothing);
  });

  testWidgets('wide layout keeps choices left and stacks detail over hero', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1600, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(_homeHarness(hasProject: true));
    await tester.pump();

    expect(tester.takeException(), isNull);
    final rail = find.byKey(const ValueKey('benchbeep_home_board_card'));
    final menu = find.byKey(const ValueKey('benchbeep_app_menu_bar'));
    final detail = find.byKey(const ValueKey('benchbeep_home_detail_panel'));
    final hero = find.byKey(const ValueKey('benchbeep_home_hero_band'));
    final heroImage = find.byKey(const ValueKey('benchbeep_home_hero_image'));
    expect(rail, findsOneWidget);
    expect(menu, findsOneWidget);
    expect(detail, findsOneWidget);
    expect(hero, findsOneWidget);
    expect(heroImage, findsOneWidget);

    final menuRect = tester.getRect(menu);
    final railRect = tester.getRect(rail);
    final detailRect = tester.getRect(detail);
    final heroRect = tester.getRect(hero);
    final heroImageRect = tester.getRect(heroImage);
    expect(menuRect.left, closeTo(20, 1));
    expect(menuRect.top, closeTo(20, 1));
    expect(menuRect.right, closeTo(1580, 1));
    expect(menuRect.height, closeTo(64, 1));
    expect(railRect.left, closeTo(20, 1));
    expect(railRect.width, closeTo(392, 1));
    expect(railRect.right, lessThan(detailRect.left));
    expect(detailRect.left - railRect.right, closeTo(18, 1));
    expect(detailRect.right, closeTo(1580, 1));
    expect(detailRect.height, closeTo(320, 1));
    expect(heroRect.left, closeTo(detailRect.left, 1));
    expect(heroRect.right, closeTo(detailRect.right, 1));
    expect(heroRect.top, greaterThan(detailRect.bottom));
    expect(heroRect.bottom, closeTo(880, 1));
    expect(heroImageRect.left, greaterThan(heroRect.center.dx));
    expect(heroImageRect.top, greaterThanOrEqualTo(heroRect.top + 20));
    expect(heroImageRect.right, lessThanOrEqualTo(heroRect.right - 20));

    expect(find.text('AVATUD PROJEKT'), findsOneWidget);
    expect(find.text('Jätka visuaalsel töölaual'), findsOneWidget);
    expect(
      find.text('Pelle PV20 · jätka sealt, kus töö pooleli jäi.'),
      findsOneWidget,
    );
    expect(find.text('Ava töölaud'), findsOneWidget);
    expect(
      find.descendant(
        of: detail,
        matching: find.byKey(
          const ValueKey('benchbeep_home_sample_project_button'),
        ),
      ),
      findsOneWidget,
    );
  });

  testWidgets('medium layout stacks the hierarchy with all actions reachable', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1180, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    var zipCount = 0;
    var folderCount = 0;
    await tester.pumpWidget(
      _homeHarness(
        hasProject: true,
        onImportProject: (_) async => zipCount += 1,
        onOpenProjectFolder: (_) async => folderCount += 1,
      ),
    );
    await tester.pump();

    expect(tester.takeException(), isNull);
    final rail = find.byKey(const ValueKey('benchbeep_home_board_card'));
    final detail = find.byKey(const ValueKey('benchbeep_home_detail_panel'));
    expect(tester.getRect(rail).bottom, lessThan(tester.getRect(detail).top));

    for (final key in [
      const ValueKey('benchbeep_home_new_project_deferred'),
      const ValueKey('benchbeep_home_open_workbench_button'),
      const ValueKey('benchbeep_home_load_project_choice'),
      const ValueKey('benchbeep_home_phone_setup_deferred'),
    ]) {
      expect(find.byKey(key), findsOneWidget);
    }

    final loadChoice =
        find.byKey(const ValueKey('benchbeep_home_load_project_choice'));
    await tester.ensureVisible(loadChoice);
    await tester.tap(loadChoice);
    await tester.pumpAndSettle();
    expect(zipCount, 0);
    expect(folderCount, 0);

    for (final key in [
      const ValueKey('benchbeep_home_import_project_button'),
      const ValueKey('benchbeep_home_open_folder_button'),
      const ValueKey('benchbeep_home_sample_project_button'),
      const ValueKey('benchbeep_home_hero_band'),
    ]) {
      final target = find.byKey(key);
      expect(target, findsOneWidget);
      await tester.ensureVisible(target);
      await tester.pump();
      expect(tester.getRect(target).bottom, lessThanOrEqualTo(900));
      expect(tester.takeException(), isNull);
    }
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

    expect(find.text('Jätka avatud projektiga'), findsOneWidget);
    expect(find.text('Projekt avatud'), findsOneWidget);
    expect(container.read(projectStateProvider)!.projectDirectory, isNull);

    final openWorkbenchButton =
        find.byKey(const ValueKey('benchbeep_home_open_workbench_button'));
    await tester.ensureVisible(openWorkbenchButton);
    await tester.pump();
    final continueAction = tester.widget<InkWell>(
      find
          .descendant(
            of: openWorkbenchButton,
            matching: find.byType(InkWell),
          )
          .first,
    );
    expect(continueAction.onTap, isNotNull);
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

    final cancelOpenFolderButton = find.text('Ava kaust');
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

  testWidgets('launcher cannot continue without a loaded project', (
    tester,
  ) async {
    var openProjectCount = 0;
    var openWorkbenchCount = 0;
    await tester.pumpWidget(
      _homeHarness(
        onOpenProject: () => openProjectCount += 1,
        onOpenWorkbench: () => openWorkbenchCount += 1,
      ),
    );

    final continueButton =
        find.byKey(const ValueKey('benchbeep_home_open_workbench_button'));
    final continueInkWell = tester.widget<InkWell>(
      find.descendant(of: continueButton, matching: find.byType(InkWell)).first,
    );
    expect(continueInkWell.onTap, isNull);
    await tester.tap(continueButton);
    await tester.pump();

    expect(openProjectCount, 0);
    expect(openWorkbenchCount, 0);
  });

  testWidgets('load parent reveals load detail without invoking pickers', (
    tester,
  ) async {
    var zipCount = 0;
    var folderCount = 0;
    await tester.pumpWidget(
      _homeHarness(
        hasProject: true,
        onImportProject: (_) async => zipCount += 1,
        onOpenProjectFolder: (_) async => folderCount += 1,
      ),
    );

    expect(find.text('AVATUD PROJEKT'), findsOneWidget);
    final loadChoice =
        find.byKey(const ValueKey('benchbeep_home_load_project_choice'));
    await tester.ensureVisible(loadChoice);
    await tester.tap(loadChoice);
    await tester.pumpAndSettle();

    expect(zipCount, 0);
    expect(folderCount, 0);
    expect(
      find.byKey(const ValueKey('benchbeep_home_load_detail')),
      findsOneWidget,
    );
    expect(find.text('AVATUD PROJEKT'), findsNothing);

    final zipButton =
        find.byKey(const ValueKey('benchbeep_home_import_project_button'));
    await tester.ensureVisible(zipButton);
    await tester.tap(zipButton);
    await tester.pump();
    expect(zipCount, 1);
    expect(folderCount, 0);

    final folderButton =
        find.byKey(const ValueKey('benchbeep_home_open_folder_button'));
    await tester.ensureVisible(folderButton);
    await tester.tap(folderButton);
    await tester.pump();
    expect(zipCount, 1);
    expect(folderCount, 1);
  });

  testWidgets('loaded project keeps direct board canvas handoff', (
    tester,
  ) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    container.read(projectStateProvider.notifier).state =
        _directoryBackedProjectState('C:\\projects\\loaded_home');
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const TraceBenchApp(),
      ),
    );

    final boardCanvasButton =
        find.byKey(const ValueKey('benchbeep_home_open_board_canvas_button'));
    await tester.ensureVisible(boardCanvasButton);
    await tester.tap(boardCanvasButton);
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
    expect(find.text('kaasaskantav projektifail'), findsOneWidget);

    expect(find.textContaining('Command menu'), findsNothing);
    expect(find.textContaining('Ctrl-K'), findsNothing);
    expect(find.textContaining('Save beep'), findsNothing);
    expect(find.textContaining('Confirm'), findsNothing);
    expect(find.textContaining('Edit Layout'), findsNothing);
  });

  testWidgets('exit dialog cancels safely and confirms exactly once', (
    tester,
  ) async {
    var exitCount = 0;
    await tester.pumpWidget(
      _homeHarness(onExitRequested: () async => exitCount += 1),
    );

    await tester.tap(
      find.byKey(const ValueKey('benchbeep_home_exit_button')),
    );
    await tester.pumpAndSettle();

    expect(find.text('Kas väljuda BenchBeepist?'), findsOneWidget);
    expect(find.text('Rakendus suletakse.'), findsOneWidget);
    expect(find.textContaining('salvest'), findsNothing);
    expect(find.text('Tühista'), findsOneWidget);
    expect(
      find.byKey(const ValueKey('benchbeep_exit_confirm_button')),
      findsOneWidget,
    );
    final dialog = tester.widget<AlertDialog>(find.byType(AlertDialog));
    expect(dialog.backgroundColor, const Color(0xFF1A1916));
    expect(dialog.titleTextStyle!.color, const Color(0xFFF3ECDC));
    expect(dialog.contentTextStyle!.color, const Color(0xFFA89F8C));
    final dialogShape = dialog.shape! as RoundedRectangleBorder;
    expect(dialogShape.side.color, const Color(0xFF8A7338));
    expect(
      find.descendant(
        of: find.byType(AlertDialog),
        matching: find.byIcon(Icons.power_settings_new),
      ),
      findsNothing,
    );
    final confirmButton = tester.widget<TextButton>(
      find.byKey(const ValueKey('benchbeep_exit_confirm_button')),
    );
    expect(
      confirmButton.style!.foregroundColor!.resolve(<WidgetState>{}),
      const Color(0xFFE08A55),
    );
    expect(
      confirmButton.style!.side!.resolve(<WidgetState>{})!.color,
      const Color(0xFFE08A55),
    );

    await tester.tap(find.text('Tühista'));
    await tester.pumpAndSettle();
    expect(exitCount, 0);
    expect(find.text('Kas väljuda BenchBeepist?'), findsNothing);

    await tester.tap(
      find.byKey(const ValueKey('benchbeep_home_exit_button')),
    );
    await tester.pumpAndSettle();
    await tester.tap(
      find.byKey(const ValueKey('benchbeep_exit_confirm_button')),
    );
    await tester.pumpAndSettle();

    expect(exitCount, 1);
    expect(find.text('Kas väljuda BenchBeepist?'), findsNothing);
  });
}
