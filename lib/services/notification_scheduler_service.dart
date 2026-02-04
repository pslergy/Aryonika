// lib/services/notification_scheduler_service.dart

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lovequest/services/logger_service.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationSchedulerService {
  final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  // --- НОВЫЙ МЕТОД ДЛЯ ОТМЕНЫ ---
  Future<void> cancelNotification(int id) async {
    await _notificationsPlugin.cancel(id);
    logger.d('Уведомление (ID: $id) было отменено.');
  }


  Future<NotificationSchedulerService> init() async {
    // ================== НАЧАЛО ИЗМЕНЕНИЯ ==================
    // 1. Получаем Android-специфичный плагин
    final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
    _notificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    // 2. Запрашиваем разрешение на точные будильники (для Android 12+)
    // Этот вызов покажет пользователю системный диалог, если нужно.
    await androidImplementation?.requestExactAlarmsPermission();
    // =================== КОНЕЦ ИЗМЕНЕНИЯ ===================
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _notificationsPlugin.initialize(initializationSettings);
    tz.initializeTimeZones();
    return this;
  }

  // 1. Метод `scheduleDailyNotification` теперь принимает часы и минуты напрямую
  Future<void> scheduleDailyNotification({
    required int id,
    required String title,
    required String body,
    required int hour,   // Вместо `Time` теперь `int hour`
    required int minute, // и `int minute`
    String payload = '',
  }) async {
    await _notificationsPlugin.cancel(id);

    const NotificationDetails notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'daily_forecasts_channel',
        'Daily Forecasts',
        channelDescription: 'Notifications with daily forecasts and tips.',
        importance: Importance.defaultImportance,
        priority: Priority.defaultPriority,
      ),
      iOS: DarwinNotificationDetails(),
    );

    // 2. Используем обновленный `zonedSchedule`
    await _notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      _nextInstanceOfTime(hour, minute), // Передаем часы и минуты
      notificationDetails,
      // `uiLocalNotificationDateInterpretation` больше не нужен,
      // `matchDateTimeComponents` делает все, что нужно
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time, // Повторять каждый день
    );

    logger.d('✅ Уведомление (ID: $id) "$title" запланировано на $hour:$minute');
  }


  Future<void> showNow({
    required int id,
    required String title,
    required String body,
    String payload = '',
  }) async {
    const NotificationDetails notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'alerts_channel',
        'Alerts',
        channelDescription: 'Important alerts like geomagnetic storms.',
        importance: Importance.high,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(presentSound: true),
    );

    await _notificationsPlugin.show(id, title, body, notificationDetails, payload: payload);
    logger.d('🔥 Срочное уведомление (ID: $id) "$title" показано');
  }



  tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,   // Используем int
      minute, // Используем int
    );
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }}