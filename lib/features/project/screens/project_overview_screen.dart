import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/app.dart';

class ProjectOverviewScreen extends ConsumerWidget {
  const ProjectOverviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectState = ref.watch(projectStateProvider);
    final isBeginnerMode = ref.watch(beginnerModeProvider);
    if (projectState == null) {
      return const Scaffold(
        body: Center(child: Text('No project loaded')),
      );
    }
    final humanReadableTitle =
        '${projectState.manifest.deviceType} · ${projectState.manifest.model}';
    final hasSymptom = projectState.manifest.symptom.isNotEmpty &&
        projectState.manifest.symptom != 'not_provided';
    final advancedDetails =
        'project_id: ${projectState.manifest.projectId} | schema_version: ${projectState.manifest.schemaVersion} | created_at: ${projectState.manifest.createdAt}';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Project overview'),
        actions: [
          IconButton(
            tooltip: 'toggle mode',
            onPressed: () => ref.read(beginnerModeProvider.notifier).state =
                !ref.read(beginnerModeProvider),
            icon: const Icon(Icons.switch_account),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              title: Text(humanReadableTitle),
              subtitle: Text(
                isBeginnerMode
                    ? (hasSymptom
                        ? 'Symptom: ${projectState.manifest.symptom}'
                        : '')
                    : advancedDetails,
              ),
            ),
          ),
          const SizedBox(height: 12),
          _OverviewChip(
              label: 'Kõik komponendid', value: projectState.componentCount),
          _OverviewChip(
              label: 'Mõõtmised', value: projectState.measurementCount),
          _OverviewChip(
            label: 'Aktiivne',
            value: projectState.activeMeasurementCount,
          ),
          _OverviewChip(
            label: 'Aegunud',
            value: projectState.staleMeasurementCount,
          ),
          _OverviewChip(
            label: 'Pole paigaldatud',
            value: projectState.notPopulatedCount,
          ),
          const SizedBox(height: 12),
          if (projectState.manifest.projectId == 'prj_pelle_pv20_001')
            const Chip(label: Text('Bundled sample')),
          const SizedBox(height: 20),
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: [
              ElevatedButton(
                onPressed: () => context.go('/project/components'),
                child: const Text('Komponendid'),
              ),
              ElevatedButton(
                onPressed: () => context.go('/project/measurements'),
                child: const Text('Mõõtmised'),
              ),
              ElevatedButton(
                onPressed: () => context.go('/project/not-populated'),
                child: const Text('Not populated'),
              ),
              ElevatedButton(
                onPressed: () => context.go('/project/pins'),
                child: const Text('Pinnid'),
              ),
              ElevatedButton(
                onPressed: () => context.go('/project/known-facts'),
                child: const Text('Known facts'),
              ),
              ElevatedButton(
                key: const ValueKey('overview-photos-button'),
                onPressed: () => context.go('/project/photos'),
                child: const Text('Foto tõendid'),
              ),
              ElevatedButton(
                onPressed: () => context.go('/project/events'),
                child: const Text('Sündmused'),
              ),
              ElevatedButton(
                key: const ValueKey('overview-board-graph-button'),
                onPressed: () => context.go('/project/graph'),
                child: const Text('Board graph'),
              ),
              ElevatedButton(
                onPressed: () => context.go('/project/report'),
                child: const Text('Raport'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _OverviewChip extends StatelessWidget {
  const _OverviewChip({
    required this.label,
    required this.value,
  });

  final String label;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.grey.shade300),
        ),
        title: Text(label),
        trailing: Text(
          value.toString(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
