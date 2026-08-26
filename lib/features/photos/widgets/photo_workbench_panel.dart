import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../shared/models/project_state.dart';
import '../../../shared/session/project_session.dart';
import '../logic/photo_event_read_model.dart';
import '../services/photo_event_writer.dart';
import '../services/photo_import_service.dart';

abstract interface class PhotoSourcePicker {
  bool get isSupported;

  Future<String?> pickSingleImage();
}

class DesktopPhotoSourcePicker implements PhotoSourcePicker {
  const DesktopPhotoSourcePicker();

  @override
  bool get isSupported =>
      !kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS);

  @override
  Future<String?> pickSingleImage() async {
    if (!isSupported) {
      return null;
    }
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: const <String>['jpg', 'jpeg', 'png', 'webp'],
      withData: false,
    );
    return result?.files.single.path;
  }
}

abstract interface class PhotoSourcePreviewLoader {
  Future<PhotoSourcePreview> loadPreview(String sourcePath);
}

class LocalPhotoSourcePreviewLoader implements PhotoSourcePreviewLoader {
  const LocalPhotoSourcePreviewLoader();

  @override
  Future<PhotoSourcePreview> loadPreview(String sourcePath) async {
    final normalized = sourcePath.replaceAll('\\', '/');
    final fileName = normalized.split('/').last;
    final dot = fileName.lastIndexOf('.');
    final extension = dot < 0 ? '' : fileName.substring(dot + 1).toLowerCase();
    if (!const <String>{'jpg', 'jpeg', 'png', 'webp'}.contains(extension)) {
      throw const PhotoSourcePreviewException(
        'Selected file is not a supported jpg, jpeg, png, or webp photo.',
      );
    }
    final file = File(sourcePath);
    if (await FileSystemEntity.type(sourcePath, followLinks: true) !=
        FileSystemEntityType.file) {
      throw const PhotoSourcePreviewException(
        'Selected photo is not a readable regular file.',
      );
    }
    final stat = await file.stat();
    return PhotoSourcePreview(
      sourcePath: sourcePath,
      fileName: fileName,
      extension: extension,
      byteSize: stat.size,
    );
  }
}

class PhotoSourcePreviewException implements Exception {
  const PhotoSourcePreviewException(this.message);

  final String message;

  @override
  String toString() => message;
}

class PhotoSourcePreview {
  const PhotoSourcePreview({
    required this.sourcePath,
    required this.fileName,
    required this.extension,
    required this.byteSize,
  });

  final String sourcePath;
  final String fileName;
  final String extension;
  final int byteSize;
}

class PhotoWorkbenchPanel extends StatefulWidget {
  const PhotoWorkbenchPanel({
    super.key,
    required this.projectState,
    required this.projectSession,
    required this.photos,
    this.sourcePicker,
    this.previewLoader,
    this.importService,
    this.onCanonicalEventApplied,
  });

  final ProjectState projectState;
  final ProjectSession projectSession;
  final List<PhotoEventItem> photos;
  final PhotoSourcePicker? sourcePicker;
  final PhotoSourcePreviewLoader? previewLoader;
  final PhotoImportService? importService;
  final VoidCallback? onCanonicalEventApplied;

  @override
  State<PhotoWorkbenchPanel> createState() => _PhotoWorkbenchPanelState();
}

class _PhotoWorkbenchPanelState extends State<PhotoWorkbenchPanel> {
  late PhotoSourcePicker _sourcePicker;
  late PhotoSourcePreviewLoader _previewLoader;
  late PhotoImportService _importService;
  PhotoSourcePreview? _preview;
  String _mode = 'normal';
  String? _layer;
  bool _selectionInFlight = false;
  bool _confirmationInFlight = false;
  String? _feedback;

  bool get _directoryBacked {
    final directory = widget.projectState.projectDirectory;
    return directory != null && directory.trim().isNotEmpty;
  }

  @override
  void initState() {
    super.initState();
    _refreshDependencies();
  }

