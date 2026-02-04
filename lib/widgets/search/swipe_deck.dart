// lib/widgets/search/swipe_deck.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:lovequest/cubit/app_cubit.dart';
import 'package:lovequest/l10n/generated/app_localizations.dart';
import 'package:lovequest/src/data/models/user_profile_card.dart';
import 'package:lovequest/widgets/search/swipe_card.dart';

class SwipeDeck extends StatefulWidget {
  final List<UserProfileCard> profiles;
  final VoidCallback? onEndReached; // <-- 1. ДОБАВЛЕНО

  const SwipeDeck({
    super.key,
    required this.profiles,
    this.onEndReached, // <-- 2. ДОБАВЛЕНО
  });

  @override
  State<SwipeDeck> createState() => _SwipeDeckState();
}

class _SwipeDeckState extends State<SwipeDeck> {
  final CardSwiperController _controller = CardSwiperController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AppCubit>();
    final profiles = widget.profiles;

    if (profiles.isEmpty) {
      return Center(
        child: Text(
          AppLocalizations.of(context)?.noUsersFound ?? 'Пользователи не найдены',
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    // Используем только длину как ключ, чтобы не пересоздавать виджет лишний раз
    // (если profiles.first.id меняется, это не всегда значит, что нужен новый Swiper)
    // Но для пагинации (добавления в конец) лучше вообще не менять ключ,
    // если библиотека умеет динамически обновлять cardsCount.
    // Если flutter_card_swiper НЕ умеет динамически расти, то ключ обязателен.
    final key = ValueKey(profiles.length);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: CardSwiper(
        key: key,
        controller: _controller,
        cardsCount: profiles.length,
        numberOfCardsDisplayed: profiles.length < 3 ? profiles.length : 3,

        cardBuilder: (context, index, percentThresholdX, percentThresholdY) {
          // Защита от выхода за границы (на всякий случай)
          if (index >= profiles.length) return const SizedBox.shrink();

          final profile = profiles[index];
          return SwipeCard(
            key: ValueKey(profile.id),
            profile: profile,
            onLike: () => _controller.swipe(CardSwiperDirection.right),
            onDislike: () => _controller.swipe(CardSwiperDirection.left),
          );
        },

        onSwipe: (previousIndex, currentIndex, direction) {
          // --- 3. ЛОГИКА ПОДГРУЗКИ ---
          // Если мы свайпнули карту, и осталось меньше 5 карт до конца списка
          if (currentIndex != null && currentIndex >= profiles.length - 5) {
            widget.onEndReached?.call();
          }
          // ---------------------------

          if (previousIndex >= profiles.length) return false;
          final swipedProfile = profiles[previousIndex];

          if (direction == CardSwiperDirection.right) {
            cubit.onLikeClicked(swipedProfile.id);
          } else if (direction == CardSwiperDirection.left) {
            cubit.onDislikeClicked(swipedProfile.id);
          }
          return true;
        },

        isLoop: false,
        padding: const EdgeInsets.only(bottom: 40),
      ),
    );
  }
}