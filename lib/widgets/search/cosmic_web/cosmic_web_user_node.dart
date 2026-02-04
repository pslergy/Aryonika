// lib/widgets/search/cosmic_web/cosmic_web_user_node.dart
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:lovequest/services/logger_service.dart';

class CosmicWebUser {
  final String id;
  final String name;
  final String? avatarUrl;
  final int compatibilityScore;
  final DateTime? lastOnline;

  CosmicWebUser({
    required this.id,
    required this.name,
    this.avatarUrl,
    required this.compatibilityScore,
    this.lastOnline,
  });

  factory CosmicWebUser.fromJson(Map<String, dynamic> json) {
    try {
      DateTime? lastOnlineDate;
      if (json['lastOnline'] != null) {
        lastOnlineDate = DateTime.tryParse(json['lastOnline'] as String);
      }

      return CosmicWebUser(
        id: json['id'] as String? ?? 'unknown_id_${DateTime.now().millisecondsSinceEpoch}',
        // --- БЫЛО ---
        // name: json['name'] as String? ?? 'Незнакомец',
        // --- СТАЛО ---
        name: json['name'] as String? ?? 'Stranger',
        avatarUrl: json['avatarUrl'] as String?,
        compatibilityScore: json['compatibilityScore'] as int? ?? 50,
        lastOnline: lastOnlineDate,
      );
    } catch (e) {
      logger.d("❌ Error parsing CosmicWebUser.json: $e");
      logger.d("   Problematic JSON: $json");
      return CosmicWebUser(
        id: 'error_id',
        // --- БЫЛО ---
        // name: 'Ошибка данных',
        // --- СТАЛО ---
        name: 'Data Error',
        compatibilityScore: 0,
      );
    }
  }
}

// Модель для отрисовки на холсте (остается без изменений)
class CosmicWebUserNode {
  final CosmicWebUser user;
  final Offset position;
  final double radius;
  final ImageProvider? avatarProvider;

  CosmicWebUserNode({
    required this.user,
    required this.position,
    required this.radius,
    this.avatarProvider,
  });
  Rect get rect => Rect.fromCircle(center: position, radius: radius);
}