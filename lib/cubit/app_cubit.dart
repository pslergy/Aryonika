// lib/cubit/app_cubit.dart
import 'dart:async';
import 'dart:ui';
import 'package:app_links/app_links.dart';
import 'package:bloc/bloc.dart'; // Обратите внимание, НЕ flutter_bloc
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/services/predictive_back_event.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:language_detector/language_detector.dart';
import 'package:location/location.dart';
import 'package:lovequest/cubit/app_state.dart';

import 'package:lovequest/repositories/api_repository.dart';

import 'package:lovequest/services/notification_scheduler_service.dart';
import 'package:lovequest/services/notification_service.dart';
import 'package:lovequest/services/websocket_service.dart';
import 'package:lovequest/src/data/models/enums.dart';
import 'package:lovequest/src/data/models/feed_event.dart';
import 'package:lovequest/src/data/models/post.dart';
import 'package:lovequest/src/data/models/user_profile_card.dart';
import 'dart:math'; // Для Random

import 'package:lovequest/src/data/models/tarot_card.dart';
import 'package:lovequest/src/data/models/user_settings.dart';
import 'package:lovequest/utils/extensions.dart';
import 'package:lovequest/widgets/search/cosmic_web/cosmic_web_user_node.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lovequest/src/data/models/numerology_report.dart';

import 'package:lovequest/l10n/generated/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

import '../repositories/firestore_repository.dart';
import '../screens/hybrid_forecast_calculator.dart';
import '../screens/oracle_screen.dart';
import '../services/logger_service.dart';
import '../src/data/models/chat_list_item.dart';

import '../utils/ui_helpers.dart';

import "package:uuid/uuid.dart";
import 'dart:io' show Platform;

import '../repositories/auth_repository.dart';
import '../repositories/horoscope_repository.dart';

import 'package:lovequest/src/data/models/channel.dart';

import 'package:lovequest/src/data/models/comment.dart';
import 'dart:convert';

import '../repositories/onboarding_repository.dart';
import '../services/cloudinary_service.dart';
import '../services/compatibility_calculator.dart';
import '../services/geomagnetic_service.dart';
import '../services/natal_chart_calculator.dart';
import '../src/data/models/astrology/compatibility_report.dart';
import '../src/data/models/astrology/natal_chart.dart'; // Наш новый сервис
import 'package:lovequest/services/numerology_calculator.dart';

import '../src/data/models/cosmic_event.dart';
import '../src/data/models/daily_hybrid_forecast.dart';
import '../src/data/models/focus_of_the_day.dart';
import '../src/data/models/geomagnetic_forecast.dart';
import '../src/data/models/message.dart' as chat_models;
import '../src/data/models/nominatim_suggestion.dart';
import '../src/data/models/oracle_theme.dart';
import '../utils/astro_utils.dart';
import '../utils/value_wrapper.dart';
import 'package:flutter/widgets.dart';

import 'channel_state.dart';

class AppCubit extends Cubit<AppState> with WidgetsBindingObserver {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final CloudinaryService _cloudinaryService = CloudinaryService();
  final NotificationService _notificationService = NotificationService();
  final NotificationSchedulerService? _scheduler;
  final ApiRepository _apiRepository = ApiRepository();

  final AuthRepository _authRepository;

  final HoroscopeRepository _horoscopeRepository = HoroscopeRepository();
  final GeomagneticService _geomagneticService = GeomagneticService();
  final OnboardingRepository _onboardingRepository = OnboardingRepository();
  final NatalChartCalculator _chartCalculator; // Создаем экземпляр

  late final AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;
  GoRouter? _router;
  Locale currentLocale = const Locale('ru');

  Timer? _locationUpdateTimer;

  // ========== ИСПРАВЛЕНИЕ ЗДЕСЬ ==========
  // Инициализируем калькулятор прямо при объявлении поля.
  // `late` здесь не нужно, так как это `final` поле.

  // =====================================

  Timer? _searchDebounce; // <-- ДОБАВЬ ЭТУ СТРОКУ

  StreamSubscription? _chatsSubscription;
  StreamSubscription? _authStateSubscription;
  StreamSubscription? _channelsSubscription;
  StreamSubscription? _postsSubscription;
  StreamSubscription? _commentsSubscription;
  StreamSubscription? _notificationsSubscription;
  StreamSubscription? _activeChannelSubscription;
  StreamSubscription? _activeChannelPostsSubscription;
  StreamSubscription? _messagesWebSocketSubscription;

  StreamSubscription? _messagesSubscription;
  Timer? _geomagneticTimer;

  // ================== ИСПРАВЛЕННЫЙ ПРИВАТНЫЙ КОНСТРУКТОР ==================
  AppCubit._({
    required AuthRepository authRepository,
    required NatalChartCalculator chartCalculator,
    required NotificationSchedulerService? scheduler,
  })  : // Используем обычное присваивание
        _authRepository = authRepository,
        _chartCalculator = chartCalculator,
        _scheduler = scheduler,
        super(const AppState(isReady: false, transitInterpretations: {})) {
    // Конструктор остается пустым, вся логика в _initializeInternalLogic()
  }

  Future<void> loadCosmicEvents() async {
    // Не запускаем загрузку, если она уже идет
    if (state.cosmicEventsStatus == LoadingState.loading) return;

    emit(state.copyWith(cosmicEventsStatus: LoadingState.loading));

    try {
      final lang = state.locale?.languageCode ?? 'ru';
      // Вызываем наш новый метод из ApiRepository!
      final events = await _apiRepository.getCosmicEvents(lang: lang);

      emit(state.copyWith(
          cosmicEvents: events, cosmicEventsStatus: LoadingState.success));
    } catch (e) {
      logger.d("❌ Ошибка загрузки космических событий: $e");
      emit(state.copyWith(cosmicEventsStatus: LoadingState.error));
    }
  }

  Future<void> loadMoonRhythm() async {
    if (state.moonRhythmStatus == LoadingState.loading) return;
    emit(state.copyWith(moonRhythmStatus: LoadingState.loading));
    try {
      final lang = state.locale?.languageCode ?? 'ru';
      final rhythm = await _apiRepository.getMoonRhythm(lang: lang);
      emit(state.copyWith(
          moonRhythm: rhythm, moonRhythmStatus: LoadingState.success));
    } catch (e) {
      logger.d("❌ Ошибка загрузки Ритмов Луны: $e");
      emit(state.copyWith(moonRhythmStatus: LoadingState.error));
    }
  }
// =======================================================================

  // ================== ИЗМЕНЕНИЕ 2: СТАТИЧЕСКИЙ МЕТОД-ФАБРИКА СТАНОВИТСЯ ГЛАВНЫМ ==================
  static Future<AppCubit> create({
    // Убираем firestoreRepository
    required AuthRepository authRepository,
    required NatalChartCalculator chartCalculator,
    required FirestoreRepository
        firestoreRepository, // Временно оставляем для совместимости
  }) async {
    // ... (логика с NotificationSchedulerService остается)
    NotificationSchedulerService? scheduler;
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      scheduler = await NotificationSchedulerService().init();
    }

    final cubit = AppCubit._(
      //firestoreRepository больше не нужен здесь, но если другие части кубита
      //все еще его используют, нужно будет передать
      // Временно оставляем
      authRepository: authRepository,
      chartCalculator: chartCalculator,
      scheduler: scheduler,
    );

