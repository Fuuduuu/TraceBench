import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/board_canvas_palette.dart';

// Read-only catalogue and presentation. Callers retain drafts, selection,
// validation, gestures, placement geometry semantics and writer handoff.
enum PlacementTemplateBodyShape {
  rectangular,
  smallThreeSide,
  dualRow,
  quadRow,
  connectorStrip,
  radialRound,
  genericBlank,
}

class PlacementTemplateDefinition {
  const PlacementTemplateDefinition({
    required this.id,
    required this.templateFamily,
    required this.topContactMarkers,
    required this.rightContactMarkers,
    required this.bottomContactMarkers,
    required this.leftContactMarkers,
    required this.example,
  });

  final String id;
  final String templateFamily;
  final int topContactMarkers;
  final int rightContactMarkers;
  final int bottomContactMarkers;
  final int leftContactMarkers;
  final String example;

  PlacementTemplateBodyShape get bodyShape {
    switch (id) {
      case 'template_family_radial_round':
        return PlacementTemplateBodyShape.radialRound;
      case 'template_family_connector_strip':
        return PlacementTemplateBodyShape.connectorStrip;
      case 'template_family_small_3_side_package':
        return PlacementTemplateBodyShape.smallThreeSide;
      case 'template_family_rect_2_top_bottom':
        return PlacementTemplateBodyShape.rectangular;
      case 'template_family_generic_blank':
        return PlacementTemplateBodyShape.genericBlank;
      case 'template_family_rect_4_perimeter':
        return PlacementTemplateBodyShape.dualRow;
      case 'template_family_rect_6_edge_balance':
        return PlacementTemplateBodyShape.quadRow;
      default:
        return PlacementTemplateBodyShape.genericBlank;
    }
  }

  double get bodyAspectRatio {
    switch (bodyShape) {
      case PlacementTemplateBodyShape.radialRound:
        return 1.0;
      case PlacementTemplateBodyShape.connectorStrip:
        return 4.0;
      case PlacementTemplateBodyShape.smallThreeSide:
        return 1.35;
      case PlacementTemplateBodyShape.dualRow:
        return 1.65;
      case PlacementTemplateBodyShape.quadRow:
        return 1.2;
      case PlacementTemplateBodyShape.rectangular:
        return 2.4;
      case PlacementTemplateBodyShape.genericBlank:
        return 2.0;
    }
  }

  bool get isRoundTemplateBody =>
      bodyShape == PlacementTemplateBodyShape.radialRound;

  bool get isConnectorStripTemplateBody =>
      bodyShape == PlacementTemplateBodyShape.connectorStrip;

  String get shortTemplateShapeName {
    final familyPrefix = templateFamily.split('—').first.trim();
    return familyPrefix
        .replaceAll(RegExp(r'template family', caseSensitive: false), '')
        .trim();
  }

  int get contactMarkerCount =>
      topContactMarkers +
      rightContactMarkers +
      bottomContactMarkers +
      leftContactMarkers;

  String get contactMarkerSummaryShort {
    final count = contactMarkerCount;
    return '$count ${count == 1 ? 'contact' : 'contacts'}';
  }

  String get contactMarkerSummary {
    return 'Top: $topContactMarkers, Right: $rightContactMarkers, '
        'Bottom: $bottomContactMarkers, Left: $leftContactMarkers';
  }
}

