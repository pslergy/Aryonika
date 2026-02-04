import 'package:lovequest/services/numerology_calculator.dart';
import 'package:lovequest/src/data/models/astrology/natal_chart.dart';
import 'package:lovequest/src/data/models/detailed_daily_forecast.dart';
import 'package:lovequest/utils/astro_utils.dart'; // Предполагаем, что у вас есть утилиты для углов
import 'package:sweph/sweph.dart'; // Если нужно для прямых расчетов, или используем NatalChartCalculator

class HybridForecastCalculator {

  // Основной метод
  static DetailedDailyForecast calculate({
    required NatalChart natalChart,
    required String userName,
    required DateTime date,
    required Map<String, double> currentTransits, // Получим из NatalChartCalculator.calculateTodaysTransits
    required Map<String, dynamic> interpretations, // Тексты из AppCubit
  }) {

    // 1. НУМЕРОЛОГИЯ: Личный день
    final birthDate = natalChart.birthDateTime ?? DateTime.now(); // Fallback

    final report = NumerologyCalculator.generateFullReport(
        birthDateTime: birthDate,
        fullName: userName
    );
    final dayNumber = report.personalDay.number;

    // Генерируем советы based on Day Number (можно вынести в JSON/API, тут для примера хардкод)
    final numData = _getNumerologyAdvice(dayNumber);

    // 2. АСТРОЛОГИЯ: Планеты в домах
    // Нам нужно понять, в какой натальный дом попала транзитная планета.
    final List<PlanetaryTransitInfo> transitsInfo = [];

    // Ключевые планеты для прогноза
    final planetsToCheck = ['SUN', 'MARS', 'VENUS', 'JUPITER'];

    for (var planet in planetsToCheck) {
      final transitPos = currentTransits[planet]; // Например, Марс сейчас в 15 гр Льва
      if (transitPos != null) {
        // Определяем дом (1-12)
        final houseNum = _getHouseForPosition(transitPos, natalChart.houseCusps!);

        // Получаем текст (ключ вида HOUSE_TRANSIT_MARS_5)
        // В интерпретациях должен быть текст
        final text = interpretations['HOUSE_TRANSIT_${planet}_$houseNum'] ??
            "Активность в сфере ${houseNum}-го дома.";

        transitsInfo.add(PlanetaryTransitInfo(planet, houseNum, text));
      }
    }

    // 3. ЗНАКОМСТВА (Meeting Vibe)
    // Анализируем транзиты Венеры, Солнца и управителей (упрощенно по домам)
    final meetingResult = _calculateMeetingVibe(transitsInfo);

    return DetailedDailyForecast(
      date: date.toString(),
      personalDayNumber: dayNumber,
      numerologyGuidance: numData['guidance']!,
      doList: numData['do'] as List<String>,
      dontList: numData['dont'] as List<String>,
      planetaryTransits: transitsInfo,
      meetingVibe: meetingResult.key,
      meetingAdvice: meetingResult.value,
    );
  }

  // --- ХЕЛПЕРЫ ---

  static int _getHouseForPosition(double planetPos, Map<String, double> cusps) {
    // Упрощенный алгоритм поиска дома.
    // Нужно проверить, между какими куспидами находится планета.
    // Учитывайте переход через 360/0 градусов!
    for (int i = 1; i <= 12; i++) {
      double cuspStart = cusps[i.toString()]!;
      double cuspEnd = cusps[(i == 12 ? 1 : i + 1).toString()]!;

      // Логика проверки вхождения в сектор (с учетом 360)
      if (_isAngleBetween(planetPos, cuspStart, cuspEnd)) {
        return i;
      }
    }
    return 1; // Fallback
  }

  static bool _isAngleBetween(double target, double start, double end) {
    if (start < end) {
      return target >= start && target < end;
    } else {
      // Переход через 0 (например, 350...10)
      return target >= start || target < end;
    }
  }

  static MapEntry<MeetingVibe, String> _calculateMeetingVibe(List<PlanetaryTransitInfo> transits) {
    // Ищем маркеры
    bool isLove = false;
    bool isSocial = false;
    bool isSolitude = false;

    for (var t in transits) {
      // Венера или Марс в 5 (романтика) или 7 (партнерство) доме
      if ((t.planetName == 'VENUS' || t.planetName == 'MARS') && (t.houseNumber == 5 || t.houseNumber == 7)) {
        isLove = true;
      }
      // Солнце или Меркурий в 11 (друзья) или 3 (общение)
      if ((t.planetName == 'SUN' || t.planetName == 'MERCURY') && (t.houseNumber == 11 || t.houseNumber == 3)) {
        isSocial = true;
      }
      // Сатурн или 12 дом (изоляция)
      if (t.houseNumber == 12) {
        isSolitude = true;
      }
    }

    if (isSolitude && !isLove) {
      return const MapEntry(MeetingVibe.solitude, "Сегодня лучше побыть наедине с собой, восстановить энергию.");
    }
    if (isLove) {
      return const MapEntry(MeetingVibe.love, "Звезды благоволят романтике! Отличное время для свиданий или поиска любви.");
    }
    if (isSocial) {
      return const MapEntry(MeetingVibe.friendship, "Прекрасный день для встреч с друзьями и нетворкинга.");
    }

    return const MapEntry(MeetingVibe.neutral, "Спокойный день. Занимайтесь привычными делами.");
  }

  static Map<String, dynamic> _getNumerologyAdvice(int dayNumber) {
    // В идеале это должно приходить с сервера (ApiRepository.getNumerologyForecasts)
    // Но пока можно зашить базу здесь
    switch (dayNumber) {
      case 1: return {
        'guidance': 'День начала новых дел и проявления инициативы.',
        'do': ['Начинать проекты', 'Принимать решения', 'Быть лидером'],
        'dont': ['Лениться', 'Следовать за толпой', 'Откладывать на потом']
      };
      case 5: return {
        'guidance': 'День перемен, свободы и приключений.',
        'do': ['Искать новое', 'Путешествовать', 'Знакомиться'],
        'dont': ['Придерживаться рутины', 'Заключать долгосрочные контракты']
      };
    // ... остальные цифры
      default: return {
        'guidance': 'Следуйте своей интуиции.',
        'do': ['Быть осознанным'],
        'dont': ['Рисковать без причины']
      };
    }
  }
}