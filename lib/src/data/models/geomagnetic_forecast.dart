// lib/src/data/models/geomagnetic_forecast.dart

// Уровень геомагнитной активности
enum KpLevel { calm, unsettled, active, minorStorm, moderateStorm, strongStorm, severeStorm, extremeStorm }

class GeomagneticForecast {
  final DateTime time;
  final int kpValue; // Значение Kp-индекса (0-9)
  final KpLevel level;
  final String description; // Простое описание ("Спокойно", "Малая буря" и т.д.)

  const GeomagneticForecast({
    required this.time,
    required this.kpValue,
    required this.level,
    required this.description,
  });



// === ДОБАВЬ ЭТИ МЕТОДЫ ===
Map<String, dynamic> toJson() => {
  'time': time.toIso8601String(),
  'kpValue': kpValue,
  'level': level.index, // Сохраняем enum как число
  'description': description,
};

factory GeomagneticForecast.fromJson(Map<String, dynamic> json) => GeomagneticForecast(
time: DateTime.parse(json['time']),
kpValue: json['kpValue'],
level: KpLevel.values[json['level']], // Восстанавливаем enum из числа
description: json['description'],
);
// =========================
}