    cubit._initializeInternalLogic();
    return cubit;
  }

  void setLocale(Locale locale) {
    if (currentLocale == locale)
      return; // Не делаем ничего, если язык не изменился

    currentLocale = locale;
    logger.d(
        "CUBIT: Язык изменен на ${locale.languageCode}. Перезагружаю все описания...");

    // Вызываем наш новый централизованный метод
    _loadAllLocalizedData(forceReload: true);
  }

  // НОВЫЙ приватный метод для загрузки ВСЕХ данных, зависящих от языка
  Future<void> _loadAllLocalizedData({bool forceReload = false}) async {
    logger.d("--- CUBIT: НАЧИНАЮ ЗАГРУЗКУ ВСЕХ ЛОКАЛИЗОВАННЫХ ДАННЫХ ---");
    // Собираем все асинхронные задачи в один список
    final tasks = [
      _loadCompatibilityDescriptions(forceReload: forceReload),
      loadNumerologyCompatibility(forceReload: forceReload),
      _loadAstroDescriptions(forceReload: forceReload),
      loadNumerologyNumberDescriptions(forceReload: forceReload),
      _loadJyotishDescriptions(forceReload: forceReload),
      loadAspectInterpretations(forceReload: forceReload),
      // Добавь сюда другие подобные загрузчики, если они появятся
    ];
    // Выполняем их параллельно
    await Future.wait(tasks);
    logger.d("CUBIT: ✅ Все локализованные данные перезагружены.");
  }

  void _initializeInternalLogic() {
    // Весь код, который раньше был в конструкторе, теперь здесь.
    // Этот метод вызывается, когда все зависимости уже на месте.
    _chartCalculator.initialize();

    _listenToWebsocket();

    _startLocationUpdater();
    _startGeomagneticTimer();
    _initDeepLinks();
    _init();
    _initNotificationHandler();
    WidgetsBinding.instance.addObserver(this);
  }

  // === НОВЫЙ МЕТОД-СЕТТЕР для GoRouter ===
  /// "Знакомит" AppCubit с экземпляром GoRouter.
  /// Должен быть вызван из UI один раз при старте приложения.
  void setRouter(GoRouter router) {
    _router = router;
  }

  void _listenToWebsocket() {
    WebSocketService.instance.events.listen((event) {
      logger.d("[CUBIT-WS] Получено событие: '${event.type}'");
      switch (event.type) {
        case 'profile_updated':
          forceRefreshUserProfile();
          break;

        // Этот блок можно пока оставить, он не вызывает проблем
        case 'partner_typing_status':
          if (event.payload is Map) {
            final chatId = event.payload['chatId'] as String?;
            final isTyping = event.payload['isTyping'] as bool?;
            if (chatId != null && isTyping != null) {
              final newStatuses = Map<String, bool>.from(state.typingStatuses);
              newStatuses[chatId] = isTyping;
              emit(state.copyWith(typingStatuses: newStatuses));
            }
          }
          break;

        // --- 👇 ГЛАВНОЕ ИЗМЕНЕНИЕ ЗДЕСЬ 👇 ---
        case 'chat_preview_updated':
          if (event.payload is Map<String, dynamic>) {
            // 1. Получаем ID чата из события
            final updatedChatId = event.payload['chatId'] as String?;
            if (updatedChatId == null) break; // Если нет ID, выходим

            // 2. Сравниваем его с ID активного чата из ChatCubit
            //    Для этого нам нужно получить доступ к ChatCubit. Это сложно.
            //    Проще сделать по-другому: AppCubit должен знать, какой чат открыт.
            //    Давай добавим поле `activeChatId` в AppState.

            // --- ВРЕМЕННОЕ РЕШЕНИЕ (простое) ---
            // Мы не будем обновлять список, если пришло событие для текущего открытого чата.
            // Это не идеально, но должно разорвать цикл.
            // **НО ЛУЧШЕ СДЕЛАТЬ ПРАВИЛЬНО.**

            // --- ПРАВИЛЬНОЕ РЕШЕНИЕ ---
            // AppCubit не должен слушать `chat_preview_updated`. Этим должен заниматься
            // виджет списка чатов. Но давай пока сделаем "костыль", чтобы быстро починить.

            // Если у нас открыт какой-то чат, AppCubit просто не будет обновлять список.
            // Это не идеально, но цикл разорвет.
            final activeChatId =
                state.activeChatId; // Предположим, это поле есть в AppState
            if (activeChatId != null && activeChatId == updatedChatId) {
              logger.d(
                  "[CUBIT-WS] Игнорирую 'chat_preview_updated' для активного чата $activeChatId");
              break; // ВЫХОДИМ!
            }

            // Если мы здесь, значит, чат не открыт, и можно безопасно обновить список.
            try {
              final newChatItem = ChatListItem.fromJson(event.payload);
              final currentList = List<ChatListItem>.from(state.chatListItems);
              final index = currentList
                  .indexWhere((item) => item.chatId == newChatItem.chatId);
              if (index != -1) {
                currentList[index] = newChatItem;
              } else {
                currentList.insert(0, newChatItem);
              }
              currentList.sort((a, b) =>
                  b.lastMessageTimestamp.compareTo(a.lastMessageTimestamp));
              emit(state.copyWith(chatListItems: currentList));
              logger.d(
                  "[CUBIT-WS] ✅ Список чатов обновлен для чата ${newChatItem.chatId}");
            } catch (e) {
              logger.d("❌ [CUBIT-WS] Ошибка парсинга chat_preview_updated: $e");
            }
          }
          break;
      }
    });
  }

  Future<void> updateBirthData(Map<String, dynamic> data) async {
    try {
      logger
          .d("--- AppCubit: Обновляю данные рождения через API. Данные: $data");
      if (data.containsKey('natalChart')) {
        logger.d("--- AppCubit: В данных ЕСТЬ natalChart!");
      } else {
        logger.d("--- AppCubit: В данных НЕТ natalChart!");
      }
      // Вызываем специальный метод репозитория
      final updatedProfile = await _apiRepository.updateUserBirthData(data);

      // Обновляем состояние AppState с полным профилем, который вернул сервер
      emit(state.copyWith(currentUserProfile: updatedProfile));
      logger.d(
          "Профиль (данные рождения) успешно обновлен, AppState синхронизирован.");
    } catch (e) {
      logger.d("!!! Ошибка обновления данных рождения в AppCubit: $e");
      rethrow; // Пробрасываем ошибку, чтобы EditProfileCubit мог ее поймать
    }
  }

  // Добавляем новый приватный метод для запуска таймера
  void _startLocationUpdater() {
    _locationUpdateTimer?.cancel(); // Отменяем старый, если есть
    // Запускаем таймер, который будет срабатывать каждые 15 минут
    _locationUpdateTimer = Timer.periodic(const Duration(minutes: 15), (timer) {
      final user = state.currentUserProfile;
      // Обновляем локацию, только если пользователь в приложении и профиль загружен
      if (user != null) {
        logger.d("⏰ Таймер геолокации сработал. Обновляю местоположение...");
        updateAndGetCurrentUserLocation(); // Просто вызываем наш существующий метод
      }
    });
  }

  void _updateChatListOnMessage(chat_models.Message msg) {
    final currentList = List<ChatListItem>.from(state.chatListItems);
    final index = currentList.indexWhere((c) => c.chatId == msg.chatId);

    if (index != -1) {
      final oldItem = currentList[index];
      // Если я отправитель - unread 0, иначе +1
      final isMe = msg.senderId == state.currentUserProfile?.id;

      // ВАЖНО: Проверяем, открыт ли сейчас этот чат.
      // Но AppCubit этого не знает напрямую.
      // Поэтому просто увеличиваем счетчик, если это не я отправил.
      // А ChatCubit сам сбросит его в 0, когда откроется.

      final newItem = oldItem.copyWith(
        lastMessage: msg.text,
        lastMessageTimestamp: msg.createdAt,
        lastMessageSenderId: msg.senderId,
        unreadCount: isMe ? 0 : oldItem.unreadCount + 1,
      );

      currentList.removeAt(index);
      currentList.insert(0, newItem);
      emit(state.copyWith(chatListItems: currentList));
    } else {
      // Новый чат - грузим с сервера
      loadInitialChatList();
    }
  }

  void updateChatListOptimistically(String chatId, String text, DateTime time) {
    final currentList = List<ChatListItem>.from(state.chatListItems);
    final index = currentList.indexWhere((c) => c.chatId == chatId);

    if (index != -1) {
      final oldItem = currentList[index];
      final newItem = oldItem.copyWith(
        lastMessage: text,
        lastMessageTimestamp: time,
        lastMessageSenderId: state.currentUserProfile?.id,
        unreadCount: 0, // Я отправил
      );
      currentList.removeAt(index);
      currentList.insert(0, newItem);
      emit(state.copyWith(chatListItems: currentList));
    }
  }

  // === НОВЫЙ МЕТОД для всей логики, связанной с уведомлениями ===
  void _initNotificationHandler() {
    // 1. Обработчик кликов по уведомлениям
    OneSignal.Notifications.addClickListener((event) {
      logger.d("--- OneSignal: Уведомление было нажато ---");
      logger.d("   - Данные: ${event.notification.additionalData}");

      if (_router == null) {
        logger.d(
            "!!! OneSignal: Роутер еще не установлен, навигация невозможна.");
        return;
      }

      final data = event.notification.additionalData;
      if (data == null) return;

      final type = data['type'] as String?;
      switch (type) {
        case 'new_message':
          final chatId = data['chatId'] as String?;
          // Используем push, чтобы добавить экран чата поверх текущего стека
          if (chatId != null) _router!.push('/chat/$chatId');
          break;
        case 'new_like':
        case 'new_match':
          // Здесь тоже используем push для открытия экрана "симпатий"
          _router!.push('/profile/likes-you');
          break;
        case 'daily_forecast':
          // Для общих экранов, на которые можно попасть из главного меню, go() подходит.
          // Но если ты хочешь, чтобы "назад" возвращало на главный экран,
          // то лучше тоже использовать push. Давай заменим и его для единообразия.
          _router!.push('/forecast');
          break;
        // Добавьте другие типы уведомлений
      }
    });

    // 2. Логика сохранения/обновления Player ID (когда пользователь залогинен)
    // Мы будем вызывать этот метод отдельно, когда профиль будет готов.
  }

  // Переименуем и оставим ваш метод для Player ID
  void updateOneSignalPlayerId() {
    final osPlayerId = OneSignal.User.pushSubscription.id;
    final savedPlayerId = state.currentUserProfile?.oneSignalPlayerId;
    final userId = state.currentUserProfile?.id;

    if (userId != null && osPlayerId != null && osPlayerId != savedPlayerId) {
      logger.d(
          "--- OneSignal: Обнаружен новый Player ID ($osPlayerId). Сохраняю в Firestore. ---");
      updateUserProfile({'oneSignalPlayerId': osPlayerId});
    }
  }

  // lib/cubit/app_cubit.dart

  Future<void> finalizeOnboardingAndSaveProfile({
    required String name,
    required String bio,
    required String gender,
    required int
        birthDateMillis, // Дата из календаря (00:00 локального времени)
    required int hour,
    required int minute,
    required NominatimSuggestion location,
  }) async {
    final userId = state.currentUserProfile?.id;
    if (userId == null) {
      emit(state.copyWith(
          profileLoadingState: LoadingState.error,
          authErrorMessage: "Ошибка: ID пользователя не найден."));
      return;
    }

    emit(state.copyWith(profileLoadingState: LoadingState.loading));

    try {
      logger.d("[Onboarding] Шаг 1: Начинаю расчет времени и карт...");

      final lat = double.parse(location.latitude);
      final lng = double.parse(location.longitude);

      // 1. Формируем "локальное" время рождения (то, что ввел пользователь на часах)
      final rawDate = DateTime.fromMillisecondsSinceEpoch(birthDateMillis);
      final localBirthDateTime =
          DateTime(rawDate.year, rawDate.month, rawDate.day, hour, minute);

      // 2. Определяем правильный UTC timestamp
      int finalUtcMillis;
      try {
        // Запрашиваем у сервера смещение часового пояса
        final timezoneInfo = await _apiRepository.getTimezoneInfo(
            lat: lat,
            lng: lng,
            timestamp:
                localBirthDateTime.millisecondsSinceEpoch ~/ 1000 // секунды
            );

        // gmtOffset - смещение в секундах (например, +10800 для Москвы +3)
        final int offsetSeconds = timezoneInfo['gmtOffset'] ?? 0;

        // Чтобы получить момент рождения в UTC:
        // Считаем localBirthDateTime как будто это UTC, и вычитаем смещение.
        final tempUtc = DateTime.utc(
            rawDate.year, rawDate.month, rawDate.day, hour, minute);
        final realUtcTime = tempUtc.subtract(Duration(seconds: offsetSeconds));

        finalUtcMillis = realUtcTime.millisecondsSinceEpoch;
        logger.d(
            "[Onboarding] Таймзона учтена. Локально: $hour:$minute, Offset: $offsetSeconds, UTC Millis: $finalUtcMillis");
      } catch (e) {
        // Если API таймзоны недоступно, используем время как есть (fallback)
        logger.d(
            "⚠️ Не удалось получить таймзону, используем локальное время устройства: $e");
        finalUtcMillis = localBirthDateTime.millisecondsSinceEpoch;
      }

      // 3. Расчет натальной карты (по UTC времени)
      final natalChart =
          await _chartCalculator.calculateAll(finalUtcMillis, lat, lng);
      if (natalChart == null)
        throw Exception("Не удалось рассчитать натальную карту");

      // 4. Расчет нумерологии (используем локальное время для даты рождения, это важно для нумерологии)
      final numerologyData = NumerologyCalculator.generateFullReport(
          birthDateTime: localBirthDateTime, fullName: name);

      // Генерация ключевых слов
      final hashtags = _extractHashtags(bio);
      final keywords = _generateKeywords(bio);
      final nameKeywords =
          name.toLowerCase().split(' ').where((s) => s.isNotEmpty).toList();
      final searchKeywords = [...nameKeywords, ...keywords].toSet().toList();

      final referralCode = 'LQ-${userId.substring(0, 6).toUpperCase()}';
      final String? country = location.address?.country;
      final userCountryName = (country != null) ? country.toLowerCase() : '';
      final trialDurationDays = (userCountryName.contains('россия') ||
              userCountryName.contains('russia'))
          ? 3
          : 7;
      final trialEndDate =
          DateTime.now().add(Duration(days: trialDurationDays));

      // --- Сборка данных ---
      final Map<String, dynamic> onboardingData = {
        'name': name,
        'surname': '',
        'nameLowercase': name.toLowerCase(),
        'bio': bio,
        'gender': gender,
        'seekingGender': gender == 'male' ? 'female' : 'male',
        'role': 'user',
        'avatarUrl': null,
        'avatarBase64': null,

        // ВАЖНО: Сохраняем рассчитанный UTC timestamp
        'birthDateMillis': finalUtcMillis,
        // Сохраняем строковое время, как ввел юзер, для отображения
        'birthTime':
            "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}",

        'birthLocation': {'latitude': lat, 'longitude': lng},
        'birthCity': location.address?.city ?? location.displayName,
        'birthCountry': location.address?.country ?? '',
        'country': location.address?.country ?? '',
        'city': location.address?.city ?? location.displayName,
        'currentLocation': {'latitude': lat, 'longitude': lng},
        'sunSign': natalChart.sunSign,
        'natalChart': natalChart.toFirestore(),
        'numerologyData': numerologyData.toFirestore(),
        'likedUsers': [],
        'likedByUsers': [],
        'hiddenLikes': [],
        'friends': [],
        'friendRequestsSent': [],
        'friendRequestsReceived': [],
        'stardust': 0,
        'giftsInventory': {},
        'isBanned': false,
        'groupIds': [],
        'subscribedChannelIds': [],
        'bioKeywords': keywords,
        'bioHashtags': hashtags,
        'referralCode': referralCode,
        'hasUsedReferralCode': false,
        'isPro': false,
        'hasUsedTrial': true,
        'trialEndsAt': trialEndDate.toIso8601String(),
        'premiumEndsAt': null,
        'photoCount': 0,
        'searchKeywords': searchKeywords,
      };

      // Отправка
      logger.d("[Onboarding] Шаг 2: Отправляю данные на сервер...");
      final updatedProfile =
          await _apiRepository.completeOnboarding(onboardingData);

      // Обновление стейта
      emit(state.copyWith(
        currentUserProfile: updatedProfile,
        isOnboardingComplete: true,
        profileStatus: ProfileValidationStatus.valid,
        profileLoadingState: LoadingState.success,
      ));

      // Инициализация после онбординга
      WebSocketService.instance.connect();
      await _loadAllLocalizedData(forceReload: true);
      _runBackgroundTasks();
    } catch (e) {
      logger.d("❌ Ошибка при финализации онбординга: $e");
      emit(state.copyWith(
        profileLoadingState: LoadingState.error,
      ));
      rethrow;
    }
  }

  Future<void> purchaseAndActivatePro() async {
    // ... (здесь будет логика показа экрана оплаты, например, Paywall)

    // После успешной "оплаты" (в нашем случае, просто по нажатию кнопки)
    try {
      emit(state.copyWith(isProLoading: true)); // Показываем индикатор
      await _apiRepository.activateProStatus();

      // ВАЖНО: Нам НЕ НУЖНО делать emit нового состояния здесь вручную.
      // Наш `_listenToUserProfile` в AppCubit, который слушает Firestore,
      // АВТОМАТИЧЕСКИ получит обновление поля `isPro` и `premiumEndsAt`
      // (которое сделал наш сервер) и сам перерисует UI.
    } catch (e) {
      // Обработка ошибки
    } finally {
      emit(state.copyWith(isProLoading: false));
    }
  }

  void initNotificationObserver() {
    // Получаем Player ID от OneSignal
    final String? osPlayerId = OneSignal.User.pushSubscription.id;

    // Получаем текущий ID, сохраненный в Firestore
    final String? savedPlayerId = state.currentUserProfile?.oneSignalPlayerId;
    final String? userId = state.currentUserProfile?.id;

    if (userId != null && osPlayerId != null && osPlayerId != savedPlayerId) {
      logger.d(
          "--- OneSignal: Обнаружен новый Player ID ($osPlayerId). Сохраняю в Firestore. ---");
      // Если ID изменился или его не было, сохраняем новый
      updateUserProfile({'oneSignalPlayerId': osPlayerId});
    }
  }

  Future<String?> resetPassword(
      {required String token, required String newPassword}) async {
    if (newPassword.length < 6) {
      return "Пароль должен быть не менее 6 символов.";
    }
    emit(state.copyWith(authStatus: AuthStatus.submitting));
    try {
      await _apiRepository.resetPassword(
          token: token, newPassword: newPassword);
      emit(state.copyWith(authStatus: AuthStatus.initial));
      return null; // Успех
    } on Exception catch (e) {
      emit(state.copyWith(authStatus: AuthStatus.initial));
      return e.toString().replaceFirst('Exception: ', '');
    }
  }

  Future<String?> forgotPassword(String email) async {
    logger.d("--- DEBUG FLUTTER: 2. AppCubit.forgotPassword ВЫЗВАН ---");
    // Устанавливаем статус "submitting", чтобы кнопка в UI показала индикатор
    emit(state.copyWith(authStatus: AuthStatus.submitting));
    try {
      // Вызываем соответствующий метод из нашего ApiRepository
      await _apiRepository.forgotPassword(email);

      // Сбрасываем статус обратно в initial
      emit(state.copyWith(authStatus: AuthStatus.initial));
      return null; // Успех
    } on Exception catch (e) {
      // В случае ошибки (например, нет сети)
      emit(state.copyWith(authStatus: AuthStatus.initial));
      return e
          .toString()
          .replaceFirst('Exception: ', ''); // Возвращаем текст ошибки
    }
  }

  // === НОВЫЙ МЕТОД ДЛЯ ОБНОВЛЕНИЯ АВАТАРА ===
  Future<void> updateProfileAvatar() async {
    if (state.currentUserProfile == null) return;

    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    emit(state.copyWith(profileLoadingState: LoadingState.loading));

    try {
      // 1. Загружаем в облако
      final imageUrl = await _cloudinaryService.uploadImage(imageFile: image);
      if (imageUrl == null) throw Exception("Upload failed");

      // 2. Сохраняем в "Историю фото" (user_photos)
      // Это вернет нам объект фото, но нам важен сам факт сохранения
      await _apiRepository.addUserPhoto(imageUrl);

      // 3. Делаем это фото главным (аватаром)
      await updateUserProfile({'avatarUrl': imageUrl});

      // 4. Оптимистичное обновление UI (сразу показываем новый аватар)
      final updatedProfile =
          state.currentUserProfile!.copyWith(avatar: imageUrl);
      emit(state.copyWith(
        currentUserProfile: updatedProfile,
        profileLoadingState: LoadingState.success,
      ));

      // 5. Обновляем список фото в стейте (чтобы в альбоме оно тоже появилось)
      await loadUserPhotos(updatedProfile.id);
    } catch (e) {
      logger.d("Ошибка смены аватара: $e");
      emit(state.copyWith(profileLoadingState: LoadingState.error));
    }
  }

  // ===== ПОЛНОСТЬЮ ЗАМЕНИ shareReferralLink =====
  Future<void> shareReferralLink(BuildContext context) async {
    final userId = state.currentUserProfile?.id;
    final referralCode = state.currentUserProfile?.referralCode ?? "ARYONIKA";

    if (userId == null) return;

    try {
      // 1. Ссылка (Замени на свой реальный домен, если есть)
      final String link = "https://psylergy.com/refer?id=$userId";

      // 2. Текст сообщения
      final String message = "Открой тайны своей судьбы в Aryonika! \n"
          "Мой код приглашения: $referralCode\n"
          "Скачать: $link";

      // 3. Системный диалог (Используем пакет share_plus)
      // box нужен для iPad, на телефонах работает и без него, но лучше оставить для надежности
      final box = context.findRenderObject() as RenderBox?;

      await Share.share(
        message,
        subject: 'Приглашение в Aryonika',
        sharePositionOrigin:
            box != null ? box.localToGlobal(Offset.zero) & box.size : null,
      );
    } catch (e) {
      logger.d("Ошибка шаринга: $e");
    }
  }

  // ===== ПОЛНОСТЬЮ ЗАМЕНИ _initDynamicLinks и _handleReferralLink =====
  Future<void> _initDeepLinks() async {
    if (kIsWeb ||
        defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS) {
      try {
        _appLinks = AppLinks(); // Инициализация

        // 1. Слушаем поток ссылок
        _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
          if (uri != null) {
            _handleReferralLink(uri);
          }
        }, onError: (err) {
          logger.d('uriLinkStream error: $err');
        });

        // 2. Проверяем ссылку при первом запуске
        final initialUri = await _appLinks.getInitialLink();
        if (initialUri != null) {
          _handleReferralLink(initialUri);
        }
      } on PlatformException catch (e) {
        logger.d('Failed to get initial link: $e');
      }
    } else {
      logger.d(
          "Deep linking (app_links) is not supported on this platform (Windows/Linux).");
    }
  }

  // === ДОБАВЬ ЭТОТ НОВЫЙ МЕТОД ===

  // === ДОБАВЬ ЭТОТ НОВЫЙ МЕТОД ===
  Future<void> markIntroAsSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('intro_seen', true);
    emit(state.copyWith(introSeen: true));
  }

  void _handleReferralLink(Uri deepLink) async {
    // Проверяем, что это наша реферальная ссылка
    if (deepLink.host == 'your-app-domain.com' && deepLink.path == '/refer') {
      final referrerId = deepLink.queryParameters['referrerId'];
      if (referrerId != null) {
        logger.d(
            "✅ Приложение запущено по DEEP LINK! ID пригласившего: $referrerId");
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('referrer_id', referrerId);
      }
    }
  }

  // === НОВЫЙ МЕТОД ДЛЯ УПРАВЛЕНИЯ ЗАГРУЗКОЙ ===
  // Внутри вашего AppCubit

  // lib/cubit/app_cubit.dart

  // lib/cubit/app_cubit.dart

  Future<void> flipCardOfTheDay() async {
    if (state.isCardOfTheDayFlipped || state.cardOfTheDay == null) return;

    final card = state.cardOfTheDay!;
    String finalInterpretation;

    // 1. Получаем базовое толкование (здесь все без изменений)
    final baseInterpretation =
        card.isReversed ? card.reversedInterpretation : card.interpretation;

    // 2. Пытаемся получить персональное толкование
    try {
      // Убеждаемся, что прогноз загружен. forceReload не нужен, если данные уже есть.
      if (state.dailyForecast == null) await loadDailyForecast();

      if (state.dailyForecast != null &&
          state.dailyForecast!.interpretations.isNotEmpty) {
        // --- 👇 ГЛАВНОЕ ИЗМЕНЕНИЕ 👇 ---
        // Преобразуем список интерпретаций в список их КЛЮЧЕЙ (строк)
        final aspectKeys = state.dailyForecast!.interpretations
            .map((interp) => interp.key)
            .toList();

        // Теперь getPersonalTarotInterpretation должен принимать List<String>
        final personalText =
            await _apiRepository.getPersonalTarotInterpretation(
          cardThemeKey: card.themeKey,
          isReversed: card.isReversed,
          aspectKeys: aspectKeys, // <-- ПЕРЕИМЕНУЙ aspectKeys вместо aspects
          lang:
              currentLocale.languageCode, // <-- ПЕРЕИМЕНУЙ lang вместо langCode
        );

        finalInterpretation = personalText != null
            ? "$baseInterpretation\n\n✨ Персональный аспект: $personalText"
            : baseInterpretation;
      } else {
        finalInterpretation = baseInterpretation;
      }
    } catch (e) {
      logger.d("⚠️ Не удалось получить персональный ключ для карты дня: $e");
      finalInterpretation = baseInterpretation;
    }

    // 3. Сохраняем и обновляем state (здесь все без изменений)
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('card_of_day_interpretation', finalInterpretation);

    emit(state.copyWith(
      isCardOfTheDayFlipped: true,
      cardOfTheDayInterpretation: finalInterpretation,
    ));
    logger.d("✅ Карта дня перевернута, толкование сохранено.");
  }

  // === НОВЫЙ МЕТОД ДЛЯ ГЕНЕРАЦИИ ПЕРСОНАЛЬНОГО СОВЕТА ===
  String getPersonalAdviceForEvent(CosmicEvent event) {
    final natalChart = state.currentUserProfile?.natalChart;
    if (natalChart == null) {
      return "Рассчитываем вашу натальную карту...";
    }

    // Здесь будет сложная логика. Пока сделаем простую заглушку.
    // TODO: Реализовать расчет дома, в который попадает событие
    final houseNumber =
        ((event.planetSign ?? '').hashCode % 12) + 1; // Используем planetSign

    return "Это событие активирует ваш ${houseNumber}-й дом. Для вас это время, чтобы сфокусироваться на...";
  }

  Future<void> loadGeomagneticForecast() async {
    final prefs = await SharedPreferences.getInstance();

    final cachedJsonString = prefs.getString('geomagnetic_cache_data');
    if (cachedJsonString != null) {
      try {
        final List<dynamic> cachedList = json.decode(cachedJsonString);
        final forecast = cachedList
            .map((item) => GeomagneticForecast.fromJson(item))
            .toList();
        emit(state.copyWith(
          geomagneticForecast: forecast,
          geomagneticForecastStatus: LoadingState.success,
        ));
        logger.d(
            "✅ Геомагнитный прогноз загружен из локального кэша (SharedPreferences).");
      } catch (e) {
        logger.d("Ошибка парсинга кэша геомагнитного прогноза: $e");
      }
    }

    final lastFetchMillis = prefs.getInt('geomagnetic_last_fetch') ?? 0;
    final oneHour = const Duration(hours: 1).inMilliseconds;

    if (DateTime.now().millisecondsSinceEpoch - lastFetchMillis < oneHour &&
        state.geomagneticForecast.isNotEmpty) {
      logger.d(
          "Обновление геомагнитного прогноза не требуется (не прошло и часа).");
      // Даже если не обновляем, все равно проверим на бурю по кэшированным данным
      _checkAndNotifyForGeomagneticStorm(state.geomagneticForecast);
      return;
    }

    emit(state.copyWith(geomagneticForecastStatus: LoadingState.loading));
    try {
      final forecast = await _geomagneticService.get3DayForecast();

      // Выносим логику проверки в отдельный метод для переиспользования
      _checkAndNotifyForGeomagneticStorm(forecast);

      final jsonToCache =
          json.encode(forecast.map((item) => item.toJson()).toList());
      await prefs.setString('geomagnetic_cache_data', jsonToCache);
      await prefs.setInt(
          'geomagnetic_last_fetch', DateTime.now().millisecondsSinceEpoch);

      emit(state.copyWith(
        geomagneticForecast: forecast,
        geomagneticForecastStatus: LoadingState.success,
      ));
      logger.d(
          "✅ Геомагнитный прогноз успешно загружен из сети и сохранен в кэш.");
    } catch (e) {
      logger.d("❌ Ошибка загрузки геомагнитного прогноза: $e");
      emit(state.copyWith(geomagneticForecastStatus: LoadingState.error));
    }
  }

  // ================== ИСПРАВЛЕННЫЙ ВСПОМОГАТЕЛЬНЫЙ МЕТОД ==================
  // Этот приватный метод содержит логику проверки и отправки уведомления о буре
  Future<void> _checkAndNotifyForGeomagneticStorm(
      List<GeomagneticForecast> forecast) async {
    if (forecast.isEmpty) return;

    final now = DateTime.now();
    final currentForecast = forecast.firstWhere(
      // Используем правильное имя поля: f.time
      (f) =>
          f.time.year == now.year &&
          f.time.month == now.month &&
          f.time.day == now.day,
      orElse: () => forecast.first,
    );

    // Kp-индекс >= 5 считается бурей. Используем правильное имя поля: currentForecast.kpValue
    if (currentForecast.kpValue >= 5) {
      final prefs = await SharedPreferences.getInstance();
      final lastAlertDate = prefs.getString('geomagnetic_alert_date');
      final todayString = "${now.year}-${now.month}-${now.day}";

      final bool notificationsEnabled = state
              .currentUserProfile?.settings?.notifications?.geomagneticAlerts ??
          true;
      if (lastAlertDate != todayString && notificationsEnabled) {
        _scheduler?.showNow(
          id: 4,
          title: '⚠️ Геомагнитная буря!',
          body:
              'Сегодня ожидается высокий уровень геомагнитной активности (Kp-индекс: ${currentForecast.kpValue}). Возможны головные боли.',
        );
        await prefs.setString('geomagnetic_alert_date', todayString);
      }

      // Отправляем уведомление только ОДИН раз в день для бури
      if (lastAlertDate != todayString) {
        _scheduler?.showNow(
          id: 4, // Уникальный ID для гео-бури
          title: '⚠️ Геомагнитная буря!',
          // Используем правильное имя поля: currentForecast.kpValue
          body:
              'Сегодня ожидается высокий уровень геомагнитной активности (Kp-индекс: ${currentForecast.kpValue}). Возможны головные боли.',
        );
        // Запоминаем, что на сегодня уже предупредили
        await prefs.setString('geomagnetic_alert_date', todayString);
      }
    }
  }

  // === НОВЫЙ МЕТОД №1: ВЫТЯГИВАЕМ КАРТУ ДНЯ ===
  Future<void> drawCardOfTheDay({bool forceSchedule = false}) async {
    // Не запускаем, если уже идет загрузка
    if (state.cardOfTheDayStatus == LoadingState.loading) return;
    emit(state.copyWith(cardOfTheDayStatus: LoadingState.loading));

    try {
      // Просто просим у сервера нашу карту на сегодня
      final lang = state.locale?.languageCode ?? 'ru';
      final dailyCard = await _apiRepository.getMyCardOfTheDay(lang);

      emit(state.copyWith(
        cardOfTheDay: dailyCard,
        cardOfTheDayStatus: LoadingState.success,
        // Сбрасываем старые данные о перевороте и толковании
        isCardOfTheDayFlipped: false,
        cardOfTheDayInterpretation: null,
      ));
      logger.d("✅ Карта дня успешно получена с сервера.");
    } catch (e) {
      logger.d("❌ ОШИБКА в drawCardOfTheDay (при запросе с сервера): $e");
      emit(state.copyWith(cardOfTheDayStatus: LoadingState.error));
    }
  }

  void resetAuthStatus() {
    // Просто сбрасываем статус аутентификации в начальное состояние.
    // Это позволит GoRouter'у снова пустить пользователя на экран логина/регистрации.
    emit(state.copyWith(
      authStatus: AuthStatus.initial,
      authErrorMessage: '', // Также очищаем старые ошибки
    ));
  }

  // === МЕТОДЫ ИЗ AuthCubit ===
  void emailChanged(String value) => emit(state.copyWith(email: value));
  void passwordChanged(String value) => emit(state.copyWith(password: value));
  void confirmPasswordChanged(String value) =>
      emit(state.copyWith(confirmPassword: value));

  Future<void> signUpWithEmailPassword(
      String email, String password, String confirmPassword) async {
    if (password != confirmPassword) {
      emit(state.copyWith(
          authStatus: AuthStatus.error,
          authErrorMessage: "Пароли не совпадают"));
      return;
    }
    if (password.length < 6) {
      emit(state.copyWith(
          authStatus: AuthStatus.error,
          authErrorMessage: "Пароль должен быть не менее 6 символов"));
      return;
    }

    emit(state.copyWith(authStatus: AuthStatus.submitting));

    try {
      // 1. Регистрируемся и получаем в ответ JWT и userId
      final authData = await _apiRepository.register(email.trim(), password);
      final userId = authData['userId'];

      if (userId == null) {
        throw Exception("Сервер не вернул ID пользователя после регистрации.");
      }

      // 2. СРАЗУ ЖЕ переводим состояние в "ожидание верификации"
      // и сохраняем ID пользователя для следующего шага.
      emit(state.copyWith(
        authStatus: AuthStatus.awaitingVerification,
        unverifiedUserId: userId,
        unverifiedUserEmail: email.trim(),
      ));
    } on Exception catch (e) {
      String errorMessage = e.toString().replaceFirst('Exception: ', '');
      if (errorMessage.contains('already exists')) {
        errorMessage = "Аккаунт с таким E-mail уже существует.";
      }
      emit(state.copyWith(
        authStatus: AuthStatus.error,
        authErrorMessage: errorMessage,
      ));
    }
  }

  Future<void> _loadUserProfile(String userId) async {
    if (state.currentUserProfile?.id != userId) {
      emit(state.copyWith(profileLoadingState: LoadingState.loading));
    }

    try {
      final profile = await _apiRepository.getUserProfile(userId);

      if (profile != null) {
        // --- 👇 ДОБАВЛЕННЫЙ БЛОК: ВОССТАНОВЛЕНИЕ НАТАЛЬНОЙ КАРТЫ 👇 ---
        // Если карты нет, но есть дата рождения -> считаем локально и сохраняем
        if (profile.natalChart == null &&
            profile.birthDateMillis > 0 &&
            profile.birthLocation != null) {
          logger.d(
              "[AppCubit] Натальная карта пуста (после миграции). Запускаю локальный пересчет...");

          try {
            final chart = await _chartCalculator.calculateAll(
                profile.birthDateMillis,
                profile.birthLocation!.latitude,
                profile.birthLocation!.longitude);

            if (chart != null) {
              // 1. Обновляем локальный профиль (копируем и добавляем карту)
              // Важно: profile - это иммутабельный объект, создаем новый
              final updatedProfile = profile.copyWith(natalChart: chart);

              // 2. Сохраняем на сервер (чтобы больше не считать)
              // Используем updateUserBirthData, так как он принимает natalChart
              await _apiRepository.updateUserBirthData({
                'natalChart': chart.toFirestore(),
                // Передаем дату, чтобы сервер знал контекст (хотя можно и без нее, если API умный)
                'birthDateMillis': profile.birthDateMillis
              });
              logger.d(
                  "[AppCubit] Карта успешно рассчитана и сохранена на сервере.");

              // Используем обновленный профиль дальше
              // (перезаписываем переменную profile нельзя, она final, поэтому используем updatedProfile в emit)
              emit(state.copyWith(
                  currentUserProfile: updatedProfile,
                  isOnboardingComplete: true,
                  isInitialized: true,
                  isReady: true,
                  profileLoadingState: LoadingState.success,
                  authStatus: AuthStatus.success,
                  profileStatus: ProfileValidationStatus.valid));
            }
          } catch (calcError) {
            logger.d(
                "[AppCubit] Ошибка при локальном пересчете карты: $calcError");
            // Если не вышло, грузим профиль как есть (без карты)
            emit(state.copyWith(
                currentUserProfile: profile,
                isOnboardingComplete: true,
                isInitialized: true,
                isReady: true,
                profileLoadingState: LoadingState.success,
                authStatus: AuthStatus.success,
                profileStatus: ProfileValidationStatus.valid));
          }
        } else {
          // Обычный путь (карта есть или юзер новый)
          final isComplete = profile.birthDateMillis > 0;
          emit(state.copyWith(
              currentUserProfile: profile,
              isOnboardingComplete: isComplete,
              isInitialized: true,
              isReady: true,
              profileLoadingState: LoadingState.success,
              authStatus: AuthStatus.success,
              profileStatus: isComplete
                  ? ProfileValidationStatus.valid
                  : ProfileValidationStatus.unknown));
        }
        // --- 👆 КОНЕЦ БЛОКА 👆 ---

        if (profile.birthDateMillis > 0) {
          // Проверяем по дате, так как isComplete мог быть не определен выше
          logger.d(
              "[AppCubit] Профиль '${profile.name}' загружен. Подключаюсь к WebSocket и загружаю справочники.");
          WebSocketService.instance.connect();

          await Future.wait([
            _loadAstroDescriptions(),
            loadAspectInterpretations(),
            _loadCompatibilityDescriptions(),
            loadNumerologyCompatibility(),
            loadNumerologyNumberDescriptions(),
            loadFriendsData(),
          ]);
          logger.d("--- CUBIT: Все справочники загружены. ---");
        }
      } else {
        emit(state.copyWith(
            isOnboardingComplete: false,
            isInitialized: true,
            isReady: true,
            profileLoadingState: LoadingState.success,
            authStatus: AuthStatus.success));
      }
    } catch (e) {
      logger.d("❌ Ошибка при загрузке профиля: $e. Выполняю выход.");
      await signOut();
    }
  }

  Future<String?> verifyEmailWithCode(String code) async {
    // 1. Проверяем длину кода и возвращаем КЛЮЧ ошибки, а не текст.
    if (code.length != 6) {
      return "errorCodeLength"; // Ключ для "Код должен состоять из 6 цифр"
    }

    emit(state.copyWith(authStatus: AuthStatus.submitting));

    try {
      // ШАГ 1: Отправляем код на сервер. Если код неверный, здесь будет ошибка.
      await _apiRepository.verifyEmailCode(code);

      // ШАГ 2: УСПЕХ! Email подтвержден. Теперь нужно "войти" в приложение.
      // Берем ID пользователя, который мы сохранили при регистрации.
      final userId = state.unverifiedUserId;
      if (userId == null || userId.isEmpty) {
        throw Exception("User ID not found in state after verification.");
      }

      // ШАГ 3: Загружаем полный профиль, чтобы приложение знало, кто вошел.
      final profile = await _apiRepository.getUserProfile(userId);
      if (profile == null) {
        throw Exception(
            "Profile not found after verification, though code was correct.");
      }

      // ШАГ 4: ЭТО САМОЕ ГЛАВНОЕ! Обновляем состояние приложения.
      // Мы говорим GoRouter'у: "Все, пользователь успешно вошел, у него есть профиль".
      emit(state.copyWith(
        authStatus: AuthStatus.success, // <-- Меняем статус на "успех"
        currentUserProfile: profile, // <-- Записываем профиль
        isOnboardingComplete: false, // <-- Он еще не проходил онбординг
        profileLoadingState: LoadingState.success,
        unverifiedUserId: null, // <-- Очищаем временные поля
        unverifiedUserEmail: '',
      ));

      return null; // Возвращаем null в знак полного успеха
    } on Exception catch (e) {
      // Если API вернул ошибку (например, "Неверный код")
      emit(state.copyWith(authStatus: AuthStatus.awaitingVerification));

      // Пытаемся извлечь ключ ошибки из ответа сервера
      String errorString = e.toString().replaceFirst('Exception: ', '');
      if (errorString.contains("Неверный или просроченный код")) {
        return 'error_invalid_or_expired_code';
      }
      // Если это не JSON, возвращаем исходный текст ошибки как есть
      return errorString;
    }
  }

  Future<void> logInWithCredentials(
      {required String email, required String password}) async {
    logger.d("--- 📱 [AppCubit] Начало входа. Email: $email");
    emit(state.copyWith(
        authStatus: AuthStatus.submitting, authErrorMessage: ''));

    try {
      // =====================================================================
      // ШАГ 1: ПРОБУЕМ ВОЙТИ ЧЕРЕЗ НАШ API (PostgreSQL)
      // =====================================================================
      try {
        logger.d("--- 📱 [AppCubit] Попытка входа через API...");
        final authData = await _apiRepository.login(email.trim(), password);
        final userId = authData['userId'];
        final isVerified = authData['isEmailVerified'] ?? false;

        if (userId == null) throw Exception("Server did not return a user ID.");

        // Если почта не подтверждена (для новых юзеров)
        if (!isVerified) {
          emit(state.copyWith(
            authStatus: AuthStatus.awaitingVerification,
            unverifiedUserEmail: email.trim(),
            unverifiedUserId: userId,
          ));
          return;
        }

        // Если успешно вошли через API -> Загружаем профиль и выходим
        logger
            .d("--- 📱 [AppCubit] Вход через API успешен. Загружаю профиль...");
        await _loadUserProfileAndDictionaries(userId);
        return;
      } catch (apiError) {
        // Если ошибка НЕ связана с неверным паролем (например, сеть упала), пробрасываем её
        final errorStr = apiError.toString();
        if (!errorStr.contains('Invalid credentials') &&
            !errorStr.contains('User not found')) {
          throw apiError;
        }
        logger.d(
            "--- 📱 [AppCubit] Вход через API не удался (${apiError}). Пробую Firebase...");
      }

      // =====================================================================
      // ШАГ 2: ЕСЛИ API ОТКАЗАЛ -> ПРОБУЕМ FIREBASE (Для старых юзеров)
      // =====================================================================
      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      final firebaseUser = userCredential.user;
      if (firebaseUser == null) {
        throw Exception('Firebase login failed');
      }

      logger
          .d("--- 📱 [AppCubit] Вход в Firebase успешен! Начинаю миграцию...");
      final firebaseToken = await firebaseUser.getIdToken(true);

      if (firebaseToken != null) {
        // Отправляем токен на сервер для миграции
        await _apiRepository.migrateWithFirebaseToken(firebaseToken);

        // После миграции JWT уже сохранен в ApiRepository.
        // Нам нужно получить ID пользователя, чтобы загрузить профиль.
        // В _apiRepository.migrateWithFirebaseToken мы не возвращаем ID,
        // но он сохраняется в SharedPreferences внутри репозитория.
        final prefs = await SharedPreferences.getInstance();
        final userId = prefs.getString('user_id');

        if (userId != null) {
          logger
              .d("--- 📱 [AppCubit] Миграция завершена. Вхожу в приложение...");
          await _loadUserProfileAndDictionaries(userId);
          return;
        }
      }

      throw Exception(
          'Migration failed: User ID not found after Firebase login');
    } on FirebaseAuthException catch (e) {
      // Ошибки Firebase (неверный пароль и т.д.)
      logger.d("--- 📱 [AppCubit] Ошибка Firebase: ${e.code}");
      String msg = "Ошибка входа.";
      if (e.code == 'user-not-found' ||
          e.code == 'wrong-password' ||
          e.code == 'invalid-credential') {
        msg = "Неверный email или пароль.";
      } else if (e.code == 'too-many-requests') {
        msg = "Слишком много попыток. Попробуйте позже.";
      }
      emit(state.copyWith(authStatus: AuthStatus.error, authErrorMessage: msg));
    } catch (e) {
      logger.d("--- 📱 [AppCubit] ❌ КРИТИЧЕСКАЯ ОШИБКА ВХОДА: $e");
      emit(state.copyWith(
        authStatus: AuthStatus.error,
        authErrorMessage: e.toString().replaceFirst('Exception: ', ''),
      ));
    }
  }

  Future<String?> resendVerificationCode() async {
    // Берем email, который пользователь ввел на экране логина
    final email = state.unverifiedUserEmail.trim();
    if (email.isEmpty) {
      return "Email не найден. Вернитесь на экран входа.";
    }

    emit(state.copyWith(authStatus: AuthStatus.submitting));
    try {
      await _apiRepository.resendVerificationCode(email);
      // Возвращаем статус в "ожидание", чтобы UI убрал индикатор загрузки
      emit(state.copyWith(authStatus: AuthStatus.awaitingVerification));
      return null; // Успех
    } on Exception catch (e) {
      emit(state.copyWith(authStatus: AuthStatus.awaitingVerification));
      return e
          .toString()
          .replaceFirst('Exception: ', ''); // Возвращаем текст ошибки
    }
  }

  Future<void> _loadUserProfileAndDictionaries(String userId) async {
    // Не ставим loading, если профиль уже есть (например, после hot reload)
    if (state.profileLoadingState != LoadingState.loading) {
      emit(state.copyWith(profileLoadingState: LoadingState.loading));
    }

    try {
      // --- Шаг 1: Загружаем профиль ---
      final profile = await _apiRepository.getUserProfile(userId);

      if (profile != null) {
        final isComplete = profile.birthDateMillis > 0;

        emit(state.copyWith(
            currentUserProfile: profile,
            isOnboardingComplete: isComplete,
            isInitialized: true,
            isReady: true,
            profileLoadingState: LoadingState.success,
            authStatus: AuthStatus
                .success, // Убираем индикатор загрузки с экрана логина
            profileStatus: isComplete
                ? ProfileValidationStatus.valid
                : ProfileValidationStatus.unknown));

        // --- Шаг 2: Если профиль полный, грузим остальное в фоне ---
        if (isComplete) {
          WebSocketService.instance.connect();
          // Загружаем переводы и данные параллельно
          await _loadAllLocalizedData(forceReload: true);
          _runBackgroundTasks();
        }
      } else {
        logger.d("Профиль не найден. Выход.");
        await signOut();
      }
    } catch (e) {
      logger.d("❌ Ошибка загрузки профиля: $e");
      emit(state.copyWith(
          authStatus: AuthStatus.error,
          authErrorMessage: "Не удалось загрузить профиль."));
    }
  }

  Future<void> _loadJyotishDescriptions({bool forceReload = false}) async {
    if (state.jyotishDescriptions.isNotEmpty && !forceReload) return;
    try {
      final lang = currentLocale.languageCode;
      logger.d(
          "🌍 [Localization DEBUG] Запрашиваю описания Джйотиш для языка: '$lang'");
      final descriptions = await _apiRepository.getJyotishDescriptions(lang);
      if (descriptions.isNotEmpty) {
        emit(state.copyWith(jyotishDescriptions: descriptions));
        logger.d("✅ Описания Джйотиш успешно загружены.");
      }
    } catch (e) {
      logger.d("❌ Ошибка загрузки описаний Джйотиш: $e");
    }
  }

