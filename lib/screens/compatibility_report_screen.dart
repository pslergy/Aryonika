// lib/screens/compatibility_report_screen.dart
import 'dart:typed_data';
import 'dart:io';


import 'dart:ui';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lovequest/cubit/app_cubit.dart';
import 'package:lovequest/cubit/app_state.dart';
import 'package:lovequest/l10n/generated/app_localizations.dart';

import 'package:lovequest/services/numerology_calculator.dart';
import 'package:lovequest/src/data/models/astrology/compatibility_report.dart';
import 'package:lovequest/src/data/models/user_profile_card.dart';
import 'package:lovequest/widgets/common/animated_cosmic_background.dart';
import 'package:lovequest/widgets/common/user_avatar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';


import '../services/logger_service.dart';
import '../src/data/models/numerology_report.dart';
// <-- ИМПОРТИРУЕМ НАШ НОВЫЙ ВИДЖЕТ

// Иконки для знаков зодиака (можно вынести в отдельный файл)
const Map<String, String> zodiacIcons = {
  "Aries": "♈", "Taurus": "♉", "Gemini": "♊", "Cancer": "♋",
  "Leo": "♌", "Virgo": "♍", "Libra": "♎", "Scorpio": "♏",
  "Sagittarius": "♐", "Capricorn": "♑", "Aquarius": "♒", "Pisces": "♓"
};

class CompatibilityReportScreen extends StatefulWidget {
  final String partnerId;

  const CompatibilityReportScreen({super.key, required this.partnerId});

  @override
  State<CompatibilityReportScreen> createState() => _CompatibilityReportScreenState();
}

class _CompatibilityReportScreenState extends State<CompatibilityReportScreen> {
  CompatibilityReport? _report;
  bool _isLoading = true;


  @override
  void initState() {
    super.initState();
    _calculateReport();
  }

  Future<void> _calculateReport() async {
    final report = await context.read<AppCubit>().calculateCompatibility(widget.partnerId);
    if (mounted) {
      setState(() {
        _report = report;
        _isLoading = false;
      });
    }
  }

