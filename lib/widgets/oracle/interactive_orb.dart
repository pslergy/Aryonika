// lib/widgets/oracle/interactive_orb.dart
import 'package:flutter/material.dart';

class InteractiveOrb extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color color1;
  final Color color2;

  const InteractiveOrb({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    required this.color1,
    required this.color2,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          padding: const EdgeInsets.all(12.0), // Добавим внутренний отступ
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [color1.withOpacity(0.8), color2.withOpacity(0.5), Colors.transparent],
              stops: const [0.0, 0.7, 1.0],
            ),
            boxShadow: [
              BoxShadow(
                color: color1.withOpacity(0.5),
                blurRadius: 20,
                spreadRadius: 2,
              )
            ],
          ),
          // ===== ГЛАВНОЕ ИСПРАВЛЕНИЕ ЗДЕСЬ =====
          child: FittedBox(
            fit: BoxFit.scaleDown, // Этот режим уменьшает контент, только если он не помещается
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: Colors.white, size: 48), // Возвращаем комфортный размер иконки
                const SizedBox(height: 12),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14, // И шрифта
                    shadows: [Shadow(color: Colors.black, blurRadius: 2)],
                  ),
                ),
              ],
            ),
          ),
          // ===================================
        ),
      ),
    );
  }}