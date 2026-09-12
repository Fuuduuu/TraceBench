import 'dart:math' as math;

const double photoAlignmentEpsilon = 1e-9;

enum PhotoAlignmentTransformType {
  similarity('similarity'),
  affine('affine');

  const PhotoAlignmentTransformType(this.canonicalName);

  final String canonicalName;

  static PhotoAlignmentTransformType? fromCanonicalName(Object? value) {
    for (final type in values) {
      if (value == type.canonicalName) {
        return type;
      }
    }
    return null;
  }
}

enum PhotoAlignmentFailureKind {
  pointCount,
  nonFinite,
  photoBounds,
  boardBounds,
  duplicatePhotoPoint,
  duplicateBoardPoint,
  photoSpread,
  boardSpread,
  affineRank,
  singularTransform,
}

class PhotoAlignmentException implements Exception {
  const PhotoAlignmentException(this.kind, this.message);

  final PhotoAlignmentFailureKind kind;
  final String message;

  @override
  String toString() => 'PhotoAlignmentException: $message';
}

class PhotoAlignmentPoint {
  const PhotoAlignmentPoint({required this.x, required this.y});

  final double x;
  final double y;

  Map<String, double> toJson() => <String, double>{'x': x, 'y': y};

  @override
  bool operator ==(Object other) =>
      other is PhotoAlignmentPoint && other.x == x && other.y == y;

  @override
  int get hashCode => Object.hash(x, y);
}

class PhotoAlignmentTransform {
  const PhotoAlignmentTransform({
    required this.m00,
    required this.m01,
    required this.m02,
    required this.m10,
    required this.m11,
    required this.m12,
  });

  final double m00;
  final double m01;
  final double m02;
  final double m10;
  final double m11;
  final double m12;

  double get determinant => (m00 * m11) - (m01 * m10);

  PhotoAlignmentPoint apply(PhotoAlignmentPoint point) => PhotoAlignmentPoint(
        x: (m00 * point.x) + (m01 * point.y) + m02,
        y: (m10 * point.x) + (m11 * point.y) + m12,
      );

  @override
  bool operator ==(Object other) =>
      other is PhotoAlignmentTransform &&
      other.m00 == m00 &&
      other.m01 == m01 &&
      other.m02 == m02 &&
      other.m10 == m10 &&
      other.m11 == m11 &&
      other.m12 == m12;

  @override
  int get hashCode => Object.hash(m00, m01, m02, m10, m11, m12);
}

class PhotoAlignmentSolution {
  const PhotoAlignmentSolution({
    required this.transformType,
    required this.transform,
    required this.rmsResidual,
    required this.maxResidual,
  });

  final PhotoAlignmentTransformType transformType;
  final PhotoAlignmentTransform transform;
  final double rmsResidual;
  final double maxResidual;

  bool get isReflected => transform.determinant < 0;
}

