import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lovequest/widgets/common/animated_cosmic_background.dart';
import 'package:lovequest/l10n/generated/app_localizations.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  Future<void> _launchWebVersion() async {
    const url = 'https://psylergy.com';
    if (!await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $url');
    }
  }

  Future<void> _sendEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'pslergy@gmail.com',
      query:
      'subject=Aryonika Tester Request&body=I want to join! / Хочу стать тестировщиком!',
    );
    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    }
  }

  void _copyEmail(BuildContext context) {
    Clipboard.setData(const ClipboardData(text: 'pslergy@gmail.com'));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Email copied / Почта скопирована',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurpleAccent.withOpacity(0.9),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        width: 250,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      // Предполагаем, что AnimatedCosmicBackground у вас уже настроен красиво
      body: AnimatedCosmicBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            // Добавил скролл на случай маленьких экранов
            child: Container(
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).padding.bottom,
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Spacer(flex: 3),

                  // --- 1. Логотип и Название ---
                  _buildBrandHeader(l10n),

                  const Spacer(flex: 2),

                  // --- 2. Баннер тестировщиков (Новый дизайн) ---
                  _buildTestersBanner(context, l10n)
                      .animate()
                      .fade(duration: 800.ms, delay: 600.ms)
                      .slideY(begin: 0.2, end: 0, curve: Curves.easeOutBack),

                  const Spacer(flex: 2),

                  // --- 3. Кнопки действий ---
                  _buildActionButtons(context, l10n),

                  const Spacer(flex: 1),

                  // --- 4. Ссылка на веб ---
                  Center(
                    child: TextButton(
                      onPressed: _launchWebVersion,
                      style: TextButton.styleFrom(foregroundColor: Colors.cyanAccent),
                      child: const Text(
                        "psylergy.com",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.cyanAccent,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                  ).animate().fade(delay: 1500.ms),

                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // === Виджет заголовка (Лого + Градиентный текст) ===
  Widget _buildBrandHeader(AppLocalizations l10n) {
    return Column(
      children: [
        // Иконка с эффектом свечения
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.pinkAccent.withOpacity(0.4),
                blurRadius: 40,
                spreadRadius: 5,
              ),
              BoxShadow(
                color: Colors.purple.withOpacity(0.3),
                blurRadius: 20,
                spreadRadius: 10,
              ),
            ],
          ),
          child: const Icon(Icons.auto_awesome,
              size: 70, color: Colors.white),
        ).animate()
            .scale(duration: 1000.ms, curve: Curves.elasticOut)
            .shimmer(delay: 1000.ms, duration: 1500.ms, color: Colors.white54),

        const SizedBox(height: 24),

        // Название с градиентом
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Colors.white, Color(0xFFE0C3FC), Color(0xFF8EC5FC)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ).createShader(bounds),
          child: const Text(
            'Aryonika',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 52,
              fontWeight: FontWeight.w300, // Более тонкий шрифт выглядит дороже
              color: Colors.white, // Цвет нужен для маски
              letterSpacing: 3.0,
              fontFamily: 'Serif', // Если есть красивый шрифт, подключи сюда
            ),
          ),
        ).animate().fade(delay: 300.ms).slideY(begin: 0.3, end: 0),

        const SizedBox(height: 8),

        Text(
          l10n.welcomeTagline, // "Ваш проводник к звездам"
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white.withOpacity(0.7),
            letterSpacing: 1.2,
            fontStyle: FontStyle.italic,
          ),
        ).animate().fade(delay: 500.ms),
      ],
    );
  }

  // === Виджет баннера тестировщиков (Стекло + Золото) ===
  Widget _buildTestersBanner(BuildContext context, AppLocalizations l10n) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        // Градиентная рамка
        gradient: LinearGradient(
          colors: [
            Colors.amberAccent.withOpacity(0.6),
            Colors.deepPurple.withOpacity(0.3),
            Colors.cyanAccent.withOpacity(0.6)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(21),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.withOpacity(0.3),
            blurRadius: 15,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.all(1.5), // Толщина рамки
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        decoration: BoxDecoration(
          // Внутренний фон ("Стекло")
          color: const Color(0xFF1A1A2E).withOpacity(0.95),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            // Заголовок баннера
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.stars, color: Colors.amberAccent, size: 22),
                const SizedBox(width: 8),

                // --- ИСПРАВЛЕНИЕ ЗДЕСЬ ---
                // Оборачиваем Text в Flexible, чтобы он не ломал верстку
                Flexible(
                  child: Text(
                    l10n.testers_banner_title.toUpperCase(),
                    textAlign: TextAlign.center, // Центрируем, если перенесется на 2 строки
                    style: const TextStyle(
                      color: Colors.amberAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                // -------------------------

                const SizedBox(width: 8),
                const Icon(Icons.stars, color: Colors.amberAccent, size: 22),
              ],
            ),
            const SizedBox(height: 12),

            // Описание
            Text(
              l10n.testers_banner_desc,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                height: 1.4,
              ),
            ),

            const SizedBox(height: 16),

            // Флаги
            const Text(
              "🇬🇧 🇷🇺 🇩🇪 🇫🇷 🇪🇸 🇰🇷 🇮🇳 🇨🇳",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 16),

            // Кнопка почты (Pill Shape)
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: _sendEmail,
                onLongPress: () => _copyEmail(context),
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white24),
                    gradient: LinearGradient(
                      colors: [Colors.white.withOpacity(0.1), Colors.white.withOpacity(0.05)],
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.mail_outline, color: Colors.white70, size: 18),
                      const SizedBox(width: 10),
                      // Тоже можно обернуть в Flexible на случай очень маленьких экранов
                      const Flexible(
                        child: Text(
                          "pslergy@gmail.com",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.testers_email_hint,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }

  // === Виджеты кнопок входа (Градиент + Аутлайн) ===
  Widget _buildActionButtons(BuildContext context, AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Кнопка регистрации (Градиентная)
        Container(
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: const LinearGradient(
              colors: [Color(0xFFB24592), Color(0xFFF15F79)], // Pink -> Orange
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFF15F79).withOpacity(0.4),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: () => context.push('/register'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
            child: Text(
              l10n.welcomeCreateAccountButton.toUpperCase(),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
                color: Colors.white,
              ),
            ),
          ),
        ).animate().fade(delay: 1000.ms).slideY(begin: 0.5, end: 0),

        const SizedBox(height: 16),

        // Кнопка входа (Прозрачная с белой обводкой)
        SizedBox(
          height: 56,
          child: OutlinedButton(
            onPressed: () => context.push('/login'),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.white30),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              foregroundColor: Colors.white,
            ),
            child: Text(
              l10n.welcomeLoginButton.toUpperCase(),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ).animate().fade(delay: 1200.ms).slideY(begin: 0.5, end: 0),
      ],
    );
  }
}