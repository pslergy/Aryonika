// lib/screens/palmistry_report_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovequest/cubit/app_cubit.dart';
import 'package:lovequest/cubit/app_state.dart';
import 'package:lovequest/l10n/generated/app_localizations.dart'; // <-- Импорт локализации
import 'package:lovequest/widgets/common/animated_cosmic_background.dart';

class PalmistryReportScreen extends StatelessWidget {
  const PalmistryReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(l10n.palmistry_report_title), // "Карта Вашей Судьбы"
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: AnimatedCosmicBackground(
        child: BlocBuilder<AppCubit, AppState>(
          builder: (context, state) {
            final profile = state.currentUserProfile;
            final palmData = state.palmistryData;

            if (profile == null || palmData == null || profile.palmistryData.isEmpty) {
              return Center(child: Text(l10n.palmistry_data_not_found)); // "Данные анализа не найдены."
            }

            final userChoices = profile.palmistryData;

            return ListView(
              padding: const EdgeInsets.only(top: kToolbarHeight + 40, bottom: 40),
              children: [
                _buildSectionHeader(l10n.palmistry_strong_traits), // "Ваши сильные стороны"
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: profile.palmistryTraits.map((trait) => Chip(
                      label: Text(trait),
                      backgroundColor: Colors.cyanAccent.withOpacity(0.2),
                    )).toList(),
                  ),
                ),
                const SizedBox(height: 30),
                _buildSectionHeader(l10n.privacy), // "Приватность"
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Card(
                    color: Colors.white.withOpacity(0.1),
                    child: SwitchListTile.adaptive(
                      title: Text(l10n.palmistry_show_in_profile), // "Показывать мои черты в профиле"
                      subtitle: Text(l10n.palmistry_show_in_profile_desc), // "Это позволит другим..."
                      value: profile.showPalmistryInProfile,
                      onChanged: (newValue) {
                        context.read<AppCubit>().setShowPalmistryInProfile(newValue);
                      },
                      activeColor: Colors.cyanAccent,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                _buildSectionHeader(l10n.palmistry_interpretation), // "Расшифровка линий"
                ...userChoices.entries.map((choice) {
                  final lineKey = choice.key;
                  final optionKey = choice.value;

                  final lineInfo = palmData.lines[lineKey];
                  final optionInfo = lineInfo?.options[optionKey];

                  if (lineInfo == null || optionInfo == null) {
                    return const SizedBox.shrink();
                  }

                  return _InterpretationCard(
                    title: lineInfo.title,
                    choiceText: optionInfo.choiceText,
                    interpretation: optionInfo.interpretation,
                    l10n: l10n,
                  );
                }).toList(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          color: Colors.pinkAccent.withOpacity(0.8),
          letterSpacing: 3,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }
}

class _InterpretationCard extends StatelessWidget {
  final String title;
  final String choiceText;
  final String interpretation;
  final AppLocalizations l10n;

  const _InterpretationCard({
    required this.title,
    required this.choiceText,
    required this.interpretation,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.cyanAccent)),
          const SizedBox(height: 8),
          Text(l10n.palmistry_your_choice(choiceText), style: const TextStyle(color: Colors.white70, fontStyle: FontStyle.italic)), // "Ваш выбор: ..."
          const Divider(height: 24, color: Colors.white24),
          Text(interpretation, style: const TextStyle(color: Colors.white, height: 1.6)),
        ],
      ),
    );
  }
}