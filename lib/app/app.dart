import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:window_manager/window_manager.dart';

import '../features/home/screens/benchbeep_home_screen.dart';
import '../features/home/screens/benchbeep_splash_screen.dart';
import '../features/project/screens/home_screen.dart';
import '../shared/models/project_state.dart';
import '../shared/services/project_loader.dart';
import '../shared/theme/app_theme.dart';
import 'router.dart';

final StateProvider<ProjectState?> projectStateProvider =
    StateProvider<ProjectState?>((_) => null);
final StateProvider<bool> beginnerModeProvider =
    StateProvider<bool>((_) => true);
final Provider<GoRouter> routerProvider = Provider<GoRouter>((ref) {
  return buildTraceBenchRouter();
});

class TraceBenchApp extends ConsumerStatefulWidget {
  const TraceBenchApp({super.key});

  @override
  ConsumerState<TraceBenchApp> createState() => _TraceBenchAppState();
}

class _TraceBenchAppState extends ConsumerState<TraceBenchApp> {
  bool _showLauncher = true;
  bool _showStartupIntro = true;
  GoRouter? _workbenchRouter;

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
          onOpenProject: () => _openWorkbench(initialLocation: '/project'),
          onOpenWorkbench: _openWorkbench,
          onExitRequested: windowManager.close,
        );
      },
    );
  }

  void _completeStartupIntro() {
    if (!_showStartupIntro || !mounted) {
      return;
    }
    setState(() {
      _showStartupIntro = false;
    });
  }

  Widget _buildLauncherShell(BuildContext context) {
    final launcher = _buildLauncherHome(context);
    if (!_showStartupIntro) {
      return launcher;
    }
    return Stack(
      fit: StackFit.expand,
      children: [
        launcher,
        IgnorePointer(
          child: BenchBeepSplashScreen(onComplete: _completeStartupIntro),
        ),
      ],
    );
  }

  void _openWorkbench({String initialLocation = '/project'}) {
    _workbenchRouter?.dispose();
    _workbenchRouter = buildTraceBenchRouter(
      initialLocation: initialLocation,
      homeBuilder: _buildLauncherHome,
    );
    setState(() {
      _showLauncher = false;
    });
  }

  @override
  void dispose() {
    _workbenchRouter?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = buildTheme();

    if (_showLauncher) {
      return MaterialApp(
        title: 'BenchBeep',
        theme: theme,
        debugShowCheckedModeBanner: false,
        home: _buildLauncherShell(context),
      );
    }

    final router =
        _workbenchRouter ?? buildTraceBenchRouter(initialLocation: '/project');

    return MaterialApp.router(
      key: const ValueKey('benchbeep_workbench_router'),
      title: 'BenchBeep',
      theme: theme,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
