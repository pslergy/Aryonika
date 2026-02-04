// lib/screens/cosmic_events_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:lovequest/cubit/app_cubit.dart';
import 'package:lovequest/cubit/app_state.dart';
import 'package:lovequest/l10n/generated/app_localizations.dart';

import 'package:lovequest/src/data/models/cosmic_event.dart';
import 'package:lovequest/src/data/models/enums.dart';
import 'package:lovequest/widgets/common/animated_cosmic_background.dart';



class CosmicEventsScreen extends StatefulWidget {
  const CosmicEventsScreen({super.key});

  @override
  State<CosmicEventsScreen> createState() => _CosmicEventsScreenState();
}

class _CosmicEventsScreenState extends State<CosmicEventsScreen> {

  @override
  void initState() {
    super.initState();
    // --- ГЛАВНОЕ ИСПРАВЛЕНИЕ: Вызываем правильную функцию для загрузки событий ---
    context.read<AppCubit>().loadCosmicEvents();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(l10n.cosmicEvents_title), // <-- Перевод
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: AnimatedCosmicBackground(
        child: BlocBuilder<AppCubit, AppState>(
          buildWhen: (prev, curr) =>
          prev.isProUser != curr.isProUser ||
              prev.cosmicEventsStatus != curr.cosmicEventsStatus,
          builder: (context, state) {

            // Если пользователь не PRO, показываем заглушку
            if (!state.isProUser) {
              return const _PaywallPlaceholder();
            }

            // Статусы загрузки
            if (state.cosmicEventsStatus == LoadingState.loading && state.cosmicEvents.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.cosmicEventsStatus == LoadingState.error) {
              return Center(child: Text(l10n.cosmicEvents_loading_error)); // <-- Перевод
            }
            if (state.cosmicEvents.isEmpty) {
              return Center(child: Text(l10n.cosmicEvents_no_events)); // <-- Перевод
            }

            // Если все успешно, показываем список
            return ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, kToolbarHeight + 32, 16, 16),
              itemCount: state.cosmicEvents.length,
              itemBuilder: (context, index) {
                final event = state.cosmicEvents[index];
                return _EventCard(event: event);
              },
            );
          },
        ),
      ),
    );
  }
}

// Виджет для заглушки PRO-версии
class _PaywallPlaceholder extends StatelessWidget {
  const _PaywallPlaceholder();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.lock_outline, size: 64, color: Colors.yellowAccent),
            const SizedBox(height: 24),
            Text(
              l10n.cosmicEvents_paywall_title, // <-- Перевод
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 16),
            Text(
              l10n.cosmicEvents_paywall_description, // <-- Перевод
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white70),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellowAccent,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              ),
              onPressed: () => context.push('/paywall'),
              child: Text(l10n.cosmicEvents_paywall_button), // <-- Перевод
            )
          ],
        ),
      ),
    );
  }
}

// Виджет для отображения одной карточки события
class _EventCard extends StatelessWidget {
  final CosmicEvent event;
  const _EventCard({required this.event});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final langCode = Localizations.localeOf(context).languageCode;
    final formattedDate = DateFormat('d MMMM yyyy, HH:mm', langCode).format(event.eventDate);

    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      color: Colors.white.withOpacity(0.1),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              formattedDate,
              style: TextStyle(color: Colors.yellow[700], fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              event.title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(
              event.description,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white70),
            ),
            if (event.personalAdvice.isNotEmpty)
              _buildPersonalAdvice(context, event.personalAdvice, l10n),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonalAdvice(BuildContext context, String advice, AppLocalizations l10n) {
    return Column(
      children: [
        const Divider(height: 24, color: Colors.white24),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.person_pin, color: Colors.yellowAccent, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      l10n.cosmicEvents_personal_focus, // <-- Перевод
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.yellowAccent)
                  ),
                  const SizedBox(height: 4),
                  Text(advice, style: const TextStyle(color: Colors.white, fontStyle: FontStyle.italic)),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}