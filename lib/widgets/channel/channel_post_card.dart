// lib/widgets/channel/channel_post_card.dart

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovequest/cubit/app_cubit.dart';
import 'package:lovequest/l10n/generated/app_localizations.dart';

import 'package:lovequest/src/data/models/post.dart';
import 'package:lovequest/widgets/common/smart_image.dart';
import 'package:share_plus/share_plus.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:visibility_detector/visibility_detector.dart';

import '../../cubit/channel_cubit.dart';

import '../../services/logger_service.dart';
import 'edit_post_dialog.dart';


void showEmojiPicker(BuildContext context, {required Function(String) onEmojiSelected}) {
  final List<String> emojis = [
    // --- Популярные ---
    '❤️', '👍', '😂', '🔥', '🥰', '👏', '🙏', '💯',

    // --- Позитивные ---
    '😊', '😍', '🤩', '🎉', '✨', '🤗', '🥳', '🙌',

    // --- Смех и веселье ---
    '🤣', '😁', '😄', '😆', '😜', '😎', '😹', '🤡',

    // --- Согласие и поддержка ---
    '👌', '✅', '✔️', '💪', '🤝', '🎯', '☑️', '👊',

    // --- Удивление ---
    '🤯', '😱', '😮', '😲', '😳', '💥', '⁉️', '‼️',

    // --- Грусть и сочувствие ---
    '😢', '😭', '💔', '😥', '😔', '🥺', '☹️', '🫂',

    // --- Злость и несогласие ---
    '😡', '😠', '👎', '🤬', '😤', '😒', '🙄', '😑',

    // --- Размышление ---
    '🤔', '🧐', '👀', '💡', '✍️', '🔎', '🤨', '👀',

    // --- Еда и напитки ---
    '🍿', '🍕', '🍻', '🥂', '🍾', '☕', '🍩', '🍓',

    // --- Животные ---
    '🦄', '🐱', '🐶', '🙈', '🙉', '🙊', '🐸', '🐳',

    // --- Негативные (осторожно) ---
    '🤮', '🤢', '💩', '☠️', '🖕', '🤡', '💀', '👻',
  ];

  showModalBottomSheet(
    context: context,
    backgroundColor: Theme.of(context).cardColor.withOpacity(0.95),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return SafeArea(
        child: GridView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.all(24.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
          ),
          itemCount: emojis.length,
          itemBuilder: (context, index) {
            final emoji = emojis[index];
            return InkWell(
              onTap: () {
                Navigator.of(context).pop();
                onEmojiSelected(emoji);
              },
              borderRadius: BorderRadius.circular(24),
              child: Center(
                child: Text(
                  emoji,
                  style: const TextStyle(fontSize: 32),
                ),
              ),
            );
          },
        ),
      );
    },
  );
}
class ChannelPostCard extends StatelessWidget {
  final Post post;
  final VoidCallback onCommentClick;

  // Убираем isCurrentUserAdmin, так как будем вычислять права более гибко
  const ChannelPostCard({
    super.key,
    required this.post,
    required this.onCommentClick,
  });

  ImageProvider? _getAvatarImage(String? url) {
    if (url != null && url.isNotEmpty) {
      if (url.startsWith('data:image')) {
        try {
          // Декодируем base64 строку
          return MemoryImage(base64Decode(url.split(',').last));
        } catch (e) {
          logger.d("Ошибка декодирования аватара (base64) в ChannelPostCard: $e");
          return null; // Возвращаем null в случае ошибки
        }
      } else if (url.startsWith('http')) {
        // Если это обычный URL, используем NetworkImage
        return NetworkImage(url);
      }
    }
    // Если URL пустой или null, возвращаем null
    return null;
  }

  // === ВСПОМОГАТЕЛЬНЫЙ ВИДЖЕТ ДЛЯ ОТОБРАЖЕНИЯ КАРТИНКИ ===
  Widget _buildPostImage() {
    // В качестве заглушки будем использовать центрированный индикатор загрузки
    const Widget placeholder = Center(child: CircularProgressIndicator());

    // Проверяем, есть ли у нас размеры изображения
    final hasDimensions = post.imageWidth != null &&
        post.imageHeight != null &&
        post.imageWidth! > 0 &&
        post.imageHeight! > 0;

    if (hasDimensions) {
      // Если размеры есть, оборачиваем SmartImage в AspectRatio
      return AspectRatio(
        aspectRatio: post.imageWidth! / post.imageHeight!,
        child: SmartImage(
          imageUrl: post.imageUrl!,
          fit: BoxFit.cover,
          // === ИСПРАВЛЕНИЕ ЗДЕСЬ ===
          placeholder: placeholder,
          // ==========================
        ),
      );
    } else {
      // Fallback для старых постов
      return SmartImage(
        imageUrl: post.imageUrl!,
        width: double.infinity,
        fit: BoxFit.cover,
        // === ИСПРАВЛЕНИЕ ЗДЕСЬ ===
        placeholder: placeholder,
        // ==========================
      );
    }
  }


