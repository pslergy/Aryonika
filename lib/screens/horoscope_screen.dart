// lib/screens/horoscope_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lovequest/cubit/app_cubit.dart';
import 'package:lovequest/cubit/app_state.dart';
import 'package:lovequest/l10n/generated/app_localizations.dart'; // <-- Импорт локализации
import 'package:lovequest/widgets/common/animated_cosmic_background.dart';
import 'package:lovequest/widgets/horoscope/horoscope_category_card.dart';

class HoroscopeScreen extends StatefulWidget {
  const HoroscopeScreen({super.key});

  @override
  State<HoroscopeScreen> createState() => _HoroscopeScreenState();
}

class _HoroscopeScreenState extends State<HoroscopeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AppCubit>().loadHoroscope();
  }

  // Метод для перевода знака зодиака (если у тебя его нет в L10nMapper)
  String _translateZodiac(String sign, AppLocalizations l10n) {
    // Упрощенная логика, если sign приходит на английском (aries, taurus...)
    // В идеале использовать маппер
    return sign.substring(0, 1).toUpperCase() + sign.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final sunSign = context.select((AppCubit cubit) => cubit.state.currentUserProfile?.sunSign);
    final displaySign = sunSign != null ? _translateZodiac(sunSign, l10n) : '...';

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(l10n.horoscopeForSign(displaySign)), // "Гороскоп для знака [Sign]"
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: AnimatedCosmicBackground(
        child: SafeArea(
          child: BlocBuilder<AppCubit, AppState>(
            buildWhen: (p, c) => p.horoscopeState != c.horoscopeState,
            builder: (context, state) {
              final horoscopeState = state.horoscopeState;

              if (horoscopeState.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (horoscopeState.error != null) {
                return Center(child: Text("${l10n.errorTitle}: ${horoscopeState.error}"));
              }

              // Если загрузка не идет и ошибки нет, но данные пусты
              if (state.horoscope == null) {
                return const Center(child: CircularProgressIndicator());
              }

              final horoscope = state.horoscope!;

              return ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  Text(
                    DateFormat('d MMMM yyyy', Localizations.localeOf(context).languageCode).format(DateTime.now()),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white.withOpacity(0.7)),
                  ),
                  const SizedBox(height: 24),

                  // Общий
                  HoroscopeCategoryCard(
                    title: l10n.horoscopeGeneral, // "Общий"
                    text: horoscope.common,
                    icon: Icons.star_border,
                    color: Colors.yellow,
                  ),
                  const SizedBox(height: 16),

                  // Любовный
                  HoroscopeCategoryCard(
                    title: l10n.horoscopeLove, // "Любовный"
                    text: horoscope.love,
                    icon: Icons.favorite_border,
                    color: Colors.pinkAccent,
                  ),
                  const SizedBox(height: 16),

                  // Деловой
                  HoroscopeCategoryCard(
                    title: l10n.horoscopeBusiness, // "Деловой"
                    text: horoscope.business,
                    icon: Icons.work_outline,
                    color: Colors.lightBlueAccent,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}