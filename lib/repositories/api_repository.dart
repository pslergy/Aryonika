// lib/repositories/api_repository.dart

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:http/http.dart' as http;
import 'package:http/http.dart' as _apiService;
import 'package:lovequest/cubit/app_cubit.dart';
import 'package:lovequest/repositories/horoscope_repository.dart';

import 'package:lovequest/src/data/models/aspect_interpretation.dart';
import 'package:lovequest/src/data/models/astrology/daily_forecast.dart';
import 'package:lovequest/src/data/models/bazi_report.dart';
import 'package:lovequest/src/data/models/channel.dart';
import 'package:lovequest/src/data/models/chat_list_item.dart';
import 'package:lovequest/src/data/models/chat_room.dart';
import 'package:lovequest/src/data/models/chinese_zodiac_report.dart';
import 'package:lovequest/src/data/models/cosmic_event.dart';

// --- 👇 ИСПРАВЛЕНИЕ: Добавляем недостающие импорты 👇 ---
import 'package:lovequest/src/data/models/feed_event.dart';
import 'package:lovequest/src/data/models/jyotish_report.dart';
import 'package:lovequest/src/data/models/moon_rhythm.dart';
import 'package:lovequest/src/data/models/oracle_theme.dart';
import 'package:lovequest/src/data/models/post.dart';
import 'package:lovequest/src/data/models/search_results.dart';
import 'package:lovequest/src/data/models/tarot_card.dart';
import 'package:lovequest/src/data/models/user_profile_card.dart';

import '../services/logger_service.dart';
import '../src/data/models/channel_preview.dart';
import '../src/data/models/comment.dart';
import '../src/data/models/daily_hybrid_forecast.dart';
import '../src/data/models/message.dart' as chat_models;
import '../src/data/models/numerology_report.dart';
import '../src/data/models/palmistry_models.dart';
import '../src/data/numerology_daily_texts.dart';
import '../widgets/search/cosmic_web/cosmic_web_user_node.dart';
import 'package:shared_preferences/shared_preferences.dart';

// --- 👆 Конец исправления 👆 ---

class UserNotAuthorizedException implements Exception {}
class UnknownServerException implements Exception {
  final String? message;
  UnknownServerException([this.message]);
}
class ServerException implements Exception {
  final int statusCode;
  ServerException(this.statusCode);
}



class ApiRepository {
  // --- 👇 ШАГ 1: ПРАВИЛЬНЫЙ SINGLETON 👇 ---

  // Приватный конструктор
  ApiRepository._internal();

  // Единственный экземпляр класса
  static final ApiRepository _instance = ApiRepository._internal();

  // Фабричный конструктор, который ВСЕГДА возвращает один и тот же экземпляр
  factory ApiRepository() {
    return _instance;
  }


  // --- IP-адрес твоего локального сервера ---
  // Убедись, что этот IP-адрес правильный для твоей локальной сети.
  // В командной строке Windows выполни ipconfig и найди "IPv4-адрес".
  static String get baseUrl {
    if (kDebugMode) {
      // --- 1. СНАЧАЛА проверяем Web ---
      // Если мы в браузере, то обращение к Platform.isAndroid вызовет краш.
      // Поэтому kIsWeb должна быть первой!
      if (kIsWeb) {
        return 'http://localhost:3000';
      }

      // --- 2. Теперь безопасно проверяем мобилки (это уже точно не Web) ---
      if (Platform.isAndroid) {
        return 'http://192.168.10.220:3000';
      }

      // iOS, Windows, macOS
      return 'http://localhost:3000';
    }

    // Продакшн
    return 'https://api.psylergy.com';
  }

  String? _cachedToken;

  Future<String?> get jwtToken async {
    if (_cachedToken != null) return _cachedToken;
    final prefs = await SharedPreferences.getInstance();
    _cachedToken = prefs.getString('jwt_token');
    return _cachedToken;
  }

  Future<void> _saveJwtToken(String? token) async {
    _cachedToken = token;
    final prefs = await SharedPreferences.getInstance();
    if (token != null) {
      await prefs.setString('jwt_token', token);
    } else {
      await prefs.remove('jwt_token');
    }
  }

  // Удаляет JWT при выходе
  Future<void> clearToken() async {
    await _saveJwtToken(null);
  }

  // Новый метод для входа через НАШ API
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      await _saveJwtToken(data['token']);

      // --- 👇 ИСПРАВЛЕНИЕ ЗДЕСЬ 👇 ---
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_id', data['userId']);
      // --- 👆 КОНЕЦ ИСПРАВЛЕНИЯ 👆 ---

