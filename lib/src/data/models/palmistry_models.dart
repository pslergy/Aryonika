// lib/src/data/models/palmistry_models.dart

class PalmistryData {
  final Map<String, PalmLine> lines;

  PalmistryData({required this.lines});

  factory PalmistryData.fromMap(Map<String, dynamic> map) {
    final linesData = map['lines'] as Map<String, dynamic>? ?? {};
    return PalmistryData(
      lines: linesData.map((key, value) => MapEntry(key, PalmLine.fromMap(value as Map<String, dynamic>))),
    );
  }
}

class PalmLine {
  final String title;
  final String description;
  final Map<String, PalmOption> options;

  PalmLine({
    required this.title,
    required this.description,
    required this.options,
  });

  factory PalmLine.fromMap(Map<String, dynamic> map) {
    final optionsData = map['options'] as Map<String, dynamic>? ?? {};
    return PalmLine(
      title: map['title'] as String? ?? '',
      description: map['description'] as String? ?? '',
      options: optionsData.map((key, value) => MapEntry(key, PalmOption.fromMap(value as Map<String, dynamic>))),
    );
  }
}

class PalmOption {
  final String choiceText;
  final String interpretation;
  final String? strengthTag;
  final String? weaknessTag;

  PalmOption({
    required this.choiceText,
    required this.interpretation,
    this.strengthTag,
    this.weaknessTag,
  });

  factory PalmOption.fromMap(Map<String, dynamic> map) {
    return PalmOption(
      choiceText: map['choice_text'] as String? ?? '',
      interpretation: map['interpretation'] as String? ?? '',
      strengthTag: map['strength_tag'] as String?,
      weaknessTag: map['weakness_tag'] as String?,
    );
  }
}