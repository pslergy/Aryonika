// lib/src/data/models/tarot_card.dart
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'astrology/natal_chart.dart'; // Для AssetImage

class TarotCard extends Equatable {
  final int id;
  final String name;
  final String themeKey;
  final String interpretation;
  final String reversedInterpretation;
  final String affirmation;
  final AssetImage image; // Используем AssetImage для локальных картинок
  final bool isReversed;
  final String? astrologicalKey;

  TarotCard({
    required this.id,
    required this.name,
    required this.themeKey,
    required this.interpretation,
    required this.reversedInterpretation,
    required this.affirmation,
    required this.image,
    this.isReversed = false,
    this.astrologicalKey,// По умолчанию карта прямая
  });

  factory TarotCard.fromJson(Map<String, dynamic> json) {
    // --- 👇 НОВЫЙ БЕЗОПАСНЫЙ ПАРСЕР ID 👇 ---
    int parseId(dynamic id) {
      if (id is int) return id;
      if (id is String) return int.tryParse(id) ?? -1;
      return -1;
    }

    final cardId = parseId(json['id']);
    // --- 👆 КОНЕЦ ПАРСЕРА 👆 ---

    return TarotCard(
      id: cardId,
      name: json['name'] as String? ?? 'Unknown Card',
      themeKey: json['themeKey'] as String? ?? '',
      interpretation: json['interpretation'] as String? ?? '',
      reversedInterpretation: json['reversedInterpretation'] as String? ?? '',
      affirmation: json['affirmation'] as String? ?? '',
      astrologicalKey: json['astrologicalKey'] as String?,
      image: AssetImage('assets/tarot/tarot_$cardId.jpg'),
      isReversed: json['isReversed'] as bool? ?? false, // <-- Добавим парсинг isReversed
    );
  }

  // Метод для создания копии с измененным полем isReversed
  TarotCard copyWith({
    bool? isReversed,
    String? astrologicalKey,
  }) {
    return TarotCard(
      id: id,
      name: name,
      themeKey: themeKey,
      interpretation: interpretation,
      reversedInterpretation: reversedInterpretation,
      affirmation: affirmation,
      image: image,
      isReversed: isReversed ?? this.isReversed,
      astrologicalKey: astrologicalKey ?? this.astrologicalKey,
    );
  }
  Planet? get astrologicalPlanet {
    if (astrologicalKey == null) return null;
    try {
      return Planet.values.firstWhere((p) => p.name == astrologicalKey);
    } catch (e) {
      return null;
    }
  }



  @override
  List<Object?> get props => [
    id,
    name,
    themeKey,
    interpretation,
    reversedInterpretation,
    affirmation,
    image,
    isReversed,
    astrologicalKey,
  ];}