  // ПРАВИЛЬНАЯ, ПОЛНОСТЬЮ РАБОЧАЯ ФУНКЦИЯ
  Future<void> _onSharePressed(

      BuildContext buttonContext, // <-- 1. Принимаем контекст кнопки
      UserProfileCard myProfile,
      UserProfileCard partnerProfile,
      CompatibilityReport report,
      ) async {
    final l10n = AppLocalizations.of(context)!;
    final GlobalKey shareCardKey = GlobalKey();

    // 2. ИСПОЛЬЗУЕМ `context` из State, а не `buttonContext`
    final overlayState = Overlay.of(context);
    late OverlayEntry overlayEntry;

    final Widget cardToRender = RepaintBoundary(
      key: shareCardKey,
      child: CompatibilityShareCard(
        l10n: l10n,
        myProfile: myProfile,
        partnerProfile: partnerProfile,
        report: report,
      ),
    );

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: -1000,
        left: 0,
        child: cardToRender,
      ),
    );
    overlayState.insert(overlayEntry);

    try {
      await WidgetsBinding.instance.endOfFrame;

      final boundary = shareCardKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) throw Exception("Не удалось найти виджет для создания изображения.");

      final image = await boundary.toImage(pixelRatio: 2.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) throw Exception("Не удалось конвертировать изображение в байты.");

      final Uint8List imageBytes = byteData.buffer.asUint8List();


      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/compatibility.png').create();
      await file.writeAsBytes(imageBytes);

      // 3. ИСПОЛЬЗУЕМ `buttonContext`, который мы передали
      final box = buttonContext.findRenderObject() as RenderBox?;
      if (box == null) return; // Добавим проверку на всякий случай

      await Share.shareXFiles(
        [XFile(file.path)],
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
        // ИСПРАВЛЕНИЕ: Передаем 2 аргумента: имя и очки
        text: l10n.shareText(partnerProfile.name, report.totalScore.toString()),
      );

    } catch (e) {
      logger.d("Ошибка при создании и отправке изображения: $e");
      // 4. ИСПОЛЬЗУЕМ `context` из State для ScaffoldMessenger
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.shareErrorSnackbar)));
      }
    } finally {
      overlayEntry.remove();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!; // Получаем l10n один раз
    // Главный Scaffold.
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(l10n.cosmicConnectionTitle),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          BlocBuilder<AppCubit, AppState>(
            builder: (context, state) { // <-- `context` из этого builder'а нам и нужен
              final canShare = !_isLoading &&
                  _report != null &&
                  state.currentUserProfile != null &&
                  state.viewedProfilesCache[widget.partnerId] != null;
              return IconButton(
                icon: const Icon(Icons.share_outlined),
                onPressed: canShare
                    ? () {
                  // Мы используем `context` из этого BlocBuilder'а, он указывает на IconButton
                  _onSharePressed(
                    context, // <-- Передаем BuildContext кнопки
                    state.currentUserProfile!,
                    state.viewedProfilesCache[widget.partnerId]!,
                    _report!,
                  );
                }
                    : null,
              );
            },
          ),
        ],
      ),
      // ===== ГЛАВНОЕ ИСПРАВЛЕНИЕ ЗДЕСЬ =====
      // AnimatedCosmicBackground теперь является `body` и принимает `child`.
      body: AnimatedCosmicBackground(
        child: BlocBuilder<AppCubit, AppState>(
          builder: (context, state) {
            final myProfile = state.currentUserProfile;
            final partnerProfile = state.viewedProfilesCache[widget.partnerId];

            // Состояние 1: Загрузка
            if (_isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            // Состояние 2: Ошибка
            if (_report == null || partnerProfile == null || myProfile == null) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.error_outline, color: Colors.redAccent, size: 48),
                      const SizedBox(height: 16),
                      Text(l10n.compatibilityErrorTitle, style: const TextStyle(fontSize: 18), textAlign: TextAlign.center), // <-- ЗАМЕНА
                      const SizedBox(height: 8),
                      Text(l10n.compatibilityErrorSubtitle, style: const TextStyle(color: Colors.white70), textAlign: TextAlign.center), // <-- ЗАМЕНА
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.arrow_back),
                        label: Text(l10n.goBack),
                        onPressed: () => context.pop(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pinkAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            // Состояние 3: Успех
            return Stack(
              children: [
                // Скрытый виджет для рендера


                // Видимый контент
                SingleChildScrollView(
                  padding: const EdgeInsets.only(top: kToolbarHeight + 40, bottom: 40),
                  child: Column(
                    children: [
                      _ProfileHeader(myProfile: myProfile, partnerProfile: partnerProfile),
                      const SizedBox(height: 30),
                      _HarmonySphere(l10n: l10n, score: _report!.totalScore),
                      const SizedBox(height: 30),

                      _buildSectionHeader(l10n.sectionCosmicAdvice), // <-- ЗАМЕНА
                      _CosmicAdviceCard(l10n: l10n, report: _report!), // Передаем l10n
                      const SizedBox(height: 20),

                      _buildSectionHeader(l10n.sectionDailyInfluence), // <-- ЗАМЕНА
                      _DailyInfluenceCard(state: state), // Этот виджет сам использует state
                      const SizedBox(height: 20),

                      _buildSectionHeader(l10n.sectionAstrologicalResonance), // <-- ЗАМЕНА
                      ..._report!.details.map((detail) {
                        // Словарь с ЗАГОЛОВКАМИ нам все еще нужен
                        final titleDescriptions = context.read<AppCubit>().state.compatibilityDescriptions;

                        return _CompatibilityAspectCard(
                          l10n: l10n, // Передаем l10n
                          // title по-прежнему берем из словаря по titleKey
                          title: titleDescriptions[detail.titleKey] ?? detail.titleKey,

                          // --- 👇 ВОТ ГЛАВНОЕ ИЗМЕНЕНИЕ 👇 ---
                          // description теперь берем НАПРЯМУЮ из объекта detail.
                          // Больше никаких поисков по ключам!
                          description: detail.description,

                          score: detail.score,
                          isLocked: !state.isProUser && detail.isProFeature,
                        );
                      }),
                      const SizedBox(height: 20),

                      _buildSectionHeader(l10n.sectionNumerologyMatrix), // <-- ЗАМЕНА
                      _NumerologyComparisonSection(l10n: l10n, myProfile: myProfile, partnerProfile: partnerProfile), // Передаем l10n
                      const SizedBox(height: 20),

                      _buildSectionHeader(l10n.sectionPalmistryConnection), // <-- ЗАМЕНА
                      _PalmistryConnectionCard(l10n: l10n, myProfile: myProfile, partnerProfile: partnerProfile), // Передаем l10n

                      if (partnerProfile.bio.isNotEmpty) ...[
                        _buildSectionHeader(l10n.sectionAboutPerson), // <-- ЗАМЕНА
                        _BioCard(bio: partnerProfile.bio),
                      ],
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // Вспомогательный виджет для заголовков секций
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          color: Colors.cyanAccent.withOpacity(0.8),
          letterSpacing: 3,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }
}

class _PalmistryConnectionCard extends StatelessWidget {
  final AppLocalizations l10n;
  final UserProfileCard myProfile;
  final UserProfileCard partnerProfile;

  const _PalmistryConnectionCard({required this.myProfile, required this.l10n, required this.partnerProfile});

  @override
  Widget build(BuildContext context) {
    final myTraits = myProfile.palmistryTraits;
    final partnerTraits = partnerProfile.palmistryTraits;

    if (myTraits.isEmpty || partnerTraits.isEmpty) {
      // Если кто-то из партнеров не прошел анализ
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Text(l10n.palmistryNoData,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white70, fontStyle: FontStyle.italic),
        ),
      );
    }

    // Ищем общие черты
    final commonTraits = myTraits.toSet().intersection(partnerTraits.toSet()).toList();

    // Ищем уникальные черты (простой пример)
    final myUniqueTrait = myTraits.firstWhere((t) => !partnerTraits.contains(t), orElse: () => '');
    final partnerUniqueTrait = partnerTraits.firstWhere((t) => !myTraits.contains(t), orElse: () => '');

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          if (commonTraits.isNotEmpty) ...[
            const Icon(Icons.sync, color: Colors.greenAccent),
            const SizedBox(height: 8),
            Text(
              "Вас объединяет: ${commonTraits.join(', ')}. Это создает прочный фундамент для ваших отношений.",
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, height: 1.5),
            ),
          ],
          if (myUniqueTrait.isNotEmpty && partnerUniqueTrait.isNotEmpty) ...[
            if (commonTraits.isNotEmpty) const Divider(height: 24, color: Colors.white24),
            const Icon(Icons.compare_arrows, color: Colors.orangeAccent),
            const SizedBox(height: 8),
            Text(
              "Вы дополняете друг друга: ваша черта '${myUniqueTrait}' прекрасно гармонирует с его(ее) '${partnerUniqueTrait}'.",
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, height: 1.5),
            ),
          ],
        ],
      ),
    );
  }
}

