import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:window_manager/window_manager.dart';

import '../features/home/screens/benchbeep_home_screen.dart';
import '../features/home/screens/benchbeep_splash_screen.dart';
import '../features/project/actions/project_acquisition_actions.dart';
import '../features/project/screens/new_project_wizard_screen.dart';
import '../shared/models/project_state.dart';
import '../shared/services/project_creator.dart';
import '../shared/services/project_loader.dart';
import '../shared/theme/app_theme.dart';
import 'router.dart';

final StateProvider<ProjectState?> projectStateProvider =
    StateProvider<ProjectState?>((_) => null);
final StateProvider<bool> beginnerModeProvider =
    StateProvider<bool>((_) => true);

class TraceBenchApp extends ConsumerStatefulWidget {
  const TraceBenchApp({
    super.key,
    this.createProject,
  });

  final Future<ProjectCreationResult> Function(ProjectCreationRequest)?
      createProject;

  @override
  ConsumerState<TraceBenchApp> createState() => _TraceBenchAppState();
}

class _TraceBenchAppState extends ConsumerState<TraceBenchApp> {
  final ValueNotifier<bool> _showStartupIntro = ValueNotifier<bool>(true);
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = _buildWorkbenchRouter();
  }

  Future<void> _loadBundledProject() async {
    final loaded = await ProjectLoader.loadFromAssets();
    if (!mounted) {
      return;
    }
    ref.read(projectStateProvider.notifier).state = loaded;
  }

  Future<void> _importProjectZip(BuildContext context) async {
    await ProjectZipImportAction.importZip(
      context: context,
      ref: ref,
      onImported: () => _openWorkbench(initialLocation: '/project'),
    );
  }

  Future<void> _openProjectDirectory(BuildContext context) async {
    await ProjectDirectoryOpenAction.openDirectory(
      context: context,
      ref: ref,
      onOpened: () => _openWorkbench(initialLocation: '/project'),
    );
  }

  Widget _buildLauncherHome(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final hasProject = ref.watch(projectStateProvider) != null;
        return BenchBeepHomeScreen(
          hasProject: hasProject,
          onLoadBundledProject: _loadBundledProject,
          onImportProject: _importProjectZip,
          onOpenProjectFolder: _openProjectDirectory,
          onCreateProject: () =>
              _openWorkbench(initialLocation: '/new-project'),
          onOpenProject: () => _openWorkbench(initialLocation: '/project'),
          onOpenWorkbench: _openWorkbench,
          onExitRequested: windowManager.close,
        );
      },
    );
  }

  void _completeStartupIntro() {
    if (!_showStartupIntro.value || !mounted) {
      return;
    }
    _showStartupIntro.value = false;
  }

  Widget _buildLauncherShell(BuildContext context) {
    final launcher = _buildLauncherHome(context);
    return ValueListenableBuilder<bool>(
      valueListenable: _showStartupIntro,
      child: launcher,
      builder: (context, showStartupIntro, launcher) {
        if (!showStartupIntro) {
          return launcher!;
        }
        return Stack(
          fit: StackFit.expand,
          children: [
            launcher!,
            IgnorePointer(
              child: BenchBeepSplashScreen(onComplete: _completeStartupIntro),
            ),
          ],
        );
      },
    );
  }

  void _openWorkbench({String initialLocation = '/project'}) {
    _showStartupIntro.value = false;
    _router.go(initialLocation);
  }

  GoRouter _buildWorkbenchRouter() {
    return buildTraceBenchRouter(
      initialLocation: '/',
      homeBuilder: _buildLauncherShell,
      newProjectBuilder: (_) => NewProjectWizardScreen(
        createProject: widget.createProject,
        onProjectCreated: (projectState) {
          ref.read(projectStateProvider.notifier).state = projectState;
        },
      ),
    );
  }

  @override
  void dispose() {
    _router.dispose();
    _showStartupIntro.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = buildTheme();

    return MaterialApp.router(
      key: const ValueKey('benchbeep_workbench_router'),
      title: 'BenchBeep',
      theme: theme,
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}
