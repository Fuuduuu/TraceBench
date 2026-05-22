import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../../app/app.dart';

class CustomerReportScreen extends ConsumerWidget {
  const CustomerReportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectState = ref.watch(projectStateProvider);
    if (projectState == null) {
      return const Scaffold(body: Center(child: Text('No project loaded')));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Kliendiraport')),
      body: Column(
        children: [
          Expanded(
            child: Markdown(data: projectState.customerReport),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Eksport tuleb järgmises versioonis'),
                    ),
                  );
                },
                child: const Text('Export ZIP'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
