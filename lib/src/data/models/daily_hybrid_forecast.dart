class DailyHybridForecast {
  final int personalDayNumber;
  final String numerologyText;
  final String astrologyText;
  final String finalAdvice;

  DailyHybridForecast({
    required this.personalDayNumber,
    required this.numerologyText,
    required this.astrologyText,
    required this.finalAdvice,
  });

  factory DailyHybridForecast.fromMap(Map<String, dynamic> map) {
    return DailyHybridForecast(
      personalDayNumber: map['personalDayNumber'] as int? ?? 0,
      numerologyText: map['numerologyText'] as String? ?? '',
      astrologyText: map['astrologyText'] as String? ?? '',
      finalAdvice: map['finalAdvice'] as String? ?? '',
    );
  }

  // Алиас для fromJson, если привыкли так
  factory DailyHybridForecast.fromJson(Map<String, dynamic> json) => DailyHybridForecast.fromMap(json);
}