      return data;
    } else {
      final error = json.decode(response.body);
      throw Exception(error['error'] ?? 'Invalid credentials');
    }
  }

  Future<void> verifyEmailCode(String code) async {
    // Используем _post, который сам подставит JWT-токен пользователя
    await _post('/api/auth/verify-code', body: {'code': code});
    // Если сервер вернет ошибку (400, 500), _post сам выбросит Exception.
    // Если вернет 200 OK, метод просто успешно завершится.
  }

  Future<void> deleteChat(String chatId) async {
    await _delete('/chats/$chatId');
  }


  // Метод выхода
  Future<void> logout() async {
    await _saveJwtToken(null);
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_id');
    // Также нужно разлогиниться из Firebase, если сессия была
    if (FirebaseAuth.instance.currentUser != null) {
      await FirebaseAuth.instance.signOut();
    }
  }

  Future<Map<String, String>> getJyotishDescriptions(String lang) async {
    final response = await _get('/jyotish/descriptions', queryParameters: {'lang': lang});
    final Map<String, dynamic> jsonMap = json.decode(utf8.decode(response.bodyBytes));
    // Приводим Map<String, dynamic> к Map<String, String>
    return jsonMap.map((key, value) => MapEntry(key, value.toString()));
  }




  Future<UserProfileCard> updateUserProfile(String userId, Map<String, dynamic> data) async {
    // Используем наш универсальный метод _put
    final response = await _put('/users/$userId', body: data);

    // Сервер в ответ присылает обновленный профиль, парсим его
    final updatedProfileJson = json.decode(utf8.decode(response.bodyBytes));

    // Возвращаем свежий, полный объект UserProfileCard
    return UserProfileCard.fromJson(updatedProfileJson);
  }

  Future<String?> getPersonalTarotInterpretation({
    required String cardThemeKey,
    required bool isReversed,
    required List<String> aspectKeys,
    required String lang,
  }) async {
    final response = await _post('/tarot/personal-interpretation', body: {
      'cardThemeKey': cardThemeKey,
      'isReversed': isReversed,
      'aspectKeys': aspectKeys,
      'lang': lang,
    });
    // Сервер может вернуть null, если ничего не найдено
    final body = json.decode(response.body);
    return body['personalText'];
  }

  Future<Map<String, String>> getNumerologyForecasts(String lang) async {
    // Безопасный выбор языка (по умолчанию 'en', если нет перевода)
    const supportedLangs = ['ru', 'en', 'de', 'fr', 'es', 'ko', 'zh', 'hi'];
    final safeLang = supportedLangs.contains(lang) ? lang : 'en';

    // Преобразуем сложную карту в простую Map<String, String> для конкретного языка
    return numerologyDailyForecasts.map((key, translations) {
      return MapEntry(key, translations[safeLang] ?? translations['en'] ?? 'No forecast');
    });
  }
  Future<void> updateChatSettings(String chatId, int? ttlMinutes) async {
    await _put(
      '/chats/$chatId/settings',
      body: {'ttlMinutes': ttlMinutes},
    );
  }



  Future<List<Channel>> getChannels({
    required String filter,
    String? languageFilter,
  }) async {
    try {
      // --- 👇 ДОБАВЬ ЭТИ ЛОГИ 👇 ---
      logger.d("--- 📢 [API_REPO /channels] 1. Выполняю GET запрос...");
      final response = await _get('/channels', queryParameters: {
        'lang': languageFilter,
      });
      logger.d("--- 📢 [API_REPO /channels] 2. Получен ответ со статусом ${response.statusCode}");

      final rawBody = utf8.decode(response.bodyBytes);
      logger.d("--- 📢 [API_REPO /channels] 3. Сырой ответ от сервера (RAW):");
      logger.d(rawBody);
      // --- 👆 КОНЕЦ БЛОКА ЛОГОВ 👆 ---

      final List<dynamic> jsonList = json.decode(rawBody);
      logger.d("--- 📢 [API_REPO /channels] 4. JSON успешно распарсен. Найдено ${jsonList.length} объектов.");

      final channels = jsonList.map((json) => Channel.fromJson(json)).toList();
      logger.d("--- 📢 [API_REPO /channels] 5. Объекты успешно преобразованы в модели Channel.");

      return channels;

    } catch (e, s) {
      logger.d("--- 📢 [API_REPO /channels] ❌ КРИТИЧЕСКАЯ ОШИБКА: $e");
      logger.d(s); // Печатаем stack trace
      return [];
    }
  }

  Future<Comment> postComment({
    required String postId,
    required String text,
    Comment? replyTo,
  }) async {
    // 1. Вызываем наш универсальный метод _post, который отправляет запрос на сервер
    final response = await _post(
        '/posts/$postId/comments',
        body: {
          'text': text,
          // Если есть ответ на другой коммент, отправляем его данные
          // Убедись, что у модели Comment есть метод toJson()
          'replyTo': replyTo?.toJson(),
        }
    );

    // 2. Декодируем ответ сервера и парсим его в нашу Dart-модель Comment
    final newCommentJson = json.decode(utf8.decode(response.bodyBytes));

    // 3. Возвращаем готовый объект, чтобы UI мог его сразу отобразить
    return Comment.fromJson(newCommentJson);
  }

  Future<void> toggleReaction({
    required String entityType, // 'post' или 'comment'
    required String entityId,
    required String emoji,
  }) async {
    await _post('/reactions/toggle', body: {
      'entityType': entityType,
      'entityId': entityId,
      'emoji': emoji,
    });
  }

  Future<List<Channel>> searchChannels(String query) async {
    try {
      final response = await _get('/channels/search', queryParameters: {'q': query});
      final List<dynamic> jsonList = json.decode(utf8.decode(response.bodyBytes));
      return jsonList.map((json) => Channel.fromJson(json)).toList();
    } catch (e) {
      logger.d("Ошибка поиска каналов: $e");
      return [];
    }
  }

  Future<String> createChannel({
    required String name,
    required String description,
    required String handle,
    required String topicKey,
    String? avatarBase64,
    required Map<String, List<String>> keywordsMap,
  }) async {
    final response = await _post('/channels', body: {
      'name': name,
      'description': description,
      'handle': handle,
      'topicKey': topicKey,
      'avatarBase64': avatarBase64,
      'keywordsMap': keywordsMap,
    });
    final body = json.decode(response.body);


    // --- ИСПРАВЛЕНИЕ ЗДЕСЬ ---
    // Преобразуем ID в строку перед возвратом
    return body['id'].toString();
  }

  Future<void> activateFreeTrial() async {
    await _post('/users/me/activate-trial');
  }

  Future<String?> getCombinationInterpretation({
    required List<String> themeKeys,
    required String langCode,
  }) async {
    final response = await _post('/tarot/interpretation', body: {
      'themeKeys': themeKeys,
      'lang': langCode,
    });
    final body = json.decode(response.body);
    return body['interpretation']; // Может быть null
  }

  Future<List<UserProfileCard>> findUsersForRoulette(bool searchInMyCountry) async {
    final response = await _get('/users/roulette-candidates', queryParameters: {
      'searchInMyCountry': searchInMyCountry.toString(),
    });
    final List<dynamic> jsonList = json.decode(utf8.decode(response.bodyBytes));
    return jsonList.map((json) => UserProfileCard.fromJson(json)).toList();
  }

  Future<List<Map<String, String>>> getUserPhotos(String userId) async {
    final response = await _get('/users/$userId/photos');
    final List<dynamic> jsonList = json.decode(utf8.decode(response.bodyBytes));
    // Приводим к типу List<Map<String, String>>
    return List<Map<String, String>>.from(jsonList.map((item) => {
      'id': item['id'].toString(),
      'url': item['photoUrl'].toString(),
    }));
  }

  Future<void> addUserPhoto(String photoUrl) async {
    await _post('/users/me/photos', body: {'photoUrl': photoUrl});
  }

  Future<void> deleteUserPhoto(String photoId) async {
    await _delete('/users/me/photos/$photoId');
  }

  // ЗАГЛУШКА 3
  Future<void> updateChannelField(String channelId, String field, dynamic value) async {
    // Оборачиваем одно поле в Map и вызываем общий метод
    await updateChannelSettings(channelId, {field: value});
  }

  Future<void> updateUserStatus() async {
    // Используем _put, так как мы обновляем существующий ресурс.
    // Тело запроса не нужно, сервер и так знает ID из токена.
    await _put('/users/me/status');
  }

  Future<Map<String, dynamic>> likeUser(String targetUserId) async {
    final response = await _post('/users/$targetUserId/like');
    return json.decode(response.body); // Возвращаем { isMatch: bool, chatId: string? }
  }

  Future<List<UserProfileCard>> getUsersWhoLikedMe() async {
    final response = await _get('/users/me/likes-you');
    final List<dynamic> jsonList = json.decode(utf8.decode(response.bodyBytes));
    return jsonList.map((json) => UserProfileCard.fromJson(json)).toList();
  }
  Future<List<OracleTheme>> getOracleThemes() async {
    final response = await _get('/oracle/themes');
    final List<dynamic> jsonList = json.decode(utf8.decode(response.bodyBytes));
    return jsonList.map((json) => OracleTheme.fromJson(json)).toList();
  }

  Future<UserProfileCard?> findPartnerOfTheDay() async {
    try {
      final response = await _get('/users/me/partner-of-the-day');
      return UserProfileCard.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } catch (e) {
      // Сервер может вернуть 404, если партнер не найден
      if (e is ServerException && e.statusCode == 404) {
        return null;
      }
      rethrow; // Пробрасываем другие ошибки
    }
  }

  Future<void> hideLikedByUser(String targetUserId) async {
    await _post('/users/$targetUserId/hide-like');
  }

  Future<List<UserProfileCard>> getBannedUsers(String channelId) async {
    final response = await _get('/channels/$channelId/banned-users');
    final List<dynamic> jsonList = json.decode(utf8.decode(response.bodyBytes));
    return jsonList.map((json) => UserProfileCard.fromJson(json)).toList();
  }

  Future<Map<String, dynamic>> getFocusDayInterpretations() async {
    final response = await _get('/astrology/focus-interpretations');
    return json.decode(utf8.decode(response.bodyBytes));
  }

  Future<Channel?> getChannelDetails(String channelId) async {
    try {
      final response = await _get('/channels/$channelId');
      // Сервер возвращает 404, если канал не найден, _get выбросит исключение
      return Channel.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } catch (e) {
      // Ловим ошибку (например, 404 Not Found) и возвращаем null
      logger.d("Не удалось загрузить детали канала $channelId: $e");
      return null;
    }
  }

