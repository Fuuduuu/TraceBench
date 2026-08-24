import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:trace_bench_viewer/shared/session/beginner_mode_provider.dart';
import 'package:trace_bench_viewer/shared/session/project_session.dart';

import '../helpers/seeded_project_session.dart';
import 'package:trace_bench_viewer/features/known_facts/screens/measurement_list_screen.dart';
import 'package:trace_bench_viewer/shared/widgets/projection_stale_banner.dart';
import 'package:trace_bench_viewer/shared/models/known_facts.dart';
import 'package:trace_bench_viewer/shared/models/project_manifest.dart';
import 'package:trace_bench_viewer/shared/models/project_state.dart';

ProjectState _inlineProjectState(
    {ProjectionFreshness projectionFreshness = ProjectionFreshness.fresh,
    bool isProjectionStale = false,
    bool includeBothValidity = false}) {
  final measurements = <Map<String, dynamic>>[
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
  ];
  if (includeBothValidity) {
    measurements.add({
      'measurement_id': 'M002',
      'mode': 'resistance',
      'from': 'R17.1',
      'to': 'R17.2',
      'reading': {'kind': 'numeric', 'value': 10, 'unit': 'ohm'},
      'power_state': 'off',
      'origin_event_id': 'evt_000002',
      'validity_status': 'stale_after_repair',
    });
  }

  return ProjectState(
    manifest: ProjectManifest.fromJson({
      'project_id': 'inline_project',
      'schema_version': '1.0',
      'created_at': '2026-05-22T00:00:00Z',
      'device_type': 'pelle',
      'model': 'PV20',
      'symptom': 'not_provided',
    }),
    knownFacts: KnownFacts.fromJson({
      'project_id': 'inline_project',
      'components': [
        {'component_id': 'Q2', 'status': 'identified', 'designator': 'Q2'},
      ],
      'pins': [
        {'component_id': 'Q2', 'pin_id': 'Q2.1'},
      ],
      'measurements': measurements,
      'component_pin_index': {
        'Q2': ['Q2.1'],
      },
    }),
    events: const [],
    customerReport: 'Inline sample report',
    projectionFreshness: projectionFreshness,
  ).copyWith(isProjectionStale: isProjectionStale);
}

void main() {
  testWidgets('shows stale projection banner when stale', (tester) async {
    final projectState = _inlineProjectState(isProjectionStale: true);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          projectStateProvider.overrideWith(
            () => SeededProjectSession(projectState),
          ),
          beginnerModeProvider.overrideWith((_) => true),
        ],
        child: const MaterialApp(home: MeasurementListScreen()),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text(ProjectionStaleBanner.stalePrimaryText), findsOneWidget);
    expect(find.text(ProjectionStaleBanner.staleSecondaryText), findsOneWidget);
    expect(find.text(ProjectionStaleBanner.staleTagText), findsOneWidget);
    expect(find.text('Refresh'), findsNothing);
    expect(find.text('Värskenda'), findsNothing);
    expect(find.text('Export now'), findsNothing);
    expect(find.text('Ekspordi kohe'), findsNothing);
    expect(find.text('Run materializer'), findsNothing);
    expect(find.text('Käivita materializer'), findsNothing);
    expect(find.text('Uuenda nüüd'), findsNothing);
  });

  testWidgets('shows distinct unknown freshness warning without blocking list',
      (tester) async {
    final projectState = _inlineProjectState(
      projectionFreshness: ProjectionFreshness.unknown,
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          projectStateProvider.overrideWith(
            () => SeededProjectSession(projectState),
          ),
          beginnerModeProvider.overrideWith((_) => true),
        ],
        child: const MaterialApp(home: MeasurementListScreen()),
      ),
    );
    await tester.pump();

    expect(find.text(ProjectionStaleBanner.unknownPrimaryText), findsOneWidget);
    expect(find.textContaining('M001:'), findsOneWidget);
  });

  testWidgets('stale and active human labels are shown', (tester) async {
    final projectState = _inlineProjectState(
      isProjectionStale: false,
      includeBothValidity: true,
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          projectStateProvider.overrideWith(
            () => SeededProjectSession(projectState),
          ),
          beginnerModeProvider.overrideWith((_) => true),
        ],
        child: const MaterialApp(home: MeasurementListScreen()),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.textContaining('Aegunud pärast remonti'), findsOneWidget);
    expect(find.textContaining('Aktiivne'), findsOneWidget);
    expect(find.textContaining('evt_'), findsNothing);
    expect(find.text(ProjectionStaleBanner.stalePrimaryText), findsNothing);
    expect(find.text(ProjectionStaleBanner.unknownPrimaryText), findsNothing);
  });
}
