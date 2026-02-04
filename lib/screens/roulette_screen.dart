// lib/screens/roulette_screen.dart
import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lovequest/l10n/generated/app_localizations.dart'; // <-- Импорт локализации

import 'package:lovequest/cubit/app_cubit.dart';
import 'package:lovequest/cubit/app_state.dart';
import 'package:lovequest/src/data/models/enums.dart';
import 'package:lovequest/src/data/models/user_profile_card.dart';
import 'package:lovequest/widgets/common/animated_cosmic_background.dart';
import 'package:lovequest/widgets/common/neon_glow_button.dart';

import '../services/logger_service.dart';
import '../widgets/common/user_avatar.dart';

class RouletteScreen extends StatefulWidget {
  const RouletteScreen({super.key});

  @override
  State<RouletteScreen> createState() => _RouletteScreenState();
}

class _RouletteScreenState extends State<RouletteScreen> with TickerProviderStateMixin {
  late final ConfettiController _confettiController;
  final _audioPlayer = AudioPlayer();
  final _scrollController = ScrollController();
  Timer? _scrollTimer;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 1));
    context.read<AppCubit>().resetRouletteState();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _audioPlayer.dispose();
    _scrollController.dispose();
    _scrollTimer?.cancel();
    super.dispose();
  }

  Future<void> _playSound(String assetPath) async {
    try {
      final playerPath = assetPath.replaceFirst('assets/', '');
      await _audioPlayer.play(AssetSource(playerPath));
    } catch (e, stackTrace) {
      logger.d("❌ Ошибка воспроизведения звука (audioplayers): $e");
      logger.d(stackTrace);
    }
  }

  void _startRoulette() {
    context.read<AppCubit>().startPartnerRoulette(true);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(l10n.oracle_roulette_title), // "Космическая рулетка"
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: AnimatedCosmicBackground(
        child: BlocListener<AppCubit, AppState>(
          listenWhen: (p, c) => p.rouletteLimitMessage != c.rouletteLimitMessage && c.rouletteLimitMessage != null,
          listener: (context, state) {
            showDialog<void>(
              context: context,
              builder: (dialogContext) => AlertDialog(
                backgroundColor: const Color(0xFF2c2c54),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                title: Text(l10n.oracle_limit_title), // "Лимит исчерпан"
                content: Text(state.rouletteLimitMessage?.value ?? "", style: const TextStyle(color: Colors.white70)),
                actions: [
                  TextButton(
                    child: Text(l10n.oracle_limit_later), // "Позже"
                    onPressed: () => Navigator.of(dialogContext).pop(),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
                    child: Text(l10n.oracle_limit_get_pro), // "Получить PRO"
                    onPressed: () {
                      Navigator.of(dialogContext).pop();
                      context.push('/paywall');
                    },
                  ),
                ],
              ),
            ).then((_) {
              context.read<AppCubit>().clearRouletteLimitMessage();
            });
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              BlocConsumer<AppCubit, AppState>(
                listenWhen: (p, c) => p.rouletteState != c.rouletteState,
                listener: (context, state) {
                  if (state.rouletteState == PartnerRouletteState.spinning) {
                    _playSound('assets/sounds/roulette_spin.mp3');
                    _startSpinAnimation(state.rouletteCandidates);
                  }
                },
                builder: (context, state) {
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: _buildContentForState(state, l10n),
                  );
                },
              ),
              Align(
                alignment: Alignment.topCenter,
                child: ConfettiWidget(
                  confettiController: _confettiController,
                  blastDirectionality: BlastDirectionality.explosive,
                  shouldLoop: false,
                  colors: const [Colors.pink, Colors.yellow, Colors.cyan, Colors.purple],
                  emissionFrequency: 0.05,
                  numberOfParticles: 20,
                  gravity: 0.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _startSpinAnimation(List<UserProfileCard> candidates) {
    if (candidates.isEmpty || !mounted) return;

    _playSound('assets/sounds/roulette_spin.mp3');

    const double itemWidth = 160.0;
    const int totalLoops = 10;
    final int totalItems = candidates.length * totalLoops;
    final double maxScrollExtent = totalItems * itemWidth;

    final winner = candidates[Random().nextInt(candidates.length)];
    final winnerIndex = (candidates.length * (totalLoops - 2)) + candidates.indexOf(winner);
    final winnerPosition = winnerIndex * itemWidth;

    _scrollTimer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      if (!_scrollController.hasClients) return;

      final newOffset = _scrollController.offset + 20;

      if (newOffset >= winnerPosition) {
        _scrollController.jumpTo(winnerPosition);
        timer.cancel();

        _playSound('assets/sounds/roulette_win.mp3');
        _confettiController.play();
        context.read<AppCubit>().rouletteFinished(winner);
      } else {
        _scrollController.jumpTo(newOffset);
      }
    });
  }

  Widget _buildContentForState(AppState state, AppLocalizations l10n) {
    switch (state.rouletteState) {
      case PartnerRouletteState.idle:
        return _buildInitialState(l10n);
      case PartnerRouletteState.searching:
        return _buildLoadingState(l10n.oracle_partner_loading); // "Ищем резонанс..."
      case PartnerRouletteState.spinning:
        return _buildSpinningState(state.rouletteCandidates, l10n);
      case PartnerRouletteState.finished:
        return _buildFinishedState(state.rouletteWinner!, l10n);
      case PartnerRouletteState.error:
      case PartnerRouletteState.noProfile:
        return _buildErrorState(l10n.oracle_partner_not_found, l10n); // "Не удалось найти..."
    }
  }

  Widget _buildInitialState(AppLocalizations l10n) {
    return Padding(
      key: const ValueKey('initial'),
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.casino_outlined, size: 80, color: Colors.orangeAccent),
          const SizedBox(height: 24),
          Text(
            l10n.roulette_trust_fate, // "Доверьтесь судьбе"
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            l10n.roulette_desc_short, // "Звезды выберут..."
            style: const TextStyle(color: Colors.white70, fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          NeonGlowButton(
            text: l10n.oracle_roulette_button, // "Крутить рулетку"
            glowColor: Colors.orangeAccent,
            onPressed: _startRoulette,
          ),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms);
  }

  Widget _buildLoadingState(String text) {
    return Column(
      key: const ValueKey('loading'),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircularProgressIndicator(),
        const SizedBox(height: 24),
        Text(text, style: const TextStyle(fontSize: 18, color: Colors.white70)),
      ],
    ).animate().fadeIn();
  }

  Widget _buildSpinningState(List<UserProfileCard> candidates, AppLocalizations l10n) {
    if (candidates.isEmpty) return _buildErrorState(l10n.roulette_no_candidates, l10n);

    final extendedCandidates = List.generate(candidates.length * 10, (index) => candidates[index % candidates.length]);
    const double itemWidth = 160.0;

    return IgnorePointer(
      key: const ValueKey('spinning'),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;
          return ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: extendedCandidates.length,
            padding: EdgeInsets.symmetric(horizontal: (screenWidth / 2) - (itemWidth / 2)),
            itemBuilder: (context, index) {
              final profile = extendedCandidates[index];
              return SizedBox(
                width: itemWidth,
                child: Center(
                  child: UserAvatar(
                    user: profile,
                    radius: 70,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildFinishedState(UserProfileCard winner, AppLocalizations l10n) {
    return Column(
      key: const ValueKey('finished'),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(l10n.roulette_winner_title, style: const TextStyle(fontSize: 22, color: Colors.yellow)), // "Звезды сделали свой выбор!"
        const SizedBox(height: 24),
        _WinnerCard(profile: winner, l10n: l10n),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: _startRoulette,
              child: Text(l10n.roulette_spin_again), // "Крутить еще раз"
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: () {
                context.push('/user_profile/${winner.id}');
              },
              child: Text(l10n.roulette_go_to_profile), // "Перейти в профиль"
            ),
          ],
        )
      ],
    ).animate().scale(delay: 200.ms, duration: 500.ms, curve: Curves.elasticOut);
  }

  Widget _buildErrorState(String message, AppLocalizations l10n) {
    return Padding(
      key: const ValueKey('error'),
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.sentiment_dissatisfied, size: 64, color: Colors.white38),
          const SizedBox(height: 16),
          Text(message, textAlign: TextAlign.center, style: const TextStyle(fontSize: 18, color: Colors.white70)),
          const SizedBox(height: 24),
          NeonGlowButton(
            text: l10n.tryAgain, // "Попробовать снова"
            onPressed: _startRoulette,
          ),
        ],
      ),
    );
  }
}

class _WinnerCard extends StatelessWidget {
  final UserProfileCard profile;
  final AppLocalizations l10n;
  const _WinnerCard({required this.profile, required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.yellow.withOpacity(0.5)),
        gradient: LinearGradient(
          colors: [Colors.purple.withOpacity(0.4), Colors.black.withOpacity(0.4)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.yellow.withOpacity(0.3),
            blurRadius: 20,
            spreadRadius: 2,
          )
        ],
      ),
      child: Column(
        children: [
          UserAvatar(
            user: profile,
            radius: 60,
          ),
          const SizedBox(height: 16),
          Text(
            "${profile.name}, ${profile.age}",
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.favorite, color: Colors.pink, size: 18),
              const SizedBox(width: 8),
              Text(
                l10n.oracle_partner_compatibility((profile.compatibilityScore ?? 85).toString()), // "Совместимость: 85%"
                style: const TextStyle(fontSize: 16, color: Colors.pinkAccent),
              ),
            ],
          ),
        ],
      ),
    );
  }
}