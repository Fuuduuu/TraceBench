import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';

@immutable
class WizardIntake {
  WizardIntake({
    required this.schemaVersion,
    required this.coordinateSpace,
    required this.problemDescription,
    required this.contour,
    required this.backgroundPhoto,
    required Iterable<WizardVisualCandidate> visualCandidates,
  }) : visualCandidates = List<WizardVisualCandidate>.unmodifiable(
          visualCandidates,
        );

  factory WizardIntake.fromJson(Map<String, dynamic> json) {
    return _WizardIntakeParser.parse(json);
  }

  final String schemaVersion;
  final String coordinateSpace;
  final WizardProblemDescription problemDescription;
  final WizardContour contour;
  final WizardBackgroundPhoto? backgroundPhoto;
  final List<WizardVisualCandidate> visualCandidates;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'schema_version': schemaVersion,
        'coordinate_space': coordinateSpace,
        'problem_description': <String, dynamic>{
          'description': problemDescription.description,
          'occurrence': switch (problemDescription.occurrence) {
            WizardProblemOccurrence.unknown => 'unknown',
            WizardProblemOccurrence.continuous => 'continuous',
            WizardProblemOccurrence.intermittent => 'intermittent',
          },
          'when_occurs': problemDescription.whenOccurs,
          'symptoms': problemDescription.symptoms,
          'attempts': problemDescription.attempts,
        },
        'contour': <String, dynamic>{
          'closed': contour.closed,
          'points': <Map<String, dynamic>>[
            for (final point in contour.points)
              <String, dynamic>{'x': point.x, 'y': point.y},
          ],
        },
        'background_photo': switch (backgroundPhoto) {
          null => null,
          final photo => <String, dynamic>{
              'relative_path': photo.relativePath,
              'transform': <String, dynamic>{
                'translation': <String, dynamic>{
                  'x': photo.transform.translation.x,
                  'y': photo.transform.translation.y,
                },
                'scale': photo.transform.scale,
                'rotation_radians': photo.transform.rotationRadians,
                'opacity': photo.transform.opacity,
              },
            },
        },
        'visual_candidates': <Map<String, dynamic>>[
          for (final candidate in visualCandidates)
            <String, dynamic>{
              'draft_key': candidate.draftKey,
              'position': <String, dynamic>{
                'x': candidate.position.x,
                'y': candidate.position.y,
              },
              'shape': switch (candidate.shape) {
                WizardVisualCandidateShape.circle => 'circle',
                WizardVisualCandidateShape.square => 'square',
                WizardVisualCandidateShape.rectangle => 'rectangle',
                WizardVisualCandidateShape.roundedRectangle =>
                  'rounded_rectangle',
              },
              'size_scale': candidate.sizeScale,
              'rotation_radians': candidate.rotationRadians,
            },
        ],
      };

  String toJsonString() =>
      '${const JsonEncoder.withIndent('  ').convert(toJson())}\n';
}

enum WizardProblemOccurrence {
  unknown,
  continuous,
  intermittent,
}

@immutable
class WizardProblemDescription {
  const WizardProblemDescription({
    required this.description,
    required this.occurrence,
    required this.whenOccurs,
    required this.symptoms,
    required this.attempts,
  });

  final String description;
  final WizardProblemOccurrence occurrence;
  final String whenOccurs;
  final String symptoms;
  final String attempts;
}

@immutable
class WizardContour {
  WizardContour({
    required this.closed,
    required Iterable<WizardPoint> points,
  }) : points = List<WizardPoint>.unmodifiable(points);

  final bool closed;
  final List<WizardPoint> points;
}

@immutable
class WizardPoint {
  const WizardPoint({
    required this.x,
    required this.y,
  });

  final double x;
  final double y;
}

@immutable
class WizardBackgroundPhoto {
  const WizardBackgroundPhoto({
    required this.relativePath,
    required this.transform,
  });

  final String relativePath;
  final WizardPhotoTransform transform;
}

@immutable
class WizardPhotoTransform {
  const WizardPhotoTransform({
    required this.translation,
    required this.scale,
    required this.rotationRadians,
    required this.opacity,
  });

  final WizardPoint translation;
  final double scale;
  final double rotationRadians;
  final double opacity;
}

enum WizardVisualCandidateShape {
  circle,
  square,
  rectangle,
  roundedRectangle,
}

@immutable
class WizardVisualCandidate {
  const WizardVisualCandidate({
    required this.draftKey,
    required this.position,
    required this.shape,
    required this.sizeScale,
    required this.rotationRadians,
  });

  final int draftKey;
  final WizardPoint position;
  final WizardVisualCandidateShape shape;
  final double sizeScale;
  final double rotationRadians;
}

@immutable
class WizardIntakeFormatException implements Exception {
  const WizardIntakeFormatException(this.path, this.reason);

  final String path;
  final String reason;

  @override
  String toString() => 'WizardIntakeFormatException: $path: $reason';
}