PhotoAlignmentSolution solvePhotoAlignment({
  required PhotoAlignmentTransformType transformType,
  required List<PhotoAlignmentPoint> photoPoints,
  required List<PhotoAlignmentPoint> boardPoints,
  double? photoWidth,
  double? photoHeight,
}) {
  final minimumPairs =
      transformType == PhotoAlignmentTransformType.similarity ? 2 : 3;
  if (photoPoints.length != boardPoints.length ||
      photoPoints.length < minimumPairs) {
    throw PhotoAlignmentException(
      PhotoAlignmentFailureKind.pointCount,
      '${transformType.canonicalName} requires at least $minimumPairs equal point pairs.',
    );
  }
  if ((photoWidth == null) != (photoHeight == null) ||
      (photoWidth != null &&
          (!photoWidth.isFinite ||
              !photoHeight!.isFinite ||
              photoWidth <= 0 ||
              photoHeight <= 0))) {
    throw const PhotoAlignmentException(
      PhotoAlignmentFailureKind.photoBounds,
      'Intrinsic photo dimensions must be finite and positive.',
    );
  }

  for (final point in photoPoints) {
    if (!point.x.isFinite || !point.y.isFinite) {
      throw const PhotoAlignmentException(
        PhotoAlignmentFailureKind.nonFinite,
        'Photo reference points must be finite.',
      );
    }
    if (point.x < 0 ||
        point.y < 0 ||
        (photoWidth != null && point.x > photoWidth) ||
        (photoHeight != null && point.y > photoHeight)) {
      throw const PhotoAlignmentException(
        PhotoAlignmentFailureKind.photoBounds,
        'Photo reference points must stay within intrinsic image bounds.',
      );
    }
  }
  for (final point in boardPoints) {
    if (!point.x.isFinite || !point.y.isFinite) {
      throw const PhotoAlignmentException(
        PhotoAlignmentFailureKind.nonFinite,
        'Board reference points must be finite.',
      );
    }
    if (point.x < 0 || point.x > 1 || point.y < 0 || point.y > 1) {
      throw const PhotoAlignmentException(
        PhotoAlignmentFailureKind.boardBounds,
        'Board reference points must stay within 0..1.',
      );
    }
  }

  final photoStats = _PointSetStats.from(photoPoints);
  final boardStats = _PointSetStats.from(boardPoints);
  if (photoStats.diagonal <= photoAlignmentEpsilon) {
    throw const PhotoAlignmentException(
      PhotoAlignmentFailureKind.photoSpread,
      'Photo reference points do not have sufficient spread.',
    );
  }
  if (boardStats.diagonal <= photoAlignmentEpsilon) {
    throw const PhotoAlignmentException(
      PhotoAlignmentFailureKind.boardSpread,
      'Board reference points do not have sufficient spread.',
    );
  }
  _rejectNearDuplicates(
    photoPoints,
    photoStats.diagonal,
    PhotoAlignmentFailureKind.duplicatePhotoPoint,
    'Photo reference points must be unique.',
  );
  _rejectNearDuplicates(
    boardPoints,
    boardStats.diagonal,
    PhotoAlignmentFailureKind.duplicateBoardPoint,
    'Board reference points must be unique.',
  );

  final transform = transformType == PhotoAlignmentTransformType.similarity
      ? _solveSimilarity(photoPoints, boardPoints, photoStats, boardStats)
      : _solveAffine(photoPoints, boardPoints, photoStats, boardStats);
  final values = <double>[
    transform.m00,
    transform.m01,
    transform.m02,
    transform.m10,
    transform.m11,
    transform.m12,
    transform.determinant,
  ];
  if (values.any((value) => !value.isFinite)) {
    throw const PhotoAlignmentException(
      PhotoAlignmentFailureKind.nonFinite,
      'Alignment transform contains a non-finite value.',
    );
  }

  var squaredResidualSum = 0.0;
  var maxResidual = 0.0;
  for (var index = 0; index < photoPoints.length; index++) {
    final actual = transform.apply(photoPoints[index]);
    final dx = actual.x - boardPoints[index].x;
    final dy = actual.y - boardPoints[index].y;
    final residual = math.sqrt((dx * dx) + (dy * dy));
    squaredResidualSum += residual * residual;
    maxResidual = math.max(maxResidual, residual);
  }
  final rmsResidual = math.sqrt(squaredResidualSum / photoPoints.length);
  if (!rmsResidual.isFinite || !maxResidual.isFinite) {
    throw const PhotoAlignmentException(
      PhotoAlignmentFailureKind.nonFinite,
      'Alignment residual contains a non-finite value.',
    );
  }
  return PhotoAlignmentSolution(
    transformType: transformType,
    transform: transform,
    rmsResidual: rmsResidual,
    maxResidual: maxResidual,
  );
}

