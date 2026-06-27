import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/app.dart';
import '../../../shared/models/known_facts.dart';
import '../../../shared/models/project_state.dart';
import '../../../shared/widgets/projection_stale_banner.dart';

class _ProjectHomeShellColors {
  static const background = Color(0xFF0A0D11);
  static const panel = Color(0xFF161B22);
  static const panelRaised = Color(0xFF1D252D);
  static const tile = Color(0xFF11161C);
  static const boardBase = Color(0xFF080B0F);
  static const boardSurface = Color(0xFF0F1F18);
  static const rule = Color(0xFF252D37);
  static const ruleStrong = Color(0xFF36404D);
  static const text = Color(0xFFE9EEF4);
  static const muted = Color(0xFFABB7C4);
  static const dim = Color(0xFF7C8A98);
  static const green = Color(0xFF1FA35C);
  static const greenBright = Color(0xFF2BC06F);
  static const greenTint = Color(0x261FA35C);
  static const copper = Color(0xFFD8A24A);
  static const copperTint = Color(0x26D8A24A);
  static const silk = Color(0xFFCDC78A);
}

class ProjectOverviewScreen extends ConsumerWidget {
  const ProjectOverviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectState = ref.watch(projectStateProvider);
    if (projectState == null) {
      return const Scaffold(
        body: Center(child: Text('No project loaded')),
      );
    }

    const workbenchDisplaySubtitle = 'Kohalik töölaud · read-only preview';
    final boardPlacements = projectState.knownFacts.componentVisualPlacements
        .where(
          (placement) => placement.coordinateSpace == 'board_normalized',
        )
        .toList(growable: false);

