// lib/services/logger_service.dart
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';


// Создаем глобальный экземпляр логгера
final logger = Logger(
  // Устанавливаем фильтр. Он будет решать, какие логи показывать.
  filter: DevelopmentFilter(),

  // Устанавливаем принтер, который форматирует вывод.
  // kDebugMode - это глобальная константа Flutter, которая равна true только в debug-сборке.
  printer: kDebugMode ? PrettyPrinter(
    methodCount: 1, // Сколько методов из стека вызовов показывать
    errorMethodCount: 8, // Сколько показывать для ошибок
    lineLength: 120, // Ширина строки
    colors: true, // Цветной вывод в консоли
    printEmojis: true, // Эмодзи для уровней логов
    printTime: false, // Время можно включить, если нужно
  ) : SimplePrinter(), // В релизе будет простой вывод, если логи вообще пройдут фильтр

  // Устанавливаем, куда выводить. LogOutput по умолчанию - это консоль.
  output: null,
);

// Можно создать кастомные уровни, но стандартных обычно хватает.
// Level.verbose, Level.debug, Level.info, Level.warning, Level.error, Level.wtf