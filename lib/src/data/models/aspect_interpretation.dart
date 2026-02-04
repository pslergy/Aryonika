// lib/src/data/models/aspect_interpretation.dart (НОВАЯ, ПРАВИЛЬНАЯ ВЕРСИЯ)



import 'package:equatable/equatable.dart';
import 'package:lovequest/services/logger_service.dart';

class AspectInterpretation extends Equatable {
  final String id;
  // Теперь у нас только ОДИН title и ОДИН description. Они уже переведены.
  final String title;
  final String description;

  const AspectInterpretation({
    required this.id,
    required this.title,
    required this.description,
  });

  @override
  List<Object?> get props => [id, title, description];

  // --- 👇 ГЛАВНОЕ ИЗМЕНЕНИЕ ЗДЕСЬ 👇 ---
  factory AspectInterpretation.fromMap(String id, Map<String, dynamic> map) {
    logger.d('--- 🔬 PARSING AspectInterpretation (ID: $id) ---');

    // Мы ожидаем, что сервер пришлет нам уже переведенные поля 'title' и 'description'
    final title = map['title']?.toString() ?? '';
    final description = map['description']?.toString() ?? '';

    // Этот лог теперь будет очень полезен
    if (title.isEmpty) logger.d("   -> WARNING: Поле 'title' в JSON ответа пустое или отсутствует.");
    if (description.isEmpty) logger.d("   -> WARNING: Поле 'description' в JSON ответа пустое или отсутствует.");

    return AspectInterpretation(
      id: id,
      title: title,
      description: description,
    );
  }

  // --- 👇 УПРОЩАЕМ ХЕЛПЕРЫ 👇 ---
  // langCode больше не нужен, но мы оставляем его для совместимости с кодом, который его вызывает.
  String getLocalizedTitle(String langCode) {
    return title;
  }

  String getLocalizedGeneralDescription(String langCode) {
    return description;
  }
}