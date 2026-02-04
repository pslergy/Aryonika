// lib/widgets/common/smart_avatar.dart

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lovequest/services/logger_service.dart';



class SmartAvatar extends StatelessWidget {
  final String? avatarUrl;
  final String? avatarBase64;
  final String? gender;
  final double radius;

  const SmartAvatar({
    super.key,
    this.avatarUrl,
    this.avatarBase64,
    this.gender,
    this.radius = 20.0, // Установим более адекватный радиус по умолчанию для аватаров
  });

  String _getPlaceholderAsset() {
    if (gender == 'female') {
      return 'assets/images/placeholder_female.png';
    }
    return 'assets/images/placeholder_male.png';
  }

  @override
  Widget build(BuildContext context) {
    ImageProvider? finalBackgroundImage;

    // 1. Приоритет у Base64
    if (avatarBase64 != null && avatarBase64!.isNotEmpty) {
      try {
        final imageBytes = base64Decode(avatarBase64!);
        finalBackgroundImage = MemoryImage(imageBytes);
      } catch (e) {
        logger.d("Ошибка декодирования Base64 аватара: $e");
        // В случае ошибки, переходим к заглушке
        finalBackgroundImage = AssetImage(_getPlaceholderAsset());
      }
    }
    // 2. Затем проверяем URL
    else if (avatarUrl != null && avatarUrl!.isNotEmpty) {
      finalBackgroundImage = NetworkImage(avatarUrl!);
    }
    // 3. Если ничего нет, используем заглушку
    else {
      finalBackgroundImage = AssetImage(_getPlaceholderAsset());
    }

    // --- Упрощенный и надежный CircleAvatar ---
    return CircleAvatar(
      radius: radius,
      backgroundImage: finalBackgroundImage,
      // onBackgroundImageError будет вызван, если NetworkImage не сможет загрузить картинку.
      // В этом случае мы ничего не делаем, и CircleAvatar покажет свой backgroundColor или child.
      onBackgroundImageError: finalBackgroundImage is NetworkImage ? (_, __) {} : null,
      // В качестве child покажем заглушку, если картинка из сети не загрузилась
      child: finalBackgroundImage is NetworkImage
          ? _NetworkImageErrorHandler(
        imageProvider: finalBackgroundImage,
        placeholderAsset: _getPlaceholderAsset(),
      )
          : null, // Для MemoryImage и AssetImage child не нужен
    );
  }
}

// Вспомогательный виджет, чтобы корректно обрабатывать ошибки загрузки NetworkImage
class _NetworkImageErrorHandler extends StatelessWidget {
  final ImageProvider imageProvider;
  final String placeholderAsset;

  const _NetworkImageErrorHandler({
    required this.imageProvider,
    required this.placeholderAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Image(
      image: imageProvider,
      fit: BoxFit.cover,
      // Если произошла ошибка загрузки из сети, показываем заглушку
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(
          placeholderAsset,
          fit: BoxFit.cover,
        );
      },
      // Пока картинка грузится, можно показать индикатор или ничего
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child; // Загрузка завершена
        // Возвращаем пустой контейнер, пока идет загрузка
        return const SizedBox.shrink();
      },
    );
  }
}