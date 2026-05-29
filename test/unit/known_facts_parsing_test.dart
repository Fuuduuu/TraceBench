import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:trace_bench_viewer/shared/models/known_facts.dart';

void main() {
  test('components parsed and loaded', () {
    final raw = File(
      'assets/samples/pelle_pv20_minimal/known_facts.json',
    ).readAsStringSync();
    final knownFacts =
        KnownFacts.fromJson(jsonDecode(raw) as Map<String, dynamic>);

    expect(knownFacts.components.map((c) => c.componentId), contains('Q2'));
    expect(knownFacts.measurements.length, 2);
    expect(knownFacts.nets.length, 1);
  });

  test('M001 stale and M002 active', () {
    final raw = File(
      'assets/samples/pelle_pv20_minimal/known_facts.json',
    ).readAsStringSync();
    final knownFacts =
        KnownFacts.fromJson(jsonDecode(raw) as Map<String, dynamic>);

    final m001 =
        knownFacts.measurements.firstWhere((m) => m.measurementId == 'M001');
    final m002 =
        knownFacts.measurements.firstWhere((m) => m.measurementId == 'M002');
    expect(m001.validityStatus, 'stale_after_repair');
    expect(m002.validityStatus, 'active');
    expect(m001.humanValidityLabel, 'Aegunud pärast remonti');
    expect(m002.humanValidityLabel, 'Aktiivne');
  });

  test('excluded footprints includes K1/K2/K3', () {
    final raw = File(
      'assets/samples/pelle_pv20_minimal/known_facts.json',
    ).readAsStringSync();
    final knownFacts =
        KnownFacts.fromJson(jsonDecode(raw) as Map<String, dynamic>);

    final footprintIds = knownFacts.excludedFromFaultCandidates
        .map((f) => f.footprintId)
        .toList();
    expect(footprintIds, containsAll(['K1', 'K2', 'K3']));
  });

  test('Q2 pins present', () {
    final raw = File(
      'assets/samples/pelle_pv20_minimal/known_facts.json',
    ).readAsStringSync();
    final knownFacts =
        KnownFacts.fromJson(jsonDecode(raw) as Map<String, dynamic>);

    final pinIds = knownFacts.pins.map((pin) => pin.pinId).toList();
    expect(pinIds, containsAll(['Q2.1', 'Q2.2', 'Q2.3']));
  });

  test('component_pin_index parsed from sample', () {
    final raw = File(
      'assets/samples/pelle_pv20_minimal/known_facts.json',
    ).readAsStringSync();
    final knownFacts =
        KnownFacts.fromJson(jsonDecode(raw) as Map<String, dynamic>);

    expect(knownFacts.componentPinIndex['Q2'], contains('Q2.1'));
    expect(knownFacts.componentPinIndex['Q2'], contains('Q2.2'));
    expect(knownFacts.componentPinIndex['Q2'], contains('Q2.3'));
  });

  test('damage regions parsed from sample when present', () {
    final raw = File(
      'assets/samples/pelle_pv20_minimal/known_facts.json',
    ).readAsStringSync();
    final knownFacts =
        KnownFacts.fromJson(jsonDecode(raw) as Map<String, dynamic>);

    final damageRegionIds =
        knownFacts.damageRegions.map((region) => region.regionId).toList();
    expect(damageRegionIds, contains('DMG001'));
  });

  test('visual traces parse empty list safely', () {
    final raw = File(
      'assets/samples/pelle_pv20_minimal/known_facts.json',
    ).readAsStringSync();
    final knownFacts =
        KnownFacts.fromJson(jsonDecode(raw) as Map<String, dynamic>);

    expect(knownFacts.visualTraces, isEmpty);
  });

  test(
      'photos, damage regions, suspect regions, visual traces parse with optional fields',
      () {
    final knownFacts = KnownFacts.fromJson({
      'project_id': 'inline_photo_case',
      'photos': [
        {'photo_id': 'photo_inline_001', 'mode': 'macro', 'path': ''},
      ],
      'damage_regions': [
        {
          'region_id': 'DMG001',
          'photo_id': 'photo_inline_001',
          'bbox': {'x': 1, 'y': 2, 'width': 3, 'height': 4},
          'damage_type': 'burn',
          'severity': 'low',
        },
      ],
      'suspect_regions': [
        {
          'region_id': 'SMG001',
          'photo_id': 'photo_inline_001',
          'bbox': {'x': 5, 'y': 6, 'width': 7, 'height': 8},
          'reason': 'discoloration',
          'priority': 'low',
        },
      ],
      'visual_traces': [
        {'trace_id': 'VT001', 'photo_id': 'photo_inline_001'},
      ],
    });

    expect(knownFacts.photos.first.mode, 'macro');
    expect(knownFacts.photos.first.path, isEmpty);
    expect(knownFacts.damageRegions.single.regionId, 'DMG001');
    expect(knownFacts.suspectRegions.single.reason, 'discoloration');
    expect(knownFacts.visualTraces.single.evidenceType, 'visual_trace');

    final raw = knownFacts.toJson();
    final visualTraces = raw['visual_traces'];
    expect(visualTraces, isA<List>());
    expect((visualTraces as List).single, isA<Map<String, dynamic>>());
    expect((visualTraces.single as Map<String, dynamic>)['evidence_type'],
        'visual_trace');
  });

  test('component_visual_placements parse from known facts projection', () {
    final knownFacts = KnownFacts.fromJson({
      'project_id': 'placement_case',
      'component_visual_placements': [
        {
          'component_id': 'Q2',
          'coordinate_space': 'board_normalized',
          'board_side': 'top',
          'center_x': 0.5,
          'center_y': 0.4,
          'rotation_deg': 0,
          'scale': 1.0,
          'source_event_id': 'evt_000123',
          'status': 'user_confirmed_visual',
        },
      ],
    });

    expect(knownFacts.componentVisualPlacements, hasLength(1));
    final placement = knownFacts.componentVisualPlacements.single;
    expect(placement.componentId, 'Q2');
    expect(placement.coordinateSpace, 'board_normalized');
    expect(placement.boardSide, 'top');
    expect(placement.scale, 1.0);
    expect(placement.width, isNull);
    expect(placement.height, isNull);
    expect(placement.sourceEventId, 'evt_000123');
    expect(placement.status, 'user_confirmed_visual');
  });

  test('missing component_visual_placements defaults to empty list', () {
    final knownFacts = KnownFacts.fromJson({
      'project_id': 'placement_missing_case',
      'components': [],
      'pins': [],
      'measurements': [],
      'nets': [],
      'excluded_from_fault_candidates': [],
    });

    expect(knownFacts.componentVisualPlacements, isEmpty);
  });

  test('scale-mode placement round-trips through KnownFacts.toJson', () {
    final knownFacts = KnownFacts.fromJson({
      'project_id': 'placement_scale_roundtrip',
      'component_visual_placements': [
        {
          'component_id': 'R5',
          'coordinate_space': 'board_normalized',
          'board_side': 'top',
          'center_x': 0.25,
          'center_y': 0.75,
          'rotation_deg': -45,
          'scale': 0.8,
          'source_event_id': 'evt_000201',
          'status': 'user_confirmed_visual',
        },
      ],
    });

    final encoded = knownFacts.toJson();
    final placements =
        encoded['component_visual_placements'] as List<dynamic>? ?? const [];
    expect(placements, hasLength(1));
    final placement = placements.single as Map<String, dynamic>;
    expect(placement['scale'], 0.8);
    expect(placement.containsKey('width'), isFalse);
    expect(placement.containsKey('height'), isFalse);
  });

  test('width+height-mode placement round-trips through KnownFacts.toJson', () {
    final knownFacts = KnownFacts.fromJson({
      'project_id': 'placement_size_roundtrip',
      'component_visual_placements': [
        {
          'component_id': 'U7',
          'coordinate_space': 'photo_local',
          'board_side': 'bottom',
          'center_x': 104.0,
          'center_y': 208.0,
          'rotation_deg': 90,
          'width': 20.0,
          'height': 10.0,
          'source_photo_id': 'photo_top_001',
          'template_id': 'soic_8',
          'source_event_id': 'evt_000202',
          'status': 'user_confirmed_visual',
        },
      ],
    });

    final encoded = knownFacts.toJson();
    final placements =
        encoded['component_visual_placements'] as List<dynamic>? ?? const [];
    expect(placements, hasLength(1));
    final placement = placements.single as Map<String, dynamic>;
    expect(placement.containsKey('scale'), isFalse);
    expect(placement['width'], 20.0);
    expect(placement['height'], 10.0);
    expect(placement['template_id'], 'soic_8');
    expect(placement['source_photo_id'], 'photo_top_001');
    expect(placement['source_event_id'], 'evt_000202');
    expect(placement['status'], 'user_confirmed_visual');
  });

  test('component removal fields parse when present and default when missing',
      () {
    final withRemoval = KnownFacts.fromJson({
      'project_id': 'removal_fields_case',
      'components': [
        {
          'component_id': 'Q2',
          'installation_status': 'removed',
          'removed_by_event_id': 'evt_000333',
        }
      ],
    });
    expect(withRemoval.components.single.installationStatus, 'removed');
    expect(withRemoval.components.single.removedByEventId, 'evt_000333');

    final withoutRemoval = KnownFacts.fromJson({
      'project_id': 'removal_fields_missing_case',
      'components': [
        {'component_id': 'Q3'}
      ],
    });
    expect(withoutRemoval.components.single.installationStatus, isNull);
    expect(withoutRemoval.components.single.removedByEventId, isNull);
  });

  test('photo_to_board_alignments parse from known facts projection', () {
    final knownFacts = KnownFacts.fromJson({
      'project_id': 'alignment_parse_case',
      'photo_to_board_alignments': [
        {
          'alignment_id': 'ALN1001',
          'source_photo_id': 'photo_top_001',
          'board_side': 'top',
          'coordinate_space_from': 'photo_local',
          'coordinate_space_to': 'board_normalized',
          'reference_points_photo': [
            {'x': 10.5, 'y': 20.25},
            {'x': 30, 'y': 40},
          ],
          'reference_points_board': [
            {'x': 0.1, 'y': 0.2},
            {'x': 0.3, 'y': 0.4},
          ],
          'transform_type': 'similarity',
          'alignment_quality_label': 'good',
          'notes': 'manual board corner match',
          'source_event_id': 'evt_001000',
          'status': 'user_confirmed_alignment',
        },
      ],
    });

    expect(knownFacts.photoToBoardAlignments, hasLength(1));
    final alignment = knownFacts.photoToBoardAlignments.single;
    expect(alignment.alignmentId, 'ALN1001');
    expect(alignment.sourcePhotoId, 'photo_top_001');
    expect(alignment.boardSide, 'top');
    expect(alignment.coordinateSpaceFrom, 'photo_local');
    expect(alignment.coordinateSpaceTo, 'board_normalized');
    expect(alignment.transformType, 'similarity');
    expect(alignment.alignmentQualityLabel, 'good');
    expect(alignment.notes, 'manual board corner match');
    expect(alignment.sourceEventId, 'evt_001000');
    expect(alignment.status, 'user_confirmed_alignment');

    expect(
      alignment.referencePointsPhoto.map((point) => point.toJson()).toList(),
      equals([
        {'x': 10.5, 'y': 20.25},
        {'x': 30, 'y': 40},
      ]),
    );
    expect(
      alignment.referencePointsBoard.map((point) => point.toJson()).toList(),
      equals([
        {'x': 0.1, 'y': 0.2},
        {'x': 0.3, 'y': 0.4},
      ]),
    );
  });

  test('missing photo_to_board_alignments defaults to empty list', () {
    final knownFacts = KnownFacts.fromJson({
      'project_id': 'alignment_missing_case',
      'components': [],
      'pins': [],
      'measurements': [],
      'nets': [],
      'excluded_from_fault_candidates': [],
    });

    expect(knownFacts.photoToBoardAlignments, isEmpty);
  });

  test('photo_to_board_alignments round-trip preserves all fields', () {
    final knownFacts = KnownFacts.fromJson({
      'project_id': 'alignment_roundtrip_case',
      'photo_to_board_alignments': [
        {
          'alignment_id': 'ALN1002',
          'source_photo_id': 'photo_bottom_001',
          'board_side': 'bottom',
          'coordinate_space_from': 'photo_local',
          'coordinate_space_to': 'board_normalized',
          'reference_points_photo': [
            {'x': 12, 'y': 24},
            {'x': 60.5, 'y': 48.25},
            {'x': 90, 'y': 72},
          ],
          'reference_points_board': [
            {'x': 0.12, 'y': 0.24},
            {'x': 0.605, 'y': 0.4825},
            {'x': 0.9, 'y': 0.72},
          ],
          'transform_type': 'affine',
          'alignment_quality_label': 'acceptable',
          'source_event_id': 'evt_001001',
          'status': 'user_confirmed_alignment',
        },
      ],
    });

    final raw = knownFacts.toJson();
    final alignments =
        raw['photo_to_board_alignments'] as List<dynamic>? ?? const [];
    expect(alignments, hasLength(1));
    final alignment = alignments.single as Map<String, dynamic>;

    expect(alignment['alignment_id'], 'ALN1002');
    expect(alignment['source_photo_id'], 'photo_bottom_001');
    expect(alignment['board_side'], 'bottom');
    expect(alignment['coordinate_space_from'], 'photo_local');
    expect(alignment['coordinate_space_to'], 'board_normalized');
    expect(alignment['transform_type'], 'affine');
    expect(alignment['alignment_quality_label'], 'acceptable');
    expect(alignment['source_event_id'], 'evt_001001');
    expect(alignment['status'], 'user_confirmed_alignment');

    expect(alignment.containsKey('notes'), isFalse);
    expect(alignment.containsKey('transform_matrix'), isFalse);
    expect(alignment.containsKey('similarity_transform'), isFalse);
    expect(alignment.containsKey('affine_transform'), isFalse);
    expect(alignment.containsKey('homography'), isFalse);

    expect(
      alignment['reference_points_photo'],
      equals([
        {'x': 12, 'y': 24},
        {'x': 60.5, 'y': 48.25},
        {'x': 90, 'y': 72},
      ]),
    );
    expect(
      alignment['reference_points_board'],
      equals([
        {'x': 0.12, 'y': 0.24},
        {'x': 0.605, 'y': 0.4825},
        {'x': 0.9, 'y': 0.72},
      ]),
    );
  });

  test('photo_to_board_alignments notes are preserved when present', () {
    final knownFacts = KnownFacts.fromJson({
      'project_id': 'alignment_notes_present_case',
      'photo_to_board_alignments': [
        {
          'alignment_id': 'ALN1003',
          'source_photo_id': 'photo_top_002',
          'board_side': 'unknown',
          'coordinate_space_from': 'photo_local',
          'coordinate_space_to': 'board_normalized',
          'reference_points_photo': [
            {'x': 1, 'y': 2},
            {'x': 3, 'y': 4},
          ],
          'reference_points_board': [
            {'x': 0.01, 'y': 0.02},
            {'x': 0.03, 'y': 0.04},
          ],
          'transform_type': 'similarity',
          'alignment_quality_label': 'manual',
          'notes': 'operator confirmed corners',
          'source_event_id': 'evt_001002',
          'status': 'user_confirmed_alignment',
        },
      ],
    });

    final raw = knownFacts.toJson();
    final alignment =
        (raw['photo_to_board_alignments'] as List<dynamic>).single
            as Map<String, dynamic>;
    expect(alignment['notes'], 'operator confirmed corners');
  });

  test(
      'photo_to_board_alignments notes absent parses null and omits notes on toJson',
      () {
    final knownFacts = KnownFacts.fromJson({
      'project_id': 'alignment_notes_absent_case',
      'photo_to_board_alignments': [
        {
          'alignment_id': 'ALN1004',
          'source_photo_id': 'photo_top_003',
          'board_side': 'top',
          'coordinate_space_from': 'photo_local',
          'coordinate_space_to': 'board_normalized',
          'reference_points_photo': [
            {'x': 11, 'y': 22},
            {'x': 33, 'y': 44},
          ],
          'reference_points_board': [
            {'x': 0.11, 'y': 0.22},
            {'x': 0.33, 'y': 0.44},
          ],
          'transform_type': 'similarity',
          'alignment_quality_label': 'manual',
          'source_event_id': 'evt_001003',
          'status': 'user_confirmed_alignment',
        },
      ],
    });

    expect(knownFacts.photoToBoardAlignments, hasLength(1));
    expect(knownFacts.photoToBoardAlignments.single.notes, isNull);

    final raw = knownFacts.toJson();
    final alignment =
        (raw['photo_to_board_alignments'] as List<dynamic>).single
            as Map<String, dynamic>;
    expect(alignment.containsKey('notes'), isFalse);
  });

  test(
      'photo_to_board_alignments multi-item parse and round-trip preserves ordering and point lists',
      () {
    final knownFacts = KnownFacts.fromJson({
      'project_id': 'alignment_multi_item_case',
      'photo_to_board_alignments': [
        {
          'alignment_id': 'ALN2001',
          'source_photo_id': 'photo_top_010',
          'board_side': 'top',
          'coordinate_space_from': 'photo_local',
          'coordinate_space_to': 'board_normalized',
          'reference_points_photo': [
            {'x': 10, 'y': 15},
            {'x': 20, 'y': 25},
          ],
          'reference_points_board': [
            {'x': 0.1, 'y': 0.15},
            {'x': 0.2, 'y': 0.25},
          ],
          'transform_type': 'similarity',
          'alignment_quality_label': 'good',
          'source_event_id': 'evt_002001',
          'status': 'user_confirmed_alignment',
        },
        {
          'alignment_id': 'ALN2002',
          'source_photo_id': 'photo_bottom_010',
          'board_side': 'bottom',
          'coordinate_space_from': 'photo_local',
          'coordinate_space_to': 'board_normalized',
          'reference_points_photo': [
            {'x': 30, 'y': 35},
            {'x': 40, 'y': 45},
            {'x': 50, 'y': 55},
          ],
          'reference_points_board': [
            {'x': 0.3, 'y': 0.35},
            {'x': 0.4, 'y': 0.45},
            {'x': 0.5, 'y': 0.55},
          ],
          'transform_type': 'affine',
          'alignment_quality_label': 'acceptable',
          'source_event_id': 'evt_002002',
          'status': 'user_confirmed_alignment',
        },
      ],
    });

    expect(knownFacts.photoToBoardAlignments, hasLength(2));
    expect(knownFacts.photoToBoardAlignments[0].alignmentId, 'ALN2001');
    expect(knownFacts.photoToBoardAlignments[1].alignmentId, 'ALN2002');
    expect(
      knownFacts.photoToBoardAlignments[0]
          .referencePointsPhoto
          .map((p) => p.toJson())
          .toList(),
      equals([
        {'x': 10, 'y': 15},
        {'x': 20, 'y': 25},
      ]),
    );
    expect(
      knownFacts.photoToBoardAlignments[0]
          .referencePointsBoard
          .map((p) => p.toJson())
          .toList(),
      equals([
        {'x': 0.1, 'y': 0.15},
        {'x': 0.2, 'y': 0.25},
      ]),
    );
    expect(
      knownFacts.photoToBoardAlignments[1]
          .referencePointsPhoto
          .map((p) => p.toJson())
          .toList(),
      equals([
        {'x': 30, 'y': 35},
        {'x': 40, 'y': 45},
        {'x': 50, 'y': 55},
      ]),
    );
    expect(
      knownFacts.photoToBoardAlignments[1]
          .referencePointsBoard
          .map((p) => p.toJson())
          .toList(),
      equals([
        {'x': 0.3, 'y': 0.35},
        {'x': 0.4, 'y': 0.45},
        {'x': 0.5, 'y': 0.55},
      ]),
    );

    final raw = knownFacts.toJson();
    final alignments =
        raw['photo_to_board_alignments'] as List<dynamic>? ?? const [];
    expect(alignments, hasLength(2));
    expect(
      (alignments[0] as Map<String, dynamic>)['alignment_id'],
      'ALN2001',
    );
    expect(
      (alignments[1] as Map<String, dynamic>)['alignment_id'],
      'ALN2002',
    );
    expect(
      (alignments[0] as Map<String, dynamic>)['reference_points_photo'],
      equals([
        {'x': 10, 'y': 15},
        {'x': 20, 'y': 25},
      ]),
    );
    expect(
      (alignments[1] as Map<String, dynamic>)['reference_points_board'],
      equals([
        {'x': 0.3, 'y': 0.35},
        {'x': 0.4, 'y': 0.45},
        {'x': 0.5, 'y': 0.55},
      ]),
    );
  });
}
