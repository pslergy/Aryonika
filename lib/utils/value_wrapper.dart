// lib/utils/value_wrapper.dart

/// Вспомогательный класс-обертка, чтобы передавать null в copyWith.
class ValueWrapper<T> {
  final T value;
  const ValueWrapper(this.value);
}