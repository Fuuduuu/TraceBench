import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../shared/models/known_facts.dart';
import '../theme/board_canvas_palette.dart';

enum ComponentCategory {
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

extension ComponentCategoryPresentation on ComponentCategory {
  String get stableId {
    switch (this) {
      case ComponentCategory.resistors:
        return 'resistors';
      case ComponentCategory.capacitors:
        return 'capacitors';
      case ComponentCategory.diodes:
        return 'diodes';
      case ComponentCategory.transistors:
        return 'transistors';
      case ComponentCategory.integratedCircuits:
        return 'integrated_circuits';
      case ComponentCategory.connectors:
        return 'connectors';
      case ComponentCategory.inductorsTransformers:
        return 'inductors_transformers';
      case ComponentCategory.fuses:
        return 'fuses';
      case ComponentCategory.testPoints:
        return 'test_points';
      case ComponentCategory.otherUnknown:
        return 'other_unknown';
    }
  }

  String get label {
    switch (this) {
      case ComponentCategory.resistors:
        return 'Takistid';
      case ComponentCategory.capacitors:
        return 'Kondensaatorid';
      case ComponentCategory.diodes:
        return 'Dioodid';
      case ComponentCategory.transistors:
        return 'Transistorid';
      case ComponentCategory.integratedCircuits:
        return 'Mikroskeemid';
      case ComponentCategory.connectors:
        return 'Konnektorid';
      case ComponentCategory.inductorsTransformers:
        return 'Poolid ja trafod';
      case ComponentCategory.fuses:
        return 'Kaitsmed';
      case ComponentCategory.testPoints:
        return 'Testpunktid';
      case ComponentCategory.otherUnknown:
        return 'Muud / tundmatu';
    }
  }
}

ComponentCategory componentCategoryFor(ComponentFact component) {
  final kind = component.type?.trim().toLowerCase() ?? '';
  if (kind == 'resistor' ||
      kind == 'takisti' ||
      kind == 'res' ||
      kind.contains('pull-up') ||
      kind.contains('pull down') ||
      kind.contains('pull-down') ||
      kind.contains('pull up') ||
      kind.contains('shunt')) {
    return ComponentCategory.resistors;
  }
  if (kind == 'capacitor' || kind == 'cap' || kind == 'kondensaator') {
    return ComponentCategory.capacitors;
  }
  if (kind == 'diode' ||
      kind == 'diood' ||
      kind == 'zener' ||
      kind == 'schottky' ||
      kind == 'led') {
    return ComponentCategory.diodes;
  }
  if (kind == 'transistor' ||
      kind == 'mosfet' ||
      kind == 'fet' ||
      kind == 'bjt') {
    return ComponentCategory.transistors;
  }
  if (kind == 'ic' ||
      kind == 'mcu' ||
      kind == 'controller' ||
      kind == 'chip' ||
      kind == 'regulator' ||
      kind == 'opamp' ||
      kind == 'mikroskeem') {
    return ComponentCategory.integratedCircuits;
  }
  if (kind == 'connector' ||
      kind == 'socket' ||
      kind == 'header' ||
      kind == 'plug' ||
      kind == 'konnektor') {
    return ComponentCategory.connectors;
  }
  if (kind == 'inductor' ||
      kind == 'coil' ||
      kind == 'choke' ||
      kind == 'transformer' ||
      kind.contains('induktiiv')) {
    return ComponentCategory.inductorsTransformers;
  }
  if (kind == 'fuse' || kind == 'kaitse' || kind == 'ptc') {
    return ComponentCategory.fuses;
  }
  if (kind == 'testpoint' ||
      kind == 'test point' ||
      kind == 'tp' ||
      kind == 'testpunkt') {
    return ComponentCategory.testPoints;
  }
  return ComponentCategory.otherUnknown;
}

String componentPrimaryLabel(ComponentFact component) {
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

/// The existing Canvas presentation key, shared by the host adapter and Navigator.
String componentNavigatorPlacementId(ComponentVisualPlacementFact placement) =>
    '${placement.componentId}|${placement.sourceEventId}';

ButtonStyle _benchBeepNavigatorControlStyle({required bool filled}) {
  return ButtonStyle(
    foregroundColor: const WidgetStatePropertyAll(BoardCanvasPalette.signal),
    backgroundColor: WidgetStatePropertyAll(
      filled ? BoardCanvasPalette.signalTint : Colors.transparent,
    ),
    overlayColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.pressed)) {
        return BoardCanvasPalette.signal.withValues(alpha: 0.28);
      }
      if (states.contains(WidgetState.focused)) {
        return BoardCanvasPalette.signal.withValues(alpha: 0.2);
      }
      if (states.contains(WidgetState.hovered)) {
        return BoardCanvasPalette.signal.withValues(alpha: 0.12);
      }
      return Colors.transparent;
    }),
    side: WidgetStateProperty.resolveWith((states) {
      final emphasized = states.contains(WidgetState.focused) ||
          states.contains(WidgetState.pressed);
      return BorderSide(
        color: emphasized
            ? BoardCanvasPalette.signal.withValues(alpha: 0.86)
            : BoardCanvasPalette.ruleStrong.withValues(alpha: 0.6),
        width: emphasized ? 1.2 : 1,
      );
    }),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
    ),
  );
}

