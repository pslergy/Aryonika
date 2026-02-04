// lib/widgets/common/pro_avatar.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lovequest/widgets/common/gradient_painter.dart'; // <-- Убедитесь, что этот импорт правильный

class ProAvatar extends StatelessWidget {
  final String? avatarBase64;
  final String? sunSign;
  final double radius;
  final bool isPro;

  const ProAvatar({
    super.key,
    this.avatarBase64,
    this.sunSign,
    required this.radius,
    required this.isPro,
  });

  @override
  Widget build(BuildContext context) {
    ImageProvider? imageProvider;
    Widget? placeholderChild;

    if (avatarBase64 != null && avatarBase64!.isNotEmpty) {
      try {
        imageProvider = MemoryImage(base64Decode(avatarBase64!.split(',').last));
      } catch(e) { /* ошибка */ }
    } else if (sunSign != null && sunSign!.isNotEmpty) {
      final signName = sunSign!.toLowerCase();
      imageProvider = AssetImage('assets/images/ic_zodiac_$signName.png');
    } else {
      placeholderChild = Icon(Icons.person, size: radius * 0.9, color: Colors.white.withOpacity(0.8));
    }

    final Widget avatarContent = CircleAvatar(
      radius: radius,
      backgroundImage: imageProvider,
      backgroundColor: Colors.deepPurple,
      child: placeholderChild,
    );

    if (!isPro) {
      return avatarContent;
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: radius * 2,
          height: radius * 2,
          child: CustomPaint(
            painter: GradientRingPainter(
              strokeWidth: 3.0,
              gradient: const LinearGradient(
                colors: [Colors.amber, Colors.purpleAccent, Colors.lightBlueAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
        CircleAvatar(
          radius: radius - 3,
          backgroundImage: imageProvider,
          backgroundColor: Colors.deepPurple,
          child: placeholderChild != null
              ? Icon(Icons.person, size: (radius-3) * 0.9, color: Colors.white.withOpacity(0.8))
              : null,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.star_rounded,
              color: Colors.amber,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }
}