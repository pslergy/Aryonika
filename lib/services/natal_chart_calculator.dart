import 'dart:async';
import 'dart:convert';
import 'dart:io';
// Убираем dart:io из глобального импорта, чтобы веб не ругался
// import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:lovequest/services/logger_service.dart';
import 'package:lovequest/src/data/models/astrology/natal_chart.dart';
// import 'package:path_provider/path_provider.dart'; // Убираем, будем импортировать динамически или использовать костыль
import 'package:sweph/sweph.dart';

// --- 👇 ИМПОРТЫ ТОЛЬКО ДЛЯ МОБИЛОК (через условный экспорт) 👇 ---
// Это хак, чтобы компилятор веба не ругался на Directory/File.
// В идеале нужно вынести инициализацию в отдельные файлы: mobile_init.dart и web_init.dart.
// Но для быстрого фикса можно использовать universal_io, если он есть в зависимостях.
// Если нет, то придется делать так:

// --- ВМЕСТО ЭТОГО ДАВАЙ СДЕЛАЕМ ПРОЩЕ ---
// Мы создадим абстрактный класс-инициализатор и две реализации.

// ---------------------------------------------------------------------------
// ЧАСТЬ 1: ЛОГИКА ИНИЦИАЛИЗАЦИИ (ВСТАВЬ ЭТО В ТОТ ЖЕ ФАЙЛ ИЛИ ОТДЕЛЬНО)
// ---------------------------------------------------------------------------

// Этот код будет работать, только если ты добавишь `universal_io` в pubspec.yaml
// flutter pub add universal_io

// path_provider все равно нужен, но он безопасен при импорте, главное не вызывать его методы в вебе.
import 'package:path_provider/path_provider.dart';

class NatalChartCalculator {
  bool _isInitialized = false;

  Future<void> initialize() async {
    if (_isInitialized) {
      // logger.d("🔍 [NatalChartCalculator] Уже инициализирован. Пропускаю.");
      return;
    }

    logger.d("🚀 [NatalChartCalculator] Начинаю инициализацию...");

    if (kIsWeb) {
      // --- ЛОГИКА ДЛЯ ВЕБА ---
      logger.d("[NatalChartCalculator] Запуск в Web. Устанавливаю пустой путь и базовый URL.");

      // 1. Инициализируем с пустым путем.
      await Sweph.init(ephePath: '');

      // 2. Устанавливаем базовый URL (относительный путь к assets)
      const baseUrl = 'assets/ephe/';
      Sweph.setBaseUrl(baseUrl);
      logger.d("[NatalChartCalculator] Базовый URL для эфемерид: $baseUrl");

    } else {
      // --- ЛОГИКА ДЛЯ МОБИЛЬНЫХ УСТРОЙСТВ ---
      logger.d("[NatalChartCalculator] Запуск на Mobile. Копирую эфемериды из assets...");

      final documentsDir = await getApplicationDocumentsDirectory();
      final ephePath = '${documentsDir.path}/ephe';
      final epheDir = Directory(ephePath);

      // Проверяем, существует ли папка, если нет - создаем
      if (!await epheDir.exists()) {
        await epheDir.create(recursive: true);
      }

      // Список файлов, которые точно есть в pubspec.yaml
      // Если добавишь новые файлы эфемерид, добавь их и сюда!
      const knownEpheFiles = [
        'seas_18.se1',
        'semo_18.se1',
        'semo_24.se1',
        'sepl_18.se1',
        'sepl_24.se1',
        'seplm18.se1'
      ];

      for (final filename in knownEpheFiles) {
        final file = File('$ephePath/$filename');

        // Копируем, только если файла нет (для ускорения запуска)
        if (!await file.exists()) {
          try {
            final assetPath = 'assets/ephe/$filename';
            // logger.d("   + Копирую $filename...");

            final byteData = await rootBundle.load(assetPath);
            final buffer = byteData.buffer.asUint8List();
            await file.writeAsBytes(buffer, flush: true);
          } catch (e) {
            logger.d("❌ Ошибка копирования $filename: $e");
            // Не прерываем цикл, пробуем скопировать остальные
          }
        }
      }

      logger.d("--- Sweph init: Файлы эфемерид проверены/скопированы.");

      // Инициализируем библиотеку с путем к папке документов
      await Sweph.init(ephePath: ephePath);
    }

    _isInitialized = true;
    logger.d("[NatalChartCalculator] ✅ Инициализация Sweph завершена.");
  }

