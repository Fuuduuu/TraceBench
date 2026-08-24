import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/session/project_session.dart';
import '../../../shared/widgets/projection_stale_banner.dart';
import '../../project/widgets/workbench_shell.dart';

class NotPopulatedScreen extends ConsumerWidget {
  const NotPopulatedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectState = ref.watch(projectStateProvider);
    if (projectState == null) {
      return const Scaffold(body: Center(child: Text('No project loaded')));
    }

    final excluded = projectState.knownFacts.excludedFromFaultCandidates;
    return WorkbenchDestinationSurface(
      child: ListView(
        children: [
          ProjectionStaleBanner(
            freshness: projectState.projectionFreshness,
          ),
          for (final item in excluded)
            ListTile(
              leading: const Icon(Icons.block),
              title: Text(item.footprintId),
              subtitle:
                  const Text('Pole paigaldatud — välistatud rikkeanalüüsist'),
            ),
        ],
      ),
    );
  }
}
