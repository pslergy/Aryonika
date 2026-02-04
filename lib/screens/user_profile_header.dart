// lib/widgets/profile/user_profile_header.dart
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lovequest/l10n/generated/app_localizations.dart'; // <-- Импорт локализации
import 'package:lovequest/widgets/common/user_avatar.dart';

import 'package:lovequest/src/data/models/user_profile_card.dart';

class UserProfileHeader extends StatelessWidget {
  final UserProfileCard profile;
  final List<Widget>? actions;

  const UserProfileHeader({
    super.key,
    required this.profile,
    this.actions,
  });

  String _getPlaceholderAsset(String? gender) {
    if (gender == 'female') {
      return 'assets/images/avatar_female.png';
    }
    return 'assets/images/avatar_male.png';
  }

  Widget _buildPlaceholder() {
    final String placeholderAsset = profile.gender == 'female'
        ? 'assets/images/placeholder_female.png'
        : 'assets/images/placeholder_male.png';
    return Image.asset(placeholderAsset, fit: BoxFit.cover);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SliverAppBar(
      expandedHeight: 400,
      pinned: true,
      actions: actions,
      stretch: true,
      backgroundColor: Colors.grey.shade900,
      iconTheme: const IconThemeData(color: Colors.white),
      leading: BackButton(
        color: Colors.white,
        onPressed: () => Navigator.of(context).pop(),
        // Flutter сам добавляет тултип "Back" или "Назад", но если хочешь свой:
        // tooltip: l10n.back,
      ),
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [StretchMode.zoomBackground, StretchMode.fadeTitle],
        centerTitle: true,
        titlePadding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        title: Text(
          profile.name,
          style: const TextStyle(shadows: [Shadow(blurRadius: 4, color: Colors.black)]),
          textAlign: TextAlign.center,
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            if (profile.avatar != null && profile.avatar!.isNotEmpty)
              UserAvatar(
                user: profile,
                fit: BoxFit.cover,
              )
            else
              _buildPlaceholder(),

            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black54, Colors.transparent, Colors.black87],
                  stops: [0.0, 0.5, 1.0],
                ),
              ),
            ),

            Positioned(
              bottom: 60,
              left: 16,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${profile.name}, ${profile.age}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      shadows: [Shadow(blurRadius: 4, color: Colors.black)],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.white70, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        profile.city != null && profile.city!.isNotEmpty
                            ? profile.city!
                            : l10n.cityNotSpecified, // "Город не указан"
                        style: const TextStyle(color: Colors.white70, fontSize: 16),
                      ),
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
}