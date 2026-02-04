// lib/src/data/models/channel.dart

import 'package:equatable/equatable.dart';

                                                                                                                                                                                       class Channel extends Equatable {
  final int id;
  // --- 👇 ИЗМЕНЕНИЕ 1: Тип меняется на Map<String, String> 👇 ---
  final Map<String, String> name;
  final Map<String, String> description;
  // --- 👆 КОНЕЦ ИЗМЕНЕНИЯ 👆 ---
  final String? avatarUrl;
  final String handle;
  final int ownerId;
  final int subscriberCount;
  final bool isPrivate;
  final String? inviteKey;
  final String postAuthorship; // 'owner', 'channel', 'anonymous'
  final String? pinnedPostId;

  const Channel({
    required this.id,
    required this.name,
    required this.description,
    this.avatarUrl,
    required this.handle,
    required this.ownerId,
    this.subscriberCount = 0,
    this.isPrivate = false,
    this.inviteKey,
    this.postAuthorship = 'owner',
    this.pinnedPostId,
  });

  // --- 👇 ИЗМЕНЕНИЕ 2: Новые методы для получения локализованного текста 👇 ---
  String getLocalizedName(String langCode, {String fallbackLang = 'ru'}) {
    return name[langCode] ?? name[fallbackLang] ?? name.values.firstOrNull ?? handle;
  }

  String getLocalizedDescription(String langCode, {String fallbackLang = 'ru'}) {
    return description[langCode] ?? description[fallbackLang] ?? description.values.firstOrNull ?? '';
  }
  // --- 👆 КОНЕЦ ИЗМЕНЕНИЯ 👆 ---

  // --- 👇 ИЗМЕНЕНИЕ 3: Исправляем конструктор fromJson 👇 ---
  factory Channel.fromJson(Map<String, dynamic> json) {
    // Вспомогательная функция для безопасного парсинга JSON-объекта в Map<String, String>
    Map<String, String> _parseLocalizedMap(dynamic field) {
      if (field is Map) {
        // Преобразуем ключи и значения в String на всякий случай
        return field.map((key, value) => MapEntry(key.toString(), value.toString()));
      }
      if (field is String) {
        // Если вдруг пришла простая строка, создаем карту с одним языком
        return {'ru': field};
      }
      return {}; // В худшем случае возвращаем пустую карту
    }

    // Вспомогательная функция для парсинга чисел (мы ее уже писали)
    int _parseInt(dynamic value) {
      if (value == null) return 0;
      if (value is int) return value;
      if (value is String) return int.tryParse(value) ?? 0;
      return 0;
    }

    return Channel(
      id: _parseInt(json['id']),
      name: _parseLocalizedMap(json['name']), // Используем хелпер
      description: _parseLocalizedMap(json['description']), // Используем хелпер
      avatarUrl: json['avatarUrl'],
      handle: json['handle'] ?? '',
      ownerId: _parseInt(json['ownerId']),
      subscriberCount: _parseInt(json['subscriberCount']),
      isPrivate: json['isPrivate'] ?? false,
      inviteKey: json['inviteKey'],
      postAuthorship: json['postAuthorship'] ?? 'owner',
      pinnedPostId: json['pinnedPostId']?.toString(), // Безопасно приводим к строке
    );
  }
  // --- 👆 КОНЕЦ ИЗМЕНЕНИЯ 👆 ---

  @override
  List<Object?> get props => [
    id, name, description, avatarUrl, handle, ownerId, subscriberCount,
    isPrivate, inviteKey, postAuthorship, pinnedPostId
  ];

  // Добавим copyWith, он пригодится
  Channel copyWith({
    int? id,
    Map<String, String>? name,
    Map<String, String>? description,
    String? avatarUrl,
    String? handle,
    int? ownerId,
    int? subscriberCount,
    bool? isPrivate,
    String? inviteKey,
    String? postAuthorship,
    String? pinnedPostId,
  }) {
    return Channel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      handle: handle ?? this.handle,
      ownerId: ownerId ?? this.ownerId,
      subscriberCount: subscriberCount ?? this.subscriberCount,
      isPrivate: isPrivate ?? this.isPrivate,
      inviteKey: inviteKey ?? this.inviteKey,
      postAuthorship: postAuthorship ?? this.postAuthorship,
      pinnedPostId: pinnedPostId ?? this.pinnedPostId,
    );
  }
}