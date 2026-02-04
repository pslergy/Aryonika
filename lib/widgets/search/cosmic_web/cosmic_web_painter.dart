// lib/widgets/search/cosmic_web/cosmic_web_painter.dart

import 'dart:math';
import 'dart:ui' as ui; // Нужен для работы с картинками
import 'package:flutter/material.dart';
import 'cosmic_web_user_node.dart'; // Убедись, что импорт правильный

class CosmicWebPainter extends CustomPainter {
  final List<CosmicWebUserNode> nodes;
  final Animation<double> pulseAnimation;
  final Map<String, ui.Image> loadedAvatars; // Кэш загруженных аватаров

  CosmicWebPainter({
    required this.nodes,
    required this.pulseAnimation,
    required this.loadedAvatars,
  }) : super(repaint: pulseAnimation); // Перерисовываемся по анимации пульса

  @override
  void paint(Canvas canvas, Size size) {
    // --- 1. РИСУЕМ ФОН (СОТЫ) ---
    _drawHoneycombBackground(canvas, size);

    // --- 2. РИСУЕМ ЗВЕЗДЫ-ПОЛЬЗОВАТЕЛИ ---
    for (final node in nodes) {
      _drawStarNode(canvas, node);
    }
  }

  void _drawStarNode(Canvas canvas, CosmicWebUserNode node) {
    final position = node.position;
    final baseRadius = node.radius;

    // --- 1. Определяем параметры на основе совместимости ---

    // ИЗМЕНЕНИЕ: Снижаем порог для теста. Поставь 70 или даже 60.
    final bool isHighCompatibility = node.user.compatibilityScore >= 65;
    final compatibilityFactor = node.user.compatibilityScore / 100.0;

    // --- 2. Рассчитываем динамический радиус для пульсации ---
    double currentRadius = baseRadius;
    if (isHighCompatibility) {
      // ИЗМЕНЕНИЕ: Делаем пульсацию более заметной, меняя масштаб от 75% до 125%
      final pulseFactor = (ui.lerpDouble(0.75, 1.25, pulseAnimation.value))!;
      currentRadius = baseRadius * pulseFactor;
    }

    // --- 3. Рассчитываем цвет и размер свечения (гало) ---

    // ИЗМЕНЕНИЕ: Сделаем цвета более контрастными.
    // Вместо почти прозрачного синего возьмем более насыщенный пурпурный.
    // Вместо желтого - огненно-оранжевый/красный для максимальной совместимости.
    final haloColor = Color.lerp(
      Colors.purple.withOpacity(0.5), // от пурпурного
      Colors.orangeAccent.withOpacity(0.9), // до оранжевого
      compatibilityFactor,
    )!;

    // ИЗМЕНЕНИЕ: Увеличиваем разброс в размере гало.
    // Теперь он будет меняться от 1.3 до 2.8 раз от радиуса аватара.
    final haloSize = currentRadius * (1.3 + compatibilityFactor * 1.5);

    // --- 4. Рисуем свечение ---

    // ИЗМЕНЕНИЕ: Увеличиваем силу размытия (blur).
    final haloPaint = Paint()
      ..color = haloColor
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 25.0); // Было 15.0, стало 25.0

    canvas.drawCircle(position, haloSize, haloPaint);

    // --- 5. Рисуем сам аватар (код остался прежним) ---
    final avatarImage = loadedAvatars[node.user.id];
    final avatarRect = Rect.fromCircle(center: position, radius: currentRadius);

    if (avatarImage != null) {
      canvas.save();
      canvas.clipPath(Path()..addOval(avatarRect));
      paintImage(
        canvas: canvas,
        rect: avatarRect,
        image: avatarImage,
        fit: BoxFit.cover,
      );
      canvas.restore();
    } else {
      final placeholderPaint = Paint()..color = Colors.grey[800]!;
      canvas.drawCircle(position, currentRadius, placeholderPaint);
    }
  }

  void _drawHoneycombBackground(Canvas canvas, Size size) {
    // Твоя логика отрисовки сот остается без изменений.
    // Она идеальна для этого случая.
    final paint = Paint()
      ..color = Colors.cyan.withOpacity(0.08)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    const double hexRadius = 80.0;
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
  bool shouldRepaint(covariant CosmicWebPainter oldDelegate) {
    // Перерисовываем, если изменился список нод или кэш аватаров
    return oldDelegate.nodes != nodes || oldDelegate.loadedAvatars != loadedAvatars;
  }
}