import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lovequest/cubit/app_cubit.dart';
import 'package:lovequest/l10n/generated/app_localizations.dart';
import 'package:lovequest/widgets/common/animated_cosmic_background.dart';

class PaywallScreen extends StatelessWidget {
  const PaywallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => context.canPop() ? context.pop() : context.push('/profile'),
        ),
      ),
      body: AnimatedCosmicBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      _HeaderSection(l10n: l10n),
                      const SizedBox(height: 32),
                      _BenefitsSection(l10n: l10n),
                    ]
                        .animate(interval: 80.ms)
                        .fadeIn(duration: 400.ms)
                        .slideY(begin: 0.2, curve: Curves.easeOut),
                  ),
                ),
                _PurchaseSection(l10n: l10n),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  final AppLocalizations l10n;
  const _HeaderSection({required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(Icons.star_purple500_outlined, color: Colors.yellow[700], size: 64),
        const SizedBox(height: 16),
        Text(
          l10n.paywall_header_title,
          style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          l10n.paywall_header_subtitle,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white.withOpacity(0.8)),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _BenefitsSection extends StatelessWidget {
  final AppLocalizations l10n;
  const _BenefitsSection({required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _BenefitItem(icon: Icons.favorite, iconColor: Colors.pinkAccent, title: l10n.paywall_benefit1_title, subtitle: l10n.paywall_benefit1_subtitle),
        _BenefitItem(icon: Icons.auto_awesome, iconColor: Colors.purpleAccent, title: l10n.paywall_benefit2_title, subtitle: l10n.paywall_benefit2_subtitle),
        _BenefitItem(icon: Icons.shield_moon, iconColor: Colors.lightBlueAccent, title: l10n.paywall_benefit3_title, subtitle: l10n.paywall_benefit3_subtitle),
        _BenefitItem(icon: Icons.question_answer, iconColor: Colors.greenAccent, title: l10n.paywall_benefit4_title, subtitle: l10n.paywall_benefit4_subtitle),
        _BenefitItem(icon: Icons.filter_drama, iconColor: Colors.orangeAccent, title: l10n.paywall_benefit5_title, subtitle: l10n.paywall_benefit5_subtitle),
        _BenefitItem(icon: Icons.style, iconColor: Colors.cyanAccent, title: l10n.paywall_benefit6_title, subtitle: l10n.paywall_benefit6_subtitle),
      ],
    );
  }
}

class _BenefitItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;

  const _BenefitItem({required this.icon, required this.iconColor, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 32),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                Text(subtitle, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white70)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PurchaseSection extends StatelessWidget {
  final AppLocalizations l10n;
  const _PurchaseSection({required this.l10n});

  @override
  Widget build(BuildContext context) {
    // const String boostyDonateUrl = 'https://boosty.to/Aryonika/donate'; // Заменил на общий донат

    // Цены (лучше получать с сервера, но пока хардкод для отображения)
    const String priceRub = '399 ₽';
    const String priceUsd = '\$5.99';

    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      child: Column(
        children: [
          // 1. ROBOKASSA (Основная для РФ)
          _PayButton(
            label: "${l10n.pay_with_card} ($priceRub / $priceUsd)", // "Оплатить картой"
            icon: Icons.credit_card,
            color: const Color(0xFFf15f2c), // Оранжевый (Robokassa)
            onPressed: () {
              // Вызываем метод в AppCubit, который получит ссылку с сервера и откроет ее
              context.read<AppCubit>().initiatePayment(context);
            },
          ),
          const SizedBox(height: 12),

          // 2. GOOGLE PLAY (Заглушка)
          _PayButton(
            label: "Google Play",
            icon: Icons.android, // Или загрузите SVG логотип
            color: Colors.green[700]!,
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.coming_soon)), // "Скоро"
              );
            },
          ),
          const SizedBox(height: 12),

          // 3. HUAWEI APP GALLERY (Заглушка)
          _PayButton(
            label: "Huawei AppGallery",
            icon: Icons.mobile_screen_share, // Или логотип Huawei
            color: Colors.red[800]!,
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.coming_soon)),
              );
            },
          ),
          const SizedBox(height: 24),

          // 4. BOOSTY (Донат)
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white70,
              padding: const EdgeInsets.symmetric(vertical: 12),
              side: const BorderSide(color: Colors.white24),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
            child: Text(l10n.paywall_arbitrary_donate_button), // "Поддержать проект (Boosty)"
            onPressed: () {
              context.push('/payment', extra: 'https://boosty.to/Aryonika/donate');
            },
          ),
          const SizedBox(height: 16),

          Text(
            l10n.paywall_subscription_terms, // "Подписка продлевается автоматически..."
            style: const TextStyle(color: Colors.white30, fontSize: 10),
            textAlign: TextAlign.center,
          ),
        ],
      ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.3),
    );
  }
}

class _PayButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  const _PayButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          elevation: 4,
        ),
        icon: Icon(icon),
        label: Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        onPressed: onPressed,
      ),
    );
  }
}