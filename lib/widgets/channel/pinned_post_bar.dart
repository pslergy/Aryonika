// lib/widgets/channel/pinned_post_bar.dart
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovequest/cubit/channel_cubit.dart';
import 'package:lovequest/cubit/channel_state.dart';

class PinnedPostBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onTap;
  const PinnedPostBar({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChannelCubit, ChannelState>(
      buildWhen: (p, c) => p.activeChannel?.pinnedPostId != c.activeChannel?.pinnedPostId,
      builder: (context, state) {
        // Находим сам закрепленный пост в списке загруженных
        final pinnedPost = state.activeChannelPosts.firstWhereOrNull(
              (p) => p.id == state.activeChannel?.pinnedPostId,
        );

        // Если нет закрепленного поста или он еще не загружен в ленту, ничего не показываем
        if (pinnedPost == null) {
          return const SizedBox.shrink();
        }

        return Material(
          color: Colors.deepPurple.withOpacity(0.3),
          child: InkWell(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.white12, width: 0.5)),
              ),
              child: Row(children: [
                const Icon(Icons.push_pin, size: 18, color: Colors.white70),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Закреплённое сообщение", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                      const SizedBox(height: 2),
                      Text(pinnedPost.text, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.8))),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50.0);
}