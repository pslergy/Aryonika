// lib/services/geomagnetic_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../src/data/models/geomagnetic_forecast.dart';
import 'logger_service.dart';

class GeomagneticService {
  final String _apiUrl = 'https://services.swpc.noaa.gov/products/noaa-planetary-k-index-forecast.json';

  Future<List<GeomagneticForecast>> get3DayForecast() async {
    try {
      final response = await http.get(Uri.parse(_apiUrl));
      if (response.statusCode != 200) {
        throw Exception('Ошибка загрузки данных: ${response.statusCode}');
      }

      final data = json.decode(response.body) as List<dynamic>;
      if (data.length < 2) {
        throw Exception('Данные от API пришли в неверном формате.');
      }

      final forecastData = data.sublist(1);
      final List<GeomagneticForecast> allForecasts = [];

      for (final item in forecastData) {
        if (item is! List || item.length < 2) continue;

        double kpValueDouble;
        final kpValueData = item[1];

        if (kpValueData is num) {
          kpValueDouble = kpValueData.toDouble();
        } else if (kpValueData is String) {
          kpValueDouble = double.tryParse(kpValueData) ?? 0.0;
        } else {
          kpValueDouble = 0.0;
        }

        final int kpValue = kpValueDouble.round();

        try {
          final timeTag = item[0] as String;
          final time = DateTime.parse(timeTag).toLocal();
          allForecasts.add(_mapKpToForecast(time, kpValue));
        } catch (e) {
          logger.d("Пропущена строка с неверным форматом даты: $item, ошибка: $e");
        }
      }

      if (allForecasts.isEmpty) {
        throw Exception('Не удалось распарсить ни одной записи из прогноза.');
      }

      final now = DateTime.now();
      final relevantForecasts = allForecasts.where((forecast) {
        return forecast.time.add(const Duration(hours: 3)).isAfter(now);
      }).toList();

      return relevantForecasts.isNotEmpty ? relevantForecasts : [allForecasts.last];

    } catch (e) {
      logger.d('❌ Ошибка в GeomagneticService: $e');
      rethrow;
    }
  }

  // Вспомогательная функция для преобразования Kp-индекса
  GeomagneticForecast _mapKpToForecast(DateTime time, int kpValue) {
    // В поле description теперь пишем КЛЮЧ ЛОКАЛИЗАЦИИ
    if (kpValue <= 2) {
      return GeomagneticForecast(time: time, kpValue: kpValue, level: KpLevel.calm, description: 'geomagnetic_calm');
    } else if (kpValue == 3) {
      return GeomagneticForecast(time: time, kpValue: kpValue, level: KpLevel.unsettled, description: 'geomagnetic_unsettled');
    } else if (kpValue == 4) {
      return GeomagneticForecast(time: time, kpValue: kpValue, level: KpLevel.active, description: 'geomagnetic_active');
    } else if (kpValue == 5) {
      return GeomagneticForecast(time: time, kpValue: kpValue, level: KpLevel.minorStorm, description: 'geomagnetic_storm_minor');
    } else if (kpValue == 6) {
      return GeomagneticForecast(time: time, kpValue: kpValue, level: KpLevel.moderateStorm, description: 'geomagnetic_storm_moderate');
    } else if (kpValue == 7) {
      return GeomagneticForecast(time: time, kpValue: kpValue, level: KpLevel.strongStorm, description: 'geomagnetic_storm_strong');
    } else if (kpValue == 8) {
      return GeomagneticForecast(time: time, kpValue: kpValue, level: KpLevel.severeStorm, description: 'geomagnetic_storm_severe');
    } else { // kpValue == 9
      return GeomagneticForecast(time: time, kpValue: kpValue, level: KpLevel.extremeStorm, description: 'geomagnetic_storm_extreme');
    }
  }
}