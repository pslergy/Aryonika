// lib/services/compatibility_calculator.dart
import 'dart:math';

import 'package:lovequest/services/logger_service.dart';
import 'package:lovequest/src/data/models/aspect_interpretation.dart';
import 'package:lovequest/src/data/models/astrology/compatibility_report.dart';
import 'package:lovequest/src/data/models/astrology/natal_chart.dart';

import '../src/data/models/numerology_report.dart';


// Внутренний класс для хранения результата расчета аспекта.
class _AspectResult {
  final int score;
  final String text;
  _AspectResult(this.score, this.text);
}

// Конфигурация весов для каждого аспекта в общем расчете.
class WeightConfig {
  final double sun, moon, chemistry, mercury, saturn, numerology;
  const WeightConfig({
    this.sun = 1.0, this.moon = 1.2, this.chemistry = 1.1, this.mercury = 0.8,
    this.saturn = 0.7, this.numerology = 0.9,
  });
}

class CompatibilityCalculator {
  // Карта позиций знаков зодиака для расчета расстояния между ними.
  static const Map<String, int> _signPositions = {
    "Aries": 0, "Taurus": 1, "Gemini": 2, "Cancer": 3, "Leo": 4, "Virgo": 5,
    "Libra": 6, "Scorpio": 7, "Sagittarius": 8, "Capricorn": 9, "Aquarius": 10, "Pisces": 11
  };

  // Главный статический метод, который выполняет все расчеты.
  static CompatibilityReport calculate({
    required NatalChart chart1,
    required NatalChart chart2,
    required Map<String, int>? numerology1,
    required Map<String, int>? numerology2,
    required String partnerName,
    required Map<String, AspectInterpretation> interpretations,
    // --- НОВЫЙ ПАРАМЕТР: Словарь с описаниями для нумерологии ---
    required Map<String, String> numerologyDescriptions,
    String langCode = 'ru',
    WeightConfig weights = const WeightConfig(),
  }) {
    final details = <CompatibilityDetail>[];

    final String defaultAspectText = interpretations['ASPECT_DEFAULT']?.getLocalizedGeneralDescription(langCode) ?? "Требуется индивидуальный анализ.";
    final String errorAspectText = interpretations['ASPECT_ERROR']?.getLocalizedGeneralDescription(langCode) ?? "Недостаточно данных для анализа.";

    // -------------------------------------------------------------------------
    // --- 1. ВНУТРЕННИЕ ФУНКЦИИ-ХЕЛПЕРЫ ---
    // -------------------------------------------------------------------------

    // Функция для расчета астрологических аспектов
    _AspectResult getAspectResult(String? sign1, String? sign2, String planet1, String planet2) {
      if (sign1 == null || sign2 == null) return _AspectResult(30, errorAspectText);

      final pos1 = _signPositions[sign1]!, pos2 = _signPositions[sign2]!;
      final distance = (pos1 - pos2).abs();
      final aspectDistance = distance > 6 ? 12 - distance : distance;

      String aspectName;
      int score;

      switch (aspectDistance) {
        case 0: aspectName = "CONJUNCTION"; score = 100; break;
        case 4: aspectName = "TRINE"; score = 95; break;
        case 2: aspectName = "SEXTILE"; score = 85; break;
        case 6: aspectName = "OPPOSITION"; score = 65; break;
        case 3: aspectName = "SQUARE"; score = 40; break;
        default: aspectName = "QUINCUNX"; score = 50; break;
      }

      String? text;
      String fullKey;

      if (planet1 == planet2) {
        final harmonyKey = (score >= 65) ? "HARMONIOUS" : "TENSE";
        fullKey = "${planet1}_${planet2}_$harmonyKey";
        text = interpretations[fullKey]?.getLocalizedGeneralDescription(langCode);
        logger.d("--- [Calculator] Ищем аспект (same-planet): $fullKey. Найден? ${text != null}");
      } else {
        final sortedPlanets = [planet1, planet2]..sort();
        fullKey = "${sortedPlanets[0]}_${aspectName}_${sortedPlanets[1]}"; // -> MARS_QUINCUNX_VENUS
        text = interpretations[fullKey]?.getLocalizedGeneralDescription(langCode);
        logger.d("--- [Calculator] Ищем аспект (cross-planet): $fullKey. Найден? ${text != null}");

        // --- 👇 ВОТ ЭТА ЛОГИКА ДОЛЖНА СРАБОТАТЬ 👇 ---
        if (text == null || text.isEmpty) { // <-- ПРОВЕРЯЕМ И НА NULL, И НА ПУСТУЮ СТРОКУ
          final defaultKeyForAspect = "ASPECT_${aspectName}_DEFAULT";
          text = interpretations[defaultKeyForAspect]?.getLocalizedGeneralDescription(langCode);
          logger.d("--- [Calculator] Конкретный аспект не найден. Ищем заглушку: $defaultKeyForAspect. Найден? ${text != null && text.isNotEmpty}");
        }
      }

      return _AspectResult(score, text ?? defaultAspectText);
    }

    // --- 👇 НОВАЯ ФУНКЦИЯ ДЛЯ НУМЕРОЛОГИИ 👇 ---
    _AspectResult getNumerologyResult() {
      // Проверка входных данных остается той же
      if (numerology1 == null || numerology2 == null ||
          !numerology1.containsKey('lifePath') || !numerology2.containsKey('lifePath')) {
        // Получаем текст ошибки. Так как у нас теперь плоский Map, доступ проще.
        final text = numerologyDescriptions['error'] ?? "Ошибка данных нумерологии.";
        return _AspectResult(50, text);
      }

      int n1 = numerology1['lifePath']!;
      int n2 = numerology2['lifePath']!;

      if (n1 > n2) {
        final temp = n1;
        n1 = n2;
        n2 = temp;
      }

      final key = '${n1}_${n2}';

      // --- ГЛАВНОЕ ИЗМЕНЕНИЕ: Упрощаем получение текста ---
      // Теперь мы просто берем значение по ключу. Если его нет, берем значение по ключу 'default'.
      final text = numerologyDescriptions[key] ??
          numerologyDescriptions['default'] ??
          "Анализ совместимости чисел ${n1} и ${n2} показывает уникальную динамику...";

      // Логика оценки остается без изменений
      int score = 65;
      if (n1 == n2) score = 100;
      else if (([1,5,7].contains(n1) && [1,5,7].contains(n2)) ||
          ([2,4,8].contains(n1) && [2,4,8].contains(n2)) ||
          ([3,6,9].contains(n1) && [3,6,9].contains(n2))) {
        score = 85;
      } else if ((n1-n2).abs() % 3 == 0) {
        score = 75;
      } else {
        score = 45;
      }

      logger.d("--- [Calculator] Ищем нумерологию: ключ $key. Найден текст? ${(text.length > 30)}");
      return _AspectResult(score, text);
    }

    // -------------------------------------------------------------------------
    // --- 2. РАСЧЕТ И ДОБАВЛЕНИЕ ДЕТАЛЕЙ ---
    // -------------------------------------------------------------------------

    // Астрология
    final sunAspect = getAspectResult(chart1.sunSign, chart2.sunSign, "SUN", "SUN");
    final moonAspect = getAspectResult(chart1.moonSign, chart2.moonSign, "LUNA", "LUNA");
    final mercuryAspect = getAspectResult(chart1.mercurySign, chart2.mercurySign, "MERCURY", "MERCURY");
    final saturnAspect = getAspectResult(chart1.saturnSign, chart2.saturnSign, "SATURN", "SATURN");
    final chemistryAspect = getAspectResult(chart1.venusSign, chart2.marsSign, "VENUS", "MARS");

    // Нумерология
    final numerologyResult = getNumerologyResult();

    details.addAll([
      CompatibilityDetail(key: "sun", titleKey: "astro_title_sun", description: sunAspect.text, score: sunAspect.score),
      CompatibilityDetail(key: "moon", titleKey: "astro_title_moon", description: moonAspect.text, score: moonAspect.score, isProFeature: true),
      CompatibilityDetail(key: "chemistry", titleKey: "astro_title_chemistry", description: chemistryAspect.text, score: chemistryAspect.score, isProFeature: true),
      CompatibilityDetail(key: "mercury", titleKey: "astro_title_mercury", description: mercuryAspect.text, score: mercuryAspect.score),
      CompatibilityDetail(key: "saturn", titleKey: "astro_title_saturn", description: saturnAspect.text, score: saturnAspect.score, isProFeature: true),
      // --- 👇 ЗАМЕНЯЕМ ЗАГЛУШКУ НА РЕАЛЬНЫЕ ДАННЫЕ 👇 ---
      CompatibilityDetail(key: "numerology", titleKey: "numerology_title", description: numerologyResult.text, score: numerologyResult.score, isProFeature: true),
    ]);

    // -------------------------------------------------------------------------
    // --- 3. ИТОГОВЫЙ СЧЕТ И ФОРМИРОВАНИЕ ОТЧЕТА ---
    // -------------------------------------------------------------------------

    final double totalWeightedScore =
        (sunAspect.score * weights.sun) +
            (moonAspect.score * weights.moon) +
            (chemistryAspect.score * weights.chemistry) +
            (mercuryAspect.score * weights.mercury) +
            (saturnAspect.score * weights.saturn) +
            (numerologyResult.score * weights.numerology); // Используем реальный балл

    final double totalWeights = weights.sun + weights.moon + weights.chemistry + weights.mercury + weights.saturn + weights.numerology;

    final int totalScore = (totalWeights > 0) ? (totalWeightedScore / totalWeights).round().clamp(10, 99) : 50;

    // Сортировка
    details.sort((a, b) {
      const order = {"sun": 1, "moon": 2, "chemistry": 3, "mercury": 4, "saturn": 5, "numerology": 6};
      return (order[a.key] ?? 99).compareTo(order[b.key] ?? 99);
    });

    // --- 👇 СОЗДАЕМ ОБЪЕКТ НУМЕРОЛОГИИ 👇 ---
    NumerologyCompatibilityReport? numerologyReportObj;

    if (numerology1 != null && numerology2 != null) {

      // Вспомогательная функция для создания сравнения
      NumerologyComparison? createComp(String title, String key) { // Возвращаем nullable
        final v1 = numerology1![key];
        final v2 = numerology2![key];

        // Если числа 0 или null - пропускаем этот аспект
        if (v1 == null || v2 == null || v1 == 0 || v2 == 0) {
          return null;
        }

        return NumerologyComparison(
            type: title,
            text: "Описание отсутствует",
            harmony: "medium",
            value1: v1,
            value2: v2
        );
      }

      final comparisons = <NumerologyComparison>[];

      // 1. Жизненный Путь (самый важный)
      if (numerology1!.containsKey('lifePath')) {
        // Для Life Path у нас уже есть рассчитанный результат, используем его!
        comparisons.add(NumerologyComparison(
          type: "Жизненный Путь",
          text: numerologyResult.text, // Тут текст уже есть!
          harmony: (numerologyResult.score >= 80) ? "high" : "medium",
          value1: numerology1!['lifePath'],
          value2: numerology2!['lifePath'],
        ));
      }

      // 2. Число Судьбы
      if (numerology1!.containsKey('destiny')) {
        final comp = createComp("Число Судьбы", 'destiny'); // <-- Объявляем и вызываем
        if (comp != null) comparisons.add(comp);
      }

      // 3. Число Души
      if (numerology1!.containsKey('soul')) {
        final comp = createComp("Число Души", 'soul');
        if (comp != null) comparisons.add(comp);
      }

      // 4. Число Личности
      if (numerology1!.containsKey('personality')) {
        final comp = createComp("Число Личности", 'personality');
        if (comp != null) comparisons.add(comp);
      }

      numerologyReportObj = NumerologyCompatibilityReport(
        totalScore: numerologyResult.score,
        shortText: numerologyResult.text,
        comparisons: comparisons,
      );
    }
    // -----------------------------------------

    return CompatibilityReport(
      totalScore: totalScore,
      details: details,
      partnerName: partnerName,
      numerologyReport: numerologyReportObj, // <--- ТЕПЕРЬ ПЕРЕДАЕМ!
    );
  } }