// lib/services/notification_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lovequest/services/logger_service.dart';

class NotificationService {
  final String _appId = "e13b7721-c57d-474e-9885-b680f59013cf";
 

  Future<void> sendNotification({
    required List<String> playerIds, // Список ID получателей
    required String title,
    required String content,
    Map<String, dynamic>? additionalData, // Для открытия нужного экрана
  }) async {
    if (playerIds.isEmpty) return;

    final body = {
      "app_id": _appId,
      "include_player_ids": playerIds,
      "headings": {"en": title}, // OneSignal требует заголовки для разных языков
      "contents": {"en": content},
      "data": additionalData,
      // Параметры для Android
      // ================== НАЧАЛО ИСПРАВЛЕНИЯ ==================
      // "android_channel_id": "YOUR_ANDROID_CHANNEL_ID", // Просто комментируем эту строку
      // =================== КОНЕЦ ИСПРАВЛЕНИЯ ===================// ID канала, настроенного в OneSignal
      "android_visibility": 1,
    };

    try {
      final response = await http.post(
        Uri.parse("https://onesignal.com/api/v1/notifications"),
        headers: {
          "Content-Type": "application/json; charset=utf-8",
          "Authorization": "Basic $_apiKey",
        },
        body: json.encode(body),
      );
      logger.d("--- NotificationService: Ответ от OneSignal: ${response.statusCode} ${response.body} ---");
    } catch (e) {
      logger.d("!!! NotificationService ОШИБКА: $e");
    }
  }
}
