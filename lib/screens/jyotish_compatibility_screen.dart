// lib/screens/jyotish_compatibility_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lovequest/cubit/app_cubit.dart';
import 'package:lovequest/cubit/app_state.dart';
import 'package:lovequest/l10n/generated/app_localizations.dart'; // <-- Импорт локализации
import 'package:lovequest/repositories/api_repository.dart';
import 'package:lovequest/src/data/models/jyotish_report.dart';
import 'package:lovequest/widgets/common/animated_cosmic_background.dart';

class JyotishCompatibilityScreen extends StatefulWidget {
  final String userId;
  const JyotishCompatibilityScreen({super.key, required this.userId});

  @override
  State<JyotishCompatibilityScreen> createState() => _JyotishCompatibilityScreenState();
}

class _JyotishCompatibilityScreenState extends State<JyotishCompatibilityScreen> {
  Future<JyotishReport>? _reportFuture;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_reportFuture == null) {
      final apiRepository = context.read<ApiRepository>();
      final lang = context.read<AppCubit>().state.locale?.languageCode ?? 'ru';
      setState(() {
        _reportFuture = apiRepository.getJyotishReport(widget.userId, lang);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final descriptions = context.watch<AppCubit>().state.jyotishDescriptions;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AnimatedCosmicBackground(
        child: FutureBuilder<JyotishReport>(
          future: _reportFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError || !snapshot.hasData) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    '${l10n.errorLoadingReport}: ${snapshot.error}', // "Ошибка загрузки..."
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }

            final report = snapshot.data!;
            final verdictText = descriptions[report.verdictKey] ?? l10n.verdictNotFound; // "Вердикт не найден"

            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: Text(l10n.vedicCompatibilityTitle), // "Ведическая совместимость"
                  backgroundColor: Colors.transparent,
                  pinned: true,
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        _buildScoreIndicator(report.score),
                        const SizedBox(height: 24),
                        Text(
                          verdictText,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.amber[200]),
                          textAlign: TextAlign.center,
                        ),
                        const Divider(height: 48),
                        Text(
                          l10n.ashtaKutaAnalysis, // "Детальный анализ (Ашта-Кута)"
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 16),
                        ...report.analysis.map((kuta) => _buildKutaCard(kuta, descriptions, l10n)),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildScoreIndicator(double score) {
    return SizedBox(
      width: 150,
      height: 150,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CircularProgressIndicator(
            value: score / 36.0,
            strokeWidth: 10,
            backgroundColor: Colors.grey.shade700,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.orangeAccent),
          ),
          Center(
            child: Text(
              '${score.toStringAsFixed(1)} / 36',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKutaCard(KutaResult kuta, Map<String, String> descriptions, AppLocalizations l10n) {
    final name = descriptions[kuta.nameKey] ?? kuta.key;
    final description = descriptions[kuta.descriptionKey] ?? l10n.noDescription; // "Описание не найдено."

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: Colors.white.withOpacity(0.1),
      child: ListTile(
        title: Text('$name (${kuta.obtainedPoints} / ${kuta.maxPoints})'),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(description),
        ),
      ),
    );
  }
}