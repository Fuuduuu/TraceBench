import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/app.dart';
import '../../../shared/footprints/footprint_models.dart';
import '../../../shared/footprints/vector_footprint_library.dart';
import '../../../shared/models/known_facts.dart';
import '../../../shared/models/project_state.dart';

class BoardCanvasScreen extends ConsumerStatefulWidget {
  const BoardCanvasScreen({super.key});

  @override
  ConsumerState<BoardCanvasScreen> createState() => _BoardCanvasScreenState();
}

class _BoardCanvasScreenState extends ConsumerState<BoardCanvasScreen> {
  String? _selectedPlacementKey;

  @override
  Widget build(BuildContext context) {
    final ProjectState? projectState = ref.watch(projectStateProvider);

    if (projectState == null) {
      return _buildScaffold(
        context,
        const _EmptyState(
          title: 'Open a project to view its board.',
        ),
      );
    }

    final knownFacts = projectState.knownFacts;
    if (knownFacts.components.isEmpty) {
      return _buildScaffold(
        context,
        const _EmptyState(
          title: 'No components recorded for this project.',
        ),
      );
    }

    final allPlacements = knownFacts.componentVisualPlacements;
    if (allPlacements.isEmpty) {
      return _buildScaffold(
        context,
        const _EmptyState(
          title: 'No confirmed visual placements yet.',
          subtitle:
              'Board canvas is read-only in V1. Placement workflow is a future step.',
        ),
      );
    }

    final renderable = allPlacements
        .where((placement) => placement.coordinateSpace == 'board_normalized')
        .toList(growable: false);

    if (renderable.isEmpty) {
      return _buildScaffold(
        context,
        const _EmptyState(
          title:
              'No board-normalized placements available for this read-only canvas.',
        ),
      );
    }

    final componentsById = <String, ComponentFact>{
      for (final component in knownFacts.components)
        component.componentId: component,
    };

    final entries = renderable
        .map(
          (placement) => _PlacementEntry(
            placement: placement,
            component: componentsById[placement.componentId],
            template: placement.templateId == null
                ? null
                : VectorFootprintLibrary.templateById(placement.templateId!),
          ),
        )
        .toList(growable: false);
    final photoToBoardAlignments = knownFacts.photoToBoardAlignments;

    final selectedKey = _coerceSelection(entries);
    _PlacementEntry? selectedEntry;
    if (selectedKey != null) {
      for (final entry in entries) {
        if (entry.key == selectedKey) {
          selectedEntry = entry;
          break;
        }
      }
    }
    final relatedMeasurements = selectedEntry == null
        ? const <MeasurementFact>[]
        : _measurementsForComponent(
            knownFacts.measurements,
            selectedEntry.placement.componentId,
          );
    final relatedVisualTraces = selectedEntry == null
        ? const <VisualTraceFact>[]
        : _visualTracesForComponent(
            knownFacts.visualTraces,
            selectedEntry.placement.componentId,
          );

    return _buildScaffold(
      context,
      Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (photoToBoardAlignments.isNotEmpty) ...[
              _PhotoAlignmentReadinessPanel(
                alignments: photoToBoardAlignments,
              ),
              const SizedBox(height: 16),
            ],
            _PlacementSelector(
              entries: entries,
              selectedKey: selectedKey,
              onSelected: (value) {
                setState(() {
                  _selectedPlacementKey = value;
                });
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final canvas = _CanvasPanel(
                    entries: entries,
                    selectedKey: selectedKey,
                  );
                  final inspector = _InspectorPanel(
                    selectedEntry: selectedEntry,
                    relatedMeasurements: relatedMeasurements,
                    relatedVisualTraces: relatedVisualTraces,
                  );

                  if (constraints.maxWidth >= 980) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 7, child: canvas),
                        const SizedBox(width: 16),
                        Expanded(flex: 4, child: inspector),
                      ],
                    );
                  }

