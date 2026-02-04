// lib/screens/chinese_zodiac_compatibility_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovequest/l10n/generated/app_localizations.dart';

import 'package:lovequest/repositories/api_repository.dart';
import 'package:lovequest/src/data/models/chinese_zodiac_report.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ChineseZodiacCompatibilityScreen extends StatefulWidget {
  final String partnerId;
  const ChineseZodiacCompatibilityScreen({super.key, required this.partnerId});

  @override
  State<ChineseZodiacCompatibilityScreen> createState() => _ChineseZodiacCompatibilityScreenState();
}

class _ChineseZodiacCompatibilityScreenState extends State<ChineseZodiacCompatibilityScreen> {
  Future<ChineseZodiacReport>? _reportFuture;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_reportFuture == null) {
      final apiRepository = context.read<ApiRepository>();
      final lang = AppLocalizations.of(context)!.localeName;
      setState(() {
        _reportFuture = apiRepository.getChineseZodiacReport(widget.partnerId, lang);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(l10n.chinese_zodiac_compatibility_button),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2D0101), Color(0xFF1E1E2A)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: FutureBuilder<ChineseZodiacReport>(
          future: _reportFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError || !snapshot.hasData) {
              return Center(child: Text("${l10n.errorLoadingReport}: ${snapshot.error}")); // "Ошибка загрузки отчета"
            }

            final report = snapshot.data!;
            return _buildReportContent(context, report, l10n);
          },
        ),
      ),
    );
  }

  Widget _buildReportContent(BuildContext context, ChineseZodiacReport report, AppLocalizations l10n) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _ZodiacAnimal(sign: report.mySign, label: l10n.numerology_report_you),
              _CompatibilityScore(score: report.score, l10n: l10n),
              _ZodiacAnimal(sign: report.theirSign, label: l10n.numerology_report_partner),
            ],
          ),
          const SizedBox(height: 32),
          Text(report.title, textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.amber[200])),
          const SizedBox(height: 16),
          Text(report.description, textAlign: TextAlign.center, style: TextStyle(color: Colors.white.withOpacity(0.8), height: 1.5)),
          const SizedBox(height: 32),
          _StrengthsWeaknesses(title: l10n.strengths, items: report.pros, color: Colors.greenAccent), // "Сильные стороны"
          const SizedBox(height: 24),
          _StrengthsWeaknesses(title: l10n.weaknesses, items: report.cons, color: Colors.redAccent), // "Возможные трудности"
        ],
      ),
    );
  }
}

class _ZodiacAnimal extends StatelessWidget {
  final String sign;
  final String label;
  const _ZodiacAnimal({required this.sign, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('assets/images/zodiac/$sign.png', height: 80, width: 80, errorBuilder: (_,__,___) => const SizedBox(height: 80, width: 80)),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.white70)),
      ],
    );
  }
}

class _CompatibilityScore extends StatelessWidget {
  final int score;
  final AppLocalizations l10n; // <-- Передаем локализацию
  const _CompatibilityScore({required this.score, required this.l10n});

  @override
  Widget build(BuildContext context) {
    final scoreColor = Color.lerp(Colors.red.shade900, Colors.greenAccent.shade700, score / 100)!;
    return CircularPercentIndicator(
      radius: 50.0,
      lineWidth: 8.0,
      percent: score / 100,
      center: Text("$score%", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
      progressColor: scoreColor,
      backgroundColor: Colors.black26,
      circularStrokeCap: CircularStrokeCap.round,
      header: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(l10n.compatibility, style: const TextStyle(color: Colors.amber)), // "Совместимость"
      ),
    );
  }
}

class _StrengthsWeaknesses extends StatelessWidget {
  final String title;
  final List<String> items;
  final Color color;
  const _StrengthsWeaknesses({required this.title, required this.items, required this.color});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(color: color)),
        const SizedBox(height: 8),
        ...items.map((item) => Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: Row(
            children: [
              Icon(Icons.check_circle_outline, size: 16, color: color.withOpacity(0.7)),
              const SizedBox(width: 8),
              Expanded(child: Text(item)),
            ],
          ),
        )),
      ],
    );
  }
}