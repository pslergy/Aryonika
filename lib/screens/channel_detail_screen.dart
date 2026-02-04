// lib/screens/channel_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lovequest/cubit/app_cubit.dart';
import 'package:lovequest/cubit/app_state.dart';
import 'package:lovequest/l10n/generated/app_localizations.dart'; // Импорт локализации
import 'package:lovequest/widgets/common/animated_cosmic_background.dart';
import 'package:lovequest/widgets/channel/channel_header.dart';
import 'package:lovequest/widgets/channel/channel_post_card.dart';
import 'package:lovequest/widgets/channel/pinned_post_bar.dart'; // Если используется внутри Header или отдельно

import '../cubit/channel_cubit.dart';
import '../cubit/channel_state.dart';
import '../services/logger_service.dart';
import '../src/data/models/channel.dart';
import '../src/data/models/post.dart';
import '../widgets/channel/create_post_dialog.dart';
import '../widgets/channel/propose_post_dialog.dart';

class ChannelDetailScreen extends StatefulWidget {
  final String channelId;
  const ChannelDetailScreen({super.key, required this.channelId});

  @override
  State<ChannelDetailScreen> createState() => _ChannelDetailScreenState();
}

class _ChannelDetailScreenState extends State<ChannelDetailScreen> {
  late final ScrollController _scrollController;
  late final ChannelCubit _channelCubit;
  final Map<String, GlobalKey> _postKeys = {};

