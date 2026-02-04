// lib/src/data/models/moon_rhythm.dart

import 'package:equatable/equatable.dart';

class MoonRhythmResponse extends Equatable {
  final MoonRhythmInfo sign;
  final MoonRhythmInfo phase;

  const MoonRhythmResponse({required this.sign, required this.phase});

  @override
  List<Object?> get props => [sign, phase];

  factory MoonRhythmResponse.fromJson(Map<String, dynamic> json) {
    return MoonRhythmResponse(
      sign: MoonRhythmInfo.fromJson(json['sign'] as Map<String, dynamic>? ?? {}),
      phase: MoonRhythmInfo.fromJson(json['phase'] as Map<String, dynamic>? ?? {}),
    );
  }
}

class MoonRhythmInfo extends Equatable {
  final String key;
  final String title;
  final String description;

  const MoonRhythmInfo({
    required this.key,
    required this.title,
    required this.description,
  });

  @override
  List<Object?> get props => [key, title, description];

  factory MoonRhythmInfo.fromJson(Map<String, dynamic> json) {
    return MoonRhythmInfo(
      key: json['key'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
    );
  }
}