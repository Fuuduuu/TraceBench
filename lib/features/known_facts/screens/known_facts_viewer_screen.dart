import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/session/project_session.dart';
import '../../../shared/widgets/projection_stale_banner.dart';
import '../../project/widgets/workbench_shell.dart';

class KnownFactsViewerScreen extends ConsumerWidget {
  const KnownFactsViewerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectState = ref.watch(projectStateProvider);
    if (projectState == null) {
      return const Scaffold(body: Center(child: Text('No project loaded')));
    }

    return WorkbenchDestinationSurface(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ProjectionStaleBanner(
              freshness: projectState.projectionFreshness,
            ),
            Text(
              const JsonEncoder.withIndent('  ')
                  .convert(projectState.knownFacts.toJson()),
              style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
