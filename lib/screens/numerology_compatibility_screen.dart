// lib/screens/numerology_compatibility_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lovequest/cubit/app_cubit.dart';
import 'package:lovequest/cubit/numerology_cubit.dart';
import 'package:lovequest/cubit/numerology_state.dart';
import 'package:lovequest/src/data/models/numerology_report.dart';
import 'package:lovequest/l10n/generated/app_localizations.dart'; // Импорт локализации
import 'package:percent_indicator/percent_indicator.dart';

// --- Wrapper для Cubit ---
class NumerologyCompatibilityScreenWrapper extends StatelessWidget {
  final String partnerId;
  const NumerologyCompatibilityScreenWrapper({Key? key, required this.partnerId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NumerologyCubit(
        appCubit: context.read<AppCubit>(),
        apiRepository: context.read(),
      )..loadCompatibilityReport(partnerId),
      child: const NumerologyCompatibilityScreen(),
    );
  }
}

class NumerologyCompatibilityScreen extends StatelessWidget {
  const NumerologyCompatibilityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.numerology_report_title)),
      body: BlocBuilder<NumerologyCubit, NumerologyState>(
        builder: (context, state) {
          if (state.status == NumerologyStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == NumerologyStatus.error) {
            return Center(child: Text(state.errorMessage ?? l10n.errorLoadingReport)); // "Ошибка загрузки отчета"
          }

          final report = state.compatibilityReport;
          if (report == null) {
            return Center(child: Text(l10n.noData)); // "Не удалось получить данные." -> "Нет данных" (используем существующий ключ)
          }

          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              _buildOverallScore(context, report.overallScore, l10n),
              const SizedBox(height: 24),
              ...report.comparisons.map((comp) => _buildComparisonCard(comp, l10n)).toList(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildOverallScore(BuildContext context, int score, AppLocalizations l10n) {
    final scoreColor = Color.lerp(Colors.orangeAccent, Colors.greenAccent, (score - 20) / 80)!;
    String scoreText;
    if (score >= 80) scoreText = l10n.numerology_score_high;
    else if (score >= 50) scoreText = l10n.numerology_score_medium;
    else scoreText = l10n.numerology_score_low;

    return Card(
      color: Colors.white.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Text(l10n.numerology_report_overall,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
                textAlign: TextAlign.center),
            const SizedBox(height: 24),
            CircularPercentIndicator(
              radius: 65.0,
              lineWidth: 13.0,
              percent: score / 100,
              center: Text("$score%", style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
              progressColor: scoreColor,
              backgroundColor: Colors.grey.shade800,
              circularStrokeCap: CircularStrokeCap.round,
              animateFromLastPercent: true,
              animation: true,
            ),
            const SizedBox(height: 16),
            Text(scoreText, style: TextStyle(fontSize: 16, color: scoreColor, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 500.ms);
  }

  Widget _buildComparisonCard(NumerologyComparison comparison, AppLocalizations l10n) {
    Color borderColor;
    switch (comparison.harmony) {
      case 'high': borderColor = Colors.greenAccent; break;
      case 'challenging':
      case 'low':
        borderColor = Colors.orangeAccent; break;
      default: borderColor = Colors.white24;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      color: Colors.black.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: borderColor, width: 1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(comparison.type, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              ],
            ),
            const SizedBox(height: 8),

            if (comparison.value1 != null && comparison.value2 != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNumberCircle(l10n.numerology_report_you, comparison.value1!),
                  Icon(Icons.sync_alt_rounded, color: borderColor, size: 28),
                  _buildNumberCircle(l10n.numerology_report_partner, comparison.value2!),
                ],
              ),

            const Divider(height: 24, color: Colors.white24),
            Text(comparison.text, style: const TextStyle(height: 1.5, color: Colors.white70)),
          ],
        ),
      ),
    );
  }

  Widget _buildNumberCircle(String label, int number) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.white54)),
        const SizedBox(height: 4),
        CircleAvatar(radius: 24, backgroundColor: Colors.deepPurple, child: Text(number.toString(), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
      ],
    );
  }
}