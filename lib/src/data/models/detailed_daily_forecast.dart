import 'package:lovequest/src/data/models/enums.dart';

enum MeetingVibe { love, friendship, networking, solitude, neutral }

class DetailedDailyForecast {
  final String date;

  // Нумерология
  final int personalDayNumber;
  final String numerologyGuidance; // Общий совет дня
  final List<String> doList;       // Что делать
  final List<String> dontList;     // Чего не делать

  // Астрология (Дома)
  // Например: "Марс в 5 доме: Время для страсти и творчества"
  final List<PlanetaryTransitInfo> planetaryTransits;

  // Прогноз знакомств
  final MeetingVibe meetingVibe;
  final String meetingAdvice; // "Сегодня отличный день для свиданий..."

  DetailedDailyForecast({
    required this.date,
    required this.personalDayNumber,
    required this.numerologyGuidance,
    required this.doList,
    required this.dontList,
    required this.planetaryTransits,
    required this.meetingVibe,
    required this.meetingAdvice,
  });
}

class PlanetaryTransitInfo {
  final String planetName; // Солнце, Марс...
  final int houseNumber;   // 1-12
  final String interpretation; // Текст описания

  PlanetaryTransitInfo(this.planetName, this.houseNumber, this.interpretation);
}