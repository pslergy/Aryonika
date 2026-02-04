// lib/screens/oracle_screen.dart
import 'dart:async';
import 'package:flutter/foundation.dart' show kIsWeb, defaultTargetPlatform, listEquals;
import 'package:flutter/gestures.dart';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:lovequest/cubit/app_cubit.dart';
import 'package:lovequest/cubit/app_state.dart';
import 'package:lovequest/l10n/generated/app_localizations.dart'; // <-- Импорт локализации

import 'package:lovequest/src/data/models/enums.dart';
import 'package:lovequest/utils/value_wrapper.dart';
import 'package:lovequest/widgets/common/animated_cosmic_background.dart';
import 'package:lovequest/widgets/common/glassmorphic_card.dart';
import 'package:lovequest/widgets/common/neon_glow_button.dart';
import 'package:lovequest/widgets/oracle/interactive_orb.dart';
import 'package:lovequest/widgets/oracle/pulsating_oracle_stone.dart';
import 'package:lovequest/widgets/search/profile_card.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../services/logger_service.dart';
import '../src/data/models/daily_hybrid_forecast.dart';
import '../src/data/models/geomagnetic_forecast.dart';
import '../src/data/models/tarot_card.dart';
import '../widgets/common/alpha_version_banner.dart';
import '../widgets/common/web_unsupported_placeholder.dart';

import '../widgets/oracle/animated_oracle_text.dart';
import '../widgets/tarot/flippable_tarot_card.dart';

enum OracleFocus {
  none, partner, roulette, duet, horoscope, oracleQuestion, focusOfTheDay,
  dailyForecast, tarotQuestion, geomagnetic, cardOfTheDay, palmistry,
}

IconData _getIconForKp(KpLevel level) {
  switch (level) {
    case KpLevel.calm:
    case KpLevel.unsettled:
      return Icons.shield_moon_outlined;
    case KpLevel.active:
    case KpLevel.minorStorm:
    case KpLevel.moderateStorm:
      return Icons.warning_amber_rounded;
    case KpLevel.strongStorm:
    case KpLevel.severeStorm:
    case KpLevel.extremeStorm:
      return Icons.flare_rounded;
  }
}

Color _getColorForKp(KpLevel level) {
  switch (level) {
    case KpLevel.calm:
    case KpLevel.unsettled:
      return Colors.greenAccent;
    case KpLevel.active:
    case KpLevel.minorStorm:
    case KpLevel.moderateStorm:
      return Colors.amberAccent;
    case KpLevel.strongStorm:
    case KpLevel.severeStorm:
    case KpLevel.extremeStorm:
      return Colors.redAccent;
  }
}

class OracleScreen extends StatefulWidget {
  final OracleFocus initialFocus;
  const OracleScreen({super.key, this.initialFocus = OracleFocus.horoscope});
  @override
  State<OracleScreen> createState() => _OracleScreenState();
}

class _OracleScreenState extends State<OracleScreen> {
  OracleFocus _currentFocus = OracleFocus.horoscope;
  String _selectedHoroscopeTab = 'common';

  @override
  void initState() {
    super.initState();
    context.read<AppCubit>().onOracleTabOpened();
    _currentFocus = widget.initialFocus;
  }

  void _setFocus(OracleFocus focus) {
    setState(() => _currentFocus = _currentFocus == focus ? OracleFocus.none : focus);
  }

