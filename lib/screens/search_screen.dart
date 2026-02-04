// lib/screens/search_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lovequest/cubit/app_cubit.dart';
import 'package:lovequest/cubit/app_state.dart';
import 'package:lovequest/l10n/generated/app_localizations.dart'; // <-- Импорт локализации

import 'package:lovequest/src/data/models/user_profile_card.dart';
import 'package:lovequest/widgets/common/animated_cosmic_background.dart';
import 'package:lovequest/widgets/search/swipe_card.dart';
import 'package:lovequest/widgets/search/swipe_deck.dart';

import 'filter_panel.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with SingleTickerProviderStateMixin {
  final TextEditingController _textController = TextEditingController();
  late AnimationController _filterAnimationController;
  bool _showFilters = false;
  int _selectedViewIndex = 0;

  @override
  void initState() {
    super.initState();
    _filterAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));

    final cubit = context.read<AppCubit>();
    _textController.text = cubit.state.searchText;

    if (!cubit.state.searchInitiated) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _startNewSearch(context, withEmptyTerm: true);
      });
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    _filterAnimationController.dispose();
    super.dispose();
  }

  void _toggleFilters() {
    setState(() {
      _showFilters = !_showFilters;
      _showFilters ? _filterAnimationController.forward() : _filterAnimationController.reverse();
    });
  }

  Future<void> _startNewSearch(BuildContext context, {bool withEmptyTerm = false}) {
    final cubit = context.read<AppCubit>();
    final String searchTerm = withEmptyTerm ? '' : _textController.text;
    return cubit.startNewSearch(query: searchTerm);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A1E),
      body: AnimatedCosmicBackground(
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              _buildSearchHeader(),
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: _showFilters ? const FilterPanel() : const SizedBox.shrink(),
              ),
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  child: _buildSelectedView(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchHeader() {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 4.0, 8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: l10n.searchHint, // "Поиск..."
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
                prefixIcon: Icon(Icons.search, color: Colors.white.withOpacity(0.7)),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0), borderSide: BorderSide.none),
                contentPadding: EdgeInsets.zero,
              ),
              onChanged: (text) => context.read<AppCubit>().onSearchTextChanged(text),
              onSubmitted: (text) => _startNewSearch(context),
            ),
          ),
          IconButton(
            icon: Icon(_showFilters ? Icons.filter_list_off_rounded : Icons.filter_list_rounded),
            color: Colors.white,
            tooltip: l10n.search_tooltip_filters, // "Фильтры"
            onPressed: _toggleFilters,
          ),
          const SizedBox(width: 8),
          _ViewToggle(
            selectedIndex: _selectedViewIndex,
            onPressed: (index) {
              setState(() => _selectedViewIndex = index);
              if (index == 1) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(l10n.feature_in_development), // "В разработке"
                    backgroundColor: Colors.blueGrey,
                    duration: const Duration(seconds: 1),
                  ),
                );
              }
            },
          ),
          const SizedBox(width: 4),
        ],
      ),
    );
  }

  Widget _buildSelectedView() {
    switch (_selectedViewIndex) {
      case 0:
        return const _PrioritizedSearchView(key: ValueKey('prioritized_view'));
      case 1:
        return _StarMapPlaceholder(key: const ValueKey('star_map_placeholder'));
      default:
        return const _PrioritizedSearchView(key: ValueKey('prioritized_view'));
    }
  }
}

class _ViewToggle extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onPressed;

  const _ViewToggle({required this.selectedIndex, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: ToggleButtons(
        isSelected: [selectedIndex == 0, selectedIndex == 1],
        onPressed: onPressed,
        borderRadius: BorderRadius.circular(30.0),
        borderWidth: 0,
        selectedBorderColor: Colors.transparent,
        selectedColor: Colors.black,
        fillColor: Colors.cyanAccent,
        color: Colors.white70,
        splashColor: Colors.cyanAccent.withOpacity(0.12),
        constraints: const BoxConstraints(minHeight: 40.0, minWidth: 40.0),
        children: [
          Tooltip(message: l10n.search_tooltip_swipes, child: const Icon(Icons.view_carousel_rounded, size: 20)),
          Tooltip(message: "${l10n.search_tooltip_star_map} (${l10n.coming_soon})", child: const Icon(Icons.map_outlined, size: 20)),
        ],
      ),
    );
  }
}

