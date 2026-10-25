import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/session/project_session.dart';
import '../../../shared/models/known_facts.dart';
import '../../../shared/models/project_state.dart';
import '../../../shared/widgets/projection_stale_banner.dart';
import '../../../shared/theme/app_theme.dart';
import '../../../shared/widgets/workbench_page.dart';

class ProjectOverviewScreen extends ConsumerWidget {
  const ProjectOverviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectState = ref.watch(projectStateProvider);
    if (projectState == null) {
      return WorkbenchPage(
          builder: (_) => const Center(child: Text('No project loaded')));
    }

    const workbenchDisplaySubtitle = 'Kohalik töölaud · ainult vaatamine';
    final boardPlacements = projectState.knownFacts.componentVisualPlacements
        .where(
          (placement) => placement.coordinateSpace == 'board_normalized',
        )
        .toList(growable: false);

    return WorkbenchPage(
      maxContentWidth: 1344,
      padding: EdgeInsets.zero,
      builder: (_) => SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1320),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ProjectionStaleBanner(
                  freshness: projectState.projectionFreshness,
                ),
                const SizedBox(height: 10),
                _WorkbenchShellLayout(
                  boardPlacements: boardPlacements,
                  projectState: projectState,
                  workbenchDisplaySubtitle: workbenchDisplaySubtitle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _WorkbenchShellLayout extends StatelessWidget {
  const _WorkbenchShellLayout({
    required this.boardPlacements,
    required this.projectState,
    required this.workbenchDisplaySubtitle,
  });

  final List<ComponentVisualPlacementFact> boardPlacements;
  final ProjectState projectState;
  final String workbenchDisplaySubtitle;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 960;

        final workbenchZone = _WorkbenchZoneCard(
          key: const ValueKey('overview-workbench-zone'),
          boardPlacements: boardPlacements,
          projectState: projectState,
          workbenchDisplaySubtitle: workbenchDisplaySubtitle,
        );

        final actionRail = SizedBox(
          key: const ValueKey('overview-actions-panel'),
          width: isWide ? 252 : double.infinity,
          child: const _ActionRailCard(),
        );

        if (isWide) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
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
            const SizedBox(height: 12),
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
    required this.boardPlacements,
    required this.projectState,
    required this.workbenchDisplaySubtitle,
  });

