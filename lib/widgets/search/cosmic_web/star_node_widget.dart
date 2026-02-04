// lib/widgets/search/cosmic_web/star_node_widget.dart
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'cosmic_web_user_node.dart';

class StarNodeWidget extends StatefulWidget {
  final CosmicWebUserNode node;
  final VoidCallback onTap;
  final Animation<double> pulseAnimation;

  const StarNodeWidget({
    super.key,
    required this.node,
    required this.onTap,
    required this.pulseAnimation,
  });

  @override
  State<StarNodeWidget> createState() => _StarNodeWidgetState();
}

class _StarNodeWidgetState extends State<StarNodeWidget> {
  @override
  void initState() {
    super.initState();
    // Подписываемся на анимацию, чтобы виджет перестраивался
    widget.pulseAnimation.addListener(_onAnimation);
  }

  @override
  void dispose() {
    // Отписываемся, чтобы избежать утечек памяти
    widget.pulseAnimation.removeListener(_onAnimation);
    super.dispose();
  }

  void _onAnimation() {
    // Просто просим виджет перестроиться на каждый кадр анимации
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final node = widget.node;
    final isHighCompatibility = node.user.compatibilityScore >= 85;
    final compatibilityFactor = node.user.compatibilityScore / 100.0;

    double currentRadius = node.radius;

    // Пульсация и мерцание
    if (isHighCompatibility) {
      final pulseFactor = (ui.lerpDouble(0.85, 1.15, widget.pulseAnimation.value))!;
      currentRadius = node.radius * pulseFactor;
    }

    // Динамическое гало
    final haloColor = Color.lerp(
        Colors.blue.withOpacity(0.3),
        Colors.yellowAccent.withOpacity(0.7),
        compatibilityFactor)!;
    final haloSize = currentRadius * (1.0 + compatibilityFactor);

    return GestureDetector(
      onTap: widget.onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 1. Гало (свечение)
          Container(
            width: haloSize * 2,
            height: haloSize * 2,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: haloColor,
                  blurRadius: 15.0,
                  spreadRadius: 3.0,
                ),
              ],
            ),
          ),

          // 2. Аватар
          AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: currentRadius * 2,
            height: currentRadius * 2,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              // Теперь мы просто передаем ImageProvider
              image: node.avatarProvider != null
                  ? DecorationImage(
                image: node.avatarProvider!,
                fit: BoxFit.cover,
              )
                  : null,
              color: node.avatarProvider == null ? Colors.grey[800] : null,
            ),
          ),
        ],
      ),
    );
  }
}

// Новый хелпер для RawImage
class RawImage extends ImageProvider<RawImage> {
  final ui.Image image;
  RawImage({required this.image});

  @override
  Future<RawImage> obtainKey(ImageConfiguration configuration) {
    return Future.value(this);
  }

  @override
  ImageStreamCompleter loadImage(RawImage key, ImageDecoderCallback decode) {
    return OneFrameImageStreamCompleter(Future.value(ImageInfo(image: key.image)));
  }
}