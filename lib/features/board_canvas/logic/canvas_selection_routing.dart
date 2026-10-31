import 'dart:ui';

enum CanvasContextMode {
  hidden,
  inspector,
  placements,
  measure,
  addComponentTemplates,
  safetyEvidence,
  photos,
}

abstract class CanvasSelection {
  const CanvasSelection();
  String? get componentId => null;
  String? get placementKey => null;
}

class EmptyCanvasSelection extends CanvasSelection {
  const EmptyCanvasSelection();
}

class ComponentSelection extends CanvasSelection {
  const ComponentSelection({required this.componentId});
  @override
  final String componentId;
}

class ComponentPlacementSelection extends CanvasSelection {
  const ComponentPlacementSelection({
    required this.placementKey,
    required this.componentId,
    this.canvasAnchor,
  });
  @override
  final String placementKey;
  @override
  final String componentId;
  final Offset? canvasAnchor;
}

/// Pure UI-local decisions. The host owns state, visibility, category lookup,
/// candidate-controller effects and lifecycle; this value invokes no callbacks.
class CanvasRoutingState {
  const CanvasRoutingState({
    this.selection = const EmptyCanvasSelection(),
    this.mode = CanvasContextMode.hidden,
  });
  final CanvasSelection selection;
  final CanvasContextMode mode;

  bool get clearsCandidateSelection => selection is! EmptyCanvasSelection;

  CanvasRoutingState withSelection(CanvasSelection next) =>
      CanvasRoutingState(selection: next, mode: mode);
  CanvasRoutingState withMode(CanvasContextMode next) =>
      CanvasRoutingState(selection: selection, mode: next);

  CanvasRoutingState reconcile(
      Map<String, String> placements, Set<String> visibleComponents) {
    final selected = selection;
    final valid = switch (selected) {
      EmptyCanvasSelection() => true,
      ComponentPlacementSelection(:final placementKey, :final componentId) =>
        placements[placementKey] == componentId &&
            visibleComponents.contains(componentId),
      ComponentSelection(:final componentId) =>
        visibleComponents.contains(componentId),
      _ => false,
    };
    if (valid) return this;
    final hide = selected is ComponentPlacementSelection &&
        (placements.isEmpty || mode == CanvasContextMode.inspector);
    return CanvasRoutingState(mode: hide ? CanvasContextMode.hidden : mode);
  }

  /// Filtering invalidates a hidden target, but never chooses a different mode.
  CanvasRoutingState afterFilter(
          Map<String, String> placements, Set<String> visibleComponents) =>
      CanvasRoutingState(
          selection: reconcile(placements, visibleComponents).selection,
          mode: mode);

  CanvasRoutingState enterMode(
      CanvasContextMode next, Map<String, String> placements) {
    var target = selection;
    if (next == CanvasContextMode.measure) {
      if (target is ComponentSelection) {
        final matches = placements.entries
            .where((entry) => entry.value == target.componentId)
            .toList();
        if (matches.length == 1) {
          target = ComponentPlacementSelection(
              placementKey: matches.single.key,
              componentId: matches.single.value);
        }
      } else if (target is EmptyCanvasSelection && placements.isNotEmpty) {
        // Accepted legacy fallback: absence of explicit selection is not proof
        // that the first visible placement is the technician's intended target.
        final first = placements.entries.first;
        target = ComponentPlacementSelection(
            placementKey: first.key, componentId: first.value);
      }
    } else if (next == CanvasContextMode.photos ||
        next == CanvasContextMode.safetyEvidence) {
      target = const EmptyCanvasSelection();
    }
    return CanvasRoutingState(selection: target, mode: next);
  }

  CanvasRoutingState selectOnCanvas(CanvasSelection next) => CanvasRoutingState(
      selection: next,
      mode: _keepsCanvasMode ? mode : CanvasContextMode.inspector);

  CanvasRoutingState selectFromDropdown(
          CanvasSelection next) =>
      CanvasRoutingState(
          selection: next,
          mode: mode == CanvasContextMode.measure ||
                  mode == CanvasContextMode.photos
              ? mode
              : CanvasContextMode.inspector);

  CanvasRoutingState clearOnCanvas() => CanvasRoutingState(
      mode: _keepsCanvasMode ? mode : CanvasContextMode.hidden);

  CanvasRoutingState selectCandidate() =>
      const CanvasRoutingState(mode: CanvasContextMode.addComponentTemplates);

  bool get _keepsCanvasMode =>
      mode == CanvasContextMode.measure ||
      mode == CanvasContextMode.placements ||
      mode == CanvasContextMode.photos;
}