  final List<ComponentVisualPlacementFact> boardPlacements;
  final ProjectState projectState;
  final String workbenchDisplaySubtitle;

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
          color: WorkbenchColors.navy,
          fontWeight: FontWeight.w800,
        );
    final subtitleStyle = Theme.of(context).textTheme.titleSmall?.copyWith(
          color: WorkbenchColors.muted,
          fontWeight: FontWeight.w600,
        );
    return DecoratedBox(
      decoration: BoxDecoration(
        color: WorkbenchColors.paper,
        border: Border.all(color: WorkbenchColors.rule),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x99000000),
            blurRadius: 28,
            offset: Offset(0, 14),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Wrap(
              spacing: 8,
              runSpacing: 6,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  'Plaadi ülevaade',
                  style: titleStyle,
                ),
                const _EvidenceTag(
                  label: 'Töölaud nr 1',
                  compact: true,
                ),
                const _EvidenceTag(
                  label: 'AINULT VAATAMINE',
                  compact: true,
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              workbenchDisplaySubtitle,
              style: subtitleStyle,
            ),
            const SizedBox(height: 8),
            if (projectState.knownFacts.componentVisualPlacements.isEmpty)
              const _WorkbenchPlaceholder()
            else
              _WorkbenchBoardReadOnlyCanvas(
                key: const ValueKey('overview-workbench-board-preview'),
                boardPlacements: boardPlacements,
                componentFacts: projectState.knownFacts.components,
              ),
            const SizedBox(height: 4),
            SizedBox(
              key: const ValueKey('overview-status-strip'),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _OverviewChip(
                      label: 'Kõik komponendid',
                      value: projectState.componentCount,
                    ),
                    const SizedBox(width: 6),
                    _OverviewChip(
                      label: 'Mõõtmised',
                      value: projectState.measurementCount,
                    ),
                    const SizedBox(width: 6),
                    _OverviewChip(
                      label: 'Aktiivne',
                      value: projectState.activeMeasurementCount,
                    ),
                    const SizedBox(width: 6),
                    _OverviewChip(
                      label: 'Aegunud',
                      value: projectState.staleMeasurementCount,
                    ),
                    const SizedBox(width: 6),
                    _OverviewChip(
                      label: 'Pole paigaldatud',
                      value: projectState.notPopulatedCount,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 6),
            if (projectState.manifest.projectId == 'prj_pelle_pv20_001')
              const Chip(
                backgroundColor: WorkbenchColors.signalTint,
                label: Text('Bundled sample'),
                labelStyle: TextStyle(color: WorkbenchColors.navy),
              ),
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

    return LayoutBuilder(
      builder: (context, constraints) {
        final boardHeight = constraints.maxWidth >= 900
            ? 430.0
            : constraints.maxWidth >= 640
                ? 380.0
                : 320.0;

        return DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(
              color: WorkbenchColors.outline,
            ),
            borderRadius: BorderRadius.circular(8),
            color: WorkbenchColors.tile,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Plaadi tööala (ainult vaatamine)',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: WorkbenchColors.navy,
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: 6),
                SizedBox(
                  height: boardHeight,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth <= 0 ||
                          constraints.maxHeight <= 0) {
                        return const SizedBox.shrink();
                      }

                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: WorkbenchColors.outline,
                          ),
                          borderRadius: BorderRadius.circular(8),
                          color: WorkbenchColors.shell,
                        ),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: CustomPaint(
                                painter: _WorkbenchGridPainter(),
                              ),
                            ),
                            ...boardPlacements.map((placement) {
                              final designator =
                                  componentById[placement.componentId]
                                          ?.designator
                                          ?.trim() ??
                                      placement.componentId;
                              final x = _clamp(placement.centerX.toDouble());
                              final y = _clamp(placement.centerY.toDouble());
                              final size = math
                                  .max(24.0, constraints.maxWidth * 0.03)
                                  .clamp(24.0, 48.0);
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
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(
                                        color: WorkbenchColors.muted,
                                        letterSpacing: 0.4,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Paigutuste kokkuvõte on ainult vaatamiseks ja lokaalne.',
                  style: TextStyle(
                    color: WorkbenchColors.muted,
                    fontSize: 11.5,
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
    final base = Paint()..color = WorkbenchColors.shell;
    final inner = Paint()..color = WorkbenchColors.tile;
    final border = Paint()
      ..color = WorkbenchColors.signal
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    canvas.drawRect(Offset.zero & size, base);
    canvas.drawRect(boardRect, inner);
    canvas.drawRect(boardRect, border);

    final grid = Paint()
      ..color = const Color(0x334D7A65)
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
          color: isSelected ? WorkbenchColors.signalTint : WorkbenchColors.navy,
          border: Border.all(
            color: isSelected ? WorkbenchColors.signal : WorkbenchColors.signal,
            width: 1.5,
          ),
        ),
        child: Center(
          child: Text(
            _shortLabel(designator),
            style: const TextStyle(
              color: WorkbenchColors.navyDeep,
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
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
    return LayoutBuilder(
      builder: (context, constraints) {
        final placeholderHeight = constraints.maxWidth >= 720 ? 360.0 : 320.0;

        return Container(
          height: placeholderHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: WorkbenchColors.outline,
            ),
            color: WorkbenchColors.shell,
          ),
          child: const DefaultTextStyle(
            style: TextStyle(color: WorkbenchColors.muted),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.dashboard_customize_outlined,
                      color: WorkbenchColors.signal,
                      size: 34,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'PCB/töölaua kohatäide',
                      style: TextStyle(
                        color: WorkbenchColors.navy,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Kinnitatud plaadipaigutusi veel pole. Töölaud ootab foto- või projektitõendeid.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(height: 6),
                    Text('Kontekst ja liikumine on säilinud.'),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ActionRailCard extends StatelessWidget {
  const _ActionRailCard();

  @override
  Widget build(BuildContext context) {
    final outlinedButtonStyle =
        Theme.of(context).outlinedButtonTheme.style!.copyWith(
              visualDensity: VisualDensity.compact,
              minimumSize: const WidgetStatePropertyAll(Size(0, 38)),
              padding: const WidgetStatePropertyAll(
                  EdgeInsets.symmetric(horizontal: 8, vertical: 7)),
            );
    final sectionTitleStyle = Theme.of(context).textTheme.labelLarge?.copyWith(
          color: WorkbenchColors.navy,
          fontWeight: FontWeight.w800,
        );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton.icon(
          key: const ValueKey('overview-measurement-record-button'),
          onPressed: () => context.go('/project/measure-sheet'),
          style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                padding: const WidgetStatePropertyAll(
                    EdgeInsets.symmetric(vertical: 10, horizontal: 12)),
              ),
          icon: const Icon(Icons.science_outlined, size: 18),
          label: const Text('Lisa mõõtmine'),
        ),
        const SizedBox(height: 6),
        Card(
          margin: const EdgeInsets.symmetric(vertical: 2),
          color: WorkbenchColors.paper,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: WorkbenchColors.rule),
          ),
          child: Padding(
            padding: const EdgeInsets.all(7),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Võtted', style: sectionTitleStyle),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 5,
                  runSpacing: 5,
                  children: [
                    OutlinedButton(
                      key: const ValueKey('overview-measure-sheet-button'),
                      onPressed: () => context.go('/project/measure-sheet'),
                      style: outlinedButtonStyle,
                      child: const Text('Measure Sheet'),
                    ),
                    OutlinedButton(
                      key: const ValueKey('overview-add-component-button'),
                      onPressed: () => context.go('/project/components/add'),
                      style: outlinedButtonStyle,
                      child: const Text('Loo komponent'),
                    ),
                    OutlinedButton(
                      key: const ValueKey('overview-edit-component-button'),
                      onPressed: () => context.go('/project/components/edit'),
                      style: outlinedButtonStyle,
                      child: const Text('Muuda komponendi andmeid'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 4),
        Card(
          margin: const EdgeInsets.symmetric(vertical: 2),
          color: WorkbenchColors.tile,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: WorkbenchColors.rule),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              key: const ValueKey('overview-future-tools-panel'),
              textColor: WorkbenchColors.navy,
              collapsedTextColor: WorkbenchColors.muted,
              iconColor: WorkbenchColors.signal,
              collapsedIconColor: WorkbenchColors.muted,
              tilePadding: const EdgeInsets.symmetric(horizontal: 8),
              childrenPadding: const EdgeInsets.only(
                bottom: 8,
                left: 8,
                right: 8,
              ),
              title: Text('Tulevased tööriistad', style: sectionTitleStyle),
              subtitle: Text(
                'Välja lülitatud',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: WorkbenchColors.muted,
                    ),
              ),
              children: [
                Wrap(
                  spacing: 5,
                  runSpacing: 5,
                  children: [
                    OutlinedButton(
                      key: const ValueKey('overview-future-contour-button'),
                      onPressed: null,
                      style: outlinedButtonStyle,
                      child: const Text('Lisa kontuur'),
                    ),
                    OutlinedButton(
                      key: const ValueKey('overview-future-photo-button'),
                      onPressed: null,
                      style: outlinedButtonStyle,
                      child: const Text('Tuvasta foto abil'),
                    ),
                    OutlinedButton(
                      key: const ValueKey('overview-future-layers-button'),
                      onPressed: null,
                      style: outlinedButtonStyle,
                      child: const Text('Kihid'),
                    ),
                    OutlinedButton(
                      key: const ValueKey(
                        'overview-future-trace-colors-button',
                      ),
                      onPressed: null,
                      style: outlinedButtonStyle,
                      child: const Text('Rajajoone värvid'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'TraceBench platform · display-only shell',
          key: const ValueKey('overview-project-id'),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: WorkbenchColors.muted,
              ),
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
        border: Border.all(color: WorkbenchColors.outline),
        color: compact ? WorkbenchColors.signalTint : WorkbenchColors.raised,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: compact ? 6 : 10,
          vertical: compact ? 2 : 4,
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: compact ? WorkbenchColors.signal : WorkbenchColors.muted,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
        ),
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
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: SizedBox(
        width: 112,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: WorkbenchColors.outline),
            color: WorkbenchColors.tile,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    label,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: WorkbenchColors.muted,
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  value.toString(),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: WorkbenchColors.signal,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
