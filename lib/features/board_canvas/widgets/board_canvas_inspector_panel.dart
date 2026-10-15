import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../shared/footprints/footprint_models.dart'
    show FootprintTemplate;
import '../../../shared/models/known_facts.dart'
    show
        ComponentFact,
        ComponentVisualPlacementFact,
        MeasurementFact,
        PhotoToBoardAlignmentFact,
        VisualTraceFact;
import '../logic/measurement_projection.dart' show endpointDisplayParts;
import '../theme/board_canvas_palette.dart';

const double _kCompactControlTileHeight = 34;
const double _kCompactControlIconSize = 16;

class BoardCanvasInspectorPanel extends StatelessWidget {
  const BoardCanvasInspectorPanel({
    super.key,
    required this.placement,
    required this.component,
    required this.template,
    required this.selectedMeasurementCount,
    required this.selectedMeasurementValueBadgeCount,
    required this.selectedMeasurementValueBadgesVisible,
    required this.onToggleSelectedMeasurementValueBadges,
    required this.relatedMeasurements,
    required this.relatedVisualTraces,
    required this.photoToBoardAlignments,
    this.placementDraftSection,
  });

  final ComponentVisualPlacementFact? placement;
  final ComponentFact? component;
  final FootprintTemplate? template;
  final int selectedMeasurementCount;
  final int selectedMeasurementValueBadgeCount;
  final bool selectedMeasurementValueBadgesVisible;
  final VoidCallback? onToggleSelectedMeasurementValueBadges;
  final List<MeasurementFact> relatedMeasurements;
  final List<VisualTraceFact> relatedVisualTraces;
  final List<PhotoToBoardAlignmentFact> photoToBoardAlignments;
  final Widget? placementDraftSection;

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];

    if (placement == null) {
      children.add(
        Card(
          color: BoardCanvasPalette.paper,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: BoardCanvasPalette.rule),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Select a placement to view read-only details.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: BoardCanvasPalette.muted,
                    ),
              ),
            ),
          ),
        ),
      );
    } else {
      children.add(
        _PlacementInspectorCard(
          placement: placement!,
          component: component,
          template: template,
          selectedMeasurementCount: selectedMeasurementCount,
          selectedMeasurementValueBadgeCount:
              selectedMeasurementValueBadgeCount,
          selectedMeasurementValueBadgesVisible:
              selectedMeasurementValueBadgesVisible,
          onToggleSelectedMeasurementValueBadges:
              onToggleSelectedMeasurementValueBadges,
        ),
      );
      if (placementDraftSection != null) {
        children.add(placementDraftSection!);
      }
      children.add(
        _MeasurementSummaryCard(relatedMeasurements: relatedMeasurements),
      );
      children.add(
        _VisualTraceMetadataCard(relatedVisualTraces: relatedVisualTraces),
      );
    }

    if (photoToBoardAlignments.isNotEmpty) {
      children.add(
        _PhotoAlignmentReadinessPanel(alignments: photoToBoardAlignments),
      );
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var index = 0; index < children.length; index++) ...[
            if (index > 0) const SizedBox(height: 12),
            children[index],
          ],
        ],
      ),
    );
  }
}

class _PlacementInspectorCard extends StatelessWidget {
  const _PlacementInspectorCard({
    required this.placement,
    required this.component,
    required this.template,
    required this.selectedMeasurementCount,
    required this.selectedMeasurementValueBadgeCount,
    required this.selectedMeasurementValueBadgesVisible,
    required this.onToggleSelectedMeasurementValueBadges,
  });

  final ComponentVisualPlacementFact placement;
  final ComponentFact? component;
  final FootprintTemplate? template;
  final int selectedMeasurementCount;
  final int selectedMeasurementValueBadgeCount;
  final bool selectedMeasurementValueBadgesVisible;
  final VoidCallback? onToggleSelectedMeasurementValueBadges;

