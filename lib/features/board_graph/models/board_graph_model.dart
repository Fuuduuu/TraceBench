import 'dart:collection';

enum BoardGraphNodeType {
  component,
  pin,
  net,
  measurement,
  visualTrace,
  damageRegion,
  suspectRegion,
  footprint,
}

enum BoardGraphEdgeType {
  hasPin,
  measuredConnection,
  visualTraceHint,
  staleAfter,
  affectedByRepair,
  annotatedRegion,
}

enum EvidenceLevel {
  measured,
  sourceImportedUnverified,
  userConfirmedVisual,
  visualTrace,
  visual,
  unknown,
}

enum ValidityStatus {
  active,
  staleAfterRepair,
  needsIdentification,
  confirmed,
  suspect,
  verifiedGood,
  unknown,
}

enum LayerTag {
  component,
  pin,
  electricalNet,
  measurement,
  visualTrace,
  damage,
  suspect,
  notPopulated,
  footprint,
  repairHistory,
}

enum IncludeValidity {
  activeOnly,
  includeStale,
  all,
}

class LayerFilter {
  const LayerFilter({
    required this.activeLayers,
    required this.minimumEvidence,
    required this.includeValidity,
    required this.showNotPopulated,
    required this.showRepairHistory,
    required this.beginnerMode,
    required this.includeVisualTraces,
    required this.includeDamageAndSuspect,
    required this.includeRawIds,
  });

  const LayerFilter.beginner()
      : activeLayers = const {
          LayerTag.component,
          LayerTag.pin,
          LayerTag.electricalNet,
          LayerTag.notPopulated,
          LayerTag.footprint,
        },
        minimumEvidence = EvidenceLevel.unknown,
        includeValidity = IncludeValidity.activeOnly,
        showNotPopulated = true,
        showRepairHistory = false,
        beginnerMode = true,
        includeVisualTraces = false,
        includeDamageAndSuspect = false,
        includeRawIds = false;

  const LayerFilter.advanced()
      : activeLayers = const {
          LayerTag.component,
          LayerTag.pin,
          LayerTag.electricalNet,
          LayerTag.measurement,
          LayerTag.notPopulated,
          LayerTag.footprint,
          LayerTag.damage,
          LayerTag.suspect,
          LayerTag.visualTrace,
          LayerTag.repairHistory,
        },
        minimumEvidence = EvidenceLevel.unknown,
        includeValidity = IncludeValidity.includeStale,
        showNotPopulated = true,
        showRepairHistory = true,
        beginnerMode = false,
        includeVisualTraces = true,
        includeDamageAndSuspect = true,
        includeRawIds = true;

  const LayerFilter.measuredNetsOnly()
      : activeLayers = const {
          LayerTag.component,
          LayerTag.pin,
          LayerTag.electricalNet,
        },
        minimumEvidence = EvidenceLevel.measured,
        includeValidity = IncludeValidity.activeOnly,
        showNotPopulated = true,
        showRepairHistory = false,
        beginnerMode = false,
        includeVisualTraces = false,
        includeDamageAndSuspect = false,
        includeRawIds = false;

  const LayerFilter.fullAudit()
      : activeLayers = const {
          LayerTag.component,
          LayerTag.pin,
          LayerTag.electricalNet,
          LayerTag.measurement,
          LayerTag.damage,
          LayerTag.suspect,
          LayerTag.notPopulated,
          LayerTag.footprint,
          LayerTag.visualTrace,
          LayerTag.repairHistory,
        },
        minimumEvidence = EvidenceLevel.unknown,
        includeValidity = IncludeValidity.all,
        showNotPopulated = true,
        showRepairHistory = true,
        beginnerMode = false,
        includeVisualTraces = true,
        includeDamageAndSuspect = true,
        includeRawIds = true;

  final Set<LayerTag> activeLayers;
  final EvidenceLevel minimumEvidence;
  final IncludeValidity includeValidity;
  final bool showNotPopulated;
  final bool showRepairHistory;
  final bool beginnerMode;
  final bool includeVisualTraces;
  final bool includeDamageAndSuspect;
  final bool includeRawIds;
}

