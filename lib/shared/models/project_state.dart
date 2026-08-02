import 'dart:convert';

import 'project_manifest.dart';
import 'known_facts.dart';
import 'trace_bench_event.dart';
import 'wizard_intake.dart';

class ProjectState {
  const ProjectState({
    required this.manifest,
    required this.knownFacts,
    required this.events,
    required this.customerReport,
    this.schemaVersions,
    this.projectDirectory,
    this.isProjectionStale = false,
    this.wizardIntake,
    this.wizardIntakeWarning,
  });

  final ProjectManifest manifest;
  final KnownFacts knownFacts;
  final List<TraceBenchEvent> events;
  final String customerReport;
  final Map<String, dynamic>? schemaVersions;
  final String? projectDirectory;
  final bool isProjectionStale;

  /// Optional noncanonical presentation input for visual planning.
  final WizardIntake? wizardIntake;

  /// Optional noncanonical presentation-state warning for intake reads.
  final String? wizardIntakeWarning;

  ProjectState copyWith({
    ProjectManifest? manifest,
    KnownFacts? knownFacts,
    List<TraceBenchEvent>? events,
    String? customerReport,
    Map<String, dynamic>? schemaVersions,
    String? projectDirectory,
    bool? isProjectionStale,
    WizardIntake? wizardIntake,
    String? wizardIntakeWarning,
  }) {
    return ProjectState(
      manifest: manifest ?? this.manifest,
      knownFacts: knownFacts ?? this.knownFacts,
      events: events ?? this.events,
      customerReport: customerReport ?? this.customerReport,
      schemaVersions: schemaVersions ?? this.schemaVersions,
      projectDirectory: projectDirectory ?? this.projectDirectory,
      isProjectionStale: isProjectionStale ?? this.isProjectionStale,
      wizardIntake: wizardIntake ?? this.wizardIntake,
      wizardIntakeWarning: wizardIntakeWarning ?? this.wizardIntakeWarning,
    );
  }

  int get componentCount => knownFacts.components.length;
  int get measurementCount => knownFacts.measurements.length;
  int get staleMeasurementCount => knownFacts.measurements
      .where((m) => m.validityStatus == 'stale_after_repair')
      .length;
  int get activeMeasurementCount =>
      knownFacts.measurements.where((m) => m.validityStatus == 'active').length;
  int get notPopulatedCount => knownFacts.excludedFromFaultCandidates.length;

  String get summary =>
      'components=$componentCount, measurements=$measurementCount';

  String get debugJson => const JsonEncoder.withIndent('  ').convert({
        'manifest': manifest.toJson(),
        'known_facts': knownFacts.toJson(),
        'events': events.map((e) => e.toJson()).toList(),
      });
}