// --- 👇 НОВЫЙ ВСПОМОГАТЕЛЬНЫЙ МЕТОД ДЛЯ ФОНОВЫХ ЗАДАЧ 👇 ---
  void _runBackgroundTasks() {
    // Подключаемся к WebSocket
    WebSocketService.instance.connect();

    // Создаем список Future'ов для загрузки
    final tasks = <Future>[
      _loadAstroDescriptions(),
      loadAspectInterpretations(),
      _loadCompatibilityDescriptions(),
      loadNumerologyNumberDescriptions(),
      loadNumerologyCompatibility(),
      _loadJyotishDescriptions(),
      loadFriendsData(),
      loadInitialChatList(),
    ];

    // Выполняем их все, но не ждем результата здесь.
    // Просто логируем ошибки, если они будут.
    Future.wait(tasks).then((_) {
      logger.d("--- CUBIT: ✅ Все фоновые задачи успешно запущены/завершены.");
    }).catchError((e) {
      logger.d("--- CUBIT: ⚠️ Ошибка при выполнении фоновых задач: $e");
    });
  }

  Future<void> signOut() async {
    await _apiRepository.clearToken();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_id');
    WebSocketService.instance.disconnect();
    _clearAllUserData();
    emit(AppState(isReady: true, transitInterpretations: {}));
  }

// === НОВЫЙ МЕТОД №2: ПЕРЕВОРАЧИВАЕМ КАРТУ ===

  // НОВЫЙ МЕТОД ДЛЯ ПОИСКА ПО ХЭШТЕГУ
  Future<void> startSearchWithHashtag(String hashtag) async {
    logger.d("Запускаю поиск по хэштегу: #${hashtag.trim()}");
    // Просто вызываем наш основной метод поиска, который работает через API.
    await startNewSearch(query: '#${hashtag.trim()}');
  }

  List<String> _extractHashtags(String text) {
    if (text.isEmpty) return [];
    // Регулярное выражение для поиска хэштегов
    final regex = RegExp(r'#(\w+)');
    return regex
        .allMatches(text)
        .map((match) {
          return match
              .group(1)!
              .toLowerCase(); // Берем текст без # и в нижнем регистре
        })
        .toSet()
        .toList(); // toSet().toList() для удаления дубликатов
  }

  // === НОВЫЙ МЕТОД №2: РАССЧИТЫВАЕМ ПЕРСОНАЛЬНЫЙ КЛЮЧ ===
  Future<void> getPersonalKeyForCard() async {
    final card = state.cardOfTheDay;
    final natalChart = state.currentUserProfile?.natalChart;

    if (card == null || natalChart == null) {
      emit(state.copyWith(
          cardOfTheDayInterpretation:
              "Данные не готовы. Сначала вытяните карту."));
      return;
    }

    final planetEnum = card.astrologicalPlanet;
    if (planetEnum == null) {
      emit(state.copyWith(cardOfTheDayInterpretation: card.affirmation));
      return;
    }

    // --- ПРОВЕРКА И ЗАГРУЗКА СЛОВАРЯ ---
    if (state.focusInterpretations.isEmpty) {
      emit(state.copyWith(
          cardOfTheDayInterpretation: "Загружаю космические данные..."));
      try {
        // Этот метод загружает /astrology/focus-interpretations
        await calculateFocusOfTheDay();
      } catch (e) {
        logger.d("Ошибка загрузки текстов для карты дня: $e");
      }

      // Если все еще пусто - выходим
      if (state.focusInterpretations.isEmpty) {
        emit(state.copyWith(
            cardOfTheDayInterpretation: "Не удалось связаться с сервером."));
        return;
      }
    }
    // -----------------------------------

    final planetKey = planetEnum.name.toUpperCase();
    final natalPos = natalChart.planetPositions?[planetKey];

    if (natalPos == null) {
      emit(state.copyWith(
          cardOfTheDayInterpretation:
              "Планета карты не найдена в вашем гороскопе."));
      return;
    }

    // Ищем дом
    final houseNum =
        AstroUtils.getHouseForPosition(natalPos, natalChart.houseCusps ?? {});

    // Достаем текст из словаря, который мы только что заполнили в БД
    final housesMap =
        state.focusInterpretations['houses'] as Map<String, dynamic>? ?? {};
    final houseKey = 'HOUSE_$houseNum';

    // Берем текст из БД или заглушку
    final lang = state.locale?.languageCode ??
        'en'; // Берем язык пользователя или английский

    final houseText = housesMap[houseKey]?['text']?[lang] ??
        housesMap[houseKey]?['text']?['en'] ?? // Фолбек на английский
        "activates your $houseNum house.";

    final planetName = card.name.contains("Солнце")
        ? "Солнце"
        : card.name.contains("Луна")
            ? "Луна"
            : planetEnum.name.capitalizeFirst();

    // Формируем красивый ответ
    final personalKey = "✨ **Персональный ключ:**\n\n"
        "Эта карта резонирует с вашим натальным $planetName, который находится в $houseNum доме.\n"
        "Это значит, что энергия карты сегодня $houseText\n\n"
        "💡 *Совет:* Используйте это влияние осознанно!";

    emit(state.copyWith(cardOfTheDayInterpretation: personalKey));
  }

  // === НОВЫЙ МЕТОД ДЛЯ ЗАПУСКА ТАЙМЕРА ===
  void _startGeomagneticTimer() {
    // Отменяем старый таймер, если он был
    _geomagneticTimer?.cancel();

    // Запускаем новый. Он будет вызывать loadGeomagneticForecast каждые 40 минут
    _geomagneticTimer = Timer.periodic(const Duration(minutes: 40), (timer) {
      logger.d(
          "⏰ Таймер сработал. Проверяю актуальность геомагнитного прогноза...");
      // Просто вызываем наш метод. Он сам проверит, нужно ли реально идти в сеть.
      loadGeomagneticForecast();
    });
  }

  Future<String?> openChatWithUser(String otherUserId) async {
    final currentUserId = state.currentUserProfile?.id;
    if (currentUserId == null) return null;

    String chatId;
    if (currentUserId.compareTo(otherUserId) < 0) {
      // БЫЛО: '${currentUserId}_${otherUserId}'
      // СТАЛО: Используем ТРОЙНОЕ подчеркивание для надежности
      chatId = '${currentUserId}___${otherUserId}';
    } else {
      chatId = '${otherUserId}___${currentUserId}';
    }
    return chatId;
  }

  Future<void> loadNumerologyDataForDetailScreen() async {
    if (state.numerologyScreenStatus == LoadingState.loading) return;

    // Если данные уже есть, просто обновляем статус
    if (state.numerologyNumberDescriptions.isNotEmpty &&
        state.currentUserProfile?.numerologyData != null) {
      emit(state.copyWith(numerologyScreenStatus: LoadingState.success));
      return;
    }

    emit(state.copyWith(numerologyScreenStatus: LoadingState.loading));

    try {
      final userId = state.currentUserProfile?.id;
      if (userId == null) throw Exception("User ID not found");

      final results = await Future.wait([
        _apiRepository.getUserProfile(userId),
        _apiRepository.getNumerologyNumberDescriptions(
            lang: currentLocale.languageCode),
      ]);

      final freshProfile = results[0] as UserProfileCard?;
      final numerologyDescriptions = results[1] as Map<String, String>;

      if (freshProfile == null || numerologyDescriptions.isEmpty) {
        // Можно добавить повторную попытку или загрузку дефолтного языка
        throw Exception("Failed to load data");
      }

      // ИСПОЛЬЗУЕМ COPYWITH!
      emit(state.copyWith(
        currentUserProfile: freshProfile,
        numerologyNumberDescriptions: numerologyDescriptions,
        numerologyScreenStatus: LoadingState.success,
      ));
    } catch (e) {
      logger.d("Error loading numerology details: $e");
      emit(state.copyWith(numerologyScreenStatus: LoadingState.error));
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState lifecycleState) {
    super.didChangeAppLifecycleState(
        lifecycleState); // <-- Хорошая практика - вызывать super

    // --- ДОБАВЬ ЭТОТ КОД ---
    // Когда приложение становится активным (запущено или вернулось из фона)
    if (lifecycleState == AppLifecycleState.resumed) {
      logger.d("App is resumed. Updating online status and syncing profile.");
      updateCurrentUserStatus(isOnline: true);

      // --- 👇 ЗАКОММЕНТИРУЙ ЭТИ ДВЕ СТРОКИ 👇 ---
      // _apiRepository.forceSyncUserProfile().catchError((e) {
      //   logger.d("Фоновая синхронизация профиля не удалась: $e");
      // });
      // --- 👆 КОНЕЦ 👆 --

      updateAndGetCurrentUserLocation();
      _startLocationUpdater();
    }

    // Когда приложение свернуто
    if (lifecycleState == AppLifecycleState.paused) {
      logger.d("App is paused. Stopping location timer.");
      // --- 👇 ДОБАВЬ ЭТО 👇 ---
      // Останавливаем таймер, чтобы не тратить батарею в фоне
      _locationUpdateTimer?.cancel();
      // --- КОНЕЦ ДОБАВЛЕНИЯ ---
    }

    // Твоя остальная логика для geomagneticTimer и т.д. остается здесь

    // --- КОНЕЦ ДОБАВЛЕНИЯ ---

    // Твоя логика с таймером для геомагнитного прогноза остается
    final userId = state.currentUserProfile?.id;
    if (userId == null) return;

    if (lifecycleState == AppLifecycleState.resumed) {
      logger.d("Приложение активно, проверяю прогноз и перезапускаю таймер.");
      loadGeomagneticForecast();
      _startGeomagneticTimer();
    } else if (lifecycleState == AppLifecycleState.paused) {
      logger.d("Приложение свернуто, останавливаю таймер.");
      _geomagneticTimer?.cancel();
    }
  }

  // --- ДОБАВЬ ЭТОТ НОВЫЙ МЕТОД В AppCubit ---
  Future<void> updateCurrentUserStatus({required bool isOnline}) async {
    final userId = state.currentUserProfile?.id;
    if (userId == null) return;

    try {
      // Вызываем наш новый метод, который идет в PostgreSQL
      await _apiRepository.updateUserStatus();
    } catch (e) {
      // Ошибку просто логируем, чтобы не прерывать работу приложения
      logger.d("Failed to update user status via API: $e");
    }
  }

  // ИЗМЕНИМ `forceRefreshUserProfile`
  Future<void> forceRefreshUserProfile() async {
    final userId = state.currentUserProfile?.id;
    if (userId == null) return;

    // Не показываем глобальный индикатор загрузки, чтобы обновление было "бесшовным"
    // emit(state.copyWith(profileLoadingState: LoadingState.loading));

    logger.d(
        "[Refresh] Получаю свежий профиль с сервера по сигналу от WebSocket...");

    try {
      // Делаем только ОДИН запрос за самим профилем.
      // Справочники (описания аспектов и т.д.) перезагружать не нужно, они не меняются.
      final freshProfile = await _apiRepository.getUserProfile(userId);

      if (freshProfile != null) {
        logger.d("[Refresh] ✅ Свежий профиль получен. Обновляю state.");

        // "Умное" обновление: сравниваем, изменилось ли что-то важное
        final bool areProfilesDifferent =
            state.currentUserProfile != freshProfile;

        if (areProfilesDifferent) {
          emit(state.copyWith(
            currentUserProfile: freshProfile,
            // profileLoadingState: LoadingState.success // Не нужно, если не ставили loading
          ));
          logger.d("[Refresh] State обновлен, UI будет перерисован.");
        } else {
          logger.d(
              "[Refresh] Изменений в профиле не обнаружено. Обновление UI пропущено.");
        }
      } else {
        logger.d(
            "[Refresh] ⚠️ Не удалось получить свежий профиль (возможно, удален). Выполняю выход.");
        signOut();
      }
    } catch (e) {
      logger.d("[Refresh] ❌ Ошибка при принудительном обновлении: $e");
      // Не меняем state, чтобы не показывать ошибку на весь экран из-за фонового обновления
      // emit(state.copyWith(profileLoadingState: LoadingState.error));
    }
  }

  // === 4. ДОБАВЬ ЭТОТ НОВЫЙ МЕТОД _init() ===
  Future<void> _init() async {
    final prefs = await SharedPreferences.getInstance();
    final introSeenValue = prefs.getBool('intro_seen') ?? false;

    String? jwtToken = await _apiRepository.jwtToken;
    String? userId = prefs.getString('user_id');

    // --- БЛОК МИГРАЦИИ (Оставляем как есть) ---
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (jwtToken == null && firebaseUser != null) {
      logger.d(
          "[Migration] Обнаружен старый пользователь Firebase (${firebaseUser.uid}). Запускаю миграцию...");
      try {
        final firebaseToken = await firebaseUser.getIdToken(true);
        if (firebaseToken != null) {
          await _apiRepository.migrateWithFirebaseToken(firebaseToken);
          jwtToken = await _apiRepository.jwtToken;
          userId = firebaseUser.uid;
          await prefs.setString('user_id', userId);
          logger.d("[Migration] ✅ Миграция успешна.");
        }
      } catch (e) {
        logger.d("[Migration] ❌ Ошибка миграции: $e");
        await FirebaseAuth.instance.signOut();
        jwtToken = null;
        userId = null;
      }
    }
    // --- КОНЕЦ БЛОКА МИГРАЦИИ ---

    if (jwtToken != null && userId != null) {
      logger.d(
          "[AppCubit] Сессия найдена для $userId. Начинаю полную загрузку...");
      emit(state.copyWith(profileLoadingState: LoadingState.loading));

      try {
        // --- 👇 ГЛАВНОЕ ИСПРАВЛЕНИЕ ЗДЕСЬ 👇 ---
        // Добавляем forceReload: true, чтобы гарантированно загрузить данные с сервера
        final results = await Future.wait([
          _apiRepository.getUserProfile(userId),
          _loadAstroDescriptions(forceReload: true),
          loadAspectInterpretations(forceReload: true),
          _loadCompatibilityDescriptions(forceReload: true),
          loadNumerologyCompatibility(forceReload: true),
          loadNumerologyNumberDescriptions(
              forceReload: true), // <--- ОБЯЗАТЕЛЬНО forceReload: true
        ]);

        logger.d("[AppCubit] ✅ Профиль и все справочники успешно загружены.");

        final profileFromApi = results[0] as UserProfileCard?;

        if (profileFromApi != null) {
          final bool isProfileComplete = profileFromApi.birthDateMillis > 0;

          if (isProfileComplete) {
            logger.d("[AppCubit] Профиль завершен. Вход.");
            emit(state.copyWith(
                currentUserProfile: profileFromApi,
                isOnboardingComplete: true,
                isInitialized: true,
                isReady: true,
                introSeen: introSeenValue,
                profileLoadingState: LoadingState.success,
                profileStatus: ProfileValidationStatus.valid));
            WebSocketService.instance.connect();
            _runBackgroundTasks();
          } else {
            logger.d("[AppCubit] Профиль не завершен. Онбординг.");
            emit(state.copyWith(
                currentUserProfile: profileFromApi,
                isOnboardingComplete: false,
                isInitialized: true,
                isReady: true,
                introSeen: introSeenValue,
                profileLoadingState: LoadingState.success,
                profileStatus: ProfileValidationStatus.unknown));
          }
        } else {
          logger.d("[AppCubit] ⚠️ Профиль не найден. Выход.");
          await signOut();
        }
      } catch (e) {
        logger.d("❌ Ошибка в _init: $e");
        await signOut();
      }
    } else {
      logger.d("[AppCubit] Сессия не найдена. Экран входа.");
      _clearAllUserData();
      emit(state.copyWith(
        isInitialized: true,
        isReady: true,
        introSeen: introSeenValue,
      ));
    }
  }

// Метод инициализации оплаты
  Future<void> initiatePayment(BuildContext context) async {
    if (state.isProLoading) return;
    emit(state.copyWith(isProLoading: true));

    try {
      // 1. Получаем ссылку
      final url = await _apiRepository.createPaymentLink(amount: "399");

      // 2. Открываем в браузере (внешнем, чтобы не было проблем с 3D Secure и куками)
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw Exception("Не могу открыть ссылку");
      }

      // 3. (Опционально) Запускаем поллинг (опрос) профиля
      // Чтобы узнать, прошла ли оплата, когда юзер вернется.
      // Или полагаемся на WebSocket уведомление.
    } catch (e) {
      logger.d("Payment Error: $e");
      emit(state.copyWith(
        snackBarMessage: 'Ошибка оплаты. Попробуйте позже.',
        snackBarIsError: true,
      ));
    } finally {
      emit(state.copyWith(isProLoading: false));
    }
  }

  Future<void> deleteAccount() async {
    emit(state.copyWith(profileLoadingState: LoadingState.loading));
    try {
      // 1. Удаляем на сервере
      await _apiRepository.deleteAccount();

      // 2. Разлогиниваемся локально (чистим токены и стейт)
      await signOut();

      logger.d("Аккаунт успешно удален.");
    } catch (e) {
      logger.d("Ошибка удаления аккаунта: $e");
      emit(state.copyWith(profileLoadingState: LoadingState.error));
      // Можно показать ошибку, но лучше всё равно разлогинить, если токен протух
      // await signOut();
    }
  }

  Future<void> calculateDetailedHybridForecast() async {
    // Не блокируем повторный вызов, если пользователь хочет обновить (при ошибке)
    if (state.hybridForecastLoadingState == LoadingState.loading) return;

    emit(state.copyWith(hybridForecastLoadingState: LoadingState.loading));

    try {
      logger.d("[AppCubit] Запрашиваю гибридный прогноз с сервера...");

      // --- ИСПРАВЛЕНИЕ: Передаем текущий язык ---
      final lang = state.locale?.languageCode ?? 'ru';
      final forecast = await _apiRepository.getHybridForecast(lang: lang);

      logger.d("[AppCubit] Прогноз получен: ${forecast.personalDayNumber}");

      emit(state.copyWith(
        hybridForecast: forecast,
        hybridForecastLoadingState: LoadingState.success,
      ));
    } catch (e) {
      logger.e("[AppCubit] Ошибка загрузки гибридного прогноза: $e");
      emit(state.copyWith(hybridForecastLoadingState: LoadingState.error));
    }
  }

  Future<void> calculateHybridForecast() async {
    final profile = state.currentUserProfile;
    if (profile?.natalChart == null) return;

    // Проверяем, загружены ли тексты
    if (state.focusInterpretations.isEmpty) {
      await calculateFocusOfTheDay(); // Это загрузит focusInterpretations
    }
    if (state.numerologyNumberDescriptions.isEmpty) {
      await loadNumerologyNumberDescriptions();
    }

    try {
      // Считаем транзиты
      final rawTransits = await _chartCalculator.calculateTodaysTransits();
      // Преобразуем ключи enum в строки (если нужно)
      final Map<String, double> stringTransits =
          rawTransits.map((k, v) => MapEntry(k.name.toUpperCase(), v));

      final detailedForecast = HybridForecastCalculator.calculate(
        natalChart: profile!.natalChart!,
        userName: profile.name,
        date: DateTime.now(), // <-- Передаем дату
        currentTransits: stringTransits,
        interpretations:
            state.focusInterpretations, // <-- Передаем интерпретации
      );

      // 4. Конвертируем DetailedDailyForecast -> DailyHybridForecast
      // (чтобы сохранить совместимость с полем hybridForecast в AppState)

      final uiForecast = DailyHybridForecast(
        personalDayNumber: detailedForecast.personalDayNumber,

        // Объединяем советы нумерологии в один текст
        numerologyText:
            "${detailedForecast.numerologyGuidance}\n\n✅: ${detailedForecast.doList.join(', ')}",

        // Используем совет по знакомствам как астро-текст
        astrologyText: detailedForecast.meetingAdvice,

        // Транзит как финальный совет
        finalAdvice: detailedForecast.planetaryTransits.isNotEmpty
            ? "Акцент дня: ${detailedForecast.planetaryTransits.first.interpretation}"
            : "Спокойный день.",
      );

      emit(state.copyWith(
        hybridForecast: uiForecast, // <-- Теперь типы совпадают!
        hybridForecastLoadingState: LoadingState.success,
      ));
    } catch (e) {
      logger.d("Hybrid Forecast Error: $e");
    }
  }

  void _clearAllUserData({bool setInitialized = false}) {
    _chatsSubscription?.cancel();
    _notificationsSubscription?.cancel();

    // Создаем абсолютно новый пустой стейт, но с флагами готовности.
    // === ИСПРАВЛЕНИЕ ЗДЕСЬ ===
    emit(AppState(
        isInitialized: setInitialized,
        isReady: true, // <-- ДОБАВЬ ЭТУ СТРОКУ
        introSeen: state.introSeen,
        transitInterpretations: {} // <-- И ЭТУ, чтобы не забыть, что интро уже видели
        ));
  }

  Future<void> loadCommentsForPost(String postId) async {
    _commentsSubscription?.cancel(); // Старая подписка больше не нужна
    emit(state.copyWith(
        activePostComments: [], activePostStatus: ChannelStatus.loading));

    try {
      // Загружаем комментарии через наш новый API
      final comments = await _apiRepository.getComments(postId);
      emit(state.copyWith(
          activePostComments: comments,
          activePostStatus: ChannelStatus.success));
      // TODO: После этого шага нужно будет подписаться на WebSocket-события
      // типа 'new_comment_for_post_XXX'
    } catch (e) {
      logger.d("Ошибка загрузки комментариев через API: $e");
      emit(state.copyWith(activePostStatus: ChannelStatus.error));
    }
  }

  void onCommentsScreenClosed() {
    _commentsSubscription?.cancel();
    emit(state.copyWith(activePostComments: [], activePost: null));
  }

  Future<void> replyToComment({
    required String channelId,
    required String postId, // <-- ID поста у нас уже есть здесь!
    required String parentCommentId,
    required String parentAuthorName,
    required String text,
  }) async {
    final currentUser = state.currentUserProfile;
    if (currentUser == null) return;

    final newComment = Comment(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      postId: postId, // <-- 1. ВОТ ИСПРАВЛЕНИЕ! ПЕРЕДАЕМ ID ПОСТА.
      text: text,
      authorId: currentUser.id,
      authorName: currentUser.name,
      authorAvatarUrl: currentUser.avatar,
      createdAt:
          Timestamp.now(), // <-- Заменил на Timestamp, как в твоей модели
      replyToCommentId: parentCommentId,
      replyToAuthorName: parentAuthorName,
    );

    final previousComments = state.activePostComments;
    final updatedComments = List<Comment>.from(previousComments)
      ..add(newComment);
    emit(state.copyWith(activePostComments: updatedComments));

    try {
      Comment? parentComment;
      try {
        parentComment =
            previousComments.firstWhere((c) => c.id == parentCommentId);
      } catch (_) {
        parentComment = null;
      }
      final savedComment = await _apiRepository.postComment(
        postId: postId,
        text: text,
        replyTo: parentComment,
      );
      final merged = List<Comment>.from(previousComments)..add(savedComment);
      emit(state.copyWith(activePostComments: merged));
    } catch (e) {
      logger.d("Ошибка отправки комментария: $e");
      emit(state.copyWith(
        activePostComments: previousComments,
        snackBarMessage: 'Не удалось отправить комментарий. Попробуйте позже.',
        snackBarIsError: true,
      ));
    }
  }

  // Новый метод для добавления/удаления реакции
  Future<void> toggleCommentReaction({
    required String commentId,
    required String reaction, // Например, "👍"
  }) async {
    final currentUser = state.currentUserProfile;
    if (currentUser == null) return;

    logger.d(
        "CUBIT: Пытаюсь поставить/убрать реакцию '$reaction' на коммент $commentId");

    // Сохраняем копию для отката при ошибке API
    final previousComments = List<Comment>.from(state.activePostComments);
    final updatedComments = List<Comment>.from(previousComments);
    final commentIndex = updatedComments.indexWhere((c) => c.id == commentId);
    if (commentIndex == -1) return; // Комментарий не найден

    final comment = updatedComments[commentIndex];

    // Создаем копию реакций для изменения
    final newReactions = Map<String, List<String>>.from(comment.reactions);

    // Получаем список пользователей для этой реакции (или создаем новый)
    final reactionUsers = newReactions[reaction] ?? [];

    if (reactionUsers.contains(currentUser.id)) {
      // Если юзер уже ставил эту реакцию - убираем
      reactionUsers.remove(currentUser.id);
      if (reactionUsers.isEmpty) {
        // Если в списке больше никого нет, удаляем сам ключ реакции
        newReactions.remove(reaction);
      }
    } else {
      // Если не ставил - добавляем
      reactionUsers.add(currentUser.id);
      newReactions[reaction] = reactionUsers;
    }

    // Создаем новый объект комментария с обновленными реакциями
    final updatedComment = comment.copyWith(reactions: newReactions);

    // Заменяем старый комментарий на новый в списке
    updatedComments[commentIndex] = updatedComment;

    emit(state.copyWith(activePostComments: updatedComments));

    try {
      await _apiRepository.toggleReaction(
        entityType: 'comment',
        entityId: commentId,
        emoji: reaction,
      );
    } catch (e) {
      logger.d("Ошибка сохранения реакции на комментарий: $e");
      emit(state.copyWith(
        activePostComments: previousComments,
        snackBarMessage: 'Не удалось обновить реакцию. Попробуйте позже.',
        snackBarIsError: true,
      ));
    }
  }

  // --- Админские функции ---

  Future<void> deleteComment({
    required String channelId,
    required String postId,
    required String commentId,
  }) async {
    // 1. Проверить, является ли текущий пользователь админом
    if (state.currentUserProfile?.role != 'admin') return;

    // 2. Вызвать функцию на бэкенде для удаления комментария
    // 3. При успехе - удалить комментарий из state.activePostComments и сделать emit()
  }

  Future<void> banUser(
      {required String userId, required bool shouldBan}) async {
    if (state.currentUserProfile?.role != 'admin') return;

    // Вызвать функцию на бэкенде, которая обновит поле is_banned в профиле пользователя
    // Можно также добавить логику удаления всех комментариев пользователя, если нужно
  }

  // ===== ДОБАВЬТЕ НОВЫЙ МЕТОД =====
  Future<void> loadHybridForecast({bool forceSchedule = false}) async {
    if (state.hybridForecastLoadingState == LoadingState.loading &&
        !forceSchedule) return;
    emit(state.copyWith(hybridForecastLoadingState: LoadingState.loading));

    try {
      // --- 👇 ИСПРАВЛЕНИЕ ЗДЕСЬ 👇 ---
      // 1. Берем ЛИЧНЫЙ нумерологический отчет из профиля
      final numerologyReport = state.currentUserProfile?.numerologyData;
      var astroForecast = state.dailyForecast;

      if (astroForecast == null) {
        await loadDailyForecast();
        astroForecast = state.dailyForecast;
      }

      // 2. Проверяем, что оба отчета есть
      if (numerologyReport == null || astroForecast == null) {
        throw Exception(
            "Не удалось получить все данные (нумерология или астрология) для гибридного прогноза.");
      }

      final numerologyForecasts =
          await _apiRepository.getNumerologyForecasts('ru');
      // 3. Обращаемся к правильному полю personalDay
      final dayNumber = numerologyReport.personalDay.number;
      final numerologyText = numerologyForecasts['day_$dayNumber'] ??
          "Описание для вашего числа дня не найдено.";
      // --- 👆 КОНЕЦ ИСПРАВЛЕНИЯ 👆 ---

      final finalAdvice = "Совет дня: ${astroForecast.summary}";
      final forecast = DailyHybridForecast(
        personalDayNumber: dayNumber,
        numerologyText: numerologyText,
        astrologyText: "Астрологическая погода: ${astroForecast.summary}",
        finalAdvice: finalAdvice,
      );

      emit(state.copyWith(
        hybridForecast: forecast,
        hybridForecastLoadingState: LoadingState.success,
      ));

      // --- ЛОГИКА ПЛАНИРОВАНИЯ УВЕДОМЛЕНИЯ ---
      final bool notificationsEnabled =
          state.currentUserProfile?.settings?.notifications?.hybridForecast ??
              true;
      if (notificationsEnabled || forceSchedule) {
        _scheduler?.scheduleDailyNotification(
          id: 3,
          title: '🚀 Ваш персональный космо-прогноз',
          body: forecast.finalAdvice,
          hour: 9,
          minute: 10,
        );
      } else {
        logger.d(
            "Уведомления о 'Гибридном прогнозе' отключены. Планирование пропущено.");
      }
    } catch (e) {
      logger.d("❌ Ошибка при создании гибридного прогноза: $e");
      emit(state.copyWith(hybridForecastLoadingState: LoadingState.error));
    }
  }
  // ====================================

  // === МЕТОДЫ ДЛЯ ПОИСКА И НАСТРОЕК КАНАЛОВ ===

  // Поиск каналов
  Future<List<Channel>> searchChannels(String query) async {
    return await _apiRepository.searchChannels(query);
  }

  // Обновление описания канала
  Future<void> updateChannelDescription(
      String channelId, String newDescription) async {
    // TODO: Определять язык пользователя
    await _apiRepository.updateChannelField(
        channelId, 'description.ru', newDescription);
  }

  // Переключение приватности
  Future<void> toggleChannelPrivacy(Channel channel) async {
    // ========== НАЧАЛО ИСПРАВЛЕНИЯ ==========
    // Объявляем переменную `channelId` и получаем ее значение из объекта `channel`
    final String channelId = channel.id.toString();
    // =====================================

    final newStatus = !channel.isPrivate;
    String? newInviteKey = channel.inviteKey;
    if (newStatus && newInviteKey == null) {
      // Генерируем ключ, если канал становится приватным впервые
      newInviteKey =
          'Aryonika-${const Uuid().v4().substring(0, 4).toUpperCase()}';
    }

    // Теперь переменная `channelId` существует, и эти вызовы будут работать
    await _apiRepository.updateChannelField(channelId, 'isPrivate', newStatus);
    await _apiRepository.updateChannelField(
        channelId, 'inviteKey', newInviteKey);
  }

  // === МЕТОДЫ ДЛЯ НАСТРОЕК КАНАЛА ===

  // Метод `updateChannelDescription` у нас уже есть
  // Метод `toggleChannelPrivacy` у нас уже есть

  // Обновление аватара канала
  Future<void> updateChannelAvatar(String channelId, String imageBase64) async {
    final dataUriString = 'data:image/jpeg;base64,$imageBase64';
    await _apiRepository.updateChannelField(
        channelId, 'avatarUrl', dataUriString);
    // UI обновится автоматически благодаря Stream'у в onChannelDetailScreenOpened
  }

  // Загрузка заблокированных пользователей
  Future<List<UserProfileCard>> getBannedUsers(String channelId) async {
    try {
      // Теперь это один простой вызов!
      return await _apiRepository.getBannedUsers(channelId);
    } catch (e) {
      logger.d("Ошибка загрузки забаненных пользователей: $e");
      return [];
    }
  }

  Future<void> calculateFocusOfTheDay({bool forceSchedule = false}) async {
    final todayString = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString('focus_of_the_day');

    if (cachedData != null) {
      final focus = FocusOfTheDay.fromJson(json.decode(cachedData));
      if (focus.date == todayString && !forceSchedule) {
        logger.d(
            "✅ Фокус Дня на $todayString загружен из кэша (уведомление не перепланируется).");
        emit(state.copyWith(
            focusOfTheDay: focus, focusLoadingState: LoadingState.success));
        return;
      }
    }

    final profile = state.currentUserProfile;
    if (profile?.natalChart == null) return;
    final natalChart = profile!.natalChart!;

    emit(state.copyWith(focusLoadingState: LoadingState.loading));

    try {
      Map<String, dynamic> interpretations = state.focusInterpretations;
      if (interpretations.isEmpty) {
        interpretations = await _apiRepository.getFocusDayInterpretations();
        if (interpretations.isEmpty) throw Exception("Тексты не загружены");
      }

      final transits = await _chartCalculator.calculateTodaysTransits();
      final moonPosition = transits[Planet.MOON];
      if (moonPosition == null)
        throw Exception("Не удалось рассчитать позицию Луны");

      final houseNumber = AstroUtils.getHouseForPosition(
        moonPosition,
        natalChart.houseCusps ?? const {},
      );
      logger.d(
          "🔮 ФОКУС ДНЯ: Транзитная Луна в ${moonPosition.toStringAsFixed(2)}°, попадает в ${houseNumber}-й дом.");

      final houseKey = 'HOUSE_$houseNumber';
      final lang = 'ru';
      final housesMap =
          interpretations['houses'] as Map<String, dynamic>? ?? {};
      final adviceMap =
          interpretations['advice'] as Map<String, dynamic>? ?? {};

      final title = housesMap[houseKey]?['title']?[lang] ?? "Сфера дня";
      final text =
          housesMap[houseKey]?['text']?[lang] ?? "Описание не найдено.";
      final advice = adviceMap[houseKey]?['text']?[lang];

      final focus = FocusOfTheDay(
          title: title, text: text, advice: advice, date: todayString);
      await prefs.setString('focus_of_the_day', json.encode(focus.toJson()));

      emit(state.copyWith(
        focusOfTheDay: focus,
        focusInterpretations: interpretations,
        focusLoadingState: LoadingState.success,
      ));
      logger.d("✅ Фокус Дня рассчитан и сохранен в кэш.");
      // === ДОБАВЬ ЭТОТ БЛОК ===
      try {
        if (profile != null) {
          // Используем наш универсальный метод, который работает через API!
          await updateUserProfile({
            'focusOfTheDay': focus.toJson(),
          });
          logger.d("✅ Фокус Дня также сохранен в PostgreSQL через API.");
        }
      } catch (e) {
        logger.d("⚠️ Не удалось сохранить Фокус Дня через API: $e");
      }
// ========================

      // ================== НАЧАЛО ИЗМЕНЕНИЯ ==================
      // Планируем уведомление после успешного расчета
      _scheduler?.scheduleDailyNotification(
        id: 2, // Уникальный ID для "Фокуса дня"
        title: '🔮 Фокус Дня: $title',
        body: text.length > 150
            ? '${text.substring(0, 150)}...'
            : text, // Обрезаем длинный текст
        hour: 9,
        minute: 5, // Отправляем в 9:05 утра
      );
      final bool notificationsEnabled =
          state.currentUserProfile?.settings?.notifications?.focusOfTheDay ??
              true;
      if (notificationsEnabled || forceSchedule) {
        _scheduler?.scheduleDailyNotification(
          id: 2,
          title: '🔮 Фокус Дня: $title',
          body: text.length > 150 ? '${text.substring(0, 150)}...' : text,
          hour: 9,
          minute: 5,
        );
      } else {
        logger
            .d("Уведомления о 'Фокусе Дня' отключены. Планирование пропущено.");
      }
      // =================== КОНЕЦ ИЗМЕНЕНИЯ ===================
    } catch (e) {
      logger.d("❌ Ошибка расчета 'Фокуса Дня': $e");
      emit(state.copyWith(focusLoadingState: LoadingState.error));
    }
  }

  // lib/cubit/app_cubit.dart

  void handleFeedEventAction(BuildContext context, FeedEvent event) {
    logger
        .d("--- CUBIT: Обработка действия для события типа ${event.type} ---");
    final isPro = state.isProUser;

    // Список типов событий, которые требуют PRO
    final proEvents = [
      'CARD_OF_THE_DAY',
      'SHARED_CARD_OF_THE_DAY',
      'FOCUS_OF_THE_DAY',
      'COMPATIBILITY_PEAK', // Если это тоже платно
      'ORBIT_CROSSING' // И это
    ];

    if (proEvents.contains(event.type) && !isPro) {
      // Если событие платное, а юзер не PRO -> ПЕЙВОЛЛ
      context.push('/paywall');
      return;
    }

    // --- ЕСЛИ ЮЗЕР PRO (ИЛИ СОБЫТИЕ БЕСПЛАТНОЕ) ---

    if (event.type == 'CARD_OF_THE_DAY') {
      // Переключаем таб оракула на Карту Дня
      // Если у тебя есть такое поле в стейте для управления табами
      // Или просто переходим, если OracleScreen сам читает аргументы
      context.push('/oracle?focus=cardOfTheDay');
      // В OracleScreen нужно добавить логику:
      // if (пришли_из_ленты_с_типом_card) _currentFocus = OracleFocus.cardOfTheDay;
      return;
    }

    final path = event.actionPath;
    if (path == null || path.isEmpty) {
      logger.d("--- CUBIT: Действие не выполнено, т.к. actionPath пуст.");
      return;
    }

    Object? extraData;

    switch (event) {
      // --- Группа 1: События с "Ледоколом" ---
      case final CompatibilityPeakEvent compatEvent:
        extraData = compatEvent.iceBreakerMessage;
        logger.d("--- CUBIT: Переход в чат с ледоколом (Пик Совместимости)...");
        break;

      case final OrbitCrossingEvent orbitEvent:
        extraData = orbitEvent.iceBreakerMessage;
        logger.d("--- CUBIT: Переход в чат с ледоколом (Пересечение Орбит)...");
        break;

      case final SpiritualNeighborEvent neighborEvent:
        // --- 👇 ДОБАВЬ ЭТОТ ЛОГ 👇 ---
        logger.d(
            "--- DEBUG ICEBREAKER: Получен ледокол: '${neighborEvent.iceBreakerMessage}' ---");
        extraData = neighborEvent.iceBreakerMessage;
        logger.d("--- CUBIT: Переход в чат с ледоколом (Духовный Сосед)...");
        break;

      // --- Группа 2: События для группового чата ---
      case final SharedCardEvent sharedCardEvent:
        extraData = {
          'isGroupChat': true,
          'participantIds': sharedCardEvent.participants,
          'groupTitle': sharedCardEvent.chatTitle,
        };
        logger.d("--- CUBIT: Переход во временный групповой чат...");
        break;

      // --- 👇 ИСПРАВЛЕНИЕ ЗДЕСЬ 👇 ---
      // Разделяем блок на два, чтобы избежать ошибки `invalid_pattern_variable_in_shared_case_scope`

      // Блок для событий с уникальными классами, но без extra
      case PartnerOfTheDayEvent():
      case NewChannelSuggestionEvent():
      case PopularPostEvent():
        extraData = null;
        logger.d(
            "--- CUBIT: Простое действие навигации для типа '${event.type}', без extra данных.");
        break;

      // Блок для "простых" событий, которые мы определяем по строковому типу
      case final FeedEvent e
          when e.type == 'GEOMAGNETIC_STORM' ||
              e.type == 'NEW_LIKE' ||
              e.type == 'CARD_OF_THE_DAY' ||
              e.type == 'HOUSE_ACTIVATION':
        extraData = null;
        logger.d(
            "--- CUBIT: Простое действие навигации для типа '${e.type}', без extra данных.");
        break;
    }

    // Выполняем навигацию
    Future.microtask(() {
      if (context.mounted) {
        context.push(path, extra: extraData);
      }
    });
  }

  Future<List<CosmicWebUser>> fetchCosmicWebUsers({
    required String gender,
    required int minAge,
    required int maxAge,
  }) async {
    // Просто вызываем метод из нашего нового репозитория.
    // Вся логика с токенами, URL, заголовками и обработкой ошибок теперь там.
    return _apiRepository.fetchCosmicWebData(
      gender: gender,
      minAge: minAge,
      maxAge: maxAge,
    );
  }

