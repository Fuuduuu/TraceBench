import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:go_router/go_router.dart';

import '../../../app/app.dart';
import '../../../shared/models/project_state.dart';
import '../../../shared/services/project_loader.dart';

class ProjectZipImportAction {
  const ProjectZipImportAction._();

  static Future<void> importZip({
    required BuildContext context,
    required WidgetRef ref,
    VoidCallback? onImported,
  }) async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: const ['zip'],
      withData: true,
    );
    if (result == null || result.files.isEmpty) return;

    final picked = result.files.single;
    try {
      if (picked.bytes != null) {
        final loaded = await ProjectLoader.loadFromZipBytes(picked.bytes!);
        ref.read(projectStateProvider.notifier).state = loaded;
        if (context.mounted) {
          if (onImported != null) {
            onImported();
          } else {
            context.go('/project');
          }
        }
        return;
      }

      if (picked.path == null || picked.path!.isEmpty) {
        throw const ProjectLoadException('No file path for selected ZIP');
      }

      final bytes = await File(picked.path!).readAsBytes();
      final loaded = await ProjectLoader.loadFromZipBytes(bytes);
      ref.read(projectStateProvider.notifier).state = loaded;
      if (context.mounted) {
        if (onImported != null) {
          onImported();
        } else {
          context.go('/project');
        }
      }
    } on ProjectLoadException catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.toString())),
        );
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('ZIP import failed: $error')),
        );
      }
    }
  }
}

class ProjectDirectoryOpenAction {
  const ProjectDirectoryOpenAction._();

  static Future<void> openDirectory({
    required BuildContext context,
    required WidgetRef ref,
    Future<String?> Function()? directoryPicker,
    Future<ProjectState> Function(String projectDirectory)? projectLoader,
    VoidCallback? onOpened,
  }) async {
    final selectedDirectory = await (directoryPicker ??
        () => FilePicker.platform.getDirectoryPath(
              dialogTitle: 'Ava TraceBenchi projektikaust',
            ))();
    if (selectedDirectory == null || selectedDirectory.trim().isEmpty) {
      return;
    }

    try {
      final loadProject = projectLoader ?? ProjectLoader.loadFromDirectory;
      final loaded = await loadProject(selectedDirectory);
      ref.read(projectStateProvider.notifier).state = loaded;
      if (context.mounted) {
        if (onOpened != null) {
          onOpened();
        } else {
          context.go('/project');
        }
      }
    } on ProjectLoadException {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Valitud kaust ei ole kehtiv TraceBenchi projekt.'),
          ),
        );
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Projekti kaustast avamine ebaõnnestus: $error'),
          ),
        );
      }
    }
  }
}

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  Future<void> _loadBundledProject(WidgetRef ref) async {
    final loaded = await ProjectLoader.loadFromAssets();
    ref.read(projectStateProvider.notifier).state = loaded;
  }

  Future<void> _importZip(BuildContext context, WidgetRef ref) async {
    await ProjectZipImportAction.importZip(context: context, ref: ref);
  }

  Future<void> _openProjectFolder(BuildContext context, WidgetRef ref) async {
    await ProjectDirectoryOpenAction.openDirectory(context: context, ref: ref);
  }

  void _openNewProjectWizard(BuildContext context) {
    if (Platform.isAndroid || Platform.isIOS) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Uue projekti loomine tuleb järgmises versioonis.'),
        ),
      );
      return;
    }
    context.go('/new-project');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectState = ref.watch(projectStateProvider);
    final hasProject = projectState != null;

    return Scaffold(
      appBar: AppBar(title: const Text('TraceBench Viewer')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Read-only Project ZIP Viewer',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Ava näidisprojekti või impordi Project ZIP (write-only view).',
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _loadBundledProject(ref),
              child: const Text('Ava näidisprojekt'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => _importZip(context, ref),
              child: const Text('Import Project ZIP'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => _openProjectFolder(context, ref),
              child: const Text('Ava projekt kaustast'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => _openNewProjectWizard(context),
              child: const Text('Uus projekt'),
            ),
            const SizedBox(height: 24),
            if (hasProject) ...[
              const Text('Seisund: näidisprojekti andmed laetud'),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => context.go('/project'),
                child: const Text('Ava projekt'),
              ),
            ],
            if (!hasProject)
              const Text('No current project loaded.')
            else
              Card(
                margin: const EdgeInsets.only(top: 12),
                child: ListTile(
                  title: Text(projectState.manifest.model),
                  subtitle: Text(projectState.manifest.deviceType),
                  trailing:
                      projectState.manifest.projectId == 'prj_pelle_pv20_001'
                          ? const Chip(label: Text('Bundled sample'))
                          : null,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
