// lib/screens/feed_screen.dart

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovequest/cubit/app_cubit.dart';
import 'package:lovequest/cubit/feed_cubit.dart';
import 'package:lovequest/l10n/generated/app_localizations.dart'; // <-- Импорт
import 'package:lovequest/repositories/api_repository.dart';
import 'package:lovequest/src/data/models/feed_event.dart';
import 'package:lovequest/widgets/common/animated_cosmic_background.dart';

import '../services/logger_service.dart';

// --- ПРОВАЙДЕР ДЛЯ FEED_CUBIT ---
class FeedScreenProvider extends StatelessWidget {
  const FeedScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final userId = context.read<AppCubit>().state.currentUserProfile?.id;

    if (userId == null) {
      return Scaffold(body: Center(child: Text(l10n.errorUserNotFound))); // "Ошибка: пользователь не найден"
    }

    return BlocProvider(
      create: (context) => FeedCubit(
        apiRepository: context.read<ApiRepository>(),
        userId: userId,
      )..loadFeed(),
      child: const FeedScreen(),
    );
  }
}

// --- САМ ЭКРАН ЛЕНТЫ ---
class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  Timer? _feedUpdateTimer;

  @override
  void initState() {
    super.initState();
    _startFeedTimer();
  }

  @override
  void dispose() {
    _stopFeedTimer();
    super.dispose();
  }

  void _loadFeed() {
    if (mounted) {
      context.read<FeedCubit>().loadFeed();
    }
  }

  void _startFeedTimer() {
    _feedUpdateTimer?.cancel();
    _feedUpdateTimer = Timer.periodic(const Duration(seconds: 15), (timer) {
      logger.d("--- [FEED TIMER] 15 секунд прошло. Обновляю ленту... ---");
      _loadFeed();
    });
  }

  void _stopFeedTimer() {
    _feedUpdateTimer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.cosmicPulseTitle), // "Космический Пульс"
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: AnimatedCosmicBackground(
        child: BlocConsumer<FeedCubit, FeedState>(
          listener: (context, state) {
            if (state is FeedError) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(content: Text("${l10n.feedUpdateError}: ${state.message}"))); // "Ошибка обновления ленты"
            }
          },
          builder: (context, state) {
            // Начальная загрузка
            if (state is FeedLoading && state.events.isEmpty) {
              return const Center(child: CupertinoActivityIndicator(radius: 14));
            }
            // Ошибка при первой загрузке
            if (state is FeedError && state.events.isEmpty) {
              return Center(child: Text(state.message, style: const TextStyle(color: Colors.red)));
            }
            // Лента пуста
            if (state.events.isEmpty) {
              return RefreshIndicator(
                onRefresh: () async => context.read<FeedCubit>().loadFeed(),
                child: Stack(
                  children: [
                    Center(child: Text(l10n.feedEmptyMessage, textAlign: TextAlign.center)), // "В вашей ленте пока пусто..."
                    ListView(),
                  ],
                ),
              );
            }

            // Лента загружена
            return RefreshIndicator(
              onRefresh: () async => context.read<FeedCubit>().loadFeed(),
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 100, bottom: 20),
                itemCount: state.events.length,
                itemBuilder: (context, index) {
                  final event = state.events[index];
                  return _buildEventCard(context, event);
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildEventCard(BuildContext context, FeedEvent event) {
    switch (event) {
      case final PartnerOfTheDayEvent partnerEvent:
        return _PartnerOfTheDayWidget(event: partnerEvent);
      case final CompatibilityPeakEvent compatEvent:
        return _CompatibilityPeakWidget(event: compatEvent);
      case final OrbitCrossingEvent orbitEvent:
        return _OrbitCrossingWidget(event: orbitEvent);
      case final simpleEvent when simpleEvent.type == 'GEOMAGNETIC_STORM':
        return _GeomagneticStormWidget(event: simpleEvent);
      case final simpleEvent when simpleEvent.type == 'NEW_LIKE':
        return _NewLikeWidget(event: simpleEvent);
      case final simpleEvent when simpleEvent.type == 'SHARED_CARD_OF_THE_DAY':
        return _SharedCardWidget(event: simpleEvent);
      default:
        return _SimpleEventWidget(event: event);
    }
  }
}

// ... Виджеты карточек (оставляем без изменений, т.к. тексты приходят с сервера) ...
// (Код виджетов карточек можно оставить как есть, он берет тексты из объекта event)

class _SimpleEventWidget extends StatelessWidget {
  final FeedEvent event;
  const _SimpleEventWidget({required this.event});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: const Icon(Icons.auto_awesome_outlined),
        title: Text(event.title),
        subtitle: Text(event.description),
        onTap: () => context.read<AppCubit>().handleFeedEventAction(context, event),
      ),
    );
  }
}

