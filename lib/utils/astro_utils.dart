// lib/utils/astro_utils.dart
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lovequest/src/data/models/astrology/compatibility_aspect.dart';

import '../src/data/models/astrology/natal_chart.dart';
import '../src/data/models/transiting_aspect.dart';
 // Для enum Planet

// ================================================================
// === ENUM С ТИПАМИ АСПЕКТОВ ===
// ================================================================
enum AspectType {
  CONJUNCTION, // 0°
  OPPOSITION,  // 180°
  SQUARE,      // 90°
  TRINE,       // 120°
  SEXTILE,     // 60°
}

class AstroUtils {
  // === ИЗМЕНЯЕМ ТИП ВОЗВРАЩАЕМОГО ЗНАЧЕНИЯ ===
  static List<TransitingAspect> findAspects({
    required Map<Planet, double> positions1, // транзиты
    required Map<Planet, double> positions2, // натал
    required Set<AspectType> allowedAspects,
    double maxOrb = 8.0,
  }) {
    final List<TransitingAspect> foundAspects = []; // <-- Тип списка тоже меняется

    for (final entry1 in positions1.entries) {
      for (final entry2 in positions2.entries) {
        final planet1 = entry1.key;
        final pos1 = entry1.value;
        final planet2 = entry2.key;
        final pos2 = entry2.value;

        // В прогнозах нам НУЖНЫ аспекты одноименных планет
        // (например, транзитный Сатурн к натальному Сатурну - это "возвращение Сатурна")
        // if (planet1 == planet2) continue; // <-- Эту проверку можно убрать для транзитов

        double angle = (pos1 - pos2).abs();
        if (angle > 180) {
          angle = 360 - angle;
        }

        for (final aspectType in allowedAspects) {
          final double targetAngle = _getAngleForAspectType(aspectType);
          final double orb = (angle - targetAngle).abs();

          if (orb <= maxOrb) {
            // === СОЗДАЕМ ОБЪЕКТ НОВОГО КЛАССА ===
            foundAspects.add(TransitingAspect(
              transitingPlanet: entry1.key,
              natalPlanet: entry2.key,
              aspectType: aspectType,
              orb: orb,
            ));
          }
        }
      }
    }
    return foundAspects;
  }
  /// Определяет знак зодиака по градусу эклиптики (0-360).
  /// Например, 15.0° -> "Aries", 35.0° -> "Taurus".
  static String getSignForPosition(double position) {
    // Массив знаков в правильном порядке
    const signs = [
      "Aries", "Taurus", "Gemini", "Cancer", "Leo", "Virgo",
      "Libra", "Scorpio", "Sagittarius", "Capricorn", "Aquarius", "Pisces"
    ];

    // Каждый знак занимает 30 градусов. Делим позицию на 30 и округляем вниз,
    // чтобы получить индекс знака (от 0 до 11).
    final index = (position / 30).floor();

    // Используем остаток от деления на 12 на случай, если позиция > 360
    return signs[index % 12];
  }


  // === МЕТОД №2: НОВЫЙ, СПЕЦИАЛЬНО ДЛЯ ТРАНЗИТОВ ===
  static List<TransitingAspect> findTransitingAspects({
    required Map<String, double> transitingPositions,
    required Map<String, double> natalPositions,
    required Set<AspectType> allowedAspects,
    double maxOrb = 8.0,
  }) {
    final List<TransitingAspect> foundAspects = [];
    final allPlanets = Planet.values.where((p) => p != Planet.ASC).toList();

    // Преобразуем Enum в строки для поиска в картах
    final planetKeys = allPlanets.map((p) => p.name.toUpperCase()).toList();

    for (String transitingPlanetKey in planetKeys) {
      final transitPos = transitingPositions[transitingPlanetKey];
      if (transitPos == null) continue;

      for (String natalPlanetKey in planetKeys) {
        final natalPos = natalPositions[natalPlanetKey];
        if (natalPos == null) continue;

        double angle = (transitPos - natalPos).abs();
        if (angle > 180) angle = 360 - angle;

        AspectType? aspectType;
        if (allowedAspects.contains(AspectType.CONJUNCTION) && angle <= maxOrb) aspectType = AspectType.CONJUNCTION;
        else if (allowedAspects.contains(AspectType.OPPOSITION) && (angle >= 180 - maxOrb)) aspectType = AspectType.OPPOSITION;
        else if (allowedAspects.contains(AspectType.SQUARE) && (angle >= 90 - maxOrb && angle <= 90 + maxOrb)) aspectType = AspectType.SQUARE;
        else if (allowedAspects.contains(AspectType.TRINE) && (angle >= 120 - maxOrb && angle <= 120 + maxOrb)) aspectType = AspectType.TRINE;
        else if (allowedAspects.contains(AspectType.SEXTILE) && (angle >= 60 - maxOrb && angle <= 60 + maxOrb)) aspectType = AspectType.SEXTILE;

        if (aspectType != null) {
          // Вычисляем точный orb
          double orbValue;
          if (aspectType == AspectType.CONJUNCTION) orbValue = angle;
          else if (aspectType == AspectType.OPPOSITION) orbValue = (180 - angle).abs();
          else if (aspectType == AspectType.SQUARE) orbValue = (90 - angle).abs();
          else if (aspectType == AspectType.TRINE) orbValue = (120 - angle).abs();
          else orbValue = (60 - angle).abs();

          // Определяем, сходящийся или расходящийся аспект (здесь нужна логика скоростей, пока опустим)
          bool isApplying = true;

          // --- Преобразуем строки обратно в Enum для создания объекта ---
          final transitingPlanet = Planet.values.firstWhere((p) => p.name.toUpperCase() == transitingPlanetKey);
          final natalPlanet = Planet.values.firstWhere((p) => p.name.toUpperCase() == natalPlanetKey);

          foundAspects.add(
            TransitingAspect(
              transitingPlanet: transitingPlanet,
              natalPlanet: natalPlanet,
              aspectType: aspectType,
              orb: orbValue,

            ),
          );
        }
      }
    }
    return foundAspects;
  }


