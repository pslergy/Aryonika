// lib/repositories/horoscope_repository.dart

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enough_convert/enough_convert.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:lovequest/services/logger_service.dart';

// Модель данных
class DailyHoroscope {
  final String common;
  final String love;
  final String business;
  const DailyHoroscope({required this.common, required this.love, required this.business});

  // Методы для сохранения/загрузки из Firestore
  Map<String, String> toJson() => {'common': common, 'love': love, 'business': business};
  factory DailyHoroscope.fromJson(Map<String, dynamic> json) => DailyHoroscope(
    common: json['common'] ?? '',
    love: json['love'] ?? '',
    business: json['business'] ?? '',
  );
}

class HoroscopeRepository {
  final _db = FirebaseFirestore.instance;
  static const List<String> _zodiacKeys = [
    "Aries", "Taurus", "Gemini", "Cancer", "Leo", "Virgo",
    "Libra", "Scorpio", "Sagittarius", "Capricorn", "Aquarius", "Pisces"
  ];

  // Главный публичный метод
  Future<Map<String, DailyHoroscope>> getAllHoroscopes(String languageCode) async {
    final todayString = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final cacheDocRef = _db.collection('horoscopes_cache').doc(todayString);

    // 1. Пытаемся прочитать из кэша в Firestore
    final cacheDoc = await cacheDocRef.get();
    if (cacheDoc.exists && cacheDoc.data() != null) {
      final langCache = cacheDoc.data()![languageCode] as Map<String, dynamic>?;
      if (langCache != null) {
        logger.d("✅ Гороскопы на $todayString для языка '$languageCode' загружены из кэша Firestore.");
        return langCache.map((key, value) => MapEntry(key, DailyHoroscope.fromJson(value)));
      }
    }

    // 2. Если в кэше нет - парсим/запрашиваем заново
    logger.d("Кэш устарел или пуст. Выполняю парсинг/запрос гороскопов...");
    final Map<String, DailyHoroscope> freshHoroscopes;
    if (languageCode == 'ru') {
      freshHoroscopes = await _getRussianHoroscopes();
    } else {
      freshHoroscopes = await _getApiHoroscopes();
    }

    // 3. Сохраняем свежие данные в кэш Firestore на сегодня
    await cacheDocRef.set({
      languageCode: freshHoroscopes.map((key, value) => MapEntry(key, value.toJson()))
    }, SetOptions(merge: true)); // merge: true, чтобы не затереть кэш для других языков

    logger.d("✅ Свежие гороскопы сохранены в кэш Firestore.");
    return freshHoroscopes;
  }

  // Парсер для 1001goroskop.ru
  Future<Map<String, DailyHoroscope>> _getRussianHoroscopes() async {
    final results = <String, DailyHoroscope>{};
    for (final signKey in _zodiacKeys) {
      final url = Uri.parse("https://1001goroskop.ru/?znak=${signKey.toLowerCase()}");
      try {
        final response = await http.get(url, headers: {
          'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36',
        });

        if (response.statusCode == 200) {
          // ========== ФИНАЛЬНОЕ ИСПРАВЛЕНИЕ ЗДЕСЬ ==========
          // 1. Создаем кодек для windows-1251
          const codec = Windows1251Codec();
          // 2. Декодируем байты ответа с помощью этого кодека
          final responseBody = codec.decode(response.bodyBytes);
          // 3. Парсим уже раскодированный HTML
          final document = parse(responseBody);
          // =================================================

          final common = document.querySelector('div[itemprop=description]')?.text.trim() ?? "Не удалось загрузить.";
          final love = document.querySelector('div[itemprop=love]')?.text.trim() ?? "Не удалось загрузить.";
          final business = document.querySelector('div[itemprop=work]')?.text.trim() ?? "Не удалось загрузить.";
          results[signKey] = DailyHoroscope(common: common, love: love, business: business);
        } else {
          results[signKey] = const DailyHoroscope(common: "Ошибка сети", love: "Ошибка", business: "Ошибка");
        }
      } catch (e) {
        logger.d("Ошибка парсинга для $signKey: $e");
        results[signKey] = const DailyHoroscope(common: "Ошибка парсинга", love: "Ошибка", business: "Ошибка");
      }
    }
    return results;
  }

  // Заглушка для API
  Future<Map<String, DailyHoroscope>> _getApiHoroscopes() async {
    logger.d("Загружаю гороскопы через API (английский)...");
    final results = <String, DailyHoroscope>{};
    const apiUrl = 'https://horoscope-app-api.vercel.app/api/v1/get-horoscope/daily';

    for (final signKey in _zodiacKeys) {
      final url = Uri.parse('$apiUrl?sign=${signKey.toLowerCase()}&day=TODAY');
      try {
        final response = await http.get(url);
        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          final text = jsonResponse['data']?['horoscope_data'] as String?;

          if (text != null && text.isNotEmpty) {
            results[signKey] = DailyHoroscope(common: text, love: text, business: text);
          } else {
            throw Exception('API response text is null or empty');
          }
        } else {
          throw Exception('API returned status code ${response.statusCode}');
        }
      } catch (e) {
        logger.d("Ошибка API для знака $signKey: $e");
        results[signKey] = const DailyHoroscope(
            common: "Horoscope couldn't be loaded. Please try again later.",
            love: "",
            business: ""
        );
      }
    }
    return results;
  }
}