import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/app.dart';
import '../../../shared/widgets/projection_stale_banner.dart';

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
    final boardContextDetails = isBeginnerMode
        ? (hasSymptom ? projectState.manifest.symptom : 'PCB-first overview')
        : advancedDetails;

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
          ProjectionStaleBanner(isStale: projectState.isProjectionStale),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'PCB-first context',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    humanReadableTitle,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    boardContextDetails,
                  ),
                  const SizedBox(height: 8),
                  if (projectState.manifest.projectId == 'prj_pelle_pv20_001')
                    const Chip(label: Text('Bundled sample')),
                  const SizedBox(height: 8),
                  Text(
                    'Status: ${projectState.isProjectionStale ? 'stale' : 'up to date'}',
                  ),
                  if (projectState.isProjectionStale)
                    const SizedBox(height: 8),
                  if (projectState.isProjectionStale)
                    const Text(
                      'Board/status context is read-only and projection-backed.',
                      style: TextStyle(fontSize: 12),
                    ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Text('Kõik komponendid'),
                      const Spacer(),
                      Text(
                        '${projectState.componentCount}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              key: const ValueKey('overview-measurement-record-button'),
              onPressed: () => context.go('/project/measure-sheet'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Text('Lisa mõõtmine'),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Quick actions',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Wrap(
                spacing: 12,
                runSpacing: 8,
                children: [
                  OutlinedButton(
                    key: const ValueKey('overview-measure-sheet-button'),
                    onPressed: () => context.go('/project/measure-sheet'),
                    child: const Text('Measure Sheet'),
                  ),
                  OutlinedButton(
                    key: const ValueKey('overview-add-component-button'),
                    onPressed: () => context.go('/project/components/add'),
                    child: const Text('Add Component'),
                  ),
                  OutlinedButton(
                    key: const ValueKey('overview-edit-component-button'),
                    onPressed: () => context.go('/project/components/edit'),
                    child: const Text('Edit Component'),
                  ),
                  OutlinedButton(
                    onPressed: () => context.go('/project/components'),
                    child: const Text('Komponendid'),
                  ),
                  OutlinedButton(
                    onPressed: () => context.go('/project/measurements'),
                    child: const Text('Mõõtmised'),
                  ),
                  OutlinedButton(
                    key: const ValueKey('overview-photos-button'),
                    onPressed: () => context.go('/project/photos'),
                    child: const Text('Foto tõendid (kiirkäik)'),
                  ),
                  OutlinedButton(
                    key: const ValueKey('overview-reference-images-button'),
                    onPressed: () => context.go('/project/reference-images'),
                    child: const Text('Reference Images'),
                  ),
                  OutlinedButton(
                    onPressed: () => context.go('/project/not-populated'),
                    child: const Text('Not populated'),
                  ),
                  OutlinedButton(
                    onPressed: () => context.go('/project/pins'),
                    child: const Text('Pinnid'),
                  ),
                  OutlinedButton(
                    onPressed: () => context.go('/project/known-facts'),
                    child: const Text('Known facts'),
                  ),
                  OutlinedButton(
                    onPressed: () => context.go('/project/events'),
                    child: const Text('Sündmused'),
                  ),
                  OutlinedButton(
                    key: const ValueKey('overview-board-graph-button'),
                    onPressed: () => context.go('/project/graph'),
                    child: const Text('Board graph view'),
                  ),
                  OutlinedButton(
                    key: const ValueKey('overview-board-canvas-button'),
                    onPressed: () => context.go('/project/board-canvas'),
                    child: const Text('Board Canvas'),
                  ),
                  OutlinedButton(
                    onPressed: () => context.go('/project/report'),
                    child: const Text('Raport'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Divider(),
          const SizedBox(height: 8),
          Text(
            'Summary',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: [
              _OverviewChip(
                  label: 'Kõik komponendid', value: projectState.componentCount),
              _OverviewChip(label: 'Mõõtmised', value: projectState.measurementCount),
              _OverviewChip(
                  label: 'Aktiivne', value: projectState.activeMeasurementCount),
              _OverviewChip(
                  label: 'Aegunud', value: projectState.staleMeasurementCount),
              _OverviewChip(
                  label: 'Pole paigaldatud',
                  value: projectState.notPopulatedCount),
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
