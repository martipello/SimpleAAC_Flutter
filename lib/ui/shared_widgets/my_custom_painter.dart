
import 'dart:ui';

import 'package:flutter/material.dart';

class MyCustomPainter extends CustomPainter {
  MyCustomPainter(this.points);

  final List<Offset?> points;

  @override
  void paint(Canvas canvas, Size size) {
    final background = Paint()..color = Colors.white;
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawRect(rect, background);

    final brush = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
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