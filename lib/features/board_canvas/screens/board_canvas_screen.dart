import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/app.dart';
import '../../../shared/models/project_state.dart';

class BoardCanvasScreen extends ConsumerWidget {
  const BoardCanvasScreen({super.key});

  static const String noProjectText = 'Open a project to view its board.';
  static const String noComponentsText =
      'No components recorded for this project.';
  static const String noPlacementsText = 'No confirmed visual placements yet.';
  static const String noPlacementsSupportText =
      'Board canvas is read-only in V1. Placement workflow is a future step.';
  static const String deferredText = 'Board canvas rendering is deferred.';
  static const String rendererWritesNoneText = 'renderer writes: none';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ProjectState? projectState = ref.watch(projectStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Board canvas'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: _BoardCanvasStateBody(projectState: projectState),
              ),
            ),
          ),
          const Divider(height: 1),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: Text(
              rendererWritesNoneText,
              key: ValueKey('board-canvas-read-only-status'),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class _BoardCanvasStateBody extends StatelessWidget {
  const _BoardCanvasStateBody({required this.projectState});

  final ProjectState? projectState;

  @override
  Widget build(BuildContext context) {
    if (projectState == null) {
      return const Text(
        BoardCanvasScreen.noProjectText,
        key: ValueKey('board-canvas-empty-no-project'),
        textAlign: TextAlign.center,
      );
    }

    final components = projectState!.knownFacts.components;
    if (components.isEmpty) {
      return const Text(
        BoardCanvasScreen.noComponentsText,
        key: ValueKey('board-canvas-empty-no-components'),
        textAlign: TextAlign.center,
      );
    }

    final placements = projectState!.knownFacts.componentVisualPlacements;
    if (placements.isEmpty) {
      return const Column(
        key: ValueKey('board-canvas-empty-no-placements'),
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            BoardCanvasScreen.noPlacementsText,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Text(
            BoardCanvasScreen.noPlacementsSupportText,
            textAlign: TextAlign.center,
          ),
        ],
      );
    }

    return const Text(
      BoardCanvasScreen.deferredText,
      key: ValueKey('board-canvas-shell-deferred'),
      textAlign: TextAlign.center,
    );
  }
}
