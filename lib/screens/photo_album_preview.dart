// lib/widgets/profile/photo_album_preview.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lovequest/services/logger_service.dart';


class PhotoAlbumPreview extends StatelessWidget {
  final String userId;
  final int photoCount;
  final List<String> photosBase64;
  final bool isMyProfile;

  const PhotoAlbumPreview({
    super.key,
    required this.userId,
    required this.photoCount,
    required this.photosBase64,
    this.isMyProfile = false,
  });

  @override
  Widget build(BuildContext context) {
    // === ЛОГИ ===
    logger.d("\n--- UI_ALBUM_PREVIEW (BUILD) ---");
    logger.d("1. Получены данные: photoCount=${photoCount}, photosBase64.length=${photosBase64.length}, isMyProfile=${isMyProfile}");

    if (photoCount == 0 && !isMyProfile) {
      logger.d("2. РЕШЕНИЕ: Скрываю виджет (чужой профиль без фото).");
      logger.d("--- UI_ALBUM_PREVIEW (END) ---\n");
      return const SizedBox.shrink();
    }

    logger.d("2. РЕШЕНИЕ: Показываю виджет.");
    logger.d("--- UI_ALBUM_PREVIEW (END) ---\n");


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 12.0),
          child: Text(
            "Фотоальбом",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
          ),
        ),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: isMyProfile ? photosBase64.length + 1 : photosBase64.length,
            itemBuilder: (context, index) {

              // === ГЛАВНОЕ ИСПРАВЛЕНИЕ: ИЗМЕНЕНА ЛОГИКА ===

              logger.d("\n--- UI_ALBUM_PREVIEW (itemBuilder) ---");
              logger.d("itemBuilder вызван для index: $index");
              logger.d("Условие 1 (is photo?): index < photosBase64.length -> ${index < photosBase64.length}");
              logger.d("Условие 2 (is add button?): isMyProfile && photoCount < 5 -> ${isMyProfile && photoCount < 5}");

              if (index < photosBase64.length) {
              logger.d("РЕШЕНИЕ: Рисую миниатюру фото (Thumbnail).");
              logger.d("--- UI_ALBUM_PREVIEW (itemBuilder END) ---\n");
              final photoBase64 = photosBase64[index];
              return _buildPhotoThumbnail(context, photoBase64, index);
              }
              else if (isMyProfile && photoCount < 5) {
              logger.d("РЕШЕНИЕ: Рисую кнопку 'Добавить' (AddButton).");
              logger.d("--- UI_ALBUM_PREVIEW (itemBuilder END) ---\n");
              return _buildAddPhotoButton(context);
              }
              else {
              logger.d("РЕШЕНИЕ: Ничего не рисую (SizedBox.shrink).");
              logger.d("--- UI_ALBUM_PREVIEW (itemBuilder END) ---\n");
              return const SizedBox.shrink();
              }
            },
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildPhotoThumbnail(BuildContext context, String photoBase64, int index) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Hero(
        tag: 'photo_${userId}_$index',
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              logger.d("!!! ACTION: Нажата миниатюра фото #$index. Перехожу на /album/${userId}...");
              context.push('/album/$userId?initialIndex=$index');
            },
            borderRadius: BorderRadius.circular(12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: AspectRatio(
                aspectRatio: 1.0,
                child: Image.memory(
                  base64Decode(photoBase64),
                  fit: BoxFit.cover,
                  gaplessPlayback: true,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAddPhotoButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            logger.d("!!! ACTION: Нажата кнопка 'Добавить фото'. Перехожу на /profile/edit...");
            context.push('/profile/edit');
          },
          borderRadius: BorderRadius.circular(12),
          child: AspectRatio(
            aspectRatio: 1.0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white38, width: 2, style: BorderStyle.solid),
                color: Colors.white.withOpacity(0.05),
              ),
              child: const Center(
                child: Icon(Icons.add_a_photo_outlined, color: Colors.white70, size: 32),
              ),
            ),
          ),
        ),
      ),
    );
  }
}