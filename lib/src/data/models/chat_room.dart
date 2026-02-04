// lib/src/data/models/chat_room.dart (НОВАЯ, УНИВЕРСАЛЬНАЯ ВЕРСИЯ)

import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoom {
  final String id;
  final List<String> participantIds; // Переименовываем userIds для ясности

  // Поля для личных и групповых чатов
  final String? title; // У групповых чатов есть название
  final bool isGroupChat;
  final Map<String, bool> isTyping;

  // Поля для временных чатов
  final DateTime? expiresAt;

  // Поля, которые приходят из Firestore для списка чатов
  final String? lastMessage;
  final Timestamp? lastMessageTimestamp;
  final String? lastMessageSenderId;
  final Map<String, int> unreadCounts;

  ChatRoom({
    required this.id,
    required this.participantIds,
    this.title,
    this.isGroupChat = false,
    this.expiresAt,
    this.lastMessage,
    this.lastMessageTimestamp,
    this.lastMessageSenderId,
    this.unreadCounts = const {},
    this.isTyping = const {},
  });

  // Фабричный конструктор для данных, приходящих с НАШЕГО API
  factory ChatRoom.fromJson(Map<String, dynamic> json) {
    return ChatRoom(
      id: json['id'] as String? ?? '',
      title: json['title'] as String?,
      participantIds: List<String>.from(json['participantIds'] ?? []),
      isGroupChat: json['type'] != null, // Считаем групповым, если есть поле type
      expiresAt: json['expiresAt'] != null
          ? DateTime.tryParse(json['expiresAt'] as String)
          : null,
    );
  }

  // Фабричный конструктор для данных, приходящих из FIRESTORE
  factory ChatRoom.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return ChatRoom(
      id: doc.id,
      participantIds: List<String>.from(data['userIds'] ?? []),
      isGroupChat: data['isGroup'] as bool? ?? false,
      title: data['name'] as String?, // В Firestore поле может называться 'name'
      lastMessage: data['lastMessage'] as String?,
      lastMessageTimestamp: data['lastMessageTimestamp'] as Timestamp?,
      lastMessageSenderId: data['lastMessageSenderId'] as String?,
      unreadCounts: Map<String, int>.from(data['unreadCounts'] ?? {}),
      expiresAt: (data['expiresAt'] as Timestamp?)?.toDate(),
      isTyping: Map<String, bool>.from(data['isTyping'] ?? {}),
    );
  }
}