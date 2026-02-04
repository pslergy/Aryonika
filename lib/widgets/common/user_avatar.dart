import 'package:flutter/material.dart';
import '../../src/data/models/user_profile_card.dart';
import 'full_screen_image_viewer.dart';

class UserAvatar extends StatelessWidget {
  final UserProfileCard user;
  final double? radius;
  final bool isClickable;
  final BoxFit? fit;
  final String? heroTag;

  const UserAvatar({
    super.key,
    required this.user,
    this.radius,
    this.isClickable = true,
    this.fit,
    this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    // 1. Безопасное получение URL
    final url = user.avatar;
    final hasImage = url != null && url.isNotEmpty;

    // --- СОЗДАЕМ КОНТЕНТ ---
    Widget avatarContent;

    if (radius != null) {
      // КРУГЛЫЙ ВАРИАНТ
      if (hasImage) {
        // Используем ClipOval + Image.network вместо CircleAvatar + NetworkImage,
        // чтобы работал errorBuilder
        avatarContent = ClipOval(
          child: Image.network(
            url!,
            width: radius! * 2,
            height: radius! * 2,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              // Если ошибка загрузки -> показываем инициалы
              return _buildInitials();
            },
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                width: radius! * 2,
                height: radius! * 2,
                color: Colors.grey[800],
                child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
              );
            },
          ),
        );
      } else {
        avatarContent = _buildInitials();
      }
    } else {
      // ПРЯМОУГОЛЬНЫЙ ВАРИАНТ
      if (hasImage) {
        avatarContent = Image.network(
          url!,
          fit: fit ?? BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          errorBuilder: (_, __, ___) => _buildPlaceholder(),
        );
      } else {
        avatarContent = _buildPlaceholder();
      }
    }

    // --- HERO ---
    Widget result = avatarContent;
    if (heroTag != null) {
      // Для круглого аватара важно обернуть Hero в Material, чтобы не было "черных углов" при полете
      // Но если у тебя ClipOval, то все ок.
      result = Hero(tag: heroTag!, child: result);
    }

    // --- CLICK ---
    if (isClickable && hasImage) {
      result = GestureDetector(
        onTap: () {
          final fullscreenTag = heroTag ?? 'fullscreen_${user.id}';
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => FullScreenImageViewer(
                  imageUrl: url!,
                  tag: fullscreenTag
              ),
            ),
          );
        },
        child: result,
      );
    }

    return result;
  }

  // Виджет инициалов (Замена CircleAvatar child)
  Widget _buildInitials() {
    final double r = radius ?? 20;
    return Container(
      width: r * 2,
      height: r * 2,
      decoration: BoxDecoration(
        color: _getAvatarColor(user.name), // Цветной фон
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
        style: TextStyle(
          fontSize: r * 0.8,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: Colors.grey[800],
      child: const Center(child: Icon(Icons.person, color: Colors.white54)),
    );
  }

  // Генератор цвета по имени (чтобы было красиво)
  Color _getAvatarColor(String name) {
    if (name.isEmpty) return Colors.grey;
    final colors = [
      Colors.blueAccent, Colors.purple, Colors.redAccent,
      Colors.teal, Colors.indigo, Colors.orangeAccent
    ];
    return colors[name.hashCode.abs() % colors.length];
  }
}