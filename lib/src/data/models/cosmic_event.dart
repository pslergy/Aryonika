// lib/src/data/models/cosmic_event.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class CosmicEvent extends Equatable {
  final String id;
  final String eventType;
  final DateTime eventDate;
  // --- 👇 ИЗМЕНЯЕМ ТИПЫ НА ПРОСТЫЕ СТРОКИ 👇 ---
  final String title;
  final String description;
  final String personalAdvice;
  // ---
  final String transitingPlanet;
  final String aspect;
  final String natalPlanet;
  final String planetSign;

  const CosmicEvent({
    required this.id,
    required this.eventType,
    required this.eventDate,
    required this.title,
    required this.description,
    required this.personalAdvice,
    required this.transitingPlanet,
    required this.aspect,
    required this.natalPlanet,
    required this.planetSign,
  });

  factory CosmicEvent.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CosmicEvent(
      id: doc.id,
      eventType: data['eventType'] ?? '',
      // Для Timestamp из Firestore
      eventDate: (data['eventDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
      // Теперь просто берем строки
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      personalAdvice: data['personalAdvice'] ?? '',
      transitingPlanet: data['transitingPlanet'] ?? '',
      aspect: data['aspect'] ?? '',
      natalPlanet: data['natalPlanet'] ?? '',
      planetSign: data['planetSign'] ?? '',
    );
  }

  // --- Фабрика для глобальных событий из Firestore (твоя логика сохранена) ---
  factory CosmicEvent.fromJson(Map<String, dynamic> json) {
    return CosmicEvent(
      id: json['id'] ?? '',
      eventType: json['eventType'] ?? '',
      eventDate: json['eventDate'] != null ? DateTime.parse(json['eventDate']) : DateTime.now(),
      title: json['title'] ?? '', // Просто берем строку
      description: json['description'] ?? '', // Просто берем строку
      personalAdvice: json['personalAdvice'] ?? '', // Просто берем строку
      transitingPlanet: json['transitingPlanet'] ?? '',
      aspect: json['aspect'] ?? '',
      natalPlanet: json['natalPlanet'] ?? '',
      planetSign: json['planetSign'] ?? '',
    );
  }





  @override
  List<Object?> get props => [id, eventDate];
}