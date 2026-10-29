import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trace_bench_viewer/features/board_canvas/theme/board_canvas_palette.dart';
import 'package:trace_bench_viewer/features/board_canvas/widgets/component_navigator.dart';
import 'package:trace_bench_viewer/shared/models/known_facts.dart';

const _components = [
  ComponentFact(componentId: 'R10', type: 'resistor'),
  ComponentFact(componentId: 'R2', designator: 'R two', type: 'resistor'),
  ComponentFact(componentId: 'R1', type: 'resistor'),
  ComponentFact(componentId: 'R20', type: 'resistor'),
  ComponentFact(componentId: 'D1', type: 'diode'),
];

ComponentVisualPlacementFact _placement(String componentId, String eventId,
        {String side = 'top'}) =>
    ComponentVisualPlacementFact(
      componentId: componentId,
      coordinateSpace: 'board_normalized',
      boardSide: side,
      centerX: .5,
      centerY: .5,
      width: .05,
      height: .04,
      rotationDeg: 0,
      sourceEventId: eventId,
      status: 'user_confirmed_visual',
    );

final _placements = [
  _placement('R2', 'e2'),
  _placement('R10', 'e10'),
  _placement('R2', 'e2b', side: 'bottom'),
];

Widget _navigator({
  List<ComponentFact> components = _components,
  List<ComponentVisualPlacementFact>? placements,
  List<ComponentVisualPlacementFact>? canvasPlacements,
  Set<String>? visibleIds,
  bool hideUnmeasured = false,
  ComponentCategory? category,
  String? selectedComponentId,
  String? selectedPlacementId,
  ValueChanged<ComponentCategory>? onCategory,
  ValueChanged<ComponentFact>? onComponent,
  ValueChanged<String>? onPlacement,
  ValueChanged<Set<String>>? onPreview,
  VoidCallback? onPlace,
  VoidCallback? onBack,
  VoidCallback? onBackToCategory,
  double width = 320,
  double textScale = 1,
}) =>
    MaterialApp(
      home: Scaffold(
        body: MediaQuery(
          data: MediaQueryData(textScaler: TextScaler.linear(textScale)),
          child: SizedBox(
            width: width,
            height: 680,
            child: ComponentNavigator(
              components: components,
              placements: placements ?? _placements,
              canvasPlacements: canvasPlacements ?? _placements,
              visibleComponentIds:
                  visibleIds ?? components.map((c) => c.componentId).toSet(),
              hideUnmeasured: hideUnmeasured,
              measurementCountsByComponentId: const {'R2': 2, 'R20': 1},
              selectedCategory: category,
              selectedComponentId: selectedComponentId,
              selectedPlacementId: selectedPlacementId,
              onCategorySelected: onCategory ?? (_) {},
              onBackToCategories: onBack ?? () {},
              onBackToCategory: onBackToCategory ?? () {},
              onComponentSelected: onComponent ?? (_) {},
              onPlacementSelected: onPlacement ?? (_) {},
              onPlaceComponent: onPlace ?? () {},
              onPreviewKeysChanged: onPreview ?? (_) {},
            ),
          ),
        ),
      ),
    );

