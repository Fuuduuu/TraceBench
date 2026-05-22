import 'package:trace_bench_viewer/features/board_graph/models/board_graph_model.dart';
import 'package:trace_bench_viewer/shared/models/known_facts.dart';

class BoardGraphProjector {
  BoardGraphProjector._();

  static BoardGraphProjection fromKnownFacts(KnownFacts knownFacts) {
    final components = [...knownFacts.components]
      ..sort((a, b) => a.componentId.compareTo(b.componentId));
    final pins = [...knownFacts.pins]
      ..sort((a, b) => a.pinId.compareTo(b.pinId));
    final measurements = [...knownFacts.measurements]
      ..sort((a, b) => a.measurementId.compareTo(b.measurementId));
    final nets = [...knownFacts.nets]..sort((a, b) => a.netId.compareTo(b.netId));
    final excluded = [...knownFacts.excludedFromFaultCandidates]
      ..sort((a, b) => a.footprintId.compareTo(b.footprintId));
    final damageRegions = [...knownFacts.damageRegions]
      ..sort((a, b) => a.regionId.compareTo(b.regionId));
    final suspectRegions = [...knownFacts.suspectRegions]
      ..sort((a, b) => a.regionId.compareTo(b.regionId));
    final visualTraces = [...knownFacts.visualTraces]
      ..sort((a, b) => a.traceId.compareTo(b.traceId));

    final excludedFootprintIds = excluded
        .map((e) => e.footprintId.toLowerCase())
        .toSet();
    final pinsByComponent = _buildPinIndex(knownFacts, pins);

    final nodeById = <String, BoardGraphNode>{};
    final nodes = <BoardGraphNode>[];
    final edges = <BoardGraphEdge>[];

    for (final component in components) {
      final node = BoardGraphNode(
        id: component.componentId,
        label: component.designator ?? component.componentId,
        type: BoardGraphNodeType.component,
        evidence: _componentEvidence(component.status),
        validity: _componentValidity(component.status),
        layers: {LayerTag.component},
        data: {
          'component_id': component.componentId,
          'designator': component.designator,
          'status': component.status,
        },
      );
      nodes.add(node);
      nodeById[node.id] = node;
    }

    final measurementsByComponent = <String, List<String>>{};

    for (final pin in pins) {
      final pinNode = BoardGraphNode(
        id: pin.pinId,
        label: pin.pinId,
        type: BoardGraphNodeType.pin,
        evidence: evidenceFromString(pin.status),
        validity: _pinValidity(pin.status),
        layers: {LayerTag.pin},
        data: {
          'pin_id': pin.pinId,
          'component_id': pin.componentId,
          'status': pin.status,
        },
      );
      nodes.add(pinNode);
      nodeById[pin.pinId] = pinNode;
    }

    for (final footprint in excluded) {
      nodes.add(
        BoardGraphNode(
          id: footprint.footprintId,
          label: footprint.designator ?? footprint.footprintId,
          type: BoardGraphNodeType.footprint,
          evidence: EvidenceLevel.userConfirmedVisual,
          validity: ValidityStatus.unknown,
          layers: {LayerTag.notPopulated, LayerTag.footprint},
          data: {
            'footprint_id': footprint.footprintId,
            'designator': footprint.designator,
          },
        ),
      );
      nodeById[footprint.footprintId] = nodes.last;
    }

    final netNodes = <String>[];
    for (final net in nets) {
      if (net.confirmationBasis != 'measured') {
        continue;
      }
      if (_hasNotPopulatedEndpoint(net.from, excludedFootprintIds) ||
          _hasNotPopulatedEndpoint(net.to, excludedFootprintIds)) {
        continue;
      }

      final node = BoardGraphNode(
        id: net.netId,
        label: net.netId,
        type: BoardGraphNodeType.net,
        evidence: EvidenceLevel.measured,
        validity: ValidityStatus.confirmed,
        layers: {LayerTag.electricalNet},
        data: {
          'net_id': net.netId,
          'from': net.from,
          'to': net.to,
          'confirmation_basis': net.confirmationBasis,
          'confirmed_by_event_ids': net.confirmedByEventIds,
          'label': net.label,
          'verification_level': net.verificationLevel,
        },
      );
      nodes.add(node);
      nodeById[node.id] = node;
      netNodes.add(node.id);
    }

    for (final m in measurements) {
      final sourceComponents = <String>[];
      for (final endpoint in <String>[m.from, m.to]) {
        final componentId = _componentIdFromReference(endpoint);
        if (componentId != null) {
          addUnique(sourceComponents, componentId);
        }
      }

      final measurementNode = BoardGraphNode(
        id: m.measurementId,
        label: m.measurementId,
        type: BoardGraphNodeType.measurement,
        evidence: EvidenceLevel.measured,
        validity: validityFromString(m.validityStatus),
        layers: {LayerTag.measurement},
        data: {
          'measurement_id': m.measurementId,
          'from': m.from,
          'to': m.to,
          'origin_event_id': m.originEventId,
          'valid_until_event_id': m.validUntilEventId,
          'source_components': sourceComponents,
        },
      );
      nodes.add(measurementNode);
      nodeById[measurementNode.id] = measurementNode;

      for (final componentId in sourceComponents) {
        addUnique(
          measurementsByComponent.putIfAbsent(componentId, () => <String>[]),
          measurementNode.id,
        );
      }
    }

    final connectedByComponent = <String, List<String>>{};
    for (final entry in normalizeStringListMap(pinsByComponent).entries) {
      for (final pinId in entry.value) {
        if (!nodeById.containsKey(entry.key) || !nodeById.containsKey(pinId)) {
          continue;
        }
        if (nodeById[pinId]!.type != BoardGraphNodeType.pin) {
          continue;
        }
        edges.add(
          BoardGraphEdge(
            id: 'pin:${entry.key}:$pinId',
            fromId: entry.key,
            toId: pinId,
            type: BoardGraphEdgeType.hasPin,
            evidence: EvidenceLevel.userConfirmedVisual,
            validity: ValidityStatus.unknown,
            layers: {LayerTag.component, LayerTag.pin},
            data: {'relation': 'has_pin'},
          ),
        );
      }
    }

    for (final netId in netNodes) {
      final node = nodeById[netId];
      if (node == null) continue;

      final from = node.data['from']?.toString() ?? '';
      final to = node.data['to']?.toString() ?? '';
      final endpointPins = <String>[];
      if (nodeById.containsKey(from) &&
          nodeById[from]!.type == BoardGraphNodeType.pin) {
        endpointPins.add(from);
      }
      if (nodeById.containsKey(to) &&
          nodeById[to]!.type == BoardGraphNodeType.pin &&
          to != from) {
        endpointPins.add(to);
      }

      for (final pin in endpointPins) {
        edges.add(
          BoardGraphEdge(
            id: 'mc:$pin->$netId',
            fromId: pin,
            toId: netId,
            type: BoardGraphEdgeType.measuredConnection,
            evidence: EvidenceLevel.measured,
            validity: ValidityStatus.confirmed,
            layers: {LayerTag.electricalNet, LayerTag.pin},
            data: {
              'net_id': netId,
              'from_pin': pin,
              'from_pin_component': _componentIdFromReference(pin),
            },
          ),
        );
      }

      final componentsOnNet = <String>[];
      final fromComponent = _componentIdFromReference(from);
      if (fromComponent != null) {
        addUnique(componentsOnNet, fromComponent);
      }
      final toComponent = _componentIdFromReference(to);
      if (toComponent != null) {
        addUnique(componentsOnNet, toComponent);
      }
      for (var i = 0; i < componentsOnNet.length; i++) {
        for (var j = i + 1; j < componentsOnNet.length; j++) {
          final a = componentsOnNet[i];
          final b = componentsOnNet[j];
          addUnique(connectedByComponent.putIfAbsent(a, () => <String>[]), b);
          addUnique(connectedByComponent.putIfAbsent(b, () => <String>[]), a);
        }
      }
    }

    final visualTracesByPin = <String, List<String>>{};
    final visualTracesByComponent = <String, List<String>>{};
    for (final trace in visualTraces) {
      if (trace.evidenceType != 'visual_trace') {
        continue;
      }

      final node = BoardGraphNode(
        id: trace.traceId,
        label: trace.traceId,
        type: BoardGraphNodeType.visualTrace,
        evidence: EvidenceLevel.visualTrace,
        validity: ValidityStatus.unknown,
        layers: {LayerTag.visualTrace},
        data: {
          'trace_id': trace.traceId,
          'photo_id': trace.photoId,
          'from_component': trace.fromComponent,
          'to_component': trace.toComponent,
          'from_pin': trace.fromPin,
          'to_pin': trace.toPin,
          'evidence_type': trace.evidenceType,
          'confidence': trace.confidence,
          'layer': trace.layer,
          'notes': trace.notes,
        },
      );
      nodes.add(node);
      nodeById[node.id] = node;

      final endpointPins = <String>{}
        ..addAll([
          if (trace.fromPin != null) trace.fromPin!,
          if (trace.toPin != null) trace.toPin!,
        ]);
      for (final pin in endpointPins) {
        if (!nodeById.containsKey(pin) ||
            nodeById[pin]!.type != BoardGraphNodeType.pin) {
          continue;
        }
        addUnique(visualTracesByPin.putIfAbsent(pin, () => <String>[]), node.id);
        edges.add(
          BoardGraphEdge(
            id: 'trace:$pin:${node.id}',
            fromId: pin,
            toId: node.id,
            type: BoardGraphEdgeType.visualTraceHint,
            evidence: EvidenceLevel.visualTrace,
            validity: ValidityStatus.unknown,
            layers: {LayerTag.visualTrace, LayerTag.pin},
            data: {'trace_id': node.id},
          ),
        );
      }

      if (trace.fromComponent != null && nodeById.containsKey(trace.fromComponent)) {
        addUnique(
          visualTracesByComponent.putIfAbsent(trace.fromComponent!, () => <String>[]),
          node.id,
        );
        edges.add(
          BoardGraphEdge(
            id: 'trace:${trace.fromComponent}:${node.id}:from',
            fromId: trace.fromComponent!,
            toId: node.id,
            type: BoardGraphEdgeType.visualTraceHint,
            evidence: EvidenceLevel.visualTrace,
            validity: ValidityStatus.unknown,
            layers: {LayerTag.visualTrace, LayerTag.component},
            data: {'trace_id': node.id},
          ),
        );
      }
      if (trace.toComponent != null && nodeById.containsKey(trace.toComponent)) {
        addUnique(
          visualTracesByComponent.putIfAbsent(trace.toComponent!, () => <String>[]),
          node.id,
        );
        edges.add(
          BoardGraphEdge(
            id: 'trace:${trace.toComponent}:${node.id}:to',
            fromId: trace.toComponent!,
            toId: node.id,
            type: BoardGraphEdgeType.visualTraceHint,
            evidence: EvidenceLevel.visualTrace,
            validity: ValidityStatus.unknown,
            layers: {LayerTag.visualTrace, LayerTag.component},
            data: {'trace_id': node.id},
          ),
        );
      }
    }

    final damageRegionsByComponent = <String, List<String>>{};
    for (final region in damageRegions) {
      final node = BoardGraphNode(
        id: region.regionId,
        label: region.regionId,
        type: BoardGraphNodeType.damageRegion,
        evidence: EvidenceLevel.visual,
        validity: ValidityStatus.unknown,
        layers: {LayerTag.damage},
        data: {
          'region_id': region.regionId,
          'photo_id': region.photoId,
          'damage_type': region.damageType,
          'severity': region.severity,
          'notes': region.notes,
          'affects_components': region.affectsComponents ?? const <String>[],
        },
      );
      nodes.add(node);
      nodeById[node.id] = node;

      for (final componentId in region.affectsComponents ?? const <String>[]) {
        if (!nodeById.containsKey(componentId)) continue;
        addUnique(
          damageRegionsByComponent.putIfAbsent(componentId, () => <String>[]),
          node.id,
        );
        edges.add(
          BoardGraphEdge(
            id: 'region:${node.id}:$componentId',
            fromId: node.id,
            toId: componentId,
            type: BoardGraphEdgeType.annotatedRegion,
            evidence: EvidenceLevel.visual,
            validity: ValidityStatus.unknown,
            layers: {LayerTag.damage},
            data: {
              'region_id': node.id,
              'component_id': componentId,
            },
          ),
        );
      }
    }

    final suspectRegionsByComponent = <String, List<String>>{};
    for (final region in suspectRegions) {
      final node = BoardGraphNode(
        id: region.regionId,
        label: region.regionId,
        type: BoardGraphNodeType.suspectRegion,
        evidence: EvidenceLevel.visual,
        validity: ValidityStatus.unknown,
        layers: {LayerTag.suspect},
        data: {
          'region_id': region.regionId,
          'photo_id': region.photoId,
          'reason': region.reason,
          'priority': region.priority,
          'notes': region.notes,
          'affects_components': region.affectsComponents ?? const <String>[],
        },
      );
      nodes.add(node);
      nodeById[node.id] = node;

      for (final componentId in region.affectsComponents ?? const <String>[]) {
        if (!nodeById.containsKey(componentId)) continue;
        addUnique(
          suspectRegionsByComponent.putIfAbsent(componentId, () => <String>[]),
          node.id,
        );
        edges.add(
          BoardGraphEdge(
            id: 'region:${node.id}:$componentId',
            fromId: node.id,
            toId: componentId,
            type: BoardGraphEdgeType.annotatedRegion,
            evidence: EvidenceLevel.visual,
            validity: ValidityStatus.unknown,
            layers: {LayerTag.suspect},
            data: {
              'region_id': node.id,
              'component_id': componentId,
            },
          ),
        );
      }
    }

    final sortedNodes = [...nodes]..sort((a, b) => a.id.compareTo(b.id));
    final sortedEdges = [...edges]..sort((a, b) => a.id.compareTo(b.id));

    return BoardGraphProjection(
      nodes: sortedNodes,
      edges: sortedEdges,
      nodeById: {for (final node in sortedNodes) node.id: node},
      pinsByComponent: normalizeStringListMap(pinsByComponent),
      measurementsByComponent: normalizeStringListMap(measurementsByComponent),
      connectedComponentsByComponent: normalizeStringListMap(connectedByComponent),
      visualTracesByPin: normalizeStringListMap(visualTracesByPin),
      visualTracesByComponent: normalizeStringListMap(visualTracesByComponent),
      damageRegionsByComponent: normalizeStringListMap(damageRegionsByComponent),
      suspectRegionsByComponent: normalizeStringListMap(suspectRegionsByComponent),
    );
  }