/// Stateless Navigator presentation. The caller owns selection, filters,
/// previews, project lifecycle and placement actions; callbacks express intent.
class ComponentNavigator extends StatelessWidget {
  const ComponentNavigator({
    super.key,
    required this.components,
    required this.placements,
    required this.canvasPlacements,
    required this.visibleComponentIds,
    required this.hideUnmeasured,
    required this.measurementCountsByComponentId,
    required this.selectedCategory,
    required this.selectedComponentId,
    required this.selectedPlacementId,
    required this.onCategorySelected,
    required this.onBackToCategories,
    required this.onBackToCategory,
    required this.onComponentSelected,
    required this.onPlacementSelected,
    required this.onPlaceComponent,
    required this.onPreviewKeysChanged,
  });

  final List<ComponentFact> components;
  final List<ComponentVisualPlacementFact> placements;
  final List<ComponentVisualPlacementFact> canvasPlacements;
  final Set<String> visibleComponentIds;
  final bool hideUnmeasured;
  final Map<String, int> measurementCountsByComponentId;
  final ComponentCategory? selectedCategory;
  final String? selectedComponentId;
  final String? selectedPlacementId;
  final ValueChanged<ComponentCategory> onCategorySelected;
  final VoidCallback onBackToCategories;
  final VoidCallback onBackToCategory;
  final ValueChanged<ComponentFact> onComponentSelected;
  final ValueChanged<String> onPlacementSelected;
  final VoidCallback onPlaceComponent;
  final ValueChanged<Set<String>> onPreviewKeysChanged;

  Set<String> get _placedComponentIds =>
      placements.map((placement) => placement.componentId).toSet();

