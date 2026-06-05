import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:trace_bench_viewer/features/board_graph/models/board_graph_model.dart';
import 'package:trace_bench_viewer/features/board_graph/services/board_graph_projector.dart';
import 'package:trace_bench_viewer/features/board_graph/services/graph_layout.dart';
import 'package:trace_bench_viewer/shared/models/known_facts.dart';

KnownFacts _sampleKnownFacts() {
  final raw = File(
    'assets/samples/pelle_pv20_minimal/known_facts.json',
  ).readAsStringSync();
  return KnownFacts.fromJson(jsonDecode(raw) as Map<String, dynamic>);
}

KnownFacts _inlineKnownFacts(Map<String, dynamic> payload) {
  return KnownFacts.fromJson(payload);
}

void main() {
  test('visual_trace_node_has_visual_trace_layer_not_electrical_net_layer', () {
    final knownFacts = _inlineKnownFacts({
      'project_id': 'p',
      'components': [
        {'component_id': 'Q2', 'status': 'needs_identification'},
      ],
      'pins': [
        {'component_id': 'Q2', 'pin_id': 'Q2.1'},
      ],
      'visual_traces': [
        {
          'trace_id': 'VT001',
          'photo_id': 'photo_1',
          'evidence_type': 'visual_trace',
          'from_pin': 'Q2.1',
        },
      ],
      'component_pin_index': {
        'Q2': ['Q2.1'],
      },
    });
    final projection = BoardGraphProjector.fromKnownFacts(knownFacts);
    final traceNodes = projection.nodes
        .where((node) => node.type == BoardGraphNodeType.visualTrace)
        .toList();

    expect(traceNodes, hasLength(1));
    expect(traceNodes.first.layers, contains(LayerTag.visualTrace));
    expect(traceNodes.first.layers, isNot(contains(LayerTag.electricalNet)));
    expect(
      projection.edges
          .where(
            (edge) =>
                edge.type == BoardGraphEdgeType.measuredConnection &&
                (edge.fromId == traceNodes.first.id ||
                    edge.toId == traceNodes.first.id),
          )
          .toList(),
      isEmpty,
    );
  });

  test('beginner_filter_hides_visual_traces', () {
    final knownFacts = _inlineKnownFacts({
      'project_id': 'p',
      'components': [
        {'component_id': 'Q2'},
      ],
      'pins': [
        {'component_id': 'Q2', 'pin_id': 'Q2.1'},
      ],
      'visual_traces': [
        {
          'trace_id': 'VT001',
          'photo_id': 'photo_1',
          'evidence_type': 'visual_trace',
        },
      ],
      'component_pin_index': {
        'Q2': ['Q2.1'],
      },
    });
    final projection = BoardGraphProjector.fromKnownFacts(knownFacts);
    final filtered = projection.filter(const LayerFilter.beginner());

    expect(
      filtered.nodes
          .where((node) => node.type == BoardGraphNodeType.visualTrace),
      isEmpty,
    );
  });

  test('beginner_filter_hides_suspect_regions', () {
    final knownFacts = _inlineKnownFacts({
      'project_id': 'p',
      'components': [
        {'component_id': 'Q2'},
      ],
      'pins': [
        {'component_id': 'Q2', 'pin_id': 'Q2.1'},
      ],
      'suspect_regions': [
        {
          'region_id': 'S001',
          'photo_id': 'photo_1',
          'bbox': {'x': 1, 'y': 1, 'width': 3, 'height': 4},
          'reason': 'heat',
        },
      ],
      'component_pin_index': {
        'Q2': ['Q2.1'],
      },
    });
    final projection = BoardGraphProjector.fromKnownFacts(knownFacts);
    final filtered = projection.filter(const LayerFilter.beginner());

    expect(
      filtered.nodes
          .where((node) => node.type == BoardGraphNodeType.suspectRegion),
      isEmpty,
    );
  });

  test(
    'measurements_by_component_contains_measurements_not_net_ids',
    () {
      final knownFacts = _inlineKnownFacts({
        'project_id': 'p',
        'components': [
          {'component_id': 'Q2'},
          {'component_id': 'R17'},
        ],
        'pins': [
          {'component_id': 'Q2', 'pin_id': 'Q2.1'},
          {'component_id': 'R17', 'pin_id': 'R17.1'},
        ],
        'measurements': [
          {
            'measurement_id': 'M001',
            'mode': 'continuity',
            'from': 'Q2.1',
            'to': 'R17.1',
            'reading': {'kind': 'numeric', 'value': 1, 'unit': 'ohm'},
            'power_state': 'off',
            'origin_event_id': 'evt_000001',
            'validity_status': 'active',
          },
        ],
        'nets': [
          {
            'net_id': 'N1',
            'from': 'Q2.1',
            'to': 'R17.1',
            'confirmation_basis': 'measured',
            'confirmed_by_event_ids': ['evt_000001'],
          },
        ],
        'component_pin_index': {
          'Q2': ['Q2.1'],
          'R17': ['R17.1'],
        },
      });

      final projection = BoardGraphProjector.fromKnownFacts(knownFacts);

      final q2Measurements = projection.measurementsByComponent['Q2'] ?? [];
      final r17Measurements = projection.measurementsByComponent['R17'] ?? [];

      expect(q2Measurements, contains('M001'));
      expect(q2Measurements, isNot(contains('N1')));
      expect(r17Measurements, contains('M001'));
      expect(r17Measurements, isNot(contains('N1')));
    },
  );

  test('focus_q2_includes_pins_and_measurements', () {
    final knownFacts = _inlineKnownFacts({
      'project_id': 'p',
      'components': [
        {'component_id': 'Q2'},
        {'component_id': 'U9'},
      ],
      'pins': [
        {'component_id': 'Q2', 'pin_id': 'Q2.1'},
        {'component_id': 'Q2', 'pin_id': 'Q2.2'},
        {'component_id': 'Q2', 'pin_id': 'Q2.3'},
      ],
      'measurements': [
        {
          'measurement_id': 'M001',
          'mode': 'continuity',
          'from': 'Q2.1',
          'to': 'Q2.2',
          'reading': {'kind': 'numeric', 'value': 1, 'unit': 'ohm'},
          'power_state': 'off',
          'origin_event_id': 'evt_000001',
          'validity_status': 'stale_after_repair',
        },
        {
          'measurement_id': 'M002',
          'mode': 'continuity',
          'from': 'Q2.2',
          'to': 'Q2.3',
          'reading': {'kind': 'numeric', 'value': 2, 'unit': 'ohm'},
          'power_state': 'off',
          'origin_event_id': 'evt_000002',
          'validity_status': 'active',
        },
      ],
      'component_pin_index': {
        'Q2': ['Q2.1', 'Q2.2', 'Q2.3'],
      },
    });

    final projection = BoardGraphProjector.fromKnownFacts(knownFacts);
    final focused = projection.focus(
      componentId: 'Q2',
      depth: 1,
      filter: const LayerFilter.fullAudit(),
    );

    expect(
      focused.nodes.where((node) => node.id == 'Q2'),
      isNotEmpty,
    );
    expect(
      focused.nodes.where((node) => node.id == 'Q2.1'),
      isNotEmpty,
    );
    expect(
      focused.nodes.where((node) => node.id == 'Q2.2'),
      isNotEmpty,
    );
    expect(
      focused.nodes.where((node) => node.id == 'Q2.3'),
      isNotEmpty,
    );
    expect(focused.nodes.where((node) => node.id == 'M001'), isNotEmpty);
    expect(focused.nodes.where((node) => node.id == 'M002'), isNotEmpty);
  });

  test('focus_q2_excludes_unrelated_components', () {
    final knownFacts = _inlineKnownFacts({
      'project_id': 'p',
      'components': [
        {'component_id': 'Q2'},
        {'component_id': 'U9'},
      ],
      'pins': [
        {'component_id': 'Q2', 'pin_id': 'Q2.1'},
        {'component_id': 'U9', 'pin_id': 'U9.1'},
      ],
      'component_pin_index': {
        'Q2': ['Q2.1'],
        'U9': ['U9.1'],
      },
    });
    final projection = BoardGraphProjector.fromKnownFacts(knownFacts);
    final focused = projection.focus(
      componentId: 'Q2',
      depth: 1,
      filter: const LayerFilter.fullAudit(),
    );

    expect(focused.nodes.where((node) => node.id == 'Q2'), isNotEmpty);
    expect(focused.nodes.where((node) => node.id == 'U9'), isEmpty);
  });

  test('stale_measurement_visible_with_history_enabled', () {
    final knownFacts = _inlineKnownFacts({
      'project_id': 'p',
      'components': [
        {'component_id': 'Q2'},
      ],
      'pins': [
        {'component_id': 'Q2', 'pin_id': 'Q2.1'},
      ],
      'measurements': [
        {
          'measurement_id': 'M001',
          'mode': 'continuity',
          'from': 'Q2.1',
          'to': 'R17.1',
          'reading': {'kind': 'numeric', 'value': 1, 'unit': 'ohm'},
          'power_state': 'off',
          'origin_event_id': 'evt_000001',
          'validity_status': 'stale_after_repair',
        },
      ],
      'component_pin_index': {
        'Q2': ['Q2.1']
      },
    });
    final projection = BoardGraphProjector.fromKnownFacts(knownFacts);
    final filtered = projection.filter(const LayerFilter.fullAudit());

    expect(filtered.nodes.where((node) => node.id == 'M001'), isNotEmpty);
  });

  test('stale_measurement_hidden_with_active_only_filter', () {
    final knownFacts = _inlineKnownFacts({
      'project_id': 'p',
      'components': [
        {'component_id': 'Q2'},
      ],
      'pins': [
        {'component_id': 'Q2', 'pin_id': 'Q2.1'},
      ],
      'measurements': [
        {
          'measurement_id': 'M001',
          'mode': 'continuity',
          'from': 'Q2.1',
          'to': 'R17.1',
          'reading': {'kind': 'numeric', 'value': 1, 'unit': 'ohm'},
          'power_state': 'off',
          'origin_event_id': 'evt_000001',
          'validity_status': 'stale_after_repair',
        },
      ],
      'component_pin_index': {
        'Q2': ['Q2.1']
      },
    });
    final projection = BoardGraphProjector.fromKnownFacts(knownFacts);
    final filtered = projection.filter(const LayerFilter.beginner());

    expect(filtered.nodes.where((node) => node.id == 'M001'), isEmpty);
  });

  test('not_populated_node_has_no_measured_connection_edges', () {
    final knownFacts = _inlineKnownFacts({
      'project_id': 'p',
      'components': [
        {'component_id': 'Q2'},
      ],
      'pins': [
        {'component_id': 'Q2', 'pin_id': 'Q2.1'},
      ],
      'excluded_from_fault_candidates': [
        {'footprint_id': 'K1'},
      ],
      'nets': [
        {
          'net_id': 'N1',
          'from': 'K1.1',
          'to': 'Q2.1',
          'confirmation_basis': 'measured',
          'confirmed_by_event_ids': ['evt_000010'],
        },
      ],
      'measurements': [
        {
          'measurement_id': 'M001',
          'mode': 'continuity',
          'from': 'Q2.1',
          'to': 'R17.1',
          'reading': {'kind': 'numeric', 'value': 1, 'unit': 'ohm'},
          'power_state': 'off',
          'origin_event_id': 'evt_000001',
          'validity_status': 'active',
        },
      ],
      'component_pin_index': {
        'Q2': ['Q2.1']
      },
    });
    final projection = BoardGraphProjector.fromKnownFacts(knownFacts);

    expect(projection.nodes.where((node) => node.id == 'K1'), isNotEmpty);
    expect(
      projection.edges.where(
        (edge) =>
            edge.type == BoardGraphEdgeType.measuredConnection &&
            (edge.fromId == 'K1' || edge.toId == 'K1'),
      ),
      isEmpty,
    );
  });

  test('advanced_filter_shows_raw_event_ids', () {
    final projection =
        BoardGraphProjector.fromKnownFacts(_sampleKnownFacts()).filter(
      const LayerFilter.fullAudit(),
    );

    final measurementNode = projection.nodes
        .where((node) => node.type == BoardGraphNodeType.measurement)
        .firstWhere((node) => node.id == 'M001');
    expect(measurementNode.data['origin_event_id'], 'evt_000006');

    final netNode = projection.nodes
        .where((node) => node.type == BoardGraphNodeType.net)
        .firstWhere((node) => node.id == 'N1');
    expect(
      (netNode.data['confirmed_by_event_ids'] as List<String>?)?.isNotEmpty,
      isTrue,
    );
  });

  test('auto_layout_is_deterministic_same_input_same_positions', () {
    final knownFacts = _inlineKnownFacts({
      'project_id': 'p',
      'components': [
        {'component_id': 'Q2'},
        {'component_id': 'U9'},
      ],
      'pins': [
        {'component_id': 'Q2', 'pin_id': 'Q2.1'},
        {'component_id': 'U9', 'pin_id': 'U9.1'},
      ],
      'measurements': [
        {
          'measurement_id': 'M001',
          'mode': 'continuity',
          'from': 'Q2.1',
          'to': 'U9.1',
          'reading': {'kind': 'numeric', 'value': 1, 'unit': 'ohm'},
          'power_state': 'off',
          'origin_event_id': 'evt_000001',
          'validity_status': 'active',
        },
      ],
      'nets': [
        {
          'net_id': 'N1',
          'from': 'Q2.1',
          'to': 'U9.1',
          'confirmation_basis': 'measured',
          'confirmed_by_event_ids': ['evt_000001'],
        },
      ],
      'excluded_from_fault_candidates': [
        {'footprint_id': 'K1'},
      ],
      'component_pin_index': {
        'Q2': ['Q2.1'],
        'U9': ['U9.1']
      },
    });
    final projection = BoardGraphProjector.fromKnownFacts(knownFacts);
    final first = GraphLayoutEngine.layout(projection).nodePositions;
    final second = GraphLayoutEngine.layout(projection).nodePositions;

    expect(first.length, second.length);
    for (final entry in first.entries) {
      final offset2 = second[entry.key];
      expect(offset2, isNotNull);
      expect(offset2!.dx, entry.value.dx);
      expect(offset2.dy, entry.value.dy);
    }
  });

  test('component_pin_index_drives_has_pin_edges', () {
    final knownFacts = _inlineKnownFacts({
      'project_id': 'p',
      'components': [
        {'component_id': 'Q2'},
      ],
      'pins': [
        {'component_id': 'Q2', 'pin_id': 'Q2.1'},
        {'component_id': 'Q2', 'pin_id': 'Q2.2'},
        {'component_id': 'Q2', 'pin_id': 'Q2.3'},
      ],
      'component_pin_index': {
        'Q2': ['Q2.1', 'Q2.2'],
      },
    });
    final projection = BoardGraphProjector.fromKnownFacts(knownFacts);
    final edges = projection.edges
        .where(
          (edge) =>
              edge.type == BoardGraphEdgeType.hasPin && edge.fromId == 'Q2',
        )
        .map((edge) => edge.toId)
        .toList();

    expect(edges, containsAll(<String>['Q2.1', 'Q2.2']));
    expect(edges, isNot(contains('Q2.3')));
  });

  test('measured_connections_come_only_from_nets', () {
    final noNets = _inlineKnownFacts({
      'project_id': 'p',
      'components': [
        {'component_id': 'Q2'},
      ],
      'pins': [
        {'component_id': 'Q2', 'pin_id': 'Q2.1'},
      ],
      'measurements': [
        {
          'measurement_id': 'M001',
          'mode': 'continuity',
          'from': 'Q2.1',
          'to': 'R17.1',
          'reading': {'kind': 'numeric', 'value': 1, 'unit': 'ohm'},
          'power_state': 'off',
          'origin_event_id': 'evt_000001',
          'validity_status': 'active',
        },
      ],
      'component_pin_index': {
        'Q2': ['Q2.1']
      },
    });

    final projectionWithoutNets = BoardGraphProjector.fromKnownFacts(noNets);
    expect(
      projectionWithoutNets.edges
          .where((edge) => edge.type == BoardGraphEdgeType.measuredConnection),
      isEmpty,
    );

    final withNets = _inlineKnownFacts({
      'project_id': 'p',
      'components': [
        {'component_id': 'Q2'},
      ],
      'pins': [
        {'component_id': 'Q2', 'pin_id': 'Q2.1'},
        {'component_id': 'R17', 'pin_id': 'R17.1'},
      ],
      'measurements': [
        {
          'measurement_id': 'M001',
          'mode': 'continuity',
          'from': 'Q2.1',
          'to': 'R17.1',
          'reading': {'kind': 'numeric', 'value': 1, 'unit': 'ohm'},
          'power_state': 'off',
          'origin_event_id': 'evt_000001',
          'validity_status': 'active',
        },
      ],
      'nets': [
        {
          'net_id': 'N1',
          'from': 'Q2.1',
          'to': 'R17.1',
          'confirmation_basis': 'measured',
          'confirmed_by_event_ids': ['evt_000001'],
        },
      ],
      'component_pin_index': {
        'Q2': ['Q2.1'],
        'R17': ['R17.1']
      },
    });
    final projectionWithNets = BoardGraphProjector.fromKnownFacts(withNets);
    expect(
      projectionWithNets.edges.any(
        (edge) => edge.type == BoardGraphEdgeType.measuredConnection,
      ),
      isTrue,
    );
  });
}