// === НОВЫЕ МЕТОДЫ ДЛЯ ЭКРАНА КАНАЛА ===

  // Вызывается в initState экрана ChannelDetailScreen
  Future<void> onChannelDetailScreenOpened(String channelId) async {
    // 1. Отменяем старые подписки, если они были (на всякий случай)
    _activeChannelSubscription?.cancel();
    _activeChannelPostsSubscription?.cancel();

    // 2. Сбрасываем состояние и показываем загрузку
    emit(state.copyWith(
      activeChannel: null,
      activeChannelPosts: [],
      isLoadingPosts: true, // Используем один флаг загрузки
    ));
    logger.d(
        "CUBIT (Детали канала): Экран открыт для ID: $channelId. Загружаю данные через API...");

    try {
      // 3. Загружаем данные о канале и посты ПАРАЛЛЕЛЬНО
      final results = await Future.wait([
        _apiRepository.getChannelDetails(channelId), // Результат 0: Канал
        _apiRepository.getPosts(channelId), // Результат 1: Посты
      ]);

      final channel = results[0] as Channel?;
      final posts = results[1] as List<Post>;

      if (channel != null) {
        logger.d(
            "CUBIT (Детали канала): ✅ Данные успешно загружены. Канал: '${channel.getLocalizedName('ru')}', Постов: ${posts.length}");
        // 4. Обновляем state ОДИН РАЗ со всеми данными
        emit(state.copyWith(
          activeChannel: channel,
          activeChannelPosts: posts,
          isLoadingPosts: false, // Выключаем индикатор
        ));
      } else {
        logger.d("CUBIT (Детали канала): ⚠️ Канал с ID $channelId не найден.");
        emit(state.copyWith(isLoadingPosts: false));
      }
    } catch (e) {
      logger.d("CUBIT (Детали канала): ❌ ОШИБКА при загрузке данных: $e");
      emit(state.copyWith(isLoadingPosts: false));
    }
  }

  // Вызывается в dispose экрана ChannelDetailScreen
  void onChannelDetailScreenClosed() {
    _activeChannelSubscription?.cancel();
    _activeChannelPostsSubscription?.cancel();
    // Очищаем данные, чтобы при следующем входе не было "мелькания" старого контента
    emit(state.copyWith(activeChannel: null, activeChannelPosts: []));
  }

  // Вызывается по нажатию кнопки "Подписаться/Отписаться"
  void toggleSubscription(String channelId, bool isCurrentlySubscribed) {
    final userId = state.currentUserProfile?.id;
    if (userId == null) return;

    // Оптимистичное обновление UI. Мы не ждем ответа от сервера,
    // а сразу обновляем состояние. UI перерисуется мгновенно.
    final currentProfile = state.currentUserProfile!;
    final currentSubscriptions =
        List<String>.from(currentProfile.subscribedChannelIds);
    if (isCurrentlySubscribed) {
      currentSubscriptions.remove(channelId);
    } else {
      currentSubscriptions.add(channelId);
    }
    final updatedProfile =
        currentProfile.copyWith(subscribedChannelIds: currentSubscriptions);
    emit(state.copyWith(currentUserProfile: updatedProfile));

    // В фоновом режиме отправляем запрос в Firestore
    _apiRepository
        .toggleSubscription(userId, channelId, isCurrentlySubscribed)
        .catchError((e) {
      logger.d("Ошибка подписки/отписки: $e");
      emit(state.copyWith(
        currentUserProfile: currentProfile,
        snackBarMessage: 'Не удалось подписаться. Попробуйте позже.',
        snackBarIsError: true,
      ));
    });
  }

  /// Очищает сообщение глобального SnackBar после показа (вызывается из UI).
  void clearSnackBarMessage() {
    emit(state.copyWith(clearSnackBar: true));
  }

  // Не забываем добавить отписки в главный метод close()
  @override
  Future<void> close() {
    WidgetsBinding.instance.removeObserver(this);
    _locationUpdateTimer?.cancel();
    _geomagneticTimer?.cancel();

    _chatsSubscription?.cancel();
    _authStateSubscription?.cancel();
    _channelsSubscription?.cancel();
    _postsSubscription?.cancel();
    _commentsSubscription?.cancel();
    _activeChannelSubscription?.cancel();
    _activeChannelPostsSubscription?.cancel();
    _searchDebounce?.cancel();

    // === НАЧАЛО ИСПРАВЛЕНИЯ ===
    _linkSubscription?.cancel(); // <-- ДОБАВЬ ЭТУ СТРОКУ
    // === КОНЕЦ ИСПРАВЛЕНИЯ ===

    // и т.д. для всех подписок
    return super.close();
  }

  Future<void> _loadAstroDescriptions({bool forceReload = false}) async {
    if (state.astroDescriptions.isNotEmpty && !forceReload) return;

    final lang = currentLocale.languageCode;
    logger.d("CUBIT: Загружаю астро-описания для языка '$lang'...");
    try {
      final descriptions =
          await _apiRepository.getAstroDescriptions(lang: lang);
      if (descriptions.isNotEmpty) {
        emit(state.copyWith(astroDescriptions: descriptions));
        logger.d("CUBIT: ✅ Астро-описания успешно загружены.");
      }
    } catch (e) {
      logger.d("CUBIT: ❌ Ошибка загрузки астро-описаний: $e");
    }
  }

  Future<void> loadDailyForecast() async {
    if (state.dailyForecastLoadingState == LoadingState.loading) return;
    emit(state.copyWith(dailyForecastLoadingState: LoadingState.loading));

    try {
      final lang = state.locale?.languageCode ?? 'ru';
      // Просто вызываем один метод!
      final forecast = await _apiRepository.getDailyForecast(lang: lang);

      emit(state.copyWith(
          dailyForecast: forecast,
          dailyForecastLoadingState: LoadingState.success));
    } catch (e) {
      logger.d("❌ Ошибка загрузки дневного прогноза с сервера: $e");
      emit(state.copyWith(dailyForecastLoadingState: LoadingState.error));
    }
  }

  // lib/cubit/app_cubit.dart

  Future<void> sendMessage({
    required String chatId,
    required String recipientId,
    required String text,
  }) async {
    final currentUser = state.currentUserProfile;
    if (currentUser == null || text.trim().isEmpty) return;

    final tempId = 'temp_${const Uuid().v4()}';
    final now = DateTime.now();

    // 1. Создаем оптимистичное сообщение
    final optimisticMessage = chat_models.Message(
      id: tempId,
      clientTempId: tempId,
      chatId: chatId,
      senderId: currentUser.id,
      recipientId: recipientId,
      text: text.trim(),
      createdAt: now,
      isRead: false, // Явно false
    );

    // 2. Обновляем UI ВНУТРИ чата (activeChatMessages)
    // Используем insert(0, ...), так как ListView обычно reverse: true
    final updatedMessages =
        List<chat_models.Message>.from(state.activeChatMessages)
          ..insert(0, optimisticMessage);

    // 3. 🔥 ГЛАВНОЕ: Обновляем СПИСОК чатов (chatListItems)
    final currentChatList = List<ChatListItem>.from(state.chatListItems);
    final chatIndex = currentChatList.indexWhere((c) => c.chatId == chatId);

    if (chatIndex != -1) {
      // Чат уже есть в списке -> обновляем текст и время, поднимаем наверх
      final oldItem = currentChatList[chatIndex];
      final newItem = oldItem.copyWith(
        lastMessage: text.trim(),
        lastMessageTimestamp: now,
        lastMessageSenderId: currentUser.id,
        unreadCount: 0, // Я отправил, значит для меня 0
      );

      currentChatList.removeAt(chatIndex);
      currentChatList.insert(0, newItem);
    }

    // 4. Эмитим ОБА обновления сразу
    emit(state.copyWith(
      activeChatMessages: updatedMessages,
      chatListItems: currentChatList,
    ));

    try {
      // 5. Отправка на сервер
      await _apiRepository.sendMessage(
        chatId: chatId,
        senderId: currentUser.id,
        recipientId: recipientId,
        text: optimisticMessage.text,
        clientTempId: optimisticMessage.clientTempId,
        senderProfile: currentUser,
      );
    } catch (e) {
      logger.d("❌ Ошибка отправки сообщения: $e");
      // Откат UI в случае ошибки
      emit(state.copyWith(
        activeChatMessages:
            state.activeChatMessages.where((msg) => msg.id != tempId).toList(),
        // Откат списка чатов можно не делать, это не так критично,
        // или можно перезагрузить список: loadInitialChatList();
      ));
    }
  }

// В AppCubit
  Future<void> deleteChatFromList(String chatId) async {
    // 1. Оптимистичное удаление из списка
    final updatedList = List<ChatListItem>.from(state.chatListItems)
      ..removeWhere((item) => item.chatId == chatId);

    emit(state.copyWith(chatListItems: updatedList));

    try {
      // 2. Запрос на сервер
      await _apiRepository.deleteChat(chatId);
    } catch (e) {
      logger.d("Ошибка удаления чата: $e");
      // Можно вернуть чат обратно в список, если ошибка, но обычно это не критично
      loadInitialChatList(); // Перезагрузим список с сервера
    }
  }

