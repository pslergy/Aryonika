// lib/screens/manual_compatibility_screen.dart

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:lovequest/cubit/app_cubit.dart';
import 'package:lovequest/cubit/manual_comp_cubit.dart';
import 'package:lovequest/cubit/manual_comp_state.dart';
import 'package:lovequest/src/data/models/nominatim_suggestion.dart';
import 'package:lovequest/widgets/common/animated_cosmic_background.dart';

import 'package:lovequest/widgets/compatibility/compatibility_share_card.dart';

import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../l10n/generated/app_localizations.dart';
import '../services/logger_service.dart';
import '../src/data/models/astrology/compatibility_report.dart';
import '../src/data/models/numerology_report.dart';
import '../widgets/common/compatibility_score_widget.dart';
import '../widgets/common/detailed_aspect_card.dart';

// 1. Провайдер для создания Cubit'а
class ManualCompatibilityScreenProvider extends StatelessWidget {
  const ManualCompatibilityScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final appCubit = context.read<AppCubit>();

    if (appCubit.state.currentUserProfile?.natalChart == null) {
      return Scaffold(
        body: Center(child: Text(l10n.errorNatalChartMissing)), // "Ошибка: ваша натальная карта не рассчитана."
      );
    }
    return BlocProvider(
      create: (_) => ManualCompCubit(appCubit),
      child: const ManualCompatibilityScreen(),
    );
  }
}

class ManualCompatibilityScreen extends StatelessWidget {
  const ManualCompatibilityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(l10n.manualCheckTitle), // "Ручная проверка"
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          BlocBuilder<ManualCompCubit, ManualCompState>(
            builder: (context, state) {
              if (state.report != null) {
                return IconButton(
                  icon: const Icon(Icons.refresh),
                  tooltip: l10n.checkAgainTooltip, // "Проверить еще раз"
                  onPressed: () => context.read<ManualCompCubit>().reset(),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: AnimatedCosmicBackground(
        child: BlocConsumer<ManualCompCubit, ManualCompState>(
          listenWhen: (p, c) => p.status != c.status && c.status == ManualCompStatus.error,
          listener: (context, state) {
            if (state.errorMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage!), backgroundColor: Colors.redAccent),
              );
            }
          },
          builder: (context, state) {
            if (state.status == ManualCompStatus.success && state.report != null) {
              return _ReportView(state: state);
            }
            return _FormView(state: state);
          },
        ),
      ),
    );
  }
}

class _FormView extends StatelessWidget {
  final ManualCompState state;
  const _FormView({required this.state});