  @override
  void initState() {
    super.initState();
    _channelCubit = context.read<ChannelCubit>();
    _scrollController = ScrollController();

    // Подписываемся на скролл для пагинации
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent * 0.9 &&
          !_channelCubit.state.isPaginatingPosts) {
        _channelCubit.loadMorePosts();
      }
    });

    // Загружаем данные (ID уже внутри Cubit)
    _channelCubit.loadInitialData();
  }

  @override
  void dispose() {
    // Важно: очищаем состояние при выходе, чтобы не было "мелькания" старых данных
    // Вызываем это через context.read, так как виджет может быть уже демонтирован
    // Но лучше вызвать метод самого кубита, если он еще жив
    _channelCubit.onChannelScreenClosed();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToPost(String postId) {
    final key = _postKeys[postId];
    if (key != null && key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        alignment: 0.05, // Чуть ниже верха
      );
    } else {
      logger.d("Пост $postId не найден на экране для прокрутки.");
    }
  }

  @override
  Widget build(BuildContext context) {
    // Получаем переводы
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      floatingActionButton: const _FloatingActionButton(),
      body: AnimatedCosmicBackground(
        child: BlocConsumer<ChannelCubit, ChannelState>(
          listenWhen: (p, c) => p.activeChannelPosts.length != c.activeChannelPosts.length,
          listener: (context, state) {
            // Обновляем ключи для скролла при изменении списка постов
            _postKeys.clear();
            for (var post in state.activeChannelPosts) {
              _postKeys[post.id] = GlobalKey();
            }
          },
          builder: (context, state) {
            // 1. Загрузка самого канала
            if (state.activeChannel == null && state.activeChannelStatus == ChannelStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            // 2. Ошибка загрузки
            if (state.activeChannel == null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(l10n.channelLoadError, style: const TextStyle(color: Colors.white70)), // "Не удалось загрузить канал"
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => context.read<ChannelCubit>().loadInitialData(),
                      child: Text(l10n.tryAgain), // "Попробовать снова"
                    )
                  ],
                ),
              );
            }

            final channel = state.activeChannel!;

            // 3. Успех - отображаем контент
            return RefreshIndicator(
              onRefresh: () => context.read<ChannelCubit>().refreshChannelData(),
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  _SliverAppBar(
                    channel: channel,
                    onPinTap: () {
                      if (channel.pinnedPostId != null) {
                        _scrollToPost(channel.pinnedPostId!);
                      }
                    },
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                      child: Text(
                        l10n.postsTitle, // "Публикации"
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),

                  // Список постов
                  _PostList(postKeys: _postKeys),

                  // Индикатор пагинации внизу
                  SliverToBoxAdapter(
                    child: BlocBuilder<ChannelCubit, ChannelState>(
                      buildWhen: (p, c) => p.isPaginatingPosts != c.isPaginatingPosts,
                      builder: (context, state) => state.isPaginatingPosts
                          ? const Center(child: Padding(padding: EdgeInsets.all(16.0), child: CircularProgressIndicator()))
                          : const SizedBox.shrink(),
                    ),
                  ),

                  // Отступ снизу для FAB
                  const SliverToBoxAdapter(child: SizedBox(height: 80)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// --- SUB-WIDGETS ---

class _FloatingActionButton extends StatelessWidget {
  const _FloatingActionButton();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<ChannelCubit, ChannelState>(
      builder: (context, state) {
        final channelCubit = context.read<ChannelCubit>();
        final appCubit = context.read<AppCubit>();

        final currentUser = appCubit.state.currentUserProfile;
        final channel = state.activeChannel;

        if (currentUser == null || channel == null) {
          return const SizedBox.shrink();
        }

        // Приводим типы к строке для надежного сравнения
        final isOwnerOrAdmin = channel.ownerId.toString() == currentUser.id;
        final isSubscribed = currentUser.subscribedChannelIds.contains(channel.id.toString());

        if (isOwnerOrAdmin) {
          return FloatingActionButton(
            heroTag: 'create_post_fab',
            onPressed: () => showDialog(
              context: context,
              builder: (_) => BlocProvider.value(
                value: channelCubit,
                child: const CreatePostDialog(),
              ),
            ),
            tooltip: l10n.createPostTooltip, // "Создать пост"
            child: const Icon(Icons.create),
          );
        }

        if (isSubscribed) {
          return FloatingActionButton.extended(
            heroTag: 'propose_post_fab',
            onPressed: () => showDialog(
              context: context,
              builder: (_) => BlocProvider.value(
                value: channelCubit,
                child: const ProposePostDialog(),
              ),
            ),
            label: Text(l10n.proposePost), // "Предложить новость"
            icon: const Icon(Icons.add_comment),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class _SliverAppBar extends StatelessWidget {
  final Channel channel;
  final VoidCallback onPinTap;
  const _SliverAppBar({required this.channel, required this.onPinTap});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // Получаем состояние подписки и метод toggle из кубита
    // Используем context.watch, чтобы кнопка подписки обновлялась реактивно
    final appCubit = context.watch<AppCubit>();
    final currentUser = appCubit.state.currentUserProfile;

    final isOwner = currentUser != null && channel.ownerId.toString() == currentUser.id;
    final isSubscribed = currentUser?.subscribedChannelIds.contains(channel.id.toString()) ?? false;

    // Локализация названия канала
    final lang = Localizations.localeOf(context).languageCode;
    final channelName = channel.name[lang] ?? channel.name['en'] ?? channel.name.values.first;

    return SliverAppBar(
      expandedHeight: 280.0, // Увеличил высоту, чтобы влезла кнопка подписки в Header
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(channelName, style: const TextStyle(shadows: [Shadow(blurRadius: 4, color: Colors.black)])),
        background: ChannelHeader(
          channel: channel,
          // --- ИСПРАВЛЕНИЕ 1: Передаем параметры подписки ---
          isSubscribed: isSubscribed,
          onSubscribeClick: () {
            appCubit.toggleSubscription(channel.id.toString(), isSubscribed);
          },
        ),
      ),
      actions: [
        if (isOwner)
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.push('/channel-settings/${channel.id}'),
          ),

        if (!isOwner)
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              if (value == 'report') {
                // TODO: Логика жалобы
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'report',
                child: Text(l10n.report),
              ),
            ],
          ),
      ],

      bottom: channel.pinnedPostId != null
          ? PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: PinnedPostBar(
          // Убрали text: "..." и pinnedPostText: "..."
          // Оставляем только onTap, если он есть в конструкторе
          onTap: onPinTap,
        ),
      )
          : null,
    );
  }
}

class _PostList extends StatelessWidget {
  final Map<String, GlobalKey> postKeys;
  const _PostList({required this.postKeys});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<ChannelCubit, ChannelState>(
      builder: (context, state) {
        if (state.activeChannelPosts.isEmpty) {
          // Если постов нет и загрузка не идет
          if (state.activeChannelStatus != ChannelStatus.loading) {
            return SliverToBoxAdapter(
                child: Center(
                    child: Padding(
                        padding: const EdgeInsets.all(48.0),
                        child: Text(l10n.noPostsYet, style: const TextStyle(color: Colors.white54)) // "В этом канале пока нет публикаций."
                    )
                )
            );
          } else {
            // Если идет начальная загрузка постов - индикатор покажет основной BlocBuilder выше
            return const SliverToBoxAdapter(child: SizedBox.shrink());
          }
        }

        return SliverList.builder(
          itemCount: state.activeChannelPosts.length,
          itemBuilder: (context, index) {
            final post = state.activeChannelPosts[index];

            return KeyedSubtree(
              key: postKeys[post.id], // Привязываем ключ для прокрутки
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ChannelPostCard(
                  post: post,
                  // Навигация к комментариям
                  onCommentClick: () => context.push('/comments/${state.activeChannel!.id}/${post.id}'),
                ),
              ),
            );
          },
        );
      },
    );
  }
}