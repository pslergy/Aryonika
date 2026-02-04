// lib/cubit/onboarding_cubit.dart
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lovequest/cubit/app_cubit.dart';
import 'package:lovequest/cubit/onboarding_state.dart';
import 'package:lovequest/repositories/onboarding_repository.dart';
import 'package:lovequest/src/data/models/nominatim_suggestion.dart';

import '../services/logger_service.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final AppCubit appCubit;
  final OnboardingRepository _onboardingRepository = OnboardingRepository();
  Timer? _searchDebounce; // <<<--- ПЕРЕНЕСЛИ СЮДА

  OnboardingCubit({required this.appCubit}) : super(const OnboardingState());

  // --- Методы для обновления полей из UI ---



  void clearLocation() {
    // Используем `copyWith` для сброса полей, связанных с локацией,
    // в их изначальное состояние.
    emit(state.copyWith(
      location: null,
      isLocationSelectedFromList: false,
      locationSuggestions: [],
    ));
  }


  void onNameChanged(String name) {
    emit(state.copyWith(name: name));
  }

  void onBioChanged(String bio) {
    emit(state.copyWith(bio: bio));
  }

  void onBirthDateSelected(int millis) {
    emit(state.copyWith(birthdateMillis: millis));
  }

  void onGenderSelected(String gender) {
    emit(state.copyWith(gender: gender));
  }

  void onTimeSelected(int hour, int minute) {
    emit(state.copyWith(hour: hour, minute: minute));
  }

  void onManualLocationSelected(NominatimSuggestion suggestion) {
    emit(state.copyWith(
      location: suggestion,
      locationSuggestions: [], // Очищаем подсказки
      isLocationSelectedFromList: true, // <-- ГЛАВНОЕ: УСТАНАВЛИВАЕМ ФЛАГ
    ));
  }


  void searchLocations(String query) {
    _searchDebounce?.cancel();

    logger.d("--- CUBIT: Получен запрос на поиск: '$query' ---");

    if (query.length < 3) {
      // Здесь тоже создаем новый список, на всякий случай
      emit(state.copyWith(locationSuggestions: const []));
      return;
    }

    _searchDebounce = Timer(const Duration(milliseconds: 500), () async {
      logger.d("--- CUBIT: Таймер сработал! Иду в репозиторий... ---");
      emit(state.copyWith(isLoadingLocations: true));
      final suggestions = await _onboardingRepository.searchLocations(query);
      logger.d("--- CUBIT: Репозиторий вернул ${suggestions.length} подсказок. ---");

      // === ГЛАВНОЕ ИСПРАВЛЕНИЕ ЗДЕСЬ ===
      // Создаем НОВЫЙ список из полученных данных.
      // Это гарантирует, что Equatable увидит изменения.
      emit(state.copyWith(
        isLoadingLocations: false,
        locationSuggestions: List.from(suggestions),
      ));
      // ===============================
    });
  }

  // --- Главный метод для сохранения ---

  void finalizeOnboarding() {
    if (state.name.isEmpty || state.birthdateMillis == null || state.gender == null || state.location == null) {
      emit(state.copyWith(status: OnboardingStatus.error, errorMessage: "Не все данные заполнены."));
      return;
    }

    emit(state.copyWith(status: OnboardingStatus.saving));

    // Вызываем метод в AppCubit, передавая ему все собранные данные
    appCubit.finalizeOnboardingAndSaveProfile(
      name: state.name.trim(),
      bio: state.bio.trim(),
      gender: state.gender!,
      birthDateMillis: state.birthdateMillis!,
      hour: state.hour,
      minute: state.minute,
      location: state.location!,
    );

    // OnboardingCubit больше не делает emit(success), т.к. он не знает, когда все закончится.
    // AppCubit сам обновит глобальное состояние, и redirect сработает.
  }

  @override
  Future<void> close() {
    _searchDebounce?.cancel();
    return super.close();
  }
}