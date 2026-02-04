// lib/widgets/search/profile_card.dart

import 'package:flutter/material.dart';
import 'package:lovequest/src/data/models/user_profile_card.dart';
import 'package:lovequest/widgets/common/mystic_placeholder_painter.dart';
import 'package:lovequest/widgets/common/user_avatar.dart'; // <-- Наш универсальный виджет

class ProfileCard extends StatelessWidget {
  final UserProfileCard profile;
  final bool isLiked;
  final VoidCallback onLikeClick;
  final VoidCallback onCardClick;
  final double height;
  final bool isPro;

  const ProfileCard({
    super.key,
    required this.profile,
    required this.isLiked,
    required this.onLikeClick,
    required this.onCardClick,
    this.height = 250.0,
    required this.isPro,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      shadowColor: Colors.pinkAccent.withOpacity(0.5),
      child: InkWell(
        onTap: onCardClick,
        // Используем Stack для наложения слоев: фон, градиент, UI
        child: SizedBox(
          height: height,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // --- СЛОЙ 1: ФОН ---
              // === ГЛАВНОЕ ИСПРАВЛЕНИЕ ЗДЕСЬ ===
              // Вся сложная логика с `backgroundImage` и `decoration` заменяется
              // на один вызов нашего универсального виджета `UserAvatar`.
              UserAvatar(
                user: profile,
                fit: BoxFit.cover,
                // `radius` не передаем, чтобы он был прямоугольным
              ),
              // ===================================

              // --- СЛОЙ 2: ЭФФЕКТЫ И ГРАДИЕНТЫ ---
              // Затемняющий фильтр, чтобы фон не был слишком ярким
              Container(color: Colors.black.withOpacity(0.25)),

              // Мистический знак вопроса, если у пользователя совсем нет аватара
              if (profile.avatar.isEmpty)
                Positioned.fill(
                  child: CustomPaint(
                    painter: MysticPlaceholderPainter(),
                  ),
                ),

              // Градиент для текста снизу
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black.withOpacity(0.9)],
                    begin: Alignment.center,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),

              // --- СЛОЙ 3: UI ЭЛЕМЕНТЫ ПОВЕРХ ---
              // Кнопка лайка
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: onLikeClick,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      color: isLiked ? Colors.redAccent : Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),

              // Информация о пользователе
              Positioned(
                bottom: 12, left: 12, right: 12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  '${profile.name}, ${profile.age}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    shadows: [Shadow(color: Colors.black, blurRadius: 2)],
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              if (isPro) ...[
                                const SizedBox(width: 6),
                                const Tooltip(
                                  message: 'PRO пользователь',
                                  child: Icon(Icons.star_rounded, color: Colors.amber, size: 20),
                                ),
                              ]
                            ],
                          ),
                          Text(
                            profile.city.isNotEmpty ? profile.city : profile.birthCity,
                            style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 13),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    if (profile.sunSign.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white.withOpacity(0.4), width: 1.5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 5,
                              spreadRadius: 2,
                            )
                          ],
                        ),
                        child: Image.asset(
                          'assets/images/zodiac/ic_zodiac_${profile.sunSign.toLowerCase()}.png',
                          width: 26,
                          height: 26,
                          color: Colors.white,
                          colorBlendMode: BlendMode.srcIn,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}