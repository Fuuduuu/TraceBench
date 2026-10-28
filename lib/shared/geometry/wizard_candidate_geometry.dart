import 'dart:math' as math;
import 'dart:ui';

import '../models/wizard_intake.dart';

/// Display geometry for a noncanonical Wizard candidate in a reference frame.
/// Body and hit-target minima are display affordances, not persisted sizes.
class WizardCandidateGeometry {
  const WizardCandidateGeometry._({
    required this.center,
    required this.minorDimension,
    required this.markerSize,
    required this.effectiveRotation,
    required this.localPath,
    required this.rotatedBounds,
    required this.hitBounds,
  });

  factory WizardCandidateGeometry.resolve({
    required Rect referenceRect,
    required Offset normalizedCenter,
    required WizardVisualCandidateShape shape,
    required double sizeScale,
    required double rotationRadians,
  }) {
    final shortestSide = referenceRect.size.shortestSide;
    final relativeMinor =
        shortestSide.isFinite ? shortestSide * 0.035 * sizeScale : 0.0;
    final minorDimension = math.max(8.0, relativeMinor);
    final aspectRatio = switch (shape) {
      WizardVisualCandidateShape.circle => 1.0,
      WizardVisualCandidateShape.square => 1.0,
      WizardVisualCandidateShape.rectangle => 1.8,
      WizardVisualCandidateShape.roundedRectangle => 2.2,
    };
    final markerSize = Size(minorDimension * aspectRatio, minorDimension);
    final localRect = Rect.fromCenter(
      center: Offset.zero,
      width: markerSize.width,
      height: markerSize.height,
    );
    final localPath = switch (shape) {
      WizardVisualCandidateShape.circle => Path()..addOval(localRect),
      WizardVisualCandidateShape.square ||
      WizardVisualCandidateShape.rectangle =>
        Path()..addRect(localRect),
      WizardVisualCandidateShape.roundedRectangle => Path()
        ..addRRect(
          RRect.fromRectAndRadius(
            localRect,
            Radius.circular(minorDimension * 0.32),
          ),
        ),
    };
    final effectiveRotation =
        shape == WizardVisualCandidateShape.circle ? 0.0 : rotationRadians;
    final cosine = math.cos(effectiveRotation).abs();
    final sine = math.sin(effectiveRotation).abs();
    final rotatedWidth = markerSize.width * cosine + markerSize.height * sine;
    final rotatedHeight = markerSize.width * sine + markerSize.height * cosine;
    final center = Offset(
      referenceRect.left + normalizedCenter.dx * referenceRect.width,
      referenceRect.top + normalizedCenter.dy * referenceRect.height,
    );
    return WizardCandidateGeometry._(
      center: center,
      minorDimension: minorDimension,
      markerSize: markerSize,
      effectiveRotation: effectiveRotation,
      localPath: localPath,
      rotatedBounds: Rect.fromCenter(
        center: center,
        width: rotatedWidth,
        height: rotatedHeight,
      ),
      hitBounds: Rect.fromCenter(
        center: center,
        width: math.max(56.0, rotatedWidth),
        height: math.max(56.0, rotatedHeight),
      ),
    );
  }

  final Offset center;
  final double minorDimension;
  final Size markerSize;
  final double effectiveRotation;
  final Path localPath;
  final Rect rotatedBounds;
  final Rect hitBounds;
}
