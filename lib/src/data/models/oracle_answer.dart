// lib/src/data/models/oracle_answer.dart
class OracleAnswer {
  final String text;
  final String sentiment; // 'positive', 'neutral', 'negative'

  OracleAnswer({required this.text, required this.sentiment});

  factory OracleAnswer.fromJson(Map<String, dynamic> json) {
    return OracleAnswer(
      text: json['text'] ?? '',
      sentiment: json['sentiment'] ?? 'neutral',
    );
  }
}