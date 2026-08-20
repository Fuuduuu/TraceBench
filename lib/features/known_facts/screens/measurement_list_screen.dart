import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/app.dart';
import '../../../shared/widgets/projection_stale_banner.dart';
import '../../project/widgets/workbench_shell.dart';

class MeasurementListScreen extends ConsumerWidget {
  const MeasurementListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectState = ref.watch(projectStateProvider);
    final beginnerMode = ref.watch(beginnerModeProvider);
    if (projectState == null) {
      return const Scaffold(body: Center(child: Text('No project loaded')));
    }

    return WorkbenchDestinationSurface(
      child: ListView.builder(
        itemCount: projectState.knownFacts.measurements.length + 1,
        itemBuilder: (_, index) {
          if (index == 0) {
            return ProjectionStaleBanner(
              freshness: projectState.projectionFreshness,
            );
          }

          final measurement = projectState.knownFacts.measurements[index - 1];
          return ListTile(
            title: Text(
                '${measurement.measurementId}: ${measurement.from} → ${measurement.to}'),
            subtitle: Text(
              'Seis: ${measurement.humanValidityLabel} · ${measurement.powerState}',
            ),
            trailing: beginnerMode
                ? null
                : Text(
                    '${measurement.value ?? 'null'} ${measurement.unit ?? ''}'
                        .trim(),
                  ),
          );
        },
      ),
    );
  }
}
