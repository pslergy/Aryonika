// lib/src/data/models/astrology/natal_chart.dart

import 'package:equatable/equatable.dart';

enum Planet { SUN, MOON, MERCURY, VENUS, MARS, JUPITER, SATURN, URANUS, NEPTUNE, PLUTO, ASC }

class NatalChart extends Equatable {
  final String? sunSign;
  final String? moonSign;
  final String? mercurySign;
  final String? venusSign;
  final String? marsSign;
  final String? jupiterSign;
  final String? saturnSign;
  final String? uranusSign;
  final String? neptuneSign;
  final String? plutoSign;
  final String? ascendantSign;
  final Map<String, double>? planetPositions;
  final DateTime? birthDateTime;
  final double? latitude;
  final double? longitude;
  final Map<String, double>? houseCusps;

  const NatalChart({
    this.sunSign, this.moonSign, this.mercurySign, this.venusSign,
    this.marsSign, this.jupiterSign, this.saturnSign, this.uranusSign,
    this.neptuneSign, this.plutoSign, this.ascendantSign,
    this.planetPositions = const {},
    this.birthDateTime, this.latitude, this.longitude,
    this.houseCusps = const {},
  });

  factory NatalChart.fromMap(Map<String, dynamic> map) {

    Map<String, double>? _parsePositions(Map<String, dynamic>? data) {
      if (data == null) return null;
      return data.map((key, value) {
        // Преобразуем ЛЮБОЕ число (int, double) в double
        if (value is num) {
          return MapEntry(key, value.toDouble());
        }
        // Если это не число, возвращаем 0.0, чтобы избежать падения
        return MapEntry(key, 0.0);
      });
    }

    Map<int, double> parseHouseCusps(Map<String, dynamic>? data) {
      if (data == null) return {};
      final Map<int, double> cusps = {};
      data.forEach((key, value) {
        final intKey = int.tryParse(key);
        if (intKey != null) {
          cusps[intKey] = (value as num).toDouble();
        }
      });
      return cusps;
    }

    DateTime? parseBirthDateTime(Map<String, dynamic>? data) {
      if (data == null) return null;
      try {
        return DateTime(
          data['year'], data['monthValue'] ?? data['month'], data['dayOfMonth'] ?? data['day'],
          data['hour'], data['minute'],
        );
      } catch (e) {
        return null;
      }
    }

    return NatalChart(
      sunSign: map['sunSign'],
      moonSign: map['moonSign'],
      mercurySign: map['mercurySign'],
      venusSign: map['venusSign'],
      marsSign: map['marsSign'],
      jupiterSign: map['jupiterSign'],
      saturnSign: map['saturnSign'],
      uranusSign: map['uranusSign'],
      neptuneSign: map['neptuneSign'],
      plutoSign: map['plutoSign'],
      ascendantSign: map['ascendantSign'],
      latitude: (map['latitude'] as num?)?.toDouble(),
      longitude: (map['longitude'] as num?)?.toDouble(),
      birthDateTime: parseBirthDateTime(map['birthDateTime'] as Map<String, dynamic>?),
      // --- ВЫЗЫВАЕМ НАШИ НОВЫЕ НАДЕЖНЫЕ ПАРСЕРЫ ---
      planetPositions: _parsePositions(map['planetPositions'] as Map<String, dynamic>?),
      houseCusps: _parsePositions(map['houseCusps'] as Map<String, dynamic>?),
    );
  }

  // Метод toFirestore() оставляем без изменений, он был правильный
  Map<String, dynamic> toFirestore() {
    return {
      'sunSign': sunSign, 'moonSign': moonSign, 'mercurySign': mercurySign,
      'venusSign': venusSign, 'marsSign': marsSign, 'jupiterSign': jupiterSign,
      'saturnSign': saturnSign, 'uranusSign': uranusSign, 'neptuneSign': neptuneSign,
      'plutoSign': plutoSign, 'ascendantSign': ascendantSign,
      'planetPositions': planetPositions,
      'latitude': latitude, 'longitude': longitude,
      'houseCusps': houseCusps,
    };
  }

  @override
  List<Object?> get props => [
    sunSign, moonSign, mercurySign, venusSign, marsSign, jupiterSign, saturnSign,
    uranusSign, neptuneSign, plutoSign, ascendantSign, planetPositions,
    birthDateTime, latitude, longitude, houseCusps,
  ];
}