const starterPlacementTemplates = <PlacementTemplateDefinition>[
  PlacementTemplateDefinition(
    id: 'template_family_rect_2_top_bottom',
    templateFamily: 'Rectangular chip',
    topContactMarkers: 1,
    rightContactMarkers: 0,
    bottomContactMarkers: 1,
    leftContactMarkers: 0,
    example: 'Rectangular chip style with paired vertical contact markers.',
  ),
  PlacementTemplateDefinition(
    id: 'template_family_rect_4_perimeter',
    templateFamily: 'Dual-row package',
    topContactMarkers: 0,
    rightContactMarkers: 4,
    bottomContactMarkers: 0,
    leftContactMarkers: 4,
    example: 'Dual-row package visual layout with four local contact markers.',
  ),
  PlacementTemplateDefinition(
    id: 'template_family_rect_6_edge_balance',
    templateFamily: 'Quad-row package',
    topContactMarkers: 2,
    rightContactMarkers: 2,
    bottomContactMarkers: 2,
    leftContactMarkers: 2,
    example: 'Quad-row package style with four-side contact markers.',
  ),
  PlacementTemplateDefinition(
    id: 'template_family_small_3_side_package',
    templateFamily: 'Small 3-side package',
    topContactMarkers: 1,
    rightContactMarkers: 1,
    bottomContactMarkers: 1,
    leftContactMarkers: 0,
    example: 'Small 3-side package starter with three visual-contact markers.',
  ),
  PlacementTemplateDefinition(
    id: 'template_family_connector_strip',
    templateFamily: 'Connector strip',
    topContactMarkers: 4,
    rightContactMarkers: 0,
    bottomContactMarkers: 0,
    leftContactMarkers: 0,
    example: 'Connector strip profile for one-row local markers.',
  ),
  PlacementTemplateDefinition(
    id: 'template_family_radial_round',
    templateFamily: 'Radial / round',
    topContactMarkers: 1,
    rightContactMarkers: 0,
    bottomContactMarkers: 1,
    leftContactMarkers: 0,
    example: 'Radial visual template with paired contacts.',
  ),
  PlacementTemplateDefinition(
    id: 'template_family_generic_blank',
    templateFamily: 'Generic blank',
    topContactMarkers: 0,
    rightContactMarkers: 0,
    bottomContactMarkers: 0,
    leftContactMarkers: 0,
    example: 'Generic blank template starts with zero local markers.',
  ),
];

PlacementTemplateDefinition? placementTemplateById(
  String? templateId,
) {
  final normalizedTemplateId = templateId?.trim();
  if (normalizedTemplateId == null || normalizedTemplateId.isEmpty) {
    return null;
  }
  for (final template in starterPlacementTemplates) {
    if (template.id == normalizedTemplateId) {
      return template;
    }
  }
  return null;
}

class PlacementTemplateChooser extends StatelessWidget {
  const PlacementTemplateChooser(
      {super.key, this.selectedTemplateId, required this.onTemplateSelected});
  final String? selectedTemplateId;
  final ValueChanged<String> onTemplateSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final templateRows = starterPlacementTemplates
        .map(
          (entry) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _PlacementTemplateListTile(
              entry: entry,
              selected: selectedTemplateId == entry.id,
              onTap: () => onTemplateSelected(entry.id),
            ),
          ),
        )
        .toList(growable: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(2, 0, 2, 6),
          child: Text(
            'Vali kuju',
            key: const Key(
              'board_canvas_add_component_template_picker_label',
            ),
            textAlign: TextAlign.center,
            style: theme.textTheme.labelSmall?.copyWith(
              color: BoardCanvasPalette.signal,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.zero,
          key: const Key(
            'board_canvas_add_component_template_list_rows',
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: templateRows,
          ),
        ),
      ],
    );
  }
}

class PlacementTemplatePreview extends StatelessWidget {
  const PlacementTemplatePreview(
      {super.key,
      required this.template,
      required this.topContactMarkers,
      required this.rightContactMarkers,
      required this.bottomContactMarkers,
      required this.leftContactMarkers});
  final PlacementTemplateDefinition template;
  final int topContactMarkers;
  final int rightContactMarkers;
  final int bottomContactMarkers;
  final int leftContactMarkers;

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: Key(
        'board_canvas_add_component_builder_preview_${template.id}',
      ),
      child: AspectRatio(
        aspectRatio: template.bodyAspectRatio,
        child: CustomPaint(
          key: const Key(
            'board_canvas_add_component_builder_preview',
          ),
          painter: PlacementTemplatePreviewPainter(
            template: template,
            topContactMarkers: topContactMarkers,
            rightContactMarkers: rightContactMarkers,
            bottomContactMarkers: bottomContactMarkers,
            leftContactMarkers: leftContactMarkers,
          ),
        ),
      ),
    );
  }
}

