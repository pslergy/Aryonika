// lib/screens/onboarding/onboarding_finish_screen.dart
import 'dart:async';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lovequest/cubit/onboarding_cubit.dart';
import 'package:lovequest/cubit/onboarding_state.dart';
import 'package:lovequest/l10n/generated/app_localizations.dart';

import 'package:lovequest/widgets/common/animated_cosmic_background.dart';



class OnboardingFinishScreen extends StatefulWidget {
  const OnboardingFinishScreen({super.key});

  @override
  State<OnboardingFinishScreen> createState() => _OnboardingFinishScreenState();
}

class _OnboardingFinishScreenState extends State<OnboardingFinishScreen> {
  // Список текстов теперь пустой по умолчанию, мы заполним его позже
  List<String> _loadingTexts = [];
  int _currentTextIndex = 0;
  Timer? _textAnimationTimer;
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Инициализируем тексты только один раз
    if (!_isInitialized) {
      final l10n = AppLocalizations.of(context)!;
      _loadingTexts = [
        l10n.onboardingFinishText1,
        l10n.onboardingFinishText2,
        l10n.onboardingFinishText3,
        l10n.onboardingFinishText4,
      ];
      _startAnimation();
      _isInitialized = true;
    }
  }

  void _startAnimation() {
    _textAnimationTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_currentTextIndex < _loadingTexts.length - 1) {
        setState(() => _currentTextIndex++);
      } else {
        timer.cancel();
      }
    });

    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) context.read<OnboardingCubit>().finalizeOnboarding();
    });
  }

  @override
  void dispose() {
    _textAnimationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!; // l10n для диалога

    return Scaffold(
      body: AnimatedCosmicBackground(
        child: BlocListener<OnboardingCubit, OnboardingState>(
          listener: (context, state) {
            if (state.status == OnboardingStatus.error) {
              _textAnimationTimer?.cancel();
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  backgroundColor: const Color(0xFF1E2A4A),
                  title: Text(l10n.onboardingFinishErrorTitle, style: const TextStyle(color: Colors.white)), // <-- ЗАМЕНА
                  content: Text(state.errorMessage ?? l10n.onboardingFinishErrorContent, style: const TextStyle(color: Colors.white70)), // <-- ЗАМЕНА
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                        context.pop();
                      },
                      child: Text(l10n.onboardingFinishErrorButton, style: const TextStyle(color: Colors.pinkAccent)), // <-- ЗАМЕНА
                    ),
                  ],
                ),
              );
            }
          },
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ... (Анимация "Атома" остается без изменений) ...
                const SizedBox(height: 40),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder: (child, animation) {
                    return FadeTransition(opacity: animation, child: SlideTransition(position: Tween<Offset>(begin: const Offset(0.0, 0.5), end: Offset.zero).animate(animation), child: child));
                  },
                  child: Text(
                    // Проверяем, что список не пустой, чтобы избежать ошибки при первой отрисовке
                    _loadingTexts.isNotEmpty ? _loadingTexts[_currentTextIndex] : '',
                    key: ValueKey<int>(_currentTextIndex),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18, color: Colors.white70),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Вспомогательный виджет для создания орбиты
  Widget _buildOrbit({required double angle, required double scale, required Duration delay}) {
    return Animate(
      delay: delay,
      onPlay: (controller) => controller.repeat(),
      effects: [
        ScaleEffect(
          duration: 2.seconds,
          curve: Curves.easeInOut,
          begin: Offset(scale * 0.8, scale * 0.8),
          end: Offset(scale, scale),
        ),
      ],
      child: Transform.rotate(
        angle: angle * (3.14159 / 180),
        child: Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withOpacity(0.1), width: 2),
          ),
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.white.withOpacity(0.5), blurRadius: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}