                  return Column(
                    children: [
                      Expanded(flex: 3, child: canvas),
                      const SizedBox(height: 12),
                      Expanded(flex: 2, child: inspector),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<MeasurementFact> _measurementsForComponent(
    List<MeasurementFact> measurements,
    String componentId,
  ) {
    return measurements
        .where((measurement) {
          return _measurementEndpointMatchesComponent(measurement.from, componentId) ||
              _measurementEndpointMatchesComponent(measurement.to, componentId);
        })
        .toList(growable: false);
  }

  bool _measurementEndpointMatchesComponent(String endpoint, String componentId) {
    return endpoint == componentId || endpoint.startsWith('$componentId.');
  }

  List<VisualTraceFact> _visualTracesForComponent(
    List<VisualTraceFact> visualTraces,
    String componentId,
  ) {
    return visualTraces
        .where(
          (trace) =>
              trace.fromComponent == componentId ||
              trace.toComponent == componentId ||
              _visualTracePinMatchesComponent(trace.fromPin, componentId) ||
              _visualTracePinMatchesComponent(trace.toPin, componentId),
        )
        .toList(growable: false);
  }

  bool _visualTracePinMatchesComponent(String? pinId, String componentId) {
    if (pinId == null) {
      return false;
    }
    return pinId.startsWith('$componentId.');
  }

  String? _coerceSelection(List<_PlacementEntry> entries) {
    if (entries.isEmpty) {
      if (_selectedPlacementKey != null) {
        _selectedPlacementKey = null;
      }
      return null;
    }

    final current = _selectedPlacementKey;
    if (current != null && entries.any((entry) => entry.key == current)) {
      return current;
    }

    if (_selectedPlacementKey != null) {
      _selectedPlacementKey = null;
    }
    return null;
  }

  Widget _buildScaffold(BuildContext context, Widget content) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Board Canvas'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: content),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              child: const Text(
                'renderer writes: none',
                key: Key('renderer_writes_none'),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.title, this.subtitle});

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 8),
              Text(
                subtitle!,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ],
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
    return Card(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 220),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Photo alignment readiness — metadata only',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 6),
              const Text('Stores alignment reference points only.'),
              const Text(
                'Does not confirm identity, nets, measurements, or faults.',
              ),
              const Text('No photo-local evidence is rendered on board canvas.'),
              const Text('No transform is computed.'),
              const Text('Not electrical proof.'),
              const SizedBox(height: 8),
              ...alignments
                  .map(
                    (alignment) => _PhotoAlignmentSummaryTile(alignment: alignment),
                  )
                  .toList(growable: false),
            ],
          ),
        ),
      ),
    );
  }
}

class _PlacementSelector extends StatelessWidget {
  const _PlacementSelector({
    required this.entries,
    required this.selectedKey,
    required this.onSelected,
  });

  final List<_PlacementEntry> entries;
  final String? selectedKey;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Placement selection (read-only)',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: entries
                  .map(
                    (entry) => ChoiceChip(
                      key: Key('placement_selector_${entry.key}'),
                      label: Text(entry.selectorLabel),
                      selected: selectedKey == entry.key,
                      onSelected: (_) => onSelected(entry.key),
                    ),
                  )
                  .toList(growable: false),
            ),
          ],
        ),
      ),
    );
  }
}

class _CanvasPanel extends StatelessWidget {
  const _CanvasPanel({required this.entries, required this.selectedKey});

  final List<_PlacementEntry> entries;
  final String? selectedKey;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return CustomPaint(
              key: const Key('board_canvas_painter'),
              painter: _BoardPlacementPainter(
                entries: entries,
                selectedKey: selectedKey,
                colorScheme: Theme.of(context).colorScheme,
              ),
              child: SizedBox(
                width: math.max(240, constraints.maxWidth),
                height: math.max(220, constraints.maxHeight),
              ),
            );
          },
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
          border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _InspectorField(label: 'Alignment ID', value: alignment.alignmentId),
              _InspectorField(label: 'Source photo ID', value: alignment.sourcePhotoId),
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
                label: 'reference pairs',
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

class _InspectorPanel extends StatelessWidget {
  const _InspectorPanel({
    required this.selectedEntry,
    required this.relatedMeasurements,
    required this.relatedVisualTraces,
  });

  final _PlacementEntry? selectedEntry;
  final List<MeasurementFact> relatedMeasurements;
  final List<VisualTraceFact> relatedVisualTraces;

