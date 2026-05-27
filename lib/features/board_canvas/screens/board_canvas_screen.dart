import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/app.dart';
import '../../../shared/footprints/footprint_models.dart';
import '../../../shared/footprints/vector_footprint_library.dart';
import '../../../shared/models/known_facts.dart';
import '../../../shared/models/project_state.dart';

class BoardCanvasScreen extends ConsumerWidget {
  const BoardCanvasScreen({super.key});

  static const String noProjectText = 'Open a project to view its board.';
  static const String noComponentsText =
      'No components recorded for this project.';
  static const String noPlacementsText = 'No confirmed visual placements yet.';
  static const String noPlacementsSupportText =
      'Board canvas is read-only in V1. Placement workflow is a future step.';
  static const String noBoardNormalizedPlacementsText =
      'No board-normalized placements available for this read-only canvas.';
  static const String rendererWritesNoneText = 'renderer writes: none';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ProjectState? projectState = ref.watch(projectStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Board canvas'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: _BoardCanvasStateBody(projectState: projectState),
              ),
            ),
          ),
          const Divider(height: 1),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: Text(
              rendererWritesNoneText,
              key: ValueKey('board-canvas-read-only-status'),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class _BoardCanvasStateBody extends StatelessWidget {
  const _BoardCanvasStateBody({required this.projectState});

  final ProjectState? projectState;

  @override
  Widget build(BuildContext context) {
    if (projectState == null) {
      return const Text(
        BoardCanvasScreen.noProjectText,
        key: ValueKey('board-canvas-empty-no-project'),
        textAlign: TextAlign.center,
      );
    }

    final components = projectState!.knownFacts.components;
    if (components.isEmpty) {
      return const Text(
        BoardCanvasScreen.noComponentsText,
        key: ValueKey('board-canvas-empty-no-components'),
        textAlign: TextAlign.center,
      );
    }

    final placements = projectState!.knownFacts.componentVisualPlacements;
    if (placements.isEmpty) {
      return const Column(
        key: ValueKey('board-canvas-empty-no-placements'),
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            BoardCanvasScreen.noPlacementsText,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Text(
            BoardCanvasScreen.noPlacementsSupportText,
            textAlign: TextAlign.center,
          ),
        ],
      );
    }

    final renderablePlacements =
        _buildRenderablePlacements(projectState!.knownFacts);
    if (renderablePlacements.isEmpty) {
      return const Text(
        BoardCanvasScreen.noBoardNormalizedPlacementsText,
        key: ValueKey('board-canvas-empty-no-board-normalized'),
        textAlign: TextAlign.center,
      );
    }

    return _BoardCanvasPlacementSurface(
      renderablePlacements: renderablePlacements,
    );
  }
}

class _RenderablePlacement {
  const _RenderablePlacement({
    required this.componentId,
    required this.center,
    required this.rotationRad,
    required this.normalizedSize,
    required this.hasKnownTemplate,
    required this.isUnknownTemplateFamily,
    this.designator,
  });

  final String componentId;
  final Offset center;
  final double rotationRad;
  final Size normalizedSize;
  final bool hasKnownTemplate;
  final bool isUnknownTemplateFamily;
  final String? designator;
}

class _BoardCanvasPlacementSurface extends StatelessWidget {
  const _BoardCanvasPlacementSurface({
    required this.renderablePlacements,
  });

  final List<_RenderablePlacement> renderablePlacements;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double maxWidth =
            constraints.maxWidth.isFinite ? constraints.maxWidth : 320;
        final double maxHeight =
            constraints.maxHeight.isFinite ? constraints.maxHeight : 320;
        final double side = math.max(1, math.min(maxWidth, maxHeight));

        return SizedBox(
          key: const ValueKey('board-canvas-placement-surface'),
          width: side,
          height: side,
          child: Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: _BoardCanvasPlacementPainter(
                    renderablePlacements: renderablePlacements,
                  ),
                ),
              ),
              ..._buildDesignatorLabels(side),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _buildDesignatorLabels(double side) {
    final List<Widget> labels = [];
    for (final placement in renderablePlacements) {
      final String? designator = placement.designator;
      if (designator == null || designator.trim().isEmpty) {
        continue;
      }
      final double left = _clamp((placement.center.dx * side) + 6, 0, side - 84);
      final double top = _clamp((placement.center.dy * side) + 6, 0, side - 24);
      labels.add(
        Positioned(
          key: ValueKey('board-canvas-label-${placement.componentId}'),
          left: left,
          top: top,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              designator,
              style: const TextStyle(
                fontSize: 11,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      );
    }
    return labels;
  }
}

class _BoardCanvasPlacementPainter extends CustomPainter {
  const _BoardCanvasPlacementPainter({
    required this.renderablePlacements,
  });

  final List<_RenderablePlacement> renderablePlacements;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect boardRect = Offset.zero & size;
    canvas.drawRect(
      boardRect,
      Paint()..color = const Color(0xFF111827),
    );
    canvas.drawRect(
      Rect.fromLTWH(0.5, 0.5, size.width - 1, size.height - 1),
      Paint()
        ..color = const Color(0x663B82F6)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1,
    );

    for (final placement in renderablePlacements) {
      final double centerX = placement.center.dx * size.width;
      final double centerY = placement.center.dy * size.height;
      final double widthPx = placement.normalizedSize.width * size.width;
      final double heightPx = placement.normalizedSize.height * size.height;

      canvas.save();
      canvas.translate(centerX, centerY);
      canvas.rotate(placement.rotationRad);

      final RRect body = RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset.zero,
          width: widthPx,
          height: heightPx,
        ),
        const Radius.circular(4),
      );

      final Color fillColor = placement.hasKnownTemplate
          ? (placement.isUnknownTemplateFamily
              ? const Color(0x44F59E0B)
              : const Color(0x444C7DFF))
          : const Color(0x559CA3AF);
      final Color strokeColor = placement.hasKnownTemplate
          ? (placement.isUnknownTemplateFamily
              ? const Color(0xFFF59E0B)
              : const Color(0xFF7DA2FF))
          : const Color(0xFFB0B7C3);

      canvas.drawRRect(
        body,
        Paint()
          ..color = fillColor
          ..style = PaintingStyle.fill,
      );
      canvas.drawRRect(
        body,
        Paint()
          ..color = strokeColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.2,
      );

      if (placement.hasKnownTemplate) {
        final double markerY = -heightPx / 2;
        canvas.drawLine(
          Offset(-widthPx * 0.18, markerY),
          Offset(widthPx * 0.18, markerY),
          Paint()
            ..color = strokeColor
            ..strokeWidth = 1.2,
        );
      }

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _BoardCanvasPlacementPainter oldDelegate) {
    return oldDelegate.renderablePlacements != renderablePlacements;
  }
}

