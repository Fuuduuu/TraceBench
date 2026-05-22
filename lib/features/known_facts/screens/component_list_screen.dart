import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/app.dart';

class ComponentListScreen extends ConsumerWidget {
  const ComponentListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectState = ref.watch(projectStateProvider);
    if (projectState == null) {
      return const Scaffold(body: Center(child: Text('No project loaded')));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Komponentide nimekiri')),
      body: ListView.builder(
        itemCount: projectState.knownFacts.components.length,
        itemBuilder: (_, index) {
          final component = projectState.knownFacts.components[index];
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
