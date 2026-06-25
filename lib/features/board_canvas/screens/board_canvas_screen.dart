import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
const int _kAddComponentContactMarkerWarningLimit = 8;
const Color _kMeasurePanelNavy = Color(0xFF173A5E);
const Color _kMeasurePanelSignal = Color(0xFFE8742B);
const Color _kMeasurePanelSignalTint = Color(0xFFFCEEE1);
const Color _kMeasurePanelCoolSurface = Color(0xFFF8FAFC);
const Color _kMeasurePanelBodyFill = Color(0xFFCDD9E6);
const Color _kMeasurePanelRule = Color(0xFFC7D2DC);
const Color _kBoardCanvasShell = Color(0xFFEAEFF4);
const Color _kBoardCanvasPaper = Color(0xFFFFFFFF);
const Color _kBoardCanvasNavy = Color(0xFF173A5E);
const Color _kBoardCanvasNavyDeep = Color(0xFF0F2A45);
const Color _kBoardCanvasSignal = Color(0xFFE8742B);
const Color _kBoardCanvasSignalTint = Color(0xFFFCEEE1);
const Color _kBoardCanvasRule = Color(0xFFDCE3EA);
const Color _kBoardCanvasRuleStrong = Color(0xFFC7D2DC);
const EdgeInsets _kCompactControlTilePadding =
    EdgeInsets.symmetric(horizontal: 8);
const EdgeInsets _kCompactControlChildrenPadding =
    EdgeInsets.fromLTRB(8, 0, 8, 6);

enum _WorkbenchContextPanelMode {
  hidden,
  inspector,
  placements,
  measure,
  addComponentTemplates,
  safetyEvidence
}

bool measurementEndpointMatchesComponent(
  String endpoint,
  String componentId,
) {
  return endpoint == componentId || endpoint.startsWith('$componentId.');
}

String _displayDirectionLabel(String from, String? to) {
  final trimmedFrom = from.trim();
  final trimmedTo = to?.trim();
  if (trimmedTo == null || trimmedTo.isEmpty) {
    return trimmedFrom;
  }
  return '$trimmedFrom -> $trimmedTo';
}

String? _firstPresentText(Iterable<String?> values) {
  for (final value in values) {
    final trimmed = value?.trim();
    if (trimmed != null && trimmed.isNotEmpty) {
      return trimmed;
    }
  }
  return null;
}

_EndpointDisplayParts _endpointDisplayParts(String endpoint) {
  final trimmed = endpoint.trim();
  final dotIndex = trimmed.indexOf('.');
  if (dotIndex <= 0 || dotIndex == trimmed.length - 1) {
    return _EndpointDisplayParts(component: trimmed, pin: null);
  }
  return _EndpointDisplayParts(
    component: trimmed.substring(0, dotIndex),
    pin: trimmed,
  );
}

class _EndpointDisplayParts {
  const _EndpointDisplayParts({required this.component, this.pin});

  final String component;
  final String? pin;
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

Map<String, List<MeasurementFact>> measurementValueBadgesByComponents({
  required List<MeasurementFact> measurements,
  required Set<String> componentIds,
}) {
  final badgesByComponent = <String, List<MeasurementFact>>{};
  for (final componentId in componentIds) {
    final matches = <_IndexedMeasurement>[];
    for (var index = 0; index < measurements.length; index++) {
      final measurement = measurements[index];
      if (!measurementHasScalarValueAndUnit(measurement)) {
        continue;
      }
      if (measurementEndpointMatchesComponent(measurement.from, componentId) ||
          measurementEndpointMatchesComponent(measurement.to, componentId)) {
        matches.add(_IndexedMeasurement(index, measurement));
      }
    }
    if (matches.isEmpty) {
      continue;
    }
    matches.sort(_compareIndexedMeasurements);
    badgesByComponent[componentId] =
        matches.map((match) => match.measurement).toList(growable: false);
  }
  return badgesByComponent;
}

bool measurementHasScalarValueAndUnit(MeasurementFact measurement) {
  final unit = measurement.unit?.trim();
  if (unit == null || unit.isEmpty) {
    return false;
  }

  final value = measurement.value;
  if (value is num) {
    return value.isFinite;
  }
  if (value is String) {
    return value.trim().isNotEmpty;
  }
  return false;
}

String measurementValueBadgeText(MeasurementFact measurement) {
  return '${measurement.value} ${measurement.unit}';
}

bool measurementValidityNeedsCaution(MeasurementFact measurement) {
  final status = measurement.validityStatus.toLowerCase();
  return status.contains('stale') ||
      status.contains('invalid') ||
      status.contains('suspect');
}

int _compareIndexedMeasurements(
  _IndexedMeasurement left,
  _IndexedMeasurement right,
) {
  final leftId = left.measurement.measurementId.trim();
  final rightId = right.measurement.measurementId.trim();
  if (leftId.isNotEmpty && rightId.isNotEmpty && leftId != rightId) {
    return leftId.compareTo(rightId);
  }
  return left.index.compareTo(right.index);
}

class _IndexedMeasurement {
  const _IndexedMeasurement(this.index, this.measurement);

  final int index;
  final MeasurementFact measurement;
}

enum _AddComponentTemplateBodyShape {
  rectangular,
  smallThreeSide,
  dualRow,
  quadRow,
  connectorStrip,
  radialRound,
  genericBlank,
}

class _AddComponentTemplateDefinition {
  const _AddComponentTemplateDefinition({
    required this.id,
    required this.templateFamily,
    required this.topContactMarkers,
    required this.rightContactMarkers,
    required this.bottomContactMarkers,
    required this.leftContactMarkers,
    required this.example,
  });

  final String id;
  final String templateFamily;
  final int topContactMarkers;
  final int rightContactMarkers;
  final int bottomContactMarkers;
  final int leftContactMarkers;
  final String example;

  _AddComponentTemplateBodyShape get bodyShape {
    switch (id) {
      case 'template_family_radial_round':
        return _AddComponentTemplateBodyShape.radialRound;
      case 'template_family_connector_strip':
        return _AddComponentTemplateBodyShape.connectorStrip;
      case 'template_family_small_3_side_package':
        return _AddComponentTemplateBodyShape.smallThreeSide;
      case 'template_family_rect_2_top_bottom':
        return _AddComponentTemplateBodyShape.rectangular;
      case 'template_family_generic_blank':
        return _AddComponentTemplateBodyShape.genericBlank;
      case 'template_family_rect_4_perimeter':
        return _AddComponentTemplateBodyShape.dualRow;
      case 'template_family_rect_6_edge_balance':
        return _AddComponentTemplateBodyShape.quadRow;
      default:
        return _AddComponentTemplateBodyShape.genericBlank;
    }
  }

  double get bodyAspectRatio {
    switch (bodyShape) {
      case _AddComponentTemplateBodyShape.radialRound:
        return 1.0;
      case _AddComponentTemplateBodyShape.connectorStrip:
        return 4.0;
      case _AddComponentTemplateBodyShape.smallThreeSide:
        return 1.35;
      case _AddComponentTemplateBodyShape.dualRow:
        return 1.65;
      case _AddComponentTemplateBodyShape.quadRow:
        return 1.2;
      case _AddComponentTemplateBodyShape.rectangular:
        return 2.4;
      case _AddComponentTemplateBodyShape.genericBlank:
        return 2.0;
    }
  }

  bool get isRoundTemplateBody =>
      bodyShape == _AddComponentTemplateBodyShape.radialRound;

  bool get isConnectorStripTemplateBody =>
      bodyShape == _AddComponentTemplateBodyShape.connectorStrip;

  String get shortTemplateShapeName {
    final familyPrefix = templateFamily.split('—').first.trim();
    return familyPrefix
        .replaceAll(RegExp(r'template family', caseSensitive: false), '')
        .trim();
  }

  int get contactMarkerCount =>
      topContactMarkers +
      rightContactMarkers +
      bottomContactMarkers +
      leftContactMarkers;

  String get contactMarkerSummaryShort {
    final count = contactMarkerCount;
    return '$count ${count == 1 ? 'contact' : 'contacts'}';
  }

  String get contactMarkerSummary {
    return 'Top: $topContactMarkers, Right: $rightContactMarkers, '
        'Bottom: $bottomContactMarkers, Left: $leftContactMarkers';
  }
}

const _kStarterAddComponentTemplates = <_AddComponentTemplateDefinition>[
  _AddComponentTemplateDefinition(
    id: 'template_family_rect_2_top_bottom',
    templateFamily: 'Rectangular chip',
    topContactMarkers: 1,
    rightContactMarkers: 0,
    bottomContactMarkers: 1,
    leftContactMarkers: 0,
    example: 'Rectangular chip style with paired vertical contact markers.',
  ),
  _AddComponentTemplateDefinition(
    id: 'template_family_rect_4_perimeter',
    templateFamily: 'Dual-row package',
    topContactMarkers: 0,
    rightContactMarkers: 4,
    bottomContactMarkers: 0,
    leftContactMarkers: 4,
    example: 'Dual-row package visual layout with four local contact markers.',
  ),
  _AddComponentTemplateDefinition(
    id: 'template_family_rect_6_edge_balance',
    templateFamily: 'Quad-row package',
    topContactMarkers: 2,
    rightContactMarkers: 2,
    bottomContactMarkers: 2,
    leftContactMarkers: 2,
    example: 'Quad-row package style with four-side contact markers.',
  ),
  _AddComponentTemplateDefinition(
    id: 'template_family_small_3_side_package',
    templateFamily: 'Small 3-side package',
    topContactMarkers: 1,
    rightContactMarkers: 1,
    bottomContactMarkers: 1,
    leftContactMarkers: 0,
    example: 'Small 3-side package starter with three visual-contact markers.',
  ),
  _AddComponentTemplateDefinition(
    id: 'template_family_connector_strip',
    templateFamily: 'Connector strip',
    topContactMarkers: 4,
    rightContactMarkers: 0,
    bottomContactMarkers: 0,
    leftContactMarkers: 0,
    example: 'Connector strip profile for one-row local markers.',
  ),
  _AddComponentTemplateDefinition(
    id: 'template_family_radial_round',
    templateFamily: 'Radial / round',
    topContactMarkers: 1,
    rightContactMarkers: 0,
    bottomContactMarkers: 1,
    leftContactMarkers: 0,
    example: 'Radial visual template with paired contacts.',
  ),
  _AddComponentTemplateDefinition(
    id: 'template_family_generic_blank',
    templateFamily: 'Generic blank',
    topContactMarkers: 0,
    rightContactMarkers: 0,
    bottomContactMarkers: 0,
    leftContactMarkers: 0,
    example: 'Generic blank template starts with zero local markers.',
  ),
];

class BoardCanvasScreen extends ConsumerStatefulWidget {
  const BoardCanvasScreen({super.key});

  @override
  ConsumerState<BoardCanvasScreen> createState() => _BoardCanvasScreenState();
}

class _BoardCanvasScreenState extends ConsumerState<BoardCanvasScreen> {
  String? _selectedPlacementKey;
  String? _selectedAddComponentTemplateId;
  int _addComponentTemplateTopContactMarkers = 0;
  int _addComponentTemplateRightContactMarkers = 0;
  int _addComponentTemplateBottomContactMarkers = 0;
  int _addComponentTemplateLeftContactMarkers = 0;
  String _addComponentTemplateDraftLabel = '';
  Offset? _addComponentTemplateGhostDraftAnchor;
  bool _inspectorVisible = true;
  bool _canvasFocusMode = false;
  final Set<String> _visibleMeasurementValueBadgeComponentIds = <String>{};
  _WorkbenchContextPanelMode _contextPanelMode =
      _WorkbenchContextPanelMode.hidden;

  _AddComponentTemplateDefinition? _selectedAddComponentTemplateDefinition() {
    for (final template in _kStarterAddComponentTemplates) {
      if (template.id == _selectedAddComponentTemplateId) {
        return template;
      }
    }
    return null;
  }

  bool get _addComponentTemplateHasExcessiveCounts {
    return _addComponentTemplateTopContactMarkers > _kAddComponentContactMarkerWarningLimit ||
        _addComponentTemplateRightContactMarkers >
            _kAddComponentContactMarkerWarningLimit ||
        _addComponentTemplateBottomContactMarkers >
            _kAddComponentContactMarkerWarningLimit ||
        _addComponentTemplateLeftContactMarkers >
            _kAddComponentContactMarkerWarningLimit;
  }

  bool get _addComponentTemplateHasZeroMarkers =>
      _addComponentTemplateTopContactMarkers +
          _addComponentTemplateRightContactMarkers +
          _addComponentTemplateBottomContactMarkers +
          _addComponentTemplateLeftContactMarkers ==
      0;