  @override
  void didUpdateWidget(PhotoWorkbenchPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    _refreshDependencies();
    if (oldWidget.projectState.manifest.projectId !=
            widget.projectState.manifest.projectId ||
        oldWidget.projectState.projectDirectory !=
            widget.projectState.projectDirectory) {
      _preview = null;
      _mode = 'normal';
      _layer = null;
      _feedback = null;
    }
  }

  void _refreshDependencies() {
    _sourcePicker = widget.sourcePicker ?? const DesktopPhotoSourcePicker();
    _previewLoader =
        widget.previewLoader ?? const LocalPhotoSourcePreviewLoader();
    _importService = widget.importService ??
        LocalPhotoImportService(eventWriter: PhotoEventWriterService());
  }

  Future<void> _pickPhoto() async {
    if (_selectionInFlight ||
        _confirmationInFlight ||
        !_directoryBacked ||
        !_sourcePicker.isSupported) {
      return;
    }
    setState(() {
      _selectionInFlight = true;
      _feedback = null;
    });
    final selectedProjectId = widget.projectState.manifest.projectId;
    final selectedProjectDirectory = widget.projectState.projectDirectory;
    try {
      final sourcePath = await _sourcePicker.pickSingleImage();
      if (sourcePath == null) {
        return;
      }
      final preview = await _previewLoader.loadPreview(sourcePath);
      if (!mounted) {
        return;
      }
      if (widget.projectState.manifest.projectId != selectedProjectId ||
          widget.projectState.projectDirectory != selectedProjectDirectory) {
        setState(() {
          _feedback =
              'The project changed while the photo picker was open. Select the photo again.';
        });
        return;
      }
      setState(() {
        _preview = preview;
        _feedback = null;
      });
    } on PhotoSourcePreviewException catch (error) {
      if (mounted) {
        setState(() => _feedback = error.message);
      }
    } on Exception catch (error) {
      if (mounted) {
        setState(() => _feedback = 'Could not inspect selected photo: $error');
      }
    } finally {
      if (mounted) {
        setState(() => _selectionInFlight = false);
      }
    }
  }

