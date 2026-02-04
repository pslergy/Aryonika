// lib/utils/extensions.dart


// Добавляем метод toFirestore в класс NatalChart
import 'dart:core';

import '../services/numerology_calculator.dart';
import '../src/data/models/astrology/natal_chart.dart';
import '../src/data/models/numerology_report.dart';

extension NatalChartFirestore on NatalChart {
  Map<String, dynamic> toFirestore() {
    return {
      // Все поля знаков остаются без изменений
      'sunSign': sunSign,
      'moonSign': moonSign,
      'ascendantSign': ascendantSign,
      'mercurySign': mercurySign,
      'venusSign': venusSign,
      'marsSign': marsSign,
      'jupiterSign': jupiterSign,
      'saturnSign': saturnSign,
      'uranusSign': uranusSign,
      'neptuneSign': neptuneSign,
      'plutoSign': plutoSign,

      // --- 👇 ВОТ ГЛАВНЫЕ ИСПРАВЛЕНИЯ 👇 ---

      // `planetPositions` уже имеет нужный тип `Map<String, double>`,
      // поэтому просто передаем его.
      'planetPositions': planetPositions,

      // `houseCusps` тоже уже имеет нужный тип `Map<String, double>`,
      // передаем его как есть.
      'houseCusps': houseCusps,
    };
  }
}

// Добавляем метод toFirestore в класс NumerologyReport
extension PersonalNumerologyReportFirestore on PersonalNumerologyReport {
  Map<String, int> toFirestore() {
    return {
      'lifePath': lifePath.number,
      'expression': destiny.number, // Используем поля из PersonalNumerologyReport
      'soulUrge': soulUrge.number,
      'personality': personality.number,
      'birthDay': birthday.number,
      'maturity': maturity.number,
      'personalYear': personalYear.number,
      'personalMonth': personalMonth.number,
      'personalDay': personalDay.number,
    };
  }
}

extension StringExtension on String {

  /// Делает первую букву строки заглавной, а остальные - строчными.
  /// Пример: "hElLo WorLD".capitalizeFirst() -> "Hello world"
  String capitalizeFirst() {
    if (this.isEmpty) return '';
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }

}