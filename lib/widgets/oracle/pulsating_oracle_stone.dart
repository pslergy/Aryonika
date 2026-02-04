// lib/widgets/oracle/pulsating_oracle_stone.dart
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class PulsatingOracleStone extends StatelessWidget {
  final String text;
  const PulsatingOracleStone({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LoopAnimationBuilder<double>(
          tween: Tween(begin: 0.9, end: 1.0),
          duration: const Duration(milliseconds: 2000),
          curve: Curves.easeInOut,
          builder: (context, value, child) {
            return Transform.scale(
              scale: value,
              child: Opacity(
                opacity: (value - 0.9) * 10, // от 0 до 1
                child: child,
              ),
            );
          },
          child: Icon(
            Icons.flare, // Иконка, похожая на камень или звезду
            color: Colors.yellow[700],
            size: 64,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          text,
          style: TextStyle(color: Colors.white.withOpacity(0.8), fontStyle: FontStyle.italic),
        ),
      ],
    );
  }
}