abstract final class _WizardIntakeParser {
  static WizardIntake parse(Map<String, dynamic> json) {
    final schemaVersion = _requiredString(
      json,
      'schema_version',
      r'$.schema_version',
    );
    if (schemaVersion != '1.0') {
      _fail(r'$.schema_version', 'unsupported value');
    }

    final coordinateSpace = _requiredString(
      json,
      'coordinate_space',
      r'$.coordinate_space',
    );
    if (coordinateSpace != 'wizard_normalized') {
      _fail(r'$.coordinate_space', 'unsupported value');
    }

    final problemDescription = _parseProblemDescription(
      _requiredObject(
        json,
        'problem_description',
        r'$.problem_description',
      ),
    );
    final contour = _parseContour(
      _requiredObject(json, 'contour', r'$.contour'),
    );
    final backgroundPhoto = _parseBackgroundPhoto(json);
    final visualCandidates = _parseVisualCandidates(
      _requiredList(json, 'visual_candidates', r'$.visual_candidates'),
    );

    return WizardIntake(
      schemaVersion: schemaVersion,
      coordinateSpace: coordinateSpace,
      problemDescription: problemDescription,
      contour: contour,
      backgroundPhoto: backgroundPhoto,
      visualCandidates: visualCandidates,
    );
  }

  static WizardProblemDescription _parseProblemDescription(
    Map<String, dynamic> json,
  ) {
    const path = r'$.problem_description';
    final description = _requiredString(
      json,
      'description',
      '$path.description',
    );
    if (description.trim().isEmpty) {
      _fail('$path.description', 'must not be blank');
    }

    final occurrenceRaw = _requiredString(
      json,
      'occurrence',
      '$path.occurrence',
    );
    final occurrence = switch (occurrenceRaw) {
      'unknown' => WizardProblemOccurrence.unknown,
      'continuous' => WizardProblemOccurrence.continuous,
      'intermittent' => WizardProblemOccurrence.intermittent,
      _ => _fail('$path.occurrence', 'unsupported value'),
    };

    return WizardProblemDescription(
      description: description,
      occurrence: occurrence,
      whenOccurs: _requiredString(
        json,
        'when_occurs',
        '$path.when_occurs',
      ),
      symptoms: _requiredString(json, 'symptoms', '$path.symptoms'),
      attempts: _requiredString(json, 'attempts', '$path.attempts'),
    );
  }

  static WizardContour _parseContour(Map<String, dynamic> json) {
    const path = r'$.contour';
    final closed = _requiredValue(json, 'closed', '$path.closed');
    if (closed is! bool || !closed) {
      _fail('$path.closed', 'must be true');
    }

    final pointsRaw = _requiredList(json, 'points', '$path.points');
    if (pointsRaw.length < 3) {
      _fail('$path.points', 'must contain at least three points');
    }

    final points = <WizardPoint>[];
    for (var index = 0; index < pointsRaw.length; index += 1) {
      final pointPath = '$path.points[$index]';
      final pointJson = _objectValue(pointsRaw[index], pointPath);
      points.add(_parseNormalizedPoint(pointJson, pointPath));
    }

    return WizardContour(closed: true, points: points);
  }

  static WizardBackgroundPhoto? _parseBackgroundPhoto(
    Map<String, dynamic> json,
  ) {
    const path = r'$.background_photo';
    if (!json.containsKey('background_photo') ||
        json['background_photo'] == null) {
      return null;
    }

    final photoJson = _objectValue(json['background_photo'], path);
    final relativePath = _requiredString(
      photoJson,
      'relative_path',
      '$path.relative_path',
    );
    if (!_isSafePhotoPath(relativePath)) {
      _fail('$path.relative_path', 'must be a safe project photo path');
    }

    final transformJson = _requiredObject(
      photoJson,
      'transform',
      '$path.transform',
    );
    final translationJson = _requiredObject(
      transformJson,
      'translation',
      '$path.transform.translation',
    );
    final translation = WizardPoint(
      x: _requiredFiniteNumber(
        translationJson,
        'x',
        '$path.transform.translation.x',
      ),
      y: _requiredFiniteNumber(
        translationJson,
        'y',
        '$path.transform.translation.y',
      ),
    );
    final scale = _requiredRangedNumber(
      transformJson,
      'scale',
      '$path.transform.scale',
      minimum: 0.25,
      maximum: 8.0,
    );
    final rotationRadians = _requiredRangedNumber(
      transformJson,
      'rotation_radians',
      '$path.transform.rotation_radians',
      minimum: -math.pi,
      maximum: math.pi,
    );
    final opacity = _requiredRangedNumber(
      transformJson,
      'opacity',
      '$path.transform.opacity',
      minimum: 0.0,
      maximum: 1.0,
    );

    return WizardBackgroundPhoto(
      relativePath: relativePath,
      transform: WizardPhotoTransform(
        translation: translation,
        scale: scale,
        rotationRadians: rotationRadians,
        opacity: opacity,
      ),
    );
  }