  @override
  Widget build(BuildContext context) {
    final packageLabel = template?.displayName ?? 'Unknown package geometry';
    final templateId = placement.templateId ?? 'not provided';
    final identityStatus = _identityStatus(component);
    final badgeCountLabel = selectedMeasurementCount == 1
        ? 'Related measurement: 1'
        : 'Related measurements: $selectedMeasurementCount';
    final valueBadgeCountLabel = selectedMeasurementValueBadgeCount == 1
        ? 'Eligible value badge: 1'
        : 'Eligible value badges: $selectedMeasurementValueBadgeCount';
    final theme = Theme.of(context);

    return Card(
      color: BoardCanvasPalette.paper,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: BoardCanvasPalette.rule),
      ),
      child: DefaultTextStyle.merge(
        style: theme.textTheme.bodyMedium?.copyWith(
          color: BoardCanvasPalette.muted,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InspectorSectionHeader(
                title: 'Placement inspector (read-only)',
                tag: identityStatus == 'unknown' ? 'UNKNOWN' : null,
                subtitle: 'read-only · projection view',
              ),
              const SizedBox(height: 12),
              _InspectorField(
                  label: 'Component ID', value: placement.componentId),
              if ((component?.designator ?? '').isNotEmpty)
                _InspectorField(
                  label: 'Designator',
                  value: component!.designator!,
                ),
              _InspectorField(label: 'Template ID', value: templateId),
              _InspectorField(
                label: 'Package',
                value: '$packageLabel (package geometry)',
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 6),
                child: Text('template family — not a part identity'),
              ),
              _InspectorField(
                label: 'Identity status',
                value: identityStatus,
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 6),
                child: Text('identity not confirmed in this projection'),
              ),
              const _InspectorField(
                label: 'Electrical role',
                value: 'not confirmed',
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 6),
                child: Text('Template does not prove electrical identity.'),
              ),
              _InspectorField(
                  label: 'Placement status', value: placement.status),
              _InspectorField(
                label: 'Coordinate space',
                value: placement.coordinateSpace,
              ),
              _InspectorField(label: 'Board side', value: placement.boardSide),
              _InspectorField(
                  label: 'Center X', value: placement.centerX.toString()),
              _InspectorField(
                  label: 'Center Y', value: placement.centerY.toString()),
              _InspectorField(
                label: 'Rotation (deg)',
                value: placement.rotationDeg.toString(),
              ),
              if (placement.scale != null)
                _InspectorField(
                    label: 'Scale', value: placement.scale.toString())
              else ...[
                if (placement.width != null)
                  _InspectorField(
                    label: 'Width',
                    value: placement.width.toString(),
                  ),
                if (placement.height != null)
                  _InspectorField(
                    label: 'Height',
                    value: placement.height.toString(),
                  ),
              ],
              _InspectorField(
                label: 'Source event ID',
                value: placement.sourceEventId,
              ),
              _InspectorField(label: 'Status', value: placement.status),
              if (selectedMeasurementCount > 0) ...[
                const SizedBox(height: 12),
                const InspectorSectionHeader(
                  title: 'Measurement badge',
                  tag: 'MARKER',
                ),
                const SizedBox(height: 6),
                Text(badgeCountLabel),
                const Text('Component-level presence only.'),
                const Text('No board-coordinate interpretation is claimed.'),
                const Text(
                    'No probe, pin/anchor, or endpoint line semantics are shown.'),
                const Text('Does not create or confirm a net.'),
                if (selectedMeasurementValueBadgeCount > 0) ...[
                  const SizedBox(height: 8),
                  Text(valueBadgeCountLabel),
                  TextButton.icon(
                    key: const Key(
                      'board_canvas_selected_measurement_value_badge_toggle',
                    ),
                    style: TextButton.styleFrom(
                      minimumSize: const Size(148, _kCompactControlTileHeight),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,
                    ),
                    icon: Icon(
                      selectedMeasurementValueBadgesVisible
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      size: _kCompactControlIconSize,
                    ),
                    label: Text(
                      selectedMeasurementValueBadgesVisible
                          ? 'Hide measurement badge'
                          : 'Show measurement badge',
                    ),
                    onPressed: onToggleSelectedMeasurementValueBadges,
                  ),
                ],
                const SizedBox(height: 8),
              ],
              if (component?.installationStatus != null)
                _InspectorField(
                  label: 'Installation status',
                  value: component!.installationStatus!,
                ),
              if (component?.removedByEventId != null)
                _InspectorField(
                  label: 'Removed by event ID',
                  value: component!.removedByEventId!,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MeasurementSummaryCard extends StatelessWidget {
  const _MeasurementSummaryCard({required this.relatedMeasurements});

  final List<MeasurementFact> relatedMeasurements;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: BoardCanvasPalette.paper,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: BoardCanvasPalette.rule),
      ),
      child: DefaultTextStyle.merge(
        style: theme.textTheme.bodyMedium?.copyWith(
          color: BoardCanvasPalette.muted,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const InspectorSectionHeader(
                title: 'Measurement — read-only summary',
                tag: 'MEASURED',
              ),
              const SizedBox(height: 6),
              const Text('measured value — shown verbatim'),
              const Text('Value shown verbatim'),
              const Text('Does not create or confirm a net'),
              const Text('No board coordinate available'),
              if (relatedMeasurements.isEmpty) ...[
                const SizedBox(height: 6),
                const Text('No related measurements for selected component.'),
              ] else ...[
                const SizedBox(height: 8),
                ...relatedMeasurements.map(
                  (measurement) => InspectorMeasurementSummaryTile(
                    measurement: measurement,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _VisualTraceMetadataCard extends StatelessWidget {
  const _VisualTraceMetadataCard({required this.relatedVisualTraces});

  final List<VisualTraceFact> relatedVisualTraces;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: BoardCanvasPalette.paper,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: BoardCanvasPalette.rule),
      ),
      child: DefaultTextStyle.merge(
        style: theme.textTheme.bodyMedium?.copyWith(
          color: BoardCanvasPalette.muted,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const InspectorSectionHeader(
                title: 'Visual trace — read-only metadata',
                tag: 'VISUAL',
              ),
              const SizedBox(height: 6),
              const Text('visual metadata — does not establish a net'),
              const Text('Visual trace is not a confirmed electrical net'),
              const Text('Photo-local evidence; no board coordinate available'),
              const Text('Does not create or confirm connectivity'),
              if (relatedVisualTraces.isEmpty) ...[
                const SizedBox(height: 6),
                const Text('No related visual traces for selected component.'),
              ] else ...[
                const SizedBox(height: 8),
                ...relatedVisualTraces.map(
                  (trace) => InspectorVisualTraceSummaryTile(trace: trace),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class InspectorMeasurementSummaryTile extends StatelessWidget {
  const InspectorMeasurementSummaryTile({
    super.key,
    required this.measurement,
  });

  final MeasurementFact measurement;

  @override
  Widget build(BuildContext context) {
    final isStale = measurement.validityStatus == 'stale_after_repair';
    final valueText = measurement.value == null
        ? measurement.reading
        : '${measurement.value}${measurement.unit == null ? '' : ' ${measurement.unit}'}';
    final fromParts = endpointDisplayParts(measurement.from);
    final toParts = endpointDisplayParts(measurement.to);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: BoardCanvasPalette.rule),
          color: BoardCanvasPalette.tile,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _InspectorField(
                  label: 'Measurement ID', value: measurement.measurementId),
              _InspectorField(label: 'Mode', value: measurement.mode),
              _InspectorField(
                label: 'From -> To',
                value: _displayDirectionLabel(measurement.from, measurement.to),
              ),
              _InspectorField(
                label: 'From component',
                value: fromParts.component,
              ),
              _InspectorField(
                label: 'To component',
                value: toParts.component,
              ),
              _InspectorField(
                label: 'From pin',
                value: fromParts.pin ?? '-',
              ),
              _InspectorField(
                label: 'To pin',
                value: toParts.pin ?? '-',
              ),
              _InspectorField(label: 'From', value: measurement.from),
              _InspectorField(label: 'To', value: measurement.to),
              _InspectorField(label: 'Value', value: valueText),
              _InspectorField(
                  label: 'Power state', value: measurement.powerState),
              _InspectorField(
                  label: 'Validity status', value: measurement.validityStatus),
              if (isStale) const Text('Stale after repair'),
              if (measurement.originEventId != null)
                _InspectorField(
                  label: 'Origin event ID',
                  value: measurement.originEventId!,
                ),
              if (measurement.validUntilEventId != null)
                _InspectorField(
                  label: 'Valid until event ID',
                  value: measurement.validUntilEventId!,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class InspectorVisualTraceSummaryTile extends StatelessWidget {
  const InspectorVisualTraceSummaryTile({
    super.key,
    required this.trace,
  });

  final VisualTraceFact trace;

  @override
  Widget build(BuildContext context) {
    final fromEndpoint =
        _firstPresentText([trace.fromPin, trace.fromComponent]);
    final toEndpoint = _firstPresentText([trace.toPin, trace.toComponent]);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border:
              Border.all(color: Theme.of(context).colorScheme.outlineVariant),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _InspectorField(label: 'Trace ID', value: trace.traceId),
              _InspectorField(label: 'Photo ID', value: trace.photoId),
              _InspectorField(
                  label: 'Evidence type', value: trace.evidenceType),
              if (fromEndpoint != null)
                _InspectorField(
                  label: 'From -> To',
                  value: _displayDirectionLabel(fromEndpoint, toEndpoint),
                ),
              if (trace.fromComponent != null)
                _InspectorField(
                  label: 'From component',
                  value: trace.fromComponent!,
                ),
              if (trace.toComponent != null)
                _InspectorField(
                  label: 'To component',
                  value: trace.toComponent!,
                ),
              if (trace.fromPin != null)
                _InspectorField(
                  label: 'From pin',
                  value: trace.fromPin!,
                ),
              if (trace.toPin != null)
                _InspectorField(
                  label: 'To pin',
                  value: trace.toPin!,
                ),
              if (trace.confidence != null)
                _InspectorField(
                  label: 'Confidence',
                  value: trace.confidence!,
                ),
              if (trace.layer != null)
                _InspectorField(
                  label: 'Layer',
                  value: trace.layer!,
                ),
              if (trace.notes != null)
                _InspectorField(
                  label: 'Notes',
                  value: trace.notes!,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class InspectorSectionHeader extends StatelessWidget {
  const InspectorSectionHeader({
    super.key,
    required this.title,
    this.tag,
    this.subtitle,
  });

  final String title;
  final String? tag;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                title,
                style: theme.textTheme.titleSmall?.copyWith(
                  color: BoardCanvasPalette.navy,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            if (tag != null) ...[
              const SizedBox(width: 8),
              _EvidenceTag(label: tag!),
            ],
          ],
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 2),
          Text(
            subtitle!,
            style: theme.textTheme.bodySmall?.copyWith(
              color: BoardCanvasPalette.muted,
            ),
          ),
        ],
      ],
    );
  }
}

class _EvidenceTag extends StatelessWidget {
  const _EvidenceTag({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: BoardCanvasPalette.tile,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: BoardCanvasPalette.rule),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: BoardCanvasPalette.navy,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _InspectorField extends StatelessWidget {
  const _InspectorField({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        '$label: $value',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: BoardCanvasPalette.muted,
            ),
      ),
    );
  }
}

class _PhotoAlignmentReadinessPanel extends StatelessWidget {
  const _PhotoAlignmentReadinessPanel({required this.alignments});

  final List<PhotoToBoardAlignmentFact> alignments;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: BoardCanvasPalette.tile,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: BoardCanvasPalette.rule),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 220),
        child: DefaultTextStyle.merge(
          style: theme.textTheme.bodySmall?.copyWith(
            color: BoardCanvasPalette.muted,
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const InspectorSectionHeader(
                  title: 'Photo alignment readiness — metadata only',
                  tag: 'READINESS',
                ),
                const SizedBox(height: 6),
                const Text('Stores alignment reference points only.'),
                const Text(
                  'Does not confirm identity, nets, measurements, or faults.',
                ),
                const Text(
                    'No photo-local evidence is rendered on board canvas.'),
                const Text('No transform is computed.'),
                const Text('Not electrical proof.'),
                const SizedBox(height: 8),
                ...alignments.map(
                  (alignment) =>
                      _PhotoAlignmentSummaryTile(alignment: alignment),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PhotoAlignmentSummaryTile extends StatelessWidget {
  const _PhotoAlignmentSummaryTile({required this.alignment});

  final PhotoToBoardAlignmentFact alignment;

  @override
  Widget build(BuildContext context) {
    final referencePairCount = math.min(
      alignment.referencePointsPhoto.length,
      alignment.referencePointsBoard.length,
    );
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: BoardCanvasPalette.rule),
          color: BoardCanvasPalette.tile,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _InspectorField(
                  label: 'Alignment ID', value: alignment.alignmentId),
              _InspectorField(
                  label: 'Source photo ID', value: alignment.sourcePhotoId),
              _InspectorField(label: 'Board side', value: alignment.boardSide),
              _InspectorField(
                label: 'Coordinate space from',
                value: alignment.coordinateSpaceFrom,
              ),
              _InspectorField(
                label: 'Coordinate space to',
                value: alignment.coordinateSpaceTo,
              ),
              _InspectorField(
                label: 'Reference pairs',
                value: referencePairCount.toString(),
              ),
              _InspectorField(
                label: 'declared type — not computed',
                value: alignment.transformType,
              ),
              _InspectorField(
                label: 'Alignment quality label',
                value: alignment.alignmentQualityLabel,
              ),
              _InspectorField(
                label: 'Source event ID',
                value: alignment.sourceEventId,
              ),
              _InspectorField(label: 'Status', value: alignment.status),
            ],
          ),
        ),
      ),
    );
  }
}

String _displayDirectionLabel(String from, String? to) {
  final trimmedFrom = from.trim();
  final trimmedTo = to?.trim();
  if (trimmedTo == null || trimmedTo.isEmpty) {
    return trimmedFrom;
  }
  return '$trimmedFrom -> $trimmedTo';
}

String? _firstPresentText(Iterable<String?> values) {
  for (final value in values) {
    final trimmed = value?.trim();
    if (trimmed != null && trimmed.isNotEmpty) {
      return trimmed;
    }
  }
  return null;
}

String _identityStatus(ComponentFact? component) {
  if (component == null) {
    return 'unknown';
  }

  final status = component.status?.toLowerCase();
  final type = component.type?.trim();
  const confirmedStates = {
    'human_confirmed',
    'user_confirmed',
    'confirmed',
    'identity_confirmed',
  };

  if (type != null && type.isNotEmpty && confirmedStates.contains(status)) {
    return 'human-confirmed ($type)';
  }

  return 'unknown';
}
