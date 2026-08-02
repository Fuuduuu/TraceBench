import 'dart:math' as math;

import 'package:flutter_test/flutter_test.dart';
import 'package:trace_bench_viewer/shared/models/wizard_intake.dart';

Map<String, dynamic> _validIntakeJson({
  String schemaVersion = '1.0',
  String coordinateSpace = 'wizard_normalized',
  String occurrence = 'intermittent',
  bool includePhoto = true,
  bool includeCandidates = true,
}) {
  return <String, dynamic>{
    'schema_version': schemaVersion,
    'coordinate_space': coordinateSpace,
    'problem_description': <String, dynamic>{
      'description': 'Human-entered main description',
      'occurrence': occurrence,
      'when_occurs': 'After warming up',
      'symptoms': 'Display flickers',
      'attempts': 'Reseated the cable',
    },
    'contour': <String, dynamic>{
      'closed': true,
      'points': <dynamic>[
        <String, dynamic>{'x': 0.1, 'y': 0.2},
        <String, dynamic>{'x': 0.8, 'y': 0.2},
        <String, dynamic>{'x': 0.8, 'y': 0.7},
      ],
    },
    'background_photo': includePhoto
        ? <String, dynamic>{
            'relative_path': 'photos/top/board.jpg',
            'transform': <String, dynamic>{
              'translation': <String, dynamic>{'x': -0.25, 'y': 0.5},
              'scale': 1.25,
              'rotation_radians': 0.75,
              'opacity': 0.65,
            },
          }
        : null,
    'visual_candidates': includeCandidates
        ? <dynamic>[
            <String, dynamic>{
              'draft_key': 7,
              'position': <String, dynamic>{'x': 0.4, 'y': 0.5},
              'shape': 'rounded_rectangle',
              'size_scale': 1.5,
              'rotation_radians': -0.5,
            },
          ]
        : <dynamic>[],
  };
}

Map<String, dynamic> _object(
  Map<String, dynamic> json,
  String key,
) {
  return json[key]! as Map<String, dynamic>;
}

Matcher _formatErrorAt(String path) {
  return isA<WizardIntakeFormatException>().having(
    (error) => error.toString(),
    'message',
    contains(path),
  );
}

