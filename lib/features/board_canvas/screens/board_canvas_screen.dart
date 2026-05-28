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

    return _buildScaffold(
      context,
      Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
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
                  final inspector = _InspectorPanel(selectedEntry: selectedEntry);

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

class _InspectorPanel extends StatelessWidget {
  const _InspectorPanel({required this.selectedEntry});

  final _PlacementEntry? selectedEntry;

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