  @override
  Widget build(BuildContext context) {
    if (selectedEntry == null) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text('Select a placement to view read-only details.'),
          ),
        ),
      );
    }

    final entry = selectedEntry!;
    final placement = entry.placement;
    final component = entry.component;
    final packageLabel = entry.template?.displayName ?? 'Unknown package geometry';
    final templateId = placement.templateId ?? 'not provided';

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Placement inspector (read-only)',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              _InspectorField(label: 'Component ID', value: placement.componentId),
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
              _InspectorField(
                label: 'Identity status',
                value: _identityStatus(component),
              ),
              _InspectorField(
                label: 'Electrical role',
                value: 'not confirmed',
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 6),
                child: Text('Template does not prove electrical identity.'),
              ),
              _InspectorField(label: 'Placement status', value: placement.status),
              _InspectorField(
                label: 'Coordinate space',
                value: placement.coordinateSpace,
              ),
              _InspectorField(label: 'Board side', value: placement.boardSide),
              _InspectorField(label: 'Center X', value: placement.centerX.toString()),
              _InspectorField(label: 'Center Y', value: placement.centerY.toString()),
              _InspectorField(
                label: 'Rotation (deg)',
                value: placement.rotationDeg.toString(),
              ),
              if (placement.scale != null)
                _InspectorField(label: 'Scale', value: placement.scale.toString())
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
              const SizedBox(height: 10),
              Text(
                'Measurement — read-only summary',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 6),
              const Text('Value shown verbatim'),
              const Text('Does not create or confirm a net'),
              const Text('No board coordinate available'),
              if (relatedMeasurements.isEmpty) ...[
                const SizedBox(height: 6),
                const Text('No related measurements for selected component.'),
              ] else ...[
                const SizedBox(height: 8),
                ...relatedMeasurements
                    .map(
                      (measurement) => _MeasurementSummaryTile(
                        measurement: measurement,
                      ),
                    )
                    .toList(growable: false),
              ],
              const SizedBox(height: 10),
              Text(
                'Visual trace — read-only metadata',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 6),
              const Text('Visual trace is not a confirmed electrical net'),
              const Text('Photo-local evidence; no board coordinate available'),
              const Text('Does not create or confirm connectivity'),
              if (relatedVisualTraces.isEmpty) ...[
                const SizedBox(height: 6),
                const Text('No related visual traces for selected component.'),
              ] else ...[
                const SizedBox(height: 8),
                ...relatedVisualTraces
                    .map(
                      (trace) => _VisualTraceSummaryTile(trace: trace),
                    )
                    .toList(growable: false),
              ],
            ],
          ),
        ),
      ),
    );
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
}

class _MeasurementSummaryTile extends StatelessWidget {
  const _MeasurementSummaryTile({required this.measurement});

  final MeasurementFact measurement;

