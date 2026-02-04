// lib/widgets/profile/my_profile_header.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lovequest/src/data/models/user_profile_card.dart';
import 'package:lovequest/widgets/common/pro_avatar.dart';
import 'package:lovequest/widgets/common/user_avatar.dart';

import '../../screens/search_screen.dart';

// Аналог вашего ClickableRow
class _ClickableRow extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onClick;

  const _ClickableRow({
    required this.text,
    required this.icon,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    // Используем InkWell для эффекта нажатия
    return InkWell(
      onTap: onClick,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          mainAxisSize: MainAxisSize.min, // Чтобы Row не растягивался
          children: [
            Icon(icon, color: Colors.yellow[700], size: 18),
            const SizedBox(width: 8),
            Text(text, style: TextStyle(color: Colors.yellow[700])),
          ],
        ),
      ),
    );
  }
}

// Основной виджет хедера
class MyProfileHeader extends StatelessWidget {
  // === ОСТАВЛЯЕМ ВАШИ ПАРАМЕТРЫ, НО ЗАМЕНЯЕМ АВАТАР ===
  final UserProfileCard user; // <-- Принимаем весь объект user для аватара
  final String userName;
  final String userId;
  // final String? avatarBase64; // <-- УДАЛЯЕМ ЭТО ПОЛЕ
  final VoidCallback onEditClick;
  final VoidCallback onSettingsClick;
  final VoidCallback onAvatarClick;
  final VoidCallback onEditBioClick;
  final String sunSign;
  final bool isPro;

  const MyProfileHeader({
    super.key,
    required this.user, // <-- `user` теперь обязательный
    required this.userName,
    required this.userId,
    // avatarBase64 больше не нужен
    required this.onEditClick,
    required this.onSettingsClick,
    required this.onAvatarClick,
    required this.onEditBioClick,
    required this.isPro,
    required this.sunSign,
  });
  // =======================================================

  @override
  Widget build(BuildContext context) {
    // Вспомогательный виджет _ClickableRow, чтобы не дублировать код
    Widget _buildClickableRow({
      required String text,
      required IconData icon,
      required VoidCallback onClick,
    }) {
      return InkWell(
        onTap: onClick,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            children: [
              Icon(icon, color: Colors.white70, size: 20),
              const SizedBox(width: 8),
              Text(text, style: const TextStyle(color: Colors.white70)),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
      child: Stack(
        children: [
          // Основной Row с контентом
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // --- 1. АВАТАР (ЕДИНСТВЕННОЕ ИЗМЕНЕНИЕ) ---
              GestureDetector(
                onTap: onAvatarClick, // Теперь этот клик сработает!
                child: UserAvatar(
                  user: user,
                  radius: 40,
                  isClickable: false, // <--- ГЛАВНОЕ ИСПРАВЛЕНИЕ: Отключаем внутренний клик
                ),
              ),
              // ==========================================

              const SizedBox(width: 16),

              // --- 2. ПРАВАЯ КОЛОНКА С ИНФОРМАЦИЕЙ ---
              // Вся ваша верстка здесь остается БЕЗ ИЗМЕНЕНИЙ
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            userName,
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (isPro) ...[
                          const SizedBox(width: 8),
                          const Tooltip(
                            message: 'PRO пользователь',
                            child: Icon(Icons.star_rounded, color: Colors.amber, size: 24),
                          ),
                        ]
                      ],
                    ),
                    const SizedBox(height: 8),
                    _buildClickableRow(
                      text: 'Редактировать профиль',
                      icon: Icons.person_outline,
                      onClick: onEditClick,
                    ),
                    _buildClickableRow(
                      text: 'О себе',
                      icon: Icons.edit_note_rounded,
                      onClick: onEditBioClick,
                    ),
                    _buildClickableRow(
                      text: 'ID: ${userId.substring(0, 8)}...',
                      icon: Icons.copy,
                      onClick: () {
                        Clipboard.setData(ClipboardData(text: userId));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('ID пользователя скопирован')),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Кнопка настроек
          Positioned(
            top: -10, // Смещаем, чтобы было аккуратнее
            right: -10,
            child: IconButton(
              icon: Icon(Icons.settings, color: Colors.white.withOpacity(0.8)),
              onPressed: onSettingsClick,
            ),
          ),
        ],
      ),
    );
  }
}