class _StarMapPlaceholder extends StatelessWidget {
  const _StarMapPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.construction, size: 80, color: Colors.white38),
          const SizedBox(height: 20),
          Text(
            l10n.search_star_map_placeholder, // "Этот режим находится в разработке..."
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white70, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class _PrioritizedSearchView extends StatelessWidget {
  const _PrioritizedSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      buildWhen: (p, c) =>
      p.isSearchLoading != c.isSearchLoading ||
          p.priorityUsers != c.priorityUsers ||
          p.otherUsers != c.otherUsers ||
          p.allUsersLoaded != c.allUsersLoaded, // Слушаем флаг конца списка
      builder: (context, state) {
        final l10n = AppLocalizations.of(context)!;

        // Если это ПЕРВАЯ загрузка и список пуст
        if (state.isSearchLoading && state.otherUsers.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        final hasPriority = state.priorityUsers.isNotEmpty;
        final hasOthers = state.otherUsers.isNotEmpty;

        if (!hasPriority && !hasOthers && !state.isSearchLoading) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.search_off, size: 80, color: Colors.white38),
                const SizedBox(height: 20),
                Text(
                  l10n.search_no_one_found,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white70, fontSize: 18, height: 1.5),
                ),
              ],
            ),
          );
        }

        // Оборачиваем в NotificationListener для отслеживания скролла
        return NotificationListener<ScrollNotification>(
          onNotification: (scrollInfo) {
            print("SCROLL: ${scrollInfo.metrics.pixels} / ${scrollInfo.metrics.maxScrollExtent}");
            // ИСПРАВЛЕНИЕ: Более надежная проверка
            // Проверяем, что это не начало скролла, а процесс или конец
            if (scrollInfo is ScrollUpdateNotification || scrollInfo is OverscrollNotification) {
              // Если осталось меньше 500 пикселей до конца -> грузим
              if (scrollInfo.metrics.extentAfter < 500) {
                context.read<AppCubit>().loadNextPage();
              }
            }
            return false;
          },
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isWideScreen = constraints.maxWidth > 600;

              return CustomScrollView(
                // ИСПРАВЛЕНИЕ: Всегда разрешаем скролл, даже если элементов мало
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  if (hasPriority)
                    SliverToBoxAdapter(
                      child: _PriorityCarousel(
                        title: l10n.search_priority_header,
                        users: state.priorityUsers,
                      ),
                    ),

                  if (hasOthers) ...[
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 16.0),
                        child: Text(l10n.search_other_header, style: Theme.of(context).textTheme.titleLarge),
                      ),
                    ),

                    if (isWideScreen)
                      _buildGridForOthers(context, state.otherUsers, constraints.maxWidth)
                    else
                    // ВАЖНО для мобилки: SwipeDeck не скроллится!
                    // Тут NotificationListener бесполезен.
                    // Для мобилки нужно передать onEndReached прямо в SwipeDeck.
                      SliverToBoxAdapter(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.65,
                          child: SwipeDeck(
                            profiles: state.otherUsers,
                            // Убедись, что SwipeDeck это поддерживает!
                            // Если нет - добавь там вызов виджета.onEndReached()
                            // onEndReached: () => context.read<AppCubit>().loadNextPage(),
                          ),
                        ),
                      ),

                    // Лоадер внизу
                    if (!state.allUsersLoaded)
                      const SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.all(32.0),
                          child: Center(child: CircularProgressIndicator()),
                        ),
                      ),

                    // Отступ внизу
                    const SliverToBoxAdapter(child: SizedBox(height: 100)),
                  ],
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildGridForOthers(BuildContext context, List<UserProfileCard> users, double maxWidth) {
    int crossAxisCount = (maxWidth / 250).floor();
    crossAxisCount = crossAxisCount < 2 ? 2 : crossAxisCount;

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
          childAspectRatio: 0.75,
        ),
        delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
            final user = users[index];
            return _WebUserCard(
              profile: user,
              onTap: () => context.push('/user_profile/${user.id}'),
            ).animate().fadeIn(delay: (50 * (index % 10)).ms).slideY(begin: 0.1);
          },
          childCount: users.length,
        ),
      ),
    );
  }
}

class _WebUserCard extends StatelessWidget {
  final UserProfileCard profile;
  final VoidCallback onTap;

  const _WebUserCard({required this.profile, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      color: Colors.white.withOpacity(0.1),
      child: InkWell(
        onTap: onTap,
        hoverColor: Colors.white.withOpacity(0.1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: profile.avatar != null
                  ? Image.network(
                profile.avatar!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(Icons.person, size: 50, color: Colors.white30),
              )
                  : Container(
                color: Colors.black26,
                child: const Icon(Icons.person, size: 50, color: Colors.white30),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${profile.name}, ${profile.age}",
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 14, color: Colors.white.withOpacity(0.7)),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          profile.city ?? "Unknown",
                          style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  if (profile.compatibilityScore != null)
                    Text(
                      "${profile.compatibilityScore}% Match",
                      style: const TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PriorityCarousel extends StatelessWidget {
  final String title;
  final List<UserProfileCard> users;
  const _PriorityCarousel({required this.title, required this.users});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.cyanAccent)),
        ),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: SizedBox(
                  width: 150,
                  child: SwipeCard(
                    profile: user,
                    isCompact: true,
                    onCardTap: () => context.push('/user_profile/${user.id}'),
                  ),
                ),
              ).animate().fadeIn(delay: (100 * index).ms).slideX(begin: 0.2);
            },
          ),
        ),
      ],
    );
  }
}