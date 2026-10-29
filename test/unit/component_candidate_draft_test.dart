import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter_test/flutter_test.dart';
import 'package:trace_bench_viewer/features/component_candidates/models/component_candidate_draft.dart';
import 'package:trace_bench_viewer/shared/models/wizard_intake.dart';

void main() {
  test('seed keeps imported identity and exact finite pose including pi', () {
    final document = ComponentCandidateDocument.seed(
      projectId: 'board-a',
      intake: intake(),
    );
    final candidate = document.candidates.single;
    expect(candidate.draftKey, 17);
    expect(candidate.position, const Offset(.123456789, .875));
    expect(candidate.sizeScale, 1.23456789);
    expect(candidate.rotationRadians, math.pi);
    expect(candidate.toWizard().rotationRadians, math.pi);
    expect(document.referenceFrameAspectRatio, 1.75);
    expect(document.nextDraftKey, 18);
    expect(() => document.candidates.clear(), throwsUnsupportedError);
  });

  test('absent intake has a distinct stable empty context', () {
    final document = ComponentCandidateDocument.seed(projectId: 'board-a');
    expect(document.candidates, isEmpty);
    expect(document.referenceFrameAspectRatio, 1);
    expect(document.nextDraftKey, 1);
    expect(
        document
            .sameContext(ComponentCandidateDocument.seed(projectId: 'board-a')),
        isTrue);
    expect(
        document
            .sameContext(ComponentCandidateDocument.seed(projectId: 'board-b')),
        isFalse);
    expect(
        document.sameContext(ComponentCandidateDocument.seed(
            projectId: 'board-a', intake: intake())),
        isFalse);
  });

  test('editing clamps finite position and scale and wraps rotation', () {
    final original =
        ComponentCandidateDraft.fromWizard(intake().visualCandidates.single);
    final edited = original.copyWith(
        position: const Offset(-1, 4),
        sizeScale: 99,
        rotationRadians: 3 * math.pi);
    expect(edited.position, const Offset(0, 1));
    expect(edited.sizeScale, 2.5);
    expect(edited.rotationRadians, closeTo(-math.pi, 1e-12));
    expect(original.copyWith(sizeScale: -2).sizeScale, .5);
    expect(original.copyWith().rotationRadians, math.pi);
    expect(original.rotationRadians, math.pi);
    for (final edit in <ComponentCandidateDraft Function()>[
      () => original.copyWith(position: const Offset(double.nan, .5)),
      () => original.copyWith(sizeScale: double.infinity),
      () => original.copyWith(rotationRadians: double.nan),
    ]) {
      expect(edit, throwsFormatException);
    }
  });

  test('JSON round trip preserves identity pose context and deleted high water',
      () {
    final seed =
        ComponentCandidateDocument.seed(projectId: 'board-a', intake: intake());
    final deleted = seed.copyWith(candidates: [], nextDraftKey: 42);
    final reopened = ComponentCandidateDocument.fromJson(
        jsonDecode(jsonEncode(deleted.toJson())) as Map<String, dynamic>);
    expect(reopened.nextDraftKey, 42);
    expect(reopened.candidates, isEmpty);
    expect(reopened.sameContext(seed), isTrue);
    expect(() => reopened.copyWith(nextDraftKey: 18), throwsFormatException);
    final restored = ComponentCandidateDocument.fromJson(
        jsonDecode(jsonEncode(seed.toJson())) as Map<String, dynamic>);
    expect(restored.candidates.single.toWizard().position.x, .123456789);
    expect(restored.candidates.single.rotationRadians, math.pi);
  });

  test('fingerprint detects any original intake change', () {
    final first =
        ComponentCandidateDocument.seed(projectId: 'board-a', intake: intake());
    final second = ComponentCandidateDocument.seed(
        projectId: 'board-a', intake: intake(description: 'Different problem'));
    expect(first.sourceFingerprint.length, 64);
    expect(first.sameContext(second), isFalse);
  });

  test('deleted candidate keys cannot be reused after reopening', () {
    final seed =
        ComponentCandidateDocument.seed(projectId: 'board-a', intake: intake());
    final deleted = ComponentCandidateDocument.fromJson(
        seed.copyWith(candidates: []).toJson());
    expect(() => deleted.copyWith(candidates: seed.candidates),
        throwsFormatException);
    final fresh = ComponentCandidateDraft(
        draftKey: deleted.nextDraftKey,
        position: const Offset(.5, .5),
        shape: WizardVisualCandidateShape.circle,
        sizeScale: 1,
        rotationRadians: 0);
    expect(
        deleted
            .copyWith(
                candidates: [fresh], nextDraftKey: deleted.nextDraftKey + 1)
            .candidates
            .single
            .draftKey,
        18);
  });

  test('decoding rejects malformed envelope and candidate values', () {
    final valid =
        ComponentCandidateDocument.seed(projectId: 'board-a', intake: intake())
            .toJson();
    for (final change in <void Function(Map<String, dynamic>)>[
      (j) => j['schema_version'] = 2,
      (j) => j['project_id'] = '',
      (j) => j['reference_frame_aspect_ratio'] = 0,
      (j) => j['reference_frame_aspect_ratio'] = double.nan,
      (j) => j['source_fingerprint'] = 'bogus',
      (j) => j['next_draft_key'] = 17,
      (j) => j['next_draft_key'] = 18.0,
      (j) => j['candidates'] = 'oops',
      (j) => (j['candidates'] as List).add((j['candidates'] as List).first),
      (j) => (j['candidates'] as List).first['draft_key'] = 0,
      (j) => (j['candidates'] as List).first['shape'] = 'hexagon',
      (j) => (j['candidates'] as List).first['size_scale'] = .49,
      (j) => (j['candidates'] as List).first['rotation_radians'] = 4,
      (j) => (j['candidates'] as List).first['position']['x'] = 1.1,
      (j) => (j['candidates'] as List).first['position']['y'] = double.infinity,
      (j) => (j['candidates'] as List).first['position'] = null,
    ]) {
      final changed = jsonDecode(jsonEncode(valid)) as Map<String, dynamic>;
      change(changed);
      expect(() => ComponentCandidateDocument.fromJson(changed),
          throwsFormatException);
    }
  });
}

WizardIntake intake({String description = 'No power'}) => WizardIntake(
      schemaVersion: '1.0',
      coordinateSpace: 'wizard_normalized',
      referenceFrameAspectRatio: 1.75,
      problemDescription: WizardProblemDescription(
          description: description,
          occurrence: WizardProblemOccurrence.unknown,
          whenOccurs: '',
          symptoms: '',
          attempts: ''),
      contour: WizardContour(closed: true, points: const [
        WizardPoint(x: 0, y: 0),
        WizardPoint(x: 1, y: 0),
        WizardPoint(x: 1, y: 1)
      ]),
      backgroundPhoto: null,
      visualCandidates: const [
        WizardVisualCandidate(
            draftKey: 17,
            position: WizardPoint(x: .123456789, y: .875),
            shape: WizardVisualCandidateShape.roundedRectangle,
            sizeScale: 1.23456789,
            rotationRadians: math.pi)
      ],
    );
