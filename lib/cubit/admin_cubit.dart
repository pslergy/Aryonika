// lib/cubits/admin_cubit.dart

import 'package:bloc/bloc.dart';

import 'package:lovequest/repositories/api_repository.dart';


import '../repositories/package/lovequest/src/data/models/enums.dart';
import 'admin_state.dart'; // Для LoadingState

class AdminCubit extends Cubit<AdminState> {
  final ApiRepository _apiRepository;

  AdminCubit(this._apiRepository) : super(const AdminState()); // Убираем const

  Future<void> loadDashboard() async {
    emit(state.copyWith(status: LoadingState.loading));
    try {
      // FIXME: Реализовать getAdminDashboard() в ApiRepository
      // final stats = await _apiRepository.getAdminDashboard();
      final stats = AdminDashboardStats(); // Временная заглушка
      emit(state.copyWith(status: LoadingState.success, stats: stats));
    } catch (e) {
      emit(state.copyWith(status: LoadingState.error, errorMessage: e.toString()));
    }
  }

  Future<void> fetchReports() async {
    // ...
  }
}