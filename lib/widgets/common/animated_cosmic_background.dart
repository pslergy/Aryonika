// lib/widgets/common/animated_cosmic_background.dart
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:flutter/foundation.dart';

class AnimatedCosmicBackground extends StatefulWidget {
  final Widget child;
  const AnimatedCosmicBackground({super.key, required this.child});

  @override
  State<AnimatedCosmicBackground> createState() => _AnimatedCosmicBackgroundState();
}

class _AnimatedCosmicBackgroundState extends State<AnimatedCosmicBackground> {
  // Переменные для параллакс-эффекта
  double _dx = 0;
  double _dy = 0;

  @override
  void initState() {
    super.initState();

    // === 2. ДОБАВЛЯЕМ ПРОВЕРКУ ПЛАТФОРМЫ ===
    // kIsWeb - это константа, которая true для Web.
    // Platform.isAndroid/isIOS работает для мобильных.
    // На Windows, macOS, Linux этот код просто не будет выполняться.
    if (!kIsWeb && (defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS)) {
      gyroscopeEventStream().listen((GyroscopeEvent event) {
        if (mounted) { // Дополнительная проверка, что виджет еще на экране
          setState(() {
            _dx += event.y * 0.2;
            _dy += event.x * 0.2;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Слой 1: Статичный градиент
        const Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 1.0,
                colors: [Color(0xFF1E2A4A), Color(0xFF0D1B2A), Color(0xFF000000)],
                stops: [0.0, 0.5, 1.0],
              ),
            ),
          ),
        ),

        // Слой 2: Далекие, медленные звезды (для параллакса)
        AnimatedPositioned(
          duration: const Duration(milliseconds: 100),
          top: -20 + _dy, left: -20 + _dx, right: -20 - _dx, bottom: -20 - _dy,
          child: LoopAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 2 * pi),
            duration: const Duration(seconds: 200),
            builder: (context, value, _) {
              return CustomPaint(painter: StarPainter(value, starCount: 50, speed: 0.1));
            },
          ),
        ),

        // Слой 3: Близкие, быстрые звезды (для параллакса)
        AnimatedPositioned(
          duration: const Duration(milliseconds: 100),
          top: -40 + _dy * 2, left: -40 + _dx * 2, right: -40 - _dx * 2, bottom: -40 - _dy * 2,
          child: LoopAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 2 * pi),
            duration: const Duration(seconds: 100),
            builder: (context, value, _) {
              return CustomPaint(painter: StarPainter(value, starCount: 30, speed: 0.3));
            },
          ),
        ),

        // Слой 4: Твой контент
        widget.child,
      ],
    );
  }
}

// Улучшенный рисовальщик звезд
class Star {
  late Offset position;
  late double radius;
  late double initialPhase; // Для анимации мерцания

  Star(Size size) {
    final random = Random();
    position = Offset(random.nextDouble() * size.width, random.nextDouble() * size.height);
    radius = random.nextDouble() * 1.2 + 0.5;
    initialPhase = random.nextDouble() * 2 * pi;
  }
}

class StarPainter extends CustomPainter {
  final double time;
  final int starCount;
  final double speed;
  List<Star>? _stars;

  StarPainter(this.time, {required this.starCount, required this.speed});

  @override
  void paint(Canvas canvas, Size size) {
    // Инициализируем звезды только один раз
    _stars ??= List.generate(starCount, (index) => Star(size));

    final paint = Paint()..color = Colors.white;

    for (final star in _stars!) {
      // Анимация мерцания
      final flicker = sin(time * 2 + star.initialPhase).abs();
      paint.color = Colors.white.withOpacity(flicker * 0.8 + 0.2);

      // Анимация движения
      final y = (star.position.dy + time * 50 * speed) % size.height;
      final x = star.position.dx;

      canvas.drawCircle(Offset(x, y), star.radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant StarPainter oldDelegate) => true;
}