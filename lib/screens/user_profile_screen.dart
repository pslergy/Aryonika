// lib/screens/user_profile_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_parsed_text/flutter_parsed_text.dart';
import 'package:go_router/go_router.dart';
import 'package:lovequest/cubit/app_cubit.dart';
import 'package:lovequest/l10n/generated/app_localizations.dart'; // <-- Импорт локализации

import 'package:lovequest/screens/photo_album_preview.dart';
import 'package:lovequest/screens/user_profile_header.dart'; // Если это твой кастомный виджет

import '../cubit/app_state.dart';

import '../src/data/models/enums.dart';
import '../src/data/models/user_profile_card.dart';
import '../widgets/common/alpha_version_banner.dart';
import '../widgets/common/animated_cosmic_background.dart';
import '../widgets/common/portal_card.dart';

class UserProfileScreen extends StatefulWidget {
  final String userId;
  final String? iceBreaker;
  const UserProfileScreen({super.key, required this.userId, this.iceBreaker,});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  late final AppCubit _appCubit;

  @override
  void initState() {
    super.initState();
    _appCubit = context.read<AppCubit>();
    _appCubit.loadProfileForViewing(widget.userId);
    _appCubit.loadUserPhotos(widget.userId);
  }

  @override
  void dispose() {
    _appCubit.clearViewedProfile(userIdToClear: widget.userId);
    super.dispose();
  }

  // Метод для перевода знака зодиака
  String _getTranslatedZodiacName(String zodiacKey, AppLocalizations l10n) {
    switch (zodiacKey) {
      case 'Rat': return l10n.zodiac_Rat;
      case 'Ox': return l10n.zodiac_Ox;
      case 'Tiger': return l10n.zodiac_Tiger;
      case 'Rabbit': return l10n.zodiac_Rabbit;
      case 'Dragon': return l10n.zodiac_Dragon;
      case 'Snake': return l10n.zodiac_Snake;
      case 'Horse': return l10n.zodiac_Horse;
      case 'Goat': return l10n.zodiac_Goat;
      case 'Monkey': return l10n.zodiac_Monkey;
      case 'Rooster': return l10n.zodiac_Rooster;
      case 'Dog': return l10n.zodiac_Dog;
      case 'Pig': return l10n.zodiac_Pig;
      default: return zodiacKey;
    }
  }