// ==========================================================
  // === НОВЫЙ МЕТОД ДЛЯ ОТПРАВКИ ЖАЛОБЫ ===
  Future<void> submitReport({
    required String reportedUserId,
    required String reason,
    required String details,
    String? contentId,
    String contentType = 'profile',
  }) async {
    final reporter = state.currentUserProfile;
    if (reporter == null) {
      logger.d("❌ CUBIT_REPORT: ОТМЕНА. Пользователь не авторизован.");
      return;
    }

    final reportData = <String, dynamic>{
      'reporterId': reporter.id,
      'reporterName': reporter.name,
      'reportedUserId': reportedUserId,
      'reason': reason,
      'details': details.trim(),
      'contentType': contentType,
      'status': 'pending',
      'createdAt': FieldValue.serverTimestamp(),
      if (contentId != null) 'contentId': contentId,
    };

    logger.d(
        "✅ CUBIT_REPORT: Данные для жалобы сформированы. Вызываю репозиторий...");

    try {
      await _apiRepository.createReport(reportData);
      logger.d("✅ CUBIT_REPORT: УСПЕХ! Репозиторий отработал без ошибок.");
    } catch (e) {
      logger.d(
          "❌ CUBIT_REPORT: КРИТИЧЕСКАЯ ОШИБКА! Репозиторий вернул ошибку: $e");
      emit(state.copyWith(
        snackBarMessage: 'Не удалось отправить жалобу. Попробуйте позже.',
        snackBarIsError: true,
      ));
    } finally {
      logger.d("🏁 CUBIT_REPORT: Блок try-catch-finally завершен.");
    }
  }
  // ==========================================================

  Future<void> _loadAstroCommunicationTips() async {
    // Защита от повторной загрузки (оставляем)
    if (state.astroCommunicationTips.isNotEmpty) {
      return;
    }

    final languageCode =
        WidgetsBinding.instance.platformDispatcher.locale.languageCode;
    logger.d("ASTRO TIPS: Запускаю загрузку для языка '$languageCode'.");

    var tips = await _apiRepository.getAstroCommunicationTips(languageCode);

    if (tips.isEmpty) {
      logger.d(
          "ASTRO TIPS: ⚠️ Советы для '$languageCode' не найдены. Пытаюсь загрузить 'en'.");
      tips = await _apiRepository.getAstroCommunicationTips('en');
    }

    if (tips.isNotEmpty) {
      logger.d("ASTRO TIPS: ✅ Советы загружены. Вызываю emit с copyWith.");
      // ИСПОЛЬЗУЕМ СТАНДАРТНЫЙ И ПРАВИЛЬНЫЙ copyWith
      emit(state.copyWith(
        astroCommunicationTips: tips,
      ));
    } else {
      logger.d("ASTRO TIPS: ❌ Не удалось загрузить советы.");
    }
  }

  /// Возвращает null в случае успеха или строку с ошибкой в случае неудачи.
  Future<String?> updatePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    if (newPassword.length < 6) {
      return "Новый пароль должен быть не менее 6 символов.";
    }

    final user = auth.currentUser;
    final email = user?.email;

    if (user == null || email == null) {
      return "Ошибка: не удалось определить текущего пользователя.";
    }

    // Создаем учетные данные для ре-аутентификации
    final cred =
        EmailAuthProvider.credential(email: email, password: currentPassword);

    try {
      // 1. Сначала пытаемся ре-аутентифицироваться
      await user.reauthenticateWithCredential(cred);

      // 2. Если успешно, меняем пароль
      await user.updatePassword(newPassword);

      logger.d("✅ Пароль успешно изменен.");
      return null; // Успех
    } on FirebaseAuthException catch (e) {
      logger.d("❌ Ошибка смены пароля: ${e.code}");
      if (e.code == 'wrong-password') {
        return 'Неверный текущий пароль.';
      } else if (e.code == 'weak-password') {
        return 'Новый пароль слишком слабый.';
      } else {
        return 'Произошла ошибка: ${e.message}';
      }
    } catch (e) {
      return 'Произошла неизвестная ошибка.';
    }
  }

  /// Возвращает null в случае успеха или строку с ошибкой в случае неудачи.

  // lib/cubit/app_cubit.dart

  Future<void> loadNumerologyCompatibility({bool forceReload = false}) async {
    if (state.numerologyCompatibility.isNotEmpty && !forceReload) return;

    logger.d(
        "NUMEROLOGY (API): Запрашиваю описания совместимости для языка '${currentLocale.languageCode}'...");
    try {
      final descriptions = await _apiRepository.getNumerologyCompatibility(
          lang: currentLocale.languageCode);
      emit(state.copyWith(numerologyCompatibility: descriptions));
      if (descriptions.isNotEmpty) {
        logger.d("NUMEROLOGY (API): ✅ Описания нумерологии успешно загружены.");
      }
    } catch (e) {
      logger.d("❌ Ошибка загрузки нумерологических описаний: $e");
    }
  }

  Future<void> loadNumerologyNumberDescriptions(
      {bool forceReload = false}) async {
    // Если уже загружено и не просят форсировать - выходим
    if (state.numerologyNumberDescriptions.isNotEmpty && !forceReload) return;

    try {
      final lang = currentLocale.languageCode;
      logger.d(
          "🌍 [Cubit] Запрашиваю описания нумерологии для языка: '$lang' (FORCE: $forceReload)");

      final descriptions =
          await _apiRepository.getNumerologyNumberDescriptions(lang: lang);

      if (descriptions.isNotEmpty) {
        emit(state.copyWith(numerologyNumberDescriptions: descriptions));
        logger.d("✅ [Cubit] Ключи: ${descriptions.keys.toList()}");
        logger.d(
            "✅ [Cubit] Описания чисел обновлены: ${descriptions.length} ключей.");
      } else {
        logger.d("⚠️ [Cubit] Сервер вернул пустоту. Оставляю старые данные.");
        // Мы НЕ делаем emit с пустым списком! Оставляем то, что было.
      }
    } catch (e) {
      logger.d("❌ [Cubit] Ошибка загрузки описаний: $e");
      // При ошибке мы тоже НЕ сбрасываем данные в пустоту.
      // Просто логируем. Пользователь увидит старые данные (если были) или сможет обновить через Pull-to-Refresh.
    }
  }

  Future<void> loadPalmistryData() async {
    // Не загружаем повторно, если данные уже есть
    if (state.palmistryData != null ||
        state.palmistryLoadingState == LoadingState.loading) {
      return;
    }

    emit(state.copyWith(palmistryLoadingState: LoadingState.loading));

    try {
      // TODO: Определить язык пользователя
      final lang = 'ru';
      final data = await _apiRepository.getPalmistryInterpretations(lang);

      if (data != null) {
        emit(state.copyWith(
          palmistryData: data,
          palmistryLoadingState: LoadingState.success,
        ));
      } else {
        throw Exception("Данные по хиромантии не были загружены.");
      }
    } catch (e) {
      logger.d("Ошибка в AppCubit.loadPalmistryData: $e");
      emit(state.copyWith(palmistryLoadingState: LoadingState.error));
    }
  }

  Future<void> savePalmistryResults(Map<String, String> userChoices) async {
    final userId = state.currentUserProfile?.id;
    final palmData = state.palmistryData;
    if (userId == null || palmData == null) return;

    // Извлекаем "теги" из выбранных пользователем опций
    final List<String> traits = [];
    userChoices.forEach((lineKey, optionKey) {
      final tag = palmData.lines[lineKey]?.options[optionKey]?.strengthTag;
      if (tag != null && tag.isNotEmpty) {
        traits.add(tag);
      }
    });

    try {
      await _apiRepository.savePalmistryResults(
        userId: userId,
        userChoices: userChoices,
        traits:
            traits.toSet().toList(), // toSet().toList() для удаления дубликатов
      );

      // Оптимистичное обновление стейта, чтобы UI сразу отреагировал
      final updatedProfile = state.currentUserProfile?.copyWith(
        palmistryData: userChoices,
        palmistryTraits: traits.toSet().toList(),
      );
      emit(state.copyWith(currentUserProfile: updatedProfile));
    } catch (e) {
      logger.d("Ошибка сохранения результатов хиромантии: $e");
      emit(state.copyWith(
        snackBarMessage: 'Не удалось сохранить анализ. Попробуйте позже.',
        snackBarIsError: true,
      ));
    }
  }

  Future<void> setShowPalmistryInProfile(bool show) async {
    final userId = state.currentUserProfile?.id;
    if (userId == null) return;

    // Оптимистичное обновление UI
    final updatedProfile =
        state.currentUserProfile?.copyWith(showPalmistryInProfile: show);
    emit(state.copyWith(currentUserProfile: updatedProfile));

    try {
      // Отправка в фоне
      await _apiRepository.setShowPalmistryInProfile(userId, show);
    } catch (e) {
      // Откат в случае ошибки
      final revertedProfile =
          state.currentUserProfile?.copyWith(showPalmistryInProfile: !show);
      emit(state.copyWith(currentUserProfile: revertedProfile));
      logger.d("Ошибка обновления showPalmistryInProfile: $e");
    }
  }

  // === ДОБАВЬ ЭТОТ НОВЫЙ ПРИВАТНЫЙ МЕТОД В AppCubit ===
  Future<void> _updateNewLikesCount(UserProfileCard profile) async {
    final prefs = await SharedPreferences.getInstance();
    // Получаем ID тех, кого мы уже "видели"
    final seenLikes = prefs.getStringList('seen_likes_ids') ?? [];

    // Получаем ВСЕХ, кто нас лайкнул, из свежего профиля
    final allLikes = profile.likedByUsers;

    // Считаем количество "новых" лайков
    final newLikesCount =
        allLikes.where((id) => !seenLikes.contains(id)).length;

    // Обновляем стейт. Убедись, что в AppState есть поле `int newLikesCount`.
    emit(state.copyWith(newLikesCount: newLikesCount));
  }

  // === ДОБАВЬ ЭТОТ ПУБЛИЧНЫЙ МЕТОД В AppCubit ===
  Future<void> markLikesAsSeen() async {
    // 1. Сбрасываем счетчик в UI немедленно
    emit(state.copyWith(newLikesCount: 0));

    // 2. В фоне обновляем SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    // Записываем ВЕСЬ текущий список лайков как "просмотренный"
    await prefs.setStringList(
        'seen_likes_ids', state.currentUserProfile?.likedByUsers ?? []);
  }

  Future<void> loadFriendsData() async {
    final userId = state.currentUserProfile?.id;
    if (userId == null) return;

    emit(state.copyWith(isLoadingFriends: true));
    try {
      // 1. ApiRepository по-прежнему возвращает Map<String, dynamic>
      final friendsData = await _apiRepository.getFriendsAndRequests(userId);

      // --- 👇 ВОТ ГЛАВНОЕ ИСПРАВЛЕНИЕ 👇 ---

      // 2. Безопасно извлекаем списки и проверяем, что они не null
      final List<dynamic> friendsJson = friendsData['friends'] ?? [];
      final List<dynamic> requestsJson = friendsData['requests'] ?? [];

      // 3. ЯВНО преобразуем List<dynamic> в List<UserProfileCard>
      // Мы "проходим" по каждому элементу (json) в списке и создаем из него UserProfileCard
      final List<UserProfileCard> friendsList = friendsJson
          .map((json) => UserProfileCard.fromJson(json as Map<String, dynamic>))
          .toList();

      final List<UserProfileCard> requestsList = requestsJson
          .map((json) => UserProfileCard.fromJson(json as Map<String, dynamic>))
          .toList();

      // 4. Безопасно извлекаем карту статусов
      final Map<String, FriendshipStatus> statusMap =
          (friendsData['statusMap'] as Map<String, dynamic>? ?? {}).map((key,
                  value) =>
              MapEntry(key, FriendshipStatus.values.byName(value.toString())));

      // --- 👆 КОНЕЦ ИСПРАВЛЕНИЯ 👆 ---

      // 5. Теперь передаем в emit списки с ПРАВИЛЬНЫМ типом
      emit(state.copyWith(
        friends: friendsList,
        friendRequests: requestsList,
        friendshipStatusMap: statusMap,
        isLoadingFriends: false,
      ));
    } catch (e, s) {
      logger.e("Ошибка загрузки данных о друзьях", error: e, stackTrace: s);
      emit(state.copyWith(isLoadingFriends: false));
    }
  }

  Future<void> sendFriendRequest(String recipientId) async {
    final senderId = state.currentUserProfile?.id;
    if (senderId == null) return;

    // Оптимистичное обновление UI
    final newStatusMap =
        Map<String, FriendshipStatus>.from(state.friendshipStatusMap);
    newStatusMap[recipientId] = FriendshipStatus.requestSent;
    emit(state.copyWith(friendshipStatusMap: newStatusMap));

    try {
      await _apiRepository.sendFriendRequest(senderId, recipientId);
      // Здесь можно отправить push-уведомление
    } catch (e) {
      // Откат UI в случае ошибки
      newStatusMap.remove(recipientId);
      emit(state.copyWith(friendshipStatusMap: newStatusMap));
      logger.d("Ошибка отправки заявки в друзья: $e");
    }
  }

  Future<void> acceptFriendRequest(UserProfileCard requester) async {
    final currentUserId = state.currentUserProfile?.id;
    if (currentUserId == null) return;

    // Оптимистичное обновление UI
    final newRequests = List<UserProfileCard>.from(state.friendRequests)
      ..removeWhere((u) => u.id == requester.id);
    final newFriends = List<UserProfileCard>.from(state.friends)
      ..add(requester);
    final newStatusMap =
        Map<String, FriendshipStatus>.from(state.friendshipStatusMap);
    newStatusMap[requester.id] = FriendshipStatus.friends;
    emit(state.copyWith(
      friendRequests: newRequests,
      friends: newFriends,
      friendshipStatusMap: newStatusMap,
    ));

    try {
      await _apiRepository.acceptFriendRequest(currentUserId, requester.id);
    } catch (e) {
      // Откат UI
      loadFriendsData(); // Проще всего просто перезагрузить данные
      logger.d("Ошибка принятия заявки: $e");
    }
  }

  Future<void> removeOrDeclineFriend(String otherUserId) async {
    final currentUserId = state.currentUserProfile?.id;
    if (currentUserId == null) return;

    // Оптимистичное обновление UI
    final newRequests = List<UserProfileCard>.from(state.friendRequests)
      ..removeWhere((u) => u.id == otherUserId);
    final newFriends = List<UserProfileCard>.from(state.friends)
      ..removeWhere((u) => u.id == otherUserId);
    final newStatusMap =
        Map<String, FriendshipStatus>.from(state.friendshipStatusMap);
    newStatusMap[otherUserId] = FriendshipStatus.none;
    emit(state.copyWith(
      friendRequests: newRequests,
      friends: newFriends,
      friendshipStatusMap: newStatusMap,
    ));

    try {
      await _apiRepository.removeOrDeclineFriend(currentUserId, otherUserId);
    } catch (e) {
      loadFriendsData();
      logger.d("Ошибка удаления/отклонения друга: $e");
    }
  }

  // --- ДОБАВЬ ЭТОТ НОВЫЙ МЕТОД ---
  Future<void> loadInitialChatList() async {
    if (state.isChatListLoading) return;
    emit(state.copyWith(isChatListLoading: true));

    try {
      logger.d(
          "--- 💬 [CUBIT /chats] 1. Вызываю apiRepository.fetchUserChatsOnce()...");
      final chatItems = await _apiRepository.fetchUserChatsOnce();
      logger.d(
          "--- 💬 [CUBIT /chats] 3. УСПЕХ: ApiRepository вернул ${chatItems.length} элементов.");

      // Добавим лог, чтобы увидеть, что внутри
      if (chatItems.isNotEmpty) {
        final firstChat = chatItems.first;
        logger.d(
            "--- 💬 [CUBIT /chats] Пример первого чата: ID=${firstChat.chatId}, Partner=${firstChat.otherUser?.name}, Msg='${firstChat.lastMessage}'");
      }

      emit(state.copyWith(
        chatListItems: chatItems,
        isChatListLoading: false,
      ));
    } catch (e, s) {
      // Ловим не только ошибку, но и stack trace
      logger.d(
          "--- 💬 [CUBIT /chats] ❌ КРИТИЧЕСКАЯ ОШИБКА при загрузке чатов: $e");
      logger.d(s); // Печатаем stack trace для детальной отладки
      emit(state.copyWith(isChatListLoading: false));
    }
  }

  void resetNewLikesCount() {
    emit(state.copyWith(newLikesCount: 0));
  }

  // ЗАМЕНИ СТАРУЮ ВЕРСИЮ ЭТОЙ ФУНКЦИИ
  Future<void> _loadCompatibilityDescriptions(
      {bool forceReload = false}) async {
    // 1. Добавляем проверку: если данные уже есть и перезагрузка не требуется - выходим
    if (state.compatibilityDescriptions.isNotEmpty && !forceReload) return;

    final langCode = currentLocale.languageCode;
    logger.d("CUBIT: Загружаю описания совместимости для языка '$langCode'...");

    try {
      final descriptions =
          await _apiRepository.getCompatibilityDescriptions(lang: langCode);
      if (descriptions.isNotEmpty) {
        emit(state.copyWith(compatibilityDescriptions: descriptions));
        logger.d("CUBIT: ✅ Описания совместимости успешно загружены.");
      }
    } catch (e) {
      logger.d("❌ Ошибка в _loadCompatibilityDescriptions: $e");
    }
  }

  // Перенос `clearAllUserData`

  // Перенос `loadFriendsData`

  Future<void> removeFriendOrRequest(String otherUserId) async {
    final currentUserId = state.currentUserProfile?.id;
    if (currentUserId == null) return;

    // 1. Оптимистичное обновление UI
    final newRequests = List<UserProfileCard>.from(state.friendRequests)
      ..removeWhere((user) => user.id == otherUserId);
    final newFriends = List<UserProfileCard>.from(state.friends)
      ..removeWhere((user) => user.id == otherUserId);
    final newStatusMap =
        Map<String, FriendshipStatus>.from(state.friendshipStatusMap);
    newStatusMap.remove(otherUserId); // Полностью удаляем статус

    emit(state.copyWith(
      friendRequests: newRequests,
      friends: newFriends,
      friendshipStatusMap: newStatusMap,
    ));

    // 2. Отправка запроса в фоне
    try {
      await _apiRepository.removeFriendOrRequest(currentUserId, otherUserId);
    } catch (e) {
      logger.d("Ошибка удаления друга/заявки: $e");
      // 3. Откат UI
      emit(state.copyWith(
        friendRequests: state.friendRequests,
        friends: state.friends,
        friendshipStatusMap: state.friendshipStatusMap,
      ));
    }
  }

  // Перенос `listenForChats`

  Future<void> onChatScreenOpened(String chatId) async {
    final currentUserId = state.currentUserProfile?.id;
    if (currentUserId == null) {
      logger.d("❌ onChatScreenOpened: currentUserId is null.");
      return;
    }

    _messagesWebSocketSubscription?.cancel(); // Отменяем старую подписку

    emit(state.copyWith(
      activeChatId: chatId,
      activeChatMessages: [],
      isLoadingMessages: true,
      chatError: const ValueWrapper(null),
    ));

    try {
      final messages = await _apiRepository.getChatMessages(chatId);

      // --- 👇 ВАЖНОЕ ИСПРАВЛЕНИЕ: ПЕРЕВОРАЧИВАЕМ ИСТОРИЮ 👇 ---
      // Сервер отдает от новых к старым. Для отображения в ListView нужно наоборот.
      final chronologicalMessages = messages.reversed.toList();

      emit(state.copyWith(
        activeChatMessages: chronologicalMessages,
        isLoadingMessages: false,
      ));

      _apiRepository.markChatAsRead(chatId).catchError((e) {
        logger.d(
            "--- CUBIT: Не удалось отметить чат как прочитанный через API: $e ---");
      });

      // Подписываемся на новые сообщения
      _listenToChatWebSocket(chatId);
    } catch (e) {
      logger.d("--- CUBIT: Ошибка в загрузке сообщений через API: $e");
      emit(state.copyWith(
        isLoadingMessages: false,
        chatError: const ValueWrapper("Не удалось загрузить сообщения."),
      ));
    }
  }

  // --- 👇 Убедись, что этот метод выглядит так 👇 ---
  // В файле lib/cubit/app_cubit.dart
  void _listenToChatWebSocket(String currentChatId) {
    _messagesWebSocketSubscription?.cancel();
    _messagesWebSocketSubscription =
        WebSocketService.instance.events.listen((event) {
      // 1. ПРИШЛО НОВОЕ СООБЩЕНИЕ
      if (event.type == 'new_message') {
        try {
          final message = chat_models.Message.fromJson(event.payload);

          // --- А) Обновляем ОТКРЫТЫЙ чат (Messages Screen) ---
          if (message.chatId == currentChatId) {
            // Ищем, есть ли уже это сообщение (чтобы обновить tempId)
            final index = state.activeChatMessages.indexWhere((m) =>
                m.id == message.id ||
                (m.clientTempId != null &&
                    m.clientTempId == message.clientTempId));

            List<chat_models.Message> updatedMessages;

            if (index != -1) {
              // Обновляем существующее (оптимистичное)
              updatedMessages = List.from(state.activeChatMessages);
              // Важно: isRead берем из оптимистичного или false
              updatedMessages[index] = message.copyWith(isRead: false);
            } else {
              // Добавляем новое в начало (так как список перевернут в UI)
              updatedMessages = List.from(state.activeChatMessages)
                ..insert(0, message);
            }

            emit(state.copyWith(activeChatMessages: updatedMessages));

            // Помечаем прочитанным, только если отправитель НЕ Я
            final myId = state.currentUserProfile?.id;
            if (message.senderId != myId) {
              _apiRepository.markChatAsRead(currentChatId);
            }
          }

          // --- Б) Обновляем СПИСОК чатов (Chat List Screen) ---
          final currentChatList = List<ChatListItem>.from(state.chatListItems);
          final chatIndex =
              currentChatList.indexWhere((c) => c.chatId == message.chatId);

          if (chatIndex != -1) {
            // Чат уже есть -> обновляем текст, время и поднимаем наверх
            final oldItem = currentChatList[chatIndex];
            final newItem = oldItem.copyWith(
              lastMessage: message.text,
              lastMessageTimestamp: message.createdAt,
              lastMessageSenderId: message.senderId,
              // Если отправил Я -> счетчик 0. Если МНЕ и чат ЗАКРЫТ -> +1
              unreadCount: (message.senderId == state.currentUserProfile?.id)
                  ? 0
                  : (message.chatId == currentChatId
                      ? 0
                      : oldItem.unreadCount + 1),
            );

            // Перемещаем наверх
            currentChatList.removeAt(chatIndex);
            currentChatList.insert(0, newItem);

            emit(state.copyWith(chatListItems: currentChatList));
          } else {
            // Новый чат -> проще всего перезагрузить список
            loadInitialChatList();
          }
        } catch (e) {
          logger.d("WS Error: $e");
        }
      }

      // 2. СОБЕСЕДНИК ПРОЧИТАЛ (Синие галочки)
      if (event.type == 'chat_read_status') {
        final payload = event.payload as Map<String, dynamic>;

        if (payload['chatId'] == currentChatId) {
          final myId = state.currentUserProfile?.id;
          final updatedMessages = state.activeChatMessages.map((msg) {
            if (msg.senderId == myId && !msg.isRead) {
              return msg.copyWith(isRead: true);
            }
            return msg;
          }).toList();

          emit(state.copyWith(activeChatMessages: updatedMessages));
        }
      }

      // 3. Статус "Печатает"
      if (event.type == 'partner_typing_status') {
        final payload = event.payload as Map<String, dynamic>;
        if (payload['chatId'] == currentChatId) {
          final isTyping = payload['isTyping'] as bool? ?? false;
          emit(state.copyWith(isPartnerTyping: isTyping));
        }
      }
    });
  }

  void onChatScreenClosed() {
    _messagesWebSocketSubscription?.cancel();
    emit(state.copyWith(
      activeChatId: null, // <-- Сбрасываем ID
      activeChatMessages: [],
    ));
  }

  void onSearchTextChanged(String text) {
    // Просто обновляем текст в стейте. НЕ ЗАПУСКАЕМ ПОИСК.
    emit(state.copyWith(searchText: text));
  }

  // --- МЕТОДЫ ДЛЯ ИЗМЕНЕНИЯ ФИЛЬТРОВ ИЗ UI ---
  Future<void> applyAllFilters({
    required SearchMode searchMode,
    required int minAge,
    required int maxAge,
    required String gender,
    required ZodiacFilter zodiac,
    String? bio,
  }) async {
    logger.d("--- CUBIT: Получил команду applyAllFilters ---");
    logger.d("Режим: $searchMode, Возраст: $minAge-$maxAge");

    if (searchMode == SearchMode.nearby) {
      final location = await updateAndGetCurrentUserLocation();
      if (location == null) {
        // Просто выходим. Сообщение об ошибке уже отправлено в updateAndGetCurrentUserLocation.
        return;
      }
    }

    // Обновляем state
    emit(state.copyWith(
      searchMode: searchMode,
      minAgeFilter: minAge,
      maxAgeFilter: maxAge,
      genderFilter: gender,
      bioKeywordFilter: bio ?? state.bioKeywordFilter,
      zodiacFilter: zodiac,
    ));

    // ЯВНО передаем ВСЕ параметры в startNewSearch
    await startNewSearch();
  }

// Метод resetSearchFilters тоже нужно немного обновить
  Future<void> startNewSearch({String? query}) async {
    // Если query передан (из текстового поля), используем его.
    // Иначе берем из state (когда поиск запускается от фильтров).
    final finalQuery = (query ?? state.searchText).trim();

    logger.d("--- CUBIT: Запускаю поиск через API. Запрос: '$finalQuery'");
    logger.d(
        "--- CUBIT: Фильтры: пол=${state.genderFilter}, возраст=${state.minAgeFilter}-${state.maxAgeFilter}");

    emit(state.copyWith(
      isSearchLoading: true,
      priorityUsers: [],
      otherUsers: [],
      searchText: finalQuery, // Обновляем текст поиска в state
      searchInitiated: true,
      allUsersLoaded: false,
      lastVisibleUserDocument: null,
    ));

    try {
      // Вызываем API
      final results = await _apiRepository.searchUsersSmart(
        query: finalQuery,
        lang: state.locale?.languageCode ?? 'ru',
        gender: state.genderFilter,
        minAge: state.minAgeFilter,
        maxAge: state.maxAgeFilter,
        offset: 0, // Явно указываем 0 для нового поиска
      );

      // Проверяем, есть ли еще страницы
      // Если пришло меньше 100 результатов (суммарно), значит это последняя страница
      final totalLoaded =
          results.priorityResults.length + results.otherResults.length;
      final isLastPage = totalLoaded < 100; // Лимит сервера

      emit(state.copyWith(
        priorityUsers: results.priorityResults,
        otherUsers: results.otherResults,
        isSearchLoading: false,
        allUsersLoaded: isLastPage, // <--- ТЕПЕРЬ ПРАВИЛЬНО
        searchOffset: 0, // Сбрасываем offset
      ));
    } catch (e) {
      logger.d("❌ Ошибка поиска через API: $e");
      emit(state.copyWith(isSearchLoading: false));
    }
  }

  void resetSearchFilters() {
    const newMinAge = 18;
    const newMaxAge = 99;
    const newGender = 'all';
    const newZodiac = ZodiacFilter.all;

    emit(state.copyWith(
      searchMode: SearchMode.all,
      minAgeFilter: newMinAge,
      maxAgeFilter: newMaxAge,
      genderFilter: newGender,
      bioKeywordFilter: '',
      zodiacFilter: newZodiac,
      searchInitiated: false,
    ));

    // Вызываем startNewSearch БЕЗ ПАРАМЕТРОВ.
    // Он возьмет свежие (сброшенные) значения из state.
    startNewSearch();
  }

// И вызов пагинации в UI

// Убедись, что startNewSearch выглядит так (он очень простой):

  // Загружает пользователей (первую или следующую страницу)

  List<String> generateKeywords(String text) {
    if (text.isEmpty) return [];
    final cleanText = text.replaceAll(RegExp(r'[^\w\s]+'), '').toLowerCase();
    return cleanText.split(' ').where((s) => s.isNotEmpty).toList();
  }

  Future<GeoPoint?> updateAndGetCurrentUserLocation() async {
    if (kIsWeb) {
      logger.w(
          "[GEO] Определение геолокации в веб-версии отключено из-за нестабильности.");
      return null; // Просто выходим, ничего не делая
    }
    final userId = state.currentUserProfile?.id;
    if (userId == null) {
      logger.d("[GEO_DEBUG] Ошибка: userId is null, не могу обновить локацию.");
      return null;
    }

    // ==========================================================
    // ===          👇 ВОТ БЛОК-ЗАГЛУШКА ДЛЯ WINDOWS 👇         ===
    // ==========================================================
    if (!kIsWeb && Platform.isWindows) {
      logger.d(
          "[GEO_DEBUG] ВНИМАНИЕ: Запуск на Windows. Использую фейковую геолокацию (центр Москвы).");
      // Возвращаем фейковые, но валидные координаты (например, Красная площадь)
      const fakeGeoPoint = GeoPoint(55.7539, 37.6208);

      // Мы также можем сымитировать сохранение в Firestore, чтобы код был полным
      // Но для теста достаточно просто вернуть точку.
      // await _firestoreRepository.updateUserLocation(userId, fakeGeoPoint.latitude, fakeGeoPoint.longitude);

      return fakeGeoPoint;
    }
    // ==========================================================
    // ===                   КОНЕЦ БЛОКА                      ===
    // ==========================================================

    logger.d("[GEO_DEBUG] --- Начинаю обновление геолокации ---");
    Location location = Location();

    // 1. Проверяем сервис
    logger.d("[GEO_DEBUG] 1. Проверяю, включен ли сервис геолокации...");
    bool serviceEnabled = await location.serviceEnabled();
    logger.d("[GEO_DEBUG] Сервис включен: $serviceEnabled");
    if (!serviceEnabled) {
      final msg =
          "Пожалуйста, включите геолокацию (GPS) в настройках телефона.";
      emit(state.copyWith(
          geoErrorMessage: msg, snackBarMessage: msg, snackBarIsError: true));
      logger.d("[GEO_DEBUG] Сервис выключен. Запрашиваю включение...");
      serviceEnabled = await location.requestService();
      logger.d("[GEO_DEBUG] Результат запроса сервиса: $serviceEnabled");
      if (!serviceEnabled) {
        logger.d("[GEO_DEBUG] Пользователь не включил сервис. Выхожу.");
        final msg =
            "Пожалуйста, включите геолокацию (GPS) в настройках телефона.";
        emit(state.copyWith(
            geoErrorMessage: msg, snackBarMessage: msg, snackBarIsError: true));
        return null;
      }
    }

    // 2. Проверяем разрешения
    logger.d("[GEO_DEBUG] 2. Проверяю разрешения для приложения...");
    PermissionStatus permissionGranted = await location.hasPermission();
    logger.d("[GEO_DEBUG] Текущий статус разрешений: $permissionGranted");
    if (permissionGranted == PermissionStatus.denied) {
      logger.d("[GEO_DEBUG] Разрешения отсутствуют. Запрашиваю...");
      emit(state.copyWith(
          geoErrorMessage: "Для поиска рядом нужен доступ к геолокации."));
      permissionGranted = await location.requestPermission();
      logger.d("[GEO_DEBUG] Результат запроса разрешений: $permissionGranted");
      if (permissionGranted != PermissionStatus.granted) {
        logger.d("[GEO_DEBUG] Пользователь НЕ предоставил доступ. Выхожу.");
        final msg = "Для поиска рядом нужен доступ к геолокации.";
        emit(state.copyWith(
            geoErrorMessage: msg, snackBarMessage: msg, snackBarIsError: true));
        return null;
      }
    }

    if (permissionGranted == PermissionStatus.deniedForever) {
      final msg =
          "Вы запретили доступ к геолокации. Включите его в настройках приложения.";
      emit(state.copyWith(
          geoErrorMessage: msg, snackBarMessage: msg, snackBarIsError: true));
      logger.d(
          "[GEO_DEBUG] Пользователь НАВСЕГДА запретил доступ. Нужно вести его в настройки.");
      return null;
    }

    logger.d("[GEO_DEBUG] 3. Все проверки пройдены. Получаю координаты...");
    try {
      // 3. Получаем координаты
      final locationData = await location.getLocation();
      final lat = locationData.latitude;
      final lng = locationData.longitude;
      logger.d("[GEO_DEBUG] Получены координаты: lat=$lat, lng=$lng");

      if (lat == null || lng == null) {
        logger.d("[GEO_DEBUG] Не удалось получить координаты (null). Выхожу.");
        return null;
      }

      final geoPoint = GeoPoint(lat, lng);

      // 4. Сохраняем в Firestore
      logger.d("[GEO_DEBUG] 4. Сохраняю координаты в Firestore...");
      await _apiRepository.updateUserLocation(lat, lng);

      // 5. Обновляем state
      logger.d("[GEO_DEBUG] 5. Обновляю state...");
      final updatedProfile = state.currentUserProfile?.copyWith(
        currentLocation: geoPoint,
        // Убедись, что в copyWith есть currentLocationPlus, и он принимает Map
        currentLocationPlus: {'geopoint': geoPoint, 'geohash': ''},
      );
      emit(state.copyWith(currentUserProfile: updatedProfile));
      logger.d("[GEO_DEBUG] --- Геолокация успешно обновлена ---");

      return geoPoint;
    } catch (e) {
      logger.d(
          "[GEO_DEBUG] ❌ КРИТИЧЕСКАЯ ОШИБКА при получении/сохранении геолокации: $e");
      return null;
    }
  }

  void clearGeoError() {
    emit(state.clearGeoError());
  }

  // Обновляет базовые данные профиля (имя, био и т.д.)

