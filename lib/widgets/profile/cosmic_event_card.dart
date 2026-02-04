// lib/widgets/profile/cosmic_event_card.dart
import 'package:flutter/material.dart';
import 'package:lovequest/src/data/models/cosmic_event.dart';

import 'package:lovequest/l10n/generated/app_localizations.dart';
 // Для локализации

class CosmicEventCard extends StatelessWidget {
  final CosmicEvent event;

  const CosmicEventCard({super.key, required this.event});

  Map<String, dynamic> _getTheme(String eventType) {
    switch (eventType) {
      case 'CONJUNCTION':
      case 'TRINE':
      case 'SEXTILE':
        return {'icon': Icons.auto_awesome, 'color': Colors.cyanAccent};
      case 'SQUARE':
      case 'OPPOSITION':
        return {'icon': Icons.warning_amber_rounded, 'color': Colors.orangeAccent};
      default:
        return {'icon': Icons.star_outline, 'color': Colors.white70};
    }
  }

  @override
  Widget build(BuildContext context) {
    final langCode = AppLocalizations.of(context)!.localeName;
    final theme = _getTheme(event.eventType);

    // --- 👇 ВОТ ИСПРАВЛЕНИЕ: Это должны быть простые строки 👇 ---
    final String title = event.title;
    final String description = event.description;
    final String advice = event.personalAdvice;
    // --- КОНЕЦ ИСПРАВЛЕНИЯ ---

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(theme['icon'], color: theme['color'] as Color, size: 22),
              const SizedBox(width: 12),
              Expanded(
                child: Text( // <-- Используем переменную-строку здесь
                  title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: theme['color'] as Color,
                      fontSize: 16),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text( // <-- Используем переменную-строку здесь
            description,
            style: const TextStyle(color: Colors.white70, height: 1.5),
          ),

          // --- Используем .isNotEmpty на строке, а не на виджете ---
          if (advice.isNotEmpty) ...[
            const Divider(height: 24, color: Colors.white24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.person_pin, color: Colors.yellowAccent, size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Ваш персональный фокус:",
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.yellowAccent),
                      ),
                      const SizedBox(height: 4),
                      Text( // <-- Используем переменную-строку здесь
                        advice,
                        style: const TextStyle(color: Colors.white, fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ],
      ),
    );
  } }