// Вместо listenToPosts
  Future<List<Post>> getPosts(String channelId, {int offset = 0, int limit = 20}) async {
    try {
      final response = await _get('/channels/$channelId/posts', queryParameters: {
        'offset': offset.toString(),
        'limit': limit.toString(),
      });
      final List<dynamic> jsonList = json.decode(utf8.decode(response.bodyBytes));
      return jsonList.map((json) => Post.fromJson(json)).toList();
    } catch (e) {
      logger.d("Не удалось загрузить посты для канала $channelId: $e");
      return []; // Возвращаем пустой список в случае ошибки
    }
  }

  Future<Post> createPost({
    required String channelId,
    required String text,
    String? imageUrl,
    double? imageWidth,
    double? imageHeight,
    required String anonymousAuthorName,
  }) async {
    final response = await _post('/channels/$channelId/posts', body: {
      'text': text,
      'imageUrl': imageUrl,
      'imageWidth': imageWidth,
      'imageHeight': imageHeight,
      'anonymousAuthorName': anonymousAuthorName,
    });
    return Post.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }

  Future<void> removeFriendOrRequest(String currentUserId, String otherUserId) async {
    // Нам нужно добавить универсальный метод _delete в репозиторий
    await _delete('/users/me/friends/$otherUserId');
  }

  Future<Map<String, String>> getNumerologyNumberDescriptions({required String lang}) async {
    try {
      final response = await _get('/numerology/number-descriptions/$lang');

      final rawJsonString = utf8.decode(response.bodyBytes);

      // --- 👇 ДОБАВЬ ЭТОТ PRINT 👇 ---
      print('--- RAW NUMEROLOGY DESCRIPTIONS FROM SERVER ---');
      print(rawJsonString.substring(0, 500)); // Печатаем первые 500 символов
      print('---------------------------------------------');
      // --- 👆 КОНЕЦ ДОБАВЛЕНИЯ 👆 ---

      final Map<String, dynamic> jsonMap = json.decode(rawJsonString);
      return jsonMap.map((key, value) => MapEntry(key.trim(), value.toString()));
    } catch (e) {
      logger.d("❌❌❌ КРИТИЧЕСКАЯ ОШИБКА в getNumerologyNumberDescriptions: $e");
      rethrow;
    }
  }
  Future<String> createPaymentLink({String amount = "399"}) async {
    // БЫЛО: '/payments/create-link'
    // СТАЛО: Добавляем /api/
    final response = await _post('/api/payments/create-link', body: {'amount': amount});

    final data = json.decode(utf8.decode(response.bodyBytes));
    return data['paymentUrl'];
  }


  Future<NumerologyReport> getNumerologyCompatibilityReport(String otherUserId, String lang) async {
    final response = await _get('/numerology/compatibility/$otherUserId?lang=$lang');
    final Map<String, dynamic> jsonMap = json.decode(utf8.decode(response.bodyBytes));
    return NumerologyReport.fromJson(jsonMap);
  }

  Future<UserProfileCard> updateUserBirthData(Map<String, dynamic> data) async {
    final response = await _put('/users/me/birthdata', body: data);
    return UserProfileCard.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }

  Stream<String> streamAiTarotInterpretation({
    required String question,
    required List<TarotCard> cards,
    required String lang,
    required bool isProUser,
    required UserProfileCard userProfile,
  }) async* {

    final cardsData = cards.map((card) => {
      'name': card.name,
      'orientation': card.isReversed ? 'reversed' : 'direct',
    }).toList();

    final userInfo = {
      'name': userProfile.name,
      'sunSign': userProfile.sunSign,
      'lifePathNumber': userProfile.numerologyData?.lifePath.number,
    };

    final requestBody = {
      'question': question,
      'cards': cardsData,
      'lang': lang,
      'model': isProUser ? 'pro' : 'mini',
      'userInfo': userInfo,
    };

    final url = Uri.parse('$baseUrl/ai/tarot-reading');
    final request = http.Request('POST', url);
    final headers = await _getAuthHeaders();
    request.headers.addAll(headers);
    request.body = jsonEncode(requestBody);

    try {
      final client = http.Client();
      final streamedResponse = await client.send(request);

      if (streamedResponse.statusCode >= 200 && streamedResponse.statusCode < 300) {
        // Правильно декодируем UTF-8 поток
        await for (final chunk in streamedResponse.stream.transform(utf8.decoder)) {
          yield chunk;
        }
      } else {
        // Читаем тело ошибки, если возможно
        final errorBody = await streamedResponse.stream.transform(utf8.decoder).join();
        throw Exception('Server error: ${streamedResponse.statusCode}. Body: $errorBody');
      }
      client.close();
    } catch (e) {
      logger.d("Stream error: $e");
      rethrow;
    }
  }

  Future<List<ChatListItem>> fetchUserChatsOnce() async {
    logger.d("--- 💬 [API_REPO /chats] 2. Выполняю GET запрос на /users/me/chats...");
    final response = await _get('/users/me/chats');

    // --- 👇 ВОТ ИЗМЕНЕНИЕ 👇 ---
    final rawBody = utf8.decode(response.bodyBytes);
    // Меняем уровень с 'd' (debug) на 'v' (verbose)
    logger.v("--- 💬 [API_REPO /chats] Ответ от сервера (RAW): ${rawBody.substring(0, rawBody.length > 500 ? 500 : rawBody.length)}...");
    // --- 👆 КОНЕЦ ИЗМЕНЕНИЯ 👆 ---

    final List<dynamic> jsonList = json.decode(rawBody);
    return jsonList.map((item) => ChatListItem.fromJson(item)).toList();
  }

  Future<void> deleteAccount() async {
    await _delete('/users/me');
  }

  Future<String?> getAiTarotInterpretation({
    required String question,
    required List<TarotCard> cards,
    required String lang,
    required bool isProUser,
    required UserProfileCard userProfile,
  }) async {

    final cardsData = cards.map((card) => {
      'name': card.name,
      'orientation': card.isReversed
          ? ({'ru': 'перевернутая', 'en': 'reversed'}[lang] ?? 'reversed')
          : ({'ru': 'прямая', 'en': 'direct'}[lang] ?? 'direct'),
    }).toList();

    // --- 👇 ИСПРАВЛЕНИЕ ЗДЕСЬ 👇 ---
    // Безопасно получаем число жизненного пути из нашего нового объекта
    final lifePathNumber = userProfile.numerologyData?.lifePath.number;

    final userInfo = {
      'name': userProfile.name,
      'sunSign': userProfile.sunSign,
      'moonSign': userProfile.natalChart?.moonSign,
      'ascendantSign': userProfile.natalChart?.ascendantSign,
      // Передаем число или null, если его нет
      'lifePathNumber': lifePathNumber,
    };
    // --- 👆 КОНЕЦ ИСПРАВЛЕНИЯ 👆 ---

    final requestBody = {
      'question': question,
      'cards': cardsData,
      'lang': lang,
      'model': isProUser ? 'pro' : 'mini',
      'userInfo': userInfo,
    };

    try {
      logger.d("--- 🔮 [API_REPO] 1. Отправляю POST-запрос на /ai/tarot-reading...");
      logger.d("--- 🔮 [API_REPO] Тело запроса: ${json.encode(requestBody)}");

      final response = await _post(
        '/ai/tarot-reading',
        body: requestBody,
      );

      logger.d("--- 🔮 [API_REPO] 2. Получен ответ от бэкенда. Статус: ${response.statusCode}");

      final rawBody = utf8.decode(response.bodyBytes);
      logger.d("--- 🔮 [API_REPO] 3. Сырой ответ от бэкенда (RAW): $rawBody");

      final body = json.decode(rawBody);
      final interpretation = body?['interpretation'] as String?;

      if (interpretation != null && interpretation.isNotEmpty) {
        logger.d("--- 🔮 [API_REPO] 4. Ответ успешно распарсен. Интерпретация: ${interpretation.substring(0, (interpretation.length > 50) ? 50 : interpretation.length)}...");
      } else {
        logger.d("--- 🔮 [API_REPO] 4. Ответ распарсен, но поле 'interpretation' пустое или отсутствует.");
      }

      return interpretation;

    } catch (e, s) {
      logger.d("--- 🔮 [API_REPO] ❌ КРИТИЧЕСКАЯ ОШИБКА в getAiTarotInterpretation: $e");
      logger.d(s);
      rethrow;
    }
  }

  Future<List<ChannelPreview>> getChannelPreviews() async {
    try {
      logger.d("[API_REPO] Запрос на /channels...");
      final response = await _get('/channels'); // Вызывает GET /channels
      final List<dynamic> jsonList = json.decode(utf8.decode(response.bodyBytes));

      // Используем модель ChannelPreview, которую ты уже создал
      final previews = jsonList.map((json) => ChannelPreview.fromJson(json)).toList();
      logger.d("[API_REPO] Успешно загружено ${previews.length} превью каналов.");
      return previews;

    } catch (e) {
      logger.d("❌ Ошибка при загрузке превью каналов: $e");
      return [];
    }
  }

  Future<void> markChannelAsRead(String channelId) async {
    // Этот метод просто отправляет запрос и не ждет ответа
    await _post('/channels/$channelId/mark-as-read');
  }




  Future<Channel> updateChannelSettings(String channelId, Map<String, dynamic> settings) async {
    final response = await _put('/channels/$channelId/settings', body: settings);
    return Channel.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }

  Future<void> deleteChannel(String channelId) async => await _delete('/channels/$channelId');

  Future<void> deletePost(String postId) async => await _delete('/posts/$postId');

  Future<void> togglePostReaction(String postId, String emoji) async {
    await _post('/posts/$postId/toggle-reaction', body: {'emoji': emoji});
  }

  Future<Post> editPost(String postId, String newText) async {
    final response = await _put('/posts/$postId', body: {'text': newText});
    return Post.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }
  Future<Channel> togglePinPost(String postId) async {
    final response = await _post('/posts/$postId/toggle-pin');
    return Channel.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }

