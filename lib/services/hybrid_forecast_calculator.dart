import 'package:lovequest/services/numerology_calculator.dart';
import 'package:lovequest/src/data/models/astrology/natal_chart.dart';
import 'package:lovequest/src/data/models/daily_hybrid_forecast.dart';
import 'package:lovequest/src/data/models/numerology_report.dart';

class HybridForecastCalculator {

  static DailyHybridForecast calculate({
    required NatalChart natalChart,
    required String userName,
    required Map<String, double> currentTransits, // Из NatalChartCalculator
    required Map<String, String> numerologyDescriptions, // Из AppCubit
    required Map<String, dynamic> houseInterpretations, // Из AppCubit (focusInterpretations)
  }) {

    // 1. НУМЕРОЛОГИЯ: Личный день
    // Проверка на null для даты рождения
    final birthDate = natalChart.birthDateTime ?? DateTime.now();

    final numReport = NumerologyCalculator.generateFullReport(
        birthDateTime: birthDate,
        fullName: userName
    );
    final dayNumber = numReport.personalDay.number;

    // Получаем текст для личного дня
    final numKey = 'personal_day_$dayNumber';
    final numText = numerologyDescriptions[numKey] ??
        "Энергия числа $dayNumber. Время для действий.";

    // 2. АСТРОЛОГИЯ: Транзиты по домам
    // Для простоты возьмем транзит Луны (он меняется быстрее всех)
    // Можно добавить Солнце или Марс
    final moonPos = currentTransits['MOON'] ?? 0.0;

    // Определяем дом (упрощенно, нужен список куспидов)
    int moonHouse = 1;
    if (natalChart.houseCusps != null) {
      // Ваша логика поиска дома по градусам (AstroUtils.getHouseForPosition)
      // moonHouse = AstroUtils.getHouseForPosition(moonPos, natalChart.houseCusps!);
      // Для примера пока хардкод или простая логика
      moonHouse = (moonPos / 30).ceil();
    }

    // Получаем текст для дома
    // В focusInterpretations ключи вида 'HOUSE_1'
    final houseKey = 'HOUSE_$moonHouse';
    final houseData = houseInterpretations['houses']?[houseKey];
    final astroText = houseData?['text']?['ru'] ??
        "Луна в $moonHouse доме. Акцент на эмоциях в этой сфере.";

    // 3. СОВЕТ (Meeting Vibe / Final Advice)
    String advice = "Слушайте свое сердце.";
    if (houseData != null && houseData['advice'] != null) {
      advice = houseData['advice']['text']['ru'] ?? advice;
    }

    return DailyHybridForecast(
      personalDayNumber: dayNumber,
      numerologyText: numText,
      astrologyText: astroText,
      finalAdvice: advice,
    );
  }
}