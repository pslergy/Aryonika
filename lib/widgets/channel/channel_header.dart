// lib/widgets/channel/channel_header.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Импорт для context.watch
import 'package:lovequest/cubit/app_cubit.dart'; // Импорт AppCubit
import 'package:lovequest/src/data/models/channel.dart';

class ChannelHeader extends StatelessWidget {
  final Channel channel;
  final bool isSubscribed;
  final VoidCallback onSubscribeClick;

  const ChannelHeader({
    super.key,
    required this.channel,
    required this.isSubscribed,
    required this.onSubscribeClick,
  });

  @override
  Widget build(BuildContext context) {
    // Получаем текущий язык из AppCubit
    final langCode = context.watch<AppCubit>().state.locale?.languageCode ?? 'ru';

    // --- ИСПРАВЛЕНИЕ 1: БЕЗОПАСНАЯ РАБОТА С NULLABLE AVATARURL ---
    final imageUrl = channel.avatarUrl; // Сначала получаем значение в переменную
    final imageBytes = (imageUrl != null && imageUrl.startsWith('data:image'))
        ? base64Decode(imageUrl.split(',').last)
        : null;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: imageBytes != null ? MemoryImage(imageBytes) : null,
            child: imageBytes == null
                ? Icon(Icons.public, size: 50, color: Colors.white.withOpacity(0.7))
                : null,
          ),
          const SizedBox(height: 16),
          Text(
            channel.getLocalizedName(langCode), // <-- ИСПОЛЬЗУЕМ ПЕРЕМЕННУЮ ЯЗЫКА
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),

          // --- ИСПРАВЛЕНИЕ 2: УДАЛЯЕМ OWNERNAME ---
          // Поле ownerName больше не существует в модели Channel
          // const SizedBox(height: 8),
          // Text(
          //   'Автор: ${channel.ownerName}',
          //   style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.7)),
          // ),

          const SizedBox(height: 16),
          Text(
            channel.getLocalizedDescription(langCode), // <-- ИСПОЛЬЗУЕМ ПЕРЕМЕННУЮ ЯЗЫКА
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, color: Colors.white.withOpacity(0.9), height: 1.5),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 16),
          Text(
            '${channel.subscriberCount} подписчиков', // TODO: Сделать локализацию для "подписчиков"
            style: TextStyle(color: Colors.white.withOpacity(0.7)),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: onSubscribeClick,
            style: ElevatedButton.styleFrom(
              backgroundColor: isSubscribed ? Colors.grey[800] : Colors.pinkAccent,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
            child: Text(isSubscribed ? 'Вы подписаны' : 'Подписаться'),
          ),
        ],
      ),
    );
  }
}