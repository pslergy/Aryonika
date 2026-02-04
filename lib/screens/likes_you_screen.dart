// lib/screens/likes_you_screen.dart
import 'dart:ui';

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lovequest/cubit/app_cubit.dart';
import 'package:lovequest/cubit/app_state.dart';
import 'package:lovequest/l10n/generated/app_localizations.dart'; // <-- Импорт локализации
import 'package:lovequest/src/data/models/enums.dart';
import 'package:lovequest/src/data/models/user_profile_card.dart';
import 'package:lovequest/widgets/common/animated_cosmic_background.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LikesYouScreen extends StatefulWidget {
  const LikesYouScreen({super.key});

  @override
  State<LikesYouScreen> createState() => _LikesYouScreenState();
}

class _LikesYouScreenState extends State<LikesYouScreen> {
  @override
  void initState() {
    super.initState();
    final cubit = context.read<AppCubit>();
    cubit.markLikesAsSeen();
    if (cubit.state.usersWhoLikedMe.isEmpty && cubit.state.likesYouLoadingState != LoadingState.loading) {
      cubit.loadUsersWhoLikedMe();
    }
  }

  // _markLikesAsSeen не используется, так как вызывается в initState, можно удалить или оставить.
  // Оставляем как в оригинале, но он не используется внутри виджета.

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(l10n.likesYouTitle), // "Вам симпатии"
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: AnimatedCosmicBackground(
        child: BlocBuilder<AppCubit, AppState>(
          builder: (context, state) {
            if (state.likesYouLoadingState == LoadingState.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.usersWhoLikedMe.isEmpty) {
              return _buildEmptyState(l10n);
            }

            return Stack(
              children: [
                GridView.builder(
                  padding: EdgeInsets.fromLTRB(16, MediaQuery.of(context).padding.top + kToolbarHeight + 16, 16, 16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: state.usersWhoLikedMe.length,
                  itemBuilder: (context, index) {
                    final profile = state.usersWhoLikedMe[index];
                    return _ProfileCard(
                      profile: profile,
                      isBlurred: !state.isProUser,
                      l10n: l10n,
                    ).animate().fadeIn(delay: (100 * index).ms).slideY(begin: 0.2);
                  },
                ),
                if (!state.isProUser) _buildPaywallOverlay(context, state.usersWhoLikedMe.length, l10n),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildEmptyState(AppLocalizations l10n) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border, size: 80, color: Colors.pinkAccent.withOpacity(0.5)),
          const SizedBox(height: 16),
          Text(
            l10n.likesYouEmpty, // "Здесь будут те, кто вами заинтересуется"
            style: const TextStyle(color: Colors.white70, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPaywallOverlay(BuildContext context, int likeCount, AppLocalizations l10n) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(24.0).copyWith(bottom: 48),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black.withOpacity(0.9), Colors.transparent],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Column(
          children: [
            Text(
              l10n.peopleLikeYou(likeCount), // "Вы нравитесь {count} людям!"
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.getProToSeeLikes, // "Получите PRO-статус..."
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              onPressed: () => context.push('/paywall'),
              icon: const Icon(Icons.star),
              label: Text(l10n.seeLikesButton), // "Посмотреть"
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  final UserProfileCard profile;
  final bool isBlurred;
  final AppLocalizations l10n;

  const _ProfileCard({required this.profile, required this.isBlurred, required this.l10n});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isBlurred) {
          context.push('/paywall');
        } else {
          context.push('/user_profile/${profile.id}'); // Путь исправлен
        }
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              profile.avatar ?? 'https://psylergy.com/placeholder.jpg',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: Colors.grey.shade800,
                child: const Icon(Icons.person, size: 50, color: Colors.grey),
              ),
            ),
            if (isBlurred)
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(color: Colors.black.withOpacity(0.1)),
              ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.8), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.center,
                ),
              ),
            ),
            Positioned(
              bottom: 12,
              left: 12,
              right: 12,
              child: Text(
                isBlurred ? l10n.someone : "${profile.name}, ${profile.age}", // "Кто-то"
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  shadows: [Shadow(blurRadius: 2, color: Colors.black)],
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (isBlurred)
              Center(
                child: BlurryContainer(
                  blur: 2,
                  color: Colors.black26,
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                  padding: const EdgeInsets.all(12),
                  child: const Icon(Icons.star, color: Colors.pinkAccent, size: 40),
                ),
              ),
          ],
        ),
      ),
    );
  }
}