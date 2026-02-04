// lib/src/data/models/jyotish_chart.dart

// Модель для хранения позиций планет
class PlanetPosition {
  final String rasi;        // Знак (например, 'Aries')
  final String nakshatra;   // Накшатра (например, 'Ashwini')
  final int pada;           // Пада накшатры (1-4)
  final double degrees;     // Градус внутри знака

  PlanetPosition({
    required this.rasi,
    required this.nakshatra,
    required this.pada,
    required this.degrees,
  });

  factory PlanetPosition.fromJson(Map<String, dynamic> json) {
    return PlanetPosition(
      rasi: json['rasi'] ?? '',
      nakshatra: json['nakshatra'] ?? '',
      pada: json['pada'] ?? 1,
      degrees: (json['degrees'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'rasi': rasi,
      'nakshatra': nakshatra,
      'pada': pada,
      'degrees': degrees,
    };
  }
}

// Основная модель для ведической карты
class JyotishChart {
  final String lagnaRasi; // Восходящий знак (Асцендент)
  final String chandraRasi; // Лунный знак
  final String chandraNakshatra; // Накшатра Луны - САМОЕ ВАЖНОЕ для совместимости
  final Map<String, PlanetPosition> planetPositions; // Позиции всех планет

  JyotishChart({
    required this.lagnaRasi,
    required this.chandraRasi,
    required this.chandraNakshatra,
    required this.planetPositions,
  });

  factory JyotishChart.fromJson(Map<String, dynamic> json) {
    return JyotishChart(
      lagnaRasi: json['lagnaRasi'] ?? '',
      chandraRasi: json['chandraRasi'] ?? '',
      chandraNakshatra: json['chandraNakshatra'] ?? '',
      planetPositions: (json['planetPositions'] as Map<String, dynamic>?)
          ?.map((key, value) => MapEntry(key, PlanetPosition.fromJson(value))) ?? {},
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'lagnaRasi': lagnaRasi,
      'chandraRasi': chandraRasi,
      'chandraNakshatra': chandraNakshatra,
      'planetPositions': planetPositions.map((key, value) => MapEntry(key, value.toFirestore())),
    };
  }
}