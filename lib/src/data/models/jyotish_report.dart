// lib/src/data/models/jyotish_report.dart

class JyotishReport {
  final double score; // Итоговый балл из 36
  final String verdictKey; // Ключ для перевода вердикта (например, VERDICT_EXCELLENT)
  final List<KutaResult> analysis; // Детальный анализ по 8 Кутам

  JyotishReport({
    required this.score,
    required this.verdictKey,
    required this.analysis,
  });

  factory JyotishReport.fromJson(Map<String, dynamic> json) {
    final analysisList = json['analysis'] as List<dynamic>? ?? [];
    return JyotishReport(
      // Сервер присылает compatibility_score, а модель ждет score
      score: (json['compatibility_score'] as num?)?.toDouble() ?? 0.0,
      // verdict_key - это то, что нам нужно
      verdictKey: json['verdict_key'] as String? ?? 'VERDICT_UNKNOWN',
      analysis: analysisList
          .map((item) => KutaResult.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class KutaResult {
  // --- 👇 ИЗМЕНЕНИЯ ЗДЕСЬ 👇 ---
  final String key;             // Например, 'varna'
  final String nameKey;         // Новый ключ для имени, например, 'kuta_name_varna'
  final String descriptionKey;  // Новый ключ для описания, например, 'kuta_desc_varna_1'
  // --- 👆 КОНЕЦ ИЗМЕНЕНИЙ 👆 ---
  final double obtainedPoints;
  final int maxPoints;

  KutaResult({
    required this.key,
    required this.nameKey,
    required this.descriptionKey,
    required this.obtainedPoints,
    required this.maxPoints,
  });

  factory KutaResult.fromJson(Map<String, dynamic> json) {
    return KutaResult(
      key: json['key'] as String? ?? 'unknown_kuta',
      // Теперь мы читаем ключи, которые отправляет исправленный бэкенд
      nameKey: json['name_key'] as String? ?? 'unknown_name',
      descriptionKey: json['description_key'] as String? ?? 'unknown_desc',
      obtainedPoints: (json['obtained_points'] as num?)?.toDouble() ?? 0.0,
      maxPoints: json['max_points'] as int? ?? 0,
    );
  }
// --- 👆 КОНЕЦ ЗАМЕНЫ 👆 ---
}