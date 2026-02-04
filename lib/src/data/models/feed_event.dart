// lib/src/data/models/feed_event.dart

import 'package:flutter/foundation.dart';
import '../../../services/logger_service.dart';

// --- 1. БАЗОВЫЙ АБСТРАКТНЫЙ КЛАСС ---
// Определяет общую структуру для всех событий в ленте.
@immutable
abstract class FeedEvent {
  final String id;
  final String type;
  final String title;
  final String description;
  final String? actionPath;
  final String? actionButtonText;
  final DateTime createdAt;
  final Map<String, dynamic>? eventData;

  const FeedEvent({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    this.actionPath,
    this.actionButtonText,
    required this.createdAt,
    this.eventData,
  });

  // Главный парсер, который делегирует работу конкретным классам.
  // Это "фабрика", которая решает, какой именно тип события создать.
  factory FeedEvent.fromJson(Map<String, dynamic> json) {
    final type = json['event_type'] as String? ?? 'UNKNOWN';

    try {
      logger.v("--- 🔬 PARSING FeedEvent (type: $type) ---");

      switch (type) {
        case 'PARTNER_OF_THE_DAY':
          return PartnerOfTheDayEvent.fromJson(json);
        case 'SPIRITUAL_NEIGHBOR':
          return SpiritualNeighborEvent.fromJson(json);
        case 'COMPATIBILITY_PEAK':
          return CompatibilityPeakEvent.fromJson(json);
        case 'ORBIT_CROSSING':
          return OrbitCrossingEvent.fromJson(json);
        case 'SHARED_CARD_OF_THE_DAY':
          return SharedCardEvent.fromJson(json);
        case 'NUMEROLOGY_TWIN':
          return NumerologyTwinEvent.fromJson(json);
        case 'CHALLENGE_DAY':
          return ChallengeDayEvent.fromJson(json);
        case 'NEW_CHANNEL_SUGGESTION':
          return NewChannelSuggestionEvent.fromJson(json);
        case 'POPULAR_POST_IN_CHANNEL':
          return PopularPostEvent.fromJson(json);

      // Все простые и неизвестные типы обрабатываются одним классом
        case 'GEOMAGNETIC_STORM':
        case 'NEW_LIKE':
        case 'CARD_OF_THE_DAY':
        case 'HOUSE_ACTIVATION':
        default:
          if (type == 'UNKNOWN' || type == 'default') {
            logger.w("Unknown FeedEvent type. JSON: $json");
          }
          return _SimpleFeedEvent.fromJson(json);
      }
    } catch (e, s) {
      logger.e("CRITICAL PARSING ERROR for event type '$type'", error: e, stackTrace: s);
      logger.e("FAULTY JSON: $json");
      // В случае ошибки парсинга, создаем "событие-заглушку", чтобы приложение не падало.
      return _SimpleFeedEvent.error(type: type, error: e.toString());
    }
  }
}

// --- 2. УНИВЕРСАЛЬНЫЙ КЛАСС ДЛЯ ПРОСТЫХ СОБЫТИЙ ---
// Этот класс реализует FeedEvent и служит базой для всех остальных.
class _SimpleFeedEvent extends FeedEvent {
  // Основной конструктор.
  const _SimpleFeedEvent({
    required super.id,
    required super.type,
    required super.title,
    required super.description,
    required super.createdAt,
    super.actionPath,
    super.actionButtonText,
    super.eventData,
  });

  // Именованный генеративный конструктор для парсинга из JSON.
  _SimpleFeedEvent.fromJson(Map<String, dynamic> json)
      : super(
    id: json['id'].toString(),
    type: json['event_type'] as String? ?? 'UNKNOWN',
    title: json['title'] as String? ?? 'Событие',
    description: json['description'] as String? ?? 'Описание отсутствует',
    createdAt: DateTime.parse(json['created_at'] as String),
    actionPath: json['action_path'] as String?,
    actionButtonText: json['action_button_text'] as String?,
    eventData: json['event_data'] as Map<String, dynamic>?,
  );

