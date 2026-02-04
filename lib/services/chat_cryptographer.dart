// lib/services/chat_cryptographer.dart
import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart' as crypto;
import 'package:cryptography/cryptography.dart';
import 'package:lovequest/services/logger_service.dart';

class ChatCryptographer {
  final algorithm = AesGcm.with256bits();
  final keyAlgorithm = crypto.sha256;

  // Генерирует ключ из ID чата
  SecretKey _deriveKeyFromChatId(String chatId) {
    final keyBytes = keyAlgorithm.convert(utf8.encode(chatId)).bytes;
    return SecretKey(keyBytes);
  }

  // Шифрует данные. Возвращает строку в формате Base64.
  Future<String?> encrypt(String? plaintext, String chatId) async {
    if (plaintext == null || plaintext.isEmpty) return plaintext;
    try {
      final secretKey = _deriveKeyFromChatId(chatId);
      final secretBox = await algorithm.encrypt(
        utf8.encode(plaintext),
        secretKey: secretKey,
      );
      // Используем стандартную конкатенацию: nonce + ciphertext + mac
      return base64Encode(secretBox.concatenation(nonce: true, mac: true));
    } catch (e) {
      logger.d("❌ Ошибка шифрования: $e");
      return null; // Возвращаем null в случае ошибки
    }
  }

  // Дешифрует данные из строки Base64.
  Future<String?> decrypt(String? base64Ciphertext, String chatId) async {
    if (base64Ciphertext == null || base64Ciphertext.isEmpty) return base64Ciphertext;
    try {
      final secretKey = _deriveKeyFromChatId(chatId);
      final combinedBytes = base64Decode(base64Ciphertext);

      // SecretBox сам разберет байты на nonce, ciphertext и mac
      final secretBox = SecretBox.fromConcatenation(
        combinedBytes,
        nonceLength: algorithm.nonceLength,
        macLength: algorithm.macAlgorithm.macLength,
      );

      final decryptedBytes = await algorithm.decrypt(
        secretBox,
        secretKey: secretKey,
      );
      return utf8.decode(decryptedBytes);
    } catch (e) {
      logger.d("⚠️ Ошибка расшифровки для '$base64Ciphertext': $e.");
      // Если не получилось, возвращаем заглушку.
      // С новыми сообщениями этого происходить не должно.
      return "[Ошибка: не удалось расшифровать]";
    }
  }
}