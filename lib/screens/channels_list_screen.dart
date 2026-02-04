// lib/screens/channels_list_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:lovequest/cubit/app_cubit.dart';
import 'package:lovequest/cubit/app_state.dart';
// НЕ ЗАБУДЬ ИМПОРТИРОВАТЬ L10N
import 'package:lovequest/l10n/generated/app_localizations.dart';

class ChannelsListScreen extends StatefulWidget {
  const ChannelsListScreen({super.key});

  @override
  State<ChannelsListScreen> createState() => _ChannelsListScreenState();
}

class _ChannelsListScreenState extends State<ChannelsListScreen> {
  @override
  void initState() {
    super.initState();
    // Используем addPostFrameCallback, чтобы не блокировать build при инициализации
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppCubit>().loadChannelPreviews();
    });
  }

  String _formatTimestamp(DateTime? timestamp) {
    if (timestamp == null) return '';
    // Используем локаль контекста, чтобы время форматировалось правильно (13:00 vs 1:00 PM)
    return DateFormat.Hm(Localizations.localeOf(context).languageCode).format(timestamp);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.channelsTitle)), // "Каналы"
      body: BlocBuilder<AppCubit, AppState>(
        buildWhen: (p, c) => p.channelPreviews != c.channelPreviews || p.isLoadingChannelPreviews != c.isLoadingChannelPreviews,
        builder: (context, state) {
          if (state.isLoadingChannelPreviews) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.channelPreviews.isEmpty) {
            return Center(child: Text(l10n.noChannelSubscriptions)); // "У вас пока нет подписок"
          }

          return RefreshIndicator(
            onRefresh: () => context.read<AppCubit>().loadChannelPreviews(),
            child: ListView.builder(
              itemCount: state.channelPreviews.length,
              itemBuilder: (context, index) {
                final preview = state.channelPreviews[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: preview.avatarUrl != null ? NetworkImage(preview.avatarUrl!) : null,
                    // Добавим иконку по умолчанию, если аватара нет
                    child: preview.avatarUrl == null ? const Icon(Icons.group) : null,
                  ),
                  title: Text(preview.name),
                  subtitle: Text(
                      preview.lastMessageText ?? l10n.noMessagesYet, // "Нет сообщений"
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis
                  ),
                  trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                            _formatTimestamp(preview.lastMessageTimestamp),
                            style: const TextStyle(fontSize: 12, color: Colors.grey)
                        ),
                        if (preview.unreadCount > 0) ...[
                          const SizedBox(height: 4),
                          Container( // Заменил CircleAvatar на Container для лучшего контроля размера
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: Colors.redAccent,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                                '${preview.unreadCount}',
                                style: const TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold)
                            ),
                          ),
                        ]
                      ]
                  ),
                  onTap: () {
                    context.read<AppCubit>().markChannelAsRead(preview.id.toString());
                    context.push('/channel-details/${preview.id}');
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}