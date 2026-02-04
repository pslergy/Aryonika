// lovequest/tool/migrate_chat_ids.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lovequest/services/logger_service.dart';

import '../lib/firebase_options.dart';

// --- ГЛАВНАЯ ФУНКЦИЯ СКРИПТА ---
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );



  final db = FirebaseFirestore.instance;
  final chatsRef = db.collection('chats');

  logger.d('✅ Firebase инициализирован. Начинаю миграцию ID чатов...');

  final snapshot = await chatsRef.get();
  logger.d('Найдено ${snapshot.docs.length} чатов. Начинаю проверку...');

  int migratedCount = 0;

  for (final oldChatDoc in snapshot.docs) {
    final data = oldChatDoc.data();
    final userIds = List<String>.from(data['userIds'] ?? []);
    
    if (userIds.length != 2) {
      logger.d("⚠️ Пропускаю чат ${oldChatDoc.id}, так как в нем не 2 участника.");
      continue;
    }

   // --- НАЧАЛО ИЗМЕНЕНИЯ ---

  // 1. Сохраняем оригинальные ID для лога
  final originalId1 = userIds[0];
  final originalId2 = userIds[1];

  // 2. Генерируем правильный, отсортированный ID
  userIds.sort();
  final correctChatId = userIds.join('_');

  // 3. Выводим подробный лог для КАЖДОГО чата
  logger.d("--- Проверяю чат ---");
  logger.d("  - Участники: $originalId1, $originalId2");
  logger.d("  - Старый ID: ${oldChatDoc.id}");
  logger.d("  - Новый ID (сгенерирован): $correctChatId");
  
  // 4. Сравниваем
  if (oldChatDoc.id != correctChatId) {
    logger.d("  - ❗️ РЕЗУЛЬТАТ: ID отличаются! ЗАПУСКАЮ МИГРАЦИЮ.");
    // ... (твой код миграции)
  } else {
    logger.d("  - ✅ РЕЗУЛЬТАТ: ID совпадают. Миграция не требуется.");
  }
  logger.d("----------------------");
  }}
  // --- КОНЕЦ ИЗМЕНЕНИЯ ---


// --- ВСПОМОГАТЕЛЬНАЯ ФУНКЦИЯ ДЛЯ МИГРАЦИИ ОДНОГО ЧАТА ---
Future<void> migrateChat(
  FirebaseFirestore db,
  DocumentSnapshot oldChatDoc,
  String newChatId,
) async {
  final newChatRef = db.collection('chats').doc(newChatId);

  // Проверяем, не существует ли уже чат с правильным ID
  final newChatExists = (await newChatRef.get()).exists;
  if (newChatExists) {
    logger.d('   ⚠️ Чат с правильным ID $newChatId уже существует. Пропускаю, чтобы не затереть данные.');
    // TODO: Здесь можно добавить логику слияния чатов, если это необходимо
    return;
  }
  
  // 1. Копируем основные данные чата
  // === НАЧАЛО ИСПРАВЛЕНИЯ ===
  
  // 1. Получаем данные и ЯВНО приводим их к нужному типу
  final chatData = oldChatDoc.data() as Map<String, dynamic>?;
  
  // Проверяем, что данные не null, на всякий случай
  if (chatData == null) {
    logger.d('   ❌ Ошибка: данные в старом чате ${oldChatDoc.id} пусты. Пропускаю.');
    return;
  }

  // 2. Копируем основные данные чата
  await newChatRef.set(chatData); // <-- Теперь chatData имеет правильный тип

  // 2. Копируем подколлекцию сообщений
  final oldMessagesRef = oldChatDoc.reference.collection('messages');
  final newMessagesRef = newChatRef.collection('messages');
  final messagesSnapshot = await oldMessagesRef.get();

  if (messagesSnapshot.docs.isNotEmpty) {
    logger.d('   - Найдено ${messagesSnapshot.docs.length} сообщений для копирования...');
    // Используем WriteBatch для эффективности
    final batch = db.batch();
    for (final messageDoc in messagesSnapshot.docs) {
      // Создаем ссылку на новый документ с тем же ID и записываем данные
      final newDocRef = newMessagesRef.doc(messageDoc.id);
      batch.set(newDocRef, messageDoc.data());
    }
    await batch.commit();
    logger.d('   - Сообщения успешно скопированы.');
  }

  // 3. (Опционально) Удаляем старый чат.
  // РАСКОММЕНТИРУЙ ЭТУ СТРОКУ, КОГДА БУДЕШЬ УВЕРЕН, ЧТО ВСЕ РАБОТАЕТ
  // await oldChatDoc.reference.delete();
  // logger.d('   - Старый чат ${oldChatDoc.id} удален.');
}