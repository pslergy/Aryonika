// lib/src/data/models/astrology/daily_forecast.dart
import 'package:equatable/equatable.dart';
import 'package:lovequest/src/data/models/astrology/natal_chart.dart';

import '../transiting_aspect.dart';
import 'compatibility_aspect.dart';
import 'forecast_interpretation.dart'; // Для enum Planet

// Описывает один найденный аспект между транзитной и натальной планетой
class FoundAspect {
  final Planet transitingPlanet;
  final String aspectType; // "Соединение", "Трин", "Квадрат" и т.д.
  final Planet natalPlanet;
  final int orb; // Насколько точный аспект в градусах

  const FoundAspect({
    required this.transitingPlanet,
    required this.aspectType,
    required this.natalPlanet,
    required this.orb,
  });
}


class DailyForecast extends Equatable {
  final DateTime date;
  final String summary;
  final List<ForecastInterpretation> interpretations;

  // --- 👇 ВОЗВРАЩАЕМ ЭТО ПОЛЕ 👇 ---
  final List<TransitingAspect> majorAspects;

  const DailyForecast({
    required this.date,
    this.summary = '',
    this.interpretations = const [],
    this.majorAspects = const [], // <-- Добавляем в конструктор
  });

  // --- 👇 ДОБАВЛЯЕМ НЕДОСТАЮЩИЙ FACTORY-КОНСТРУКТОР 👇 ---
  factory DailyForecast.fromJson(Map<String, dynamic> json) {
    // Безопасно парсим список интерпретаций
    final interpretationsList = (json['interpretations'] as List<dynamic>?)
        ?.map((item) => ForecastInterpretation.fromJson(item as Map<String, dynamic>))
        .toList() ?? [];

    return DailyForecast(
      // Парсим дату из ответа сервера
      date: json['date'] != null ? DateTime.parse(json['date']) : DateTime.now(),
      // Summary пока не приходит с сервера, поэтому оставляем пустым
      summary: json['summary'] ?? '',
      interpretations: interpretationsList,
    );
  }

  // Реализуем props для Equatable
  @override
  List<Object?> get props => [date, summary, interpretations];
}