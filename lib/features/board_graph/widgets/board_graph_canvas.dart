import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:trace_bench_viewer/features/board_graph/models/board_graph_model.dart';

class BoardGraphCanvas extends StatelessWidget {
  const BoardGraphCanvas({
    required this.projection,
    required this.nodePositions,
    required this.showAdvancedDetails,
    super.key,
  });

  final BoardGraphProjection projection;
  final Map<String, Offset> nodePositions;
  final bool showAdvancedDetails;

  @override
  Widget build(BuildContext context) {
    var maxX = 0.0;
    var maxY = 0.0;
    for (final position in nodePositions.values) {
      maxX = math.max(maxX, position.dx);
      maxY = math.max(maxY, position.dy);
    }

    return InteractiveViewer(
      minScale: 0.5,
      maxScale: 2,
      child: SizedBox(
        width: math.max(maxX + 220, 300),
        height: math.max(maxY + 180, 240),
        child: CustomPaint(
          painter: _BoardGraphPainter(
            projection: projection,
            nodePositions: nodePositions,
            showAdvancedDetails: showAdvancedDetails,
          ),
        ),
      ),
    );
  }
}

class _BoardGraphPainter extends CustomPainter {
  _BoardGraphPainter({
    required this.projection,
    required this.nodePositions,
    required this.showAdvancedDetails,
  });

  final BoardGraphProjection projection;
  final Map<String, Offset> nodePositions;
  final bool showAdvancedDetails;