  // Фабричный конструктор для создания события-ошибки.
  factory _SimpleFeedEvent.error({required String type, required String error}) {
    return _SimpleFeedEvent(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      type: 'ERROR',
      title: 'Ошибка загрузки события',
      description: 'Не удалось обработать событие типа "$type". Ошибка: $error',
      createdAt: DateTime.now(),
    );
  }
}

// --- 3. СПЕЦИАЛИЗИРОВАННЫЕ КЛАССЫ-НАСЛЕДНИКИ ---
// Они наследуются от _SimpleFeedEvent, а не от FeedEvent.

class PartnerOfTheDayEvent extends _SimpleFeedEvent {
  final String partnerId;
  final String? partnerAvatarUrl;
  final int compatibilityScore;

  PartnerOfTheDayEvent.fromJson(Map<String, dynamic> json)
      : partnerId = json['related_user_id'] as String? ?? '',
        partnerAvatarUrl = (json['event_data'] as Map<String, dynamic>?)?['userAvatar'] as String?,
        compatibilityScore = (json['event_data'] as Map<String, dynamic>?)?['compatibilityScore'] as int? ?? 0,
        super.fromJson(json); // Вызываем родительский конструктор для парсинга общих полей
}

class CompatibilityPeakEvent extends _SimpleFeedEvent {
  final String partnerId;
  final String iceBreakerMessage;

  CompatibilityPeakEvent.fromJson(Map<String, dynamic> json)
      : partnerId = json['related_user_id'] as String? ?? '',
        iceBreakerMessage = (json['event_data'] as Map<String, dynamic>?)?['iceBreaker'] as String? ?? 'Привет!',
        super.fromJson(json);
}

class OrbitCrossingEvent extends _SimpleFeedEvent {
  final String strangerId;
  final String iceBreakerMessage;

  OrbitCrossingEvent.fromJson(Map<String, dynamic> json)
      : strangerId = json['related_user_id'] as String? ?? '',
        iceBreakerMessage = (json['event_data'] as Map<String, dynamic>?)?['iceBreaker'] as String? ?? 'Привет! Кажется, мы были где-то рядом :)',
        super.fromJson(json);
}

class SpiritualNeighborEvent extends _SimpleFeedEvent {
  final String partnerId;
  final String iceBreakerMessage;

  SpiritualNeighborEvent.fromJson(Map<String, dynamic> json)
      : partnerId = json['related_user_id'] as String? ?? '',
        iceBreakerMessage = (json['event_data'] as Map<String, dynamic>?)?['iceBreaker'] as String? ?? 'Привет! У нас много общего!',
        super.fromJson(json);
}

class SharedCardEvent extends _SimpleFeedEvent {
  final List<String> participants;
  final String chatTitle;

  SharedCardEvent.fromJson(Map<String, dynamic> json)
      : participants = ((json['event_data'] as Map<String, dynamic>?)?['participants'] as List<dynamic>? ?? []).map((e) => e.toString()).toList(),
        chatTitle = (json['event_data'] as Map<String, dynamic>?)?['chatTitle'] as String? ?? 'Общий чат',
        super.fromJson(json);
}

// Простые классы, у которых нет своих уникальных полей.
// Их конструктор просто вызывает родительский.

class NewChannelSuggestionEvent extends _SimpleFeedEvent {
  NewChannelSuggestionEvent.fromJson(Map<String, dynamic> json) : super.fromJson(json);
}

class PopularPostEvent extends _SimpleFeedEvent {
  PopularPostEvent.fromJson(Map<String, dynamic> json) : super.fromJson(json);
}

class NumerologyTwinEvent extends _SimpleFeedEvent {
  NumerologyTwinEvent.fromJson(Map<String, dynamic> json) : super.fromJson(json);
}

class ChallengeDayEvent extends _SimpleFeedEvent {
  ChallengeDayEvent.fromJson(Map<String, dynamic> json) : super.fromJson(json);
}