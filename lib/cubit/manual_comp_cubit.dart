// lib/cubit/manual_comp_cubit.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovequest/cubit/app_cubit.dart';
import 'package:lovequest/cubit/manual_comp_state.dart';
import 'package:lovequest/repositories/onboarding_repository.dart';
import 'package:lovequest/services/compatibility_calculator.dart';
import 'package:lovequest/services/natal_chart_calculator.dart';
import 'package:lovequest/services/numerology_calculator.dart';
import 'package:lovequest/src/data/models/nominatim_suggestion.dart';

import '../src/data/models/numerology_report.dart';

class ManualCompCubit extends Cubit<ManualCompState> {
  final AppCubit _appCubit;
  final OnboardingRepository _onboardingRepository = OnboardingRepository();
  final NatalChartCalculator _chartCalculator = NatalChartCalculator();
  Timer? _searchDebounce;

  ManualCompCubit(this._appCubit) : super(const ManualCompState()) {
    _chartCalculator.initialize();
  }

  void onNameChanged(String name) => emit(state.copyWith(partnerName: name, status: ManualCompStatus.initial, errorMessage: null));
  void onBirthDateChanged(DateTime date) => emit(state.copyWith(partnerBirthDate: date, status: ManualCompStatus.initial, errorMessage: null));
  void onBirthTimeChanged(TimeOfDay time) => emit(state.copyWith(partnerBirthTime: time, status: ManualCompStatus.initial, errorMessage: null));
  void onLocationSelected(NominatimSuggestion location) => emit(state.copyWith(partnerLocation: location, locationSuggestions: [], status: ManualCompStatus.initial, errorMessage: null));

  void searchLocations(String query) {
    _searchDebounce?.cancel();
    if (query.length < 2) {
      emit(state.copyWith(locationSuggestions: []));
      return;
    }
    emit(state.copyWith(status: ManualCompStatus.loadingLocations));
    _searchDebounce = Timer(const Duration(milliseconds: 500), () async {
      try {
        final suggestions = await _onboardingRepository.searchLocations(query);
        emit(state.copyWith(locationSuggestions: suggestions, status: ManualCompStatus.initial));
      } catch (e) {
        emit(state.copyWith(status: ManualCompStatus.error, errorMessage: "Ошибка поиска города"));
      }
    });
  }

  // --- 👇 НОВАЯ ВСПОМОГАТЕЛЬНАЯ ФУНКЦИЯ 👇 ---
  // Преобразует сложный Map<String, dynamic> в простой Map<String, int>
  Map<String, int> _flattenNumerology(Map<String, dynamic>? complexMap) {
    if (complexMap == null) return {};
    final result = <String, int>{};
    complexMap.forEach((key, value) {
      if (value is Map && value.containsKey('number')) {
        // Новый формат: {'lifePath': {'number': 5, ...}} -> {'lifePath': 5}
        result[key] = value['number'] as int;
      } else if (value is int) {
        // Старый формат (на всякий случай)
        result[key] = value;
      }
    });
    return result;
  }
  // --- 👆 КОНЕЦ ФУНКЦИИ 👆 ---

  Future<void> calculateCompatibility() async {
    print("🔵 [ManualCompCubit] Нажата кнопка расчета.");

    if (!state.isFormValid) {
      emit(state.copyWith(status: ManualCompStatus.error, errorMessage: 'Пожалуйста, заполните все поля'));
      return;
    }

    emit(state.copyWith(status: ManualCompStatus.calculating, report: null, errorMessage: null));

    final myChart = _appCubit.state.currentUserProfile?.natalChart;
    if (myChart == null) {
      emit(state.copyWith(status: ManualCompStatus.error, errorMessage: 'Ваша натальная карта не загружена.'));
      return;
    }

    if (_appCubit.state.aspectInterpretations.isEmpty) {
      await _appCubit.loadAspectInterpretations();
    }
    if (_appCubit.state.numerologyCompatibility.isEmpty) {
      await _appCubit.loadNumerologyCompatibility();
    }

    try {
      final date = state.partnerBirthDate!;
      final time = state.partnerBirthTime;
      final birthDateTime = DateTime(date.year, date.month, date.day, time.hour, time.minute);
      final location = state.partnerLocation!;

      final partnerChart = await _chartCalculator.calculateAll(
        birthDateTime.millisecondsSinceEpoch,
        double.parse(location.latitude),
        double.parse(location.longitude),
      );

      if (partnerChart == null) throw Exception('Не удалось рассчитать карту партнера.');

      // 1. Получаем личный нумерологический отчет текущего пользователя
      final PersonalNumerologyReport? myNumerology = _appCubit.state.currentUserProfile?.numerologyData;

      // 2. Рассчитываем личный нумерологический отчет для партнера
      final PersonalNumerologyReport partnerNumerology = NumerologyCalculator.generateFullReport(
        birthDateTime: birthDateTime,
        fullName: state.partnerName!,
      );

      final report = CompatibilityCalculator.calculate(
        chart1: myChart,
        chart2: partnerChart,
        // --- 👇 ИСПОЛЬЗУЕМ _flattenNumerology ЗДЕСЬ 👇 ---
        numerology1: _flattenNumerology(myNumerology?.toFirestore()),
        numerology2: _flattenNumerology(partnerNumerology.toFirestore()),
        // --- 👆 ---
        partnerName: state.partnerName!,
        interpretations: _appCubit.state.aspectInterpretations,
        numerologyDescriptions: _appCubit.state.numerologyCompatibility,
      );

      emit(state.copyWith(status: ManualCompStatus.success, report: report));
    } catch (e) {
      print("🔴 [ManualCompCubit] Ошибка при расчете: $e");
      emit(state.copyWith(status: ManualCompStatus.error, errorMessage: e.toString()));
    }
  }

  void reset() {
    emit(const ManualCompState());
  }

  @override
  Future<void> close() {
    _searchDebounce?.cancel();
    return super.close();
  }
}