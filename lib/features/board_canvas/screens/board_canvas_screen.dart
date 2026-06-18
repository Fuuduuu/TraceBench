import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/app.dart';
import '../../../shared/footprints/footprint_models.dart';
import '../../../shared/footprints/vector_footprint_library.dart';
import '../../../shared/models/known_facts.dart';
import '../../../shared/models/project_state.dart';

const double _kCompactBoardCanvasAppBarHeight = 36;
const double _kCompactControlTileHeight = 34;
const double _kCompactControlIconSize = 16;
const double _kWorkbenchRailWidth = 92;
const double _kWorkbenchRailContentIconSize = 18;
const double _kWorkbenchToolTileGap = 4;
const EdgeInsets _kWorkbenchRailPadding = EdgeInsets.fromLTRB(8, 8, 8, 10);
const double _kWideContextPanelWidth = 320;
const double _kMediumContextPanelWidth = 280;
const EdgeInsets _kCompactControlTilePadding =
    EdgeInsets.symmetric(horizontal: 8);
const EdgeInsets _kCompactControlChildrenPadding =
    EdgeInsets.fromLTRB(8, 0, 8, 6);

enum _WorkbenchContextPanelMode { hidden, inspector, placements, safetyEvidence }

bool measurementEndpointMatchesComponent(
  String endpoint,
  String componentId,
) {
  return endpoint == componentId || endpoint.startsWith('$componentId.');
}

Map<String, int> measurementCountsByComponents({
  required List<MeasurementFact> measurements,
  required Set<String> componentIds,
}) {
  final counts = <String, int>{};
  for (final componentId in componentIds) {
    final measurementCount = measurements
        .where(
          (measurement) =>
              measurementEndpointMatchesComponent(
                  measurement.from, componentId) ||
              measurementEndpointMatchesComponent(measurement.to, componentId),
        )
        .length;
    if (measurementCount > 0) {
      counts[componentId] = measurementCount;
    }
  }
  return counts;
}

int measurementCountForComponent({
  required List<MeasurementFact> measurements,
  required String componentId,
}) {
  return measurements
      .where(
        (measurement) =>
            measurementEndpointMatchesComponent(
                measurement.from, componentId) ||
            measurementEndpointMatchesComponent(measurement.to, componentId),
      )
      .length;
}

class BoardCanvasScreen extends ConsumerStatefulWidget {
  const BoardCanvasScreen({super.key});

  @override
  ConsumerState<BoardCanvasScreen> createState() => _BoardCanvasScreenState();
}

class _BoardCanvasScreenState extends ConsumerState<BoardCanvasScreen> {
  String? _selectedPlacementKey;
  bool _inspectorVisible = true;
  bool _canvasFocusMode = false;
  _WorkbenchContextPanelMode _contextPanelMode =
      _WorkbenchContextPanelMode.hidden;

