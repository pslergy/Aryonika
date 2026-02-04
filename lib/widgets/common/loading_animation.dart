// lib/widgets/common/loading_animation.dart

import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class PulsatingLogo extends StatelessWidget {
  const PulsatingLogo({super.key});

  @override
  Widget build(BuildContext context) {
    // Используем LoopAnimationBuilder для бесконечной плавной анимации
    return LoopAnimationBuilder<double>(
      tween: Tween(begin: 0.9, end: 1.1), // Пульсация от 90% до 110% размера
      duration: const Duration(milliseconds: 1500),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: child,
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.favorite, // Или твоя иконка-сердечко/звезда
            size: 80,
            color: Colors.pinkAccent.withOpacity(0.8),
            shadows: [
              Shadow(color: Colors.pinkAccent.withOpacity(0.5), blurRadius: 15)
            ],
          ),
          const SizedBox(height: 16),
          Text(
            "Aryonika",
            style: TextStyle(
              fontSize: 24,
              color: Colors.white.withOpacity(0.8),
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Соединяем сердца во Вселенной...",
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }
}