EvidenceLevel evidenceFromString(String? value) {
  switch (value) {
    case 'measured':
      return EvidenceLevel.measured;
    case 'source_imported_unverified':
      return EvidenceLevel.sourceImportedUnverified;
    case 'user_confirmed_visual':
      return EvidenceLevel.userConfirmedVisual;
    case 'visual_trace':
      return EvidenceLevel.visualTrace;
    case 'visual':
      return EvidenceLevel.visual;
    default:
      return EvidenceLevel.unknown;
  }
}

ValidityStatus validityFromString(String? value) {
  switch (value) {
    case 'active':
      return ValidityStatus.active;
    case 'stale_after_repair':
      return ValidityStatus.staleAfterRepair;
    case 'needs_identification':
      return ValidityStatus.needsIdentification;
    case 'confirmed':
      return ValidityStatus.confirmed;
    case 'suspect':
      return ValidityStatus.suspect;
    case 'verified_good':
      return ValidityStatus.verifiedGood;
    default:
      return ValidityStatus.unknown;
  }
}

class BoardGraphNode {
  const BoardGraphNode({
    required this.id,
    required this.label,
    required this.type,
    required this.evidence,
    required this.validity,
    required this.layers,
    this.data = const {},
  });

  final String id;
  final String label;
  final BoardGraphNodeType type;
  final EvidenceLevel evidence;
  final ValidityStatus validity;
  final Set<LayerTag> layers;
  final Map<String, dynamic> data;

  String get shortLabel => data['shortLabel']?.toString() ?? label;
}

class BoardGraphEdge {
  const BoardGraphEdge({
    required this.id,
    required this.fromId,
    required this.toId,
    required this.type,
    required this.evidence,
    required this.validity,
    required this.layers,
    this.data = const {},
  });

  final String id;
  final String fromId;
  final String toId;
  final BoardGraphEdgeType type;
  final EvidenceLevel evidence;
  final ValidityStatus validity;
  final Set<LayerTag> layers;
  final Map<String, dynamic> data;
}

class BoardGraphProjection {
  const BoardGraphProjection({
    required this.nodes,
    required this.edges,
    required this.nodeById,
    required this.pinsByComponent,
    required this.measurementsByComponent,
    required this.connectedComponentsByComponent,
    required this.visualTracesByPin,
    required this.visualTracesByComponent,
    required this.damageRegionsByComponent,
    required this.suspectRegionsByComponent,
  });

  final List<BoardGraphNode> nodes;
  final List<BoardGraphEdge> edges;
  final Map<String, BoardGraphNode> nodeById;
  final Map<String, List<String>> pinsByComponent;
  final Map<String, List<String>> measurementsByComponent;
  final Map<String, List<String>> connectedComponentsByComponent;
  final Map<String, List<String>> visualTracesByPin;
  final Map<String, List<String>> visualTracesByComponent;
  final Map<String, List<String>> damageRegionsByComponent;
  final Map<String, List<String>> suspectRegionsByComponent;

  static BoardGraphProjection empty() {
    return const BoardGraphProjection(
      nodes: <BoardGraphNode>[],
      edges: <BoardGraphEdge>[],
      nodeById: <String, BoardGraphNode>{},
      pinsByComponent: <String, List<String>>{},
      measurementsByComponent: <String, List<String>>{},
      connectedComponentsByComponent: <String, List<String>>{},
      visualTracesByPin: <String, List<String>>{},
      visualTracesByComponent: <String, List<String>>{},
      damageRegionsByComponent: <String, List<String>>{},
      suspectRegionsByComponent: <String, List<String>>{},
    );
  }

  BoardGraphProjection filter(LayerFilter filter) {
    final includeNodeIds = <String>{};
    for (final node in nodes) {
      if (!_passesNode(node, filter)) {
        continue;
      }
      includeNodeIds.add(node.id);
    }

    final filteredNodes = <BoardGraphNode>[];
    for (final node in nodes) {
      if (!includeNodeIds.contains(node.id)) {
        continue;
      }
      filteredNodes.add(
        filter.includeRawIds
            ? node
            : _sanitizeNode(node, includeRawData: false),
      );
    }

    final filteredEdges = <BoardGraphEdge>[];
    for (final edge in edges) {
      if (!_passesEdge(edge, filter)) {
        continue;
      }
      if (!includeNodeIds.contains(edge.fromId) ||
          !includeNodeIds.contains(edge.toId)) {
        continue;
      }
      filteredEdges.add(
        filter.includeRawIds
            ? edge
            : _sanitizeEdge(edge, includeRawData: false),
      );
    }

    return _rebuildIndexes(
      projectionNodes: filteredNodes,
      projectionEdges: filteredEdges,
    );
  }