// ==========================================================
// === ВСЕ НОВЫЕ И ПЕРЕРАБОТАННЫЕ ВИДЖЕТЫ ===
// ==========================================================

class _ProfileHeader extends StatelessWidget {
  final UserProfileCard myProfile;
  final UserProfileCard partnerProfile;
  const _ProfileHeader({required this.myProfile, required this.partnerProfile});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(child: _buildProfileColumn(partnerProfile)),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Icon(Icons.favorite, color: Colors.pinkAccent, size: 30),
          ),
          Expanded(child: _buildProfileColumn(myProfile)),
        ],
      ),
    );
  }

  Widget _buildProfileColumn(UserProfileCard profile) {
    return Column(
      children: [
        // ===== ГЛАВНОЕ ИСПРАВЛЕНИЕ ЗДЕСЬ =====
        // Мы передаем параметр `user` вместо `profile`.
        UserAvatar(user: profile, radius: 40),
        // ===================================
        const SizedBox(height: 8),
        Text(profile.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16), textAlign: TextAlign.center),
        Text(
          "${zodiacIcons[profile.sunSign] ?? ''} ${profile.sunSign}, ${profile.age}",
          style: TextStyle(color: Colors.white.withOpacity(0.7)),
        ),
      ],
    );
  }
}


class _HarmonySphere extends StatelessWidget {
  final AppLocalizations l10n;
  final int score;
  const _HarmonySphere({required this.l10n, required this.score});

