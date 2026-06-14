import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/app.dart';
import '../../../shared/models/known_facts.dart';
import '../../../shared/models/project_state.dart';
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
    final boardPlacements = projectState.knownFacts.componentVisualPlacements
        .where(
          (placement) => placement.coordinateSpace == 'board_normalized',
        )
        .toList(growable: false);

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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 14),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1320),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ProjectionStaleBanner(isStale: projectState.isProjectionStale),
                  const SizedBox(height: 8),
                  _WorkbenchShellLayout(
                    boardContextDetails: boardContextDetails,
                    boardPlacements: boardPlacements,
                    humanReadableTitle: humanReadableTitle,
                    hasSymptom: hasSymptom,
                    isBeginnerMode: isBeginnerMode,
                    isProjectionStale: projectState.isProjectionStale,
                    projectState: projectState,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _WorkbenchShellLayout extends StatelessWidget {
  const _WorkbenchShellLayout({
    required this.boardContextDetails,
    required this.boardPlacements,
    required this.humanReadableTitle,
    required this.hasSymptom,
    required this.isBeginnerMode,
    required this.isProjectionStale,
    required this.projectState,
  });

  final String boardContextDetails;
  final List<ComponentVisualPlacementFact> boardPlacements;
  final String humanReadableTitle;
  final bool hasSymptom;
  final bool isBeginnerMode;
  final bool isProjectionStale;
  final ProjectState projectState;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 960;

        final workbenchZone = _WorkbenchZoneCard(
          key: const ValueKey('overview-workbench-zone'),
          boardContextDetails: boardContextDetails,
          boardPlacements: boardPlacements,
          humanReadableTitle: humanReadableTitle,
          hasSymptom: hasSymptom,
          isBeginnerMode: isBeginnerMode,
          isProjectionStale: isProjectionStale,
          projectState: projectState,
        );

        final actionRail = SizedBox(
          key: const ValueKey('overview-actions-panel'),
          width: isWide ? 300 : double.infinity,
          child: _ActionRailCard(projectState: projectState),
        );

        if (isWide) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 8,
                child: workbenchZone,
              ),
              const SizedBox(width: 12),
              actionRail,
            ],
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            workbenchZone,
            const SizedBox(height: 16),
            actionRail,
          ],
        );
      },
    );
  }
}

class _WorkbenchZoneCard extends StatelessWidget {
  const _WorkbenchZoneCard({
    super.key,
    required this.boardContextDetails,
    required this.boardPlacements,
    required this.humanReadableTitle,
    required this.hasSymptom,
    required this.isBeginnerMode,
    required this.isProjectionStale,
    required this.projectState,
  });

  final String boardContextDetails;
  final List<ComponentVisualPlacementFact> boardPlacements;
  final String humanReadableTitle;
  final bool hasSymptom;
  final bool isBeginnerMode;
  final bool isProjectionStale;
  final ProjectState projectState;

  @override
  Widget build(BuildContext context) {
    final boardSummary = boardPlacements.isEmpty
        ? 'No usable board placement is available yet.'
        : 'Read-only projection: ${boardPlacements.length} placement(s) found';
    final subtitle = isBeginnerMode
        ? (hasSymptom ? projectState.manifest.symptom : 'Start from board view first.')
        : boardContextDetails;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Text(
                  'Töölaud / PCB board',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Spacer(),
                if (isProjectionStale)
                  const _EvidenceTag(
                    label: 'PROJECTION STALE',
                    compact: true,
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(humanReadableTitle, style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 4),
            Text(
              boardSummary,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 6),
            Text(subtitle),
            const SizedBox(height: 8),
            if (projectState.knownFacts.componentVisualPlacements.isEmpty)
              const _WorkbenchPlaceholder()
            else
              _WorkbenchBoardReadOnlyCanvas(
                key: const ValueKey('overview-workbench-board-preview'),
                boardPlacements: boardPlacements,
                componentFacts: projectState.knownFacts.components,
              ),
            const SizedBox(height: 8),
            Text(
              'Toimingute mõju ja mõõtmised on kontekstis allpool.',
              style: Theme.of(context).textTheme.labelSmall,
            ),
            const SizedBox(height: 4),
            Wrap(
              spacing: 8,
              runSpacing: 6,
              alignment: WrapAlignment.spaceBetween,
              children: [
                _OverviewChip(label: 'Kõik komponendid', value: projectState.componentCount),
                _OverviewChip(label: 'Mõõtmised', value: projectState.measurementCount),
                _OverviewChip(label: 'Aktiivne', value: projectState.activeMeasurementCount),
                _OverviewChip(label: 'Aegunud', value: projectState.staleMeasurementCount),
                _OverviewChip(label: 'Pole paigaldatud', value: projectState.notPopulatedCount),
              ],
            ),
            const SizedBox(height: 8),
            if (projectState.manifest.projectId == 'prj_pelle_pv20_001')
              const Chip(label: Text('Bundled sample')),
          ],
        ),
      ),
    );
  }
}

