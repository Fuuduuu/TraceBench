import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/app.dart';
import '../../../shared/widgets/projection_stale_banner.dart';

class PinListScreen extends ConsumerWidget {
  const PinListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectState = ref.watch(projectStateProvider);
    if (projectState == null) {
      return const Scaffold(body: Center(child: Text('No project loaded')));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Pinnid')),
      body: ListView.builder(
        itemCount: projectState.knownFacts.pins.length + 1,
        itemBuilder: (_, index) {
          if (index == 0) {
            return ProjectionStaleBanner(
              freshness: projectState.projectionFreshness,
            );
          }

          final pin = projectState.knownFacts.pins[index - 1];
          return ListTile(
            title: Text(pin.pinId),
            subtitle: Text('Komponent: ${pin.componentId}'),
            trailing: Text(pin.status ?? 'unknown'),
          );
        },
      ),
    );
  }
}
