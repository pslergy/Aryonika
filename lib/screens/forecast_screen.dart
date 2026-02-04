// lib/screens/forecast_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lovequest/cubit/app_cubit.dart';
import 'package:lovequest/l10n/generated/app_localizations.dart'; // <-- Импорт локализации

import 'package:lovequest/src/data/models/astrology/daily_forecast.dart';
import 'package:lovequest/src/data/models/astrology/forecast_interpretation.dart';
import 'package:lovequest/src/data/models/astrology/natal_chart.dart';
import 'package:lovequest/widgets/common/animated_cosmic_background.dart';

import '../cubit/app_state.dart';

class ForecastScreen extends StatefulWidget {
  const ForecastScreen({super.key});
  @override
  State<ForecastScreen> createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AppCubit>().loadDailyForecast();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(l10n.personalForecastTitle, style: const TextStyle(color: Colors.yellow)), // "Персональный прогноз"
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: AnimatedCosmicBackground(
        child: SafeArea(
          child: BlocBuilder<AppCubit, AppState>(
            builder: (context, state) {
              if (state.isForecastLoading) {
                return const Center(child: CircularProgressIndicator(color: Colors.yellow));
              }

              if (state.dailyForecast == null) {
                return Center(child: Text(l10n.forecastLoadError)); // "Не удалось загрузить прогноз..."
              }

              final forecast = state.dailyForecast!;

              return _buildForecastView(context, forecast, state.isProUser, l10n);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildForecastView(BuildContext context, DailyForecast forecast, bool isProUser, AppLocalizations l10n) {
    final interpretations = forecast.interpretations;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            DateFormat('d MMMM yyyy', Localizations.localeOf(context).languageCode).format(DateTime.now()),
            style: TextStyle(color: Colors.white.withOpacity(0.7)),
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: _buildForecastList(context, interpretations, isProUser, l10n),
        ),
      ],
    );
  }

  Widget _buildForecastList(BuildContext context, List<ForecastInterpretation> interpretations, bool isProUser, AppLocalizations l10n) {
    if (interpretations.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Text(
            l10n.noForecastEvents, // "На сегодня нет значимых событий..."
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    final freeInterpretations = interpretations.where((i) => !i.isProFeature).toList();
    final proInterpretations = interpretations.where((i) => i.isProFeature).toList();

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      children: [
        ...freeInterpretations.map((item) => Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: _AspectInterpretationCard(interpretation: item),
        )),
        if (proInterpretations.isNotEmpty)
          if (isProUser) ...[
            ...proInterpretations.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: _AspectInterpretationCard(interpretation: item),
            )),
          ] else ...[
            ...proInterpretations.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: _LockedAspectCard(interpretation: item, l10n: l10n),
            )),
            _UnlockFullForecastButton(
              onClick: () { /* TODO: context.push('/paywall') */ },
              label: l10n.unlockFullForecast, // "Разблокировать полный прогноз"
            ),
          ]
      ],
    );
  }
}

// ... _getIconForCategory и _ForecastInterpretation ...

IconData _getIconForCategory(String category) {
  switch (category) {
    case "love": return Icons.favorite_border_outlined;
    case "communication": return Icons.chat_bubble_outline;
    case "energy": return Icons.electric_bolt_outlined;
    case "work": return Icons.work_outline;
    case "money": return Icons.monetization_on_outlined;
    case "self": return Icons.self_improvement_outlined;
    case "destiny": return Icons.auto_awesome_outlined;
    case "intuition": return Icons.flare_outlined;
    default: return Icons.star_outline;
  }
}

class _AspectInterpretationCard extends StatelessWidget {
  final ForecastInterpretation interpretation;
  const _AspectInterpretationCard({required this.interpretation});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.yellow[700]!.withOpacity(0.6), width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      color: const Color(0xFF0A0A1E).withOpacity(0.4),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.yellow[700]!.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(_getIconForCategory(interpretation.category), color: Colors.yellow[700], size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    interpretation.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(interpretation.text, style: TextStyle(color: Colors.white.withOpacity(0.9), height: 1.5)),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.3), borderRadius: BorderRadius.circular(8)),
              child: Row(
                children: [
                  Icon(Icons.lightbulb_outline, color: Colors.yellow[700], size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      interpretation.shortAdvice,
                      style: TextStyle(color: Colors.yellow[700], fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LockedAspectCard extends StatelessWidget {
  final ForecastInterpretation interpretation;
  final AppLocalizations l10n; // <-- Передаем локализацию
  const _LockedAspectCard({required this.interpretation, required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.yellow[700]!.withOpacity(0.2), width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      color: const Color(0xFF0A0A1E).withOpacity(0.2),
      child: InkWell(
        onTap: () { /* TODO: context.push('/paywall') */ },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    _getIconForCategory(interpretation.category),
                    color: Colors.yellow[700]!.withOpacity(0.7),
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      interpretation.title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white.withOpacity(0.7),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Icon(Icons.lock_outline, color: Colors.yellow[700], size: 40),
              const SizedBox(height: 8),
              Text(
                l10n.availableInPro, // "Доступно в PRO-версии"
                style: TextStyle(color: Colors.yellow[700]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _UnlockFullForecastButton extends StatelessWidget {
  final VoidCallback onClick;
  final String label; // <-- Принимаем текст
  const _UnlockFullForecastButton({required this.onClick, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
      child: ElevatedButton.icon(
        onPressed: onClick,
        icon: const Icon(Icons.workspace_premium_outlined),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.yellow[700],
          foregroundColor: Colors.black,
          textStyle: const TextStyle(fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          padding: const EdgeInsets.symmetric(vertical: 16),
          minimumSize: const Size(double.infinity, 50),
        ),
      ),
    );
  }
}