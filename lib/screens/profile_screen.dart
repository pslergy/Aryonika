// lib/screens/profile_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lovequest/cubit/app_cubit.dart';
import 'package:lovequest/cubit/app_state.dart';
import 'package:lovequest/l10n/generated/app_localizations.dart';
import 'package:lovequest/src/data/models/numerology_report.dart';

import 'package:lovequest/src/data/models/astrology/natal_chart.dart';
import 'package:lovequest/utils/l10n_mapper.dart';
import 'package:lovequest/widgets/common/animated_cosmic_background.dart';
import 'package:lovequest/widgets/oracle/moon_rhythm_widget.dart';
import 'package:lovequest/widgets/profile/cosmic_event_card.dart';
import 'package:lovequest/widgets/profile/my_profile_header.dart';
import 'package:lovequest/widgets/common/portal_card.dart';
 // <-- ОБЯЗАТЕЛЬНЫЙ ИМПОРТ

import '../repositories/package/lovequest/src/data/models/enums.dart';
import '../services/logger_service.dart';
import '../widgets/common/alpha_version_banner.dart';
import '../widgets/common/clickable_text.dart';
import 'package:badges/badges.dart' as badges;

import '../widgets/common/neon_glow_button.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final cubit = context.read<AppCubit>();
        // Возвращаем загрузку данных, нужных для экрана профиля
        cubit.loadDailyForecast();
        cubit.loadMoonRhythm();
        cubit.loadCosmicEvents();
        context.read<AppCubit>().recheckProStatus();
      }
    });
  }
  void _showCompassBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const _CompassBottomSheetContent(),
    );
  }

  Future<bool> _showSafetyDisclaimer(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;

    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E3D),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Icon(Icons.warning_amber_rounded, color: Colors.orangeAccent, size: 40),
        content: Text(
          l10n.uploadPhotoDisclaimer, // "Загружая фото, вы подтверждаете..."
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white70, fontSize: 16),
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(l10n.cancel, style: const TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(l10n.iAgree, style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  // 2. МЕТОД ОБРАБОТКИ КЛИКА (С МЕНЮ)
  void _handleAvatarClick(String? currentAvatarUrl) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E1E3D),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Кнопка 1: Посмотреть (если есть фото)
              if (currentAvatarUrl != null && currentAvatarUrl.isNotEmpty)
                ListTile(
                  leading: const Icon(Icons.visibility, color: Colors.white),
                  title: const Text('Посмотреть фото', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.pop(ctx);
                    // Открываем просмотрщик (PhotoView)
                    // context.push('/photo-view', extra: currentAvatarUrl); // Если есть такой роут
                    // ИЛИ просто показываем диалог с картинкой:
                    showDialog(
                      context: context,
                      builder: (_) => Dialog(
                        backgroundColor: Colors.transparent,
                        child: InteractiveViewer(child: Image.network(currentAvatarUrl)),
                      ),
                    );
                  },
                ),

              // Кнопка 2: Загрузить новое
              ListTile(
                leading: const Icon(Icons.upload, color: Colors.pinkAccent),
                title: const Text('Загрузить новое фото', style: TextStyle(color: Colors.pinkAccent)),
                onTap: () async {
                  Navigator.pop(ctx); // Закрываем меню

                  // 1. Показываем дисклеймер
                  final confirmed = await _showSafetyDisclaimer(context);

                  // 2. Если ОК -> Вызываем загрузку
                  if (confirmed) {
                    if (!mounted) return;
                    context.read<AppCubit>().updateProfileAvatar();
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    // Получаем доступ к переводам один раз в главном методе build
    final l10n = AppLocalizations.of(context)!;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        context.read<AppCubit>().loadDailyForecast();
      }
    });

    return Scaffold(
      body: AnimatedCosmicBackground(
        child: BlocBuilder<AppCubit, AppState>(
          builder: (context, state) {
            final currentUser = state.currentUserProfile;
            if (currentUser == null) {
              return const Center(child: CircularProgressIndicator());
            }

            return RefreshIndicator(
              onRefresh: () async => context.read<AppCubit>().recheckProStatus(),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: MyProfileHeader(
                      user: currentUser,
                      userName: currentUser.name,
                      userId: currentUser.id,
                      sunSign: currentUser.sunSign,
                      isPro: state.isProUser,
                      onEditClick: () => context.push('/profile/edit'),
                      onSettingsClick: () => context.push('/profile/settings'),
                      onAvatarClick: () {
                        // Логируем, чтобы проверить, что мы тут
                        logger.d("Avatar clicked! URL: ${currentUser.avatar}");

                        _handleAvatarClick(currentUser.avatar); // <-- ВАЖНО: передаем URL аватара
                      },

                      onEditBioClick: () {},
                    ),
                  ),
                  const SliverToBoxAdapter(child: MoonRhythmWidget()),

                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
                      child: ClickableParsedText(
                        text: currentUser.bio.isNotEmpty ? currentUser.bio : l10n.bioPlaceholder,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white.withOpacity(0.8), fontStyle: FontStyle.italic, fontSize: 15),
                        onHashtagPressed: (tag) {
                          context.read<AppCubit>().startSearchWithHashtag(tag);
                          context.push('/search');
                        },
                      ),
                    ),
                  ),

                  SliverList(
                    delegate: SliverChildListDelegate([
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                        child: PortalCard(
                          icon: Icons.photo_library_outlined,
                          title: l10n.photoAlbumTitle(currentUser.photoCount),
                          subtitle: l10n.photoAlbumSubtitle,
                          onClick: () => context.push('/album/${currentUser.id}'),
                        ),
                      ),
                      const Divider(indent: 16, endIndent: 16, color: Colors.white24),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        child: _ProStatusCard(l10n: l10n), // Передаем l10n
                      ),
                      const AlphaVersionBanner(telegramChannelUrl: 'https://t.me/NumeroPlatform'),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: BlocBuilder<AppCubit, AppState>(
                          buildWhen: (p, c) => p.newLikesCount != c.newLikesCount,
                          builder: (context, state) {
                            return badges.Badge(
                              showBadge: state.newLikesCount > 0,
                              badgeAnimation: const badges.BadgeAnimation.scale(animationDuration: Duration(milliseconds: 300)),
                              position: badges.BadgePosition.topEnd(top: -5, end: -5),
                              badgeContent: Text(state.newLikesCount.toString(), style: const TextStyle(color: Colors.white, fontSize: 12)),
                              child: _LikesYouCard(
                                l10n: l10n, // Передаем l10n
                                likeCount: state.currentUserProfile?.likedByUsers.length ?? 0,
                                onCardClick: () => context.push('/profile/likes-you'),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: _CompassOfTheDayCard(
                          onTap: () {
                            // Проверяем PRO статус
                            if (state.isProUser) {
                              // Запускаем расчет и показываем экран/модалку
                              context.read<AppCubit>().calculateDetailedHybridForecast();
                              // TODO: Открыть экран/BottomSheet (покажем код ниже)
                              _showCompassBottomSheet(context);
                            } else {
                              context.push('/paywall');
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                        child: PortalCard(
                          icon: Icons.auto_awesome_motion,
                          title: l10n.cosmicEventsTitle,
                          subtitle: l10n.cosmicEventsSubtitle,
                          onClick: () => context.push('/cosmic-events'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                        child: PortalCard(
                          icon: Icons.confirmation_number_outlined, // Иконка билетика/кода
                          title: "Активировать промокод", // Добавь в l10n: l10n.enterPromoCodeTitle
                          subtitle: "Введи код друга и получи бонус", // l10n.enterPromoCodeSubtitle
                          onClick: () => context.push('/referral'), // Переход на экран
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                        child: PortalCard(
                          icon: Icons.gamepad_outlined,
                          title: l10n.gameCenterTitle,
                          subtitle: l10n.gameCenterSubtitle,
                          onClick: () => context.push('/profile/games'),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: _DailyForecastCard(
                          l10n: l10n, // Передаем l10n
                          isPro: state.isProUser,
                          onCardClick: () => state.isProUser ? context.push('/forecast') : context.push('/paywall'),
                        ),
                      ),
                      _SectionTitle(title: l10n.yourCosmicInfluence),

                      Builder(builder: (context) {
                        switch(state.cosmicEventsStatus) {
                          case LoadingState.loading:
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.all(32.0),
                                child: Column(
                                  children: [
                                    const CircularProgressIndicator(strokeWidth: 2),
                                    const SizedBox(height: 16),
                                    Text(l10n.cosmicEventsLoading, style: const TextStyle(color: Colors.white70)),
                                  ],
                                ),
                              ),
                            );
                          case LoadingState.error:
                            return Center(child: Text(l10n.cosmicEventsError, style: const TextStyle(color: Colors.redAccent)));
                          case LoadingState.success:
                            if (state.cosmicEvents.isEmpty) {
                              return Center(child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                                child: Text(l10n.cosmicEventsEmpty, style: const TextStyle(color: Colors.white70, fontStyle: FontStyle.italic), textAlign: TextAlign.center),
                              ));
                            }
                            // Отображаем список карточек
                            return Column(
                              children: state.cosmicEvents
                                  .map((event) => CosmicEventCard(event: event))
                                  .toList(),
                            );
                          default:
                            return const SizedBox.shrink();
                        }
                      }),
                      const SizedBox(height: 32),
                      _SectionTitle(title: l10n.cosmicPassportTitle),
                      _buildCosmicPassport(context, l10n, state, currentUser.natalChart),
                      const SizedBox(height: 32),
                      _SectionTitle(title: l10n.numerologyPortraitTitle),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        child: Column(
                          children: [
                            // Просто показываем числа из профиля
                            BlocBuilder<AppCubit, AppState>(
                              builder: (context, state) {
                                final report = state.currentUserProfile?.numerologyData;
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    _NumberPreview(title: l10n.numerologyPath, number: report?.lifePath.number),
                                    _NumberPreview(title: l10n.numerologyDestiny, number: report?.destiny.number),
                                    _NumberPreview(title: l10n.numerologySoul, number: report?.soulUrge.number),
                                  ],
                                );
                              },
                            ),
                            const SizedBox(height: 16),
                            // Кнопка, которая ведет на новый экран
                            OutlinedButton.icon(
                              icon: const Icon(Icons.psychology_alt_outlined),
                              label: Text(l10n.yourNumbersOfDestinySubtitle),
                              onPressed: () => context.push('/numerology'), // Навигация на детальный экран
                            ),
                          ],
                        ),
                      ),
                      // --- 👆 КОНЕЦ ЗАМЕНЫ 👆 ---


                      const SizedBox(height: 48),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 64.0),
                        child: TextButton.icon(
                          icon: const Icon(Icons.logout, color: Colors.white54),
                          label: Text(l10n.signOut, style: const TextStyle(color: Colors.white54)),
                          onPressed: () => context.read<AppCubit>().signOut(),
                        ),
                      ),
                      const SizedBox(height: 32),
                    ]),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // Вспомогательный МЕТОД, а не виджет, чтобы иметь доступ к l10n из build
  Widget _buildCosmicPassport(BuildContext context, AppLocalizations l10n, AppState state, NatalChart? chart) {
    if (chart == null) {
      // --- 👇 ЗАМЕНЯЕМ БЕСКОНЕЧНУЮ ЗАГРУЗКУ НА КНОПКУ 👇 ---
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32.0),
          child: Column(
            children: [
              const Text(
                "Ваша карта требует обновления", // Добавь в l10n
                style: TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 16),
              NeonGlowButton(
                text: "Обновить данные рождения", // Добавь в l10n
                onPressed: () => context.push('/profile/edit'),
              ),
            ],
          ),
        ),
      );
      // --- 👆 -------------------------------------------
    }

    String getPlanetName(String key) {
      switch (key) {
        case 'sun': return l10n.planetSun;
        case 'moon': return l10n.planetMoon;
        case 'ascendant': return l10n.planetAscendant;
        case 'mercury': return l10n.planetMercury;
        case 'venus': return l10n.planetVenus;
        case 'mars': return l10n.planetMars;
        case 'saturn': return l10n.planetSaturn;
        case 'jupiter': return l10n.planetJupiter;
        case 'uranus': return l10n.planetUranus;
        case 'neptune': return l10n.planetNeptune;
        case 'pluto': return l10n.planetPluto;
        default: return key;
      }
    }

    final descriptions = state.astroDescriptions;
    String getDesc(String planetKey, String? signKey) {
      if (signKey == null || signKey.isEmpty) return l10n.astroDataSignMissing;

      // 1. Определяем имя карты (раздела) в JSON
      // Обычно это "sun_signs", "moon_signs" и т.д.
      final mapKey = '${planetKey}_signs';

      if (descriptions.containsKey(mapKey)) {
        final signMap = descriptions[mapKey] as Map<String, dynamic>?;
        if (signMap == null) return "Error loading map";

        // 2. Пробуем разные варианты ключа
        // Вариант А: Как пришло (Capricorn)
        if (signMap.containsKey(signKey)) return signMap[signKey].toString();

        // Вариант Б: С маленькой буквы (capricorn) - САМЫЙ ЧАСТЫЙ ВАРИАНТ
        if (signMap.containsKey(signKey.toLowerCase())) return signMap[signKey.toLowerCase()].toString();

        // Вариант В: С большой буквы (Capricorn)
        final cap = signKey[0].toUpperCase() + signKey.substring(1).toLowerCase();
        if (signMap.containsKey(cap)) return signMap[cap].toString();

        return l10n.astroDataDescriptionNotFound(signKey);
      }
      return l10n.astroDataMapNotLoaded(mapKey);
    }

    final passportItems = [
      {'key': 'sun', 'value': chart.sunSign, 'icon': Icons.wb_sunny_outlined, 'color': Colors.orangeAccent, 'isPro': false},
      {'key': 'moon', 'value': chart.moonSign, 'icon': Icons.nightlight_round, 'color': Colors.grey[300]!, 'isPro': true},
      {'key': 'ascendant', 'value': chart.ascendantSign, 'icon': Icons.arrow_upward, 'color': Colors.lightBlueAccent, 'isPro': true},
      {'key': 'mercury', 'value': chart.mercurySign, 'icon': Icons.messenger_outline, 'color': Colors.yellow, 'isPro': true},
      {'key': 'venus', 'value': chart.venusSign, 'icon': Icons.favorite_border, 'color': Colors.pinkAccent, 'isPro': true},
      {'key': 'mars', 'value': chart.marsSign, 'icon': Icons.male, 'color': Colors.redAccent, 'isPro': true},
      {'key': 'saturn', 'value': chart.saturnSign, 'icon': Icons.ac_unit_outlined, 'color': Colors.brown[300]!, 'isPro': true},
      {'key': 'jupiter', 'value': chart.jupiterSign, 'icon': Icons.shield_outlined, 'color': Colors.deepPurpleAccent, 'isPro': true},
      {'key': 'uranus', 'value': chart.uranusSign, 'icon': Icons.flash_on_outlined, 'color': Colors.cyan, 'isPro': true},
      {'key': 'neptune', 'value': chart.neptuneSign, 'icon': Icons.waves_outlined, 'color': Colors.blue, 'isPro': true},
      {'key': 'pluto', 'value': chart.plutoSign, 'icon': Icons.whatshot_outlined, 'color': Colors.black54, 'isPro': true},
    ];

    return SizedBox(
      height: 180,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemCount: passportItems.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final item = passportItems[index];
          final planetKey = item['key'] as String;
          final signValue = item['value'] as String? ?? '...';
          // --- 👇 ЛОГ 👇 ---
          if (planetKey == 'sun') {
            print("DEBUG PASSPORT: Planet: $planetKey, Sign Value: '$signValue'");
          }
          // ----------------
          final bool isLocked = (item['isPro'] as bool) && !state.isProUser;
          return _PassportEntryCard(
            l10n: l10n,
            isLocked: isLocked,
            icon: item['icon'] as IconData,
            iconColor: item['color'] as Color,
            title: getPlanetName(planetKey),
            value: signValue,
            description: getDesc(planetKey, signValue),
            onLockedClick: () => context.push('/paywall'),
          );
        },
      ),
    );
  }
}