  @override
  Widget build(BuildContext context) {
    final ProjectState? projectState = ref.watch(projectStateProvider);

    if (projectState == null) {
      return _buildScaffold(
        context,
        const _EmptyState(
          title: 'Open a project to view its board.',
        ),
      );
    }

    final knownFacts = projectState.knownFacts;
    if (knownFacts.components.isEmpty) {
      return _buildScaffold(
        context,
        const _EmptyState(
          title: 'No components recorded for this project.',
        ),
      );
    }

    final allPlacements = knownFacts.componentVisualPlacements;
    if (allPlacements.isEmpty) {
      return _buildScaffold(
        context,
        const _EmptyState(
          title: 'No confirmed visual placements yet.',
          subtitle:
              'Board canvas is read-only in V1. Placement workflow is a future step.',
        ),
      );
    }

    final renderable = allPlacements
        .where((placement) => placement.coordinateSpace == 'board_normalized')
        .toList(growable: false);

    if (renderable.isEmpty) {
      return _buildScaffold(
        context,
        const _EmptyState(
          title:
              'No board-normalized placements available for this read-only canvas.',
        ),
      );
    }

    final componentsById = <String, ComponentFact>{
      for (final component in knownFacts.components)
        component.componentId: component,
    };

    final entries = renderable
        .map(
          (placement) => _PlacementEntry(
            placement: placement,
            component: componentsById[placement.componentId],
            template: placement.templateId == null
                ? null
                : VectorFootprintLibrary.templateById(placement.templateId!),
          ),
        )
        .toList(growable: false);
    final photoToBoardAlignments = knownFacts.photoToBoardAlignments;

    final selectedKey = _coerceSelection(entries);
    _PlacementEntry? selectedEntry;
    if (selectedKey != null) {
      for (final entry in entries) {
        if (entry.key == selectedKey) {
          selectedEntry = entry;
          break;
        }
      }
    }
    final relatedMeasurements = selectedEntry == null
        ? const <MeasurementFact>[]
        : _measurementsForComponent(
            knownFacts.measurements,
            selectedEntry.placement.componentId,
          );
    final relatedVisualTraces = selectedEntry == null
        ? const <VisualTraceFact>[]
        : _visualTracesForComponent(
            knownFacts.visualTraces,
            selectedEntry.placement.componentId,
          );
    final measurementCountByComponent = measurementCountsByComponents(
      measurements: knownFacts.measurements,
      componentIds: entries.map((entry) => entry.placement.componentId).toSet(),
    );
    final selectedMeasurementCount = selectedEntry == null
        ? 0
        : measurementCountByComponent[selectedEntry.placement.componentId] ?? 0;

    return _buildScaffold(
      context,
      Padding(
        padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final useWorkbenchShell = constraints.maxWidth >= 900;
            final selector = _PlacementSelector(
              entries: entries,
              selectedKey: selectedKey,
              selectedLabel: selectedEntry?.selectorLabel,
              onSelected: (value) {
                setState(() {
                  _selectedPlacementKey = value;
                  _contextPanelMode = _WorkbenchContextPanelMode.inspector;
                  _inspectorVisible = true;
                });
              },
            );
            final focusToggle = _CanvasFocusButton(
              showLabel: false,
              onPressed: () {
                setState(() {
                  _canvasFocusMode = true;
                  _inspectorVisible = false;
                });
              },
            );
            final canvas = _CanvasPanel(
              entries: entries,
              selectedKey: selectedKey,
              measurementCountsByComponentId: measurementCountByComponent,
              cornerFocusAction: useWorkbenchShell && !_canvasFocusMode
                  ? focusToggle
                  : null,
              onPlacementSelected: (value) {
                setState(() {
                  _selectedPlacementKey = value;
                  _contextPanelMode = _WorkbenchContextPanelMode.inspector;
                  _inspectorVisible = true;
                });
              },
              onCanvasTapEmpty: () {
                setState(() {
                  _selectedPlacementKey = null;
                  _contextPanelMode = _WorkbenchContextPanelMode.hidden;
                });
              },
            );
            final metadata = _InspectorPanel(
              selectedEntry: selectedEntry,
              selectedMeasurementCount: selectedMeasurementCount,
              relatedMeasurements: relatedMeasurements,
              relatedVisualTraces: relatedVisualTraces,
              photoToBoardAlignments: photoToBoardAlignments,
            );
            final inspectorToggle = _InspectorChromeToggle(
              inspectorVisible: _inspectorVisible,
              showLabel: false,
              onPressed: () {
                setState(() {
                  _inspectorVisible = !_inspectorVisible;
                });
              },
            );
            final controlBand = useWorkbenchShell
                ? const SizedBox.shrink(key: Key('board_canvas_control_band'))
                : _BoardCanvasControlBand(
                    selector: selector,
                    safetyEvidence: const _BoardCanvasSafetyEvidenceDisclosure(),
                    trailingActions: <Widget>[focusToggle, inspectorToggle],
                  );
            final restoreBar = _CanvasFocusRestoreBar(
              onRestore: () {
                setState(() {
                  _canvasFocusMode = false;
                  _inspectorVisible = true;
                  if (selectedKey == null &&
                      _contextPanelMode == _WorkbenchContextPanelMode.inspector) {
                    _contextPanelMode = _WorkbenchContextPanelMode.hidden;
                  }
                });
              },
            );

            if (useWorkbenchShell) {
              Widget? contextPanel;
              switch (_contextPanelMode) {
                case _WorkbenchContextPanelMode.hidden:
                  contextPanel = null;
                  break;
                case _WorkbenchContextPanelMode.inspector:
                  contextPanel = metadata;
                  break;
                case _WorkbenchContextPanelMode.placements:
                  contextPanel = _PlacementSelector(
                    entries: entries,
                    selectedKey: selectedKey,
                    selectedLabel: selectedEntry?.selectorLabel,
                    initiallyExpanded: true,
                    onSelected: (value) {
                      setState(() {
                        _selectedPlacementKey = value;
                        _contextPanelMode = _WorkbenchContextPanelMode.inspector;
                        _inspectorVisible = true;
                      });
                    },
                  );
                  break;
                case _WorkbenchContextPanelMode.safetyEvidence:
                  contextPanel = const _BoardCanvasSafetyEvidenceDisclosure(
                    initiallyExpanded: true,
                  );
                  break;
              }
              final contextPanelWidth = constraints.maxWidth >= 1180
                  ? _kWideContextPanelWidth
                  : _kMediumContextPanelWidth;
              final showContextPanel = _inspectorVisible &&
                  !_canvasFocusMode &&
                  contextPanel != null;
              final focusPanelToggle = _WorkbenchPanelModeButton(
                buttonKey: const Key('board_canvas_rail_placements_tool'),
                icon: Icons.format_list_bulleted_rounded,
                tooltip: 'Show placements in right contextual panel',
                label: 'Placements',
                selected:
                    _contextPanelMode == _WorkbenchContextPanelMode.placements,
                onPressed: () {
                  setState(() {
                    _selectedPlacementKey = null;
                    _contextPanelMode = _WorkbenchContextPanelMode.placements;
                    _inspectorVisible = true;
                  });
                },
              );
              final safetyPanelToggle = _WorkbenchPanelModeButton(
                buttonKey: const Key('board_canvas_rail_safety_evidence_tool'),
                icon: Icons.shield_outlined,
                tooltip: 'Show safety/evidence read-only details',
                label: 'Safety / Evidence',
                selected:
                    _contextPanelMode ==
                        _WorkbenchContextPanelMode.safetyEvidence,
                onPressed: () {
                  setState(() {
                    _selectedPlacementKey = null;
                    _contextPanelMode =
                        _WorkbenchContextPanelMode.safetyEvidence;
                    _inspectorVisible = true;
                  });
                },
              );
              return Row(
                key: const Key('board_canvas_workbench_shell'),
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (!_canvasFocusMode) ...[
                    _WorkbenchToolRail(
                      inspectorToggle: inspectorToggle,
                      placementTool: focusPanelToggle,
                      safetyEvidenceTool: safetyPanelToggle,
                    ),
                    const SizedBox(width: 6),
                  ],
                  Expanded(
                    child: Column(
                      key: const Key('board_canvas_workbench_canvas_zone'),
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (_canvasFocusMode) restoreBar,
                        Expanded(child: canvas),
                      ],
                    ),
                  ),
                  if (showContextPanel) ...[
                    const SizedBox(width: 8),
                    SizedBox(
                      key: const Key('board_canvas_context_panel'),
                      width: contextPanelWidth,
                      child: contextPanel,
                    ),
                  ],
                ],
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (_canvasFocusMode) restoreBar else controlBand,
                const SizedBox(height: 4),
                Expanded(
                  flex: _inspectorVisible && !_canvasFocusMode ? 4 : 1,
                  child: canvas,
                ),
                if (_inspectorVisible && !_canvasFocusMode) ...[
                  const SizedBox(height: 4),
                  Expanded(flex: 2, child: metadata),
                ],
              ],
            );
          },
        ),
      ),
    );
  }

  List<MeasurementFact> _measurementsForComponent(
    List<MeasurementFact> measurements,
    String componentId,
  ) {
    return measurements.where((measurement) {
      return measurementEndpointMatchesComponent(
            measurement.from,
            componentId,
          ) ||
          measurementEndpointMatchesComponent(measurement.to, componentId);
    }).toList(growable: false);
  }

  bool _measurementEndpointMatchesComponent(
      String endpoint, String componentId) {
    return measurementEndpointMatchesComponent(endpoint, componentId);
  }

  List<VisualTraceFact> _visualTracesForComponent(
    List<VisualTraceFact> visualTraces,
    String componentId,
  ) {
    return visualTraces
        .where(
          (trace) =>
              trace.fromComponent == componentId ||
              trace.toComponent == componentId ||
              _visualTracePinMatchesComponent(trace.fromPin, componentId) ||
              _visualTracePinMatchesComponent(trace.toPin, componentId),
        )
        .toList(growable: false);
  }

  bool _visualTracePinMatchesComponent(String? pinId, String componentId) {
    if (pinId == null) {
      return false;
    }
    return pinId.startsWith('$componentId.');
  }

  String? _coerceSelection(List<_PlacementEntry> entries) {
    if (entries.isEmpty) {
      if (_selectedPlacementKey != null) {
        _selectedPlacementKey = null;
        _contextPanelMode = _WorkbenchContextPanelMode.hidden;
      }
      return null;
    }

    final current = _selectedPlacementKey;
    if (current != null && entries.any((entry) => entry.key == current)) {
      return current;
    }

    if (_selectedPlacementKey != null) {
      if (_contextPanelMode == _WorkbenchContextPanelMode.inspector) {
        _contextPanelMode = _WorkbenchContextPanelMode.hidden;
      }
      _selectedPlacementKey = null;
    }
    return null;
  }

  Widget _buildScaffold(BuildContext context, Widget content) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: _kCompactBoardCanvasAppBarHeight,
        leadingWidth: 36,
        titleSpacing: 0,
        title: const Text('Board Canvas'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: content),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              child: const Text(
                'renderer writes: none',
                key: Key('renderer_writes_none'),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.title, this.subtitle});

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 8),
              Text(
                subtitle!,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _PhotoAlignmentReadinessPanel extends StatelessWidget {
  const _PhotoAlignmentReadinessPanel({required this.alignments});

  final List<PhotoToBoardAlignmentFact> alignments;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: theme.colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: theme.colorScheme.outlineVariant),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 220),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _SectionHeader(
                title: 'Photo alignment readiness — metadata only',
                tag: 'READINESS',
              ),
              const SizedBox(height: 6),
              const Text('Stores alignment reference points only.'),
              const Text(
                'Does not confirm identity, nets, measurements, or faults.',
              ),
              const Text(
                  'No photo-local evidence is rendered on board canvas.'),
              const Text('No transform is computed.'),
              const Text('Not electrical proof.'),
              const SizedBox(height: 8),
              ...alignments.map(
                (alignment) => _PhotoAlignmentSummaryTile(alignment: alignment),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BoardCanvasControlBand extends StatelessWidget {
  const _BoardCanvasControlBand({
    required this.selector,
    required this.safetyEvidence,
    required this.trailingActions,
  });

  final Widget selector;
  final Widget safetyEvidence;
  final List<Widget> trailingActions;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 760) {
          return Row(
            key: const Key('board_canvas_control_band'),
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 5, child: selector),
              const SizedBox(width: 4),
              Expanded(flex: 3, child: safetyEvidence),
              for (final action in trailingActions) ...[
                const SizedBox(width: 4),
                action,
              ],
            ],
          );
        }

        return Column(
          key: const Key('board_canvas_control_band'),
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            selector,
            const SizedBox(height: 4),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: safetyEvidence),
                for (final action in trailingActions) ...[
                  const SizedBox(width: 4),
                  action,
                ],
              ],
            ),
          ],
        );
      },
    );
  }
}

