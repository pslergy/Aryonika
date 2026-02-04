// lib/src/data/models/bazi_report.dart

class BaziReport {
  final int score;
  final String verdict;
  final List<BaziAnalysisItem> detailedAnalysis;

  BaziReport({
    required this.score,
    required this.verdict,
    required this.detailedAnalysis,
  });

  factory BaziReport.fromJson(Map<String, dynamic> json) {
    var analysisList = json['detailed_analysis'] as List? ?? [];
    List<BaziAnalysisItem> analysis = analysisList
        .map((i) => BaziAnalysisItem.fromJson(i))
        .toList();

    return BaziReport(
      score: json['score'] as int? ?? 0,
      verdict: json['verdict'] as String? ?? 'No verdict available.',
      detailedAnalysis: analysis,
    );
  }
}

class BaziAnalysisItem {
  final String text;
  final int impact;

  BaziAnalysisItem({required this.text, required this.impact});

  factory BaziAnalysisItem.fromJson(Map<String, dynamic> json) {
    return BaziAnalysisItem(
      text: json['text'] as String? ?? '',
      impact: json['impact'] as int? ?? 0,
    );
  }
}