// lib/widgets/search/swipe_card.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lovequest/src/data/models/user_profile_card.dart';
import 'package:lovequest/widgets/common/user_avatar.dart';

class SwipeCard extends StatelessWidget {
  final UserProfileCard profile;
  final VoidCallback? onLike;
  final VoidCallback? onDislike;
  final bool isCompact;
  final VoidCallback? onCardTap;

  const SwipeCard({
    super.key,
    required this.profile,
    this.onLike,
    this.onDislike,
    this.isCompact = false,
    this.onCardTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        // Адаптивные размеры шрифтов
        final double nameFontSize = isCompact ? 18 : (constraints.maxWidth > 600 ? 36 : 28);
        final double cityFontSize = isCompact ? 14 : (constraints.maxWidth > 600 ? 20 : 16);
        final double bioFontSize = isCompact ? 12 : (constraints.maxWidth > 600 ? 18 : 14);
        final double padding = isCompact ? 12.0 : (constraints.maxWidth > 600 ? 32.0 : 20.0);

        return Card(
          elevation: 8,
          shadowColor: Colors.black45,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
          clipBehavior: Clip.antiAlias, // Обрезаем контент по краям карточки
          margin: EdgeInsets.zero,
          child: InkWell(
            onTap: onCardTap ?? () => context.push('/user_profile/${profile.id}'),
            child: Stack(
              children: [
                // --- СЛОЙ 1: ФОН (Аватар) ---
                // Используем наш универсальный UserAvatar, он сам разберется с форматами
                Positioned.fill(
                  child: UserAvatar(
                    user: profile,
                    fit: BoxFit.cover,
                    // radius не нужен, так как мы заполняем всё пространство
                  ),
                ),

                // --- СЛОЙ 2: ГРАДИЕНТ ---
                // Делаем текст читаемым на любом фоне
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.4),
                          Colors.black.withOpacity(0.9),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: const [0.4, 0.7, 1.0],
                      ),
                    ),
                  ),
                ),

                // --- СЛОЙ 3: КОНТЕНТ ---
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: EdgeInsets.all(padding),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Имя и Возраст
                        Text(
                          '${profile.name}, ${profile.age}',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: nameFontSize,
                            shadows: [const Shadow(blurRadius: 4, color: Colors.black)],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),

                        // Город
                        if (profile.city.isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.location_on_outlined, color: Colors.white70, size: cityFontSize),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  profile.city,
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: cityFontSize,
                                    shadows: const [Shadow(blurRadius: 2, color: Colors.black54)],
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],

                        // Биография (только в полной версии)
                        if (!isCompact && profile.bio.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          // Ограничиваем высоту текста, чтобы он не вылезал
                          Text(
                            profile.bio,
                            maxLines: 3, // Максимум 3 строки
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: bioFontSize,
                              height: 1.4,
                              shadows: const [Shadow(blurRadius: 2, color: Colors.black54)],
                            ),
                          ),
                        ],

                        // Кнопки действий (только в полной версии)
                        if (!isCompact) ...[
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _ActionButton(
                                icon: Icons.close,
                                color: Colors.white,
                                iconColor: Colors.grey.shade700,
                                size: 50,
                                onTap: onDislike,
                              ),
                              _ActionButton(
                                icon: Icons.favorite,
                                color: Colors.red.shade400,
                                iconColor: Colors.white,
                                size: 64, // Кнопка лайка больше
                                onTap: onLike,
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Вспомогательный виджет для кнопок, чтобы код был чище
class _ActionButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color iconColor;
  final double size;
  final VoidCallback? onTap;

  const _ActionButton({
    required this.icon,
    required this.color,
    required this.iconColor,
    required this.size,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      shape: const CircleBorder(),
      elevation: 4,
      shadowColor: Colors.black45,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Container(
          width: size,
          height: size,
          alignment: Alignment.center,
          child: Icon(icon, color: iconColor, size: size * 0.5),
        ),
      ),
    );
  }
}