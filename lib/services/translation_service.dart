// lib/services/translation_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lovequest/services/logger_service.dart'; // Для Locale

class TranslationService {
  static final TranslationService _instance = TranslationService._internal();
  factory TranslationService() => _instance;
  TranslationService._internal();

  final _db = FirebaseFirestore.instance;
  final Map<String, Map<String, dynamic>> _cache = {};

  // Метод загрузки остается почти таким же, но путь теперь другой
  Future<Map<String, dynamic>> getNumerologyTranslations(Locale locale) async {
    final langCode = locale.languageCode;

    if (_cache.containsKey(langCode)) {
      logger.d("НУМЕРОЛОГИЯ (КЭШ): Данные для '$langCode' уже загружены.");
      return _cache[langCode]!;
    }

    logger.d("НУМЕРОЛОГИЯ (СЕТЬ): Запрашиваю документ '/numerology_descriptions/$langCode' из Firestore...");
    try {
      // ПРАВИЛЬНЫЙ ПУТЬ
      final doc = await _db.collection('numerology_descriptions').doc(langCode).get();

      if (doc.exists && doc.data() != null) {
        final data = doc.data()!;
        logger.d("НУМЕРОЛОГИЯ (СЕТЬ): Документ для '$langCode' УСПЕШНО НАЙДЕН.");
        // ========== ОТЛАДКА: ВЫВОДИМ ВЕСЬ ДОКУМЕНТ В КОНСОЛЬ ==========
        logger.d("----------------------------------------------------");
        logger.d("Содержимое документа '$langCode':");
        data.forEach((key, value) {
          logger.d("  Ключ: '$key', Тип значения: ${value.runtimeType}");
        });
        logger.d("----------------------------------------------------");
        // ==========================================================
        _cache[langCode] = data;
        return data;
      } else {
        logger.d("НУМЕРОЛОГИЯ (СЕТЬ): ПРЕДУПРЕЖДЕНИЕ! Документ для '$langCode' НЕ найден.");
        if (langCode != 'en') {
          return await getNumerologyTranslations(const Locale('en'));
        }
        return {};
      }
    } catch (e) {
      logger.d("!!! НУМЕРОЛОГИЯ (СЕТЬ): КРИТИЧЕСКАЯ ОШИБКА загрузки: $e");
      return {};
    }
  }
  Map<String, dynamic> getNumerologyTranslationsSync(Locale locale) {
    final langCode = locale.languageCode;
    return _cache[langCode] ?? _cache['en'] ?? {};
  }


  // Вспомогательный метод для получения конкретного описания
  String getDescription({
    required Map<String, dynamic> translations,
    required String numberTypeKey, // e.g., 'life_path_numbers'
    required int number,
  }) {
    final numberMap = translations[numberTypeKey] as Map<String, dynamic>?;
    return numberMap?[number.toString()] as String? ?? "Описание не найдено.";
  }
}