  Color _getScoreColor(int score) {
    if (score >= 80) return Colors.greenAccent;
    if (score >= 60) return Colors.yellowAccent;
    if (score >= 40) return Colors.orangeAccent;
    return Colors.redAccent;
  }

  @override
  Widget build(BuildContext context) {
    final color = _getScoreColor(score);
    return Container(
      width: 180,
      height: 180,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black.withOpacity(0.3),
        boxShadow: [
          BoxShadow(color: color.withOpacity(0.7), blurRadius: 30, spreadRadius: 5),
          BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 20, spreadRadius: -5),
        ],
        border: Border.all(color: color.withOpacity(0.8), width: 2),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$score%',
              style: TextStyle(fontSize: 56, fontWeight: FontWeight.w200, color: color, height: 1.1),
            ),
            Text(
              l10n.harmony,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}


class _CosmicAdviceCard extends StatelessWidget {
  final AppLocalizations l10n;
  final CompatibilityReport report;
  const _CosmicAdviceCard({required this.l10n, required this.report});

  // Вспомогательный метод для получения оценки конкретного аспекта
  int _getScore(String key) {
    try {
      return report.details.firstWhere((d) => d.key == key).score;
    } catch (e) {
      return 0; // Возвращаем 0, если аспект не найден
    }
  }

  // Главная логика выбора совета
  Map<String, dynamic> _getAdvice() {
    final sunScore = _getScore("sun");
    final moonScore = _getScore("moon");
    final chemistryScore = _getScore("chemistry");
    final mercuryScore = _getScore("mercury");

    // Используем ключи из l10n вместо текста
    // Используем ключи из l10n вместо текста
    if (report.totalScore >= 85 && sunScore >= 80 && moonScore >= 70) {
      return {'icon': Icons.auto_awesome_mosaic, 'color': Colors.cyanAccent, 'text': l10n.adviceRareConnection};
    }
    if (chemistryScore >= 90 && sunScore < 50) {
      return {'icon': Icons.local_fire_department, 'color': Colors.pinkAccent, 'text': l10n.advicePassionChallenge};
    }
    if (mercuryScore >= 90 && moonScore >= 80 && chemistryScore < 60) {
      return {'icon': Icons.group, 'color': Colors.yellowAccent, 'text': l10n.adviceBestFriends};
    }
    if (report.totalScore < 50) {
      return {'icon': Icons.compost, 'color': Colors.orangeAccent, 'text': l10n.adviceKarmicLesson};
    }
    if (report.totalScore >= 65) {
      return {'icon': Icons.explore_outlined, 'color': Colors.lightGreenAccent, 'text': l10n.adviceGreatPotential};
    }
    return {'icon': Icons.star_border, 'color': Colors.white70, 'text': l10n.adviceBase};
  }

  @override
  Widget build(BuildContext context) {
    final adviceData = _getAdvice();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Icon(adviceData['icon'], color: adviceData['color'], size: 30),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              adviceData['text'],
              style: TextStyle(color: Colors.white.withOpacity(0.9), height: 1.5, fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    );
  }
}

// НОВЫЙ ВИДЖЕТ: Влияние дня (Транзиты)
class _DailyInfluenceCard extends StatelessWidget {
  final AppState state;
  const _DailyInfluenceCard({required this.state});