  BoardGraphProjection focus({
    required String componentId,
    int depth = 1,
    required LayerFilter filter,
  }) {
    if (!nodeById.containsKey(componentId)) {
      return copyWith(nodes: const [], edges: const [], nodeById: {})
          .filter(filter);
    }

    final includeComponents = <String>{componentId};
    var frontier = <String>{componentId};
    for (var level = 0; level < depth; level++) {
      final next = <String>{};
      for (final component in frontier) {
        for (final neighbor
            in connectedComponentsByComponent[component] ?? const <String>[]) {
          if (includeComponents.add(neighbor)) {
            next.add(neighbor);
          }
        }
      }
      frontier = next;
      if (frontier.isEmpty) {
        break;
      }
    }

    final includeNodeIds = <String>{};
    for (final component in includeComponents) {
      if (nodeById.containsKey(component)) {
        includeNodeIds.add(component);
      }
      for (final pin in pinsByComponent[component] ?? const <String>[]) {
        includeNodeIds.add(pin);
      }
      for (final measurement
          in measurementsByComponent[component] ?? const <String>[]) {
        includeNodeIds.add(measurement);
      }
    }

    final queue = List<String>.from(includeNodeIds);
    while (queue.isNotEmpty) {
      final nodeId = queue.removeAt(0);
      for (final edge in edges) {
        if (edge.fromId == nodeId) {
          if (!_isFocusAllowedEdge(edge, filter)) continue;
          if (includeNodeIds.add(edge.toId)) {
            queue.add(edge.toId);
          }
          if (edge.type == BoardGraphEdgeType.visualTraceHint &&
              filter.includeVisualTraces) {
            includeNodeIds.add(edge.fromId);
          }
        }
        if (edge.toId == nodeId) {
          if (!_isFocusAllowedEdge(edge, filter)) continue;
          if (includeNodeIds.add(edge.fromId)) {
            queue.add(edge.fromId);
          }
        }
      }
    }

    final includedNodes =
        nodes.where((node) => includeNodeIds.contains(node.id)).toList();
    final includedEdges = edges.where((edge) {
      return includeNodeIds.contains(edge.fromId) &&
          includeNodeIds.contains(edge.toId) &&
          _isFocusAllowedEdge(edge, filter);
    }).toList();

    return _rebuildIndexes(
      projectionNodes: includedNodes,
      projectionEdges: includedEdges,
    ).filter(filter);
  }

  BoardGraphProjection copyWith({
    List<BoardGraphNode>? nodes,
    List<BoardGraphEdge>? edges,
    Map<String, BoardGraphNode>? nodeById,
    Map<String, List<String>>? pinsByComponent,
    Map<String, List<String>>? measurementsByComponent,
    Map<String, List<String>>? connectedComponentsByComponent,
    Map<String, List<String>>? visualTracesByPin,
    Map<String, List<String>>? visualTracesByComponent,
    Map<String, List<String>>? damageRegionsByComponent,
    Map<String, List<String>>? suspectRegionsByComponent,
  }) {
    return BoardGraphProjection(
      nodes: nodes ?? this.nodes,
      edges: edges ?? this.edges,
      nodeById: nodeById ?? this.nodeById,
      pinsByComponent: pinsByComponent ?? this.pinsByComponent,
      measurementsByComponent:
          measurementsByComponent ?? this.measurementsByComponent,
      connectedComponentsByComponent:
          connectedComponentsByComponent ?? this.connectedComponentsByComponent,
      visualTracesByPin: visualTracesByPin ?? this.visualTracesByPin,
      visualTracesByComponent:
          visualTracesByComponent ?? this.visualTracesByComponent,
      damageRegionsByComponent:
          damageRegionsByComponent ?? this.damageRegionsByComponent,
      suspectRegionsByComponent:
          suspectRegionsByComponent ?? this.suspectRegionsByComponent,
    );
  }

