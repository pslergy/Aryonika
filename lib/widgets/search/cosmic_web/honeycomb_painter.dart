// lib/widgets/search/cosmic_web/cosmic_web_painter.dart (ФИНАЛЬНАЯ ВЕРСИЯ С СОТАМИ)

import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'cosmic_web_user_node.dart';

class CosmicWebPainter extends CustomPainter {
  final List<CosmicWebUserNode> nodes;
  final Animation<double> pulseAnimation;

  CosmicWebPainter({
    required this.nodes,
    required this.pulseAnimation,
  }) : super(repaint: pulseAnimation);

  @override
  void paint(Canvas canvas, Size size) {
    // ШАГ 1: РИСУЕМ ФОН С СОТАМИ
    _drawHoneycombBackground(canvas, size);

    // ШАГ 2: РИСУЕМ ЗВЕЗДЫ-ПОЛЬЗОВАТЕЛИ
    for (final node in nodes) {
      // --- ИСПРАВЛЕНИЕ: Проверяем avatarProvider, а не avatarImage ---
      if (node.avatarProvider == null) continue;
      // В нашем подходе с виджетами этот painter вообще не рисует аватары,
      // но оставим эту логику здесь на случай, если вернемся к CustomPaint для звезд
    }
  }

  void _drawHoneycombBackground(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.cyan.withOpacity(0.08)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    const double hexRadius = 70.0;
    final double hexWidth = hexRadius * 2;
    final double hexHeight = sqrt(3) * hexRadius;
    final int cols = (size.width / (hexWidth * 0.75)).ceil() + 2;
    final int rows = (size.height / hexHeight).ceil() + 2;

    for (int row = -1; row < rows; row++) {
      for (int col = -1; col < cols; col++) {
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

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}