// =========================================================================
// === ИСПРАВЛЕНИЕ ВСЕХ ДОЧЕРНИХ ВИДЖЕТОВ ДЛЯ ПРИЕМА ПАРАМЕТРА `l10n` ===
// =========================================================================

class _ProStatusCard extends StatelessWidget {
  final AppLocalizations l10n;
  const _ProStatusCard({required this.l10n}); // <-- ИСПРАВЛЕННЫЙ КОНСТРУКТОР

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      buildWhen: (p, c) => p.isProUser != c.isProUser || p.currentUserProfile?.proEndDate != c.currentUserProfile?.proEndDate,
      builder: (context, state) {
        if (!state.isProUser) {
          return Card(
            clipBehavior: Clip.antiAlias,
            elevation: 0,
            shape: RoundedRectangleBorder(side: BorderSide(color: Colors.white.withOpacity(0.2)), borderRadius: BorderRadius.circular(16)),
            child: InkWell(
              onTap: () => context.push('/paywall'),
              child: Container(
                decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.blueGrey.withOpacity(0.2), Colors.black.withOpacity(0.2)], begin: Alignment.topLeft, end: Alignment.bottomRight)),
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const Icon(Icons.workspace_premium_outlined, size: 40, color: Colors.white70),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(l10n.getProTitle, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                          Text(l10n.getProSubtitle, style: const TextStyle(color: Colors.white70)),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 16),
                  ],
                ),
              ),
            ),
          );
        }

        final endDate = state.currentUserProfile?.proEndDate;
        if (endDate == null) return const SizedBox.shrink();

        final now = DateTime.now();
        final difference = endDate.difference(now);

        String remainingText;
        if (difference.isNegative) {
          remainingText = l10n.proStatusExpired;
        } else if (difference.inDays > 0) {
          remainingText = l10n.proStatusDaysLeft(difference.inDays + 1);
        } else if (difference.inHours > 0) {
          remainingText = l10n.proStatusHoursLeft(difference.inHours + 1);
        } else {
          remainingText = l10n.proStatusExpiresToday;
        }

        return Card(
          clipBehavior: Clip.antiAlias,
          elevation: 0,
          shape: RoundedRectangleBorder(side: BorderSide(color: Colors.yellow.withOpacity(0.4)), borderRadius: BorderRadius.circular(16)),
          child: InkWell(
            onTap: () => context.push('/paywall'),
            child: Container(
              decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.deepPurple.withOpacity(0.4), Colors.yellow.withOpacity(0.1)], begin: Alignment.topLeft, end: Alignment.bottomRight)),
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(Icons.workspace_premium, size: 40, color: Colors.yellowAccent),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(l10n.proStatusActive, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.yellowAccent)),
                        Text(remainingText, style: const TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 16),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title}); // <-- ИЗМЕНЕНО ДЛЯ ЯСНОСТИ

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        title.toUpperCase(),
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.yellow[700]?.withOpacity(0.8), fontWeight: FontWeight.bold, letterSpacing: 2.0, fontSize: 14),
      ),
    );
  }
}

