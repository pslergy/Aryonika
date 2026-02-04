// lib/screens/chat_list_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:lovequest/cubit/app_cubit.dart';
import 'package:lovequest/cubit/app_state.dart';
import 'package:lovequest/l10n/generated/app_localizations.dart';

import '../services/logger_service.dart';
import '../widgets/common/user_avatar.dart';
import 'channels_screen.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.constellationsTitle), // "Созвездия"
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              tooltip: l10n.search,
              onPressed: () => context.push('/search'),
            ),
          ],
          bottom: TabBar(
            indicatorColor: Colors.pinkAccent,
            tabs: [
              Tab(text: l10n.privateChatsTab), // "Личные"
              Tab(text: l10n.channelsTab),     // "Каналы"
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _PrivateChatsView(),
            ChannelsScreen(), // Вставляем экран каналов
          ],
        ),
      ),
    );
  }
}

class _PrivateChatsView extends StatefulWidget {
  const _PrivateChatsView();

  @override
  State<_PrivateChatsView> createState() => _PrivateChatsViewState();
}

class _PrivateChatsViewState extends State<_PrivateChatsView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      logger.d("--- [ChatListScreen] initState: Запускаю загрузку списка чатов...");
      context.read<AppCubit>().loadInitialChatList();
    });
  }

  String _formatTimestamp(DateTime timestamp) {
    // Используем локаль контекста для правильного формата времени (24h/12h)
    return DateFormat.Hm(Localizations.localeOf(context).languageCode).format(timestamp);
  }

  bool _isUserOnline(DateTime? lastOnline) {
    if (lastOnline == null) return false;
    return DateTime.now().difference(lastOnline).inMinutes < 5;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final currentUserId = context.select((AppCubit cubit) => cubit.state.currentUserProfile?.id);

    if (currentUserId == null) {
      return Center(child: Text(l10n.loadingUser)); // "Загрузка пользователя..."
    }

    return BlocBuilder<AppCubit, AppState>(
      buildWhen: (p, c) => p.isChatListLoading != c.isChatListLoading || p.chatListItems != c.chatListItems,
      builder: (context, state) {
        if (state.isChatListLoading && state.chatListItems.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.chatListItems.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                l10n.emptyChatsPlaceholder, // "Здесь будут ваши личные чаты..."
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[400], fontSize: 16),
              ),
            ),
          );
        }

        return ListView.separated(
          itemCount: state.chatListItems.length,
          separatorBuilder: (context, index) => const Divider(height: 1, indent: 80, color: Colors.white12),
          itemBuilder: (context, index) {
            final chatItem = state.chatListItems[index];
            final otherUser = chatItem.otherUser;

            if (otherUser == null) {
              return const SizedBox.shrink();
            }

            final amISender = chatItem.lastMessageSenderId == currentUserId;

            // --- ОБЕРТКА ДЛЯ УДАЛЕНИЯ СВАЙПОМ ---
            return Dismissible(
              key: Key(chatItem.chatId), // Уникальный ключ обязателен
              direction: DismissDirection.endToStart, // Свайп справа налево

              // Фон при свайпе (Красный с корзиной)
              background: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 24.0),
                color: Colors.redAccent,
                child: const Icon(Icons.delete_outline, color: Colors.white, size: 28),
              ),

              // Диалог подтверждения
              confirmDismiss: (direction) async {
                return await showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    backgroundColor: const Color(0xFF1E1E3D),
                    title: Text(l10n.deleteChatTitle), // "Удалить чат?" (Добавь в l10n)
                    content: Text(
                      l10n.deleteChatConfirmation, // "Вся переписка будет удалена." (Добавь в l10n)
                      style: const TextStyle(color: Colors.white70),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(ctx).pop(false),
                        child: Text(l10n.cancel, style: const TextStyle(color: Colors.grey)),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(ctx).pop(true),
                        child: Text(l10n.delete, style: const TextStyle(color: Colors.redAccent)),
                      ),
                    ],
                  ),
                );
              },

              // Действие при успешном удалении
              onDismissed: (direction) {
                // Вызываем метод в AppCubit для удаления чата из списка и с сервера
                context.read<AppCubit>().deleteChatFromList(chatItem.chatId);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(l10n.chatDeleted), // "Чат удален"
                    backgroundColor: Colors.grey[800],
                  ),
                );
              },

              // Сам элемент списка (ListTile)
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                leading: UserAvatar(
                  user: otherUser,
                  radius: 28,
                  heroTag: 'list_${otherUser.id}',
                ),
                title: Row(
                  children: [
                    Expanded(
                      child: Text(otherUser.name, style: const TextStyle(fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
                    ),
                    const SizedBox(width: 8),
                    if (_isUserOnline(otherUser.lastOnline))
                      Container(
                        width: 8, height: 8,
                        decoration: const BoxDecoration(color: Colors.greenAccent, shape: BoxShape.circle),
                      ),
                  ],
                ),
                subtitle: Row(
                  children: [
                    if (amISender) ...[
                      // Логика галочек для списка чатов (может отличаться от MessageBubble)
                      // Здесь мы предполагаем, что если otherUserUnreadCount == 0, значит он всё прочитал.
                      Icon(
                        chatItem.otherUserUnreadCount == 0 ? Icons.done_all : Icons.done,
                        size: 18,
                        color: chatItem.otherUserUnreadCount == 0 ? Colors.blueAccent : Colors.grey,
                      ),
                      const SizedBox(width: 4),
                    ],
                    Expanded(
                      child: Text(
                        chatItem.lastMessage,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: chatItem.unreadCount > 0 ? FontWeight.bold : FontWeight.normal,
                          color: chatItem.unreadCount > 0 ? Theme.of(context).textTheme.bodyLarge?.color : Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      _formatTimestamp(chatItem.lastMessageTimestamp),
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    if (chatItem.unreadCount > 0)
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: Text(
                          '${chatItem.unreadCount}',
                          style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      )
                    else
                      const SizedBox(width: 24, height: 24),
                  ],
                ),
                onTap: () => context.push('/chat/${chatItem.chatId}'),
              ),
            );
          },
        );
      },
    );
  }
}