class _WorkbenchToolRail extends StatelessWidget {
  const _WorkbenchToolRail({
    required this.inspectorToggle,
    required this.placementTool,
    required this.safetyEvidenceTool,
  });

  final Widget inspectorToggle;
  final Widget placementTool;
  final Widget safetyEvidenceTool;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      key: const Key('board_canvas_workbench_rail'),
      width: _kWorkbenchRailWidth,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: theme.colorScheme.outlineVariant),
        ),
        child: Padding(
          padding: _kWorkbenchRailPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _WorkbenchSectionHeader(label: 'Workbench tools'),
              const SizedBox(height: _kWorkbenchToolTileGap),
              inspectorToggle,
              const SizedBox(height: _kWorkbenchToolTileGap),
              placementTool,
              const SizedBox(height: _kWorkbenchToolTileGap),
              safetyEvidenceTool,
              const SizedBox(height: 6),
              Divider(
                height: 1,
                thickness: 1,
                color: theme.colorScheme.outlineVariant,
              ),
              const SizedBox(height: 6),
              const _WorkbenchSectionHeader(label: 'Future tools'),
              const SizedBox(height: 4),
              const _InactiveRailToolButton(
                buttonKey: Key('board_canvas_rail_future_trace_tool'),
                icon: Icons.timeline,
                tooltip: 'Trace map (future/readonly) - inactive',
                label: 'Trace',
                showLabel: true,
              ),
              const SizedBox(height: _kWorkbenchToolTileGap),
              const _InactiveRailToolButton(
                buttonKey: Key('board_canvas_rail_future_repair_map_tool'),
                icon: Icons.map_outlined,
                tooltip: 'Repair map (future) - inactive',
                label: 'Repair map',
                showLabel: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WorkbenchPanelModeButton extends StatelessWidget {
  const _WorkbenchPanelModeButton({
    required this.buttonKey,
    required this.icon,
    required this.tooltip,
    required this.label,
    required this.selected,
    required this.onPressed,
  });

  final Key buttonKey;
  final IconData icon;
  final String tooltip;
  final String label;
  final bool selected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tileColor = selected
        ? theme.colorScheme.primaryContainer.withValues(alpha: 0.35)
        : theme.colorScheme.surfaceContainerLow;

    final content = SizedBox(
      width: _kCompactControlTileHeight,
      height: _kCompactControlTileHeight,
      child: IconButton(
        key: buttonKey,
        tooltip: tooltip,
        iconSize: _kWorkbenchRailContentIconSize,
        style: IconButton.styleFrom(
          minimumSize: const Size.square(_kCompactControlTileHeight),
          padding: EdgeInsets.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          foregroundColor: selected
              ? theme.colorScheme.onPrimaryContainer
              : theme.colorScheme.onSurfaceVariant,
        ),
        icon: Icon(icon),
        onPressed: onPressed,
      ),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Card(
          margin: EdgeInsets.zero,
          color: tileColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: theme.colorScheme.outlineVariant),
          ),
          child: content,
        ),
        const SizedBox(height: 2),
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: theme.textTheme.labelSmall,
        ),
      ],
    );
  }
}

class _WorkbenchSectionHeader extends StatelessWidget {
  const _WorkbenchSectionHeader({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 2, bottom: 2),
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: theme.textTheme.labelSmall,
      ),
    );
  }
}

class _InactiveRailToolButton extends StatelessWidget {
  const _InactiveRailToolButton({
    required this.buttonKey,
    required this.icon,
    required this.tooltip,
    this.label,
    this.showLabel = false,
  });

  final Key buttonKey;
  final IconData icon;
  final String tooltip;
  final String? label;
  final bool showLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final button = SizedBox(
      width: _kCompactControlTileHeight,
      height: _kCompactControlTileHeight,
      child: IconButton(
        key: buttonKey,
        tooltip: tooltip,
        iconSize: _kCompactControlIconSize,
        style: IconButton.styleFrom(
          minimumSize: const Size.square(_kCompactControlTileHeight),
          padding: EdgeInsets.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          foregroundColor: theme.disabledColor,
        ),
        icon: Icon(icon),
        onPressed: null,
      ),
    );

    if (!showLabel || label == null) {
      return button;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        button,
        const SizedBox(height: 2),
        Text(
          label!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: theme.textTheme.labelSmall,
        ),
      ],
    );
  }
}

class _CompactDisclosureTitle extends StatelessWidget {
  const _CompactDisclosureTitle({
    required this.label,
    required this.detail,
  });

  final String label;
  final String detail;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Flexible(
          flex: 4,
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.labelLarge,
          ),
        ),
        const SizedBox(width: 6),
        Flexible(
          flex: 3,
          child: Text(
            detail,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}

class _CanvasFocusButton extends StatelessWidget {
  const _CanvasFocusButton({
    required this.onPressed,
    this.showLabel = false,
  });

  final VoidCallback onPressed;
  final bool showLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final button = Card(
      margin: EdgeInsets.zero,
      color: theme.colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: theme.colorScheme.outlineVariant),
      ),
      child: SizedBox(
        width: _kCompactControlTileHeight,
        height: _kCompactControlTileHeight,
        child: IconButton(
          key: const Key('board_canvas_focus_toggle_button'),
          tooltip: 'Focus canvas',
          iconSize: _kWorkbenchRailContentIconSize,
          style: IconButton.styleFrom(
            minimumSize: const Size.square(_kCompactControlTileHeight),
            padding: EdgeInsets.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          icon: const Icon(Icons.fullscreen),
          onPressed: onPressed,
        ),
      ),
    );

    if (!showLabel) {
      return button;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        button,
        const SizedBox(height: 2),
        Text(
          'Focus canvas',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: theme.textTheme.labelSmall,
        ),
      ],
    );
  }
}

class _InspectorChromeToggle extends StatelessWidget {
  const _InspectorChromeToggle({
    required this.inspectorVisible,
    required this.onPressed,
    this.showLabel = false,
  });