  void _closeFocus() {
    setState(() => _currentFocus = OracleFocus.none);
  }

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not launch $urlString')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocListener<AppCubit, AppState>(
      listenWhen: (p, c) =>
      (p.oracleLimitMessage != c.oracleLimitMessage && c.oracleLimitMessage != null) ||
          (p.tarotLimitMessage != c.tarotLimitMessage && c.tarotLimitMessage != null),
      listener: (context, state) {

        final wrapper = state.oracleLimitMessage ?? state.tarotLimitMessage;
        if (wrapper == null) return;

        final rawCode = wrapper.value;
        if (rawCode == null) return;

        String displayMessage = rawCode;

        if (rawCode.startsWith('LIMIT_PRO:')) {
          final parts = rawCode.split(':');
          final hours = parts.length > 1 ? parts[1] : '0';
          displayMessage = l10n.oracle_limit_pro(hours);
        } else if (rawCode.startsWith('LIMIT_FREE:')) {
          final parts = rawCode.split(':');
          final days = parts.length > 1 ? parts[1] : '0';
          displayMessage = l10n.oracle_limit_free(days);
        } else if (rawCode == 'ERROR_STREAM') {
          displayMessage = l10n.oracle_error_stream;
        } else if (rawCode == 'ERROR_START') {
          displayMessage = l10n.oracle_error_start;
        }

        showDialog<void>(
          context: context,
          builder: (dialogContext) => AlertDialog(
            backgroundColor: const Color(0xFF2c2c54),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: Text(l10n.oracle_limit_title, style: const TextStyle(color: Colors.white)),
            content: Text(displayMessage, style: const TextStyle(color: Colors.white70)),
            actions: <Widget>[
              TextButton(
                  child: Text(l10n.close, style: const TextStyle(color: Colors.cyanAccent)), // Используем существующий "Закрыть"
                  onPressed: () => Navigator.of(dialogContext).pop()
              ),
              if (rawCode.startsWith('LIMIT_FREE:'))
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent, foregroundColor: Colors.white),
                  child: Text(l10n.oracle_limit_get_pro),
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                    context.push('/paywall');
                  },
                ),
            ],
          ),
        ).then((_) {
          context.read<AppCubit>().clearOracleLimitMessage();
          context.read<AppCubit>().clearTarotLimitMessage();
        });
      },
      child: Scaffold(
        body: AnimatedCosmicBackground(
          child: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 800) {
                  return _buildWideLayout();
                } else {
                  return _buildNarrowLayout();
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWideLayout() {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      children: [
        SizedBox(
          width: 300,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(l10n.oracle_title, style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white)),
              ),
              const _GeomagneticForecastBar(),
              const Divider(color: Colors.white24, height: 1),
              Expanded(
                child: _OrbList(
                  currentFocus: _currentFocus,
                  onOrbSelected: (focus) => setState(() => _currentFocus = focus),
                ),
              ),
              if (kIsWeb)
                const _AppStoreLinks(),
            ],
          ),
        ),
        const VerticalDivider(width: 1, thickness: 1, color: Colors.white24),
        Expanded(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
            child: Container(
              key: ValueKey(_currentFocus),
              child: _buildFocusedContent(_currentFocus),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNarrowLayout() {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        SingleChildScrollView(
          child: Column(children: const [
            _GeomagneticForecastBar(),
            Padding(padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0), child: _AstroCommunicationTipsCard()),
            AlphaVersionBanner(telegramChannelUrl: 'https://t.me/NumeroPlatform'),
          ]),
        ),
        Expanded(
          child: Stack(
            children: [
              AnimatedOpacity(
                duration: const Duration(milliseconds: 400),
                opacity: _currentFocus == OracleFocus.none ? 1.0 : 0.0,
                child: IgnorePointer(
                  ignoring: _currentFocus != OracleFocus.none,
                  child: _OrbCarousel(onOrbSelected: _setFocus),
                ),
              ),

              if (_currentFocus != OracleFocus.none)
                _FocusedContentMobile(
                  content: _buildFocusedContent(_currentFocus),
                  onClose: _closeFocus,
                ),
              if (kIsWeb)
                const _AppStoreLinks()
              else
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: TextButton.icon(
                    icon: const Icon(Icons.language, color: Colors.cyanAccent),
                    label: Text(
                        l10n.open_web_version, // "Открыть WEB версию"
                        style: const TextStyle(color: Colors.cyanAccent)
                    ),
                    onPressed: () {
                      _launchUrl('https://psylergy.com');
                    },
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  String _translateGeomagneticDesc(String key, AppLocalizations l10n) {
    switch (key) {
      case 'geomagnetic_calm': return l10n.geomagnetic_calm;
      case 'geomagnetic_unsettled': return l10n.geomagnetic_unsettled;
      case 'geomagnetic_active': return l10n.geomagnetic_active;
      case 'geomagnetic_storm_minor': return l10n.geomagnetic_storm_minor;
      case 'geomagnetic_storm_moderate': return l10n.geomagnetic_storm_moderate;
      case 'geomagnetic_storm_strong': return l10n.geomagnetic_storm_strong;
      case 'geomagnetic_storm_severe': return l10n.geomagnetic_storm_severe;
      case 'geomagnetic_storm_extreme': return l10n.geomagnetic_storm_extreme;
      default: return key;
    }
  }

  Widget _buildFocusedContent(OracleFocus focus) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        final l10n = AppLocalizations.of(context)!;
        final focusToShow = (focus == OracleFocus.none) ? OracleFocus.horoscope : focus;
        Widget content;

        switch (focusToShow) {
          case OracleFocus.partner:
            content = _buildPartnerContent(state, l10n);
            break;
          case OracleFocus.roulette:
            content = _buildRouletteContent(state, l10n);
            break;
          case OracleFocus.cardOfTheDay:
            content = _ProFeatureLockWrapper(
              isPro: state.isProUser,
              proChild: const _CardOfTheDayView(),
              nonProChild: _ProFeatureLock(icon: Icons.style, title: l10n.oracle_pro_card_of_day_title, description: l10n.oracle_pro_card_of_day_desc),
            );
            break;

          case OracleFocus.focusOfTheDay:
            content = _ProFeatureLockWrapper(
              isPro: state.isProUser,
              proChild: _FocusOfTheDayWidget(state: state, l10n: l10n),
              nonProChild: _ProFeatureLock(icon: Icons.track_changes, title: l10n.oracle_pro_focus_of_day_title, description: l10n.oracle_pro_focus_of_day_desc),
            );
            break;

          case OracleFocus.dailyForecast:
            content = _ProFeatureLockWrapper(
              isPro: state.isProUser,
              proChild: const _AstrologicalForecastView(),
              nonProChild: _ProFeatureLock(icon: Icons.today, title: l10n.oracle_pro_forecast_of_day_title, description: l10n.oracle_pro_forecast_of_day_desc),
            );
            break;
          case OracleFocus.horoscope:
            content = _buildHoroscopeContent(state, l10n);
            break;
          case OracleFocus.tarotQuestion:
            content = const _TarotQuestionInput();
            break;
          case OracleFocus.oracleQuestion:
            content = _buildOracleQuestionContent();
            break;
          case OracleFocus.duet:
            content = _buildDuetContent(state, l10n);
            break;
          case OracleFocus.geomagnetic:
            content = _buildGeomagneticContent(state, l10n);
            break;
          case OracleFocus.palmistry:
            content = _buildPalmistryContent(l10n);
            break;
          case OracleFocus.none:
            content = _buildHoroscopeContent(state, l10n);
        }

        return Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32.0),
            child: content,
          ),
        );
      },
    );
  }

  Widget _buildGeomagneticContent(AppState state, AppLocalizations l10n) {
    // 1. Проверяем статус загрузки
    if (state.geomagneticForecastStatus == LoadingState.loading) {
      return PulsatingOracleStone(text: l10n.loading); // "Загрузка..."
    }

    // 2. Проверяем ошибку
    if (state.geomagneticForecastStatus == LoadingState.error) {
      return _InfoContent(icon: Icons.error_outline, text: l10n.oracle_focus_error); // "Ошибка загрузки"
    }

    // 3. Проверяем пустоту
    if (state.geomagneticForecast.isEmpty) {
      return _InfoContent(icon: Icons.signal_cellular_off, text: l10n.oracle_focus_no_data); // "Нет данных"
    }

    final currentForecast = state.geomagneticForecast.first;
    final nextForecasts = state.geomagneticForecast.skip(1).take(5).toList();
    final color = _getColorForKp(currentForecast.level);

    // Переводим описание текущего состояния
    final currentDescTranslated = _translateGeomagneticDesc(currentForecast.description, l10n);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(l10n.oracle_geomagnetic_title, style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),

        // Текущее состояние
        Text(
          l10n.oracle_geomagnetic_now(currentDescTranslated),
          style: TextStyle(fontSize: 18, color: color, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
            l10n.oracle_geomagnetic_index(currentForecast.kpValue.toString()),
            style: const TextStyle(color: Colors.white70)
        ),

        const Divider(height: 32, color: Colors.white24),

        // Прогноз
        Text(l10n.oracle_geomagnetic_forecast, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),

        ...nextForecasts.map((forecast) {
          // Переводим описание для каждого элемента прогноза
          final descTranslated = _translateGeomagneticDesc(forecast.description, l10n);

          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    DateFormat.Hm(l10n.localeName).format(forecast.time), // Используем локаль для времени
                    style: const TextStyle(color: Colors.white70)
                ),
                Expanded(
                  child: Text(
                    descTranslated,
                    style: TextStyle(color: _getColorForKp(forecast.level)),
                    textAlign: TextAlign.right,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildDuetContent(AppState state, AppLocalizations l10n) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(l10n.oracle_duet_title, style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Text(l10n.oracle_duet_description, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white70)),
        const SizedBox(height: 24),
        NeonGlowButton(
          text: l10n.oracle_duet_button,
          glowColor: Colors.amber,
          onPressed: () {
            _setFocus(OracleFocus.none);
            context.push('/manual_compatibility');
          },
        ),
      ],
    );
  }

  Widget _buildRouletteContent(AppState state, AppLocalizations l10n) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(l10n.oracle_roulette_title, style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Text(l10n.oracle_roulette_description, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white70)),
        const SizedBox(height: 24),
        NeonGlowButton(
          text: l10n.oracle_roulette_button,
          glowColor: Colors.orangeAccent,
          onPressed: () {
            context.push('/roulette');
            Future.delayed(const Duration(milliseconds: 100), () {
              if (mounted) _setFocus(OracleFocus.none);
            });
          },
        ),
      ],
    );
  }

  Widget _buildPalmistryContent(AppLocalizations l10n) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(l10n.oracle_palmistry_title, style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Text(l10n.oracle_palmistry_description, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white70)),
        const SizedBox(height: 24),
        NeonGlowButton(
          text: l10n.oracle_palmistry_button,
          glowColor: Colors.purpleAccent,
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(l10n.feature_in_development), // "В разработке"
                backgroundColor: Colors.blueGrey,
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildOracleQuestionContent() {
    return BlocBuilder<AppCubit, AppState>(
      buildWhen: (p, c) => p.isOracleAnswering != c.isOracleAnswering || p.oracleAnswer != c.oracleAnswer,
      builder: (context, state) => AnimatedSwitcher(duration: const Duration(milliseconds: 400), child: _buildCurrentOracleWidget(state)),
    );
  }

  Widget _buildCurrentOracleWidget(AppState state) {
    final l10n = AppLocalizations.of(context)!;
    if (state.isOracleAnswering) return PulsatingOracleStone(key: const ValueKey('loading'), text: l10n.oracle_ask_loading);
    if (state.oracleAnswer != null) {
      return Column(
        key: ValueKey(state.oracleAnswer),
        children: [
          DefaultTextStyle(
            style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w400, fontStyle: FontStyle.italic, height: 1.6, color: Colors.white, shadows: [Shadow(blurRadius: 10.0, color: Colors.black54)]),
            textAlign: TextAlign.center,
            child: AnimatedOracleText(text: state.oracleAnswer!),
          ),
          const SizedBox(height: 32),
          TextButton(onPressed: () => context.read<AppCubit>().resetOracle(), child: Text(l10n.oracle_ask_again, style: const TextStyle(color: Colors.pinkAccent)))
              .animate().fadeIn(delay: 3.seconds, duration: 500.ms),
        ],
      );
    }
    return const _OracleQuestionInput(key: ValueKey('input'));
  }

  Widget _buildPartnerContent(AppState state, AppLocalizations l10n) {
    if (!state.isProUser) return _ProFeatureLock(icon: Icons.favorite, title: l10n.oracle_pro_feature_title, description: l10n.oracle_pro_feature_desc);
    switch (state.partnerLoadingState) {
      case LoadingState.loading: return PulsatingOracleStone(text: l10n.oracle_partner_loading);
      case LoadingState.error: return _InfoContent(icon: Icons.error_outline, text: l10n.oracle_partner_error);
      case LoadingState.notFound: return _InfoContent(icon: Icons.sentiment_dissatisfied, text: l10n.oracle_partner_not_found);
      case LoadingState.success:
        if (state.partnerOfTheDay == null) return _InfoContent(icon: Icons.error, text: l10n.oracle_partner_profile_error);
        return Column(
          children: [
            Text(l10n.oracle_partner_title, style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(l10n.oracle_partner_compatibility(state.partnerOfTheDay!.compatibilityScore.toString()), style: const TextStyle(color: Colors.pinkAccent, fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ProfileCard(
              profile: state.partnerOfTheDay!, isPro: state.partnerOfTheDay!.isProUser, isLiked: state.likedUserIds.contains(state.partnerOfTheDay!.id),
              onLikeClick: () => context.read<AppCubit>().onLikeClicked(state.partnerOfTheDay!.id),
              onCardClick: () => context.push('/user_profile/${state.partnerOfTheDay!.id}'),
            ),
          ],
        ).animate().fadeIn();
      default: return const SizedBox.shrink();
    }
  }

  Widget _buildHoroscopeContent(AppState state, AppLocalizations l10n) {
    final horoscopeState = state.horoscopeState;
    final horoscope = state.horoscope;

    if (horoscopeState.isLoading) return PulsatingOracleStone(text: l10n.oracle_ask_loading);

    if (horoscopeState.error != null) {
      return _InfoContent(icon: Icons.warning_amber_rounded, text: horoscopeState.error!);
    }

    if (horoscope != null) {
      String textToShow;
      switch (_selectedHoroscopeTab) {
        case 'love': textToShow = horoscope.love; break;
        case 'business': textToShow = horoscope.business; break;
        default: textToShow = horoscope.common;
      }

      return Container(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
                l10n.oracle_orb_horoscope,
                style: const TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold)
            ),
            const SizedBox(height: 24),

            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(30),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildTabButton(Icons.auto_awesome, 'common', l10n),
                    _buildTabButton(Icons.favorite, 'love', l10n),
                    _buildTabButton(Icons.work, 'business', l10n),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
              child: Text(
                textToShow,
                key: ValueKey(_selectedHoroscopeTab),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 16, height: 1.6),
              ),
            ),
          ],
        ),
      );
    }

    return _InfoContent(icon: Icons.help_outline, text: l10n.oracle_focus_no_data);
  }

  Widget _buildTabButton(IconData icon, String key, AppLocalizations l10n) {
    final isSelected = _selectedHoroscopeTab == key;
    return GestureDetector(
      onTap: () => setState(() => _selectedHoroscopeTab = key),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.purpleAccent.withOpacity(0.3) : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          border: isSelected ? Border.all(color: Colors.purpleAccent, width: 1) : null,
        ),
        child: Icon(
          icon,
          color: isSelected ? Colors.white : Colors.white54,
          size: 24,
        ),
      ),
    );
  }
}