  static BoardGraphProjection _rebuildIndexes({
    required List<BoardGraphNode> projectionNodes,
    required List<BoardGraphEdge> projectionEdges,
  }) {
    final nodeById = {for (final node in projectionNodes) node.id: node};
    final pinsByComponent = <String, List<String>>{};
    final measurementsByComponent = <String, List<String>>{};
    final connectedComponentsByComponent = <String, List<String>>{};
    final visualTracesByPin = <String, List<String>>{};
    final visualTracesByComponent = <String, List<String>>{};
    final damageRegionsByComponent = <String, List<String>>{};
    final suspectRegionsByComponent = <String, List<String>>{};

    for (final edge in projectionEdges) {
      final from = nodeById[edge.fromId];
      final to = nodeById[edge.toId];
      if (from == null || to == null) continue;

      if (edge.type == BoardGraphEdgeType.hasPin &&
          from.type == BoardGraphNodeType.component &&
          to.type == BoardGraphNodeType.pin) {
        addUnique(
            pinsByComponent.putIfAbsent(from.id, () => <String>[]), to.id);
      }

      if (edge.type == BoardGraphEdgeType.measuredConnection &&
          from.type == BoardGraphNodeType.pin &&
          to.type == BoardGraphNodeType.net) {
        final componentId = _componentIdFromReference(from.id);
        final fromComp = _componentIdFromReference(from.id);
        final netData = to.data;
        final fromNet = netData['from']?.toString();
        final toNet = netData['to']?.toString();
        final endpoints = <String?>[fromNet, toNet];
        for (final endpoint in endpoints) {
          final otherComponent = _componentIdFromReference(endpoint ?? '');
          if (otherComponent == null || componentId == null) {
            continue;
          }
          if (otherComponent == componentId) {
            continue;
          }
          addUnique(
            connectedComponentsByComponent.putIfAbsent(
                componentId, () => <String>[]),
            otherComponent,
          );
          addUnique(
            connectedComponentsByComponent.putIfAbsent(
              otherComponent,
              () => <String>[],
            ),
            componentId,
          );
        }
      }

      if (edge.type == BoardGraphEdgeType.visualTraceHint) {
        if (from.type == BoardGraphNodeType.pin &&
            to.type == BoardGraphNodeType.visualTrace) {
          addUnique(
            visualTracesByPin.putIfAbsent(from.id, () => <String>[]),
            to.id,
          );
        }
        if (from.type == BoardGraphNodeType.component &&
            to.type == BoardGraphNodeType.visualTrace) {
          addUnique(
            visualTracesByComponent.putIfAbsent(from.id, () => <String>[]),
            to.id,
          );
        }
      }

      if (edge.type == BoardGraphEdgeType.annotatedRegion &&
          to.type == BoardGraphNodeType.component) {
        if (from.type == BoardGraphNodeType.damageRegion) {
          addUnique(
            damageRegionsByComponent.putIfAbsent(to.id, () => <String>[]),
            from.id,
          );
        }
        if (from.type == BoardGraphNodeType.suspectRegion) {
          addUnique(
            suspectRegionsByComponent.putIfAbsent(to.id, () => <String>[]),
            from.id,
          );
        }
      }
    }

    for (final node in projectionNodes) {
      if (node.type != BoardGraphNodeType.measurement) {
        continue;
      }
      final sourceComponents =
          (node.data['source_components'] as List<dynamic>?)
                  ?.whereType<String>() ??
              const [];
      for (final componentId in sourceComponents) {
        addUnique(
          measurementsByComponent.putIfAbsent(componentId, () => <String>[]),
          node.id,
        );
      }
    }

    return BoardGraphProjection(
      nodes: projectionNodes,
      edges: projectionEdges,
      nodeById: nodeById,
      pinsByComponent: normalizeStringListMap(pinsByComponent),
      measurementsByComponent: normalizeStringListMap(measurementsByComponent),
      connectedComponentsByComponent:
          normalizeStringListMap(connectedComponentsByComponent),
      visualTracesByPin: normalizeStringListMap(visualTracesByPin),
      visualTracesByComponent: normalizeStringListMap(visualTracesByComponent),
      damageRegionsByComponent:
          normalizeStringListMap(damageRegionsByComponent),
      suspectRegionsByComponent:
          normalizeStringListMap(suspectRegionsByComponent),
    );
  }

  static bool _passesNode(BoardGraphNode node, LayerFilter filter) {
    if (!filter.activeLayers.any(node.layers.contains)) {
      return false;
    }
    if (!_isAtLeastEvidence(node.evidence, filter.minimumEvidence)) {
      return false;
    }
    if (!_isAllowedValidity(node.validity, filter.includeValidity)) {
      return false;
    }
    if (!filter.showNotPopulated &&
        node.layers.contains(LayerTag.notPopulated)) {
      return false;
    }
    if (!filter.includeVisualTraces &&
        node.type == BoardGraphNodeType.visualTrace) {
      return false;
    }
    if (!filter.includeDamageAndSuspect &&
        (node.type == BoardGraphNodeType.damageRegion ||
            node.type == BoardGraphNodeType.suspectRegion)) {
      return false;
    }
    return true;
  }