  Map<String, dynamic> _getThemeForCategory(String category) {
    switch (category) {
      case "love": return {'icon': Icons.favorite_border, 'color': Colors.pinkAccent};
      case "communication": return {'icon': Icons.chat_bubble_outline, 'color': Colors.lightBlueAccent};
      case "energy": return {'icon': Icons.flash_on, 'color': Colors.orangeAccent};
      case "money": return {'icon': Icons.paid_outlined, 'color': Colors.greenAccent};
      case "self": return {'icon': Icons.sentiment_very_satisfied, 'color': Colors.yellowAccent};
      default: return {'icon': Icons.star_outline, 'color': Colors.white70};
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final interpretations = state.dailyForecast?.interpretations ?? [];

    if (interpretations.isEmpty) {
      return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: Row( // <-- УБРАЛИ const
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.nightlight_round, color: Colors.white54),
              const SizedBox(width: 12),
              Expanded(child: Text(l10n.dailyInfluenceCalm, style: const TextStyle(fontStyle: FontStyle.italic))),
            ],
          )
      );
    }

    final aspectsToShow = interpretations.take(3).toList();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.white.withOpacity(0.1))),
      child: Column(
        children: List.generate(aspectsToShow.length, (index) {
          final aspect = aspectsToShow[index];
          final theme = _getThemeForCategory(aspect.category);

          String advice = "";
          final lowerCaseText = aspect.text.toLowerCase();
          const favorableKeywords = ["favorable", "благоприятный", "günstig", "favorable", "favorable"];
          const tenseKeywords = ["tense", "напряженный", "angespannt", "tendu", "tenso", "конфликт", "konflikt", "conflit", "conflicto"];

          if (favorableKeywords.any((keyword) => lowerCaseText.contains(keyword))) {
            advice = l10n.dailyAdviceFavorable;
          } else if (tenseKeywords.any((keyword) => lowerCaseText.contains(keyword))) {
            advice = l10n.dailyAdviceTense;
          }

          return Padding(
            padding: EdgeInsets.only(bottom: index == aspectsToShow.length - 1 ? 0 : 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(theme['icon'], color: theme['color'], size: 20),
                    const SizedBox(width: 8),
                    Expanded(child: Text(aspect.title, style: TextStyle(fontWeight: FontWeight.bold, color: theme['color']))),
                  ],
                ),
                const SizedBox(height: 8),
                Text(aspect.text, style: TextStyle(color: Colors.white.withOpacity(0.9), height: 1.5)),
                if (advice.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(advice, style: TextStyle(color: theme['color'], fontStyle: FontStyle.italic, fontWeight: FontWeight.bold)),
                ]
              ],
            ),
          );
        }),
      ),
    );
  }
}

// Переработанная карточка аспекта
class _CompatibilityAspectCard extends StatelessWidget {
  final AppLocalizations l10n;
  final String title;
  final String description;
  final int score;
  final bool isLocked;

  const _CompatibilityAspectCard({required this.l10n, required this.title, required this.description, required this.score, required this.isLocked});

  Color _getScoreColor(int score) {
    if (score >= 80) return Colors.greenAccent;
    if (score >= 60) return Colors.yellow;
    if (score >= 40) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.white.withOpacity(0.1))),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          trailing: isLocked
              ? const Icon(Icons.lock_outline, color: Colors.grey)
              : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("$score%", style: TextStyle(color: _getScoreColor(score), fontWeight: FontWeight.bold)),
              const SizedBox(width: 8),
              const Icon(Icons.keyboard_arrow_down),
            ],
          ),
          children: [
            if (isLocked)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Column(
                  children: [
                    Text(l10n.proFeatureLocked, style: const TextStyle(color: Colors.white70, fontStyle: FontStyle.italic)),
                    const SizedBox(height: 10),
                    ElevatedButton(onPressed: () => context.push('/paywall'), child: Text(l10n.getProButton)),
                  ],
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Text(description, style: const TextStyle(height: 1.5, color: Colors.white70)),
              ),
          ],
        ),
      ),
    );
  }
}


