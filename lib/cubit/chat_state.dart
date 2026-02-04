// lib/cubit/chat_state.dart

import 'package:equatable/equatable.dart';
import 'package:lovequest/src/data/models/user_profile_card.dart';
import 'package:lovequest/src/data/models/message.dart' as chat_models;

enum ChatStatus { initial, loading, success, error }

class ChatState extends Equatable {
  // --- Основные данные чата ---
  final String? chatId; // СДЕЛАЛИ НЕОБЯЗАТЕЛЬНЫМ
  final List<chat_models.Message> messages;
  final ChatStatus status;

  // --- Данные собеседника/группы ---
  final UserProfileCard? otherUser; // Для личных чатов
  final bool isGroupChat;
  final String? groupChatTitle;
  final List<UserProfileCard> groupMembers;

  // --- Вспомогательные флаги и данные ---
  final bool isPartnerTyping;
  final String? errorMessage;
  final DateTime? expiresAt; // Для временных чатов

  const ChatState({
    this.chatId, // ТЕПЕРЬ ОН НЕОБЯЗАТЕЛЬНЫЙ
    this.messages = const [],
    this.status = ChatStatus.initial,
    this.otherUser,
    this.isGroupChat = false,
    this.groupChatTitle,
    this.groupMembers = const [],
    this.isPartnerTyping = false,
    this.errorMessage,
    this.expiresAt,
  });

  ChatState copyWith({
    String? chatId,
    List<chat_models.Message>? messages,
    ChatStatus? status,
    UserProfileCard? otherUser,
    bool? isGroupChat,
    String? groupChatTitle,
    List<UserProfileCard>? groupMembers,
    bool? isPartnerTyping,
    String? errorMessage,
    DateTime? expiresAt,
  }) {
    return ChatState(
      chatId: chatId ?? this.chatId,
      messages: messages ?? this.messages,
      status: status ?? this.status,
      otherUser: otherUser ?? this.otherUser,
      isGroupChat: isGroupChat ?? this.isGroupChat,
      groupChatTitle: groupChatTitle ?? this.groupChatTitle,
      groupMembers: groupMembers ?? this.groupMembers,
      isPartnerTyping: isPartnerTyping ?? this.isPartnerTyping,
      errorMessage: errorMessage ?? this.errorMessage,
      expiresAt: expiresAt ?? this.expiresAt,
    );
  }

  @override
  List<Object?> get props => [
    chatId,
    messages,
    status,
    otherUser,
    isGroupChat,
    groupChatTitle,
    groupMembers,
    isPartnerTyping,
    errorMessage,
    expiresAt,
  ];
}