// =======================================================================
// === КОНЕЦ ПОЛНОЙ РЕАЛИЗАЦИИ ЛОГИКИ ПОИСКА В CUBIT ===
// =======================================================================

  // =======================================================================
  // === НАЧАЛО РЕАЛИЗАЦИИ ЛОГИКИ ТАРО В CUBIT ===
  // =======================================================================

  Future<void> loadTarotDeck() async {
    if (state.isTarotDeckLoading || state.fullTarotDeck.isNotEmpty) return;
    emit(state.copyWith(isTarotDeckLoading: true));

    try {
      final languageCode = state.locale?.languageCode ?? 'ru';

      // Вызываем метод из ApiRepository
      final List<TarotCard> deckFromRepo =
          await _apiRepository.getTarotDeck(languageCode);

      emit(state.copyWith(
        fullTarotDeck: deckFromRepo,
        isTarotDeckLoading: false,
      ));
      logger.d(
          "--- CUBIT_TAROT: Колода из ${deckFromRepo.length} карт успешно загружена с API.");
    } catch (e) {
      logger.d("--- CUBIT_TAROT: ❌ Ошибка в loadTarotDeck: $e");
      emit(state.copyWith(isTarotDeckLoading: false));
    }
  }

  // =======================================================================
  // === КОНЕЦ РЕАЛИЗАЦИИ ЛОГИКИ ТАРО В CUBIT ===
  // =======================================================================
  // =======================================================================
  // === НАЧАЛО РЕАЛИЗАЦИИ ЛОГИКИ КАНАЛОВ В CUBIT ===
  // =======================================================================

  // Вызывается при открытии вкладки "Каналы"
  // === ПОЛНОСТЬЮ ЗАМЕНИ СТАРЫЙ onChannelsTabOpened НА ЭТОТ ===
  // === ПОЛНОСТЬЮ ЗАМЕНИ СВОЙ МЕТОД onChannelsTabOpened НА ЭТОТ ===
  // === ПОЛНОСТЬЮ ЗАМЕНИ СВОЙ МЕТОД onChannelsTabOpened НА ЭТОТ ===
  // === ПОЛНОСТЬЮ ЗАМЕНИ СТАРЫЙ МЕТОД onChannelsTabOpened НА ЭТОТ ===
  Future<void> onChannelsTabOpened() async {
    // Отменяем старые подписки (это не относится к нашей проблеме, но это хорошая практика)
    _channelsSubscription?.cancel();

    // Проверяем, не идет ли уже загрузка
    if (state.isLoadingChannels) {
      logger.d("CUBIT_CHANNELS: Загрузка уже идет. Выход.");
      return;
    }

    emit(state.copyWith(isLoadingChannels: true));
    logger.d("CUBIT_CHANNELS: Запускаю загрузку каналов через API...");

    try {
      // Вызываем метод репозитория, в который мы добавили логи
      final channels = await _apiRepository.getChannels(
        filter: state.channelListFilter,
        languageFilter: state.channelLanguageFilter,
      );

      logger.d(
          "CUBIT_CHANNELS: ✅ API отработал. Получено ${channels.length} каналов. Обновляю стейт.");

      emit(state.copyWith(
        channels: channels, // <-- Записываем результат в стейт
        isLoadingChannels: false,
      ));
    } catch (e, s) {
      logger.d("CUBIT_CHANNELS: ❌ Ошибка при загрузке каналов: $e");
      logger.d(s);
      emit(state.copyWith(isLoadingChannels: false));
    }
  }

  void onDislikeClicked(String userId) {
    // Логика для дизлайка. Например, просто добавление в список просмотренных,
    // чтобы пользователь больше не появлялся в этой сессии.
    final newLikedIds = Set<String>.from(state.likedUserIds)..add(userId);
    emit(state.copyWith(likedUserIds: newLikedIds));
  }

  // === НОВЫЙ МЕТОД: СБРАСЫВАЕТ ИНДИКАТОР, КОГДА ПОЛЬЗОВАТЕЛЬ ОБНОВЛЯЕТ ЛЕНТУ ===

// Не забудь вызвать _startListeningToChannelUpdates() в _listenToUserProfile
// после того, как профиль загружен.
// И отписаться в close().

  // === ДОБАВЬ ЭТИ ТРИ НОВЫХ МЕТОДА В AppCubit ===

  /// Вспомогательный приватный метод для фильтрации списка "Все".
  /// Firestore плохо справляется с запросами "НЕ ВХОДИТ В", поэтому
  /// проще и надежнее сделать эту фильтрацию на стороне клиента.
  List<Channel> _filterChannels(
      List<Channel> list, String filter, UserProfileCard currentUser) {
    if (filter == 'all') {
      final subscribedIds = currentUser.subscribedChannelIds.toSet();
      // Возвращаем только те каналы, на которые пользователь НЕ подписан
      return list
          .where((channel) => !subscribedIds.contains(channel.id))
          .toList();
    }
    return list; // Для других фильтров ("Мои", "Для вас") возвращаем как есть
  }

  Future<void> loadChannelPreviews() async {
    // Проверяем, не идет ли уже загрузка
    if (state.isLoadingChannelPreviews) return;

    emit(state.copyWith(isLoadingChannelPreviews: true));
    logger.d("[CUBIT] Начинаю загрузку превью каналов...");

    try {
      final previews = await _apiRepository.getChannelPreviews();
      emit(state.copyWith(
        channelPreviews: previews,
        isLoadingChannelPreviews: false,
      ));
    } catch (e) {
      logger.d("❌ Ошибка при загрузке превью каналов в Cubit: $e");
      emit(state.copyWith(isLoadingChannelPreviews: false));
    }
  }

  Future<void> markChannelAsRead(String channelId) async {
    // 1. Оптимистичное обновление: мгновенно убираем счетчик в UI
    final updatedPreviews = state.channelPreviews.map((p) {
      if (p.id.toString() == channelId) {
        return p.copyWith(unreadCount: 0);
      }
      return p;
    }).toList();
    emit(state.copyWith(channelPreviews: updatedPreviews));

    // 2. В фоне отправляем запрос на сервер, чтобы он запомнил
    _apiRepository.markChannelAsRead(channelId).catchError((e) {
      // Если на сервере произошла ошибка, просто перезагружаем список,
      // чтобы вернуть счетчик на место.
      loadChannelPreviews();
    });
  }

  /// Вспомогательный приватный метод для добавления счетчиков непрочитанных постов.

  /// Вызывается, когда пользователь открывает канал, чтобы "сбросить" счетчик.

  // === ЗАМЕНИ СТАРЫЙ МЕТОД НА ЭТОТ ===
  // 2. ЗАМЕНИ СТАРЫЙ МЕТОД НА ЭТОТ. ОН СНОВА АСИНХРОННЫЙ.
  Future<Map<String, List<String>>> _generateKeywordsForChannel(
      String name, String description) async {
    final fullText = '$name $description'.toLowerCase();

    if (fullText.trim().length < 3) {
      // Проверяем на минимальную длину
      return {};
    }

    // Определяем язык текста с помощью асинхронного метода из пакета
    final String detectedLang =
        await LanguageDetector.getLanguageCode(content: fullText);
    logger.d(
        "LANGUAGE DETECT: Обнаружен язык '$detectedLang' для канала '$name'");

    // Русские стоп-слова
    const russianStopWords = <String>{
      'и',
      'в',
      'во',
      'не',
      'что',
      'он',
      'на',
      'я',
      'с',
      'со',
      'как',
      'а',
      'то',
      'все',
      'она',
      'так',
      'его',
      'но',
      'да',
      'ты',
      'к',
      'у',
      'же',
      'вы',
      'за',
      'бы',
      'по',
      'только',
      'ее',
      'мне',
      'было',
      'вот',
      'от',
      'меня',
      'еще',
      'о',
      'из',
      'ему',
      'теперь',
      'когда',
      'даже',
      'ну',
      'вдруг',
      'ли',
      'если',
      'уже',
      'или',
      'ни',
      'быть',
      'мой',
      'нам',
      'это',
      'для',
      'канал',
      'группа'
    };

    // Английские стоп-слова
    const englishStopWords = <String>{
      'and',
      'the',
      'a',
      'in',
      'is',
      'it',
      'of',
      'to',
      'for',
      'on',
      'with',
      'as',
      'by',
      'at',
      'an',
      'my',
      'your',
      'our',
      'we',
      'you',
      'i',
      'he',
      'she',
      'me',
      'him',
      'her',
      'channel',
      'group'
    };

    Set<String> stopWords;
    RegExp regex;

    // Пакет возвращает коды языков ISO 639-1 (например, "en", "ru")
    switch (detectedLang) {
      case 'ru':
        stopWords = russianStopWords;
        regex = RegExp(r'[^\w\sа-яА-Я]+');
        break;
      case 'en':
        stopWords = englishStopWords;
        regex = RegExp(r'[^\w\sa-zA-Z]+');
        break;
      default:
        logger.d(
            "LANGUAGE DETECT: Язык '$detectedLang' не поддерживается, ключевые слова не сгенерированы.");
        return {};
    }

    final cleanText =
        fullText.replaceAll(regex, '').replaceAll(RegExp(r'\s+'), ' ');
    final words = cleanText.split(' ');
    final keywords = words
        .where((word) => word.length > 2 && !stopWords.contains(word))
        .toSet()
        .toList();

    return {detectedLang: keywords};
  }

  /// Генерирует ключевые слова из текста bio пользователя.
  List<String> _generateKeywords(String text) {
    if (text.isEmpty) return [];

    // Список "мусорных" слов для русского языка
    const stopWords = <String>{
      'и',
      'в',
      'во',
      'не',
      'что',
      'он',
      'на',
      'я',
      'с',
      'со',
      'как',
      'а',
      'то',
      'все',
      'она',
      'так',
      'его',
      'но',
      'да',
      'ты',
      'к',
      'у',
      'же',
      'вы',
      'за',
      'бы',
      'по',
      'только',
      'ее',
      'мне',
      'было',
      'вот',
      'от',
      'меня',
      'еще',
      'о',
      'из',
      'ему',
      'теперь',
      'когда',
      'даже',
      'ну',
      'вдруг',
      'ли',
      'если',
      'уже',
      'или',
      'ни',
      'быть',
      'мой',
      'нам',
      'это',
      'для'
    };

    // 1. Убираем хэштеги, чтобы они не попали в ключевые слова
    final textWithoutHashtags = text.replaceAll(RegExp(r'#\w+'), '');

    // 2. Очищаем текст от знаков препинания и приводим к нижнему регистру
    final cleanText = textWithoutHashtags
        .replaceAll(RegExp(r'[^\w\sа-яА-Я]+'), '')
        .toLowerCase();

    // 3. Разбиваем на слова, фильтруем короткие слова и стоп-слова
    final keywords = cleanText
        .split(' ')
        .where((word) => word.length > 2 && !stopWords.contains(word))
        .toSet() // Убираем дубликаты
        .toList();

    return keywords;
  }

  Future<String> applyReferralCode(String code, BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final currentUser = state.currentUserProfile;

    // Клиентская проверка (быстрая)
    if (currentUser == null) return l10n.error_generic;
    if (currentUser.hasUsedReferralCode) return l10n.referral_already_used;
    if (currentUser.referralCode == code.trim().toUpperCase())
      return l10n.referral_own_code;

    try {
      // Вызываем API
      final successMessage =
          await _apiRepository.applyReferralCode(code.trim().toUpperCase());

      // Если успешно - обновляем профиль (ставим флаг и обновляем статус PRO)
      // Лучше всего перезагрузить профиль целиком, чтобы увидеть новую дату подписки
      await _loadUserProfile(currentUser.id);

      return successMessage; // "Код применен! ..."
    } catch (e) {
      // Если сервер вернул ошибку, ApiRepository выбросит исключение с текстом ошибки
      // Мы просто возвращаем этот текст в UI
      return e.toString().replaceAll("Exception: ", "");
    }
  }

  Future<void> checkAndUpdateUserLanguage(BuildContext context) async {
    final profile = state.currentUserProfile;
    if (profile == null) return; // Профиль еще не загружен

    // Получаем текущий язык устройства
    final deviceLanguage = Localizations.localeOf(context).languageCode;
    // --- 👇 ДОБАВЬ ЭТИ СТРОЧКИ ДЛЯ ДИАГНОСТИКИ 👇 ---
    logger.d("--- ДИАГНОСТИКА ЯЗЫКА ---");
    logger.d("Язык устройства: $deviceLanguage");
    logger.d("Язык в профиле из БД: ${profile.languageCode}");
    // --- 👆 КОНЕЦ БЛОКА ДИАГНОСТИКИ 👆 ---

    // Сравниваем с языком, сохраненным в профиле
    if (profile.languageCode != deviceLanguage) {
      logger.d(
          'CUBIT: Язык устройства ($deviceLanguage) отличается от языка в профиле (${profile.languageCode}). Обновляю на сервере...');
      try {
        await _apiRepository.updateUserLanguage(deviceLanguage);
        // Оптимистично обновляем стейт, чтобы приложение сразу использовало новый язык
        final updatedProfile = profile.copyWith(languageCode: deviceLanguage);
        emit(state.copyWith(currentUserProfile: updatedProfile));
        logger.d('CUBIT: Язык на сервере успешно обновлен.');
      } catch (e) {
        logger.d('CUBIT: Ошибка при обновлении языка на сервере: $e');
      }
    } else {
      logger.d(
          'CUBIT: Язык устройства ($deviceLanguage) и профиля совпадают. Обновление не требуется.');
    }
  }

  // Вызывается, когда пользователь меняет фильтр (Все/Подписки/Рекомендованные)
  void setChannelListFilter(String newFilter) {
    // Если фильтр не изменился, ничего не делаем
    if (state.channelListFilter == newFilter) return;

    // 1. Обновляем фильтр в состоянии
    emit(state.copyWith(channelListFilter: newFilter));
    // 2. Перезапускаем прослушивание с новым фильтром
    onChannelsTabOpened();
  }

  // Вызывается, когда пользователь меняет языковой фильтр
  void setChannelLanguageFilter(String newFilter) {
    if (state.channelLanguageFilter == newFilter) return;

    emit(state.copyWith(channelLanguageFilter: newFilter));
    onChannelsTabOpened();
  }

  // Не забываем отписаться, когда Cubit уничтожается

  // =======================================================================
  // === КОНЕЦ РЕАЛИЗАЦИИ ЛОГИКИ КАНАЛОВ В CUBIT ===
  // =======================================================================

  // =======================================================================
  // === НАЧАЛО РЕАЛИЗАЦИИ ЛОГИКИ ПОСТОВ/КОММЕНТАРИЕВ В CUBIT ===
  // =======================================================================

  // Вызывается при открытии экрана канала

  // Вызывается при открытии экрана с комментариями

  // Вызывается при отправке комментария
  Future<void> postComment({
    required String channelId,
    required String postId, // <-- ID поста у нас уже есть здесь!
    required String text,
    Comment? replyTo,
  }) async {
    final currentUser = state.currentUserProfile;
    if (currentUser == null || text.trim().isEmpty) return;

    // Создаем временный объект для оптимистичного обновления
    final tempComment = Comment(
      id: 'temp_${const Uuid().v4()}',
      postId: postId, // <-- 2. ВОТ ИСПРАВЛЕНИЕ! ПЕРЕДАЕМ ID ПОСТА.
      authorId: currentUser.id,
      authorName: currentUser.name,
      authorAvatarUrl: currentUser.avatar,
      text: text.trim(),
      createdAt: Timestamp.now(),
      replyToCommentId: replyTo?.id,
      replyToAuthorName: replyTo?.authorName,
      replyToText: replyTo?.text,
    );

    try {
      final newCommentFromServer = await _apiRepository.postComment(
        postId: postId,
        text: text.trim(),
        replyTo: replyTo,
      );

      // Оптимистичное обновление: добавляем в UI комментарий, который вернул сервер
      final updatedComments = List<Comment>.from(state.activePostComments)
        ..add(newCommentFromServer);
      emit(state.copyWith(activePostComments: updatedComments));
    } catch (e) {
      logger.d("Ошибка отправки комментария: $e");
      // TODO: Откатить UI, если было оптимистичное обновление
    }
  }

  // Вызывается при нажатии на реакцию
  void toggleReaction({
    required String channelId,
    String? postId,
    String? commentId,
    required String emoji,
  }) {
    final userId = state.currentUserProfile?.id;
    if (userId == null) return;

    // Определяем тип и ID сущности
    String entityType;
    String entityId;
    if (commentId != null) {
      entityType = 'comment';
      entityId = commentId;
    } else if (postId != null) {
      entityType = 'post';
      entityId = postId;
    } else {
      return;
    }

    // TODO: Реализовать оптимистичное обновление UI здесь, если нужно.
    // Это сложнее, чем для комментариев, т.к. нужно менять счетчики.
    // Проще всего дождаться WebSocket-события об обновлении.

    // Выполняем в фоне, UI обновится позже (через WS или при перезагрузке)
    _apiRepository
        .toggleReaction(
      entityType: entityType,
      entityId: entityId,
      emoji: emoji,
    )
        .catchError((e) {
      logger.d("Ошибка установки реакции через API: $e");
      // TODO: Откатить UI, если было оптимистичное обновление
    });
  }

  // Очистка при выходе с экранов
  void stopListeningToPostsAndComments() {
    _postsSubscription?.cancel();
    _commentsSubscription?.cancel();
  }

  Future<void> loadProfileForViewing(String userId) async {
    logger.d(">>> CUBIT: Получен запрос loadProfileForViewing для ID: $userId");

    // 1. Устанавливаем ID текущего профиля и флаг загрузки
    emit(state.copyWith(
      isLoadingViewedProfile: true,
      currentViewedUserId: userId,
    ));
    logger.d(">>> CUBIT: state обновлен -> isLoading=true, currentId=$userId");

    // 2. Если профиль уже есть в кэше, просто выключаем загрузку.
    // Getter в AppState сам подхватит его.
    if (state.viewedProfilesCache.containsKey(userId)) {
      emit(state.copyWith(isLoadingViewedProfile: false));
      logger.d("APP_CUBIT: Профиль для $userId взят из кэша.");
      return;
    }

    // 3. Если в кэше нет, грузим из Firestore
    logger.d(
        "APP_CUBIT: Профиль для $userId не найден в кэше, загружаю с API-сервера (PostgreSQL)...");
    try {
      final profile = await _apiRepository.getUserProfile(userId);

      if (profile != null) {
        final newCache =
            Map<String, UserProfileCard>.from(state.viewedProfilesCache);
        newCache[userId] = profile;

        // Обновляем состояние с новым кэшем и выключаем загрузку
        emit(state.copyWith(
          viewedProfilesCache: newCache,
          isLoadingViewedProfile: false,
        ));
        logger.d(
            "APP_CUBIT: Профиль для $userId УСПЕШНО загружен. Имя: ${profile.name}");
      } else {
        // Профиль не найден
        emit(state.copyWith(isLoadingViewedProfile: false));
        logger
            .d("APP_CUBIT: Не удалось найти профиль для $userId в Firestore.");
      }
    } catch (e) {
      emit(state.copyWith(isLoadingViewedProfile: false));
      logger.d("APP_CUBIT: Ошибка при загрузке профиля для $userId: $e");
    }
  }

  // Не забываем отписаться в close()

  // =======================================================================
  // === КОНЕЦ РЕАЛИЗАЦИИ ЛОГИКИ ПОСТОВ/КОММЕНТАРИЕВ В CUBIT ===
  // =======================================================================

  // --- НОВЫЕ МЕТОДЫ ---

  // Вызывается при открытии экрана чужого профиля

// Также обнови метод onUserProfileScreenClosed (или убедись, что он такой)
  void clearViewedProfile({required String userIdToClear}) {
    // ГЛАВНАЯ ПРОВЕРКА!
    // Мы очищаем ID, только если в стейте сейчас именно тот ID, который просят очистить.
    // Это предотвратит случайное удаление ID нового экрана старым экраном.
    if (state.currentViewedUserId == userIdToClear) {
      emit(state.copyWith(currentViewedUserId: null));
      logger.d(
          "APP_CUBIT: Успешно очищен currentViewedUserId для $userIdToClear.");
    } else {
      // Эта ветка как раз и сработает в твоем случае.
      // Старый экран попытается очистить свой ID, но в стейте уже будет ID нового экрана.
      logger.d(
          "APP_CUBIT: Попытка очистить $userIdToClear, но текущий ID другой (${state.currentViewedUserId}). Игнорирую.");
    }
  }

  Map<String, int> _flattenNumerology(Map<String, dynamic>? complexMap) {
    if (complexMap == null) return {};
    final result = <String, int>{};
    complexMap.forEach((key, value) {
      if (value is Map && value.containsKey('number')) {
        // Новый формат: {'lifePath': {'number': 5, ...}} -> {'lifePath': 5}
        result[key] = value['number'] as int;
      } else if (value is int) {
        // Старый формат (на всякий случай)
        result[key] = value;
      }
    });
    return result;
  }

  // lib/cubit/app_cubit.dart

  Future<CompatibilityReport?> calculateCompatibility(String partnerId) async {
    // 1. Сразу сообщаем UI, что начинается расчет
    emit(state.copyWith(isCalculatingCompatibility: true));

    try {
      logger.d(
          "--- [CUBIT COMPATIBILITY] Начинаю расчет. Интерпретаций в state: ${state.aspectInterpretations.length}");

      // --- Параллельно грузим все необходимые справочники ---
      await Future.wait([
        if (state.aspectInterpretations.isEmpty)
          loadAspectInterpretations(forceReload: true),
        if (state.numerologyCompatibility.isEmpty)
          loadNumerologyCompatibility(forceReload: true),
        if (state.compatibilityDescriptions.isEmpty)
          _loadCompatibilityDescriptions(forceReload: true)
      ]);

      // --- ШАГ 2: Проверяем, что все загрузилось успешно ---
      if (state.aspectInterpretations.isEmpty ||
          state.numerologyCompatibility.isEmpty ||
          state.compatibilityDescriptions.isEmpty) {
        logger.d(
            "--- [CUBIT COMPATIBILITY] ОШИБКА: Не все справочники были загружены.");
        throw Exception(
            'Не удалось загрузить все необходимые описания для расчета.');
      }

      if (state.currentUserProfile != null &&
          state.currentUserProfile!.natalChart == null) {
        logger.d(
            "[Compatibility] У текущего пользователя нет карты. Рассчитываю...");
        final p = state.currentUserProfile!;
        // Если есть данные рождения - считаем
        if (p.birthDateMillis > 0 && p.birthLocation != null) {
          final chart = await _chartCalculator.calculateAll(p.birthDateMillis,
              p.birthLocation!.latitude, p.birthLocation!.longitude);
          // Обновляем профиль в стейте (временно)
          final updatedProfile = p.copyWith(natalChart: chart);
          emit(state.copyWith(currentUserProfile: updatedProfile));
        }
      }

      // 3. Получаем данные ТЕКУЩЕГО пользователя
      final currentUserProfile = state.currentUserProfile;
      if (currentUserProfile == null || currentUserProfile.natalChart == null) {
        throw Exception(
            'Профиль или натальная карта текущего пользователя не готовы.');
      }

      // Получаем нумерологию текущего пользователя ИЛИ РАССЧИТЫВАЕМ ЕЕ "НА ЛЕТУ"
      PersonalNumerologyReport? currentUserNumerologyData =
          currentUserProfile.numerologyData;
      if (currentUserNumerologyData == null) {
        if (currentUserProfile.birthDateMillis > 0 &&
            currentUserProfile.name.isNotEmpty) {
          currentUserNumerologyData = NumerologyCalculator.generateFullReport(
            birthDateTime: DateTime.fromMillisecondsSinceEpoch(
                currentUserProfile.birthDateMillis),
            fullName:
                '${currentUserProfile.name} ${currentUserProfile.surname ?? ''}'
                    .trim(),
          );
        }
      }

      // 4. Получаем данные ПАРТНЕРА
      UserProfileCard? partnerProfile = state.viewedProfilesCache[partnerId];
      if (partnerProfile == null) {
        logger.d(
            "[Compatibility] Профиль партнера $partnerId не в кэше, гружу с API...");
        partnerProfile = await _apiRepository.getUserProfile(partnerId);
        if (partnerProfile == null)
          throw Exception('Не удалось загрузить профиль партнера $partnerId.');
        final newCache =
            Map<String, UserProfileCard>.from(state.viewedProfilesCache)
              ..[partnerId] = partnerProfile;
        emit(state.copyWith(viewedProfilesCache: newCache));
      }

      // 5. Рассчитываем карту партнера "на лету", если ее нет
      NatalChart? partnerChart = partnerProfile.natalChart;
      if (partnerChart == null) {
        logger
            .d("[Compatibility] У партнера нет карты. Рассчитываю на лету...");
        if (partnerProfile.birthDateMillis == 0 ||
            partnerProfile.birthLocation == null) {
          throw Exception(
              'У партнера нет даты/места рождения для расчета карты.');
        }
        partnerChart = await _chartCalculator.calculateAll(
          partnerProfile.birthDateMillis,
          partnerProfile.birthLocation!.latitude,
          partnerProfile.birthLocation!.longitude,
        );
        if (partnerChart == null)
          throw Exception('Не удалось рассчитать карту партнера на лету.');
      }

      // Расчет нумерологии партнера
      PersonalNumerologyReport? partnerNumerologyData =
          partnerProfile.numerologyData;
      if (partnerNumerologyData == null) {
        if (partnerProfile.birthDateMillis > 0 &&
            partnerProfile.name.isNotEmpty) {
          partnerNumerologyData = NumerologyCalculator.generateFullReport(
            birthDateTime: DateTime.fromMillisecondsSinceEpoch(
                partnerProfile.birthDateMillis),
            fullName:
                '${partnerProfile.name} ${partnerProfile.surname ?? ''}'.trim(),
          );
        }
      }

      // 6. Вызываем калькулятор
      logger.d("[Compatibility] Все данные на месте. Вызываю калькулятор...");
      final report = CompatibilityCalculator.calculate(
        chart1: currentUserProfile.natalChart!,
        chart2: partnerChart,

        // --- 👇 ИСПРАВЛЕНИЕ: Оборачиваем в _flattenNumerology 👇 ---
        numerology1:
            _flattenNumerology(currentUserNumerologyData?.toFirestore()),
        numerology2: _flattenNumerology(partnerNumerologyData?.toFirestore()),
        // --- 👆 ---

        partnerName: partnerProfile.name,
        interpretations: state.aspectInterpretations,
        numerologyDescriptions: state.numerologyCompatibility,
      );

      logger.d(
          "[Compatibility] Расчет завершен. Результат: ${report.totalScore}%.");
      return report;
    } catch (e) {
      logger.d("❌ КРИТИЧЕСКАЯ ОШИБКА при расчете совместимости: $e");
      return null;
    } finally {
      emit(state.copyWith(isCalculatingCompatibility: false));
    }
  }

  // 1. Метод для загрузки интерпретаций с нового эндпоинта
  Future<void> _loadTransitInterpretations() async {
    if (state.transitInterpretations.isNotEmpty) return;
    try {
      // Этот метод нужно добавить в ApiRepository
      final interpretations = await _apiRepository.getTransitInterpretations();
      if (interpretations.isNotEmpty) {
        emit(state.copyWith(transitInterpretations: interpretations));
      }
    } catch (e) {
      logger.d('❌ Ошибка загрузки transitInterpretations: $e');
    }
  }