class _DailyForecastCard extends StatelessWidget {
  final AppLocalizations l10n;
  final bool isPro;
  final VoidCallback onCardClick;
  const _DailyForecastCard({required this.l10n, required this.isPro, required this.onCardClick}); // <-- ИСПРАВЛЕННЫЙ КОНСТРУКТОР

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.transparent,
      child: InkWell(
        onTap: onCardClick,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.white.withOpacity(0.2)), gradient: LinearGradient(colors: [Colors.purple.withOpacity(0.3), Colors.blueAccent.withOpacity(0.3)], begin: Alignment.topLeft, end: Alignment.bottomRight)),
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(isPro ? Icons.auto_awesome : Icons.lock, color: Colors.yellow[700], size: 48),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.personalForecastTitle, style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white)),
                    Text(isPro ? l10n.personalForecastSubtitlePro : l10n.personalForecastSubtitleFree, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.yellow[700])),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, color: Colors.white54),
            ],
          ),
        ),
      ),
    );
  }
}

class _PassportEntryCard extends StatelessWidget {
  final AppLocalizations l10n;
  final bool isLocked;
  final IconData icon;
  final Color iconColor;
  final String title;
  final String value;
  final String description;
  final VoidCallback onLockedClick;
  const _PassportEntryCard({required this.l10n, required this.isLocked, required this.icon, required this.iconColor, required this.title, required this.value, required this.description, required this.onLockedClick}); // <-- ИСПРАВЛЕННЫЙ КОНСТРУКТОР

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (isLocked) {
          onLockedClick();
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: const Color(0xFF1A1A3D).withOpacity(0.95),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: BorderSide(color: iconColor.withOpacity(0.5))),
              icon: Icon(icon, color: iconColor, size: 32),
              title: Text(l10n.astroDialogTitle(title, value), style: TextStyle(color: iconColor, fontWeight: FontWeight.bold)),
              content: SingleChildScrollView(child: Text(description, style: const TextStyle(color: Colors.white70))),
              actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: Text(l10n.close, style: const TextStyle(color: Colors.white)))],
            ),
          );
        }
      },
      borderRadius: BorderRadius.circular(16),
      child: Card(
        child: SizedBox(
          width: 140,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isLocked) Icon(Icons.lock, color: Colors.yellow[700], size: 32) else Icon(icon, color: iconColor, size: 32),
              const SizedBox(height: 8),
              Text(title, style: TextStyle(color: isLocked ? Colors.grey : Colors.white)),
              const SizedBox(height: 4),
              Text(isLocked ? "PRO" : value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: isLocked ? Colors.yellow[700] : Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}

class _LikesYouCard extends StatelessWidget {
  final AppLocalizations l10n;
  final int likeCount;
  final VoidCallback onCardClick;
  const _LikesYouCard({required this.l10n, required this.likeCount, required this.onCardClick}); // <-- ИСПРАВЛЕННЫЙ КОНСТРУКТОР

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.transparent,
      child: InkWell(
        onTap: onCardClick,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.white.withOpacity(0.2)), gradient: LinearGradient(colors: [Colors.pink.withOpacity(0.3), Colors.redAccent.withOpacity(0.3)], begin: Alignment.topLeft, end: Alignment.bottomRight)),
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              const Icon(Icons.favorite, color: Colors.pinkAccent, size: 48),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.likesYouTitle, style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white)),
                    Text(likeCount > 0 ? l10n.likesYouTotal(likeCount) : l10n.likesYouNone, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.pinkAccent)),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, color: Colors.white54),
            ],
          ),
        ),
      ),
    );
  }
}

