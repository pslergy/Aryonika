// lib/src/data/models/astrology/compatibility_report.dart


import 'package:equatable/equatable.dart';

import '../numerology_report.dart';

class CompatibilityReport extends Equatable {
  final int totalScore;
  final String partnerName;
  final List<CompatibilityDetail> details;

  // Добавляем нумерологию как опциональное поле
  final NumerologyCompatibilityReport? numerologyReport;

  const CompatibilityReport({
    required this.totalScore,
    required this.partnerName,
    required this.details,
    this.numerologyReport, // <-- Добавлено в конструктор
  });

  const CompatibilityReport.empty()
      : totalScore = 0,
        partnerName = '',
        details = const [],
        numerologyReport = null;

  @override
  List<Object?> get props => [totalScore, partnerName, details, numerologyReport];

  // Фабрика для парсинга JSON с сервера
  factory CompatibilityReport.fromJson(Map<String, dynamic> json) {
    // Парсим детали астрологии (если есть)
    var detailsList = <CompatibilityDetail>[];
    if (json['details'] != null) {
      detailsList = (json['details'] as List)
          .map((i) => CompatibilityDetail.fromJson(i))
          .toList();
    } else if (json['western'] != null) {
      // Если сервер возвращает структуру { western: {...}, jyotish: {...} }
      // То можно превратить их в детали здесь
      // Но пока оставим стандартный парсинг списка details
    }

    // Парсим нумерологию
    NumerologyCompatibilityReport? numReport;
    if (json['numerology'] != null) {
      numReport = NumerologyCompatibilityReport.fromJson(json['numerology']);
    }

    return CompatibilityReport(
      totalScore: json['totalScore'] ?? 0,
      partnerName: json['partnerName'] ?? 'Partner',
      details: detailsList,
      numerologyReport: numReport,
    );
  }
}

// Деталь астрологии (Аспект)
class CompatibilityDetail extends Equatable {
  final String key;
  final String titleKey;
  final String description;
  final int score;
  final bool isProFeature;

  const CompatibilityDetail({
    required this.key,
    required this.titleKey,
    required this.description,
    required this.score,
    this.isProFeature = false,
  });

  factory CompatibilityDetail.fromJson(Map<String, dynamic> json) {
    return CompatibilityDetail(
      key: json['key'] ?? 'unknown',
      titleKey: json['titleKey'] ?? 'unknown_aspect',
      description: json['description'] ?? '',
      score: json['score'] ?? 50,
      isProFeature: json['isPro'] ?? false,
    );
  }

  @override
  List<Object?> get props => [key, titleKey, description, score, isProFeature];
}

// Новая модель для отчета Нумерологии
class NumerologyCompatibilityReport extends Equatable {
  final int totalScore;
  final String shortText;

  // Используем ту же модель, что и в NumerologyCompatibilityScreen
  final List<NumerologyComparison> comparisons;

  const NumerologyCompatibilityReport({
    required this.totalScore,
    required this.shortText,
    required this.comparisons,
  });


  factory NumerologyCompatibilityReport.fromJson(Map<String, dynamic> json) {
    var comparisonsList = <NumerologyComparison>[];

    // Если сервер возвращает details как объект { lifePath: {val1:5, val2:7, text:"..."}, ... }
    if (json['details'] != null && json['details'] is Map) {
      final d = json['details'] as Map;

      // Вручную перебираем известные ключи, чтобы создать список сравнений
      if (d['lifePath'] != null) {
        comparisonsList.add(_createComparison('Жизненный Путь', d['lifePath']));
      }
      if (d['destiny'] != null) { // Если сервер это шлет
        comparisonsList.add(_createComparison('Число Судьбы', d['destiny']));
      }
      // ... другие
    }

    return NumerologyCompatibilityReport(
      totalScore: json['score'] ?? 0,
      shortText: json['short_text'] ?? '',
      comparisons: comparisonsList,
    );
  }

  // Вспомогательный метод
  static NumerologyComparison _createComparison(String title, dynamic data) {
    // Если данные пришли как объект { val1, val2, text } - отлично
    // Если просто числа, берем дефолтный текст
    return NumerologyComparison(
      type: title,
      text: data['text'] ?? "Описание отсутствует", // Если сервер не прислал текст в деталях
      harmony: 'medium', // Можно вычислить на основе score, если сервер пришлет
      value1: data['val1'],
      value2: data['val2'],
    );
  }

  @override
  List<Object?> get props => [totalScore, shortText, comparisons];
}

class NumerologyDetail extends Equatable {
  final String title;
  final int score;
  final String description;

  const NumerologyDetail({required this.title, required this.score, required this.description});

  @override
  List<Object?> get props => [title, score, description];
}