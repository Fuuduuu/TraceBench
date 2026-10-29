import 'dart:convert';
import 'dart:math' as math;
import 'dart:ui';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';

import '../../../shared/models/wizard_intake.dart';

/// A visual draft only; this does not identify or confirm a component.
@immutable
class ComponentCandidateDraft {
  const ComponentCandidateDraft({
    required this.draftKey,
    required this.position,
    required this.shape,
    required this.sizeScale,
    required this.rotationRadians,
  });

  factory ComponentCandidateDraft.fromWizard(WizardVisualCandidate candidate) {
    final draft = ComponentCandidateDraft(
      draftKey: candidate.draftKey,
      position: Offset(candidate.position.x, candidate.position.y),
      shape: candidate.shape,
      sizeScale: candidate.sizeScale,
      rotationRadians: candidate.rotationRadians,
    );
    draft._validate();
    return draft;
  }

  factory ComponentCandidateDraft.fromJson(Map<String, dynamic> json) {
    final point = _object(json['position'], 'candidate position');
    final shape = switch (json['shape']) {
      'circle' => WizardVisualCandidateShape.circle,
      'square' => WizardVisualCandidateShape.square,
      'rectangle' => WizardVisualCandidateShape.rectangle,
      'rounded_rectangle' => WizardVisualCandidateShape.roundedRectangle,
      _ => throw const FormatException('Invalid candidate shape.'),
    };
    final draft = ComponentCandidateDraft(
      draftKey: _positiveInt(json['draft_key'], 'draft_key'),
      position: Offset(
          _finite(point['x'], 'position.x'), _finite(point['y'], 'position.y')),
      shape: shape,
      sizeScale: _finite(json['size_scale'], 'size_scale'),
      rotationRadians: _finite(json['rotation_radians'], 'rotation_radians'),
    );
    draft._validate();
    return draft;
  }

  final int draftKey;
  final Offset position;
  final WizardVisualCandidateShape shape;
  final double sizeScale;
  final double rotationRadians;

  WizardVisualCandidate toWizard() {
    _validate();
    return WizardVisualCandidate(
      draftKey: draftKey,
      position: WizardPoint(x: position.dx, y: position.dy),
      shape: shape,
      sizeScale: sizeScale,
      rotationRadians: rotationRadians,
    );
  }

  ComponentCandidateDraft copyWith({
    Offset? position,
    WizardVisualCandidateShape? shape,
    double? sizeScale,
    double? rotationRadians,
  }) {
    _validate();
    if (position != null && (!position.dx.isFinite || !position.dy.isFinite)) {
      throw const FormatException('Candidate position must be finite.');
    }
    if (sizeScale != null && !sizeScale.isFinite ||
        rotationRadians != null && !rotationRadians.isFinite) {
      throw const FormatException(
          'Candidate size and rotation must be finite.');
    }
    return ComponentCandidateDraft(
      draftKey: draftKey,
      position: position == null
          ? this.position
          : Offset(position.dx.clamp(0.0, 1.0), position.dy.clamp(0.0, 1.0)),
      shape: shape ?? this.shape,
      sizeScale: sizeScale?.clamp(.5, 2.5) ?? this.sizeScale,
      // Only edited rotation is wrapped: an imported +pi stays byte-exact.
      rotationRadians: rotationRadians == null
          ? this.rotationRadians
          : (rotationRadians + math.pi) % (2 * math.pi) - math.pi,
    );
  }

  Map<String, dynamic> toJson() {
    _validate();
    return <String, dynamic>{
      'draft_key': draftKey,
      'position': <String, dynamic>{'x': position.dx, 'y': position.dy},
      'shape': switch (shape) {
        WizardVisualCandidateShape.circle => 'circle',
        WizardVisualCandidateShape.square => 'square',
        WizardVisualCandidateShape.rectangle => 'rectangle',
        WizardVisualCandidateShape.roundedRectangle => 'rounded_rectangle',
      },
      'size_scale': sizeScale,
      'rotation_radians': rotationRadians,
    };
  }

  void _validate() {
    _positiveInt(draftKey, 'draft_key');
    _range(position.dx, 0, 1, 'position.x');
    _range(position.dy, 0, 1, 'position.y');
    _range(sizeScale, .5, 2.5, 'size_scale');
    _range(rotationRadians, -math.pi, math.pi, 'rotation_radians');
  }
}

@immutable
class ComponentCandidateDocument {
  ComponentCandidateDocument._({
    required this.projectId,
    required this.referenceFrameAspectRatio,
    required this.sourceFingerprint,
    required Iterable<ComponentCandidateDraft> candidates,
    required this.nextDraftKey,
  }) : candidates = List<ComponentCandidateDraft>.unmodifiable(candidates) {
    _validate();
  }