  final bool inspectorVisible;
  final VoidCallback onPressed;
  final bool showLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final icon = inspectorVisible
        ? Icons.keyboard_double_arrow_right
        : Icons.keyboard_double_arrow_left;
    final tooltip = inspectorVisible ? 'Hide inspector' : 'Show inspector';
    final label = inspectorVisible ? 'Hide inspector' : 'Show inspector';
    final button = Card(
      margin: EdgeInsets.zero,
      color: theme.colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: theme.colorScheme.outlineVariant),
      ),
      child: SizedBox(
        width: _kCompactControlTileHeight,
        height: _kCompactControlTileHeight,
        child: IconButton(
          key: const Key('board_canvas_inspector_toggle_button'),
          tooltip: tooltip,
          iconSize: _kWorkbenchRailContentIconSize,
          style: IconButton.styleFrom(
            minimumSize: const Size.square(_kCompactControlTileHeight),
            padding: EdgeInsets.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          icon: Icon(icon),
          onPressed: onPressed,
        ),
      ),
    );

    if (!showLabel) {
      return button;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        button,
        const SizedBox(height: 2),
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: theme.textTheme.labelSmall,
        ),
      ],
    );
  }
}

class _CanvasFocusRestoreBar extends StatelessWidget {
  const _CanvasFocusRestoreBar({required this.onRestore});

  final VoidCallback onRestore;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      key: const Key('board_canvas_focus_restore_bar'),
      margin: EdgeInsets.zero,
      color: theme.colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: theme.colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          children: [
            Icon(
              Icons.fullscreen_exit,
              size: _kCompactControlIconSize,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                'Canvas focus mode. Controls and read-only details are recoverable.',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall,
              ),
            ),
            const SizedBox(width: 8),
            TextButton(
              key: const Key('board_canvas_focus_restore_button'),
              style: TextButton.styleFrom(
                minimumSize: const Size(96, _kCompactControlTileHeight - 4),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
              ),
              onPressed: onRestore,
              child: const Text('Show controls'),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlacementSelector extends StatelessWidget {
  const _PlacementSelector({
    required this.entries,
    required this.selectedKey,
    required this.selectedLabel,
    required this.onSelected,
    this.initiallyExpanded = false,
  });

  final List<_PlacementEntry> entries;
  final String? selectedKey;
  final String? selectedLabel;
  final ValueChanged<String> onSelected;
  final bool initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final summary = selectedLabel ??
        '${entries.length} placement${entries.length == 1 ? '' : 's'} available';
    return Card(
      margin: EdgeInsets.zero,
      color: theme.colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: theme.colorScheme.outlineVariant),
      ),
      child: ExpansionTile(
        key: const Key('board_canvas_placement_selector_disclosure'),
        initiallyExpanded: initiallyExpanded,
        maintainState: true,
        dense: true,
        visualDensity: VisualDensity.compact,
        minTileHeight: _kCompactControlTileHeight,
        tilePadding: _kCompactControlTilePadding,
        childrenPadding: _kCompactControlChildrenPadding,
        title: _CompactDisclosureTitle(
          label: 'Placements',
          detail: summary,
        ),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: entries
                    .map(
                      (entry) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          key: Key('placement_selector_${entry.key}'),
                          label: Text(entry.selectorLabel),
                          selected: selectedKey == entry.key,
                          onSelected: (_) => onSelected(entry.key),
                        ),
                      ),
                    )
                    .toList(growable: false),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CanvasStatusPill extends StatelessWidget {
  const _CanvasStatusPill();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLow.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Board projection canvas',
              style: theme.textTheme.labelLarge,
            ),
            Text(
              'Existing board-normalized placements only',
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

class _CanvasPanel extends StatefulWidget {
  const _CanvasPanel({
    required this.entries,
    required this.selectedKey,
    required this.measurementCountsByComponentId,
    this.cornerFocusAction,
    required this.onPlacementSelected,
    required this.onCanvasTapEmpty,
  });

  final List<_PlacementEntry> entries;
  final String? selectedKey;
  final Map<String, int> measurementCountsByComponentId;
  final Widget? cornerFocusAction;
  final ValueChanged<String> onPlacementSelected;
  final VoidCallback onCanvasTapEmpty;

  @override
  State<_CanvasPanel> createState() => _CanvasPanelState();
}

class _CanvasPanelState extends State<_CanvasPanel> {
  static const double _kMinZoom = 0.5;
  static const double _kMaxZoom = 4.0;

  final TransformationController _transformationController =
      TransformationController();

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  void _fitCanvasView() {
    _transformationController.value = Matrix4.identity();
  }

  void _selectPlacementAt(Offset position, Size size) {
    for (final entry in widget.entries.reversed) {
      if (_renderedPlacementContains(
        entry: entry,
        position: position,
        size: size,
      )) {
        widget.onPlacementSelected(entry.key);
        return;
      }
    }
    widget.onCanvasTapEmpty();
  }

  Widget _buildCanvas(BuildContext context, {required Size size}) {
    final theme = Theme.of(context);
    return InteractiveViewer(
      key: const Key('board_canvas_interactive_viewer'),
      transformationController: _transformationController,
      minScale: _kMinZoom,
      maxScale: _kMaxZoom,
      panEnabled: true,
      scaleEnabled: true,
      constrained: false,
      child: GestureDetector(
        key: const Key('board_canvas_tap_layer'),
        behavior: HitTestBehavior.opaque,
        onTapUp: (details) => _selectPlacementAt(details.localPosition, size),
        child: CustomPaint(
          key: const Key('board_canvas_painter'),
          painter: _BoardPlacementPainter(
            entries: widget.entries,
            selectedKey: widget.selectedKey,
            measurementCountsByComponentId:
                widget.measurementCountsByComponentId,
            colorScheme: theme.colorScheme,
          ),
          child: SizedBox(
            width: math.max(240, size.width),
            height: math.max(96, size.height),
          ),
        ),
      ),
    );
  }

  Widget _buildCornerControls(BuildContext context) {
    final theme = Theme.of(context);
    final fitButton = IconButton(
      key: const Key('board_canvas_fit_view_button'),
      tooltip: 'Fit board view',
      icon: const Icon(Icons.center_focus_strong),
      color: theme.colorScheme.onSurface,
      onPressed: _fitCanvasView,
    );

    return Positioned(
      top: 8,
      right: 8,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.cornerFocusAction != null) ...[
            widget.cornerFocusAction!,
            const SizedBox(width: 6),
          ],
          fitButton,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: theme.colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: theme.colorScheme.outlineVariant),
      ),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                Positioned.fill(
                  child: LayoutBuilder(
                    builder: (context, canvasConstraints) {
                      return _buildCanvas(
                        context,
                        size: Size(
                          math.max(240, canvasConstraints.maxWidth),
                          math.max(96, canvasConstraints.maxHeight),
                        ),
                      );
                    },
                  ),
                ),
                const Positioned(
                  left: 6,
                  top: 6,
                  child: _CanvasStatusPill(),
                ),
                _buildCornerControls(context),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _BoardCanvasSafetyEvidenceDisclosure extends StatelessWidget {
  const _BoardCanvasSafetyEvidenceDisclosure({this.initiallyExpanded = false});

  final bool initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: EdgeInsets.zero,
      color: theme.colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: theme.colorScheme.outlineVariant),
      ),
      child: ExpansionTile(
        key: const Key('board_canvas_safety_evidence_disclosure'),
        initiallyExpanded: initiallyExpanded,
        maintainState: true,
        dense: true,
        visualDensity: VisualDensity.compact,
        minTileHeight: _kCompactControlTileHeight,
        tilePadding: _kCompactControlTilePadding,
        childrenPadding: _kCompactControlChildrenPadding,
        title: _CompactDisclosureTitle(
          label: 'Safety / Evidence',
          detail: 'read-only boundaries',
        ),
        children: [
          _BoardCanvasLegend(),
        ],
      ),
    );
  }
}

