import '../../../shared/models/trace_bench_event.dart';
import 'photo_alignment_transform.dart';

const Set<String> _photoModes = <String>{
  'normal',
  'backlight',
  'macro',
  'side_light',
};
const Set<String> _photoLayers = <String>{
  'top',
  'bottom',
  'side',
  'detail',
};
final RegExp _photoIdPattern = RegExp(r'^photo_[a-z0-9_]+$');
final RegExp _sha256Pattern = RegExp(r'^[0-9a-fA-F]{64}$');

class PhotoEventItem {
  const PhotoEventItem({
    required this.eventId,
    required this.sequence,
    required this.photoId,
    required this.mode,
    required this.path,
    this.sha256,
    this.layer,
  });

  final String eventId;
  final int sequence;
  final String photoId;
  final String mode;
  final String path;
  final String? sha256;
  final String? layer;
}

List<PhotoEventItem> photoEventItemsFromEvents(
  Iterable<TraceBenchEvent> events,
) {
  final items = <PhotoEventItem>[];
  for (final event in events) {
    if (event.schemaVersion != '1.0' ||
        event.eventType != 'photo_added' ||
        event.status != 'accepted') {
      continue;
    }

    final payload = event.payload;
    final photoId = payload['photo_id'];
    final mode = payload['mode'];
    final path = payload['path'];
    final sha256 = payload['sha256'];
    final layer = payload['layer'];
    if (photoId is! String ||
        !_photoIdPattern.hasMatch(photoId) ||
        mode is! String ||
        !_photoModes.contains(mode) ||
        path is! String ||
        !isSafePhotoRelativePath(path) ||
        (sha256 != null &&
            (sha256 is! String || !_sha256Pattern.hasMatch(sha256))) ||
        (layer != null &&
            (layer is! String || !_photoLayers.contains(layer)))) {
      continue;
    }

    items.add(
      PhotoEventItem(
        eventId: event.eventId,
        sequence: event.sequence,
        photoId: photoId,
        mode: mode,
        path: path,
        sha256: sha256 as String?,
        layer: layer as String?,
      ),
    );
  }
  return List<PhotoEventItem>.unmodifiable(items);
}

PhotoEventItem? primaryPhotoEventItemFromEvents(
  Iterable<TraceBenchEvent> events, {
  required String relativePath,
  required String sha256,
}) {
  if (!isSafePhotoRelativePath(relativePath) ||
      !_sha256Pattern.hasMatch(sha256)) {
    return null;
  }
  final normalizedSha256 = sha256.toLowerCase();
  PhotoEventItem? primary;
  for (final photo in photoEventItemsFromEvents(events)) {
    final photoSha256 = photo.sha256;
    if (photo.sequence <= 0 ||
        photo.path != relativePath ||
        photoSha256 == null ||
        photoSha256.toLowerCase() != normalizedSha256) {
      continue;
    }
    if (primary == null || photo.sequence < primary.sequence) {
      primary = photo;
    }
  }
  return primary;
}

final RegExp _alignmentIdPattern = RegExp(r'^ALN[0-9]+$');
const Set<String> _alignmentBoardSides = <String>{'top', 'bottom', 'unknown'};
const Set<String> _alignmentPayloadFields = <String>{
  'alignment_id',
  'source_photo_id',
  'board_side',
  'coordinate_space_from',
  'coordinate_space_to',
  'reference_points_photo',
  'reference_points_board',
  'transform_type',
  'alignment_quality_label',
  'notes',
};

class PhotoAlignmentEventItem {
  const PhotoAlignmentEventItem({
    required this.eventId,
    required this.sequence,
    required this.alignmentId,
    required this.sourcePhoto,
    required this.boardSide,
    required this.transformType,
    required this.photoPoints,
    required this.boardPoints,
    required this.solution,
  });

  final String eventId;
  final int sequence;
  final String alignmentId;
  final PhotoEventItem sourcePhoto;
  final String boardSide;
  final PhotoAlignmentTransformType transformType;
  final List<PhotoAlignmentPoint> photoPoints;
  final List<PhotoAlignmentPoint> boardPoints;
  final PhotoAlignmentSolution solution;
}

