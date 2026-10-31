import 'package:flutter_test/flutter_test.dart';
import 'package:trace_bench_viewer/features/board_canvas/logic/canvas_selection_routing.dart';

void main() {
  const placements = {'r1': 'R1', 'c2a': 'C2', 'c2b': 'C2'};
  const visible = {'R1', 'C2', 'U3'};
  const c2 = ComponentSelection(componentId: 'C2');
  const exact = ComponentPlacementSelection(
      placementKey: 'c2b', componentId: 'C2', canvasAnchor: Offset(7, 9));

  group('measurement routing preserves accepted P0 policy', () {
    test('explicit placement and its anchor survive', () {
      final next = const CanvasRoutingState(selection: exact)
          .enterMode(CanvasContextMode.measure, placements);
      expect(next.selection, same(exact));
      expect(next.mode, CanvasContextMode.measure);
    });
    for (final entry in <String, Map<String, String>>{
      'zero': {'r1': 'R1'},
      'multiple': placements,
    }.entries) {
      test('${entry.key} matching placements preserve component-only context',
          () {
        final next = const CanvasRoutingState(selection: c2)
            .enterMode(CanvasContextMode.measure, entry.value);
        expect(next.selection, same(c2));
        expect(next.selection.placementKey, isNull);
      });
    }
    test('one match resolves only the explicitly selected component', () {
      final next = const CanvasRoutingState(selection: c2)
          .enterMode(CanvasContextMode.measure, {'r1': 'R1', 'c2a': 'C2'});
      expect(next.selection.componentId, 'C2');
      expect(next.selection.placementKey, 'c2a');
    });
    test('empty selection retains first-visible fallback and its residual risk',
        () {
      final next = const CanvasRoutingState()
          .enterMode(CanvasContextMode.measure, placements);
      expect(next.selection.componentId, 'R1');
      expect(next.selection.placementKey, 'r1');
    });
    test('empty inventory cannot produce a measurement target', () {
      expect(
          const CanvasRoutingState()
              .enterMode(CanvasContextMode.measure, {}).selection,
          isA<EmptyCanvasSelection>());
    });
  });

  group('pure reconciliation', () {
    test('valid exact selection retains identity', () {
      const state = CanvasRoutingState(selection: exact);
      expect(state.reconcile(placements, visible), same(state));
    });
    test('known unplaced component remains a component selection', () {
      const selected = ComponentSelection(componentId: 'U3');
      expect(
          const CanvasRoutingState(selection: selected)
              .reconcile(placements, visible)
              .selection,
          same(selected));
    });
    test('missing or mismatched placement is cleared without mutating input',
        () {
      for (final selection in [
        const ComponentPlacementSelection(
            placementKey: 'gone', componentId: 'C2'),
        const ComponentPlacementSelection(
            placementKey: 'r1', componentId: 'C2'),
      ]) {
        final original = CanvasRoutingState(
            selection: selection, mode: CanvasContextMode.inspector);
        final next = original.reconcile(placements, visible);
        expect(next.selection, isA<EmptyCanvasSelection>());
        expect(next.mode, CanvasContextMode.hidden);
        expect(original.selection, same(selection));
        expect(original.mode, CanvasContextMode.inspector);
        expect(next.reconcile(placements, visible), same(next));
      }
    });
    test('deleted component cannot remain selected', () {
      expect(
          const CanvasRoutingState(selection: c2)
              .reconcile({}, {'R1'}).selection,
          isA<EmptyCanvasSelection>());
    });
  });

  for (final mode in CanvasContextMode.values) {
    test('filter keeps $mode while clearing an ineligible selection (BB-11)',
        () {
      final next = CanvasRoutingState(selection: exact, mode: mode)
          .afterFilter({'r1': 'R1'}, {'R1'});
      expect(next.mode, mode);
      expect(next.selection, isA<EmptyCanvasSelection>());
    });
    test('Canvas placement click routes from $mode without losing target', () {
      final next = CanvasRoutingState(mode: mode).selectOnCanvas(exact);
      expect(next.selection, same(exact));
      expect(
          next.mode,
          [
            CanvasContextMode.measure,
            CanvasContextMode.placements,
            CanvasContextMode.photos
          ].contains(mode)
              ? mode
              : CanvasContextMode.inspector);
      expect(next.clearsCandidateSelection, isTrue);
    });
    test('empty Canvas click respects $mode', () {
      final next =
          CanvasRoutingState(selection: exact, mode: mode).clearOnCanvas();
      expect(next.selection, isA<EmptyCanvasSelection>());
      expect(
          next.mode,
          [
            CanvasContextMode.measure,
            CanvasContextMode.placements,
            CanvasContextMode.photos
          ].contains(mode)
              ? mode
              : CanvasContextMode.hidden);
    });
  }

  test('Navigator entry preserves selection instead of resetting it (BB-09)',
      () {
    final next = const CanvasRoutingState(selection: exact)
        .enterMode(CanvasContextMode.placements, placements);
    expect(next.selection, same(exact));
    expect(next.mode, CanvasContextMode.placements);
  });
  test(
      'candidate entry clears canonical selection; canonical selection clears candidate (BB-08)',
      () {
    final next = const CanvasRoutingState(selection: exact).selectCandidate();
    expect(next.selection, isA<EmptyCanvasSelection>());
    expect(next.mode, CanvasContextMode.addComponentTemplates);
    expect(next.clearsCandidateSelection, isFalse);
    expect(next.withSelection(c2).clearsCandidateSelection, isTrue);
  });
  for (final mode in [
    CanvasContextMode.photos,
    CanvasContextMode.safetyEvidence
  ]) {
    test('$mode retains its existing canonical-selection clearing behavior',
        () {
      final next = const CanvasRoutingState(selection: exact)
          .enterMode(mode, placements);
      expect(next.selection, isA<EmptyCanvasSelection>());
      expect(next.mode, mode);
    });
  }
  test('dropdown selection retains Measurement, otherwise opens Inspector', () {
    expect(
        const CanvasRoutingState(mode: CanvasContextMode.measure)
            .selectFromDropdown(exact)
            .mode,
        CanvasContextMode.measure);
    expect(
        const CanvasRoutingState(mode: CanvasContextMode.placements)
            .selectFromDropdown(exact)
            .mode,
        CanvasContextMode.inspector);
  });
}