void main() {
  group('WizardIntake valid parsing', () {
    test('parses the complete v1 contract into typed values', () {
      final intake = WizardIntake.fromJson(_validIntakeJson());

      expect(intake.schemaVersion, '1.0');
      expect(intake.coordinateSpace, 'wizard_normalized');
      expect(
        intake.problemDescription.occurrence,
        WizardProblemOccurrence.intermittent,
      );
      expect(intake.contour.closed, isTrue);
      expect(intake.contour.points, hasLength(3));
      expect(intake.contour.points.first.x, 0.1);
      expect(intake.backgroundPhoto!.relativePath, 'photos/top/board.jpg');
      expect(intake.backgroundPhoto!.transform.translation.x, -0.25);
      expect(intake.backgroundPhoto!.transform.scale, 1.25);
      expect(intake.visualCandidates.single.draftKey, 7);
      expect(
        intake.visualCandidates.single.shape,
        WizardVisualCandidateShape.roundedRectangle,
      );
    });

    test('parses minimal valid input with absent or null photo', () {
      final absentPhotoJson = _validIntakeJson(
        includePhoto: false,
        includeCandidates: false,
      )..remove('background_photo');
      final nullPhotoJson = _validIntakeJson(
        includePhoto: false,
        includeCandidates: false,
      );

      final absentPhoto = WizardIntake.fromJson(absentPhotoJson);
      final nullPhoto = WizardIntake.fromJson(nullPhotoJson);

      expect(absentPhoto.backgroundPhoto, isNull);
      expect(absentPhoto.visualCandidates, isEmpty);
      expect(nullPhoto.backgroundPhoto, isNull);
      expect(nullPhoto.visualCandidates, isEmpty);
    });

    test('maps only the exact occurrence values', () {
      final cases = <String, WizardProblemOccurrence>{
        'unknown': WizardProblemOccurrence.unknown,
        'continuous': WizardProblemOccurrence.continuous,
        'intermittent': WizardProblemOccurrence.intermittent,
      };

      for (final entry in cases.entries) {
        final intake = WizardIntake.fromJson(
          _validIntakeJson(occurrence: entry.key),
        );
        expect(intake.problemDescription.occurrence, entry.value);
      }
    });

    test('maps every exact candidate shape and preserves source order', () {
      final json = _validIntakeJson(includeCandidates: false);
      json['visual_candidates'] = <dynamic>[
        for (final entry in <(int, String)>[
          (4, 'circle'),
          (2, 'square'),
          (9, 'rectangle'),
          (1, 'rounded_rectangle'),
        ])
          <String, dynamic>{
            'draft_key': entry.$1,
            'position': <String, dynamic>{'x': 0.5, 'y': 0.5},
            'shape': entry.$2,
            'size_scale': 1.0,
            'rotation_radians': 0.0,
          },
      ];

      final candidates = WizardIntake.fromJson(json).visualCandidates;

      expect(candidates.map((candidate) => candidate.draftKey), [4, 2, 9, 1]);
      expect(candidates.map((candidate) => candidate.shape), [
        WizardVisualCandidateShape.circle,
        WizardVisualCandidateShape.square,
        WizardVisualCandidateShape.rectangle,
        WizardVisualCandidateShape.roundedRectangle,
      ]);
    });

    test('preserves human-entered strings verbatim after validation', () {
      final json = _validIntakeJson();
      final problem = _object(json, 'problem_description');
      problem['description'] = '  Main issue\nwith spacing  ';
      problem['when_occurs'] = '  sometimes  ';
      problem['symptoms'] = '\ncustom symptom\n';
      problem['attempts'] = 'attempt 1\nattempt 2';

      final parsed = WizardIntake.fromJson(json).problemDescription;

      expect(parsed.description, '  Main issue\nwith spacing  ');
      expect(parsed.whenOccurs, '  sometimes  ');
      expect(parsed.symptoms, '\ncustom symptom\n');
      expect(parsed.attempts, 'attempt 1\nattempt 2');
    });

    test('tolerates unknown fields at every object level', () {
      final json = _validIntakeJson();
      json['future_top_level'] = true;
      final problem = _object(json, 'problem_description')
        ..['future_problem'] = 1;
      final contour = _object(json, 'contour')..['future_contour'] = 2;
      final point =
          (contour['points']! as List<dynamic>).first as Map<String, dynamic>;
      point['future_point'] = 3;
      final photo = _object(json, 'background_photo')..['future_photo'] = 4;
      final transform = _object(photo, 'transform')..['future_transform'] = 5;
      _object(transform, 'translation')['future_translation'] = 6;
      final candidate = (json['visual_candidates']! as List<dynamic>).single
          as Map<String, dynamic>;
      candidate['future_candidate'] = 7;
      _object(candidate, 'position')['future_position'] = 8;

      final parsed = WizardIntake.fromJson(json);

      expect(parsed.problemDescription.description, problem['description']);
      expect(parsed.contour.points, hasLength(3));
      expect(parsed.backgroundPhoto, isNotNull);
      expect(parsed.visualCandidates, hasLength(1));
    });

    test('accepts integer normalized coordinates without changing values', () {
      final json = _validIntakeJson();
      final contour = _object(json, 'contour');
      contour['points'] = <dynamic>[
        <String, dynamic>{'x': 0, 'y': 0},
        <String, dynamic>{'x': 1, 'y': 0},
        <String, dynamic>{'x': 1, 'y': 1},
      ];
      final candidate = (json['visual_candidates']! as List<dynamic>).single
          as Map<String, dynamic>;
      candidate['position'] = <String, dynamic>{'x': 0, 'y': 1};

      final parsed = WizardIntake.fromJson(json);

      expect(parsed.contour.points.first.x, 0.0);
      expect(parsed.contour.points.last.y, 1.0);
      expect(parsed.visualCandidates.single.position.y, 1.0);
    });
  });

  group('WizardIntake known-field validation', () {
    test('rejects unsupported schema version and coordinate space', () {
      expect(
        () => WizardIntake.fromJson(
          _validIntakeJson(schemaVersion: '2.0'),
        ),
        throwsA(_formatErrorAt(r'$.schema_version')),
      );
      expect(
        () => WizardIntake.fromJson(
          _validIntakeJson(coordinateSpace: 'board_normalized'),
        ),
        throwsA(_formatErrorAt(r'$.coordinate_space')),
      );
    });

    test('rejects missing and wrong-type top-level known fields', () {
      final cases = <(String, void Function(Map<String, dynamic>), String)>[
        (
          'missing schema',
          (json) => json.remove('schema_version'),
          r'$.schema_version'
        ),
        (
          'wrong schema',
          (json) => json['schema_version'] = 1,
          r'$.schema_version'
        ),
        (
          'missing coordinate',
          (json) => json.remove('coordinate_space'),
          r'$.coordinate_space'
        ),
        (
          'wrong coordinate',
          (json) => json['coordinate_space'] = false,
          r'$.coordinate_space'
        ),
        (
          'missing problem',
          (json) => json.remove('problem_description'),
          r'$.problem_description'
        ),
        (
          'wrong problem',
          (json) => json['problem_description'] = 'bad',
          r'$.problem_description'
        ),
        ('missing contour', (json) => json.remove('contour'), r'$.contour'),
        (
          'wrong contour',
          (json) => json['contour'] = <dynamic>[],
          r'$.contour'
        ),
        (
          'wrong photo',
          (json) => json['background_photo'] = 'bad',
          r'$.background_photo'
        ),
        (
          'missing candidates',
          (json) => json.remove('visual_candidates'),
          r'$.visual_candidates'
        ),
        (
          'wrong candidates',
          (json) => json['visual_candidates'] = <String, dynamic>{},
          r'$.visual_candidates'
        ),
      ];

      for (final entry in cases) {
        final json = _validIntakeJson();
        entry.$2(json);
        expect(
          () => WizardIntake.fromJson(json),
          throwsA(_formatErrorAt(entry.$3)),
          reason: entry.$1,
        );
      }
    });

    test('rejects missing and wrong-type problem-description fields', () {
      final cases = <(String, void Function(Map<String, dynamic>), String)>[
        (
          'description missing',
          (problem) => problem.remove('description'),
          r'$.problem_description.description'
        ),
        (
          'description wrong',
          (problem) => problem['description'] = 1,
          r'$.problem_description.description'
        ),
        (
          'occurrence missing',
          (problem) => problem.remove('occurrence'),
          r'$.problem_description.occurrence'
        ),
        (
          'occurrence wrong',
          (problem) => problem['occurrence'] = 1,
          r'$.problem_description.occurrence'
        ),
        (
          'when missing',
          (problem) => problem.remove('when_occurs'),
          r'$.problem_description.when_occurs'
        ),
        (
          'when wrong',
          (problem) => problem['when_occurs'] = null,
          r'$.problem_description.when_occurs'
        ),
        (
          'symptoms missing',
          (problem) => problem.remove('symptoms'),
          r'$.problem_description.symptoms'
        ),
        (
          'symptoms wrong',
          (problem) => problem['symptoms'] = <dynamic>[],
          r'$.problem_description.symptoms'
        ),
        (
          'attempts missing',
          (problem) => problem.remove('attempts'),
          r'$.problem_description.attempts'
        ),
        (
          'attempts wrong',
          (problem) => problem['attempts'] = false,
          r'$.problem_description.attempts'
        ),
      ];

      for (final entry in cases) {
        final json = _validIntakeJson();
        entry.$2(_object(json, 'problem_description'));
        expect(
          () => WizardIntake.fromJson(json),
          throwsA(_formatErrorAt(entry.$3)),
          reason: entry.$1,
        );
      }
    });

    test('rejects blank description and non-exact occurrence', () {
      final blank = _validIntakeJson();
      _object(blank, 'problem_description')['description'] = ' \n\t ';
      final badOccurrence = _validIntakeJson();
      _object(badOccurrence, 'problem_description')['occurrence'] = 'sometimes';

      expect(
        () => WizardIntake.fromJson(blank),
        throwsA(_formatErrorAt(r'$.problem_description.description')),
      );
      expect(
        () => WizardIntake.fromJson(badOccurrence),
        throwsA(_formatErrorAt(r'$.problem_description.occurrence')),
      );
    });

    test('rejects malformed contour fields and requires explicit closure', () {
      final cases = <(String, void Function(Map<String, dynamic>), String)>[
        (
          'closed missing',
          (contour) => contour.remove('closed'),
          r'$.contour.closed'
        ),
        (
          'closed wrong',
          (contour) => contour['closed'] = 1,
          r'$.contour.closed'
        ),
        (
          'open contour',
          (contour) => contour['closed'] = false,
          r'$.contour.closed'
        ),
        (
          'points missing',
          (contour) => contour.remove('points'),
          r'$.contour.points'
        ),
        (
          'points wrong',
          (contour) => contour['points'] = <String, dynamic>{},
          r'$.contour.points'
        ),
        (
          'point wrong',
          (contour) => contour['points'] = <dynamic>[1, 2, 3],
          r'$.contour.points[0]'
        ),
        (
          'x missing',
          (contour) => ((contour['points']! as List<dynamic>).first
                  as Map<String, dynamic>)
              .remove('x'),
          r'$.contour.points[0].x'
        ),
        (
          'x wrong',
          (contour) => ((contour['points']! as List<dynamic>).first
              as Map<String, dynamic>)['x'] = '0.1',
          r'$.contour.points[0].x'
        ),
        (
          'y missing',
          (contour) => ((contour['points']! as List<dynamic>).first
                  as Map<String, dynamic>)
              .remove('y'),
          r'$.contour.points[0].y'
        ),
        (
          'y wrong',
          (contour) => ((contour['points']! as List<dynamic>).first
              as Map<String, dynamic>)['y'] = null,
          r'$.contour.points[0].y'
        ),
      ];

      for (final entry in cases) {
        final json = _validIntakeJson();
        entry.$2(_object(json, 'contour'));
        expect(
          () => WizardIntake.fromJson(json),
          throwsA(_formatErrorAt(entry.$3)),
          reason: entry.$1,
        );
      }
    });

    test('requires at least three contour points', () {
      final json = _validIntakeJson();
      _object(json, 'contour')['points'] = <dynamic>[
        <String, dynamic>{'x': 0.0, 'y': 0.0},
        <String, dynamic>{'x': 1.0, 'y': 1.0},
      ];

      expect(
        () => WizardIntake.fromJson(json),
        throwsA(_formatErrorAt(r'$.contour.points')),
      );
    });

    test('rejects out-of-range and non-finite normalized coordinates', () {
      final values = <double>[-0.01, 1.01, double.nan, double.infinity];

      for (final value in values) {
        final pointJson = _validIntakeJson();
        final contour = _object(pointJson, 'contour');
        ((contour['points']! as List<dynamic>).first
            as Map<String, dynamic>)['x'] = value;
        expect(
          () => WizardIntake.fromJson(pointJson),
          throwsA(_formatErrorAt(r'$.contour.points[0].x')),
        );

        final candidateJson = _validIntakeJson();
        final candidate = (candidateJson['visual_candidates']! as List<dynamic>)
            .single as Map<String, dynamic>;
        _object(candidate, 'position')['y'] = value;
        expect(
          () => WizardIntake.fromJson(candidateJson),
          throwsA(_formatErrorAt(r'$.visual_candidates[0].position.y')),
        );
      }
    });

    test('does not echo arbitrary rejected content in exception text', () {
      const sensitive = 'PRIVATE_USER_TEXT_SHOULD_NOT_LEAK';
      final json = _validIntakeJson();
      _object(json, 'problem_description')['occurrence'] = sensitive;

      try {
        WizardIntake.fromJson(json);
        fail('Expected WizardIntakeFormatException');
      } on WizardIntakeFormatException catch (error) {
        expect(error.toString(), contains(r'$.problem_description.occurrence'));
        expect(error.toString(), isNot(contains(sensitive)));
      }
    });
  });

  group('WizardIntake background photo validation', () {
    test('accepts a safe project-relative photo path', () {
      final parsed = WizardIntake.fromJson(_validIntakeJson());

      expect(parsed.backgroundPhoto!.relativePath, 'photos/top/board.jpg');
    });

    test('rejects unsafe photo paths', () {
      final unsafePaths = <String>[
        '',
        'photos/',
        'photos//board.jpg',
        'photos/./board.jpg',
        'photos/../board.jpg',
        '/photos/board.jpg',
        r'photos\board.jpg',
        r'C:/photos/board.jpg',
        'https://example.test/board.jpg',
        'notes/board.jpg',
      ];

      for (final path in unsafePaths) {
        final json = _validIntakeJson();
        _object(json, 'background_photo')['relative_path'] = path;
        expect(
          () => WizardIntake.fromJson(json),
          throwsA(_formatErrorAt(r'$.background_photo.relative_path')),
          reason: path,
        );
      }
    });

    test('requires every known photo and transform field with exact types', () {
      final cases = <(String, void Function(Map<String, dynamic>), String)>[
        (
          'path missing',
          (photo) => photo.remove('relative_path'),
          r'$.background_photo.relative_path'
        ),
        (
          'path wrong',
          (photo) => photo['relative_path'] = 1,
          r'$.background_photo.relative_path'
        ),
        (
          'transform missing',
          (photo) => photo.remove('transform'),
          r'$.background_photo.transform'
        ),
        (
          'transform wrong',
          (photo) => photo['transform'] = <dynamic>[],
          r'$.background_photo.transform'
        ),
        (
          'translation missing',
          (photo) => _object(photo, 'transform').remove('translation'),
          r'$.background_photo.transform.translation'
        ),
        (
          'translation wrong',
          (photo) => _object(photo, 'transform')['translation'] = 1,
          r'$.background_photo.transform.translation'
        ),
        (
          'translation x missing',
          (photo) =>
              _object(_object(photo, 'transform'), 'translation').remove('x'),
          r'$.background_photo.transform.translation.x'
        ),
        (
          'translation x wrong',
          (photo) =>
              _object(_object(photo, 'transform'), 'translation')['x'] = '0',
          r'$.background_photo.transform.translation.x'
        ),
        (
          'translation y missing',
          (photo) =>
              _object(_object(photo, 'transform'), 'translation').remove('y'),
          r'$.background_photo.transform.translation.y'
        ),
        (
          'translation y wrong',
          (photo) =>
              _object(_object(photo, 'transform'), 'translation')['y'] = null,
          r'$.background_photo.transform.translation.y'
        ),
        (
          'scale missing',
          (photo) => _object(photo, 'transform').remove('scale'),
          r'$.background_photo.transform.scale'
        ),
        (
          'scale wrong',
          (photo) => _object(photo, 'transform')['scale'] = '1',
          r'$.background_photo.transform.scale'
        ),
        (
          'rotation missing',
          (photo) => _object(photo, 'transform').remove('rotation_radians'),
          r'$.background_photo.transform.rotation_radians'
        ),
        (
          'rotation wrong',
          (photo) => _object(photo, 'transform')['rotation_radians'] = false,
          r'$.background_photo.transform.rotation_radians'
        ),
        (
          'opacity missing',
          (photo) => _object(photo, 'transform').remove('opacity'),
          r'$.background_photo.transform.opacity'
        ),
        (
          'opacity wrong',
          (photo) => _object(photo, 'transform')['opacity'] = '0.5',
          r'$.background_photo.transform.opacity'
        ),
      ];

      for (final entry in cases) {
        final json = _validIntakeJson();
        entry.$2(_object(json, 'background_photo'));
        expect(
          () => WizardIntake.fromJson(json),
          throwsA(_formatErrorAt(entry.$3)),
          reason: entry.$1,
        );
      }
    });

    test('accepts inclusive transform boundaries and finite translation', () {
      final minimumJson = _validIntakeJson();
      final minimumTransform = _object(
        _object(minimumJson, 'background_photo'),
        'transform',
      );
      minimumTransform['translation'] = <String, dynamic>{
        'x': -100,
        'y': 100.5,
      };
      minimumTransform['scale'] = 0.25;
      minimumTransform['rotation_radians'] = -math.pi;
      minimumTransform['opacity'] = 0.0;

      final maximumJson = _validIntakeJson();
      final maximumTransform = _object(
        _object(maximumJson, 'background_photo'),
        'transform',
      );
      maximumTransform['scale'] = 8.0;
      maximumTransform['rotation_radians'] = math.pi;
      maximumTransform['opacity'] = 1.0;

      final minimum = WizardIntake.fromJson(minimumJson).backgroundPhoto!;
      final maximum = WizardIntake.fromJson(maximumJson).backgroundPhoto!;

      expect(minimum.transform.translation.x, -100.0);
      expect(minimum.transform.translation.y, 100.5);
      expect(minimum.transform.scale, 0.25);
      expect(minimum.transform.rotationRadians, -math.pi);
      expect(minimum.transform.opacity, 0.0);
      expect(maximum.transform.scale, 8.0);
      expect(maximum.transform.rotationRadians, math.pi);
      expect(maximum.transform.opacity, 1.0);
    });

    test('rejects invalid transform ranges and non-finite values', () {
      final cases = <(String, double, String)>[
        ('scale', 0.249, r'$.background_photo.transform.scale'),
        ('scale', 8.001, r'$.background_photo.transform.scale'),
        ('scale', double.nan, r'$.background_photo.transform.scale'),
        (
          'rotation_radians',
          -math.pi - 0.001,
          r'$.background_photo.transform.rotation_radians'
        ),
        (
          'rotation_radians',
          math.pi + 0.001,
          r'$.background_photo.transform.rotation_radians'
        ),
        (
          'rotation_radians',
          double.infinity,
          r'$.background_photo.transform.rotation_radians'
        ),
        ('opacity', -0.001, r'$.background_photo.transform.opacity'),
        ('opacity', 1.001, r'$.background_photo.transform.opacity'),
        ('opacity', double.nan, r'$.background_photo.transform.opacity'),
      ];

      for (final entry in cases) {
        final json = _validIntakeJson();
        final transform = _object(
          _object(json, 'background_photo'),
          'transform',
        );
        transform[entry.$1] = entry.$2;
        expect(
          () => WizardIntake.fromJson(json),
          throwsA(_formatErrorAt(entry.$3)),
          reason: '${entry.$1}=${entry.$2}',
        );
      }

      for (final axis in <String>['x', 'y']) {
        final json = _validIntakeJson();
        final translation = _object(
          _object(_object(json, 'background_photo'), 'transform'),
          'translation',
        );
        translation[axis] = double.nan;
        expect(
          () => WizardIntake.fromJson(json),
          throwsA(
            _formatErrorAt(
              r'$.background_photo.transform.translation.' + axis,
            ),
          ),
        );
      }
    });
  });

  group('WizardIntake visual candidate validation', () {
    test('requires every candidate field with exact types', () {
      final cases = <(String, void Function(Map<String, dynamic>), String)>[
        (
          'candidate wrong',
          (candidate) => candidate['__replace__'] = true,
          r'$.visual_candidates[0]'
        ),
        (
          'key missing',
          (candidate) => candidate.remove('draft_key'),
          r'$.visual_candidates[0].draft_key'
        ),
        (
          'key wrong',
          (candidate) => candidate['draft_key'] = 1.0,
          r'$.visual_candidates[0].draft_key'
        ),
        (
          'position missing',
          (candidate) => candidate.remove('position'),
          r'$.visual_candidates[0].position'
        ),
        (
          'position wrong',
          (candidate) => candidate['position'] = 1,
          r'$.visual_candidates[0].position'
        ),
        (
          'position x missing',
          (candidate) => _object(candidate, 'position').remove('x'),
          r'$.visual_candidates[0].position.x'
        ),
        (
          'position y wrong',
          (candidate) => _object(candidate, 'position')['y'] = '0.5',
          r'$.visual_candidates[0].position.y'
        ),
        (
          'shape missing',
          (candidate) => candidate.remove('shape'),
          r'$.visual_candidates[0].shape'
        ),
        (
          'shape wrong',
          (candidate) => candidate['shape'] = 1,
          r'$.visual_candidates[0].shape'
        ),
        (
          'size missing',
          (candidate) => candidate.remove('size_scale'),
          r'$.visual_candidates[0].size_scale'
        ),
        (
          'size wrong',
          (candidate) => candidate['size_scale'] = '1',
          r'$.visual_candidates[0].size_scale'
        ),
        (
          'rotation missing',
          (candidate) => candidate.remove('rotation_radians'),
          r'$.visual_candidates[0].rotation_radians'
        ),
        (
          'rotation wrong',
          (candidate) => candidate['rotation_radians'] = false,
          r'$.visual_candidates[0].rotation_radians'
        ),
      ];

      for (final entry in cases) {
        final json = _validIntakeJson();
        final candidates = json['visual_candidates']! as List<dynamic>;
        final candidate = candidates.single as Map<String, dynamic>;
        if (entry.$1 == 'candidate wrong') {
          candidates[0] = 'bad';
        } else {
          entry.$2(candidate);
        }
        expect(
          () => WizardIntake.fromJson(json),
          throwsA(_formatErrorAt(entry.$3)),
          reason: entry.$1,
        );
      }
    });

    test('accepts inclusive size and rotation boundaries', () {
      final json = _validIntakeJson(includeCandidates: false);
      json['visual_candidates'] = <dynamic>[
        <String, dynamic>{
          'draft_key': 1,
          'position': <String, dynamic>{'x': 0.0, 'y': 1.0},
          'shape': 'circle',
          'size_scale': 0.5,
          'rotation_radians': -math.pi,
        },
        <String, dynamic>{
          'draft_key': 2,
          'position': <String, dynamic>{'x': 1.0, 'y': 0.0},
          'shape': 'square',
          'size_scale': 2.5,
          'rotation_radians': math.pi,
        },
      ];

      final candidates = WizardIntake.fromJson(json).visualCandidates;

      expect(candidates.first.sizeScale, 0.5);
      expect(candidates.first.rotationRadians, -math.pi);
      expect(candidates.last.sizeScale, 2.5);
      expect(candidates.last.rotationRadians, math.pi);
    });

    test('rejects invalid shape, size, rotation, and draft keys', () {
      final shapeJson = _validIntakeJson();
      final shapeCandidate = (shapeJson['visual_candidates']! as List<dynamic>)
          .single as Map<String, dynamic>;
      shapeCandidate['shape'] = 'oval';
      expect(
        () => WizardIntake.fromJson(shapeJson),
        throwsA(_formatErrorAt(r'$.visual_candidates[0].shape')),
      );

      for (final size in <double>[0.499, 2.501, double.nan]) {
        final json = _validIntakeJson();
        final candidate = (json['visual_candidates']! as List<dynamic>).single
            as Map<String, dynamic>;
        candidate['size_scale'] = size;
        expect(
          () => WizardIntake.fromJson(json),
          throwsA(_formatErrorAt(r'$.visual_candidates[0].size_scale')),
        );
      }

      for (final rotation in <double>[
        -math.pi - 0.001,
        math.pi + 0.001,
        double.infinity,
      ]) {
        final json = _validIntakeJson();
        final candidate = (json['visual_candidates']! as List<dynamic>).single
            as Map<String, dynamic>;
        candidate['rotation_radians'] = rotation;
        expect(
          () => WizardIntake.fromJson(json),
          throwsA(
            _formatErrorAt(r'$.visual_candidates[0].rotation_radians'),
          ),
        );
      }

      for (final key in <int>[0, -1]) {
        final json = _validIntakeJson();
        final candidate = (json['visual_candidates']! as List<dynamic>).single
            as Map<String, dynamic>;
        candidate['draft_key'] = key;
        expect(
          () => WizardIntake.fromJson(json),
          throwsA(_formatErrorAt(r'$.visual_candidates[0].draft_key')),
        );
      }
    });

    test('requires unique positive draft keys', () {
      final json = _validIntakeJson();
      final candidates = json['visual_candidates']! as List<dynamic>;
      candidates.add(<String, dynamic>{
        'draft_key': 7,
        'position': <String, dynamic>{'x': 0.2, 'y': 0.3},
        'shape': 'circle',
        'size_scale': 1.0,
        'rotation_radians': 0.0,
      });

      expect(
        () => WizardIntake.fromJson(json),
        throwsA(_formatErrorAt(r'$.visual_candidates[1].draft_key')),
      );
    });
  });

  test('returned and constructor-supplied collections are defensive', () {
    final parsed = WizardIntake.fromJson(_validIntakeJson());

    expect(
      () => parsed.contour.points.add(const WizardPoint(x: 0, y: 0)),
      throwsUnsupportedError,
    );
    expect(
      () => parsed.visualCandidates.add(
        const WizardVisualCandidate(
          draftKey: 99,
          position: WizardPoint(x: 0.5, y: 0.5),
          shape: WizardVisualCandidateShape.circle,
          sizeScale: 1,
          rotationRadians: 0,
        ),
      ),
      throwsUnsupportedError,
    );

    final sourcePoints = <WizardPoint>[
      const WizardPoint(x: 0, y: 0),
      const WizardPoint(x: 1, y: 0),
      const WizardPoint(x: 1, y: 1),
    ];
    final contour = WizardContour(closed: true, points: sourcePoints);
    sourcePoints.clear();
    expect(contour.points, hasLength(3));

    final sourceCandidates = <WizardVisualCandidate>[
      const WizardVisualCandidate(
        draftKey: 1,
        position: WizardPoint(x: 0.5, y: 0.5),
        shape: WizardVisualCandidateShape.square,
        sizeScale: 1,
        rotationRadians: 0,
      ),
    ];
    final intake = WizardIntake(
      schemaVersion: '1.0',
      coordinateSpace: 'wizard_normalized',
      problemDescription: const WizardProblemDescription(
        description: 'Issue',
        occurrence: WizardProblemOccurrence.unknown,
        whenOccurs: '',
        symptoms: '',
        attempts: '',
      ),
      contour: contour,
      backgroundPhoto: null,
      visualCandidates: sourceCandidates,
    );
    sourceCandidates.clear();
    expect(intake.visualCandidates, hasLength(1));
  });
}
