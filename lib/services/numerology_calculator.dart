import 'package:lovequest/src/data/models/numerology_report.dart';

// ==========================================================
// КЛАСС NumerologyDetail УДАЛЕН ОТСЮДА, ТАК КАК ОН ИМПОРТИРУЕТСЯ
// ИЗ src/data/models/numerology_report.dart
// ==========================================================

class NumerologyCalculator {

  static PersonalNumerologyReport generateFullReport({
    required DateTime birthDateTime,
    required String fullName,
  }) {
    final int lifePathBase = birthDateTime.year + birthDateTime.month + birthDateTime.day;
    final int lifePath = _reduceNumber(lifePathBase);
    final int expressionBase = _calculateRawNameNumber(fullName, isVowel: null);
    final int expression = _reduceNumber(expressionBase);
    final int soulUrgeBase = _calculateRawNameNumber(fullName, isVowel: true);
    final int soulUrge = _reduceNumber(soulUrgeBase);
    final int personalityBase = _calculateRawNameNumber(fullName, isVowel: false);
    final int personality = _reduceNumber(personalityBase);
    final int birthDayBase = birthDateTime.day;
    final int birthDay = _reduceNumber(birthDayBase, keepMasters: false);
    final int maturityBase = lifePath + expression;
    final int maturity = _reduceNumber(maturityBase);
    final now = DateTime.now();
    final int personalYearBase = birthDateTime.month + birthDateTime.day + now.year;
    final int personalYear = _reduceNumber(personalYearBase);
    final int personalMonthBase = personalYear + now.month;
    final int personalMonth = _reduceNumber(personalMonthBase);
    final int personalDayBase = personalMonth + now.day;
    final int personalDay = _reduceNumber(personalDayBase);

    return PersonalNumerologyReport(
      lifePath: NumerologyDetail(number: lifePath, descriptionKey: 'life_path_$lifePath', baseNumber: _reduceToBaseKarmic(lifePathBase)),
      destiny: NumerologyDetail(number: expression, descriptionKey: 'expression_$expression', baseNumber: _reduceToBaseKarmic(expressionBase)),
      soulUrge: NumerologyDetail(number: soulUrge, descriptionKey: 'soul_urge_$soulUrge', baseNumber: _reduceToBaseKarmic(soulUrgeBase)),
      personality: NumerologyDetail(number: personality, descriptionKey: 'personality_$personality', baseNumber: _reduceToBaseKarmic(personalityBase)),
      maturity: NumerologyDetail(number: maturity, descriptionKey: 'maturity_$maturity', baseNumber: _reduceToBaseKarmic(maturityBase)),
      birthday: NumerologyDetail(number: birthDay, descriptionKey: 'birthday_$birthDay', baseNumber: _reduceToBaseKarmic(birthDayBase)),
      personalYear: NumerologyDetail(number: personalYear, descriptionKey: 'personal_year_$personalYear', baseNumber: _reduceToBaseKarmic(personalYearBase)),
      personalMonth: NumerologyDetail(number: personalMonth, descriptionKey: 'personal_month_$personalMonth', baseNumber: _reduceToBaseKarmic(personalMonthBase)),
      personalDay: NumerologyDetail(number: personalDay, descriptionKey: 'personal_day_$personalDay', baseNumber: _reduceToBaseKarmic(personalDayBase)),
    );
  }

  static int _calculateRawNameNumber(String name, {bool? isVowel}) {
    const Map<String, int> letterValues = {
      'a': 1, 'j': 1, 's': 1, 'b': 2, 'k': 2, 't': 2, 'c': 3, 'l': 3, 'u': 3,
      'd': 4, 'm': 4, 'v': 4, 'e': 5, 'n': 5, 'w': 5, 'f': 6, 'o': 6, 'x': 6,
      'g': 7, 'p': 7, 'y': 7, 'h': 8, 'q': 8, 'z': 8, 'i': 9, 'r': 9,
      // Кириллица (примерная транслитерация/нумерология, если нужно)
      'а': 1, 'б': 2, 'в': 6, 'г': 3, 'д': 4, 'е': 5, 'ё': 7, 'ж': 2, 'з': 7,
      'и': 1, 'й': 1, 'к': 2, 'л': 2, 'м': 4, 'н': 5, 'о': 7, 'п': 8, 'р': 2,
      'с': 3, 'т': 4, 'у': 6, 'ф': 8, 'х': 5, 'ц': 3, 'ч': 7, 'ш': 2, 'щ': 9,
      'ъ': 1, 'ы': 1, 'ь': 1, 'э': 6, 'ю': 7, 'я': 2
    };
    const vowels = {'a', 'e', 'i', 'o', 'u', 'y', 'а', 'е', 'ё', 'и', 'о', 'у', 'ы', 'э', 'ю', 'я'};
    int sum = 0;
    for (var char in name.toLowerCase().split('')) {
      if (letterValues.containsKey(char)) {
        if (isVowel == null || (isVowel && vowels.contains(char)) || (!isVowel && !vowels.contains(char))) {
          sum += letterValues[char]!;
        }
      }
    }
    return sum;
  }

  static int _reduceNumber(int num, {bool keepMasters = true}) {
    if (keepMasters && (num == 11 || num == 22)) {
      return num;
    }
    if ([13, 14, 16, 19].contains(num)) {
      return num.toString().split('').map(int.parse).reduce((a, b) => a + b);
    }
    if (num < 10) return num;
    int sum = num.toString().split('').map(int.parse).reduce((a, b) => a + b);
    return _reduceNumber(sum, keepMasters: keepMasters);
  }

  static int _reduceToBaseKarmic(int num) {
    if (num < 10 || [11, 13, 14, 16, 19, 22].contains(num)) {
      return num;
    }
    int sum = num.toString().split('').map(int.parse).reduce((a, b) => a + b);
    return _reduceToBaseKarmic(sum);
  }
}