class _BoardCanvasLegend extends StatelessWidget {
  const _BoardCanvasLegend();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color:
            theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Wrap(
              spacing: 10,
              runSpacing: 6,
              children: [
                _LegendItem(label: 'Body outline'),
                _LegendItem(label: 'Pin pads'),
                _LegendItem(label: 'Pin-1 marker'),
                _LegendItem(label: 'Designator'),
                _LegendItem(label: 'Measurement badge'),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              'Footprint geometry is read-only display metadata.',
              style: theme.textTheme.bodySmall,
            ),
            Text(
              'Template family is not electrical identity; visual metadata does not establish a net.',
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: 6),
            Text(
              'Measurement badge: component has related measurement(s).',
              style: theme.textTheme.bodySmall,
            ),
            Text(
              'Component-level only.',
              style: theme.textTheme.bodySmall,
            ),
            Text(
              'No measurement board coordinate is available.',
              style: theme.textTheme.bodySmall,
            ),
            Text(
              'Does not create or confirm a net.',
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 9,
          height: 9,
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer,
            border: Border.all(color: theme.colorScheme.primary),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style: theme.textTheme.bodySmall,
        ),
      ],
    );
  }
}

class _PhotoAlignmentSummaryTile extends StatelessWidget {
  const _PhotoAlignmentSummaryTile({required this.alignment});

  final PhotoToBoardAlignmentFact alignment;

  @override
  Widget build(BuildContext context) {
    final referencePairCount = math.min(
      alignment.referencePointsPhoto.length,
      alignment.referencePointsBoard.length,
    );
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border:
              Border.all(color: Theme.of(context).colorScheme.outlineVariant),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _InspectorField(
                  label: 'Alignment ID', value: alignment.alignmentId),
              _InspectorField(
                  label: 'Source photo ID', value: alignment.sourcePhotoId),
              _InspectorField(label: 'Board side', value: alignment.boardSide),
              _InspectorField(
                label: 'Coordinate space from',
                value: alignment.coordinateSpaceFrom,
              ),
              _InspectorField(
                label: 'Coordinate space to',
                value: alignment.coordinateSpaceTo,
              ),
              _InspectorField(
                label: 'Reference pairs',
                value: referencePairCount.toString(),
              ),
              _InspectorField(
                label: 'declared type — not computed',
                value: alignment.transformType,
              ),
              _InspectorField(
                label: 'Alignment quality label',
                value: alignment.alignmentQualityLabel,
              ),
              _InspectorField(
                label: 'Source event ID',
                value: alignment.sourceEventId,
              ),
              _InspectorField(label: 'Status', value: alignment.status),
            ],
          ),
        ),
      ),
    );
  }
}

class _InspectorPanel extends StatelessWidget {
  const _InspectorPanel({
    required this.selectedEntry,
    required this.selectedMeasurementCount,
    required this.relatedMeasurements,
    required this.relatedVisualTraces,
    required this.photoToBoardAlignments,
  });

  final _PlacementEntry? selectedEntry;
  final int selectedMeasurementCount;
  final List<MeasurementFact> relatedMeasurements;
  final List<VisualTraceFact> relatedVisualTraces;
  final List<PhotoToBoardAlignmentFact> photoToBoardAlignments;

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];

    if (selectedEntry == null) {
      children.add(
        const Card(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text('Select a placement to view read-only details.'),
            ),
          ),
        ),
      );
    } else {
      children.add(
        _PlacementInspectorCard(
          entry: selectedEntry!,
          selectedMeasurementCount: selectedMeasurementCount,
        ),
      );
      children.add(
        _MeasurementSummaryCard(relatedMeasurements: relatedMeasurements),
      );
      children.add(
        _VisualTraceMetadataCard(relatedVisualTraces: relatedVisualTraces),
      );
    }

    if (photoToBoardAlignments.isNotEmpty) {
      children.add(
        _PhotoAlignmentReadinessPanel(alignments: photoToBoardAlignments),
      );
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var index = 0; index < children.length; index++) ...[
            if (index > 0) const SizedBox(height: 12),
            children[index],
          ],
        ],
      ),
    );
  }
}

class _PlacementInspectorCard extends StatelessWidget {
  const _PlacementInspectorCard({
    required this.entry,
    required this.selectedMeasurementCount,
  });

  final _PlacementEntry entry;
  final int selectedMeasurementCount;

  @override
  Widget build(BuildContext context) {
    final placement = entry.placement;
    final component = entry.component;
    final packageLabel =
        entry.template?.displayName ?? 'Unknown package geometry';
    final templateId = placement.templateId ?? 'not provided';
    final identityStatus = _identityStatus(component);
    final badgeCountLabel = selectedMeasurementCount == 1
        ? 'Related measurement: 1'
        : 'Related measurements: $selectedMeasurementCount';

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SectionHeader(
              title: 'Placement inspector (read-only)',
              tag: identityStatus == 'unknown' ? 'UNKNOWN' : null,
              subtitle: 'read-only · projection view',
            ),
            const SizedBox(height: 12),
            _InspectorField(
                label: 'Component ID', value: placement.componentId),
            if ((component?.designator ?? '').isNotEmpty)
              _InspectorField(
                label: 'Designator',
                value: component!.designator!,
              ),
            _InspectorField(label: 'Template ID', value: templateId),
            _InspectorField(
              label: 'Package',
              value: '$packageLabel (package geometry)',
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 6),
              child: Text('template family — not a part identity'),
            ),
            _InspectorField(
              label: 'Identity status',
              value: identityStatus,
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 6),
              child: Text('identity not confirmed in this projection'),
            ),
            const _InspectorField(
              label: 'Electrical role',
              value: 'not confirmed',
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 6),
              child: Text('Template does not prove electrical identity.'),
            ),
            _InspectorField(label: 'Placement status', value: placement.status),
            _InspectorField(
              label: 'Coordinate space',
              value: placement.coordinateSpace,
            ),
            _InspectorField(label: 'Board side', value: placement.boardSide),
            _InspectorField(
                label: 'Center X', value: placement.centerX.toString()),
            _InspectorField(
                label: 'Center Y', value: placement.centerY.toString()),
            _InspectorField(
              label: 'Rotation (deg)',
              value: placement.rotationDeg.toString(),
            ),
            if (placement.scale != null)
              _InspectorField(label: 'Scale', value: placement.scale.toString())
            else ...[
              if (placement.width != null)
                _InspectorField(
                  label: 'Width',
                  value: placement.width.toString(),
                ),
              if (placement.height != null)
                _InspectorField(
                  label: 'Height',
                  value: placement.height.toString(),
                ),
            ],
            _InspectorField(
              label: 'Source event ID',
              value: placement.sourceEventId,
            ),
            _InspectorField(label: 'Status', value: placement.status),
            if (selectedMeasurementCount > 0) ...[
              const SizedBox(height: 12),
              const _SectionHeader(
                title: 'Measurement badge',
                tag: 'MARKER',
              ),
              const SizedBox(height: 6),
              Text(badgeCountLabel),
              const Text('Component-level presence only.'),
              const Text('No board-coordinate interpretation is claimed.'),
              const Text(
                  'No probe, pin/anchor, or endpoint line semantics are shown.'),
              const Text('Does not create or confirm a net.'),
              const SizedBox(height: 8),
            ],
            if (component?.installationStatus != null)
              _InspectorField(
                label: 'Installation status',
                value: component!.installationStatus!,
              ),
            if (component?.removedByEventId != null)
              _InspectorField(
                label: 'Removed by event ID',
                value: component!.removedByEventId!,
              ),
          ],
        ),
      ),
    );
  }
}

