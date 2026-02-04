// lovequest/tool/backfill_location.dart
import 'package:flutter/widgets.dart';
import 'dart:io'; // Для exit()
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lovequest/services/logger_service.dart';
// Импортируем автосгенерированный файл с конфигурацией
import '../lib/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Инициализируем Firebase, используя стандартную конфигурацию твоего проекта
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final db = FirebaseFirestore.instance;
  final usersRef = db.collection('users');

  logger.d('✅ Firebase инициализирован. Начинаю обработку пользователей...');

  // Используем snapshots().first для получения данных один раз.
  // Это может быть надежнее, чем .get() в некоторых окружениях.
  final snapshot = await usersRef.get();
  
  logger.d('Найдено ${snapshot.docs.length} пользователей. Начинаю проверку...');

  var batch = db.batch();
  int updateCounter = 0;
  int batchCounter = 0;

  for (final doc in snapshot.docs) {
    // Явно приводим тип, чтобы избежать ошибок анализатора
    final data = doc.data() as Map<String, dynamic>;
    final oldLocation = data['currentLocation'];
    final newLocationExists = data.containsKey('currentLocation_plus');

    // Обновляем, только если есть старое поле и еще НЕТ нового
    if (oldLocation is GeoPoint && !newLocationExists) {
      logger.d('Нашел пользователя для миграции: ${doc.id}');

      final newLocationMap = {
        'geohash': '', // geoflutterfire_plus добавит его сам при необходимости
        'geopoint': oldLocation,
      };

      // Добавляем новое поле, не трогая старое
      batch.update(doc.reference, {'currentLocation_plus': newLocationMap});
      updateCounter++;
      batchCounter++;
    }

    // Когда пакет наполняется (например, каждые 400 операций), отправляем его
    if (batchCounter >= 400) {
      logger.d('Отправляю пакет из $batchCounter миграций...');
      await batch.commit();
      logger.d('Пакет успешно отправлен.');
      // Создаем новый пустой пакет для следующих операций
      batch = db.batch();
      batchCounter = 0;
    }
  }

  // Отправляем последний пакет, если в нем что-то есть
  if (batchCounter > 0) {
    logger.d('Отправляю финальный пакет из $batchCounter миграций...');
    await batch.commit();
    logger.d('Финальный пакет успешно отправлен.');
  }

  logger.d('🎉 Готово! Всего мигрировано пользователей: $updateCounter.');

  // Завершаем процесс, чтобы flutter run не "висел"
  exit(0);
}