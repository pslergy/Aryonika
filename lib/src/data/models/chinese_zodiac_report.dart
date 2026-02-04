// lib/src/data/models/chinese_zodiac_report.dart
class ChineseZodiacReport {
  final String mySign;
  final String theirSign;
  final int score;
  final String title;
  final String description;
  final List<String> pros;
  final List<String> cons;

  ChineseZodiacReport({
    required this.mySign,
    required this.theirSign,
    required this.score,
    required this.title,
    required this.description,
    required this.pros,
    required this.cons,
  });

  factory ChineseZodiacReport.fromJson(Map<String, dynamic> json) {
    return ChineseZodiacReport(
      mySign: json['mySign'] as String? ?? '',
      theirSign: json['theirSign'] as String? ?? '',
      score: json['score'] as int? ?? 0,
      title: json['title'] as String? ?? '...',
      description: json['description'] as String? ?? '...',
      pros: List<String>.from(json['pros'] ?? []),
      cons: List<String>.from(json['cons'] ?? []),
    );
  }
}