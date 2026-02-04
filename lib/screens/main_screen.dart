// lib/screens/main_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lovequest/cubit/app_cubit.dart';
import 'package:lovequest/cubit/app_state.dart';

import 'package:lovequest/l10n/generated/app_localizations.dart';

// --- Этот виджет теперь StatelessWidget, так как вся логика в его дочерних элементах ---
class MainScreen extends StatelessWidget {
  final Widget child;
  const MainScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    // LayoutBuilder следит за размерами и перестраивает UI при их изменении
    return LayoutBuilder(
      builder: (context, constraints) {
        // Определяем, достаточно ли широкий экран для боковой навигации
        final bool useRail = constraints.maxWidth >= 720;

        if (useRail) {
          // --- ВЕРСИЯ ДЛЯ ШИРОКИХ ЭКРАНОВ (WEB, DESKTOP) ---
          return _DesktopScaffold(child: child);
        } else {
          // --- ВЕРСИЯ ДЛЯ УЗКИХ ЭКРАНОВ (MOBILE) ---
          return _MobileScaffold(child: child);
        }
      },
    );
  }
}

// ==========================================================
// --- ВИДЖЕТ ДЛЯ МОБИЛЬНОЙ ВЕРСИИ С BOTTOMNAVIGATIONBAR ---
// ==========================================================
class _MobileScaffold extends StatefulWidget {
  final Widget child;
  const _MobileScaffold({required this.child});

  @override
  State<_MobileScaffold> createState() => _MobileScaffoldState();
}

class _MobileScaffoldState extends State<_MobileScaffold> {
  @override
  void initState() {
    super.initState();
    // Проверка языка остается здесь, она нужна на всех платформах
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<AppCubit>().checkAndUpdateUserLanguage(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _calculateSelectedIndex(context),
        onTap: (index) => _onItemTapped(index, context),
        type: BottomNavigationBarType.fixed,
        backgroundColor:
            Theme.of(context).scaffoldBackgroundColor.withOpacity(0.95),
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false, // Для чистоты интерфейса можно скрыть лейблы
        showUnselectedLabels: false,
        items: _buildNavItems(context.watch<AppCubit>().state, l10n),
      ),
    );
  }
}

// ==========================================================
// --- ВИДЖЕТ ДЛЯ WEB/DESKTOP ВЕРСИИ С NAVIGATIONRAIL ---
// ==========================================================
class _DesktopScaffold extends StatelessWidget {
  final Widget child;
  const _DesktopScaffold({required this.child});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _calculateSelectedIndex(context),
            onDestinationSelected: (index) => _onItemTapped(index, context),
            labelType: NavigationRailLabelType.all,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            indicatorColor:
                Theme.of(context).colorScheme.primary.withOpacity(0.2),
            destinations: _buildNavItems(context.watch<AppCubit>().state, l10n)
                .map((item) => NavigationRailDestination(
                      icon: item.icon,
                      label: item.label != null
                          ? Text(item.label!)
                          : const SizedBox.shrink(),
                    ))
                .toList(),
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: child,
          ),
        ],
      ),
    );
  }
}

// ==========================================================
// --- ОБЩАЯ ЛОГИКА ДЛЯ ОБОИХ ВИДЖЕТОВ ---
// ==========================================================

// Выносим общие методы в корень файла, чтобы их могли использовать оба Scaffold'а

int _calculateSelectedIndex(BuildContext context) {
  final location = GoRouterState.of(context).matchedLocation;
  if (location.startsWith('/feed')) return 0;
  if (location.startsWith('/search')) return 1;
  if (location.startsWith('/friends')) return 2;
  if (location.startsWith('/chats'))
    return 3; // ИЛИ '/channels', если они объединены
  if (location.startsWith('/oracle')) return 4;
  if (location.startsWith('/profile')) return 5; // <-- Это последний индекс

  return 0;
}

void _onItemTapped(int index, BuildContext context) {
  context.read<AppCubit>().recheckProStatus();
  switch (index) {
    case 0:
      context.push('/feed');
      break;
    case 1:
      context.push('/search');
      break;
    case 2:
      context.push('/friends');
      break;
    case 3:
      context.push('/chats');
      break; // Ведет на объединенный экран
    case 4:
      context.push('/oracle');
      break;
    case 5:
      context.push('/profile');
      break;
  }
}

// Общий метод для создания элементов навигации (и для Rail, и для Bar)
List<BottomNavigationBarItem> _buildNavItems(
    AppState state, AppLocalizations l10n) {
  final friendRequestsCount = state.friendRequests.length;
  // Суммируем непрочитанные: чаты + каналы (если есть счетчик для каналов в стейте)
  // Пока берем только чаты, или добавь state.totalChannelUnread
  final totalUnread = state.totalUnreadCount;

  return [
    BottomNavigationBarItem(
        icon: const Icon(Icons.hub_outlined), label: l10n.nav_feed), // 0
    BottomNavigationBarItem(
        icon: const Icon(Icons.search), label: l10n.nav_search), // 1

    // ДРУЗЬЯ
    BottomNavigationBarItem(
      icon: Badge(
        label: Text('$friendRequestsCount'),
        isLabelVisible: friendRequestsCount > 0,
        child: const Icon(Icons.people_outline),
      ),
      label: l10n.nav_friends,
    ), // 2

    // ОБЩЕНИЕ (Чаты + Каналы)
    BottomNavigationBarItem(
      icon: Badge(
        label: Text('$totalUnread'),
        isLabelVisible: totalUnread > 0,
        child: const Icon(Icons.message_outlined), // Или forum
      ),
      label: l10n.nav_chats,
    ), // 3

    BottomNavigationBarItem(
        icon: const Icon(Icons.star_border), label: l10n.nav_oracle), // 4

    BottomNavigationBarItem(
      icon: Badge(
        label: Text('${state.newLikesCount}'),
        isLabelVisible: state.newLikesCount > 0,
        child: const Icon(Icons.face_outlined),
      ),
      label: l10n.nav_profile,
    ), // 5
  ];
}
