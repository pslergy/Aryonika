// lib/widgets/onboarding/onboarding_scaffold.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lovequest/widgets/common/animated_cosmic_background.dart';

class OnboardingScaffold extends StatelessWidget {
  final String title;
  final Widget child;
  final List<Widget>? actions;

  const OnboardingScaffold({
    super.key,
    required this.title,
    required this.child,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: context.canPop()
            ? BackButton(color: Colors.white70, onPressed: () => context.pop())
            : null, // Если возвращаться некуда, не показываем кнопку
        actions: actions, // <<<--- ПЕРЕДАЕМ actions В AppBar
      ),
      body: AnimatedCosmicBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: child,
          ),
        ),
      ),
    );
  }
}