// ... _GeomagneticForecastBar ...
class _GeomagneticForecastBar extends StatelessWidget {
  const _GeomagneticForecastBar();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocBuilder<AppCubit, AppState>(
      buildWhen: (p, c) => p.geomagneticForecastStatus != c.geomagneticForecastStatus,
      builder: (context, state) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: SizeTransition(sizeFactor: animation, child: child)),
          child: _buildContent(state, l10n),
        );
      },
    );
  }

  Widget _buildContent(AppState state, AppLocalizations l10n) {
    if (state.geomagneticForecastStatus != LoadingState.success || state.geomagneticForecast.isEmpty) {
      return const SizedBox.shrink(key: ValueKey('empty'));
    }
    final currentForecast = state.geomagneticForecast.first;
    final color = _getColorForKp(currentForecast.level);
    return Container(
      key: const ValueKey('forecast'),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(_getIconForKp(currentForecast.level), color: color, size: 20),
          const SizedBox(width: 12),
          Flexible(
            child: Text(l10n.oracle_weather_title, style: TextStyle(color: Colors.white.withOpacity(0.8)), overflow: TextOverflow.ellipsis),
          ),
          Flexible(
            child: Text(
              l10n.oracle_weather_desc(currentForecast.description, currentForecast.kpValue.toString()),
              style: TextStyle(color: color, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProFeatureLock extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  const _ProFeatureLock({required this.icon, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 48, color: Colors.yellow),
        const SizedBox(height: 16),
        Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.yellow)),
        const SizedBox(height: 8),
        Text(description, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white70)),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: () => context.push('/paywall'),
          child: Text(l10n.oracle_limit_get_pro),
        )
      ],
    );
  }
}

