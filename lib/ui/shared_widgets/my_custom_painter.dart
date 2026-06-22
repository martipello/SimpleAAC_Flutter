
import 'dart:ui';

import 'package:flutter/material.dart';

class MyCustomPainter extends CustomPainter {
  MyCustomPainter(this.points, {this.color = Colors.black, this.strokeWidth = 4, this.hasBackground = false});

  final List<Offset?> points;
  final Color color;
  final double strokeWidth;
  final bool hasBackground;

  @override
  void paint(Canvas canvas, Size size) {
    if (!hasBackground) {
      canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Paint()..color = Colors.white,
      );
    }

    final brush = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..isAntiAlias = true
      ..strokeCap = StrokeCap.round;

    for (var x = 0; x < points.length - 1; x++) {
      if (points[x] != null && points[x + 1] != null) {
        canvas.drawLine(points[x]!, points[x + 1]!, brush);
      } else if (points[x] != null && points[x + 1] == null) {
        canvas.drawPoints(PointMode.points, [points[x]!], brush);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}