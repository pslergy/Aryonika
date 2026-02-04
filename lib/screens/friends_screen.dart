// lib/screens/friends_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lovequest/cubit/app_cubit.dart';
import 'package:lovequest/cubit/app_state.dart';
import 'package:lovequest/l10n/generated/app_localizations.dart';
import 'package:lovequest/src/data/models/user_profile_card.dart';
import 'package:lovequest/widgets/common/user_avatar.dart';
import '../widgets/common/animated_cosmic_background.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key});

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    context.read<AppCubit>().loadFriendsData();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.nav_friends),
        backgroundColor: Colors.transparent,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.pinkAccent,
          tabs: [
            Tab(text: l10n.myFriendsTab), // "Мои друзья"
            Tab(text: l10n.friendRequestsTab), // "Заявки"
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add),
            onPressed: () => context.push('/search'),
          )
        ],
      ),
      body: AnimatedCosmicBackground(
        child: BlocBuilder<AppCubit, AppState>(
          builder: (context, state) {
            if (state.isLoadingFriends) {
              return const Center(child: CircularProgressIndicator());
            }

            return TabBarView(
              controller: _tabController,
              children: [
                _buildUserList(
                  context,
                  state.friends,
                  emptyMessage: l10n.noFriendsYet, // "У вас пока нет друзей..."
                  isRequest: false,
                  l10n: l10n,
                ),
                _buildUserList(
                  context,
                  state.friendRequests,
                  emptyMessage: l10n.noFriendRequests, // "Нет новых заявок."
                  isRequest: true,
                  l10n: l10n,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildUserList(BuildContext context, List<UserProfileCard> users, {required String emptyMessage, required bool isRequest, required AppLocalizations l10n}) {
    if (users.isEmpty) {
      return Center(child: Text(emptyMessage, style: const TextStyle(color: Colors.white54)));
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: users.length,
      separatorBuilder: (ctx, i) => const Divider(color: Colors.white10),
      itemBuilder: (context, index) {
        final user = users[index];
        return ListTile(
          leading: UserAvatar(user: user, radius: 24),
          title: Text(user.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          subtitle: Text(user.sunSign.isNotEmpty ? user.sunSign : "...", style: const TextStyle(color: Colors.white54)),
          onTap: () => context.push('/user_profile/${user.id}'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isRequest) ...[
                IconButton(
                  icon: const Icon(Icons.check_circle, color: Colors.greenAccent),
                  onPressed: () => context.read<AppCubit>().acceptFriendRequest(user),
                ),
                IconButton(
                  icon: const Icon(Icons.cancel, color: Colors.redAccent),
                  onPressed: () => context.read<AppCubit>().removeOrDeclineFriend(user.id),
                ),
              ] else ...[
                IconButton(
                  icon: const Icon(Icons.chat_bubble_outline, color: Colors.white),
                  onPressed: () async {
                    final chatId = await context.read<AppCubit>().openChatWithUser(user.id);
                    if (chatId != null && context.mounted) {
                      context.push('/chat/$chatId');
                    }
                  },
                ),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert, color: Colors.white54),
                  onSelected: (value) {
                    if (value == 'delete') {
                      context.read<AppCubit>().removeOrDeclineFriend(user.id);
                    }
                  },
                  itemBuilder: (BuildContext context) => [
                    PopupMenuItem(
                      value: 'delete',
                      child: Text(l10n.removeFriend, style: const TextStyle(color: Colors.red)), // "Удалить из друзей"
                    ),
                  ],
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}