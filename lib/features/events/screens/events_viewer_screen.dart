import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/app.dart';

class EventsViewerScreen extends ConsumerWidget {
  const EventsViewerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectState = ref.watch(projectStateProvider);
    final isBeginnerMode = ref.watch(beginnerModeProvider);
    if (projectState == null) {
      return const Scaffold(body: Center(child: Text('No project loaded')));
    }
    if (isBeginnerMode) {
      return Scaffold(
        appBar: AppBar(title: const Text('Sündmused')),
        body: const Center(
          child: Text('Advanced režiim vajalik'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Sündmused')),
      body: ListView.builder(
        itemCount: projectState.events.length,
        itemBuilder: (_, index) {
          final event = projectState.events[index];
          return ExpansionTile(
            title: Text(
              '${event.sequence} · ${event.eventType} · ${event.createdAt}',
            ),
            subtitle: Text('event_id: ${event.eventId}'),
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  const JsonEncoder.withIndent('  ').convert(event.payload),
                  style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
