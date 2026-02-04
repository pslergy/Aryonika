// lib/widgets/common/section_title.dart
import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        title.toUpperCase(),
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.yellow[700]?.withOpacity(0.8),
          fontWeight: FontWeight.bold,
          letterSpacing: 2.0,
          fontSize: 14,
        ),
      ),
    );
  }
}