class _MeasurementSummaryCard extends StatelessWidget {
  const _MeasurementSummaryCard({required this.relatedMeasurements});

  final List<MeasurementFact> relatedMeasurements;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _SectionHeader(
              title: 'Measurement — read-only summary',
              tag: 'MEASURED',
            ),
            const SizedBox(height: 6),
            const Text('measured value — shown verbatim'),
            const Text('Value shown verbatim'),
            const Text('Does not create or confirm a net'),
            const Text('No board coordinate available'),
            if (relatedMeasurements.isEmpty) ...[
              const SizedBox(height: 6),
              const Text('No related measurements for selected component.'),
            ] else ...[
              const SizedBox(height: 8),
              ...relatedMeasurements.map(
                (measurement) => _MeasurementSummaryTile(
                  measurement: measurement,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _VisualTraceMetadataCard extends StatelessWidget {
  const _VisualTraceMetadataCard({required this.relatedVisualTraces});

  final List<VisualTraceFact> relatedVisualTraces;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _SectionHeader(
              title: 'Visual trace — read-only metadata',
              tag: 'VISUAL',
            ),
            const SizedBox(height: 6),
            const Text('visual metadata — does not establish a net'),
            const Text('Visual trace is not a confirmed electrical net'),
            const Text('Photo-local evidence; no board coordinate available'),
            const Text('Does not create or confirm connectivity'),
            if (relatedVisualTraces.isEmpty) ...[
              const SizedBox(height: 6),
              const Text('No related visual traces for selected component.'),
            ] else ...[
              const SizedBox(height: 8),
              ...relatedVisualTraces.map(
                (trace) => _VisualTraceSummaryTile(trace: trace),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

String _identityStatus(ComponentFact? component) {
  if (component == null) {
    return 'unknown';
  }

  final status = component.status?.toLowerCase();
  final type = component.type?.trim();
  const confirmedStates = {
    'human_confirmed',
    'user_confirmed',
    'confirmed',
    'identity_confirmed',
  };

  if (type != null && type.isNotEmpty && confirmedStates.contains(status)) {
    return 'human-confirmed ($type)';
  }

  return 'unknown';
}

class _MeasurementSummaryTile extends StatelessWidget {
  const _MeasurementSummaryTile({required this.measurement});

  final MeasurementFact measurement;

  @override
  Widget build(BuildContext context) {
    final isStale = measurement.validityStatus == 'stale_after_repair';
    final valueText = measurement.value == null
        ? measurement.reading
        : '${measurement.value}${measurement.unit == null ? '' : ' ${measurement.unit}'}';

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border:
              Border.all(color: Theme.of(context).colorScheme.outlineVariant),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _InspectorField(
                  label: 'Measurement ID', value: measurement.measurementId),
              _InspectorField(label: 'Mode', value: measurement.mode),
              _InspectorField(label: 'From', value: measurement.from),
              _InspectorField(label: 'To', value: measurement.to),
              _InspectorField(label: 'Value', value: valueText),
              _InspectorField(
                  label: 'Power state', value: measurement.powerState),
              _InspectorField(
                  label: 'Validity status', value: measurement.validityStatus),
              if (isStale) const Text('Stale after repair'),
              if (measurement.originEventId != null)
                _InspectorField(
                  label: 'Origin event ID',
                  value: measurement.originEventId!,
                ),
              if (measurement.validUntilEventId != null)
                _InspectorField(
                  label: 'Valid until event ID',
                  value: measurement.validUntilEventId!,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _VisualTraceSummaryTile extends StatelessWidget {
  const _VisualTraceSummaryTile({required this.trace});

  final VisualTraceFact trace;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border:
              Border.all(color: Theme.of(context).colorScheme.outlineVariant),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _InspectorField(label: 'Trace ID', value: trace.traceId),
              _InspectorField(label: 'Photo ID', value: trace.photoId),
              _InspectorField(
                  label: 'Evidence type', value: trace.evidenceType),
              if (trace.fromComponent != null)
                _InspectorField(
                  label: 'From component',
                  value: trace.fromComponent!,
                ),
              if (trace.toComponent != null)
                _InspectorField(
                  label: 'To component',
                  value: trace.toComponent!,
                ),
              if (trace.fromPin != null)
                _InspectorField(
                  label: 'From pin',
                  value: trace.fromPin!,
                ),
              if (trace.toPin != null)
                _InspectorField(
                  label: 'To pin',
                  value: trace.toPin!,
                ),
              if (trace.confidence != null)
                _InspectorField(
                  label: 'Confidence',
                  value: trace.confidence!,
                ),
              if (trace.layer != null)
                _InspectorField(
                  label: 'Layer',
                  value: trace.layer!,
                ),
              if (trace.notes != null)
                _InspectorField(
                  label: 'Notes',
                  value: trace.notes!,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, this.tag, this.subtitle});

  final String title;
  final String? tag;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                title,
                style: theme.textTheme.titleSmall,
              ),
            ),
            if (tag != null) ...[
              const SizedBox(width: 8),
              _EvidenceTag(label: tag!),
            ],
          ],
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 2),
          Text(
            subtitle!,
            style: theme.textTheme.bodySmall,
          ),
        ],
      ],
    );
  }
}

class _EvidenceTag extends StatelessWidget {
  const _EvidenceTag({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: Text(
          label,
          style: theme.textTheme.labelSmall,
        ),
      ),
    );
  }
}

