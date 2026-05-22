import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/app.dart';

class NotPopulatedScreen extends ConsumerWidget {
  const NotPopulatedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectState = ref.watch(projectStateProvider);
    if (projectState == null) {
      return const Scaffold(body: Center(child: Text('No project loaded')));
    }

    final excluded = projectState.knownFacts.excludedFromFaultCandidates;
    return Scaffold(
      appBar: AppBar(title: const Text('Puudub populeerimine')),
      body: ListView(
        children: [
          for (final item in excluded)
            ListTile(
              leading: const Icon(Icons.block),
              title: Text(item.footprintId),
              subtitle: const Text('Pole paigaldatud — välistatud rikkeanalüüsist'),
            ),
        ],
      ),
    );
  }
}
