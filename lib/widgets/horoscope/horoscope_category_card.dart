// lib/widgets/horoscope/horoscope_category_card.dart
import 'package:flutter/material.dart';

class HoroscopeCategoryCard extends StatelessWidget {
  final String title;
  final String text;
  final IconData icon;
  final Color color;

  const HoroscopeCategoryCard({
    super.key,
    required this.title,
    required this.text,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: color.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 28),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            Text(
              text,
              style: TextStyle(color: Colors.white.withOpacity(0.9), height: 1.5, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}