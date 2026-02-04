// lib/screens/onboarding/onboarding_birthdate_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:lovequest/cubit/onboarding_cubit.dart';
import 'package:lovequest/cubit/onboarding_state.dart';
 // <-- ИМПОРТ



import 'package:lovequest/l10n/generated/app_localizations.dart';
import 'onboarding_scaffold.dart';

class OnboardingBirthdateScreen extends StatelessWidget {
  const OnboardingBirthdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!; // <-- Получаем l10n
    final langCode = Localizations.localeOf(context).languageCode; // Получаем код языка для DateFormat

    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        final cubit = context.read<OnboardingCubit>();

        if (state.name.trim().isEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) context.push('/onboarding/name');
          });
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        return OnboardingScaffold(
          title: l10n.onboardingBirthdateTitle, // <-- ЗАМЕНА
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(flex: 2),
              Text(
                l10n.onboardingBirthdateSubtitle, // <-- ЗАМЕНА
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
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: state.birthdateMillis != null ? DateTime.fromMillisecondsSinceEpoch(state.birthdateMillis!) : DateTime(2000),
                      firstDate: DateTime(1940),
                      lastDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
                      helpText: l10n.datePickerHelpText, // <-- ЗАМЕНА
                      locale: Localizations.localeOf(context), // <-- Передаем локаль для календаря
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
                          ),
                          child: child!,
                        );
                      },
                    );
                    if (pickedDate != null) {
                      cubit.onBirthDateSelected(pickedDate.millisecondsSinceEpoch);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_today, color: Colors.white70),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(l10n.birthdateLabel, style: const TextStyle(color: Colors.white70)), // <-- ЗАМЕНА
                            const SizedBox(height: 4),
                            Text(
                              state.birthdateMillis != null
                              // --- ИСПОЛЬЗУЕМ ЛОКАЛИЗОВАННЫЙ ФОРМАТ ---
                                  ? DateFormat(l10n.dateFormat, langCode).format(DateTime.fromMillisecondsSinceEpoch(state.birthdateMillis!))
                                  : l10n.birthdatePlaceholder, // <-- ЗАМЕНА
                              style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ).animate().fade(delay: 500.ms).slideX(begin: -0.5),
              const Spacer(flex: 3),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.pinkAccent,
                  disabledBackgroundColor: Colors.grey.withOpacity(0.3),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: state.birthdateMillis != null ? () => context.push('/onboarding/gender') : null,
                child: Text(
                  l10n.onboardingButtonNext, // <-- ЗАМЕНА
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