  Future<void> _confirmImport() async {
    final preview = _preview;
    if (preview == null ||
        _selectionInFlight ||
        _confirmationInFlight ||
        !_directoryBacked) {
      return;
    }
    final capturedState = widget.projectState;
    final capturedGeneration = widget.projectSession.generation;
    setState(() {
      _confirmationInFlight = true;
      _feedback = null;
    });
    try {
      final result = await _importService.importPhoto(
        projectState: capturedState,
        request: PhotoImportRequest(
          sourcePath: preview.sourcePath,
          mode: _mode,
          layer: _layer,
        ),
      );
      final applied = widget.projectSession.applyCanonicalEvent(
        result.event,
        generation: capturedGeneration,
      );
      if (!mounted) {
        return;
      }
      if (applied) {
        setState(() {
          _preview = null;
          _feedback = 'Photo imported and canonical photo_added event applied.';
        });
        widget.onCanonicalEventApplied?.call();
      } else {
        setState(() {
          _feedback =
              'The photo and event were saved to the previous project, but the current project was not changed.';
        });
      }
    } on PhotoImportException catch (error) {
      if (mounted) {
        setState(() {
          _feedback = error.copyPreserved
              ? '${error.message} The imported copy was preserved.'
              : error.message;
        });
      }
    } on Exception catch (error) {
      if (mounted) {
        setState(() {
          _feedback = 'Photo import failed before a proven UI result: $error';
        });
      }
    } finally {
      if (mounted) {
        setState(() => _confirmationInFlight = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final canPick = _directoryBacked &&
        _sourcePicker.isSupported &&
        !_selectionInFlight &&
        !_confirmationInFlight;
    final canConfirm = _directoryBacked &&
        _preview != null &&
        !_selectionInFlight &&
        !_confirmationInFlight;

    return Material(
      key: const Key('photo_workbench_panel'),
      color: Colors.transparent,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('Fotod', style: theme.textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(
              'Imported photos are visual evidence. Import does not create components, nets, measurements, or alignment.',
              style: theme.textTheme.bodySmall,
            ),
            if (!_directoryBacked) ...<Widget>[
              const SizedBox(height: 8),
              const Text(
                'Import requires a project opened from a local folder.',
                key: Key('photo_import_read_only_guidance'),
              ),
            ] else if (!_sourcePicker.isSupported) ...<Widget>[
              const SizedBox(height: 8),
              const Text(
                'Photo selection is available only in the desktop app.',
                key: Key('photo_import_platform_guidance'),
              ),
            ],
            const SizedBox(height: 10),
            OutlinedButton.icon(
              key: const Key('photo_pick_button'),
              onPressed: canPick ? _pickPhoto : null,
              icon: const Icon(Icons.photo_library_outlined),
              label: Text(
                _selectionInFlight ? 'Opening…' : 'Vali foto kettalt',
              ),
            ),
            if (_preview case final preview?) ...<Widget>[
              const SizedBox(height: 8),
              DecoratedBox(
                key: const Key('photo_preview'),
                decoration: BoxDecoration(
                  border: Border.all(color: theme.colorScheme.outlineVariant),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        preview.fileName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text('Type: ${preview.extension}'),
                      Text('Size: ${_formatByteSize(preview.byteSize)}'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                key: const Key('photo_mode_field'),
                initialValue: _mode,
                decoration: const InputDecoration(labelText: 'Mode'),
                items: const <DropdownMenuItem<String>>[
                  DropdownMenuItem(value: 'normal', child: Text('normal')),
                  DropdownMenuItem(
                    value: 'backlight',
                    child: Text('backlight'),
                  ),
                  DropdownMenuItem(value: 'macro', child: Text('macro')),
                  DropdownMenuItem(
                    value: 'side_light',
                    child: Text('side_light'),
                  ),
                ],
                onChanged: _confirmationInFlight
                    ? null
                    : (value) {
                        if (value != null) {
                          setState(() => _mode = value);
                        }
                      },
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String?>(
                key: const Key('photo_layer_field'),
                initialValue: _layer,
                decoration: const InputDecoration(labelText: 'Layer'),
                items: const <DropdownMenuItem<String?>>[
                  DropdownMenuItem<String?>(
                    value: null,
                    child: Text('absent'),
                  ),
                  DropdownMenuItem<String?>(value: 'top', child: Text('top')),
                  DropdownMenuItem<String?>(
                    value: 'bottom',
                    child: Text('bottom'),
                  ),
                  DropdownMenuItem<String?>(
                    value: 'side',
                    child: Text('side'),
                  ),
                  DropdownMenuItem<String?>(
                    value: 'detail',
                    child: Text('detail'),
                  ),
                ],
                onChanged: _confirmationInFlight
                    ? null
                    : (value) => setState(() => _layer = value),
              ),
            ],
            const SizedBox(height: 10),
            FilledButton.icon(
              key: const Key('photo_import_confirm'),
              onPressed: canConfirm ? _confirmImport : null,
              icon: const Icon(Icons.add_photo_alternate_outlined),
              label: const Text('Impordi ja lisa'),
            ),
            if (_feedback case final feedback?) ...<Widget>[
              const SizedBox(height: 8),
              Text(feedback, key: const Key('photo_import_feedback')),
            ],
            const SizedBox(height: 14),
            Text('Canonical photo events', style: theme.textTheme.titleSmall),
            const SizedBox(height: 4),
            if (widget.photos.isEmpty)
              const Text('No accepted photo_added events yet.')
            else
              Column(
                key: const Key('photo_event_list'),
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  for (final photo in widget.photos)
                    ListTile(
                      key: Key('photo_event_${photo.eventId}'),
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.image_outlined),
                      title: Text(photo.photoId),
                      subtitle: Text(
                        '${photo.mode}${photo.layer == null ? '' : ' · ${photo.layer}'}\n${photo.path}',
                      ),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

String _formatByteSize(int bytes) {
  if (bytes < 1024) {
    return '$bytes B';
  }
  if (bytes < 1024 * 1024) {
    return '${(bytes / 1024).toStringAsFixed(1)} KB';
  }
  return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
}
