// lib/screens/photo_album_screen.dart

import 'package:flutter/material.dart';
import 'package:lovequest/l10n/generated/app_localizations.dart'; // <-- Импорт локализации
import 'package:lovequest/widgets/common/animated_cosmic_background.dart';

class PhotoAlbumScreen extends StatelessWidget {
  final String userId;
  const PhotoAlbumScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.photoAlbumTitle('')), // "Фотоальбом" (пустой аргумент, т.к. счетчик тут не нужен)
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.white),
      ),
      extendBodyBehindAppBar: true,
      body: AnimatedCosmicBackground(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.lock_clock, size: 80, color: Colors.white.withOpacity(0.5)),
              const SizedBox(height: 20),
              Text(
                l10n.feature_in_development, // "Функция в разработке" (уже есть в ARB)
                style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                l10n.photoAlbumComingSoon, // "Скоро вы сможете загружать сюда свои фото."
                style: const TextStyle(color: Colors.white70),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}