class _InspectorField extends StatelessWidget {
  const _InspectorField({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        '$label: $value',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}

class _PlacementEntry {
  const _PlacementEntry({
    required this.placement,
    required this.component,
    required this.template,
  });

  final ComponentVisualPlacementFact placement;
  final ComponentFact? component;
  final FootprintTemplate? template;

  String get key => '${placement.componentId}|${placement.sourceEventId}';

  String get selectorLabel {
    final designator = component?.designator?.trim();
    if (designator != null && designator.isNotEmpty) {
      return '$designator (${placement.componentId})';
    }
    return placement.componentId;
  }
}

Offset _renderedPlacementCenter(_PlacementEntry entry, Size size) {
  final placement = entry.placement;
  final normalizedX = placement.centerX.toDouble().clamp(0.0, 1.0);
  final normalizedY = placement.centerY.toDouble().clamp(0.0, 1.0);
  return Offset(normalizedX * size.width, normalizedY * size.height);
}

Size _renderedPlacementBodySize(_PlacementEntry entry) {
  final placement = entry.placement;
  if (placement.scale != null) {
    final scale = placement.scale!.toDouble();
    const base = 28.0;
    final scaled = (base * scale).clamp(8.0, 140.0);
    return Size(scaled, (scaled * 0.66).clamp(6.0, 120.0));
  }

  if (placement.width != null && placement.height != null) {
    final width = (placement.width!.toDouble() * 60).clamp(8.0, 140.0);
    final height = (placement.height!.toDouble() * 60).clamp(6.0, 120.0);
    return Size(width, height);
  }

  final template = entry.template;
  if (template != null) {
    final width = (template.body.width * 40).clamp(8.0, 140.0);
    final height = (template.body.height * 40).clamp(6.0, 120.0);
    return Size(width, height);
  }

  return const Size(24, 16);
}

bool _renderedPlacementContains({
  required _PlacementEntry entry,
  required Offset position,
  required Size size,
}) {
  final center = _renderedPlacementCenter(entry, size);
  final bodySize = _renderedPlacementBodySize(entry);
  final translated = position - center;
  final rotation = -entry.placement.rotationDeg.toDouble() * math.pi / 180.0;
  final cosTheta = math.cos(rotation);
  final sinTheta = math.sin(rotation);
  final localPosition = Offset(
    translated.dx * cosTheta - translated.dy * sinTheta,
    translated.dx * sinTheta + translated.dy * cosTheta,
  );
  return Rect.fromCenter(
    center: Offset.zero,
    width: bodySize.width,
    height: bodySize.height,
  ).contains(localPosition);
}

class _BoardPlacementPainter extends CustomPainter {
  _BoardPlacementPainter({
    required this.entries,
    required this.selectedKey,
    required this.measurementCountsByComponentId,
    required this.colorScheme,
  });

  final List<_PlacementEntry> entries;
  final String? selectedKey;
  final Map<String, int> measurementCountsByComponentId;
  final ColorScheme colorScheme;

  @override
  void paint(Canvas canvas, Size size) {
    final boardRect = Rect.fromLTWH(0, 0, size.width, size.height);

    const boardBase = Color(0xFF101A17);
    const boardInset = Color(0xFF172722);
    const boardBorder = Color(0xFF325247);
    const gridColor = Color(0x2F4D7A65);

    final boardPaint = Paint()
      ..color = boardBase
      ..style = PaintingStyle.fill;
    canvas.drawRect(boardRect, boardPaint);

    final innerBoardPaint = Paint()
      ..color = boardInset
      ..style = PaintingStyle.fill;
    canvas.drawRect(boardRect.deflate(6), innerBoardPaint);

    final gridPaint = Paint()
      ..color = gridColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    const gridStep = 26.0;
    for (double x = 6; x < size.width - 6; x += gridStep) {
      canvas.drawLine(Offset(x, 6), Offset(x, size.height - 6), gridPaint);
    }
    for (double y = 6; y < size.height - 6; y += gridStep) {
      canvas.drawLine(Offset(6, y), Offset(size.width - 6, y), gridPaint);
    }

    final borderPaint = Paint()
      ..color = boardBorder
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawRect(boardRect.deflate(0.5), borderPaint);

    for (final entry in entries) {
      final placement = entry.placement;
      final center = _renderedPlacementCenter(entry, size);
      final bodySize = _renderedPlacementBodySize(entry);
      final selected = entry.key == selectedKey;

      final fillPaint = Paint()
        ..color = selected
            ? colorScheme.primary.withValues(alpha: 0.28)
            : const Color(0xFFE5DDC5).withValues(alpha: 0.88)
        ..style = PaintingStyle.fill;

      final strokePaint = Paint()
        ..color = selected ? colorScheme.primary : const Color(0xFF222821)
        ..style = PaintingStyle.stroke
        ..strokeWidth = selected ? 2.4 : 1.3;

      final padFillPaint = Paint()
        ..color = selected
            ? colorScheme.primaryContainer.withValues(alpha: 0.95)
            : const Color(0xFFD8B36A)
        ..style = PaintingStyle.fill;

      final padStrokePaint = Paint()
        ..color = selected ? colorScheme.primary : const Color(0xFF312817)
        ..style = PaintingStyle.stroke
        ..strokeWidth = selected ? 1.1 : 0.8;

      final markerPaint = Paint()
        ..color = selected ? colorScheme.primary : const Color(0xFF161914)
        ..style = PaintingStyle.fill;

      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.rotate(placement.rotationDeg.toDouble() * math.pi / 180.0);

      final rect = Rect.fromCenter(
        center: Offset.zero,
        width: bodySize.width,
        height: bodySize.height,
      );
      _drawFootprintBody(canvas, rect, entry.template, fillPaint, strokePaint);

      final template = entry.template;
      if (template != null) {
        _drawTemplatePins(
          canvas: canvas,
          template: template,
          bodySize: bodySize,
          fillPaint: padFillPaint,
          strokePaint: padStrokePaint,
        );
        _drawOrientationMarker(
          canvas: canvas,
          template: template,
          bodySize: bodySize,
          markerPaint: markerPaint,
        );
      }

      canvas.restore();
      final measurementCount =
          measurementCountsByComponentId[placement.componentId] ?? 0;

      final designator = entry.component?.designator;
      if (designator != null && designator.trim().isNotEmpty) {
        final textPainter = TextPainter(
          textDirection: TextDirection.ltr,
          text: TextSpan(
            text: designator,
            style: TextStyle(
              color: colorScheme.onSurface,
              fontSize: 11,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        )..layout(maxWidth: 120);
        textPainter.paint(
          canvas,
          Offset(
            (center.dx + 6)
                .clamp(0.0, math.max(0.0, size.width - textPainter.width)),
            (center.dy + 6)
                .clamp(0.0, math.max(0.0, size.height - textPainter.height)),
          ),
        );
      }

      if (measurementCount > 0) {
        _paintMeasurementPresenceBadge(
          canvas: canvas,
          center: center,
          bodySize: bodySize,
          measurementCount: measurementCount,
          colorScheme: colorScheme,
          size: size,
        );
      }
    }
  }

  void _drawFootprintBody(
    Canvas canvas,
    Rect rect,
    FootprintTemplate? template,
    Paint fillPaint,
    Paint strokePaint,
  ) {
    final bodyShape = template?.body.shape ?? FootprintBodyShape.roundedRect;
    switch (bodyShape) {
      case FootprintBodyShape.oval:
        canvas.drawOval(rect, fillPaint);
        canvas.drawOval(rect, strokePaint);
        break;
      case FootprintBodyShape.rect:
      case FootprintBodyShape.customPath:
        canvas.drawRect(rect, fillPaint);
        canvas.drawRect(rect, strokePaint);
        break;
      case FootprintBodyShape.roundedRect:
        final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(4));
        canvas.drawRRect(rrect, fillPaint);
        canvas.drawRRect(rrect, strokePaint);
        break;
    }
  }

  void _drawTemplatePins({
    required Canvas canvas,
    required FootprintTemplate template,
    required Size bodySize,
    required Paint fillPaint,
    required Paint strokePaint,
  }) {
    for (final pin in template.pinAnchors) {
      final center = _templatePointToCanvas(pin.anchor, template, bodySize);
      final pinSize = _pinSize(pin, template, bodySize);
      final pinRect = Rect.fromCenter(
        center: center,
        width: pinSize.width,
        height: pinSize.height,
      );

      switch (pin.shape) {
        case FootprintPinShape.circle:
        case FootprintPinShape.oval:
          canvas.drawOval(pinRect, fillPaint);
          canvas.drawOval(pinRect, strokePaint);
          break;
        case FootprintPinShape.rect:
          final pad =
              RRect.fromRectAndRadius(pinRect, const Radius.circular(1.5));
          canvas.drawRRect(pad, fillPaint);
          canvas.drawRRect(pad, strokePaint);
          break;
      }
    }
  }

  void _drawOrientationMarker({
    required Canvas canvas,
    required FootprintTemplate template,
    required Size bodySize,
    required Paint markerPaint,
  }) {
    final marker = template.orientationMarker;
    final markerCenter =
        _templatePointToCanvas(marker.point, template, bodySize);
    final markerRadius = _templateLengthToCanvas(
      marker.size,
      template,
      bodySize,
    ).clamp(2.0, 5.0);
    canvas.drawCircle(markerCenter, markerRadius, markerPaint);
  }

  void _paintMeasurementPresenceBadge({
    required Canvas canvas,
    required Offset center,
    required Size bodySize,
    required int measurementCount,
    required ColorScheme colorScheme,
    required Size size,
  }) {
    if (measurementCount < 1) {
      return;
    }

    final badgeText = measurementCount == 1 ? 'M' : 'M$measurementCount';
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: badgeText,
        style: TextStyle(
          color: colorScheme.onPrimary,
          fontSize: 10,
          fontWeight: FontWeight.w700,
        ),
      ),
    )..layout();

    final minBadgeDimension = 18.0;
    final badgeHeight = 16.0;
    final badgeWidth =
        math.max(minBadgeDimension, textPainter.width + 6.0).clamp(16.0, 34.0);
    final badgeCenter = Offset(
      (center.dx + bodySize.width / 2 + badgeWidth / 2 + 2)
          .clamp(0.0, size.width),
      (center.dy - bodySize.height / 2 - badgeHeight / 2 - 4)
          .clamp(0.0, size.height),
    );
    final badgeRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: badgeCenter,
        width: badgeWidth,
        height: badgeHeight,
      ),
      Radius.circular(badgeHeight / 2),
    );