  @override
  Widget build(BuildContext context) {
    final isStale = measurement.validityStatus == 'stale_after_repair';
    final valueText = measurement.value == null
        ? measurement.reading
        : '${measurement.value}${measurement.unit == null ? '' : ' ${measurement.unit}'}';

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _InspectorField(label: 'Measurement ID', value: measurement.measurementId),
              _InspectorField(label: 'Mode', value: measurement.mode),
              _InspectorField(label: 'From', value: measurement.from),
              _InspectorField(label: 'To', value: measurement.to),
              _InspectorField(label: 'Value', value: valueText),
              _InspectorField(label: 'Power state', value: measurement.powerState),
              _InspectorField(label: 'Validity status', value: measurement.validityStatus),
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

class _VisualTraceSummaryTile extends StatelessWidget {
  const _VisualTraceSummaryTile({required this.trace});

  final VisualTraceFact trace;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _InspectorField(label: 'Trace ID', value: trace.traceId),
              _InspectorField(label: 'Photo ID', value: trace.photoId),
              _InspectorField(label: 'Evidence type', value: trace.evidenceType),
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
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}

class _PlacementEntry {
  const _PlacementEntry({
    required this.placement,
    required this.component,
    required this.template,
  });

  final ComponentVisualPlacementFact placement;
  final ComponentFact? component;
  final FootprintTemplate? template;

  String get key => '${placement.componentId}|${placement.sourceEventId}';

  String get selectorLabel {
    final designator = component?.designator?.trim();
    if (designator != null && designator.isNotEmpty) {
      return '$designator (${placement.componentId})';
    }
    return placement.componentId;
  }
}

class _BoardPlacementPainter extends CustomPainter {
  _BoardPlacementPainter({
    required this.entries,
    required this.selectedKey,
    required this.colorScheme,
  });

  final List<_PlacementEntry> entries;
  final String? selectedKey;
  final ColorScheme colorScheme;

  @override
  void paint(Canvas canvas, Size size) {
    final boardRect = Rect.fromLTWH(0, 0, size.width, size.height);

    final boardPaint = Paint()
      ..color = colorScheme.surfaceContainerLowest
      ..style = PaintingStyle.fill;
    canvas.drawRect(boardRect, boardPaint);

    final borderPaint = Paint()
      ..color = colorScheme.outline
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawRect(boardRect.deflate(0.5), borderPaint);

    for (final entry in entries) {
      final placement = entry.placement;
      final normalizedX = placement.centerX.toDouble().clamp(0.0, 1.0);
      final normalizedY = placement.centerY.toDouble().clamp(0.0, 1.0);
      final center = Offset(normalizedX * size.width, normalizedY * size.height);
      final bodySize = _placementBodySize(entry);
      final selected = entry.key == selectedKey;

      final fillPaint = Paint()
        ..color = selected
            ? colorScheme.primary.withValues(alpha: 0.35)
            : colorScheme.tertiaryContainer.withValues(alpha: 0.65)
        ..style = PaintingStyle.fill;

      final strokePaint = Paint()
        ..color = selected ? colorScheme.primary : colorScheme.outline
        ..style = PaintingStyle.stroke
        ..strokeWidth = selected ? 2 : 1.2;

      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.rotate(placement.rotationDeg.toDouble() * math.pi / 180.0);

      final rect = Rect.fromCenter(
        center: Offset.zero,
        width: bodySize.width,
        height: bodySize.height,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(4)),
        fillPaint,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(4)),
        strokePaint,
      );

      canvas.restore();

      final designator = entry.component?.designator;
      if (designator != null && designator.trim().isNotEmpty) {
        final textPainter = TextPainter(
          textDirection: TextDirection.ltr,
          text: TextSpan(
            text: designator,
            style: TextStyle(
              color: colorScheme.onSurface,
              fontSize: 11,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        )..layout(maxWidth: 120);
        textPainter.paint(
          canvas,
          Offset(
            (center.dx + 6).clamp(0.0, math.max(0.0, size.width - textPainter.width)),
            (center.dy + 6)
                .clamp(0.0, math.max(0.0, size.height - textPainter.height)),
          ),
        );
      }
    }
  }

  Size _placementBodySize(_PlacementEntry entry) {
    final placement = entry.placement;
    if (placement.scale != null) {
      final scale = placement.scale!.toDouble();
      final base = 28.0;
      final scaled = (base * scale).clamp(8.0, 140.0);
      return Size(scaled, (scaled * 0.66).clamp(6.0, 120.0));
    }

    if (placement.width != null && placement.height != null) {
      final width = (placement.width!.toDouble() * 60).clamp(8.0, 140.0);
      final height = (placement.height!.toDouble() * 60).clamp(6.0, 120.0);
      return Size(width, height);
    }

    final template = entry.template;
    if (template != null) {
      final width = (template.body.width * 40).clamp(8.0, 140.0);
      final height = (template.body.height * 40).clamp(6.0, 120.0);
      return Size(width, height);
    }

    return const Size(24, 16);
  }

  @override
  bool shouldRepaint(covariant _BoardPlacementPainter oldDelegate) {
    if (oldDelegate.selectedKey != selectedKey) {
      return true;
    }
    if (oldDelegate.colorScheme != colorScheme) {
      return true;
    }
    return !_entriesEquivalent(oldDelegate.entries, entries);
  }

  static bool _entriesEquivalent(
    List<_PlacementEntry> left,
    List<_PlacementEntry> right,
  ) {
    if (identical(left, right)) {
      return true;
    }
    if (left.length != right.length) {
      return false;
    }
    for (var index = 0; index < left.length; index++) {
      if (!_entryEquivalent(left[index], right[index])) {
        return false;
      }
    }
    return true;
  }

  static bool _entryEquivalent(_PlacementEntry left, _PlacementEntry right) {
    final leftPlacement = left.placement;
    final rightPlacement = right.placement;
    if (leftPlacement.componentId != rightPlacement.componentId ||
        leftPlacement.coordinateSpace != rightPlacement.coordinateSpace ||
        leftPlacement.boardSide != rightPlacement.boardSide ||
        leftPlacement.centerX != rightPlacement.centerX ||
        leftPlacement.centerY != rightPlacement.centerY ||
        leftPlacement.rotationDeg != rightPlacement.rotationDeg ||
        leftPlacement.scale != rightPlacement.scale ||
        leftPlacement.width != rightPlacement.width ||
        leftPlacement.height != rightPlacement.height ||
        leftPlacement.templateId != rightPlacement.templateId ||
        leftPlacement.sourceEventId != rightPlacement.sourceEventId ||
        leftPlacement.status != rightPlacement.status) {
      return false;
    }

    final leftDesignator = left.component?.designator ?? '';
    final rightDesignator = right.component?.designator ?? '';
    if (leftDesignator != rightDesignator) {
      return false;
    }

    final leftTemplate = left.template;
    final rightTemplate = right.template;
    if ((leftTemplate == null) != (rightTemplate == null)) {
      return false;
    }
    if (leftTemplate == null || rightTemplate == null) {
      return true;
    }

    return leftTemplate.templateId == rightTemplate.templateId &&
        leftTemplate.templateVersion == rightTemplate.templateVersion &&
        leftTemplate.body.width == rightTemplate.body.width &&
        leftTemplate.body.height == rightTemplate.body.height;
  }
}
