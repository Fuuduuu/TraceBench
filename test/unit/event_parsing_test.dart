import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:trace_bench_viewer/shared/models/trace_bench_event.dart';
import 'package:trace_bench_viewer/shared/services/project_loader.dart';

void main() {
  test('events line count is 15', () {
    final eventsRaw = File(
      'assets/samples/pelle_pv20_minimal/events.jsonl',
    ).readAsStringSync();
    final events = ProjectLoader.parseEvents(eventsRaw);

    expect(events.length, 15);
    expect(events.first.eventType, 'project_created');
    expect(events[13].eventType, 'photo_added');
    expect(events[14].eventType, 'damage_region_marked');
    expect(events.where((e) => e.actor['type'] == 'ai'), isEmpty);
  });

  test('first event actor is user', () {
    final eventsRaw = File(
      'assets/samples/pelle_pv20_minimal/events.jsonl',
    ).readAsStringSync();
    final first = ProjectLoader.parseEvents(eventsRaw).first;

    expect(first.actor['type'], 'user');
    expect(first.payload.containsKey('reading'), false);
  });

  test('repair event has invalidation_policy', () {
    final eventsRaw = File(
      'assets/samples/pelle_pv20_minimal/events.jsonl',
    ).readAsStringSync();
    final repair = ProjectLoader.parseEvents(eventsRaw).firstWhere(
      (event) => event.eventType == 'repair_action_recorded',
    );
    expect(repair.payload.containsKey('invalidation_policy'), true);
  });

  test('event JSON object parse rejects non-object lines', () {
    expect(
      () => ProjectLoader.parseEvents('{"a":1}\n[]'),
      throwsA(isA<ProjectLoadException>()),
    );
  });
}
