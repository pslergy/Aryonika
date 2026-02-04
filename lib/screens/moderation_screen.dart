// lib/screens/channel_moderation_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovequest/cubit/channel_cubit.dart';
import 'package:lovequest/cubit/channel_state.dart';
import 'package:lovequest/l10n/generated/app_localizations.dart'; // <-- Импорт локализации
import 'package:lovequest/widgets/common/animated_cosmic_background.dart';

class ChannelModerationScreen extends StatefulWidget {
  final String channelId;
  const ChannelModerationScreen({super.key, required this.channelId});

  @override
  State<ChannelModerationScreen> createState() => _ChannelModerationScreenState();
}

class _ChannelModerationScreenState extends State<ChannelModerationScreen> {
  late final ChannelCubit _channelCubit;

  @override
  void initState() {
    super.initState();
    _channelCubit = context.read<ChannelCubit>();
    context.read<ChannelCubit>().onModerationScreenOpened();
  }

  @override
  void dispose() {
    _channelCubit.onModerationScreenClosed();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.moderationProposedPosts)), // "Предложенные посты"
      body: AnimatedCosmicBackground(
        child: BlocBuilder<ChannelCubit, ChannelState>(
          builder: (context, state) {
            if (state.proposedPostsStatus == ChannelStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.proposedPosts.isEmpty) {
              return Center(child: Text(l10n.noProposedPosts)); // "Нет предложенных постов."
            }

            return ListView.builder(
              itemCount: state.proposedPosts.length,
              itemBuilder: (context, index) {
                final post = state.proposedPosts[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(post.text, maxLines: 2, overflow: TextOverflow.ellipsis),
                    subtitle: Text("${l10n.from}: ${post.authorName ?? '...'}"), // "От: ..."
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.check_circle, color: Colors.green),
                          onPressed: () {
                            context.read<ChannelCubit>().approvePost(post);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.cancel, color: Colors.red),
                          onPressed: () {
                            context.read<ChannelCubit>().rejectPost(post.id);
                          },
                        ),
                      ],
                    ),
                    onTap: () {
                      // TODO: Показать диалог с полным текстом
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}