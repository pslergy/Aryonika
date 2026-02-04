// lib/src/data/models/astrology/forecast_interpretation.dart

import 'package:equatable/equatable.dart';

class ForecastInterpretation extends Equatable {
  final String key;
  final String category;
  final int impact; // <-- ИСПРАВЛЕНО: String -> int
  final String title;
  final String text;
  final String shortAdvice;
  final bool isProFeature;

  const ForecastInterpretation({
    required this.key,
    required this.category,
    required this.impact, // <-- Тип изменен
    required this.title,
    required this.text,
    this.shortAdvice = '',
    this.isProFeature = false,
  });

  @override
  // Добавляем impact в props для корректного сравнения
  List<Object?> get props => [key, category, impact, title, text, shortAdvice, isProFeature];

  factory ForecastInterpretation.fromJson(Map<String, dynamic> json) {
    return ForecastInterpretation(
      key: json['key'] as String? ?? '',
      category: json['category'] as String? ?? 'general',
      // --- ИСПРАВЛЕНО: Читаем как int, со значением по умолчанию 0 ---
      impact: json['impact'] as int? ?? 0,
      title: json['title'] as String? ?? '...',
      // --- ВАЖНО: Сервер присылает поле 'advice', а не 'text' ---
      text: json['advice'] as String? ?? '...', // <-- ИСПРАВЛЕНО: 'text' -> 'advice'
      shortAdvice: json['shortAdvice'] as String? ?? '',
      isProFeature: json['isProFeature'] as bool? ?? false,
    );
  }
}