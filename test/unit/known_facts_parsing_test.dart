import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:trace_bench_viewer/shared/models/known_facts.dart';

void main() {
  test('components parsed and loaded', () {
    final raw = File(
      'assets/samples/pelle_pv20_minimal/known_facts.json',
    ).readAsStringSync();
    final knownFacts = KnownFacts.fromJson(jsonDecode(raw) as Map<String, dynamic>);

    expect(knownFacts.components.map((c) => c.componentId), contains('Q2'));
    expect(knownFacts.measurements.length, 2);
    expect(knownFacts.nets.length, 1);
  });

  test('M001 stale and M002 active', () {
    final raw = File(
      'assets/samples/pelle_pv20_minimal/known_facts.json',
    ).readAsStringSync();
    final knownFacts = KnownFacts.fromJson(jsonDecode(raw) as Map<String, dynamic>);

    final m001 = knownFacts.measurements.firstWhere((m) => m.measurementId == 'M001');
    final m002 = knownFacts.measurements.firstWhere((m) => m.measurementId == 'M002');
    expect(m001.validityStatus, 'stale_after_repair');
    expect(m002.validityStatus, 'active');
    expect(m001.humanValidityLabel, 'Aegunud pärast remonti');
    expect(m002.humanValidityLabel, 'Aktiivne');
  });

  test('excluded footprints includes K1/K2/K3', () {
    final raw = File(
      'assets/samples/pelle_pv20_minimal/known_facts.json',
    ).readAsStringSync();
    final knownFacts = KnownFacts.fromJson(jsonDecode(raw) as Map<String, dynamic>);

    final footprintIds =
        knownFacts.excludedFromFaultCandidates.map((f) => f.footprintId).toList();
    expect(footprintIds, containsAll(['K1', 'K2', 'K3']));
  });

  test('Q2 pins present', () {
    final raw = File(
      'assets/samples/pelle_pv20_minimal/known_facts.json',
    ).readAsStringSync();
    final knownFacts = KnownFacts.fromJson(jsonDecode(raw) as Map<String, dynamic>);

    final pinIds = knownFacts.pins.map((pin) => pin.pinId).toList();
    expect(pinIds, containsAll(['Q2.1', 'Q2.2', 'Q2.3']));
  });

  test('component_pin_index parsed from sample', () {
    final raw = File(
      'assets/samples/pelle_pv20_minimal/known_facts.json',
    ).readAsStringSync();
    final knownFacts = KnownFacts.fromJson(jsonDecode(raw) as Map<String, dynamic>);

    expect(knownFacts.componentPinIndex['Q2'], contains('Q2.1'));
    expect(knownFacts.componentPinIndex['Q2'], contains('Q2.2'));
    expect(knownFacts.componentPinIndex['Q2'], contains('Q2.3'));
  });

  test('damage regions parsed from sample when present', () {
    final raw = File(
      'assets/samples/pelle_pv20_minimal/known_facts.json',
    ).readAsStringSync();
    final knownFacts = KnownFacts.fromJson(jsonDecode(raw) as Map<String, dynamic>);

    final damageRegionIds =
        knownFacts.damageRegions.map((region) => region.regionId).toList();
    expect(damageRegionIds, contains('DMG001'));
  });

  test('visual traces parse empty list safely', () {
    final raw = File(
      'assets/samples/pelle_pv20_minimal/known_facts.json',
    ).readAsStringSync();
    final knownFacts = KnownFacts.fromJson(jsonDecode(raw) as Map<String, dynamic>);

    expect(knownFacts.visualTraces, isEmpty);
  });
}
