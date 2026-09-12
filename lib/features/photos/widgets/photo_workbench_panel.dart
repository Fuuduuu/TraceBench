import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../shared/models/project_state.dart';
import '../../../shared/models/trace_bench_event.dart';
import '../../../shared/session/project_session.dart';
import '../../board_canvas/rendering/aligned_photo_layer.dart';
import '../../board_canvas/theme/board_canvas_palette.dart';
import '../logic/photo_alignment_transform.dart';
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
    required this.primaryPhotoRelativePath,
    required this.primaryPhotoAsset,
    required this.primaryPhotoLoading,
    required this.primaryPhotoUnavailable,
    this.alignments = const <PhotoAlignmentEventItem>[],
    this.sourcePicker,
    this.previewLoader,
    this.importService,
    this.alignmentWriter,
    this.alignedPhotoAssetLoader,
    this.alignedPhotoImageBuilder,
    this.boardPointPicker,
    this.onAlignmentPreviewChanged,
    this.activeAlignmentId,
    this.onActiveAlignmentChanged,
    this.alignmentLayerVisible = true,
    this.onAlignmentLayerVisibleChanged,
    this.alignmentLayerOpacity = 0.65,
    this.onAlignmentLayerOpacityChanged,
    this.onPrimaryPhotoAssetChanged,
    this.onCanonicalEventApplied,
  });

  final ProjectState projectState;
  final ProjectSession projectSession;
  final List<PhotoEventItem> photos;
  final String? primaryPhotoRelativePath;
  final AlignedPhotoAsset? primaryPhotoAsset;
  final bool primaryPhotoLoading;
  final bool primaryPhotoUnavailable;
  final List<PhotoAlignmentEventItem> alignments;
  final PhotoSourcePicker? sourcePicker;
  final PhotoSourcePreviewLoader? previewLoader;
  final PhotoImportService? importService;
  final PhotoAlignmentEventWriter? alignmentWriter;
  final AlignedPhotoAssetLoader? alignedPhotoAssetLoader;
  final AlignedPhotoImageBuilder? alignedPhotoImageBuilder;
  final Future<PhotoAlignmentPoint?> Function()? boardPointPicker;
  final ValueChanged<PhotoAlignmentPreview?>? onAlignmentPreviewChanged;
  final String? activeAlignmentId;
  final ValueChanged<String?>? onActiveAlignmentChanged;
  final bool alignmentLayerVisible;
  final ValueChanged<bool>? onAlignmentLayerVisibleChanged;
  final double alignmentLayerOpacity;
  final ValueChanged<double>? onAlignmentLayerOpacityChanged;
  final ValueChanged<AlignedPhotoAsset>? onPrimaryPhotoAssetChanged;
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
    final inherited = Theme.of(context);
    final textTheme = inherited.textTheme.apply(
      bodyColor: BoardCanvasPalette.navy,
      displayColor: BoardCanvasPalette.navy,
    );
    return Theme(
      data: inherited.copyWith(
        colorScheme: inherited.colorScheme.copyWith(
          brightness: Brightness.dark,
          primary: BoardCanvasPalette.signal,
          onPrimary: BoardCanvasPalette.paper,
          primaryContainer: BoardCanvasPalette.signalTint,
          onPrimaryContainer: BoardCanvasPalette.navy,
          secondary: BoardCanvasPalette.signal,
          onSecondary: BoardCanvasPalette.paper,
          secondaryContainer: BoardCanvasPalette.signalTint,
          onSecondaryContainer: BoardCanvasPalette.navy,
          surface: BoardCanvasPalette.paper,
          onSurface: BoardCanvasPalette.navy,
          onSurfaceVariant: BoardCanvasPalette.muted,
          surfaceContainerHighest: BoardCanvasPalette.rule,
          outline: BoardCanvasPalette.ruleStrong,
          outlineVariant: BoardCanvasPalette.rule,
        ),
        canvasColor: BoardCanvasPalette.tile,
        disabledColor: BoardCanvasPalette.dim,
        dividerColor: BoardCanvasPalette.rule,
        textTheme: textTheme.copyWith(
          bodySmall: textTheme.bodySmall?.copyWith(color: BoardCanvasPalette.muted),
        ),
        iconTheme: inherited.iconTheme.copyWith(color: BoardCanvasPalette.navy),
        iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(
            foregroundColor: BoardCanvasPalette.navy,
            disabledForegroundColor: BoardCanvasPalette.dim,
          ).copyWith(
            // ListTile resolves foregroundColor using the tile's own state;
            // retain each trailing button's disabled state for its icon.
            iconColor: WidgetStateProperty.resolveWith((states) =>
                states.contains(WidgetState.disabled)
                    ? BoardCanvasPalette.dim
                    : BoardCanvasPalette.navy),
          ),
        ),
        inputDecorationTheme: inherited.inputDecorationTheme.copyWith(
          labelStyle: const TextStyle(color: BoardCanvasPalette.muted),
          floatingLabelStyle: const TextStyle(color: BoardCanvasPalette.signal),
          helperStyle: const TextStyle(color: BoardCanvasPalette.muted),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            foregroundColor: BoardCanvasPalette.paper,
            backgroundColor: BoardCanvasPalette.signal,
            disabledForegroundColor: BoardCanvasPalette.dim,
            disabledBackgroundColor: BoardCanvasPalette.rule,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: BoardCanvasPalette.signal,
            disabledForegroundColor: BoardCanvasPalette.dim,
          ),
        ),
      ),
      // Descendant controls and explicit Theme.of calls must resolve this
      // local dark theme, not the light app theme above the panel.
      child: Builder(builder: _buildContent),
    );
  }

  Widget _buildContent(BuildContext context) {
    final theme = Theme.of(context);
    final primaryPhotoPath = widget.primaryPhotoRelativePath;
    final primaryPhotoSha256 = widget.primaryPhotoAsset?.sha256.toLowerCase();
    final additionalPhotos = widget.photos.where((photo) {
      final photoSha256 = photo.sha256?.toLowerCase();
      return primaryPhotoPath == null ||
          primaryPhotoSha256 == null ||
          photo.path != primaryPhotoPath ||
          photoSha256 != primaryPhotoSha256;
    }).toList(growable: false);
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
            const Text(
              'Projekti foto on ainus V1 joondusallikas. Joondus on geomeetriline visuaalne tõend.',
            ),
            const SizedBox(height: 10),
            _PhotoAlignmentWorkbench(
              key: ValueKey<String>(
                'photo_alignment_${widget.projectState.manifest.projectId}_${widget.projectState.projectDirectory}_${widget.primaryPhotoRelativePath}',
              ),
              projectState: widget.projectState,
              projectSession: widget.projectSession,
              primaryPhotoRelativePath: widget.primaryPhotoRelativePath,
              primaryPhotoAsset: widget.primaryPhotoAsset,
              primaryPhotoLoading: widget.primaryPhotoLoading,
              primaryPhotoUnavailable: widget.primaryPhotoUnavailable,
              alignments: widget.alignments,
              writer: widget.alignmentWriter,
              assetLoader: widget.alignedPhotoAssetLoader,
              imageBuilder: widget.alignedPhotoImageBuilder,
              boardPointPicker: widget.boardPointPicker,
              onPreviewChanged: widget.onAlignmentPreviewChanged,
              activeAlignmentId: widget.activeAlignmentId,
              onActiveAlignmentChanged: widget.onActiveAlignmentChanged,
              layerVisible: widget.alignmentLayerVisible,
              onLayerVisibleChanged: widget.onAlignmentLayerVisibleChanged,
              layerOpacity: widget.alignmentLayerOpacity,
              onLayerOpacityChanged: widget.onAlignmentLayerOpacityChanged,
              onPrimaryPhotoAssetChanged: widget.onPrimaryPhotoAssetChanged,
              onCanonicalEventApplied: widget.onCanonicalEventApplied,
            ),
            const SizedBox(height: 14),
            const Divider(),
            Text('Lisafotod', style: theme.textTheme.titleSmall),
            const SizedBox(height: 4),
            Text(
              'Impordi ja lisa säilitab täiendava visuaalse tõendi. Lisafoto ei asenda ega joonda projekti fotot.',
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
            OutlinedButton.icon(
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
            Text(
              'Canonical additional photo events',
              style: theme.textTheme.titleSmall,
            ),
            const SizedBox(height: 4),
            if (additionalPhotos.isEmpty)
              const Text('No accepted additional photo events yet.')
            else
              Column(
                key: const Key('photo_event_list'),
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  for (final photo in additionalPhotos)
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

class PhotoAlignmentPreview {
  const PhotoAlignmentPreview({
    required this.sourceRelativePath,
    required this.asset,
    required this.solution,
    required this.photoPoints,
    required this.boardPoints,
  });

  final String sourceRelativePath;
  final AlignedPhotoAsset asset;
  final PhotoAlignmentSolution? solution;
  final List<PhotoAlignmentPoint> photoPoints;
  final List<PhotoAlignmentPoint> boardPoints;
}

class _PhotoAlignmentPair {
  const _PhotoAlignmentPair({required this.photo, required this.board});

  final PhotoAlignmentPoint photo;
  final PhotoAlignmentPoint board;
}

class _PhotoAlignmentWorkbench extends StatefulWidget {
  const _PhotoAlignmentWorkbench({
    super.key,
    required this.projectState,
    required this.projectSession,
    required this.primaryPhotoRelativePath,
    required this.primaryPhotoAsset,
    required this.primaryPhotoLoading,
    required this.primaryPhotoUnavailable,
    required this.alignments,
    required this.writer,
    required this.assetLoader,
    required this.imageBuilder,
    required this.boardPointPicker,
    required this.onPreviewChanged,
    required this.activeAlignmentId,
    required this.onActiveAlignmentChanged,
    required this.layerVisible,
    required this.onLayerVisibleChanged,
    required this.layerOpacity,
    required this.onLayerOpacityChanged,
    required this.onPrimaryPhotoAssetChanged,
    required this.onCanonicalEventApplied,
  });

  final ProjectState projectState;
  final ProjectSession projectSession;
  final String? primaryPhotoRelativePath;
  final AlignedPhotoAsset? primaryPhotoAsset;
  final bool primaryPhotoLoading;
  final bool primaryPhotoUnavailable;
  final List<PhotoAlignmentEventItem> alignments;
  final PhotoAlignmentEventWriter? writer;
  final AlignedPhotoAssetLoader? assetLoader;
  final AlignedPhotoImageBuilder? imageBuilder;
  final Future<PhotoAlignmentPoint?> Function()? boardPointPicker;
  final ValueChanged<PhotoAlignmentPreview?>? onPreviewChanged;
  final String? activeAlignmentId;
  final ValueChanged<String?>? onActiveAlignmentChanged;
  final bool layerVisible;
  final ValueChanged<bool>? onLayerVisibleChanged;
  final double layerOpacity;
  final ValueChanged<double>? onLayerOpacityChanged;
  final ValueChanged<AlignedPhotoAsset>? onPrimaryPhotoAssetChanged;
  final VoidCallback? onCanonicalEventApplied;

  @override
  State<_PhotoAlignmentWorkbench> createState() =>
      _PhotoAlignmentWorkbenchState();
}

class _PhotoAlignmentWorkbenchState extends State<_PhotoAlignmentWorkbench> {
  static const String _primaryPhotoChangedFeedback =
      'Projekti foto fail muutus. Kontrolli värskendatud fotot ja vali joonduspunktid uuesti.';

  late PhotoAlignmentEventWriter _writer;
  late AlignedPhotoAssetLoader _assetLoader;
  PhotoAlignmentPoint? _pendingPhotoPoint;
  final List<_PhotoAlignmentPair> _pairs = <_PhotoAlignmentPair>[];
  PhotoAlignmentTransformType _transformType =
      PhotoAlignmentTransformType.similarity;
  String _boardSide = 'top';
  PhotoAlignmentSolution? _solution;
  bool _boardPointInFlight = false;
  bool _confirmationInFlight = false;
  String? _feedback;

  bool get _directoryBacked =>
      widget.projectState.projectDirectory?.trim().isNotEmpty ?? false;

  @override
  void initState() {
    super.initState();
    _refreshDependencies();
  }

  @override
  void didUpdateWidget(covariant _PhotoAlignmentWorkbench oldWidget) {
    super.didUpdateWidget(oldWidget);
    _refreshDependencies();
    final pathChanged =
        oldWidget.primaryPhotoRelativePath != widget.primaryPhotoRelativePath;
    final assetChanged =
        oldWidget.primaryPhotoAsset?.sha256 != widget.primaryPhotoAsset?.sha256;
    if (pathChanged || assetChanged) {
      _clearDraft(notify: false);
      if (!pathChanged &&
          oldWidget.primaryPhotoAsset != null &&
          widget.primaryPhotoAsset != null) {
        _feedback = _primaryPhotoChangedFeedback;
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          widget.onPreviewChanged?.call(null);
        }
      });
    }
  }

  void _refreshDependencies() {
    _writer = widget.writer ?? PhotoEventWriterService();
    _assetLoader = widget.assetLoader ?? const LocalAlignedPhotoAssetLoader();
  }

  void _capturePhotoPoint(TapUpDetails details) {
    final asset = widget.primaryPhotoAsset;
    if (asset == null) {
      return;
    }
    final previewContext =
        _photoPreviewKey.currentContext?.findRenderObject() as RenderBox?;
    if (previewContext == null ||
        previewContext.size.width <= 0 ||
        previewContext.size.height <= 0) {
      return;
    }
    final point = PhotoAlignmentPoint(
      x: (details.localPosition.dx / previewContext.size.width)
              .clamp(0.0, 1.0) *
          asset.width,
      y: (details.localPosition.dy / previewContext.size.height)
              .clamp(0.0, 1.0) *
          asset.height,
    );
    setState(() {
      _pendingPhotoPoint = point;
      _feedback = null;
    });
  }

  final GlobalKey _photoPreviewKey = GlobalKey();

  Future<void> _captureBoardPoint() async {
    final pending = _pendingPhotoPoint;
    final picker = widget.boardPointPicker;
    final capturedPhotoPath = widget.primaryPhotoRelativePath;
    if (pending == null ||
        picker == null ||
        capturedPhotoPath == null ||
        _boardPointInFlight) {
      return;
    }
    final capturedProjectId = widget.projectState.manifest.projectId;
    setState(() {
      _boardPointInFlight = true;
      _feedback = 'Click the corresponding point on Board Canvas.';
    });
    try {
      final board = await picker();
      if (!mounted ||
          widget.projectState.manifest.projectId != capturedProjectId ||
          widget.primaryPhotoRelativePath != capturedPhotoPath ||
          board == null) {
        return;
      }
      setState(() {
        _pairs.add(_PhotoAlignmentPair(photo: pending, board: board));
        _pendingPhotoPoint = null;
        _feedback = null;
      });
      _recomputeSolution();
    } finally {
      if (mounted) {
        setState(() => _boardPointInFlight = false);
      }
    }
  }

  void _removePair(int index) {
    setState(() => _pairs.removeAt(index));
    _recomputeSolution();
  }

  void _movePair(int from, int to) {
    if (to < 0 || to >= _pairs.length) {
      return;
    }
    setState(() {
      final pair = _pairs.removeAt(from);
      _pairs.insert(to, pair);
    });
    _recomputeSolution();
  }

  void _setTransformType(PhotoAlignmentTransformType type) {
    setState(() => _transformType = type);
    _recomputeSolution();
  }

  void _recomputeSolution() {
    final asset = widget.primaryPhotoAsset;
    final photoPoints =
        _pairs.map((pair) => pair.photo).toList(growable: false);
    final boardPoints =
        _pairs.map((pair) => pair.board).toList(growable: false);
    PhotoAlignmentSolution? solution;
    String? error;
    if (asset != null) {
      try {
        solution = solvePhotoAlignment(
          transformType: _transformType,
          photoPoints: photoPoints,
          boardPoints: boardPoints,
          photoWidth: asset.width,
          photoHeight: asset.height,
        );
      } on PhotoAlignmentException catch (value) {
        error = value.message;
      }
    }
    if (mounted) {
      setState(() {
        _solution = solution;
        if (_pairs.isNotEmpty) {
          _feedback = error;
        }
      });
    }
    widget.onPreviewChanged?.call(
      asset == null || widget.primaryPhotoRelativePath == null || _pairs.isEmpty
          ? null
          : PhotoAlignmentPreview(
              sourceRelativePath: widget.primaryPhotoRelativePath!,
              asset: asset,
              solution: solution,
              photoPoints: List<PhotoAlignmentPoint>.unmodifiable(photoPoints),
              boardPoints: List<PhotoAlignmentPoint>.unmodifiable(boardPoints),
            ),
    );
  }

  void _clearDraft({required bool notify}) {
    _pairs.clear();
    _pendingPhotoPoint = null;
    _solution = null;
    _transformType = PhotoAlignmentTransformType.similarity;
    _boardSide = 'top';
    _feedback = null;
    if (notify) {
      widget.onPreviewChanged?.call(null);
    }
  }

  void _cancelDraft() {
    setState(() => _clearDraft(notify: false));
    widget.onPreviewChanged?.call(null);
  }

  Future<void> _confirmAlignment() async {
    final solution = _solution;
    final asset = widget.primaryPhotoAsset;
    final primaryPhotoPath = widget.primaryPhotoRelativePath;
    final projectDirectory = widget.projectState.projectDirectory;
    if (solution == null ||
        asset == null ||
        primaryPhotoPath == null ||
        projectDirectory == null ||
        _confirmationInFlight ||
        !_directoryBacked) {
      return;
    }
    final capturedState = widget.projectState;
    final capturedSession = widget.projectSession;
    final capturedGeneration = widget.projectSession.generation;
    final capturedProjectId = capturedState.manifest.projectId;
    final capturedProjectDirectory = capturedState.projectDirectory;
    final capturedPhotoPoints =
        _pairs.map((pair) => pair.photo).toList(growable: false);
    final capturedBoardPoints =
        _pairs.map((pair) => pair.board).toList(growable: false);
    final capturedTransformType = _transformType;
    final capturedBoardSide = _boardSide;
    setState(() {
      _confirmationInFlight = true;
      _feedback = null;
    });
    try {
      final freshAsset = await _assetLoader.load(
        projectDirectory: projectDirectory,
        relativePath: primaryPhotoPath,
      );
      if (!_capturedContextIsCurrent(
        session: capturedSession,
        generation: capturedGeneration,
        projectId: capturedProjectId,
        projectDirectory: capturedProjectDirectory,
        primaryPhotoPath: primaryPhotoPath,
      )) {
        _showStaleConfirmationFeedback();
        return;
      }
      if (freshAsset.sha256.toLowerCase() != asset.sha256.toLowerCase()) {
        setState(() {
          _clearDraft(notify: false);
          _feedback = _primaryPhotoChangedFeedback;
        });
        widget.onPreviewChanged?.call(null);
        widget.onPrimaryPhotoAssetChanged?.call(freshAsset);
        return;
      }
      solvePhotoAlignment(
        transformType: capturedTransformType,
        photoPoints: capturedPhotoPoints,
        boardPoints: capturedBoardPoints,
        photoWidth: freshAsset.width,
        photoHeight: freshAsset.height,
      );

      final primaryResult = await _writer.ensurePrimaryPhotoAdded(
        projectState: capturedState,
        request: PrimaryPhotoEventWriteRequest(
          path: primaryPhotoPath,
          sha256: freshAsset.sha256,
        ),
      );
      if (!_capturedContextIsCurrent(
        session: capturedSession,
        generation: capturedGeneration,
        projectId: capturedProjectId,
        projectDirectory: capturedProjectDirectory,
        primaryPhotoPath: primaryPhotoPath,
      )) {
        _showStaleConfirmationFeedback();
        return;
      }

      var workingState = capturedState;
      final primaryEventId = primaryResult.event['event_id'];
      final primaryAlreadyApplied = primaryEventId is String &&
          capturedState.events.any((event) => event.eventId == primaryEventId);
      if (!primaryAlreadyApplied) {
        final photoApplied = capturedSession.applyCanonicalEvent(
          primaryResult.event,
          generation: capturedGeneration,
        );
        if (!photoApplied) {
          _showStaleConfirmationFeedback();
          return;
        }
        workingState = capturedState.copyWith(
          events: <TraceBenchEvent>[
            ...capturedState.events,
            TraceBenchEvent.fromJson(primaryResult.event),
          ],
        );
        widget.onCanonicalEventApplied?.call();
      }
      if (!_capturedContextIsCurrent(
        session: capturedSession,
        generation: capturedGeneration,
        projectId: capturedProjectId,
        projectDirectory: capturedProjectDirectory,
        primaryPhotoPath: primaryPhotoPath,
      )) {
        _showStaleConfirmationFeedback();
        return;
      }

      final sourcePhotoId =
          (primaryResult.event['payload'] as Map?)?['photo_id'];
      if (sourcePhotoId is! String) {
        throw const PhotoEventWriteException(
          PhotoEventWriteFailureKind.invalidEventHistory,
          'Primary photo handoff did not return a canonical photo identity.',
          durability: PhotoEventDurability.durable,
        );
      }
      final result = await _writer.confirmAlignment(
        projectState: workingState,
        request: PhotoAlignmentEventWriteRequest(
          sourcePhotoId: sourcePhotoId,
          boardSide: capturedBoardSide,
          transformType: capturedTransformType,
          photoPoints: capturedPhotoPoints,
          boardPoints: capturedBoardPoints,
          photoWidth: freshAsset.width,
          photoHeight: freshAsset.height,
        ),
      );
      if (!_capturedContextIsCurrent(
        session: capturedSession,
        generation: capturedGeneration,
        projectId: capturedProjectId,
        projectDirectory: capturedProjectDirectory,
        primaryPhotoPath: primaryPhotoPath,
      )) {
        _showStaleConfirmationFeedback();
        return;
      }
      final applied = capturedSession.applyCanonicalEvent(
        result.event,
        generation: capturedGeneration,
      );
      if (!mounted) {
        return;
      }
      if (applied) {
        setState(() {
          _clearDraft(notify: false);
          _feedback = 'Alignment confirmed and canonical event applied.';
        });
        widget.onPreviewChanged?.call(null);
        final alignmentId = (result.event['payload'] as Map?)?['alignment_id'];
        if (alignmentId is String) {
          widget.onActiveAlignmentChanged?.call(alignmentId);
        }
        widget.onCanonicalEventApplied?.call();
      } else {
        setState(() {
          _feedback =
              'The alignment event was saved to the previous project, but the current project was not changed.';
        });
      }
    } on PhotoEventWriteException catch (error) {
      if (mounted) {
        setState(() => _feedback = error.message);
      }
    } on Exception catch (error) {
      if (mounted) {
        setState(() => _feedback = 'Alignment confirmation failed: $error');
      }
    } finally {
      if (mounted) {
        setState(() => _confirmationInFlight = false);
      }
    }
  }

  bool _capturedContextIsCurrent({
    required ProjectSession session,
    required int generation,
    required String projectId,
    required String? projectDirectory,
    required String primaryPhotoPath,
  }) {
    return mounted &&
        identical(widget.projectSession, session) &&
        session.generation == generation &&
        widget.projectState.manifest.projectId == projectId &&
        widget.projectState.projectDirectory == projectDirectory &&
        widget.primaryPhotoRelativePath == primaryPhotoPath;
  }

  void _showStaleConfirmationFeedback() {
    if (!mounted) {
      return;
    }
    setState(() {
      _feedback =
          'The photo event may be saved to the previous project, but the current project was not changed.';
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final asset = widget.primaryPhotoAsset;
    final solution = _solution;
    return Column(
      key: const Key('photo_alignment_workbench'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text('Projekti foto', style: theme.textTheme.titleSmall),
        const SizedBox(height: 4),
        const Text(
          'Alignment is geometric visual evidence only. Review the residual before using Kinnita joondus.',
        ),
        if (!_directoryBacked) ...<Widget>[
          const SizedBox(height: 6),
          const Text('Alignment authoring requires a local directory project.'),
        ],
        if (widget.primaryPhotoRelativePath == null) ...<Widget>[
          const SizedBox(height: 6),
          const Text(
            'Projektis puudub Wizardi taustafoto. V1 joondus vajab projekti loomisel valitud fotot.',
            key: Key('photo_alignment_no_primary_guidance'),
          ),
        ] else ...<Widget>[
          const SizedBox(height: 8),
          Text(
            widget.primaryPhotoRelativePath!,
            key: const Key('photo_alignment_primary_path'),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          if (widget.primaryPhotoLoading) const LinearProgressIndicator(),
          if (widget.primaryPhotoUnavailable) ...<Widget>[
            const SizedBox(height: 6),
            const Text(
              'Projekti foto puudub, ei ole turvaline või pole loetav. Canvas jääb kasutatavaks.',
              key: Key('photo_alignment_primary_unavailable'),
            ),
          ],
          if (asset != null) ...<Widget>[
            const SizedBox(height: 8),
            AspectRatio(
              aspectRatio: asset.width / asset.height,
              child: LayoutBuilder(
                builder: (context, constraints) => GestureDetector(
                  key: const Key('photo_alignment_photo_preview'),
                  behavior: HitTestBehavior.opaque,
                  onTapUp: _confirmationInFlight ? null : _capturePhotoPoint,
                  child: Stack(
                    key: _photoPreviewKey,
                    clipBehavior: Clip.hardEdge,
                    children: <Widget>[
                      Positioned.fill(
                        child: (widget.imageBuilder ??
                            (context, value) => Image.file(
                                  value.file,
                                  fit: BoxFit.fill,
                                ))(context, asset),
                      ),
                      for (var index = 0; index < _pairs.length; index++)
                        _photoPointMarker(
                          point: _pairs[index].photo,
                          asset: asset,
                          previewSize: constraints.biggest,
                          key: Key('photo_alignment_photo_marker_$index'),
                          label: '${index + 1}',
                        ),
                      if (_pendingPhotoPoint case final pending?)
                        _photoPointMarker(
                          point: pending,
                          asset: asset,
                          previewSize: constraints.biggest,
                          key: const Key('photo_alignment_pending_marker'),
                          label: '+',
                        ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              _pendingPhotoPoint == null
                  ? 'Click a photo reference point.'
                  : 'Photo point: ${_pendingPhotoPoint!.x.toStringAsFixed(1)}, ${_pendingPhotoPoint!.y.toStringAsFixed(1)}',
            ),
            OutlinedButton.icon(
              key: const Key('photo_alignment_capture_board_point'),
              onPressed: _pendingPhotoPoint != null &&
                      !_boardPointInFlight &&
                      widget.boardPointPicker != null
                  ? _captureBoardPoint
                  : null,
              icon: const Icon(Icons.gps_fixed),
              label: Text(
                _boardPointInFlight
                    ? 'Waiting for Canvas…'
                    : 'Vali vaste Canvaselt',
              ),
            ),
          ],
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            key: const Key('photo_alignment_board_side_field'),
            isExpanded: true,
            initialValue: _boardSide,
            decoration: const InputDecoration(labelText: 'Board side'),
            items: const <DropdownMenuItem<String>>[
              DropdownMenuItem(value: 'top', child: Text('top')),
              DropdownMenuItem(value: 'bottom', child: Text('bottom')),
              DropdownMenuItem(value: 'unknown', child: Text('unknown')),
            ],
            onChanged: asset == null || _confirmationInFlight
                ? null
                : (value) {
                    if (value != null) {
                      setState(() => _boardSide = value);
                    }
                  },
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<PhotoAlignmentTransformType>(
            key: const Key('photo_alignment_transform_field'),
            isExpanded: true,
            initialValue: _transformType,
            decoration: const InputDecoration(labelText: 'Transform'),
            items: const <DropdownMenuItem<PhotoAlignmentTransformType>>[
              DropdownMenuItem(
                value: PhotoAlignmentTransformType.similarity,
                child: Text('Similarity'),
              ),
              DropdownMenuItem(
                value: PhotoAlignmentTransformType.affine,
                child: Text('Affine (Advanced)'),
              ),
            ],
            onChanged: asset == null || _confirmationInFlight
                ? null
                : (value) {
                    if (value != null) {
                      _setTransformType(value);
                    }
                  },
          ),
          const SizedBox(height: 8),
          for (var index = 0; index < _pairs.length; index++)
            ListTile(
              key: Key('photo_alignment_pair_$index'),
              dense: true,
              contentPadding: EdgeInsets.zero,
              title: Text('Pair ${index + 1}'),
              subtitle: Text(
                'photo ${_pairs[index].photo.x.toStringAsFixed(1)}, ${_pairs[index].photo.y.toStringAsFixed(1)} → board ${_pairs[index].board.x.toStringAsFixed(3)}, ${_pairs[index].board.y.toStringAsFixed(3)}',
              ),
              trailing: Wrap(
                spacing: 0,
                children: <Widget>[
                  IconButton(
                    key: Key('photo_alignment_pair_up_$index'),
                    onPressed:
                        index > 0 ? () => _movePair(index, index - 1) : null,
                    icon: const Icon(Icons.arrow_upward),
                  ),
                  IconButton(
                    key: Key('photo_alignment_pair_down_$index'),
                    onPressed: index + 1 < _pairs.length
                        ? () => _movePair(index, index + 1)
                        : null,
                    icon: const Icon(Icons.arrow_downward),
                  ),
                  IconButton(
                    key: Key('photo_alignment_pair_remove_$index'),
                    onPressed: () => _removePair(index),
                    icon: const Icon(Icons.delete_outline),
                  ),
                ],
              ),
            ),
          if (solution != null) ...<Widget>[
            Text(
              'RMS ${solution.rmsResidual.toStringAsFixed(6)} · max ${solution.maxResidual.toStringAsFixed(6)}',
              key: const Key('photo_alignment_residual'),
            ),
            if (solution.isReflected)
              const Text(
                'Warning: affine alignment is mirrored (negative determinant).',
                key: Key('photo_alignment_mirror_warning'),
              ),
          ],
          const SizedBox(height: 8),
          Row(
            children: <Widget>[
              Expanded(
                child: OutlinedButton(
                  key: const Key('photo_alignment_cancel'),
                  onPressed: _pairs.isNotEmpty || _pendingPhotoPoint != null
                      ? _cancelDraft
                      : null,
                  child: const Text('Tühista joondus'),
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: FilledButton(
                  key: const Key('photo_alignment_confirm'),
                  onPressed: solution != null &&
                          !_confirmationInFlight &&
                          _directoryBacked
                      ? _confirmAlignment
                      : null,
                  child: Text(
                    _confirmationInFlight ? 'Kinnitamine…' : 'Kinnita joondus',
                  ),
                ),
              ),
            ],
          ),
        ],
        if (_feedback case final feedback?) ...<Widget>[
          const SizedBox(height: 6),
          Text(feedback, key: const Key('photo_alignment_feedback')),
        ],
        if (widget.alignments.isNotEmpty) ...<Widget>[
          const SizedBox(height: 12),
          Text('Aligned Canvas layer', style: theme.textTheme.titleSmall),
          DropdownButtonFormField<String>(
            key: const Key('photo_alignment_active_layer_field'),
            isExpanded: true,
            initialValue: widget.activeAlignmentId,
            decoration: const InputDecoration(labelText: 'Active alignment'),
            items: <DropdownMenuItem<String>>[
              for (final alignment in widget.alignments)
                DropdownMenuItem<String>(
                  value: alignment.alignmentId,
                  child: Text(
                    '${alignment.alignmentId} · ${alignment.transformType.canonicalName}',
                  ),
                ),
            ],
            onChanged: widget.onActiveAlignmentChanged,
          ),
          SwitchListTile(
            key: const Key('photo_alignment_layer_visibility'),
            contentPadding: EdgeInsets.zero,
            title: const Text('Show aligned photo'),
            value: widget.layerVisible,
            onChanged: widget.onLayerVisibleChanged,
          ),
          Slider(
            key: const Key('photo_alignment_layer_opacity'),
            value: widget.layerOpacity.clamp(0, 1),
            min: 0,
            max: 1,
            label: widget.layerOpacity.toStringAsFixed(2),
            onChanged: widget.onLayerOpacityChanged,
          ),
        ],
      ],
    );
  }

  Widget _photoPointMarker({
    required Key key,
    required PhotoAlignmentPoint point,
    required AlignedPhotoAsset asset,
    required Size previewSize,
    required String label,
  }) {
    const diameter = 16.0;
    final left = ((point.x / asset.width) * previewSize.width - diameter / 2)
        .clamp(0.0, previewSize.width - diameter);
    final top = ((point.y / asset.height) * previewSize.height - diameter / 2)
        .clamp(0.0, previewSize.height - diameter);
    return Positioned(
      left: left,
      top: top,
      child: IgnorePointer(
        child: Container(
          key: key,
          width: diameter,
          height: diameter,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.amber.withValues(alpha: 0.9),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black, width: 1.5),
          ),
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 9,
              fontWeight: FontWeight.w700,
            ),
          ),
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
