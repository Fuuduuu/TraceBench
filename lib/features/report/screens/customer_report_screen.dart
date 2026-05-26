import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../../app/app.dart';
import '../../../shared/models/project_state.dart';
import '../../../shared/services/project_exporter.dart';
import '../../../shared/services/project_loader.dart';
import '../../../shared/widgets/projection_stale_banner.dart';

final Provider<ProjectExporter> projectExporterProvider =
    Provider<ProjectExporter>((_) => ProjectExporter());

typedef ProjectStateLoader = Future<ProjectState> Function(String directory);

final Provider<ProjectStateLoader> projectStateLoaderProvider =
    Provider<ProjectStateLoader>((_) => ProjectLoader.loadFromDirectory);

class CustomerReportScreen extends ConsumerWidget {
  const CustomerReportScreen({
    super.key,
    this.projectExporter,
    this.projectStateLoader,
  });

  final ProjectExporter? projectExporter;
  final ProjectStateLoader? projectStateLoader;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectState = ref.watch(projectStateProvider);
    final ProjectExporter exporter =
        projectExporter ?? ref.watch(projectExporterProvider);
    final ProjectStateLoader loader =
        projectStateLoader ?? ref.watch(projectStateLoaderProvider);

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
                  final message = await _handleExportResult(
                    ref: ref,
                    currentState: projectState,
                    result: result,
                    loader: loader,
                  );
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

Future<String> _handleExportResult({
  required WidgetRef ref,
  required ProjectState currentState,
  required ExportResult result,
  required ProjectStateLoader loader,
}) async {
  if (result case ExportSuccess(:final zipPath)) {
    final projectDirectory = currentState.projectDirectory;
    if (projectDirectory == null || projectDirectory.trim().isEmpty) {
      return _reloadFailedMessage(zipPath);
    }

    try {
      final reloadedState = await loader(projectDirectory);
      ref.read(projectStateProvider.notifier).state = reloadedState;
      return 'ZIP eksporditud: $zipPath.';
    } catch (_) {
      return _reloadFailedMessage(zipPath);
    }
  }

  return _messageForExportResult(result);
}

String _messageForExportResult(ExportResult result) {
  return switch (result) {
    ExportSuccess(:final zipPath) => 'ZIP eksporditud: $zipPath.',
    ExportMobilePlaceholder() => 'Mobiilne eksport jääb V1-s placeholderiks.',
    ExportNoDirectory() => 'Projekt ei ole laaditud kohalikust kaustast.',
    ExportPythonNotFound() =>
      'Pythonit ei leitud. Desktop/dev eksport vajab Python toolingut.',
    ExportMaterializerFailed(:final sanitizedMessage) => sanitizedMessage,
    ExportExportFailed(:final sanitizedMessage) => sanitizedMessage,
    _ => 'Eksport ebaõnnestus.',
  };
}

String _reloadFailedMessage(String zipPath) {
  return 'ZIP eksporditud: $zipPath. '
      'Projekti uuesti laadimine ebaõnnestus; ava või impordi projekt uuesti, '
      'et näha uuendatud projektsiooni.';
}
