import 'package:flutter/material.dart';
import 'package:lovequest/src/data/models/astrology/compatibility_report.dart';

class CompatibilityScoreWidget extends StatelessWidget {
  final int totalScore;
  const CompatibilityScoreWidget({super.key, required this.totalScore}); // <-- ИЗМЕНЕНО

  @override
  Widget build(BuildContext context) {
    // Простая заглушка, можешь вставить сюда свой красивый виджет с процентами
    return Center(
      child: Text(
        '$totalScore%',
        style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.pinkAccent),
      ),
    );
  }
}