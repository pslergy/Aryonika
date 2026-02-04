// lib/screens/onboarding/onboarding_name_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lovequest/cubit/app_cubit.dart';
import 'package:lovequest/cubit/onboarding_cubit.dart';
import 'package:lovequest/cubit/onboarding_state.dart';


import 'package:lovequest/l10n/generated/app_localizations.dart';
import 'onboarding_scaffold.dart';

class OnboardingNameScreen extends StatelessWidget {
  const OnboardingNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!; // <-- Получаем l10n

    return BlocBuilder<OnboardingCubit, OnboardingState>(
      buildWhen: (prev, current) => prev.name != current.name,
      builder: (context, state) {
        final cubit = context.read<OnboardingCubit>();

        return OnboardingScaffold(
          title: l10n.onboardingNameTitle, // <-- ЗАМЕНА
          actions: [
            IconButton(
              icon: const Icon(Icons.logout, color: Colors.redAccent),
              tooltip: l10n.onboardingNameSignOutTooltip, // <-- ЗАМЕНА
              onPressed: () => context.read<AppCubit>().signOut(),
            ),
          ],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(flex: 2),
              Text(
                l10n.onboardingNameSubtitle, // <-- ЗАМЕНА
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.white.withOpacity(0.8)),
              ).animate().fade(delay: 300.ms).slideY(begin: 0.5),
              const SizedBox(height: 40),
              TextFormField(
                initialValue: state.name,
                onChanged: (name) => cubit.onNameChanged(name),
                style: const TextStyle(color: Colors.white, fontSize: 18),
                textCapitalization: TextCapitalization.words,
                decoration: _inputDecoration(
                  labelText: l10n.onboardingNameLabel, // <-- ЗАМЕНА
                  prefixIcon: Icons.person_outline,
                ),
              ).animate().fade(delay: 500.ms).slideX(begin: -0.5),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: state.bio,
                onChanged: (bio) => cubit.onBioChanged(bio),
                style: const TextStyle(color: Colors.white),
                maxLines: 4,
                decoration: _inputDecoration(
                  labelText: l10n.onboardingBioLabel, // <-- ЗАМЕНА
                  hintText: l10n.onboardingBioHint, // <-- ЗАМЕНА
                  prefixIcon: Icons.edit_note,
                ),
              ).animate().fade(delay: 600.ms).slideX(begin: 0.5),
              const Spacer(flex: 3),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.pinkAccent,
                  disabledBackgroundColor: Colors.grey.withOpacity(0.3),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: state.name.trim().isNotEmpty
                    ? () => context.push('/onboarding/birthdate')
                    : null,
                child: Text(
                  l10n.onboardingButtonNext, // <-- ЗАМЕНА
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

  // Вспомогательный метод остается без изменений
  InputDecoration _inputDecoration({required String labelText, String? hintText, required IconData prefixIcon}) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      prefixIcon: Icon(prefixIcon, color: Colors.white70),
      labelStyle: const TextStyle(color: Colors.white70),
      hintStyle: const TextStyle(color: Colors.white30),
      contentPadding: const EdgeInsets.symmetric(vertical: 20.0),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.white30),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.pinkAccent),
      ),
    );
  }
}