  static List<WizardVisualCandidate> _parseVisualCandidates(
    List<dynamic> candidatesRaw,
  ) {
    const path = r'$.visual_candidates';
    final candidates = <WizardVisualCandidate>[];
    final draftKeys = <int>{};

    for (var index = 0; index < candidatesRaw.length; index += 1) {
      final candidatePath = '$path[$index]';
      final candidateJson = _objectValue(
        candidatesRaw[index],
        candidatePath,
      );
      final draftKeyValue = _requiredValue(
        candidateJson,
        'draft_key',
        '$candidatePath.draft_key',
      );
      if (draftKeyValue is! int || draftKeyValue <= 0) {
        _fail('$candidatePath.draft_key', 'must be a positive integer');
      }
      if (!draftKeys.add(draftKeyValue)) {
        _fail('$candidatePath.draft_key', 'must be unique');
      }

      final position = _parseNormalizedPoint(
        _requiredObject(
          candidateJson,
          'position',
          '$candidatePath.position',
        ),
        '$candidatePath.position',
      );
      final shapeRaw = _requiredString(
        candidateJson,
        'shape',
        '$candidatePath.shape',
      );
      final shape = switch (shapeRaw) {
        'circle' => WizardVisualCandidateShape.circle,
        'square' => WizardVisualCandidateShape.square,
        'rectangle' => WizardVisualCandidateShape.rectangle,
        'rounded_rectangle' => WizardVisualCandidateShape.roundedRectangle,
        _ => _fail('$candidatePath.shape', 'unsupported value'),
      };
      final sizeScale = _requiredRangedNumber(
        candidateJson,
        'size_scale',
        '$candidatePath.size_scale',
        minimum: 0.5,
        maximum: 2.5,
      );
      final rotationRadians = _requiredRangedNumber(
        candidateJson,
        'rotation_radians',
        '$candidatePath.rotation_radians',
        minimum: -math.pi,
        maximum: math.pi,
      );

      candidates.add(
        WizardVisualCandidate(
          draftKey: draftKeyValue,
          position: position,
          shape: shape,
          sizeScale: sizeScale,
          rotationRadians: rotationRadians,
        ),
      );
    }

    return candidates;
  }

  static WizardPoint _parseNormalizedPoint(
    Map<String, dynamic> json,
    String path,
  ) {
    return WizardPoint(
      x: _requiredRangedNumber(
        json,
        'x',
        '$path.x',
        minimum: 0.0,
        maximum: 1.0,
      ),
      y: _requiredRangedNumber(
        json,
        'y',
        '$path.y',
        minimum: 0.0,
        maximum: 1.0,
      ),
    );
  }

  static dynamic _requiredValue(
    Map<String, dynamic> json,
    String key,
    String path,
  ) {
    if (!json.containsKey(key)) {
      _fail(path, 'is required');
    }
    return json[key];
  }

  static String _requiredString(
    Map<String, dynamic> json,
    String key,
    String path,
  ) {
    final value = _requiredValue(json, key, path);
    if (value is! String) {
      _fail(path, 'must be a string');
    }
    return value;
  }

  static Map<String, dynamic> _requiredObject(
    Map<String, dynamic> json,
    String key,
    String path,
  ) {
    return _objectValue(_requiredValue(json, key, path), path);
  }

  static Map<String, dynamic> _objectValue(dynamic value, String path) {
    if (value is! Map<String, dynamic>) {
      _fail(path, 'must be an object');
    }
    return value;
  }

  static List<dynamic> _requiredList(
    Map<String, dynamic> json,
    String key,
    String path,
  ) {
    final value = _requiredValue(json, key, path);
    if (value is! List<dynamic>) {
      _fail(path, 'must be a list');
    }
    return value;
  }

  static double _requiredFiniteNumber(
    Map<String, dynamic> json,
    String key,
    String path,
  ) {
    final value = _requiredValue(json, key, path);
    if (value is! num) {
      _fail(path, 'must be a number');
    }
    final converted = value.toDouble();
    if (!converted.isFinite) {
      _fail(path, 'must be finite');
    }
    if (value is int && converted.toInt() != value) {
      _fail(path, 'must convert to double without precision loss');
    }
    return converted;
  }

  static double _requiredRangedNumber(
    Map<String, dynamic> json,
    String key,
    String path, {
    required double minimum,
    required double maximum,
  }) {
    final value = _requiredFiniteNumber(json, key, path);
    if (value < minimum || value > maximum) {
      _fail(path, 'is outside the allowed range');
    }
    return value;
  }

  static bool _isSafePhotoPath(String value) {
    if (value.isEmpty ||
        value.startsWith('/') ||
        value.contains('\\') ||
        !value.startsWith('photos/')) {
      return false;
    }

    final segments = value.split('/');
    if (segments.any(
      (segment) =>
          segment.isEmpty ||
          segment == '.' ||
          segment == '..' ||
          RegExp(r'^[A-Za-z][A-Za-z0-9+.-]*:').hasMatch(segment),
    )) {
      return false;
    }

    return true;
  }

  static Never _fail(String path, String reason) {
    throw WizardIntakeFormatException(path, reason);
  }
}
