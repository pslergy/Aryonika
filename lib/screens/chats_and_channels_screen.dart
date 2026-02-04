// lib/screens/chats_and_channels_screen.dart

import 'package:flutter/material.dart';
import 'package:lovequest/l10n/generated/app_localizations.dart'; // Импорт
import 'package:lovequest/screens/channels_screen.dart';
import 'package:lovequest/screens/chat_list_screen.dart';
import 'package:lovequest/widgets/common/animated_cosmic_background.dart';

class ChatsAndChannelsScreen extends StatelessWidget {
  const ChatsAndChannelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.communicationTitle), // "Общение"
          backgroundColor: Colors.transparent,
          elevation: 0,
          bottom: TabBar(
            indicatorColor: Colors.pinkAccent,
            tabs: [
              Tab(text: l10n.privateChatsTab), // "Личные" (ключ уже есть)
              Tab(text: l10n.channelsTab),     // "Каналы" (ключ уже есть)
            ],
          ),
        ),
        body: AnimatedCosmicBackground(
          child: const TabBarView(
            children: [
              ChatListScreen(),
              ChannelsScreen(),
            ],
          ),
        ),
      ),
    );
  }
}