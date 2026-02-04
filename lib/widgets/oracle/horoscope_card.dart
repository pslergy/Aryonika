// lib/widgets/oracle/horoscope_card.dart
import 'package:flutter/material.dart';

class HoroscopeCard extends StatelessWidget {
  final String title;
  final String text;
  final Widget icon; // Можем передавать иконку или эмодзи

  const HoroscopeCard({
    super.key,
    required this.title,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                icon,
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              text,
              style: TextStyle(color: Colors.white.withOpacity(0.8), height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}