// lib/widgets/common/mystic_placeholder_painter.dart

import 'package:flutter/material.dart';
import 'dart:ui' as ui; // Импортируем для PathMetric

class MysticPlaceholderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round; // Скругленные концы

    // --- Создаем основной путь для знака вопроса ---
    final path = Path();
    final width = size.width * 0.25; // Ширина знака
    final height = size.height * 0.4; // Высота знака
    final startX = center.dx;
    final startY = center.dy - height / 2;

    // Верхняя кривая часть
    path.moveTo(startX - width * 0.5, startY + height * 0.25);
    path.cubicTo(
        startX - width * 0.9, startY - height * 0.1, // Контрольная точка 1
        startX + width * 0.9, startY - height * 0.1, // Контрольная точка 2
        startX, startY + height * 0.45             // Конечная точка
    );
    // Прямая часть
    path.lineTo(startX, startY + height * 0.65);

    // --- Рисуем свечение ---
    final gradient = const LinearGradient(
      colors: [Color(0xFF8A2BE2), Color(0xFF00BFFF)], // Яркий фиолетовый и синий
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    paint
      ..shader = gradient
      ..strokeWidth = 8.0 // Делаем свечение толще
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8.0); // И более размытым

    canvas.drawPath(path, paint);
    canvas.drawCircle(Offset(startX, startY + height * 0.9), width * 0.15, paint);

    // --- Рисуем сам знак вопроса (внутренняя часть) ---
    paint
      ..shader = null // Убираем градиент
      ..color = Colors.white.withOpacity(0.9)
      ..strokeWidth = 5.0 // Основная линия тоже толще
      ..maskFilter = null; // Убираем размытие

    canvas.drawPath(path, paint);
    // Точка внизу
    paint.style = PaintingStyle.fill;
    canvas.drawCircle(Offset(startX, startY + height * 0.9), width * 0.15, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}