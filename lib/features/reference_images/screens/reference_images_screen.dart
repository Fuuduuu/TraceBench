import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/app.dart';
import '../services/reference_image_sidecar_service.dart';

class ReferenceImagesScreen extends ConsumerStatefulWidget {
  const ReferenceImagesScreen({
    super.key,
    this.service,
    this.pickReferenceImageFile,
  });

  final ReferenceImageSidecarService? service;
  final Future<String?> Function()? pickReferenceImageFile;

  @override
  ConsumerState<ReferenceImagesScreen> createState() => _ReferenceImagesScreenState();
}

class _ReferenceImagesScreenState extends ConsumerState<ReferenceImagesScreen> {
  late final ReferenceImageSidecarService _service;
  late final Future<String?> Function() _pickReferenceImageFile;

  bool _isLoading = true;
  bool _isImporting = false;
  String? _errorMessage;
  ReferenceImageLedger _ledger = const ReferenceImageLedger(
    projectId: '',
    images: [],
  );
  String? _selectedReferenceImageId;

  @override
  void initState() {
    super.initState();
    _service = widget.service ?? const ReferenceImageSidecarService();
    _pickReferenceImageFile = widget.pickReferenceImageFile ?? _defaultPickFile;
    _loadLedger();
  }

  Future<String?> _defaultPickFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: const ['png', 'jpg', 'jpeg', 'webp'],
      withData: false,
    );
    if (result == null || result.files.isEmpty) {
      return null;
    }
    return result.files.single.path;
  }

  Future<void> _loadLedger() async {
    final projectState = ref.read(projectStateProvider);
    if (projectState == null || projectState.projectDirectory == null) {
      setState(() {
        _isLoading = false;
        _ledger = ReferenceImageLedger(
          projectId: projectState?.manifest.projectId ?? '',
          images: const [],
        );
      });
      return;
    }

    final loaded = await _service.loadLedger(
      projectDirectory: projectState.projectDirectory!,
      projectId: projectState.manifest.projectId,
    );
    if (!mounted) {
      return;
    }
    setState(() {
      _isLoading = false;
      _ledger = loaded;
    });
  }

  Future<void> _importReferenceImage() async {
    final projectState = ref.read(projectStateProvider);
    if (projectState == null || projectState.projectDirectory == null) {
      return;
    }

    final selectedPath = await _pickReferenceImageFile();
    if (selectedPath == null || selectedPath.trim().isEmpty) {
      return;
    }

    setState(() {
      _isImporting = true;
      _errorMessage = null;
    });

    final result = await _service.importFromLocalFile(
      projectDirectory: projectState.projectDirectory!,
      projectId: projectState.manifest.projectId,
      sourceFilePath: selectedPath,
    );

    if (!mounted) {
      return;
    }

    if (!result.isSuccess || result.record == null) {
      setState(() {
        _isImporting = false;
        _errorMessage = result.errorMessage ?? 'Import failed.';
      });
      return;
    }

    final reloaded = await _service.loadLedger(
      projectDirectory: projectState.projectDirectory!,
      projectId: projectState.manifest.projectId,
    );
    if (!mounted) {
      return;
    }
    setState(() {
      _isImporting = false;
      _ledger = reloaded;
      _selectedReferenceImageId = result.record!.referenceImageId;
      _errorMessage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final projectState = ref.watch(projectStateProvider);
    final hasProject = projectState != null;
    final hasLocalProjectDirectory =
        hasProject && projectState!.projectDirectory != null;

    final selected = _selectedRecord();
    final selectedFile = hasLocalProjectDirectory && selected != null
        ? _service.resolveStoredImageFile(
            projectDirectory: projectState!.projectDirectory!,
            record: selected,
          )
        : null;

    return Scaffold(
      appBar: AppBar(title: const Text('Reference Images')),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _ReferenceOnlyWarningCard(),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
              child: Wrap(
                spacing: 12,
                runSpacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  ElevatedButton(
                    key: const ValueKey('reference-images-import-button'),
                    onPressed: hasLocalProjectDirectory && !_isImporting
                        ? _importReferenceImage
                        : null,
                    child: Text(
                      _isImporting
                          ? 'Importing...'
                          : 'Import local reference image',
                    ),
                  ),
                  Text(
                    'Allowed: png, jpg, jpeg, webp · max ${ReferenceImageSidecarService.maxFileCount} files · max ${ReferenceImageSidecarService.maxFileSizeBytes ~/ (1024 * 1024)} MB each',
                  ),
                ],
              ),
            ),
            if (!hasProject)
              const Padding(
                padding: EdgeInsets.all(12),
                child: Text('Open a project to use local sidecar reference images.'),
              ),
            if (hasProject && !hasLocalProjectDirectory)
              const Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  'Local project directory is required for sidecar storage.',
                ),
              ),
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
                child: Text(
                  _errorMessage!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ),
            const SizedBox(height: 8),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: _ReferenceImageListPanel(
                            records: _ledger.images,
                            selectedReferenceImageId: _selectedReferenceImageId,
                            onSelected: (id) {
                              setState(() {
                                _selectedReferenceImageId = id;
                              });
                            },
                          ),
                        ),
                        const VerticalDivider(width: 1),
                        Expanded(
                          flex: 3,
                          child: _ReferenceImagePreviewPanel(
                            record: selected,
                            file: selectedFile,
                            hasLocalProjectDirectory: hasLocalProjectDirectory,
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  ReferenceImageRecord? _selectedRecord() {
    if (_ledger.images.isEmpty) {
      return null;
    }
    final selectedId = _selectedReferenceImageId;
    if (selectedId == null) {
      return _ledger.images.last;
    }
    for (final record in _ledger.images) {
      if (record.referenceImageId == selectedId) {
        return record;
      }
    }
    return _ledger.images.last;
  }
}

class _ReferenceOnlyWarningCard extends StatelessWidget {
  const _ReferenceOnlyWarningCard();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Reference images (local sidecar)'),
              SizedBox(height: 6),
              Text('reference only'),
              Text('not evidence'),
              Text('not included in Project ZIP'),
              Text('not used by AI'),
              Text('renderer writes: none'),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReferenceImageListPanel extends StatelessWidget {
  const _ReferenceImageListPanel({
    required this.records,
    required this.selectedReferenceImageId,
    required this.onSelected,
  });

  final List<ReferenceImageRecord> records;
  final String? selectedReferenceImageId;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    if (records.isEmpty) {
      return const Center(
        child: Text('No local sidecar reference images yet.'),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(12),
      itemCount: records.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final record = records[index];
        final selected = record.referenceImageId == selectedReferenceImageId;
        return Card(
          color: selected
              ? Theme.of(context).colorScheme.surfaceContainerHighest
              : null,
          child: ListTile(
            key: ValueKey('reference-image-${record.referenceImageId}'),
            title: Text(record.originalFilenameDisplay),
            subtitle: Text(record.referenceImageId),
            trailing: Text('${record.fileSizeBytes} B'),
            onTap: () => onSelected(record.referenceImageId),
          ),
        );
      },
    );
  }
}

class _ReferenceImagePreviewPanel extends StatelessWidget {
  const _ReferenceImagePreviewPanel({
    required this.record,
    required this.file,
    required this.hasLocalProjectDirectory,
  });

  final ReferenceImageRecord? record;
  final File? file;
  final bool hasLocalProjectDirectory;

  @override
  Widget build(BuildContext context) {
    if (!hasLocalProjectDirectory) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Text('Preview is available after opening a local project directory.'),
        ),
      );
    }

    if (record == null) {
      return const Center(
        child: Text('Select a reference image to preview.'),
      );
    }

    final hasFile = file != null && file!.existsSync();
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        Text('ID: ${record!.referenceImageId}'),
        Text('Original file: ${record!.originalFilenameDisplay}'),
        Text('Stored path: ${record!.storedRelativePath}'),
        Text('Type: ${record!.mimeType}'),
        Text('Size: ${record!.fileSizeBytes} bytes'),
        if (record!.sha256 != null) Text('SHA-256: ${record!.sha256}'),
        Text('Imported at: ${record!.importedAt}'),
        Text('Source: ${record!.source}'),
        if (record!.notes != null) Text('Notes: ${record!.notes}'),
        const SizedBox(height: 12),
        if (hasFile)
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.file(
              file!,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) =>
                  const Text('Failed to render selected local sidecar image.'),
            ),
          )
        else
          const Text('Stored file is missing from local sidecar storage.'),
      ],
    );
  }
}
