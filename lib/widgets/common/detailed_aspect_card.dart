// lib/widgets/compatibility/detailed_aspect_card.dart
import 'package:flutter/material.dart';

class DetailedAspectCard extends StatelessWidget {
  final String title;
  final String description;
  final int score;
  final bool isPro;

  const DetailedAspectCard({
    super.key,
    required this.title,
    required this.description,
    required this.score,
    required this.isPro,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Добавить логику блокировки для `isPro`
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(title),
        subtitle: Text(description),
        trailing: Text(
          '${score > 0 ? '+' : ''}$score',
          style: TextStyle(color: score > 0 ? Colors.green : Colors.red),
        ),
      ),
    );
  }
}