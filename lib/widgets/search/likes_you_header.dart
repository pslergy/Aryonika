// lib/widgets/search/likes_you_header.dart
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lovequest/src/data/models/user_profile_card.dart';
import 'package:lovequest/widgets/common/user_avatar.dart';

class LikesYouHeader extends StatelessWidget {
  final List<UserProfileCard> profiles;
  final bool isPro;
  final VoidCallback onClick;

  const LikesYouHeader({
    super.key,
    required this.profiles,
    required this.isPro,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Им понравился твой лик",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),
                ),
                const Spacer(),
                if (!isPro && profiles.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.yellow[700],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "PRO",
                      style: TextStyle(color: Colors.grey[900], fontWeight: FontWeight.bold),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            if (profiles.isEmpty)
              Text("Пока никто...", style: TextStyle(color: Colors.white.withOpacity(0.5))),
            if (profiles.isNotEmpty)
              Row(
                // === НАЧАЛО ИСПРАВЛЕНИЯ ===
                children: profiles.take(4).map((profile) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    // Используем Stack, чтобы наложить размытие поверх аватара
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Слой 1: Наш универсальный UserAvatar
                        UserAvatar(
                          user: profile,
                          radius: 16,
                        ),
                        // Слой 2: Размытие (только если не PRO)
                        if (!isPro)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                              child: Container(
                                width: 32, // 2 * radius
                                height: 32,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black.withOpacity(0.1), // Легкое затемнение
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                }).toList(),
                // === КОНЕЦ ИСПРАВЛЕНИЯ ===
              ),
          ],
        ),
      ),
    );
  }
}