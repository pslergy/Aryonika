// lib/src/data/models/oracle_theme.dart

import 'package:lovequest/src/data/models/oracle_answer.dart';

class OracleTheme {
  final String id;
  final Map<String, List<String>> keywordsByLang;
  final Map<String, List<OracleAnswer>> answersByLang;

  const OracleTheme({
    required this.id,
    required this.keywordsByLang,
    required this.answersByLang,
  });

  factory OracleTheme.fromJson(Map<String, dynamic> json) {
    // 1. Парсим ключевые слова
    // Сервер присылает camelCase 'keywordsByLang' (благодаря toCamelCase в api-server.js)
    final keywordsRaw = json['keywordsByLang'] as Map<String, dynamic>? ?? {};
    final keywords = keywordsRaw.map((lang, list) {
      return MapEntry(lang, List<String>.from(list as List));
    });

    // 2. Парсим ответы
    final answersRaw = json['answersByLang'] as Map<String, dynamic>? ?? {};
    final answers = answersRaw.map((lang, list) {
      final answerList = (list as List).map((item) => OracleAnswer.fromJson(item)).toList();
      return MapEntry(lang, answerList);
    });

    return OracleTheme(
      id: json['id'],
      keywordsByLang: keywords,
      answersByLang: answers,
    );
  }

// Метод fromMap можно оставить или удалить, если он не используется
// (fromJson теперь главный)
}