// lib/widgets/channel/stylish_channel_card.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Импорт для context.watch
import 'package:lovequest/cubit/app_cubit.dart'; // Импорт AppCubit
import 'package:lovequest/src/data/models/channel.dart';

import '../../src/data/models/channel_preview.dart';

class StylishChannelCard extends StatelessWidget {
  // --- 👇 ТИП ПОМЕНЯЛСЯ НА ChannelPreview 👇 ---
  final ChannelPreview channelPreview;
  final VoidCallback onCardClick;

  const StylishChannelCard({
    super.key,
    required this.channelPreview,
    required this.onCardClick,
  });

  // Вспомогательный метод для аватара
  ImageProvider? _getAvatarImage(String? avatarUrl) {
    if (avatarUrl != null && avatarUrl.isNotEmpty) {
      if (avatarUrl.startsWith('data:image')) {
        try { return MemoryImage(base64Decode(avatarUrl.split(',').last)); } catch (e) { return null; }
      } else if (avatarUrl.startsWith('http')) {
        return NetworkImage(avatarUrl);
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final avatar = _getAvatarImage(channelPreview.avatarUrl);

    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onCardClick,
        child: SizedBox(
          height: 120, // Сделаем карточку чуть компактнее для списка
          child: Stack(
            children: [
              // Фон (можно добавить картинку или оставить градиент)
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.purple.withOpacity(0.5), Colors.indigo.withOpacity(0.7)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),

              // Основной контент
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundImage: avatar,
                      child: avatar == null ? Text(channelPreview.name.substring(0, 1).toUpperCase(), style: const TextStyle(fontSize: 24)) : null,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            channelPreview.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            channelPreview.lastMessageText ?? 'Нет сообщений',
                            style: TextStyle(
                              color: channelPreview.unreadCount > 0 ? Colors.white : Colors.white70,
                              fontSize: 14,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Счетчик непрочитанных
              if (channelPreview.unreadCount > 0)
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.pinkAccent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      channelPreview.unreadCount > 9 ? '9+' : channelPreview.unreadCount.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}