// ... _CardOfTheDayView, _OracleQuestionInput ...
class _CardOfTheDayView extends StatelessWidget {
  const _CardOfTheDayView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        if (state.cardOfTheDayStatus == LoadingState.loading) {
          return PulsatingOracleStone(text: l10n.cardOfTheDayDrawing);
        }

        if (state.cardOfTheDay == null) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n.cardOfTheDayDefaultInterpretation,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white70, fontSize: 16),
              ),
              const SizedBox(height: 24),
              NeonGlowButton(
                text: l10n.cardOfTheDayGetButton,
                onPressed: () => context.read<AppCubit>().drawCardOfTheDay(),
              ),
            ],
          );
        }

        final card = state.cardOfTheDay!;
        final isFlipped = state.isCardOfTheDayFlipped;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isFlipped ? l10n.cardOfTheDayYourCard : l10n.cardOfTheDayTapToReveal,
              style: const TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: 150,
              height: 260,
              child: FlippableTarotCard(
                card: card,
                isFlipped: isFlipped,
                onCardFlip: () => context.read<AppCubit>().flipCardOfTheDay(),
              ),
            ),
            const SizedBox(height: 24),

            AnimatedSwitcher(
              duration: const Duration(milliseconds: 600),
              child: isFlipped
                  ? _buildResultCard(context, state, l10n)
                  : const SizedBox.shrink(),
            ),
          ],
        );
      },
    );
  }

  Widget _buildResultCard(BuildContext context, AppState state, AppLocalizations l10n) {
    final card = state.cardOfTheDay!;
    final baseInterpretation = card.isReversed ? card.reversedInterpretation : card.interpretation;
    final personalKey = state.cardOfTheDayInterpretation;

    return Card(
      key: ValueKey(card.id),
      color: Colors.white.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "${card.name}${card.isReversed ? l10n.cardOfTheDayReversedSuffix : ''}",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.yellowAccent),
              textAlign: TextAlign.center,
            ),
            const Divider(height: 24, color: Colors.white24),
            Text(
              personalKey ?? baseInterpretation,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontStyle: FontStyle.italic, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}