void main() {
  test('standalone library has no Canvas host or private-type dependency', () {
    final source = File(
      'lib/features/board_canvas/widgets/component_navigator.dart',
    ).readAsStringSync();
    for (final forbidden in [
      'part of ',
      'board_canvas_screen.dart',
      'CanvasSelection',
      '_PlacementEntry',
      '_ComponentCategory',
      'project_session.dart',
    ]) {
      expect(source, isNot(contains(forbidden)), reason: forbidden);
    }
  });

  test('shared classifier retains every alias, precedence and fallback', () {
    const aliases = <ComponentCategory, List<String>>{
      ComponentCategory.resistors: [
        'resistor',
        'takisti',
        'res',
        'pull-up',
        'pull down',
        'pull-down',
        'pull up',
        'shunt'
      ],
      ComponentCategory.capacitors: ['capacitor', 'cap', 'kondensaator'],
      ComponentCategory.diodes: ['diode', 'diood', 'zener', 'schottky', 'led'],
      ComponentCategory.transistors: ['transistor', 'mosfet', 'fet', 'bjt'],
      ComponentCategory.integratedCircuits: [
        'ic',
        'mcu',
        'controller',
        'chip',
        'regulator',
        'opamp',
        'mikroskeem'
      ],
      ComponentCategory.connectors: [
        'connector',
        'socket',
        'header',
        'plug',
        'konnektor'
      ],
      ComponentCategory.inductorsTransformers: [
        'inductor',
        'coil',
        'choke',
        'transformer',
        'induktiivne'
      ],
      ComponentCategory.fuses: ['fuse', 'kaitse', 'ptc'],
      ComponentCategory.testPoints: [
        'testpoint',
        'test point',
        'tp',
        'testpunkt'
      ],
    };
    for (final entry in aliases.entries) {
      for (final alias in entry.value) {
        expect(
            componentCategoryFor(ComponentFact(
                componentId: 'x', type: '  ${alias.toUpperCase()}  ')),
            entry.key,
            reason: alias);
      }
    }
    expect(
        componentCategoryFor(
            const ComponentFact(componentId: 'x', type: 'inductor shunt')),
        ComponentCategory.resistors);
    for (final kind in [null, '', 'unknown', 'resistance', 'miscellaneous']) {
      expect(componentCategoryFor(ComponentFact(componentId: 'x', type: kind)),
          ComponentCategory.otherUnknown);
    }
    expect(ComponentCategory.values.map((c) => c.stableId), [
      'resistors',
      'capacitors',
      'diodes',
      'transistors',
      'integrated_circuits',
      'connectors',
      'inductors_transformers',
      'fuses',
      'test_points',
      'other_unknown',
    ]);
    expect(
        componentPrimaryLabel(
            const ComponentFact(componentId: 'R1', designator: '  ')),
        'R1');
    expect(componentPrimaryLabel(_components[1]), 'R two');
    expect(componentNavigatorPlacementId(_placements.first), 'R2|e2');
  });

  testWidgets(
      'overview preserves counts, semantics, absent categories and intent',
      (tester) async {
    ComponentCategory? selected;
    await tester
        .pumpWidget(_navigator(onCategory: (value) => selected = value));
    expect(find.text('Takistid'), findsOneWidget);
    expect(find.text('Dioodid'), findsOneWidget);
    expect(find.text('Kondensaatorid'), findsNothing);
    expect(find.text('2 / 4 paigutatud'), findsOneWidget);
    expect(
        find.bySemanticsLabel(
            RegExp('Takistid, 2 / 4 paigutatud, 2 paigutamata')),
        findsOneWidget);
    await tester.tap(
        find.byKey(const Key('board_canvas_component_category_resistors')));
    expect(selected, ComponentCategory.resistors);
    expect(find.byKey(const Key('board_canvas_component_categories')),
        findsOneWidget,
        reason: 'The host, not the Navigator, owns the selected category.');
  });

  testWidgets('category hover emits only visible placement IDs and clears them',
      (tester) async {
    Set<String>? preview;
    await tester.pumpWidget(_navigator(
        canvasPlacements: [_placements.first],
        onPreview: (value) => preview = value));
    final mouse = await tester.createGesture(kind: PointerDeviceKind.mouse);
    await mouse.addPointer(location: const Offset(700, 500));
    await mouse.moveTo(tester.getCenter(
        find.byKey(const Key('board_canvas_component_category_resistors'))));
    await tester.pump();
    expect(preview, {'R2|e2'});
    await mouse.moveTo(const Offset(700, 500));
    await tester.pump();
    expect(preview, isEmpty);
    await mouse.removePointer();
  });

  testWidgets(
      'category list partitions and sorts measured first then natural ID without input mutation',
      (tester) async {
    final input = List<ComponentFact>.of(_components);
    ComponentFact? selected;
    await tester.pumpWidget(_navigator(
        components: input,
        category: ComponentCategory.resistors,
        onComponent: (value) => selected = value));
    final placed =
        find.byKey(const Key('board_canvas_component_section_placed'));
    final unplaced =
        find.byKey(const Key('board_canvas_component_section_unplaced'));
    expect(find.descendant(of: placed, matching: find.text('R two')),
        findsOneWidget);
    expect(find.descendant(of: unplaced, matching: find.text('R20')),
        findsOneWidget);
    double y(String id) =>
        tester.getTopLeft(find.byKey(Key('board_canvas_component_row_$id'))).dy;
    expect(y('R2'), lessThan(y('R10')));
    expect(y('R20'), lessThan(y('R1')));
    expect(input, _components);
    await tester.tap(find.byKey(const Key('board_canvas_component_row_R2')));
    expect(identical(selected, _components[1]), isTrue);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
      'filtered counts and zero-visible category retain the back action',
      (tester) async {
    await tester.pumpWidget(
        _navigator(hideUnmeasured: true, visibleIds: {'R2', 'R20'}));
    expect(find.text('2 / 4 nähtaval'), findsOneWidget);
    expect(find.text('2 peidetud'), findsOneWidget);
    var back = 0;
    await tester.pumpWidget(_navigator(
        category: ComponentCategory.diodes,
        hideUnmeasured: true,
        visibleIds: {'R2', 'R20'},
        onBack: () => back++));
    expect(find.byKey(const Key('board_canvas_component_category_empty')),
        findsOneWidget);
    await tester
        .tap(find.byKey(const Key('board_canvas_component_category_back')));
    expect(back, 1);
  });

  testWidgets(
      'unplaced inspector delegates Paiguta canvasele without changing data',
      (tester) async {
    var placements = 0;
    await tester.pumpWidget(_navigator(
        category: ComponentCategory.resistors,
        selectedComponentId: 'R1',
        onPlace: () => placements++));
    expect(find.text('Pole veel canvasele paigutatud'), findsOneWidget);
    await tester
        .tap(find.byKey(const Key('board_canvas_component_place_action')));
    expect(placements, 1);
    expect(_placements.length, 3);
  });

  testWidgets(
      'single visible placement delegates its stable ID and preserves board context',
      (tester) async {
    String? selected;
    await tester.pumpWidget(_navigator(
        category: ComponentCategory.resistors,
        selectedComponentId: 'R2',
        canvasPlacements: [_placements.first],
        onPlacement: (value) => selected = value));
    expect(find.text('top · board_normalized'), findsOneWidget);
    await tester
        .tap(find.byKey(const Key('board_canvas_component_view_placement')));
    expect(selected, 'R2|e2');
  });

  testWidgets('hidden placements show summaries with no placement action',
      (tester) async {
    var back = 0;
    await tester.pumpWidget(_navigator(
        category: ComponentCategory.resistors,
        selectedComponentId: 'R2',
        canvasPlacements: [],
        onBackToCategory: () => back++));
    expect(find.text('Kinnitatud paigutus ei ole plaadi canvasel nähtav.'),
        findsOneWidget);
    expect(find.text('top · board_normalized'), findsOneWidget);
    expect(find.text('bottom · board_normalized'), findsOneWidget);
    expect(find.byKey(const Key('board_canvas_component_view_placement')),
        findsNothing);
    expect(find.byKey(const Key('board_canvas_component_place_action')),
        findsNothing);
    await tester
        .tap(find.byKey(const Key('board_canvas_component_inspector_back')));
    expect(back, 1);
  });

  testWidgets(
      'multiple placements preserve selected semantics, highlight and hover callbacks',
      (tester) async {
    Set<String>? preview;
    String? selected;
    await tester.pumpWidget(_navigator(
        category: ComponentCategory.resistors,
        selectedComponentId: 'R2',
        selectedPlacementId: 'R2|e2b',
        onPlacement: (value) => selected = value,
        onPreview: (value) => preview = value));
    final choice =
        find.byKey(const Key('board_canvas_component_placement_R2|e2b'));
    expect(
        tester.getSemantics(choice),
        matchesSemantics(
            isSelected: true,
            hasSelectedState: true,
            isButton: true,
            hasTapAction: true,
            isFocusable: true,
            hasFocusAction: true,
            label: '2. paigutus · bottom\nboard_normalized'));
    final material = tester.widget<Material>(
        find.ancestor(of: choice, matching: find.byType(Material)).first);
    expect(material.color, BoardCanvasPalette.signalTint);
    final mouse = await tester.createGesture(kind: PointerDeviceKind.mouse);
    await mouse.addPointer(location: const Offset(700, 500));
    await mouse.moveTo(tester.getCenter(choice));
    await tester.pump();
    expect(preview, {'R2|e2b'});
    await mouse.moveTo(const Offset(700, 500));
    await tester.pump();
    expect(preview, isEmpty);
    await mouse.removePointer();
    await tester.tap(choice);
    expect(selected, 'R2|e2b');
  });

  testWidgets('compact and wide callers retain all branches at enlarged text',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(800, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    for (final width in [280.0, 320.0]) {
      for (final selected in [null, 'R1', 'R2', 'missing']) {
        await tester.pumpWidget(_navigator(
            width: width,
            textScale: 1.5,
            category: ComponentCategory.resistors,
            selectedComponentId: selected));
        await tester.pump();
        expect(find.byKey(const Key('board_canvas_component_navigator')),
            findsOneWidget);
        expect(tester.takeException(), isNull);
      }
    }
  });
}
