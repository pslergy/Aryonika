// lib/screens/auth_wrapper_screen.dart

// 1. Добавь этот импорт


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lovequest/cubit/app_cubit.dart';
import 'package:lovequest/cubit/app_state.dart';
import 'package:lovequest/l10n/generated/app_localizations.dart';

import 'package:lovequest/widgets/common/animated_cosmic_background.dart';
import 'package:simple_animations/simple_animations.dart';


import '../services/logger_service.dart';

class AuthWrapperScreen extends StatelessWidget {
  const AuthWrapperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // --- НАЧАЛО ИЗМЕНЕНИЙ: Добавляем BlocListener ---
    // Оборачиваем весь виджет в BlocListener. Он будет "слушать" изменения в фоне.
    return BlocListener<AppCubit, AppState>(
      // Срабатываем только в тот момент, когда приложение переходит из состояния "не готово" в "готово".
      listenWhen: (previous, current) => !previous.isReady && current.isReady,
      listener: (context, state) {
        // Условие `listenWhen` уже гарантирует, что state.isReady здесь будет true,
        // поэтому дополнительная проверка не нужна.
        logger.d("--- AuthWrapper: Приложение готово! Запускаю проверку языка. ---");
        // Вызываем нашу функцию для проверки и обновления языка на сервере.
        context.read<AppCubit>().checkAndUpdateUserLanguage(context);
      },
      // В child оставляем весь ваш существующий код, который строит UI.
      // Он будет работать как и раньше.
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          Widget content;

          if (state.profileStatus == ProfileValidationStatus.invalid) {
            content = _buildValidationError(context, l10n);
          } else {
            content = _PulsatingLogo(l10n: l10n);
          }

          return Scaffold(
            body: AnimatedCosmicBackground(
              child: Center(child: content),
            ),
          );
        },
      ),
    );
    // --- КОНЕЦ ИЗМЕНЕНИЙ ---
  }


  Widget _buildValidationError(BuildContext context, AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline_rounded, color: Colors.redAccent, size: 60),
          const SizedBox(height: 20),
          Text(
            l10n.profileCreationErrorTitle, // <- ЗАМЕНА
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 12),
          Text(
            l10n.profileCreationErrorDescription, // <- ЗАМЕНА
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            onPressed: () {
              context.read<AppCubit>().signOut();
              context.push('/login');
            },
            child: Text(l10n.tryAgain), // <- ЗАМЕНА
          )
        ],
      ),
    );
  }
}


class _PulsatingLogo extends StatelessWidget {
  final AppLocalizations l10n;
  const _PulsatingLogo({required this.l10n});

  @override
  Widget build(BuildContext context) {
    return LoopAnimationBuilder<double>(
      tween: Tween(begin: 0.95, end: 1.05),
      duration: const Duration(milliseconds: 1800),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Opacity(
            opacity: 1.5 - value,
            child: child,
          ),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.favorite_border,
            size: 80,
            color: Colors.pinkAccent.withOpacity(0.8),
            shadows: [
              Shadow(color: Colors.pinkAccent.withOpacity(0.5), blurRadius: 15)
            ],
          ),
          const SizedBox(height: 16),
          Text(
            "Aryonika", // Название бренда обычно не переводят
            style: TextStyle(
              fontSize: 24,
              color: Colors.white.withOpacity(0.8),
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.connectingHearts, // <- ЗАМЕНА
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }
}