List<_RenderablePlacement> _buildRenderablePlacements(KnownFacts knownFacts) {
  final Map<String, ComponentFact> componentsById = {
    for (final component in knownFacts.components) component.componentId: component,
  };
  final List<_RenderablePlacement> placements = [];

  for (final placement in knownFacts.componentVisualPlacements) {
    if (placement.coordinateSpace != 'board_normalized') {
      continue;
    }

    final String? templateId = placement.templateId?.trim();
    final FootprintTemplate? template =
        (templateId == null || templateId.isEmpty)
            ? null
            : VectorFootprintLibrary.templateById(templateId);

    final ComponentFact? component = componentsById[placement.componentId];
    final String? designator = (component?.designator?.trim().isEmpty ?? true)
        ? null
        : component!.designator!.trim();

    placements.add(
      _RenderablePlacement(
        componentId: placement.componentId,
        center: Offset(
          _clamp(placement.centerX.toDouble(), 0, 1),
          _clamp(placement.centerY.toDouble(), 0, 1),
        ),
        rotationRad: placement.rotationDeg.toDouble() * math.pi / 180,
        normalizedSize: _resolveNormalizedPlacementSize(
          placement: placement,
          template: template,
        ),
        hasKnownTemplate: template != null,
        isUnknownTemplateFamily:
            templateId != null && templateId.startsWith('unknown_'),
        designator: designator,
      ),
    );
  }

  return placements;
}

Size _resolveNormalizedPlacementSize({
  required ComponentVisualPlacementFact placement,
  required FootprintTemplate? template,
}) {
  final double? explicitWidth = placement.width?.toDouble();
  final double? explicitHeight = placement.height?.toDouble();
  if (explicitWidth != null &&
      explicitHeight != null &&
      explicitWidth > 0 &&
      explicitHeight > 0) {
    return Size(
      _clamp(explicitWidth, 0.002, 0.95),
      _clamp(explicitHeight, 0.002, 0.95),
    );
  }

  final double scale = placement.scale?.toDouble() ?? 1.0;
  final double aspectRatio = _clamp(_templateAspectRatio(template), 0.25, 4.0);
  final double width = _clamp(0.07 * scale, 0.01, 0.35);
  final double height = _clamp(width / aspectRatio, 0.01, 0.35);
  return Size(width, height);
}

double _templateAspectRatio(FootprintTemplate? template) {
  if (template == null) {
    return 1.6;
  }

  final Map<String, dynamic> map = template.toMap();
  final Map<String, dynamic>? body = _asMap(map['body']);
  final Map<String, dynamic>? bbox = _asMap(map['bounding_box']);

  double? width = _firstDouble(body, ['width', 'body_width', 'w']);
  double? height = _firstDouble(body, ['height', 'body_height', 'h']);

  if ((width == null || height == null) && bbox != null) {
    width ??= _firstDouble(bbox, ['width', 'w']);
    height ??= _firstDouble(bbox, ['height', 'h']);

    if (width == null) {
      final double? minX = _firstDouble(bbox, ['min_x', 'left', 'x_min']);
      final double? maxX = _firstDouble(bbox, ['max_x', 'right', 'x_max']);
      if (minX != null && maxX != null) {
        width = (maxX - minX).abs();
      }
    }

    if (height == null) {
      final double? minY = _firstDouble(bbox, ['min_y', 'top', 'y_min']);
      final double? maxY = _firstDouble(bbox, ['max_y', 'bottom', 'y_max']);
      if (minY != null && maxY != null) {
        height = (maxY - minY).abs();
      }
    }
  }

  if (width == null || height == null || width <= 0 || height <= 0) {
    return 1.6;
  }
  return width / height;
}

Map<String, dynamic>? _asMap(dynamic value) {
  if (value is Map) {
    return value.map((key, value) => MapEntry(key.toString(), value));
  }
  return null;
}

double? _firstDouble(Map<String, dynamic>? map, List<String> keys) {
  if (map == null) {
    return null;
  }
  for (final key in keys) {
    final double? parsed = _asDouble(map[key]);
    if (parsed != null) {
      return parsed;
    }
  }
  return null;
}

double? _asDouble(dynamic value) {
  if (value is num) {
    return value.toDouble();
  }
  if (value is String) {
    return double.tryParse(value);
  }
  return null;
}

double _clamp(double value, double min, double max) {
  if (value < min) {
    return min;
  }
  if (value > max) {
    return max;
  }
  return value;
}
