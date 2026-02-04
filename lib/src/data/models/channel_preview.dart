// lib/src/data/models/channel_preview.dart

import 'package:equatable/equatable.dart';

// Вспомогательная функция для безопасного парсинга даты
DateTime? _dateTimeFromDynamic(dynamic json) {
  if (json == null) return null;
  if (json is String) return DateTime.tryParse(json);
  // Добавь другие форматы, если сервер может присылать их
  return null;
}

class ChannelPreview extends Equatable {
  final int id;
  final String name;
  final String? avatarUrl;
  final String? lastMessageText;
  final DateTime? lastMessageTimestamp;
  final int unreadCount;

  const ChannelPreview({
    required this.id,
    required this.name,
    this.avatarUrl,
    this.lastMessageText,
    this.lastMessageTimestamp,
    this.unreadCount = 0,
  });

  factory ChannelPreview.fromJson(Map<String, dynamic> json) {

    // --- 👇 НОВАЯ ФУНКЦИЯ-ПОМОЩНИК ДЛЯ БЕЗОПАСНОГО ПАРСИНГА ЧИСЕЛ 👇 ---
    int _parseInt(dynamic value) {
      if (value == null) return 0;
      if (value is int) return value;
      if (value is String) {
        return int.tryParse(value) ?? 0; // Пытаемся распарсить строку, если не вышло - возвращаем 0
      }
      return 0; // Возвращаем 0 для любых других неожиданных типов
    }
    // --- 👆 КОНЕЦ ФУНКЦИИ-ПОМОЩНИКА 👆 ---

    return ChannelPreview(
      // Используем нашу новую функцию для всех числовых полей
      id: _parseInt(json['id']),
      unreadCount: _parseInt(json['unreadCount']),

      // Остальные поля остаются как есть
      name: json['name'] ?? 'Без имени',
      avatarUrl: json['avatarUrl'],
      lastMessageText: json['lastMessageText'],
      // Для даты тоже делаем безопасный парсинг
      lastMessageTimestamp: json['lastMessageTimestamp'] != null
          ? DateTime.tryParse(json['lastMessageTimestamp'])
          : null,
    );
  }

  ChannelPreview copyWith({
    int? unreadCount,
  }) {
    return ChannelPreview(
      id: id,
      name: name,
      avatarUrl: avatarUrl,
      lastMessageText: lastMessageText,
      lastMessageTimestamp: lastMessageTimestamp,
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }

  @override
  List<Object?> get props => [id, name, avatarUrl, lastMessageText, lastMessageTimestamp, unreadCount];
}