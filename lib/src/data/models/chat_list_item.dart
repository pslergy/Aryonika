// lib/src/data/models/chat_list_item.dart

import 'package:equatable/equatable.dart';
import 'package:lovequest/src/data/models/user_profile_card.dart';

// Вспомогательная функция для безопасного парсинга DateTime из разных форматов (строка, int, Timestamp)
// Она должна быть ВНЕ класса.
DateTime _dateTimeFromDynamic(dynamic json) {
  if (json == null) return DateTime.now();
  if (json is String) return DateTime.tryParse(json) ?? DateTime.now();
  if (json is int) return DateTime.fromMillisecondsSinceEpoch(json);
  // На случай, если где-то остался Timestamp от Firebase
  if (json.runtimeType.toString() == 'Timestamp') {
    return (json as dynamic).toDate();
  }
  return DateTime.now();
}

class ChatListItem extends Equatable {
  final String chatId;
  final UserProfileCard? otherUser;
  final String lastMessage;
  final String lastMessageSenderId;
  final DateTime lastMessageTimestamp;
  final int unreadCount;
  final int otherUserUnreadCount;
  final bool isTyping; // Поле для статуса "печатает"

  const ChatListItem({
    required this.chatId,
    this.otherUser,
    required this.lastMessage,
    required this.lastMessageSenderId,
    required this.lastMessageTimestamp,
    required this.unreadCount,
    required this.otherUserUnreadCount,
    this.isTyping = false, // Значение по умолчанию
  });

  // Фабричный конструктор для создания объекта из JSON
  factory ChatListItem.fromJson(Map<String, dynamic> json) {
    // Создаем объект otherUser, гарантируя, что все поля будут не-null там, где это требуется
    final otherUser = UserProfileCard(
      id: json['partnerId'] as String? ?? '',
      name: json['partnerName'] as String? ?? 'Собеседник',

      // --- 👇 ГЛАВНОЕ ИСПРАВЛЕНИЕ ЗДЕСЬ 👇 ---
      // Если 'partnerAvatarUrl' отсутствует или null, подставляем пустую строку '',
      // потому что поле 'avatar' в UserProfileCard не может быть null.
      avatar: json['partnerAvatarUrl'] as String? ?? '',

      // Остальные обязательные поля UserProfileCard, которых нет в JSON ответа
      birthDateMillis: 0,
      sunSign: '',
    );

    return ChatListItem(
      chatId: json['chatId'] as String? ?? '',
      otherUser: otherUser,
      lastMessage: json['lastMessageText'] as String? ?? '',

      // Это исправление тоже оставляем, оно верное
      lastMessageSenderId: json['lastMessageSenderId'] as String? ?? '',

      lastMessageTimestamp: _dateTimeFromDynamic(json['lastMessageTimestamp']),
      unreadCount: json['unreadCount'] as int? ?? 0,
      otherUserUnreadCount: 0,
    );
  }


  // Метод copyWith для удобного и безопасного обновления объекта
  ChatListItem copyWith({
    String? chatId,
    UserProfileCard? otherUser,
    String? lastMessage,
    String? lastMessageSenderId,
    DateTime? lastMessageTimestamp,
    int? unreadCount,
    int? otherUserUnreadCount,
    bool? isTyping,
  }) {
    return ChatListItem(
      chatId: chatId ?? this.chatId,
      otherUser: otherUser ?? this.otherUser,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageSenderId: lastMessageSenderId ?? this.lastMessageSenderId,
      lastMessageTimestamp: lastMessageTimestamp ?? this.lastMessageTimestamp,
      unreadCount: unreadCount ?? this.unreadCount,
      otherUserUnreadCount: otherUserUnreadCount ?? this.otherUserUnreadCount,
      isTyping: isTyping ?? this.isTyping,
    );
  }

  @override
  List<Object?> get props => [
    chatId,
    otherUser,
    lastMessage,
    lastMessageSenderId,
    lastMessageTimestamp,
    unreadCount,
    otherUserUnreadCount,
    isTyping,
  ];
}