  Future<NatalChart?> calculateAll(int birthDateMillis, double latitude, double longitude) async {
    if (!_isInitialized) {
      await initialize();
    }

    try {
      final birthDate = DateTime.fromMillisecondsSinceEpoch(birthDateMillis, isUtc: true);
      final julianDay = Sweph.swe_utc_to_jd(
        birthDate.year, birthDate.month, birthDate.day,
        birthDate.hour, birthDate.minute, birthDate.second.toDouble(),
        CalendarType.SE_GREG_CAL,
      )[0];

      final houseData = Sweph.swe_houses(julianDay, latitude, longitude, Hsys.P);

      final positionsMap = <String, double>{};
      positionsMap['ASC'] = houseData.cusps[0];

      for (final planet in Planet.values) {
        if (planet == Planet.ASC) continue;
        final body = _planetToHeavenlyBody(planet);
        if (body != null) {
          final planetData = Sweph.swe_calc_ut(julianDay, body, SwephFlag.SEFLG_SPEED);
          positionsMap[planet.name.toUpperCase()] = planetData.longitude;
        }
      }

      final cuspsMap = <String, double>{};
      for (int i = 0; i < houseData.cusps.length; i++) {
        cuspsMap[(i + 1).toString()] = houseData.cusps[i];
      }

      return NatalChart(
        sunSign: _getSignKeyForPosition(positionsMap['SUN']!),
        moonSign: _getSignKeyForPosition(positionsMap['MOON']!),
        mercurySign: _getSignKeyForPosition(positionsMap['MERCURY']!),
        venusSign: _getSignKeyForPosition(positionsMap['VENUS']!),
        marsSign: _getSignKeyForPosition(positionsMap['MARS']!),
        jupiterSign: _getSignKeyForPosition(positionsMap['JUPITER']!),
        saturnSign: _getSignKeyForPosition(positionsMap['SATURN']!),
        uranusSign: _getSignKeyForPosition(positionsMap['URANUS']!),
        neptuneSign: _getSignKeyForPosition(positionsMap['NEPTUNE']!),
        plutoSign: _getSignKeyForPosition(positionsMap['PLUTO']!),
        ascendantSign: _getSignKeyForPosition(positionsMap['ASC']!),
        planetPositions: positionsMap,
        birthDateTime: DateTime.fromMillisecondsSinceEpoch(birthDateMillis),
        latitude: latitude,
        longitude: longitude,
        houseCusps: cuspsMap,
      );
    } catch (e, st) {
      logger.d("❌ Ошибка при расчете натальной карты: $e");
      logger.d(st);
      return null;
    }
  }

  Future<Map<Planet, double>> calculateTodaysTransits() async {
    if (!_isInitialized) {
      await initialize();
    }

    try {
      final now = DateTime.now().toUtc();
      final julianDay = Sweph.swe_utc_to_jd(
        now.year, now.month, now.day,
        now.hour, now.minute, now.second.toDouble(),
        CalendarType.SE_GREG_CAL,
      )[0];

      final positionsMap = <Planet, double>{};
      for (final planet in Planet.values) {
        if (planet == Planet.ASC) continue;
        final body = _planetToHeavenlyBody(planet);
        if (body != null) {
          final planetData = Sweph.swe_calc_ut(julianDay, body, SwephFlag.SEFLG_SPEED);
          positionsMap[planet] = planetData.longitude;
        }
      }
      return positionsMap;
    } catch (e, st) {
      logger.d("❌ Ошибка при расчете транзитов: $e");
      logger.d(st);
      return {};
    }
  }

  HeavenlyBody? _planetToHeavenlyBody(Planet planet) {
    const map = {
      Planet.SUN: HeavenlyBody.SE_SUN,
      Planet.MOON: HeavenlyBody.SE_MOON,
      Planet.MERCURY: HeavenlyBody.SE_MERCURY,
      Planet.VENUS: HeavenlyBody.SE_VENUS,
      Planet.MARS: HeavenlyBody.SE_MARS,
      Planet.JUPITER: HeavenlyBody.SE_JUPITER,
      Planet.SATURN: HeavenlyBody.SE_SATURN,
      Planet.URANUS: HeavenlyBody.SE_URANUS,
      Planet.NEPTUNE: HeavenlyBody.SE_NEPTUNE,
      Planet.PLUTO: HeavenlyBody.SE_PLUTO,
    };
    return map[planet];
  }

  String _getSignKeyForPosition(double position) {
    const signs = ["Aries", "Taurus", "Gemini", "Cancer", "Leo", "Virgo", "Libra", "Scorpio", "Sagittarius", "Capricorn", "Aquarius", "Pisces"];
    final signIndex = (position / 30).floor() % 12;
    return signs[signIndex];
  }
}