import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:trace_bench_viewer/app/app.dart';
import 'package:trace_bench_viewer/features/board_graph/screens/board_graph_screen.dart';
import 'package:trace_bench_viewer/shared/models/known_facts.dart';
import 'package:trace_bench_viewer/shared/models/project_manifest.dart';
import 'package:trace_bench_viewer/shared/models/project_state.dart';
import 'package:trace_bench_viewer/shared/widgets/projection_stale_banner.dart';

ProjectState _inlineProjectState() {
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
        'Q2': ['Q2.1'],
      },
    }),
    events: const [],
    customerReport: 'Inline sample report',
  );
}

void main() {
  testWidgets('board graph screen renders title and key labels',
      (tester) async {
    final projectState =
        _inlineProjectState().copyWith(isProjectionStale: true);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          projectStateProvider.overrideWith((_) => projectState),
          beginnerModeProvider.overrideWith((_) => true),
        ],
        child: const MaterialApp(home: BoardGraphScreen()),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('Board graph'), findsOneWidget);
    expect(find.textContaining('Q2'), findsAtLeast(1));
    expect(find.textContaining('components:'), findsOneWidget);
    expect(find.text('Show visual traces'), findsNothing);
    expect(find.text(ProjectionStaleBanner.primaryText), findsOneWidget);
    expect(find.text(ProjectionStaleBanner.passiveTagText), findsOneWidget);
  });

  testWidgets('board graph advanced mode exposes history controls',
      (tester) async {
    final projectState = _inlineProjectState();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          projectStateProvider.overrideWith((_) => projectState),
          beginnerModeProvider.overrideWith((_) => false),
        ],
        child: const MaterialApp(home: BoardGraphScreen()),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.textContaining('Show visual traces'), findsOneWidget);
    expect(find.text('Audit/history'), findsOneWidget);
    expect(find.byType(DropdownButton<String>), findsOneWidget);
    expect(find.text('Advanced mode: true'), findsOneWidget);
    expect(find.text(ProjectionStaleBanner.primaryText), findsNothing);
  });
}