    return Scaffold(
      backgroundColor: _ProjectHomeShellColors.background,
      appBar: AppBar(
        backgroundColor: _ProjectHomeShellColors.panel,
        foregroundColor: _ProjectHomeShellColors.text,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.black,
        title: const Text('Project overview'),
        actions: [
          IconButton(
            key: const ValueKey('overview-home-menu-button'),
            tooltip: 'BenchBeep Home',
            onPressed: () => context.go('/'),
            icon: const Icon(Icons.home_outlined),
          ),
          IconButton(
            tooltip: 'toggle mode',
            onPressed: () => ref.read(beginnerModeProvider.notifier).state =
                !ref.read(beginnerModeProvider),
            icon: const Icon(Icons.switch_account),
          ),
        ],
        bottom: const _WorkbenchMenuBreadcrumb(),
      ),
      body: SafeArea(
        child: Material(
          key: const ValueKey('overview-dark-eda-shell'),
          color: _ProjectHomeShellColors.background,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 16),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1320),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ProjectionStaleBanner(
                      isStale: projectState.isProjectionStale,
                    ),
                    const SizedBox(height: 10),
                    _WorkbenchShellLayout(
                      boardPlacements: boardPlacements,
                      isProjectionStale: projectState.isProjectionStale,
                      projectState: projectState,
                      workbenchDisplaySubtitle: workbenchDisplaySubtitle,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _WorkbenchMenuBreadcrumb extends StatelessWidget
    implements PreferredSizeWidget {
  const _WorkbenchMenuBreadcrumb();

  @override
  Size get preferredSize => const Size.fromHeight(38);

  @override
  Widget build(BuildContext context) {
    final labelStyle = Theme.of(context).textTheme.labelSmall?.copyWith(
          color: _ProjectHomeShellColors.text,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.6,
        );
    final mutedStyle = Theme.of(context).textTheme.labelSmall?.copyWith(
          color: _ProjectHomeShellColors.dim,
          letterSpacing: 0.4,
        );

    return DecoratedBox(
      key: const ValueKey('overview-menu-breadcrumb'),
      decoration: BoxDecoration(
        color: _ProjectHomeShellColors.tile,
        border: Border(
          top: const BorderSide(color: _ProjectHomeShellColors.rule),
        ),
      ),
      child: SizedBox(
        height: preferredSize.height,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Text('BenchBeep', style: labelStyle),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Icon(
                  Icons.chevron_right,
                  size: 16,
                  color: _ProjectHomeShellColors.dim,
                ),
              ),
              Text('Workbench', style: labelStyle),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Icon(
                  Icons.chevron_right,
                  size: 16,
                  color: _ProjectHomeShellColors.dim,
                ),
              ),
              Text('Overview', style: mutedStyle),
              const Spacer(),
              DecoratedBox(
                key: const ValueKey('overview-menu-disabled-affordance'),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: _ProjectHomeShellColors.ruleStrong,
                  ),
                  borderRadius: BorderRadius.circular(999),
                  color: _ProjectHomeShellColors.panel,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  child: Text('Future menu items disabled', style: mutedStyle),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WorkbenchShellLayout extends StatelessWidget {
  const _WorkbenchShellLayout({
    required this.boardPlacements,
    required this.isProjectionStale,
    required this.projectState,
    required this.workbenchDisplaySubtitle,
  });

  final List<ComponentVisualPlacementFact> boardPlacements;
  final bool isProjectionStale;
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
          isProjectionStale: isProjectionStale,
          projectState: projectState,
          workbenchDisplaySubtitle: workbenchDisplaySubtitle,
        );

        final actionRail = SizedBox(
          key: const ValueKey('overview-actions-panel'),
          width: isWide ? 252 : double.infinity,
          child: _ActionRailCard(projectState: projectState),
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
    required this.isProjectionStale,
    required this.projectState,
    required this.workbenchDisplaySubtitle,
  });

  final List<ComponentVisualPlacementFact> boardPlacements;
  final bool isProjectionStale;
  final ProjectState projectState;
  final String workbenchDisplaySubtitle;

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
          color: _ProjectHomeShellColors.text,
          fontWeight: FontWeight.w800,
        );
    final subtitleStyle = Theme.of(context).textTheme.titleSmall?.copyWith(
          color: _ProjectHomeShellColors.muted,
          fontWeight: FontWeight.w600,
        );
    return DecoratedBox(
      decoration: BoxDecoration(
        color: _ProjectHomeShellColors.panel,
        border: Border.all(color: _ProjectHomeShellColors.rule),
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
                  'BenchBeep Workbench',
                  style: titleStyle,
                ),
                const _EvidenceTag(
                  label: 'Töölaud nr 1',
                  compact: true,
                ),
                const _EvidenceTag(
                  label: 'READ ONLY',
                  compact: true,
                ),
                if (isProjectionStale)
                  const _EvidenceTag(
                    label: 'PROJECTION STALE',
                    compact: true,
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              workbenchDisplaySubtitle,
              style: subtitleStyle,
              overflow: TextOverflow.ellipsis,
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
                backgroundColor: _ProjectHomeShellColors.greenTint,
                label: Text('Bundled sample'),
                labelStyle: TextStyle(color: _ProjectHomeShellColors.text),
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
              color: _ProjectHomeShellColors.ruleStrong,
            ),
            borderRadius: BorderRadius.circular(8),
            color: _ProjectHomeShellColors.tile,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Board workspace (read-only)',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: _ProjectHomeShellColors.text,
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
                            color: _ProjectHomeShellColors.ruleStrong,
                          ),
                          borderRadius: BorderRadius.circular(8),
                          color: _ProjectHomeShellColors.boardBase,
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
                                        color: _ProjectHomeShellColors.dim,
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
                  'Placement summary is read-only and local only.',
                  style: TextStyle(
                    color: _ProjectHomeShellColors.dim,
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
    final base = Paint()..color = _ProjectHomeShellColors.boardBase;
    final inner = Paint()..color = _ProjectHomeShellColors.boardSurface;
    final border = Paint()
      ..color = _ProjectHomeShellColors.green
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
          color: isSelected
              ? _ProjectHomeShellColors.greenTint
              : _ProjectHomeShellColors.silk,
          border: Border.all(
            color: isSelected
                ? _ProjectHomeShellColors.greenBright
                : _ProjectHomeShellColors.green,
            width: 1.5,
          ),
        ),
        child: Center(
          child: Text(
            _shortLabel(designator),
            style: const TextStyle(
              color: Color(0xFF06140C),
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
              color: _ProjectHomeShellColors.ruleStrong,
            ),
            color: _ProjectHomeShellColors.boardBase,
          ),
          child: const DefaultTextStyle(
            style: TextStyle(color: _ProjectHomeShellColors.muted),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.dashboard_customize_outlined,
                      color: _ProjectHomeShellColors.greenBright,
                      size: 34,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'PCB/workbench placeholder',
                      style: TextStyle(
                        color: _ProjectHomeShellColors.text,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'No confirmed board placements yet. The workbench is open and awaiting evidence from photo/project evidence capture.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(height: 6),
                    Text('Context and route behavior are preserved.'),
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
  const _ActionRailCard({required this.projectState});

  final ProjectState projectState;

  @override
  Widget build(BuildContext context) {
    final outlinedButtonStyle = OutlinedButton.styleFrom(
      foregroundColor: _ProjectHomeShellColors.muted,
      disabledForegroundColor: _ProjectHomeShellColors.dim,
      backgroundColor: _ProjectHomeShellColors.tile,
      visualDensity: VisualDensity.compact,
      minimumSize: const Size(0, 34),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      textStyle: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600),
      side: const BorderSide(color: _ProjectHomeShellColors.ruleStrong),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
    final sectionTitleStyle = Theme.of(context).textTheme.labelLarge?.copyWith(
          color: _ProjectHomeShellColors.text,
          fontWeight: FontWeight.w800,
        );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton.icon(
          key: const ValueKey('overview-measurement-record-button'),
          onPressed: () => context.go('/project/measure-sheet'),
          style: ElevatedButton.styleFrom(
            backgroundColor: _ProjectHomeShellColors.green,
            foregroundColor: Colors.white,
            surfaceTintColor: Colors.transparent,
            padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 12),
            textStyle: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          icon: const Icon(Icons.science_outlined, size: 18),
          label: const Text('Lisa mõõtmine'),
        ),
        const SizedBox(height: 6),
        Card(
          margin: const EdgeInsets.symmetric(vertical: 2),
          color: _ProjectHomeShellColors.panel,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: _ProjectHomeShellColors.rule),
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
                      child: const Text('Add Component'),
                    ),
                    OutlinedButton(
                      key: const ValueKey('overview-edit-component-button'),
                      onPressed: () => context.go('/project/components/edit'),
                      style: outlinedButtonStyle,
                      child: const Text('Edit Component'),
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
          color: _ProjectHomeShellColors.panel,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: _ProjectHomeShellColors.rule),
          ),
          child: Padding(
            padding: const EdgeInsets.all(7),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Navigatsioon', style: sectionTitleStyle),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 5,
                  runSpacing: 5,
                  children: [
                    OutlinedButton(
                      key: const ValueKey('overview-board-graph-button'),
                      onPressed: () => context.go('/project/graph'),
                      style: outlinedButtonStyle,
                      child: const Text('Board graph view'),
                    ),
                    OutlinedButton(
                      key: const ValueKey('overview-board-canvas-button'),
                      onPressed: () => context.go('/project/board-canvas'),
                      style: outlinedButtonStyle,
                      child: const Text('Board Canvas'),
                    ),
                    OutlinedButton(
                      key: const ValueKey('overview-reference-images-button'),
                      onPressed: () => context.go('/project/reference-images'),
                      style: outlinedButtonStyle,
                      child: const Text('Reference Images'),
                    ),
                    OutlinedButton(
                      key: const ValueKey('overview-photos-button'),
                      onPressed: () => context.go('/project/photos'),
                      style: outlinedButtonStyle,
                      child: const Text('Foto tõendid'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 4),
        Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            title: const Text('Muud tegevused'),
            textColor: _ProjectHomeShellColors.text,
            collapsedTextColor: _ProjectHomeShellColors.muted,
            iconColor: _ProjectHomeShellColors.greenBright,
            collapsedIconColor: _ProjectHomeShellColors.dim,
            tilePadding: EdgeInsets.zero,
            childrenPadding: const EdgeInsets.only(
              bottom: 8,
              left: 6,
              right: 6,
            ),
            children: [
              Wrap(
                spacing: 5,
                runSpacing: 5,
                children: [
                  OutlinedButton(
                    key: const ValueKey('overview-measurements-button'),
                    onPressed: () => context.go('/project/measurements'),
                    style: outlinedButtonStyle,
                    child: const Text('Mõõtmised'),
                  ),
                  OutlinedButton(
                    onPressed: () => context.go('/project/known-facts'),
                    style: outlinedButtonStyle,
                    child: const Text('Known facts'),
                  ),
                  OutlinedButton(
                    key: const ValueKey('overview-components-button'),
                    onPressed: () => context.go('/project/components'),
                    style: outlinedButtonStyle,
                    child: const Text('Komponendid'),
                  ),
                  OutlinedButton(
                    onPressed: () => context.go('/project/pins'),
                    style: outlinedButtonStyle,
                    child: const Text('Pinnid'),
                  ),
                  OutlinedButton(
                    onPressed: () => context.go('/project/events'),
                    style: outlinedButtonStyle,
                    child: const Text('Sündmused'),
                  ),
                  OutlinedButton(
                    onPressed: () => context.go('/project/not-populated'),
                    style: outlinedButtonStyle,
                    child: const Text('Not populated'),
                  ),
                  OutlinedButton(
                    onPressed: () => context.go('/project/report'),
                    style: outlinedButtonStyle,
                    child: const Text('Raport'),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Card(
          margin: const EdgeInsets.symmetric(vertical: 2),
          color: _ProjectHomeShellColors.tile,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: _ProjectHomeShellColors.rule),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              key: const ValueKey('overview-future-tools-panel'),
              textColor: _ProjectHomeShellColors.text,
              collapsedTextColor: _ProjectHomeShellColors.muted,
              iconColor: _ProjectHomeShellColors.greenBright,
              collapsedIconColor: _ProjectHomeShellColors.dim,
              tilePadding: const EdgeInsets.symmetric(horizontal: 8),
              childrenPadding: const EdgeInsets.only(
                bottom: 8,
                left: 8,
                right: 8,
              ),
              title: Text('Future tools (tulekul)', style: sectionTitleStyle),
              subtitle: Text(
                'Disabled',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: _ProjectHomeShellColors.dim,
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
                      child: const Text('Layers'),
                    ),
                    OutlinedButton(
                      key: const ValueKey(
                        'overview-future-trace-colors-button',
                      ),
                      onPressed: null,
                      style: outlinedButtonStyle,
                      child: const Text('Trace colors'),
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
                color: _ProjectHomeShellColors.dim,
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
        border: Border.all(color: _ProjectHomeShellColors.ruleStrong),
        color: compact
            ? _ProjectHomeShellColors.greenTint
            : _ProjectHomeShellColors.panelRaised,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: compact ? 6 : 10,
          vertical: compact ? 2 : 4,
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: compact
                    ? _ProjectHomeShellColors.greenBright
                    : _ProjectHomeShellColors.muted,
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
            border: Border.all(color: _ProjectHomeShellColors.ruleStrong),
            color: _ProjectHomeShellColors.tile,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    label,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: _ProjectHomeShellColors.muted,
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  value.toString(),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: _ProjectHomeShellColors.copper,
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
