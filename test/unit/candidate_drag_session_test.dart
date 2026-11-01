import 'dart:ui' show Size;

import 'package:flutter_test/flutter_test.dart';
import 'package:trace_bench_viewer/features/component_candidates/logic/candidate_drag_session.dart';

void main() {
  CandidateDragSession start({Offset position = const Offset(.5, .5)}) =>
      CandidateDragSession(
        pointerId: 7,
        draftKey: 19,
        normalizedPosition: position,
        globalPosition: const Offset(110, 105),
        dragThreshold: 18,
      );

  test('click or wobble cannot turn frame reflow into a committed position',
      () {
    final original = start();
    final next = original.move(
      pointerId: 7,
      globalPosition: const Offset(113, 107),
      referenceDelta: const Offset(3, 2),
      referenceSize: const Size(300, 300),
    );
    expect(next, same(original));
    expect(next.positionToCommit(pointerId: 7), isNull);
  });

  test('threshold is global logical distance, independent of frame scale', () {
    final next = start().move(
      pointerId: 7,
      globalPosition: const Offset(128, 105),
      referenceDelta: const Offset(9, 0),
      referenceSize: const Size(300, 150),
    );
    expect(next.position, const Offset(.53, .5));
    expect(next.positionToCommit(pointerId: 7), const Offset(.53, .5));
  });

  test('drag translates original center rather than snapping to the pointer',
      () {
    final next = start().move(
      pointerId: 7,
      globalPosition: const Offset(140, 120),
      referenceDelta: const Offset(30, 15),
      referenceSize: const Size(600, 300),
    );
    expect(next.position, const Offset(.55, .55));
    expect(next.initialPosition, const Offset(.5, .5));
    expect(next.referencePointerPosition, const Offset(140, 120));
  });

  test('frame resize changes only the scale of subsequent displacement', () {
    var next = start().move(
      pointerId: 7,
      globalPosition: const Offset(140, 120),
      referenceDelta: const Offset(30, 15),
      referenceSize: const Size(300, 150),
    );
    expect(next.position, const Offset(.6, .6));
    next = next.move(
      pointerId: 7,
      globalPosition: const Offset(170, 135),
      referenceDelta: const Offset(30, 15),
      referenceSize: const Size(150, 300),
    );
    expect(next.position.dx, closeTo(.8, 1e-12));
    expect(next.position.dy, closeTo(.65, 1e-12));
  });

  test('foreign pointer cannot move or complete the active transaction', () {
    final original = start();
    expect(
        original.move(
          pointerId: 8,
          globalPosition: const Offset(170, 135),
          referenceDelta: const Offset(60, 30),
          referenceSize: const Size(600, 300),
        ),
        same(original));
    expect(original.positionToCommit(pointerId: 8), isNull);
    final moved = original.move(
      pointerId: 7,
      globalPosition: const Offset(170, 135),
      referenceDelta: const Offset(60, 30),
      referenceSize: const Size(600, 300),
    );
    expect(moved.positionToCommit(pointerId: 8), isNull);
    expect(moved.positionToCommit(pointerId: 7, cancelled: true), isNull);
    expect(moved.positionToCommit(pointerId: 7), const Offset(.6, .6));
  });

  test('returning to the original center produces no completed edit', () {
    final moved = start(position: const Offset(.3, .4)).move(
      pointerId: 7,
      globalPosition: const Offset(170, 135),
      referenceDelta: const Offset(60, 30),
      referenceSize: const Size(600, 300),
    );
    final returned = moved.move(
      pointerId: 7,
      globalPosition: const Offset(110, 105),
      referenceDelta: const Offset(-60, -30),
      referenceSize: const Size(600, 300),
    );
    expect(returned.positionToCommit(pointerId: 7), isNull);
  });

  test('clamping does not accumulate hidden overshoot before reversing', () {
    final edge = start(position: const Offset(.99, .5)).move(
      pointerId: 7,
      globalPosition: const Offset(170, 105),
      referenceDelta: const Offset(60, 0),
      referenceSize: const Size(600, 300),
    );
    expect(edge.position, const Offset(1, .5));
    final reversed = edge.move(
      pointerId: 7,
      globalPosition: const Offset(140, 105),
      referenceDelta: const Offset(-30, 0),
      referenceSize: const Size(600, 300),
    );
    expect(reversed.position, const Offset(.95, .5));
  });

  for (final size in [
    Size.zero,
    const Size(double.nan, 300),
    const Size(300, double.infinity)
  ]) {
    test('unusable frame $size cannot corrupt or advance the transaction', () {
      final original = start();
      expect(
          original.move(
              pointerId: 7,
              globalPosition: const Offset(170, 135),
              referenceDelta: const Offset(60, 30),
              referenceSize: size),
          same(original));
    });
  }

  test('nonfinite pointer coordinates and displacement are ignored', () {
    final original = start();
    for (final value in [double.nan, double.infinity]) {
      expect(
          original.move(
              pointerId: 7,
              globalPosition: Offset(value, 105),
              referenceDelta: const Offset(60, 30),
              referenceSize: const Size(600, 300)),
          same(original));
      expect(
          original.move(
              pointerId: 7,
              globalPosition: const Offset(170, 135),
              referenceDelta: Offset(60, value),
              referenceSize: const Size(600, 300)),
          same(original));
    }
  });
}