class _OracleQuestionInput extends StatefulWidget {
  const _OracleQuestionInput({super.key});

  @override
  State<_OracleQuestionInput> createState() => _OracleQuestionInputState();
}

class _OracleQuestionInputState extends State<_OracleQuestionInput> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      key: const ValueKey('idle'),
      children: [
        Text(l10n.oracle_question_title, style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        TextField(
          controller: _controller,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: l10n.oracle_question_hint,
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
            filled: true,
            fillColor: Colors.white.withOpacity(0.1),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0), borderSide: BorderSide.none),
          ),
          maxLines: 3,
        ),
        const SizedBox(height: 24),
        NeonGlowButton(
          text: l10n.oracle_question_button,
          glowColor: Colors.tealAccent,
          onPressed: () {
            if (_controller.text.trim().isNotEmpty) {
              FocusScope.of(context).unfocus();
              context.read<AppCubit>().askOracle(_controller.text.trim());
            }
          },
        ),
      ],
    );
  }
}

// ... _AstroCommunicationTipsCard, _InfoContent, _AstrologicalForecastView, _FocusOfTheDayWidget ...
// (эти виджеты уже используют l10n или не требуют перевода)

class _AstroCommunicationTipsCard extends StatefulWidget {
  const _AstroCommunicationTipsCard();

  @override
  State<_AstroCommunicationTipsCard> createState() => _AstroCommunicationTipsCardState();
}

