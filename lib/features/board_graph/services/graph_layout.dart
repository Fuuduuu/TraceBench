import 'package:flutter/material.dart';

import 'package:trace_bench_viewer/features/board_graph/models/board_graph_model.dart';

class GraphLayoutResult {
  const GraphLayoutResult({required this.nodePositions});

  final Map<String, Offset> nodePositions;
}

class GraphLayoutEngine {
  GraphLayoutEngine._();

  static GraphLayoutResult layout(BoardGraphProjection projection) {
    final positions = <String, Offset>{};
    const spacingX = 220.0;
    const spacingY = 170.0;

    final components = projection.nodes
        .where((node) => node.type == BoardGraphNodeType.component)
        .toList()
      ..sort((a, b) => a.id.compareTo(b.id));
    final pins = projection.nodes
        .where((node) => node.type == BoardGraphNodeType.pin)
        .toList()
      ..sort((a, b) => a.id.compareTo(b.id));
    final measurements = projection.nodes
        .where((node) => node.type == BoardGraphNodeType.measurement)
        .toList()
      ..sort((a, b) => a.id.compareTo(b.id));
    final nets = projection.nodes
        .where((node) => node.type == BoardGraphNodeType.net)
        .toList()
      ..sort((a, b) => a.id.compareTo(b.id));
    final footprints = projection.nodes
        .where((node) => node.type == BoardGraphNodeType.footprint)
        .toList()
      ..sort((a, b) => a.id.compareTo(b.id));
    final damage = projection.nodes
        .where((node) => node.type == BoardGraphNodeType.damageRegion)
        .toList()
      ..sort((a, b) => a.id.compareTo(b.id));
    final suspect = projection.nodes
        .where((node) => node.type == BoardGraphNodeType.suspectRegion)
        .toList()
      ..sort((a, b) => a.id.compareTo(b.id));
    final traces = projection.nodes
        .where((node) => node.type == BoardGraphNodeType.visualTrace)
        .toList()
      ..sort((a, b) => a.id.compareTo(b.id));

    final placed = <String>{};

    _placeRow(components, 0, 0, spacingX, spacingY, positions, placed);
    _placeRow(pins, 1, 0, spacingX, spacingY, positions, placed);
    _placeRow(measurements, 2, 0, spacingX, spacingY, positions, placed);
    _placeRow(nets, 3, 0, spacingX, spacingY, positions, placed);
    _placeRow(footprints, 4, 0, spacingX, spacingY, positions, placed);
    _placeRow(damage, 5, 0, spacingX, spacingY, positions, placed);
    _placeRow(suspect, 6, 0, spacingX, spacingY, positions, placed);
    _placeRow(traces, 7, 0, spacingX, spacingY, positions, placed);

    return GraphLayoutResult(nodePositions: positions);
  }

  static void _placeRow(
    List<BoardGraphNode> nodes,
    int row,
    int columnOffset,
    double spacingX,
    double spacingY,
    Map<String, Offset> positions,
    Set<String> placed,
  ) {
    for (var i = 0; i < nodes.length; i++) {
      final node = nodes[i];
      if (placed.contains(node.id)) continue;
      positions[node.id] =
          Offset((columnOffset + i) * spacingX, row * spacingY);
      placed.add(node.id);
    }
  }
}
