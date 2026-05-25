import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'package:trace_bench_viewer/app/app.dart';
import 'package:trace_bench_viewer/features/report/screens/customer_report_screen.dart';
import 'package:trace_bench_viewer/shared/models/known_facts.dart';
import 'package:trace_bench_viewer/shared/models/project_manifest.dart';
import 'package:trace_bench_viewer/shared/models/project_state.dart';
import 'package:trace_bench_viewer/shared/services/project_exporter.dart';
import 'package:trace_bench_viewer/shared/widgets/projection_stale_banner.dart';

class _StaticProjectExporter extends ProjectExporter {
  _StaticProjectExporter(this.result);

  final ExportResult result;

  @override
  Future<ExportResult> exportProjectZip(ProjectState projectState) async {
    return result;
  }
}

ProjectState _inlineProjectState({
  bool isProjectionStale = false,
  String customerReport = 'Inline sample report',
}) {
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
    customerReport: customerReport,
    projectDirectory: 'C:/tmp/inline_project',
  ).copyWith(isProjectionStale: isProjectionStale);
}

void main() {
  testWidgets('shows stale projection banner when stale', (tester) async {
    final projectState = _inlineProjectState(isProjectionStale: true);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [projectStateProvider.overrideWith((_) => projectState)],
        child: const MaterialApp(home: CustomerReportScreen()),
      ),
    );
    await tester.pump();

    expect(find.text(ProjectionStaleBanner.primaryText), findsOneWidget);
    expect(find.text(ProjectionStaleBanner.passiveTagText), findsOneWidget);
    expect(find.text(ProjectionStaleBanner.secondaryText), findsOneWidget);
    expect(find.text('Export ZIP'), findsOneWidget);
    expect(find.text('Refresh'), findsNothing);
    expect(find.text('Värskenda'), findsNothing);
    expect(find.text('Export now'), findsNothing);
    expect(find.text('Ekspordi kohe'), findsNothing);
    expect(find.text('Run materializer'), findsNothing);
    expect(find.text('Käivita materializer'), findsNothing);
  });

  testWidgets('hides stale projection banner when fresh', (tester) async {
    final projectState = _inlineProjectState(isProjectionStale: false);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [projectStateProvider.overrideWith((_) => projectState)],
        child: const MaterialApp(home: CustomerReportScreen()),
      ),
    );
    await tester.pump();

    expect(find.text(ProjectionStaleBanner.primaryText), findsNothing);
  });

  testWidgets('export button renders on customer report screen',
      (tester) async {
    final projectState = _inlineProjectState();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [projectStateProvider.overrideWith((_) => projectState)],
        child: MaterialApp(
          home: CustomerReportScreen(
            projectExporter:
                _StaticProjectExporter(ExportSuccess('C:/tmp/export.zip')),
          ),
        ),
      ),
    );
    await tester.pump();

    expect(find.widgetWithText(ElevatedButton, 'Export ZIP'), findsOneWidget);
  });

  testWidgets('mobile export shows placeholder message', (tester) async {
    final projectState = _inlineProjectState(isProjectionStale: false);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [projectStateProvider.overrideWith((_) => projectState)],
        child: MaterialApp(
          home: CustomerReportScreen(
            projectExporter:
                _StaticProjectExporter(const ExportMobilePlaceholder()),
          ),
        ),
      ),
    );
    await tester.pump();

    await tester.tap(find.text('Export ZIP'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 120));

    expect(find.text('Mobiilne eksport jääb V1-s placeholderiks.'),
        findsOneWidget);
  });

  testWidgets('materializer failure shows sanitized message only',
      (tester) async {
    final projectState = _inlineProjectState(isProjectionStale: true);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [projectStateProvider.overrideWith((_) => projectState)],
        child: MaterialApp(
          home: CustomerReportScreen(
            projectExporter: _StaticProjectExporter(
              ExportMaterializerFailed(
                sanitizedMessage:
                    'Materialiseerimine ebaõnnestus. Kontrolli projekti sündmuste faili.',
                rawDetail:
                    '/Users/test/tracebench/Tools\\materialize_known_facts.py failed with Traceback...',
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pump();

    await tester.tap(find.text('Export ZIP'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));

    expect(
      find.text(
          'Materialiseerimine ebaõnnestus. Kontrolli projekti sündmuste faili.'),
      findsOneWidget,
    );
    expect(
      find.text('C:/Users/test/tracebench/projects/materialize_known_facts.py'),
      findsNothing,
    );
    expect(find.text('Traceback'), findsNothing);
    expect(find.text(ProjectionStaleBanner.primaryText), findsOneWidget);
  });

  testWidgets('export failure shows sanitized message only', (tester) async {
    final projectState = _inlineProjectState(isProjectionStale: true);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [projectStateProvider.overrideWith((_) => projectState)],
        child: MaterialApp(
          home: CustomerReportScreen(
            projectExporter: _StaticProjectExporter(
              ExportExportFailed(
                sanitizedMessage: 'ZIP pakkimine ebaõnnestus.',
                rawDetail:
                    'C:\\\\Users\\\\test\\\\tracebench\\\\export_project_zip.py',
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pump();

    await tester.tap(find.text('Export ZIP'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 120));

    expect(find.text('ZIP pakkimine ebaõnnestus.'), findsOneWidget);
    expect(
        find.text('C:\\\\Users\\\\test\\\\tracebench\\\\export_project_zip.py'),
        findsNothing);
    expect(find.text('Traceback'), findsNothing);
    expect(find.text('Export failed'), findsNothing);
    expect(find.text(ProjectionStaleBanner.primaryText), findsOneWidget);
  });

  testWidgets('desktop export success keeps stale banner visible',
      (tester) async {
    final projectState = _inlineProjectState(isProjectionStale: true);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [projectStateProvider.overrideWith((_) => projectState)],
        child: MaterialApp(
          home: CustomerReportScreen(
            projectExporter: _StaticProjectExporter(
              const ExportSuccess('C:/tmp/inline_export.zip'),
            ),
          ),
        ),
      ),
    );
    await tester.pump();

    await tester.tap(find.text('Export ZIP'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));

    expect(
      find.text(
          'ZIP eksporditud: C:/tmp/inline_export.zip. Uuendatud projektsiooni nägemiseks impordi projekt uuesti.'),
      findsOneWidget,
    );
    expect(find.text(ProjectionStaleBanner.primaryText), findsOneWidget);
    expect(find.text(ProjectionStaleBanner.passiveTagText), findsOneWidget);
  });

  testWidgets(
    'stale banner primary text is not injected into customer report content',
    (tester) async {
      final expectedReport = 'Inline sample report (assert content)';
      final projectState = _inlineProjectState(
        isProjectionStale: true,
        customerReport: expectedReport,
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [projectStateProvider.overrideWith((_) => projectState)],
          child: MaterialApp(
            home: CustomerReportScreen(
              projectExporter: _StaticProjectExporter(
                ExportSuccess('C:/tmp/inline_export.zip'),
              ),
            ),
          ),
        ),
      );
      await tester.pump();

      final markdown = tester.widget<Markdown>(find.byType(Markdown));
      expect(markdown.data, equals(expectedReport));
    },
  );

  testWidgets('projection stale banner still has no export action',
      (tester) async {
    final projectState = _inlineProjectState(isProjectionStale: true);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [projectStateProvider.overrideWith((_) => projectState)],
        child: MaterialApp(
          home: CustomerReportScreen(
            projectExporter: _StaticProjectExporter(
              const ExportSuccess('C:/tmp/inline_export.zip'),
            ),
          ),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('Refresh'), findsNothing);
    expect(find.text('Värskenda'), findsNothing);
    expect(find.text('Uuenda nüüd'), findsNothing);
    expect(find.text('Export now'), findsNothing);
    expect(find.text('Ekspordi kohe'), findsNothing);
    expect(find.text('Run materializer'), findsNothing);
    expect(find.text('Käivita materializer'), findsNothing);
  });
}
