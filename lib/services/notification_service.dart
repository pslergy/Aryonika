// lib/services/notification_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lovequest/services/logger_service.dart';

/// OneSignal: ключи только через --dart-define, в коде не хранить!
/// flutter run --dart-define=ONESIGNAL_APP_ID=... --dart-define=ONESIGNAL_REST_API_KEY=...
class NotificationService {
  static final String _appId =
      String.fromEnvironment('ONESIGNAL_APP_ID', defaultValue: '');
  static final String _apiKey =
      String.fromEnvironment('ONESIGNAL_REST_API_KEY', defaultValue: '');

  Future<void> sendNotification({
    required List<String> playerIds,
    required String title,
    required String content,
    Map<String, dynamic>? additionalData,
  }) async {
    if (playerIds.isEmpty) return;

    if (_appId.isEmpty || _apiKey.isEmpty) {
      logger.d(
        "NotificationService: OneSignal keys are not set (dart-define). Notification skipped.",
      );
      return;
    }

    final body = {
      "app_id": _appId,
      "include_player_ids": playerIds,
      "headings": {"en": title},
      "contents": {"en": content},
      "data": additionalData,
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

      logger.d(
        "NotificationService: ${response.statusCode} ${response.body}",
      );
    } catch (e) {
      logger.d("NotificationService ERROR: $e");
    }
  }
}
