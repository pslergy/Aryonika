// lib/services/localization_service.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lovequest/repositories/api_repository.dart';

import 'logger_service.dart'; // Предполагаем, что _baseUrl там

class LocalizationService {
  // Реализация Singleton
  LocalizationService._privateConstructor();
  static final LocalizationService instance = LocalizationService._privateConstructor();

  Map<String, Map<String, String>> _localizations = {};
  bool _isInitialized = false;

  Future<void> initialize() async {
    if (_isInitialized) return;
    try {
      final url = Uri.parse('${ApiRepository.baseUrl}/localizations');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(utf8.decode(response.bodyBytes));
        _localizations = data.map((key, value) {
          return MapEntry(key, Map<String, String>.from(value));
        });
        _isInitialized = true;
        logger.d('[LocalizationService] ✅ Локализации успешно загружены.');
      }
    } catch (e) {
      logger.d('[LocalizationService] ❌ Ошибка загрузки локализаций: $e');
    }
  }

  String translate(BuildContext context, String key) {
    if (!_isInitialized) return '...'; // Заглушка на время загрузки

    // Определяем язык устройства
    final locale = Localizations.localeOf(context);
    final langCode = locale.languageCode; // 'ru', 'en', 'de', 'fr'

    // Ищем перевод для нужного языка, если нет - используем английский как запасной
    return _localizations[key]?[langCode] ?? _localizations[key]?['en'] ?? key;
  }
}