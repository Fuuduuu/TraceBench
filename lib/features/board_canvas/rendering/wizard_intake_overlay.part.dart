part of '../screens/board_canvas_screen.dart';

@immutable
class _WizardIntakeFitTransform {
  const _WizardIntakeFitTransform._({
    required this.sourceBounds,
    required this.canvasSize,
    required this.padding,
    required this.scale,
    required this.offset,
    required this.referenceFrameAspectRatio,
  });

  factory _WizardIntakeFitTransform.fromContour({
    required List<WizardPoint> points,
    required Size canvasSize,
    required double referenceFrameAspectRatio,
  }) {
    var minX = points.first.x * referenceFrameAspectRatio;
    var maxX = minX;
    var minY = points.first.y;
    var maxY = points.first.y;
    for (final point in points.skip(1)) {
      final referenceX = point.x * referenceFrameAspectRatio;
      minX = math.min(minX, referenceX);
      maxX = math.max(maxX, referenceX);
      minY = math.min(minY, point.y);
      maxY = math.max(maxY, point.y);
    }

    final bounds = Rect.fromLTRB(minX, minY, maxX, maxY);
    final padding =
        (canvasSize.shortestSide * 0.03).clamp(16.0, 28.0).toDouble();
    final availableWidth = math.max(0.0, canvasSize.width - (2 * padding));
    final availableHeight = math.max(0.0, canvasSize.height - (2 * padding));
    final scaleX =
        bounds.width > 0 ? availableWidth / bounds.width : double.infinity;
    final scaleY =
        bounds.height > 0 ? availableHeight / bounds.height : double.infinity;
    var scale = math.min(scaleX, scaleY);
    if (!scale.isFinite) {
      scale = math.min(availableWidth, availableHeight);
    }
    if (!scale.isFinite || scale <= 0) {
      scale = 1.0;
    }
    final offset = Offset(
      (canvasSize.width / 2) - (bounds.center.dx * scale),
      (canvasSize.height / 2) - (bounds.center.dy * scale),
    );
    return _WizardIntakeFitTransform._(
      sourceBounds: bounds,
      canvasSize: canvasSize,
      padding: padding,
      scale: scale,
      offset: offset,
      referenceFrameAspectRatio: referenceFrameAspectRatio,
    );
  }

  final Rect sourceBounds;
  final Size canvasSize;
  final double padding;
  final double scale;
  final Offset offset;
  final double referenceFrameAspectRatio;

  Offset mapPoint(WizardPoint point) {
    return Offset(
      offset.dx + (point.x * referenceFrameAspectRatio * scale),
      offset.dy + (point.y * scale),
    );
  }

  Rect get renderedContourBounds => Rect.fromLTRB(
        offset.dx + (sourceBounds.left * scale),
        offset.dy + (sourceBounds.top * scale),
        offset.dx + (sourceBounds.right * scale),
        offset.dy + (sourceBounds.bottom * scale),
      );

  Rect get normalizedCanvasRect => Rect.fromLTWH(
        offset.dx,
        offset.dy,
        referenceFrameAspectRatio * scale,
        scale,
      );
}

class _WizardIntakePhotoLayer extends StatelessWidget {
  const _WizardIntakePhotoLayer({
    super.key,
    required this.photoFile,
    required this.photoTransform,
    required this.fitTransform,
  });

  final File photoFile;
  final WizardPhotoTransform photoTransform;
  final _WizardIntakeFitTransform fitTransform;

  Offset get photoTranslation => Offset(
        photoTransform.translation.x,
        photoTransform.translation.y,
      );
  double get photoScale => photoTransform.scale;
  double get photoRotationRadians => photoTransform.rotationRadians;
  double get photoOpacity => photoTransform.opacity;

