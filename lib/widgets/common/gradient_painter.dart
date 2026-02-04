// lib/widgets/common/gradient_painter.dart

import 'package:flutter/material.dart';
import 'dart:math' as math;

class GradientRingPainter extends CustomPainter {
  final double strokeWidth;
  final Gradient gradient;

  GradientRingPainter({
    required this.strokeWidth,
    required this.gradient,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Сдвигаем прямоугольник на половину толщины линии, чтобы обводка была по центру
    final Rect rect = Rect.fromLTWH(strokeWidth / 2, strokeWidth / 2, size.width - strokeWidth, size.height - strokeWidth);

    final paint = Paint()
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke // Рисуем только обводку, а не заливку
      ..shader = gradient.createShader(rect); // Применяем градиент

    // Рисуем дугу, которая является полной окружностью
    canvas.drawArc(rect, 0, math.pi * 2, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}