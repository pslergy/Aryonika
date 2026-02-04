// lib/widgets/common/neon_glow_button.dart
import 'package:flutter/material.dart';

class NeonGlowButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color glowColor;

  const NeonGlowButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.glowColor = Colors.pinkAccent,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: glowColor.withOpacity(0.15),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: glowColor),
          boxShadow: [
            BoxShadow(
              color: glowColor.withOpacity(0.7),
              blurRadius: 10.0,
              spreadRadius: 1.0,
            ),
            BoxShadow(
              color: glowColor.withOpacity(0.3),
              blurRadius: 20.0,
              spreadRadius: 5.0,
            ),
          ],
        ),
        child: Text(
          text.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }
}