// lib/screens/channels_screen.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:lovequest/l10n/generated/app_localizations.dart'; // <-- Импорт локализации
import '../cubit/app_cubit.dart';
import '../cubit/app_state.dart';
import '../widgets/channel_search_dialog.dart';
import '../widgets/common/animated_cosmic_background.dart';
import 'package:lovequest/src/data/models/channel_preview.dart';

class ChannelsScreen extends StatefulWidget {
  const ChannelsScreen({super.key});

  @override
  State<ChannelsScreen> createState() => _ChannelsScreenState();
}

class _ChannelsScreenState extends State<ChannelsScreen> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    context.read<AppCubit>().loadChannelPreviews();
  }

  String _formatTimestamp(DateTime? timestamp) {
    // Вспомогательная локализация времени (Вчера / Сегодня)
    final l10n = AppLocalizations.of(context)!;
    if (timestamp == null) return '';

    final now = DateTime.now();
    final difference = now.difference(timestamp);
    final locale = Localizations.localeOf(context).languageCode;

    if (difference.inHours < 24 && now.day == timestamp.day) {
      // 14:30
      return DateFormat.Hm(locale).format(timestamp);
    }
    if (difference.inDays == 1 || (difference.inHours < 48 && now.day - 1 == timestamp.day)) {
      // "Вчера"
      return l10n.yesterday;
    }
    // "5 Jun"
    return DateFormat.MMMd(locale).format(timestamp);
  }

  ImageProvider? _getAvatarImage(String? avatarUrl) {
    if (avatarUrl != null && avatarUrl.isNotEmpty) {
      if (avatarUrl.startsWith('data:image')) {
        try { return MemoryImage(base64Decode(avatarUrl.split(',').last)); } catch (e) { return null; }
      } else if (avatarUrl.startsWith('http')) {
        return NetworkImage(avatarUrl);
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    // Получаем переводы
    final l10n = AppLocalizations.of(context)!;
    final user = context.read<AppCubit>().state.currentUserProfile;
    final isAdmin = user?.role == 'admin';

    super.build(context);

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              heroTag: 'search_channel_fab',
              onPressed: () async {
                final channelId = await showDialog<String>(
                    context: context,
                    builder: (_) => const ChannelSearchDialog()
                );

                if (channelId != null && context.mounted) {
                  context.push('/channel-details/$channelId');
                }
              },
              tooltip: l10n.search,
              child: const Icon(Icons.search),
            ),
            FloatingActionButton.extended(
              heroTag: 'create_channel_fab',
              onPressed: () {
                if (isAdmin) {
                  context.push('/create_channel');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(l10n.adminOnlyFeature)), // "Доступно только администраторам"
                  );
                }
              },
              label: Text(l10n.createChannel), // "Создать канал"
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ),
      body: AnimatedCosmicBackground(
        child: BlocBuilder<AppCubit, AppState>(
          buildWhen: (p, c) =>
          p.isLoadingChannelPreviews != c.isLoadingChannelPreviews ||
              p.channelPreviews != c.channelPreviews,
          builder: (context, state) {
            return RefreshIndicator(
              onRefresh: () async => context.read<AppCubit>().loadChannelPreviews(),
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: 180.0,
                    pinned: true,
                    backgroundColor: Colors.transparent,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text(
                          l10n.galacticBroadcasts, // "Галактические Трансляции"
                          style: const TextStyle(shadows: [Shadow(color: Colors.black, blurRadius: 4)])
                      ),
                      centerTitle: true,
                      background: Image.network("https://images.unsplash.com/photo-1534796636912-3b95b3ab5986?w=800", fit: BoxFit.cover).animate().fadeIn(),
                    ),
                  ),

                  // Состояние загрузки
                  if (state.isLoadingChannelPreviews && state.channelPreviews.isEmpty)
                    const SliverFillRemaining(child: Center(child: CircularProgressIndicator()))

                  // Пустой список
                  else if (state.channelPreviews.isEmpty)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(48.0),
                        child: Center(
                            child: Text(
                                l10n.noChannelsYet, // "Вы пока ни на что не подписаны..."
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.white70)
                            )
                        ),
                      ),
                    )

                  // Список каналов
                  else
                    SliverList.builder(
                      itemCount: state.channelPreviews.length,
                      itemBuilder: (context, index) {
                        final preview = state.channelPreviews[index];
                        final avatar = _getAvatarImage(preview.avatarUrl);

                        return ListTile(
                          leading: CircleAvatar(
                            radius: 28,
                            backgroundImage: avatar,
                            child: avatar == null ? Text(preview.name.substring(0, 1).toUpperCase()) : null,
                          ),
                          title: Text(preview.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(
                            preview.lastMessageText ?? l10n.noMessagesYet, // "Пока нет сообщений"
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: preview.unreadCount > 0 ? Colors.white : Colors.grey),
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                _formatTimestamp(preview.lastMessageTimestamp),
                                style: const TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                              const SizedBox(height: 4),
                              if (preview.unreadCount > 0)
                                CircleAvatar(
                                  radius: 12,
                                  backgroundColor: Colors.pinkAccent,
                                  child: Text(
                                    '${preview.unreadCount}',
                                    style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                                  ),
                                )
                              else
                                const SizedBox(width: 24, height: 24),
                            ],
                          ),
                          onTap: () {
                            context.read<AppCubit>().markChannelAsRead(preview.id.toString());
                            context.push('/channel-details/${preview.id}');
                          },
                        ).animate().fadeIn(duration: 400.ms, delay: (50 * index).ms).slideY(begin: 0.2);
                      },
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}