  // Вспомогательный виджет для отображения картинки поста


  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final appState = context.watch<AppCubit>().state;
    final currentUserId = appState.currentUserProfile?.id;
    final cubit = context.read<ChannelCubit>();

    timeago.setLocaleMessages(l10n.localeName, _getTimeagoLocale(l10n.localeName));
    final postTime = timeago.format(post.createdAt, locale: l10n.localeName);

    final avatarImage = _getAvatarImage(post.authorAvatarUrl);
    final myReaction = _getMyReaction(post.reactions, currentUserId);

    // --- 👇 НОВАЯ, БОЛЕЕ ГИБКАЯ ПРОВЕРКА ПРАВ 👇 ---
    final isChannelOwner = appState.currentUserProfile?.id == cubit.state.activeChannel?.ownerId;
    final isPostAuthor = post.authorId == currentUserId;
    // Редактировать или удалять может либо владелец канала, либо автор поста
    final canEditOrDelete = isChannelOwner || isPostAuthor;

    return VisibilityDetector(
      key: Key(post.id),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.5) cubit.onPostVisible(post.id);
      },
      child: Card(
        elevation: 4,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: avatarImage,
                child: avatarImage == null ? Text(post.authorName.isNotEmpty ? post.authorName.substring(0, 1).toUpperCase() : '?') : null,
              ),
              title: Text(post.authorName, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Row(children: [
                Text(postTime),
                if (post.isEdited)
                  const Text(' • изменено', style: TextStyle(fontSize: 12, color: Colors.grey, fontStyle: FontStyle.italic)),
                const SizedBox(width: 8),
                const Icon(Icons.visibility_outlined, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Text(_formatViews(post.viewCount), style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ]),
              // --- 👇 ОБНОВЛЕННЫЙ ВЫЗОВ МЕНЮ 👇 ---
              trailing: canEditOrDelete ? _buildAdminMenu(context, cubit, post, l10n) : null,
            ),
            if (post.text.isNotEmpty)
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 8.0),
                child: Text(post.text),
              ),
            if (post.imageUrl != null && post.imageUrl!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: _buildPostImage(),
              ),

            // --- 👇 ИСПРАВЛЕНИЕ ВЫЗОВА 👇 ---
            if (post.reactions.isNotEmpty)
              _buildReactionsDisplay(context, post.reactions, currentUserId),

            const Divider(height: 1),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildActionButton(
                    context: context,
                    icon: myReaction != null ? null : Icons.favorite_border,
                    label: myReaction ?? l10n.postActionLike,
                    color: myReaction != null ? Colors.pinkAccent : Colors.grey,
                    onPressed: () {
                      // --- 👇 ИСПРАВЛЕНИЕ ВЫЗОВА 👇 ---
                      if (currentUserId != null) {
                        cubit.togglePostReaction(post.id, '❤️', currentUserId);
                      }
                    },
                    onLongPress: () => showEmojiPicker(context, onEmojiSelected: (emoji) {
                      // --- 👇 ИСПРАВЛЕНИЕ ВЫЗОВА 👇 ---
                      if (currentUserId != null) {
                        cubit.togglePostReaction(post.id, emoji, currentUserId);
                      }
                    }),
                  ),
                  _buildActionButton(
                    context: context,
                    icon: Icons.chat_bubble_outline_rounded,
                    label: post.commentCount > 0 ? post.commentCount.toString() : l10n.postActionComment,
                    color: Colors.grey,
                    onPressed: onCommentClick,
                  ),
                  _buildActionButton(
                    context: context,
                    icon: Icons.share_outlined,
                    label: l10n.postActionShare,
                    color: Colors.grey,
                    onPressed: () {
                      final channelName = cubit.state.activeChannel?.getLocalizedName(l10n.localeName) ?? l10n.channelDefaultName;
                      Share.share(l10n.postShareText(channelName, post.text));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? _getMyReaction(Map<String, List<String>> reactions, String? myId) {
    if (myId == null) return null;
    for (final entry in reactions.entries) {
      if (entry.value.contains(myId)) {
        return entry.key;
      }
    }
    return null; // <-- Убедись, что этот return есть
  }

  Widget _buildReactionsDisplay(BuildContext context, Map<String, List<String>> reactions, String? currentUserId) {
    // Сортируем реакции по количеству
    final sortedReactions = reactions.entries.toList()
      ..sort((a, b) => b.value.length.compareTo(a.value.length));

    return Padding(
      padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 0),
      child: Wrap(
        spacing: 6.0,
        runSpacing: 6.0,
        children: sortedReactions.map((entry) {
          final emoji = entry.key;
          final count = entry.value.length;
          final iLikedThis = currentUserId != null && entry.value.contains(currentUserId);

          // Анимируем появление/исчезновение и изменение размера
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: iLikedThis
                  ? Colors.pink.withOpacity(0.3) // Моя реакция
                  : Colors.grey.withOpacity(0.15), // Чужая реакция
              borderRadius: BorderRadius.circular(20),
              border: iLikedThis
                  ? Border.all(color: Colors.pinkAccent.withOpacity(0.5), width: 1.0)
                  : null,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(emoji, style: const TextStyle(fontSize: 14)),
                const SizedBox(width: 5),
                Text(
                  count.toString(),
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ],
            ),
          ).animate().fadeIn(duration: 300.ms);
        }).toList(),
      ),
    );
  }

  // --- Вспомогательный виджет для компактной кнопки ---
  Widget _buildActionButton({
    required BuildContext context,
    IconData? icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
    VoidCallback? onLongPress,
  }) {
    // 1. Внешний Expanded остается, он нужен, чтобы кнопки занимали равное пространство в родительском Row.
    return Expanded(
      child: InkWell(
        onTap: onPressed,
        onLongPress: onLongPress,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) Icon(icon, color: color, size: 20),
              if (icon != null && label.length > 2) const SizedBox(width: 8),

              // --- 👇 ГЛАВНОЕ ИСПРАВЛЕНИЕ 👇 ---
              // 2. Оборачиваем Text в Flexible.
              // Flexible позволяет виджету сжиматься, если не хватает места.
              Flexible(
                child: Text(
                  label,
                  style: TextStyle(color: color, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis, // Показывает '...' если текст не помещается
                  maxLines: 1,                     // Ограничивает текст одной строкой
                  textAlign: TextAlign.center,     // Центрируем текст, если он сжимается
                ),
              ),
              // --- 👆 КОНЕЦ ИСПРАВЛЕНИЯ 👆 ---
            ],
          ),
        ),
      ),
    );
  }

  // --- Вспомогательная функция для форматирования числа просмотров (1.2k, 1.5M) ---
  String _formatViews(int count) {
    if (count < 1000) return count.toString();
    if (count < 1000000) return '${(count / 1000).toStringAsFixed(1)}k';
    return '${(count / 1000000).toStringAsFixed(1)}M';
  }

  Widget _buildAdminMenu(BuildContext context, ChannelCubit cubit, Post post, AppLocalizations l10n) {
    // Получаем ID закрепленного поста из стейта кубита
    final pinnedPostId = cubit.state.activeChannel?.pinnedPostId;
    final isPinned = post.id == pinnedPostId;
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert),
      onSelected: (value) {
        if (value == 'edit') {
          showDialog(
            context: context,
            // Передаем кубит в диалог, чтобы он мог вызвать метод editPost
            builder: (_) => BlocProvider.value(
              value: cubit,
              child: EditPostDialog(post: post),
            ),
          );
        }
        if (value == 'delete') {
          showDialog(
            context: context,
            builder: (dialogContext) => AlertDialog(
              title: Text(l10n.postDeleteDialogTitle),
              content: Text(l10n.postDeleteDialogContent),
              actions: [
                TextButton(onPressed: () => Navigator.of(dialogContext).pop(), child: Text(l10n.cancel)),
                TextButton(
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                    cubit.deletePost(post.id);
                  },
                  child: Text(l10n.delete, style: const TextStyle(color: Colors.red)),
                ),
              ],
            ),
          );
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 'pin',
          child: ListTile(
            leading: Icon(isPinned ? Icons.push_pin : Icons.push_pin_outlined),
            title: Text(isPinned ? "Открепить" : "Закрепить"),
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem(
          value: 'edit',
          child: ListTile(
            leading: const Icon(Icons.edit_outlined),
            title: Text("Редактировать"), // TODO: l10n
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem(
          value: 'delete',
          child: ListTile(
            leading: const Icon(Icons.delete_outline, color: Colors.red),
            title: Text(l10n.postMenuDelete, style: const TextStyle(color: Colors.red)),
          ),
        ),
      ],
    );
  }

  timeago.LookupMessages _getTimeagoLocale(String locale) {
    switch(locale) {
      case 'ru': return timeago.RuMessages();
      case 'de': return timeago.DeMessages();
      case 'fr': return timeago.FrMessages();
      case 'es': return timeago.EsMessages();
    // Добавь другие языки, если для них есть поддержка в пакете
      default: return timeago.EnMessages();
    }
  }
}