  void _showReportDialog(BuildContext context, UserProfileCard profile) {
    final l10n = AppLocalizations.of(context)!;
    String? selectedReason;
    final detailsController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(l10n.reportOnUser(profile.name)),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _buildReasonRadioTile(setState, l10n.reportReasonSpam, selectedReason, (val) => selectedReason = val),
                    _buildReasonRadioTile(setState, l10n.reportReasonInsultingBehavior, selectedReason, (val) => selectedReason = val),
                    _buildReasonRadioTile(setState, l10n.reportReasonScam, selectedReason, (val) => selectedReason = val),
                    _buildReasonRadioTile(setState, l10n.reportReasonInappropriateContent, selectedReason, (val) => selectedReason = val),
                    const SizedBox(height: 16),
                    TextField(
                      controller: detailsController,
                      decoration: InputDecoration(
                        hintText: l10n.reportDetailsHint,
                        border: const OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text(l10n.cancel),
                  onPressed: () => Navigator.of(dialogContext).pop(),
                ),
                ElevatedButton(
                  onPressed: selectedReason == null ? null : () {
                    context.read<AppCubit>().submitReport(
                      reportedUserId: profile.id,
                      reason: selectedReason!,
                      details: detailsController.text,
                      contentType: 'profile',
                    );

                    Navigator.of(dialogContext).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(l10n.reportSentSnackbar)),
                    );
                  },
                  child: Text(l10n.send),
                ),
              ],
            );
          },
        );
      },
    ).whenComplete(() => detailsController.dispose());
  }

  Widget _buildReasonRadioTile(void Function(void Function()) setState, String title, String? groupValue, void Function(String?) onChanged) {
    return RadioListTile<String>(
      title: Text(title),
      value: title,
      groupValue: groupValue,
      onChanged: (value) {
        setState(() {
          onChanged(value);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _buildActionButtons(context),
      backgroundColor: Colors.transparent,
      body: AnimatedCosmicBackground(
        child: BlocBuilder<AppCubit, AppState>(
          buildWhen: (p, c) => p.isLoadingViewedProfile != c.isLoadingViewedProfile || p.currentViewedProfile != c.currentViewedProfile || p.likedUserIds != c.likedUserIds || p.friendshipStatusMap != c.friendshipStatusMap,
          builder: (context, state) {
            if (state.isLoadingViewedProfile && state.currentViewedProfile == null) {
              return const Center(child: CircularProgressIndicator());
            }
            final profile = state.currentViewedProfile;
            if (profile == null) {
              return Scaffold(
                appBar: AppBar(
                  leading: const BackButton(color: Colors.white),
                  backgroundColor: Colors.transparent,
                ),
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(l10n.profileLoadError, style: const TextStyle(color: Colors.white)), // "Не удалось загрузить профиль"
                      const SizedBox(height: 16),
                      ElevatedButton(
                          onPressed: () => context.pop(),
                          child: Text(l10n.back) // "Назад"
                      )
                    ],
                  ),
                ),
              );
            }

            return CustomScrollView(
              slivers: [
                UserProfileHeader(
                  profile: profile,
                  actions: [
                    PopupMenuButton<String>(
                      onSelected: (value) { if (value == 'report') _showReportDialog(context, profile); },
                      itemBuilder: (ctx) => [
                        PopupMenuItem<String>(value: 'report', child: ListTile(leading: const Icon(Icons.report_problem_outlined), title: Text(l10n.report))), // "Пожаловаться"
                      ],
                    ),
                  ],
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildFriendshipButton(context, profile.id),
                        const SizedBox(height: 24),
                        if (profile.photoCount > 0)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 24.0),
                            child: PortalCard(
                              icon: Icons.photo_library_outlined,
                              title: l10n.userProfilePhotoAlbumTitle(profile.photoCount.toString()), // "Фотоальбом (5)"
                              subtitle: l10n.userProfileViewPhotos, // "Посмотреть фотографии"
                              onClick: () => context.push('/album/${profile.id}'),
                            ),
                          ),
                        Text(l10n.aboutMe, style: Theme.of(context).textTheme.titleLarge), // "О себе"
                        const SizedBox(height: 8),
                        if (profile.bio.isEmpty)
                          Text(l10n.bioEmpty) // "Пользователь ничего не рассказал о себе."
                        else
                          ParsedText(
                            text: profile.bio,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5),
                            parse: <MatchText>[
                              MatchText(
                                pattern: r'#(\w+)',
                                style: const TextStyle(color: Colors.cyanAccent, fontWeight: FontWeight.bold),
                                onTap: (tag) {
                                  context.read<AppCubit>().startSearchWithHashtag(tag.substring(1));
                                  context.push('/search');
                                },
                              ),
                            ],
                          ),

                        const Divider(height: 48, color: Colors.white24),
                        Text(l10n.cosmicPassport, style: Theme.of(context).textTheme.titleLarge), // "Космический паспорт"
                        ListTile(title: Text(l10n.sunInSign(profile.sunSign))), // "Солнце в знаке..."

                        if (profile.chineseZodiac.isNotEmpty) ...[
                          const SizedBox(height: 16),
                          Text(l10n.chinese_zodiac_title, style: Theme.of(context).textTheme.titleLarge), // "Китайский гороскоп"
                          const SizedBox(height: 8),
                          Card(
                            color: Colors.white.withOpacity(0.1),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Image.asset('assets/images/zodiac/${profile.chineseZodiac.toLowerCase()}.png', height: 60, width: 60, errorBuilder: (_, __, ___) => const Icon(Icons.help_outline, size: 60)),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(_getTranslatedZodiacName(profile.chineseZodiac, l10n), style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                                        const SizedBox(height: 8),
                                        TextButton(
                                          onPressed: () => context.push ('/chinese_zodiac_compatibility/${profile.id}'),
                                          child: Text(l10n.chinese_zodiac_compatibility_button), // "Совместимость по гороскопу"
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],

                        const Divider(height: 48, color: Colors.white24),
                        Text(l10n.compatibility_section_title, style: Theme.of(context).textTheme.titleLarge), // "Совместимость"
                        const SizedBox(height: 16),

                        Row(
                          children: [
                            Expanded(child: ElevatedButton.icon(style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent), icon: const Icon(Icons.favorite), label: Text(l10n.userProfile_astro_button), onPressed: () => context.push('/compatibility/${profile.id}'))),
                            const SizedBox(width: 16),
                            Expanded(child: ElevatedButton.icon(style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple), icon: const Icon(Icons.calculate_outlined), label: Text(l10n.userProfile_numerology_button), onPressed: () => context.push('/numerology-compatibility/${profile.id}'),
                            )),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                            icon: const Icon(Icons.translate),
                            label: Text(l10n.userProfile_bazi_button),
                            onPressed: () => context.push('/bazi_compatibility/${profile.id}'),
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.orangeAccent),
                            icon: const Icon(Icons.wb_sunny_outlined),
                            label: Text(l10n.vedicCompatibilityTitle), // "Ведическая совместимость"
                            onPressed: () => context.push('/jyotish_compatibility/${profile.id}'),
                          ),
                        ),

                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildFriendshipButton(BuildContext context, String viewedUserId) {
    final l10n = AppLocalizations.of(context)!;
    final appState = context.watch<AppCubit>().state;
    final appCubit = context.read<AppCubit>();
    final status = appState.friendshipStatusMap[viewedUserId] ?? FriendshipStatus.none;

    switch (status) {
      case FriendshipStatus.friends:
        return _buildStatusButton(
          context: context,
          icon: Icons.how_to_reg,
          text: l10n.friendshipStatusFriends, // "Вы друзья"
          color: Colors.green,
          onPressed: () {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: Text(l10n.friendshipRemoveTitle), // "Удалить из друзей?"
                content: Text(l10n.friendshipRemoveContent(appState.currentViewedProfile?.name ?? '')),
                actions: [
                  TextButton(child: Text(l10n.cancel), onPressed: () => Navigator.of(ctx).pop()),
                  TextButton(
                    child: Text(l10n.remove), // "Удалить"
                    onPressed: () {
                      appCubit.removeOrDeclineFriend(viewedUserId);
                      Navigator.of(ctx).pop();
                    },
                  ),
                ],
              ),
            );
          },
        );
      case FriendshipStatus.requestSent:
        return _buildStatusButton(
          context: context,
          icon: Icons.outgoing_mail,
          text: l10n.friendshipStatusRequestSent, // "Заявка отправлена"
          color: Colors.orange,
          onPressed: () => appCubit.removeOrDeclineFriend(viewedUserId),
        );
      case FriendshipStatus.requestReceived:
        final requesterProfile = appState.friendRequests.firstWhere((user) => user.id == viewedUserId, orElse: () => appState.currentViewedProfile!);
        return Row(
          children: [
            Expanded(child: _buildStatusButton(context: context, icon: Icons.close, text: l10n.friendshipActionDecline, color: Colors.grey.shade700, onPressed: () => appCubit.removeOrDeclineFriend(viewedUserId))), // "Отклонить"
            const SizedBox(width: 16),
            Expanded(child: _buildStatusButton(context: context, icon: Icons.check, text: l10n.friendshipActionAccept, color: Colors.blue, onPressed: () => appCubit.acceptFriendRequest(requesterProfile))), // "Принять"
          ],
        );
      default:
        return _buildStatusButton(context: context, icon: Icons.person_add_outlined, text: l10n.friendshipActionAdd, color: Theme.of(context).primaryColor, onPressed: () => appCubit.sendFriendRequest(viewedUserId)); // "Добавить в друзья"
    }
  }

  Widget _buildStatusButton({
    required BuildContext context,
    required IconData icon,
    required String text,
    required Color color,
    required VoidCallback? onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: Icon(icon),
        label: Text(text),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          disabledBackgroundColor: color.withOpacity(0.5),
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        final profile = state.currentViewedProfile;
        if (profile == null) return const SizedBox.shrink();
        final isLiked = state.likedUserIds.contains(profile.id);

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton(
                heroTag: 'like_btn',
                backgroundColor: Colors.white,
                child: Icon(
                  isLiked ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red.shade400,
                  size: 32,
                ),
                onPressed: () {
                  if (!isLiked) {
                    context.read<AppCubit>().onLikeClicked(profile.id);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.likeSnackbarSuccess(profile.name))));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.likeSnackbarAlreadyLiked(profile.name))));
                  }
                },
              ),
              FloatingActionButton.extended(
                heroTag: 'message_btn',
                icon: const Icon(Icons.send),
                label: Text(l10n.writeMessage), // "Написать"
                onPressed: () async {
                  final cubit = context.read<AppCubit>();
                  final chatId = await cubit.openChatWithUser(profile.id);
                  if (!mounted) return;

                  if (chatId != null) {
                    context.push(
                      '/chat/$chatId',
                      extra: widget.iceBreaker,
                    );
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCompatibilityButton(BuildContext context, UserProfileCard profile) {
    final l10n = AppLocalizations.of(context)!;
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.pinkAccent,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
      icon: const Icon(Icons.favorite, color: Colors.white),
      label: Text(l10n.checkCompatibility, style: const TextStyle(color: Colors.white)), // "Проверить совместимость"
      onPressed: () {
        context.push('/compatibility/${profile.id}');
      },
    );
  }
}