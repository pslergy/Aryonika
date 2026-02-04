// lib/screens/comments_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lovequest/cubit/channel_state.dart';
// НЕ ЗАБУДЬ ИМПОРТ ЛОКАЛИЗАЦИИ
import 'package:lovequest/l10n/generated/app_localizations.dart';
// Проверь путь до enums.dart (или удали этот импорт, если ChannelStatus определен в channel_state.dart)
// import 'package:lovequest/src/data/models/enums.dart';
import 'package:lovequest/widgets/common/animated_cosmic_background.dart';
import 'package:lovequest/widgets/channel/comment_bubble.dart';

import '../cubit/channel_cubit.dart';
import '../src/data/models/comment.dart';

class CommentsScreen extends StatefulWidget {
  final String channelId;
  final String postId;
  const CommentsScreen({super.key, required this.channelId, required this.postId});

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  late final TextEditingController _textController;
  final _focusNode = FocusNode();
  Comment? _replyingToComment;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();

    // Загружаем комментарии
    context.read<ChannelCubit>().loadCommentsForPost(widget.postId);

    _textController.addListener(() {
      context.read<ChannelCubit>().onCommentTextChanged(_textController.text);
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    // Сообщаем ChannelCubit, что мы ушли
    // Используем context.read безопасно, так как dispose может быть вызван при размонтировании
    // Но лучше вызывать методы кубита напрямую, если он создавался выше
    // context.read<ChannelCubit>().onCommentsScreenClosed();
    super.dispose();
  }

  void _postOrReply() {
    if (_textController.text.trim().isEmpty) return;

    final channelCubit = context.read<ChannelCubit>();

    if (_replyingToComment != null) {
      channelCubit.replyToComment(
        postId: widget.postId,
        parentComment: _replyingToComment!,
        text: _textController.text.trim(),
      );
    } else {
      channelCubit.postComment(
        widget.postId,
        _textController.text.trim(),
      );
    }

    _textController.clear();
    FocusScope.of(context).unfocus();
    setState(() => _replyingToComment = null);
  }

  void _cancelReply() {
    setState(() => _replyingToComment = null);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AnimatedCosmicBackground(
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(l10n.commentsTitle), // "Комментарии"
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new),
                onPressed: () => context.pop(),
              ),
            ),

            Expanded(
              child: BlocBuilder<ChannelCubit, ChannelState>(
                buildWhen: (p, c) =>
                p.commentsStatus != c.commentsStatus ||
                    p.activePostComments != c.activePostComments,
                builder: (context, state) {
                  if (state.commentsStatus == ChannelStatus.loading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state.commentsStatus == ChannelStatus.error) {
                    return Center(child: Text(l10n.commentsLoadError)); // "Ошибка загрузки комментариев."
                  }
                  if (state.activePostComments.isEmpty) {
                    return Center(child: Text(l10n.noCommentsYet)); // "Здесь пока нет комментариев."
                  }

                  final comments = state.activePostComments;

                  return ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: comments.length,
                    itemBuilder: (context, index) {
                      final comment = comments[index];
                      return CommentBubble(
                        comment: comment,
                        onReply: () {
                          setState(() => _replyingToComment = comment);
                          _focusNode.requestFocus();
                        },
                      );
                    },
                  );
                },
              ),
            ),

            BlocBuilder<ChannelCubit, ChannelState>(
              buildWhen: (p, c) => p.typingUsers != c.typingUsers,
              builder: (context, state) {
                if (state.typingUsers.isEmpty) return const SizedBox.shrink();

                final names = state.typingUsers.values.toList();
                String typingText;

                // Простая логика для локализации
                if (names.length == 1) {
                  typingText = l10n.userIsTyping(names[0]); // "Ivan печатает..."
                } else if (names.length == 2) {
                  typingText = l10n.twoUsersTyping(names[0], names[1]); // "Ivan и Maria печатают..."
                } else {
                  typingText = l10n.manyUsersTyping(names[0], names[1], (names.length - 2).toString()); // "Ivan, Maria и еще 3..."
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                  child: Text(typingText, style: TextStyle(color: Colors.grey[400], fontStyle: FontStyle.italic)),
                );
              },
            ),

            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 12),
                child: Column(mainAxisSize: MainAxisSize.min, children: [

                  // --- Блок ответа на комментарий (восстановлен) ---
                  if (_replyingToComment != null)
                    Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: Colors.white10,
                        border: const Border(left: BorderSide(color: Colors.pinkAccent, width: 2)),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    l10n.replyingTo( _replyingToComment!.authorName), // "Ответ для Ivan"
                                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.pinkAccent, fontSize: 12)
                                ),
                                Text(
                                    _replyingToComment!.text,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(color: Colors.white70, fontSize: 12)
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, size: 16, color: Colors.white54),
                            onPressed: _cancelReply,
                          ),
                        ],
                      ),
                    ),
                  // --------------------------------------------------

                  Row(children: [
                    Expanded(child: TextField(
                      controller: _textController,
                      focusNode: _focusNode,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: l10n.writeCommentHint, // "Написать комментарий..."
                        hintStyle: const TextStyle(color: Colors.white54),
                        filled: true,
                        fillColor: Colors.white10,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      ),
                      onSubmitted: (_) => _postOrReply(),
                    )),
                    IconButton(
                        icon: const Icon(Icons.send, color: Colors.pinkAccent),
                        onPressed: _postOrReply
                    ),
                  ]),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}