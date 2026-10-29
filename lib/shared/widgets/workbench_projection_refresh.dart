import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/project_state.dart';
import '../services/project_projection_refresher.dart';
import '../session/project_session.dart';
import '../theme/app_theme.dart';

final projectProjectionRefresherProvider = Provider<ProjectProjectionRefresher>(
  (_) => ProjectProjectionRefresher(),
);

/// One explicit refresh affordance shared by Canvas and secondary destinations.
/// Its local theme never reaches the existing destination content.
class WorkbenchProjectionRefresh extends ConsumerStatefulWidget {
  const WorkbenchProjectionRefresh({required this.child, super.key});

  final Widget child;

  @override
  ConsumerState<WorkbenchProjectionRefresh> createState() =>
      _WorkbenchProjectionRefreshState();
}

class _WorkbenchProjectionRefreshState
    extends ConsumerState<WorkbenchProjectionRefresh> {
  bool _busy = false;
  String? _error;
  ProjectState? _attemptProject;
  int? _attemptGeneration;

  bool _sameContext(ProjectState? current, int generation) =>
      current != null &&
      generation == _attemptGeneration &&
      current.manifest.projectId == _attemptProject?.manifest.projectId &&
      current.projectDirectory == _attemptProject?.projectDirectory;

  Future<void> _refresh() async {
    if (_busy) return;
    final snapshot = ref.read(projectStateProvider);
    if (snapshot == null) return;
    final session = ref.read(projectStateProvider.notifier);
    final generation = session.generation;
    setState(() {
      _busy = true;
      _error = null;
      _attemptProject = snapshot;
      _attemptGeneration = generation;
    });
    try {
      final loaded =
          await ref.read(projectProjectionRefresherProvider).refresh(snapshot);
      if (!mounted) return;
      final current = ref.read(projectStateProvider);
      if (!_sameContext(current, session.generation)) return;
      // Session performs the final snapshot/history guards and projection-only
      // adoption atomically, without invalidating a same-project pending save.
      if (!session.adoptRefreshedProjection(
        loaded,
        expectedState: snapshot,
        generation: generation,
      )) {
        setState(() {
          _error = 'Vahepeal salvestati uusi andmeid. Värskenda uuesti.';
        });
      }
    } catch (error) {
      if (!mounted ||
          !_sameContext(ref.read(projectStateProvider), session.generation)) {
        return;
      }
      setState(() {
        _error = error is ProjectionRefreshException
            ? error.message
            : 'Andmete värskendamine ebaõnnestus. Proovi uuesti.';
      });
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final project = ref.watch(projectStateProvider);
    final generation = ref.read(projectStateProvider.notifier).generation;
    final error = _sameContext(project, generation) ? _error : null;
    return Column(
      key: const Key('workbench-projection-refresh'),
      children: [
        if (project?.isProjectionStale == true)
          Theme(
            data: buildWorkbenchTheme(),
            child: Material(
              color: WorkbenchColors.paper,
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: SizedBox(
                    width: double.infinity,
                    child: Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 12,
                      runSpacing: 6,
                      children: [
                        Semantics(
                          liveRegion: true,
                          child: Text(error ??
                              (_busy
                                  ? 'Värskendan andmeid…'
                                  : 'Salvestatud andmed vajavad värskendamist.')),
                        ),
                        FilledButton.icon(
                          key: const Key('workbench-refresh-button'),
                          onPressed: _busy ? null : _refresh,
                          icon: _busy
                              ? const SizedBox.square(
                                  dimension: 16,
                                  child:
                                      CircularProgressIndicator(strokeWidth: 2),
                                )
                              : const Icon(Icons.refresh),
                          label: const Text('Värskenda andmeid'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        else
          const SizedBox.shrink(),
        Expanded(child: widget.child),
      ],
    );
  }
}
