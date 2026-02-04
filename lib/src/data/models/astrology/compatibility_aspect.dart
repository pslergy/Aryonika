// lib/src/data/models/astrology/compatibility_aspect.dart

class CompatibilityAspect {
  final String aspectType; // e.g., "Соединение", "Трин"
  final String planet1;    // e.g., "Солнце"
  final String planet2;    // e.g., "Луна"
  final String description;  // Описание аспекта
  final bool isHarmonious;
  final double orb;// Гармоничный или напряженный аспект

  CompatibilityAspect({
    required this.aspectType,
    required this.planet1,
    required this.planet2,
    required this.description,
    required this.isHarmonious,
    required this.orb,
  });
}