PhotoAlignmentTransform _solveSimilarity(
  List<PhotoAlignmentPoint> source,
  List<PhotoAlignmentPoint> target,
  _PointSetStats sourceStats,
  _PointSetStats targetStats,
) {
  var denominator = 0.0;
  var dot = 0.0;
  var cross = 0.0;
  for (var index = 0; index < source.length; index++) {
    final sx = (source[index].x - sourceStats.meanX) / sourceStats.diagonal;
    final sy = (source[index].y - sourceStats.meanY) / sourceStats.diagonal;
    final tx = (target[index].x - targetStats.meanX) / targetStats.diagonal;
    final ty = (target[index].y - targetStats.meanY) / targetStats.diagonal;
    denominator += (sx * sx) + (sy * sy);
    dot += (sx * tx) + (sy * ty);
    cross += (sx * ty) - (sy * tx);
  }
  if (!denominator.isFinite || denominator <= photoAlignmentEpsilon) {
    throw const PhotoAlignmentException(
      PhotoAlignmentFailureKind.photoSpread,
      'Photo reference points do not define a similarity transform.',
    );
  }
  final normalizedA = dot / denominator;
  final normalizedB = cross / denominator;
  final normalizedScale = math.sqrt(
    (normalizedA * normalizedA) + (normalizedB * normalizedB),
  );
  if (!normalizedScale.isFinite || normalizedScale <= photoAlignmentEpsilon) {
    throw const PhotoAlignmentException(
      PhotoAlignmentFailureKind.singularTransform,
      'Similarity transform scale is singular or near-singular.',
    );
  }

  final ratio = targetStats.diagonal / sourceStats.diagonal;
  final m00 = ratio * normalizedA;
  final m01 = -ratio * normalizedB;
  final m10 = ratio * normalizedB;
  final m11 = ratio * normalizedA;
  return PhotoAlignmentTransform(
    m00: m00,
    m01: m01,
    m02: targetStats.meanX -
        (m00 * sourceStats.meanX) -
        (m01 * sourceStats.meanY),
    m10: m10,
    m11: m11,
    m12: targetStats.meanY -
        (m10 * sourceStats.meanX) -
        (m11 * sourceStats.meanY),
  );
}

PhotoAlignmentTransform _solveAffine(
  List<PhotoAlignmentPoint> source,
  List<PhotoAlignmentPoint> target,
  _PointSetStats sourceStats,
  _PointSetStats targetStats,
) {
  final normal = List<List<double>>.generate(
    3,
    (_) => List<double>.filled(3, 0),
  );
  final rhsX = List<double>.filled(3, 0);
  final rhsY = List<double>.filled(3, 0);
  for (var index = 0; index < source.length; index++) {
    final row = <double>[
      (source[index].x - sourceStats.meanX) / sourceStats.diagonal,
      (source[index].y - sourceStats.meanY) / sourceStats.diagonal,
      1,
    ];
    final tx = (target[index].x - targetStats.meanX) / targetStats.diagonal;
    final ty = (target[index].y - targetStats.meanY) / targetStats.diagonal;
    for (var r = 0; r < 3; r++) {
      rhsX[r] += row[r] * tx;
      rhsY[r] += row[r] * ty;
      for (var c = 0; c < 3; c++) {
        normal[r][c] += row[r] * row[c];
      }
    }
  }
  final coefficientsX = _solveLinear3(normal, rhsX);
  final coefficientsY = _solveLinear3(normal, rhsY);
  final normalizedDeterminant = (coefficientsX[0] * coefficientsY[1]) -
      (coefficientsX[1] * coefficientsY[0]);
  if (!normalizedDeterminant.isFinite ||
      normalizedDeterminant.abs() <= photoAlignmentEpsilon) {
    throw const PhotoAlignmentException(
      PhotoAlignmentFailureKind.singularTransform,
      'Affine transform is singular or near-singular.',
    );
  }

  final ratio = targetStats.diagonal / sourceStats.diagonal;
  final m00 = ratio * coefficientsX[0];
  final m01 = ratio * coefficientsX[1];
  final m10 = ratio * coefficientsY[0];
  final m11 = ratio * coefficientsY[1];
  return PhotoAlignmentTransform(
    m00: m00,
    m01: m01,
    m02: targetStats.meanX +
        (targetStats.diagonal * coefficientsX[2]) -
        (m00 * sourceStats.meanX) -
        (m01 * sourceStats.meanY),
    m10: m10,
    m11: m11,
    m12: targetStats.meanY +
        (targetStats.diagonal * coefficientsY[2]) -
        (m10 * sourceStats.meanX) -
        (m11 * sourceStats.meanY),
  );
}