  void _showLocationSearchDialog(BuildContext context) {
    final cubit = context.read<ManualCompCubit>();
    showDialog(
      context: context,
      builder: (dialogContext) {
        return BlocProvider.value(
          value: cubit,
          child: const _LocationSearchDialog(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cubit = context.read<ManualCompCubit>();

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Icon(Icons.people_alt_outlined, size: 64, color: Colors.white38),
          const SizedBox(height: 16),
          Text(
            l10n.synastryTitle, // "Синастрия Партнеров"
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.synastryDesc, // "Введите данные рождения человека..."
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, color: Colors.white70),
          ),
          const SizedBox(height: 32),
          TextField(
            onChanged: cubit.onNameChanged,
            decoration: InputDecoration(labelText: l10n.partnerNameLabel), // "Имя партнера"
            textCapitalization: TextCapitalization.words,
          ),
          const SizedBox(height: 16),
          _buildPickerTile(
            context: context,
            icon: Icons.calendar_today_outlined,
            title: l10n.birthDateLabel, // "Дата рождения"
            value: state.partnerBirthDate != null
                ? DateFormat('d MMMM yyyy', Localizations.localeOf(context).languageCode).format(state.partnerBirthDate!)
                : l10n.tapToSelect, // "Нажмите, чтобы выбрать"
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: state.partnerBirthDate ?? DateTime(2000),
                firstDate: DateTime(1930),
                lastDate: DateTime.now(),
              );
              if (date != null) cubit.onBirthDateChanged(date);
            },
          ),
          const SizedBox(height: 16),
          _buildPickerTile(
            context: context,
            icon: Icons.access_time_outlined,
            title: l10n.birthTimeLabel, // "Время рождения"
            value: state.partnerBirthTime.format(context),
            onTap: () async {
              final time = await showTimePicker(
                context: context,
                initialTime: state.partnerBirthTime,
              );
              if (time != null) cubit.onBirthTimeChanged(time);
            },
          ),
          const SizedBox(height: 16),
          _buildPickerTile(
            context: context,
            icon: Icons.location_city_outlined,
            title: l10n.birthPlaceLabel, // "Место рождения"
            value: state.partnerLocation?.displayName ?? l10n.tapToSelect,
            onTap: () => _showLocationSearchDialog(context),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: Colors.pinkAccent,
              disabledBackgroundColor: Colors.grey.withOpacity(0.3),
            ),
            onPressed: state.isFormValid && state.status != ManualCompStatus.calculating
                ? () => cubit.calculateCompatibility()
                : null,
            child: state.status == ManualCompStatus.calculating
                ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                : Text(l10n.calculateButton, style: const TextStyle(fontSize: 16, color: Colors.white)), // "Рассчитать"
          ),
        ],
      ),
    );
  }

  // _buildPickerTile без изменений
  Widget _buildPickerTile({required BuildContext context, required IconData icon, required String title, required String value, required VoidCallback onTap}) {
    return Material(
      color: Colors.white.withOpacity(0.1),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Row(
            children: [
              Icon(icon, color: Colors.white70),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(color: Colors.white70)),
                    const SizedBox(height: 4),
                    Text(value, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500), overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
              const Icon(Icons.arrow_drop_down, color: Colors.white54),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReportView extends StatefulWidget {
  final ManualCompState state;
  const _ReportView({required this.state});

  @override
  State<_ReportView> createState() => _ReportViewState();
}

class _ReportViewState extends State<_ReportView> with SingleTickerProviderStateMixin {
  final _screenshotController = ScreenshotController();
  late TabController _tabController;
  bool _isSharing = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _shareReport() async {
    // Оставляем логику скриншота как есть
    if (_isSharing) return;
    setState(() { _isSharing = true; });

    try {
      final imageBytes = await _screenshotController.capture(
        delay: const Duration(milliseconds: 20),
        pixelRatio: 2.0,
      );

      if (imageBytes != null) {
        final directory = await getTemporaryDirectory();
        final imagePath = await File('${directory.path}/Aryonika_report.png').create();
        await imagePath.writeAsBytes(imageBytes);

        // Используем l10n для текста шаринга
        // ignore: use_build_context_synchronously
        final l10n = AppLocalizations.of(context)!;
        await Share.shareXFiles(
          [XFile(imagePath.path)],
          text: l10n.shareText(widget.state.partnerName, widget.state.report!.totalScore.toString()), // "Наша совместимость..."
        );
      }
    } catch (e) {
      if(mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Error creating image")));
    } finally {
      if (mounted) setState(() { _isSharing = false; });
    }
  }

  String _getVerdict(int score, AppLocalizations l10n) {
    if (score >= 90) return l10n.verdictSoulmates;
    if (score >= 70) return l10n.verdictGreatMatch;
    if (score >= 50) return l10n.verdictPotential;
    return l10n.verdictKarmic;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final myName = context.read<AppCubit>().state.currentUserProfile?.name ?? l10n.you; // "Вы"
    final isPro = context.read<AppCubit>().state.isProUser;
    final report = widget.state.report!;
    final astroScore = report.totalScore;

    return Stack(
      children: [
        Transform.translate(
          offset: Offset(MediaQuery.of(context).size.width, 0),
          child: Screenshot(
            controller: _screenshotController,
            child: CompatibilityShareCard(
                myName: myName,
                partnerName: widget.state.partnerName,
                score: astroScore,
                verdict: _getVerdict(astroScore, l10n)
            ),
          ),
        ),

        SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      "$myName & ${widget.state.partnerName}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: TabBar(
                        controller: _tabController,
                        indicator: BoxDecoration(
                          color: Colors.pinkAccent,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.white60,
                        isScrollable: true,
                        labelPadding: const EdgeInsets.symmetric(horizontal: 20),
                        tabs: [
                          Tab(text: l10n.tab_summary),
                          Tab(text: l10n.tab_astrology),
                          Tab(text: l10n.tab_numerology),
                          Tab(text: l10n.tab_bazi),
                          Tab(text: l10n.tab_jyotish),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildSummaryTab(context, report, l10n),
                    _buildAstroTab(context, report),
                    isPro ? _buildNumerologyTab(context, report, l10n) : _buildLockedTab(context, l10n.tab_numerology, l10n),
                    _buildComingSoonTab(context, l10n.tab_bazi, l10n),
                    _buildComingSoonTab(context, l10n.tab_jyotish, l10n),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton.icon(
                  icon: _isSharing
                      ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                      : const Icon(Icons.share_outlined),
                  label: Text(_isSharing ? l10n.share_preparing : l10n.share_result),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.pinkAccent,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: _isSharing ? null : _shareReport,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryTab(BuildContext context, CompatibilityReport report, AppLocalizations l10n) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          color: Colors.white.withOpacity(0.1),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Text(l10n.summary_verdict_title, style: const TextStyle(color: Colors.white54, fontSize: 14)),
                const SizedBox(height: 8),
                Text(_getVerdict(report.totalScore, l10n),
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.pinkAccent, fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                Text(
                  l10n.summary_desc(report.totalScore.toString(), report.totalScore > 70 ? l10n.strongConnection : l10n.interestingLessons),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white70, height: 1.5),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),

        // 2. Сводка по системам (Мини-карточки)
        _buildSystemRow(l10n.tab_astrology, report.totalScore, Icons.auto_awesome),
        const SizedBox(height: 12),
        _buildSystemRow(l10n.tab_numerology, report.numerologyReport?.totalScore ?? 0, Icons.looks_one, isPro: true),
        const SizedBox(height: 12),
        // Китайский зодиак (Заглушка пока нет расчета)
        _buildSystemRow(l10n.tab_chinese_zodiac, 85, Icons.pets, subtitle: "Год Дракона + Год Обезьяны"),
        const SizedBox(height: 12),
        _buildSystemRow(l10n.tab_bazi, 0, Icons.water_drop, isComingSoon: true),
        const SizedBox(height: 12),
        _buildSystemRow(l10n.tab_jyotish, 0, Icons.spa, isComingSoon: true),
      ],
    );
  }

  Widget _buildSystemRow(String title, int score, IconData icon, {bool isPro = false, bool isComingSoon = false, String? subtitle}) {
    // Логика цвета
    Color scoreColor = Colors.greenAccent;
    if (score < 50) scoreColor = Colors.redAccent;
    else if (score < 75) scoreColor = Colors.orangeAccent;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white70),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                if (subtitle != null) Text(subtitle, style: const TextStyle(color: Colors.white38, fontSize: 12)),
              ],
            ),
          ),
          if (isComingSoon)
            const Text("Скоро", style: TextStyle(color: Colors.white30, fontSize: 12))
          else
            Text("$score%", style: TextStyle(color: scoreColor, fontWeight: FontWeight.bold, fontSize: 18)),
        ],
      ),
    );
  }

  // Виджет "В разработке"
  Widget _buildComingSoonTab(BuildContext context, String title, AppLocalizations l10n) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.construction, size: 80, color: Colors.white24),
          const SizedBox(height: 24),
          Text("$title ${l10n.coming_soon_suffix}", style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(l10n.feature_in_development, style: const TextStyle(color: Colors.white54)),
        ],
      ),
    );
  }

  // Виджет "Замок" (для Нумерологии)
  Widget _buildLockedTab(BuildContext context, String title, AppLocalizations l10n) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.lock_outline, size: 80, color: Colors.amber),
            const SizedBox(height: 24),
            Text(textAlign: TextAlign.center, l10n.locked_feature_title(title), style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Text(l10n.locked_feature_desc, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white70)),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => context.push('/paywall'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black, padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16)),
              child: Text(l10n.get_access_button),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAstroTab(BuildContext context, CompatibilityReport report) {
    final descriptions = context.read<AppCubit>().state.compatibilityDescriptions;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        CompatibilityScoreWidget(totalScore: report.totalScore),
        const SizedBox(height: 24),
        Text(
          descriptions['astro_overall_summary']?.replaceAll('{score}', report.totalScore.toString()) ??
              'Звезды говорят о вашей связи...',
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white70, fontSize: 15, height: 1.5),
        ),
        const SizedBox(height: 24),
        ...report.details.map((detail) {
          final title = descriptions[detail.titleKey] ?? detail.titleKey;
          return DetailedAspectCard(
            title: title,
            description: detail.description,
            score: detail.score,
            isPro: detail.isProFeature,
          );
        }),
      ],
    );
  }

  Widget _buildNumerologyTab(BuildContext context, CompatibilityReport report, AppLocalizations l10n) {
    if (report.numerologyReport == null) {
      return const Center(child: Text("Данные нумерологии недоступны", style: TextStyle(color: Colors.white54)));
    }

    final numRep = report.numerologyReport!;
    final l10n = AppLocalizations.of(context)!;

    // Получаем словарь совместимости из AppCubit
    final descriptions = context.read<AppCubit>().state.numerologyCompatibility;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Общий балл
        Center(child: CompatibilityScoreWidget(totalScore: numRep.totalScore)),
        const SizedBox(height: 24),

        // Общий текст
        Text(
          numRep.shortText,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white70, fontSize: 16),
        ),
        const SizedBox(height: 24),

        // Карточки аспектов
        ...numRep.comparisons.map((comp) {
          String text = comp.text;

          // Если текста нет, ищем в словаре по числам
          if ((text == "Описание отсутствует" || text.isEmpty) && comp.value1 != null && comp.value2 != null) {
            int v1 = comp.value1!;
            int v2 = comp.value2!;

            // --- РЕДУКЦИЯ ЧИСЕЛ ---
            // Сворачиваем числа > 9 до однозначных (кроме 11 и 22)
            // Пример: 19 -> 10 -> 1.  25 -> 7.
            while (v1 > 9 && v1 != 11 && v1 != 22) {
              v1 = v1.toString().split('').map(int.parse).reduce((a, b) => a + b);
            }
            while (v2 > 9 && v2 != 11 && v2 != 22) {
              v2 = v2.toString().split('').map(int.parse).reduce((a, b) => a + b);
            }
            // ---------------------

            // Формируем ключ: меньшее_большее (1_3)
            final key = (v1 < v2) ? "${v1}_${v2}" : "${v2}_${v1}";

            if (descriptions.containsKey(key)) {
              text = descriptions[key]!;
            }
          }

          // Рисуем карточку
          return _buildComparisonCard(
              comp.copyWith(text: text), // Обновляем текст в модели для отображения
              l10n
          );
        }),
      ],
    );
  }

  Widget _buildComparisonCard(NumerologyComparison comparison, AppLocalizations l10n) {
    Color borderColor;
    switch (comparison.harmony) {
      case 'high': borderColor = Colors.greenAccent; break;
      case 'challenging': // Fallthrough
      case 'low': // У сервера 'low', у тебя 'challenging' - обрабатываем оба
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
            // Убираем tooltip, если его нет в модели
            Row(
              children: [
                Text(comparison.type, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                // const SizedBox(width: 4),
                // const Icon(Icons.info_outline, size: 16, color: Colors.white54),
              ],
            ),
            const SizedBox(height: 8),

            // --- 👇 ИСПРАВЛЕНИЕ: ИСПОЛЬЗУЕМ value1/value2 👇 ---
            if (comparison.value1 != null && comparison.value2 != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNumberCircle(l10n.numerology_report_you, comparison.value1!), // <-- value1
                  Icon(Icons.sync_alt_rounded, color: borderColor, size: 28),
                  _buildNumberCircle(l10n.numerology_report_partner, comparison.value2!), // <-- value2
                ],
              ),
            // --- 👆 -------------------------------------------

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

  String _getVerdict(int score) {
    if (score >= 90) return "Родственные души";
    if (score >= 70) return "Идеальная пара";
    if (score >= 50) return "Есть потенциал";
    return "Кармический урок";
  }



// --- Диалоговое окно для поиска локации ---
class _LocationSearchDialog extends StatefulWidget {
  const _LocationSearchDialog();

  @override
  State<_LocationSearchDialog> createState() => __LocationSearchDialogState();
}

class __LocationSearchDialogState extends State<_LocationSearchDialog> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ManualCompCubit>();
    return AlertDialog(
      title: const Text("Поиск города"),
      content: SizedBox(
        width: double.maxFinite,
        height: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _searchController,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: "Начните вводить город...",
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: cubit.searchLocations,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<ManualCompCubit, ManualCompState>(
                builder: (context, state) {
                  if (state.status == ManualCompStatus.loadingLocations) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state.locationSuggestions.isEmpty && _searchController.text.length >= 2) {
                    return const Center(child: Text("Ничего не найдено."));
                  }
                  return ListView.builder(
                    itemCount: state.locationSuggestions.length,
                    itemBuilder: (context, index) {
                      final suggestion = state.locationSuggestions[index];
                      return ListTile(
                        title: Text(suggestion.displayName),
                        subtitle: Text(suggestion.address?.country ?? ''),
                        onTap: () {
                          cubit.onLocationSelected(suggestion);
                          Navigator.of(context).pop();
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Закрыть"),
        ),
      ],
    );
  }
}