List<PhotoAlignmentEventItem> photoAlignmentEventItemsFromEvents(
  Iterable<TraceBenchEvent> events,
) {
  final photosById = <String, PhotoEventItem>{};
  final seenAlignmentIds = <String>{};
  final alignments = <PhotoAlignmentEventItem>[];
  for (final event in events) {
    if (event.schemaVersion != '1.0' || event.status != 'accepted') {
      continue;
    }
    if (event.eventType == 'photo_added') {
      final photoItems = photoEventItemsFromEvents(<TraceBenchEvent>[event]);
      if (photoItems.isNotEmpty) {
        photosById.putIfAbsent(
          photoItems.single.photoId,
          () => photoItems.single,
        );
      }
      continue;
    }
    if (event.eventType != 'photo_to_board_alignment_confirmed' ||
        event.actor['type'] != 'user') {
      continue;
    }

    final payload = event.payload;
    final alignmentId = payload['alignment_id'];
    final sourcePhotoId = payload['source_photo_id'];
    final boardSide = payload['board_side'];
    final transformType = PhotoAlignmentTransformType.fromCanonicalName(
      payload['transform_type'],
    );
    final qualityLabel = payload['alignment_quality_label'];
    final notes = payload['notes'];
    final sourcePhoto =
        sourcePhotoId is String ? photosById[sourcePhotoId] : null;
    if (alignmentId is! String ||
        !_alignmentIdPattern.hasMatch(alignmentId) ||
        !seenAlignmentIds.add(alignmentId) ||
        payload.keys.any((key) => !_alignmentPayloadFields.contains(key)) ||
        sourcePhoto == null ||
        sourcePhoto.sequence >= event.sequence ||
        boardSide is! String ||
        !_alignmentBoardSides.contains(boardSide) ||
        payload['coordinate_space_from'] != 'photo_local' ||
        payload['coordinate_space_to'] != 'board_normalized' ||
        transformType == null ||
        qualityLabel != 'manual_preview_confirmed' ||
        (notes != null && notes is! String)) {
      continue;
    }
    final photoPoints = _readAlignmentPoints(payload['reference_points_photo']);
    final boardPoints = _readAlignmentPoints(payload['reference_points_board']);
    if (photoPoints == null || boardPoints == null) {
      continue;
    }
    try {
      final solution = solvePhotoAlignment(
        transformType: transformType,
        photoPoints: photoPoints,
        boardPoints: boardPoints,
      );
      alignments.add(
        PhotoAlignmentEventItem(
          eventId: event.eventId,
          sequence: event.sequence,
          alignmentId: alignmentId,
          sourcePhoto: sourcePhoto,
          boardSide: boardSide,
          transformType: transformType,
          photoPoints: List<PhotoAlignmentPoint>.unmodifiable(photoPoints),
          boardPoints: List<PhotoAlignmentPoint>.unmodifiable(boardPoints),
          solution: solution,
        ),
      );
    } on PhotoAlignmentException {
      continue;
    }
  }
  return List<PhotoAlignmentEventItem>.unmodifiable(alignments);
}

PhotoAlignmentEventItem? latestPhotoAlignmentEventItem(
  Iterable<TraceBenchEvent> events,
) {
  PhotoAlignmentEventItem? latest;
  for (final alignment in photoAlignmentEventItemsFromEvents(events)) {
    if (latest == null || alignment.sequence > latest.sequence) {
      latest = alignment;
    }
  }
  return latest;
}

List<PhotoAlignmentEventItem> primaryPhotoAlignmentEventItemsFromEvents(
  Iterable<TraceBenchEvent> events, {
  required String relativePath,
  required String sha256,
  required double photoWidth,
  required double photoHeight,
}) {
  final eventList = events.toList(growable: false);
  final primary = primaryPhotoEventItemFromEvents(
    eventList,
    relativePath: relativePath,
    sha256: sha256,
  );
  if (primary == null) {
    return const <PhotoAlignmentEventItem>[];
  }

  final alignments = <PhotoAlignmentEventItem>[];
  for (final alignment in photoAlignmentEventItemsFromEvents(eventList)) {
    if (alignment.sourcePhoto.photoId != primary.photoId) {
      continue;
    }
    try {
      final boundedSolution = solvePhotoAlignment(
        transformType: alignment.transformType,
        photoPoints: alignment.photoPoints,
        boardPoints: alignment.boardPoints,
        photoWidth: photoWidth,
        photoHeight: photoHeight,
      );
      alignments.add(
        PhotoAlignmentEventItem(
          eventId: alignment.eventId,
          sequence: alignment.sequence,
          alignmentId: alignment.alignmentId,
          sourcePhoto: primary,
          boardSide: alignment.boardSide,
          transformType: alignment.transformType,
          photoPoints: alignment.photoPoints,
          boardPoints: alignment.boardPoints,
          solution: boundedSolution,
        ),
      );
    } on PhotoAlignmentException {
      continue;
    }
  }
  return List<PhotoAlignmentEventItem>.unmodifiable(alignments);
}

PhotoAlignmentEventItem? latestPrimaryPhotoAlignmentEventItem(
  Iterable<TraceBenchEvent> events, {
  required String relativePath,
  required String sha256,
  required double photoWidth,
  required double photoHeight,
}) {
  PhotoAlignmentEventItem? latest;
  for (final alignment in primaryPhotoAlignmentEventItemsFromEvents(
    events,
    relativePath: relativePath,
    sha256: sha256,
    photoWidth: photoWidth,
    photoHeight: photoHeight,
  )) {
    if (latest == null || alignment.sequence > latest.sequence) {
      latest = alignment;
    }
  }
  return latest;
}

List<PhotoAlignmentPoint>? _readAlignmentPoints(Object? value) {
  if (value is! List) {
    return null;
  }
  final points = <PhotoAlignmentPoint>[];
  for (final rawPoint in value) {
    if (rawPoint is! Map) {
      return null;
    }
    final x = rawPoint['x'];
    final y = rawPoint['y'];
    if (x is! num || y is! num) {
      return null;
    }
    points.add(PhotoAlignmentPoint(x: x.toDouble(), y: y.toDouble()));
  }
  return points;
}

bool isSafePhotoRelativePath(String path) {
  if (!path.startsWith('photos/') ||
      path.startsWith('/') ||
      path.contains(r'\')) {
    return false;
  }
  final segments = path.split('/');
  if (segments.length < 2 || segments.first != 'photos') {
    return false;
  }
  for (final segment in segments) {
    if (segment.isEmpty || segment == '.' || segment == '..') {
      return false;
    }
    if (segment.endsWith(' ') || segment.endsWith('.')) {
      return false;
    }
    for (final codeUnit in segment.codeUnits) {
      if (codeUnit < 32 || '<>:"\\|?*'.codeUnits.contains(codeUnit)) {
        return false;
      }
    }
  }
  final lower = segments.last.toLowerCase();
  return lower.endsWith('.jpg') ||
      lower.endsWith('.jpeg') ||
      lower.endsWith('.png') ||
      lower.endsWith('.webp');
}
