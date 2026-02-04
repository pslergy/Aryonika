// lib/screens/chat_screen.dart

import 'dart:async';
import 'dart:ui';
// Убрал лишние импорты (cloud_firestore)
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:lovequest/cubit/app_cubit.dart';
import 'package:lovequest/cubit/chat_cubit.dart';
import 'package:lovequest/cubit/chat_state.dart';
import 'package:lovequest/l10n/generated/app_localizations.dart';

import 'package:lovequest/repositories/api_repository.dart';
import 'package:lovequest/src/data/models/message.dart' as chat_models;
import 'package:lovequest/src/data/models/user_profile_card.dart';
import 'package:lovequest/widgets/common/animated_cosmic_background.dart';

import '../services/websocket_service.dart';
import '../widgets/common/user_avatar.dart';

// --- ПРОВАЙДЕР ---
class ChatScreenProvider extends StatefulWidget {
  final String chatId;
  final String? initialMessage;

  const ChatScreenProvider({super.key, required this.chatId, this.initialMessage});

  @override
  State<ChatScreenProvider> createState() => _ChatScreenProviderState();
}

class _ChatScreenProviderState extends State<ChatScreenProvider> {
  Future<UserProfileCard?>? _getOtherUserFuture;
  late String otherUserId;

  @override
  void initState() {
    super.initState();
    final currentUserId = context.read<AppCubit>().state.currentUserProfile?.id;
    // Разделитель '___'
    final participantIds = widget.chatId.split('___');
    otherUserId = participantIds.firstWhere((id) => id != currentUserId, orElse: () => '');

    // Пытаемся найти пользователя в кэше
    final cachedUser = context.read<AppCubit>().state.viewedProfilesCache[otherUserId];
    if (cachedUser != null) {
      _getOtherUserFuture = Future.value(cachedUser);
    } else {
      // Иначе грузим с сервера
      _getOtherUserFuture = context.read<ApiRepository>().getUserProfile(otherUserId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (otherUserId.isEmpty) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(child: Text(l10n.chat_error_recipient_not_found)),
      );
    }

    return FutureBuilder<UserProfileCard?>(
      future: _getOtherUserFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        if (snapshot.hasError || snapshot.data == null) {
          return Scaffold(
            appBar: AppBar(title: Text(l10n.errorTitle)), // "Ошибка"
            body: Center(child: Text(l10n.chat_error_recipient_profile_load_failed)),
          );
        }
        final otherUser = snapshot.data!;

        return BlocProvider(
          create: (context) => ChatCubit(
            apiRepository: context.read<ApiRepository>(),
            appCubit: context.read<AppCubit>(),
          )..initPersonalChat(widget.chatId, otherUser),
          child: ChatScreen(initialMessage: widget.initialMessage),
        );
      },
    );
  }
}

// --- ОСНОВНОЙ ЭКРАН ---
class ChatScreen extends StatefulWidget {
  final String? initialMessage;
  const ChatScreen({super.key, this.initialMessage});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final TextEditingController _textController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.initialMessage);
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ВАЖНО: ChatCubit доступен здесь через context, так как ChatScreen обернут в BlocProvider
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const _ChatAppBar(),
      body: AnimatedCosmicBackground(
        child: Column(
          children: [
            Expanded(
              child: BlocConsumer<ChatCubit, ChatState>(
                listener: (context, state) {
                  if (state.errorMessage != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.errorMessage!), backgroundColor: Colors.red)
                    );
                  }
                },
                builder: (context, state) {
                  if (state.status == ChatStatus.loading && state.messages.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return _MessageList(scrollController: _scrollController);
                },
              ),
            ),
            _MessageInput(controller: _textController),
          ],
        ),
      ),
    );
  }
}

