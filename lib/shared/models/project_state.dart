import 'dart:convert';

import 'project_manifest.dart';
import 'known_facts.dart';
import 'trace_bench_event.dart';

class ProjectState {
  const ProjectState({
    required this.manifest,
    required this.knownFacts,
    required this.events,
    required this.customerReport,
    this.schemaVersions,
  });

  final ProjectManifest manifest;
  final KnownFacts knownFacts;
  final List<TraceBenchEvent> events;
  final String customerReport;
  final Map<String, dynamic>? schemaVersions;

  int get componentCount => knownFacts.components.length;
  int get measurementCount => knownFacts.measurements.length;
  int get staleMeasurementCount =>
      knownFacts.measurements.where((m) => m.validityStatus == 'stale_after_repair').length;
  int get activeMeasurementCount =>
      knownFacts.measurements.where((m) => m.validityStatus == 'active').length;
  int get notPopulatedCount => knownFacts.excludedFromFaultCandidates.length;

  String get summary => 'components=${componentCount}, measurements=${measurementCount}';

  String get debugJson => const JsonEncoder.withIndent('  ').convert({
        'manifest': manifest.toJson(),
        'known_facts': knownFacts.toJson(),
        'events': events.map((e) => e.toJson()).toList(),
      });
}