Widget _buildTemplateMiniShape(
  BuildContext context,
  PlacementTemplateDefinition template, {
  double width = 22,
  double height = 14,
}) {
  final isRadialRound = template.isRoundTemplateBody;
  final isConnector = template.isConnectorStripTemplateBody;
  final isGenericBlank =
      template.bodyShape == PlacementTemplateBodyShape.genericBlank;
  final isSmallThreeSide =
      template.bodyShape == PlacementTemplateBodyShape.smallThreeSide;
  final isQuadRow = template.bodyShape == PlacementTemplateBodyShape.quadRow;

  final double shapeWidth = isRadialRound
      ? height
      : isConnector
          ? 26
          : isSmallThreeSide
              ? 16
              : isQuadRow
                  ? 26
                  : width;

  final double shapeHeight = isRadialRound
      ? width
      : isConnector
          ? 8
          : isSmallThreeSide
              ? 16
              : isQuadRow
                  ? 16
                  : height;

  return Container(
    width: shapeWidth,
    height: shapeHeight,
    decoration: BoxDecoration(
      borderRadius: isRadialRound ? null : BorderRadius.circular(4),
      shape: isRadialRound ? BoxShape.circle : BoxShape.rectangle,
      border: Border.all(
        color: isGenericBlank
            ? BoardCanvasPalette.ruleStrong
            : BoardCanvasPalette.navy,
      ),
    ),
    child: isRadialRound
        ? null
        : Center(
            child: Container(
              width: (shapeWidth / 1.45).clamp(6.0, 20.0),
              height: (shapeHeight / 1.45).clamp(4.0, 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(isGenericBlank ? 1 : 2),
                border: Border.all(
                  color: BoardCanvasPalette.signal,
                  width: isConnector ? 0.8 : 1,
                ),
              ),
            ),
          ),
  );
}

class PlacementTemplateSelectedSummary extends StatelessWidget {
  const PlacementTemplateSelectedSummary({
    super.key,
    required this.template,
    required this.onChangeTemplate,
  });

  final PlacementTemplateDefinition template;
  final VoidCallback onChangeTemplate;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final title = template.shortTemplateShapeName;
    return Container(
      key: const Key('board_canvas_add_component_template_summary'),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: BoardCanvasPalette.tile,
        border: Border.all(color: BoardCanvasPalette.rule),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            key: const Key(
              'board_canvas_add_component_template_summary_shape',
            ),
            child: _buildTemplateMiniShape(
              context,
              template,
              width: 28,
              height: 20,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: BoardCanvasPalette.navy,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  template.contactMarkerSummaryShort,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: BoardCanvasPalette.muted,
                  ),
                ),
                const SizedBox(height: 2),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 1,
                  ),
                  decoration: BoxDecoration(
                    color: BoardCanvasPalette.signalTint,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: BoardCanvasPalette.rule),
                  ),
                  child: Text(
                    'Mustand',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: BoardCanvasPalette.signal,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 6),
          TextButton(
            key: const Key('board_canvas_add_component_change_template'),
            onPressed: onChangeTemplate,
            style: TextButton.styleFrom(
              visualDensity: VisualDensity.compact,
              padding: const EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 0,
              ),
              minimumSize: const Size(0, 24),
              textStyle: theme.textTheme.labelSmall,
              foregroundColor: BoardCanvasPalette.muted,
            ),
            child: const Text('Muuda kuju'),
          ),
          const SizedBox(width: 2),
          Icon(
            Icons.check_circle_rounded,
            size: 16,
            color: BoardCanvasPalette.signal,
            key: Key(
              'board_canvas_add_component_template_${template.id}_selected',
            ),
            semanticLabel: 'selected',
          ),
        ],
      ),
    );
  }
}

class PlacementDraftPreviewCard extends StatelessWidget {
  const PlacementDraftPreviewCard({
    super.key,
    required this.template,
    required this.draftWidth,
    required this.draftHeight,
    required this.draftRotationDeg,
    required this.topContactMarkers,
    required this.rightContactMarkers,
    required this.bottomContactMarkers,
    required this.leftContactMarkers,
  });

  final PlacementTemplateDefinition template;
  final double draftWidth;
  final double draftHeight;
  final int draftRotationDeg;
  final int topContactMarkers;
  final int rightContactMarkers;
  final int bottomContactMarkers;
  final int leftContactMarkers;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      key: const Key('board_canvas_add_component_builder_preview_section'),
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: BoardCanvasPalette.paper,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: BoardCanvasPalette.rule),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Eelvaade',
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: BoardCanvasPalette.navy,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: BoardCanvasPalette.tile,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: BoardCanvasPalette.rule),
                ),
                child: Text(
                  'Draft / unsaved',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: BoardCanvasPalette.navy,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 150,
                maxHeight: 70,
              ),
              child: AspectRatio(
                aspectRatio: template.bodyAspectRatio,
                child: CustomPaint(
                  key: const Key(
                    'board_canvas_add_component_builder_local_preview',
                  ),
                  painter: PlacementTemplatePreviewPainter(
                    template: template,
                    topContactMarkers: topContactMarkers,
                    rightContactMarkers: rightContactMarkers,
                    bottomContactMarkers: bottomContactMarkers,
                    leftContactMarkers: leftContactMarkers,
                    dashedBoundary: true,
                    strokeWidth: 2,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Suurus: ${draftWidth.toStringAsFixed(2)} × ${draftHeight.toStringAsFixed(2)}',
            key: const Key(
              'board_canvas_add_component_builder_preview_size_value',
            ),
            style: theme.textTheme.labelSmall?.copyWith(
              color: BoardCanvasPalette.muted,
            ),
          ),
          Text(
            'Pööre: $draftRotationDeg°',
            key: const Key(
              'board_canvas_add_component_builder_preview_rotation_value',
            ),
            style: theme.textTheme.labelSmall?.copyWith(
              color: BoardCanvasPalette.muted,
            ),
          ),
        ],
      ),
    );
  }
}