List<double> _solveLinear3(List<List<double>> matrix, List<double> rhs) {
  final augmented = List<List<double>>.generate(
    3,
    (row) => <double>[...matrix[row], rhs[row]],
  );
  var scale = 0.0;
  for (final row in matrix) {
    for (final value in row) {
      scale = math.max(scale, value.abs());
    }
  }
  if (!scale.isFinite || scale <= photoAlignmentEpsilon) {
    throw const PhotoAlignmentException(
      PhotoAlignmentFailureKind.affineRank,
      'Affine source points are rank-deficient.',
    );
  }
  for (var column = 0; column < 3; column++) {
    var pivotRow = column;
    var pivotMagnitude = augmented[column][column].abs();
    for (var row = column + 1; row < 3; row++) {
      final candidate = augmented[row][column].abs();
      if (candidate > pivotMagnitude) {
        pivotMagnitude = candidate;
        pivotRow = row;
      }
    }
    if (!pivotMagnitude.isFinite ||
        pivotMagnitude <= photoAlignmentEpsilon * scale) {
      throw const PhotoAlignmentException(
        PhotoAlignmentFailureKind.affineRank,
        'Affine source points are collinear or near-collinear.',
      );
    }
    if (pivotRow != column) {
      final swap = augmented[column];
      augmented[column] = augmented[pivotRow];
      augmented[pivotRow] = swap;
    }
    final pivot = augmented[column][column];
    for (var c = column; c < 4; c++) {
      augmented[column][c] /= pivot;
    }
    for (var row = 0; row < 3; row++) {
      if (row == column) {
        continue;
      }
      final factor = augmented[row][column];
      for (var c = column; c < 4; c++) {
        augmented[row][c] -= factor * augmented[column][c];
      }
    }
  }
  final result = <double>[
    augmented[0][3],
    augmented[1][3],
    augmented[2][3],
  ];
  if (result.any((value) => !value.isFinite)) {
    throw const PhotoAlignmentException(
      PhotoAlignmentFailureKind.nonFinite,
      'Affine solve produced a non-finite coefficient.',
    );
  }
  return result;
}

void _rejectNearDuplicates(
  List<PhotoAlignmentPoint> points,
  double diagonal,
  PhotoAlignmentFailureKind kind,
  String message,
) {
  for (var left = 0; left < points.length; left++) {
    for (var right = left + 1; right < points.length; right++) {
      final dx = (points[left].x - points[right].x) / diagonal;
      final dy = (points[left].y - points[right].y) / diagonal;
      if (math.sqrt((dx * dx) + (dy * dy)) <= photoAlignmentEpsilon) {
        throw PhotoAlignmentException(kind, message);
      }
    }
  }
}

class _PointSetStats {
  const _PointSetStats({
    required this.meanX,
    required this.meanY,
    required this.diagonal,
  });

  final double meanX;
  final double meanY;
  final double diagonal;

  factory _PointSetStats.from(List<PhotoAlignmentPoint> points) {
    var minX = double.infinity;
    var minY = double.infinity;
    var maxX = double.negativeInfinity;
    var maxY = double.negativeInfinity;
    var sumX = 0.0;
    var sumY = 0.0;
    for (final point in points) {
      minX = math.min(minX, point.x);
      minY = math.min(minY, point.y);
      maxX = math.max(maxX, point.x);
      maxY = math.max(maxY, point.y);
      sumX += point.x;
      sumY += point.y;
    }
    final width = maxX - minX;
    final height = maxY - minY;
    return _PointSetStats(
      meanX: sumX / points.length,
      meanY: sumY / points.length,
      diagonal: math.sqrt((width * width) + (height * height)),
    );
  }
}
