// lib/widgets/common/smart_image.dart

import 'dart:convert';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lovequest/services/logger_service.dart';

// Top-level функция для декодирования (может быть в другом файле, если вы ее вынесли)
Uint8List _decodeAndCleanBase64(String base64String) {
  String cleaned = base64String;
  if (cleaned.startsWith('data:image')) {
    cleaned = cleaned.split(',').last;
  }
  cleaned = cleaned.replaceAll(RegExp(r'\s+'), '');
  return base64Decode(cleaned);
}

class SmartImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Widget placeholder;

  const SmartImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    required this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    // 1. Если это URL
    if (imageUrl.startsWith('http')) {
      return CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit,
        // --- УЛУЧШЕНИЕ 1: Показываем индикатор загрузки ---
        // Это выглядит лучше, чем показывать одну картинку, а потом резко менять ее на другую.
        placeholder: (context, url) => const Center(child: CircularProgressIndicator(strokeWidth: 2.0)),
        // Если произошла ошибка сети, показываем твою заглушку (placeholder_male/female.png)
        errorWidget: (context, url, error) => placeholder,
      );
    }

    // 2. Если это Base64
    // --- УЛУЧШЕНИЕ 2: Более надежная проверка ---
    else if (imageUrl.startsWith('data:image')) {
      try {
        final pureBase64 = imageUrl.split(',').last;
        return Image.memory(
            base64Decode(pureBase64),
            width: width,
            height: height,
            fit: fit,
            gaplessPlayback: true // Предотвращает "моргание" при смене изображения
        );
      } catch (e) {
        logger.d("!!! SmartImage ОШИБКА: Не удалось декодировать Base64. Ошибка: $e");
        return placeholder;
      }
    }

    // 3. Если это ассет знака зодиака (эта логика у тебя хорошая)
    else if (imageUrl.startsWith('ic_zodiac_')) {
      try {
        final imagePath = 'assets/images/zodiac/$imageUrl.png';
        return Image.asset(imagePath, width: width, height: height, fit: fit);
      } catch (e) {
        logger.d("!!! SmartImage ОШИБКА: Не удалось загрузить ассет $imageUrl. Ошибка: $e");
        return placeholder;
      }
    }

    // 4. Во всех остальных случаях (пустая строка или неизвестный формат)
    else {
      return placeholder;
    }
  }
}