  static bool _passesEdge(BoardGraphEdge edge, LayerFilter filter) {
    if (!filter.activeLayers.any(edge.layers.contains)) {
      return false;
    }
    if (!_isAtLeastEvidence(edge.evidence, filter.minimumEvidence)) {
      return false;
    }
    if (!_isAllowedValidity(edge.validity, filter.includeValidity)) {
      return false;
    }
    if (!filter.includeVisualTraces &&
        edge.type == BoardGraphEdgeType.visualTraceHint) {
      return false;
    }
    if (!filter.includeDamageAndSuspect &&
        edge.type == BoardGraphEdgeType.annotatedRegion) {
      return false;
    }
    return true;
  }

  static bool _isFocusAllowedEdge(BoardGraphEdge edge, LayerFilter filter) {
    if (!filter.includeVisualTraces &&
        edge.type == BoardGraphEdgeType.visualTraceHint) {
      return false;
    }
    if (!filter.includeDamageAndSuspect &&
        edge.type == BoardGraphEdgeType.annotatedRegion) {
      return false;
    }
    if (!filter.showRepairHistory &&
        (edge.type == BoardGraphEdgeType.staleAfter ||
            edge.type == BoardGraphEdgeType.affectedByRepair)) {
      return false;
    }
    return true;
  }
}

BoardGraphNode _sanitizeNode(
  BoardGraphNode node, {
  required bool includeRawData,
}) {
  if (includeRawData) {
    return node;
  }
  final data = Map<String, dynamic>.from(node.data)
    ..remove('origin_event_id')
    ..remove('valid_until_event_id')
    ..remove('confirmed_by_event_ids');
  return BoardGraphNode(
    id: node.id,
    label: node.label,
    type: node.type,
    evidence: node.evidence,
    validity: node.validity,
    layers: node.layers,
    data: data,
  );
}

BoardGraphEdge _sanitizeEdge(
  BoardGraphEdge edge, {
  required bool includeRawData,
}) {
  if (includeRawData) {
    return edge;
  }
  final data = Map<String, dynamic>.from(edge.data)
    ..remove('origin_event_id')
    ..remove('confirmed_by_event_ids')
    ..remove('raw_event_id');
  return BoardGraphEdge(
    id: edge.id,
    fromId: edge.fromId,
    toId: edge.toId,
    type: edge.type,
    evidence: edge.evidence,
    validity: edge.validity,
    layers: edge.layers,
    data: data,
  );
}

int _evidenceRank(EvidenceLevel level) {
  switch (level) {
    case EvidenceLevel.unknown:
      return 0;
    case EvidenceLevel.visual:
      return 1;
    case EvidenceLevel.visualTrace:
      return 2;
    case EvidenceLevel.userConfirmedVisual:
      return 3;
    case EvidenceLevel.sourceImportedUnverified:
      return 4;
    case EvidenceLevel.measured:
      return 5;
  }
}

bool _isAtLeastEvidence(EvidenceLevel actual, EvidenceLevel minimum) {
  return _evidenceRank(actual) >= _evidenceRank(minimum);
}

bool _isAllowedValidity(
    ValidityStatus status, IncludeValidity includeValidity) {
  if (includeValidity == IncludeValidity.activeOnly) {
    return status != ValidityStatus.staleAfterRepair;
  }
  return true;
}

String? _componentIdFromReference(String reference) {
  final idx = reference.indexOf('.');
  if (idx <= 0) {
    return null;
  }
  return reference.substring(0, idx);
}

void addUnique(List<String> values, String value) {
  if (!values.contains(value)) {
    values.add(value);
  }
}

Map<String, List<String>> normalizeStringListMap(
  Map<String, List<String>> source,
) {
  final out = SplayTreeMap<String, List<String>>();
  for (final entry in source.entries) {
    final normalized = <String>[];
    for (final value in entry.value) {
      addUnique(normalized, value);
    }
    normalized.sort();
    out[entry.key] = normalized;
  }
  return out;
}
