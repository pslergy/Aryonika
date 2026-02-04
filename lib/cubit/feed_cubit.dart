// lib/cubit/feed_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lovequest/repositories/api_repository.dart'; // <-- ИЗМЕНЕНИЕ: используем ApiRepository
import 'package:lovequest/src/data/models/feed_event.dart';

// --- Состояния ---
// Базовое состояние теперь хранит список событий
abstract class FeedState extends Equatable {
  final List<FeedEvent> events;
  const FeedState(this.events);

  @override
  List<Object> get props => [events];
}

// Начальное состояние с пустым списком
class FeedInitial extends FeedState {
  FeedInitial() : super([]);
}

// Состояние загрузки хранит СТАРЫЙ список, пока грузится новый
class FeedLoading extends FeedState {
  FeedLoading(super.events);
}

// Состояние успеха с новым, загруженным списком
class FeedLoaded extends FeedState {
  FeedLoaded(super.events);
}

// Состояние ошибки хранит СТАРЫЙ список и сообщение об ошибке
class FeedError extends FeedState {
  final String message;
  // Передаем старый список в super, чтобы UI не "моргал"
  const FeedError(this.message, List<FeedEvent> previousEvents) : super(previousEvents);

  @override
  List<Object> get props => [message, events];
}


// --- Cubit ---
class FeedCubit extends Cubit<FeedState> {
  final ApiRepository _apiRepository; // <-- ИЗМЕНЕНИЕ: используем ApiRepository
  final String _userId;
  bool _isLoading = false;

  FeedCubit({
    required ApiRepository apiRepository, // <-- ИЗМЕНЕНИЕ
    required String userId,
  }) : _apiRepository = apiRepository,
        _userId = userId,
        super(FeedInitial());

  Future<void> loadFeed({bool isRefresh = false}) async {
    // Используем локальный флаг вместо проверки state
    if (_isLoading) return;

    _isLoading = true;

    // Если это обновление, эмитим состояние загрузки.
    // ВАЖНО: Проверяем isClosed перед первым emit тоже, на всякий случай,
    // хотя синхронно это редко бывает проблемой.
    if (isRefresh && !isClosed) {
      emit(FeedLoading(state.events));
    }

    try {
      final events = await _apiRepository.getPulseFeed();

      // ✅ ПРОВЕРКА ЕСТЬ (хорошо)
      if (isClosed) return;
      emit(FeedLoaded(events));

    } catch (e) {
      // ❌ ЗДЕСЬ НЕ БЫЛО ПРОВЕРКИ. ДОБАВЛЯЕМ ЕЕ СЕЙЧАС.
      if (isClosed) return;

      emit(FeedError(e.toString(), state.events));
    } finally {
      _isLoading = false;
    }
  }}