import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/app.dart';

class KnownFactsViewerScreen extends ConsumerWidget {
  const KnownFactsViewerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectState = ref.watch(projectStateProvider);
    if (projectState == null) {
      return const Scaffold(body: Center(child: Text('No project loaded')));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Known facts')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Text(
          const JsonEncoder.withIndent('  ').convert(projectState.knownFacts.toJson()),
          style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
        ),
      ),
    );
  }
}