class _WorkbenchBoardReadOnlyCanvas extends StatelessWidget {
  const _WorkbenchBoardReadOnlyCanvas({
    super.key,
    required this.boardPlacements,
    required this.componentFacts,
  });

  final List<ComponentVisualPlacementFact> boardPlacements;
  final List<ComponentFact> componentFacts;

  @override
  Widget build(BuildContext context) {
    final componentById = <String, ComponentFact>{
      for (final component in componentFacts) component.componentId: component,
    };

    return Card(
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Board workspace (read-only)',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 6),
            SizedBox(
              height: 300,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth <= 0 || constraints.maxHeight <= 0) {
                    return const SizedBox.shrink();
                  }

                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).colorScheme.outlineVariant,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).colorScheme.surfaceContainerHigh,
                    ),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: CustomPaint(
                            painter: _WorkbenchGridPainter(),
                          ),
                        ),
                        ...boardPlacements.map((placement) {
                          final designator = componentById[placement.componentId]
                                  ?.designator
                                  ?.trim() ??
                              placement.componentId;
                          final x = _clamp(placement.centerX.toDouble());
                          final y = _clamp(placement.centerY.toDouble());
                          final size =
                              math.max(24.0, constraints.maxWidth * 0.03).clamp(24.0, 48.0);
                          return Positioned(
                            left: x * (constraints.maxWidth - size) + 1,
                            top: y * (constraints.maxHeight - size) + 1,
                            child: _WorkbenchPlacementBadge(
                              designator: designator,
                              isSelected: false,
                              size: size,
                            ),
                          );
                        }),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              'renderer writes: none',
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Placement summary is read-only and local only.',
              style: TextStyle(fontSize: 11.5),
            ),
          ],
        ),
      ),
    );
  }

  double _clamp(double value) {
    if (value.isInfinite || value.isNaN) {
      return 0.5;
    }
    return value.clamp(0.0, 1.0);
  }
}