  List<ComponentFact> _componentsInCategory(ComponentCategory category) {
    return components
        .where((component) => componentCategoryFor(component) == category)
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
    ComponentFact? selectedComponent;
    if (category != null &&
        selectedComponentId != null &&
        visibleComponentIds.contains(selectedComponentId)) {
      for (final component in components) {
        if (component.componentId == selectedComponentId &&
            componentCategoryFor(component) == category) {
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
    final visibleCategories = ComponentCategory.values
        .where((category) => _componentsInCategory(category).isNotEmpty)
        .toList(growable: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Komponenditüübid',
          style: theme.textTheme.titleMedium?.copyWith(
            color: BoardCanvasPalette.navy,
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
    ComponentCategory category,
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
    final componentsById = {
      for (final component in components) component.componentId: component
    };
    final previewKeys = canvasPlacements
        .where((placement) {
          final component = componentsById[placement.componentId];
          return component != null &&
              componentCategoryFor(component) == category;
        })
        .map(componentNavigatorPlacementId)
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
          color: BoardCanvasPalette.tile,
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
                            color: BoardCanvasPalette.navy,
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
                            color: BoardCanvasPalette.muted,
                          ),
                        ),
                        Text(
                          hideUnmeasured
                              ? '$hiddenCount peidetud'
                              : '$unplacedCount paigutamata',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: BoardCanvasPalette.dim,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right_rounded,
                    size: 20,
                    color: BoardCanvasPalette.signal,
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
    ComponentCategory category,
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
            color: BoardCanvasPalette.navy,
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
                  color: BoardCanvasPalette.muted,
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
            color: BoardCanvasPalette.signal,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 5),
        if (sectionComponents.isEmpty)
          Text(
            'Komponente pole.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: BoardCanvasPalette.dim,
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
    final previewKeys = canvasPlacements
        .where(
          (placement) => placement.componentId == component.componentId,
        )
        .map((placement) => componentNavigatorPlacementId(placement))
        .toSet();

    return MouseRegion(
      onEnter: (_) => onPreviewKeysChanged(previewKeys),
      onExit: (_) => onPreviewKeysChanged(const <String>{}),
      child: Semantics(
        button: true,
        child: Material(
          color: BoardCanvasPalette.tile,
          borderRadius: BorderRadius.circular(7),
          child: InkWell(
            key: Key('board_canvas_component_row_${component.componentId}'),
            borderRadius: BorderRadius.circular(7),
            onTap: () => onComponentSelected(component),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 7),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                border: Border.all(color: BoardCanvasPalette.rule),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          componentPrimaryLabel(component),
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: BoardCanvasPalette.navy,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 1),
                        Text(
                          '${component.componentId} · '
                          '${_componentKindLabel(component)}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: BoardCanvasPalette.muted,
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
                          ? BoardCanvasPalette.dim
                          : BoardCanvasPalette.ready,
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
    ComponentCategory category,
    ComponentFact component,
  ) {
    final theme = Theme.of(context);
    final componentPlacements = placements
        .where(
          (placement) => placement.componentId == component.componentId,
        )
        .toList(growable: false);
    final visibleComponentPlacements = canvasPlacements
        .where(
          (placement) => placement.componentId == component.componentId,
        )
        .toList(growable: false);
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
          componentPrimaryLabel(component),
          style: theme.textTheme.titleMedium?.copyWith(
            color: BoardCanvasPalette.navy,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          '${component.componentId} · ${_componentKindLabel(component)}',
          style: theme.textTheme.bodySmall?.copyWith(
            color: BoardCanvasPalette.muted,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          measurementCount == 0 ? 'Mõõtmata' : '$measurementCount mõõtmist',
          style: theme.textTheme.labelSmall?.copyWith(
            color: measurementCount == 0
                ? BoardCanvasPalette.dim
                : BoardCanvasPalette.ready,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        if (componentPlacements.isEmpty) ...[
          Text(
            'Pole veel canvasele paigutatud',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: BoardCanvasPalette.navy,
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
        ] else if (visibleComponentPlacements.isEmpty) ...[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (var index = 0;
                      index < componentPlacements.length;
                      index++) ...[
                    _buildPlacementSummary(context, componentPlacements[index]),
                    if (index != componentPlacements.length - 1)
                      const SizedBox(height: 6),
                  ],
                  const SizedBox(height: 8),
                  Text(
                    'Kinnitatud paigutus ei ole plaadi canvasel nähtav.',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: BoardCanvasPalette.muted,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ] else if (visibleComponentPlacements.length == 1) ...[
          _buildPlacementSummary(context, visibleComponentPlacements.single),
          const SizedBox(height: 8),
          FilledButton.icon(
            key: const Key('board_canvas_component_view_placement'),
            onPressed: () => onPlacementSelected(componentNavigatorPlacementId(
                visibleComponentPlacements.single)),
            style: _benchBeepNavigatorControlStyle(filled: true),
            icon: const Icon(Icons.center_focus_strong),
            label: const Text('Vaata canvasel'),
          ),
        ] else ...[
          Text(
            'Vali paigutus',
            style: theme.textTheme.labelLarge?.copyWith(
              color: BoardCanvasPalette.navy,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (var index = 0;
                      index < visibleComponentPlacements.length;
                      index++) ...[
                    _buildPlacementChoice(
                      context,
                      visibleComponentPlacements[index],
                      index: index,
                      selected: componentNavigatorPlacementId(
                              visibleComponentPlacements[index]) ==
                          selectedPlacementId,
                    ),
                    if (index != visibleComponentPlacements.length - 1)
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
    ComponentVisualPlacementFact placement,
  ) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        color: BoardCanvasPalette.tile,
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: BoardCanvasPalette.rule),
      ),
      child: Text(
        '${placement.boardSide} · '
        '${placement.coordinateSpace}',
        style: theme.textTheme.bodySmall?.copyWith(
          color: BoardCanvasPalette.muted,
        ),
      ),
    );
  }

  Widget _buildPlacementChoice(
    BuildContext context,
    ComponentVisualPlacementFact placement, {
    required int index,
    required bool selected,
  }) {
    final theme = Theme.of(context);
    return MouseRegion(
      onEnter: (_) => onPreviewKeysChanged(
          <String>{componentNavigatorPlacementId(placement)}),
      onExit: (_) => onPreviewKeysChanged(const <String>{}),
      child: Semantics(
        selected: selected,
        button: true,
        child: Material(
          color: selected
              ? BoardCanvasPalette.signalTint
              : BoardCanvasPalette.tile,
          borderRadius: BorderRadius.circular(7),
          child: InkWell(
            key: Key(
                'board_canvas_component_placement_${componentNavigatorPlacementId(placement)}'),
            borderRadius: BorderRadius.circular(7),
            onTap: () =>
                onPlacementSelected(componentNavigatorPlacementId(placement)),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                border: Border.all(
                  color: selected
                      ? BoardCanvasPalette.signal
                      : BoardCanvasPalette.rule,
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
                          '${placement.boardSide}',
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: BoardCanvasPalette.navy,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          placement.coordinateSpace,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: BoardCanvasPalette.muted,
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
                    color: selected
                        ? BoardCanvasPalette.signal
                        : BoardCanvasPalette.dim,
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
