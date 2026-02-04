// lib/src/data/models/message.dart

import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final String id;
  final String? chatId;
  final String senderId;
  final String recipientId; // <-- ДОБАВЛЕНО: ID получателя, нужен для отправки
  final String text;
  final DateTime createdAt; // <-- ПЕРЕИМЕНОВАНО: Используем 'createdAt' для единообразия с сервером
  final String? imageUrl;
  final String? audioUrl;
  final bool isRead;
  final String? clientTempId;

  const Message({
    required this.id,
    this.chatId,
    required this.senderId,
    required this.recipientId, // <-- ДОБАВЛЕНО
    required this.text,
    required this.createdAt,   // <-- ПЕРЕИМЕНОВАНО
    this.imageUrl,
    this.audioUrl,
    this.isRead = false,
    this.clientTempId,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      // Сервер присылает id как UUID (строку) или bigint, приводим к строке
      id: json['id'].toString(),
      chatId: json['chatId'] as String?,
      senderId: json['senderId'] as String? ?? '',
      recipientId: json['recipientId'] as String? ?? '', // <-- ДОБАВЛЕНО
      text: json['text'] as String? ?? '',
      // Сервер присылает дату как строку ISO 8601, парсим ее в DateTime
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(), // <-- ПЕРЕИМЕНОВАНО
      imageUrl: json['imageUrl'] as String?,
      audioUrl: json['audioUrl'] as String?,
      isRead: json['isRead'] as bool? ?? json['is_read'] as bool? ?? false,
      clientTempId: json['clientTempId'] as String?,
    );
  }

  // Метод для преобразования в JSON для отправки на сервер
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'chatId': chatId,
      'senderId': senderId,
      'recipientId': recipientId, // <-- ДОБАВЛЕНО
      'text': text,
      // Преобразуем DateTime в строку формата ISO 8601
      'createdAt': createdAt.toIso8601String(), // <-- ИСПРАВЛЕНО
      'imageUrl': imageUrl,
      'audioUrl': audioUrl,
      'isRead': isRead,
      'clientTempId': clientTempId,
    };
  }

  Message copyWith({
    String? id,
    String? chatId,
    String? senderId,
    String? recipientId, // <-- ДОБАВЛЕНО
    String? text,
    DateTime? createdAt, // <-- ПЕРЕИМЕНОВАНО
    String? imageUrl,
    String? audioUrl,
    bool? isRead,
    String? clientTempId,
  }) {
    return Message(
      id: id ?? this.id,
      chatId: chatId ?? this.chatId,
      senderId: senderId ?? this.senderId,
      recipientId: recipientId ?? this.recipientId, // <-- ДОБАВЛЕНО
      text: text ?? this.text,
      createdAt: createdAt ?? this.createdAt,       // <-- ПЕРЕИМЕНОВАНО
      imageUrl: imageUrl ?? this.imageUrl,
      audioUrl: audioUrl ?? this.audioUrl,
      isRead: isRead ?? this.isRead,
      clientTempId: clientTempId ?? this.clientTempId,
    );
  }

  @override
  List<Object?> get props => [
    id,
    chatId,
    senderId,
    recipientId,
    text,
    createdAt,
    imageUrl,
    audioUrl,
    isRead,
    clientTempId,
  ];
}