import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:trace_bench_viewer/shared/geometry/wizard_candidate_geometry.dart';
import 'package:trace_bench_viewer/shared/models/wizard_intake.dart';

void main() {
  const shapes = <(WizardVisualCandidateShape, double, double)>[
    (WizardVisualCandidateShape.circle, 14, 21),
    (WizardVisualCandidateShape.square, 14, 21),
    (WizardVisualCandidateShape.rectangle, 25.2, 37.8),
    (WizardVisualCandidateShape.roundedRectangle, 30.8, 46.2),
  ];
  const frames = <(String, Rect, Offset)>[
    ('portrait', Rect.fromLTWH(30, 40, 200, 400), Offset(80, 340)),
    ('square', Rect.fromLTWH(30, 40, 300, 300), Offset(105, 265)),
    ('landscape', Rect.fromLTWH(30, 40, 600, 300), Offset(180, 265)),
  ];
  for (final (name, frame, center) in frames) {
    for (final (shape, portraitWidth, otherWidth) in shapes) {
      test('$name $shape keeps the authoring body and center', () {
        final geometry = WizardCandidateGeometry.resolve(
          referenceRect: frame,
          normalizedCenter: const Offset(0.25, 0.75),
          shape: shape,
          sizeScale: 2,
          rotationRadians: 0,
        );
        final width = name == 'portrait' ? portraitWidth : otherWidth;
        final height = name == 'portrait' ? 14.0 : 21.0;
        expect(geometry.center, center);
        expect(geometry.markerSize.width, closeTo(width, 1e-9));
        expect(geometry.markerSize.height, closeTo(height, 1e-9));
        expect(geometry.minorDimension, closeTo(height, 1e-9));
        expect(geometry.localPath.getBounds().left, closeTo(-width / 2, 1e-5));
        expect(geometry.localPath.getBounds().right, closeTo(width / 2, 1e-5));
        expect(geometry.localPath.getBounds().height, closeTo(height, 1e-5));
        expect(geometry.rotatedBounds.center, center);
        expect(geometry.rotatedBounds.width, closeTo(width, 1e-9));
        expect(geometry.rotatedBounds.height, closeTo(height, 1e-9));
        expect(
            geometry.hitBounds,
            Rect.fromCenter(
              center: center,
              width: 56,
              height: 56,
            ));
      });
    }
  }

  for (final (scale, minor) in <(double, double)>[
    (0.5, 8),
    (1, 8),
    (2, 14),
    (2.5, 17.5),
  ]) {
    test('portrait sizeScale $scale preserves floor and relative body size',
        () {
      final geometry = WizardCandidateGeometry.resolve(
        referenceRect: const Rect.fromLTWH(0, 0, 200, 400),
        normalizedCenter: const Offset(0.5, 0.5),
        shape: WizardVisualCandidateShape.square,
        sizeScale: scale,
        rotationRadians: 0,
      );
      expect(geometry.minorDimension, closeTo(minor, 1e-9));
      expect(geometry.markerSize.width, closeTo(minor, 1e-9));
      expect(geometry.markerSize.height, closeTo(minor, 1e-9));
      expect(geometry.hitBounds.size, const Size(56, 56));
      expect(geometry.localPath.contains(Offset(minor / 2 - 0.1, 0)), isTrue);
      expect(geometry.localPath.contains(Offset(minor / 2 + 0.1, 0)), isFalse);
    });
  }

  test('quarter turn swaps rectangular extents without moving center', () {
    final geometry = WizardCandidateGeometry.resolve(
      referenceRect: const Rect.fromLTWH(-20, 12, 1000, 500),
      normalizedCenter: const Offset(0.2, 0.4),
      shape: WizardVisualCandidateShape.rectangle,
      sizeScale: 2,
      rotationRadians: math.pi / 2,
    );
    expect(geometry.center, const Offset(180, 212));
    expect(geometry.markerSize.width, closeTo(63, 1e-9));
    expect(geometry.markerSize.height, closeTo(35, 1e-9));
    expect(geometry.effectiveRotation, math.pi / 2);
    expect(geometry.rotatedBounds.width, closeTo(35, 1e-9));
    expect(geometry.rotatedBounds.height, closeTo(63, 1e-9));
    expect(geometry.hitBounds.width, 56);
    expect(geometry.hitBounds.height, closeTo(63, 1e-9));
    expect(geometry.hitBounds.contains(const Offset(180, 242)), isTrue);
    expect(geometry.hitBounds.contains(const Offset(209, 212)), isFalse);
  });

  for (final sign in <double>[-1, 1]) {
    test('3-4-5 rotation sign $sign derives absolute rotated and hit bounds',
        () {
      final geometry = WizardCandidateGeometry.resolve(
        referenceRect: const Rect.fromLTWH(10, 20, 800, 400),
        normalizedCenter: const Offset(0.25, 0.75),
        shape: WizardVisualCandidateShape.rectangle,
        sizeScale: 2,
        rotationRadians: sign * math.atan2(3, 4),
      );
      expect(geometry.center, const Offset(210, 320));
      expect(geometry.effectiveRotation, sign * math.atan2(3, 4));
      expect(geometry.rotatedBounds.width, closeTo(57.12, 1e-9));
      expect(geometry.rotatedBounds.height, closeTo(52.64, 1e-9));
      expect(geometry.hitBounds.width, closeTo(57.12, 1e-9));
      expect(geometry.hitBounds.height, 56);
      expect(geometry.rotatedBounds.center, const Offset(210, 320));
    });
  }

  test('circle is rotation invariant while its input candidate remains intact',
      () {
    const candidate = WizardVisualCandidate(
      draftKey: 3,
      position: WizardPoint(x: 0.5, y: 0.5),
      shape: WizardVisualCandidateShape.circle,
      sizeScale: 2,
      rotationRadians: math.pi / 3,
    );
    final geometry = WizardCandidateGeometry.resolve(
      referenceRect: const Rect.fromLTWH(0, 0, 300, 300),
      normalizedCenter: const Offset(0.5, 0.5),
      shape: candidate.shape,
      sizeScale: candidate.sizeScale,
      rotationRadians: candidate.rotationRadians,
    );
    expect(geometry.effectiveRotation, 0);
    expect(geometry.rotatedBounds.size, const Size(21, 21));
    expect(geometry.localPath.contains(const Offset(9.45, 9.45)), isFalse);
    expect(geometry.localPath.contains(const Offset(10, 0)), isTrue);
    expect(candidate.rotationRadians, math.pi / 3);
    expect(candidate.sizeScale, 2);
  });

  test('rounded rectangle retains the 0.32 corner rather than square corners',
      () {
    final geometry = WizardCandidateGeometry.resolve(
      referenceRect: const Rect.fromLTWH(0, 0, 400, 400),
      normalizedCenter: const Offset(0.5, 0.5),
      shape: WizardVisualCandidateShape.roundedRectangle,
      sizeScale: 1,
      rotationRadians: 0,
    );
    expect(geometry.markerSize.width, closeTo(30.8, 1e-9));
    expect(geometry.markerSize.height, closeTo(14, 1e-9));
    expect(geometry.localPath.contains(const Offset(13.4, 5)), isTrue);
    expect(geometry.localPath.contains(const Offset(14.9, 6.5)), isFalse);
    expect(geometry.localPath.contains(const Offset(14.13, 5.73)), isFalse);
    expect(geometry.localPath.contains(const Offset(14.05, 5.65)), isTrue);
  });

  test('uniform refit doubles body size but does not redefine the hit minimum',
      () {
    final first = WizardCandidateGeometry.resolve(
      referenceRect: const Rect.fromLTWH(10, 20, 200, 400),
      normalizedCenter: const Offset(0.25, 0.75),
      shape: WizardVisualCandidateShape.rectangle,
      sizeScale: 2,
      rotationRadians: 0,
    );
    final second = WizardCandidateGeometry.resolve(
      referenceRect: const Rect.fromLTWH(130, -20, 400, 800),
      normalizedCenter: const Offset(0.25, 0.75),
      shape: WizardVisualCandidateShape.rectangle,
      sizeScale: 2,
      rotationRadians: 0,
    );
    expect(first.center, const Offset(60, 320));
    expect(second.center, const Offset(230, 580));
    expect(first.markerSize.width, closeTo(25.2, 1e-9));
    expect(second.markerSize.width, closeTo(50.4, 1e-9));
    expect(first.markerSize.height, closeTo(14, 1e-9));
    expect(second.markerSize.height, closeTo(28, 1e-9));
    expect(first.hitBounds.size, const Size(56, 56));
    expect(second.hitBounds.size, const Size(56, 56));
  });

  test(
      'display floor stays 8px across tiny fits rather than becoming persisted size',
      () {
    for (final frame in <Rect>[
      const Rect.fromLTWH(0, 0, 50, 100),
      const Rect.fromLTWH(80, -40, 100, 200),
    ]) {
      final geometry = WizardCandidateGeometry.resolve(
        referenceRect: frame,
        normalizedCenter: const Offset(0.5, 0.5),
        shape: WizardVisualCandidateShape.rectangle,
        sizeScale: 0.5,
        rotationRadians: 0,
      );
      expect(geometry.minorDimension, 8);
      expect(geometry.markerSize.width, closeTo(14.4, 1e-9));
      expect(geometry.hitBounds.size, const Size(56, 56));
    }
  });

  test('normalized edge centers include the full reference offset', () {
    for (final (position, expected) in <(Offset, Offset)>[
      (const Offset(0, 0), const Offset(-80, 60)),
      (const Offset(1, 1), const Offset(120, 460)),
      (const Offset(0, 1), const Offset(-80, 460)),
      (const Offset(1, 0), const Offset(120, 60)),
    ]) {
      final geometry = WizardCandidateGeometry.resolve(
        referenceRect: const Rect.fromLTWH(-80, 60, 200, 400),
        normalizedCenter: position,
        shape: WizardVisualCandidateShape.square,
        sizeScale: 2,
        rotationRadians: 0,
      );
      expect(geometry.center, expected);
      expect(geometry.rotatedBounds.center, expected);
      expect(geometry.hitBounds.center, expected);
    }
  });
}
