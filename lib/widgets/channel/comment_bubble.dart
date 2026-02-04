// lib/widgets/channel/comment_bubble.dart (Новый или обновленный файл)

import 'dart:convert';

import 'package:flutter/material.dart';
import '../../src/data/models/comment.dart';
import 'package:lovequest/src/data/models/comment.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovequest/cubit/app_cubit.dart';

class CommentBubble extends StatelessWidget {
  final Comment comment;
  final VoidCallback onReply;

  // Список доступных реакций
  final List<String> _availableReactions = ['👍', '❤️', '😂', '🔥', '🤔'];

  CommentBubble({
    super.key,
    required this.comment,
    required this.onReply,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AppCubit>();
    final currentUser = cubit.state.currentUserProfile;
    final bool isAdmin = currentUser?.role == 'admin';
    final currentUserId = cubit.state.currentUserProfile?.id;

    final imageBytes = (comment.authorAvatarUrl != null && comment.authorAvatarUrl!.isNotEmpty && comment.authorAvatarUrl!.contains(','))
        ? base64Decode(comment.authorAvatarUrl!.split(',').last)
        : null;

    return InkWell(
      onLongPress: () {
        if (isAdmin) {
          _showAdminMenu(context, cubit, comment);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- АВАТАР ---
            GestureDetector(
            onTap: () {
          // --- ИСПРАВЛЕНИЕ ЗДЕСЬ ---
          if (comment.authorId == currentUserId) {
        // Если это наш собственный комментарий, переходим на наш профиль
                    context.push('/profile');
              } else {
                // Иначе - на экран профиля другого пользователя
                context.push('/user_profile/${comment.authorId}');
                }
                // --------------------------
                },
              child: CircleAvatar(
                radius: 20,
                backgroundImage: imageBytes != null ? MemoryImage(imageBytes) : null,
                child: imageBytes == null
                    ? Text(comment.authorName.isNotEmpty ? comment.authorName.substring(0, 1).toUpperCase() : '?')
                    : null,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- ИМЯ И ТЕКСТ ---
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () => context.push('/user_profile/${comment.authorId}'),
                          child: Text(
                            comment.authorName,
                            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.pinkAccent),
                          ),
                        ),
                        if (comment.replyToAuthorName != null && comment.replyToAuthorName!.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              "в ответ @${comment.replyToAuthorName}",
                              style: TextStyle(color: Colors.grey.shade400, fontStyle: FontStyle.italic, fontSize: 12),
                            ),
                          ),
                        const SizedBox(height: 4),
                        Text(comment.text, style: const TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),

                  // --- ИСПРАВЛЕННАЯ СТРОКА С КНОПКАМИ ДЕЙСТВИЙ И РЕАКЦИЯМИ ---
                  Row(
                    children: [
                      Text(
                        "5м", // TODO: Добавить форматирование времени (timeago)
                        style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                      ),
                      const SizedBox(width: 16),
                      InkWell(
                        onTap: onReply,
                        child: Text(
                          "Ответить",
                          style: TextStyle(color: Colors.grey.shade400, fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Spacer(), // Занимает все свободное место
                      IconButton(
                        icon: const Icon(Icons.add_reaction_outlined, size: 18, color: Colors.grey),
                        onPressed: () => _showReactionPicker(context, cubit, comment),
                      ),
                      // Отображаем существующие реакции с помощью spread-оператора (...)
                      ...comment.reactions.entries.map((entry) {
                        final bool didReact = entry.value.contains(currentUser?.id);
                        return Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: InkWell(
                            onTap: () {
                              cubit.toggleCommentReaction(
                                commentId: comment.id,
                                reaction: entry.key,
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: didReact ? Colors.blue.withOpacity(0.5) : Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                                border: didReact ? Border.all(color: Colors.blueAccent, width: 1.5) : null,
                              ),
                              child: Text("${entry.key} ${entry.value.length}", style: const TextStyle(fontSize: 12)),
                            ),
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- ДОБАВЛЕН НЕДОСТАЮЩИЙ МЕТОД ---
  void _showReactionPicker(BuildContext context, AppCubit cubit, Comment comment) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900],
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: _availableReactions.map((emoji) {
              return InkWell(
                onTap: () {
                  cubit.toggleCommentReaction(
                    commentId: comment.id,
                    reaction: emoji,
                  );
                  Navigator.pop(context);
                },
                child: Text(
                  emoji,
                  style: const TextStyle(fontSize: 28),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  // Меню для админа
  void _showAdminMenu(BuildContext context, AppCubit cubit, Comment comment) {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.delete_outline, color: Colors.red),
              title: const Text('Удалить комментарий'),
              onTap: () {
                Navigator.pop(context);
                // cubit.deleteComment(...);
              },
            ),
            ListTile(
              leading: const Icon(Icons.block, color: Colors.orange),
              title: const Text('Забанить пользователя'),
              onTap: () {
                Navigator.pop(context);
                cubit.banUser(userId: comment.authorId, shouldBan: true);
              },
            ),
            ListTile(
              leading: const Icon(Icons.check_circle_outline, color: Colors.green),
              title: const Text('Разбанить пользователя'),
              onTap: () {
                Navigator.pop(context);
                cubit.banUser(userId: comment.authorId, shouldBan: false);
              },
            ),
          ],
        ),
      ),
    );
  }
}