part of '../screens/board_canvas_screen.dart';

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
