// lib/screens/bazi_compatibility_screen.dart


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lovequest/repositories/api_repository.dart';
import 'package:lovequest/src/data/models/bazi_report.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'package:lovequest/l10n/generated/app_localizations.dart';

import '../l10n/generated/app_localizations.dart';

class BaziCompatibilityScreen extends StatefulWidget {
  final String partnerId;
  const BaziCompatibilityScreen({super.key, required this.partnerId});

  @override
  State<BaziCompatibilityScreen> createState() => _BaziCompatibilityScreenState();
}

class _BaziCompatibilityScreenState extends State<BaziCompatibilityScreen> {
  Future<BaziReport>? _reportFuture;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_reportFuture == null) {
      final apiRepository = context.read<ApiRepository>();
      final lang = Localizations.localeOf(context).languageCode;
      setState(() {
        _reportFuture = apiRepository.getBaziReport(widget.partnerId, lang);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text("Совместимость по Бацзы"), // TODO: Перевести
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: FutureBuilder<BaziReport>(
        future: _reportFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Ошибка загрузки отчета: ${snapshot.error}"));
          }
          if (!snapshot.hasData) {
            return const Center(child: Text("Не удалось получить данные."));
          }

          final report = snapshot.data!;

          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              _buildOverallScore(context, report.score, report.verdict),
              const SizedBox(height: 24),
              Text("Детальный анализ:", style: Theme.of(context).textTheme.titleLarge), // TODO: Перевести
              const SizedBox(height: 16),
              ...report.detailedAnalysis.map((item) => _buildAnalysisItem(item)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildOverallScore(BuildContext context, int score, String verdict) {
    final scoreColor = Color.lerp(Colors.redAccent, Colors.greenAccent, score / 100)!;
    return Card(
      color: Colors.white.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Text("Общая совместимость", style: Theme.of(context).textTheme.titleLarge, textAlign: TextAlign.center), // TODO: Перевести
            const SizedBox(height: 24),
            CircularPercentIndicator(
              radius: 60.0,
              lineWidth: 12.0,
              percent: score / 100,
              center: Text("$score%", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              progressColor: scoreColor,
              backgroundColor: Colors.grey.shade800,
              circularStrokeCap: CircularStrokeCap.round,
            ),
            const SizedBox(height: 16),
            Text(verdict, textAlign: TextAlign.center, style: TextStyle(color: scoreColor, fontWeight: FontWeight.bold, fontSize: 16)),
          ],
        ),
      ),
    );
  }

  Widget _buildAnalysisItem(BaziAnalysisItem item) {
    final impactColor = item.impact > 0 ? Colors.greenAccent.withOpacity(0.7) : item.impact < 0 ? Colors.redAccent.withOpacity(0.7) : Colors.grey;
    final icon = item.impact > 10 ? Icons.favorite : item.impact > 0 ? Icons.add_circle_outline : item.impact < -10 ? Icons.heart_broken_outlined : item.impact < 0 ? Icons.remove_circle_outline : Icons.circle_outlined;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: Colors.white.withOpacity(0.05),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: impactColor, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Text(item.text, style: TextStyle(height: 1.5, color: Colors.white.withOpacity(0.9))),
            ),
          ],
        ),
      ),
    );
  }
}