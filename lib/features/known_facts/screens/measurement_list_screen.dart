import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/app.dart';

class MeasurementListScreen extends ConsumerWidget {
  const MeasurementListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectState = ref.watch(projectStateProvider);
    final beginnerMode = ref.watch(beginnerModeProvider);
    if (projectState == null) {
      return const Scaffold(body: Center(child: Text('No project loaded')));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Mõõtmised')),
      body: ListView.builder(
        itemCount: projectState.knownFacts.measurements.length,
        itemBuilder: (_, index) {
          final measurement = projectState.knownFacts.measurements[index];
          return ListTile(
            title: Text('${measurement.measurementId}: ${measurement.from} → ${measurement.to}'),
            subtitle: Text(
              'Seis: ${measurement.humanValidityLabel} · ${measurement.powerState}',
            ),
            trailing: beginnerMode
                ? null
                : Text(
                    '${measurement.value ?? 'null'} ${measurement.unit ?? ''}'.trim(),
                  ),
          );
        },
      ),
    );
  }
}
