// lib/cubit/chat_cubit.dart

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:lovequest/cubit/app_cubit.dart';
import 'package:lovequest/cubit/chat_state.dart';
import 'package:lovequest/repositories/api_repository.dart';
import 'package:lovequest/services/websocket_service.dart';
import 'package:lovequest/src/data/models/message.dart'; // Убрал alias, так проще
import 'package:lovequest/src/data/models/user_profile_card.dart';
import 'package:uuid/uuid.dart';

import '../services/logger_service.dart';

class ChatCubit extends Cubit<ChatState> {
  final ApiRepository _apiRepository;
  final AppCubit _appCubit;
  StreamSubscription? _webSocketSubscription; // Используем это имя везде
  Timer? _typingTimer;
  // final _uuid = const Uuid(); // Не используется, можно убрать

  ChatCubit({
    required ApiRepository apiRepository,
    required AppCubit appCubit,
  })  : _apiRepository = apiRepository,
        _appCubit = appCubit,
        super(const ChatState());

  // Метод для инициализации личного чата
  Future<void> initPersonalChat(String chatId, UserProfileCard otherUser) async {
    emit(state.copyWith(
      chatId: chatId,
      otherUser: otherUser,
      status: ChatStatus.loading,
    ));

    try {
      // 1. Загружаем историю
      final history = await _apiRepository.getChatMessages(chatId);
      // Разворачиваем, чтобы новые были внизу (если список reverse: true)
      emit(state.copyWith(
        messages: history.toList(),
        status: ChatStatus.success,
      ));

      // 2. Помечаем прочитанным
      _apiRepository.markChatAsRead(chatId);

      // 3. ПОДПИСЫВАЕМСЯ НА СОБЫТИЯ
      _subscribeToWebSocket(chatId);

    } catch (e) {
      emit(state.copyWith(status: ChatStatus.error, errorMessage: e.toString()));
    }
  }

  void _subscribeToWebSocket(String chatId) {
    _webSocketSubscription?.cancel(); // ИСПРАВЛЕНО
    _webSocketSubscription = WebSocketService.instance.events.listen((event) { // ИСПРАВЛЕНО
      // А) Новое сообщение
      if (event.type == 'new_message') {
        final msg = Message.fromJson(event.payload);
        if (msg.chatId == chatId) {
          _onNewMessageReceived(msg);
        }
      }

      // Б) Статус "Прочитано" (Синие галочки)
      if (event.type == 'chat_read_status') {
        final payload = event.payload as Map<String, dynamic>;
        if (payload['chatId'] == chatId) {
          // Ставим галочки всем моим сообщениям
          final myId = _appCubit.state.currentUserProfile?.id;
          final updated = state.messages.map((m) {
            if (m.senderId == myId && !m.isRead) {
              return m.copyWith(isRead: true);
            }
            return m;
          }).toList();
          emit(state.copyWith(messages: updated));
        }
      }

      // В) Статус "Печатает"
      if (event.type == 'partner_typing_status') {
        final payload = event.payload as Map<String, dynamic>;
        if (payload['chatId'] == chatId) {
          emit(state.copyWith(isPartnerTyping: payload['isTyping'] ?? false));
        }
      }
    });
  }

  Future<void> deleteChat() async {
    final chatId = state.chatId;
    if (chatId == null) return;

    try {
      await _apiRepository.deleteChat(chatId);
    } catch (e) {
      emit(state.copyWith(errorMessage: "Не удалось удалить чат"));
    }
  }

  void _onNewMessageReceived(Message message) {
    // Проверяем дубликаты (оптимистичные)
    final index = state.messages.indexWhere((m) =>
    m.id == message.id ||
        (m.clientTempId != null && m.clientTempId == message.clientTempId)
    );

    List<Message> updatedList = List.from(state.messages);

    if (index != -1) {
      // Обновляем существующее
      updatedList[index] = message.copyWith(isRead: false);
    } else {
      // Пришло новое от собеседника - добавляем в начало (для reverse list)
      updatedList.insert(0, message);

      // Если это от собеседника - помечаем прочитанным
      if (message.senderId != _appCubit.state.currentUserProfile?.id) {
        _apiRepository.markChatAsRead(state.chatId!);
      }
    }
    emit(state.copyWith(messages: updatedList));
  }

  Future<void> setMessageTTL(int? minutes) async {
    if (state.chatId == null) return;
    try {
      await _apiRepository.updateChatSettings(state.chatId!, minutes);
    } catch (e) {
      logger.d("Ошибка установки таймера: $e");
    }
  }

  void onTyping() {
    if (state.chatId == null) return;
    WebSocketService.instance.sendTypingStatus(chatId: state.chatId!, isTyping: true);
    _typingTimer?.cancel();
    _typingTimer = Timer(const Duration(seconds: 2), () {
      if (state.chatId != null) {
        WebSocketService.instance.sendTypingStatus(chatId: state.chatId!, isTyping: false);
      }
    });
  }

  Future<void> sendMessage(String text) async {
    final chatId = state.chatId;
    final sender = _appCubit.state.currentUserProfile;
    if (chatId == null || sender == null) return;

    final tempId = 'temp_${const Uuid().v4()}';

    // Оптимистичное сообщение
    final optimisticMsg = Message(
      id: tempId,
      chatId: chatId,
      senderId: sender.id,
      recipientId: state.otherUser?.id ?? '',
      text: text,
      createdAt: DateTime.now(),
      clientTempId: tempId,
      isRead: false, // <-- СЕРАЯ ГАЛОЧКА
    );

    // Сразу показываем в чате
    final newList = List<Message>.from(state.messages)..insert(0, optimisticMsg);
    emit(state.copyWith(messages: newList));
    logger.d("ChatCubit: UI обновлен оптимистично. Новых сообщений: ${newList.length}");

    // Вызываем AppCubit, чтобы он обновил список чатов (последнее сообщение)
    _appCubit.updateChatListOptimistically(chatId, text, DateTime.now());

    try {
      await _apiRepository.sendMessage(
        chatId: chatId,
        recipientId: state.otherUser?.id ?? '',
        senderId: sender.id,
        text: text,
        clientTempId: tempId,
        senderProfile: sender,
      );
    } catch (e) {
      // Можно добавить логику отката или пометки "ошибка отправки"
    }
  }

  @override
  Future<void> close() {
    _webSocketSubscription?.cancel();
    _typingTimer?.cancel();
    if (state.chatId != null) {
      WebSocketService.instance.sendTypingStatus(chatId: state.chatId!, isTyping: false);
    }
    return super.close();
  }
}