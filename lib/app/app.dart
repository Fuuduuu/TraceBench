import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../shared/models/project_state.dart';
import '../shared/theme/app_theme.dart';
import 'router.dart';

final StateProvider<ProjectState?> projectStateProvider = StateProvider<ProjectState?>((_) => null);
final StateProvider<bool> beginnerModeProvider = StateProvider<bool>((_) => true);

class TraceBenchApp extends ConsumerWidget {
  const TraceBenchApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = buildTraceBenchRouter();

    return MaterialApp.router(
      title: 'TraceBench Viewer',
      theme: buildTheme(),
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