class PlacementTemplatePreviewPainter extends CustomPainter {
  const PlacementTemplatePreviewPainter({
    required this.template,
    required this.topContactMarkers,
    required this.rightContactMarkers,
    required this.bottomContactMarkers,
    required this.leftContactMarkers,
    this.boundaryColor = const Color(0xFF5C6BC0),
    this.markerColor = const Color(0xFF2E7D32),
    this.fillColor = Colors.transparent,
    this.strokeWidth = 1.8,
    this.dashedBoundary = false,
  });

  final PlacementTemplateDefinition template;
  final int topContactMarkers;
  final int rightContactMarkers;
  final int bottomContactMarkers;
  final int leftContactMarkers;
  final Color boundaryColor;
  final Color markerColor;
  final Color fillColor;
  final double strokeWidth;
  final bool dashedBoundary;

  @override
  void paint(Canvas canvas, Size size) {
    const rectInsets = EdgeInsets.all(12.0);
    final paintArea = Offset.zero & size;
    final previewRect = Rect.fromLTWH(
      rectInsets.left,
      rectInsets.top,
      paintArea.width - rectInsets.horizontal,
      paintArea.height - rectInsets.vertical,
    );
    final bodyPath = _buildBodyPath(previewRect);

    final boundaryPaint = Paint()
      ..color = boundaryColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final markerPaint = Paint()
      ..color = markerColor
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    if (fillColor != Colors.transparent) {
      final fillPaint = Paint()
        ..color = fillColor
        ..style = PaintingStyle.fill;
      canvas.drawPath(bodyPath, fillPaint);
    }
    if (dashedBoundary) {
      _drawDashedPath(canvas, bodyPath, boundaryPaint);
    } else {
      canvas.drawPath(bodyPath, boundaryPaint);
    }

    _drawContactMarkersAlongTop(
      canvas,
      previewRect,
      topContactMarkers,
      markerPaint,
    );
    _drawContactMarkersAlongRight(
      canvas,
      previewRect,
      rightContactMarkers,
      markerPaint,
    );
    _drawContactMarkersAlongBottom(
      canvas,
      previewRect,
      bottomContactMarkers,
      markerPaint,
    );
    _drawContactMarkersAlongLeft(
      canvas,
      previewRect,
      leftContactMarkers,
      markerPaint,
    );
  }

