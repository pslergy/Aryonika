// lib/widgets/search/cosmic_web/honeycomb_background_painter.dart

import 'dart:math';
import 'package:flutter/material.dart';

class HoneycombBackgroundPainter extends CustomPainter {

  // Этот painter максимально простой. Ему не нужны никакие параметры.
  const HoneycombBackgroundPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.cyan.withOpacity(0.08)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    // Просто рисуем соты на всей предоставленной ему площади (нашем большом _canvasSize)
    const double hexRadius = 80.0;
    final double hexWidth = hexRadius * 2;
    final double hexHeight = sqrt(3) * hexRadius;
    final int cols = (size.width / (hexWidth * 0.75)).ceil();
    final int rows = (size.height / hexHeight).ceil();

    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < cols; col++) {
        final double x = col * hexWidth * 0.75;
        final double y = row * hexHeight + (col.isOdd ? hexHeight / 2 : 0);
        _drawHexagon(canvas, Offset(x, y), hexRadius, paint);
      }
    }
  }

  void _drawHexagon(Canvas canvas, Offset center, double radius, Paint paint) {
    final path = Path();
    for (int i = 0; i < 6; i++) {
      final angle = (pi / 3) * i - (pi / 6);
      final point = Offset(center.dx + radius * cos(angle), center.dy + radius * sin(angle));
      if (i == 0) path.moveTo(point.dx, point.dy);
      else path.lineTo(point.dx, point.dy);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  // Фон статичен, ему не нужно перерисовываться при зуме.
  @override
  bool shouldRepaint(covariant HoneycombBackgroundPainter oldDelegate) => false;
}