  static Map<String, List<String>> _buildPinIndex(
    KnownFacts knownFacts,
    List<PinFact> orderedPins,
  ) {
    if (knownFacts.componentPinIndex.isNotEmpty) {
      return {
        for (final entry in knownFacts.componentPinIndex.entries)
          entry.key: _unique(entry.value),
      };
    }

    final fallback = <String, List<String>>{};
    for (final pin in orderedPins) {
      addUnique(fallback.putIfAbsent(pin.componentId, () => <String>[]), pin.pinId);
    }
    return fallback;
  }

  static bool _hasNotPopulatedEndpoint(
    String endpoint,
    Set<String> excludedIds,
  ) {
    final normalized = endpoint.toLowerCase();
    for (final excluded in excludedIds) {
      if (normalized == excluded || normalized.startsWith('$excluded.') ||
          normalized.startsWith('$excluded-')) {
        return true;
      }
    }
    return false;
  }

  static EvidenceLevel _componentEvidence(String? status) {
    switch (status) {
      case 'confirmed':
      case 'verified_good':
        return EvidenceLevel.userConfirmedVisual;
      case 'suspect':
        return EvidenceLevel.userConfirmedVisual;
      case 'needs_identification':
        return EvidenceLevel.unknown;
      default:
        return EvidenceLevel.unknown;
    }
  }

  static ValidityStatus _componentValidity(String? status) {
    switch (status) {
      case 'needs_identification':
        return ValidityStatus.needsIdentification;
      case 'confirmed':
        return ValidityStatus.confirmed;
      case 'verified_good':
        return ValidityStatus.verifiedGood;
      case 'suspect':
        return ValidityStatus.suspect;
      default:
        return ValidityStatus.unknown;
    }
  }

  static ValidityStatus _pinValidity(String? status) {
    switch (status) {
      case 'measured':
        return ValidityStatus.confirmed;
      case 'suspect':
        return ValidityStatus.suspect;
      case 'needs_identification':
        return ValidityStatus.needsIdentification;
      default:
        return ValidityStatus.unknown;
    }
  }

  static String? _componentIdFromReference(String reference) {
    final trimmed = reference.trim();
    if (trimmed.isEmpty) return null;
    final index = trimmed.indexOf('.');
    if (index <= 0) return null;
    return trimmed.substring(0, index);
  }

  static List<String> _unique(List<String> values) {
    final unique = <String>[];
    for (final value in values) {
      addUnique(unique, value);
    }
    return unique;
  }
}
