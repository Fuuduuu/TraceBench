import 'dart:ui';

/// One noncanonical pointer transaction. Positions are normalized; threshold
/// distance is measured in global logical pixels. The caller converts a pointer
/// displacement using one current render transform, so frame-origin changes
/// cannot be mistaken for pointer movement. The caller supplies in-frame moves;
/// frame containment and candidate hit testing stay with the editor geometry.
class CandidateDragSession {
  CandidateDragSession({
    required this.pointerId,
    required this.draftKey,
    required Offset normalizedPosition,
    required Offset globalPosition,
    required this.dragThreshold,
  })  : assert(dragThreshold > 0 && dragThreshold.isFinite),
        initialPosition = normalizedPosition,
        position = normalizedPosition,
        downGlobalPosition = globalPosition,
        referencePointerPosition = globalPosition,
        dragging = false;

  const CandidateDragSession._({
    required this.pointerId,
    required this.draftKey,
    required this.initialPosition,
    required this.position,
    required this.downGlobalPosition,
    required this.referencePointerPosition,
    required this.dragThreshold,
    required this.dragging,
  });

  final int pointerId;
  final int draftKey;
  final Offset initialPosition;
  final Offset position;
  final Offset downGlobalPosition;
  final Offset referencePointerPosition;
  final double dragThreshold;
  final bool dragging;

  CandidateDragSession move({
    required int pointerId,
    required Offset globalPosition,
    required Offset referenceDelta,
    required Size referenceSize,
  }) {
    if (pointerId != this.pointerId ||
        !_finite(globalPosition) ||
        !_finite(referenceDelta) ||
        !referenceSize.width.isFinite ||
        !referenceSize.height.isFinite ||
        referenceSize.width <= 0 ||
        referenceSize.height <= 0 ||
        (!dragging &&
            (globalPosition - downGlobalPosition).distance < dragThreshold)) {
      return this;
    }
    return CandidateDragSession._(
      pointerId: pointerId,
      draftKey: draftKey,
      initialPosition: initialPosition,
      position: Offset(
        (position.dx + referenceDelta.dx / referenceSize.width).clamp(0.0, 1.0),
        (position.dy + referenceDelta.dy / referenceSize.height)
            .clamp(0.0, 1.0),
      ),
      downGlobalPosition: downGlobalPosition,
      referencePointerPosition: globalPosition,
      dragThreshold: dragThreshold,
      dragging: true,
    );
  }

  /// A cancelled, foreign-pointer or unchanged transaction has no edit to save.
  /// The caller retires this session on the owning pointer's end.
  Offset? positionToCommit({required int pointerId, bool cancelled = false}) =>
      pointerId == this.pointerId &&
              !cancelled &&
              dragging &&
              // Suppress arithmetic roundoff after returning to the start.
              (position - initialPosition).distance > 1e-12
          ? position
          : null;

  static bool _finite(Offset point) => point.dx.isFinite && point.dy.isFinite;
}
