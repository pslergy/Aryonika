// lib/services/cosmic_events_calculator.dart

import 'package:lovequest/services/logger_service.dart';
import 'package:lovequest/src/data/models/aspect_interpretation.dart';
import 'package:lovequest/src/data/models/astrology/natal_chart.dart';
import 'package:lovequest/src/data/models/cosmic_event.dart';
import 'package:lovequest/utils/astro_utils.dart';

class _RankedEvent {
  final CosmicEvent event;
  final int score;
  _RankedEvent({required this.event, required this.score});
}

class CosmicEventsCalculator {
  static const List<String> _planetsToTrack = [
    "SUN", "MOON", "MERCURY", "VENUS", "MARS", "JUPITER", "SATURN"
  ];

  static List<CosmicEvent> calculateCurrentEvents({
    required Map<String, double> transits,
    required NatalChart natalChart,
    required Map<String, AspectInterpretation> interpretations,
    String langCode = 'ru',
    double orb = 5.0,
  }) {
    logger.d("--- 🪐 CosmicEventsCalculator: НАЧАТ РАСЧЕТ ---");
    final List<_RankedEvent> rankedEvents = [];
    final natalPositions = natalChart.planetPositions ?? {};

    for (String transitingPlanet in _planetsToTrack) {
      final transitPos = transits[transitingPlanet];
      if (transitPos == null) continue;

      for (String natalPlanet in _planetsToTrack) {
        final natalPos = natalPositions[natalPlanet];
        if (natalPos == null) continue;

        double angle = (transitPos - natalPos).abs();
        if (angle > 180) angle = 360 - angle;

        String? aspectName;
        if (angle <= orb) aspectName = "CONJUNCTION";
        else if ((angle >= 60 - orb && angle <= 60 + orb)) aspectName = "SEXTILE";
        else if ((angle >= 90 - orb && angle <= 90 + orb)) aspectName = "SQUARE";
        else if ((angle >= 120 - orb && angle <= 120 + orb)) aspectName = "TRINE";
        else if ((angle >= 180 - orb && angle <= 180 + orb)) aspectName = "OPPOSITION";

        if (aspectName != null) {
          String key;
          if (transitingPlanet == natalPlanet) {
            final isHarmonious = (aspectName == "TRINE" || aspectName == "SEXTILE");
            key = "${transitingPlanet}_${natalPlanet}_${isHarmonious ? 'HARMONIOUS' : 'TENSE'}";
          } else {
            final sorted = [transitingPlanet, natalPlanet]..sort();
            key = "${sorted[0]}_${aspectName}_${sorted[1]}";
          }

          final interpretation = interpretations[key];

          if (interpretation != null) {
            // --- 👇 ИСПРАВЛЕННЫЙ КОНСТРУКТОР 👇 ---
            // Теперь типы совпадают!
            final event = CosmicEvent(
              id: key,
              eventType: 'TRANSITING_ASPECT',
              eventDate: DateTime.now(),
              title: interpretation.title, // String -> String (OK!)
              description: interpretation.description, // String -> String (OK!)
              personalAdvice: '', // String -> String (OK!)
              transitingPlanet: transitingPlanet,
              aspect: aspectName,
              natalPlanet: natalPlanet,
              planetSign: AstroUtils.getSignForPosition(transitPos),
            );
            // --- КОНЕЦ ИСПРАВЛЕНИЯ ---

            int score = (transitingPlanet == 'SUN' || transitingPlanet == 'MOON') ? 10 : 5;
            rankedEvents.add(_RankedEvent(event: event, score: score));
          }
        }
      }
    }

    rankedEvents.sort((a, b) => b.score.compareTo(a.score));
    return rankedEvents.map((e) => e.event).take(5).toList();
  }
}