// lib/services/notification_helper.dart
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lovequest/services/logger_service.dart';

class NotificationHelper {
  // Синглтон
  static final NotificationHelper _instance = NotificationHelper._internal();
  factory NotificationHelper() => _instance;
  NotificationHelper._internal();

  final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  // Инициализация плагина
  Future<void> initialize() async {
    // Android
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    // iOS
    const DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings();

    // Linux
    const LinuxInitializationSettings initializationSettingsLinux =
    LinuxInitializationSettings(
      defaultActionName: 'Открыть уведомление',
    );

    // Windows
    const WindowsInitializationSettings initializationSettingsWindows =
    WindowsInitializationSettings(
      appName: 'LoveQuest',
      appUserModelId: 'com.lovequest.app',
      guid: 'd7f1b1c0-1234-5678-9abc-def012345678', // любой уникальный GUID
    );

    // Общие настройки
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
      linux: initializationSettingsLinux,
      windows: initializationSettingsWindows,
    );

    await _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        // TODO: логика при нажатии на уведомление
        logger.d('Notification payload: ${response.payload}');
      },
    );
  }

  // Метод показа уведомления
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'lovequest_channel_id',
      'LoveQuest Notifications',
      channelDescription: 'Уведомления о новых сообщениях и лайках',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
    );

    const DarwinNotificationDetails iosPlatformChannelSpecifics =
    DarwinNotificationDetails();

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iosPlatformChannelSpecifics,
    );

    await _notificationsPlugin.show(
      id,
      title,
      body,
      platformChannelSpecifics,
      payload: payload,
    );
  }
}