class _AstroCommunicationTipsCardState extends State<_AstroCommunicationTipsCard> {
  bool _isExpanded = false;
  LoadingState _loadingState = LoadingState.loading;
  List<String> _dailyTips = [];
  StreamSubscription<AppState>? _appStateSubscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _processState(context.read<AppCubit>().state);
        _appStateSubscription = context.read<AppCubit>().stream.listen(_processState);
      }
    });
  }

  void _processState(AppState state) {
    final l10n = AppLocalizations.of(context)!;
    if (!mounted) return;
    final forecast = state.dailyForecast;
    final tipsData = state.astroCommunicationTips;
    if (forecast != null && tipsData.isNotEmpty) {
      final List<String> calculatedTips = [];
      final interpretationsToAnalyze = forecast.interpretations;
      for (final interpretation in interpretationsToAnalyze) {
        final key = interpretation.key;
        if (tipsData.containsKey(key)) calculatedTips.add(tipsData[key]!);
        if (calculatedTips.length >= 3) break;
      }
      if (calculatedTips.isEmpty) {
        calculatedTips.add(tipsData['general_advice'] ?? l10n.oracle_tips_general_advice);
      }
      if (!listEquals(_dailyTips, calculatedTips)) {
        setState(() { _dailyTips = calculatedTips; _loadingState = LoadingState.success; });
      }
    }
  }

  @override
  void dispose() {
    _appStateSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (_loadingState == LoadingState.loading) {
      return Card(
        color: Colors.white.withOpacity(0.1),
        child: ListTile(
          leading: const CircularProgressIndicator(strokeWidth: 2),
          title: Text(l10n.oracle_tips_loading),
        ),
      );
    }
    return Card(
      color: Colors.white.withOpacity(0.1),
      clipBehavior: Clip.antiAlias,
      child: AnimatedSize(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: Column(
          children: [
            InkWell(
              onTap: () => setState(() => _isExpanded = !_isExpanded),
              child: ListTile(
                leading: const Icon(Icons.connect_without_contact, color: Colors.cyanAccent),
                title: Text(l10n.oracle_tips_title, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: !_isExpanded ? Text(l10n.oracle_tips_subtitle(_dailyTips.length.toString()), style: const TextStyle(color: Colors.white70)) : null,
                trailing: Icon(_isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, color: Colors.white70),
              ),
            ),
            if (_isExpanded)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Column(
                  children: [
                    const Divider(height: 1, color: Colors.white24),
                    const SizedBox(height: 16),
                    ..._dailyTips.map((tip) => Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 4.0, right: 8.0),
                            child: Icon(Icons.star_purple500_outlined, size: 16, color: Colors.yellowAccent),
                          ),
                          Expanded(child: Text(tip, style: const TextStyle(height: 1.5))),
                        ],
                      ),
                    )).toList(),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _InfoContent extends StatelessWidget {
  final IconData icon;
  final String text;
  const _InfoContent({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 48, color: Colors.white54),
        const SizedBox(height: 16),
        Text(text, style: const TextStyle(color: Colors.white70), textAlign: TextAlign.center),
      ],
    );
  }
}

class _AstrologicalForecastView extends StatelessWidget {
  const _AstrologicalForecastView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<AppCubit, AppState>(
      buildWhen: (p, c) => p.dailyForecastLoadingState != c.dailyForecastLoadingState || p.dailyForecast != c.dailyForecast,
      builder: (context, state) {
        switch (state.dailyForecastLoadingState) {
          case LoadingState.loading:
            return PulsatingOracleStone(text: l10n.forecast_loading);
          case LoadingState.error:
            return _InfoContent(icon: Icons.error, text: l10n.forecast_error);
          case LoadingState.success:
            final forecast = state.dailyForecast;
            if (forecast == null || forecast.interpretations.isEmpty) {
              return _InfoContent(icon: Icons.shield_moon_outlined, text: l10n.forecast_no_aspects);
            }
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  l10n.forecast_astrological_title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                ...forecast.interpretations.map((interp) {
                  final color = interp.category == 'challenge' ? Colors.orangeAccent : Colors.cyanAccent;
                  return Card(
                    color: Colors.white.withOpacity(0.1),
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            interp.title,
                            style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const Divider(height: 16, color: Colors.white24),
                          Text(
                            interp.text,
                            style: const TextStyle(color: Colors.white70, height: 1.5),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ],
            );
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}

class _FocusOfTheDayWidget extends StatelessWidget {
  final AppState state;
  final AppLocalizations l10n;
  const _FocusOfTheDayWidget({required this.state, required this.l10n});
  @override
  Widget build(BuildContext context) {
    switch (state.focusLoadingState) {
      case LoadingState.loading: return PulsatingOracleStone(text: l10n.oracle_focus_loading);
      case LoadingState.error: return _InfoContent(icon: Icons.error_outline, text: l10n.oracle_focus_error);
      case LoadingState.success:
        final focus = state.focusOfTheDay;
        if (focus == null) return _InfoContent(icon: Icons.search_off, text: l10n.oracle_focus_no_data);
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(focus.title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 22, color: Colors.cyanAccent, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Text(focus.text, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, height: 1.6, fontSize: 16)),
            if (focus.advice != null) ...[
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: Colors.black.withOpacity(0.3), borderRadius: BorderRadius.circular(8)),
                child: Row(
                  children: [
                    const Icon(Icons.lightbulb_outline, color: Colors.cyanAccent, size: 20),
                    const SizedBox(width: 8),
                    Expanded(child: Text(focus.advice!, style: const TextStyle(color: Colors.cyanAccent, fontWeight: FontWeight.bold))),
                  ],
                ),
              ),
            ],
          ],
        ).animate().fadeIn(duration: 500.ms);
      default: return const SizedBox.shrink();
    }
  }
}

class _OrbCarousel extends StatefulWidget {
  final ValueChanged<OracleFocus> onOrbSelected;
  const _OrbCarousel({required this.onOrbSelected});

  @override
  State<_OrbCarousel> createState() => _OrbCarouselState();
}

class _OrbCarouselState extends State<_OrbCarousel> with TickerProviderStateMixin {
  late final PageController _pageController;
  double _currentPage = 0.0;
  Offset _gyroOffset = Offset.zero;
  StreamSubscription? _gyroSubscription;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.5, initialPage: 0);
    _pageController.addListener(() {
      if (mounted) {
        setState(() { _currentPage = _pageController.page!; });
      }
    });

    if (!kIsWeb && (defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS)) {
      _gyroSubscription = gyroscopeEventStream(
        samplingPeriod: const Duration(milliseconds: 50),
      ).listen((GyroscopeEvent event) {
        if (mounted) {
          setState(() {
            _gyroOffset += Offset(event.y, event.x) * 0.1;
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _gyroSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final orbs = <OracleFocus, Map<String, dynamic>>{
      OracleFocus.partner: {'icon': Icons.favorite_border, 'title': l10n.oracle_orb_partner, 'color1': Colors.pinkAccent, 'color2': Colors.redAccent},
      OracleFocus.roulette: {'icon': Icons.casino_outlined, 'title': l10n.oracle_orb_roulette, 'color1': Colors.orange, 'color2': Colors.deepOrange},
      OracleFocus.duet: {'icon': Icons.people_outline, 'title': l10n.oracle_orb_duet, 'color1': Colors.amber, 'color2': Colors.yellow},
      OracleFocus.horoscope: {'icon': Icons.auto_awesome, 'title': l10n.oracle_orb_horoscope, 'color1': Colors.lightBlueAccent, 'color2': Colors.blue},
      OracleFocus.geomagnetic: {'icon': Icons.public, 'title': l10n.oracle_orb_weather, 'color1': Colors.green, 'color2': Colors.lightGreenAccent},
      OracleFocus.oracleQuestion: {'icon': Icons.question_answer_outlined, 'title': l10n.oracle_orb_ask, 'color1': Colors.greenAccent, 'color2': Colors.teal},
      OracleFocus.focusOfTheDay: {'icon': Icons.track_changes, 'title': l10n.oracle_orb_focus, 'color1': Colors.cyanAccent, 'color2': Colors.cyan},
      OracleFocus.dailyForecast: {'icon': Icons.today, 'title': l10n.oracle_orb_forecast, 'color1': Colors.indigoAccent, 'color2': Colors.indigo},
      OracleFocus.cardOfTheDay: {'icon': Icons.filter_vintage_outlined, 'title': l10n.oracle_orb_card, 'color1': Colors.white, 'color2': Colors.grey},
      OracleFocus.tarotQuestion: {'icon': Icons.style_outlined, 'title': l10n.oracle_orb_tarot, 'color1': Colors.deepPurpleAccent, 'color2': Colors.purple},
      OracleFocus.palmistry: {'icon': Icons.sign_language, 'title': l10n.oracle_orb_palmistry, 'color1': Colors.purpleAccent, 'color2': Colors.deepPurple},
    };
    final orbList = orbs.entries.toList();

    return Listener(
      onPointerSignal: (pointerSignal) {
        if (pointerSignal is PointerScrollEvent) {
          if (pointerSignal.scrollDelta.dy > 0) _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
          else if (pointerSignal.scrollDelta.dy < 0) _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
        }
      },
      child: PageView.builder(
        controller: _pageController,
        itemCount: orbList.length,
        itemBuilder: (context, index) {
          double difference = index - _currentPage;
          double scale = 1 - (difference.abs() * 0.4);
          double opacity = 1 - (difference.abs() * 0.6);
          double rotationY = difference * -0.7;
          return Opacity(
            opacity: max(0.0, opacity),
            child: Transform.scale(
              scale: max(0.2, scale),
              child: Transform(
                transform: Matrix4.identity()..setEntry(3, 2, 0.001)..rotateY(rotationY),
                alignment: FractionalOffset.center,
                child: InteractiveOrb(
                  icon: orbList[index].value['icon'], title: orbList[index].value['title'],
                  color1: orbList[index].value['color1'], color2: orbList[index].value['color2'],
                  onTap: () => widget.onOrbSelected(orbList[index].key),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _OrbList extends StatelessWidget {
  final OracleFocus currentFocus;
  final ValueChanged<OracleFocus> onOrbSelected;

  const _OrbList({required this.currentFocus, required this.onOrbSelected});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final orbs = <OracleFocus, Map<String, dynamic>>{
      OracleFocus.horoscope: {'icon': Icons.auto_awesome, 'title': l10n.oracle_orb_horoscope},
      OracleFocus.cardOfTheDay: {'icon': Icons.filter_vintage_outlined, 'title': l10n.oracle_orb_card},
      OracleFocus.focusOfTheDay: {'icon': Icons.track_changes, 'title': l10n.oracle_orb_focus},
      OracleFocus.dailyForecast: {'icon': Icons.today, 'title': l10n.oracle_orb_forecast},
      OracleFocus.partner: {'icon': Icons.favorite_border, 'title': l10n.oracle_orb_partner},
      OracleFocus.roulette: {'icon': Icons.casino_outlined, 'title': l10n.oracle_orb_roulette},
      OracleFocus.duet: {'icon': Icons.people_outline, 'title': l10n.oracle_orb_duet},
      OracleFocus.geomagnetic: {'icon': Icons.public, 'title': l10n.oracle_orb_weather},
      OracleFocus.oracleQuestion: {'icon': Icons.question_answer_outlined, 'title': l10n.oracle_orb_ask},
      OracleFocus.tarotQuestion: {'icon': Icons.style_outlined, 'title': l10n.oracle_orb_tarot},
      OracleFocus.palmistry: {'icon': Icons.sign_language, 'title': l10n.oracle_orb_palmistry},
    };

    return ListView(
      children: orbs.entries.map((entry) {
        final focus = entry.key;
        final data = entry.value;
        final isSelected = currentFocus == focus;

        return ListTile(
          leading: Icon(data['icon'], color: isSelected ? Theme.of(context).colorScheme.secondary : Colors.white70),
          title: Text(data['title'], style: TextStyle(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal, color: Colors.white)),
          tileColor: isSelected ? Theme.of(context).colorScheme.secondary.withOpacity(0.15) : Colors.transparent,
          onTap: () => onOrbSelected(focus),
        );
      }).toList(),
    );
  }
}

class _FocusedContentMobile extends StatelessWidget {
  final Widget content;
  final VoidCallback onClose;

  const _FocusedContentMobile({
    required this.content,
    required this.onClose
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(onTap: onClose, child: Container(color: Colors.black.withOpacity(0.6))),
        Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32.0),
            child: GlassmorphicCard(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: content,
              ),
            ),
          ),
        ),
        Positioned(top: 16, right: 16, child: IconButton(icon: const Icon(Icons.close, color: Colors.white, size: 30), onPressed: onClose)),
      ],
    ).animate().fadeIn(duration: 500.ms);
  }
}

class _ProFeatureLockWrapper extends StatelessWidget {
  final bool isPro;
  final Widget proChild;
  final Widget nonProChild;

  const _ProFeatureLockWrapper({required this.isPro, required this.proChild, required this.nonProChild});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: isPro ? proChild : nonProChild,
    );
  }
}

class _AppStoreLinks extends StatelessWidget {
  const _AppStoreLinks();

  Widget _buildStoreButton(BuildContext context, {required String asset, required String label, String? url}) {
    final l10n = AppLocalizations.of(context)!;
    final bool isAvailable = url != null;

    return Opacity(
      opacity: isAvailable ? 1.0 : 0.5,
      child: InkWell(
        onTap: isAvailable ? () { /* TODO */ } : null,
        child: Column(
          children: [
            Image.asset(asset, height: 40),
            const SizedBox(height: 4),
            Text(
              isAvailable ? label : l10n.coming_soon,
              style: const TextStyle(fontSize: 10, color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Column(
        children: [
          Text(
            l10n.download_our_app,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStoreButton(context, asset: 'assets/images/stores/google_play.png', label: 'Google Play', url: 'https://...'),
              _buildStoreButton(context, asset: 'assets/images/stores/app_store.png', label: 'App Store', url: null),
              _buildStoreButton(context, asset: 'assets/images/stores/rustore.png', label: 'RuStore', url: null),
              _buildStoreButton(context, asset: 'assets/images/stores/app_gallery.png', label: 'AppGallery', url: null),
            ],
          ),
        ],
      ),
    );
  }
}
class _TarotQuestionInput extends StatefulWidget {
  const _TarotQuestionInput();

  @override
  State<_TarotQuestionInput> createState() => _TarotQuestionInputState();
}

class _TarotQuestionInputState extends State<_TarotQuestionInput> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Метод для показа попапа с описанием карты
  void _showCardDescription(BuildContext context, TarotCard card) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2c2c54), // Твой фирменный цвет фона
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Название карты
              Text(
                card.name,
                style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.amberAccent
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),

              // Положение (Прямая / Перевернутая)
              Text(
                card.isReversed ? "Перевернутая" : "Прямая",
                style: const TextStyle(color: Colors.white54, fontStyle: FontStyle.italic),
              ),
              const Divider(color: Colors.white24, height: 32),

              // Описание
              Text(
                card.isReversed
                    ? (card.reversedInterpretation ?? "Описание отсутствует")
                    : (card.interpretation ?? "Описание отсутствует"),
                style: const TextStyle(color: Colors.white, height: 1.5, fontSize: 16),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 24),

              // Аффирмация (если есть)
              if (card.affirmation != null && card.affirmation!.isNotEmpty) ...[
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: Text(
                    "✨ ${card.affirmation}",
                    style: const TextStyle(color: Colors.tealAccent, fontStyle: FontStyle.italic),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 16),
              ],

              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Закрыть", style: TextStyle(color: Colors.white70)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {

        // ----------------------------------------------------
        // 1. РЕЖИМ ВВОДА ВОПРОСА (IDLE)
        // ----------------------------------------------------
        if (state.tarotReadingState == LoadingState.idle) {
          return Column(
            key: const ValueKey('input_mode'),
            children: [
              Text(
                  l10n.oracle_tarot_title, // "Спроси карты Таро"
                  style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _controller,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: l10n.oracle_tarot_hint, // "Ваш вопрос..."
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.1),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              NeonGlowButton(
                text: l10n.oracle_tarot_button, // "Разложить карты"
                glowColor: Colors.deepPurpleAccent,
                onPressed: () {
                  if (_controller.text.trim().isNotEmpty) {
                    FocusScope.of(context).unfocus();
                    context.read<AppCubit>().startTarotQuestion(_controller.text.trim());
                  }
                },
              ),
            ],
          );
        }

        // ----------------------------------------------------
        // 2. РЕЖИМ РАСКЛАДА (КАРТЫ + РЕЗУЛЬТАТ)
        // ----------------------------------------------------
        return Column(
          key: const ValueKey('reading_mode'),
          children: [
            // Вопрос пользователя
            if (state.tarotQuestion != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Text(
                  l10n.oracle_tarot_your_question(state.tarotQuestion!),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white.withOpacity(0.8), fontStyle: FontStyle.italic, fontSize: 16),
                ),
              ),

            // КАРТЫ (ROW)
            SizedBox(
              height: 240,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: state.tarotReadingCards.map((card) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      // НАШ ГЛАВНЫЙ ОБРАБОТЧИК НАЖАТИЙ
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          final isFlipped = state.flippedCardIds.contains(card.id);

                          if (!isFlipped) {
                            // 1. Если карта рубашкой вверх -> ПЕРЕВОРАЧИВАЕМ
                            context.read<AppCubit>().flipTarotCard(card.id);
                          } else {
                            // 2. Если карта уже открыта -> ПОКАЗЫВАЕМ ОПИСАНИЕ
                            _showCardDescription(context, card);
                          }
                        },
                        // AbsorbPointer ОТКЛЮЧАЕТ встроенные нажатия внутри самой карты,
                        // чтобы они не мешали нашему GestureDetector
                        child: AbsorbPointer(
                          child: FlippableTarotCard(
                            card: card,
                            isFlipped: state.flippedCardIds.contains(card.id),
                            onCardFlip: () {}, // Оставляем пустым, так как AbsorbPointer всё равно это блокирует
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 24),

            // ЗОНА РЕЗУЛЬТАТА (ИИ ОТВЕТ)

            // А. Текст уже есть (печатается или готов)
            if (state.tarotCombinationInterpretation != null && state.tarotCombinationInterpretation!.isNotEmpty)
              GlassmorphicCard(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Text(
                      state.tarotCombinationInterpretation!,
                      // Ключ заставляет Flutter видеть изменения текста для анимации
                      key: ValueKey(state.tarotCombinationInterpretation!.length),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          height: 1.5
                      ),
                    ),
                  ),
                ),
              )
            // Б. Идет загрузка (3 карты открыты, ждем ответа)
            else if (state.tarotReadingState == LoadingState.loading)
              PulsatingOracleStone(text: l10n.oracle_tarot_loading) // "Связь с космосом..."

            // В. Ошибка
            else if (state.tarotReadingState == LoadingState.error)
                Column(
                  children: const [
                    Icon(Icons.error_outline, color: Colors.redAccent, size: 40),
                    SizedBox(height: 8),
                    Text("Ошибка связи с оракулом", style: TextStyle(color: Colors.redAccent)),
                  ],
                ),

            const SizedBox(height: 24),

            // КНОПКА СБРОСА (Только когда завершено или ошибка, или есть текст)
            if (state.tarotReadingState == LoadingState.finished ||
                state.tarotReadingState == LoadingState.error ||
                (state.tarotReadingState == LoadingState.success && state.tarotCombinationInterpretation != null)
            )
              TextButton(
                onPressed: () {
                  _controller.clear();
                  context.read<AppCubit>().resetTarotReading();
                },
                child: Text(
                    l10n.oracle_tarot_ask_again, // "Спросить еще раз"
                    style: const TextStyle(color: Colors.tealAccent, fontSize: 16)
                ),
              ),
          ],
        );
      },
    );
  }
}