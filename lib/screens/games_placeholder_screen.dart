// lib/screens/games_placeholder_screen.dart
import 'package:flutter/material.dart';
import 'package:lovequest/l10n/generated/app_localizations.dart'; // Импорт локализации
import 'package:lovequest/widgets/common/animated_cosmic_background.dart';
import 'package:lovequest/widgets/common/feature_placeholder.dart';

class GamesPlaceholderScreen extends StatelessWidget {
  const GamesPlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.gameCenterTitle), // "Игровой центр"
      ),
      body: AnimatedCosmicBackground(
        child: Center(
          child: FeaturePlaceholder(
            icon: Icons.games_rounded,
            title: l10n.gamesComingSoonTitle, // "Игры и Награды скоро появятся!"
            description: l10n.gamesComingSoonDesc, // "Мы готовим увлекательные мини-игры..."
            buttonText: l10n.joinTelegramButton, // "Узнавайте первыми в нашем Telegram"
            buttonUrl: 'https://t.me/your_channel_name',
          ),
        ),
      ),
    );
  }
}