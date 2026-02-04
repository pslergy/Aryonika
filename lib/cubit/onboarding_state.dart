// lib/cubit/onboarding_state.dart
import 'package:equatable/equatable.dart';
import 'package:lovequest/src/data/models/nominatim_suggestion.dart';

// Статусы для отслеживания процесса сохранения
enum OnboardingStatus { initial, saving, success, error }

class OnboardingState extends Equatable {
  final String name;
  final String bio;
  final int? birthdateMillis;
  final String? gender;
  final int hour;
  final int minute;
  final NominatimSuggestion? location;
  final OnboardingStatus status;
  final String? errorMessage;
  final List<NominatimSuggestion> locationSuggestions;
  final bool isLoadingLocations;
  final bool isLocationSelectedFromList;

  const OnboardingState({
    this.name = '',
    this.bio = '',
    this.birthdateMillis,
    this.gender,
    this.hour = 12,
    this.minute = 0,
    this.location,
    this.status = OnboardingStatus.initial,
    this.errorMessage,
    this.locationSuggestions = const [],
    this.isLoadingLocations = false,
    this.isLocationSelectedFromList = false, // По умолчанию - не выбран
  });

  OnboardingState copyWith({
    String? name,
    String? bio,
    int? birthdateMillis,
    String? gender,
    int? hour,
    int? minute,
    NominatimSuggestion? location,
    OnboardingStatus? status,
    String? errorMessage,
    List<NominatimSuggestion>? locationSuggestions,
    bool? isLoadingLocations,
    bool? isLocationSelectedFromList,
  }) {
    return OnboardingState(
      name: name ?? this.name,
      bio: bio ?? this.bio,
      birthdateMillis: birthdateMillis ?? this.birthdateMillis,
      gender: gender ?? this.gender,
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
      location: location ?? this.location,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      locationSuggestions: locationSuggestions ?? this.locationSuggestions,
      isLoadingLocations: isLoadingLocations ?? this.isLoadingLocations,
      isLocationSelectedFromList: isLocationSelectedFromList ?? this.isLocationSelectedFromList,
    );
  }

  @override
  List<Object?> get props => [
    name,
    bio,
    birthdateMillis,
    gender,
    hour,
    minute,
    location,
    status,
    errorMessage,
    locationSuggestions,
    isLoadingLocations,
    isLocationSelectedFromList,
  ];
}