// lib/screens/intro_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:lovequest/widgets/common/animated_cosmic_background.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_animate/flutter_animate.dart';
// Импортируем нашу модель слайдов
import 'package:lovequest/src/data/models/intro_slide.dart';

import '../cubit/app_cubit.dart';
import 'package:lovequest/l10n/generated/app_localizations.dart';
import '../l10n/helpers/intro_texts.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Widget> _slideAnimations = const [
    _Slide1Animation(),
    _Slide2Animation(),
    _Slide3Animation(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      if (mounted) {
        setState(() {
          _currentPage = _pageController.page?.round() ?? 0;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _finishIntro() {
    context.read<AppCubit>().markIntroAsSeen();
  }

  @override
  Widget build(BuildContext context) {
    // --- 👇 ГЛАВНЫЕ ИЗМЕНЕНИЯ ЗДЕСЬ 👇 ---

    // 1. Получаем объект локализации
    final l10n = AppLocalizations.of(context)!;

    // 2. Генерируем локализованные слайды с помощью нашей новой функции
    final List<IntroSlide> slides = getIntroSlides(l10n);

    // --- КОНЕЦ ГЛАВНЫХ ИЗМЕНЕНИЙ ---

    return Scaffold(
      body: AnimatedCosmicBackground(
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: slides.length, // Используем длину нового списка
              itemBuilder: (context, index) {
                final slide = slides[index];
                return _buildSlide(
                  animation: _slideAnimations[index],
                  title: slide.title,         // <-- ТЕПЕРЬ ПРОСТО .title
                  description: slide.description, // <-- ТЕПЕРЬ ПРОСТО .description
                );
              },
            ),
            Positioned(
              bottom: 30,
              left: 24,
              right: 24,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: _finishIntro,
                    child: Text(l10n.introButtonSkip, style: const TextStyle(color: Colors.white70)), // <-- ЗАМЕНА
                  ),
                  Row(
                    children: List.generate(slides.length, (index) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        height: 8,
                        width: _currentPage == index ? 24 : 8,
                        decoration: BoxDecoration(
                          color: _currentPage == index ? Colors.pinkAccent : Colors.white54,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      );
                    }),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_currentPage == slides.length - 1) {
                        _finishIntro();
                      } else {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: _currentPage == slides.length - 1 ? const StadiumBorder() : const CircleBorder(),
                      padding: _currentPage == slides.length - 1
                          ? const EdgeInsets.symmetric(horizontal: 24, vertical: 12)
                          : const EdgeInsets.all(16),
                      backgroundColor: Colors.pinkAccent,
                    ),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
                      child: _currentPage == slides.length - 1
                          ? Text(l10n.introButtonStart, key: const ValueKey('start_button')) // <-- ЗАМЕНА
                          : const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, key: ValueKey('next_button')),
                    ),
                  ),
                ],
              ).animate().fade(delay: 500.ms),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSlide({
    required Widget animation,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          animation,
          const SizedBox(height: 60),
          Text(
            title, // title уже локализован
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ).animate().fade(delay: 200.ms),
          const SizedBox(height: 16),
          Text(
            description, // description уже локализован
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.8), height: 1.5),
          ).animate().fade(delay: 400.ms),
        ],
      ),
    );
  }
}

  // === ПОЛНАЯ И ИСПРАВЛЕННАЯ ВЕРСИЯ `_buildSlide` ===
  Widget _buildSlide({
    required Widget animation,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 1. Используем переданный виджет с анимацией
          animation,

          const SizedBox(height: 60),

          // 2. Используем переданный локализованный title
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ).animate().fade(delay: 200.ms),

          const SizedBox(height: 16),

          // 3. Используем переданный локализованный description
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.8),
              height: 1.5,
            ),
          ).animate().fade(delay: 400.ms),
        ],
      ),
    );
  }

// Анимация для первого слайда: вращающиеся планеты
class _Slide1Animation extends StatelessWidget {
  const _Slide1Animation();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: 250,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(Icons.star, color: Colors.amber.withOpacity(0.5), size: 250)
              .animate(onPlay: (c) => c.repeat())
              .rotate(duration: 20.seconds),
          const Icon(Icons.favorite, color: Colors.pink, size: 80),
          // Орбиты
          CircleAvatar(backgroundColor: Colors.white12, radius: 90),
          CircleAvatar(backgroundColor: Colors.white12, radius: 120),
          // Планеты
          const CircleAvatar(radius: 10, backgroundColor: Colors.lightBlueAccent)
              .animate(onPlay: (c) => c.repeat())
              .followPath(path: Path()..addOval(Rect.fromCircle(center: Offset.zero, radius: 90)), duration: 8.seconds),
          const CircleAvatar(radius: 15, backgroundColor: Colors.purpleAccent)
              .animate(onPlay: (c) => c.repeat())
              .followPath(path: Path()..addOval(Rect.fromCircle(center: Offset.zero, radius: 120)), duration: 12.seconds, rotate: true),
        ],
      ),
    );
  }
}
// Анимация для второго слайда: появляющийся "паспорт"
class _Slide2Animation extends StatelessWidget {
  const _Slide2Animation();
  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.auto_stories, color: Colors.lightBlueAccent, size: 150)
        .animate()
        .scale(delay: 200.ms, duration: 600.ms, curve: Curves.elasticOut)
        .shimmer(delay: 800.ms, duration: 1000.ms, color: Colors.white);
  }
}

// Анимация для третьего слайда: ракета, улетающая вверх
class _Slide3Animation extends StatelessWidget {
  const _Slide3Animation();
  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.rocket_launch, color: Colors.orangeAccent, size: 150)
        .animate(onPlay: (c) => c.repeat(reverse: true))
        .slideY(begin: 0, end: -0.2, duration: 1500.ms, curve: Curves.easeInOut)
        .shake(hz: 2, duration: 1500.ms);
  }
}