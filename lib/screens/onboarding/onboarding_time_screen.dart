// lib/screens/onboarding/onboarding_time_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lovequest/cubit/onboarding_cubit.dart';
import 'package:lovequest/cubit/onboarding_state.dart';

 // <-- ИМПОРТ


import 'package:lovequest/l10n/generated/app_localizations.dart';
import 'onboarding_scaffold.dart';

class OnboardingTimeScreen extends StatelessWidget {
  const OnboardingTimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!; // <-- Получаем l10n

    // Используем BlocBuilder для всего экрана, чтобы иметь доступ к state
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        final cubit = context.read<OnboardingCubit>();

        // Проверка: есть ли у нас данные с предыдущего шага?
        if (state.gender == null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) context.push('/onboarding/name');
          });
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        return OnboardingScaffold(
          title: l10n.onboardingTimeTitle, // <-- ЗАМЕНА
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(flex: 2),
              Text(
                l10n.onboardingTimeSubtitle, // <-- ЗАМЕНА
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.white.withOpacity(0.8)),
              ).animate().fade(delay: 300.ms).slideY(begin: 0.5),
              const SizedBox(height: 40),
              Material(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () async {
                    final pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay(hour: state.hour, minute: state.minute),
                      helpText: l10n.timePickerHelpText, // <-- ЗАМЕНА
                      builder: (context, child) {
                        return Theme(
                          data: ThemeData.dark().copyWith(
                            colorScheme: const ColorScheme.dark(
                              primary: Colors.pinkAccent,
                              onPrimary: Colors.white,
                              surface: Color(0xFF1E2A4A),
                              onSurface: Colors.white,
                            ),
                            dialogBackgroundColor: const Color(0xFF0D1B2A),
                            textButtonTheme: TextButtonThemeData(
                              style: TextButton.styleFrom(foregroundColor: Colors.pinkAccent),
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );
                    if (pickedTime != null) {
                      cubit.onTimeSelected(pickedTime.hour, pickedTime.minute);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
                    child: Row(
                      children: [
                        const Icon(Icons.access_time_filled, color: Colors.white70),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(l10n.birthTimeLabel, style: const TextStyle(color: Colors.white70)), // <-- ЗАМЕНА
                            const SizedBox(height: 4),
                            Text(
                              "${state.hour.toString().padLeft(2, '0')}:${state.minute.toString().padLeft(2, '0')}",
                              style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ).animate().fade(delay: 500.ms).slideX(begin: 0.5),
              const Spacer(flex: 3),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.pinkAccent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: () => context.push('/onboarding/location'),
                child: Text(
                  l10n.onboardingButtonNextLocation, // <-- ЗАМЕНА
                  style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ).animate().fade(delay: 700.ms).slideY(begin: 0.5),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }
}