// Переработанный виджет нумерологии
class _NumerologyComparisonSection extends StatelessWidget {
  final AppLocalizations l10n;
  final UserProfileCard myProfile;
  final UserProfileCard partnerProfile;
  const _NumerologyComparisonSection({required this.l10n, required this.myProfile, required this.partnerProfile});

  @override
  Widget build(BuildContext context) {
    final myReport = NumerologyCalculator.generateFullReport(
      birthDateTime: DateTime.fromMillisecondsSinceEpoch(myProfile.birthDateMillis),
      fullName: myProfile.name,
    );
    final partnerReport = NumerologyCalculator.generateFullReport(
      birthDateTime: DateTime.fromMillisecondsSinceEpoch(partnerProfile.birthDateMillis),
      fullName: partnerProfile.name,
    );

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.white.withOpacity(0.1))),
      child: Column(
        children: [
          _NumerologyRow(title: l10n.numerologyLifePath, myNumber: myReport.lifePath.number, partnerNumber: partnerReport.lifePath.number),
          const Divider(color: Colors.white24, height: 24),
          _NumerologyRow(title: l10n.numerologyDestinyNumber, myNumber: myReport.destiny.number, partnerNumber: partnerReport.destiny.number),
          const Divider(color: Colors.white24, height: 24),
          _NumerologyRow(title: l10n.numerologySoulNumber, myNumber: myReport.soulUrge.number, partnerNumber: partnerReport.soulUrge.number),
        ],
      ),
    );
  }
}

class _NumerologyRow extends StatelessWidget {
  final String title;
  final int myNumber;
  final int partnerNumber;

  const _NumerologyRow({required this.title, required this.myNumber, required this.partnerNumber});

  @override
  Widget build(BuildContext context) {
    final bool isMatch = myNumber == partnerNumber;
    return Row(
      children: [
        Expanded(child: Text(myNumber.toString(), textAlign: TextAlign.center, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w200))),
        Expanded(
            flex: 2,
            child: Column(
              children: [
                Text(title, style: const TextStyle(color: Colors.white70)),
                const SizedBox(height: 4),
                Container(
                  width: 60,
                  height: 2,
                  color: isMatch ? Colors.greenAccent.withOpacity(0.5) : Colors.orangeAccent.withOpacity(0.5),
                )
              ],
            )
        ),
        Expanded(child: Text(partnerNumber.toString(), textAlign: TextAlign.center, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w200))),
      ],
    );
  }
}

