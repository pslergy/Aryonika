// lib/widgets/common/debug_avatar.dart
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:lovequest/services/logger_service.dart';
import 'package:lovequest/src/data/models/user_profile_card.dart';

class DebugAvatar extends StatelessWidget {
  final UserProfileCard user;

  const DebugAvatar({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    // Получаем строку аватара ИЗ ЕДИНОГО ПОЛЯ, которое мы сделали
    final String avatarString = user.avatar;

    // --- НАЧАЛО ДИАГНОСТИКИ ---
    logger.d("--- DEBUG AVATAR for ${user.name} ---");
    logger.d("   - Длина строки: ${avatarString.length}");

    // Проверяем, это Base64 или что-то другое
    if (avatarString.length < 100) {
      logger.d("   - РЕШЕНИЕ: Строка слишком короткая. Это не Base64. Показываю текст.");
      return Container(
        color: Colors.blueGrey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "НЕ Base64:\n'${avatarString.isEmpty ? "ПУСТО" : avatarString}'",
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 10),
            ),
          ),
        ),
      );
    }

    // Если строка длинная, пытаемся ее декодировать ПРЯМО ЗДЕСЬ
    try {
      String cleaned = avatarString;
      if (cleaned.startsWith('data:image')) {
        cleaned = cleaned.split(',').last;
      }
      cleaned = cleaned.replaceAll(RegExp(r'\s+'), '');

      final Uint8List bytes = base64Decode(cleaned);

      logger.d("   - РЕШЕНИЕ: Успешно декодировано ${bytes.lengthInBytes} байт. Показываю картинку.");
      // Показываем картинку
      return Image.memory(
        bytes,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          logger.d("   - ОШИБКА: Image.memory не смог отрисовать байты! $error");
          return Container(color: Colors.orange, child: const Center(child: Text("Ошибка отрисовки", style: TextStyle(color: Colors.white))));
        },
      );

    } catch (e) {
      logger.d("   - РЕШЕНИЕ: КРАХ ДЕКОДИРОВАНИЯ! Ошибка: $e");
      // Если декодирование упало с ошибкой
      return Container(
        color: Colors.red,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "ОШИБКА ДЕКОДИРОВАНИЯ:\n$e",
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 10),
            ),
          ),
        ),
      );
    }
    // --- КОНЕЦ ДИАГНОСТИКИ ---
  }
}