import 'dart:math' as math;

import 'package:flutter/foundation.dart' show setEquals;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/app.dart';
import '../../components/services/v2_add_component_writer.dart';
import '../../components/services/v2_edit_component_writer.dart';
import '../../components/services/v2_placement_writer.dart';
import '../../measure_sheet/services/v2_save_measurement_writer.dart';
import '../../../shared/footprints/footprint_models.dart';
import '../../../shared/footprints/vector_footprint_library.dart';
import '../../../shared/models/known_facts.dart';
import '../../../shared/models/project_state.dart';
import '../../../shared/models/trace_bench_event.dart';

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
const double _reservedPinControlGutterWidth = 40;
const double _kPreviewFootprintVerticalCenterOffset = 2;
const Color _kMeasurePanelNavy = Color(0xFFF3ECDC);
const Color _kMeasurePanelSignal = Color(0xFFE7C25A);
const Color _kMeasurePanelSignalTint = Color(0xFF2A2416);
const Color _kMeasurePanelCoolSurface = Color(0xFF141310);
const Color _kMeasurePanelBodyFill = Color(0xFF1A1916);
const Color _kMeasurePanelRowFill = Color(0xFF0A0A0A);
const Color _kMeasurePanelRowRaised = Color(0xFF211E18);
const Color _kMeasurePanelRule = Color(0xFF332E22);
const Color _kBoardCanvasShell = Color(0xFF0C0C0C);
const Color _kBoardCanvasPaper = Color(0xFF1A1916);
const Color _kBoardCanvasTile = Color(0xFF141310);
const Color _kBoardCanvasNavy = Color(0xFFF3ECDC);
const Color _kBoardCanvasNavyDeep = Color(0xFF0A0A0A);
const Color _kBoardCanvasMuted = Color(0xFFA89F8C);
const Color _kBoardCanvasDim = Color(0xFF7E776A);
const Color _kBoardCanvasSignal = Color(0xFFE7C25A);
const Color _kBoardCanvasSignalTint = Color(0xFF2A2416);
const Color _kBoardCanvasReady = Color(0xFF6FCF97);
const Color _kBoardCanvasReadyTint = Color(0xFF0E251B);
const Color _kBoardCanvasRule = Color(0xFF332E22);
const Color _kBoardCanvasRuleStrong = Color(0xFF6B5A30);
const EdgeInsets _kCompactControlTilePadding =
    EdgeInsets.symmetric(horizontal: 8);
const EdgeInsets _kCompactControlChildrenPadding =
    EdgeInsets.fromLTRB(8, 0, 8, 6);

ButtonStyle _benchBeepNavigatorControlStyle({required bool filled}) {
  return ButtonStyle(
    foregroundColor: const WidgetStatePropertyAll(_kBoardCanvasSignal),
    backgroundColor: WidgetStatePropertyAll(
      filled ? _kBoardCanvasSignalTint : Colors.transparent,
    ),
    overlayColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.pressed)) {
        return _kBoardCanvasSignal.withValues(alpha: 0.28);
      }
      if (states.contains(WidgetState.focused)) {
        return _kBoardCanvasSignal.withValues(alpha: 0.2);
      }
      if (states.contains(WidgetState.hovered)) {
        return _kBoardCanvasSignal.withValues(alpha: 0.12);
      }
      return Colors.transparent;
    }),
    side: WidgetStateProperty.resolveWith((states) {
      final emphasized = states.contains(WidgetState.focused) ||
          states.contains(WidgetState.pressed);
      return BorderSide(
        color: emphasized
            ? _kBoardCanvasSignal.withValues(alpha: 0.86)
            : _kBoardCanvasRuleStrong.withValues(alpha: 0.6),
        width: emphasized ? 1.2 : 1,
      );
    }),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
    ),
  );
}

enum _WorkbenchContextPanelMode {
  hidden,
  inspector,
  placements,
  measure,
  addComponentTemplates,
  safetyEvidence,
  projectNavigation,
}

enum _ComponentCategory {
  resistors,
  capacitors,
  diodes,
  transistors,
  integratedCircuits,
  connectors,
  inductorsTransformers,
  fuses,
  testPoints,
  otherUnknown,
}

extension on _ComponentCategory {
  String get stableId {
    switch (this) {
      case _ComponentCategory.resistors:
        return 'resistors';
      case _ComponentCategory.capacitors:
        return 'capacitors';
      case _ComponentCategory.diodes:
        return 'diodes';
      case _ComponentCategory.transistors:
        return 'transistors';
      case _ComponentCategory.integratedCircuits:
        return 'integrated_circuits';
      case _ComponentCategory.connectors:
        return 'connectors';
      case _ComponentCategory.inductorsTransformers:
        return 'inductors_transformers';
      case _ComponentCategory.fuses:
        return 'fuses';
      case _ComponentCategory.testPoints:
        return 'test_points';
      case _ComponentCategory.otherUnknown:
        return 'other_unknown';
    }
  }

  String get label {
    switch (this) {
      case _ComponentCategory.resistors:
        return 'Takistid';
      case _ComponentCategory.capacitors:
        return 'Kondensaatorid';
      case _ComponentCategory.diodes:
        return 'Dioodid';
      case _ComponentCategory.transistors:
        return 'Transistorid';
      case _ComponentCategory.integratedCircuits:
        return 'Mikroskeemid';
      case _ComponentCategory.connectors:
        return 'Konnektorid';
      case _ComponentCategory.inductorsTransformers:
        return 'Poolid ja trafod';
      case _ComponentCategory.fuses:
        return 'Kaitsmed';
      case _ComponentCategory.testPoints:
        return 'Testpunktid';
      case _ComponentCategory.otherUnknown:
        return 'Muud / tundmatu';
    }
  }
}

_ComponentCategory _componentCategoryFor(ComponentFact component) {
  final kind = component.type?.trim().toLowerCase() ?? '';
  if (kind == 'resistor' ||
      kind == 'takisti' ||
      kind == 'res' ||
      kind.contains('pull-up') ||
      kind.contains('pull down') ||
      kind.contains('pull-down') ||
      kind.contains('pull up') ||
      kind.contains('shunt')) {
    return _ComponentCategory.resistors;
  }
  if (kind == 'capacitor' || kind == 'cap' || kind == 'kondensaator') {
    return _ComponentCategory.capacitors;
  }
  if (kind == 'diode' ||
      kind == 'diood' ||
      kind == 'zener' ||
      kind == 'schottky' ||
      kind == 'led') {
    return _ComponentCategory.diodes;
  }
  if (kind == 'transistor' ||
      kind == 'mosfet' ||
      kind == 'fet' ||
      kind == 'bjt') {
    return _ComponentCategory.transistors;
  }
  if (kind == 'ic' ||
      kind == 'mcu' ||
      kind == 'controller' ||
      kind == 'chip' ||
      kind == 'regulator' ||
      kind == 'opamp' ||
      kind == 'mikroskeem') {
    return _ComponentCategory.integratedCircuits;
  }
  if (kind == 'connector' ||
      kind == 'socket' ||
      kind == 'header' ||
      kind == 'plug' ||
      kind == 'konnektor') {
    return _ComponentCategory.connectors;
  }
  if (kind == 'inductor' ||
      kind == 'coil' ||
      kind == 'choke' ||
      kind == 'transformer' ||
      kind.contains('induktiiv')) {
    return _ComponentCategory.inductorsTransformers;
  }
  if (kind == 'fuse' || kind == 'kaitse' || kind == 'ptc') {
    return _ComponentCategory.fuses;
  }
  if (kind == 'testpoint' ||
      kind == 'test point' ||
      kind == 'tp' ||
      kind == 'testpunkt') {
    return _ComponentCategory.testPoints;
  }
  return _ComponentCategory.otherUnknown;
}

String _componentPrimaryLabel(ComponentFact component) {
  final designator = component.designator?.trim();
  return designator == null || designator.isEmpty
      ? component.componentId
      : designator;
}

String _componentKindLabel(ComponentFact component) {
  final kind = component.type?.trim();
  return kind == null || kind.isEmpty ? 'tundmatu' : kind;
}

int _naturalComponentIdCompare(String left, String right) {
  final tokenPattern = RegExp(r'\d+|\D+');
  final leftTokens = tokenPattern
      .allMatches(left.toLowerCase())
      .map((match) => match.group(0)!)
      .toList(growable: false);
  final rightTokens = tokenPattern
      .allMatches(right.toLowerCase())
      .map((match) => match.group(0)!)
      .toList(growable: false);
  final commonLength = math.min(leftTokens.length, rightTokens.length);
  for (var index = 0; index < commonLength; index++) {
    final leftToken = leftTokens[index];
    final rightToken = rightTokens[index];
    final leftNumber = int.tryParse(leftToken);
    final rightNumber = int.tryParse(rightToken);
    final comparison = leftNumber != null && rightNumber != null
        ? leftNumber.compareTo(rightNumber)
        : leftToken.compareTo(rightToken);
    if (comparison != 0) {
      return comparison;
    }
  }
  return leftTokens.length.compareTo(rightTokens.length);
}

abstract class CanvasSelection {
  const CanvasSelection();
}

class EmptyCanvasSelection extends CanvasSelection {
  const EmptyCanvasSelection();
}

class ComponentSelection extends CanvasSelection {
  const ComponentSelection({required this.componentId});

  final String componentId;
}

class ComponentPlacementSelection extends CanvasSelection {
  const ComponentPlacementSelection({
    required this.placementKey,
    required this.componentId,
    this.canvasAnchor,
  });

  final String placementKey;
  final String componentId;
  final Offset? canvasAnchor;
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
  CanvasSelection _canvasSelection = const EmptyCanvasSelection();
  _ComponentCategory? _componentNavigatorCategory;
  Set<String> _previewPlacementKeys = const <String>{};
  bool _hideUnmeasuredComponents = false;
  String? _selectedAddComponentTemplateId;
  int _addComponentTemplateTopContactMarkers = 0;
  int _addComponentTemplateRightContactMarkers = 0;
  int _addComponentTemplateBottomContactMarkers = 0;
  int _addComponentTemplateLeftContactMarkers = 0;
  String _addComponentTemplateDraftLabel = '';
  double _addComponentTemplateDraftWidth = 1.0;
  double _addComponentTemplateDraftHeight = 0.6;
  int _addComponentTemplateDraftRotationDeg = 0;
  Offset? _addComponentTemplateGhostDraftAnchor;
  Size? _addComponentTemplateGhostDraftCanvasSize;
  String? _placementEditorDraftKey;
  _PlacementEditorDraftState? _placementEditorDraft;
  bool _addComponentPlacementSaveInFlight = false;
  String? _addComponentTemplateSaveStatusMessage;
  String _rightPanelCreateComponentId = '';
  String _rightPanelCreateComponentLabel = '';
  String? _rightPanelCreateComponentKind;
  bool _rightPanelCreateComponentInFlight = false;
  String? _rightPanelCreateComponentStatusMessage;
  String? _rightPanelCreateComponentErrorMessage;
  String? _rightPanelMetadataEditComponentId;
  String _rightPanelMetadataEditLabel = '';
  String _rightPanelMetadataEditKind = 'unknown';
  bool _rightPanelMetadataEditInFlight = false;
  String? _rightPanelMetadataEditStatusMessage;
  String? _rightPanelMetadataEditErrorMessage;
  String? _rightPanelMetadataEditLastSuccessfulFormKey;
  bool _inspectorVisible = true;
  bool _canvasFocusMode = false;
  final Set<String> _visibleMeasurementValueBadgeComponentIds = <String>{};
  final ScrollController _addComponentContextScrollController =
      ScrollController();
  _WorkbenchContextPanelMode _contextPanelMode =
      _WorkbenchContextPanelMode.hidden;

  @override
  void dispose() {
    _addComponentContextScrollController.dispose();
    super.dispose();
  }

  String? get _selectedPlacementKey {
    final selection = _canvasSelection;
    return selection is ComponentPlacementSelection
        ? selection.placementKey
        : null;
  }

  String? get _selectedComponentId {
    final selection = _canvasSelection;
    if (selection is ComponentSelection) {
      return selection.componentId;
    }
    if (selection is ComponentPlacementSelection) {
      return selection.componentId;
    }
    return null;
  }

  void _setCanvasSelection(CanvasSelection selection) {
    _canvasSelection = selection;
  }

  void _clearCanvasSelection() {
    _setCanvasSelection(const EmptyCanvasSelection());
  }

  void _selectComponent(ComponentFact component) {
    _setCanvasSelection(
      ComponentSelection(componentId: component.componentId),
    );
  }

  void _setPreviewPlacementKeys(Set<String> keys) {
    if (setEquals(_previewPlacementKeys, keys)) {
      return;
    }
    setState(() {
      _previewPlacementKeys = Set<String>.unmodifiable(keys);
    });
  }

  void _toggleHideUnmeasuredComponents(
    Map<String, int> measurementCountsByComponentId,
    Map<String, ComponentFact> componentsById,
  ) {
    setState(() {
      final nextValue = !_hideUnmeasuredComponents;
      if (nextValue) {
        final selectedComponentId = _selectedComponentId;
        if (selectedComponentId != null &&
            (measurementCountsByComponentId[selectedComponentId] ?? 0) == 0) {
          final selectedComponent = componentsById[selectedComponentId];
          _clearCanvasSelection();
          _componentNavigatorCategory = selectedComponent == null
              ? null
              : _componentCategoryFor(selectedComponent);
          _contextPanelMode = _WorkbenchContextPanelMode.placements;
          _inspectorVisible = true;
          _canvasFocusMode = false;
        }
      }
      _hideUnmeasuredComponents = nextValue;
      _previewPlacementKeys = const <String>{};
    });
  }

  void _beginUnplacedComponentPlacement(ComponentFact component) {
    setState(() {
      _contextPanelMode = _WorkbenchContextPanelMode.addComponentTemplates;
      _inspectorVisible = true;
      _canvasFocusMode = false;
      _selectedAddComponentTemplateId = null;
      _addComponentTemplateTopContactMarkers = 0;
      _addComponentTemplateRightContactMarkers = 0;
      _addComponentTemplateBottomContactMarkers = 0;
      _addComponentTemplateLeftContactMarkers = 0;
      _addComponentTemplateDraftLabel = _componentPrimaryLabel(component);
      _resetAddComponentTemplateLocalDraftScalars();
      _addComponentTemplateGhostDraftAnchor = null;
      _addComponentTemplateGhostDraftCanvasSize = null;
      _addComponentTemplateSaveStatusMessage = null;
      _previewPlacementKeys = const <String>{};
    });
  }

  void _selectComponentPlacement(
    _PlacementEntry entry, {
    Offset? canvasAnchor,
  }) {
    _setCanvasSelection(
      ComponentPlacementSelection(
        placementKey: entry.key,
        componentId: entry.placement.componentId,
        canvasAnchor: canvasAnchor,
      ),
    );
  }

  void _selectComponentPlacementByKey(
    String placementKey,
    List<_PlacementEntry> entries, {
    Offset? canvasAnchor,
  }) {
    for (final entry in entries) {
      if (entry.key == placementKey) {
        _selectComponentPlacement(entry, canvasAnchor: canvasAnchor);
        return;
      }
    }
    _clearCanvasSelection();
  }

  _AddComponentTemplateDefinition? _selectedAddComponentTemplateDefinition() {
    return _starterAddComponentTemplateById(_selectedAddComponentTemplateId);
  }

