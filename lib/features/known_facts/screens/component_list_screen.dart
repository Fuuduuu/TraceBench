import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/app.dart';
import '../../../shared/widgets/projection_stale_banner.dart';
import '../../project/widgets/workbench_shell.dart';

class ComponentListScreen extends ConsumerWidget {
  const ComponentListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectState = ref.watch(projectStateProvider);
    if (projectState == null) {
      return const Scaffold(body: Center(child: Text('No project loaded')));
    }

    return WorkbenchDestinationSurface(
      child: ListView.builder(
        itemCount: projectState.knownFacts.components.length + 1,
        itemBuilder: (_, index) {
          if (index == 0) {
            return ProjectionStaleBanner(
              freshness: projectState.projectionFreshness,
            );
          }

          final component = projectState.knownFacts.components[index - 1];
          return ListTile(
            title: Text(component.componentId),
            subtitle: Text(
              [
                component.designator ?? 'unknown',
                component.type ?? 'type ?',
                component.package ?? 'package ?',
                component.status ?? 'status ?',
              ].join(' · '),
            ),
            trailing: Text(component.marking ?? ''),
          );
        },
      ),
    );
  }
}
