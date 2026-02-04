// lib/screens/onboarding/onboarding_gender_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:lovequest/cubit/onboarding_cubit.dart';
import 'package:lovequest/cubit/onboarding_state.dart';




import 'package:lovequest/l10n/generated/app_localizations.dart';
import 'onboarding_scaffold.dart';

class OnboardingGenderScreen extends StatelessWidget {
  const OnboardingGenderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!; // <-- Получаем l10n

    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        final cubit = context.read<OnboardingCubit>();

        if (state.birthdateMillis == null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) context.push('/onboarding/name');
          });
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        return OnboardingScaffold(
          title: l10n.onboardingGenderTitle, // <-- ЗАМЕНА
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(flex: 2),
              Text(
                l10n.onboardingGenderSubtitle, // <-- ЗАМЕНА
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.white.withOpacity(0.8)),
              ).animate().fade(delay: 300.ms).slideY(begin: 0.5),
              const SizedBox(height: 40),
              _GenderButton(
                label: l10n.genderMale, // <-- ЗАМЕНА
                icon: Icons.male,
                isSelected: state.gender == 'male',
                onTap: () => cubit.onGenderSelected('male'),
              ).animate().fade(delay: 500.ms).slideX(begin: -0.5),
              const SizedBox(height: 20),
              _GenderButton(
                label: l10n.genderFemale, // <-- ЗАМЕНА
                icon: Icons.female,
                isSelected: state.gender == 'female',
                onTap: () => cubit.onGenderSelected('female'),
              ).animate().fade(delay: 600.ms).slideX(begin: 0.5),
              const Spacer(flex: 3),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.pinkAccent,
                  disabledBackgroundColor: Colors.grey.withOpacity(0.3),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: state.gender != null ? () => context.push('/onboarding/time') : null,
                child: Text(
                  l10n.onboardingButtonNext, // <-- ЗАМЕНА (используем тот же ключ, что и на экране имени)
                  style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ).animate().fade(delay: 800.ms).slideY(begin: 0.5),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }
}

class _GenderButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _GenderButton({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? Colors.pinkAccent.withOpacity(0.2) : Colors.white.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isSelected ? Colors.pinkAccent : Colors.white.withOpacity(0.2),
          width: 2,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 28,
                color: isSelected ? Colors.white : Colors.white70,
              ),
              const SizedBox(width: 12),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.white70,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}