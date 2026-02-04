import 'package:flutter_bloc/flutter_bloc.dart';

import '../repositories/api_repository.dart';


class CompatibilityState {
  final bool isLoading;
  final Map<String, dynamic>? report;
  final String? error;

  CompatibilityState({this.isLoading = false, this.report, this.error});
}

class CompatibilityCubit extends Cubit<CompatibilityState> {
  final ApiRepository _api;

  CompatibilityCubit(this._api) : super(CompatibilityState());

  // 1. По ID партнера (для списка лайков)
  Future<void> loadById(String partnerId) async {
    emit(CompatibilityState(isLoading: true));
    try {
      final report = await _api.getSuperCompatibility(partnerId);
      emit(CompatibilityState(isLoading: false, report: report));
    } catch (e) {
      emit(CompatibilityState(isLoading: false, error: "Ошибка загрузки: $e"));
    }
  }

  // 2. По ручному вводу (НОВАЯ ФУНКЦИЯ)
  Future<void> calculateManual({required String name, required DateTime date}) async {
    emit(CompatibilityState(isLoading: true));
    try {
      final report = await _api.calculateManualCompatibility(
        name: name,
        date: date,
      );
      emit(CompatibilityState(isLoading: false, report: report));
    } catch (e) {
      emit(CompatibilityState(isLoading: false, error: "Ошибка расчета: $e"));
    }
  }
}