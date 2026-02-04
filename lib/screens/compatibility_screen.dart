// lib/screens/compatibility_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovequest/l10n/generated/app_localizations.dart'; // <-- Импорт локализации

import '../cubit/compatibility_cubit.dart';
import '../repositories/api_repository.dart';

class CompatibilityScreen extends StatelessWidget {
  final String partnerId;

  const CompatibilityScreen({super.key, required this.partnerId});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (context) => CompatibilityCubit(context.read<ApiRepository>())..loadById(partnerId),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(l10n.compatibilityTitle, style: const TextStyle(color: Colors.white)), // "Космическая Связь"
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF2E003E), Color(0xFF000000)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: BlocBuilder<CompatibilityCubit, CompatibilityState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator(color: Colors.pinkAccent));
              }
              if (state.error != null) {
                return Center(child: Text("${l10n.errorTitle}: ${state.error}", style: const TextStyle(color: Colors.white))); // "Ошибка: ..."
              }
              if (state.report == null) {
                return Center(child: Text(l10n.noData, style: const TextStyle(color: Colors.white))); // "Нет данных"
              }

              return _buildReportView(context, state.report!, l10n);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildReportView(BuildContext context, Map<String, dynamic> report, AppLocalizations l10n) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 80),
      children: [
        // 1. Общий балл
        _buildTotalScore(context, report['totalScore'] ?? 0, l10n),

        const SizedBox(height: 30),

        // 2. Карточки по системам
        _buildSystemCard(context, l10n.westernAstrology, report['western'], Icons.star, l10n), // "Западная Астрология"
        _buildSystemCard(context, l10n.vedicAstrology, report['jyotish'], Icons.spa, l10n, isLocked: true), // "Ведическая (Джйотиш)"
        _buildSystemCard(context, l10n.numerology, report['numerology'], Icons.format_list_numbered, l10n), // "Нумерология"
        _buildSystemCard(context, l10n.chineseZodiac, report['chinese'], Icons.pets, l10n), // "Китайский Зодиак"
        _buildSystemCard(context, l10n.baziElements, report['bazi'], Icons.water_drop, l10n, isLocked: true), // "Бацзы (Стихии)"
      ],
    );
  }

  Widget _buildTotalScore(BuildContext context, int score, AppLocalizations l10n) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 150, height: 150,
              child: CircularProgressIndicator(
                value: score / 100,
                strokeWidth: 10,
                color: _getScoreColor(score),
                backgroundColor: Colors.white10,
              ),
            ),
            Text("$score%", style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white)),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          _getScoreVerdict(score, l10n),
          style: TextStyle(color: _getScoreColor(score), fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildSystemCard(BuildContext context, String title, Map<String, dynamic>? data, IconData icon, AppLocalizations l10n, {bool isLocked = false}) {
    return Card(
      color: Colors.white.withOpacity(0.05),
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: Icon(icon, color: Colors.pinkAccent),
        title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        subtitle: isLocked
            ? Text(l10n.availableInPremium, style: const TextStyle(color: Colors.amber)) // "Доступно в Premium"
            : Text(data?['short_text'] ?? l10n.noData, style: const TextStyle(color: Colors.white70), maxLines: 2, overflow: TextOverflow.ellipsis),
        trailing: isLocked
            ? const Icon(Icons.lock, color: Colors.amber)
            : Text("${data?['score'] ?? 0}%", style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        onTap: () {
          // Открыть детальный экран или Paywall
        },
      ),
    );
  }

  Color _getScoreColor(int score) {
    if (score >= 80) return Colors.greenAccent;
    if (score >= 50) return Colors.amberAccent;
    return Colors.redAccent;
  }

  String _getScoreVerdict(int score, AppLocalizations l10n) {
    if (score >= 90) return l10n.verdictSoulmates; // "Родственные Души"
    if (score >= 70) return l10n.verdictGreatMatch; // "Отличная Пара"
    if (score >= 50) return l10n.verdictPotential; // "Есть Потенциал"
    return l10n.verdictKarmic; // "Кармический Урок"
  }
}