  @override
  void paint(Canvas canvas, Size size) {
    final nodePaint = Paint()..style = PaintingStyle.fill;
    final edgePaint = Paint()..style = PaintingStyle.stroke..strokeWidth = 2;

    for (final edge in projection.edges) {
      final from = nodePositions[edge.fromId];
      final to = nodePositions[edge.toId];
      if (from == null || to == null) continue;

      final start = from + const Offset(60, 18);
      final end = to + const Offset(60, 18);
      edgePaint.color = _edgeColor(edge);

      if (edge.type == BoardGraphEdgeType.visualTraceHint) {
        _drawDashedLine(canvas, start, end, edgePaint);
      } else {
        canvas.drawLine(start, end, edgePaint);
      }

      final tip = end;
      final angle = math.atan2(end.dy - start.dy, end.dx - start.dx);
      if (edge.type == BoardGraphEdgeType.measuredConnection) {
        _drawArrowTip(canvas, tip, angle, edgePaint.color);
      }

      if (showAdvancedDetails && edge.data.isNotEmpty) {
        final raw = edge.data['trace_id'] ?? edge.data['region_id'];
        if (raw != null) {
          final labelPainter = TextPainter(
            text: TextSpan(
              text: raw.toString(),
              style: const TextStyle(color: Colors.black87, fontSize: 9),
            ),
            textDirection: TextDirection.ltr,
            maxLines: 1,
          )..layout(maxWidth: 100);
          final mid = Offset((start.dx + end.dx) / 2, (start.dy + end.dy) / 2);
          labelPainter.paint(canvas, mid + const Offset(4, -10));
        }
      }
    }

    for (final node in projection.nodes) {
      final position = nodePositions[node.id] ?? Offset.zero;
      nodePaint.color = _nodeColor(node);
      final rect = Rect.fromLTWH(position.dx, position.dy, 120, 36);
      final radius = Radius.circular(8);
      canvas.drawRRect(RRect.fromRectAndRadius(rect, radius), nodePaint);

      final textPainter = TextPainter(
        text: TextSpan(
          text: node.shortLabel,
          style: const TextStyle(color: Colors.white, fontSize: 11),
        ),
        textDirection: TextDirection.ltr,
        maxLines: 1,
      )..layout(maxWidth: 110);
      textPainter.paint(canvas, position + const Offset(4, 8));

      if (showAdvancedDetails && node.data['origin_event_id'] != null) {
        final rawPainter = TextPainter(
          text: TextSpan(
            text: node.data['origin_event_id'].toString(),
            style: const TextStyle(color: Colors.white70, fontSize: 9),
          ),
          textDirection: TextDirection.ltr,
          maxLines: 1,
        )..layout(maxWidth: 110);
        rawPainter.paint(canvas, position + const Offset(4, 22));
      }

      if (showAdvancedDetails && node.type == BoardGraphNodeType.measurement) {
        final validityLabel = node.validity == ValidityStatus.staleAfterRepair
            ? 'Aegunud'
            : node.validity == ValidityStatus.active
                ? 'Aktiivne'
                : '';
        if (validityLabel.isNotEmpty) {
          final validPainter = TextPainter(
            text: TextSpan(
              text: validityLabel,
              style: const TextStyle(color: Colors.white70, fontSize: 8),
            ),
            textDirection: TextDirection.ltr,
          )..layout(maxWidth: 110);
          validPainter.paint(canvas, position + const Offset(4, 32));
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant _BoardGraphPainter oldDelegate) {
    return oldDelegate.projection != projection ||
        oldDelegate.nodePositions != nodePositions ||
        oldDelegate.showAdvancedDetails != showAdvancedDetails;
  }

  Color _nodeColor(BoardGraphNode node) {
    switch (node.type) {
      case BoardGraphNodeType.component:
        return Colors.blue.shade600;
      case BoardGraphNodeType.pin:
        return Colors.green.shade600;
      case BoardGraphNodeType.net:
        return Colors.orange.shade700;
      case BoardGraphNodeType.measurement:
        return Colors.purple.shade700;
      case BoardGraphNodeType.visualTrace:
        return Colors.indigo.shade600;
      case BoardGraphNodeType.damageRegion:
        return Colors.red.shade700;
      case BoardGraphNodeType.suspectRegion:
        return Colors.brown.shade700;
      case BoardGraphNodeType.footprint:
        return Colors.grey.shade600;
    }
  }

  Color _edgeColor(BoardGraphEdge edge) {
    switch (edge.type) {
      case BoardGraphEdgeType.visualTraceHint:
        return Colors.deepPurple.shade300;
      case BoardGraphEdgeType.measuredConnection:
        return Colors.green.shade700;
      case BoardGraphEdgeType.annotatedRegion:
        return Colors.red.shade400;
      case BoardGraphEdgeType.hasPin:
      case BoardGraphEdgeType.staleAfter:
      case BoardGraphEdgeType.affectedByRepair:
        return Colors.grey.shade600;
    }
  }

  void _drawArrowTip(Canvas canvas, Offset tip, double angle, Color color) {
    final paint = Paint()..color = color;
    final p1 = tip + Offset.fromDirection(angle - 0.4, 8);
    final p2 = tip + Offset.fromDirection(angle + 0.4, 8);
    canvas.drawPath(
      Path()
        ..moveTo(tip.dx, tip.dy)
        ..lineTo(p1.dx, p1.dy)
        ..lineTo(p2.dx, p2.dy)
        ..close(),
      paint,
    );
  }

  void _drawDashedLine(Canvas canvas, Offset from, Offset to, Paint paint) {
    const dashLength = 6.0;
    const gapLength = 4.0;
    final dx = to.dx - from.dx;
    final dy = to.dy - from.dy;
    final distance = math.sqrt(dx * dx + dy * dy);
    final steps = (distance / (dashLength + gapLength)).floor();
    if (steps <= 0) return;

    final unitX = dx / distance;
    final unitY = dy / distance;
    for (var i = 0; i < steps; i++) {
      final start = from + Offset(unitX * (dashLength + gapLength) * i,
          unitY * (dashLength + gapLength) * i);
      final end = Offset(
        start.dx + unitX * dashLength,
        start.dy + unitY * dashLength,
      );
      canvas.drawLine(start, end, paint);
    }
  }
}
