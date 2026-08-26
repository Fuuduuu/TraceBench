import '../../../shared/models/trace_bench_event.dart';

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
    required this.photoId,
    required this.mode,
    required this.path,
    this.sha256,
    this.layer,
  });

  final String eventId;
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