// 2. Главный метод для расчета космических событий

// === ДОБАВЬ ЭТОТ ВСПОМОГАТЕЛЬНЫЙ МЕТОД В AppCubit, ЕСЛИ ЕГО ЕЩЕ НЕТ ===
  Future<void> loadAspectInterpretations({bool forceReload = false}) async {
    if (state.aspectInterpretations.isNotEmpty && !forceReload) return;

    try {
      logger.d(
          "CUBIT: Загружаю ВСЕ интерпретации аспектов для языка '${currentLocale.languageCode}'...");
      final interpretations = await _apiRepository.getAspectInterpretations(
          lang: currentLocale.languageCode);
      if (interpretations.isNotEmpty) {
        emit(state.copyWith(aspectInterpretations: interpretations));
        logger.d(
            "CUBIT: ✅ Загружено ${interpretations.length} интерпретаций аспектов.");
      }
    } catch (e) {
      logger.d("❌ Ошибка загрузки aspectInterpretations: $e");
    }
  }

  // === НАЧАЛО РЕАЛИЗАЦИИ СОЗДАНИЯ КАНАЛА В CUBIT ===
  // =======================================================================

  // Метод возвращает Future<String?>. Если канал создан успешно, вернется его ID.
  // Если произошла ошибка, вернется null. UI сможет это обработать.
  Future<String?> createChannel({
    required String name,
    required String description,
    required String handle,
    required String topicKey,
    String? avatarBase64,
  }) async {
    final currentUser = state.currentUserProfile;
    if (currentUser == null) {
      emit(
          state.copyWith(channelCreationError: "Пользователь не авторизован."));
      return null;
    }

    emit(state.copyWith(isCreatingChannel: true, channelCreationError: null));

    try {
      // Ключевые слова по-прежнему генерируются на клиенте
      final keywordsMap = await _generateKeywordsForChannel(name, description);

      // Один-единственный вызов к API
      final newChannelId = await _apiRepository.createChannel(
        name: name,
        description: description,
        handle: handle,
        topicKey: topicKey,
        avatarBase64: avatarBase64,
        keywordsMap: keywordsMap,
      );

      emit(state.copyWith(isCreatingChannel: false));
      // TODO: Можно обновить список каналов, чтобы новый сразу появился
      onChannelsTabOpened();
      return newChannelId;
    } catch (e) {
      logger.d("Ошибка создания канала: $e");
      // API теперь возвращает осмысленную ошибку, ее можно показать пользователю
      String errorMessage = e.toString();
      if (e is UnknownServerException && e.message != null) {
        errorMessage = e.message!;
      }
      emit(state.copyWith(
        isCreatingChannel: false,
        channelCreationError: errorMessage,
      ));
      return null;
    }
  }

  // =======================================================================
  // === КОНЕЦ РЕАЛИЗАЦИИ СОЗДАНИЯ КАНАЛА В CUBIT ===
  // =======================================================================

  // =======================================================================
  // === НАЧАЛО РЕАЛИЗАЦИИ СОЗДАНИЯ ПОСТА В CUBIT ===
  // =======================================================================

  // =======================================================================
  // === КОНЕЦ РЕАЛИЗАЦИИ СОЗДАНИЯ ПОСТА В CUBIT ===
  // =======================================================================

  // =======================================================================
  // === НАЧАЛО РЕАЛИЗАЦИИ ЛОГИКИ PRO-СТАТУСА В CUBIT ===
  // =======================================================================

  // Эта логика теперь находится в `_listenToUserProfile`,
  // где мы вычисляем `isPro` при каждом обновлении профиля.
  // Это аналог вашего "живого" StateFlow `isProUser`.

  Future<void> activateFreeTrial() async {
    final userId = state.currentUserProfile?.id;
    final hasUsedTrial = state.currentUserProfile?.hasUsedTrial ?? false;

    if (userId == null || hasUsedTrial) {
      return;
    }

    try {
      // Вызов нашего нового API
      await _apiRepository.activateFreeTrial();
      // UI обновится автоматически, так как сервер пришлет WebSocket-событие `profile_updated`,
      // которое вызовет `forceRefreshUserProfile`.
      logger.d("Триал успешно активирован через API.");
    } catch (e) {
      logger.d("Ошибка активации триала через API: $e");
    }
  }

  // Перенос `createRobokassaPaymentUrl`
  // ВАЖНО: Храните ключи и логины в безопасном месте, а не прямо в коде!
  // Например, используя flutter_dotenv. Здесь для простоты они в коде.
  String createRobokassaPaymentUrl({
    required String amount,
    required String description,
  }) {
    final userId = state.currentUserProfile?.id;
    if (userId == null) {
      throw Exception("Пользователь не авторизован для создания платежа");
    }

    // TODO: Замените на ваши реальные данные
    const merchantLogin = "Dontisolate";
    const password_1 = "p3lLAJY3IHa4Ecl3gY9P"; // Тестовый или боевой пароль
    final orderId = DateTime.now().millisecondsSinceEpoch.toString();

    // Формируем строку для подписи: [login]:[sum]:[orderId]:[password]:[shp_uid=userId]
    final signatureString =
        '$merchantLogin:$amount:$orderId:$password_1:shp_uid=$userId';

    // Хэшируем в MD5
    final signatureBytes = utf8.encode(signatureString);
    final signature = md5.convert(signatureBytes).toString();

    // Кодируем описание для URL
    final encodedDescription = Uri.encodeComponent(description);

    // Собираем финальный URL
    final url = 'https://auth.robokassa.ru/Merchant/Index.aspx?'
        'MerchantLogin=$merchantLogin'
        '&OutSum=$amount'
        '&InvId=$orderId'
        '&Description=$encodedDescription'
        '&SignatureValue=$signature'
        '&shp_uid=$userId'
        '&IsTest=1'; // Уберите '&IsTest=1' для боевого режима

    logger.d("Сгенерирован URL Robokassa: $url");
    return url;
  }

  // ===== ДОБАВЬТЕ ЭТИ ДВА НОВЫХ МЕТОДА =====

  Future<void> startTarotQuestion(String question) async {
    // 1. Сразу показываем загрузку, чтобы интерфейс не зависал
    emit(state.copyWith(tarotReadingState: LoadingState.loading));

    final prefs = await SharedPreferences.getInstance();
    final lastUsageTs = prefs.getInt('tarot_last_usage_ts') ?? 0;
    final lastUsageTime = DateTime.fromMillisecondsSinceEpoch(lastUsageTs);
    final now = DateTime.now();

    if (state.isProUser) {
      // === ДЛЯ PRO: 1 раз в 12 часов ===
      if (now.difference(lastUsageTime).inHours < 12) {
        final hoursLeft = 12 - now.difference(lastUsageTime).inHours;
        // Возвращаем IDLE, чтобы убрать лоадер и показать попап
        emit(state.copyWith(
            tarotReadingState: LoadingState.idle,
            tarotLimitMessage: ValueWrapper('LIMIT_PRO:$hoursLeft')));
        return;
      }
    } else {
      // === ДЛЯ FREE: 1 раз в неделю (7 дней) ===
      if (now.difference(lastUsageTime).inDays < 7) {
        final daysLeft = 7 - now.difference(lastUsageTime).inDays;
        // Возвращаем IDLE, чтобы убрать лоадер и показать попап
        emit(state.copyWith(
            tarotReadingState: LoadingState.idle,
            tarotLimitMessage: ValueWrapper('LIMIT_FREE:$daysLeft')));
        return;
      }
    }
    // Сохраняем время (тоже пока отключил, чтобы тесты не сбивали таймер)
    await prefs.setInt('tarot_last_usage_ts', now.millisecondsSinceEpoch);

    try {
      // --- ПРОВЕРКА КОЛОДЫ ---
      if (state.fullTarotDeck.isEmpty) {
        logger.d("Колода пуста, загружаю...");
        await loadTarotDeck();
        if (state.fullTarotDeck.isEmpty) {
          logger.d("Не удалось загрузить колоду.");
          // Возвращаем ошибку в UI
          emit(state.copyWith(tarotReadingState: LoadingState.error));
          return;
        }
      }

      // --- ТАСУЕМ КАРТЫ ---
      final shuffledDeck = List<TarotCard>.from(state.fullTarotDeck)..shuffle();
      final readingCards = shuffledDeck.take(3).map((card) {
        return card.copyWith(isReversed: Random().nextBool());
      }).toList();

      logger.d("Карты выбраны: ${readingCards.length}. Переключаю UI...");

      // --- ОБНОВЛЯЕМ STATE ---
      emit(state.copyWith(
        // ВАЖНО: Ставим success, чтобы UI переключился с поля ввода на карты!
        tarotReadingState: LoadingState.success,
        tarotQuestion: question,
        tarotReadingCards: readingCards,
        flippedCardIds: {}, // Сбрасываем перевернутые
        tarotCombinationInterpretation: null, // Очищаем старый текст
      ));
    } catch (e) {
      logger.d("Ошибка в startTarotQuestion: $e");
      emit(state.copyWith(tarotReadingState: LoadingState.error));
    }
  }

  // Внутри AppCubit

  Future<void> loadNextPage() async {
    logger.d("--- PAGINATION: Попытка загрузить следующую страницу ---");
    logger.d("Current Offset: ${state.searchOffset}");
    logger.d(
        "IsLoading: ${state.isSearchLoading}, AllLoaded: ${state.allUsersLoaded}");

    if (state.isSearchLoading || state.allUsersLoaded) {
      logger.d(
          "--- PAGINATION: Блокировка (уже грузится или все загружено). Выход.");
      return;
    }

    emit(state.copyWith(
        isSearchLoading:
            true)); // <-- Лучше завести отдельный флаг isMoreLoading!

    try {
      // 2. Вычисляем следующий offset
      final currentOffset = state.searchOffset + 100;
      logger.d("--- PAGINATION: Запрос с offset = $currentOffset");

      // 3. Вызываем API с передачей ВСЕХ обязательных параметров из state
      final results = await _apiRepository.searchUsersSmart(
        query: state.searchText, // <-- БЕРЕМ ИЗ STATE
        lang: state.locale?.languageCode ?? 'ru', // <-- БЕРЕМ ИЗ STATE
        gender: state.genderFilter,
        minAge: state.minAgeFilter,
        maxAge: state.maxAgeFilter,
        offset: currentOffset, // <-- ПЕРЕДАЕМ OFFSET
      );
      logger.d(
          "--- PAGINATION: Получено ${results.otherResults.length} новых пользователей.");
      // 4. Проверяем, есть ли результаты
      if (results.otherResults.isEmpty && results.priorityResults.isEmpty) {
        emit(state.copyWith(allUsersLoaded: true, isSearchLoading: false));
      } else {
        // Если есть -> добавляем к текущему списку
        emit(state.copyWith(
          // Объединяем старые и новые
          otherUsers: [...state.otherUsers, ...results.otherResults],
          priorityUsers: [...state.priorityUsers, ...results.priorityResults],

          // Обновляем offset
          searchOffset: currentOffset,

          // Выключаем загрузку
          isSearchLoading: false,
        ));
      }
    } catch (e) {
      logger.d("Ошибка пагинации: $e");
      emit(state.copyWith(isSearchLoading: false));
    }
  }

// --- 👇 ПОЛНОСТЬЮ ЗАМЕНИ СТАРЫЙ МЕТОД flipTarotCard 👇 ---
  // Внутри AppCubit

  Future<void> flipTarotCard(int cardId) async {
    // 1. Если карта уже перевернута - игнорируем
    if (state.flippedCardIds.contains(cardId)) return;

    // 2. Добавляем ID карты в список перевернутых
    final newFlippedIds = Set<int>.from(state.flippedCardIds)..add(cardId);

    // Обновляем UI, чтобы карта визуально перевернулась
    emit(state.copyWith(flippedCardIds: newFlippedIds));

    // 3. Если перевернуты ВСЕ 3 карты -> Запускаем магию ИИ
    if (newFlippedIds.length == 3) {
      // Небольшая задержка, чтобы юзер успел увидеть 3-ю карту
      await Future.delayed(const Duration(milliseconds: 600));

      // А. Включаем режим "Загрузка" (появится пульсирующий камень)
      // И очищаем старый текст
      emit(state.copyWith(
        tarotReadingState: LoadingState.loading,
        tarotCombinationInterpretation: "",
      ));

      try {
        final userProfile = state.currentUserProfile;
        if (userProfile == null) throw Exception("User profile missing");

        logger.d("--- 🔮 Запуск потока Таро ---");

        // Б. Буфер для накопления текста
        final StringBuffer buffer = StringBuffer();

        // В. Подписываемся на поток с сервера
        _apiRepository
            .streamAiTarotInterpretation(
          question: state.tarotQuestion ?? "",
          cards: state.tarotReadingCards,
          lang: currentLocale.languageCode,
          isProUser: state.isProUser,
          userProfile: userProfile,
        )
            .listen(
          (chunk) {
            // Г. Пришел кусочек текста -> добавляем в буфер
            buffer.write(chunk);

            // Д. ОБНОВЛЯЕМ ЭКРАН!
            // Ставим success, чтобы UI показал текст вместо лоадера
            emit(state.copyWith(
              tarotReadingState: LoadingState.success,
              tarotCombinationInterpretation: buffer.toString(),
            ));
          },
          onError: (error) {
            logger.d("Ошибка стрима: $error");
            emit(state.copyWith(
              tarotReadingState: LoadingState.error,
              tarotCombinationInterpretation: "Связь с космосом прервалась...",
            ));
          },
          onDone: () {
            logger.d("Стрим завершен.");
            // Финализируем (можно оставить success)
            emit(state.copyWith(tarotReadingState: LoadingState.success));
          },
        );
      } catch (e) {
        logger.d("Ошибка запуска: $e");
        emit(state.copyWith(tarotReadingState: LoadingState.error));
      }
    }
  }

  void resetTarotReading() {
    emit(state.copyWith(
      tarotReadingState: LoadingState.idle,
      tarotQuestion: null,
      tarotReadingCards: [],
      flippedCardIds: {},
      tarotCombinationInterpretation: null,
    ));
  }

  void clearTarotLimitMessage() {
    emit(state.copyWith(tarotLimitMessage: const ValueWrapper(null)));
  }

  void clearRouletteLimitMessage() {
    emit(state.copyWith(rouletteLimitMessage: const ValueWrapper(null)));
  }
// ============================================

  // =======================================================================
  // === ДОБАВЬТЕ ЭТОТ МЕТОД ===
  // =======================================================================

  // Приватный метод для генерации толкования. Он у нас уже должен быть.
  // Если нет, добавьте и его.

  // Перенос `recheckProStatus`
  Future<void> recheckProStatus() async {
    final userId = state.currentUserProfile?.id;
    if (userId == null) {
      logger.d("CUBIT_DEBUG (recheck): Проверка отменена, userId is null.");
      return;
    }

    logger.d(
        "Принудительная перепроверка статуса PRO и данных профиля через API...");

    try {
      // 1. ПАРАЛЛЕЛЬНО запрашиваем и свежий профиль, и ОПИСАНИЯ
      final results = await Future.wait([
        _apiRepository.getUserProfile(userId),
        _apiRepository.getNumerologyNumberDescriptions(
            lang: currentLocale.languageCode),
        // Сюда можно добавить и другие справочники, если они нужны на этом экране
        // _apiRepository.getAstroDescriptions(lang: currentLocale.languageCode),
      ]);

      // 2. Разбираем результаты
      final freshProfile = results[0] as UserProfileCard?;
      final numerologyDescriptions = results[1] as Map<String, String>;
      // final astroDescriptions = results[2] as Map<String, dynamic>; // <-- если добавишь

      if (freshProfile == null) {
        logger.d(
            "CUBIT_DEBUG (recheck): Не удалось получить свежий профиль с сервера.");
        return;
      }

      // --- 👇 САМОЕ ГЛАВНОЕ: ОДИН emit СРАЗУ СО ВСЕМИ ДАННЫМИ 👇 ---
      // 3. Обновляем состояние приложения ОДНИМ махом, передавая и профиль, и описания
      emit(state.copyWith(
        currentUserProfile: freshProfile,
        numerologyNumberDescriptions: numerologyDescriptions,
        // astroDescriptions: astroDescriptions, // <-- если добавишь
      ));

      logger.d(
          "Статус PRO, профиль и описания обновлены. Новый статус PRO: ${freshProfile.isProUser}.");
    } catch (e) {
      logger.d("Ошибка при перепроверке статуса PRO через API: $e");
    }
  }

  void onProfileScreenOpened() {
    logger.d("CUBIT_DEBUG: Получено событие onProfileScreenOpened.");
    // Просто вызываем recheckProStatus, который уже умеет
    // загружать свежий профиль. Мы просто даем ему новый "триггер".
    recheckProStatus();
  }

  // =======================================================================
  // === КОНЕЦ РЕАЛИЗАЦИИ ЛОГИКИ PRO-СТАТУСА В CUBIT ===
  // =======================================================================
  // =======================================================================
  // === НАЧАЛО РЕАЛИЗАЦИИ РУЛЕТКИ В CUBIT ===
  // =======================================================================

  Future<void> startPartnerRoulette(bool searchInMyCountry) async {
    if (!state.isProUser) {
      const dailyLimit = 1;
      final prefs = await SharedPreferences.getInstance();
      final todayString = DateFormat('yyyy-MM-dd').format(DateTime.now());
      final lastUsageDate = prefs.getString('roulette_usage_date');
      int usageCount = prefs.getInt('roulette_usage_count') ?? 0;

      if (lastUsageDate != todayString) {
        usageCount = 0;
        await prefs.setString('roulette_usage_date', todayString);
      }
      if (usageCount >= dailyLimit) {
        emit(state.copyWith(
            rouletteLimitMessage: const ValueWrapper(
                'Вы использовали бесплатную попытку в Космической рулетке на сегодня. Безлимитные вращения доступны в PRO-версии.')));
        // ВАЖНО: для рулетки нужно еще перевести стейт в ошибку, чтобы UI обновился
        emit(state.copyWith(rouletteState: PartnerRouletteState.error));
        return;
      }
      usageCount++;
      await prefs.setInt('roulette_usage_count', usageCount);
    }
    final myProfile = state.currentUserProfile;
    if (myProfile?.natalChart == null) {
      emit(state.copyWith(rouletteState: PartnerRouletteState.noProfile));
      return;
    }

    emit(state.copyWith(
      rouletteState: PartnerRouletteState.searching,
      rouletteCandidates: [],
      rouletteWinner: null,
    ));

    try {
      logger.d("РУЛЕТКА: Запрашиваю кандидатов с сервера...");

      // 1. ОДИН вызов к API
      List<UserProfileCard> finalCandidates =
          await _apiRepository.findUsersForRoulette(searchInMyCountry);

      // Если в своей стране не нашли, пробуем по всему миру (если еще не пробовали)
      if (finalCandidates.isEmpty && searchInMyCountry) {
        logger.d(
            "РУЛЕТКА: В своей стране кандидаты не найдены. Ищем по всему миру...");
        finalCandidates = await _apiRepository.findUsersForRoulette(false);
      }

      if (finalCandidates.isEmpty) {
        logger.d("РУЛЕТКА: ❌ Кандидаты не найдены даже на сервере.");
        emit(state.copyWith(rouletteState: PartnerRouletteState.error));
        return;
      }

      logger.d(
          "РУЛЕТКА: ✅ Сервер вернул ${finalCandidates.length} кандидатов. Запускаю вращение...");
      emit(state.copyWith(
        rouletteState: PartnerRouletteState.spinning,
        rouletteCandidates: finalCandidates,
      ));
    } catch (e, stackTrace) {
      logger.d("❌ КРИТИЧЕСКАЯ ОШИБКА при запуске рулетки: $e");
      logger.d(stackTrace);
      emit(state.copyWith(rouletteState: PartnerRouletteState.error));
    }
  }

  // ===== ДОБАВЬ ЭТОТ НОВЫЙ МЕТОД =====
  void rouletteFinished(UserProfileCard winner) {
    emit(state.copyWith(
      rouletteState: PartnerRouletteState.finished,
      rouletteWinner: winner,
    ));
  }
  // ===================================

  // Сбрасывает рулетку в начальное состояние
  void resetRouletteState() {
    emit(state.copyWith(rouletteState: PartnerRouletteState.idle));
  }

  // =======================================================================
  // === КОНЕЦ РЕАЛИЗАЦИИ РУЛЕТКИ В CUBIT ===
  // =======================================================================

  // =======================================================================
  // === НАЧАЛО РЕАЛИЗАЦИИ ОБНОВЛЕНИЯ ПРОФИЛЯ В CUBIT ===
  // =======================================================================

  // Обновляет базовые данные профиля (имя, био и т.д.)
  Future<void> updateUserProfile(Map<String, dynamic> data) async {
    final currentUser = state.currentUserProfile;
    if (currentUser == null) {
      logger.d(
          "Ошибка: Профиль пользователя не загружен, обновление невозможно.");
      return;
    }
    final userId = currentUser.id;

    try {
      // Создаем копию Map для отправки на сервер
      final updatesForApi = Map<String, dynamic>.from(data);

      // --- 1. ТВОЯ ЛОГИКА ПЕРЕСЧЕТА КЛЮЧЕВЫХ СЛОВ (ОСТАЕТСЯ ЗДЕСЬ!) ---
      // Если меняется имя или био, мы должны пересчитать производные поля.
      if (updatesForApi.containsKey('name') ||
          updatesForApi.containsKey('bio')) {
        final newName = updatesForApi['name'] as String? ?? currentUser.name;
        final newBio = updatesForApi['bio'] as String? ?? currentUser.bio;

        // Твои функции-хелперы
        final bioKeywords = _generateKeywords(newBio);
        final hashtags = _extractHashtags(newBio);
        final nameKeywords = newName
            .toLowerCase()
            .split(' ')
            .where((s) => s.isNotEmpty)
            .toList();
        final searchKeywords =
            [...nameKeywords, ...bioKeywords].toSet().toList();

        // Добавляем вычисленные поля в Map для отправки на сервер
        updatesForApi['bio_hashtags'] = hashtags;
        updatesForApi['bio_keywords'] = bioKeywords;
        updatesForApi['name_lowercase'] = newName.toLowerCase();
        updatesForApi['search_keywords'] = searchKeywords;
      }

      logger.d(
          "--- AppCubit: Обновляю профиль через API. Данные: $updatesForApi");

      // --- 2. ВЫЗЫВАЕМ API REPOSITORY ---
      // Отправляем финальный Map в ApiRepository
      final updatedProfile =
          await _apiRepository.updateUserProfile(userId, updatesForApi);

      // --- 3. ОБНОВЛЯЕМ STATE ---
      // ApiRepository вернул нам самый свежий профиль из базы.
      // Используем его, чтобы обновить состояние приложения.
      emit(state.copyWith(currentUserProfile: updatedProfile));

      logger.d(
          "Профиль успешно обновлен через API и состояние AppCubit синхронизировано.");
    } catch (e) {
      logger.d("!!! Ошибка обновления профиля в AppCubit: $e");
      emit(state.copyWith(
        snackBarMessage: 'Не удалось сохранить изменения. Попробуйте позже.',
        snackBarIsError: true,
      ));
      throw e;
    }
  }

  // Обновляет дату рождения и пересчитывает все зависимые данные
  Future<bool> updateBirthDate(DateTime newBirthDate) async {
    final userId = state.currentUserProfile?.id;
    if (userId == null) return false;

    // Вся логика пересчета карт и нумерологии ДОЛЖНА БЫТЬ на сервере.
    // Клиент просто отправляет новые данные.
    // Но пока калькуляторы на Dart, мы делаем это здесь.
    try {
      // ... (твой код пересчета `newChart`, `newNumerology`)

      final updates = {
        'birthDateMillis': newBirthDate.millisecondsSinceEpoch,
        'age': DateTime.now().year - newBirthDate.year,
        // 'natalChart': newChart.toFirestore(),
        // 'sunSign': newChart.sunSign,
        // 'numerologyData': newNumerology.toFirestore(),
      };

      // Используем наш универсальный метод API
      await updateUserProfile(updates);

      // UI обновится автоматически, так как updateUserProfile обновляет стейт
      return true;
    } catch (e) {
      logger.d("Ошибка обновления даты рождения через API: $e");
      return false;
    }
  }

  // Обновляет аватар пользователя
  Future<bool> updateAvatar(String imageBase64) async {
    final userId = state.currentUserProfile?.id;
    if (userId == null) return false;

    // 1. Оптимистичное обновление (сразу показываем юзеру)
    final tempAvatarUrl = 'data:image/jpeg;base64,$imageBase64';
    final optimisticProfile =
        state.currentUserProfile?.copyWith(avatar: tempAvatarUrl);
    emit(state.copyWith(currentUserProfile: optimisticProfile));

    try {
      // 2. Грузим в облако
      final imageUrl =
          await _cloudinaryService.uploadBase64Image(base64String: imageBase64);
      if (imageUrl == null) throw Exception("Cloudinary upload failed");

      // 3. Отправляем URL на сервер и ЖДЕМ обновленный профиль
      // Важно: мы НЕ вызываем updateUserProfile, а делаем запрос напрямую через репозиторий,
      // чтобы контролировать обновление стейта здесь.
      final updatedProfile = await _apiRepository
          .updateUserProfile(userId, {'avatarUrl': imageUrl});

      // 4. Обновляем стейт финальными данными от сервера
      emit(state.copyWith(currentUserProfile: updatedProfile));

      logger.d("Аватар успешно обновлен. URL: $imageUrl");
      return true;
    } catch (e) {
      logger.d("Ошибка обновления аватара: $e");
      // Откат (возвращаем старый профиль, если он был сохранен, или просто перезагружаем)
      // Лучше всего просто перезагрузить профиль с сервера
      if (userId != null) _loadUserProfile(userId);
      return false;
    }
  }

  // =======================================================================
  // === КОНЕЦ РЕАЛИЗАЦИИ ОБНОВЛЕНИЯ ПРОФИЛЯ В CUBIT ===
  // =======================================================================

  // Этот метод вызывается из UI, чтобы "пнуть" процесс инициализации,
  // если он еще не начался (например, если authStateChanges сработал слишком быстро)
  void triggerInitialization() {
    final user = auth.currentUser;
    if (user != null && state.currentUserProfile == null) {
      logger.d("Инициализация вызвана вручную из UI.");
    }
  }

  // --- Обновляем loadUserPhotos ---
  Future<void> loadUserPhotos(String userId) async {
    if (state.viewedUserPhotosStatus == LoadingState.loading) return;
    emit(state.copyWith(
        viewedUserPhotos: [], viewedUserPhotosStatus: LoadingState.loading));
    try {
      final photos =
          await _apiRepository.getUserPhotos(userId); // <-- Вызов API
      emit(state.copyWith(
        viewedUserPhotos:
            photos, // photos уже имеет тип List<Map<String, String>>
        viewedUserPhotosStatus: LoadingState.success,
      ));
    } catch (e) {
      emit(state.copyWith(viewedUserPhotosStatus: LoadingState.error));
    }
  }