  void _seedAddComponentTemplateContactCounts(
    _AddComponentTemplateDefinition template,
  ) {
    _addComponentTemplateTopContactMarkers = template.topContactMarkers;
    _addComponentTemplateRightContactMarkers = template.rightContactMarkers;
    _addComponentTemplateBottomContactMarkers = template.bottomContactMarkers;
    _addComponentTemplateLeftContactMarkers = template.leftContactMarkers;
  }

  void _setAddComponentTemplateSelection(String templateId) {
    final template = _kStarterAddComponentTemplates
        .cast<_AddComponentTemplateDefinition?>()
        .firstWhere(
          (entry) => entry?.id == templateId,
          orElse: () => null,
        );
    if (template == null) {
      return;
    }
    setState(() {
      _selectedAddComponentTemplateId = templateId;
      _seedAddComponentTemplateContactCounts(template);
      _addComponentTemplateGhostDraftAnchor = null;
    });
  }

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
    final measurementValueBadgesByComponent =
        measurementValueBadgesByComponents(
      measurements: knownFacts.measurements,
      componentIds: entries.map((entry) => entry.placement.componentId).toSet(),
    );
    final eligibleMeasurementValueBadgeComponentIds =
        measurementValueBadgesByComponent.keys.toSet();
    final visibleMeasurementValueBadgeComponentIds =
        _visibleMeasurementValueBadgeComponentIds
            .where(eligibleMeasurementValueBadgeComponentIds.contains)
            .toSet();
    final selectedAddComponentTemplate =
        _selectedAddComponentTemplateDefinition();
    final allMeasurementValueBadgesVisible =
        eligibleMeasurementValueBadgeComponentIds.isNotEmpty &&
            visibleMeasurementValueBadgeComponentIds.length ==
                eligibleMeasurementValueBadgeComponentIds.length;
    final selectedMeasurementCount = selectedEntry == null
        ? 0
        : measurementCountByComponent[selectedEntry.placement.componentId] ?? 0;
    final selectedMeasurementValueBadgeCount = selectedEntry == null
        ? 0
        : measurementValueBadgesByComponent[selectedEntry.placement.componentId]
                ?.length ??
            0;
    final selectedMeasurementValueBadgesVisible = selectedEntry != null &&
        visibleMeasurementValueBadgeComponentIds.contains(
          selectedEntry.placement.componentId,
        );

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
                  if (_contextPanelMode != _WorkbenchContextPanelMode.measure) {
                    _contextPanelMode = _WorkbenchContextPanelMode.inspector;
                  }
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
              measurementValueBadgesByComponentId:
                  measurementValueBadgesByComponent,
              visibleMeasurementValueBadgeComponentIds:
                  visibleMeasurementValueBadgeComponentIds,
              hasEligibleMeasurementValueBadges:
                  eligibleMeasurementValueBadgeComponentIds.isNotEmpty,
              allMeasurementValueBadgesVisible:
                  allMeasurementValueBadgesVisible,
              onToggleAllMeasurementValueBadges: () {
                setState(() {
                  _visibleMeasurementValueBadgeComponentIds.clear();
                  if (!allMeasurementValueBadgesVisible) {
                    _visibleMeasurementValueBadgeComponentIds.addAll(
                      eligibleMeasurementValueBadgeComponentIds,
                    );
                  }
                });
              },
              cornerFocusAction:
                  useWorkbenchShell && !_canvasFocusMode ? focusToggle : null,
              onPlacementSelected: (value) {
                setState(() {
                  _selectedPlacementKey = value;
                  if (_contextPanelMode != _WorkbenchContextPanelMode.measure) {
                    _contextPanelMode = _WorkbenchContextPanelMode.inspector;
                  }
                  _inspectorVisible = true;
                });
              },
              onCanvasTapEmpty: () {
                setState(() {
                  _selectedPlacementKey = null;
                  if (_contextPanelMode != _WorkbenchContextPanelMode.measure) {
                    _contextPanelMode = _WorkbenchContextPanelMode.hidden;
                  }
                });
              },
              showAddComponentTemplateGhost: _contextPanelMode ==
                      _WorkbenchContextPanelMode.addComponentTemplates &&
                  _selectedAddComponentTemplateId != null,
              addComponentTemplateGhostTopContactMarkers:
                  _addComponentTemplateTopContactMarkers,
              addComponentTemplateGhostRightContactMarkers:
                  _addComponentTemplateRightContactMarkers,
              addComponentTemplateGhostBottomContactMarkers:
                  _addComponentTemplateBottomContactMarkers,
              addComponentTemplateGhostLeftContactMarkers:
                  _addComponentTemplateLeftContactMarkers,
              addComponentTemplateGhostDraftLabel:
                  _addComponentTemplateDraftLabel,
              addComponentTemplateGhostDraftAnchor:
                  _addComponentTemplateGhostDraftAnchor,
              selectedAddComponentTemplate: selectedAddComponentTemplate,
              onAddComponentTemplateGhostDraftAnchorChanged: (value) {
                setState(() {
                  _addComponentTemplateGhostDraftAnchor = value;
                });
              },
            );
            final metadata = _InspectorPanel(
              selectedEntry: selectedEntry,
              selectedMeasurementCount: selectedMeasurementCount,
              selectedMeasurementValueBadgeCount:
                  selectedMeasurementValueBadgeCount,
              selectedMeasurementValueBadgesVisible:
                  selectedMeasurementValueBadgesVisible,
              onToggleSelectedMeasurementValueBadges: selectedEntry == null ||
                      selectedMeasurementValueBadgeCount == 0
                  ? null
                  : () {
                      final componentId = selectedEntry!.placement.componentId;
                      setState(() {
                        if (_visibleMeasurementValueBadgeComponentIds
                            .contains(componentId)) {
                          _visibleMeasurementValueBadgeComponentIds
                              .remove(componentId);
                        } else {
                          _visibleMeasurementValueBadgeComponentIds
                              .add(componentId);
                        }
                      });
                    },
              relatedMeasurements: relatedMeasurements,
              relatedVisualTraces: relatedVisualTraces,
              photoToBoardAlignments: photoToBoardAlignments,
            );
            final controlBand = useWorkbenchShell
                ? const SizedBox.shrink(key: Key('board_canvas_control_band'))
                : _BoardCanvasControlBand(
                    selector: selector,
                    safetyEvidence:
                        const _BoardCanvasSafetyEvidenceDisclosure(),
                    trailingActions: <Widget>[
                      _MeasureSheetNavigationButton(
                        onPressed: () {
                          context.push('/project/measure-sheet');
                        },
                      ),
                      focusToggle,
                      _InspectorChromeToggle(
                        inspectorVisible: _inspectorVisible,
                        showLabel: false,
                        onPressed: () {
                          setState(() {
                            _inspectorVisible = !_inspectorVisible;
                          });
                        },
                      ),
                    ],
                  );
            final restoreBar = _CanvasFocusRestoreBar(
              onRestore: () {
                setState(() {
                  _canvasFocusMode = false;
                  _inspectorVisible = true;
                  if (selectedKey == null &&
                      _contextPanelMode ==
                          _WorkbenchContextPanelMode.inspector) {
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
                        _contextPanelMode =
                            _WorkbenchContextPanelMode.inspector;
                        _inspectorVisible = true;
                      });
                    },
                  );
                  break;
                case _WorkbenchContextPanelMode.measure:
                  contextPanel = _IntegratedMeasurePanel(
                    selectedEntry: selectedEntry,
                    relatedMeasurements: relatedMeasurements,
                    relatedVisualTraces: relatedVisualTraces,
                    onContinueToMeasureSheet: () {
                      context.push('/project/measure-sheet');
                    },
                  );
                  break;
                case _WorkbenchContextPanelMode.addComponentTemplates:
                  contextPanel = _AddComponentTemplateListPanel(
                    entries: _kStarterAddComponentTemplates,
                    selectedTemplateId: _selectedAddComponentTemplateId,
                    selectedTemplate: selectedAddComponentTemplate,
                    topContactMarkers: _addComponentTemplateTopContactMarkers,
                    rightContactMarkers:
                        _addComponentTemplateRightContactMarkers,
                    bottomContactMarkers:
                        _addComponentTemplateBottomContactMarkers,
                    leftContactMarkers: _addComponentTemplateLeftContactMarkers,
                    hasZeroContactMarkers: _addComponentTemplateHasZeroMarkers,
                    hasExcessiveContactMarkers:
                        _addComponentTemplateHasExcessiveCounts,
                    onTemplateSelected: _setAddComponentTemplateSelection,
                    draftLabel: _addComponentTemplateDraftLabel,
                    onDraftLabelChanged: (value) {
                      setState(() {
                        _addComponentTemplateDraftLabel = value;
                      });
                    },
                    onTopContactMarkersChanged: (value) {
                      setState(
                          () => _addComponentTemplateTopContactMarkers = value);
                    },
                    onRightContactMarkersChanged: (value) {
                      setState(() =>
                          _addComponentTemplateRightContactMarkers = value);
                    },
                    onBottomContactMarkersChanged: (value) {
                      setState(() =>
                          _addComponentTemplateBottomContactMarkers = value);
                    },
                    onLeftContactMarkersChanged: (value) {
                      setState(() =>
                          _addComponentTemplateLeftContactMarkers = value);
                    },
                    onChangeTemplateSelection: () {
                      setState(() {
                        _selectedAddComponentTemplateId = null;
                        _addComponentTemplateGhostDraftAnchor = null;
                      });
                    },
                    onResetToTemplateDefaults:
                        selectedAddComponentTemplate == null
                            ? null
                            : () {
                                setState(() {
                                  _seedAddComponentTemplateContactCounts(
                                      selectedAddComponentTemplate);
                                  _addComponentTemplateGhostDraftAnchor = null;
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
              final measurePanelToggle = _WorkbenchPanelModeButton(
                buttonKey: const Key('board_canvas_measure_sheet_button'),
                icon: Icons.science_outlined,
                tooltip: 'Open measurement context panel',
                label: 'Measure',
                modeKey: 'measure',
                selected:
                    _contextPanelMode == _WorkbenchContextPanelMode.measure,
                onPressed: () {
                  setState(() {
                    _selectedPlacementKey ??=
                        entries.isEmpty ? null : entries.first.key;
                    _contextPanelMode = _WorkbenchContextPanelMode.measure;
                    _inspectorVisible = true;
                    _canvasFocusMode = false;
                  });
                },
              );
              final focusPanelToggle = _WorkbenchPanelModeButton(
                buttonKey: const Key('board_canvas_rail_placements_tool'),
                icon: Icons.format_list_bulleted_rounded,
                tooltip: 'Show placements in right contextual panel',
                label: 'Placements',
                modeKey: 'placements',
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
              final addComponentPanelToggle = _WorkbenchPanelModeButton(
                buttonKey: const Key('board_canvas_rail_add_component_tool'),
                icon: Icons.add_box_outlined,
                tooltip: 'Open Add Component template-list mode',
                label: 'Add Component',
                modeKey: 'add_component',
                selected: _contextPanelMode ==
                    _WorkbenchContextPanelMode.addComponentTemplates,
                onPressed: () {
                  setState(() {
                    _selectedPlacementKey = null;
                    _contextPanelMode =
                        _WorkbenchContextPanelMode.addComponentTemplates;
                    _inspectorVisible = true;
                  });
                },
              );
              final safetyPanelToggle = _WorkbenchPanelModeButton(
                buttonKey: const Key('board_canvas_rail_safety_evidence_tool'),
                icon: Icons.shield_outlined,
                tooltip: 'Show safety/evidence read-only details',
                label: 'Safety',
                modeKey: 'safety',
                selected: _contextPanelMode ==
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
              final inspectorPanelToggle = _WorkbenchPanelModeButton(
                buttonKey: const Key('board_canvas_rail_inspector_tool'),
                icon: Icons.info_outline,
                tooltip: 'Show inspector context panel',
                label: 'Inspector',
                modeKey: 'inspector',
                selected:
                    _contextPanelMode == _WorkbenchContextPanelMode.inspector,
                onPressed: () {
                  setState(() {
                    _contextPanelMode = _WorkbenchContextPanelMode.inspector;
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
                      addComponentTool: addComponentPanelToggle,
                      inspectorTool: inspectorPanelToggle,
                      measureSheetTool: measurePanelToggle,
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
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: _kBoardCanvasShell,
      appBar: AppBar(
        toolbarHeight: _kCompactBoardCanvasAppBarHeight,
        backgroundColor: _kBoardCanvasPaper,
        foregroundColor: _kBoardCanvasNavy,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 36,
        titleSpacing: 0,
        title: Text(
          'Board Canvas',
          style: theme.textTheme.titleMedium?.copyWith(
            color: _kBoardCanvasNavyDeep,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Center(
              child: Container(
                key: const Key('board_canvas_read_only_status_pill'),
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                decoration: BoxDecoration(
                  color: _kBoardCanvasSignalTint,
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    color: _kBoardCanvasSignal.withValues(alpha: 0.62),
                  ),
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 164),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: _kBoardCanvasSignal,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          'Read-only · no writes',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: _kBoardCanvasSignal,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: _kBoardCanvasRule),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: content),
            Container(
              key: const Key('board_canvas_status_bar'),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 7),
              decoration: const BoxDecoration(
                color: _kBoardCanvasPaper,
                border: Border(
                  top: BorderSide(color: _kBoardCanvasRule),
                ),
              ),
              child: DefaultTextStyle(
                style: (theme.textTheme.labelSmall ??
                        const TextStyle(fontSize: 11))
                    .copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Color(0xFF2F8F6B),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 7),
                    const Text('Ready'),
                    const SizedBox(width: 12),
                    const Expanded(
                      flex: 2,
                      child: Center(
                        child: Text(
                          'renderer writes: none',
                          key: Key('renderer_writes_none'),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      flex: 2,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'BenchBeep · TraceBench platform',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
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
    required this.addComponentTool,
    required this.inspectorTool,
    required this.measureSheetTool,
    required this.placementTool,
    required this.safetyEvidenceTool,
  });

  final Widget addComponentTool;
  final Widget inspectorTool;
  final Widget measureSheetTool;
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
          color: _kBoardCanvasPaper,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _kBoardCanvasRule),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1F0F2A45),
              blurRadius: 18,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Padding(
          padding: _kWorkbenchRailPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _WorkbenchSectionHeader(label: 'Panels'),
              const SizedBox(height: _kWorkbenchToolTileGap),
              measureSheetTool,
              const SizedBox(height: _kWorkbenchToolTileGap),
              addComponentTool,
              const SizedBox(height: _kWorkbenchToolTileGap),
              inspectorTool,
              const SizedBox(height: _kWorkbenchToolTileGap),
              placementTool,
              const SizedBox(height: _kWorkbenchToolTileGap),
              safetyEvidenceTool,
              const SizedBox(height: 6),
              Divider(
                height: 1,
                thickness: 1,
                color: _kBoardCanvasRule,
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

class _MeasureSheetNavigationButton extends StatelessWidget {
  const _MeasureSheetNavigationButton({
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
          key: const Key('board_canvas_measure_sheet_button'),
          tooltip: 'Open Measure Sheet',
          iconSize: _kWorkbenchRailContentIconSize,
          style: IconButton.styleFrom(
            minimumSize: const Size.square(_kCompactControlTileHeight),
            padding: EdgeInsets.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          icon: const Icon(Icons.science_outlined),
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
          'Measure',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: theme.textTheme.labelSmall,
        ),
      ],
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
    required this.modeKey,
    required this.onPressed,
  });

  final Key buttonKey;
  final IconData icon;
  final String tooltip;
  final String label;
  final bool selected;
  final String modeKey;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tileColor = selected ? _kBoardCanvasPaper : const Color(0xFFF7F9FC);
    final borderColor =
        selected ? _kBoardCanvasSignal : _kBoardCanvasRuleStrong;
    final labelStyle = theme.textTheme.labelSmall?.copyWith(
      fontWeight: selected ? FontWeight.w700 : FontWeight.normal,
      color: selected ? _kBoardCanvasNavy : theme.colorScheme.onSurfaceVariant,
    );
    final tooltipText = selected ? '$tooltip • active' : tooltip;

    final content = SizedBox(
      width: _kCompactControlTileHeight,
      height: _kCompactControlTileHeight,
      child: IconButton(
        key: buttonKey,
        tooltip: tooltipText,
        iconSize: _kWorkbenchRailContentIconSize,
        style: IconButton.styleFrom(
          minimumSize: const Size.square(_kCompactControlTileHeight),
          padding: EdgeInsets.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          foregroundColor: selected ? _kBoardCanvasSignal : _kBoardCanvasNavy,
        ),
        icon: Icon(icon),
        onPressed: onPressed,
      ),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Semantics(
          button: true,
          selected: selected,
          label: '$label panel mode',
          hint: tooltipText,
          child: Card(
            margin: EdgeInsets.zero,
            color: tileColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: borderColor),
            ),
            child: Stack(
              children: [
                content,
                if (selected)
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 2, right: 2),
                      child: Icon(
                        Icons.keyboard_arrow_right_rounded,
                        size: 10,
                        color: _kBoardCanvasSignal,
                        key: Key('board_canvas_rail_${modeKey}_active'),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: labelStyle,
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
        style: theme.textTheme.labelSmall?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.8,
        ),
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
    final button = Container(
      width: _kCompactControlTileHeight,
      height: _kCompactControlTileHeight,
      decoration: BoxDecoration(
        color: const Color(0xFFF2F5F8),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _kBoardCanvasRule),
      ),
      child: IconButton(
        key: buttonKey,
        tooltip: tooltip,
        iconSize: _kCompactControlIconSize,
        style: IconButton.styleFrom(
          minimumSize: const Size.square(_kCompactControlTileHeight),
          padding: EdgeInsets.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          foregroundColor: theme.colorScheme.onSurfaceVariant,
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

class _AddComponentTemplateListPanel extends StatelessWidget {
  const _AddComponentTemplateListPanel({
    required this.entries,
    required this.selectedTemplateId,
    required this.onTemplateSelected,
    required this.selectedTemplate,
    required this.topContactMarkers,
    required this.rightContactMarkers,
    required this.bottomContactMarkers,
    required this.leftContactMarkers,
    required this.hasZeroContactMarkers,
    required this.hasExcessiveContactMarkers,
    required this.onTopContactMarkersChanged,
    required this.onRightContactMarkersChanged,
    required this.onBottomContactMarkersChanged,
    required this.onLeftContactMarkersChanged,
    required this.onChangeTemplateSelection,
    required this.draftLabel,
    required this.onDraftLabelChanged,
    this.onResetToTemplateDefaults,
    this.initiallyExpanded = true,
  });

  final List<_AddComponentTemplateDefinition> entries;
  final String? selectedTemplateId;
  final ValueChanged<String> onTemplateSelected;
  final _AddComponentTemplateDefinition? selectedTemplate;
  final int topContactMarkers;
  final int rightContactMarkers;
  final int bottomContactMarkers;
  final int leftContactMarkers;
  final bool hasZeroContactMarkers;
  final bool hasExcessiveContactMarkers;
  final ValueChanged<int> onTopContactMarkersChanged;
  final ValueChanged<int> onRightContactMarkersChanged;
  final ValueChanged<int> onBottomContactMarkersChanged;
  final ValueChanged<int> onLeftContactMarkersChanged;
  final VoidCallback onChangeTemplateSelection;
  final String draftLabel;
  final ValueChanged<String> onDraftLabelChanged;
  final VoidCallback? onResetToTemplateDefaults;
  final bool initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final maxPanelHeight = MediaQuery.of(context).size.height > 200
        ? MediaQuery.of(context).size.height - 210.0
        : 200.0;
    final templateRows = entries
        .map(
          (entry) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _AddComponentTemplateListTile(
              entry: entry,
              selected: selectedTemplateId == entry.id,
              onTap: () => onTemplateSelected(entry.id),
            ),
          ),
        )
        .toList(growable: false);
    return Card(
      margin: EdgeInsets.zero,
      color: _kBoardCanvasPaper,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: _kBoardCanvasRule),
      ),
      child: ExpansionTile(
        key: const Key('board_canvas_add_component_template_list'),
        initiallyExpanded: initiallyExpanded,
        maintainState: true,
        dense: true,
        visualDensity: VisualDensity.compact,
        minTileHeight: _kCompactControlTileHeight,
        tilePadding: _kCompactControlTilePadding,
        childrenPadding: _kCompactControlChildrenPadding,
        title: _CompactDisclosureTitle(
          label: 'Add Component',
          detail: selectedTemplate == null
              ? 'Starter visual templates'
              : 'Active template',
        ),
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: maxPanelHeight),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (selectedTemplate == null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(2, 0, 2, 6),
                          child: Text(
                            'Pick a footprint',
                            key: const Key(
                              'board_canvas_add_component_template_picker_label',
                            ),
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: _kBoardCanvasSignal,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.zero,
                          key: const Key(
                            'board_canvas_add_component_template_list_rows',
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: templateRows,
                          ),
                        ),
                      ],
                    )
                  else ...[
                    _AddComponentTemplateSelectedSummary(
                      template: selectedTemplate!,
                      onChangeTemplate: onChangeTemplateSelection,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      key: const Key(
                        'board_canvas_add_component_template_draft_label_input',
                      ),
                      initialValue: draftLabel,
                      decoration: const InputDecoration(
                        isDense: true,
                        labelText: 'Draft label',
                        hintText: 'e.g. AGH789',
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 6,
                        ),
                      ),
                      maxLength: 16,
                      onChanged: onDraftLabelChanged,
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 12),
                    ),
                    _AddComponentTemplateBuilderPanel(
                      key: const Key(
                        'board_canvas_add_component_template_builder',
                      ),
                      template: selectedTemplate!,
                      topContactMarkers: topContactMarkers,
                      rightContactMarkers: rightContactMarkers,
                      bottomContactMarkers: bottomContactMarkers,
                      leftContactMarkers: leftContactMarkers,
                      hasZeroContactMarkers: hasZeroContactMarkers,
                      hasExcessiveContactMarkers: hasExcessiveContactMarkers,
                      onTopChanged: onTopContactMarkersChanged,
                      onRightChanged: onRightContactMarkersChanged,
                      onBottomChanged: onBottomContactMarkersChanged,
                      onLeftChanged: onLeftContactMarkersChanged,
                      onResetToDefaults: onResetToTemplateDefaults,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildTemplateMiniShape(
  BuildContext context,
  _AddComponentTemplateDefinition template, {
  double width = 22,
  double height = 14,
}) {
  final isRadialRound = template.isRoundTemplateBody;
  final isConnector = template.isConnectorStripTemplateBody;
  final isGenericBlank =
      template.bodyShape == _AddComponentTemplateBodyShape.genericBlank;
  final isSmallThreeSide =
      template.bodyShape == _AddComponentTemplateBodyShape.smallThreeSide;
  final isQuadRow =
      template.bodyShape == _AddComponentTemplateBodyShape.quadRow;

  final double shapeWidth = isRadialRound
      ? height
      : isConnector
          ? 26
          : isSmallThreeSide
              ? 16
              : isQuadRow
                  ? 26
                  : width;

  final double shapeHeight = isRadialRound
      ? width
      : isConnector
          ? 8
          : isSmallThreeSide
              ? 16
              : isQuadRow
                  ? 16
                  : height;

  return Container(
    width: shapeWidth,
    height: shapeHeight,
    decoration: BoxDecoration(
      borderRadius: isRadialRound ? null : BorderRadius.circular(4),
      shape: isRadialRound ? BoxShape.circle : BoxShape.rectangle,
      border: Border.all(
        color: isGenericBlank ? _kBoardCanvasRuleStrong : _kBoardCanvasNavy,
      ),
    ),
    child: isRadialRound
        ? null
        : Center(
            child: Container(
              width: (shapeWidth / 1.45).clamp(6.0, 20.0),
              height: (shapeHeight / 1.45).clamp(4.0, 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(isGenericBlank ? 1 : 2),
                border: Border.all(
                  color: _kBoardCanvasSignal,
                  width: isConnector ? 0.8 : 1,
                ),
              ),
            ),
          ),
  );
}

class _AddComponentTemplateSelectedSummary extends StatelessWidget {
  const _AddComponentTemplateSelectedSummary({
    required this.template,
    required this.onChangeTemplate,
  });

  final _AddComponentTemplateDefinition template;
  final VoidCallback onChangeTemplate;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final title = template.shortTemplateShapeName;
    return Container(
      key: const Key('board_canvas_add_component_template_summary'),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: theme.colorScheme.surfaceContainerHighest,
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            key: const Key(
              'board_canvas_add_component_template_summary_shape',
            ),
            child: _buildTemplateMiniShape(
              context,
              template,
              width: 28,
              height: 20,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  template.contactMarkerSummaryShort,
                  style: theme.textTheme.labelSmall,
                ),
              ],
            ),
          ),
          const SizedBox(width: 6),
          TextButton(
            key: const Key('board_canvas_add_component_change_template'),
            onPressed: onChangeTemplate,
            style: TextButton.styleFrom(
              visualDensity: VisualDensity.compact,
              padding: const EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 0,
              ),
              minimumSize: const Size(0, 24),
              textStyle: theme.textTheme.labelSmall,
            ),
            child: const Text('Change template'),
          ),
          const SizedBox(width: 2),
          Icon(
            Icons.check_circle_rounded,
            size: 16,
            color: theme.colorScheme.primary,
            key: Key(
              'board_canvas_add_component_template_${template.id}_selected',
            ),
            semanticLabel: 'selected',
          ),
        ],
      ),
    );
  }
}

class _AddComponentTemplateBuilderPanel extends StatelessWidget {
  const _AddComponentTemplateBuilderPanel({
    super.key,
    required this.template,
    required this.topContactMarkers,
    required this.rightContactMarkers,
    required this.bottomContactMarkers,
    required this.leftContactMarkers,
    required this.hasZeroContactMarkers,
    required this.hasExcessiveContactMarkers,
    required this.onTopChanged,
    required this.onRightChanged,
    required this.onBottomChanged,
    required this.onLeftChanged,
    this.onResetToDefaults,
  });

  final _AddComponentTemplateDefinition template;
  final int topContactMarkers;
  final int rightContactMarkers;
  final int bottomContactMarkers;
  final int leftContactMarkers;
  final bool hasZeroContactMarkers;
  final bool hasExcessiveContactMarkers;
  final ValueChanged<int> onTopChanged;
  final ValueChanged<int> onRightChanged;
  final ValueChanged<int> onBottomChanged;
  final ValueChanged<int> onLeftChanged;
  final VoidCallback? onResetToDefaults;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      key: const Key('board_canvas_add_component_builder_card'),
      margin: EdgeInsets.zero,
      color: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: theme.colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Visual-contact builder',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  'Contact markers',
                  style: theme.textTheme.labelSmall,
                ),
              ],
            ),
            const SizedBox(height: 6),
            SizedBox(
              key: const Key('board_canvas_add_component_builder_visual_body'),
              height: 170,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 36,
                    child: Center(
                      child: _ContactMarkerCountRow(
                        controlKey: const Key(
                          'board_canvas_add_component_builder_top_control',
                        ),
                        side: 'Top',
                        sideKey: 'top',
                        value: topContactMarkers,
                        onChanged: (value) {
                          if (value < 0) {
                            return;
                          }
                          onTopChanged(value);
                        },
                        axis: Axis.horizontal,
                        showLabel: false,
                        compact: true,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 58,
                          child: Center(
                            child: _ContactMarkerCountRow(
                              controlKey: const Key(
                                'board_canvas_add_component_builder_left_control',
                              ),
                              side: 'Left',
                              sideKey: 'left',
                              value: leftContactMarkers,
                              onChanged: (value) {
                                if (value < 0) {
                                  return;
                                }
                                onLeftChanged(value);
                              },
                              axis: Axis.vertical,
                              showLabel: false,
                              compact: true,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(
                                maxWidth: 140,
                                maxHeight: 82,
                              ),
                              child: KeyedSubtree(
                                key: Key(
                                  'board_canvas_add_component_builder_preview_${template.id}',
                                ),
                                child: RepaintBoundary(
                                  child: AspectRatio(
                                    aspectRatio: template.bodyAspectRatio,
                                    child: CustomPaint(
                                      key: const Key(
                                        'board_canvas_add_component_builder_preview',
                                      ),
                                      painter:
                                          _RectangularPerimeterTemplatePreviewPainter(
                                        template: template,
                                        topContactMarkers: topContactMarkers,
                                        rightContactMarkers:
                                            rightContactMarkers,
                                        bottomContactMarkers:
                                            bottomContactMarkers,
                                        leftContactMarkers: leftContactMarkers,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 58,
                          child: Center(
                            child: _ContactMarkerCountRow(
                              controlKey: const Key(
                                'board_canvas_add_component_builder_right_control',
                              ),
                              side: 'Right',
                              sideKey: 'right',
                              value: rightContactMarkers,
                              onChanged: (value) {
                                if (value < 0) {
                                  return;
                                }
                                onRightChanged(value);
                              },
                              axis: Axis.vertical,
                              showLabel: false,
                              compact: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 36,
                    child: Center(
                      child: _ContactMarkerCountRow(
                        controlKey: const Key(
                          'board_canvas_add_component_builder_bottom_control',
                        ),
                        side: 'Bottom',
                        sideKey: 'bottom',
                        value: bottomContactMarkers,
                        onChanged: (value) =>
                            onBottomChanged(value < 0 ? 0 : value),
                        axis: Axis.horizontal,
                        showLabel: false,
                        compact: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (onResetToDefaults != null)
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  height: 24,
                  child: TextButton(
                    key: const Key(
                      'board_canvas_add_component_builder_reset_to_defaults',
                    ),
                    onPressed: onResetToDefaults,
                    style: TextButton.styleFrom(
                      visualDensity: VisualDensity.compact,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 0,
                      ),
                      minimumSize: const Size(0, 24),
                      textStyle: theme.textTheme.labelSmall,
                    ),
                    child: const Text('Reset to template defaults'),
                  ),
                ),
              ),
            if (hasZeroContactMarkers)
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(
                  'No visual contact markers configured.',
                  key: const Key(
                    'board_canvas_add_component_builder_zero_markers_hint',
                  ),
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.error,
                  ),
                ),
              ),
            if (hasExcessiveContactMarkers)
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(
                  'Excessive contact marker counts may be invalid.',
                  key: const Key(
                    'board_canvas_add_component_builder_excessive_markers_hint',
                  ),
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.tertiary,
                  ),
                  maxLines: 2,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _ContactMarkerCountRow extends StatelessWidget {
  const _ContactMarkerCountRow({
    this.controlKey,
    required this.side,
    required this.sideKey,
    required this.value,
    required this.onChanged,
    this.axis = Axis.horizontal,
    this.showLabel = true,
    this.compact = false,
  });

  final Key? controlKey;
  final String side;
  final String sideKey;
  final int value;
  final ValueChanged<int> onChanged;
  final Axis axis;
  final bool showLabel;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final label = Text(
      side,
      style: theme.textTheme.labelSmall?.copyWith(
        fontSize: 10,
      ),
    );

    final controls = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          iconSize: 16,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints.tightFor(width: 16, height: 16),
          style: IconButton.styleFrom(
            visualDensity: VisualDensity.compact,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            minimumSize: const Size(16, 16),
          ),
          onPressed: value <= 0 ? null : () => onChanged(value - 1),
          icon: const Icon(Icons.remove_circle_outline),
          tooltip: 'Decrease $side contact markers',
          key: Key(
            'board_canvas_add_component_template_builder_${sideKey}_decrement',
          ),
        ),
        Container(
          width: 20,
          alignment: Alignment.center,
          child: Text(
            value.toString(),
            key: Key(
              'board_canvas_add_component_template_builder_${sideKey}_value',
            ),
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        IconButton(
          iconSize: 16,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints.tightFor(width: 16, height: 16),
          style: IconButton.styleFrom(
            visualDensity: VisualDensity.compact,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            minimumSize: const Size(16, 16),
          ),
          onPressed: () => onChanged(value + 1),
          icon: const Icon(Icons.add_circle_outline),
          tooltip: 'Increase $side contact markers',
          key: Key(
            'board_canvas_add_component_template_builder_${sideKey}_increment',
          ),
        ),
      ],
    );

    if (!showLabel) {
      return Container(
        key: controlKey,
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: controls,
      );
    }

    if (axis == Axis.horizontal) {
      return Row(
        key: controlKey,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!compact)
            SizedBox(
              width: 34,
              child: label,
            ),
          if (!compact) const SizedBox(width: 2),
          controls,
        ],
      );
    }

    return Column(
      key: controlKey,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!compact) label,
        if (!compact) const SizedBox(height: 2),
        controls,
      ],
    );
  }
}

class _RectangularPerimeterTemplatePreviewPainter extends CustomPainter {
  const _RectangularPerimeterTemplatePreviewPainter({
    required this.template,
    required this.topContactMarkers,
    required this.rightContactMarkers,
    required this.bottomContactMarkers,
    required this.leftContactMarkers,
    this.boundaryColor = const Color(0xFF5C6BC0),
    this.markerColor = const Color(0xFF2E7D32),
    this.fillColor = Colors.transparent,
    this.strokeWidth = 1.8,
    this.dashedBoundary = false,
  });

  final _AddComponentTemplateDefinition template;
  final int topContactMarkers;
  final int rightContactMarkers;
  final int bottomContactMarkers;
  final int leftContactMarkers;
  final Color boundaryColor;
  final Color markerColor;
  final Color fillColor;
  final double strokeWidth;
  final bool dashedBoundary;

  @override
  void paint(Canvas canvas, Size size) {
    final rectInsets = const EdgeInsets.all(12.0);
    final paintArea = Offset.zero & size;
    final previewRect = Rect.fromLTWH(
      rectInsets.left,
      rectInsets.top,
      paintArea.width - rectInsets.horizontal,
      paintArea.height - rectInsets.vertical,
    );
    final bodyPath = _buildBodyPath(previewRect);

    final boundaryPaint = Paint()
      ..color = boundaryColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final markerPaint = Paint()
      ..color = markerColor
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    if (fillColor != Colors.transparent) {
      final fillPaint = Paint()
        ..color = fillColor
        ..style = PaintingStyle.fill;
      canvas.drawPath(bodyPath, fillPaint);
    }
    if (dashedBoundary) {
      _drawDashedPath(canvas, bodyPath, boundaryPaint);
    } else {
      canvas.drawPath(bodyPath, boundaryPaint);
    }

    _drawContactMarkersAlongTop(
      canvas,
      previewRect,
      topContactMarkers,
      markerPaint,
    );
    _drawContactMarkersAlongRight(
      canvas,
      previewRect,
      rightContactMarkers,
      markerPaint,
    );
    _drawContactMarkersAlongBottom(
      canvas,
      previewRect,
      bottomContactMarkers,
      markerPaint,
    );
    _drawContactMarkersAlongLeft(
      canvas,
      previewRect,
      leftContactMarkers,
      markerPaint,
    );
  }

  Path _buildBodyPath(Rect rect) {
    if (template.bodyShape == _AddComponentTemplateBodyShape.radialRound) {
      return Path()
        ..addOval(Rect.fromCircle(
            center: rect.center,
            radius: math.min(rect.width, rect.height) / 2));
    }

    final radius =
        template.bodyShape == _AddComponentTemplateBodyShape.genericBlank
            ? const Radius.circular(2)
            : const Radius.circular(4);
    return Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          rect,
          radius,
        ),
      );
  }

  void _drawDashedPath(
    Canvas canvas,
    Path path,
    Paint paint,
  ) {
    const dashLength = 6.0;
    const gap = 3.0;
    for (final metric in path.computeMetrics()) {
      var distance = metric.length;
      var offset = 0.0;
      while (distance > 0) {
        final segmentEnd = math.min(offset + dashLength, metric.length);
        final segment = metric.extractPath(offset, segmentEnd);
        canvas.drawPath(segment, paint);
        offset = segmentEnd + gap;
        distance = metric.length - offset;
      }
    }
  }

  void _drawContactMarkersAlongTop(
    Canvas canvas,
    Rect rect,
    int count,
    Paint paint,
  ) {
    if (count <= 0) {
      return;
    }
    if (count == 1) {
      final center = Offset(rect.center.dx, rect.top);
      canvas.drawCircle(center, 3.0, paint);
      return;
    }
    for (var i = 0; i < count; i++) {
      final x = rect.left + rect.width * ((i + 1) / (count + 1));
      final point = Offset(x, rect.top);
      canvas.drawCircle(point, 3.0, paint);
    }
  }

  void _drawContactMarkersAlongBottom(
    Canvas canvas,
    Rect rect,
    int count,
    Paint paint,
  ) {
    if (count <= 0) {
      return;
    }
    if (count == 1) {
      final center = Offset(rect.center.dx, rect.bottom);
      canvas.drawCircle(center, 3.0, paint);
      return;
    }
    for (var i = 0; i < count; i++) {
      final x = rect.left + rect.width * ((i + 1) / (count + 1));
      final point = Offset(x, rect.bottom);
      canvas.drawCircle(point, 3.0, paint);
    }
  }

  void _drawContactMarkersAlongLeft(
    Canvas canvas,
    Rect rect,
    int count,
    Paint paint,
  ) {
    if (count <= 0) {
      return;
    }
    if (count == 1) {
      final center = Offset(rect.left, rect.center.dy);
      canvas.drawCircle(center, 3.0, paint);
      return;
    }
    for (var i = 0; i < count; i++) {
      final y = rect.top + rect.height * ((i + 1) / (count + 1));
      final point = Offset(rect.left, y);
      canvas.drawCircle(point, 3.0, paint);
    }
  }

  void _drawContactMarkersAlongRight(
    Canvas canvas,
    Rect canvasRect,
    int count,
    Paint paint,
  ) {
    if (count <= 0) {
      return;
    }
    if (count == 1) {
      final center = Offset(canvasRect.right, canvasRect.center.dy);
      canvas.drawCircle(center, 3.0, paint);
      return;
    }
    for (var i = 0; i < count; i++) {
      final y = canvasRect.top + canvasRect.height * ((i + 1) / (count + 1));
      final point = Offset(canvasRect.right, y);
      canvas.drawCircle(point, 3.0, paint);
    }
  }

  @override
  bool shouldRepaint(
    covariant _RectangularPerimeterTemplatePreviewPainter oldDelegate,
  ) {
    return oldDelegate.template != template ||
        oldDelegate.topContactMarkers != topContactMarkers ||
        oldDelegate.rightContactMarkers != rightContactMarkers ||
        oldDelegate.bottomContactMarkers != bottomContactMarkers ||
        oldDelegate.leftContactMarkers != leftContactMarkers;
  }
}

class _AddComponentTemplateListTile extends StatelessWidget {
  const _AddComponentTemplateListTile({
    required this.entry,
    required this.selected,
    required this.onTap,
  });

  final _AddComponentTemplateDefinition entry;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final baseColor = selected
        ? _kBoardCanvasSignalTint.withValues(alpha: 0.68)
        : _kBoardCanvasPaper;
    final borderColor = selected ? _kBoardCanvasSignal : _kBoardCanvasRule;
    final shortShapeName = entry.shortTemplateShapeName;
    final contactCountText = entry.contactMarkerSummaryShort;

    return InkWell(
      key: Key('board_canvas_add_component_template_${entry.id}'),
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 6),
        decoration: BoxDecoration(
          color: baseColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              selected
                  ? Icons.check_circle_rounded
                  : Icons.radio_button_unchecked_rounded,
              color: selected
                  ? _kBoardCanvasSignal
                  : theme.colorScheme.onSurfaceVariant,
              size: 16,
            ),
            const SizedBox(width: 6),
            Container(
              key: Key(
                'board_canvas_add_component_template_shape_${entry.id}',
              ),
              child: _buildTemplateMiniShape(
                context,
                entry,
                width: 20,
                height: 14,
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          shortShapeName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontWeight:
                                selected ? FontWeight.w700 : FontWeight.w500,
                          ),
                        ),
                      ),
                      if (selected)
                        Icon(
                          Icons.label_important,
                          size: 16,
                          key: Key(
                            'board_canvas_add_component_template_${entry.id}_selected',
                          ),
                          color: theme.colorScheme.onPrimaryContainer,
                          semanticLabel: 'selected',
                        ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    contactCountText,
                    style: theme.textTheme.labelSmall,
                  ),
                ],
              ),
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
      key: const Key('board_canvas_projection_overlay'),
      decoration: BoxDecoration(
        color: _kBoardCanvasNavyDeep.withValues(alpha: 0.78),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _kBoardCanvasPaper.withValues(alpha: 0.10)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Board projection canvas',
              style: theme.textTheme.labelLarge?.copyWith(
                color: const Color(0xFFEAF1F7),
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'Existing board-normalized placements only',
              style: theme.textTheme.bodySmall?.copyWith(
                color: const Color(0xFF9FB6CC),
              ),
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
    required this.measurementValueBadgesByComponentId,
    required this.visibleMeasurementValueBadgeComponentIds,
    required this.hasEligibleMeasurementValueBadges,
    required this.allMeasurementValueBadgesVisible,
    required this.onToggleAllMeasurementValueBadges,
    this.cornerFocusAction,
    required this.onPlacementSelected,
    required this.onCanvasTapEmpty,
    this.showAddComponentTemplateGhost = false,
    required this.addComponentTemplateGhostTopContactMarkers,
    required this.addComponentTemplateGhostRightContactMarkers,
    required this.addComponentTemplateGhostBottomContactMarkers,
    required this.addComponentTemplateGhostLeftContactMarkers,
    required this.addComponentTemplateGhostDraftLabel,
    required this.addComponentTemplateGhostDraftAnchor,
    required this.selectedAddComponentTemplate,
    required this.onAddComponentTemplateGhostDraftAnchorChanged,
  });

  final List<_PlacementEntry> entries;
  final String? selectedKey;
  final Map<String, int> measurementCountsByComponentId;
  final Map<String, List<MeasurementFact>> measurementValueBadgesByComponentId;
  final Set<String> visibleMeasurementValueBadgeComponentIds;
  final bool hasEligibleMeasurementValueBadges;
  final bool allMeasurementValueBadgesVisible;
  final VoidCallback onToggleAllMeasurementValueBadges;
  final Widget? cornerFocusAction;
  final ValueChanged<String> onPlacementSelected;
  final VoidCallback onCanvasTapEmpty;
  final bool showAddComponentTemplateGhost;
  final int addComponentTemplateGhostTopContactMarkers;
  final int addComponentTemplateGhostRightContactMarkers;
  final int addComponentTemplateGhostBottomContactMarkers;
  final int addComponentTemplateGhostLeftContactMarkers;
  final String addComponentTemplateGhostDraftLabel;
  final Offset? addComponentTemplateGhostDraftAnchor;
  final _AddComponentTemplateDefinition? selectedAddComponentTemplate;
  final ValueChanged<Offset> onAddComponentTemplateGhostDraftAnchorChanged;

  @override
  State<_CanvasPanel> createState() => _CanvasPanelState();
}

class _CanvasPanelState extends State<_CanvasPanel> {
  static const double _kMinZoom = 0.5;
  static const double _kMaxZoom = 4.0;

  final TransformationController _transformationController =
      TransformationController();
  int? _addComponentTemplateGhostDragPointer;
  Offset? _addComponentTemplateGhostDragStartGlobalPosition;
  Offset? _addComponentTemplateGhostDragStartCanvasPosition;
  Offset? _addComponentTemplateGhostDragGrabOffset;
  double _addComponentTemplateGhostDragScale = 1.0;
  Size _addComponentTemplateGhostDragCanvasSize = Size.zero;

  @override
  void dispose() {
    _clearAddComponentTemplateGhostDragRoute();
    _transformationController.dispose();
    super.dispose();
  }

  void _fitCanvasView() {
    _transformationController.value = Matrix4.identity();
  }

  void _selectPlacementAt(Offset position, Size size) {
    if (widget.showAddComponentTemplateGhost &&
        widget.selectedAddComponentTemplate != null) {
      widget.onAddComponentTemplateGhostDraftAnchorChanged(position);
      return;
    }
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
    final canvasSize = Size(
      math.max(240, size.width),
      math.max(96, size.height),
    );
    return InteractiveViewer(
      key: const Key('board_canvas_interactive_viewer'),
      transformationController: _transformationController,
      minScale: _kMinZoom,
      maxScale: _kMaxZoom,
      panEnabled: !widget.showAddComponentTemplateGhost,
      scaleEnabled: !widget.showAddComponentTemplateGhost,
      constrained: false,
      child: GestureDetector(
        key: const Key('board_canvas_tap_layer'),
        behavior: HitTestBehavior.opaque,
        onTapUp: (details) =>
            _selectPlacementAt(details.localPosition, canvasSize),
        child: SizedBox(
          width: canvasSize.width,
          height: canvasSize.height,
          child: Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(
                  key: const Key('board_canvas_painter'),
                  painter: _BoardPlacementPainter(
                    entries: widget.entries,
                    selectedKey: widget.selectedKey,
                    measurementCountsByComponentId:
                        widget.measurementCountsByComponentId,
                    colorScheme: theme.colorScheme,
                  ),
                ),
              ),
              if (widget.showAddComponentTemplateGhost &&
                  widget.selectedAddComponentTemplate != null) ...[
                Positioned.fill(
                  child: _buildLocalAddComponentTemplateGhostLayer(
                    context,
                    canvasSize,
                  ),
                ),
              ],
              Positioned.fill(
                child: IgnorePointer(
                  child: _MeasurementValueBadgeLayer(
                    entries: widget.entries,
                    measurementValueBadgesByComponentId:
                        widget.measurementValueBadgesByComponentId,
                    visibleMeasurementValueBadgeComponentIds:
                        widget.visibleMeasurementValueBadgeComponentIds,
                    size: canvasSize,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLocalAddComponentTemplateGhostLayer(
    BuildContext context,
    Size canvasSize,
  ) {
    final ghost = Builder(
      builder: (ghostContext) {
        return Listener(
          key: const Key(
            'board_canvas_add_component_template_ghost_drag_handle',
          ),
          behavior: HitTestBehavior.opaque,
          onPointerDown: (details) => _startAddComponentTemplateGhostDrag(
            details,
            canvasSize,
            ghostContext,
          ),
          child: _buildLocalAddComponentTemplateGhost(context),
        );
      },
    );
    final draftAnchor = widget.addComponentTemplateGhostDraftAnchor;
    if (draftAnchor == null) {
      return Stack(
        children: [
          Center(child: ghost),
        ],
      );
    }
    final clampedAnchor =
        _clampAddComponentTemplateGhostDraftAnchor(draftAnchor, canvasSize);
    return Stack(
      children: [
        Positioned(
          key: const Key(
            'board_canvas_add_component_template_ghost_draft_position',
          ),
          left: clampedAnchor.dx,
          top: clampedAnchor.dy,
          child: FractionalTranslation(
            translation: const Offset(-0.5, -0.5),
            child: ghost,
          ),
        ),
      ],
    );
  }

  void _startAddComponentTemplateGhostDrag(
    PointerDownEvent details,
    Size canvasSize,
    BuildContext ghostContext,
  ) {
    final renderObject = ghostContext.findRenderObject();
    if (renderObject is! RenderBox) {
      return;
    }
    _clearAddComponentTemplateGhostDragRoute();
    final scale = _transformationController.value.getMaxScaleOnAxis();
    final currentAnchor = widget.addComponentTemplateGhostDraftAnchor ??
        Offset(canvasSize.width / 2, canvasSize.height / 2);
    final clampedAnchor =
        _clampAddComponentTemplateGhostDraftAnchor(currentAnchor, canvasSize);
    final ghostCenter = renderObject.size.center(Offset.zero);
    final pointerCanvasPosition =
        clampedAnchor + (details.localPosition - ghostCenter);

    _addComponentTemplateGhostDragPointer = details.pointer;
    _addComponentTemplateGhostDragStartGlobalPosition = details.position;
    _addComponentTemplateGhostDragStartCanvasPosition = pointerCanvasPosition;
    _addComponentTemplateGhostDragGrabOffset =
        pointerCanvasPosition - clampedAnchor;
    _addComponentTemplateGhostDragScale = scale <= 0 ? 1.0 : scale;
    _addComponentTemplateGhostDragCanvasSize = canvasSize;
    GestureBinding.instance.pointerRouter.addRoute(
      details.pointer,
      _handleAddComponentTemplateGhostDragPointer,
    );
  }

  void _handleAddComponentTemplateGhostDragPointer(PointerEvent event) {
    if (event.pointer != _addComponentTemplateGhostDragPointer) {
      return;
    }
    if (event is PointerMoveEvent) {
      final startGlobal = _addComponentTemplateGhostDragStartGlobalPosition;
      final startCanvas = _addComponentTemplateGhostDragStartCanvasPosition;
      final grabOffset = _addComponentTemplateGhostDragGrabOffset;
      if (startGlobal == null || startCanvas == null || grabOffset == null) {
        return;
      }
      final pointerCanvasPosition = startCanvas +
          (event.position - startGlobal) / _addComponentTemplateGhostDragScale;
      final nextAnchor = pointerCanvasPosition - grabOffset;
      widget.onAddComponentTemplateGhostDraftAnchorChanged(
        _clampAddComponentTemplateGhostDraftAnchor(
          nextAnchor,
          _addComponentTemplateGhostDragCanvasSize,
        ),
      );
      return;
    }
    if (event is PointerUpEvent || event is PointerCancelEvent) {
      _clearAddComponentTemplateGhostDragRoute();
    }
  }

  void _clearAddComponentTemplateGhostDragRoute() {
    final pointer = _addComponentTemplateGhostDragPointer;
    if (pointer != null) {
      GestureBinding.instance.pointerRouter.removeRoute(
        pointer,
        _handleAddComponentTemplateGhostDragPointer,
      );
    }
    _addComponentTemplateGhostDragPointer = null;
    _addComponentTemplateGhostDragStartGlobalPosition = null;
    _addComponentTemplateGhostDragStartCanvasPosition = null;
    _addComponentTemplateGhostDragGrabOffset = null;
    _addComponentTemplateGhostDragScale = 1.0;
    _addComponentTemplateGhostDragCanvasSize = Size.zero;
  }

  Offset _clampAddComponentTemplateGhostDraftAnchor(
    Offset value,
    Size canvasSize,
  ) {
    return Offset(
      _clampDraftAnchorCoordinate(value.dx, canvasSize.width),
      _clampDraftAnchorCoordinate(value.dy, canvasSize.height),
    );
  }

  double _clampDraftAnchorCoordinate(double value, double extent) {
    const minMargin = 28.0;
    final maxMargin = math.max(minMargin, extent - minMargin);
    return value.clamp(minMargin, maxMargin).toDouble();
  }

  Widget _buildLocalAddComponentTemplateGhost(BuildContext context) {
    final theme = Theme.of(context);
    final String draftLabel = widget.addComponentTemplateGhostDraftLabel.trim();
    const addComponentDraftGhostBoundaryColor = Color(0xFF7B3FF2);
    const addComponentDraftGhostMarkerColor = Color(0xFF5E35B1);
    const addComponentDraftGhostFillColor = Color(0x227B3FF2);
    final ghostPreview = widget.selectedAddComponentTemplate == null
        ? null
        : ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 200, maxHeight: 115),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                AspectRatio(
                  aspectRatio:
                      widget.selectedAddComponentTemplate!.bodyAspectRatio,
                  child: KeyedSubtree(
                    key: Key(
                      'board_canvas_add_component_template_ghost_preview_body_${widget.selectedAddComponentTemplate!.id}',
                    ),
                    child: CustomPaint(
                      key: const Key(
                        'board_canvas_add_component_template_ghost_preview_body',
                      ),
                      painter: _RectangularPerimeterTemplatePreviewPainter(
                        template: widget.selectedAddComponentTemplate!,
                        topContactMarkers:
                            widget.addComponentTemplateGhostTopContactMarkers,
                        rightContactMarkers:
                            widget.addComponentTemplateGhostRightContactMarkers,
                        bottomContactMarkers: widget
                            .addComponentTemplateGhostBottomContactMarkers,
                        leftContactMarkers:
                            widget.addComponentTemplateGhostLeftContactMarkers,
                        boundaryColor: addComponentDraftGhostBoundaryColor,
                        markerColor: addComponentDraftGhostMarkerColor,
                        fillColor: addComponentDraftGhostFillColor,
                        dashedBoundary: true,
                        strokeWidth: 2.1,
                      ),
                    ),
                  ),
                ),
                if (draftLabel.isNotEmpty)
                  Positioned.fill(
                    child: Center(
                      child: Text(
                        draftLabel,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: theme.colorScheme.onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  top: -20,
                  right: 0,
                  child: Container(
                    key: const Key(
                      'board_canvas_add_component_template_ghost_preview_status',
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerHigh,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: theme.colorScheme.outlineVariant,
                      ),
                    ),
                    child: Text(
                      'Draft / unsaved',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
    if (ghostPreview == null) {
      return const SizedBox.shrink();
    }
    return Semantics(
      label: 'Local draft add component template ghost preview',
      child: Container(
        key: const Key('board_canvas_add_component_template_ghost_preview'),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color:
              theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.34),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: theme.colorScheme.outlineVariant,
          ),
        ),
        child: ghostPreview,
      ),
    );
  }

  Widget _buildCornerControls(BuildContext context) {
    final measurementValueBadgeToggle = TextButton.icon(
      key: const Key('board_canvas_measurement_value_badge_global_toggle'),
      style: TextButton.styleFrom(
        backgroundColor: widget.allMeasurementValueBadgesVisible
            ? _kBoardCanvasSignal
            : _kBoardCanvasPaper.withValues(alpha: 0.92),
        foregroundColor: widget.allMeasurementValueBadgesVisible
            ? _kBoardCanvasPaper
            : _kBoardCanvasNavy,
        minimumSize: const Size(92, _kCompactControlTileHeight),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.compact,
      ),
      icon: Icon(
        widget.allMeasurementValueBadgesVisible
            ? Icons.visibility_off_outlined
            : Icons.visibility_outlined,
        size: _kCompactControlIconSize,
      ),
      label: Text(
        widget.allMeasurementValueBadgesVisible ? 'Hide All' : 'Show All',
      ),
      onPressed: widget.onToggleAllMeasurementValueBadges,
    );
    final fitButton = IconButton(
      key: const Key('board_canvas_fit_view_button'),
      tooltip: 'Fit board view',
      icon: const Icon(Icons.center_focus_strong),
      color: _kBoardCanvasNavy,
      style: IconButton.styleFrom(
        backgroundColor: _kBoardCanvasPaper.withValues(alpha: 0.92),
        minimumSize: const Size.square(_kCompactControlTileHeight),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
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
          if (widget.hasEligibleMeasurementValueBadges) ...[
            Tooltip(
              message: widget.allMeasurementValueBadgesVisible
                  ? 'Hide all measurement value badges'
                  : 'Show all measurement value badges',
              child: measurementValueBadgeToggle,
            ),
            const SizedBox(width: 6),
          ],
          fitButton,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _kBoardCanvasNavyDeep,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: _kBoardCanvasNavyDeep),
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
              'Value badges are optional and show projected value plus unit only.',
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
    required this.selectedMeasurementValueBadgeCount,
    required this.selectedMeasurementValueBadgesVisible,
    required this.onToggleSelectedMeasurementValueBadges,
    required this.relatedMeasurements,
    required this.relatedVisualTraces,
    required this.photoToBoardAlignments,
  });

  final _PlacementEntry? selectedEntry;
  final int selectedMeasurementCount;
  final int selectedMeasurementValueBadgeCount;
  final bool selectedMeasurementValueBadgesVisible;
  final VoidCallback? onToggleSelectedMeasurementValueBadges;
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
          selectedMeasurementValueBadgeCount:
              selectedMeasurementValueBadgeCount,
          selectedMeasurementValueBadgesVisible:
              selectedMeasurementValueBadgesVisible,
          onToggleSelectedMeasurementValueBadges:
              onToggleSelectedMeasurementValueBadges,
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

class _IntegratedMeasurePanel extends StatefulWidget {
  const _IntegratedMeasurePanel({
    required this.selectedEntry,
    required this.relatedMeasurements,
    required this.relatedVisualTraces,
    required this.onContinueToMeasureSheet,
  });

  final _PlacementEntry? selectedEntry;
  final List<MeasurementFact> relatedMeasurements;
  final List<VisualTraceFact> relatedVisualTraces;
  final VoidCallback onContinueToMeasureSheet;

  @override
  State<_IntegratedMeasurePanel> createState() =>
      _IntegratedMeasurePanelState();
}

class _IntegratedMeasurePanelState extends State<_IntegratedMeasurePanel> {
  static const List<String> _draftUnitOptions = ['V', 'Ω', 'Diode', 'Beep'];

  String? _selectedTarget;
  final Map<String, String> _draftValuesByTarget = {};
  final Map<String, String> _draftUnitsByTarget = {};

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectedName = widget.selectedEntry == null
        ? null
        : _preferredComponentLabel(widget.selectedEntry!);
    final selectedHeader = widget.selectedEntry == null
        ? 'Select a component on Canvas.'
        : widget.selectedEntry!.selectorLabel;
    final targetRows = _measureTargetRows();
    final contextRows = _measureContextRows();
    final selectedTargetRow = _effectiveSelectedTargetRow(targetRows);
    final selectedTarget = selectedTargetRow?.target;
    final measuredTargetCount =
        targetRows.where((row) => row.isExistingValue).length;

    return SingleChildScrollView(
      key: const Key('board_canvas_integrated_measure_panel'),
      child: DecoratedBox(
        key: const Key('board_canvas_measure_panel_surface'),
        decoration: BoxDecoration(
          color: _kMeasurePanelCoolSurface,
          border: Border.all(color: _kMeasurePanelRule),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              key: const Key('board_canvas_measure_panel_header'),
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 7),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Measure',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          selectedHeader,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 6),
                  const _MeasurePanelPill(label: 'local · no write'),
                ],
              ),
            ),
            const _MeasurePanelDivider(),
            Padding(
              key: const Key('board_canvas_measure_visual_section'),
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 9),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Component visual',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 5),
                  _MeasureComponentPreview(
                    selectedName: selectedName,
                    selectedTarget: selectedTarget,
                    targetRows: targetRows,
                    onTargetSelected: (target) {
                      setState(() {
                        _selectedTarget = target;
                      });
                    },
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Visual only; no connectivity proof.',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            const _MeasurePanelDivider(),
            Padding(
              key: const Key('board_canvas_measure_values_section'),
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 9),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          'Measured values',
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      _MeasurePanelPill(
                        key: const Key('board_canvas_measure_values_count'),
                        label:
                            '$measuredTargetCount / ${targetRows.length} measured',
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'inline values · local drafts',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 7),
                  ...targetRows.map(
                    (row) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: _MeasureTargetRow(
                        row: row,
                        selected: row.target == selectedTarget,
                        draftValue: _draftValuesByTarget[row.target] ?? '',
                        draftUnit: _draftUnitsByTarget[row.target] ??
                            _defaultDraftUnit(row),
                        unitOptions: _draftUnitOptions,
                        onSelected: () {
                          setState(() {
                            _selectedTarget = row.target;
                          });
                        },
                        onDraftValueChanged: (value) {
                          setState(() {
                            _selectedTarget = row.target;
                            _draftValuesByTarget[row.target] = value;
                          });
                        },
                        onDraftUnitChanged: (value) {
                          setState(() {
                            _selectedTarget = row.target;
                            _draftUnitsByTarget[row.target] = value;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton.icon(
                      key: const Key(
                        'board_canvas_measure_continue_sheet_button',
                      ),
                      onPressed: widget.onContinueToMeasureSheet,
                      style: TextButton.styleFrom(
                        foregroundColor: theme.colorScheme.onSurfaceVariant,
                        visualDensity: VisualDensity.compact,
                        minimumSize: const Size(0, 30),
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        textStyle: theme.textTheme.labelMedium,
                      ),
                      icon: const Icon(Icons.open_in_new_rounded, size: 16),
                      label: const Text('Continue in Measure Sheet'),
                    ),
                  ),
                ],
              ),
            ),
            const _MeasurePanelDivider(),
            Padding(
              key: const Key('board_canvas_measure_context_section'),
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 9),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'From -> To context',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Display only; no confirmed connectivity.',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 6),
                  if (contextRows.isEmpty)
                    Text(
                      'No From -> To context for selected component.',
                      style: theme.textTheme.bodySmall,
                    )
                  else
                    ...contextRows.map(
                      (row) => Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: _MeasureContextRow(row: row),
                      ),
                    ),
                ],
              ),
            ),
            const _MeasurePanelDivider(),
            Material(
              color: Colors.transparent,
              child: ExpansionTile(
                key: const Key('board_canvas_measure_advanced_section'),
                dense: true,
                visualDensity: VisualDensity.compact,
                minTileHeight: 40,
                tilePadding: const EdgeInsets.symmetric(horizontal: 10),
                childrenPadding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                title: Text(
                  'Advanced technical details',
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                subtitle: Text(
                  'read-only provenance',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                children: [
                  if (widget.relatedVisualTraces.isEmpty &&
                      widget.relatedMeasurements.isEmpty) ...[
                    const Align(
                      alignment: Alignment.centerLeft,
                      child:
                          Text('No advanced details for selected component.'),
                    ),
                  ] else ...[
                    if (widget.relatedVisualTraces.isNotEmpty) ...[
                      const _SectionHeader(
                        title: 'Visual trace provenance',
                        tag: 'READ',
                      ),
                      const SizedBox(height: 8),
                      ...widget.relatedVisualTraces.map(
                        (trace) => _VisualTraceSummaryTile(trace: trace),
                      ),
                    ],
                    if (widget.relatedMeasurements.isNotEmpty) ...[
                      if (widget.relatedVisualTraces.isNotEmpty)
                        const SizedBox(height: 8),
                      const _SectionHeader(
                        title: 'Existing measurement provenance',
                        tag: 'READ',
                      ),
                      const SizedBox(height: 8),
                      ...widget.relatedMeasurements.map(
                        (measurement) => _MeasurementSummaryTile(
                          measurement: measurement,
                        ),
                      ),
                    ],
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _MeasureTargetRowData? _effectiveSelectedTargetRow(
    List<_MeasureTargetRowData> targetRows,
  ) {
    if (targetRows.isEmpty) {
      return null;
    }
    for (final row in targetRows) {
      if (row.target == _selectedTarget) {
        return row;
      }
    }
    return targetRows.first;
  }

  List<_MeasureTargetRowData> _measureTargetRows() {
    final componentId = widget.selectedEntry?.placement.componentId;
    final componentLabel = widget.selectedEntry == null
        ? null
        : _preferredComponentLabel(widget.selectedEntry!);
    final rowsByTarget = <String, _MeasureTargetRowData>{};

    for (final measurement in widget.relatedMeasurements) {
      final target = _measurementTargetLabel(measurement, componentId);
      final displayValue = _measurementDisplayValue(measurement);
      final displayUnit = _measurementDisplayUnit(measurement);
      rowsByTarget[target] = _MeasureTargetRowData(
        target: target,
        displayLabel: _technicianTargetLabel(
          target,
          componentId: componentId,
          componentLabel: componentLabel,
        ),
        value: displayValue,
        unit: displayUnit,
        isExistingValue: true,
        showExistingUnit: _shouldShowMeasurementUnit(displayUnit),
        suggestedUnit: measurement.unit,
      );
    }

    if (componentId != null) {
      for (final trace in widget.relatedVisualTraces) {
        for (final target in _visualTraceTargets(trace, componentId)) {
          rowsByTarget.putIfAbsent(
            target,
            () => _MeasureTargetRowData(
              target: target,
              displayLabel: _technicianTargetLabel(
                target,
                componentId: componentId,
                componentLabel: componentLabel,
              ),
              value: '',
              isExistingValue: false,
            ),
          );
        }
      }
    }

    if (rowsByTarget.isEmpty) {
      rowsByTarget[widget.selectedEntry?.placement.componentId ?? 'No target'] =
          _MeasureTargetRowData(
        target:
            widget.selectedEntry?.placement.componentId ?? 'Select component',
        displayLabel: _technicianTargetLabel(
          widget.selectedEntry?.placement.componentId ?? 'Select component',
          componentId: componentId,
          componentLabel: componentLabel,
        ),
        value: '',
        isExistingValue: false,
      );
    }

    return rowsByTarget.values.toList(growable: false);
  }

  List<_MeasureContextRowData> _measureContextRows() {
    final rows = <_MeasureContextRowData>[];

    for (final measurement in widget.relatedMeasurements) {
      rows.add(
        _MeasureContextRowData(
          label: _measurementDirectionLabel(measurement),
          detail: 'measurement context · ${measurement.measurementId}',
        ),
      );
    }

    for (final trace in widget.relatedVisualTraces) {
      final label = _visualTraceDirectionLabel(trace, trace.traceId);
      rows.add(
        _MeasureContextRowData(
          label: label,
          detail: 'visual-only context · ${trace.traceId}',
        ),
      );
    }

    return rows;
  }

  String _measurementTargetLabel(
    MeasurementFact measurement,
    String? componentId,
  ) {
    if (componentId != null) {
      if (measurementEndpointMatchesComponent(measurement.from, componentId)) {
        return measurement.from;
      }
      if (measurementEndpointMatchesComponent(measurement.to, componentId)) {
        return measurement.to;
      }
    }
    return measurement.measurementId;
  }

  String _measurementDirectionLabel(MeasurementFact measurement) {
    return _displayDirectionLabel(measurement.from, measurement.to);
  }

  String _measurementDisplayValue(MeasurementFact measurement) {
    final rawValue = measurement.value == null
        ? measurement.reading
        : '${measurement.value}';
    final unit = measurement.unit?.trim().toLowerCase();
    final normalized = rawValue.trim().toLowerCase();
    if (unit == 'beep') {
      if (normalized == 'true' ||
          normalized == 'yes' ||
          normalized == '1' ||
          normalized == 'beep') {
        return 'Beep';
      }
      if (normalized == 'false' ||
          normalized == 'no' ||
          normalized == '0' ||
          normalized == 'silent') {
        return 'No beep';
      }
    }
    return rawValue;
  }

  String? _measurementDisplayUnit(MeasurementFact measurement) {
    final unit = measurement.unit?.trim();
    if (unit == null || unit.isEmpty) {
      return null;
    }
    return unit;
  }

  bool _shouldShowMeasurementUnit(String? unit) {
    final normalized = unit?.trim().toLowerCase();
    return normalized != null && normalized.isNotEmpty && normalized != 'beep';
  }

  String _technicianTargetLabel(
    String target, {
    String? componentId,
    String? componentLabel,
  }) {
    final trimmed = target.trim();
    final separatorIndex = trimmed.lastIndexOf('.');
    if (separatorIndex <= 0 || separatorIndex == trimmed.length - 1) {
      if (componentId != null &&
          componentLabel != null &&
          trimmed == componentId) {
        return componentLabel;
      }
      return trimmed;
    }
    final pinLabel = trimmed.substring(separatorIndex + 1);
    final targetComponentId = trimmed.substring(0, separatorIndex);
    final displayTarget = componentId != null &&
            componentLabel != null &&
            targetComponentId == componentId
        ? '$componentLabel.$pinLabel'
        : trimmed;
    return 'Pin $pinLabel · $displayTarget';
  }

  String _visualTraceDirectionLabel(
    VisualTraceFact trace,
    String fallbackTarget,
  ) {
    final from = _firstPresentText([trace.fromPin, trace.fromComponent]);
    final to = _firstPresentText([trace.toPin, trace.toComponent]);
    if (from != null) {
      return _displayDirectionLabel(from, to);
    }
    return to ?? fallbackTarget;
  }

  List<String> _visualTraceTargets(
    VisualTraceFact trace,
    String componentId,
  ) {
    final targets = <String>[];
    if (_tracePinMatchesComponent(trace.fromPin, componentId)) {
      targets.add(trace.fromPin!);
    }
    if (_tracePinMatchesComponent(trace.toPin, componentId)) {
      targets.add(trace.toPin!);
    }
    if (targets.isEmpty && trace.fromComponent == componentId) {
      targets.add(trace.fromComponent!);
    }
    if (targets.isEmpty && trace.toComponent == componentId) {
      targets.add(trace.toComponent!);
    }
    return targets;
  }

  bool _tracePinMatchesComponent(String? pinId, String componentId) {
    return pinId != null && pinId.startsWith('$componentId.');
  }

  String _defaultDraftUnit(_MeasureTargetRowData row) {
    return row.suggestedUnit ?? row.unit ?? _draftUnitOptions.first;
  }

  String _preferredComponentLabel(_PlacementEntry entry) {
    final designator = entry.component?.designator?.trim();
    if (designator != null && designator.isNotEmpty) {
      return designator;
    }
    return entry.placement.componentId;
  }
}

class _MeasureTargetRowData {
  const _MeasureTargetRowData({
    required this.target,
    required this.displayLabel,
    required this.value,
    required this.isExistingValue,
    this.unit,
    this.showExistingUnit = true,
    this.suggestedUnit,
  });

  final String target;
  final String displayLabel;
  final String value;
  final bool isExistingValue;
  final String? unit;
  final bool showExistingUnit;
  final String? suggestedUnit;
}

class _MeasureContextRowData {
  const _MeasureContextRowData({
    required this.label,
    required this.detail,
  });

  final String label;
  final String detail;
}

class _MeasurePanelDivider extends StatelessWidget {
  const _MeasurePanelDivider();

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      color: _kMeasurePanelRule,
    );
  }
}

class _MeasurePanelPill extends StatelessWidget {
  const _MeasurePanelPill({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: _kMeasurePanelSignalTint,
        border: Border.all(color: _kMeasurePanelSignal.withValues(alpha: 0.5)),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: _kMeasurePanelNavy,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _MeasureComponentPreview extends StatelessWidget {
  const _MeasureComponentPreview({
    required this.selectedName,
    required this.selectedTarget,
    required this.targetRows,
    required this.onTargetSelected,
  });

  final String? selectedName;
  final String? selectedTarget;
  final List<_MeasureTargetRowData> targetRows;
  final ValueChanged<String> onTargetSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final leftPads = <_MeasureTargetRowData>[];
    final rightPads = <_MeasureTargetRowData>[];
    for (var index = 0; index < targetRows.length; index++) {
      if (index.isEven) {
        leftPads.add(targetRows[index]);
      } else {
        rightPads.add(targetRows[index]);
      }
    }

    return DecoratedBox(
      key: const Key('board_canvas_measure_component_preview'),
      decoration: BoxDecoration(
        border: Border.all(color: _kMeasurePanelRule),
        borderRadius: BorderRadius.circular(8),
        color: theme.colorScheme.surface,
      ),
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.memory_outlined, size: 16),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    selectedName == null
                        ? 'No component selected.'
                        : '$selectedName footprint preview',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: _kMeasurePanelNavy,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            DecoratedBox(
              key: const Key('board_canvas_measure_component_visual_stage'),
              decoration: BoxDecoration(
                color: _kMeasurePanelNavy.withValues(alpha: 0.08),
                border: Border.all(color: _kMeasurePanelRule),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 8,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _MeasureVisualPadColumn(
                      rows: leftPads,
                      selectedTarget: selectedTarget,
                      onTargetSelected: onTargetSelected,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: _kMeasurePanelBodyFill,
                          border: Border.all(
                            color: _kMeasurePanelNavy,
                            width: 1.4,
                          ),
                          borderRadius: BorderRadius.circular(9),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 13,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                selectedName == null
                                    ? 'component'
                                    : '$selectedName body',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.labelLarge?.copyWith(
                                  color: _kMeasurePanelNavy,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                selectedTarget == null
                                    ? 'select pad'
                                    : 'selected ${_targetVisualLabel(selectedTarget!)}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: _kMeasurePanelNavy,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    _MeasureVisualPadColumn(
                      rows: rightPads,
                      selectedTarget: selectedTarget,
                      onTargetSelected: onTargetSelected,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static String _targetVisualLabel(String target) {
    final dotIndex = target.lastIndexOf('.');
    if (dotIndex <= 0 || dotIndex == target.length - 1) {
      return target;
    }
    return target.substring(dotIndex + 1);
  }
}

class _MeasureVisualPadColumn extends StatelessWidget {
  const _MeasureVisualPadColumn({
    required this.rows,
    required this.selectedTarget,
    required this.onTargetSelected,
  });

  final List<_MeasureTargetRowData> rows;
  final String? selectedTarget;
  final ValueChanged<String> onTargetSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final row in rows)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: _MeasureVisualPad(
              row: row,
              selected: row.target == selectedTarget,
              onSelected: () => onTargetSelected(row.target),
            ),
          ),
      ],
    );
  }
}

class _MeasureVisualPad extends StatelessWidget {
  const _MeasureVisualPad({
    required this.row,
    required this.selected,
    required this.onSelected,
  });

  final _MeasureTargetRowData row;
  final bool selected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final pad = DecoratedBox(
      key: Key('board_canvas_measure_visual_pad_${row.target}'),
      decoration: BoxDecoration(
        color: selected
            ? _kMeasurePanelSignalTint
            : row.isExistingValue
                ? _kMeasurePanelSignal.withValues(alpha: 0.22)
                : theme.colorScheme.surface,
        border: Border.all(
          color: selected ? _kMeasurePanelSignal : _kMeasurePanelRule,
          width: selected ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(6),
        boxShadow: selected
            ? [
                BoxShadow(
                  color: _kMeasurePanelSignal.withValues(alpha: 0.18),
                  blurRadius: 8,
                ),
              ]
            : null,
      ),
      child: SizedBox(
        width: 34,
        height: 24,
        child: Center(
          child: Text(
            _MeasureComponentPreview._targetVisualLabel(row.target),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.labelSmall?.copyWith(
              color:
                  selected ? _kMeasurePanelNavy : theme.colorScheme.onSurface,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );

    Widget keyedPad = InkWell(
      key: Key('board_canvas_measure_visual_target_${row.target}'),
      borderRadius: BorderRadius.circular(6),
      onTap: onSelected,
      child: pad,
    );
    if (selected) {
      keyedPad = KeyedSubtree(
        key: Key('board_canvas_measure_visual_pad_selected_${row.target}'),
        child: KeyedSubtree(
          key: Key('board_canvas_measure_visual_target_selected_${row.target}'),
          child: keyedPad,
        ),
      );
    }
    return keyedPad;
  }
}

class _MeasureTargetRow extends StatelessWidget {
  const _MeasureTargetRow({
    required this.row,
    required this.selected,
    required this.draftValue,
    required this.draftUnit,
    required this.unitOptions,
    required this.onSelected,
    required this.onDraftValueChanged,
    required this.onDraftUnitChanged,
  });

  final _MeasureTargetRowData row;
  final bool selected;
  final String draftValue;
  final String draftUnit;
  final List<String> unitOptions;
  final VoidCallback onSelected;
  final ValueChanged<String> onDraftValueChanged;
  final ValueChanged<String> onDraftUnitChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final trimmedDraft = draftValue.trim();
    final unitValue =
        unitOptions.contains(draftUnit) ? draftUnit : unitOptions.first;
    Widget targetDot() {
      return Container(
        width: 9,
        height: 9,
        decoration: BoxDecoration(
          color: selected || row.isExistingValue
              ? _kMeasurePanelSignal
              : Colors.transparent,
          border: Border.all(
            color: selected ? _kMeasurePanelSignal : theme.colorScheme.outline,
          ),
          shape: BoxShape.circle,
        ),
      );
    }

    Widget targetLabel() {
      return Text(
        row.displayLabel,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: theme.textTheme.bodySmall?.copyWith(
          fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
        ),
      );
    }

    Widget existingValueControls() {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _MeasureInlineReadonlyBox(
            key: Key(
              'board_canvas_measure_row_existing_value_${row.target}',
            ),
            value: row.value,
            compact: !row.showExistingUnit,
          ),
          if (row.showExistingUnit && row.unit != null) ...[
            const SizedBox(width: 6),
            _MeasureInlineReadonlyBox(
              key: Key(
                'board_canvas_measure_row_existing_unit_${row.target}',
              ),
              value: row.unit!,
              compact: true,
            ),
          ],
        ],
      );
    }

    Widget draftControls() {
      return SizedBox(
        width: 146,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: SizedBox(
                height: 32,
                child: TextFormField(
                  key: Key(
                    'board_canvas_measure_row_value_input_${row.target}',
                  ),
                  initialValue: draftValue,
                  style: theme.textTheme.labelMedium,
                  decoration: const InputDecoration(
                    isDense: true,
                    isCollapsed: true,
                    hintText: 'lisa väärtus',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 7,
                      vertical: 8,
                    ),
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                    signed: true,
                  ),
                  onTap: onSelected,
                  onChanged: onDraftValueChanged,
                ),
              ),
            ),
            const SizedBox(width: 5),
            DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(
                  color: _kMeasurePanelRule,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: SizedBox(
                width: 54,
                height: 32,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    key: Key(
                      'board_canvas_measure_row_unit_select_${row.target}',
                    ),
                    value: unitValue,
                    isDense: true,
                    isExpanded: true,
                    iconSize: 16,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    items: unitOptions
                        .map(
                          (unit) => DropdownMenuItem<String>(
                            value: unit,
                            child: Text(
                              unit,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        )
                        .toList(growable: false),
                    onChanged: (value) {
                      if (value == null) {
                        return;
                      }
                      onSelected();
                      onDraftUnitChanged(value);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget targetRowContent(BoxConstraints constraints) {
      final controls =
          row.isExistingValue ? existingValueControls() : draftControls();
      final isCompact = constraints.maxWidth < 320;
      if (isCompact) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                targetDot(),
                const SizedBox(width: 8),
                Expanded(child: targetLabel()),
              ],
            ),
            const SizedBox(height: 4),
            Align(
              alignment: Alignment.centerRight,
              child: controls,
            ),
          ],
        );
      }
      return Row(
        children: [
          targetDot(),
          const SizedBox(width: 8),
          Expanded(child: targetLabel()),
          const SizedBox(width: 8),
          Flexible(
            fit: FlexFit.loose,
            child: Align(
              alignment: Alignment.centerRight,
              child: controls,
            ),
          ),
        ],
      );
    }

    return MouseRegion(
      onEnter: (_) => onSelected(),
      child: InkWell(
        key: Key('board_canvas_measure_target_row_${row.target}'),
        borderRadius: BorderRadius.circular(8),
        onTap: onSelected,
        onHover: (hovering) {
          if (hovering) {
            onSelected();
          }
        },
        child: DecoratedBox(
          key: selected
              ? Key('board_canvas_measure_target_row_selected_${row.target}')
              : null,
          decoration: BoxDecoration(
            color: selected
                ? _kMeasurePanelSignalTint
                : row.isExistingValue
                    ? _kMeasurePanelCoolSurface
                    : theme.colorScheme.surface,
            border: Border.all(
              color: selected ? _kMeasurePanelSignal : _kMeasurePanelRule,
              width: selected ? 1.6 : 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LayoutBuilder(
                  builder: (context, constraints) =>
                      targetRowContent(constraints),
                ),
                if (!row.isExistingValue && trimmedDraft.isNotEmpty) ...[
                  const SizedBox(height: 3),
                  Text(
                    'Draft: ${row.displayLabel} = $trimmedDraft $unitValue',
                    key: Key(
                      'board_canvas_measure_local_draft_summary_${row.target}',
                    ),
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MeasureContextRow extends StatelessWidget {
  const _MeasureContextRow({required this.row});

  final _MeasureContextRowData row;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border.all(color: _kMeasurePanelRule),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
        child: Row(
          children: [
            const Icon(Icons.alt_route_rounded, size: 15),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                row.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                row.detail,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.right,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MeasureInlineReadonlyBox extends StatelessWidget {
  const _MeasureInlineReadonlyBox({
    super.key,
    required this.value,
    this.compact = false,
  });

  final String value;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border.all(color: _kMeasurePanelRule),
        borderRadius: BorderRadius.circular(5),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: compact ? 46 : 58,
          maxWidth: compact ? 64 : 74,
          minHeight: 32,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7),
          child: Text(
            value,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }
}

class _PlacementInspectorCard extends StatelessWidget {
  const _PlacementInspectorCard({
    required this.entry,
    required this.selectedMeasurementCount,
    required this.selectedMeasurementValueBadgeCount,
    required this.selectedMeasurementValueBadgesVisible,
    required this.onToggleSelectedMeasurementValueBadges,
  });

  final _PlacementEntry entry;
  final int selectedMeasurementCount;
  final int selectedMeasurementValueBadgeCount;
  final bool selectedMeasurementValueBadgesVisible;
  final VoidCallback? onToggleSelectedMeasurementValueBadges;

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
    final valueBadgeCountLabel = selectedMeasurementValueBadgeCount == 1
        ? 'Eligible value badge: 1'
        : 'Eligible value badges: $selectedMeasurementValueBadgeCount';

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
              if (selectedMeasurementValueBadgeCount > 0) ...[
                const SizedBox(height: 8),
                Text(valueBadgeCountLabel),
                TextButton.icon(
                  key: const Key(
                    'board_canvas_selected_measurement_value_badge_toggle',
                  ),
                  style: TextButton.styleFrom(
                    minimumSize: const Size(148, _kCompactControlTileHeight),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                  ),
                  icon: Icon(
                    selectedMeasurementValueBadgesVisible
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    size: _kCompactControlIconSize,
                  ),
                  label: Text(
                    selectedMeasurementValueBadgesVisible
                        ? 'Hide measurement badge'
                        : 'Show measurement badge',
                  ),
                  onPressed: onToggleSelectedMeasurementValueBadges,
                ),
              ],
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
    final fromParts = _endpointDisplayParts(measurement.from);
    final toParts = _endpointDisplayParts(measurement.to);

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
              _InspectorField(
                label: 'From -> To',
                value: _displayDirectionLabel(measurement.from, measurement.to),
              ),
              _InspectorField(
                label: 'From component',
                value: fromParts.component,
              ),
              _InspectorField(
                label: 'To component',
                value: toParts.component,
              ),
              _InspectorField(
                label: 'From pin',
                value: fromParts.pin ?? '-',
              ),
              _InspectorField(
                label: 'To pin',
                value: toParts.pin ?? '-',
              ),
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
    final fromEndpoint =
        _firstPresentText([trace.fromPin, trace.fromComponent]);
    final toEndpoint = _firstPresentText([trace.toPin, trace.toComponent]);
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
              if (fromEndpoint != null)
                _InspectorField(
                  label: 'From -> To',
                  value: _displayDirectionLabel(fromEndpoint, toEndpoint),
                ),
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

class _MeasurementValueBadgeLayer extends StatelessWidget {
  const _MeasurementValueBadgeLayer({
    required this.entries,
    required this.measurementValueBadgesByComponentId,
    required this.visibleMeasurementValueBadgeComponentIds,
    required this.size,
  });

  final List<_PlacementEntry> entries;
  final Map<String, List<MeasurementFact>> measurementValueBadgesByComponentId;
  final Set<String> visibleMeasurementValueBadgeComponentIds;
  final Size size;

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];
    for (final entry in entries) {
      final componentId = entry.placement.componentId;
      if (!visibleMeasurementValueBadgeComponentIds.contains(componentId)) {
        continue;
      }
      final measurements = measurementValueBadgesByComponentId[componentId] ??
          const <MeasurementFact>[];
      if (measurements.isEmpty) {
        continue;
      }

      final center = _renderedPlacementCenter(entry, size);
      final bodySize = _renderedPlacementBodySize(entry);
      const badgeWidth = 108.0;
      const badgeHeight = 22.0;
      const badgeGap = 3.0;
      final stackHeight = measurements.length * badgeHeight +
          (measurements.length - 1) * badgeGap;
      final rightCandidate = center.dx + bodySize.width / 2 + 8;
      final leftCandidate = center.dx - bodySize.width / 2 - badgeWidth - 8;
      final left = (rightCandidate + badgeWidth <= size.width - 4
              ? rightCandidate
              : leftCandidate)
          .clamp(4.0, math.max(4.0, size.width - badgeWidth - 4))
          .toDouble();
      var top = center.dy - stackHeight / 2;
      top = top
          .clamp(4.0, math.max(4.0, size.height - stackHeight - 4))
          .toDouble();

      for (var index = 0; index < measurements.length; index++) {
        final measurement = measurements[index];
        children.add(
          Positioned(
            left: left,
            top: top + index * (badgeHeight + badgeGap),
            width: badgeWidth,
            height: badgeHeight,
            child: _MeasurementValueBadge(measurement: measurement),
          ),
        );
      }
    }

    return Stack(
      key: const Key('board_canvas_measurement_value_badge_layer'),
      clipBehavior: Clip.none,
      children: children,
    );
  }
}

class _MeasurementValueBadge extends StatelessWidget {
  const _MeasurementValueBadge({required this.measurement});

  final MeasurementFact measurement;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final valueText = measurementValueBadgeText(measurement);
    final needsCaution = measurementValidityNeedsCaution(measurement);
    final foreground = needsCaution
        ? theme.colorScheme.onErrorContainer
        : theme.colorScheme.onPrimaryContainer;
    final background = needsCaution
        ? theme.colorScheme.errorContainer.withValues(alpha: 0.94)
        : theme.colorScheme.primaryContainer.withValues(alpha: 0.94);
    final borderColor =
        needsCaution ? theme.colorScheme.error : theme.colorScheme.primary;
    final semanticsLabel = needsCaution
        ? 'Measurement value badge ${measurement.measurementId}: $valueText; ${measurement.validityStatus}; not fresh authoritative value'
        : 'Measurement value badge ${measurement.measurementId}: $valueText';

    return Semantics(
      key: Key(
        'board_canvas_measurement_value_badge_semantics_${measurement.measurementId}',
      ),
      label: semanticsLabel,
      child: Tooltip(
        message: needsCaution
            ? '${measurement.validityStatus} - not fresh authoritative value'
            : 'Projected measurement value',
        child: DecoratedBox(
          key: Key(
            'board_canvas_measurement_value_badge_${measurement.measurementId}',
          ),
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(7),
            border:
                Border.all(color: borderColor, width: needsCaution ? 1.8 : 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.24),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (needsCaution) ...[
                  Icon(
                    Icons.warning_amber_rounded,
                    key: Key(
                      'board_canvas_measurement_value_badge_status_${measurement.measurementId}',
                    ),
                    size: 12,
                    color: foreground,
                  ),
                  const SizedBox(width: 3),
                ],
                Flexible(
                  child: Text(
                    valueText,
                    key: Key(
                      'board_canvas_measurement_value_badge_value_${measurement.measurementId}',
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: foreground,
                      fontWeight: FontWeight.w700,
                    ),
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

    const boardBase = Color(0xFF0C1D30);
    const boardInset = Color(0xFF11263D);
    const boardBorder = Color(0xFF0F2A45);
    const gridColor = Color(0x2A7FA0C8);

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
            ? _kBoardCanvasSignalTint.withValues(alpha: 0.92)
            : _kMeasurePanelBodyFill.withValues(alpha: 0.92)
        ..style = PaintingStyle.fill;

      final strokePaint = Paint()
        ..color = selected ? _kBoardCanvasSignal : _kBoardCanvasNavy
        ..style = PaintingStyle.stroke
        ..strokeWidth = selected ? 2.4 : 1.3;

      final padFillPaint = Paint()
        ..color = selected ? _kBoardCanvasSignal : const Color(0xFFE8A764)
        ..style = PaintingStyle.fill;

      final padStrokePaint = Paint()
        ..color = selected ? _kBoardCanvasSignal : _kBoardCanvasNavyDeep
        ..style = PaintingStyle.stroke
        ..strokeWidth = selected ? 1.1 : 0.8;

      final markerPaint = Paint()
        ..color = selected ? _kBoardCanvasSignal : _kBoardCanvasNavyDeep
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
              color:
                  selected ? _kBoardCanvasSignalTint : const Color(0xFF9FB6CC),
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
      ..color = _kBoardCanvasSignal.withValues(alpha: 0.95)
      ..style = PaintingStyle.fill;
    final badgeBorderPaint = Paint()
      ..color = _kBoardCanvasPaper.withValues(alpha: 0.85)
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