    final badgePaint = Paint()
      ..color = colorScheme.primary.withValues(alpha: 0.95)
      ..style = PaintingStyle.fill;
    final badgeBorderPaint = Paint()
      ..color = colorScheme.onPrimary.withValues(alpha: 0.85)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    canvas.drawRRect(badgeRect, badgePaint);
    canvas.drawRRect(badgeRect, badgeBorderPaint);

    textPainter.paint(
      canvas,
      Offset(
        (badgeCenter.dx - textPainter.width / 2).clamp(
          0.0,
          math.max(0.0, size.width - textPainter.width),
        ),
        (badgeCenter.dy - textPainter.height / 2).clamp(
          0.0,
          math.max(0.0, size.height - textPainter.height),
        ),
      ),
    );
  }

  Size _pinSize(
    FootprintPinAnchor pin,
    FootprintTemplate template,
    Size bodySize,
  ) {
    final scale = _templateScale(template, bodySize);
    if (pin.radius != null) {
      final diameter = (pin.radius! * 2 * scale).clamp(3.0, 13.0);
      return Size.square(diameter);
    }

    final width = ((pin.width ?? 0.08) * scale).clamp(3.0, 15.0);
    final height = ((pin.height ?? 0.08) * scale).clamp(3.0, 15.0);
    return Size(width, height);
  }

  Offset _templatePointToCanvas(
    FootprintPoint point,
    FootprintTemplate template,
    Size bodySize,
  ) {
    return Offset(
      point.x * bodySize.width / template.body.width,
      point.y * bodySize.height / template.body.height,
    );
  }

  double _templateLengthToCanvas(
    double value,
    FootprintTemplate template,
    Size bodySize,
  ) {
    return value * _templateScale(template, bodySize);
  }

  double _templateScale(FootprintTemplate template, Size bodySize) {
    final scaleX = bodySize.width / template.body.width;
    final scaleY = bodySize.height / template.body.height;
    return math.min(scaleX, scaleY);
  }

  @override
  bool shouldRepaint(covariant _BoardPlacementPainter oldDelegate) {
    if (oldDelegate.selectedKey != selectedKey) {
      return true;
    }
    if (oldDelegate.colorScheme != colorScheme) {
      return true;
    }
    if (!_measurementCountsEquivalent(
      oldDelegate.measurementCountsByComponentId,
      measurementCountsByComponentId,
    )) {
      return true;
    }
    return !_entriesEquivalent(oldDelegate.entries, entries);
  }

  static bool _measurementCountsEquivalent(
    Map<String, int> left,
    Map<String, int> right,
  ) {
    if (identical(left, right)) {
      return true;
    }
    if (left.length != right.length) {
      return false;
    }
    for (final entry in left.entries) {
      if (right[entry.key] != entry.value) {
        return false;
      }
    }
    return true;
  }

  static bool _entriesEquivalent(
    List<_PlacementEntry> left,
    List<_PlacementEntry> right,
  ) {
    if (identical(left, right)) {
      return true;
    }
    if (left.length != right.length) {
      return false;
    }
    for (var index = 0; index < left.length; index++) {
      if (!_entryEquivalent(left[index], right[index])) {
        return false;
      }
    }
    return true;
  }

  static bool _entryEquivalent(_PlacementEntry left, _PlacementEntry right) {
    final leftPlacement = left.placement;
    final rightPlacement = right.placement;
    if (leftPlacement.componentId != rightPlacement.componentId ||
        leftPlacement.coordinateSpace != rightPlacement.coordinateSpace ||
        leftPlacement.boardSide != rightPlacement.boardSide ||
        leftPlacement.centerX != rightPlacement.centerX ||
        leftPlacement.centerY != rightPlacement.centerY ||
        leftPlacement.rotationDeg != rightPlacement.rotationDeg ||
        leftPlacement.scale != rightPlacement.scale ||
        leftPlacement.width != rightPlacement.width ||
        leftPlacement.height != rightPlacement.height ||
        leftPlacement.templateId != rightPlacement.templateId ||
        leftPlacement.sourceEventId != rightPlacement.sourceEventId ||
        leftPlacement.status != rightPlacement.status) {
      return false;
    }

    final leftDesignator = left.component?.designator ?? '';
    final rightDesignator = right.component?.designator ?? '';
    if (leftDesignator != rightDesignator) {
      return false;
    }

    final leftTemplate = left.template;
    final rightTemplate = right.template;
    if ((leftTemplate == null) != (rightTemplate == null)) {
      return false;
    }
    if (leftTemplate == null || rightTemplate == null) {
      return true;
    }

    return leftTemplate.templateId == rightTemplate.templateId &&
        leftTemplate.templateVersion == rightTemplate.templateVersion &&
        leftTemplate.body.width == rightTemplate.body.width &&
        leftTemplate.body.height == rightTemplate.body.height;
  }
}