// --- ШАПКА ЧАТА ---
class _ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _ChatAppBar();

  String _formatOnlineStatus(DateTime? lastOnline, AppLocalizations l10n) {
    if (lastOnline == null) return l10n.chat_online_status_long_ago;
    final now = DateTime.now();
    final difference = now.difference(lastOnline);
    if (difference.inMinutes < 5) return l10n.chat_online_status_online;
    if (difference.inHours < 1) return l10n.chat_online_status_minutes_ago(difference.inMinutes.toString());
    if (DateUtils.isSameDay(now, lastOnline)) return l10n.chat_online_status_today_at(DateFormat.Hm(l10n.localeName).format(lastOnline));
    final yesterday = now.subtract(const Duration(days: 1));
    if (DateUtils.isSameDay(yesterday, lastOnline)) return l10n.chat_online_status_yesterday_at(DateFormat.Hm(l10n.localeName).format(lastOnline));
    return l10n.chat_online_status_date(DateFormat('d MMM', l10n.localeName).format(lastOnline));
  }

  void _showTimerDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final chatCubit = context.read<ChatCubit>();
    final isPro = context.read<AppCubit>().state.isProUser;

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E1E3D),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
                l10n.autoDeleteMessages,
                style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)
            ),
          ),
          if (!isPro)
            ListTile(
              leading: const Icon(Icons.lock, color: Colors.amber),
              title: Text(l10n.availableInPro, style: const TextStyle(color: Colors.amber)),
              onTap: () {
                Navigator.pop(ctx);
                context.push('/paywall');
              },
            ),
          _buildTimerOption(ctx, l10n.timerOff, null, isPro, chatCubit),
          _buildTimerOption(ctx, l10n.timer15min, 15, isPro, chatCubit),
          _buildTimerOption(ctx, l10n.timer1hour, 60, isPro, chatCubit),
          _buildTimerOption(ctx, l10n.timer4hours, 240, isPro, chatCubit),
          _buildTimerOption(ctx, l10n.timer24hours, 1440, isPro, chatCubit),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildTimerOption(BuildContext context, String title, int? minutes, bool isPro, ChatCubit cubit) {
    return ListTile(
      title: Text(title, style: TextStyle(color: isPro ? Colors.white : Colors.white38)),
      onTap: !isPro ? null : () {
        Navigator.pop(context);
        cubit.setMessageTTL(minutes);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("${AppLocalizations.of(context)!.timerSet}: $title"))
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: AppBar(
          backgroundColor: Colors.black.withOpacity(0.3),
          elevation: 0,
          leading: const BackButton(color: Colors.white),
          title: BlocBuilder<ChatCubit, ChatState>(
            buildWhen: (p, c) => p.otherUser != c.otherUser,
            builder: (context, state) {
              final user = state.otherUser;
              if (user == null) return const SizedBox.shrink();
              return GestureDetector(
                onTap: () => context.push('/user_profile/${user.id}'),
                child: Row(
                  children: [
                    UserAvatar(
                      user: user,
                      radius: 20,
                      // --- ФИКС HERO ERROR ---
                      // Мы меняем префикс тега на 'chat_screen_', чтобы он отличался
                      // от тегов в списке ('list_...'). Это предотвратит конфликт.
                      heroTag: 'chat_screen_${user.id}',
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(user.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
                          Text(_formatOnlineStatus(user.lastOnline, l10n), style: const TextStyle(fontSize: 12, color: Colors.white70)),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.timer_outlined),
              tooltip: l10n.disappearingMessages,
              onPressed: () => _showTimerDialog(context),
            ),
            PopupMenuButton<String>(
              onSelected: (value) async {
                if (value == 'delete') {
                  // Показываем подтверждение
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text("Удалить чат?"),
                      content: const Text("Это действие нельзя отменить. История переписки будет удалена для обоих участников."),
                      backgroundColor: const Color(0xFF1E1E3D),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(ctx, false),
                          child: const Text("Отмена", style: TextStyle(color: Colors.grey)),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(ctx, true),
                          child: const Text("Удалить", style: TextStyle(color: Colors.redAccent)),
                        ),
                      ],
                    ),
                  );

                  if (confirm == true && context.mounted) {
                    await context.read<ChatCubit>().deleteChat();
                    if (context.mounted) context.pop(); // Выходим из чата
                  }
                } else if (value == 'report') {
                  // Твоя логика жалобы
                }
              },
              itemBuilder: (ctx) => [
                // Новый пункт
                const PopupMenuItem(
                    value: 'delete',
                    child: Row(children: [
                      Icon(Icons.delete_outline, color: Colors.redAccent),
                      SizedBox(width: 8),
                      Text("Удалить чат")
                    ])
                ),
                PopupMenuItem(value: 'report', child: Text(l10n.report)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// ... _MessageList, _MessageBubble, _MessageInput, _DateHeader, _TypingIndicator ...
// (Оставляем как есть, они уже используют l10n или не содержат текста)

// --- _MessageList (Без изменений) ---
class _MessageList extends StatelessWidget {
  final ScrollController scrollController;
  const _MessageList({required this.scrollController});

  bool _shouldShowDateHeader(chat_models.Message current, chat_models.Message? previous) {
    if (previous == null) return true;
    return !DateUtils.isSameDay(current.createdAt, previous.createdAt);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      buildWhen: (p, c) => p.messages != c.messages || p.isPartnerTyping != c.isPartnerTyping,
      builder: (context, state) {
        if (state.messages.isEmpty && !state.isPartnerTyping) {
          return const _EncryptionInfoCard();
        }

        return ListView.builder(
          controller: scrollController,
          reverse: true, // Рисуем снизу вверх
          padding: const EdgeInsets.fromLTRB(8, kToolbarHeight + 40, 8, 8),
          itemCount: state.messages.length + 1,
          itemBuilder: (context, index) {

            // Индекс 0 зарезервирован для индикатора "печатает"
            if (index == 0) {
              return state.isPartnerTyping ? const _TypingIndicator() : const SizedBox.shrink();
            }

            // ИСПРАВЛЕНИЕ: Берем сообщение напрямую по индексу (сдвиг -1 из-за индикатора)
            // Было: state.messages.reversed.toList()[index - 1]
            // Стало:
            final message = state.messages[index - 1];

            // Для даты берем следующее сообщение (которое старее, т.е. индекс больше)
            final prevMessage = (index < state.messages.length)
                ? state.messages[index]
                : null;

            return Column(
              children: [
                // Дату показываем, если день отличается от предыдущего (более старого) сообщения
                if (_shouldShowDateHeader(message, prevMessage)) _DateHeader(date: message.createdAt),
                _MessageBubble(message: message),
              ],
            );
          },
        );
      },
    );
  }
}

// --- _MessageInput (Без изменений) ---
class _MessageInput extends StatefulWidget {
  final TextEditingController controller;
  const _MessageInput({super.key, required this.controller});

  @override
  State<_MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<_MessageInput> {
  Timer? _typingTimer;
  bool _isTyping = false;

  void _onTextChanged(String text, BuildContext context) {
    // Сбрасываем старый таймер отключения статуса
    if (_typingTimer?.isActive ?? false) _typingTimer!.cancel();

    final chatId = context.read<ChatCubit>().state.chatId;
    if (chatId == null) return;

    // Если начали печатать и статус был false -> шлем true
    if (!_isTyping && text.isNotEmpty) {
      _isTyping = true;
      WebSocketService.instance.sendTypingStatus(
        chatId: chatId,
        isTyping: true,
      );
    }

    // Если стерли всё -> шлем false
    if (text.isEmpty && _isTyping) {
      _isTyping = false;
      WebSocketService.instance.sendTypingStatus(
        chatId: chatId,
        isTyping: false,
      );
      return;
    }

    // Таймер: если 2 секунды ничего не вводили -> шлем false
    _typingTimer = Timer(const Duration(seconds: 2), () {
      if (_isTyping) {
        _isTyping = false;
        if (mounted) {
          WebSocketService.instance.sendTypingStatus(
            chatId: chatId,
            isTyping: false,
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _typingTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: widget.controller,
      builder: (context, value, child) {
        final isTextEmpty = value.text.trim().isEmpty;

        return ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              padding: EdgeInsets.only(
                left: 8,
                right: 8,
                top: 8,
                bottom: MediaQuery.of(context).viewInsets.bottom + 8,
              ),
              color: Colors.black.withOpacity(0.3),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.attach_file, color: Colors.white70),
                    onPressed: () {},
                  ),
                  Expanded(
                    child: TextField(
                      controller: widget.controller,
                      style: const TextStyle(color: Colors.white),
                      textCapitalization: TextCapitalization.sentences,
                      maxLines: 5,
                      minLines: 1,
                      decoration: InputDecoration(
                        hintText: l10n.chat_input_hint,
                        hintStyle: const TextStyle(color: Colors.white54),
                        filled: true,
                        fillColor: Colors.white10,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                      ),
                      onChanged: (text) => _onTextChanged(text, context),
                    ),
                  ),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    transitionBuilder: (child, animation) =>
                        ScaleTransition(scale: animation, child: child),
                    child: isTextEmpty
                        ? IconButton(
                      key: const ValueKey('mic'),
                      icon: const Icon(Icons.mic, color: Colors.white70),
                      onPressed: () { /* TODO: Аудио */ },
                    )
                        : IconButton(
                      key: const ValueKey('send'),
                      icon: const Icon(Icons.send, color: Colors.pinkAccent),
                      onPressed: () {
                        if (widget.controller.text.trim().isNotEmpty) {
                          // При отправке сразу сбрасываем "печатает"
                          if (_isTyping) {
                            _isTyping = false;
                            _typingTimer?.cancel();
                            final chatId = context.read<ChatCubit>().state.chatId;
                            if (chatId != null) {
                              WebSocketService.instance.sendTypingStatus(
                                chatId: chatId,
                                isTyping: false,
                              );
                            }
                          }

                          context.read<ChatCubit>().sendMessage(widget.controller.text);
                          widget.controller.clear();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// --- _MessageBubble (Без изменений) ---
class _MessageBubble extends StatelessWidget {
  final chat_models.Message message;
  const _MessageBubble({required this.message});

  bool _isEmojiOnly(String text) {
    if (text.trim().isEmpty) return false;
    if (text.runes.length > 10) return false;
    const emojiPattern = r'[\u{1F600}-\u{1F64F}\u{1F300}-\u{1F5FF}\u{1F680}-\u{1F6FF}\u{1F1E0}-\u{1F1FF}\u{2600}-\u{26FF}\u{2700}-\u{27BF}\u{FE00}-\u{FE0F}\u{1F900}-\u{1F9FF}\u{1F018}-\u{1F270}\u{238C}-\u{2454}\u{20D0}-\u{20FF}\s+]';
    final noEmoji = text.replaceAll(RegExp(emojiPattern, unicode: true), '');
    return noEmoji.isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isMyMessage = context.read<AppCubit>().state.currentUserProfile?.id == message.senderId;
    final isEmoji = _isEmojiOnly(message.text);
    final fontSize = isEmoji ? 40.0 : 16.0;
    final bubbleColor = isEmoji ? Colors.transparent : (isMyMessage ? Colors.pinkAccent : const Color(0xFF2E2E3A));
    final double elevation = isEmoji ? 0 : 1;

    final bubbleContent = Card(
      color: bubbleColor,
      elevation: elevation,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(20),
          topRight: const Radius.circular(20),
          bottomLeft: isMyMessage ? const Radius.circular(20) : const Radius.circular(4),
          bottomRight: isMyMessage ? const Radius.circular(4) : const Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(message.text, style: TextStyle(color: Colors.white, fontSize: fontSize)),
            if (!isEmoji) ...[
              const SizedBox(height: 4),
              Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      DateFormat.Hm(l10n.localeName).format(message.createdAt),
                      style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12),
                    ),
                    if (isMyMessage) ...[
                      const SizedBox(width: 5),
                      Icon(Icons.done_all, size: 16, color: message.isRead ? Colors.lightBlueAccent : Colors.white54),
                    ],
                  ],
                ),
              ),
            ]
          ],
        ),
      ),
    );

    return Align(
      alignment: isMyMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        child: bubbleContent,
      ),
    );
  }
}

// --- _DateHeader (Исправлено, убрана инициализация локали) ---
class _DateHeader extends StatelessWidget {
  final DateTime date;
  const _DateHeader({required this.date});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    // Инициализация локали происходит в main.dart, здесь не нужно
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        DateFormat(l10n.chat_date_format, l10n.localeName).format(date),
        style: const TextStyle(color: Colors.white54, fontSize: 12),
      ),
    );
  }
}

// --- _TypingIndicator (Без изменений) ---
class _TypingIndicator extends StatelessWidget {
  const _TypingIndicator();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(color: const Color(0xFF2E2E3A), borderRadius: BorderRadius.circular(20)),
        child: const SizedBox(width: 40, height: 20, child: GlisteningDots()),
      ),
    ).animate().fadeIn(duration: 300.ms);
  }
}

// --- GlisteningDots (Без изменений) ---
class GlisteningDots extends StatefulWidget {
  const GlisteningDots({super.key});
  @override
  State<GlisteningDots> createState() => _GlisteningDotsState();
}

class _GlisteningDotsState extends State<GlisteningDots> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000))..repeat();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(3, (i) {
          final time = (_controller.value + i * 0.33) % 1.0;
          final opacity = (0.5 - (time - 0.5).abs()) * 2;
          return Opacity(opacity: opacity, child: const CircleAvatar(radius: 4, backgroundColor: Colors.white54));
        }),
      ),
    );
  }
}

// --- _EncryptionInfoCard (Без изменений) ---
class _EncryptionInfoCard extends StatelessWidget {
  const _EncryptionInfoCard({super.key});
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(12)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.lock_outline, color: Colors.greenAccent, size: 32),
                  const SizedBox(height: 12),
                  Text(l10n.encrypted_chat_banner_title, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16)),
                  const SizedBox(height: 8),
                  Text(l10n.encrypted_chat_banner_desc, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white70, height: 1.5)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}