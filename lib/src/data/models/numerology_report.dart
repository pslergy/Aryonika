import 'package:equatable/equatable.dart';

// ==========================================================
// 1. МОДЕЛЬ ДЛЯ ОДНОГО ЧИСЛА (Личная нумерология)
// ==========================================================
class NumerologyDetail extends Equatable {
  final int number;
  final String descriptionKey;
  final int baseNumber;

  const NumerologyDetail({
    required this.number,
    required this.descriptionKey,
    required this.baseNumber,
  });


  bool get isMaster => number == 11 || number == 22;
  bool get isKarmic => [13, 14, 16, 19].contains(baseNumber);

  factory NumerologyDetail.empty() {
    return const NumerologyDetail(number: 0, descriptionKey: '', baseNumber: 0);
  }

  factory NumerologyDetail.fromJson(Map<String, dynamic> json) {
    return NumerologyDetail(
      number: json['number'] as int? ?? 0,
      descriptionKey: json['descriptionKey'] as String? ?? '',
      baseNumber: json['baseNumber'] as int? ?? (json['number'] as int? ?? 0),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'number': number,
      'descriptionKey': descriptionKey,
      'baseNumber': baseNumber,
    };
  }

  // Алиас для совместимости с Firestore/API
  Map<String, dynamic> toFirestore() => toMap();

  @override
  List<Object?> get props => [number, descriptionKey, baseNumber];
}

// ==========================================================
// 2. ЛИЧНЫЙ ОТЧЕТ (Весь профиль пользователя)
// ==========================================================
class PersonalNumerologyReport extends Equatable {
  final NumerologyDetail lifePath;
  final NumerologyDetail destiny;    // Expression
  final NumerologyDetail soulUrge;
  final NumerologyDetail personality;
  final NumerologyDetail maturity;
  final NumerologyDetail birthday;
  final NumerologyDetail personalYear;
  final NumerologyDetail personalMonth;
  final NumerologyDetail personalDay;

  const PersonalNumerologyReport({
    required this.lifePath,
    required this.destiny,
    required this.soulUrge,
    required this.personality,
    required this.maturity,
    required this.birthday,
    required this.personalYear,
    required this.personalMonth,
    required this.personalDay,
  });

  factory PersonalNumerologyReport.fromJson(Map<String, dynamic> json) {
    // Вспомогательная функция для создания детали из разных форматов JSON
    NumerologyDetail parseDetail(dynamic data, String keyBase) {
      if (data is Map<String, dynamic>) {
        // Новый формат: { number: 5, descriptionKey: ... }
        return NumerologyDetail.fromJson(data);
      } else if (data is int) {
        // Старый "плоский" формат сервера: { lifePathNumber: 5 }
        return NumerologyDetail(
            number: data,
            descriptionKey: '${keyBase}_$data',
            baseNumber: data // Упрощенно считаем базовым само число
        );
      }
      return NumerologyDetail.empty();
    }

    return PersonalNumerologyReport(
      // Пробуем взять 'lifePath' (объект) ИЛИ 'lifePathNumber' (число)
      lifePath: parseDetail(json['lifePath'] ?? json['lifePathNumber'], 'life_path'),
      destiny: parseDetail(json['destiny'] ?? json['expression'] ?? json['expressionNumber'], 'expression'),
      soulUrge: parseDetail(json['soulUrge'] ?? json['soulUrgeNumber'], 'soul_urge'),
      personality: parseDetail(json['personality'] ?? json['personalityNumber'], 'personality'),
      maturity: parseDetail(json['maturity'] ?? json['maturityNumber'], 'maturity'), // Если есть
      birthday: parseDetail(json['birthday'] ?? json['birthDayNumber'], 'birthday'),

      // Эти поля обычно считаются на клиенте, но если сервер прислал - берем
      personalYear: parseDetail(json['personalYear'], 'personal_year'),
      personalMonth: parseDetail(json['personalMonth'], 'personal_month'),
      personalDay: parseDetail(json['personalDay'], 'personal_day'),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'lifePath': lifePath.toMap(),
      'destiny': destiny.toMap(),
      'soulUrge': soulUrge.toMap(),
      'personality': personality.toMap(),
      'maturity': maturity.toMap(),
      'birthday': birthday.toMap(),
      'personalYear': personalYear.toMap(),
      'personalMonth': personalMonth.toMap(),
      'personalDay': personalDay.toMap(),
    };
  }

  @override
  List<Object?> get props => [lifePath, destiny, soulUrge, personality, maturity, birthday];
}

// ==========================================================
// 3. СРАВНЕНИЕ ДВУХ ЧИСЕЛ (Для отчета совместимости)
// ==========================================================
class NumerologyReport {
  final int overallScore;
  final List<NumerologyComparison> comparisons;
  // Новые поля для чисел (опционально, если хочешь показывать "1 vs 5")
  final Map<String, int>? user1Numbers;
  final Map<String, int>? user2Numbers;

  NumerologyReport({
    required this.overallScore,
    required this.comparisons,
    this.user1Numbers,
    this.user2Numbers,
  });

  factory NumerologyReport.fromJson(Map<String, dynamic> json) {
    var comparisonsList = json['comparisons'] as List;
    List<NumerologyComparison> comparisons = comparisonsList
        .map((i) => NumerologyComparison.fromJson(i))
        .toList();

    return NumerologyReport(
      overallScore: json['overallScore'] ?? 0,
      comparisons: comparisons,
      // Парсим карты чисел
      user1Numbers: json['user1Numbers'] != null ? Map<String, int>.from(json['user1Numbers']) : null,
      user2Numbers: json['user2Numbers'] != null ? Map<String, int>.from(json['user2Numbers']) : null,
    );
  }
}

class NumerologyComparison {
  final String type; // Life Path, Destiny...
  final String text;
  final String harmony;
  final int? value1; // Число первого юзера
  final int? value2; // Число второго

  NumerologyComparison({
    required this.type,
    required this.text,
    required this.harmony,
    this.value1,
    this.value2,
  });

  NumerologyComparison copyWith({
    String? type,
    String? text,
    String? harmony,
    int? value1,
    int? value2,
  }) {
    return NumerologyComparison(
      type: type ?? this.type,
      text: text ?? this.text,
      harmony: harmony ?? this.harmony,
      value1: value1 ?? this.value1,
      value2: value2 ?? this.value2,
    );
  }
  // -------------------------

  factory NumerologyComparison.fromJson(Map<String, dynamic> json) {
    return NumerologyComparison(
      type: json['type'] ?? '',
      text: json['text'] ?? '',
      harmony: json['harmony'] ?? 'medium',
      value1: json['value1'],
      value2: json['value2'],
    );
  }
}