  // Приватный метод-помощник для findAspects
  static double _getAngleForAspectType(AspectType type) {
    switch (type) {
      case AspectType.CONJUNCTION: return 0.0;
      case AspectType.OPPOSITION: return 180.0;
      case AspectType.SQUARE: return 90.0;
      case AspectType.TRINE: return 120.0;
      case AspectType.SEXTILE: return 60.0;
    }
  }

  // ================================================================
  // === ТВОЙ СУЩЕСТВУЮЩИЙ МЕТОД ОСТАЕТСЯ ЗДЕСЬ ===
  // ================================================================
  static int getHouseForPosition(double planetPosition, Map<String, double> houseCusps) {
    // 1. Проверка на пустые данные
    if (houseCusps.isEmpty || houseCusps.length < 12) {
      // Если данных о домах нет, нельзя рассчитать. Можно вернуть 1 как заглушку.
      return 1;
    }

    // 2. Преобразуем карту в упорядоченный список градусов куспидов.
    final List<double> cusps = [];
    for (int i = 1; i <= 12; i++) {
      cusps.add(houseCusps[i.toString()]!);
    }

    // 3. Главный цикл проверки
    for (int i = 0; i < 12; i++) {
      final houseNumber = i + 1;

      final startCusp = cusps[i];
      // Конец дома - это начало следующего. Для 12-го дома это начало 1-го.
      final endCusp = cusps[(i + 1) % 12];

      double correctedPlanetPos = planetPosition;

      // 4. Обработка "перехода через 0° Овна"
      // Если начало дома (например, 280°) больше, чем конец (например, 10°),
      // то дом пересекает точку 0.
      if (startCusp > endCusp) {
        // Если позиция планеты "до" точки 0 (например, 300°), она в доме.
        // Если позиция "после" (например, 5°), она тоже в доме.
        if (correctedPlanetPos >= startCusp || correctedPlanetPos < endCusp) {
          return houseNumber;
        }
      }
      // 5. Стандартный случай
      else {
        if (correctedPlanetPos >= startCusp && correctedPlanetPos < endCusp) {
          return houseNumber;
        }
      }
    }

    // 6. Запасной вариант, если что-то пошло не так.
    // Обычно до этого не доходит.
    return 1;
  }


  IconData getZodiacIcon(String sunSign) {
    // Это заглушка, в идеале использовать кастомный шрифт с иконками
    // Например, `AstrologyIcons.aries`
    switch (sunSign.toLowerCase()) {
      case 'aries': return Icons.circle; // Замени на реальные иконки
      case 'taurus': return Icons.square;
      case 'gemini': return Icons.pentagon;
    // ... и так далее для всех 12 знаков
      default: return Icons.help_outline;
    }
  }

// Альтернатива - текстовые символы
  String getZodiacSymbol(String sunSign) {
    switch (sunSign.toLowerCase()) {
      case 'aries': return '♈';
      case 'taurus': return '♉';
      case 'gemini': return '♊';
      case 'cancer': return '♋';
      case 'leo': return '♌';
      case 'virgo': return '♍';
      case 'libra': return '♎';
      case 'scorpio': return '♏';
      case 'sagittarius': return '♐';
      case 'capricorn': return '♑';
      case 'aquarius': return '♒';
      case 'pisces': return '♓';
      default: return '?';
    }
  }
}