class _WorkbenchGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final boardRect = Rect.fromLTWH(4, 4, size.width - 8, size.height - 8);
    final base = Paint()..color = const Color(0xFF0F1A17);
    final inner = Paint()..color = const Color(0xFF172722);
    final border = Paint()
      ..color = const Color(0xFF5A6863)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    canvas.drawRect(Offset.zero & size, base);
    canvas.drawRect(boardRect, inner);
    canvas.drawRect(boardRect, border);

    final grid = Paint()
      ..color = const Color(0x2F4D7A65)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    const step = 24.0;
    for (var x = 10.0; x < size.width - 10; x += step) {
      canvas.drawLine(Offset(x, 8), Offset(x, size.height - 8), grid);
    }
    for (var y = 10.0; y < size.height - 10; y += step) {
      canvas.drawLine(Offset(8, y), Offset(size.width - 8, y), grid);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _WorkbenchPlacementBadge extends StatelessWidget {
  const _WorkbenchPlacementBadge({
    required this.designator,
    required this.isSelected,
    required this.size,
  });

  final String designator;
  final bool isSelected;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected
              ? Theme.of(context).colorScheme.primaryContainer
              : const Color(0xFFD4C7A8),
          border: Border.all(color: Theme.of(context).colorScheme.primary, width: 1.5),
        ),
        child: Center(
          child: Text(
            _shortLabel(designator),
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  static String _shortLabel(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) {
      return '?';
    }
    if (trimmed.length <= 4) {
      return trimmed;
    }
    return trimmed.substring(0, 2);
  }
}

class _WorkbenchPlaceholder extends StatelessWidget {
  const _WorkbenchPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.dashboard_customize_outlined, size: 36),
              const SizedBox(height: 10),
              const Text('PCB/workbench placeholder'),
              const SizedBox(height: 6),
              const Text(
                'No confirmed board placements yet. The workbench is open and awaiting evidence from photo/project evidence capture.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 6),
              const Text('Context and route behavior are preserved.'),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionRailCard extends StatelessWidget {
  const _ActionRailCard({required this.projectState});

  final ProjectState projectState;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          key: const ValueKey('overview-measurement-record-button'),
          onPressed: () => context.go('/project/measure-sheet'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          child: const Text('Lisa mõõtmine'),
        ),
        const SizedBox(height: 8),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Võtted', style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
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
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 6),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Navigatsioon', style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
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
                      key: const ValueKey('overview-reference-images-button'),
                      onPressed: () => context.go('/project/reference-images'),
                      child: const Text('Reference Images'),
                    ),
                    OutlinedButton(
                      key: const ValueKey('overview-photos-button'),
                      onPressed: () => context.go('/project/photos'),
                      child: const Text('Foto tõendid'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 6),
        ExpansionTile(
          title: const Text('Muud tegevused'),
          tilePadding: EdgeInsets.zero,
          childrenPadding: const EdgeInsets.only(bottom: 10, left: 8, right: 8),
          children: [
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                OutlinedButton(
                  key: const ValueKey('overview-measurements-button'),
                  onPressed: () => context.go('/project/measurements'),
                  child: const Text('Mõõtmised'),
                ),
                OutlinedButton(
                  onPressed: () => context.go('/project/known-facts'),
                  child: const Text('Known facts'),
                ),
                OutlinedButton(
                  key: const ValueKey('overview-components-button'),
                  onPressed: () => context.go('/project/components'),
                  child: const Text('Komponendid'),
                ),
                OutlinedButton(
                  onPressed: () => context.go('/project/pins'),
                  child: const Text('Pinnid'),
                ),
                OutlinedButton(
                  onPressed: () => context.go('/project/events'),
                  child: const Text('Sündmused'),
                ),
                OutlinedButton(
                  onPressed: () => context.go('/project/not-populated'),
                  child: const Text('Not populated'),
                ),
                OutlinedButton(
                  onPressed: () => context.go('/project/report'),
                  child: const Text('Raport'),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 6),
        Card(
          color: Theme.of(context).colorScheme.surfaceContainerLow,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Future tools (tulekul)', style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    OutlinedButton(
                      key: const ValueKey('overview-future-contour-button'),
                      onPressed: null,
                      child: const Text('Lisa kontuur'),
                    ),
                    OutlinedButton(
                      key: const ValueKey('overview-future-photo-button'),
                      onPressed: null,
                      child: const Text('Tuvasta foto abil'),
                    ),
                    OutlinedButton(
                      key: const ValueKey('overview-future-layers-button'),
                      onPressed: null,
                      child: const Text('Layers'),
                    ),
                    OutlinedButton(
                      key: const ValueKey('overview-future-trace-colors-button'),
                      onPressed: null,
                      child: const Text('Trace colors'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          projectState.manifest.projectId,
          key: const ValueKey('overview-project-id'),
          style: Theme.of(context).textTheme.bodySmall,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class _EvidenceTag extends StatelessWidget {
  const _EvidenceTag({required this.label, this.compact = false});

  final String label;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: compact ? 6 : 10,
          vertical: compact ? 2 : 4,
        ),
        child: Text(label, style: Theme.of(context).textTheme.labelSmall),
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
      child: SizedBox(
        width: 130,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade300),
            color: Theme.of(context).colorScheme.surfaceContainerLow,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    label,
                    style: Theme.of(context).textTheme.bodySmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  value.toString(),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
