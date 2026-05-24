import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../../app/app.dart';
import '../../../shared/services/project_exporter.dart';
import '../../../shared/widgets/projection_stale_banner.dart';

final Provider<ProjectExporter> projectExporterProvider =
    Provider<ProjectExporter>((_) => ProjectExporter());

class CustomerReportScreen extends ConsumerWidget {
  const CustomerReportScreen({super.key, this.projectExporter});

  final ProjectExporter? projectExporter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectState = ref.watch(projectStateProvider);
    final ProjectExporter exporter =
        projectExporter ?? ref.watch(projectExporterProvider);

    if (projectState == null) {
      return const Scaffold(body: Center(child: Text('No project loaded')));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Kliendiraport')),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ProjectionStaleBanner(
                      isStale: projectState.isProjectionStale),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Markdown(
                      data: projectState.customerReport,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final result = await exporter.exportProjectZip(projectState);
                  final message = _messageForExportResult(result);
                  if (!context.mounted) {
                    return;
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(message)),
                  );
                },
                child: const Text('Export ZIP'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String _messageForExportResult(ExportResult result) {
  return switch (result) {
    ExportSuccess(:final zipPath) =>
      'ZIP eksporditud: $zipPath. Uuendatud projektsiooni nägemiseks impordi projekt uuesti.',
    ExportMobilePlaceholder() => 'Mobiilne eksport jääb V1-s placeholderiks.',
    ExportNoDirectory() => 'Projekt ei ole laaditud kohalikust kaustast.',
    ExportPythonNotFound() =>
      'Pythonit ei leitud. Desktop/dev eksport vajab Python toolingut.',
    ExportMaterializerFailed(:final message) =>
      'Materjaliseerimine ebaõnnestus: ${_truncateFailureMessage(message)}',
    ExportExportFailed(:final message) =>
      'Eksport ebaõnnestus: ${_truncateFailureMessage(message)}',
    _ => 'Eksport ebaõnnestus.',
  };
}

String _truncateFailureMessage(String message) {
  const maxLength = 220;
  if (message.length <= maxLength) {
    return message;
  }
  return '${message.substring(0, maxLength)}…';
}