  Path _buildBodyPath(Rect rect) {
    if (template.bodyShape == PlacementTemplateBodyShape.radialRound) {
      return Path()
        ..addOval(Rect.fromCircle(
            center: rect.center,
            radius: math.min(rect.width, rect.height) / 2));
    }

    final radius = template.bodyShape == PlacementTemplateBodyShape.genericBlank
        ? const Radius.circular(2)
        : const Radius.circular(4);
    return Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          rect,
          radius,
        ),
      );
  }

  void _drawDashedPath(
    Canvas canvas,
    Path path,
    Paint paint,
  ) {
    const dashLength = 6.0;
    const gap = 3.0;
    for (final metric in path.computeMetrics()) {
      var distance = metric.length;
      var offset = 0.0;
      while (distance > 0) {
        final segmentEnd = math.min(offset + dashLength, metric.length);
        final segment = metric.extractPath(offset, segmentEnd);
        canvas.drawPath(segment, paint);
        offset = segmentEnd + gap;
        distance = metric.length - offset;
      }
    }
  }

  void _drawContactMarkersAlongTop(
    Canvas canvas,
    Rect rect,
    int count,
    Paint paint,
  ) {
    if (count <= 0) {
      return;
    }
    if (count == 1) {
      final center = Offset(rect.center.dx, rect.top);
      canvas.drawCircle(center, 3.0, paint);
      return;
    }
    for (var i = 0; i < count; i++) {
      final x = rect.left + rect.width * ((i + 1) / (count + 1));
      final point = Offset(x, rect.top);
      canvas.drawCircle(point, 3.0, paint);
    }
  }

  void _drawContactMarkersAlongBottom(
    Canvas canvas,
    Rect rect,
    int count,
    Paint paint,
  ) {
    if (count <= 0) {
      return;
    }
    if (count == 1) {
      final center = Offset(rect.center.dx, rect.bottom);
      canvas.drawCircle(center, 3.0, paint);
      return;
    }
    for (var i = 0; i < count; i++) {
      final x = rect.left + rect.width * ((i + 1) / (count + 1));
      final point = Offset(x, rect.bottom);
      canvas.drawCircle(point, 3.0, paint);
    }
  }

  void _drawContactMarkersAlongLeft(
    Canvas canvas,
    Rect rect,
    int count,
    Paint paint,
  ) {
    if (count <= 0) {
      return;
    }
    if (count == 1) {
      final center = Offset(rect.left, rect.center.dy);
      canvas.drawCircle(center, 3.0, paint);
      return;
    }
    for (var i = 0; i < count; i++) {
      final y = rect.top + rect.height * ((i + 1) / (count + 1));
      final point = Offset(rect.left, y);
      canvas.drawCircle(point, 3.0, paint);
    }
  }

  void _drawContactMarkersAlongRight(
    Canvas canvas,
    Rect canvasRect,
    int count,
    Paint paint,
  ) {
    if (count <= 0) {
      return;
    }
    if (count == 1) {
      final center = Offset(canvasRect.right, canvasRect.center.dy);
      canvas.drawCircle(center, 3.0, paint);
      return;
    }
    for (var i = 0; i < count; i++) {
      final y = canvasRect.top + canvasRect.height * ((i + 1) / (count + 1));
      final point = Offset(canvasRect.right, y);
      canvas.drawCircle(point, 3.0, paint);
    }
  }

  @override
  bool shouldRepaint(
    covariant PlacementTemplatePreviewPainter oldDelegate,
  ) {
    return oldDelegate.template != template ||
        oldDelegate.topContactMarkers != topContactMarkers ||
        oldDelegate.rightContactMarkers != rightContactMarkers ||
        oldDelegate.bottomContactMarkers != bottomContactMarkers ||
        oldDelegate.leftContactMarkers != leftContactMarkers;
  }
}

class _PlacementTemplateListTile extends StatelessWidget {
  const _PlacementTemplateListTile({
    required this.entry,
    required this.selected,
    required this.onTap,
  });

  final PlacementTemplateDefinition entry;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final baseColor = selected
        ? BoardCanvasPalette.signalTint.withValues(alpha: 0.82)
        : BoardCanvasPalette.tile;
    final borderColor = selected
        ? BoardCanvasPalette.signal
        : BoardCanvasPalette.ruleStrong.withValues(alpha: 0.72);
    final shortShapeName = entry.shortTemplateShapeName;
    final contactCountText = entry.contactMarkerSummaryShort;

    return InkWell(
      key: Key('board_canvas_add_component_template_${entry.id}'),
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 6),
        decoration: BoxDecoration(
          color: baseColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: borderColor, width: selected ? 1.4 : 1),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: BoardCanvasPalette.signal.withValues(alpha: 0.14),
                    blurRadius: 9,
                    offset: const Offset(0, 3),
                  ),
                ]
              : null,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              selected
                  ? Icons.check_circle_rounded
                  : Icons.radio_button_unchecked_rounded,
              color: selected
                  ? BoardCanvasPalette.signal
                  : BoardCanvasPalette.muted,
              size: 16,
            ),
            const SizedBox(width: 6),
            Container(
              key: Key(
                'board_canvas_add_component_template_shape_${entry.id}',
              ),
              child: _buildTemplateMiniShape(
                context,
                entry,
                width: 20,
                height: 14,
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          shortShapeName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontWeight:
                                selected ? FontWeight.w700 : FontWeight.w500,
                            color: BoardCanvasPalette.navy,
                          ),
                        ),
                      ),
                      if (selected)
                        Icon(
                          Icons.label_important,
                          size: 16,
                          key: Key(
                            'board_canvas_add_component_template_${entry.id}_selected',
                          ),
                          color: BoardCanvasPalette.signal,
                          semanticLabel: 'selected',
                        ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    contactCountText,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: BoardCanvasPalette.muted,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
