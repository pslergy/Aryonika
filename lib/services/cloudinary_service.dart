// lib/services/cloudinary_service.dart
import 'dart:convert';      // Для base64Decode
import 'dart:io';
import 'dart:typed_data';   // Для Uint8List
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lovequest/services/logger_service.dart';
import 'package:path_provider/path_provider.dart';

class CloudinaryService {
  static final _cloudinary = CloudinaryPublic(
      'dxcqjsh8r',    // <-- Ваш "Cloud Name" (остается без изменений)
      'Aryonika',       // <-- ИЗМЕНЕНИЕ: Указываем имя вашего пресета
      cache: false
  );
  Future<String?> uploadBase64Image({required String base64String}) async {
    File? tempFile; // Объявляем переменную для временного файла
    try {
      // 1. Декодируем base64 в байты
      final Uint8List imageBytes = base64Decode(base64String);

      // 2. Создаем временный файл
      final tempDir = await getTemporaryDirectory();
      tempFile = File('${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg');
      await tempFile.writeAsBytes(imageBytes);

      // 3. Загружаем временный файл, как обычное изображение
      CloudinaryResponse response = await _cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          tempFile.path, // Используем путь к нашему временному файлу
          resourceType: CloudinaryResourceType.Image,
        ),
      );

      return response.secureUrl;
    } catch (e) {
      logger.d('Ошибка загрузки base64 в Cloudinary: $e');
      return null;
    } finally {
      // 4. Обязательно удаляем временный файл после загрузки
      if (tempFile != null && await tempFile.exists()) {
        await tempFile.delete();
        logger.d("Временный файл удален.");
      }
    }
  }


  Future<String?> uploadImage({required XFile imageFile}) async {
    logger.d("--- CloudinaryService: Начало загрузки файла ${imageFile.name}...");
    try {
      CloudinaryResponse response = await _cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          imageFile.path,
          resourceType: CloudinaryResourceType.Image,
        ),
      );

      // === ИСПРАВЛЕНИЕ ЗДЕСЬ ===
      // Проверяем, что secureUrl не null и не пустой
      if (response.secureUrl != null && response.secureUrl!.isNotEmpty) {
        logger.d("--- CloudinaryService: Успех! URL: ${response.secureUrl} ---");
        return response.secureUrl;
      } else {
        // Пакет не предоставляет детальной информации об ошибке в этом объекте,
        // поэтому выводим общее сообщение. Ошибка будет поймана в catch.
        logger.d("!!! CloudinaryService ERROR: Ответ от сервера пуст или не содержит URL.");
        return null;
      }
      // ==========================

    } on CloudinaryException catch (e) {
      logger.d("!!! CloudinaryService ERROR (CloudinaryException): ${e.message}");
      logger.d(e.request);
      return null;
    } catch (e) {
      logger.d("!!! CloudinaryService ERROR (General Exception): $e");
      return null;
    }
  }}



