// lib/screens/card_of_the_day_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovequest/cubit/app_cubit.dart';
import 'package:lovequest/cubit/app_state.dart';
import 'package:lovequest/l10n/generated/app_localizations.dart';
 // <-- Импорт уже есть, отлично!
import 'package:lovequest/src/data/models/enums.dart';
import 'package:lovequest/widgets/common/animated_cosmic_background.dart';
import 'package:lovequest/widgets/common/neon_glow_button.dart';
import 'package:lovequest/widgets/oracle/pulsating_oracle_stone.dart';
import 'package:lovequest/widgets/tarot/flippable_tarot_card.dart';



class CardOfTheDayScreen extends StatelessWidget {
  const CardOfTheDayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Получаем доступ к локализациям
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // Эта строка уже была тобой переведена, все верно
        title: Text(l10n.cardOfTheDayTitle),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: AnimatedCosmicBackground(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: const CardOfTheDayView(),
          ),
        ),
      ),
    );
  }
}


class CardOfTheDayView extends StatelessWidget {
  const CardOfTheDayView({super.key});

  @override
  Widget build(BuildContext context) {
    // Получаем доступ к локализациям здесь тоже, т.к. это отдельный виджет
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<AppCubit, AppState>(
      buildWhen: (p, c) =>
      p.cardOfTheDayStatus != c.cardOfTheDayStatus ||
          p.isCardOfTheDayFlipped != c.isCardOfTheDayFlipped ||
          p.cardOfTheDayInterpretation != c.cardOfTheDayInterpretation,
      builder: (context, state) {
        if (state.cardOfTheDayStatus == LoadingState.loading) {
          // --- БЫЛО ---
          // return const PulsatingOracleStone(text: "Вытягиваю вашу карту...");
          // --- СТАЛО ---
          return PulsatingOracleStone(text: l10n.cardOfTheDayDrawing);
        }

        if (state.cardOfTheDay == null || state.cardOfTheDayStatus == LoadingState.error) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // --- БЫЛО ---
              // const Text(
              //   "Узнайте, какая энергия будет сопровождать вас сегодня.",
              //   ...
              // ),
              // --- СТАЛО ---
              Text(
                l10n.cardOfTheDayDefaultInterpretation,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white70, fontSize: 16),
              ),
              const SizedBox(height: 24),
              // --- БЫЛО ---
              // NeonGlowButton(
              //   text: "Получить Карту Дня",
              //   ...
              // ),
              // --- СТАЛО ---
              NeonGlowButton(
                text: l10n.cardOfTheDayGetButton,
                onPressed: () => context.read<AppCubit>().drawCardOfTheDay(),
              ),
            ],
          );
        }

        final card = state.cardOfTheDay!;
        final isFlipped = state.isCardOfTheDayFlipped;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // --- БЫЛО ---
            // Text(
            //   isFlipped ? "Ваша Карта Дня" : "Нажмите на карту, чтобы узнать послание",
            //   ...
            // ),
            // --- СТАЛО ---
            Text(
              isFlipped ? l10n.cardOfTheDayYourCard : l10n.cardOfTheDayTapToReveal,
              style: const TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: 150,
              height: 260,
              child: FlippableTarotCard(
                card: card,
                isFlipped: isFlipped,
                onCardFlip: () {
                  context.read<AppCubit>().flipCardOfTheDay();
                },
              ),
            ),
            const SizedBox(height: 24),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 600),
              transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
              // Передаем l10n в метод _buildInterpretationContent
              child: isFlipped
                  ? _buildInterpretationContent(context, state, l10n)
                  : const SizedBox.shrink(key: ValueKey('empty_interpretation')),
            ),
          ],
        );
      },
    );
  }

  // Теперь метод принимает l10n
  Widget _buildInterpretationContent(BuildContext context, AppState state, AppLocalizations l10n) {
    final card = state.cardOfTheDay!;
    final interpretation = state.cardOfTheDayInterpretation ??
        (card.isReversed ? card.reversedInterpretation : card.interpretation);

    // Название карты (card.name) и толкование (interpretation) приходят уже
    // на нужном языке из Cubit'а, их мы не трогаем.
    // Нам нужно перевести только суффикс "(перевернутая)".

    return Card(
      key: ValueKey(card.id),
      color: Colors.white.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              // --- БЫЛО ---
              // "${card.name}${card.isReversed ? ' (перевернутая)' : ''}",
              // --- СТАЛО ---
              "${card.name}${card.isReversed ? l10n.cardOfTheDayReversedSuffix : ''}",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.yellowAccent),
              textAlign: TextAlign.center,
            ),
            const Divider(height: 24, color: Colors.white24),
            Text(
              interpretation,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontStyle: FontStyle.italic, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}