class _NumberPreview extends StatelessWidget {
  final String title;
  final int? number;
  const _NumberPreview({required this.title, this.number});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title.toUpperCase(), style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12, letterSpacing: 1.5)),
        const SizedBox(height: 4),
        Text(number?.toString() ?? '?', style: TextStyle(color: Colors.yellow[700], fontSize: 32, fontWeight: FontWeight.bold, shadows: [Shadow(color: Colors.yellow.withOpacity(0.5), blurRadius: 10)])),
      ],
    );
  }
}
class _NumerologyInfoCard extends StatelessWidget {
  final String title;
  final int? number;
  final String descriptionKey;

  const _NumerologyInfoCard({
    required this.title,
    required this.number,
    required this.descriptionKey,
  });

  @override
  Widget build(BuildContext context) {
    // Получаем словарь с описаниями из AppState
    final descriptions = context.watch<AppCubit>().state.numerologyNumberDescriptions;



    final description = descriptions[descriptionKey] ?? "Описание для этого числа скоро появится.";

    if (number == null) {
      return const SizedBox.shrink(); // Не показываем ничего, если числа нет
    }

    return Card(
      color: Colors.white.withOpacity(0.05),
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$title: $number',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: Colors.deepPurple[200]),
            ),
            const Divider(height: 16, color: Colors.white24),
            Text(
              description,
              style: TextStyle(color: Colors.white.withOpacity(0.8), height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}

// lib/screens/profile_screen.dart (Вспомогательные классы внизу)

// НЕ ЗАБУДЬ ДОБАВИТЬ ИМПОРТ НАВЕРХУ ФАЙЛА:
// import 'package:lovequest/utils/l10n_mapper.dart';

class _CompassBottomSheetContent extends StatelessWidget {
  const _CompassBottomSheetContent();

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (_, controller) {
        return Container(
          decoration: const BoxDecoration(
            color: Color(0xFF1A1A2E), // Темно-синий фон
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: BlocBuilder<AppCubit, AppState>(
            builder: (context, state) {
              // 1. Состояние загрузки
              if (state.hybridForecastLoadingState == LoadingState.loading) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(color: Colors.cyanAccent),
                      SizedBox(height: 16),
                      // Можно тоже вынести в l10n: l10n.loading_transits
                      Text("Рассчитываем транзиты...", style: TextStyle(color: Colors.white54)),
                    ],
                  ),
                );
              }

              // 2. Состояние ошибки
              if (state.hybridForecastLoadingState == LoadingState.error) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline, color: Colors.redAccent, size: 48),
                      const SizedBox(height: 16),
                      const Text("Ошибка расчета.", style: TextStyle(color: Colors.white70)),
                      TextButton(
                        onPressed: () => context.read<AppCubit>().calculateDetailedHybridForecast(),
                        child: const Text("Повторить", style: TextStyle(color: Colors.cyanAccent)),
                      )
                    ],
                  ),
                );
              }

              final forecast = state.hybridForecast;

              // 3. Данных нет
              if (forecast == null) {
                return const Center(child: Text("Данные отсутствуют.", style: TextStyle(color: Colors.white54)));
              }

              // 4. УСПЕХ: Показываем данные
              return ListView(
                controller: controller,
                padding: const EdgeInsets.all(24),
                children: [
                  Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(2)))),
                  const SizedBox(height: 32),

                  const Text(
                    "Компас Дня",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1.2),
                  ),
                  const SizedBox(height: 24),

                  // --- КАРТОЧКА НУМЕРОЛОГИИ ---
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.purpleAccent.withOpacity(0.3)),
                    ),
                    child: Column(
                      children: [
                        Text("Число Личного Дня", style: TextStyle(color: Colors.purpleAccent[100], fontSize: 14)),
                        const SizedBox(height: 8),
                        Text(
                          forecast.personalDayNumber.toString(),
                          style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.purpleAccent),
                        ),
                        const SizedBox(height: 16),

                        // ИСПОЛЬЗУЕМ L10nMapper ДЛЯ ПЕРЕВОДА
                        Text(
                          L10nMapper.getNumerologyText(context, forecast.numerologyText),
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.white70, height: 1.5),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // --- КАРТОЧКА АСТРОЛОГИИ ---
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.cyanAccent.withOpacity(0.3)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.auto_awesome, color: Colors.cyanAccent),
                            const SizedBox(width: 12),
                            Text("Космическая Погода", style: TextStyle(color: Colors.cyanAccent[100], fontSize: 16, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // ИСПОЛЬЗУЕМ L10nMapper ДЛЯ ПЕРЕВОДА
                        Text(
                          L10nMapper.getAstrologyText(context, forecast.astrologyText),
                          style: const TextStyle(color: Colors.white70, height: 1.5),
                        ),
                        const SizedBox(height: 16),

                        // ИСПОЛЬЗУЕМ L10nMapper ДЛЯ ПЕРЕВОДА
                        if (forecast.finalAdvice.isNotEmpty)
                          Text(
                            L10nMapper.getFinalAdviceText(context, forecast.finalAdvice),
                            style: const TextStyle(color: Colors.amberAccent, fontStyle: FontStyle.italic),
                          ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white10,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Закрыть"),
                    ),
                  )
                ],
              );
            },
          ),
        );
      },
    );
  }
}

class _CompassOfTheDayCard extends StatelessWidget {
  final VoidCallback onTap;

  const _CompassOfTheDayCard({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFF6A1B9A), Color(0xFF283593)], // Фиолетовый -> Синий
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(color: Colors.purple.withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 4)),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.explore, color: Colors.cyanAccent, size: 32),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Компас Дня",
                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Гибридный прогноз: Астрология + Нумерология. Узнай, что сегодня можно, а что нельзя.",
                        style: TextStyle(color: Colors.white70, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, color: Colors.white30, size: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ... конец файла