// НОВЫЙ ВИДЖЕТ: Карточка с Bio
class _BioCard extends StatelessWidget {
  final String bio;
  const _BioCard({required this.bio});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "«$bio»",
            style: const TextStyle(color: Colors.white, height: 1.6, fontStyle: FontStyle.italic, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

// ==========================================================
// === НОВЫЙ, ИНФОРМАТИВНЫЙ ВИДЖЕТ-ШАБЛОН ДЛЯ КАРТИНКИ ===
// ==========================================================
class CompatibilityShareCard extends StatelessWidget {
  final AppLocalizations l10n;
  final UserProfileCard myProfile;
  final UserProfileCard partnerProfile;
  final CompatibilityReport report;
  final String appUrl = "https://www.rustore.ru/catalog/app/com.psylergy.lovequest"; // Ссылка на приложение

  const CompatibilityShareCard({
    super.key,
    required this.l10n,
    required this.myProfile,
    required this.partnerProfile,
    required this.report,
  });

  Color _getScoreColor(int score) {
    if (score >= 80) return Colors.greenAccent;
    if (score >= 60) return Colors.yellowAccent;
    if (score >= 40) return Colors.orangeAccent;
    return Colors.redAccent;
  }

  @override
  Widget build(BuildContext context) {
    final color = _getScoreColor(report.totalScore);

    // Рассчитываем нумерологию для обоих
    final myNumerology = NumerologyCalculator.generateFullReport(
      birthDateTime: DateTime.fromMillisecondsSinceEpoch(myProfile.birthDateMillis),
      fullName: myProfile.name,
    );
    final partnerNumerology = NumerologyCalculator.generateFullReport(
      birthDateTime: DateTime.fromMillisecondsSinceEpoch(partnerProfile.birthDateMillis),
      fullName: partnerProfile.name,
    );

    return Material(
      // Убираем внешние отступы Material, чтобы контролировать их самим
      child: Container(
        width: 450, // Увеличим ширину для большей информации
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF190731), Color(0xFF33114f)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Верхний "титульный" блок
            _buildHeader(),

            // Блок с аватарами и знаками
            _buildProfilesRow(),

            const SizedBox(height: 24),

            // Центральный блок с процентом
            _buildHarmonySphere(color),

            const SizedBox(height: 24),

            // НОВЫЙ БЛОК: Ключевые точки совместимости
            _buildKeyPoints(myNumerology, partnerNumerology),

            const SizedBox(height: 24),

            // Нижний блок с QR-кодом и призывом к действию
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      width: double.infinity,
      color: Colors.black.withOpacity(0.2),
      child: Column(
        children: [
          Text(l10n.shareCardTitle, style: const TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.bold, fontSize: 18, letterSpacing: 4)),
          const SizedBox(height: 4),
          Text(l10n.shareCardSubtitle, style: const TextStyle(color: Colors.white70, fontSize: 10, letterSpacing: 1.5)),
        ],
      ),
    );
  }

  Widget _buildProfilesRow() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildProfileColumn(partnerProfile),
          const Icon(Icons.favorite, color: Colors.pinkAccent, size: 24),
          _buildProfileColumn(myProfile),
        ],
      ),
    );
  }

  Widget _buildProfileColumn(UserProfileCard profile) {
    return Column(
      children: [
        UserAvatar(user: profile, radius: 40),
        const SizedBox(height: 8),
        Text(profile.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
        Text(
          "${zodiacIcons[profile.sunSign] ?? ''} ${profile.sunSign}",
          style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildHarmonySphere(Color color) {
    return Column(
      children: [
        Text('${report.totalScore}%', style: TextStyle(fontSize: 64, fontWeight: FontWeight.w200, color: color, height: 1)),
        Text(l10n.shareCardHarmony, style: const TextStyle(color: Colors.white70, fontSize: 14)),
      ],
    );
  }

  Widget _buildKeyPoints(PersonalNumerologyReport myNumerology, PersonalNumerologyReport partnerNumerology) {
    final sunScore = report.details.firstWhere((d) => d.key == 'sun').score;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          _buildPointRow(
            icon: Icons.wb_sunny_outlined,
            title: l10n.shareCardPersonalityHarmony,
            value: '$sunScore%',
            color: _getScoreColor(sunScore),
          ),
          const SizedBox(height: 12),
          _buildPointRow(
            icon: Icons.sync,
            title: l10n.shareCardLifePath,
            value: '${myNumerology.lifePath.number} & ${partnerNumerology.lifePath.number}',
            color: myNumerology.lifePath.number == partnerNumerology.lifePath.number ? Colors.greenAccent : Colors.white70,
          ),
        ],
      ),
    );
  }

  Widget _buildPointRow({required IconData icon, required String title, required String value, required Color color}) {
    return Row(
      children: [
        Icon(icon, color: Colors.white70, size: 20),
        const SizedBox(width: 12),
        Expanded(child: Text(title, style: const TextStyle(color: Colors.white, fontSize: 14))),
        Text(value, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 16)),
      ],
    );
  }

  Widget _buildFooter() {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      padding: const EdgeInsets.all(16),
      color: Colors.black.withOpacity(0.2),
      child: Row(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(4),
            child: QrImageView(data: appUrl, version: QrVersions.auto, size: 80.0, gapless: false),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.shareCardCtaTitle, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16, height: 1.3)),
                const SizedBox(height: 4),
                Text(l10n.shareCardCtaSubtitle, style: const TextStyle(color: Colors.white70, fontSize: 12)),
              ],
            ),
          )
        ],
      ),
    );
  }
}