  @override
  Widget build(BuildContext context) {
    final normalizedCanvasRect = fitTransform.normalizedCanvasRect;
    final pixelTranslation = Offset(
      photoTransform.translation.x * normalizedCanvasRect.width,
      photoTransform.translation.y * normalizedCanvasRect.height,
    );
    return IgnorePointer(
      child: ClipRect(
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            Positioned.fromRect(
              rect: normalizedCanvasRect,
              child: ClipRect(
                child: Transform.translate(
                  key: const Key(
                    'board_canvas_wizard_photo_translation_layer',
                  ),
                  offset: pixelTranslation,
                  child: Transform.rotate(
                    key: const Key(
                      'board_canvas_wizard_photo_rotation_layer',
                    ),
                    angle: photoTransform.rotationRadians,
                    child: Transform.scale(
                      key: const Key(
                        'board_canvas_wizard_photo_scale_layer',
                      ),
                      scale: photoTransform.scale,
                      child: Opacity(
                        key: const Key(
                          'board_canvas_wizard_photo_opacity_layer',
                        ),
                        opacity: photoTransform.opacity,
                        child: Image.file(
                          photoFile,
                          key: const Key('board_canvas_wizard_photo_image'),
                          fit: BoxFit.contain,
                          filterQuality: FilterQuality.medium,
                          errorBuilder: (context, error, stackTrace) {
                            return const ColoredBox(
                              key: Key(
                                'board_canvas_wizard_photo_render_unavailable',
                              ),
                              color: BoardCanvasPalette.paper,
                              child: Center(
                                child: Text(
                                  'Taustafotot ei saanud kuvada',
                                  style: TextStyle(
                                    color: BoardCanvasPalette.muted,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WizardIntakePainter extends CustomPainter {
  const _WizardIntakePainter({
    required this.intake,
    required this.fitTransform,
  });

  final WizardIntake intake;
  final _WizardIntakeFitTransform fitTransform;

  String get coordinateSpace => intake.coordinateSpace;
  bool get contourClosed => intake.contour.closed;
  int get candidateCount => intake.visualCandidates.length;
  bool get readOnly => true;
  _WizardIntakeFitTransform get contourTransform => fitTransform;
  _WizardIntakeFitTransform get candidateTransform => fitTransform;
  List<Offset> get candidateCenters => intake.visualCandidates
      .map((candidate) => fitTransform.mapPoint(candidate.position))
      .toList(growable: false);

  @override
  void paint(Canvas canvas, Size size) {
    final contourPoints = intake.contour.points;
    if (intake.contour.closed && contourPoints.length >= 3) {
      final first = fitTransform.mapPoint(contourPoints.first);
      final path = Path()..moveTo(first.dx, first.dy);
      for (final point in contourPoints.skip(1)) {
        final renderedPoint = fitTransform.mapPoint(point);
        path.lineTo(renderedPoint.dx, renderedPoint.dy);
      }
      path.close();
      canvas.drawPath(
        path,
        Paint()
          ..color = BoardCanvasPalette.signal.withValues(alpha: 0.08)
          ..style = PaintingStyle.fill,
      );
      canvas.drawPath(
        path,
        Paint()
          ..color = BoardCanvasPalette.signal.withValues(alpha: 0.84)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2
          ..strokeJoin = StrokeJoin.round,
      );
    }

    for (final candidate in intake.visualCandidates) {
      _paintCandidate(canvas, candidate);
    }
  }

  void _paintCandidate(
    Canvas canvas,
    WizardVisualCandidate candidate,
  ) {
    final center = fitTransform.mapPoint(candidate.position);
    final minorDimension = math.max(
      8.0,
      fitTransform.scale * 0.035 * candidate.sizeScale,
    );
    final aspectRatio = switch (candidate.shape) {
      WizardVisualCandidateShape.circle => 1.0,
      WizardVisualCandidateShape.square => 1.0,
      WizardVisualCandidateShape.rectangle => 1.8,
      WizardVisualCandidateShape.roundedRectangle => 2.2,
    };
    final markerRect = Rect.fromCenter(
      center: Offset.zero,
      width: minorDimension * aspectRatio,
      height: minorDimension,
    );
    final markerPath = switch (candidate.shape) {
      WizardVisualCandidateShape.circle => Path()..addOval(markerRect),
      WizardVisualCandidateShape.square ||
      WizardVisualCandidateShape.rectangle =>
        Path()..addRect(markerRect),
      WizardVisualCandidateShape.roundedRectangle => Path()
        ..addRRect(
          RRect.fromRectAndRadius(
            markerRect,
            Radius.circular(minorDimension * 0.32),
          ),
        ),
    };
    final rotation = candidate.shape == WizardVisualCandidateShape.circle
        ? 0.0
        : candidate.rotationRadians;
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation);
    canvas.drawPath(
      markerPath,
      Paint()
        ..color = BoardCanvasPalette.navy.withValues(alpha: 0.94)
        ..style = PaintingStyle.fill,
    );
    canvas.drawPath(
      markerPath,
      Paint()
        ..color = BoardCanvasPalette.signal
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.6
        ..strokeJoin = StrokeJoin.round,
    );
    final markerArm = math.max(2.0, minorDimension * 0.28);
    final markerPaint = Paint()
      ..color = BoardCanvasPalette.signalTint
      ..strokeWidth = math.max(1.2, minorDimension * 0.1)
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(-markerArm, 0),
      Offset(markerArm, 0),
      markerPaint,
    );
    canvas.drawLine(
      Offset(0, -markerArm),
      Offset(0, markerArm),
      markerPaint,
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _WizardIntakePainter oldDelegate) {
    return !identical(intake, oldDelegate.intake) ||
        fitTransform.canvasSize != oldDelegate.fitTransform.canvasSize ||
        fitTransform.sourceBounds != oldDelegate.fitTransform.sourceBounds ||
        fitTransform.padding != oldDelegate.fitTransform.padding ||
        fitTransform.referenceFrameAspectRatio !=
            oldDelegate.fitTransform.referenceFrameAspectRatio;
  }
}
