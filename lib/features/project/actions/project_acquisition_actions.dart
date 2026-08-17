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
