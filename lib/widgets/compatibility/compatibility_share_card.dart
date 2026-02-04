import 'package:flutter/material.dart';

class CompatibilityShareCard extends StatelessWidget {
  final String myName;
  final String partnerName;
  final int score;
  final String verdict;

  const CompatibilityShareCard({
    super.key,
    required this.myName,
    required this.partnerName,
    required this.score,
    required this.verdict,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400, // Фиксированная ширина для красивого скриншота
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2E003E), Color(0xFF000000)], // Фирменный фон
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(0), // Прямоугольник или скругленный
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Логотип (Текст)
          const Text(
            "Aryonika",
            style: TextStyle(
              fontFamily: 'Cinzel', // Если есть шрифт, или просто serif
              fontSize: 24,
              letterSpacing: 8,
              color: Colors.white54,
            ),
          ),
          const SizedBox(height: 32),

          // Имена
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildName(myName),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.favorite, color: Colors.pinkAccent, size: 32),
              ),
              _buildName(partnerName),
            ],
          ),
          const SizedBox(height: 40),

          // Процент
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 180, height: 180,
                child: CircularProgressIndicator(
                  value: score / 100,
                  strokeWidth: 15,
                  color: Colors.pinkAccent,
                  backgroundColor: Colors.white10,
                ),
              ),
              Column(
                children: [
                  Text(
                    "$score%",
                    style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    verdict.toUpperCase(),
                    style: const TextStyle(fontSize: 12, color: Colors.pinkAccent, letterSpacing: 2),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 40),

          // Футер с ссылкой
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.public, color: Colors.white70, size: 16),
                SizedBox(width: 8),
                Text("psylergy.com", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildName(String name) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 120),
      child: Text(
        name,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}