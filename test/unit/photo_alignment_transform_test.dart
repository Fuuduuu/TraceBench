import 'package:flutter_test/flutter_test.dart';
import 'package:trace_bench_viewer/features/photos/logic/photo_alignment_transform.dart';

PhotoAlignmentPoint _similarityTarget(PhotoAlignmentPoint point) {
  return PhotoAlignmentPoint(
    x: 0.8 - (0.0025 * point.y),
    y: 0.05 + (0.0025 * point.x),
  );
}

PhotoAlignmentPoint _affineTarget(PhotoAlignmentPoint point) {
  return PhotoAlignmentPoint(
    x: 0.08 + (0.0012 * point.x) + (0.00035 * point.y),
    y: 0.12 - (0.0002 * point.x) + (0.0009 * point.y),
  );
}

void _expectPointClose(
  PhotoAlignmentPoint actual,
  PhotoAlignmentPoint expected, {
  double tolerance = 1e-10,
}) {
  expect(actual.x, closeTo(expected.x, tolerance));
  expect(actual.y, closeTo(expected.y, tolerance));
}

void main() {
  const photoWidth = 400.0;
  const photoHeight = 300.0;

  group('similarity transform', () {
    test('solves exact two-pair rotation, positive scale, and translation', () {
      const photo = <PhotoAlignmentPoint>[
        PhotoAlignmentPoint(x: 20, y: 30),
        PhotoAlignmentPoint(x: 220, y: 30),
      ];
      final board = photo.map(_similarityTarget).toList(growable: false);

      final solution = solvePhotoAlignment(
        transformType: PhotoAlignmentTransformType.similarity,
        photoPoints: photo,
        boardPoints: board,
        photoWidth: photoWidth,
        photoHeight: photoHeight,
      );

      _expectPointClose(solution.transform.apply(photo.first), board.first);
      _expectPointClose(solution.transform.apply(photo.last), board.last);
      expect(solution.rmsResidual, lessThan(1e-12));
      expect(solution.maxResidual, lessThan(1e-12));
      expect(solution.isReflected, isFalse);
    });

    test('solves deterministic overdetermined pairs', () {
      const photo = <PhotoAlignmentPoint>[
        PhotoAlignmentPoint(x: 20, y: 30),
        PhotoAlignmentPoint(x: 220, y: 30),
        PhotoAlignmentPoint(x: 20, y: 230),
        PhotoAlignmentPoint(x: 220, y: 230),
      ];
      final board = photo.map(_similarityTarget).toList(growable: true);
      board[3] = PhotoAlignmentPoint(
        x: board[3].x + 0.0004,
        y: board[3].y - 0.0002,
      );

      final first = solvePhotoAlignment(
        transformType: PhotoAlignmentTransformType.similarity,
        photoPoints: photo,
        boardPoints: board,
        photoWidth: photoWidth,
        photoHeight: photoHeight,
      );
      const order = <int>[2, 0, 3, 1];
      final reordered = solvePhotoAlignment(
        transformType: PhotoAlignmentTransformType.similarity,
        photoPoints: order.map((index) => photo[index]).toList(growable: false),
        boardPoints: order.map((index) => board[index]).toList(growable: false),
        photoWidth: photoWidth,
        photoHeight: photoHeight,
      );

      expect(reordered.transform.m00, closeTo(first.transform.m00, 1e-14));
      expect(reordered.transform.m01, closeTo(first.transform.m01, 1e-14));
      expect(reordered.transform.m02, closeTo(first.transform.m02, 1e-14));
      expect(reordered.transform.m10, closeTo(first.transform.m10, 1e-14));
      expect(reordered.transform.m11, closeTo(first.transform.m11, 1e-14));
      expect(reordered.transform.m12, closeTo(first.transform.m12, 1e-14));
      expect(reordered.rmsResidual, closeTo(first.rmsResidual, 1e-14));
      expect(first.rmsResidual, greaterThan(0));
      expect(first.maxResidual, greaterThanOrEqualTo(first.rmsResidual));
    });
  });

  group('affine transform', () {
    test('solves exact three-pair affine transform including shear', () {
      const photo = <PhotoAlignmentPoint>[
        PhotoAlignmentPoint(x: 10, y: 20),
        PhotoAlignmentPoint(x: 310, y: 20),
        PhotoAlignmentPoint(x: 10, y: 220),
      ];
      final board = photo.map(_affineTarget).toList(growable: false);

      final solution = solvePhotoAlignment(
        transformType: PhotoAlignmentTransformType.affine,
        photoPoints: photo,
        boardPoints: board,
        photoWidth: photoWidth,
        photoHeight: photoHeight,
      );

      expect(solution.transform.m01.abs(), greaterThan(0));
      expect(solution.transform.m10.abs(), greaterThan(0));
      for (var index = 0; index < photo.length; index++) {
        _expectPointClose(solution.transform.apply(photo[index]), board[index]);
      }
      expect(solution.rmsResidual, lessThan(1e-12));
      expect(solution.isReflected, isFalse);
    });

    test('solves overdetermined affine pairs', () {
      const photo = <PhotoAlignmentPoint>[
        PhotoAlignmentPoint(x: 10, y: 20),
        PhotoAlignmentPoint(x: 310, y: 20),
        PhotoAlignmentPoint(x: 10, y: 220),
        PhotoAlignmentPoint(x: 310, y: 220),
        PhotoAlignmentPoint(x: 160, y: 120),
      ];
      final board = photo.map(_affineTarget).toList(growable: true);
      board[4] = PhotoAlignmentPoint(
        x: board[4].x - 0.0003,
        y: board[4].y + 0.0002,
      );

      final solution = solvePhotoAlignment(
        transformType: PhotoAlignmentTransformType.affine,
        photoPoints: photo,
        boardPoints: board,
        photoWidth: photoWidth,
        photoHeight: photoHeight,
      );

      expect(solution.rmsResidual, greaterThan(0));
      expect(solution.maxResidual, greaterThanOrEqualTo(solution.rmsResidual));
    });

    test('accepts reflection and reports the mirror warning condition', () {
      const photo = <PhotoAlignmentPoint>[
        PhotoAlignmentPoint(x: 0, y: 0),
        PhotoAlignmentPoint(x: 200, y: 0),
        PhotoAlignmentPoint(x: 0, y: 200),
      ];
      final board = photo
          .map(
            (point) => PhotoAlignmentPoint(
              x: 0.8 - (0.002 * point.x),
              y: 0.1 + (0.002 * point.y),
            ),
          )
          .toList(growable: false);

      final solution = solvePhotoAlignment(
        transformType: PhotoAlignmentTransformType.affine,
        photoPoints: photo,
        boardPoints: board,
        photoWidth: photoWidth,
        photoHeight: photoHeight,
      );

      expect(solution.transform.determinant, lessThan(0));
      expect(solution.isReflected, isTrue);
    });
  });

  group('degeneracy and bounds', () {
    test('rejects non-finite values and intrinsic photo-bound violations', () {
      for (final point in <PhotoAlignmentPoint>[
        const PhotoAlignmentPoint(x: double.nan, y: 10),
        const PhotoAlignmentPoint(x: double.infinity, y: 10),
        const PhotoAlignmentPoint(x: 401, y: 10),
      ]) {
        expect(
          () => solvePhotoAlignment(
            transformType: PhotoAlignmentTransformType.similarity,
            photoPoints: <PhotoAlignmentPoint>[
              point,
              const PhotoAlignmentPoint(x: 20, y: 20),
            ],
            boardPoints: const <PhotoAlignmentPoint>[
              PhotoAlignmentPoint(x: 0.1, y: 0.1),
              PhotoAlignmentPoint(x: 0.2, y: 0.2),
            ],
            photoWidth: photoWidth,
            photoHeight: photoHeight,
          ),
          throwsA(isA<PhotoAlignmentException>()),
        );
      }
    });

    test('rejects board-bound violations and mismatched point counts', () {
      expect(
        () => solvePhotoAlignment(
          transformType: PhotoAlignmentTransformType.similarity,
          photoPoints: const <PhotoAlignmentPoint>[
            PhotoAlignmentPoint(x: 0, y: 0),
            PhotoAlignmentPoint(x: 10, y: 10),
          ],
          boardPoints: const <PhotoAlignmentPoint>[
            PhotoAlignmentPoint(x: -0.1, y: 0),
            PhotoAlignmentPoint(x: 0.5, y: 0.5),
          ],
          photoWidth: photoWidth,
          photoHeight: photoHeight,
        ),
        throwsA(isA<PhotoAlignmentException>()),
      );
      expect(
        () => solvePhotoAlignment(
          transformType: PhotoAlignmentTransformType.similarity,
          photoPoints: const <PhotoAlignmentPoint>[
            PhotoAlignmentPoint(x: 0, y: 0),
            PhotoAlignmentPoint(x: 10, y: 10),
          ],
          boardPoints: const <PhotoAlignmentPoint>[
            PhotoAlignmentPoint(x: 0, y: 0),
          ],
        ),
        throwsA(isA<PhotoAlignmentException>()),
      );
    });

    test('rejects duplicate and zero-spread source or target points', () {
      final cases = <({
        List<PhotoAlignmentPoint> photo,
        List<PhotoAlignmentPoint> board
      })>[
        (
          photo: const <PhotoAlignmentPoint>[
            PhotoAlignmentPoint(x: 10, y: 10),
            PhotoAlignmentPoint(x: 10, y: 10),
          ],
          board: const <PhotoAlignmentPoint>[
            PhotoAlignmentPoint(x: 0.1, y: 0.1),
            PhotoAlignmentPoint(x: 0.2, y: 0.2),
          ],
        ),
        (
          photo: const <PhotoAlignmentPoint>[
            PhotoAlignmentPoint(x: 10, y: 10),
            PhotoAlignmentPoint(x: 20, y: 20),
          ],
          board: const <PhotoAlignmentPoint>[
            PhotoAlignmentPoint(x: 0.1, y: 0.1),
            PhotoAlignmentPoint(x: 0.1, y: 0.1),
          ],
        ),
      ];
      for (final value in cases) {
        expect(
          () => solvePhotoAlignment(
            transformType: PhotoAlignmentTransformType.similarity,
            photoPoints: value.photo,
            boardPoints: value.board,
            photoWidth: photoWidth,
            photoHeight: photoHeight,
          ),
          throwsA(isA<PhotoAlignmentException>()),
        );
      }
    });

    test('rejects collinear affine source and singular target mappings', () {
      final cases = <({
        List<PhotoAlignmentPoint> photo,
        List<PhotoAlignmentPoint> board
      })>[
        (
          photo: const <PhotoAlignmentPoint>[
            PhotoAlignmentPoint(x: 0, y: 0),
            PhotoAlignmentPoint(x: 100, y: 100),
            PhotoAlignmentPoint(x: 200, y: 200),
          ],
          board: const <PhotoAlignmentPoint>[
            PhotoAlignmentPoint(x: 0.1, y: 0.1),
            PhotoAlignmentPoint(x: 0.4, y: 0.2),
            PhotoAlignmentPoint(x: 0.8, y: 0.7),
          ],
        ),
        (
          photo: const <PhotoAlignmentPoint>[
            PhotoAlignmentPoint(x: 0, y: 0),
            PhotoAlignmentPoint(x: 200, y: 0),
            PhotoAlignmentPoint(x: 0, y: 200),
          ],
          board: const <PhotoAlignmentPoint>[
            PhotoAlignmentPoint(x: 0.1, y: 0.1),
            PhotoAlignmentPoint(x: 0.4, y: 0.4),
            PhotoAlignmentPoint(x: 0.7, y: 0.7),
          ],
        ),
      ];
      for (final value in cases) {
        expect(
          () => solvePhotoAlignment(
            transformType: PhotoAlignmentTransformType.affine,
            photoPoints: value.photo,
            boardPoints: value.board,
            photoWidth: photoWidth,
            photoHeight: photoHeight,
          ),
          throwsA(isA<PhotoAlignmentException>()),
        );
      }
    });

    test('rejects non-finite dimensions and near-degenerate geometry', () {
      expect(
        () => solvePhotoAlignment(
          transformType: PhotoAlignmentTransformType.similarity,
          photoPoints: const <PhotoAlignmentPoint>[
            PhotoAlignmentPoint(x: 0, y: 0),
            PhotoAlignmentPoint(x: 100, y: 0),
          ],
          boardPoints: const <PhotoAlignmentPoint>[
            PhotoAlignmentPoint(x: 0.1, y: 0.1),
            PhotoAlignmentPoint(x: 0.5, y: 0.1),
          ],
          photoWidth: double.nan,
          photoHeight: photoHeight,
        ),
        throwsA(isA<PhotoAlignmentException>()),
      );
      expect(
        () => solvePhotoAlignment(
          transformType: PhotoAlignmentTransformType.similarity,
          photoPoints: const <PhotoAlignmentPoint>[
            PhotoAlignmentPoint(x: 0, y: 0),
            PhotoAlignmentPoint(x: 0.0000000001, y: 0),
          ],
          boardPoints: const <PhotoAlignmentPoint>[
            PhotoAlignmentPoint(x: 0.1, y: 0.1),
            PhotoAlignmentPoint(x: 0.5, y: 0.1),
          ],
        ),
        throwsA(isA<PhotoAlignmentException>()),
      );
      expect(
        () => solvePhotoAlignment(
          transformType: PhotoAlignmentTransformType.affine,
          photoPoints: const <PhotoAlignmentPoint>[
            PhotoAlignmentPoint(x: 0, y: 0),
            PhotoAlignmentPoint(x: 200, y: 0),
            PhotoAlignmentPoint(x: 0, y: 200),
          ],
          boardPoints: const <PhotoAlignmentPoint>[
            PhotoAlignmentPoint(x: 0.1, y: 0.1),
            PhotoAlignmentPoint(x: 0.4, y: 0.4),
            PhotoAlignmentPoint(x: 0.7, y: 0.70000000001),
          ],
        ),
        throwsA(isA<PhotoAlignmentException>()),
      );
    });
  });
}
