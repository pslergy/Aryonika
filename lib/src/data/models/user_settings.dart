// lib/src/data/models/user_settings.dart

import 'package:equatable/equatable.dart';

class UserSettings extends Equatable {
  final NotificationSettings notifications;

  const UserSettings({
    this.notifications = const NotificationSettings(),
  });

  factory UserSettings.fromMap(Map<String, dynamic>? map) {
    if (map == null) return const UserSettings();
    return UserSettings(
      notifications: NotificationSettings.fromMap(map['notifications'] as Map<String, dynamic>?),
    );
  }

  Map<String, dynamic> toMap() => {'notifications': notifications.toMap()};

  UserSettings copyWith({NotificationSettings? notifications}) {
    return UserSettings(notifications: notifications ?? this.notifications);
  }

  @override
  List<Object?> get props => [notifications];
}

class NotificationSettings extends Equatable {
  final bool horoscope;
  final bool focusOfTheDay;
  final bool hybridForecast;
  final bool geomagneticAlerts;
  final bool cardOfTheDay;
  final bool partnerOfTheDay;

  const NotificationSettings({
    this.horoscope = true,
    this.focusOfTheDay = true,
    this.hybridForecast = true,
    this.geomagneticAlerts = true,
    this.cardOfTheDay = true,
    this.partnerOfTheDay = true,
  });

  factory NotificationSettings.fromMap(Map<String, dynamic>? map) {
    if (map == null) return const NotificationSettings();
    return NotificationSettings(
      horoscope: map['horoscope'] ?? true,
      focusOfTheDay: map['focusOfTheDay'] ?? true,
      hybridForecast: map['hybridForecast'] ?? true,
      geomagneticAlerts: map['geomagneticAlerts'] ?? true,
      cardOfTheDay: map['cardOfTheDay'] ?? true,
      partnerOfTheDay: map['partnerOfTheDay'] ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'horoscope': horoscope,
      'focusOfTheDay': focusOfTheDay,
      'hybridForecast': hybridForecast,
      'geomagneticAlerts': geomagneticAlerts,
      'cardOfTheDay': cardOfTheDay,
      'partnerOfTheDay': partnerOfTheDay,
    };
  }

  NotificationSettings copyWith({
    bool? horoscope, bool? focusOfTheDay, bool? hybridForecast,
    bool? geomagneticAlerts, bool? cardOfTheDay, bool? partnerOfTheDay,
  }) {
    return NotificationSettings(
      horoscope: horoscope ?? this.horoscope,
      focusOfTheDay: focusOfTheDay ?? this.focusOfTheDay,
      hybridForecast: hybridForecast ?? this.hybridForecast,
      geomagneticAlerts: geomagneticAlerts ?? this.geomagneticAlerts,
      cardOfTheDay: cardOfTheDay ?? this.cardOfTheDay,
      partnerOfTheDay: partnerOfTheDay ?? this.partnerOfTheDay,
    );
  }

  @override
  List<Object?> get props => [
    horoscope, focusOfTheDay, hybridForecast, geomagneticAlerts, cardOfTheDay, partnerOfTheDay
  ];
}