// --- МЕТОДЫ ДЛЯ МОДЕРАЦИИ ---
  Future<List<Post>> getProposedPosts(String channelId) async {
    try {
      final response = await _get('/channels/$channelId/proposed-posts');
      final List<dynamic> jsonList = json.decode(utf8.decode(response.bodyBytes));
      return jsonList.map((json) => Post.fromJson(json)).toList();
    } catch (e) {
      logger.d("Не удалось загрузить предложенные посты для канала $channelId: $e");
      return [];
    }
  }
  Future<void> migrateWithFirebaseToken(String firebaseToken) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/migrate-from-firebase'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'firebaseToken': firebaseToken}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      // 1. Сохраняем токен
      await _saveJwtToken(data['token']);

      // --- 👇 ИСПРАВЛЕНИЕ: СОХРАНЯЕМ USER ID 👇 ---
      if (data['userId'] != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_id', data['userId']);
      }
      // --- 👆 -------------------------------------

    } else {
      try {
        final error = json.decode(response.body);
        throw Exception(error['error'] ?? 'Failed to migrate user');
      } catch (e) {
        throw Exception('Failed to migrate user with status code: ${response.statusCode}');
      }
    }
  }


  Future<Map<String, dynamic>> getNumerologyTranslations(String langCode) async {
    try {
      final response = await _get('/numerology/translations/$langCode');
      return json.decode(utf8.decode(response.bodyBytes));
    } catch (e) {
      logger.d("Не удалось загрузить переводы нумерологии: $e");
      return {};
    }
  }

  Future<void> approvePost(String postId) async {
    await _post('/posts/$postId/approve');
  }

  Future<void> rejectPost(String postId) async {
    await _post('/posts/$postId/reject');
  }

  Future<void> proposePost(String channelId, String text, {String? imageUrl}) async {
    // Убираем TODO и print
    await _post(
        '/channels/$channelId/propose-post',
        body: {
          'text': text,
          'imageUrl': imageUrl
        }
    );
  }