// --- Обновляем addUserPhoto, чтобы он работал с Map ---
  Future<void> addUserPhoto(String base64) async {
    final userId = auth.currentUser?.uid;
    if (userId == null) return;
    try {
      // Шаг 1: Загружаем в Cloudinary
      final imageUrl =
          await _cloudinaryService.uploadBase64Image(base64String: base64);
      if (imageUrl == null) throw Exception("Upload failed");

      // Шаг 2: Отправляем URL на наш сервер
      await _apiRepository.addUserPhoto(imageUrl);

      // Шаг 3: Перезагружаем список фото, чтобы увидеть новое
      await loadUserPhotos(userId);
    } catch (e) {
      logger.d("Ошибка добавления фото в AppCubit: $e");
    }
  }

// --- НОВЫЙ МЕТОД для удаления фото ---
  Future<void> deleteUserPhoto(String photoId) async {
    final userId = auth.currentUser?.uid;
    if (userId == null) return;
    try {
      // Оптимистичное обновление UI
      final updatedPhotos =
          List<Map<String, String>>.from(state.viewedUserPhotos)
            ..removeWhere((photo) => photo['id'] == photoId);
      emit(state.copyWith(viewedUserPhotos: updatedPhotos));

      // Вызов API в фоне
      await _apiRepository.deleteUserPhoto(photoId);

      // recheckProStatus() больше не нужен, т.к. сервер пришлет WS-уведомление
      // об обновлении профиля (photo_count), и UI обновится сам.
    } catch (e) {
      logger.d("Ошибка удаления фото: $e");
      await loadUserPhotos(userId); // Откат
    }
  }

// === ОБНОВЛЕНИЕ: Очищаем фото при закрытии профиля ===

  // ЗАМЕНЯЕМ ЗАГЛУШКУ `onLikeClicked`
  Future<void> onLikeClicked(String otherUserId) async {
    final currentUserId = state.currentUserProfile?.id;
    if (currentUserId == null) return;

    // Оптимистичное обновление
    final newLikedIds = Set<String>.from(state.likedUserIds)..add(otherUserId);
    emit(state.copyWith(likedUserIds: newLikedIds));

    try {
      // Один вызов к API
      final result = await _apiRepository.likeUser(otherUserId);
      final bool isMatch = result['isMatch'] ?? false;

      // Логика Push-уведомлений теперь полностью на сервере, здесь она не нужна.
      // Профиль обновится автоматически через WebSocket.

      if (isMatch) {
        logger.d("!!! МЭТЧ с $otherUserId !!!");
        // Можно дополнительно что-то сделать, например, показать диалог мэтча
      } else {
        logger.d("Лайк успешно отправлен $otherUserId");
      }
    } catch (e) {
      logger.d("!!! Ошибка при отправке лайка: $e");
      // Откат UI
      final revertedLikedIds = Set<String>.from(state.likedUserIds)
        ..remove(otherUserId);
      emit(state.copyWith(likedUserIds: revertedLikedIds));
    }
  }

  // ДОБАВЛЯЕМ НОВЫЕ МЕТОДЫ

  // ===== ПОЛНОСТЬЮ ЗАМЕНИ СТАРЫЙ МЕТОД =====
  // Загружает полный список тех, кто нас лайкнул
  Future<void> loadUsersWhoLikedMe() async {
    if (state.likesYouLoadingState == LoadingState.loading) return;
    emit(state.copyWith(likesYouLoadingState: LoadingState.loading));
    try {
      // Один вызов к API
      final users = await _apiRepository.getUsersWhoLikedMe();
      emit(state.copyWith(
        usersWhoLikedMe: users,
        likesYouLoadingState: LoadingState.success,
      ));
      logger.d("✅ Загружен список 'Кто лайкнул': ${users.length} чел.");
    } catch (e) {
      logger.d("❌ Ошибка загрузки лайкнувших: $e");
      emit(state.copyWith(likesYouLoadingState: LoadingState.error));
    }
  }

  // ===== ДОБАВЬ ЭТОТ НОВЫЙ МЕТОД =====
  // Он будет вызываться при каждом обновлении профиля, чтобы обновить счетчик
  void _updateLikesYouCount(UserProfileCard? profile) {
    // <-- ИЗМЕНИ ЗДЕСЬ, ДОБАВЬ ?
    // ===== ДОБАВЬ ЭТУ ПРОВЕРКУ ВНАЧАЛЕ =====
    if (profile == null) return;
    // ======================================
    // Получаем ID тех, кого мы уже видели (просмотрели на экране "Вам симпатии")
    // Для этого нам понадобится SharedPreferences
    SharedPreferences.getInstance().then((prefs) {
      final seenLikes = prefs.getStringList('seen_likes_ids') ?? [];

      // Считаем количество "новых" лайков
      final allLikes = profile.likedByUsers;
      final newLikesCount =
          allLikes.where((id) => !seenLikes.contains(id)).length;

      // Обновляем стейт. ВАЖНО: friendRequestCount - это неправильное поле, давай добавим новое!
      // Сначала нужно добавить поле `newLikesCount` в AppState
      emit(state.copyWith(newLikesCount: newLikesCount));
    });
  }

  // Скрывает профиль из списка "Likes You"
  Future<void> hideLikedByUser(String userIdToHide) async {
    final currentUserId = state.currentUserProfile?.id;
    if (currentUserId == null) return;

    // 1. Оптимистичное обновление UI
    final originalList = List<UserProfileCard>.from(state.usersWhoLikedMe);
    final newList =
        originalList.where((user) => user.id != userIdToHide).toList();
    emit(state.copyWith(usersWhoLikedMe: newList));

    try {
      // 2. Отправляем запрос в фоне
      await _apiRepository.hideLikedByUser(userIdToHide);
    } catch (e) {
      logger.d("Ошибка скрытия лайка: $e");
      // 3. Откат UI в случае ошибки
      emit(state.copyWith(
        usersWhoLikedMe: originalList,
        snackBarMessage: 'Не удалось обновить список. Попробуйте позже.',
        snackBarIsError: true,
      ));
    }
  }

  void onOracleTabOpened() {
    findPartnerOfTheDay();
    loadTarotDeck();
    loadHoroscope();
    calculateFocusOfTheDay();
    loadHybridForecast();
    loadGeomagneticForecast();
    drawCardOfTheDay();
    loadDailyForecast();
    _loadAstroCommunicationTips(); // Добавляем вызов
  }

  Future<void> updateNotificationSettings({
    required BuildContext context,
    bool? horoscope,
    bool? focusOfTheDay,
    bool? hybridForecast,
    bool? geomagneticAlerts,
    bool? cardOfTheDay,
    bool? partnerOfTheDay,
  }) async {
    final currentUser = state.currentUserProfile;
    if (currentUser == null) return;

    // --- 1. СОХРАНЯЕМ СТАРОЕ СОСТОЯНИЕ ДЛЯ ВОЗМОЖНОГО ОТКАТА ---
    final oldSettings =
        currentUser.settings?.notifications ?? const NotificationSettings();

    // --- 2. СОЗДАЕМ НОВЫЕ НАСТРОЙКИ И ОБНОВЛЕННЫЙ ПРОФИЛЬ ---
    final newSettings = oldSettings.copyWith(
      horoscope: horoscope,
      focusOfTheDay: focusOfTheDay,
      hybridForecast: hybridForecast,
      geomagneticAlerts: geomagneticAlerts,
      cardOfTheDay: cardOfTheDay,
      partnerOfTheDay: partnerOfTheDay,
    );
    // Важно создать новый объект UserSettings, а затем новый UserProfileCard
    final updatedSettingsObject =
        (currentUser.settings ?? const UserSettings()).copyWith(
      notifications: newSettings,
    );
    final optimisticProfile =
        currentUser.copyWith(settings: updatedSettingsObject);

    // --- 3. НЕМЕДЛЕННО ОБНОВЛЯЕМ UI (ОПТИМИСТИЧНОЕ ОБНОВЛЕНИЕ) ---
    // Этот emit мгновенно перерисует BlocBuilder с новым состоянием тумблера.
    emit(state.copyWith(currentUserProfile: optimisticProfile));

    // --- 4. ГОТОВИМ И ПОКАЗЫВАЕМ SNACKBAR ---
    String notificationType = "";
    bool isEnabled = false;

    if (horoscope != null) {
      notificationType = "Гороскоп";
      isEnabled = horoscope;
    }
    if (cardOfTheDay != null) {
      notificationType = "Карта Дня";
      isEnabled = cardOfTheDay;
    }
    if (focusOfTheDay != null) {
      notificationType = "Фокус Дня";
      isEnabled = focusOfTheDay;
    }
    if (hybridForecast != null) {
      notificationType = "Персональный прогноз";
      isEnabled = hybridForecast;
    }
    if (geomagneticAlerts != null) {
      notificationType = "Оповещения о бурях";
      isEnabled = geomagneticAlerts;
    }

    final message = isEnabled
        ? 'Уведомления "$notificationType" включены.'
        : 'Уведомления "$notificationType" выключены.';
    showSnackBar(context, message);

    // --- 5. В ФОНОВОМ РЕЖИМЕ ВЫПОЛНЯЕМ ВСЮ АСИНХРОННУЮ РАБОТУ ---
    try {
      // 5a. Асинхронно планируем или отменяем уведомления
      List<Future> tasks = [];
      if (horoscope != null) {
        tasks.add(horoscope
            ? loadHoroscope(forceSchedule: true)
            : _scheduler!.cancelNotification(1));
      }
      if (cardOfTheDay != null) {
        tasks.add(cardOfTheDay
            ? drawCardOfTheDay(forceSchedule: true)
            : _scheduler!.cancelNotification(5));
      }
      if (focusOfTheDay != null) {
        tasks.add(focusOfTheDay
            ? calculateFocusOfTheDay(forceSchedule: true)
            : _scheduler!.cancelNotification(2));
      }
      if (hybridForecast != null) {
        tasks.add(hybridForecast
            ? loadHybridForecast(forceSchedule: true)
            : _scheduler!.cancelNotification(3));
      }

      // Дожидаемся завершения планирования/отмены
      await Future.wait(tasks);

      // 5b. Асинхронно сохраняем в Firestore
      await updateUserProfile({
        'settings': updatedSettingsObject.toMap(),
      });
      logger.d("✅ Настройки уведомлений успешно сохранены в Firestore.");
    } catch (e) {
      logger.d("❌ Ошибка сохранения/планирования: $e. Откатываю UI.");

      // --- 6. ОТКАТ UI В СЛУЧАЕ ЛЮБОЙ ОШИБКИ ---
      // Возвращаем в state профиль со старыми настройками
      emit(state.copyWith(
        currentUserProfile: currentUser.copyWith(
          settings: (currentUser.settings ?? const UserSettings()).copyWith(
            notifications: oldSettings,
          ),
        ),
      ));

      if (context.mounted) {
        showSnackBar(context, "Ошибка. Не удалось сохранить настройки.",
            isError: true);
      }
    }
  }

  // Внутри класса AppCubit в файле lib/cubit/app_cubit.dart

  Future<void> loadHoroscope({bool forceSchedule = false}) async {
    // --- 👇 ШАГ 1: ДОБАВЛЯЕМ ЛОГИ ДЛЯ ДИАГНОСТИКИ 👇 ---
    logger.d("\n--- 🔬 ДИАГНОСТИКА ГОРОСКОПА 🔬 ---");

    final sunSign = state.currentUserProfile?.sunSign;

    if (sunSign == null || sunSign.isEmpty) {
      logger.d(
          "--- 🔬 1. ОТМЕНА: Знак зодиака (sunSign) в профиле пользователя не найден или пуст.");
      emit(state.copyWith(
          horoscopeState:
              const HoroscopeState(error: "Ваш знак зодиака не определен.")));
      return;
    }
    logger.d("--- 🔬 1. Знак зодиака найден: '$sunSign'.");

    if (state.horoscopeState.isLoading && !forceSchedule) {
      logger.d("--- 🔬 2. ОТМЕНА: Гороскоп уже находится в процессе загрузки.");
      return;
    }
    logger.d("--- 🔬 2. Проверка на текущую загрузку пройдена.");

    final bool notificationsEnabled =
        state.currentUserProfile?.settings?.notifications?.horoscope ?? true;
    logger.d("--- 🔬 3. Уведомления включены: $notificationsEnabled.");

    emit(state.copyWith(
      horoscopeState: const HoroscopeState(isLoading: true, error: null),
    ));
    logger.d(
        "--- 🔬 4. Установлено состояние 'isLoading: true'. Начинаю запрос к API...");

    try {
      final languageCode = currentLocale.languageCode;
      logger.d(
          "--- 🔬 5. Язык для запроса: '$languageCode'. Вызываю ApiRepository...");

      // --- 👇 ШАГ 2: ВЫЗОВ API (ОСТАЕТСЯ БЕЗ ИЗМЕНЕНИЙ) 👇 ---
      final allHoroscopes = await _apiRepository.getAllHoroscopes(languageCode);
      logger.d(
          "--- 🔬 6. API ответил. Всего получено ${allHoroscopes.length} гороскопов.");

      final userHoroscope = allHoroscopes[sunSign];

      if (userHoroscope != null) {
        logger.d(
            "--- 🔬 7. УСПЕХ: Гороскоп для знака '$sunSign' найден в ответе API.");
        logger.d("   - Текст: '${userHoroscope.common.substring(0, 50)}...'");

        emit(state.copyWith(
          horoscope: userHoroscope,
          horoscopeState: HoroscopeState(
            isLoading: false,
            horoscopeText: userHoroscope.common,
          ),
        ));
        logger.d("--- 🔬 8. Состояние обновлено, загрузка завершена.");

        // --- ЛОГИКА ПЛАНИРОВАНИЯ УВЕДОМЛЕНИЯ (оставляем как есть) ---
        if (notificationsEnabled || forceSchedule) {
          _scheduler?.scheduleDailyNotification(
            id: 1,
            title: '✨ Ваш гороскоп на сегодня, ${sunSign.capitalizeFirst()}!',
            body: userHoroscope.common.length > 100
                ? '${userHoroscope.common.substring(0, 100)}...'
                : userHoroscope.common,
            hour: 9,
            minute: 0,
          );
          logger.d("--- 🔬 9. Уведомление запланировано.");
        } else {
          logger.d(
              "--- 🔬 9. Планирование уведомления пропущено (отключено в настройках).");
        }
      } else {
        logger.d(
            "--- 🔬 7. ОШИБКА: Гороскоп для знака '$sunSign' НЕ НАЙДЕН в ответе от API.");
        // Это может случиться, если на сервере в ключе 'Aries', а в профиле 'aries'
        throw Exception(
            "Horoscope for sign '$sunSign' not found in API response.");
      }
    } catch (e) {
      logger.d("--- 🔬 КРИТИЧЕСКАЯ ОШИБКА при загрузке гороскопа: $e");
      emit(state.copyWith(
        horoscopeState: HoroscopeState(
          isLoading: false,
          error: "Не удалось загрузить гороскоп. Попробуйте обновить.",
        ),
      ));
    }
  }

  // ===== ПОЛНОСТЬЮ ЗАМЕНИ СТАРЫЙ МЕТОД askOracle НА ЭТОТ =====
  Future<void> askOracle(String question) async {
    logger.d("\n--- 🔬 LOG: 2. CUBIT: Получен вопрос Оракулу: '$question' ---");

    // --- ЛОГИКА ПРОВЕРКИ ЛИМИТОВ ---
    if (state.isProUser) {
      logger.d("--- 🔬 LOG: Пользователь PRO. Лимиты не применяются.");
    } else {
      const dailyLimit = 2;
      final prefs = await SharedPreferences.getInstance();
      final todayString = DateFormat('yyyy-MM-dd').format(DateTime.now());
      final lastUsageDate = prefs.getString('oracle_last_usage_date');
      int usageCount = prefs.getInt('oracle_usage_count') ?? 0;

      if (lastUsageDate != todayString) {
        logger.d("--- 🔬 LOG: Новый день! Сбрасываю счетчик запросов Оракула.");
        usageCount = 0;
        await prefs.setString('oracle_last_usage_date', todayString);
      }
      if (usageCount >= dailyLimit) {
        logger.d("--- 🔬 LOG: ❌ Дневной лимит ($dailyLimit) исчерпан.");
        emit(state.copyWith(
            oracleLimitMessage: const ValueWrapper(
                'Вы использовали 2 бесплатных вопроса на сегодня. Безлимитные ответы доступны в PRO-версии.')));
        return;
      }
      usageCount++;
      await prefs.setInt('oracle_usage_count', usageCount);
      logger.d("--- 🔬 LOG: Запрос #$usageCount/$dailyLimit на сегодня.");
    }
    // --- КОНЕЦ ПРОВЕРКИ ЛИМИТОВ ---

    emit(state.copyWith(
        isOracleAnswering: true, oracleAnswer: const ValueWrapper(null)));

    try {
      var themes = state.oracleThemes;
      if (themes.isEmpty) {
        logger.d(
            "--- 🔬 LOG: 2a. CUBIT: Кэш тем пуст, загружаю из репозитория...");
        themes = await _apiRepository.getOracleThemes();
        emit(state.copyWith(oracleThemes: themes));
      } else {
        logger.d(
            "--- 🔬 LOG: 2a. CUBIT: Темы взяты из кэша стейта. Количество: ${themes.length}");
      }

      if (themes.isEmpty)
        throw Exception("Темы Оракула так и не были загружены.");

      // ===== НАЧАЛО ВОССТАНОВЛЕННОГО БЛОКА =====
      final langCode =
          WidgetsBinding.instance.platformDispatcher.locale.languageCode;
      logger
          .d("--- 🔬 LOG: 2b. CUBIT: Определен язык пользователя: '$langCode'");

      final questionInLowerCase = question.toLowerCase();
      OracleTheme? matchedTheme;

      for (final theme in themes) {
        final keywords =
            theme.keywordsByLang[langCode] ?? theme.keywordsByLang['en'] ?? [];
        for (final keyword in keywords) {
          if (questionInLowerCase.contains(keyword)) {
            matchedTheme = theme;
            break;
          }
        }
        if (matchedTheme != null) break;
      }

      String finalAnswer;
      if (matchedTheme != null) {
        logger.d(
            "--- 🔬 LOG: 2c. CUBIT: ✅ Найдена тема по ключевым словам: '${matchedTheme.id}'");
        final answersForLang = matchedTheme.answersByLang[langCode] ??
            matchedTheme.answersByLang['en'] ??
            [];
        logger.d(
            "--- 🔬 LOG: 2d. CUBIT: Для этой темы и языка найдено ${answersForLang.length} вариантов ответа.");
        if (answersForLang.isNotEmpty) {
          finalAnswer = (answersForLang..shuffle()).first.text;
        } else {
          finalAnswer = "Нет ответов для темы '${matchedTheme.id}'";
        }
      } else {
        logger.d(
            "--- 🔬 LOG: 2c. CUBIT: ⚠️ Тема не найдена. Использую тему 'default'.");
        final defaultTheme = themes.firstWhere((t) => t.id == 'default',
            orElse: () => themes.first);
        final answersForLang = defaultTheme.answersByLang[langCode] ??
            defaultTheme.answersByLang['en'] ??
            [];
        logger.d(
            "--- 🔬 LOG: 2d. CUBIT: Для темы 'default' найдено ${answersForLang.length} вариантов ответа.");
        if (answersForLang.isNotEmpty) {
          finalAnswer = (answersForLang..shuffle()).first.text;
        } else {
          finalAnswer = "Нет ответов для темы 'default'";
        }
      }
      // ===== КОНЕЦ ВОССТАНОВЛЕННОГО БЛОКА =====

      logger.d(
          "--- 🔬 LOG: 2e. CUBIT: 🎯 ВЫБРАН ФИНАЛЬНЫЙ ОТВЕТ: '$finalAnswer'");

      await Future.delayed(const Duration(seconds: 2));

      logger.d(
          "--- 🔬 LOG: 2f. CUBIT: Выпускаю стейт: isOracleAnswering: false, oracleAnswer: '$finalAnswer'");
      emit(state.copyWith(
          isOracleAnswering: false, oracleAnswer: ValueWrapper(finalAnswer)));
    } catch (e) {
      logger.d("--- 🔬 LOG: 2. CUBIT: ❌ КРИТИЧЕСКАЯ ОШИБКА в askOracle: $e");
      emit(state.copyWith(
          isOracleAnswering: false,
          oracleAnswer: const ValueWrapper("Ошибка...")));
    }
  }

  // ===== ДОБАВЬ ЭТОТ НОВЫЙ МЕТОД =====
  // Он нужен, чтобы убрать сообщение о лимите после того, как пользователь закроет диалог
  void clearOracleLimitMessage() {
    emit(state.copyWith(oracleLimitMessage: const ValueWrapper(null)));
  }

// Также добавим лог в resetOracle
  void resetOracle() {
    logger
        .d("--- 🔬 LOG: 4. CUBIT: Вызван resetOracle. Сбрасываю ответ в null.");
    // ЗАМЕНА. Оборачиваем null, чтобы copyWith его не проигнорировал.
    emit(state.copyWith(
      oracleAnswer: const ValueWrapper(null),
      isOracleAnswering: false,
    ));
  }

  Future<void> findPartnerOfTheDay({bool forceSchedule = false}) async {
    final myProfile = state.currentUserProfile;
    if (myProfile == null || !myProfile.isProUser) {
      // Проверки на PRO и наличие профиля остаются
      return;
    }
    if (state.partnerLoadingState == LoadingState.loading && !forceSchedule) {
      return;
    }

    emit(state.copyWith(partnerLoadingState: LoadingState.loading));

    try {
      // Один единственный вызов к нашему умному API
      final partner = await _apiRepository.findPartnerOfTheDay();

      if (partner != null) {
        logger.d("--- 🦋 ПАРТНЕР ДНЯ: ✅ УСПЕХ! Сервер нашел: ${partner.name}");

        // Логика планирования уведомления остается на клиенте, это нормально
        final bool notificationsEnabled =
            myProfile.settings?.notifications?.partnerOfTheDay ?? true;
        if (notificationsEnabled || forceSchedule) {
          _scheduler?.scheduleDailyNotification(
            id: 6, // Уникальный ID для уведомления "Партнер Дня"
            title: '💖 Ваш Партнер Дня ждет вас!',
            body:
                'Найден пользователь ${partner.name} с высокой совместимостью. Откройте приложение, чтобы узнать больше!',
            hour: 10, // Время отправки, например, 10 утра
            minute: 0,
          );
        }

        emit(state.copyWith(
          partnerOfTheDay: partner,
          partnerLoadingState: LoadingState.success,
        ));
      } else {
        logger
            .d("--- 🦋 ПАРТНЕР ДНЯ: ⚠️ Сервер не нашел подходящих кандидатов.");
        emit(state.copyWith(partnerLoadingState: LoadingState.notFound));
      }
    } catch (e) {
      logger.d("--- 🦋 ПАРТНЕР ДНЯ: ❌ КРИТИЧЕСКАЯ ОШИБКА: $e");
      emit(state.copyWith(partnerLoadingState: LoadingState.error));
    }
  }

  Future<void> _loadNumerologyDescriptions({bool forceReload = false}) async {
    // <-- Добавляем forceReload
    if (state.numerologyCompatibility.isNotEmpty && !forceReload) return;

    try {
      final descriptions = await _apiRepository.getNumerologyCompatibility(
          lang: currentLocale.languageCode); // <-- Передаем язык
      // Теперь `descriptions` это Map<String, String>, и мы сохраняем его в state
      emit(state.copyWith(numerologyCompatibility: descriptions));
    } catch (e) {
      logger.d("❌ Ошибка загрузки нумерологических описаний: $e");
    }
  }

  // Вызываем этот метод из других методов (sendMessage, onLikeClicked, и т.д.)

  @override
  void didChangeAccessibilityFeatures() {
    // TODO: implement didChangeAccessibilityFeatures
  }

  @override
  void didChangeLocales(List<Locale>? locales) {
    // TODO: implement didChangeLocales
  }

  @override
  void didChangeMetrics() {
    // TODO: implement didChangeMetrics
  }

  @override
  void didChangePlatformBrightness() {
    // TODO: implement didChangePlatformBrightness
  }

  @override
  void didChangeTextScaleFactor() {
    // TODO: implement didChangeTextScaleFactor
  }

  @override
  void didChangeViewFocus(ViewFocusEvent event) {
    // TODO: implement didChangeViewFocus
  }

  @override
  void didHaveMemoryPressure() {
    // TODO: implement didHaveMemoryPressure
  }

  void handleUpdateBackGestureProgress(PredictiveBackEvent backEvent) {
    // TODO: implement handleUpdateBackGestureProgress
  }
}
