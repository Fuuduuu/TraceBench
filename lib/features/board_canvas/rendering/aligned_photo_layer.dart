import 'dart:io';
import 'dart:ui' as ui;

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

import '../../photos/logic/photo_alignment_transform.dart';
import '../../photos/logic/photo_event_read_model.dart';

class AlignedPhotoAssetException implements Exception {
  const AlignedPhotoAssetException(this.message);

  final String message;

  @override
  String toString() => message;
}

class AlignedPhotoAsset {
  const AlignedPhotoAsset({
    required this.file,
    required this.width,
    required this.height,
    required this.sha256,
  });

  final File file;
  final double width;
  final double height;
  final String sha256;
}

class AlignedPhotoUnavailableWarning extends StatelessWidget {
  const AlignedPhotoUnavailableWarning({super.key});

  @override
  Widget build(BuildContext context) {
    return const IgnorePointer(
      child: Align(
        alignment: Alignment.topCenter,
        child: Card(
          key: Key('board_canvas_aligned_photo_warning'),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: Text(
              'Projekti foto puudub, ei ole turvaline või pole loetav.',
            ),
          ),
        ),
      ),
    );
  }
}

abstract interface class AlignedPhotoAssetLoader {
  Future<AlignedPhotoAsset> load({
    required String projectDirectory,
    required String relativePath,
  });
}

class LocalAlignedPhotoAssetLoader implements AlignedPhotoAssetLoader {
  const LocalAlignedPhotoAssetLoader();

  @override
  Future<AlignedPhotoAsset> load({
    required String projectDirectory,
    required String relativePath,
  }) async {
    if (!isSafePhotoRelativePath(relativePath) ||
        !_isAbsolute(projectDirectory) ||
        _containsDotSegment(projectDirectory)) {
      throw const AlignedPhotoAssetException(
        'Canonical photo path is not a safe project-local image path.',
      );
    }
    try {
      final root = Directory(projectDirectory);
      if (!await root.exists()) {
        throw const FileSystemException('Project directory does not exist.');
      }
      final resolvedRoot = await root.resolveSymbolicLinks();
      if (FileSystemEntity.typeSync(resolvedRoot, followLinks: true) !=
          FileSystemEntityType.directory) {
        throw const FileSystemException('Project path is not a directory.');
      }
      final candidatePath = relativePath.split('/').fold<String>(
            resolvedRoot,
            (parent, segment) => '$parent${Platform.pathSeparator}$segment',
          );
      if (await FileSystemEntity.type(candidatePath, followLinks: false) !=
          FileSystemEntityType.file) {
        throw const FileSystemException(
          'Canonical photo is missing or is not a regular file.',
        );
      }
      final resolvedCandidate =
          await File(candidatePath).resolveSymbolicLinks();
      if (!_isContained(resolvedRoot, resolvedCandidate)) {
        throw const FileSystemException(
            'Canonical photo escapes project root.');
      }
      final file = File(resolvedCandidate);
      final bytes = await file.readAsBytes();
      final codec = await ui.instantiateImageCodec(bytes);
      try {
        final frame = await codec.getNextFrame();
        try {
          if (frame.image.width <= 0 || frame.image.height <= 0) {
            throw const FileSystemException(
              'Canonical photo has invalid intrinsic dimensions.',
            );
          }
          return AlignedPhotoAsset(
            file: file,
            width: frame.image.width.toDouble(),
            height: frame.image.height.toDouble(),
            sha256: sha256.convert(bytes).toString(),
          );
        } finally {
          frame.image.dispose();
        }
      } finally {
        codec.dispose();
      }
    } on AlignedPhotoAssetException {
      rethrow;
    } on Exception catch (error) {
      throw AlignedPhotoAssetException(
        'Canonical photo could not be loaded safely: $error',
      );
    }
  }
}

typedef AlignedPhotoImageBuilder = Widget Function(
  BuildContext context,
  AlignedPhotoAsset asset,
);

Widget _defaultAlignedPhotoImageBuilder(
  BuildContext context,
  AlignedPhotoAsset asset,
) {
  return Image.file(
    asset.file,
    width: asset.width,
    height: asset.height,
    fit: BoxFit.fill,
    gaplessPlayback: true,
    filterQuality: FilterQuality.medium,
  );
}

class AlignedPhotoLayer extends StatelessWidget {
  const AlignedPhotoLayer({
    super.key,
    required this.asset,
    required this.solution,
    required this.opacity,
    this.imageBuilder,
  });

  final AlignedPhotoAsset asset;
  final PhotoAlignmentSolution solution;
  final double opacity;
  final AlignedPhotoImageBuilder? imageBuilder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final boardWidth = constraints.maxWidth;
        final boardHeight = constraints.maxHeight;
        final transform = solution.transform;
        final matrix = Matrix4.identity()
          ..setEntry(0, 0, boardWidth * transform.m00)
          ..setEntry(0, 1, boardWidth * transform.m01)
          ..setEntry(0, 3, boardWidth * transform.m02)
          ..setEntry(1, 0, boardHeight * transform.m10)
          ..setEntry(1, 1, boardHeight * transform.m11)
          ..setEntry(1, 3, boardHeight * transform.m12);
        return ClipRect(
          child: IgnorePointer(
            key: const Key('board_canvas_aligned_photo_pointer_guard'),
            child: Opacity(
              opacity: opacity.clamp(0, 1),
              // Keep the clipped viewport board-sized, but lay out the raster
              // in photo pixels before applying the photo-to-board matrix.
              child: OverflowBox(
                alignment: Alignment.topLeft,
                minWidth: 0,
                maxWidth: double.infinity,
                minHeight: 0,
                maxHeight: double.infinity,
                child: Transform(
                  key: const Key('board_canvas_aligned_photo_transform'),
                  alignment: Alignment.topLeft,
                  transform: matrix,
                  child: SizedBox(
                    width: asset.width,
                    height: asset.height,
                    child: (imageBuilder ?? _defaultAlignedPhotoImageBuilder)(
                      context,
                      asset,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class ProjectAlignedPhotoLayer extends StatefulWidget {
  const ProjectAlignedPhotoLayer({
    super.key,
    required this.projectId,
    required this.projectDirectory,
    required this.alignment,
    required this.opacity,
    this.assetLoader,
    this.imageBuilder,
  });

  final String projectId;
  final String projectDirectory;
  final PhotoAlignmentEventItem alignment;
  final double opacity;
  final AlignedPhotoAssetLoader? assetLoader;
  final AlignedPhotoImageBuilder? imageBuilder;

  @override
  State<ProjectAlignedPhotoLayer> createState() =>
      _ProjectAlignedPhotoLayerState();
}

class _ProjectAlignedPhotoLayerState extends State<ProjectAlignedPhotoLayer> {
  late Future<AlignedPhotoAsset> _asset;

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  @override
  void didUpdateWidget(covariant ProjectAlignedPhotoLayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.projectId != widget.projectId ||
        oldWidget.projectDirectory != widget.projectDirectory ||
        oldWidget.alignment.alignmentId != widget.alignment.alignmentId ||
        oldWidget.alignment.sourcePhoto.path !=
            widget.alignment.sourcePhoto.path ||
        oldWidget.alignment.sourcePhoto.sha256 !=
            widget.alignment.sourcePhoto.sha256 ||
        oldWidget.assetLoader != widget.assetLoader) {
      _refresh();
    }
  }

  void _refresh() {
    _asset = (widget.assetLoader ?? const LocalAlignedPhotoAssetLoader()).load(
      projectDirectory: widget.projectDirectory,
      relativePath: widget.alignment.sourcePhoto.path,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AlignedPhotoAsset>(
      future: _asset,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const AlignedPhotoUnavailableWarning();
        }
        final asset = snapshot.data;
        if (asset == null) {
          return const SizedBox.shrink();
        }
        final expectedSha256 = widget.alignment.sourcePhoto.sha256;
        if (expectedSha256 == null ||
            asset.sha256 != expectedSha256.toLowerCase()) {
          return const AlignedPhotoUnavailableWarning();
        }
        PhotoAlignmentSolution boundedSolution;
        try {
          boundedSolution = solvePhotoAlignment(
            transformType: widget.alignment.transformType,
            photoPoints: widget.alignment.photoPoints,
            boardPoints: widget.alignment.boardPoints,
            photoWidth: asset.width,
            photoHeight: asset.height,
          );
        } on PhotoAlignmentException {
          return const AlignedPhotoUnavailableWarning();
        }
        return AlignedPhotoLayer(
          asset: asset,
          solution: boundedSolution,
          opacity: widget.opacity,
          imageBuilder: widget.imageBuilder,
        );
      },
    );
  }
}

bool _isAbsolute(String path) => Platform.isWindows
    ? RegExp(r'^[A-Za-z]:[\\/]').hasMatch(path)
    : path.startsWith('/');

bool _containsDotSegment(String path) => path
    .replaceAll('\\', '/')
    .split('/')
    .any((segment) => segment == '.' || segment == '..');

bool _isContained(String root, String candidate) {
  final separator = Platform.pathSeparator;
  final normalizedRoot = root.endsWith(separator) ? root : '$root$separator';
  if (Platform.isWindows) {
    return candidate.toLowerCase().startsWith(normalizedRoot.toLowerCase());
  }
  return candidate.startsWith(normalizedRoot);
}
