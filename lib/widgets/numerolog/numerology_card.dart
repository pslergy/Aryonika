// lib/widgets/numerology/numerology_card.dart

import 'package:flutter/material.dart';
import 'package:lovequest/services/numerology_calculator.dart';
import 'package:lovequest/src/data/models/numerology_report.dart'; // Нужен для NumerologyDetail

class NumerologyCard extends StatelessWidget {
  final NumerologyDetail detail;
  final String title;
  final String description;
  final bool isLocked;
  final VoidCallback onLockedClick;

  const NumerologyCard({
    super.key,
    required this.detail,
    required this.title,
    required this.description,
    this.isLocked = false,
    required this.onLockedClick,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLocked ? onLockedClick : null,
      child: Card(
        color: Colors.white.withOpacity(0.08),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.white.withOpacity(0.1)),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        number.toString(),
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.cyanAccent[100],
                          shadows: [
                            Shadow(color: Colors.cyan.withOpacity(0.5), blurRadius: 10),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (detail.isKarmic || detail.isMaster)
                              Text(
                                detail.isMaster ? '(Мастер-число)' : '(Кармический долг)', // TODO: в l10n
                                style: TextStyle(
                                  color: detail.isMaster ? Colors.amberAccent : Colors.redAccent,
                                  fontSize: 12,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 24, color: Colors.white24),
                  Text(
                    description,
                    style: TextStyle(color: Colors.white.withOpacity(0.8), height: 1.5),
                  ),
                ],
              ),
            ),
            if (isLocked)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.lock_outline,
                      color: Colors.yellowAccent,
                      size: 40,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Вспомогательный геттер для удобства
  int get number => detail.isMaster || detail.isKarmic ? detail.baseNumber : detail.number;
}