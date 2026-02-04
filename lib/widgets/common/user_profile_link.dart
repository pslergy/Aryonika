// lib/widgets/common/user_profile_link.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lovequest/services/logger_service.dart';

class UserProfileLink extends StatelessWidget {
  final String userId;
  final Widget child;

  const UserProfileLink({
    super.key,
    required this.userId,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Можно использовать InkWell для эффекта "волны" при нажатии
      onTap: () {
        logger.d("Переход на профиль пользователя с ID: $userId");
        // Используем push, чтобы экран открылся поверх текущего
        context.push('/user_profile/$userId');
      },
      child: child,
    );
  }
}