// Также добавь сам метод _delete в репозиторий
  Future<http.Response> _delete(String endpoint) async {
    final headers = await _getAuthHeaders();
    final url = Uri.parse('$baseUrl$endpoint');
    logger.d('>>> API DELETE: $url');
    final response = await http.delete(url, headers: headers);
    _handleResponseError(response);
    return response;
  }



  Future<void> toggleSubscription(String userId, String channelId, bool isCurrentlySubscribed) async {
    await _post('/channels/$channelId/toggle-subscription');
  }

  Future<Map<String, DailyHoroscope>> getAllHoroscopes(String languageCode) async {
    try {
      final response = await _get('/horoscopes', queryParameters: {'lang': languageCode});

      // Сервер возвращает Map<String, dynamic>, где ключ - это знак зодиака
      final Map<String, dynamic> jsonMap = json.decode(utf8.decode(response.bodyBytes));

      // Преобразуем его в Map<String, DailyHoroscope>
      return jsonMap.map((sign, horoscopeJson) {
        return MapEntry(sign, DailyHoroscope.fromJson(horoscopeJson));
      });

    } catch (e) {
      logger.d("Ошибка загрузки всех гороскопов через API: $e");
      // Возвращаем пустую карту в случае ошибки, чтобы не ронять приложение
      return {};
    }
  }



  Future<List<chat_models.Message>> getChatMessages(String chatId) async {
    final response = await _get('/chats/$chatId/messages');
    final List<dynamic> jsonList = json.decode(utf8.decode(response.bodyBytes));
    return jsonList.map((json) => chat_models.Message.fromJson(json)).toList();
  }

  Future<void> markChatAsRead(String chatId) async {
    await _post('/chats/$chatId/mark-as-read');
  }


  Future<void> createReport(Map<String, dynamic> reportData) async {
    await _post('/reports', body: reportData);
  }

  Future<Map<String, String>> getAstroCommunicationTips(String lang) async {
    final response = await _get('/astrology/communication-tips', queryParameters: {'lang': lang});
    // ... твой код ...
    // final response = await _get(...);
    // final Map<String, dynamic> jsonMap = json.decode(...);
    // Приводим типы перед возвратом
    final Map<String, dynamic> jsonMap = json.decode(utf8.decode(response.bodyBytes));
    return jsonMap.map((key, value) => MapEntry(key, value.toString()));
  }

  Future<void> sendMessage({
    required String chatId,
    required String senderId,      // Оставляем, может пригодиться для логов на сервере
    required String recipientId,
    required String text,          // Принимаем только текст
    String? clientTempId,         // Принимаем временный ID
    required UserProfileCard senderProfile, // Оставляем для отправки PUSH
  }) async {
    // Вызываем _post, передавая в теле запроса только то, что ждет сервер
    await _post(
        '/chats/$chatId/messages',
        body: {
          'text': text, // Используем параметр 'text'
          'recipientId': recipientId,
          // Сервер ожидает snake_case, а в Dart у нас camelCase, поэтому преобразуем имя ключа
          'client_temp_id': clientTempId,
        }
    );
  }
  Future<void> incrementPostViewCount(String postId) async {
    // Используем _post, но не ждем тела ответа
    await _post('/posts/$postId/view');
  }

  Future<List<Comment>> getComments(String postId) async {
    // Вызываем эндпоинт, который мы уже создали на бэкенде
    final response = await _get('/posts/$postId/comments');
    final List<dynamic> jsonList = json.decode(utf8.decode(response.bodyBytes));
    // Парсим каждый JSON-объект в нашу модель Comment
    return jsonList.map((json) => Comment.fromJson(json)).toList();
  }

  Future<void> loginWithFirebaseToken() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('No Firebase user found');

    final firebaseToken = await user.getIdToken(true);

    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/login-with-token'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $firebaseToken' // Отправляем Firebase токен
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      await _saveJwtToken(data['token']); // Получаем и сохраняем НАШ JWT
    } else {
      final error = json.decode(response.body);
      throw Exception(error['error'] ?? 'Failed to login with token');
    }
  }



  // FIXME: Функция в разработке (Хиромантия)
  Future<PalmistryData?> getPalmistryInterpretations(String lang) async {
    logger.w("Заглушка: getPalmistryInterpretations еще не реализован на API.");
    return null; // Возвращаем null, пока эндпоинт не готов
  }

  // FIXME: Функция в разработке (Хиромантия)
  Future<void> savePalmistryResults({
    required String userId,
    required Map<String, String> userChoices,
    required List<String> traits,
  }) async {
    logger.d("API WARNING: savePalmistryResults is not implemented.");
  }

  // FIXME: Функция в разработке (Хиромантия)
  Future<void> setShowPalmistryInProfile(String userId, bool show) async {
    logger.d("API WARNING: setShowPalmistryInProfile is not implemented.");
  }



  // ЗАГЛУШКИ ДЛЯ СИСТЕМЫ ДРУЖБЫ
  Future<Map<String, dynamic>> getFriendsAndRequests(String userId) async {
    try {
      // Используем /users/me/friends (userId в аргументе игнорируем, так как берем из токена)
      final response = await _get('/users/me/friends');
      return json.decode(utf8.decode(response.bodyBytes));
    } catch (e) {
      logger.d("Ошибка загрузки друзей: $e");
      return {'friends': [], 'requests': [], 'statusMap': {}};
    }
  }

  Future<void> sendFriendRequest(String senderId, String recipientId) async {
    // Отправка заявки в друзья — это просто ЛАЙК
    await _post('/users/$recipientId/like');
  }

  Future<void> acceptFriendRequest(String currentUserId, String requesterId) async {
    // Принятие заявки — это просто встречный лайк!
    // Используем уже существующий эндпоинт.
    await _post('/users/$requesterId/like');
  }



  Future<void> removeOrDeclineFriend(String currentUserId, String otherUserId) async {
    // Вызываем наш рабочий DELETE метод
    // currentUserId не нужен в URL, так как он берется из токена ("me")
    await _delete('/users/me/friends/$otherUserId');
  }

  // Новый метод для регистрации через НАШ API
  Future<Map<String, dynamic>> register(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );
    if (response.statusCode == 201) {
      final data = json.decode(response.body);
      await _saveJwtToken(data['token']);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_id', data['userId']);
      return data;
    } else {
      final error = json.decode(response.body);
      throw Exception(error['error'] ?? 'Failed to register');
    }
  }
  Future<void> resetPassword({required String token, required String newPassword}) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/reset-password'), // <-- Наш эндпоинт
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'token': token,
        'newPassword': newPassword,
      }),
    );

    if (response.statusCode != 200) {
      final error = json.decode(response.body);
      throw Exception(error['error'] ?? 'Failed to reset password');
    }
    // Если все успешно, метод просто завершается
  }

  Future<void> forgotPassword(String email) async {
    logger.d("--- DEBUG FLUTTER: 3. ApiRepository.forgotPassword ВЫЗВАН ---");
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/forgot-password'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'identifier': email}), // Сервер ждет 'identifier'
    );
    logger.d("--- DEBUG FLUTTER: СЕРВЕР ОТВЕТИЛ со статусом ${response.statusCode} ---");

    // Мы не проверяем statusCode, так как сервер всегда возвращает 200
    // для безопасности, даже если email не найден.
    // Если произойдет реальная ошибка 500, http.post сам выбросит исключение.
  }



  Future<Map<String, String>> _getAuthHeaders() async {
    final token = await jwtToken; // Используем наш геттер
    if (token == null) {
      throw UserNotAuthorizedException();
    }
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
  }



  // --- УНИВЕРСАЛЬНЫЕ ПРИВАТНЫЕ МЕТОДЫ ДЛЯ ЗАПРОСОВ ---

  Future<http.Response> _get(String endpoint, {Map<String, String?>? queryParameters}) async {
    final headers = await _getAuthHeaders(); // <-- Использует JWT
    final url = Uri.parse('$baseUrl$endpoint').replace(queryParameters: queryParameters);
    logger.d('>>> API GET: $url');
    final response = await http.get(url, headers: headers);
    _handleResponseError(response);
    return response;
  }

  // --- 👇 ВОТ ГЛАВНОЕ ИСПРАВЛЕНИЕ 👇 ---
  // Делаем body опциональным
  Future<http.Response> _post(String endpoint, {Map<String, dynamic>? body}) async {
    final headers = await _getAuthHeaders(); // <-- Использует JWT
    final url = Uri.parse('$baseUrl$endpoint');
    logger.d('>>> API POST: $url');
    final response = await http.post(
      url,
      headers: headers,
      body: body != null ? json.encode(body) : null,
    );

    if (response.statusCode >= 400) {
      logger.d('!!! API Error: ${response.statusCode} for ${response.request?.url}');
      logger.d('!!! Body: ${response.body}');
      throw ServerException(response.statusCode);
    }
    _handleResponseError(response);
    return response;
  }

  Future<http.Response> _put(String endpoint, {Map<String, dynamic>? body}) async {
    final headers = await _getAuthHeaders(); // <-- Использует JWT
    final url = Uri.parse('$baseUrl$endpoint');
    logger.d('>>> API PUT: $url');
    final response = await http.put(
      url,
      headers: headers,
      body: body != null ? json.encode(body) : null,
    );
    _handleResponseError(response);
    return response;
  }

  void _handleResponseError(http.Response response) {
    if (response.statusCode >= 400) {
      // Логируем один раз с уровнем warning
      logger.w('API Error ${response.statusCode} for ${response.request?.url}', error: response.body);
      try {
        final errorJson = json.decode(response.body);
        throw UnknownServerException(errorJson['error']);
      } catch (e) {
        // Если это не ошибка парсинга JSON, а что-то другое
        if (e is UnknownServerException) rethrow;
        throw ServerException(response.statusCode);
      }
    }
  }





  // --- 👇 ИСПРАВЛЕНИЕ: Добавляем метод-хелпер для заголовков 👇 ---

  // --- 👆 Конец исправления 👆 ---



  Future<List<UserProfileCard>> getUsersByIds(List<String> userIds) async {
    if (userIds.isEmpty) return [];

    final url = Uri.parse('$baseUrl/users/by-ids');
    try {
      final headers = await _getAuthHeaders();
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode({'userIds': userIds}),
      );

      if (response.statusCode == 200) {
        // --- 👇 ВОТ ЭТОТ ЛОГ НУЖЕН 👇 ---
        final rawJsonString = utf8.decode(response.bodyBytes);
        logger.d('--- [API_REPO DEBUG] RAW JSON from /users/by-ids ---');
        logger.d(rawJsonString);
        logger.d('--- END RAW JSON ---');
        // --- 👆 КОНЕЦ БЛОКА 👆 ---

        final List<dynamic> jsonList = json.decode(rawJsonString);
        return jsonList.map((json) => UserProfileCard.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load users by IDs: ${response.body}');
      }
    } catch (e) {
      logger.d("[API_REPO] Ошибка получения пользователей по ID: $e");
      return [];
    }
  }

  Future<void> forceSyncUserProfile() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    final url = Uri.parse('$baseUrl/users/$userId/sync');
    try {
      final headers = await _getAuthHeaders();
      // Используем POST, так как это действие, а не просто получение данных
      final response = await http.post(url, headers: headers);

      if (response.statusCode == 200) {
        logger.d('[API_REPO] Профиль успешно синхронизирован.');
      } else {
        throw Exception('Failed to sync profile: ${response.body}');
      }
    } catch (e) {
      logger.d('[API_REPO] Ошибка принудительной синхронизации: $e');
      rethrow;
    }
  }

  Future<void> linkReferral(String referrerId) async {
    final url = Uri.parse('$baseUrl/referrals/link');
    try {
      final headers = await _getAuthHeaders(); // Токен нового юзера (Нины)
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode({'referrerId': referrerId}),
      );
      if (response.statusCode != 201) {
        throw Exception('Failed to link referral: ${response.body}');
      }
      logger.d('[API_REPO] Реферальная связь успешно создана.');
    } catch (e) {
      logger.d('[API_REPO] Ошибка создания реферальной связи: $e');
      // Не пробрасываем ошибку, чтобы не сломать онбординг, просто логируем.
    }
  }

  Future<NumerologyReport> getNumerologyReport(String otherUserId, String lang) async {
    // Используем наш универсальный метод _get
    final response = await _get('/numerology/compatibility/$otherUserId?lang=$lang');
    final Map<String, dynamic> jsonMap = json.decode(utf8.decode(response.bodyBytes));

    // Парсим ответ в нашу новую Dart-модель
    return NumerologyReport.fromJson(jsonMap);
  }

  Future<void> updateUserLanguage(String lang) async {
    // Используем наш универсальный метод _put
    await _put('/users/language', body: {'lang': lang});
  }

  Future<String> applyReferralCode(String code) async {
    final response = await _post('/api/referrals/apply-code', body: {'referralCode': code});

    final body = json.decode(utf8.decode(response.bodyBytes));

    if (response.statusCode == 200) {
      return body['message'] ?? 'Success';
    } else {
      // Выбрасываем текст ошибки, который прислал сервер ("Нельзя использовать свой код" и т.д.)
      throw Exception(body['error'] ?? 'Unknown error');
    }
  }

  Future<Map<String, dynamic>> getSuperCompatibility(String partnerId) async {
    final response = await _get('/compatibility/super-report/$partnerId');
    return json.decode(utf8.decode(response.bodyBytes));
  }

  // Расчет "Супер-совместимости" (Ручной ввод)
  Future<Map<String, dynamic>> calculateManualCompatibility({
    required String name,
    required DateTime date,
    // time и place пока опционально, т.к. для нумерологии они не нужны
  }) async {
    final response = await _post('/compatibility/manual-super-check', body: {
      'partnerName': name,
      'partnerDate': date.toIso8601String(),
    });
    return json.decode(utf8.decode(response.bodyBytes));
  }


  Future<void> activateProStatus({int months = 1}) async {
    final url = Uri.parse('$baseUrl/users/activate-pro');
    try {
      final headers = await _getAuthHeaders();
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode({'months': months}),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to activate PRO status: ${response.body}');
      }
      logger.d('[API_REPO] PRO-статус успешно активирован на бэкенде.');
    } catch (e) {
      logger.d('[API_REPO] Ошибка активации PRO: $e');
      rethrow;
    }
  }




  Future<ChatRoom?> getChatRoomInfo(String roomId) async {
    final url = Uri.parse('$baseUrl/chats/room/$roomId');
    try {
      final headers = await _getAuthHeaders();
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        // --- 👇 ТЕПЕРЬ МЫ ИСПОЛЬЗУЕМ ЕДИНЫЙ КОНСТРУКТОР 👇 ---
        return ChatRoom.fromJson(json.decode(utf8.decode(response.bodyBytes)));
      }
      return null;
    } catch (e) {
      logger.d("[API_REPO] Ошибка получения информации о комнате: $e");
      return null;
    }
  }



  Future<List<FeedEvent>> getPulseFeed() async { // убираем userId, он не нужен
    final url = Uri.parse('$baseUrl/feed');
    logger.d("\n--- [API_REPO] Начинаю запрос на получение ленты ---");
    logger.d("--- [API_REPO] URL: $url");

    try {
      final headers = await _getAuthHeaders(); // Используем хелпер
      final response = await http.get(url, headers: headers)
          .timeout(const Duration(seconds: 15));

      logger.d("--- [API_REPO] Получен ответ от сервера со статусом: ${response.statusCode}");

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(utf8.decode(response.bodyBytes));
        logger.d("--- [API_REPO] УСПЕХ: Найдено ${jsonList.length} событий.");
        return jsonList.map((json) => FeedEvent.fromJson(json)).toList();
      } else {
        logger.d("--- [API_REPO] ОШИБКА СЕРВЕРА: Статус ${response.statusCode}, Тело: ${response.body}");
        throw Exception("Ошибка сервера: ${response.statusCode}");
      }
    } catch (e, s) {
      logger.e("Сетевая ошибка в getPulseFeed", error: e, stackTrace: s);
      return [];
    }
  }

  // --- 👇 ИСПРАВЛЕНИЕ: Добавляем недостающий метод fetchCosmicWebData 👇 ---
  Future<List<CosmicWebUser>> fetchCosmicWebData({
    required String gender,
    required int minAge,
    required int maxAge,
  }) async {
    final url = Uri.parse('$baseUrl/search/cosmic-web').replace(queryParameters: {
      'gender': gender,
      'minAge': minAge.toString(),
      'maxAge': maxAge.toString(),
    });

    logger.d("\n--- [API_REPO] Начинаю запрос для Cosmic Web ---");
    logger.d("--- [API_REPO] URL: $url");

    try {
      final headers = await _getAuthHeaders();
      final response = await http.get(url, headers: headers)
          .timeout(const Duration(seconds: 20));

      logger.d("--- [API_REPO] Cosmic Web: получен ответ со статусом: ${response.statusCode}");

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(utf8.decode(response.bodyBytes));
        final users = jsonList.map((json) => CosmicWebUser.fromJson(json)).toList();
        logger.d("--- [API_REPO] УСПЕХ: Загружено ${users.length} пользователей для Cosmic Web.");
        return users;
      } else {
        final errorBody = json.decode(response.body);
        logger.d("--- [API_REPO] ОШИБКА СЕРВЕРА: Статус ${response.statusCode}, Тело: ${errorBody['message'] ?? response.body}");
        throw Exception("Ошибка сервера: ${errorBody['message'] ?? 'Неизвестная ошибка'}");
      }
    } catch (e) {
      if (e is TimeoutException) {
        logger.d("--- [API_REPO] КРИТИЧЕСКАЯ ОШИБКА: Таймаут запроса для Cosmic Web!");
        throw Exception("Сервер не отвечает. Проверьте ваше интернет-соединение или попробуйте позже.");
      }
      logger.d("--- [API_REPO] КРИТИЧЕСКАЯ ОШИБКА в fetchCosmicWebData: $e");
      rethrow;
    }
  }

  Future<void> resendVerificationCode(String email) async {
    // Этот запрос не требует JWT-токена
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/resend-verification'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email}),
    );

    // Обрабатываем возможные ошибки
    if (response.statusCode >= 400) {
      try {
        final error = json.decode(response.body);
        // Пробрасываем ошибку, чтобы Cubit мог ее поймать
        throw Exception(error['error'] ?? 'Failed to resend code');
      } catch (e) {
        throw Exception('Failed to resend code with status code: ${response.statusCode}');
      }
    }
    // Если статус 200 OK, метод просто успешно завершается
  }
  // --- 👆 Конец исправления 👆 ---

  // --- 👇 ИСПРАВЛЕНИЕ: Добавляем методы, которые мы создали ранее 👇 ---
  Future<UserProfileCard?> getUserProfile(String userId) async {
    final url = Uri.parse('$baseUrl/users/$userId');
    try {
      final headers = await _getAuthHeaders();
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        // --- 👇 ВОТ ЭТОТ ЛОГ НУЖЕН 👇 ---
        final rawJsonString = utf8.decode(response.bodyBytes);
        logger.d("================= RAW PROFILE JSON FROM SERVER =================");
        logger.v(rawJsonString); // <--- ЗАМЕНИ .d НА .v
        logger.d("================================================================");
        // --- 👆 КОНЕЦ БЛОКА 👆 ---

        final data = json.decode(rawJsonString);
        return UserProfileCard.fromJson(data);


      } else if (response.statusCode == 404) {
        return null;
      } else {
        throw Exception('Failed to load user profile: ${response.body}');
      }
    } catch (e) {
      logger.d("--- [API_REPO] КРИТИЧЕСКАЯ ОШИБКА в getUserProfile: $e");
      rethrow;
    }
  }

  Future<void> registerNewUser() async {
    final url = Uri.parse('$baseUrl/users/register');
    try {
      final headers = await _getAuthHeaders();
      final response = await http.post(url, headers: headers);
      if (response.statusCode != 201) {
        throw Exception('Failed to register user on backend: ${response.body}');
      }
      logger.d('[API_REPO] Новый пользователь успешно зарегистрирован на бэкенде.');
    } catch (e) {
      logger.d("--- [API_REPO] КРИТИЧЕСКАЯ ОШИБКА в registerNewUser: $e");
      rethrow;
    }
  }
  Future<ChineseZodiacReport> getChineseZodiacReport(String otherUserId, String lang) async {
    final response = await _get('/zodiac/compatibility/$otherUserId?lang=$lang');
    final Map<String, dynamic> jsonMap = json.decode(utf8.decode(response.bodyBytes));
    return ChineseZodiacReport.fromJson(jsonMap);
  }

  Future<JyotishReport> getJyotishReport(String otherUserId, String lang) async {
    // Используем наш универсальный метод _get для запроса
    final response = await _get(
        '/jyotish/compatibility/$otherUserId', // <-- Наш новый эндпоинт
        queryParameters: {'lang': lang}
    );

    // Декодируем ответ от сервера
    final Map<String, dynamic> jsonMap = json.decode(utf8.decode(response.bodyBytes));

    // Парсим JSON в нашу Dart-модель, которую мы создали на Шаге 1
    return JyotishReport.fromJson(jsonMap);
  }

  Future<BaziReport> getBaziReport(String otherUserId, String lang) async {
    final response = await _get('/bazi/compatibility/$otherUserId', queryParameters: {'lang': lang});
    final Map<String, dynamic> jsonMap = json.decode(utf8.decode(response.bodyBytes));
    return BaziReport.fromJson(jsonMap);
  }

  Future<UserProfileCard> completeOnboarding(Map<String, dynamic> data) async {
    final url = Uri.parse('$baseUrl/users/onboarding/complete');
    try {
      final headers = await _getAuthHeaders();
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode(data),
      );
      if (response.statusCode == 200) {
        logger.d('[API_REPO] Онбординг успешно завершен, получен обновленный профиль.');
        // --- 👇 ГЛАВНОЕ ИЗМЕНЕНИЕ 👇 ---
        // Парсим JSON ответа и возвращаем свежий, полный UserProfileCard
        return UserProfileCard.fromJson(json.decode(utf8.decode(response.bodyBytes)));
      } else {
        throw Exception('Failed to complete onboarding: ${response.body}');
      }
    } catch (e) {
      logger.d("--- [API_REPO] КРИТИЧЕСКАЯ ОШИБКА в completeOnboarding: $e");
      rethrow;
    }
  }
  Future<List<TarotCard>> getTarotDeck(String lang) async {
    final response = await _get('/tarot/deck', queryParameters: {'lang': lang});
    final List<dynamic> jsonList = json.decode(utf8.decode(response.bodyBytes));
    // Тебе нужно будет убедиться, что в модели TarotCard есть фабрика fromJson
    return jsonList.map((json) => TarotCard.fromJson(json)).toList();
  }

  Future<TarotCard> getMyCardOfTheDay(String lang) async {
    final response = await _get('/users/me/card-of-the-day', queryParameters: {'lang': lang});
    final Map<String, dynamic> jsonMap = json.decode(utf8.decode(response.bodyBytes));
    return TarotCard.fromJson(jsonMap);
  }

  // НОВЫЙ МЕТОД 1
  Future<Map<String, AspectInterpretation>> getAspectInterpretations({required String lang}) async {
    // Этот запрос НЕ должен содержать WHERE. Он должен загружать ВСЮ таблицу.
    final response = await _get('/astrology/aspect-interpretations?lang=$lang');

    final Map<String, dynamic> jsonMap = json.decode(utf8.decode(response.bodyBytes));

    return jsonMap.map((key, value) => MapEntry(key, AspectInterpretation.fromMap(key, value as Map<String, dynamic>)));
  }
  Future<DailyForecast> getDailyForecast({required String lang}) async {
    // Делаем GET-запрос, передавая язык
    final response = await _get('/astrology/daily-forecast?lang=$lang');
    final Map<String, dynamic> jsonMap = json.decode(utf8.decode(response.bodyBytes));

    // Парсим ответ в нашу Dart-модель
    return DailyForecast.fromJson(jsonMap);
  }

  Future<SearchResults> searchUsersSmart({
    required String query,
    required String lang,
    String? gender,
    int? minAge,
    int? maxAge,
    int offset = 0, // <-- ДОБАВЛЕНО
  }) async {
    final response = await _get('/search/users', queryParameters: {
      'q': query,
      'lang': lang,
      'gender': gender,
      'minAge': minAge?.toString(),
      'maxAge': maxAge?.toString(),
      'offset': offset.toString(),
    });
    // Теперь мы парсим ответ как Map, а не как List
    final Map<String, dynamic> jsonMap = json.decode(utf8.decode(response.bodyBytes));
    return SearchResults.fromJson(jsonMap);
  }

  Future<MoonRhythmResponse> getMoonRhythm({required String lang}) async {
    final response = await _get('/astrology/moon-rhythm?lang=$lang');
    final Map<String, dynamic> jsonMap = json.decode(utf8.decode(response.bodyBytes));
    return MoonRhythmResponse.fromJson(jsonMap);
  }

  Future<List<CosmicEvent>> getCosmicEvents({required String lang}) async {
    // Вызываем наш универсальный метод _get с новым путем
    final response = await _get('/astrology/cosmic-events?lang=$lang');

    // Парсим ответ сервера, который представляет собой список JSON-объектов
    final List<dynamic> jsonList = json.decode(utf8.decode(response.bodyBytes));

    // Твоя сложная модель CosmicEvent.fromJson сама правильно распарсит каждый элемент списка
    return jsonList.map((json) => CosmicEvent.fromJson(json)).toList();
  }

  Future<Map<String, String>> getCompatibilityDescriptions({String lang = 'ru'}) async {
    final response = await _get('/astrology/compatibility-descriptions?lang=$lang');
    final Map<String, dynamic> jsonMap = json.decode(utf8.decode(response.bodyBytes));
    return jsonMap.map((key, value) => MapEntry(key, value.toString()));
  }

  Future<Map<String, dynamic>> getAstroDescriptions({String lang = 'ru'}) async {
    logger.d('--- [API REPO] Запрос на /astrology/descriptions...');
    final response = await _get('/astrology/descriptions?lang=$lang');

    final Map<String, dynamic> jsonMap = json.decode(utf8.decode(response.bodyBytes));

    logger.d('--- [API REPO] AstroDescriptions: Успешно распарсено ${jsonMap.length} ключей.');
    if (jsonMap.containsKey('sun_signs')) {
      logger.d('--- [API REPO] AstroDescriptions: ✅ Тестовый ключ "sun_signs" найден!');
    } else {
      logger.d('--- [API REPO] AstroDescriptions: ❌ ВНИМАНИЕ! Ключ "sun_signs" НЕ НАЙДЕН в ответе!');
    }

    return jsonMap;
  }
  Future<Map<String, String>> getNumerologyCompatibility({required String lang}) async {
    logger.d("\n--- [DEBUG Flutter] Запрос getNumerologyCompatibility для языка '$lang' ---");
    try {
      final response = await _get('/numerology/compatibility-descriptions', queryParameters: {'lang': lang});

      // --- ОТЛАДОЧНЫЕ ЛОГИ ---
      final rawBody = utf8.decode(response.bodyBytes);
      logger.d("[DEBUG Flutter] 1. Сырой ответ от сервера: ${rawBody.substring(0, 150)}..."); // Печатаем начало ответа

      final Map<String, dynamic> jsonMap = json.decode(rawBody);
      // --- ВРЕМЕННЫЙ ЛОГ ---
      print("🔎 [API DEBUG] Ключи совместимости (первые 10): ${jsonMap.keys.take(10).join(', ')}");
      // ---------------------
      logger.d("[DEBUG Flutter] 2. Распарсенный JSON содержит ${jsonMap.length} ключей.");

      if (jsonMap.isNotEmpty) {
        logger.d("[DEBUG Flutter] 3. Пример первого ключа: '${jsonMap.keys.first}'");
        logger.d("[DEBUG Flutter] 4. Пример первого значения: '${jsonMap.values.first}'");
      }
      // -------------------------

      final result = jsonMap.map((key, value) => MapEntry(key, value.toString()));
      logger.d("[DEBUG Flutter] 5. Финальная карта готова к отправке в Cubit.");

      return result;

    } catch (e) {
      logger.d("[DEBUG Flutter] ❌ КРИТИЧЕСКАЯ ОШИБКА в getNumerologyCompatibility: $e");
      return {};
    }
  }

  Future<DailyHybridForecast> getHybridForecast({required String lang}) async {
    // Передаем язык в query параметрах
    final response = await _get('/api/forecast/hybrid', queryParameters: {'lang': lang});

    final Map<String, dynamic> jsonMap = json.decode(utf8.decode(response.bodyBytes));
    return DailyHybridForecast.fromMap(jsonMap);
  }

  Future<Map<String, dynamic>> getTimezoneInfo({
    required double lat,
    required double lng,
    required int timestamp, // UNIX timestamp в секундах
  }) async {
    try {
      // Предполагаем, что на бэкенде есть эндпоинт, который возвращает { "gmtOffset": 10800, ... }
      // Если его нет, сервер вернет 404, и мы поймаем ошибку
      final response = await _get('/astrology/timezone', queryParameters: {
        'lat': lat.toString(),
        'lng': lng.toString(),
        'timestamp': timestamp.toString(),
      });

      return json.decode(utf8.decode(response.bodyBytes));
    } catch (e) {
      logger.d("⚠️ [API_REPO] Ошибка получения таймзоны (используем локальное время): $e");
      // Возвращаем дефолтное значение (смещение 0), чтобы приложение не упало
      return {'gmtOffset': 0, 'zoneName': 'UTC'};
    }
  }

  Future<Map<String, dynamic>> getTransitInterpretations() async {
    final response = await _get('/astrology/transit-interpretations');
    return json.decode(utf8.decode(response.bodyBytes));
  }








  Future<void> updateUserLocation(double latitude, double longitude) async {
    final url = Uri.parse('$baseUrl/users/location');
    try {
      final headers = await _getAuthHeaders();
      final response = await http.put(
        url,
        headers: headers,
        body: json.encode({'latitude': latitude, 'longitude': longitude}),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to update location: ${response.body}');
      }
      logger.d('[API_REPO] Геолокация успешно обновлена на бэкенде.');
    } catch (e) {
      logger.d("--- [API_REPO] КРИТИЧЕСКАЯ ОШИБКА в updateUserLocation: $e");
      rethrow;
    }
  }
// --- 👆 Конец исправления 👆 ---
}

