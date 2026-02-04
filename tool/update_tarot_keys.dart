// lovequest/tool/update_tarot_keys.dart
import 'package:flutter/widgets.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lovequest/services/logger_service.dart';
import '../lib/firebase_options.dart';

// --- НАШ СЛОВАРЬ АСТРОЛОГИЧЕСКИХ СООТВЕТСТВИЙ ---
const Map<int, String> tarotAstrologyMap = {
  // Старшие Арканы (Планеты и Знаки)
  0: 'URANUS',       // Шут
  1: 'MERCURY',      // Маг
  2: 'MOON',         // Верховная Жрица
  3: 'VENUS',        // Императрица
  4: 'ARIES',        // Император (Овен)
  5: 'TAURUS',       // Иерофант (Телец)
  6: 'GEMINI',       // Влюбленные (Близнецы)
  7: 'CANCER',       // Колесница (Рак)
  8: 'LEO',          // Сила (Лев)
  9: 'VIRGO',        // Отшельник (Дева)
  10: 'JUPITER',     // Колесо Фортуны
  11: 'LIBRA',       // Справедливость (Весы)
  12: 'NEPTUNE',     // Повешенный
  13: 'SCORPIO',     // Смерть (Скорпион)
  14: 'SAGITTARIUS', // Умеренность (Стрелец)
  15: 'CAPRICORN',   // Дьявол (Козерог)
  16: 'MARS',        // Башня
  17: 'AQUARIUS',    // Звезда (Водолей)
  18: 'PISCES',      // Луна (Рыбы)
  19: 'SUN',         // Солнце
  20: 'PLUTO',       // Суд
  21: 'SATURN',      // Мир

  // TODO: При желании можно добавить соответствия для Младших Арканов
};

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final db = FirebaseFirestore.instance;
  final tarotRef = db.collection('tarot_cards');

  logger.d('✅ Firebase инициализирован. Начинаю обновление Карты Судьбы...');

  final snapshot = await tarotRef.get();
  logger.d('Найдено ${snapshot.docs.length} карт. Начинаю проверку...');

  final batch = db.batch();
  int updateCounter = 0;

  for (final doc in snapshot.docs) {
  // === НАЧАЛО ИСПРАВЛЕНИЯ: УМНЫЙ ПАРСИНГ ID ===
  int? cardId;
  // Пытаемся найти число в ID документа, разделенном подчеркиваниями
  final parts = doc.id.split('_');
  for (final part in parts) {
    final id = int.tryParse(part);
    if (id != null) {
      cardId = id;
      break; // Нашли первое число, выходим
    }
  }

    if (cardId != null && tarotAstrologyMap.containsKey(cardId)) {
      final astrologicalKey = tarotAstrologyMap[cardId];
      logger.d('Обновляю карту ${doc.id} (ID: $cardId) -> astrological_key: $astrologicalKey');
      
      // Добавляем операцию обновления в "пакет"
      batch.update(doc.reference, {'astrological_key': astrologicalKey});
      updateCounter++;
    }
  }

  if (updateCounter > 0) {
    logger.d('Отправляю пакет из $updateCounter обновлений...');
    await batch.commit();
    logger.d('Пакет успешно отправлен.');
  } else {
    logger.d('Не найдено карт для обновления.');
  }

  logger.d('🎉 Готово! Всего обновлено карт: $updateCounter.');
  exit(0);
}