  _AddComponentTemplateDefinition? _starterAddComponentTemplateById(
    String? templateId,
  ) {
    final normalizedTemplateId = templateId?.trim();
    if (normalizedTemplateId == null || normalizedTemplateId.isEmpty) {
      return null;
    }
    for (final template in _kStarterAddComponentTemplates) {
      if (template.id == normalizedTemplateId) {
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

  void _resetAddComponentTemplateLocalDraftScalars() {
    _addComponentTemplateDraftWidth = 1.0;
    _addComponentTemplateDraftHeight = 0.6;
    _addComponentTemplateDraftRotationDeg = 0;
  }

  void _seedAddComponentTemplateDraftFromPlacement(
    _PlacementEntry entry, {
    bool seedTemplate = true,
  }) {
    final placement = entry.placement;
    final placementWidth = placement.width?.toDouble();
    final placementHeight = placement.height?.toDouble();
    _addComponentTemplateDraftWidth = placementWidth == null ||
            !placementWidth.isFinite ||
            placementWidth <= 0
        ? 1.0
        : _clampAddComponentTemplateDraftDimension(placementWidth);
    _addComponentTemplateDraftHeight = placementHeight == null ||
            !placementHeight.isFinite ||
            placementHeight <= 0
        ? 0.6
        : _clampAddComponentTemplateDraftDimension(placementHeight);
    _addComponentTemplateDraftRotationDeg =
        _normalizeAddComponentTemplateDraftRotation(
      placement.rotationDeg.round(),
    );
    _addComponentTemplateGhostDraftAnchor = null;
    _addComponentTemplateGhostDraftCanvasSize = null;

    if (!seedTemplate) {
      return;
    }
    final template = _starterAddComponentTemplateById(placement.templateId);
    if (template == null) {
      _selectedAddComponentTemplateId = null;
      return;
    }
    _selectedAddComponentTemplateId = template.id;
    _seedAddComponentTemplateContactCounts(template);
  }

  double _clampAddComponentTemplateDraftDimension(double value) {
    return value.clamp(0.2, 9.9).toDouble();
  }

  int _normalizeAddComponentTemplateDraftRotation(int value) {
    return ((value % 360) + 360) % 360;
  }

  double? _addComponentTemplateDraftCenterX(_PlacementSaveTarget target) {
    final draftAnchor = _addComponentTemplateGhostDraftAnchor;
    if (draftAnchor == null) {
      return target.existingCenterX;
    }
    final canvasSize = _addComponentTemplateGhostDraftCanvasSize;
    if (canvasSize == null || canvasSize.width <= 0) {
      return target.coordinateSpace == 'board_normalized'
          ? null
          : draftAnchor.dx;
    }
    return draftAnchor.dx / canvasSize.width;
  }

  double? _addComponentTemplateDraftCenterY(_PlacementSaveTarget target) {
    final draftAnchor = _addComponentTemplateGhostDraftAnchor;
    if (draftAnchor == null) {
      return target.existingCenterY;
    }
    final canvasSize = _addComponentTemplateGhostDraftCanvasSize;
    if (canvasSize == null || canvasSize.height <= 0) {
      return target.coordinateSpace == 'board_normalized'
          ? null
          : draftAnchor.dy;
    }
    return draftAnchor.dy / canvasSize.height;
  }

  bool _isBoardNormalizedCoordinateInBounds(double value) {
    return value.isFinite && value >= 0 && value <= 1;
  }

  bool _isBoardNormalizedSizeInBounds(double value) {
    return value.isFinite && value > 0 && value <= 1;
  }

  String? _addComponentTemplateCanonicalBoundsBlockReason(
    _PlacementSaveTarget target,
  ) {
    if (target.coordinateSpace.trim() != 'board_normalized') {
      return null;
    }
    final centerX = _addComponentTemplateDraftCenterX(target);
    final centerY = _addComponentTemplateDraftCenterY(target);
    if (centerX == null ||
        centerY == null ||
        !_isBoardNormalizedCoordinateInBounds(centerX) ||
        !_isBoardNormalizedCoordinateInBounds(centerY) ||
        !_isBoardNormalizedSizeInBounds(_addComponentTemplateDraftWidth) ||
        !_isBoardNormalizedSizeInBounds(_addComponentTemplateDraftHeight)) {
      return 'Suurus või asukoht ei mahu plaadi piiridesse.';
    }
    return null;
  }

  void _setAddComponentTemplateSelection(
    String templateId, {
    _PlacementEntry? placementContextEntry,
  }) {
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
      if (placementContextEntry == null) {
        _resetAddComponentTemplateLocalDraftScalars();
        _addComponentTemplateGhostDraftAnchor = null;
        _addComponentTemplateGhostDraftCanvasSize = null;
        return;
      }
      _seedAddComponentTemplateDraftFromPlacement(
        placementContextEntry,
        seedTemplate: false,
      );
    });
  }

  _PlacementEditorDraftState _placementEditorDraftFor(_PlacementEntry entry) {
    if (_placementEditorDraftKey != entry.key ||
        _placementEditorDraft == null) {
      _placementEditorDraftKey = entry.key;
      _placementEditorDraft = _PlacementEditorDraftState.fromEntry(entry);
    }
    return _placementEditorDraft!;
  }

  void _updatePlacementEditorDraft(
    _PlacementEntry entry,
    _PlacementEditorDraftState Function(_PlacementEditorDraftState draft)
        update,
  ) {
    setState(() {
      final current =
          _placementEditorDraftKey == entry.key && _placementEditorDraft != null
              ? _placementEditorDraft!
              : _PlacementEditorDraftState.fromEntry(entry);
      _placementEditorDraftKey = entry.key;
      _placementEditorDraft = update(current);
    });
  }

  void _resetPlacementEditorDraft(_PlacementEntry entry) {
    setState(() {
      _placementEditorDraftKey = entry.key;
      _placementEditorDraft = _PlacementEditorDraftState.fromEntry(entry);
    });
  }

  String? _addComponentTemplateSaveBlockReason({
    required ProjectState projectState,
    required _PlacementSaveTarget? target,
  }) {
    if (target == null) {
      return 'Vali olemasolev komponent enne salvestamist.';
    }
    if (_addComponentTemplateDraftLabel.trim().isEmpty) {
      return 'Lisa nimi enne salvestamist.';
    }
    if (target.requiresExplicitAnchor &&
        _addComponentTemplateGhostDraftAnchor == null) {
      return 'Vali canvasele paigutuse asukoht.';
    }
    final canonicalBoundsReason =
        _addComponentTemplateCanonicalBoundsBlockReason(target);
    if (canonicalBoundsReason != null) {
      return canonicalBoundsReason;
    }
    final projectDirectory = projectState.projectDirectory;
    if (projectDirectory == null || projectDirectory.trim().isEmpty) {
      return 'Salvestamiseks ava projekt kohalikust kaustast.';
    }
    return null;
  }

  _PlacementSaveTarget? _placementSaveTarget(
    List<_PlacementEntry> entries,
  ) {
    final selection = _canvasSelection;
    if (selection is ComponentPlacementSelection) {
      for (final entry in entries) {
        if (entry.key == selection.placementKey &&
            entry.placement.componentId == selection.componentId) {
          return _PlacementSaveTarget.fromEntry(entry);
        }
      }
      return null;
    }
    if (selection is ComponentSelection) {
      final hasConfirmedPlacement = entries.any(
        (entry) => entry.placement.componentId == selection.componentId,
      );
      if (hasConfirmedPlacement) {
        return null;
      }
      return _PlacementSaveTarget.firstBoardPlacement(
        componentId: selection.componentId,
      );
    }
    return null;
  }

  void _showAddComponentTemplateSaveStatus(String message) {
    setState(() {
      _addComponentTemplateSaveStatusMessage = message;
    });
  }

  void _markPlacementProjectionStale({
    required ProjectState projectState,
    required Map<String, dynamic> event,
  }) {
    final returnedEvent = TraceBenchEvent.fromJson(event);
    final updatedEvents = List<TraceBenchEvent>.from(projectState.events);
    final eventAlreadyPresent = updatedEvents.any(
      (localEvent) => localEvent.eventId == returnedEvent.eventId,
    );
    if (!eventAlreadyPresent) {
      updatedEvents.add(returnedEvent);
    }
    ref.read(projectStateProvider.notifier).state = projectState.copyWith(
      events: updatedEvents,
      isProjectionStale: true,
    );
  }

  String? _rightPanelCreateComponentBlockReason(ProjectState projectState) {
    if (_rightPanelCreateComponentId.trim().isEmpty) {
      return 'Sisesta komponendi ID enne loomist.';
    }
    if (_rightPanelCreateComponentLabel.trim().isEmpty) {
      return 'Sisesta komponendi nimi enne loomist.';
    }
    if (_rightPanelCreateComponentKind == null ||
        _rightPanelCreateComponentKind!.trim().isEmpty) {
      return 'Vali komponendi liik enne loomist.';
    }
    final projectDirectory = projectState.projectDirectory;
    if (projectDirectory == null || projectDirectory.trim().isEmpty) {
      return 'Komponendi loomiseks ava projekt kohalikust kaustast.';
    }
    return null;
  }

  Future<void> _confirmRightPanelComponentCreation({
    required ProjectState projectState,
  }) async {
    if (_rightPanelCreateComponentInFlight) {
      return;
    }

    final blockReason = _rightPanelCreateComponentBlockReason(projectState);
    if (blockReason != null) {
      setState(() {
        _rightPanelCreateComponentStatusMessage = null;
        _rightPanelCreateComponentErrorMessage = blockReason;
      });
      return;
    }

    final componentId = _rightPanelCreateComponentId.trim();
    final request = V2AddComponentRequest(
      componentId: componentId,
      label: _rightPanelCreateComponentLabel.trim(),
      componentKind: _rightPanelCreateComponentKind!.trim(),
      clientOperationId: _componentCreationClientOperationIdFor(componentId),
    );

    setState(() {
      _rightPanelCreateComponentInFlight = true;
      _rightPanelCreateComponentStatusMessage =
          'Salvestan komponendi identiteeti...';
      _rightPanelCreateComponentErrorMessage = null;
    });

    try {
      final result = await ref.read(v2AddComponentWriterProvider).addComponent(
            projectState: projectState,
            request: request,
          );
      if (!mounted) {
        return;
      }
      _markPlacementProjectionStale(
        projectState: projectState,
        event: result.event,
      );
      setState(() {
        _rightPanelCreateComponentStatusMessage = result.appended
            ? 'Komponent loodud. Projektsioon vajab värskendamist.'
            : 'Komponent oli juba salvestatud. Projektsioon vajab värskendamist.';
        _rightPanelCreateComponentErrorMessage = null;
      });
    } on V2AddComponentException catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _rightPanelCreateComponentStatusMessage = null;
        _rightPanelCreateComponentErrorMessage =
            _componentCreationFailureMessage(error);
      });
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _rightPanelCreateComponentStatusMessage = null;
        _rightPanelCreateComponentErrorMessage =
            'Komponendi loomine ebaõnnestus: $error';
      });
    } finally {
      if (mounted) {
        setState(() {
          _rightPanelCreateComponentInFlight = false;
        });
      }
    }
  }

  String _componentCreationClientOperationIdFor(String componentId) {
    final safeComponentId = componentId
        .trim()
        .replaceAll(RegExp(r'[^A-Za-z0-9_]+'), '_')
        .replaceAll(RegExp(r'_+'), '_');
    final timestamp = DateTime.now().toUtc().microsecondsSinceEpoch;
    return 'op_board_canvas_component_created_${safeComponentId}_$timestamp';
  }

  String _componentCreationFailureMessage(V2AddComponentException error) {
    switch (error.kind) {
      case V2AddComponentFailureKind.noProjectDirectory:
        return 'Komponendi loomiseks ava projekt kohalikust kaustast.';
      case V2AddComponentFailureKind.invalidProjectDirectory:
        return 'Projektikaust ei sobi komponendi loomiseks.';
      case V2AddComponentFailureKind.pythonUnavailable:
        return 'Komponendi kirjutaja pole saadaval.';
      case V2AddComponentFailureKind.lockConflict:
        return 'Komponendi kirjutaja on hetkel hõivatud.';
      case V2AddComponentFailureKind.validation:
        if (error.message.toLowerCase().contains(
              'duplicate v2 component_id',
            )) {
          return 'Komponendi ID on juba kasutusel. Vali uus Koht / ID.';
        }
        return 'Komponenti ei loodud: sisestus ei läbinud valideerimist.';
      case V2AddComponentFailureKind.append:
        return 'Komponendi loomine ebaõnnestus: ${error.message}';
    }
  }

  ComponentFact? _rightPanelSelectedMetadataComponent(
    ProjectState projectState, {
    String? fallbackComponentId,
  }) {
    final selection = _canvasSelection;
    final componentId = switch (selection) {
      ComponentSelection(:final componentId) => componentId,
      ComponentPlacementSelection(:final componentId) => componentId,
      _ => fallbackComponentId,
    };
    if (componentId == null || componentId.trim().isEmpty) {
      return null;
    }
    for (final component in projectState.knownFacts.components) {
      if (component.componentId == componentId) {
        return component;
      }
    }
    return null;
  }

  void _seedRightPanelMetadataEditDraft(ComponentFact? component) {
    final componentId = component?.componentId;
    if (_rightPanelMetadataEditComponentId == componentId) {
      return;
    }
    _rightPanelMetadataEditComponentId = componentId;
    _rightPanelMetadataEditLabel =
        component == null ? '' : _componentMetadataEditBaselineLabel(component);
    _rightPanelMetadataEditKind = _canonicalRightPanelComponentKind(
      component?.type,
    );
    _rightPanelMetadataEditStatusMessage = null;
    _rightPanelMetadataEditErrorMessage = null;
    _rightPanelMetadataEditLastSuccessfulFormKey = null;
  }

  String _componentMetadataEditBaselineLabel(ComponentFact component) {
    final designator = component.designator?.trim();
    if (designator != null && designator.isNotEmpty) {
      return designator;
    }
    return component.componentId;
  }

  String _componentMetadataEditDisplayLabel(ComponentFact component) {
    final label = _componentMetadataEditBaselineLabel(component);
    if (label == component.componentId) {
      return component.componentId;
    }
    return '$label (${component.componentId})';
  }

  String _canonicalRightPanelComponentKind(String? rawValue) {
    final value = rawValue?.trim().toLowerCase() ?? '';
    if (_RightPanelComponentCreationSection._componentKinds.contains(value)) {
      return value;
    }
    return 'unknown';
  }

  List<V2ComponentChange> _rightPanelMetadataEditChanges(
    ComponentFact component,
  ) {
    final changes = <V2ComponentChange>[];
    final oldLabel = _componentMetadataEditBaselineLabel(component);
    final newLabel = _rightPanelMetadataEditLabel.trim();
    if (newLabel != oldLabel) {
      changes.add(
        V2ComponentChange(
          field: 'label',
          oldValueObserved: oldLabel,
          newValue: newLabel,
          changeKind: oldLabel.isEmpty ? 'set' : 'replace',
        ),
      );
    }

    final oldKind = _canonicalRightPanelComponentKind(component.type);
    final newKind = _canonicalRightPanelComponentKind(
      _rightPanelMetadataEditKind,
    );
    if (newKind != oldKind) {
      changes.add(
        V2ComponentChange(
          field: 'component_kind',
          oldValueObserved: oldKind,
          newValue: newKind,
          changeKind: oldKind == 'unknown' ? 'set' : 'replace',
        ),
      );
    }
    return changes;
  }

  String? _rightPanelMetadataEditBlockReason(
    ProjectState projectState,
    ComponentFact? component,
  ) {
    if (component == null) {
      if (_rightPanelCreateComponentStatusMessage?.startsWith(
            'Komponent loodud.',
          ) ??
          false) {
        return 'Komponent loodi. Värskenda projektsioon või vali olemasolev komponent enne metadata muutmist.';
      }
      return 'Vali plaadil olemasolev komponent. Mustandit ei saa siin muuta.';
    }
    if (_rightPanelMetadataEditLabel.trim().isEmpty) {
      return 'Sisesta komponendi nimi enne salvestamist.';
    }
    if (_rightPanelMetadataEditChanges(component).isEmpty) {
      return 'Muuda nime või liiki enne salvestamist.';
    }
    final formKey = _rightPanelMetadataEditFormKey(component);
    if (_rightPanelMetadataEditLastSuccessfulFormKey == formKey) {
      return 'Komponendi andmed on salvestatud. Projektsioon vajab värskendamist.';
    }
    final projectDirectory = projectState.projectDirectory;
    if (projectDirectory == null || projectDirectory.trim().isEmpty) {
      return 'Muudatuste salvestamiseks ava projekt kohalikust kaustast.';
    }
    return null;
  }

  Future<void> _confirmRightPanelMetadataEdit({
    required ProjectState projectState,
    required ComponentFact component,
  }) async {
    if (_rightPanelMetadataEditInFlight) {
      return;
    }

    final blockReason = _rightPanelMetadataEditBlockReason(
      projectState,
      component,
    );
    if (blockReason != null) {
      setState(() {
        _rightPanelMetadataEditStatusMessage = null;
        _rightPanelMetadataEditErrorMessage = blockReason;
      });
      return;
    }

    final request = V2EditComponentRequest(
      componentId: component.componentId,
      changes: _rightPanelMetadataEditChanges(component),
      editReason: 'board_canvas_right_panel_metadata_edit',
      clientOperationId: _metadataEditClientOperationIdFor(
        component.componentId,
      ),
    );
    final formKey = _rightPanelMetadataEditFormKey(component);

    setState(() {
      _rightPanelMetadataEditInFlight = true;
      _rightPanelMetadataEditStatusMessage = 'Salvestan komponendi andmeid...';
      _rightPanelMetadataEditErrorMessage = null;
    });

    try {
      final result =
          await ref.read(v2EditComponentWriterProvider).editComponent(
                projectState: projectState,
                request: request,
              );
      if (!mounted) {
        return;
      }
      _markPlacementProjectionStale(
        projectState: projectState,
        event: result.event,
      );
      setState(() {
        _rightPanelMetadataEditStatusMessage = result.appended
            ? 'Komponendi andmed salvestatud. Projektsioon vajab värskendamist.'
            : 'Komponendi andmed olid juba salvestatud. Projektsioon vajab värskendamist.';
        _rightPanelMetadataEditErrorMessage = null;
        _rightPanelMetadataEditLastSuccessfulFormKey = formKey;
      });
    } on V2EditComponentException catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _rightPanelMetadataEditStatusMessage = null;
        _rightPanelMetadataEditErrorMessage =
            _componentMetadataEditFailureMessage(error);
      });
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _rightPanelMetadataEditStatusMessage = null;
        _rightPanelMetadataEditErrorMessage =
            'Komponendi andmete muutmine ebaõnnestus: $error';
      });
    } finally {
      if (mounted) {
        setState(() {
          _rightPanelMetadataEditInFlight = false;
        });
      }
    }
  }

  String _rightPanelMetadataEditFormKey(ComponentFact component) {
    final label = _rightPanelMetadataEditLabel.trim();
    final kind = _canonicalRightPanelComponentKind(_rightPanelMetadataEditKind);
    return '${component.componentId}|$label|$kind';
  }

  String _metadataEditClientOperationIdFor(String componentId) {
    final safeComponentId = componentId
        .trim()
        .replaceAll(RegExp(r'[^A-Za-z0-9_]+'), '_')
        .replaceAll(RegExp(r'_+'), '_');
    final timestamp = DateTime.now().toUtc().microsecondsSinceEpoch;
    return 'op_board_canvas_component_updated_${safeComponentId}_$timestamp';
  }

  String _componentMetadataEditFailureMessage(
    V2EditComponentException error,
  ) {
    switch (error.kind) {
      case V2EditComponentFailureKind.noProjectDirectory:
        return 'Muudatuste salvestamiseks ava projekt kohalikust kaustast.';
      case V2EditComponentFailureKind.invalidProjectDirectory:
        return 'Projektikaust ei sobi komponendi muutmiseks.';
      case V2EditComponentFailureKind.pythonUnavailable:
        return 'Komponendi muutmise kirjutaja pole saadaval.';
      case V2EditComponentFailureKind.lockConflict:
        return 'Komponendi muutmise kirjutaja on hetkel hõivatud.';
      case V2EditComponentFailureKind.unknownComponent:
        return 'Vali plaadil olemasolev komponent. Mustandit ei saa siin muuta.';
      case V2EditComponentFailureKind.validation:
        return 'Komponendi andmeid ei salvestatud: sisestus ei läbinud valideerimist.';
      case V2EditComponentFailureKind.append:
        return 'Komponendi andmete salvestamine ebaõnnestus: ${error.message}';
    }
  }

  Future<void> _confirmAddComponentTemplatePlacement({
    required ProjectState projectState,
    required _PlacementSaveTarget target,
    required _AddComponentTemplateDefinition template,
  }) async {
    if (_addComponentPlacementSaveInFlight) {
      return;
    }

    final canonicalBoundsBlockReason =
        _addComponentTemplateCanonicalBoundsBlockReason(target);
    if (canonicalBoundsBlockReason != null) {
      _showAddComponentTemplateSaveStatus(canonicalBoundsBlockReason);
      return;
    }
    final centerX = _addComponentTemplateDraftCenterX(target);
    final centerY = _addComponentTemplateDraftCenterY(target);
    if (centerX == null || centerY == null) {
      _showAddComponentTemplateSaveStatus(
        'Vali canvasele paigutuse asukoht.',
      );
      return;
    }
    final request = V2PlacementWriterRequest(
      componentId: target.componentId,
      coordinateSpace: target.coordinateSpace,
      boardSide: target.boardSide,
      centerX: centerX,
      centerY: centerY,
      rotationDeg: _addComponentTemplateDraftRotationDeg,
      width: _addComponentTemplateDraftWidth,
      height: _addComponentTemplateDraftHeight,
      templateId: template.id,
      sourcePhotoId: target.sourcePhotoId,
      clientOperationId: _placementClientOperationIdFor(target.componentId),
    );

    setState(() {
      _addComponentPlacementSaveInFlight = true;
      _addComponentTemplateSaveStatusMessage =
          'Salvestan valitud komponendi visuaalset paigutust...';
    });

    try {
      final result = await ref.read(v2PlacementWriterProvider).confirmPlacement(
            projectState: projectState,
            request: request,
          );
      if (!mounted) {
        return;
      }
      _markPlacementProjectionStale(
        projectState: projectState,
        event: result.event,
      );
      _showAddComponentTemplateSaveStatus(
        result.appended
            ? 'Visuaalne paigutus salvestatud. Projektsioon vajab värskendamist.'
            : 'See visuaalne paigutus oli juba salvestatud. Projektsioon vajab värskendamist.',
      );
    } on V2PlacementWriterException catch (error) {
      if (!mounted) {
        return;
      }
      _showAddComponentTemplateSaveStatus(
        'Salvestamine ebaõnnestus: ${error.message}',
      );
    } catch (error) {
      if (!mounted) {
        return;
      }
      _showAddComponentTemplateSaveStatus('Salvestamine ebaõnnestus: $error');
    } finally {
      if (mounted) {
        setState(() {
          _addComponentPlacementSaveInFlight = false;
        });
      }
    }
  }

  String _placementClientOperationIdFor(String componentId) {
    final safeComponentId = componentId
        .trim()
        .replaceAll(RegExp(r'[^A-Za-z0-9_]+'), '_')
        .replaceAll(RegExp(r'_+'), '_');
    final timestamp = DateTime.now().toUtc().microsecondsSinceEpoch;
    return 'op_board_canvas_visual_placement_${safeComponentId}_$timestamp';
  }

  String _nextPlacementDraftBoardSide(String boardSide) {
    switch (boardSide.trim().toLowerCase()) {
      case 'top':
        return 'bottom';
      case 'bottom':
        return 'top';
      default:
        return 'top';
    }
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
    final componentsById = <String, ComponentFact>{
      for (final component in knownFacts.components)
        component.componentId: component,
    };
    final knownPinsByComponentId = _knownPinVisualRefsByComponentId(knownFacts);

    final allEntries = allPlacements
        .map(
          (placement) => _PlacementEntry(
            placement: placement,
            component: componentsById[placement.componentId],
            template: placement.templateId == null
                ? null
                : VectorFootprintLibrary.templateById(placement.templateId!),
            knownPins:
                knownPinsByComponentId[placement.componentId] ?? const [],
          ),
        )
        .toList(growable: false);
    final entries = allEntries
        .where(
          (entry) => entry.placement.coordinateSpace == 'board_normalized',
        )
        .toList(growable: false);
    final photoToBoardAlignments = knownFacts.photoToBoardAlignments;

    final measurementCountByComponent = measurementCountsByComponents(
      measurements: knownFacts.measurements,
      componentIds: knownFacts.components
          .map((component) => component.componentId)
          .toSet(),
    );
    final visibleComponentIds = knownFacts.components
        .where(
          (component) =>
              !_hideUnmeasuredComponents ||
              (measurementCountByComponent[component.componentId] ?? 0) > 0,
        )
        .map((component) => component.componentId)
        .toSet();
    final visibleEntries = entries
        .where(
          (entry) => visibleComponentIds.contains(entry.placement.componentId),
        )
        .toList(growable: false);

    final selectedKey = _coerceSelection(visibleEntries);
    _PlacementEntry? selectedEntry;
    if (selectedKey != null) {
      for (final entry in visibleEntries) {
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
    final measurementValueBadgesByComponent =
        measurementValueBadgesByComponents(
      measurements: knownFacts.measurements,
      componentIds:
          visibleEntries.map((entry) => entry.placement.componentId).toSet(),
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
    final _PlacementEntry? selectedDraftEntry = selectedEntry;
    final selectedPlacementDraft = selectedDraftEntry == null
        ? null
        : _placementEditorDraftFor(selectedDraftEntry);
    final placementSaveTarget = _placementSaveTarget(allEntries);
    final addComponentTemplatePlacementContextEntry =
        placementSaveTarget?.sourceEntry;
    final addComponentTemplateSaveBlockReason =
        selectedAddComponentTemplate == null
            ? null
            : _addComponentTemplateSaveBlockReason(
                projectState: projectState,
                target: placementSaveTarget,
              );
    final canConfirmAddComponentPlacement =
        selectedAddComponentTemplate != null &&
            addComponentTemplateSaveBlockReason == null &&
            !_addComponentPlacementSaveInFlight;
    return _buildScaffold(
      context,
      Padding(
        padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
        child: DecoratedBox(
          key: const Key('board_canvas_workspace_frame'),
          decoration: BoxDecoration(
            color: _kBoardCanvasPaper.withValues(alpha: 0.72),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: _kBoardCanvasRule),
            boxShadow: const [
              BoxShadow(
                color: Color(0x52080B0F),
                blurRadius: 22,
                offset: Offset(0, 12),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final useWorkbenchShell = constraints.maxWidth >= 900;
                final selector = _PlacementSelector(
                  entries: visibleEntries,
                  selectedKey: selectedKey,
                  selectedLabel: selectedEntry?.selectorLabel,
                  onSelected: (value) {
                    setState(() {
                      _selectComponentPlacementByKey(value, visibleEntries);
                      if (_contextPanelMode !=
                          _WorkbenchContextPanelMode.measure) {
                        _contextPanelMode =
                            _WorkbenchContextPanelMode.inspector;
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
                  entries: visibleEntries,
                  selectedKey: selectedKey,
                  selectedComponentId: _selectedComponentId,
                  previewKeys: _previewPlacementKeys,
                  hideUnmeasured: _hideUnmeasuredComponents,
                  onToggleHideUnmeasured: () => _toggleHideUnmeasuredComponents(
                    measurementCountByComponent,
                    componentsById,
                  ),
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
                  cornerFocusAction: useWorkbenchShell && !_canvasFocusMode
                      ? focusToggle
                      : null,
                  onPlacementSelected: (selection) {
                    setState(() {
                      _setCanvasSelection(selection);
                      if (_contextPanelMode !=
                              _WorkbenchContextPanelMode.measure &&
                          _contextPanelMode !=
                              _WorkbenchContextPanelMode.placements) {
                        _contextPanelMode =
                            _WorkbenchContextPanelMode.inspector;
                      }
                      _inspectorVisible = true;
                    });
                  },
                  onCanvasTapEmpty: () {
                    setState(() {
                      _clearCanvasSelection();
                      if (_contextPanelMode !=
                              _WorkbenchContextPanelMode.measure &&
                          _contextPanelMode !=
                              _WorkbenchContextPanelMode.placements) {
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
                      _addComponentTemplateGhostDraftAnchor = value.anchor;
                      _addComponentTemplateGhostDraftCanvasSize =
                          value.canvasSize;
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
                  onToggleSelectedMeasurementValueBadges:
                      selectedEntry == null ||
                              selectedMeasurementValueBadgeCount == 0
                          ? null
                          : () {
                              final componentId =
                                  selectedEntry!.placement.componentId;
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
                  placementDraft: selectedPlacementDraft,
                  onTogglePlacementDraftSide: selectedDraftEntry == null
                      ? null
                      : () {
                          _updatePlacementEditorDraft(
                            selectedDraftEntry,
                            (draft) => draft.copyWith(
                              boardSide:
                                  _nextPlacementDraftBoardSide(draft.boardSide),
                            ),
                          );
                        },
                  onIncrementPlacementDraftRotation: selectedDraftEntry == null
                      ? null
                      : () {
                          _updatePlacementEditorDraft(
                            selectedDraftEntry,
                            (draft) => draft.copyWith(
                              rotationDeg: draft.rotationDeg + 15,
                            ),
                          );
                        },
                  onIncrementPlacementDraftWidth: selectedDraftEntry == null
                      ? null
                      : () {
                          _updatePlacementEditorDraft(
                            selectedDraftEntry,
                            (draft) => draft.copyWith(
                              width: draft.width + 0.1,
                            ),
                          );
                        },
                  onIncrementPlacementDraftHeight: selectedDraftEntry == null
                      ? null
                      : () {
                          _updatePlacementEditorDraft(
                            selectedDraftEntry,
                            (draft) => draft.copyWith(
                              height: draft.height + 0.1,
                            ),
                          );
                        },
                  onResetPlacementDraft: selectedDraftEntry == null
                      ? null
                      : () => _resetPlacementEditorDraft(selectedDraftEntry),
                  onDiscardPlacementDraft: selectedDraftEntry == null
                      ? null
                      : () => _resetPlacementEditorDraft(selectedDraftEntry),
                );
                final controlBand = useWorkbenchShell
                    ? const SizedBox.shrink(
                        key: Key('board_canvas_control_band'))
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
                      contextPanel = _ComponentNavigatorPanel(
                        components: knownFacts.components,
                        entries: allEntries,
                        canvasEntries: visibleEntries,
                        visibleComponentIds: visibleComponentIds,
                        hideUnmeasured: _hideUnmeasuredComponents,
                        measurementCountsByComponentId:
                            measurementCountByComponent,
                        selectedCategory: _componentNavigatorCategory,
                        selection: _canvasSelection,
                        onCategorySelected: (category) {
                          setState(() {
                            _clearCanvasSelection();
                            _componentNavigatorCategory = category;
                            _previewPlacementKeys = const <String>{};
                          });
                        },
                        onBackToCategories: () {
                          setState(() {
                            _clearCanvasSelection();
                            _componentNavigatorCategory = null;
                            _previewPlacementKeys = const <String>{};
                          });
                        },
                        onBackToCategory: () {
                          setState(() {
                            _clearCanvasSelection();
                            _previewPlacementKeys = const <String>{};
                          });
                        },
                        onComponentSelected: (component) {
                          setState(() {
                            _selectComponent(component);
                            _previewPlacementKeys = const <String>{};
                          });
                        },
                        onPlacementSelected: (entry) {
                          setState(() {
                            _selectComponentPlacement(entry);
                            _previewPlacementKeys = const <String>{};
                          });
                        },
                        onPlaceComponent: () {
                          final component =
                              componentsById[_selectedComponentId];
                          if (component != null) {
                            _beginUnplacedComponentPlacement(component);
                          }
                        },
                        onPreviewKeysChanged: _setPreviewPlacementKeys,
                      );
                      break;
                    case _WorkbenchContextPanelMode.measure:
                      contextPanel = _IntegratedMeasurePanel(
                        projectState: projectState,
                        selectedEntry: selectedEntry,
                        relatedMeasurements: relatedMeasurements,
                        relatedVisualTraces: relatedVisualTraces,
                        onContinueToMeasureSheet: () {
                          context.push('/project/measure-sheet');
                        },
                      );
                      break;
                    case _WorkbenchContextPanelMode.addComponentTemplates:
                      final metadataEditComponent =
                          _rightPanelSelectedMetadataComponent(
                        projectState,
                        fallbackComponentId:
                            addComponentTemplatePlacementContextEntry
                                ?.placement.componentId,
                      );
                      _seedRightPanelMetadataEditDraft(metadataEditComponent);
                      final metadataEditBlockReason =
                          _rightPanelMetadataEditBlockReason(
                        projectState,
                        metadataEditComponent,
                      );
                      contextPanel = _AddComponentTemplateListPanel(
                        entries: _kStarterAddComponentTemplates,
                        createComponentId: _rightPanelCreateComponentId,
                        onCreateComponentIdChanged: (value) {
                          setState(() {
                            _rightPanelCreateComponentId = value;
                            _rightPanelCreateComponentStatusMessage = null;
                            _rightPanelCreateComponentErrorMessage = null;
                          });
                        },
                        createComponentLabel: _rightPanelCreateComponentLabel,
                        onCreateComponentLabelChanged: (value) {
                          setState(() {
                            _rightPanelCreateComponentLabel = value;
                            _rightPanelCreateComponentStatusMessage = null;
                            _rightPanelCreateComponentErrorMessage = null;
                          });
                        },
                        createComponentKind: _rightPanelCreateComponentKind,
                        onCreateComponentKindChanged: (value) {
                          setState(() {
                            _rightPanelCreateComponentKind = value;
                            _rightPanelCreateComponentStatusMessage = null;
                            _rightPanelCreateComponentErrorMessage = null;
                          });
                        },
                        createComponentBlockReason:
                            _rightPanelCreateComponentBlockReason(projectState),
                        createComponentStatusMessage:
                            _rightPanelCreateComponentStatusMessage,
                        createComponentErrorMessage:
                            _rightPanelCreateComponentErrorMessage,
                        createComponentInFlight:
                            _rightPanelCreateComponentInFlight,
                        onCreateComponent:
                            _rightPanelCreateComponentBlockReason(
                                          projectState,
                                        ) ==
                                        null &&
                                    !_rightPanelCreateComponentInFlight
                                ? () => _confirmRightPanelComponentCreation(
                                      projectState: projectState,
                                    )
                                : null,
                        metadataEditComponentLabel:
                            metadataEditComponent == null
                                ? null
                                : _componentMetadataEditDisplayLabel(
                                    metadataEditComponent,
                                  ),
                        metadataEditLabel: _rightPanelMetadataEditLabel,
                        onMetadataEditLabelChanged: (value) {
                          setState(() {
                            _rightPanelMetadataEditLabel = value;
                            _rightPanelMetadataEditStatusMessage = null;
                            _rightPanelMetadataEditErrorMessage = null;
                            _rightPanelMetadataEditLastSuccessfulFormKey = null;
                          });
                        },
                        metadataEditKind: _rightPanelMetadataEditKind,
                        onMetadataEditKindChanged: (value) {
                          setState(() {
                            _rightPanelMetadataEditKind =
                                _canonicalRightPanelComponentKind(value);
                            _rightPanelMetadataEditStatusMessage = null;
                            _rightPanelMetadataEditErrorMessage = null;
                            _rightPanelMetadataEditLastSuccessfulFormKey = null;
                          });
                        },
                        metadataEditBlockReason: metadataEditBlockReason,
                        metadataEditStatusMessage:
                            _rightPanelMetadataEditStatusMessage,
                        metadataEditErrorMessage:
                            _rightPanelMetadataEditErrorMessage,
                        metadataEditInFlight: _rightPanelMetadataEditInFlight,
                        onMetadataEdit: metadataEditComponent != null &&
                                metadataEditBlockReason == null &&
                                !_rightPanelMetadataEditInFlight
                            ? () => _confirmRightPanelMetadataEdit(
                                  projectState: projectState,
                                  component: metadataEditComponent,
                                )
                            : null,
                        selectedTemplateId: _selectedAddComponentTemplateId,
                        selectedTemplate: selectedAddComponentTemplate,
                        topContactMarkers:
                            _addComponentTemplateTopContactMarkers,
                        rightContactMarkers:
                            _addComponentTemplateRightContactMarkers,
                        bottomContactMarkers:
                            _addComponentTemplateBottomContactMarkers,
                        leftContactMarkers:
                            _addComponentTemplateLeftContactMarkers,
                        draftWidth: _addComponentTemplateDraftWidth,
                        draftHeight: _addComponentTemplateDraftHeight,
                        draftRotationDeg: _addComponentTemplateDraftRotationDeg,
                        hasZeroContactMarkers:
                            _addComponentTemplateHasZeroMarkers,
                        hasExcessiveContactMarkers:
                            _addComponentTemplateHasExcessiveCounts,
                        onTemplateSelected: (templateId) {
                          _setAddComponentTemplateSelection(
                            templateId,
                            placementContextEntry:
                                addComponentTemplatePlacementContextEntry,
                          );
                        },
                        draftLabel: _addComponentTemplateDraftLabel,
                        onDraftLabelChanged: (value) {
                          setState(() {
                            _addComponentTemplateDraftLabel = value;
                          });
                        },
                        onTopContactMarkersChanged: (value) {
                          setState(() =>
                              _addComponentTemplateTopContactMarkers = value);
                        },
                        onRightContactMarkersChanged: (value) {
                          setState(() =>
                              _addComponentTemplateRightContactMarkers = value);
                        },
                        onBottomContactMarkersChanged: (value) {
                          setState(() =>
                              _addComponentTemplateBottomContactMarkers =
                                  value);
                        },
                        onLeftContactMarkersChanged: (value) {
                          setState(() =>
                              _addComponentTemplateLeftContactMarkers = value);
                        },
                        onDraftWidthChanged: (value) {
                          setState(() {
                            _addComponentTemplateDraftWidth =
                                _clampAddComponentTemplateDraftDimension(value);
                          });
                        },
                        onDraftHeightChanged: (value) {
                          setState(() {
                            _addComponentTemplateDraftHeight =
                                _clampAddComponentTemplateDraftDimension(value);
                          });
                        },
                        onDraftRotationChanged: (value) {
                          setState(() {
                            _addComponentTemplateDraftRotationDeg =
                                _normalizeAddComponentTemplateDraftRotation(
                                    value);
                          });
                        },
                        onChangeTemplateSelection: () {
                          setState(() {
                            _selectedAddComponentTemplateId = null;
                            _addComponentTemplateGhostDraftAnchor = null;
                            _addComponentTemplateGhostDraftCanvasSize = null;
                            _resetAddComponentTemplateLocalDraftScalars();
                          });
                        },
                        onResetToTemplateDefaults:
                            selectedAddComponentTemplate == null
                                ? null
                                : () {
                                    setState(() {
                                      _seedAddComponentTemplateContactCounts(
                                          selectedAddComponentTemplate);
                                      _resetAddComponentTemplateLocalDraftScalars();
                                      _addComponentTemplateGhostDraftAnchor =
                                          null;
                                      _addComponentTemplateGhostDraftCanvasSize =
                                          null;
                                    });
                                  },
                        onConfirmPlacement: canConfirmAddComponentPlacement
                            ? () {
                                _confirmAddComponentTemplatePlacement(
                                  projectState: projectState,
                                  target: placementSaveTarget!,
                                  template: selectedAddComponentTemplate,
                                );
                              }
                            : null,
                        saveBoundaryCopy: _addComponentPlacementSaveInFlight
                            ? 'Salvestamine on pooleli...'
                            : addComponentTemplateSaveBlockReason ??
                                'Salvesta kinnitab ainult valitud olemasoleva komponendi visuaalse paigutuse. Renderer/painter ei kirjuta.',
                        saveContextLabel:
                            addComponentTemplatePlacementContextEntry
                                    ?.selectorLabel ??
                                (placementSaveTarget == null
                                    ? null
                                    : _componentPrimaryLabel(
                                        componentsById[placementSaveTarget
                                                .componentId] ??
                                            ComponentFact(
                                              componentId: placementSaveTarget
                                                  .componentId,
                                            ),
                                      )),
                        saveStatusMessage:
                            _addComponentTemplateSaveStatusMessage,
                      );
                      break;
                    case _WorkbenchContextPanelMode.safetyEvidence:
                      contextPanel = const _BoardCanvasSafetyEvidenceDisclosure(
                        initiallyExpanded: true,
                      );
                      break;
                    case _WorkbenchContextPanelMode.projectNavigation:
                      contextPanel = _ProjectNavigationHub(
                        onNavigate: context.go,
                      );
                      break;
                  }
                  final contextPanelWidth = constraints.maxWidth >= 1180
                      ? _kWideContextPanelWidth
                      : _kMediumContextPanelWidth;
                  final showContextPanel = _inspectorVisible &&
                      !_canvasFocusMode &&
                      contextPanel != null;
                  final contextPanelSlot = contextPanel == null
                      ? null
                      : _contextPanelMode ==
                              _WorkbenchContextPanelMode.addComponentTemplates
                          ? Scrollbar(
                              controller: _addComponentContextScrollController,
                              child: SingleChildScrollView(
                                key: const Key(
                                  'board_canvas_add_component_context_scroll',
                                ),
                                controller:
                                    _addComponentContextScrollController,
                                child: contextPanel,
                              ),
                            )
                          : contextPanel;
                  final measurePanelToggle = _WorkbenchPanelModeButton(
                    buttonKey: const Key('board_canvas_measure_sheet_button'),
                    icon: Icons.science_outlined,
                    tooltip: 'Ava mõõtmise kontekstipaneel',
                    label: 'Mõõtmine',
                    modeKey: 'measure',
                    selected:
                        _contextPanelMode == _WorkbenchContextPanelMode.measure,
                    onPressed: () {
                      setState(() {
                        if (_selectedPlacementKey == null &&
                            visibleEntries.isNotEmpty) {
                          _selectComponentPlacement(visibleEntries.first);
                        }
                        _contextPanelMode = _WorkbenchContextPanelMode.measure;
                        _inspectorVisible = true;
                        _canvasFocusMode = false;
                      });
                    },
                  );
                  final focusPanelToggle = _WorkbenchPanelModeButton(
                    buttonKey: const Key('board_canvas_rail_placements_tool'),
                    icon: Icons.format_list_bulleted_rounded,
                    tooltip: 'Näita komponente parempoolses kontekstipaneelis',
                    label: 'Komponendid',
                    modeKey: 'placements',
                    selected: _contextPanelMode ==
                        _WorkbenchContextPanelMode.placements,
                    onPressed: () {
                      setState(() {
                        _clearCanvasSelection();
                        _componentNavigatorCategory = null;
                        _contextPanelMode =
                            _WorkbenchContextPanelMode.placements;
                        _inspectorVisible = true;
                      });
                    },
                  );
                  final addComponentPanelToggle = _WorkbenchPanelModeButton(
                    buttonKey:
                        const Key('board_canvas_rail_add_component_tool'),
                    icon: Icons.add_box_outlined,
                    tooltip: 'Ava komponendi lisamise malliloend',
                    label: 'Lisa',
                    semanticLabel: 'Visuaalse paigutuse Lisa',
                    modeKey: 'add_component',
                    selected: _contextPanelMode ==
                        _WorkbenchContextPanelMode.addComponentTemplates,
                    onPressed: () {
                      final placementContextEntry = selectedEntry;
                      setState(() {
                        if (placementContextEntry != null) {
                          _seedAddComponentTemplateDraftFromPlacement(
                              placementContextEntry);
                        } else if (_canvasSelection is ComponentSelection) {
                          _clearCanvasSelection();
                        }
                        _contextPanelMode =
                            _WorkbenchContextPanelMode.addComponentTemplates;
                        _inspectorVisible = true;
                      });
                    },
                  );
                  final safetyPanelToggle = _WorkbenchPanelModeButton(
                    buttonKey:
                        const Key('board_canvas_rail_safety_evidence_tool'),
                    icon: Icons.shield_outlined,
                    tooltip: 'Näita ohutuse/tõendite kirjutuskaitstud detaile',
                    label: 'Ohutus',
                    modeKey: 'safety',
                    selected: _contextPanelMode ==
                        _WorkbenchContextPanelMode.safetyEvidence,
                    onPressed: () {
                      setState(() {
                        _clearCanvasSelection();
                        _contextPanelMode =
                            _WorkbenchContextPanelMode.safetyEvidence;
                        _inspectorVisible = true;
                      });
                    },
                  );
                  final inspectorPanelToggle = _WorkbenchPanelModeButton(
                    buttonKey: const Key('board_canvas_rail_inspector_tool'),
                    icon: Icons.info_outline,
                    tooltip: 'Näita inspektori kontekstipaneeli',
                    label: 'Inspektor',
                    modeKey: 'inspector',
                    selected: _contextPanelMode ==
                        _WorkbenchContextPanelMode.inspector,
                    onPressed: () {
                      setState(() {
                        _contextPanelMode =
                            _WorkbenchContextPanelMode.inspector;
                        _inspectorVisible = true;
                      });
                    },
                  );
                  final projectPanelToggle = _WorkbenchPanelModeButton(
                    buttonKey: const Key('board_canvas_rail_project_tool'),
                    icon: Icons.folder_open_outlined,
                    tooltip: 'Ava projekti navigatsioon',
                    label: 'Projekt',
                    modeKey: 'project',
                    selected: _contextPanelMode ==
                        _WorkbenchContextPanelMode.projectNavigation,
                    onPressed: () {
                      setState(() {
                        _contextPanelMode =
                            _WorkbenchContextPanelMode.projectNavigation;
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
                          projectTool: projectPanelToggle,
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
                          child: DecoratedBox(
                            key: const Key(
                              'board_canvas_context_panel_frame',
                            ),
                            decoration: BoxDecoration(
                              color: _kBoardCanvasPaper,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: _kBoardCanvasRuleStrong,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x33000000),
                                  blurRadius: 14,
                                  offset: Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const _WorkbenchBoundaryNotice(),
                                  const SizedBox(height: 8),
                                  Flexible(child: contextPanelSlot!),
                                ],
                              ),
                            ),
                          ),
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
        _clearCanvasSelection();
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
      _clearCanvasSelection();
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
            color: _kBoardCanvasNavy,
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
                  color: _kBoardCanvasReadyTint,
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    color: _kBoardCanvasReady.withValues(alpha: 0.54),
                  ),
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 222),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: _kBoardCanvasReady,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          'Renderdus loeb · Salvesta võib kirjutada',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: _kBoardCanvasNavy,
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
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                  color: _kBoardCanvasMuted,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: _kBoardCanvasReady,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 7),
                    const Text(
                      'Valmis',
                      style: TextStyle(color: _kBoardCanvasReady),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      flex: 2,
                      child: Center(
                        child: Text(
                          'renderer/painter writes: none',
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
      color: _kBoardCanvasTile,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: _kBoardCanvasRule),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 220),
        child: DefaultTextStyle.merge(
          style: theme.textTheme.bodySmall?.copyWith(
            color: _kBoardCanvasMuted,
          ),
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
                  (alignment) =>
                      _PhotoAlignmentSummaryTile(alignment: alignment),
                ),
              ],
            ),
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
    required this.projectTool,
    required this.safetyEvidenceTool,
  });

  final Widget addComponentTool;
  final Widget inspectorTool;
  final Widget measureSheetTool;
  final Widget placementTool;
  final Widget projectTool;
  final Widget safetyEvidenceTool;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: const Key('board_canvas_workbench_rail'),
      width: _kWorkbenchRailWidth,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: _kBoardCanvasNavyDeep,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: _kBoardCanvasRuleStrong.withValues(alpha: 0.72),
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x3D080B0F),
              blurRadius: 12,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Padding(
          padding: _kWorkbenchRailPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _WorkbenchSectionHeader(label: 'Paneelid'),
              const SizedBox(height: _kWorkbenchToolTileGap),
              measureSheetTool,
              const SizedBox(height: _kWorkbenchToolTileGap),
              addComponentTool,
              const SizedBox(height: _kWorkbenchToolTileGap),
              inspectorTool,
              const SizedBox(height: _kWorkbenchToolTileGap),
              placementTool,
              const SizedBox(height: _kWorkbenchToolTileGap),
              projectTool,
              const SizedBox(height: _kWorkbenchToolTileGap),
              safetyEvidenceTool,
              const SizedBox(height: 6),
              const Divider(
                height: 1,
                thickness: 1,
                color: _kBoardCanvasRule,
              ),
              const SizedBox(height: 6),
              const _WorkbenchSectionHeader(
                label: 'Tulekul',
                semanticLabel: 'Tulevased tööriistad',
              ),
              const SizedBox(height: 4),
              const _InactiveRailToolButton(
                buttonKey: Key('board_canvas_rail_future_trace_tool'),
                icon: Icons.timeline,
                tooltip: 'Rajakaart (tulekul/ainult vaatamine) - passiivne',
                label: 'Rajad',
                semanticLabel: 'Rajakaart',
                showLabel: true,
              ),
              const SizedBox(height: _kWorkbenchToolTileGap),
              const _InactiveRailToolButton(
                buttonKey: Key('board_canvas_rail_future_repair_map_tool'),
                icon: Icons.map_outlined,
                tooltip: 'Paranduskaart (tulekul) - passiivne',
                label: 'Parandus',
                semanticLabel: 'Paranduskaart',
                showLabel: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProjectNavigationHub extends StatelessWidget {
  const _ProjectNavigationHub({required this.onNavigate});

  final ValueChanged<String> onNavigate;

  Widget _action({
    required Key key,
    required IconData icon,
    required String label,
    required String location,
  }) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        key: key,
        style: _benchBeepNavigatorControlStyle(filled: false),
        onPressed: () => onNavigate(location),
        icon: Icon(icon, size: _kWorkbenchRailContentIconSize),
        label: Text(label),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView(
      key: const Key('board_canvas_project_navigation_hub'),
      padding: EdgeInsets.zero,
      children: [
        Text(
          'Projekt',
          style: theme.textTheme.titleMedium?.copyWith(
            color: _kBoardCanvasNavy,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Ava projektiga seotud vaated. Navigeerimine ei kirjuta projekti.',
          style: theme.textTheme.bodySmall?.copyWith(
            color: _kBoardCanvasMuted,
          ),
        ),
        const SizedBox(height: 10),
        _action(
          key: const Key('board_canvas_project_home_action'),
          icon: Icons.home_outlined,
          label: 'BenchBeep Home',
          location: '/',
        ),
        const SizedBox(height: 6),
        _action(
          key: const Key('board_canvas_project_photos_action'),
          icon: Icons.photo_camera_back_outlined,
          label: 'Foto tõendid',
          location: '/project/photos',
        ),
        const SizedBox(height: 6),
        _action(
          key: const Key('board_canvas_project_reference_images_action'),
          icon: Icons.image_outlined,
          label: 'Viitepildid',
          location: '/project/reference-images',
        ),
        const SizedBox(height: 6),
        _action(
          key: const Key('board_canvas_project_graph_action'),
          icon: Icons.account_tree_outlined,
          label: 'Advanced graph',
          location: '/project/graph',
        ),
        const SizedBox(height: 6),
        _action(
          key: const Key('board_canvas_project_events_action'),
          icon: Icons.history_outlined,
          label: 'Sündmused',
          location: '/project/events',
        ),
        const SizedBox(height: 6),
        _action(
          key: const Key('board_canvas_project_known_facts_action'),
          icon: Icons.fact_check_outlined,
          label: 'Teadaolevad faktid',
          location: '/project/known-facts',
        ),
        const SizedBox(height: 6),
        _action(
          key: const Key('board_canvas_project_report_action'),
          icon: Icons.description_outlined,
          label: 'Raport',
          location: '/project/report',
        ),
      ],
    );
  }
}

class _WorkbenchBoundaryNotice extends StatelessWidget {
  const _WorkbenchBoundaryNotice();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Semantics(
      label: 'Inimese kinnituse piir',
      child: Container(
        key: const Key('board_canvas_human_confirmation_boundary'),
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 7),
        decoration: BoxDecoration(
          color: _kBoardCanvasNavyDeep,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _kBoardCanvasRuleStrong),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 1),
              child: Icon(
                Icons.verified_user_outlined,
                size: 15,
                color: _kBoardCanvasSignal,
              ),
            ),
            const SizedBox(width: 7),
            Expanded(
              child: Text(
                'AI/foto/rada ei ole fakt enne kinnitamist.',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: _kBoardCanvasNavy,
                  fontWeight: FontWeight.w700,
                  height: 1.25,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MeasureSheetNavigationButton extends StatelessWidget {
  const _MeasureSheetNavigationButton({
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color: _kBoardCanvasTile,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: _kBoardCanvasRule),
      ),
      child: SizedBox(
        width: _kCompactControlTileHeight,
        height: _kCompactControlTileHeight,
        child: IconButton(
          key: const Key('board_canvas_measure_sheet_button'),
          tooltip: 'Ava mõõteleht',
          iconSize: _kWorkbenchRailContentIconSize,
          style: IconButton.styleFrom(
            minimumSize: const Size.square(_kCompactControlTileHeight),
            padding: EdgeInsets.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            foregroundColor: _kBoardCanvasMuted,
          ),
          icon: const Icon(Icons.science_outlined),
          onPressed: onPressed,
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
    required this.modeKey,
    required this.onPressed,
    this.semanticLabel,
  });

  final Key buttonKey;
  final IconData icon;
  final String tooltip;
  final String label;
  final String? semanticLabel;
  final bool selected;
  final String modeKey;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tileColor = selected ? _kBoardCanvasSignalTint : _kBoardCanvasTile;
    final borderColor =
        selected ? _kBoardCanvasSignal : _kBoardCanvasRuleStrong;
    final labelStyle = theme.textTheme.labelSmall?.copyWith(
      fontWeight: selected ? FontWeight.w700 : FontWeight.normal,
      color: selected ? _kBoardCanvasSignal : _kBoardCanvasMuted,
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
          label: '${semanticLabel ?? label} panel mode',
          hint: tooltipText,
          child: Align(
            alignment: Alignment.center,
            child: Container(
              key: Key('board_canvas_rail_${modeKey}_tile'),
              width: _kCompactControlTileHeight,
              height: _kCompactControlTileHeight,
              decoration: BoxDecoration(
                color: tileColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: borderColor,
                  width: selected ? 1.4 : 1,
                ),
                boxShadow: selected
                    ? [
                        BoxShadow(
                          color: _kBoardCanvasSignal.withValues(alpha: 0.26),
                          blurRadius: 10,
                          spreadRadius: 0.6,
                        ),
                      ]
                    : const [],
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
  const _WorkbenchSectionHeader({required this.label, this.semanticLabel});

  final String label;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final fullLabel = semanticLabel ?? label;
    return Tooltip(
      message: fullLabel,
      child: Semantics(
        label: fullLabel,
        child: ExcludeSemantics(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(2, 0, 2, 2),
            child: Container(
              height: 1,
              color: _kBoardCanvasRuleStrong.withValues(alpha: 0.55),
            ),
          ),
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
    this.semanticLabel,
    this.showLabel = false,
  });

  final Key buttonKey;
  final IconData icon;
  final String tooltip;
  final String? label;
  final String? semanticLabel;
  final bool showLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final button = Container(
      width: _kCompactControlTileHeight,
      height: _kCompactControlTileHeight,
      decoration: BoxDecoration(
        color: _kBoardCanvasNavyDeep,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: _kBoardCanvasRuleStrong.withValues(alpha: 0.65),
        ),
      ),
      child: IconButton(
        key: buttonKey,
        tooltip: tooltip,
        iconSize: _kCompactControlIconSize,
        style: IconButton.styleFrom(
          minimumSize: const Size.square(_kCompactControlTileHeight),
          padding: EdgeInsets.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          foregroundColor: _kBoardCanvasMuted,
          disabledForegroundColor: _kBoardCanvasDim,
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
        Semantics(
          label: semanticLabel ?? label!,
          hint: tooltip,
          enabled: false,
          child: ExcludeSemantics(
            child: Text(
              label!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: theme.textTheme.labelSmall?.copyWith(
                color: _kBoardCanvasDim,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
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
            style: theme.textTheme.labelLarge?.copyWith(
              color: _kBoardCanvasNavy,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: 6),
        Flexible(
          flex: 3,
          child: Text(
            detail,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodySmall?.copyWith(
              color: _kBoardCanvasMuted,
            ),
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
      color: _kBoardCanvasTile,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: _kBoardCanvasRule),
      ),
      child: SizedBox(
        width: _kCompactControlTileHeight,
        height: _kCompactControlTileHeight,
        child: IconButton(
          key: const Key('board_canvas_focus_toggle_button'),
          tooltip: 'Fookusta plaat',
          iconSize: _kWorkbenchRailContentIconSize,
          style: IconButton.styleFrom(
            minimumSize: const Size.square(_kCompactControlTileHeight),
            padding: EdgeInsets.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            foregroundColor: _kBoardCanvasMuted,
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
          'Fookusta plaat',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: theme.textTheme.labelSmall?.copyWith(
            color: _kBoardCanvasMuted,
          ),
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
      color: _kBoardCanvasTile,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: _kBoardCanvasRule),
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
            foregroundColor: _kBoardCanvasMuted,
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
          style: theme.textTheme.labelSmall?.copyWith(
            color: _kBoardCanvasMuted,
          ),
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
      color: _kBoardCanvasTile,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: _kBoardCanvasRule),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          children: [
            const Icon(
              Icons.fullscreen_exit,
              size: _kCompactControlIconSize,
              color: _kBoardCanvasMuted,
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                'Canvas focus mode. Controls and read-only details are recoverable.',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: _kBoardCanvasMuted,
                ),
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
    required this.createComponentId,
    required this.onCreateComponentIdChanged,
    required this.createComponentLabel,
    required this.onCreateComponentLabelChanged,
    required this.createComponentKind,
    required this.onCreateComponentKindChanged,
    required this.createComponentBlockReason,
    required this.createComponentStatusMessage,
    required this.createComponentErrorMessage,
    required this.createComponentInFlight,
    required this.onCreateComponent,
    required this.metadataEditComponentLabel,
    required this.metadataEditLabel,
    required this.onMetadataEditLabelChanged,
    required this.metadataEditKind,
    required this.onMetadataEditKindChanged,
    required this.metadataEditBlockReason,
    required this.metadataEditStatusMessage,
    required this.metadataEditErrorMessage,
    required this.metadataEditInFlight,
    required this.onMetadataEdit,
    required this.selectedTemplateId,
    required this.onTemplateSelected,
    required this.selectedTemplate,
    required this.topContactMarkers,
    required this.rightContactMarkers,
    required this.bottomContactMarkers,
    required this.leftContactMarkers,
    required this.draftWidth,
    required this.draftHeight,
    required this.draftRotationDeg,
    required this.hasZeroContactMarkers,
    required this.hasExcessiveContactMarkers,
    required this.onTopContactMarkersChanged,
    required this.onRightContactMarkersChanged,
    required this.onBottomContactMarkersChanged,
    required this.onLeftContactMarkersChanged,
    required this.onDraftWidthChanged,
    required this.onDraftHeightChanged,
    required this.onDraftRotationChanged,
    required this.onChangeTemplateSelection,
    required this.draftLabel,
    required this.onDraftLabelChanged,
    required this.onConfirmPlacement,
    this.saveBoundaryCopy =
        'Salvesta kinnitab ainult valitud olemasoleva komponendi visuaalse paigutuse. Renderer/painter ei kirjuta.',
    this.saveContextLabel,
    this.saveStatusMessage,
    this.onResetToTemplateDefaults,
  });

  final List<_AddComponentTemplateDefinition> entries;
  final String createComponentId;
  final ValueChanged<String> onCreateComponentIdChanged;
  final String createComponentLabel;
  final ValueChanged<String> onCreateComponentLabelChanged;
  final String? createComponentKind;
  final ValueChanged<String?> onCreateComponentKindChanged;
  final String? createComponentBlockReason;
  final String? createComponentStatusMessage;
  final String? createComponentErrorMessage;
  final bool createComponentInFlight;
  final VoidCallback? onCreateComponent;
  final String? metadataEditComponentLabel;
  final String metadataEditLabel;
  final ValueChanged<String> onMetadataEditLabelChanged;
  final String metadataEditKind;
  final ValueChanged<String?> onMetadataEditKindChanged;
  final String? metadataEditBlockReason;
  final String? metadataEditStatusMessage;
  final String? metadataEditErrorMessage;
  final bool metadataEditInFlight;
  final VoidCallback? onMetadataEdit;
  final String? selectedTemplateId;
  final ValueChanged<String> onTemplateSelected;
  final _AddComponentTemplateDefinition? selectedTemplate;
  final int topContactMarkers;
  final int rightContactMarkers;
  final int bottomContactMarkers;
  final int leftContactMarkers;
  final double draftWidth;
  final double draftHeight;
  final int draftRotationDeg;
  final bool hasZeroContactMarkers;
  final bool hasExcessiveContactMarkers;
  final ValueChanged<int> onTopContactMarkersChanged;
  final ValueChanged<int> onRightContactMarkersChanged;
  final ValueChanged<int> onBottomContactMarkersChanged;
  final ValueChanged<int> onLeftContactMarkersChanged;
  final ValueChanged<double> onDraftWidthChanged;
  final ValueChanged<double> onDraftHeightChanged;
  final ValueChanged<int> onDraftRotationChanged;
  final VoidCallback onChangeTemplateSelection;
  final String draftLabel;
  final ValueChanged<String> onDraftLabelChanged;
  final VoidCallback? onConfirmPlacement;
  final String saveBoundaryCopy;
  final String? saveContextLabel;
  final String? saveStatusMessage;
  final VoidCallback? onResetToTemplateDefaults;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
        initiallyExpanded: true,
        maintainState: true,
        dense: true,
        visualDensity: VisualDensity.compact,
        minTileHeight: _kCompactControlTileHeight,
        tilePadding: _kCompactControlTilePadding,
        childrenPadding: _kCompactControlChildrenPadding,
        title: _CompactDisclosureTitle(
          label: 'Lisa visuaalne paigutus',
          detail: selectedTemplate == null
              ? 'Visuaalsed algmallid'
              : 'Aktiivne mall',
        ),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              _RightPanelComponentCreationSection(
                componentId: createComponentId,
                onComponentIdChanged: onCreateComponentIdChanged,
                label: createComponentLabel,
                onLabelChanged: onCreateComponentLabelChanged,
                componentKind: createComponentKind,
                onComponentKindChanged: onCreateComponentKindChanged,
                blockReason: createComponentBlockReason,
                statusMessage: createComponentStatusMessage,
                errorMessage: createComponentErrorMessage,
                inFlight: createComponentInFlight,
                onCreateComponent: onCreateComponent,
              ),
              const SizedBox(height: 10),
              const Divider(color: _kBoardCanvasRule, height: 1),
              const SizedBox(height: 8),
              if (selectedTemplate == null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(2, 0, 2, 6),
                      child: Text(
                        'Vali kuju',
                        key: const Key(
                          'board_canvas_add_component_template_picker_label',
                        ),
                        textAlign: TextAlign.center,
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
                const SizedBox(height: 6),
                TextFormField(
                  key: const Key(
                    'board_canvas_add_component_template_draft_label_input',
                  ),
                  initialValue: draftLabel,
                  decoration: InputDecoration(
                    isDense: true,
                    labelText: 'Draft label',
                    hintText: 'e.g. AGH789',
                    labelStyle: theme.textTheme.labelSmall?.copyWith(
                      color: _kBoardCanvasMuted,
                    ),
                    hintStyle: theme.textTheme.bodySmall?.copyWith(
                      color: _kBoardCanvasDim,
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: _kBoardCanvasRule),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: _kBoardCanvasSignal),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 6,
                    ),
                  ),
                  maxLength: 16,
                  onChanged: onDraftLabelChanged,
                  textAlign: TextAlign.left,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: _kBoardCanvasNavy,
                  ),
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
                  draftWidth: draftWidth,
                  draftHeight: draftHeight,
                  draftRotationDeg: draftRotationDeg,
                  hasZeroContactMarkers: hasZeroContactMarkers,
                  hasExcessiveContactMarkers: hasExcessiveContactMarkers,
                  onTopChanged: onTopContactMarkersChanged,
                  onRightChanged: onRightContactMarkersChanged,
                  onBottomChanged: onBottomContactMarkersChanged,
                  onLeftChanged: onLeftContactMarkersChanged,
                  onDraftWidthChanged: onDraftWidthChanged,
                  onDraftHeightChanged: onDraftHeightChanged,
                  onDraftRotationChanged: onDraftRotationChanged,
                  onResetToDefaults: onResetToTemplateDefaults,
                  onConfirmPlacement: onConfirmPlacement,
                  saveBoundaryCopy: saveBoundaryCopy,
                  saveContextLabel: saveContextLabel,
                  saveStatusMessage: saveStatusMessage,
                ),
              ],
              const SizedBox(height: 10),
              const Divider(color: _kBoardCanvasRule, height: 1),
              const SizedBox(height: 8),
              _RightPanelMetadataEditSection(
                selectedComponentLabel: metadataEditComponentLabel,
                label: metadataEditLabel,
                onLabelChanged: onMetadataEditLabelChanged,
                componentKind: metadataEditKind,
                onComponentKindChanged: onMetadataEditKindChanged,
                blockReason: metadataEditBlockReason,
                statusMessage: metadataEditStatusMessage,
                errorMessage: metadataEditErrorMessage,
                inFlight: metadataEditInFlight,
                onSave: onMetadataEdit,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RightPanelComponentCreationSection extends StatelessWidget {
  const _RightPanelComponentCreationSection({
    required this.componentId,
    required this.onComponentIdChanged,
    required this.label,
    required this.onLabelChanged,
    required this.componentKind,
    required this.onComponentKindChanged,
    required this.blockReason,
    required this.statusMessage,
    required this.errorMessage,
    required this.inFlight,
    required this.onCreateComponent,
  });

  static const List<String> _componentKinds = <String>[
    'unknown',
    'passive',
    'ic',
    'connector',
    'regulator',
  ];
  static const Map<String, String> _componentKindLabels = <String, String>{
    'unknown': 'Generic / unclassified',
    'passive': 'Resistor / capacitor / diode / passive',
    'ic': 'IC dual-side / quad-side / dense grid',
    'connector': 'Connector / header',
    'regulator': 'Regulator / relay / module',
  };

  final String componentId;
  final ValueChanged<String> onComponentIdChanged;
  final String label;
  final ValueChanged<String> onLabelChanged;
  final String? componentKind;
  final ValueChanged<String?> onComponentKindChanged;
  final String? blockReason;
  final String? statusMessage;
  final String? errorMessage;
  final bool inFlight;
  final VoidCallback? onCreateComponent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DecoratedBox(
      key: const Key('board_canvas_create_component_section'),
      decoration: BoxDecoration(
        color: _kBoardCanvasTile,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _kBoardCanvasRule),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Loo komponent',
              key: const Key('board_canvas_create_component_title'),
              style: theme.textTheme.titleSmall?.copyWith(
                color: _kBoardCanvasNavy,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              'Sündmus: component_created',
              key: const Key('board_canvas_create_component_event_type'),
              style: theme.textTheme.labelSmall?.copyWith(
                color: _kBoardCanvasSignal,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Loob komponendi identiteedi projekti faktidesse. Ei paiguta komponenti plaadile ega loo kontakte, võrke või mõõtmisi.',
              key: const Key('board_canvas_create_component_boundary_copy'),
              style: theme.textTheme.labelSmall?.copyWith(
                color: _kBoardCanvasMuted,
                height: 1.25,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              key: const Key('board_canvas_create_component_id_input'),
              initialValue: componentId,
              decoration: _compactInputDecoration(
                theme: theme,
                labelText: 'Koht / ID',
                hintText: 'nt R102',
              ),
              onChanged: onComponentIdChanged,
              style: theme.textTheme.bodySmall?.copyWith(
                color: _kBoardCanvasNavy,
              ),
            ),
            const SizedBox(height: 6),
            TextFormField(
              key: const Key('board_canvas_create_component_label_input'),
              initialValue: label,
              decoration: _compactInputDecoration(
                theme: theme,
                labelText: 'Nimi',
                hintText: 'nt Pull-up resistor',
              ),
              onChanged: onLabelChanged,
              style: theme.textTheme.bodySmall?.copyWith(
                color: _kBoardCanvasNavy,
              ),
            ),
            const SizedBox(height: 6),
            DropdownButtonFormField<String>(
              key: const Key('board_canvas_create_component_kind_dropdown'),
              initialValue: componentKind,
              isExpanded: true,
              dropdownColor: _kBoardCanvasPaper,
              decoration: _compactInputDecoration(
                theme: theme,
                labelText: 'Liik',
                hintText: 'Vali liik',
              ),
              iconEnabledColor: _kBoardCanvasSignal,
              style: theme.textTheme.bodySmall?.copyWith(
                color: _kBoardCanvasNavy,
              ),
              items: _componentKinds
                  .map(
                    (kind) => DropdownMenuItem<String>(
                      value: kind,
                      child: Text(
                        _componentKindLabels[kind] ?? kind,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  )
                  .toList(growable: false),
              selectedItemBuilder: (context) => _componentKinds
                  .map(
                    (kind) => Text(
                      _componentKindLabels[kind] ?? kind,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: _kBoardCanvasNavy,
                      ),
                    ),
                  )
                  .toList(growable: false),
              onChanged: inFlight ? null : onComponentKindChanged,
            ),
            const SizedBox(height: 8),
            if (blockReason != null)
              Text(
                blockReason!,
                key: const Key('board_canvas_create_component_guard'),
                style: theme.textTheme.labelSmall?.copyWith(
                  color: const Color(0xFFF6C453),
                  fontWeight: FontWeight.w700,
                ),
              ),
            if (errorMessage != null)
              Text(
                errorMessage!,
                key: const Key('board_canvas_create_component_error'),
                style: theme.textTheme.labelSmall?.copyWith(
                  color: const Color(0xFFEAA6A6),
                  fontWeight: FontWeight.w700,
                ),
              ),
            if (statusMessage != null)
              Text(
                statusMessage!,
                key: const Key('board_canvas_create_component_status'),
                style: theme.textTheme.labelSmall?.copyWith(
                  color: _kBoardCanvasSignal,
                  fontWeight: FontWeight.w800,
                ),
              ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.center,
              child: _AddComponentDraftChipButton(
                key: const Key('board_canvas_create_component_save'),
                label: inFlight ? 'Salvestan...' : 'Loo komponent',
                onPressed: onCreateComponent,
                minWidth: 132,
                minHeight: 38,
                foregroundColor: _kBoardCanvasSignal,
                backgroundColor: _kBoardCanvasSignalTint,
                borderColor: _kBoardCanvasSignal.withValues(alpha: 0.7),
                disabledForegroundColor: _kBoardCanvasMuted,
                disabledBackgroundColor: _kBoardCanvasPaper,
                disabledBorderColor: _kBoardCanvasRuleStrong,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static InputDecoration _compactInputDecoration({
    required ThemeData theme,
    required String labelText,
    required String hintText,
  }) {
    return InputDecoration(
      isDense: true,
      labelText: labelText,
      hintText: hintText,
      labelStyle: theme.textTheme.labelSmall?.copyWith(
        color: _kBoardCanvasMuted,
      ),
      hintStyle: theme.textTheme.bodySmall?.copyWith(
        color: _kBoardCanvasDim,
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: _kBoardCanvasRule),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: _kBoardCanvasSignal),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 7,
      ),
    );
  }
}

class _RightPanelMetadataEditSection extends StatelessWidget {
  const _RightPanelMetadataEditSection({
    required this.selectedComponentLabel,
    required this.label,
    required this.onLabelChanged,
    required this.componentKind,
    required this.onComponentKindChanged,
    required this.blockReason,
    required this.statusMessage,
    required this.errorMessage,
    required this.inFlight,
    required this.onSave,
  });

  final String? selectedComponentLabel;
  final String label;
  final ValueChanged<String> onLabelChanged;
  final String componentKind;
  final ValueChanged<String?> onComponentKindChanged;
  final String? blockReason;
  final String? statusMessage;
  final String? errorMessage;
  final bool inFlight;
  final VoidCallback? onSave;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasSelectedComponent = selectedComponentLabel != null;
    return DecoratedBox(
      key: const Key('board_canvas_metadata_edit_section'),
      decoration: BoxDecoration(
        color: _kBoardCanvasTile,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _kBoardCanvasRule),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Muuda andmeid',
              key: const Key('board_canvas_metadata_edit_title'),
              style: theme.textTheme.titleSmall?.copyWith(
                color: _kBoardCanvasNavy,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              'Sündmus: component_updated',
              key: const Key('board_canvas_metadata_edit_event_type'),
              style: theme.textTheme.labelSmall?.copyWith(
                color: _kBoardCanvasSignal,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Muudab ainult valitud olemasoleva komponendi nime või liiki. Ei loo identiteeti, paigutust, kontakte, võrke ega mõõtmisi.',
              key: const Key('board_canvas_metadata_edit_boundary_copy'),
              style: theme.textTheme.labelSmall?.copyWith(
                color: _kBoardCanvasMuted,
                height: 1.25,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              hasSelectedComponent
                  ? 'Metaandmete komponent: $selectedComponentLabel'
                  : 'Metaandmete komponent: puudub',
              key: const Key('board_canvas_metadata_edit_selected_component'),
              style: theme.textTheme.labelSmall?.copyWith(
                color:
                    hasSelectedComponent ? _kBoardCanvasNavy : _kBoardCanvasDim,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            KeyedSubtree(
              key: const Key('board_canvas_metadata_edit_label_input'),
              child: TextFormField(
                key: ValueKey(
                  'board_canvas_metadata_edit_label_input_${selectedComponentLabel ?? 'none'}',
                ),
                initialValue: label,
                enabled: hasSelectedComponent && !inFlight,
                decoration:
                    _RightPanelComponentCreationSection._compactInputDecoration(
                  theme: theme,
                  labelText: 'Nimi',
                  hintText: 'nt R101',
                ),
                onChanged: onLabelChanged,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: _kBoardCanvasNavy,
                ),
              ),
            ),
            const SizedBox(height: 6),
            DropdownButtonFormField<String>(
              key: const Key('board_canvas_metadata_edit_kind_dropdown'),
              initialValue: _RightPanelComponentCreationSection._componentKinds
                      .contains(componentKind)
                  ? componentKind
                  : 'unknown',
              isExpanded: true,
              dropdownColor: _kBoardCanvasPaper,
              decoration:
                  _RightPanelComponentCreationSection._compactInputDecoration(
                theme: theme,
                labelText: 'Liik',
                hintText: 'Vali liik',
              ),
              iconEnabledColor: _kBoardCanvasSignal,
              style: theme.textTheme.bodySmall?.copyWith(
                color: _kBoardCanvasNavy,
              ),
              items: _RightPanelComponentCreationSection._componentKinds
                  .map(
                    (kind) => DropdownMenuItem<String>(
                      value: kind,
                      child: Text(
                        _RightPanelComponentCreationSection
                                ._componentKindLabels[kind] ??
                            kind,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  )
                  .toList(growable: false),
              selectedItemBuilder: (context) =>
                  _RightPanelComponentCreationSection._componentKinds
                      .map(
                        (kind) => Text(
                          _RightPanelComponentCreationSection
                                  ._componentKindLabels[kind] ??
                              kind,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: _kBoardCanvasNavy,
                          ),
                        ),
                      )
                      .toList(growable: false),
              onChanged: hasSelectedComponent && !inFlight
                  ? onComponentKindChanged
                  : null,
            ),
            const SizedBox(height: 8),
            if (blockReason != null)
              Text(
                blockReason!,
                key: const Key('board_canvas_metadata_edit_guard'),
                style: theme.textTheme.labelSmall?.copyWith(
                  color: const Color(0xFFF6C453),
                  fontWeight: FontWeight.w700,
                ),
              ),
            if (errorMessage != null)
              Text(
                errorMessage!,
                key: const Key('board_canvas_metadata_edit_error'),
                style: theme.textTheme.labelSmall?.copyWith(
                  color: const Color(0xFFEAA6A6),
                  fontWeight: FontWeight.w700,
                ),
              ),
            if (statusMessage != null)
              Text(
                statusMessage!,
                key: const Key('board_canvas_metadata_edit_status'),
                style: theme.textTheme.labelSmall?.copyWith(
                  color: _kBoardCanvasSignal,
                  fontWeight: FontWeight.w800,
                ),
              ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.center,
              child: _AddComponentDraftChipButton(
                key: const Key('board_canvas_metadata_edit_save'),
                label: inFlight ? 'Salvestan...' : 'Salvesta muudatused',
                onPressed: onSave,
                minWidth: 158,
                minHeight: 38,
                foregroundColor: const Color(0xFFF6C453),
                backgroundColor: const Color(0xFF33270F),
                borderColor: const Color(0xFFF6C453).withValues(alpha: 0.7),
                disabledForegroundColor: _kBoardCanvasMuted,
                disabledBackgroundColor: _kBoardCanvasPaper,
                disabledBorderColor: _kBoardCanvasRuleStrong,
              ),
            ),
          ],
        ),
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
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: _kBoardCanvasTile,
        border: Border.all(color: _kBoardCanvasRule),
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
                    color: _kBoardCanvasNavy,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  template.contactMarkerSummaryShort,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: _kBoardCanvasMuted,
                  ),
                ),
                const SizedBox(height: 2),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 1,
                  ),
                  decoration: BoxDecoration(
                    color: _kBoardCanvasSignalTint,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: _kBoardCanvasRule),
                  ),
                  child: Text(
                    'Mustand',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: _kBoardCanvasSignal,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
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
              foregroundColor: _kBoardCanvasMuted,
            ),
            child: const Text('Muuda kuju'),
          ),
          const SizedBox(width: 2),
          Icon(
            Icons.check_circle_rounded,
            size: 16,
            color: _kBoardCanvasSignal,
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
    required this.draftWidth,
    required this.draftHeight,
    required this.draftRotationDeg,
    required this.hasZeroContactMarkers,
    required this.hasExcessiveContactMarkers,
    required this.onTopChanged,
    required this.onRightChanged,
    required this.onBottomChanged,
    required this.onLeftChanged,
    required this.onDraftWidthChanged,
    required this.onDraftHeightChanged,
    required this.onDraftRotationChanged,
    required this.onConfirmPlacement,
    required this.saveBoundaryCopy,
    this.saveContextLabel,
    this.saveStatusMessage,
    this.onResetToDefaults,
  });

  final _AddComponentTemplateDefinition template;
  final int topContactMarkers;
  final int rightContactMarkers;
  final int bottomContactMarkers;
  final int leftContactMarkers;
  final double draftWidth;
  final double draftHeight;
  final int draftRotationDeg;
  final bool hasZeroContactMarkers;
  final bool hasExcessiveContactMarkers;
  final ValueChanged<int> onTopChanged;
  final ValueChanged<int> onRightChanged;
  final ValueChanged<int> onBottomChanged;
  final ValueChanged<int> onLeftChanged;
  final ValueChanged<double> onDraftWidthChanged;
  final ValueChanged<double> onDraftHeightChanged;
  final ValueChanged<int> onDraftRotationChanged;
  final VoidCallback? onConfirmPlacement;
  final String saveBoundaryCopy;
  final String? saveContextLabel;
  final String? saveStatusMessage;
  final VoidCallback? onResetToDefaults;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      key: const Key('board_canvas_add_component_builder_card'),
      margin: EdgeInsets.zero,
      color: _kBoardCanvasTile,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: _kBoardCanvasRule),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pin-asetus',
              key: const Key(
                'board_canvas_add_component_builder_pin_layout_heading',
              ),
              style: theme.textTheme.labelSmall?.copyWith(
                color: _kBoardCanvasSignal,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'UI-local marker draft',
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: _kBoardCanvasNavy,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  'UI-local markers',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: _kBoardCanvasMuted,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Text(
              'Kontaktid on lokaalne mustand; neid ei kinnitata elektriliste kontaktidena.',
              key: const Key(
                'board_canvas_add_component_builder_local_contact_boundary',
              ),
              style: theme.textTheme.labelSmall?.copyWith(
                color: _kBoardCanvasNavy,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'Per-side markers are UI-local; not confirmed contacts.',
              key: const Key(
                'board_canvas_add_component_builder_local_marker_boundary',
              ),
              style: theme.textTheme.labelSmall?.copyWith(
                color: _kBoardCanvasMuted,
              ),
            ),
            const SizedBox(height: 5),
            SizedBox(
              key: const Key('board_canvas_add_component_builder_visual_body'),
              height: 148,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 30,
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
                                      rightContactMarkers: rightContactMarkers,
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
                    height: 30,
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
                      foregroundColor: _kBoardCanvasMuted,
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
            const SizedBox(height: 6),
            _AddComponentDraftSizeControls(
              draftWidth: draftWidth,
              draftHeight: draftHeight,
              onWidthChanged: onDraftWidthChanged,
              onHeightChanged: onDraftHeightChanged,
            ),
            const SizedBox(height: 6),
            _AddComponentDraftRotationControls(
              rotationDeg: draftRotationDeg,
              onRotationChanged: onDraftRotationChanged,
            ),
            const SizedBox(height: 6),
            _AddComponentDraftPreviewCard(
              template: template,
              draftWidth: draftWidth,
              draftHeight: draftHeight,
              draftRotationDeg: draftRotationDeg,
              topContactMarkers: topContactMarkers,
              rightContactMarkers: rightContactMarkers,
              bottomContactMarkers: bottomContactMarkers,
              leftContactMarkers: leftContactMarkers,
            ),
            const SizedBox(height: 6),
            Text(
              'Mustand on lokaalne kuni salvestamiseni.',
              key: const Key(
                'board_canvas_add_component_builder_local_draft_copy',
              ),
              style: theme.textTheme.labelSmall?.copyWith(
                color: _kBoardCanvasNavy,
              ),
            ),
            Text(
              'Kontaktid ei kinnita elektrilist ühendust.',
              key: const Key(
                'board_canvas_add_component_builder_no_connectivity_copy',
              ),
              style: theme.textTheme.labelSmall?.copyWith(
                color: _kBoardCanvasNavy,
              ),
            ),
            DecoratedBox(
              key: const Key(
                'board_canvas_add_component_builder_save_boundary_notice',
              ),
              decoration: BoxDecoration(
                color: _kBoardCanvasTile,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _kBoardCanvasRule),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 7,
                ),
                child: Text(
                  saveBoundaryCopy,
                  key: const Key(
                    'board_canvas_add_component_builder_save_boundary_copy',
                  ),
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: _kBoardCanvasNavy,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Text(
              saveContextLabel == null
                  ? 'Valitud komponent: puudub'
                  : 'Valitud komponent: $saveContextLabel',
              key: const Key(
                'board_canvas_add_component_builder_save_context',
              ),
              style: theme.textTheme.labelSmall?.copyWith(
                color: _kBoardCanvasMuted,
              ),
            ),
            if (saveStatusMessage != null)
              Text(
                saveStatusMessage!,
                key: const Key(
                  'board_canvas_add_component_builder_save_status',
                ),
                style: theme.textTheme.labelSmall?.copyWith(
                  color: _kBoardCanvasSignal,
                  fontWeight: FontWeight.w700,
                ),
              ),
            const SizedBox(height: 6),
            _AddComponentDraftActionBar(
              onResetToDefaults: onResetToDefaults,
              onConfirmPlacement: onConfirmPlacement,
            ),
          ],
        ),
      ),
    );
  }
}

class _AddComponentDraftSizeControls extends StatelessWidget {
  const _AddComponentDraftSizeControls({
    required this.draftWidth,
    required this.draftHeight,
    required this.onWidthChanged,
    required this.onHeightChanged,
  });

  final double draftWidth;
  final double draftHeight;
  final ValueChanged<double> onWidthChanged;
  final ValueChanged<double> onHeightChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      key: const Key('board_canvas_add_component_builder_size_section'),
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: _kBoardCanvasPaper,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _kBoardCanvasRule),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Suurus',
            style: theme.textTheme.titleSmall?.copyWith(
              color: _kBoardCanvasNavy,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          _AddComponentDraftScalarControl(
            label: 'Laius',
            valueText: draftWidth.toStringAsFixed(2),
            decrementKey: const Key(
              'board_canvas_add_component_builder_width_decrement',
            ),
            valueKey:
                const Key('board_canvas_add_component_builder_width_value'),
            incrementKey: const Key(
              'board_canvas_add_component_builder_width_increment',
            ),
            onDecrement: () => onWidthChanged(draftWidth - 0.1),
            onIncrement: () => onWidthChanged(draftWidth + 0.1),
          ),
          const SizedBox(height: 4),
          _AddComponentDraftScalarControl(
            label: 'Kõrgus',
            valueText: draftHeight.toStringAsFixed(2),
            decrementKey: const Key(
              'board_canvas_add_component_builder_height_decrement',
            ),
            valueKey:
                const Key('board_canvas_add_component_builder_height_value'),
            incrementKey: const Key(
              'board_canvas_add_component_builder_height_increment',
            ),
            onDecrement: () => onHeightChanged(draftHeight - 0.1),
            onIncrement: () => onHeightChanged(draftHeight + 0.1),
          ),
          const SizedBox(height: 4),
          Text(
            'Lohista nurgast suuruse muutmiseks',
            key: const Key(
              'board_canvas_add_component_builder_resize_hint',
            ),
            style: theme.textTheme.labelSmall?.copyWith(
              color: _kBoardCanvasMuted,
            ),
          ),
        ],
      ),
    );
  }
}

class _AddComponentDraftRotationControls extends StatelessWidget {
  const _AddComponentDraftRotationControls({
    required this.rotationDeg,
    required this.onRotationChanged,
  });

  final int rotationDeg;
  final ValueChanged<int> onRotationChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      key: const Key('board_canvas_add_component_builder_rotation_section'),
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: _kBoardCanvasPaper,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _kBoardCanvasRule),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pööramine',
            style: theme.textTheme.titleSmall?.copyWith(
              color: _kBoardCanvasNavy,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Pööre: $rotationDeg°',
            key: const Key(
              'board_canvas_add_component_builder_rotation_value',
            ),
            style: theme.textTheme.bodySmall?.copyWith(
              color: _kBoardCanvasNavy,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 6,
            runSpacing: 6,
            children: [
              for (final snap in const [0, 90, 180, 270])
                _AddComponentDraftChipButton(
                  key: Key(
                    'board_canvas_add_component_builder_rotation_snap_$snap',
                  ),
                  label: '$snap°',
                  onPressed: () => onRotationChanged(snap),
                  minWidth: 52,
                  minHeight: 32,
                  foregroundColor: _kBoardCanvasNavy,
                  backgroundColor: _kBoardCanvasSignalTint,
                  borderColor: _kBoardCanvasRuleStrong,
                ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Peenhäälestus',
            style: theme.textTheme.labelSmall?.copyWith(
              color: _kBoardCanvasMuted,
            ),
          ),
          const SizedBox(height: 4),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 6,
            runSpacing: 6,
            children: [
              _AddComponentDraftChipButton(
                key: const Key(
                  'board_canvas_add_component_builder_rotation_decrement',
                ),
                label: '−10°',
                onPressed: () => onRotationChanged(rotationDeg - 10),
                minHeight: 26,
                foregroundColor: _kBoardCanvasMuted,
                borderColor: _kBoardCanvasRule,
              ),
              _AddComponentDraftChipButton(
                key: const Key(
                  'board_canvas_add_component_builder_rotation_increment',
                ),
                label: '+10°',
                onPressed: () => onRotationChanged(rotationDeg + 10),
                minHeight: 26,
                foregroundColor: _kBoardCanvasMuted,
                borderColor: _kBoardCanvasRule,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AddComponentDraftPreviewCard extends StatelessWidget {
  const _AddComponentDraftPreviewCard({
    required this.template,
    required this.draftWidth,
    required this.draftHeight,
    required this.draftRotationDeg,
    required this.topContactMarkers,
    required this.rightContactMarkers,
    required this.bottomContactMarkers,
    required this.leftContactMarkers,
  });

  final _AddComponentTemplateDefinition template;
  final double draftWidth;
  final double draftHeight;
  final int draftRotationDeg;
  final int topContactMarkers;
  final int rightContactMarkers;
  final int bottomContactMarkers;
  final int leftContactMarkers;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      key: const Key('board_canvas_add_component_builder_preview_section'),
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: _kBoardCanvasPaper,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _kBoardCanvasRule),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Eelvaade',
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: _kBoardCanvasNavy,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: _kBoardCanvasTile,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _kBoardCanvasRule),
                ),
                child: Text(
                  'Draft / unsaved',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: _kBoardCanvasNavy,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 150,
                maxHeight: 70,
              ),
              child: AspectRatio(
                aspectRatio: template.bodyAspectRatio,
                child: CustomPaint(
                  key: const Key(
                    'board_canvas_add_component_builder_local_preview',
                  ),
                  painter: _RectangularPerimeterTemplatePreviewPainter(
                    template: template,
                    topContactMarkers: topContactMarkers,
                    rightContactMarkers: rightContactMarkers,
                    bottomContactMarkers: bottomContactMarkers,
                    leftContactMarkers: leftContactMarkers,
                    dashedBoundary: true,
                    strokeWidth: 2,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Suurus: ${draftWidth.toStringAsFixed(2)} × ${draftHeight.toStringAsFixed(2)}',
            key: const Key(
              'board_canvas_add_component_builder_preview_size_value',
            ),
            style: theme.textTheme.labelSmall?.copyWith(
              color: _kBoardCanvasMuted,
            ),
          ),
          Text(
            'Pööre: $draftRotationDeg°',
            key: const Key(
              'board_canvas_add_component_builder_preview_rotation_value',
            ),
            style: theme.textTheme.labelSmall?.copyWith(
              color: _kBoardCanvasMuted,
            ),
          ),
        ],
      ),
    );
  }
}

class _AddComponentDraftActionBar extends StatelessWidget {
  const _AddComponentDraftActionBar({
    required this.onResetToDefaults,
    required this.onConfirmPlacement,
  });

  final VoidCallback? onResetToDefaults;
  final VoidCallback? onConfirmPlacement;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      key: const Key('board_canvas_add_component_builder_action_bar'),
      alignment: WrapAlignment.center,
      spacing: 8,
      runSpacing: 8,
      children: [
        _AddComponentDraftChipButton(
          key: const Key('board_canvas_add_component_builder_save'),
          label: 'Salvesta',
          onPressed: onConfirmPlacement,
          minWidth: 74,
          minHeight: 38,
          foregroundColor: _kBoardCanvasSignal,
          backgroundColor: _kBoardCanvasSignalTint,
          borderColor: _kBoardCanvasSignal.withValues(alpha: 0.7),
          disabledForegroundColor: _kBoardCanvasMuted,
          disabledBackgroundColor: _kBoardCanvasTile,
          disabledBorderColor: _kBoardCanvasRuleStrong,
        ),
        const _AddComponentDraftChipButton(
          key: Key('board_canvas_add_component_builder_local_edit'),
          label: 'Muuda (tulekul)',
          onPressed: null,
          minWidth: 68,
          minHeight: 38,
          foregroundColor: Color(0xFFF6C453),
          backgroundColor: Color(0xFF231B0A),
          borderColor: Color(0xFF66501D),
        ),
        _AddComponentDraftChipButton(
          key: const Key('board_canvas_add_component_builder_delete'),
          label: 'Kustuta mustand',
          onPressed: onResetToDefaults,
          minWidth: 74,
          minHeight: 38,
          foregroundColor: const Color(0xFFEAA6A6),
          backgroundColor: const Color(0xFF211417),
          borderColor: const Color(0xFF493039),
        ),
        const _AddComponentDraftChipButton(
          key: Key('board_canvas_add_component_builder_cancel'),
          label: 'Tühista (pole aktiivne)',
          onPressed: null,
          minWidth: 74,
          minHeight: 38,
          foregroundColor: _kBoardCanvasNavy,
          backgroundColor: _kBoardCanvasPaper,
          borderColor: _kBoardCanvasRuleStrong,
        ),
      ],
    );
  }
}

class _AddComponentDraftScalarControl extends StatelessWidget {
  const _AddComponentDraftScalarControl({
    required this.label,
    required this.valueText,
    required this.decrementKey,
    required this.valueKey,
    required this.incrementKey,
    required this.onDecrement,
    required this.onIncrement,
  });

  final String label;
  final String valueText;
  final Key decrementKey;
  final Key valueKey;
  final Key incrementKey;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: _kBoardCanvasTile,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _kBoardCanvasRule),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 52,
            child: Text(
              label,
              style: theme.textTheme.labelMedium?.copyWith(
                color: _kBoardCanvasNavy,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          IconButton(
            key: decrementKey,
            iconSize: 20,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints.tightFor(width: 30, height: 30),
            style: IconButton.styleFrom(
              visualDensity: VisualDensity.compact,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              minimumSize: const Size(30, 30),
              maximumSize: const Size(30, 30),
              foregroundColor: const Color(0xFFEAA6A6),
              backgroundColor: const Color(0xFF211417),
            ),
            tooltip: 'Vähenda $label',
            onPressed: onDecrement,
            icon: const Icon(Icons.remove_circle_outline),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              decoration: BoxDecoration(
                color: _kBoardCanvasShell,
                borderRadius: BorderRadius.circular(7),
                border: Border.all(color: _kBoardCanvasRuleStrong),
              ),
              child: Text(
                valueText,
                key: valueKey,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleSmall?.copyWith(
                  color: _kBoardCanvasNavy,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            key: incrementKey,
            iconSize: 20,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints.tightFor(width: 30, height: 30),
            style: IconButton.styleFrom(
              visualDensity: VisualDensity.compact,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              minimumSize: const Size(30, 30),
              maximumSize: const Size(30, 30),
              foregroundColor: _kBoardCanvasSignal,
              backgroundColor: _kBoardCanvasSignalTint,
            ),
            tooltip: 'Suurenda $label',
            onPressed: onIncrement,
            icon: const Icon(Icons.add_circle_outline),
          ),
        ],
      ),
    );
  }
}

class _AddComponentDraftChipButton extends StatelessWidget {
  const _AddComponentDraftChipButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.foregroundColor,
    this.backgroundColor,
    this.borderColor,
    this.disabledForegroundColor,
    this.disabledBackgroundColor,
    this.disabledBorderColor,
    this.minWidth = 0,
    this.minHeight = 28,
  });

  final String label;
  final VoidCallback? onPressed;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? disabledForegroundColor;
  final Color? disabledBackgroundColor;
  final Color? disabledBorderColor;
  final double minWidth;
  final double minHeight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        visualDensity: VisualDensity.compact,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
        minimumSize: Size(minWidth, minHeight),
        maximumSize: Size(math.max(minWidth, 120), minHeight),
        foregroundColor: foregroundColor ?? _kBoardCanvasNavy,
        backgroundColor: backgroundColor ?? Colors.transparent,
        disabledForegroundColor: disabledForegroundColor ?? _kBoardCanvasDim,
        disabledBackgroundColor: disabledBackgroundColor ?? Colors.transparent,
        side: BorderSide(
          color: onPressed == null
              ? disabledBorderColor ?? _kBoardCanvasRule
              : borderColor ?? _kBoardCanvasRuleStrong,
        ),
        textStyle: theme.textTheme.labelSmall?.copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
      child: Text(label),
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
        color: _kBoardCanvasMuted,
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
            foregroundColor: _kBoardCanvasMuted,
            disabledForegroundColor: _kBoardCanvasDim,
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
              color: _kBoardCanvasNavy,
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
            foregroundColor: _kBoardCanvasMuted,
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
    const rectInsets = EdgeInsets.all(12.0);
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
        ? _kBoardCanvasSignalTint.withValues(alpha: 0.82)
        : _kBoardCanvasTile;
    final borderColor = selected
        ? _kBoardCanvasSignal
        : _kBoardCanvasRuleStrong.withValues(alpha: 0.72);
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
          border: Border.all(color: borderColor, width: selected ? 1.4 : 1),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: _kBoardCanvasSignal.withValues(alpha: 0.14),
                    blurRadius: 9,
                    offset: const Offset(0, 3),
                  ),
                ]
              : null,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              selected
                  ? Icons.check_circle_rounded
                  : Icons.radio_button_unchecked_rounded,
              color: selected ? _kBoardCanvasSignal : _kBoardCanvasMuted,
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
                            color: _kBoardCanvasNavy,
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
                          color: _kBoardCanvasSignal,
                          semanticLabel: 'selected',
                        ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    contactCountText,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: _kBoardCanvasMuted,
                    ),
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

class _ComponentNavigatorPanel extends StatelessWidget {
  const _ComponentNavigatorPanel({
    required this.components,
    required this.entries,
    required this.canvasEntries,
    required this.visibleComponentIds,
    required this.hideUnmeasured,
    required this.measurementCountsByComponentId,
    required this.selectedCategory,
    required this.selection,
    required this.onCategorySelected,
    required this.onBackToCategories,
    required this.onBackToCategory,
    required this.onComponentSelected,
    required this.onPlacementSelected,
    required this.onPlaceComponent,
    required this.onPreviewKeysChanged,
  });

  final List<ComponentFact> components;
  final List<_PlacementEntry> entries;
  final List<_PlacementEntry> canvasEntries;
  final Set<String> visibleComponentIds;
  final bool hideUnmeasured;
  final Map<String, int> measurementCountsByComponentId;
  final _ComponentCategory? selectedCategory;
  final CanvasSelection selection;
  final ValueChanged<_ComponentCategory> onCategorySelected;
  final VoidCallback onBackToCategories;
  final VoidCallback onBackToCategory;
  final ValueChanged<ComponentFact> onComponentSelected;
  final ValueChanged<_PlacementEntry> onPlacementSelected;
  final VoidCallback onPlaceComponent;
  final ValueChanged<Set<String>> onPreviewKeysChanged;

  Set<String> get _placedComponentIds =>
      entries.map((entry) => entry.placement.componentId).toSet();

  List<ComponentFact> _componentsInCategory(_ComponentCategory category) {
    return components
        .where((component) => _componentCategoryFor(component) == category)
        .toList(growable: false);
  }

  int _compareComponents(ComponentFact left, ComponentFact right) {
    final leftMeasured =
        (measurementCountsByComponentId[left.componentId] ?? 0) > 0;
    final rightMeasured =
        (measurementCountsByComponentId[right.componentId] ?? 0) > 0;
    if (leftMeasured != rightMeasured) {
      return leftMeasured ? -1 : 1;
    }
    return _naturalComponentIdCompare(left.componentId, right.componentId);
  }

  @override
  Widget build(BuildContext context) {
    final category = selectedCategory;
    final selectedComponentId = switch (selection) {
      ComponentSelection(:final componentId) => componentId,
      ComponentPlacementSelection(:final componentId) => componentId,
      _ => null,
    };
    ComponentFact? selectedComponent;
    if (category != null &&
        selectedComponentId != null &&
        visibleComponentIds.contains(selectedComponentId)) {
      for (final component in components) {
        if (component.componentId == selectedComponentId &&
            _componentCategoryFor(component) == category) {
          selectedComponent = component;
          break;
        }
      }
    }
    return KeyedSubtree(
      key: const Key('board_canvas_component_navigator'),
      child: category == null
          ? _buildCategoryOverview(context)
          : selectedComponent == null
              ? _buildCategoryList(context, category)
              : _buildComponentInspector(
                  context,
                  category,
                  selectedComponent,
                ),
    );
  }

  Widget _buildCategoryOverview(BuildContext context) {
    final theme = Theme.of(context);
    final visibleCategories = _ComponentCategory.values
        .where((category) => _componentsInCategory(category).isNotEmpty)
        .toList(growable: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Komponenditüübid',
          style: theme.textTheme.titleMedium?.copyWith(
            color: _kBoardCanvasNavy,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: SingleChildScrollView(
            key: const Key('board_canvas_component_categories'),
            child: Column(
              children: [
                for (final category in visibleCategories) ...[
                  _buildCategoryRow(context, category),
                  if (category != visibleCategories.last)
                    const SizedBox(height: 6),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryRow(
    BuildContext context,
    _ComponentCategory category,
  ) {
    final theme = Theme.of(context);
    final categoryComponents = _componentsInCategory(category);
    final visibleCount = categoryComponents
        .where(
          (component) => visibleComponentIds.contains(component.componentId),
        )
        .length;
    final hiddenCount = categoryComponents.length - visibleCount;
    final placedIds = _placedComponentIds;
    final placedCount = categoryComponents
        .where((component) => placedIds.contains(component.componentId))
        .length;
    final unplacedCount = categoryComponents.length - placedCount;
    final previewKeys = canvasEntries
        .where(
          (entry) =>
              entry.component != null &&
              _componentCategoryFor(entry.component!) == category,
        )
        .map((entry) => entry.key)
        .toSet();

    return MouseRegion(
      onEnter: (_) => onPreviewKeysChanged(previewKeys),
      onExit: (_) => onPreviewKeysChanged(const <String>{}),
      child: Semantics(
        button: true,
        label: hideUnmeasured
            ? '${category.label}, $visibleCount / '
                '${categoryComponents.length} nähtaval, '
                '$hiddenCount peidetud'
            : '${category.label}, $placedCount / '
                '${categoryComponents.length} paigutatud, '
                '$unplacedCount paigutamata',
        child: Material(
          color: _kBoardCanvasTile,
          borderRadius: BorderRadius.circular(8),
          child: InkWell(
            key: Key('board_canvas_component_category_${category.stableId}'),
            borderRadius: BorderRadius.circular(8),
            onTap: () => onCategorySelected(category),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          category.label,
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: _kBoardCanvasNavy,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          hideUnmeasured
                              ? '$visibleCount / ${categoryComponents.length} '
                                  'nähtaval'
                              : '$placedCount / ${categoryComponents.length} '
                                  'paigutatud',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: _kBoardCanvasMuted,
                          ),
                        ),
                        Text(
                          hideUnmeasured
                              ? '$hiddenCount peidetud'
                              : '$unplacedCount paigutamata',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: _kBoardCanvasDim,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right_rounded,
                    size: 20,
                    color: _kBoardCanvasSignal,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryList(
    BuildContext context,
    _ComponentCategory category,
  ) {
    final theme = Theme.of(context);
    final placedIds = _placedComponentIds;
    final allCategoryComponents = _componentsInCategory(category);
    final categoryComponents = allCategoryComponents
        .where(
          (component) => visibleComponentIds.contains(component.componentId),
        )
        .toList(growable: false);
    final placed = categoryComponents
        .where((component) => placedIds.contains(component.componentId))
        .toList(growable: false)
      ..sort(_compareComponents);
    final unplaced = categoryComponents
        .where((component) => !placedIds.contains(component.componentId))
        .toList(growable: false)
      ..sort(_compareComponents);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton.icon(
            key: const Key('board_canvas_component_category_back'),
            onPressed: onBackToCategories,
            style: _benchBeepNavigatorControlStyle(filled: false),
            icon: const Icon(Icons.arrow_back_rounded, size: 17),
            label: const Text('Komponenditüübid'),
          ),
        ),
        Text(
          category.label,
          style: theme.textTheme.titleMedium?.copyWith(
            color: _kBoardCanvasNavy,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 8),
        if (hideUnmeasured && categoryComponents.isEmpty)
          Expanded(
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Kõik selle grupi komponendid on mõõtmata ja peidetud.',
                key: const Key('board_canvas_component_category_empty'),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: _kBoardCanvasMuted,
                ),
              ),
            ),
          )
        else
          Expanded(
            child: SingleChildScrollView(
              key: Key(
                'board_canvas_component_category_list_${category.stableId}',
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildComponentSection(
                    context,
                    key: const Key('board_canvas_component_section_placed'),
                    title: 'PAIGUTATUD',
                    sectionComponents: placed,
                  ),
                  const SizedBox(height: 12),
                  _buildComponentSection(
                    context,
                    key: const Key('board_canvas_component_section_unplaced'),
                    title: 'PAIGUTAMATA',
                    sectionComponents: unplaced,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildComponentSection(
    BuildContext context, {
    required Key key,
    required String title,
    required List<ComponentFact> sectionComponents,
  }) {
    final theme = Theme.of(context);
    return Column(
      key: key,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: theme.textTheme.labelSmall?.copyWith(
            color: _kBoardCanvasSignal,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 5),
        if (sectionComponents.isEmpty)
          Text(
            'Komponente pole.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: _kBoardCanvasDim,
            ),
          )
        else
          for (var index = 0; index < sectionComponents.length; index++) ...[
            _buildComponentRow(context, sectionComponents[index]),
            if (index != sectionComponents.length - 1)
              const SizedBox(height: 5),
          ],
      ],
    );
  }

  Widget _buildComponentRow(
    BuildContext context,
    ComponentFact component,
  ) {
    final theme = Theme.of(context);
    final measurementCount =
        measurementCountsByComponentId[component.componentId] ?? 0;
    final measurementLabel =
        measurementCount == 0 ? 'Mõõtmata' : '$measurementCount mõõtmist';
    final previewKeys = canvasEntries
        .where(
          (entry) => entry.placement.componentId == component.componentId,
        )
        .map((entry) => entry.key)
        .toSet();

    return MouseRegion(
      onEnter: (_) => onPreviewKeysChanged(previewKeys),
      onExit: (_) => onPreviewKeysChanged(const <String>{}),
      child: Semantics(
        button: true,
        child: Material(
          color: _kBoardCanvasTile,
          borderRadius: BorderRadius.circular(7),
          child: InkWell(
            key: Key('board_canvas_component_row_${component.componentId}'),
            borderRadius: BorderRadius.circular(7),
            onTap: () => onComponentSelected(component),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 7),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                border: Border.all(color: _kBoardCanvasRule),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _componentPrimaryLabel(component),
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: _kBoardCanvasNavy,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 1),
                        Text(
                          '${component.componentId} · '
                          '${_componentKindLabel(component)}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: _kBoardCanvasMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    measurementLabel,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: measurementCount == 0
                          ? _kBoardCanvasDim
                          : _kBoardCanvasReady,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildComponentInspector(
    BuildContext context,
    _ComponentCategory category,
    ComponentFact component,
  ) {
    final theme = Theme.of(context);
    final componentEntries = entries
        .where(
          (entry) => entry.placement.componentId == component.componentId,
        )
        .toList(growable: false);
    final visibleComponentEntries = canvasEntries
        .where(
          (entry) => entry.placement.componentId == component.componentId,
        )
        .toList(growable: false);
    final selectedPlacementKey = selection is ComponentPlacementSelection
        ? (selection as ComponentPlacementSelection).placementKey
        : null;
    final measurementCount =
        measurementCountsByComponentId[component.componentId] ?? 0;

    return Column(
      key: const Key('board_canvas_component_inspector'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton.icon(
            key: const Key('board_canvas_component_inspector_back'),
            onPressed: onBackToCategory,
            style: _benchBeepNavigatorControlStyle(filled: false),
            icon: const Icon(Icons.arrow_back_rounded, size: 17),
            label: Text(category.label),
          ),
        ),
        Text(
          _componentPrimaryLabel(component),
          style: theme.textTheme.titleMedium?.copyWith(
            color: _kBoardCanvasNavy,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          '${component.componentId} · ${_componentKindLabel(component)}',
          style: theme.textTheme.bodySmall?.copyWith(
            color: _kBoardCanvasMuted,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          measurementCount == 0 ? 'Mõõtmata' : '$measurementCount mõõtmist',
          style: theme.textTheme.labelSmall?.copyWith(
            color:
                measurementCount == 0 ? _kBoardCanvasDim : _kBoardCanvasReady,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        if (componentEntries.isEmpty) ...[
          Text(
            'Pole veel canvasele paigutatud',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: _kBoardCanvasNavy,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            key: const Key('board_canvas_component_place_action'),
            onPressed: onPlaceComponent,
            icon: const Icon(Icons.add_location_alt_outlined),
            label: const Text('Paiguta canvasele'),
          ),
        ] else if (visibleComponentEntries.isEmpty) ...[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (var index = 0;
                      index < componentEntries.length;
                      index++) ...[
                    _buildPlacementSummary(context, componentEntries[index]),
                    if (index != componentEntries.length - 1)
                      const SizedBox(height: 6),
                  ],
                  const SizedBox(height: 8),
                  Text(
                    'Kinnitatud paigutus ei ole plaadi canvasel nähtav.',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: _kBoardCanvasMuted,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ] else if (visibleComponentEntries.length == 1) ...[
          _buildPlacementSummary(context, visibleComponentEntries.single),
          const SizedBox(height: 8),
          FilledButton.icon(
            key: const Key('board_canvas_component_view_placement'),
            onPressed: () =>
                onPlacementSelected(visibleComponentEntries.single),
            style: _benchBeepNavigatorControlStyle(filled: true),
            icon: const Icon(Icons.center_focus_strong),
            label: const Text('Vaata canvasel'),
          ),
        ] else ...[
          Text(
            'Vali paigutus',
            style: theme.textTheme.labelLarge?.copyWith(
              color: _kBoardCanvasNavy,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (var index = 0;
                      index < visibleComponentEntries.length;
                      index++) ...[
                    _buildPlacementChoice(
                      context,
                      visibleComponentEntries[index],
                      index: index,
                      selected: visibleComponentEntries[index].key ==
                          selectedPlacementKey,
                    ),
                    if (index != visibleComponentEntries.length - 1)
                      const SizedBox(height: 6),
                  ],
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildPlacementSummary(
    BuildContext context,
    _PlacementEntry entry,
  ) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        color: _kBoardCanvasTile,
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: _kBoardCanvasRule),
      ),
      child: Text(
        '${entry.placement.boardSide} · '
        '${entry.placement.coordinateSpace}',
        style: theme.textTheme.bodySmall?.copyWith(
          color: _kBoardCanvasMuted,
        ),
      ),
    );
  }

  Widget _buildPlacementChoice(
    BuildContext context,
    _PlacementEntry entry, {
    required int index,
    required bool selected,
  }) {
    final theme = Theme.of(context);
    return MouseRegion(
      onEnter: (_) => onPreviewKeysChanged(<String>{entry.key}),
      onExit: (_) => onPreviewKeysChanged(const <String>{}),
      child: Semantics(
        selected: selected,
        button: true,
        child: Material(
          color: selected ? _kBoardCanvasSignalTint : _kBoardCanvasTile,
          borderRadius: BorderRadius.circular(7),
          child: InkWell(
            key: Key('board_canvas_component_placement_${entry.key}'),
            borderRadius: BorderRadius.circular(7),
            onTap: () => onPlacementSelected(entry),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                border: Border.all(
                  color: selected ? _kBoardCanvasSignal : _kBoardCanvasRule,
                  width: selected ? 2 : 1,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${index + 1}. paigutus · '
                          '${entry.placement.boardSide}',
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: _kBoardCanvasNavy,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          entry.placement.coordinateSpace,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: _kBoardCanvasMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    selected
                        ? Icons.radio_button_checked
                        : Icons.radio_button_unchecked,
                    size: 18,
                    color: selected ? _kBoardCanvasSignal : _kBoardCanvasDim,
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
    final summary = selectedLabel ??
        (entries.length == 1
            ? '1 paigutus saadaval'
            : '${entries.length} paigutust saadaval');
    return Card(
      margin: EdgeInsets.zero,
      color: _kBoardCanvasTile,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: _kBoardCanvasRule),
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
          label: 'Paigutused',
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
        border: Border.all(color: _kBoardCanvasRule.withValues(alpha: 0.72)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Plaadi projektsioonivaade',
              style: theme.textTheme.labelLarge?.copyWith(
                color: _kBoardCanvasNavy,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'Ainult olemasolevad plaadinormaliseeritud paigutused',
              style: theme.textTheme.bodySmall?.copyWith(
                color: _kBoardCanvasMuted,
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
    required this.selectedComponentId,
    required this.previewKeys,
    required this.hideUnmeasured,
    required this.onToggleHideUnmeasured,
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
  final String? selectedComponentId;
  final Set<String> previewKeys;
  final bool hideUnmeasured;
  final VoidCallback onToggleHideUnmeasured;
  final Map<String, int> measurementCountsByComponentId;
  final Map<String, List<MeasurementFact>> measurementValueBadgesByComponentId;
  final Set<String> visibleMeasurementValueBadgeComponentIds;
  final bool hasEligibleMeasurementValueBadges;
  final bool allMeasurementValueBadgesVisible;
  final VoidCallback onToggleAllMeasurementValueBadges;
  final Widget? cornerFocusAction;
  final ValueChanged<ComponentPlacementSelection> onPlacementSelected;
  final VoidCallback onCanvasTapEmpty;
  final bool showAddComponentTemplateGhost;
  final int addComponentTemplateGhostTopContactMarkers;
  final int addComponentTemplateGhostRightContactMarkers;
  final int addComponentTemplateGhostBottomContactMarkers;
  final int addComponentTemplateGhostLeftContactMarkers;
  final String addComponentTemplateGhostDraftLabel;
  final Offset? addComponentTemplateGhostDraftAnchor;
  final _AddComponentTemplateDefinition? selectedAddComponentTemplate;
  final ValueChanged<({Offset anchor, Size canvasSize})>
      onAddComponentTemplateGhostDraftAnchorChanged;

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
      widget.onAddComponentTemplateGhostDraftAnchorChanged(
        (anchor: position, canvasSize: size),
      );
      return;
    }
    for (final entry in widget.entries.reversed) {
      if (_renderedPlacementContains(
        entry: entry,
        position: position,
        size: size,
      )) {
        widget.onPlacementSelected(
          ComponentPlacementSelection(
            placementKey: entry.key,
            componentId: entry.placement.componentId,
            canvasAnchor: position,
          ),
        );
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
                    selectedComponentId: widget.selectedComponentId,
                    previewKeys: widget.previewKeys,
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
              if (widget.hideUnmeasured && widget.entries.isEmpty)
                const Positioned.fill(
                  child: IgnorePointer(
                    child: Center(
                      child: DecoratedBox(
                        key: Key('board_canvas_filter_canvas_empty'),
                        decoration: BoxDecoration(
                          color: _kBoardCanvasTile,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                          child: Text('Kõik komponendid on mõõtmata'),
                        ),
                      ),
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
        (
          anchor: _clampAddComponentTemplateGhostDraftAnchor(
            nextAnchor,
            _addComponentTemplateGhostDragCanvasSize,
          ),
          canvasSize: _addComponentTemplateGhostDragCanvasSize,
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
                          color: _kBoardCanvasNavy,
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
                      color: _kBoardCanvasTile,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: _kBoardCanvasRule,
                      ),
                    ),
                    child: Text(
                      'Draft / unsaved',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: _kBoardCanvasNavy,
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
          color: _kBoardCanvasTile.withValues(alpha: 0.72),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: _kBoardCanvasRule,
          ),
        ),
        child: ghostPreview,
      ),
    );
  }

  Widget _buildCornerControls(BuildContext context) {
    final hideUnmeasuredToggle = TextButton.icon(
      key: const Key('board_canvas_hide_unmeasured_toggle'),
      style: TextButton.styleFrom(
        backgroundColor: widget.hideUnmeasured
            ? _kBoardCanvasSignal
            : _kBoardCanvasPaper.withValues(alpha: 0.92),
        foregroundColor:
            widget.hideUnmeasured ? _kBoardCanvasPaper : _kBoardCanvasNavy,
        minimumSize: const Size(112, _kCompactControlTileHeight),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.compact,
      ),
      icon: Icon(
        widget.hideUnmeasured
            ? Icons.visibility_outlined
            : Icons.visibility_off_outlined,
        size: _kCompactControlIconSize,
      ),
      label: Text(
        widget.hideUnmeasured ? 'Näita mõõtmata' : 'Peida mõõtmata',
      ),
      onPressed: widget.onToggleHideUnmeasured,
    );
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
        widget.allMeasurementValueBadgesVisible ? 'Peida kõik' : 'Näita kõiki',
      ),
      onPressed: widget.onToggleAllMeasurementValueBadges,
    );
    final fitButton = Tooltip(
      message: 'Sobita / taasta vaade',
      child: Semantics(
        label: 'Sobita või taasta plaadivaade',
        hint: 'Lähtestab suumi ja nihke.',
        button: true,
        child: TextButton.icon(
          key: const Key('board_canvas_fit_view_button'),
          style: TextButton.styleFrom(
            backgroundColor: _kBoardCanvasPaper.withValues(alpha: 0.92),
            foregroundColor: _kBoardCanvasNavy,
            minimumSize: const Size(74, _kCompactControlTileHeight),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
          ),
          icon: const Icon(
            Icons.center_focus_strong,
            size: _kCompactControlIconSize,
          ),
          label: const Text('Sobita'),
          onPressed: _fitCanvasView,
        ),
      ),
    );

    return Positioned(
      top: 8,
      right: 8,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          hideUnmeasuredToggle,
          const SizedBox(width: 6),
          if (widget.cornerFocusAction != null) ...[
            widget.cornerFocusAction!,
            const SizedBox(width: 6),
          ],
          if (widget.hasEligibleMeasurementValueBadges) ...[
            Tooltip(
              message: widget.allMeasurementValueBadgesVisible
                  ? 'Peida kõik mõõteväärtuse märgid'
                  : 'Näita kõiki mõõteväärtuse märke',
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
      color: _kBoardCanvasTile,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: _kBoardCanvasRuleStrong),
      ),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(8),
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
    return Card(
      margin: EdgeInsets.zero,
      color: _kBoardCanvasTile,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: _kBoardCanvasRule),
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
        title: const _CompactDisclosureTitle(
          label: 'Ohutus / tõendid',
          detail: 'kirjutuskaitstud piirid',
        ),
        children: const [
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
        color: _kBoardCanvasPaper,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _kBoardCanvasRule),
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
              style: theme.textTheme.bodySmall?.copyWith(
                color: _kBoardCanvasMuted,
              ),
            ),
            Text(
              'Template family is not electrical identity; visual metadata does not establish a net.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: _kBoardCanvasMuted,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Measurement badge: component has related measurement(s).',
              style: theme.textTheme.bodySmall?.copyWith(
                color: _kBoardCanvasMuted,
              ),
            ),
            Text(
              'Value badges are optional and show projected value plus unit only.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: _kBoardCanvasMuted,
              ),
            ),
            Text(
              'Component-level only.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: _kBoardCanvasMuted,
              ),
            ),
            Text(
              'No measurement board coordinate is available.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: _kBoardCanvasMuted,
              ),
            ),
            Text(
              'Does not create or confirm a net.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: _kBoardCanvasMuted,
              ),
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
            color: _kBoardCanvasSignalTint,
            border: Border.all(color: _kBoardCanvasSignal),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: _kBoardCanvasMuted,
          ),
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
          border: Border.all(color: _kBoardCanvasRule),
          color: _kBoardCanvasTile,
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
    required this.placementDraft,
    required this.onTogglePlacementDraftSide,
    required this.onIncrementPlacementDraftRotation,
    required this.onIncrementPlacementDraftWidth,
    required this.onIncrementPlacementDraftHeight,
    required this.onResetPlacementDraft,
    required this.onDiscardPlacementDraft,
  });

  final _PlacementEntry? selectedEntry;
  final int selectedMeasurementCount;
  final int selectedMeasurementValueBadgeCount;
  final bool selectedMeasurementValueBadgesVisible;
  final VoidCallback? onToggleSelectedMeasurementValueBadges;
  final List<MeasurementFact> relatedMeasurements;
  final List<VisualTraceFact> relatedVisualTraces;
  final List<PhotoToBoardAlignmentFact> photoToBoardAlignments;
  final _PlacementEditorDraftState? placementDraft;
  final VoidCallback? onTogglePlacementDraftSide;
  final VoidCallback? onIncrementPlacementDraftRotation;
  final VoidCallback? onIncrementPlacementDraftWidth;
  final VoidCallback? onIncrementPlacementDraftHeight;
  final VoidCallback? onResetPlacementDraft;
  final VoidCallback? onDiscardPlacementDraft;

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];

    if (selectedEntry == null) {
      children.add(
        Card(
          color: _kBoardCanvasPaper,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: _kBoardCanvasRule),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Select a placement to view read-only details.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: _kBoardCanvasMuted,
                    ),
              ),
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
      if (placementDraft != null) {
        children.add(
          _PlacementEditorShellCard(
            entry: selectedEntry!,
            draft: placementDraft!,
            onToggleSide: onTogglePlacementDraftSide,
            onIncrementRotation: onIncrementPlacementDraftRotation,
            onIncrementWidth: onIncrementPlacementDraftWidth,
            onIncrementHeight: onIncrementPlacementDraftHeight,
            onReset: onResetPlacementDraft,
            onDiscard: onDiscardPlacementDraft,
          ),
        );
      }
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

class _PlacementEditorDraftState {
  const _PlacementEditorDraftState({
    required this.componentLabel,
    required this.boardSide,
    required this.templateLabel,
    required this.rotationDeg,
    required this.width,
    required this.height,
  });

  factory _PlacementEditorDraftState.fromEntry(_PlacementEntry entry) {
    final placement = entry.placement;
    final templateId = placement.templateId?.trim();
    final width = placement.width?.toDouble();
    final height = placement.height?.toDouble();
    return _PlacementEditorDraftState(
      componentLabel: entry.selectorLabel,
      boardSide: placement.boardSide.trim().isEmpty
          ? 'top'
          : placement.boardSide.trim(),
      templateLabel: templateId == null || templateId.isEmpty
          ? _footprintVisualKindLabel(_footprintVisualKind(entry))
          : templateId,
      rotationDeg: placement.rotationDeg.toDouble(),
      width: width == null || !width.isFinite || width <= 0 ? 1.0 : width,
      height: height == null || !height.isFinite || height <= 0 ? 0.6 : height,
    );
  }

  final String componentLabel;
  final String boardSide;
  final String templateLabel;
  final double rotationDeg;
  final double width;
  final double height;

  _PlacementEditorDraftState copyWith({
    String? boardSide,
    double? rotationDeg,
    double? width,
    double? height,
  }) {
    return _PlacementEditorDraftState(
      componentLabel: componentLabel,
      boardSide: boardSide ?? this.boardSide,
      templateLabel: templateLabel,
      rotationDeg: rotationDeg ?? this.rotationDeg,
      width: width ?? this.width,
      height: height ?? this.height,
    );
  }
}

class _PlacementEditorShellCard extends StatelessWidget {
  const _PlacementEditorShellCard({
    required this.entry,
    required this.draft,
    required this.onToggleSide,
    required this.onIncrementRotation,
    required this.onIncrementWidth,
    required this.onIncrementHeight,
    required this.onReset,
    required this.onDiscard,
  });

  final _PlacementEntry entry;
  final _PlacementEditorDraftState draft;
  final VoidCallback? onToggleSide;
  final VoidCallback? onIncrementRotation;
  final VoidCallback? onIncrementWidth;
  final VoidCallback? onIncrementHeight;
  final VoidCallback? onReset;
  final VoidCallback? onDiscard;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final boundaryTextStyle = theme.textTheme.bodySmall?.copyWith(
      color: _kBoardCanvasNavy,
      fontWeight: FontWeight.w600,
      height: 1.25,
    );
    return Card(
      key: const Key('board_canvas_placement_editor_shell'),
      color: _kBoardCanvasTile,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: _kBoardCanvasRule),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _SectionHeader(
              title: 'Placement draft',
              tag: 'LOCAL',
            ),
            const SizedBox(height: 6),
            Text(
              'unsaved/session-only',
              key: const Key('board_canvas_placement_draft_session_only'),
              style: theme.textTheme.labelSmall?.copyWith(
                color: _kBoardCanvasSignal,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Draft changes stay in memory only.',
              style: boundaryTextStyle,
            ),
            Text(
              'Canonical projection remains unchanged.',
              style: boundaryTextStyle,
            ),
            Text(
              'Canonical write unavailable in this pass.',
              style: boundaryTextStyle,
            ),
            const SizedBox(height: 10),
            Text(
              'Selected component: ${draft.componentLabel}',
              key: const Key('board_canvas_placement_draft_component'),
            ),
            Text(
              'Board side draft: ${draft.boardSide}',
              key: const Key('board_canvas_placement_draft_side'),
            ),
            Text(
              'Shape/template draft: ${draft.templateLabel}',
              key: const Key('board_canvas_placement_draft_template'),
            ),
            Text(
              'Rotation draft: ${_formatPlacementDraftRotation(draft.rotationDeg)} deg',
              key: const Key('board_canvas_placement_draft_rotation'),
            ),
            Text(
              'Width draft: ${_formatPlacementDraftSize(draft.width)}',
              key: const Key('board_canvas_placement_draft_width'),
            ),
            Text(
              'Height draft: ${_formatPlacementDraftSize(draft.height)}',
              key: const Key('board_canvas_placement_draft_height'),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                _PlacementDraftButton(
                  buttonKey:
                      const Key('board_canvas_placement_draft_side_toggle'),
                  label: 'Toggle side',
                  onPressed: onToggleSide,
                ),
                _PlacementDraftButton(
                  buttonKey: const Key(
                    'board_canvas_placement_draft_rotation_increment',
                  ),
                  label: 'Rotate +15',
                  onPressed: onIncrementRotation,
                ),
                _PlacementDraftButton(
                  buttonKey: const Key(
                    'board_canvas_placement_draft_width_increment',
                  ),
                  label: 'Width +0.10',
                  onPressed: onIncrementWidth,
                ),
                _PlacementDraftButton(
                  buttonKey: const Key(
                    'board_canvas_placement_draft_height_increment',
                  ),
                  label: 'Height +0.10',
                  onPressed: onIncrementHeight,
                ),
                _PlacementDraftButton(
                  buttonKey: const Key('board_canvas_placement_draft_cancel'),
                  label: 'Cancel local draft',
                  onPressed: onReset,
                ),
                _PlacementDraftButton(
                  buttonKey: const Key('board_canvas_placement_draft_reset'),
                  label: 'Reset local draft',
                  onPressed: onReset,
                ),
                _PlacementDraftButton(
                  buttonKey: const Key('board_canvas_placement_draft_discard'),
                  label: 'Discard local draft',
                  onPressed: onDiscard,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PlacementDraftButton extends StatelessWidget {
  const _PlacementDraftButton({
    required this.buttonKey,
    required this.label,
    required this.onPressed,
  });

  final Key buttonKey;
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextButton(
      key: buttonKey,
      onPressed: onPressed,
      style: TextButton.styleFrom(
        visualDensity: VisualDensity.compact,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        minimumSize: const Size(0, 28),
        textStyle: theme.textTheme.labelSmall,
        foregroundColor: _kBoardCanvasSignal,
        disabledForegroundColor: _kBoardCanvasDim,
      ),
      child: Text(label),
    );
  }
}

String _formatPlacementDraftRotation(double value) {
  if (!value.isFinite) {
    return '0';
  }
  final rounded = value.roundToDouble();
  if ((value - rounded).abs() < 0.001) {
    return rounded.toInt().toString();
  }
  return value.toStringAsFixed(1);
}

String _formatPlacementDraftSize(double value) {
  if (!value.isFinite) {
    return '0.00';
  }
  return value.toStringAsFixed(2);
}

class _IntegratedMeasurePanel extends ConsumerStatefulWidget {
  const _IntegratedMeasurePanel({
    required this.projectState,
    required this.selectedEntry,
    required this.relatedMeasurements,
    required this.relatedVisualTraces,
    required this.onContinueToMeasureSheet,
  });

  final ProjectState projectState;
  final _PlacementEntry? selectedEntry;
  final List<MeasurementFact> relatedMeasurements;
  final List<VisualTraceFact> relatedVisualTraces;
  final VoidCallback onContinueToMeasureSheet;

  @override
  ConsumerState<_IntegratedMeasurePanel> createState() =>
      _IntegratedMeasurePanelState();
}

class _IntegratedMeasurePanelState
    extends ConsumerState<_IntegratedMeasurePanel> {
  static const List<String> _draftUnitOptions = ['V', 'Ω', 'Diode', 'Beep'];

  String? _selectedTarget;
  final Map<String, String> _draftValuesByTarget = {};
  final Map<String, String> _draftUnitsByTarget = {};
  bool _saveInFlight = false;
  String? _saveStatusMessage;
  String? _saveErrorMessage;
  String? _lastSuccessfulFormKey;

  _MeasureUnitSelection _unitSelection(String unitLabel) {
    switch (unitLabel) {
      case 'Ω':
        return const _MeasureUnitSelection(
          label: 'Ω',
          mode: 'resistance',
          schemaUnit: 'Ω',
        );
      case 'Diode':
        return const _MeasureUnitSelection(
          label: 'Diode',
          mode: 'diode',
          schemaUnit: 'diode',
        );
      case 'Beep':
        return const _MeasureUnitSelection(
          label: 'Beep',
          mode: 'continuity',
          schemaUnit: 'beep',
        );
      case 'V':
      default:
        return const _MeasureUnitSelection(
          label: 'V',
          mode: 'voltage',
          schemaUnit: 'V',
        );
    }
  }

  Object _readingValue(String rawValue) {
    return num.tryParse(rawValue) ?? rawValue;
  }

  String? _componentIdForTarget(String target) {
    final selectedComponentId = widget.selectedEntry?.placement.componentId;
    if (selectedComponentId != null &&
        measurementEndpointMatchesComponent(target, selectedComponentId)) {
      return selectedComponentId;
    }
    return selectedComponentId;
  }

  String? _pinIdForTarget(String target) {
    final componentId = widget.selectedEntry?.placement.componentId;
    if (componentId == null) {
      return null;
    }
    return target.startsWith('$componentId.') ? target : null;
  }

  String? _formKeyFor({
    required _MeasureTargetRowData? row,
    required String valueText,
    required String unitLabel,
  }) {
    if (widget.selectedEntry == null || row == null || row.isExistingValue) {
      return null;
    }
    final trimmedValue = valueText.trim();
    if (trimmedValue.isEmpty || unitLabel.trim().isEmpty) {
      return null;
    }
    return [
      row.target,
      unitLabel.trim(),
      trimmedValue,
      'human_entered',
    ].join('|');
  }

  String? _saveBlockReason({
    required _MeasureTargetRowData? row,
    required String valueText,
    required String unitLabel,
  }) {
    if (widget.selectedEntry == null) {
      return 'Vali mõõtmise Koht plaadil.';
    }
    if (row == null) {
      return 'Vali Koht enne salvestamist.';
    }
    if (row.isExistingValue) {
      return 'Vali uus Koht või sisesta mõõtmata reale Väärtus.';
    }
    if (valueText.trim().isEmpty) {
      return 'Sisesta Väärtus enne salvestamist.';
    }
    if (unitLabel.trim().isEmpty) {
      return 'Vali Ühik enne salvestamist.';
    }
    if (_lastSuccessfulFormKey ==
        _formKeyFor(row: row, valueText: valueText, unitLabel: unitLabel)) {
      return 'Mõõtmine on salvestatud. Projektsioon vajab värskendamist.';
    }
    final projectDirectory = widget.projectState.projectDirectory;
    if (projectDirectory == null || projectDirectory.trim().isEmpty) {
      return 'Mõõtmise salvestamiseks ava projekt kohalikust kaustast.';
    }
    return null;
  }

  Future<void> _saveMeasurement({
    required _MeasureTargetRowData row,
    required String valueText,
    required String unitLabel,
  }) async {
    if (_saveInFlight) {
      return;
    }
    final blockReason = _saveBlockReason(
      row: row,
      valueText: valueText,
      unitLabel: unitLabel,
    );
    if (blockReason != null) {
      setState(() {
        _saveStatusMessage = null;
        _saveErrorMessage = blockReason;
      });
      return;
    }

    final formKey =
        _formKeyFor(row: row, valueText: valueText, unitLabel: unitLabel)!;
    final unitSelection = _unitSelection(unitLabel);
    final componentId = _componentIdForTarget(row.target);
    final pinId = _pinIdForTarget(row.target);
    final request = V2SaveMeasurementRequest(
      value: _readingValue(valueText.trim()),
      valueText: valueText.trim(),
      displayValue: '${valueText.trim()} ${unitSelection.label}',
      unitLabel: unitSelection.label,
      schemaUnit: unitSelection.schemaUnit,
      mode: unitSelection.mode,
      targetKey: row.target,
      displayLabel: row.displayLabel,
      componentId: componentId,
      pinId: pinId,
      valueProvenance: 'human_entered',
      clientOperationId: _measurementClientOperationIdFor(formKey),
    );

    setState(() {
      _saveInFlight = true;
      _saveStatusMessage = 'Salvestan mõõtmist...';
      _saveErrorMessage = null;
    });

    try {
      final projectState =
          ref.read(projectStateProvider) ?? widget.projectState;
      final result =
          await ref.read(v2SaveMeasurementWriterProvider).saveMeasurement(
                projectState: projectState,
                request: request,
              );
      if (!mounted) {
        return;
      }
      _appendMeasurementEventAndMarkStale(
        projectState: projectState,
        event: result.event,
      );
      setState(() {
        _lastSuccessfulFormKey = formKey;
        _saveStatusMessage = result.appended
            ? 'Mõõtmine salvestatud. Projektsioon vajab värskendamist.'
            : 'Mõõtmine oli juba salvestatud. Projektsioon vajab värskendamist.';
        _saveErrorMessage = null;
      });
    } on V2SaveMeasurementException catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _saveStatusMessage = null;
        _saveErrorMessage = _measurementFailureMessage(error);
      });
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _saveStatusMessage = null;
        _saveErrorMessage = 'Mõõtmise salvestamine ebaõnnestus: $error';
      });
    } finally {
      if (mounted) {
        setState(() {
          _saveInFlight = false;
        });
      }
    }
  }

  void _appendMeasurementEventAndMarkStale({
    required ProjectState projectState,
    required Map<String, dynamic> event,
  }) {
    final returnedEvent = TraceBenchEvent.fromJson(event);
    final updatedEvents = List<TraceBenchEvent>.from(projectState.events);
    final clientOperationId = event['client_operation_id']?.toString();
    final eventAlreadyPresent = updatedEvents.any((localEvent) {
      if (localEvent.eventId == returnedEvent.eventId) {
        return true;
      }
      if (clientOperationId == null || clientOperationId.isEmpty) {
        return false;
      }
      return localEvent.toJson()['client_operation_id'] == clientOperationId ||
          localEvent.payload['client_operation_id'] == clientOperationId;
    });
    if (!eventAlreadyPresent) {
      updatedEvents.add(returnedEvent);
    }
    ref.read(projectStateProvider.notifier).state = projectState.copyWith(
      events: updatedEvents,
      isProjectionStale: true,
    );
  }

  String _measurementClientOperationIdFor(String formKey) {
    final safeKey = formKey
        .trim()
        .replaceAll(RegExp(r'[^A-Za-z0-9_]+'), '_')
        .replaceAll(RegExp(r'_+'), '_')
        .replaceAll(RegExp(r'^_|_$'), '');
    final timestamp = DateTime.now().toUtc().microsecondsSinceEpoch;
    return 'op_board_canvas_measurement_${safeKey}_$timestamp';
  }

  String _measurementFailureMessage(V2SaveMeasurementException error) {
    switch (error.kind) {
      case V2SaveMeasurementFailureKind.noProjectDirectory:
        return 'Mõõtmise salvestamiseks ava projekt kohalikust kaustast.';
      case V2SaveMeasurementFailureKind.invalidProjectDirectory:
        return 'Projektikaust ei sobi mõõtmise salvestamiseks.';
      case V2SaveMeasurementFailureKind.pythonUnavailable:
        return 'Mõõtmise kirjutaja pole saadaval.';
      case V2SaveMeasurementFailureKind.lockConflict:
        return 'Mõõtmise kirjutaja on hetkel hõivatud.';
      case V2SaveMeasurementFailureKind.validation:
        return 'Mõõtmist ei salvestatud: sisestus ei läbinud valideerimist.';
      case V2SaveMeasurementFailureKind.append:
        return 'Mõõtmise salvestamine ebaõnnestus: ${error.message}';
    }
  }

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
    final selectedDraftValue = selectedTarget == null
        ? ''
        : _draftValuesByTarget[selectedTarget] ?? '';
    final selectedDraftUnit = selectedTarget == null
        ? _draftUnitOptions.first
        : _draftUnitsByTarget[selectedTarget] ??
            (selectedTargetRow == null
                ? _draftUnitOptions.first
                : _defaultDraftUnit(selectedTargetRow));
    final saveBlockReason = _saveBlockReason(
      row: selectedTargetRow,
      valueText: selectedDraftValue,
      unitLabel: selectedDraftUnit,
    );
    final canSaveMeasurement = !_saveInFlight && saveBlockReason == null;
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
                          'Mõõtmine',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: _kMeasurePanelNavy,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          selectedHeader,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleSmall?.copyWith(
                            color: _kBoardCanvasMuted,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 6),
                  const _MeasurePanelPill(label: 'human · write'),
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
                    'Komponendi vaade',
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: _kMeasurePanelNavy,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 5),
                  _MeasureComponentPreview(
                    selectedEntry: widget.selectedEntry,
                    selectedName: selectedName,
                    selectedTarget: selectedTarget,
                    targetRows: targetRows,
                    measurementCount: measuredTargetCount,
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
                      color: _kBoardCanvasMuted,
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
                          'Mõõdetud väärtused',
                          style: theme.textTheme.titleSmall?.copyWith(
                            color: _kMeasurePanelNavy,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      _MeasurePanelPill(
                        key: const Key('board_canvas_measure_values_count'),
                        label:
                            '$measuredTargetCount / ${targetRows.length} mõõdetud',
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Koht -> Väärtus -> Ühik -> Salvesta',
                    key: const Key('board_canvas_measure_entry_flow_copy'),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: _kBoardCanvasMuted,
                    ),
                  ),
                  const SizedBox(height: 7),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: _kMeasurePanelBodyFill.withValues(alpha: 0.62),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: _kMeasurePanelRule.withValues(alpha: 0.88),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        children: [
                          ...targetRows.map(
                            (row) => Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: _MeasureTargetRow(
                                row: row,
                                selected: row.target == selectedTarget,
                                draftValue:
                                    _draftValuesByTarget[row.target] ?? '',
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
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'AI/photo/trace context is not canonical. Salvesta records only the human-entered measurement.',
                    key: const Key(
                      'board_canvas_measure_canonical_boundary_copy',
                    ),
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: _kBoardCanvasMuted,
                    ),
                  ),
                  const SizedBox(height: 7),
                  DecoratedBox(
                    key: const Key('board_canvas_measure_save_bar'),
                    decoration: BoxDecoration(
                      color: _kMeasurePanelRowFill,
                      borderRadius: BorderRadius.circular(9),
                      border: Border.all(color: _kMeasurePanelRule),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(7),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  saveBlockReason ??
                                      'Valmis mõõtmist salvestama.',
                                  key: const Key(
                                    'board_canvas_measure_save_guard',
                                  ),
                                  style: theme.textTheme.labelMedium?.copyWith(
                                    color: canSaveMeasurement
                                        ? _kMeasurePanelSignal
                                        : _kBoardCanvasMuted,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              OutlinedButton.icon(
                                key: const Key(
                                  'board_canvas_measure_save_button',
                                ),
                                onPressed: canSaveMeasurement &&
                                        selectedTargetRow != null
                                    ? () => _saveMeasurement(
                                          row: selectedTargetRow,
                                          valueText: selectedDraftValue,
                                          unitLabel: selectedDraftUnit,
                                        )
                                    : null,
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: _kMeasurePanelSignal,
                                  disabledForegroundColor: _kBoardCanvasDim,
                                  side: BorderSide(
                                    color: canSaveMeasurement
                                        ? _kMeasurePanelSignal
                                        : _kMeasurePanelRule,
                                  ),
                                  visualDensity: VisualDensity.compact,
                                ),
                                icon: Icon(
                                  _saveInFlight
                                      ? Icons.hourglass_top_rounded
                                      : Icons.save_alt_rounded,
                                  size: 16,
                                ),
                                label: Text(
                                  _saveInFlight ? 'Salvestan...' : 'Salvesta',
                                ),
                              ),
                            ],
                          ),
                          if (_saveStatusMessage != null) ...[
                            const SizedBox(height: 5),
                            Text(
                              _saveStatusMessage!,
                              key: const Key(
                                'board_canvas_measure_save_status',
                              ),
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: _kMeasurePanelSignal,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                          if (_saveErrorMessage != null) ...[
                            const SizedBox(height: 5),
                            Text(
                              _saveErrorMessage!,
                              key: const Key(
                                'board_canvas_measure_save_error',
                              ),
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: const Color(0xFFFCA5A5),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ],
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
                        foregroundColor: _kBoardCanvasMuted,
                        visualDensity: VisualDensity.compact,
                        minimumSize: const Size(0, 30),
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        textStyle: theme.textTheme.labelMedium,
                      ),
                      icon: const Icon(Icons.open_in_new_rounded, size: 16),
                      label: const Text('Jätka mõõtelehel'),
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
                      color: _kMeasurePanelNavy,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Display only; no confirmed connectivity.',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: _kBoardCanvasMuted,
                    ),
                  ),
                  const SizedBox(height: 6),
                  if (contextRows.isEmpty)
                    Text(
                      'No From -> To context for selected component.',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: _kBoardCanvasMuted,
                      ),
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
                  'Tehnilised detailid',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: _kMeasurePanelNavy,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                subtitle: Text(
                  'kirjutuskaitstud päritolu',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: _kBoardCanvasMuted,
                  ),
                ),
                children: [
                  if (widget.relatedVisualTraces.isEmpty &&
                      widget.relatedMeasurements.isEmpty) ...[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'No advanced details for selected component.',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: _kBoardCanvasMuted,
                        ),
                      ),
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
        visualLabel: _visualPointLabel(
          target,
          componentId: componentId,
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
              visualLabel: _visualPointLabel(
                target,
                componentId: componentId,
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
        visualLabel: _visualPointLabel(
          widget.selectedEntry?.placement.componentId ?? 'Select component',
          componentId: componentId,
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

  String _visualPointLabel(
    String target, {
    String? componentId,
  }) {
    final trimmed = target.trim();
    if (componentId != null && trimmed == componentId) {
      return 'Component';
    }
    final separatorIndex = trimmed.lastIndexOf('.');
    if (separatorIndex <= 0 || separatorIndex == trimmed.length - 1) {
      return trimmed;
    }
    return 'Pin ${trimmed.substring(separatorIndex + 1)}';
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
    required this.visualLabel,
    required this.value,
    required this.isExistingValue,
    this.unit,
    this.showExistingUnit = true,
    this.suggestedUnit,
  });

  final String target;
  final String displayLabel;
  final String visualLabel;
  final String value;
  final bool isExistingValue;
  final String? unit;
  final bool showExistingUnit;
  final String? suggestedUnit;
}

class _MeasureUnitSelection {
  const _MeasureUnitSelection({
    required this.label,
    required this.mode,
    required this.schemaUnit,
  });

  final String label;
  final String mode;
  final String schemaUnit;
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
    return const Divider(
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
        color: _kMeasurePanelSignalTint.withValues(alpha: 0.88),
        border: Border.all(color: _kMeasurePanelSignal.withValues(alpha: 0.72)),
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
    required this.selectedEntry,
    required this.selectedName,
    required this.selectedTarget,
    required this.targetRows,
    required this.measurementCount,
    required this.onTargetSelected,
  });

  final _PlacementEntry? selectedEntry;
  final String? selectedName;
  final String? selectedTarget;
  final List<_MeasureTargetRowData> targetRows;
  final int measurementCount;
  final ValueChanged<String> onTargetSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectedRow = _selectedRow;
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
        color: _kBoardCanvasTile,
      ),
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Component visual editing entry is deferred to a later explicit scope.
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
                    SizedBox(
                      key: const Key(
                        'board_canvas_measure_component_left_gutter',
                      ),
                      width: _reservedPinControlGutterWidth,
                      child: Align(
                        alignment: Alignment.center,
                        child: _MeasureVisualPadColumn(
                          rows: leftPads,
                          selectedTarget: selectedTarget,
                          onTargetSelected: onTargetSelected,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: SizedBox(
                        key: const Key(
                          'board_canvas_measure_component_center_slot',
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              height: 82,
                              child: Semantics(
                                label: _componentPreviewSemanticsLabel(
                                  selectedEntry,
                                ),
                                child: CustomPaint(
                                  key: const Key(
                                    'board_canvas_measure_component_footprint_preview',
                                  ),
                                  painter: _FootprintPreviewPainter(
                                    entry: selectedEntry,
                                    selectedTarget: selectedTarget,
                                    selectedTargetLabel: selectedRow
                                                ?.visualLabel ==
                                            null
                                        ? null
                                        : 'selected ${selectedRow!.visualLabel}',
                                    measurementCount: measurementCount,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              selectedTarget == null
                                  ? 'select a local point'
                                  : 'selected ${selectedRow?.visualLabel ?? _targetVisualLabel(selectedTarget!)}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: _kMeasurePanelNavy,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    SizedBox(
                      key: const Key(
                        'board_canvas_measure_component_right_gutter',
                      ),
                      width: _reservedPinControlGutterWidth,
                      child: Align(
                        alignment: Alignment.center,
                        child: _MeasureVisualPadColumn(
                          rows: rightPads,
                          selectedTarget: selectedTarget,
                          onTargetSelected: onTargetSelected,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (selectedEntry != null)
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  'Visual only; contacts not added.',
                  key: const Key(
                    'board_canvas_measure_component_contacts_not_added',
                  ),
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: _kBoardCanvasMuted,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            if (selectedEntry != null)
              Padding(
                padding: const EdgeInsets.only(top: 3),
                child: Text(
                  'Visual only; no connectivity proof.',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: _kBoardCanvasMuted,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  _MeasureTargetRowData? get _selectedRow {
    for (final row in targetRows) {
      if (row.target == selectedTarget) {
        return row;
      }
    }
    return null;
  }

  static String _targetVisualLabel(String target) {
    final dotIndex = target.lastIndexOf('.');
    if (dotIndex <= 0 || dotIndex == target.length - 1) {
      return target;
    }
    return target.substring(dotIndex + 1);
  }
}

String _componentPreviewSemanticsLabel(_PlacementEntry? entry) {
  if (entry == null) {
    return 'Component preview footprint visual: generic component footprint, visual only';
  }
  final kind = _footprintVisualKind(entry);
  final pinRenderPlan = _footprintPinRenderPlan(entry);
  return 'Component preview footprint visual ${_footprintDisplayLabel(entry)}: '
      '${_footprintVisualKindLabel(kind)}, visual only'
      '${pinRenderPlan.semanticsSuffix}';
}

class _FootprintPreviewPainter extends CustomPainter {
  const _FootprintPreviewPainter({
    required this.entry,
    required this.selectedTarget,
    required this.selectedTargetLabel,
    required this.measurementCount,
  });

  final _PlacementEntry? entry;
  final String? selectedTarget;
  final String? selectedTargetLabel;
  final int measurementCount;

  @override
  void paint(Canvas canvas, Size size) {
    final stageRect = Offset.zero & size;
    final stageFillPaint = Paint()
      ..color = _kMeasurePanelBodyFill.withValues(alpha: 0.48)
      ..style = PaintingStyle.fill;
    final stageStrokePaint = Paint()
      ..color = _kMeasurePanelRule.withValues(alpha: 0.78)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    final stageRRect = RRect.fromRectAndRadius(
      stageRect.deflate(0.5),
      const Radius.circular(9),
    );
    canvas.drawRRect(stageRRect, stageFillPaint);
    canvas.drawRRect(stageRRect, stageStrokePaint);

    final visualKind = entry == null
        ? _FootprintVisualKind.generic
        : _footprintVisualKind(entry!);
    final pinRenderPlan = _footprintPinRenderPlan(entry);
    final contactVisibilityState = _contactVisibilityStateForEntry(entry);
    final fixedSlotBodyRect = _previewFootprintBodyRect(visualKind, size);
    final bodySize = fixedSlotBodyRect.size;
    final bodyRect = Rect.fromCenter(
      center: Offset.zero,
      width: bodySize.width,
      height: bodySize.height,
    );
    final fillPaint = Paint()
      ..color = _kBoardCanvasSignalTint.withValues(alpha: 0.78)
      ..style = PaintingStyle.fill;
    final strokePaint = Paint()
      ..color = _kFootprintSelected
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    final padFillPaint = Paint()
      ..color = _kFootprintPad
      ..style = PaintingStyle.fill;
    final padStrokePaint = Paint()
      ..color = _kBoardCanvasSignal
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    final markerPaint = Paint()
      ..color = _kFootprintSelected
      ..style = PaintingStyle.fill;

    canvas.save();
    canvas.translate(fixedSlotBodyRect.center.dx, fixedSlotBodyRect.center.dy);
    // Rotation visual support is intentionally deferred to a later explicit rotation scope.
    // Preview painting stays upright so it matches the Board Canvas footprint renderer.
    _BoardPlacementPainter._drawFootprintBody(
      canvas,
      bodyRect,
      visualKind,
      entry?.template,
      fillPaint,
      strokePaint,
    );
    _BoardPlacementPainter._drawFootprintSurfaceDetails(
      canvas: canvas,
      rect: bodyRect,
      kind: visualKind,
      selected: true,
    );

    if (_shouldDrawFootprintContacts(contactVisibilityState)) {
      if (pinRenderPlan.mode == _FootprintPinRenderMode.templateGeometry) {
        _BoardPlacementPainter._drawTemplatePins(
          canvas: canvas,
          template: pinRenderPlan.template!,
          bodySize: bodySize,
          selectedTarget: selectedTarget,
          fillPaint: padFillPaint,
          strokePaint: padStrokePaint,
        );
        _BoardPlacementPainter._drawOrientationMarker(
          canvas: canvas,
          template: pinRenderPlan.template!,
          bodySize: bodySize,
          markerPaint: markerPaint,
        );
      } else {
        _BoardPlacementPainter._drawDecorativePackagePads(
          canvas: canvas,
          kind: visualKind,
          bodySize: bodySize,
          fillPaint: padFillPaint,
          strokePaint: padStrokePaint,
        );
      }
    }
    _BoardPlacementPainter._drawSelectionRing(
      canvas,
      bodyRect.inflate(_kFootprintSelectionOutset * 0.62),
    );
    _BoardPlacementPainter._drawMeasurementEvidenceCue(
      canvas: canvas,
      bodyRect: bodyRect,
      measurementCount: measurementCount,
      selected: true,
    );
    canvas.restore();

    final label = entry == null
        ? 'component'
        : entry!.component?.designator?.trim().isNotEmpty == true
            ? entry!.component!.designator!.trim()
            : entry!.placement.componentId;
    _paintCenteredPreviewLabel(
      canvas: canvas,
      size: size,
      text: label,
      dy: size.height / 2 - 7,
      color: _kFootprintSelected,
      fontSize: 11,
      fontWeight: FontWeight.w800,
    );

    if (selectedTargetLabel != null) {
      _paintCenteredPreviewLabel(
        canvas: canvas,
        size: size,
        text: selectedTargetLabel!,
        dy: size.height - 18,
        color: _kMeasurePanelNavy,
        fontSize: 9.5,
        fontWeight: FontWeight.w700,
      );
    }
  }

  Size _previewFootprintBodySize(_FootprintVisualKind kind, Size size) {
    final minimumSize = _minimumFootprintVisualEnvelope(kind);
    final availableWidth = math.max(28.0, size.width - 44);
    final availableHeight = math.max(18.0, size.height - 30);
    final scale = math
        .min(
          availableWidth / minimumSize.width,
          availableHeight / minimumSize.height,
        )
        .clamp(1.05, 2.2);
    return Size(minimumSize.width * scale, minimumSize.height * scale);
  }

  Rect _previewFootprintBodyRect(_FootprintVisualKind kind, Size size) {
    final bodySize = _previewFootprintBodySize(kind, size);
    return Rect.fromCenter(
      center: Offset(
        size.width / 2,
        size.height / 2 + _kPreviewFootprintVerticalCenterOffset,
      ),
      width: bodySize.width,
      height: bodySize.height,
    );
  }

  void _paintCenteredPreviewLabel({
    required Canvas canvas,
    required Size size,
    required String text,
    required double dy,
    required Color color,
    required double fontSize,
    required FontWeight fontWeight,
  }) {
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          letterSpacing: 0.3,
        ),
      ),
    )..layout(maxWidth: math.max(1, size.width - 10));
    textPainter.paint(
      canvas,
      Offset((size.width - textPainter.width) / 2, dy),
    );
  }

  @override
  bool shouldRepaint(covariant _FootprintPreviewPainter oldDelegate) {
    return oldDelegate.entry?.key != entry?.key ||
        oldDelegate.selectedTarget != selectedTarget ||
        oldDelegate.selectedTargetLabel != selectedTargetLabel ||
        oldDelegate.measurementCount != measurementCount;
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
            ? _kMeasurePanelSignal
            : row.isExistingValue
                ? _kMeasurePanelSignal.withValues(alpha: 0.22)
                : _kBoardCanvasTile,
        border: Border.all(
          color: selected ? _kMeasurePanelNavy : _kMeasurePanelRule,
          width: selected ? 2.4 : 1,
        ),
        borderRadius: BorderRadius.circular(6),
        boxShadow: selected
            ? [
                BoxShadow(
                  color: _kMeasurePanelSignal.withValues(alpha: 0.34),
                  blurRadius: 11,
                  spreadRadius: 1,
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
              color: selected ? _kBoardCanvasNavyDeep : _kBoardCanvasMuted,
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
            color: selected ? _kMeasurePanelSignal : _kMeasurePanelRule,
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
          color: selected ? _kMeasurePanelNavy : _kBoardCanvasNavy,
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
        width: 152,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: _kMeasurePanelCoolSurface,
            borderRadius: BorderRadius.circular(7),
            border: Border.all(
              color: selected
                  ? _kMeasurePanelSignal.withValues(alpha: 0.7)
                  : _kMeasurePanelRule,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 30,
                    child: TextFormField(
                      key: Key(
                        'board_canvas_measure_row_value_input_${row.target}',
                      ),
                      initialValue: draftValue,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: _kMeasurePanelNavy,
                      ),
                      cursorColor: _kMeasurePanelSignal,
                      decoration: InputDecoration(
                        isDense: true,
                        isCollapsed: true,
                        filled: true,
                        fillColor: _kMeasurePanelRowFill,
                        hintText: 'lisa väärtus',
                        hintStyle: theme.textTheme.labelMedium?.copyWith(
                          color: _kBoardCanvasDim,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: _kMeasurePanelRule,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: _kMeasurePanelSignal,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 7,
                          vertical: 7,
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
                const SizedBox(width: 4),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: _kMeasurePanelRowFill,
                    border: Border.all(
                      color: _kMeasurePanelRule,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: SizedBox(
                    width: 54,
                    height: 30,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        key: Key(
                          'board_canvas_measure_row_unit_select_${row.target}',
                        ),
                        value: unitValue,
                        isDense: true,
                        isExpanded: true,
                        iconSize: 16,
                        dropdownColor: _kMeasurePanelRowRaised,
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: _kMeasurePanelNavy,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        items: unitOptions
                            .map(
                              (unit) => DropdownMenuItem<String>(
                                value: unit,
                                child: Text(
                                  unit,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.labelMedium?.copyWith(
                                    color: _kMeasurePanelNavy,
                                  ),
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
          ),
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

    return InkWell(
      key: Key('board_canvas_measure_target_row_${row.target}'),
      borderRadius: BorderRadius.circular(8),
      onTap: onSelected,
      child: DecoratedBox(
        key: selected
            ? Key('board_canvas_measure_target_row_selected_${row.target}')
            : null,
        decoration: BoxDecoration(
          color: selected
              ? _kMeasurePanelSignalTint
              : row.isExistingValue
                  ? _kMeasurePanelRowRaised
                  : _kMeasurePanelRowFill,
          border: Border.all(
            color: selected
                ? _kMeasurePanelSignal
                : row.isExistingValue
                    ? _kMeasurePanelRule.withValues(alpha: 0.95)
                    : _kMeasurePanelRule.withValues(alpha: 0.72),
            width: selected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: _kMeasurePanelSignal.withValues(alpha: 0.24),
                    blurRadius: 12,
                    offset: const Offset(0, 3),
                  ),
                ]
              : null,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
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
                    color: _kBoardCanvasMuted,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ],
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
        color: _kMeasurePanelRowFill,
        border: Border.all(
          color: _kMeasurePanelRule.withValues(alpha: 0.82),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
        child: Row(
          children: [
            const Icon(
              Icons.alt_route_rounded,
              size: 15,
              color: _kBoardCanvasMuted,
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                row.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: _kBoardCanvasNavy,
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
                  color: _kBoardCanvasMuted,
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
        color: _kMeasurePanelRowRaised,
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
              color: _kMeasurePanelNavy,
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
    final theme = Theme.of(context);

    return Card(
      color: _kBoardCanvasPaper,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: _kBoardCanvasRule),
      ),
      child: DefaultTextStyle.merge(
        style: theme.textTheme.bodyMedium?.copyWith(
          color: _kBoardCanvasMuted,
        ),
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
              _InspectorField(
                  label: 'Placement status', value: placement.status),
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
                _InspectorField(
                    label: 'Scale', value: placement.scale.toString())
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
      ),
    );
  }
}

class _MeasurementSummaryCard extends StatelessWidget {
  const _MeasurementSummaryCard({required this.relatedMeasurements});

  final List<MeasurementFact> relatedMeasurements;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: _kBoardCanvasPaper,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: _kBoardCanvasRule),
      ),
      child: DefaultTextStyle.merge(
        style: theme.textTheme.bodyMedium?.copyWith(
          color: _kBoardCanvasMuted,
        ),
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
      ),
    );
  }
}

class _VisualTraceMetadataCard extends StatelessWidget {
  const _VisualTraceMetadataCard({required this.relatedVisualTraces});

  final List<VisualTraceFact> relatedVisualTraces;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: _kBoardCanvasPaper,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: _kBoardCanvasRule),
      ),
      child: DefaultTextStyle.merge(
        style: theme.textTheme.bodyMedium?.copyWith(
          color: _kBoardCanvasMuted,
        ),
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
          border: Border.all(color: _kBoardCanvasRule),
          color: _kBoardCanvasTile,
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
                style: theme.textTheme.titleSmall?.copyWith(
                  color: _kBoardCanvasNavy,
                  fontWeight: FontWeight.w700,
                ),
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
            style: theme.textTheme.bodySmall?.copyWith(
              color: _kBoardCanvasMuted,
            ),
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
        color: _kBoardCanvasTile,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: _kBoardCanvasRule),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: _kBoardCanvasNavy,
            fontWeight: FontWeight.w700,
          ),
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
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: _kBoardCanvasMuted,
            ),
      ),
    );
  }
}

class _KnownPinVisualRef {
  const _KnownPinVisualRef({
    required this.pinId,
    required this.visualLabel,
  });

  final String pinId;
  final String visualLabel;
}

Map<String, List<_KnownPinVisualRef>> _knownPinVisualRefsByComponentId(
  KnownFacts knownFacts,
) {
  final refsByComponentId = <String, List<_KnownPinVisualRef>>{};
  final seenByComponentId = <String, Set<String>>{};

  void addRef(String componentId, String pinId) {
    final trimmedComponentId = componentId.trim();
    final trimmedPinId = pinId.trim();
    if (trimmedComponentId.isEmpty || trimmedPinId.isEmpty) {
      return;
    }
    final seen = seenByComponentId.putIfAbsent(trimmedComponentId, () => {});
    if (!seen.add(trimmedPinId)) {
      return;
    }
    refsByComponentId.putIfAbsent(trimmedComponentId, () => []).add(
          _KnownPinVisualRef(
            pinId: trimmedPinId,
            visualLabel: _knownPinVisualLabel(trimmedPinId),
          ),
        );
  }

  for (final entry in knownFacts.componentPinIndex.entries) {
    for (final pinId in entry.value) {
      addRef(entry.key, pinId);
    }
  }

  for (final pin in knownFacts.pins) {
    addRef(pin.componentId, pin.pinId);
  }

  return {
    for (final entry in refsByComponentId.entries)
      entry.key: List.unmodifiable(entry.value),
  };
}

String _knownPinVisualLabel(String pinId) {
  final dotIndex = pinId.lastIndexOf('.');
  if (dotIndex <= 0 || dotIndex == pinId.length - 1) {
    return pinId;
  }
  return 'Pin ${pinId.substring(dotIndex + 1)}';
}

class _PlacementEntry {
  const _PlacementEntry({
    required this.placement,
    required this.component,
    required this.template,
    required this.knownPins,
  });

  final ComponentVisualPlacementFact placement;
  final ComponentFact? component;
  final FootprintTemplate? template;
  final List<_KnownPinVisualRef> knownPins;

  String get key => '${placement.componentId}|${placement.sourceEventId}';

  String get selectorLabel {
    final designator = component?.designator?.trim();
    if (designator != null && designator.isNotEmpty) {
      return '$designator (${placement.componentId})';
    }
    return placement.componentId;
  }
}

class _PlacementSaveTarget {
  const _PlacementSaveTarget({
    required this.componentId,
    required this.coordinateSpace,
    required this.boardSide,
    required this.existingCenterX,
    required this.existingCenterY,
    required this.sourcePhotoId,
    required this.requiresExplicitAnchor,
    required this.sourceEntry,
  });

  factory _PlacementSaveTarget.fromEntry(_PlacementEntry entry) {
    final placement = entry.placement;
    return _PlacementSaveTarget(
      componentId: placement.componentId,
      coordinateSpace: placement.coordinateSpace,
      boardSide: placement.boardSide,
      existingCenterX: placement.centerX.toDouble(),
      existingCenterY: placement.centerY.toDouble(),
      sourcePhotoId: placement.sourcePhotoId,
      requiresExplicitAnchor: false,
      sourceEntry: entry,
    );
  }

  factory _PlacementSaveTarget.firstBoardPlacement({
    required String componentId,
  }) {
    return _PlacementSaveTarget(
      componentId: componentId,
      coordinateSpace: 'board_normalized',
      boardSide: 'unknown',
      existingCenterX: null,
      existingCenterY: null,
      sourcePhotoId: null,
      requiresExplicitAnchor: true,
      sourceEntry: null,
    );
  }

  final String componentId;
  final String coordinateSpace;
  final String boardSide;
  final double? existingCenterX;
  final double? existingCenterY;
  final String? sourcePhotoId;
  final bool requiresExplicitAnchor;
  final _PlacementEntry? sourceEntry;
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
  final bodySize = _renderedFootprintVisualSize(entry);
  final translated = position - center;
  // Rotation visual support is intentionally deferred to a later explicit rotation scope.
  // Keep hit testing aligned with the upright footprint rendered in this pass.
  final localPosition = translated;
  return Rect.fromCenter(
    center: Offset.zero,
    width: bodySize.width,
    height: bodySize.height,
  ).contains(localPosition);
}

enum _FootprintVisualKind {
  testPoint,
  passive2,
  capacitor,
  diode,
  transistor3,
  icDualSide,
  icQuadSide,
  smallMultiPin,
  connector,
  switchPackage,
  moduleBlock,
  mechanical,
  denseGrid,
  generic,
}

const Color _kFootprintSilk = Color(0xFFD3CD9A);
const Color _kFootprintPad = Color(0xFF74E0A6);
const Color _kFootprintCopper = Color(0xFFD8A24A);
const Color _kFootprintSelected = _kBoardCanvasSignal;
const Color _kFootprintFallback = Color(0xFF93A3B3);
const double _kFootprintSelectionOutset = 8;

enum _FootprintPinRenderMode {
  templateGeometry,
  knownPinList,
  none,
}

enum _ContactVisibilityState {
  bodyOnly,
  draftContacts,
  confirmedVisualContacts,
  verifiedAnchorsAvailable,
}

_ContactVisibilityState _contactVisibilityStateForEntry(_PlacementEntry? _) {
  // Current projection data has no confirmed visual-contact layout field.
  // Template pins, measurement pins, and user_confirmed_visual placement status
  // stay body-only until a future explicit visual-contact confirmation flow.
  return _ContactVisibilityState.bodyOnly;
}

bool _shouldDrawFootprintContacts(_ContactVisibilityState state) {
  switch (state) {
    case _ContactVisibilityState.bodyOnly:
    case _ContactVisibilityState.draftContacts:
      return false;
    case _ContactVisibilityState.confirmedVisualContacts:
    case _ContactVisibilityState.verifiedAnchorsAvailable:
      return true;
  }
}

class _FootprintPinRenderPlan {
  const _FootprintPinRenderPlan({
    required this.mode,
    required this.template,
    required this.knownPins,
  });

  const _FootprintPinRenderPlan.none()
      : mode = _FootprintPinRenderMode.none,
        template = null,
        knownPins = const [];

  final _FootprintPinRenderMode mode;
  final FootprintTemplate? template;
  final List<_KnownPinVisualRef> knownPins;

  int get pinCount {
    switch (mode) {
      case _FootprintPinRenderMode.templateGeometry:
        return template?.pinAnchors.length ?? 0;
      case _FootprintPinRenderMode.knownPinList:
        return knownPins.length;
      case _FootprintPinRenderMode.none:
        return 0;
    }
  }

  bool get hasVerifiedGeometry => false;

  String get semanticsSuffix {
    switch (mode) {
      case _FootprintPinRenderMode.templateGeometry:
        return '; contacts not added; template pins are not rendered before confirmed visual contacts';
      case _FootprintPinRenderMode.knownPinList:
        return '; $pinCount known pin ${pinCount == 1 ? 'identity' : 'identities'} listed separately; contacts not added';
      case _FootprintPinRenderMode.none:
        return '; contacts not added';
    }
  }
}

_FootprintPinRenderPlan _footprintPinRenderPlan(_PlacementEntry? entry) {
  if (entry == null) {
    return const _FootprintPinRenderPlan.none();
  }
  final knownPinCount = entry.knownPins.length;

  if (knownPinCount > 0) {
    return _FootprintPinRenderPlan(
      mode: _FootprintPinRenderMode.knownPinList,
      template: null,
      knownPins: entry.knownPins,
    );
  }

  return const _FootprintPinRenderPlan.none();
}

bool _templatePinMatchesTarget(FootprintPinAnchor pin, String? selectedTarget) {
  if (selectedTarget == null || selectedTarget.trim().isEmpty) {
    return false;
  }
  final pinNumber = pin.pinNumber.toString();
  final trimmed = selectedTarget.trim();
  return trimmed == pinNumber ||
      trimmed.endsWith('.$pinNumber') ||
      trimmed.toLowerCase() == 'pin $pinNumber';
}

Size _renderedFootprintVisualSize(_PlacementEntry entry) {
  final bodySize = _renderedPlacementBodySize(entry);
  final minimumSize =
      _minimumFootprintVisualEnvelope(_footprintVisualKind(entry));
  return Size(
    math.max(bodySize.width, minimumSize.width),
    math.max(bodySize.height, minimumSize.height),
  );
}

Size _minimumFootprintVisualEnvelope(_FootprintVisualKind visualKind) {
  switch (visualKind) {
    case _FootprintVisualKind.icDualSide:
      return const Size(56, 40);
    case _FootprintVisualKind.icQuadSide:
      return const Size(60, 44);
    case _FootprintVisualKind.smallMultiPin:
      return const Size(34, 24);
    case _FootprintVisualKind.passive2:
    case _FootprintVisualKind.diode:
      return const Size(44, 18);
    case _FootprintVisualKind.capacitor:
      return const Size(40, 40);
    case _FootprintVisualKind.transistor3:
      return const Size(52, 40);
    case _FootprintVisualKind.connector:
      return const Size(44, 22);
    case _FootprintVisualKind.testPoint:
      return const Size(22, 22);
    case _FootprintVisualKind.switchPackage:
      return const Size(36, 24);
    case _FootprintVisualKind.moduleBlock:
      return const Size(56, 40);
    case _FootprintVisualKind.mechanical:
      return const Size(20, 20);
    case _FootprintVisualKind.denseGrid:
      return const Size(48, 48);
    case _FootprintVisualKind.generic:
      return const Size(32, 22);
  }
}

_FootprintVisualKind _footprintVisualKind(_PlacementEntry entry) {
  final designator = (entry.component?.designator ?? '').trim().toUpperCase();
  final componentId = entry.placement.componentId.trim().toUpperCase();
  final templateId = (entry.placement.templateId ?? '').trim().toLowerCase();
  final templateName = (entry.template?.templateId ?? '').trim().toLowerCase();
  final marker = '$designator $componentId $templateId $templateName';
  final markerLower = marker.toLowerCase();
  final componentIdTokens = componentId
      .split(RegExp(r'[^A-Z0-9]+'))
      .where((token) => token.isNotEmpty)
      .toList(growable: false);
  final componentRef =
      componentIdTokens.isEmpty ? componentId : componentIdTokens.last;

  bool hasReferencePrefix(String prefix) {
    final upperPrefix = prefix.toUpperCase();
    return designator.startsWith(upperPrefix) ||
        componentRef.startsWith(upperPrefix);
  }

  final templateVisualKind = _footprintVisualKindByTemplateId(templateId) ??
      _footprintVisualKindByTemplateId(templateName);

  if (hasReferencePrefix('TP') ||
      designator == 'GND' ||
      componentRef == 'GND' ||
      markerLower.contains('testpoint') ||
      markerLower.contains('test point') ||
      markerLower.contains('test-point') ||
      markerLower.contains('ground') ||
      markerLower.contains('gnd')) {
    return _FootprintVisualKind.testPoint;
  }
  if (hasReferencePrefix('J') ||
      hasReferencePrefix('JP') ||
      hasReferencePrefix('CN')) {
    return _FootprintVisualKind.connector;
  }
  if (templateVisualKind != null) {
    return templateVisualKind;
  }
  if (hasReferencePrefix('Q') ||
      markerLower.contains('mosfet') ||
      markerLower.contains('transistor')) {
    final pinCount = entry.template?.pinAnchors.length ?? 0;
    if (pinCount > 4) {
      return _FootprintVisualKind.icDualSide;
    }
    return _FootprintVisualKind.transistor3;
  }
  if (hasReferencePrefix('U') || hasReferencePrefix('IC')) {
    final markerHasSoic = markerLower.contains('soic') ||
        markerLower.contains('dip') ||
        markerLower.contains('tssop') ||
        markerLower.contains('so-ic');
    final markerHasQfn = markerLower.contains('qfp') ||
        markerLower.contains('qfn') ||
        markerLower.contains('densegrid') ||
        markerLower.contains('bga');
    if (markerHasQfn) {
      return _FootprintVisualKind.icQuadSide;
    }
    if (markerHasSoic) {
      return _FootprintVisualKind.icDualSide;
    }
    final pinCount = entry.template?.pinAnchors.length ?? 0;
    if (pinCount >= 8) {
      return _FootprintVisualKind.icDualSide;
    }
    if (pinCount == 5 || pinCount == 6) {
      return _FootprintVisualKind.smallMultiPin;
    }
    return _FootprintVisualKind.icDualSide;
  }
  if (hasReferencePrefix('R')) {
    return _FootprintVisualKind.passive2;
  }
  if (hasReferencePrefix('C')) {
    return _FootprintVisualKind.capacitor;
  }
  if (hasReferencePrefix('D')) {
    return _FootprintVisualKind.diode;
  }
  if (hasReferencePrefix('SW') || hasReferencePrefix('S')) {
    return _FootprintVisualKind.switchPackage;
  }
  if (hasReferencePrefix('MH') || hasReferencePrefix('FID')) {
    return _FootprintVisualKind.mechanical;
  }
  if (hasReferencePrefix('K')) {
    return _FootprintVisualKind.moduleBlock;
  }

  final pinCount = entry.template?.pinAnchors.length ?? 0;
  if (markerLower.contains('connector') || markerLower.contains('header')) {
    return _FootprintVisualKind.connector;
  }
  if (markerLower.contains('capacitor') ||
      markerLower.contains('cap_') ||
      markerLower.contains('cap-')) {
    return _FootprintVisualKind.capacitor;
  }
  if (markerLower.contains('resistor') || markerLower.contains('passive')) {
    return _FootprintVisualKind.passive2;
  }
  if (markerLower.contains('diode')) {
    return _FootprintVisualKind.diode;
  }
  if (pinCount >= 3 ||
      markerLower.contains('sot') ||
      markerLower.contains('soic') ||
      markerLower.contains('qfp') ||
      markerLower.contains('qfn') ||
      markerLower.contains('dip')) {
    return markerLower.contains('qfp') || markerLower.contains('qfn')
        ? _FootprintVisualKind.icQuadSide
        : _FootprintVisualKind.icDualSide;
  }

  return _FootprintVisualKind.generic;
}

_FootprintVisualKind? _footprintVisualKindByTemplateId(String templateId) {
  if (templateId.trim().isEmpty) {
    return null;
  }
  switch (templateId) {
    case 'unknown_rect':
      return _FootprintVisualKind.generic;
    case 'unknown_2pin':
      return _FootprintVisualKind.passive2;
    case 'unknown_3pin':
      return _FootprintVisualKind.transistor3;
    case 'unknown_multi_pin':
      return _FootprintVisualKind.smallMultiPin;
    case 'chip_0402':
    case 'chip_0603':
    case 'chip_0805':
    case 'chip_1206':
    case 'two_pin_smd':
    case 'two_pin_axial':
      return _FootprintVisualKind.passive2;
    case 'sot23_3':
      return _FootprintVisualKind.transistor3;
    case 'sot23_5':
    case 'sot223':
      return _FootprintVisualKind.smallMultiPin;
    case 'soic_8':
    case 'soic_14':
    case 'soic_16':
      return _FootprintVisualKind.icDualSide;
    case 'header_1xn':
    case 'header_2xn':
      return _FootprintVisualKind.connector;
    default:
      return null;
  }
}

String _footprintVisualKindLabel(_FootprintVisualKind kind) {
  switch (kind) {
    case _FootprintVisualKind.testPoint:
      return 'test point / ground footprint';
    case _FootprintVisualKind.passive2:
      return 'passive 2-terminal footprint';
    case _FootprintVisualKind.capacitor:
      return 'capacitor footprint';
    case _FootprintVisualKind.diode:
      return 'diode footprint';
    case _FootprintVisualKind.transistor3:
      return 'transistor 3-terminal footprint';
    case _FootprintVisualKind.icDualSide:
      return 'IC / dual-side package footprint';
    case _FootprintVisualKind.icQuadSide:
      return 'IC / quad-side package footprint';
    case _FootprintVisualKind.smallMultiPin:
      return 'small multi-pin package footprint';
    case _FootprintVisualKind.connector:
      return 'connector / header footprint';
    case _FootprintVisualKind.switchPackage:
      return 'switch package footprint';
    case _FootprintVisualKind.moduleBlock:
      return 'module / relay / transformer footprint';
    case _FootprintVisualKind.mechanical:
      return 'mechanical / mounting footprint';
    case _FootprintVisualKind.denseGrid:
      return 'dense grid footprint';
    case _FootprintVisualKind.generic:
      return 'generic component footprint';
  }
}

String _footprintDisplayLabel(_PlacementEntry entry) {
  final designator = entry.component?.designator?.trim();
  final componentId = entry.placement.componentId;
  if (designator != null && designator.isNotEmpty) {
    return '$designator ($componentId)';
  }
  return componentId;
}

String _footprintSemanticsLabel(_PlacementEntry entry) {
  final kind = _footprintVisualKind(entry);
  final pinRenderPlan = _footprintPinRenderPlan(entry);
  return 'Board Canvas footprint visual ${_footprintDisplayLabel(entry)}: '
      '${_footprintVisualKindLabel(kind)}, visual only'
      '${pinRenderPlan.semanticsSuffix}';
}

class _BoardPlacementPainter extends CustomPainter {
  _BoardPlacementPainter({
    required this.entries,
    required this.selectedKey,
    required this.selectedComponentId,
    required this.previewKeys,
    required this.measurementCountsByComponentId,
    required this.colorScheme,
  });

  final List<_PlacementEntry> entries;
  final String? selectedKey;
  final String? selectedComponentId;
  final Set<String> previewKeys;
  final Map<String, int> measurementCountsByComponentId;
  final ColorScheme colorScheme;

  Color get componentSelectionColor => _kFootprintSelected;
  Color get placementSelectionColor => _kFootprintSelected;
  Color get hoverPreviewColor => const Color(0xFF9CB4AD);
  double get componentSelectionStrokeWidth => 1.6;
  double get placementSelectionStrokeWidth => 2.4;

  Set<String> get dimmedPlacementKeys {
    final componentId = selectedComponentId;
    final placementKey = selectedKey;
    if (componentId == null || placementKey == null) {
      return const <String>{};
    }
    return entries
        .where(
          (entry) =>
              entry.placement.componentId == componentId &&
              entry.key != placementKey,
        )
        .map((entry) => entry.key)
        .toSet();
  }

  @override
  void paint(Canvas canvas, Size size) {
    final boardRect = Rect.fromLTWH(0, 0, size.width, size.height);

    const boardBase = Color(0xFF060A08);
    const boardInset = Color(0xFF0A1712);
    const boardBorder = Color(0xFF243D35);
    const gridColor = Color(0x224D7A65);

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
      final center = _renderedPlacementCenter(entry, size);
      final bodySize = _renderedFootprintVisualSize(entry);
      final selected = entry.key == selectedKey;
      final componentSelected =
          entry.placement.componentId == selectedComponentId;
      final componentOnlySelected = componentSelected && selectedKey == null;
      final siblingDimmed =
          componentSelected && selectedKey != null && !selected;
      final previewed = previewKeys.contains(entry.key) &&
          !selected &&
          !componentOnlySelected &&
          !siblingDimmed;
      final emphasized = selected || componentOnlySelected;
      final visualKind = _footprintVisualKind(entry);
      final pinRenderPlan = _footprintPinRenderPlan(entry);
      final contactVisibilityState = _contactVisibilityStateForEntry(entry);

      final fillPaint = Paint()
        ..color = emphasized
            ? _kBoardCanvasSignalTint.withValues(
                alpha: selected ? 0.82 : 0.54,
              )
            : _kFootprintSilk.withValues(
                alpha: siblingDimmed ? 0.025 : 0.07,
              )
        ..style = PaintingStyle.fill;

      final strokePaint = Paint()
        ..color = emphasized
            ? _kFootprintSelected.withValues(
                alpha: selected ? 1 : 0.86,
              )
            : _kFootprintSilk.withValues(
                alpha: siblingDimmed ? 0.3 : 0.82,
              )
        ..style = PaintingStyle.stroke
        ..strokeWidth = selected ? 2.8 : (componentOnlySelected ? 2 : 1.3);

      final padFillPaint = Paint()
        ..color = emphasized
            ? _kFootprintPad
            : _kFootprintPad.withValues(alpha: siblingDimmed ? 0.32 : 0.88)
        ..style = PaintingStyle.fill;

      final padStrokePaint = Paint()
        ..color = emphasized
            ? _kBoardCanvasSignal
            : _kBoardCanvasNavyDeep.withValues(
                alpha: siblingDimmed ? 0.35 : 1,
              )
        ..style = PaintingStyle.stroke
        ..strokeWidth = emphasized ? 1.1 : 0.8;

      final markerPaint = Paint()
        ..color = emphasized
            ? _kFootprintSelected
            : _kFootprintSilk.withValues(
                alpha: siblingDimmed ? 0.28 : 0.74,
              )
        ..style = PaintingStyle.fill;

      canvas.save();
      canvas.translate(center.dx, center.dy);
      // Rotation visual support is intentionally deferred to a later explicit rotation scope.
      // The stored rotationDeg metadata remains available to inspector/projection code,
      // but footprint painting stays upright in this pass.

      final rect = Rect.fromCenter(
        center: Offset.zero,
        width: bodySize.width,
        height: bodySize.height,
      );
      final measurementCount =
          measurementCountsByComponentId[entry.placement.componentId] ?? 0;
      _drawFootprintBody(
        canvas,
        rect,
        visualKind,
        entry.template,
        fillPaint,
        strokePaint,
      );
      _drawFootprintSurfaceDetails(
        canvas: canvas,
        rect: rect,
        kind: visualKind,
        selected: emphasized,
      );

      if (_shouldDrawFootprintContacts(contactVisibilityState)) {
        if (pinRenderPlan.mode == _FootprintPinRenderMode.templateGeometry) {
          _drawTemplatePins(
            canvas: canvas,
            template: pinRenderPlan.template!,
            bodySize: bodySize,
            selectedTarget: null,
            fillPaint: padFillPaint,
            strokePaint: padStrokePaint,
          );
          _drawOrientationMarker(
            canvas: canvas,
            template: pinRenderPlan.template!,
            bodySize: bodySize,
            markerPaint: markerPaint,
          );
        } else {
          _drawDecorativePackagePads(
            canvas: canvas,
            kind: visualKind,
            bodySize: bodySize,
            fillPaint: padFillPaint,
            strokePaint: padStrokePaint,
          );
        }
      }
      _drawMeasurementEvidenceCue(
        canvas: canvas,
        bodyRect: rect,
        measurementCount: measurementCount,
        selected: emphasized,
      );

      if (selected) {
        _drawSelectionRing(
          canvas,
          rect.inflate(_kFootprintSelectionOutset),
          color: placementSelectionColor,
          strokeWidth: placementSelectionStrokeWidth,
        );
      } else if (componentOnlySelected) {
        _drawComponentSelectionRing(
          canvas,
          rect.inflate(_kFootprintSelectionOutset),
        );
      } else if (previewed) {
        _drawHoverPreviewRing(
          canvas,
          rect.inflate(_kFootprintSelectionOutset),
        );
      }

      canvas.restore();

      final designator = entry.component?.designator;
      if (designator != null && designator.trim().isNotEmpty) {
        final textPainter = TextPainter(
          textDirection: TextDirection.ltr,
          text: TextSpan(
            text: designator,
            style: TextStyle(
              color: emphasized
                  ? _kFootprintSelected
                  : _kFootprintSilk.withValues(
                      alpha: siblingDimmed ? 0.34 : 0.9,
                    ),
              fontSize: emphasized ? 11 : 10.5,
              fontWeight: emphasized ? FontWeight.w800 : FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
        )..layout(maxWidth: 120);
        textPainter.paint(
          canvas,
          Offset(
            (center.dx - textPainter.width / 2)
                .clamp(0.0, math.max(0.0, size.width - textPainter.width)),
            (center.dy - textPainter.height / 2)
                .clamp(0.0, math.max(0.0, size.height - textPainter.height)),
          ),
        );
      }
    }
  }

  static void _drawFootprintBody(
    Canvas canvas,
    Rect rect,
    _FootprintVisualKind visualKind,
    FootprintTemplate? template,
    Paint fillPaint,
    Paint strokePaint,
  ) {
    if (visualKind == _FootprintVisualKind.generic) {
      final genericStroke = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.1
        ..strokeJoin = StrokeJoin.round
        ..color = _kFootprintFallback.withValues(alpha: 0.78);
      _drawDashedRRect(
        canvas,
        RRect.fromRectAndRadius(rect, const Radius.circular(8)),
        genericStroke,
        dash: 4.6,
        gap: 3.2,
      );
      return;
    }

    if (visualKind == _FootprintVisualKind.testPoint) {
      final center = rect.center;
      final radius = math.min(rect.width, rect.height) / 2;
      final ringFillPaint = Paint()
        ..style = PaintingStyle.fill
        ..color = fillPaint.color.withValues(alpha: 0.62);
      final innerStrokePaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.9
        ..color = strokePaint.color.withValues(alpha: 0.72);
      canvas.drawCircle(center, radius * 0.82, ringFillPaint);
      canvas.drawCircle(center, radius * 0.82, strokePaint);
      canvas.drawCircle(center, radius * 0.42, innerStrokePaint);
      return;
    }

    if (visualKind == _FootprintVisualKind.capacitor &&
        (rect.width - rect.height).abs() <=
            math.max(rect.width, rect.height) * 0.35) {
      canvas.drawOval(rect, fillPaint);
      canvas.drawOval(rect, strokePaint);
      return;
    }

    final bodyShape = visualKind == _FootprintVisualKind.connector
        ? FootprintBodyShape.rect
        : template?.body.shape ?? FootprintBodyShape.roundedRect;
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

  static void _drawSelectionRing(
    Canvas canvas,
    Rect rect, {
    Color color = _kFootprintSelected,
    double strokeWidth = 2.4,
  }) {
    final ring = RRect.fromRectAndRadius(rect, const Radius.circular(10));
    final glowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..color = color.withValues(alpha: 0.32)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
    canvas.drawRRect(ring, glowPaint);
    final ringPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..color = color;
    canvas.drawRRect(ring, ringPaint);
  }

  void _drawComponentSelectionRing(Canvas canvas, Rect rect) {
    final ringPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = componentSelectionStrokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..color = componentSelectionColor.withValues(alpha: 0.82);
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(10)),
      ringPaint,
    );
  }

  void _drawHoverPreviewRing(Canvas canvas, Rect rect) {
    final ringPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..color = hoverPreviewColor.withValues(alpha: 0.92);
    _drawDashedRRect(
      canvas,
      RRect.fromRectAndRadius(rect, const Radius.circular(10)),
      ringPaint,
      dash: 4,
      gap: 3,
    );
  }

  static void _drawMeasurementEvidenceCue({
    required Canvas canvas,
    required Rect bodyRect,
    required int measurementCount,
    required bool selected,
  }) {
    if (measurementCount < 1) {
      return;
    }

    final cueFill = Paint()
      ..color = _kFootprintCopper.withValues(alpha: selected ? 0.95 : 0.74)
      ..style = PaintingStyle.fill;
    final cueStroke = Paint()
      ..color = _kBoardCanvasPaper.withValues(alpha: selected ? 0.96 : 0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;
    const cueHeight = 7.0;
    final cueWidth = math.min(18.0, 7.0 + measurementCount * 2.2);
    final cueRect = Rect.fromLTWH(
      (bodyRect.right - cueWidth * 0.88).clamp(0.0, double.infinity),
      (bodyRect.top - cueHeight * 0.6).clamp(0.0, double.infinity),
      cueWidth,
      cueHeight,
    );
    final cueRRect = RRect.fromRectAndRadius(
      cueRect,
      const Radius.circular(cueHeight / 2),
    );
    canvas.drawRRect(cueRRect, cueFill);
    canvas.drawRRect(cueRRect, cueStroke);

    if (measurementCount == 1) {
      canvas.drawCircle(
        Offset(bodyRect.right - (cueWidth * 0.45), bodyRect.top + 0.2),
        1.8,
        Paint()
          ..color = selected
              ? Colors.white
              : _kBoardCanvasNavy.withValues(alpha: 0.78)
          ..style = PaintingStyle.fill,
      );
      return;
    }

    final cueTextPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
      text: TextSpan(
        text: measurementCount.toString(),
        style: TextStyle(
          color: selected ? _kBoardCanvasNavy : const Color(0xFF0F1F1F),
          fontSize: 5.2,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.1,
        ),
      ),
    )..layout(maxWidth: cueWidth - 2);
    cueTextPainter.paint(
      canvas,
      Offset(
        cueRect.left + (cueWidth - cueTextPainter.width) / 2,
        cueRect.center.dy - cueTextPainter.height / 2 + 0.2,
      ),
    );
    canvas.drawCircle(
      Offset(bodyRect.right - cueWidth / 5, bodyRect.top - cueHeight * 0.32),
      0.8,
      Paint()
        ..color =
            selected ? Colors.white : _kBoardCanvasNavy.withValues(alpha: 0.78)
        ..style = PaintingStyle.fill,
    );
  }

  static void _drawDashedRRect(
    Canvas canvas,
    RRect rrect,
    Paint paint, {
    required double dash,
    required double gap,
  }) {
    final path = Path()..addRRect(rrect);
    for (final metric in path.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        final next = math.min(distance + dash, metric.length);
        canvas.drawPath(metric.extractPath(distance, next), paint);
        distance += dash + gap;
      }
    }
  }

  static void _drawFootprintSurfaceDetails({
    required Canvas canvas,
    required Rect rect,
    required _FootprintVisualKind kind,
    required bool selected,
  }) {
    final detailPaint = Paint()
      ..color = (selected ? _kFootprintSelected : _kFootprintSilk)
          .withValues(alpha: selected ? 0.72 : 0.52)
      ..style = PaintingStyle.stroke
      ..strokeWidth = selected ? 1.4 : 1.0;
    final mutedDetailPaint = Paint()
      ..color = _kFootprintCopper.withValues(alpha: selected ? 0.42 : 0.28)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;

    switch (kind) {
      case _FootprintVisualKind.icDualSide:
      case _FootprintVisualKind.icQuadSide:
        final notchRadius =
            math.min(rect.width, rect.height).clamp(4.0, 12.0) / 2;
        canvas.drawArc(
          Rect.fromCenter(
            center: Offset(rect.left + rect.width / 2, rect.top),
            width: notchRadius * 3,
            height: notchRadius * 2,
          ),
          0,
          math.pi,
          false,
          detailPaint,
        );
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            rect.deflate(math.min(rect.width, rect.height) * 0.18),
            const Radius.circular(2),
          ),
          mutedDetailPaint,
        );
        break;
      case _FootprintVisualKind.passive2:
      case _FootprintVisualKind.smallMultiPin:
      case _FootprintVisualKind.switchPackage:
      case _FootprintVisualKind.denseGrid:
      case _FootprintVisualKind.mechanical:
      case _FootprintVisualKind.moduleBlock:
        for (final fraction in const [0.36, 0.5, 0.64]) {
          final x = rect.left + rect.width * fraction;
          canvas.drawLine(
            Offset(x, rect.top + rect.height * 0.18),
            Offset(x, rect.bottom - rect.height * 0.18),
            fraction == 0.5 ? detailPaint : mutedDetailPaint,
          );
        }
        break;
      case _FootprintVisualKind.capacitor:
        final centerX = rect.center.dx;
        canvas.drawLine(
          Offset(centerX - 2, rect.top + rect.height * 0.18),
          Offset(centerX - 2, rect.bottom - rect.height * 0.18),
          detailPaint,
        );
        canvas.drawLine(
          Offset(centerX + 4, rect.top + rect.height * 0.18),
          Offset(centerX + 4, rect.bottom - rect.height * 0.18),
          mutedDetailPaint,
        );
        break;
      case _FootprintVisualKind.diode:
        final stripeX = rect.right - rect.width * 0.22;
        canvas.drawLine(
          Offset(stripeX, rect.top + rect.height * 0.16),
          Offset(stripeX, rect.bottom - rect.height * 0.16),
          detailPaint,
        );
        canvas.drawLine(
          Offset(rect.left + rect.width * 0.24, rect.center.dy),
          Offset(stripeX - rect.width * 0.08, rect.center.dy),
          mutedDetailPaint,
        );
        break;
      case _FootprintVisualKind.transistor3:
        final centerX = rect.center.dx;
        final topY = rect.top + rect.height * 0.2;
        final bottomY = rect.bottom - rect.height * 0.2;
        canvas.drawLine(
          Offset(centerX, topY),
          Offset(centerX, bottomY),
          detailPaint,
        );
        canvas.drawLine(
          Offset(rect.left + rect.width * 0.24, rect.center.dy),
          Offset(centerX, rect.center.dy),
          mutedDetailPaint,
        );
        canvas.drawLine(
          Offset(centerX, rect.center.dy),
          Offset(rect.right - rect.width * 0.22, topY),
          mutedDetailPaint,
        );
        canvas.drawLine(
          Offset(centerX, rect.center.dy),
          Offset(rect.right - rect.width * 0.22, bottomY),
          mutedDetailPaint,
        );
        break;
      case _FootprintVisualKind.connector:
        final slotRect = rect.deflate(math.min(rect.width, rect.height) * 0.22);
        canvas.drawRRect(
          RRect.fromRectAndRadius(slotRect, const Radius.circular(2)),
          mutedDetailPaint,
        );
        break;
      case _FootprintVisualKind.testPoint:
        canvas.drawLine(
          Offset(rect.center.dx, rect.top + rect.height * 0.22),
          Offset(rect.center.dx, rect.bottom - rect.height * 0.22),
          mutedDetailPaint,
        );
        canvas.drawLine(
          Offset(rect.left + rect.width * 0.22, rect.center.dy),
          Offset(rect.right - rect.width * 0.22, rect.center.dy),
          mutedDetailPaint,
        );
        break;
      case _FootprintVisualKind.generic:
        canvas.drawLine(rect.topLeft, rect.bottomRight, mutedDetailPaint);
        canvas.drawLine(rect.topRight, rect.bottomLeft, mutedDetailPaint);
        break;
    }
  }

  static void _drawDecorativePackagePads({
    required Canvas canvas,
    required _FootprintVisualKind kind,
    required Size bodySize,
    required Paint fillPaint,
    required Paint strokePaint,
  }) {
    final decorativeFillPaint = Paint()
      ..color = fillPaint.color.withValues(alpha: 0.86)
      ..style = PaintingStyle.fill;
    final decorativeStrokePaint = Paint()
      ..color = strokePaint.color.withValues(alpha: 0.82)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;

    void drawPad(Rect rect, {bool oval = false}) {
      if (oval) {
        canvas.drawOval(rect, decorativeFillPaint);
        canvas.drawOval(rect, decorativeStrokePaint);
        return;
      }
      final rrect = RRect.fromRectAndRadius(
        rect,
        Radius.circular(math.min(rect.width, rect.height) * 0.3),
      );
      canvas.drawRRect(rrect, decorativeFillPaint);
      canvas.drawRRect(rrect, decorativeStrokePaint);
    }

    void drawEndPads({bool oval = false}) {
      final padWidth = math.min(7.0, math.max(4.0, bodySize.width * 0.16));
      final padHeight = math.min(11.0, math.max(5.0, bodySize.height * 0.64));
      for (final side in const [-1.0, 1.0]) {
        drawPad(
          Rect.fromCenter(
            center: Offset(side * (bodySize.width / 2 + padWidth * 0.24), 0),
            width: padWidth,
            height: padHeight,
          ),
          oval: oval,
        );
      }
    }

    switch (kind) {
      case _FootprintVisualKind.icDualSide:
      case _FootprintVisualKind.icQuadSide:
        final legCount = math.max(
          3,
          math.min(6, (bodySize.height / 8.5).round()),
        );
        final legWidth = math.min(6.0, math.max(3.8, bodySize.width * 0.08));
        final legHeight = math.min(
          7.0,
          math.max(3.4, bodySize.height / (legCount * 2.4)),
        );
        for (var index = 0; index < legCount; index++) {
          final y = -bodySize.height / 2 +
              bodySize.height * (index + 1) / (legCount + 1);
          for (final side in const [-1.0, 1.0]) {
            drawPad(
              Rect.fromCenter(
                center: Offset(
                  side * (bodySize.width / 2 + legWidth * 0.22),
                  y,
                ),
                width: legWidth,
                height: legHeight,
              ),
            );
          }
        }
        break;
      case _FootprintVisualKind.passive2:
      case _FootprintVisualKind.switchPackage:
      case _FootprintVisualKind.smallMultiPin:
      case _FootprintVisualKind.diode:
      case _FootprintVisualKind.denseGrid:
      case _FootprintVisualKind.mechanical:
      case _FootprintVisualKind.moduleBlock:
        drawEndPads();
        break;
      case _FootprintVisualKind.capacitor:
        drawEndPads(oval: true);
        break;
      case _FootprintVisualKind.transistor3:
        final leadWidth = math.min(6.0, math.max(3.8, bodySize.width * 0.1));
        final leadHeight = math.min(7.0, math.max(3.8, bodySize.height * 0.18));
        for (final fraction in const [-0.28, 0.0, 0.28]) {
          drawPad(
            Rect.fromCenter(
              center: Offset(
                bodySize.width * fraction,
                bodySize.height / 2 + leadHeight * 0.24,
              ),
              width: leadWidth,
              height: leadHeight,
            ),
          );
        }
        break;
      case _FootprintVisualKind.connector:
        final padCount = math.max(
          3,
          math.min(5, (bodySize.width / 12).round()),
        );
        final diameter = math.min(6.0, math.max(3.5, bodySize.height * 0.28));
        final spacing = bodySize.width / (padCount + 1);
        for (var index = 0; index < padCount; index++) {
          final x = -bodySize.width / 2 + spacing * (index + 1);
          drawPad(
            Rect.fromCenter(
              center: Offset(x, 0),
              width: diameter,
              height: diameter,
            ),
            oval: true,
          );
        }
        break;
      case _FootprintVisualKind.testPoint:
        // Testpoint/ground footprints use the body ring as the package cue;
        // extra decorative pads would look like invented pin geometry.
        break;
      case _FootprintVisualKind.generic:
        final tabWidth = math.min(7.0, math.max(4.0, bodySize.width * 0.16));
        final tabHeight = math.min(6.0, math.max(3.5, bodySize.height * 0.22));
        for (final corner in const [
          Offset(-1, -1),
          Offset(1, -1),
          Offset(-1, 1),
          Offset(1, 1),
        ]) {
          drawPad(
            Rect.fromCenter(
              center: Offset(
                corner.dx * (bodySize.width / 2 - tabWidth * 0.38),
                corner.dy * (bodySize.height / 2 - tabHeight * 0.38),
              ),
              width: tabWidth,
              height: tabHeight,
            ),
          );
        }
        break;
    }
  }

  static void _drawTemplatePins({
    required Canvas canvas,
    required FootprintTemplate template,
    required Size bodySize,
    required String? selectedTarget,
    required Paint fillPaint,
    required Paint strokePaint,
  }) {
    for (final pin in template.pinAnchors) {
      final selected = _templatePinMatchesTarget(pin, selectedTarget);
      final effectiveFillPaint = selected
          ? (Paint()
            ..color = _kFootprintSelected.withValues(alpha: 0.95)
            ..style = PaintingStyle.fill)
          : fillPaint;
      final effectiveStrokePaint = selected
          ? (Paint()
            ..color = _kFootprintSelected
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.5)
          : strokePaint;
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
          canvas.drawOval(pinRect, effectiveFillPaint);
          canvas.drawOval(pinRect, effectiveStrokePaint);
          break;
        case FootprintPinShape.rect:
          final pad =
              RRect.fromRectAndRadius(pinRect, const Radius.circular(1.5));
          canvas.drawRRect(pad, effectiveFillPaint);
          canvas.drawRRect(pad, effectiveStrokePaint);
          break;
      }
    }
  }

  static void _drawOrientationMarker({
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

  static Size _pinSize(
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

  static Offset _templatePointToCanvas(
    FootprintPoint point,
    FootprintTemplate template,
    Size bodySize,
  ) {
    return Offset(
      point.x * bodySize.width / template.body.width,
      point.y * bodySize.height / template.body.height,
    );
  }

  static double _templateLengthToCanvas(
    double value,
    FootprintTemplate template,
    Size bodySize,
  ) {
    return value * _templateScale(template, bodySize);
  }

  static double _templateScale(FootprintTemplate template, Size bodySize) {
    final scaleX = bodySize.width / template.body.width;
    final scaleY = bodySize.height / template.body.height;
    return math.min(scaleX, scaleY);
  }

  @override
  SemanticsBuilderCallback get semanticsBuilder {
    return (Size size) {
      final canvasRect = Offset.zero & size;
      return entries.map<CustomPainterSemantics>((entry) {
        final center = _renderedPlacementCenter(entry, size);
        final bodySize = _renderedFootprintVisualSize(entry);
        final rawRect = Rect.fromCenter(
          center: center,
          width: bodySize.width,
          height: bodySize.height,
        ).inflate(8);
        final rect = rawRect.overlaps(canvasRect)
            ? rawRect.intersect(canvasRect)
            : Rect.fromCenter(center: center, width: 1, height: 1);
        return CustomPainterSemantics(
          rect: rect,
          properties: SemanticsProperties(
            label: _footprintSemanticsLabel(entry),
            selected: entry.key == selectedKey ||
                (selectedKey == null &&
                    entry.placement.componentId == selectedComponentId),
            hint: previewKeys.contains(entry.key)
                ? 'Ajutine hõljutuse eelvaade'
                : dimmedPlacementKeys.contains(entry.key)
                    ? 'Sama komponendi valimata paigutus'
                    : null,
            textDirection: TextDirection.ltr,
          ),
        );
      }).toList(growable: false);
    };
  }

  @override
  bool shouldRebuildSemantics(covariant _BoardPlacementPainter oldDelegate) {
    return shouldRepaint(oldDelegate);
  }

  @override
  bool shouldRepaint(covariant _BoardPlacementPainter oldDelegate) {
    if (oldDelegate.selectedKey != selectedKey) {
      return true;
    }
    if (oldDelegate.selectedComponentId != selectedComponentId ||
        !setEquals(oldDelegate.previewKeys, previewKeys)) {
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
