// lib/widgets/oracle/animated_oracle_text.dart
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lovequest/services/logger_service.dart';

class AnimatedOracleText extends StatelessWidget {
  final String text;
  const AnimatedOracleText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    logger.d("--- 🔬 LOG: 3a. UI_WIDGET: AnimatedOracleText получил текст: '$text'");

    // Стиль теперь будет наследоваться от DefaultTextStyle, который мы задали выше.
    // Это делает код чище.
    final defaultStyle = DefaultTextStyle.of(context).style;

    return Wrap(
      alignment: WrapAlignment.center,
      children: text.split(' ').asMap().entries.map((entry) {
        final index = entry.key;
        final word = entry.value;

        return Text('$word ', style: defaultStyle)
            .animate(
          // Задержка появления каждого слова, создает эффект "печатания"
          delay: (index * 100).ms,
        )
        // 1. Эффект появления: слово проявляется из невидимости и легкого размытия
            .fadeIn(duration: 600.ms, curve: Curves.easeOut)
            .move(begin: const Offset(0, 10), duration: 600.ms, curve: Curves.easeOut)
            .blur(begin: const Offset(4, 4), end: Offset.zero)
        // 2. После появления добавляем эффект "космического мерцания"
            .then(delay: 1500.ms) // Ждем 1.5 секунды после появления всего текста
            .shimmer(
          duration: 2.seconds,
          delay: (200 * sin(index)).ms, // У каждого слова своя задержка мерцания
          colors: [
            // Цвета для перелива
            Colors.white,
            Colors.cyanAccent,
            Colors.white,
          ],
        );
      }).toList(),
    );
  }
}