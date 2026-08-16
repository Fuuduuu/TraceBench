import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/app.dart';
import '../../../shared/models/project_state.dart';
import '../../../shared/theme/app_theme.dart';
import '../screens/home_screen.dart';

typedef ProjectGateDirectoryPicker = Future<String?> Function();
typedef ProjectGateProjectLoader = Future<ProjectState> Function(
  String projectDirectory,
);

final Provider<ProjectGateDirectoryPicker?> projectGateDirectoryPickerProvider =
    Provider<ProjectGateDirectoryPicker?>((_) => null);
final Provider<ProjectGateProjectLoader?> projectGateProjectLoaderProvider =
    Provider<ProjectGateProjectLoader?>((_) => null);

class ProjectGate extends ConsumerWidget {
  const ProjectGate({
    super.key,
    required this.child,
  });

  final Widget child;

  Future<void> _openProject(BuildContext context, WidgetRef ref) async {
    await ProjectDirectoryOpenAction.openDirectory(
      context: context,
      ref: ref,
      directoryPicker: ref.read(projectGateDirectoryPickerProvider),
      projectLoader: ref.read(projectGateProjectLoaderProvider),
      onOpened: () {},
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (ref.watch(projectStateProvider) != null) {
      return child;
    }

    final tokens = Theme.of(context).extension<BenchBeepVisualTokens>() ??
        BenchBeepVisualTokens.darkInstrument;

    return Scaffold(
      backgroundColor: tokens.surface,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: DecoratedBox(
              key: const Key('project_gate_recovery_panel'),
              decoration: BoxDecoration(
                color: tokens.panel,
                border: Border.all(color: tokens.rule),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(28),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.folder_off_outlined,
                      color: tokens.textMuted,
                      size: 32,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Projekt pole avatud',
                      style: TextStyle(
                        color: tokens.textPrimary,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Selle vaate kasutamiseks ava TraceBenchi projekt.',
                      style: TextStyle(color: tokens.textSecondary),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 12,
                      runSpacing: 8,
                      children: [
                        FilledButton(
                          style: FilledButton.styleFrom(
                            backgroundColor: tokens.measuringArmedMeasured,
                            foregroundColor: tokens.surface,
                          ),
                          onPressed: () => _openProject(context, ref),
                          child: const Text('Ava projekt'),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: tokens.textSecondary,
                          ),
                          onPressed: () => context.go('/'),
                          child: const Text('Tagasi avalehele'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
