// lib/services/websocket_service.dart

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:lovequest/services/logger_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketEvent {
  final String type;
  final dynamic payload;
  WebSocketEvent({required this.type, this.payload});
}

class WebSocketService {
  WebSocketService._privateConstructor();
  static final WebSocketService instance = WebSocketService._privateConstructor();

  String get wsUrl {
    if (kDebugMode) {
      if (kIsWeb) return 'ws://localhost:3000';
      if (Platform.isAndroid) return 'ws://10.0.2.2:3000';
      return 'ws://localhost:3000';
    }
    return 'wss://api.psylergy.com';
  }

  WebSocketChannel? _channel;
  StreamSubscription? _streamSubscription;
  Timer? _reconnectTimer;
  bool _isConnecting = false;
  bool _isConnected = false;

  // Очередь сообщений, которые не удалось отправить
  final List<String> _messageQueue = [];

  final StreamController<WebSocketEvent> _eventController = StreamController.broadcast();
  Stream<WebSocketEvent> get events => _eventController.stream;

  /// Подключение к серверу
  Future<void> connect() async {
    if (_isConnected || _isConnecting) return;

    _isConnecting = true;
    logger.d("[WS Service] 🔄 Попытка подключения к $wsUrl...");

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');

    if (token == null) {
      logger.d("[WS Service] ❌ Токен не найден. Остановка попыток.");
      _isConnecting = false;
      return;
    }

    try {
      final urlWithToken = Uri.parse('$wsUrl?token=$token');

      // Создаем канал
      _channel = WebSocketChannel.connect(urlWithToken);

      // Ожидаем готовности (костыль для проверки соединения, так как channel.ready может висеть)
      // В dart web_socket_channel нет явного метода 'onOpen', поэтому считаем подключенным сразу,
      // но реальная проверка будет в stream.listen

      await _streamSubscription?.cancel();
      _streamSubscription = _channel!.stream.listen(
            (message) {
          if (!_isConnected) {
            logger.d("[WS Service] ✅ Соединение установлено!");
            _isConnected = true;
            _isConnecting = false;
            _flushQueue(); // Отправляем всё, что накопилось
          }

          try {
            final data = json.decode(message) as Map<String, dynamic>;
            // Игнорируем сервисные сообщения (pong и т.д.)
            _eventController.add(WebSocketEvent(
              type: data['type'] ?? 'unknown',
              payload: data['payload'],
            ));
          } catch (e) {
            logger.d("[WS Service] Ошибка парсинга: $e");
          }
        },
        onDone: () {
          logger.d("[WS Service] 🔻 Соединение закрыто (onDone).");
          _handleDisconnect();
        },
        onError: (error) {
          logger.d("[WS Service] ❌ Ошибка сокета: $error");
          _handleDisconnect();
        },
        cancelOnError: true,
      );

    } catch (e) {
      logger.d("[WS Service] ❌ Ошибка при создании канала: $e");
      _handleDisconnect();
    }
  }

  /// Отправка сообщения
  void send(Map<String, dynamic> data) {
    final jsonMessage = json.encode(data);

    if (_isConnected && _channel != null) {
      try {
        _channel!.sink.add(jsonMessage);
        // logger.d("[WS Service] ➡️ Отправлено: $jsonMessage"); // Слишком много логов
      } catch (e) {
        logger.d("[WS Service] Ошибка отправки, добавляю в очередь.");
        _messageQueue.add(jsonMessage);
        _handleDisconnect(); // Скорее всего сокет умер
      }
    } else {
      logger.d("[WS Service] ⏳ Сокет не готов. Сообщение добавлено в очередь.");
      _messageQueue.add(jsonMessage);
      if (!_isConnecting) connect(); // Пытаемся поднять
    }
  }

  /// Отправка очереди сообщений
  void _flushQueue() {
    if (_messageQueue.isEmpty) return;

    logger.d("[WS Service] 📤 Отправка ${_messageQueue.length} сообщений из очереди...");
    for (final msg in _messageQueue) {
      _channel?.sink.add(msg);
    }
    _messageQueue.clear();
  }

  void sendTypingStatus({required String chatId, required bool isTyping}) {
    // Статусы печати можно не класть в очередь, они устаревают быстро
    if (_isConnected) {
      send({
        'type': 'typing_status',
        'payload': {'chatId': chatId, 'isTyping': isTyping},
      });
    }
  }

  void disconnect() {
    _reconnectTimer?.cancel();
    _streamSubscription?.cancel();
    _channel?.sink.close();
    _channel = null;
    _isConnected = false;
    _isConnecting = false;
    _messageQueue.clear();
  }

  void _handleDisconnect() {
    _isConnected = false;
    _isConnecting = false;
    _channel = null;
    _streamSubscription?.cancel();

    if (_reconnectTimer?.isActive ?? false) return;

    logger.d("[WS Service] 🔄 Переподключение через 5 секунд...");
    _reconnectTimer = Timer(const Duration(seconds: 5), () {
      connect();
    });
  }
}