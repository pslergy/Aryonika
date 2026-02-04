// lib/cubit/manual_comp_state.dart
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lovequest/src/data/models/astrology/compatibility_report.dart';
import 'package:lovequest/src/data/models/nominatim_suggestion.dart'; // <-- ИЗМЕНЕН ИМПОРТ

enum ManualCompStatus { initial, loadingLocations, calculating, success, error }

class ManualCompState extends Equatable {
  final ManualCompStatus status;
  final String partnerName;
  final DateTime? partnerBirthDate;
  final TimeOfDay partnerBirthTime;
  final NominatimSuggestion? partnerLocation;
  final List<NominatimSuggestion> locationSuggestions;
  final CompatibilityReport? report;
  final String? errorMessage;

  const ManualCompState({
    this.status = ManualCompStatus.initial,
    this.partnerName = '',
    this.partnerBirthDate,
    this.partnerBirthTime = const TimeOfDay(hour: 12, minute: 0),
    this.partnerLocation,
    this.locationSuggestions = const [],
    this.report,
    this.errorMessage,
  });

  // Геттер для проверки, можно ли нажимать кнопку "Рассчитать"
  bool get isFormValid =>
      partnerName.trim().isNotEmpty &&
          partnerBirthDate != null &&
          partnerLocation != null;

  ManualCompState copyWith({
    ManualCompStatus? status,
    String? partnerName,
    DateTime? partnerBirthDate,
    TimeOfDay? partnerBirthTime,
    NominatimSuggestion? partnerLocation,
    List<NominatimSuggestion>? locationSuggestions,
    CompatibilityReport? report,
    String? errorMessage,
    bool clearLocation = false,
    bool clearReport = false,
  }) {
    return ManualCompState(
      status: status ?? this.status,
      partnerName: partnerName ?? this.partnerName,
      partnerBirthDate: partnerBirthDate ?? this.partnerBirthDate,
      partnerBirthTime: partnerBirthTime ?? this.partnerBirthTime,
      partnerLocation: clearLocation ? null : partnerLocation ?? this.partnerLocation,
      locationSuggestions: locationSuggestions ?? this.locationSuggestions,
      report: clearReport ? null : report ?? this.report,
      errorMessage: errorMessage, // errorMessage всегда перезаписывается
    );
  }

  @override
  List<Object?> get props => [status, partnerName, partnerBirthDate, partnerBirthTime, partnerLocation, locationSuggestions, report, errorMessage];
}