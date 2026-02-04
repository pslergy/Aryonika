// lib/screens/numerology_screen.dart

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lovequest/l10n/generated/app_localizations.dart'; // <-- Импорт локализации

import '../cubit/app_cubit.dart';
import '../cubit/app_state.dart';
import '../cubit/numerology_cubit.dart';
import '../cubit/numerology_state.dart';
import '../src/data/models/numerology_report.dart';

class NumerologyScreen extends StatefulWidget {
  final String partnerId;

  const NumerologyScreen({Key? key, required this.partnerId}) : super(key: key);

  @override
  State<NumerologyScreen> createState() => _NumerologyScreenState();
}

class _NumerologyScreenState extends State<NumerologyScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _loadData();
      }
    });
  }

  Future<void> _loadData() async {
    context.read<NumerologyCubit>().loadPersonalReport(widget.partnerId);
    final appCubit = context.read<AppCubit>();
    await appCubit.loadNumerologyNumberDescriptions(forceReload: true);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(l10n.personalNumerologyTitle, style: const TextStyle(color: Colors.white)), // "Личная Нумерология"
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF1A0B2E), Color(0xFF2D1B4E), Color(0xFF000000)],
              ),
            ),
          ),

          BlocBuilder<AppCubit, AppState>(
            builder: (context, appState) {
              final descriptions = appState.numerologyNumberDescriptions;
              final isPro = appState.currentUserProfile?.isProUser ?? false;

              return BlocBuilder<NumerologyCubit, NumerologyState>(
                builder: (context, numState) {
                  if (numState.status == NumerologyStatus.loading) {
                    return const Center(child: CircularProgressIndicator(color: Colors.amber));
                  }

                  final report = numState.personalReport;
                  if (report == null) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(l10n.dataNotLoaded, style: const TextStyle(color: Colors.white54)), // "Данные не загружены"
                          const SizedBox(height: 16),
                          TextButton(
                            onPressed: _loadData,
                            child: Text(l10n.tryAgain, style: const TextStyle(color: Colors.amber)), // "Повторить"
                          )
                        ],
                      ),
                    );
                  }

                  String getDesc(NumerologyDetail detail) {
                    if (descriptions.isEmpty) return l10n.loading; // "Загрузка..."

                    if (descriptions.containsKey(detail.descriptionKey)) return descriptions[detail.descriptionKey]!;

                    String type = detail.descriptionKey.split('_')[0];

                    Map<String, String> keyMapping = {
                      'lifePath': 'life_path',
                      'destiny': 'destiny',
                      'expression': 'destiny',
                      'soulUrge': 'soul_urge',
                      'personality': 'personality',
                      'maturity': 'maturity',
                      'birthday': 'birthday',
                      'personalYear': 'personal_year',
                      'personalMonth': 'personal_month',
                      'personalDay': 'personal_day',
                    };

                    String prefix = keyMapping[type] ?? type;

                    int num = detail.number;
                    while (num > 9 && num != 11 && num != 22 && num != 33) {
                      num = num.toString().split('').map(int.parse).reduce((a, b) => a + b);
                    }

                    final finalKey = '${prefix}_$num';

                    if (descriptions.containsKey(finalKey)) {
                      return descriptions[finalKey]!;
                    }

                    return l10n.noDescription; // "Описание отсутствует"
                  }

                  return RefreshIndicator(
                    color: Colors.amber,
                    backgroundColor: const Color(0xFF1E1E2C),
                    onRefresh: _loadData,
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(16, 100, 16, 30),
                      children: [
                        _HeroCard(
                          title: l10n.lifePathNumber, // "Число Жизненного Пути"
                          number: report.lifePath.number,
                          description: getDesc(report.lifePath),
                          icon: Icons.auto_awesome,
                          color: Colors.amber,
                        ),

                        const SizedBox(height: 24),
                        _SectionHeader(title: l10n.corePersonality), // "Ядро Личности"
                        const SizedBox(height: 12),

                        _InfoCard(title: l10n.destinyNumber, number: report.destiny.number, description: getDesc(report.destiny), icon: Icons.psychology), // "Число Судьбы"
                        _InfoCard(title: l10n.soulNumber, number: report.soulUrge.number, description: getDesc(report.soulUrge), icon: Icons.favorite, accentColor: Colors.pinkAccent), // "Число Души"
                        _InfoCard(title: l10n.personalityNumber, number: report.personality.number, description: getDesc(report.personality), icon: Icons.face), // "Число Личности"

                        const SizedBox(height: 24),
                        _SectionHeader(title: l10n.timeInfluence), // "Влияние Времени"
                        const SizedBox(height: 12),

                        _InfoCard(title: l10n.maturityNumber, number: report.maturity.number, description: getDesc(report.maturity), icon: Icons.hourglass_bottom), // "Число Зрелости"
                        _InfoCard(title: l10n.birthdayNumber, number: report.birthday.number, description: getDesc(report.birthday), icon: Icons.cake), // "День Рождения"

                        const SizedBox(height: 24),
                        _SectionHeader(title: l10n.currentVibrationsPro), // "Текущие Вибрации (PRO)"
                        const SizedBox(height: 12),

                        if (isPro) ...[
                          Row(
                            children: [
                              Expanded(child: _MiniCard(title: l10n.personalYear, number: report.personalYear.number, description: getDesc(report.personalYear), l10n: l10n)), // "Личный Год"
                              const SizedBox(width: 12),
                              Expanded(child: _MiniCard(title: l10n.personalMonth, number: report.personalMonth.number, description: getDesc(report.personalMonth), l10n: l10n)), // "Личный Месяц"
                            ],
                          ),
                          const SizedBox(height: 12),
                          _InfoCard(title: l10n.personalDay, number: report.personalDay.number, description: getDesc(report.personalDay), icon: Icons.today, accentColor: Colors.lightBlueAccent), // "Личный День"
                        ] else ...[
                          _LockedContent(
                            onUnlockTap: () {
                              context.push('/paywall');
                            },
                            l10n: l10n,
                          ),
                        ],

                        const SizedBox(height: 50),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class _LockedContent extends StatelessWidget {
  final VoidCallback onUnlockTap;
  final AppLocalizations l10n; // <-- Передаем локализацию

  const _LockedContent({required this.onUnlockTap, required this.l10n});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.amber.withOpacity(0.3)),
          ),
          child: Column(
            children: [
              const Icon(Icons.lock_outline, color: Colors.amber, size: 48),
              const SizedBox(height: 16),
              Text(
                l10n.personalForecastTitle, // Используем существующий ключ
                style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.proVibrationsDesc, // "Узнайте свои вибрации на Год..."
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: onUnlockTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: Text(l10n.unlockButton, style: const TextStyle(fontWeight: FontWeight.bold)), // "Разблокировать"
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 4, height: 18, color: Colors.purpleAccent, margin: const EdgeInsets.only(right: 8)),
        Text(
          title.toUpperCase(),
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }
}

class _HeroCard extends StatelessWidget {
  final String title;
  final int number;
  final String description;
  final IconData icon;
  final Color color;

  const _HeroCard({
    required this.title,
    required this.number,
    required this.description,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF4A148C).withOpacity(0.8),
            const Color(0xFF311B92).withOpacity(0.6),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.15)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.4), blurRadius: 15, offset: const Offset(0, 5)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, color: color, size: 32),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: color.withOpacity(0.5)),
                  ),
                  child: Text(
                    number.toString(),
                    style: TextStyle(
                      color: color,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'serif',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: const TextStyle(color: Colors.white70, fontSize: 16, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final int number;
  final String description;
  final IconData icon;
  final Color accentColor;

  const _InfoCard({
    required this.title,
    required this.number,
    required this.description,
    required this.icon,
    this.accentColor = Colors.purpleAccent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2C).withOpacity(0.7),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          collapsedIconColor: Colors.white54,
          iconColor: accentColor,
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: accentColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: accentColor, size: 20),
          ),
          title: Text(
            title,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                number.toString(),
                style: TextStyle(
                  color: accentColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 12),
              const Icon(Icons.keyboard_arrow_down, color: Colors.white24),
            ],
          ),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
              child: Text(
                description,
                style: const TextStyle(color: Colors.white70, fontSize: 15, height: 1.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MiniCard extends StatelessWidget {
  final String title;
  final int number;
  final String description;
  final AppLocalizations l10n; // <-- Передаем локализацию

  const _MiniCard({
    required this.title,
    required this.number,
    required this.description,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              backgroundColor: const Color(0xFF1E1E2C),
              title: Text(title, style: const TextStyle(color: Colors.white)),
              content: SingleChildScrollView(
                child: Text(description, style: const TextStyle(color: Colors.white70, height: 1.5)),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: Text(l10n.close, style: const TextStyle(color: Colors.amber)), // "Закрыть"
                )
              ],
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                number.toString(),
                style: const TextStyle(color: Colors.tealAccent, fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
              const SizedBox(height: 4),
              Text(
                l10n.tapForDetails, // "Нажмите подробнее"
                style: const TextStyle(color: Colors.white24, fontSize: 10),
              ),
            ],
          ),
        ),
      ),
    );
  }
}