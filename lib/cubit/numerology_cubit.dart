import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovequest/cubit/app_cubit.dart';
import 'package:lovequest/cubit/numerology_state.dart';
import 'package:lovequest/repositories/api_repository.dart';
import 'package:lovequest/services/numerology_calculator.dart';
import 'package:lovequest/src/data/models/numerology_report.dart';
import '../services/logger_service.dart';

class NumerologyCubit extends Cubit<NumerologyState> {
  final AppCubit _appCubit;
  final ApiRepository _apiRepository;

  NumerologyCubit({
    required AppCubit appCubit,
    required ApiRepository apiRepository
  }) : _appCubit = appCubit,
        _apiRepository = apiRepository,
        super(const NumerologyState());

  // ==================================================
  // ЛИЧНЫЙ ОТЧЕТ
  // ==================================================
  Future<void> loadPersonalReport(String userId) async {
    emit(state.copyWith(status: NumerologyStatus.loading));

    try {
      // 1. Получаем текущий профиль из памяти
      var userProfile = _appCubit.state.currentUserProfile;

      // Очищаем переданный ID от пробелов
      final targetId = userId.trim();

      logger.d("NumerologyCubit: Запрос для ID: '$targetId'. Текущий юзер: '${userProfile?.id}'");

      // ЛОГИКА ВЫБОРА ПРОФИЛЯ:
      // Если ID пустой ИЛИ ID совпадает с текущим -> берем текущего пользователя
      if (targetId.isEmpty || (userProfile != null && userProfile.id == targetId)) {
        logger.d("NumerologyCubit: Использую профиль текущего пользователя из AppCubit.");
        // userProfile уже установлен выше
      }
      // Иначе ищем в кэше просмотренных
      else {
        final cachedProfile = _appCubit.state.viewedProfilesCache[targetId];
        if (cachedProfile != null) {
          logger.d("NumerologyCubit: Нашел профиль в кэше просмотренных.");
          userProfile = cachedProfile;
        } else {
          // Если нигде нет - грузим с сервера
          logger.d("NumerologyCubit: Профиль не найден локально. Гружу с сервера ID: $targetId");
          if (targetId.isNotEmpty) {
            userProfile = await _apiRepository.getUserProfile(targetId);
          }
        }
      }

      if (userProfile == null) {
        throw Exception("Не удалось найти профиль для расчета (ID: '$targetId').");
      }

      // 2. ГАРАНТИРОВАННЫЙ ЛОКАЛЬНЫЙ РАСЧЕТ
      // У нас есть профиль, значит есть дата рождения. Считаем числа прямо здесь.
      logger.d("NumerologyCubit: Рассчитываю числа для ${userProfile.name}...");

      final birthDate = DateTime.fromMillisecondsSinceEpoch(userProfile.birthDateMillis);

      final report = NumerologyCalculator.generateFullReport(
        birthDateTime: birthDate,
        fullName: userProfile.name,
      );

      logger.d("NumerologyCubit: Расчет готов. LifePath: ${report.lifePath.number}");

      // 3. Обновляем стейт
      emit(state.copyWith(
        status: NumerologyStatus.success,
        personalReport: report,
      ));

    } catch (e, s) {
      logger.d("NumerologyCubit ОШИБКА: $e");
      logger.d(s);
      emit(state.copyWith(status: NumerologyStatus.error, errorMessage: "Ошибка: $e"));
    }
  }

  // СОВМЕСТИМОСТЬ
  Future<void> loadCompatibilityReport(String partnerId) async {
    emit(state.copyWith(status: NumerologyStatus.loading));

    try {
      final lang = _appCubit.state.locale?.languageCode ?? 'ru';
      // Если partnerId пустой, вылетит ошибка, поэтому проверим
      if (partnerId.trim().isEmpty) throw Exception("ID партнера пустой");

      final report = await _apiRepository.getNumerologyReport(partnerId, lang);

      emit(state.copyWith(
        status: NumerologyStatus.success,
        compatibilityReport: report,
      ));
    } catch (e) {
      logger.d("NumerologyCubit Compatibility Error: $e");
      emit(state.copyWith(status: NumerologyStatus.error, errorMessage: e.toString()));
    }
  }
}