  factory ComponentCandidateDocument.seed(
      {required String projectId, WizardIntake? intake}) {
    final candidates = intake?.visualCandidates
            .map(ComponentCandidateDraft.fromWizard)
            .toList() ??
        <ComponentCandidateDraft>[];
    return ComponentCandidateDocument._(
      projectId: projectId,
      referenceFrameAspectRatio: intake?.referenceFrameAspectRatio ?? 1,
      sourceFingerprint: intake == null
          ? 'none'
          : sha256.convert(utf8.encode(jsonEncode(intake.toJson()))).toString(),
      candidates: candidates,
      nextDraftKey: candidates.fold<int>(0,
              (largest, candidate) => math.max(largest, candidate.draftKey)) +
          1,
    );
  }

  factory ComponentCandidateDocument.fromJson(Map<String, dynamic> json) {
    if (json['schema_version'] is! int || json['schema_version'] != 1) {
      throw const FormatException(
          'Unsupported component candidate draft schema.');
    }
    final rawCandidates = json['candidates'];
    if (rawCandidates is! List) {
      throw const FormatException('Candidate drafts must be a list.');
    }
    return ComponentCandidateDocument._(
      projectId: _string(json['project_id'], 'project_id'),
      referenceFrameAspectRatio: _finite(
          json['reference_frame_aspect_ratio'], 'reference_frame_aspect_ratio'),
      sourceFingerprint:
          _string(json['source_fingerprint'], 'source_fingerprint'),
      candidates: rawCandidates.map((candidate) =>
          ComponentCandidateDraft.fromJson(_object(candidate, 'candidate'))),
      nextDraftKey: _positiveInt(json['next_draft_key'], 'next_draft_key'),
    );
  }

  final String projectId;
  final double referenceFrameAspectRatio;
  final String sourceFingerprint;
  final List<ComponentCandidateDraft> candidates;
  final int nextDraftKey;

  ComponentCandidateDocument copyWith(
      {List<ComponentCandidateDraft>? candidates, int? nextDraftKey}) {
    if (nextDraftKey != null && nextDraftKey < this.nextDraftKey) {
      throw const FormatException(
          'Candidate identity high water cannot decrease.');
    }
    if (candidates != null) {
      final existingKeys =
          this.candidates.map((candidate) => candidate.draftKey).toSet();
      if (candidates.any((candidate) =>
          candidate.draftKey < this.nextDraftKey &&
          !existingKeys.contains(candidate.draftKey))) {
        throw const FormatException(
            'A deleted candidate identity cannot be reused.');
      }
    }
    return ComponentCandidateDocument._(
      projectId: projectId,
      referenceFrameAspectRatio: referenceFrameAspectRatio,
      sourceFingerprint: sourceFingerprint,
      candidates: candidates ?? this.candidates,
      nextDraftKey: nextDraftKey ?? this.nextDraftKey,
    );
  }

  bool sameContext(ComponentCandidateDocument other) =>
      projectId == other.projectId &&
      referenceFrameAspectRatio == other.referenceFrameAspectRatio &&
      sourceFingerprint == other.sourceFingerprint;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'schema_version': 1,
        'project_id': projectId,
        'reference_frame_aspect_ratio': referenceFrameAspectRatio,
        'source_fingerprint': sourceFingerprint,
        'next_draft_key': nextDraftKey,
        'candidates':
            candidates.map((candidate) => candidate.toJson()).toList(),
      };

  void _validate() {
    if (projectId.trim().isEmpty) {
      throw const FormatException('project_id must not be blank.');
    }
    if (!referenceFrameAspectRatio.isFinite || referenceFrameAspectRatio <= 0) {
      throw const FormatException(
          'Reference frame aspect ratio must be finite and positive.');
    }
    if (sourceFingerprint != 'none' &&
        !RegExp(r'^[a-f0-9]{64}$').hasMatch(sourceFingerprint)) {
      throw const FormatException('Invalid source intake fingerprint.');
    }
    _positiveInt(nextDraftKey, 'next_draft_key');
    final keys = <int>{};
    for (final candidate in candidates) {
      candidate._validate();
      if (!keys.add(candidate.draftKey)) {
        throw const FormatException('Candidate draft keys must be unique.');
      }
      if (candidate.draftKey >= nextDraftKey) {
        throw const FormatException(
            'next_draft_key must exceed every candidate key.');
      }
    }
  }
}

Map<String, dynamic> _object(Object? value, String name) {
  if (value is! Map<String, dynamic>) {
    throw FormatException('$name must be an object.');
  }
  return value;
}

String _string(Object? value, String name) {
  if (value is! String) throw FormatException('$name must be a string.');
  return value;
}

int _positiveInt(Object? value, String name) {
  if (value is! int || value <= 0) {
    throw FormatException('$name must be a positive integer.');
  }
  return value;
}

double _finite(Object? value, String name) {
  if (value is! num || !value.isFinite) {
    throw FormatException('$name must be finite.');
  }
  final result = value.toDouble();
  if (!result.isFinite || value is int && result.toInt() != value) {
    throw FormatException('$name loses numeric precision.');
  }
  return result;
}

void _range(double value, double minimum, double maximum, String name) {
  if (!value.isFinite || value < minimum || value > maximum) {
    throw FormatException('$name is outside the allowed range.');
  }
}