class _NewLikeWidget extends StatelessWidget {
  final FeedEvent event;
  const _NewLikeWidget({required this.event});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      color: Colors.pink.shade900.withOpacity(0.5),
      child: ListTile(
        leading: const Icon(Icons.favorite, color: Colors.pinkAccent),
        title: Text(event.title, style: const TextStyle(color: Colors.pinkAccent)),
        subtitle: Text(event.description, style: const TextStyle(color: Colors.white70)),
        onTap: () => context.read<AppCubit>().handleFeedEventAction(context, event),
      ),
    );
  }
}

class _GeomagneticStormWidget extends StatelessWidget {
  final FeedEvent event;
  const _GeomagneticStormWidget({required this.event});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      color: Colors.red[900]?.withOpacity(0.5),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.redAccent.withOpacity(0.7), width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: const Icon(Icons.warning_amber_rounded, size: 40, color: Colors.amberAccent),
        title: Text(event.title, style: const TextStyle(color: Colors.amberAccent, fontWeight: FontWeight.bold)),
        subtitle: Text(event.description, style: const TextStyle(color: Colors.white)),
        onTap: () => context.read<AppCubit>().handleFeedEventAction(context, event),
      ),
    );
  }
}

class _PartnerOfTheDayWidget extends StatelessWidget {
  final PartnerOfTheDayEvent event;
  const _PartnerOfTheDayWidget({required this.event});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundImage: event.partnerAvatarUrl != null ? NetworkImage(event.partnerAvatarUrl!) : null,
          child: event.partnerAvatarUrl == null ? const Icon(Icons.person) : null,
        ),
        title: Text(event.title),
        subtitle: Text(event.description),
        onTap: () => context.read<AppCubit>().handleFeedEventAction(context, event),
      ),
    );
  }
}

class _SharedCardWidget extends StatelessWidget {
  final FeedEvent event;
  const _SharedCardWidget({required this.event});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      color: const Color(0xFF4a4e69).withOpacity(0.7),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: const Color(0xFF9a8c98).withOpacity(0.7), width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.style, size: 30, color: Color(0xFFc9ada7)),
          ],
        ),
        title: Text(
            event.title,
            style: const TextStyle(color: Color(0xFFf2e9e4), fontWeight: FontWeight.bold)
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
              event.description,
              style: const TextStyle(color: Color(0xFFc9ada7), height: 1.4)
          ),
        ),
        trailing: event.actionButtonText != null
            ? const Icon(Icons.arrow_forward_ios, color: Color(0xFFf2e9e4))
            : null,
        onTap: () => context.read<AppCubit>().handleFeedEventAction(context, event),
      ),
    );
  }
}

class _CompatibilityPeakWidget extends StatelessWidget {
  final CompatibilityPeakEvent event;
  const _CompatibilityPeakWidget({required this.event});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      color: Colors.deepPurple[800],
      child: ListTile(
        leading: const Icon(Icons.star_purple500_outlined, size: 40, color: Colors.white),
        title: Text(event.title, style: const TextStyle(color: Colors.white)),
        subtitle: Text(event.description, style: const TextStyle(color: Colors.white70)),
        onTap: () => context.read<AppCubit>().handleFeedEventAction(context, event),
      ),
    );
  }
}

class _OrbitCrossingWidget extends StatelessWidget {
  final OrbitCrossingEvent event;
  const _OrbitCrossingWidget({required this.event});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.cyan.withOpacity(0.5), width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: const Icon(Icons.radar, size: 40, color: Colors.cyan),
        title: Text(event.title, style: const TextStyle(color: Colors.cyan)),
        subtitle: Text(event.description),
        onTap: () => context.read<AppCubit>().handleFeedEventAction(context, event),
      ),
    );
  }
}