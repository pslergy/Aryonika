// lib/widgets/common/web_unsupported_placeholder.dart

import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart'; // Если будешь добавлять ссылки

class WebUnsupportedPlaceholder extends StatelessWidget {
  final String featureName;
  final IconData icon;

  const WebUnsupportedPlaceholder({
    super.key,
    required this.featureName,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: Colors.white.withOpacity(0.4)),
            const SizedBox(height: 24),
            Text(
              'Функция "$featureName" недоступна в веб-версии',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Для полного доступа к астрологическим расчетам, пожалуйста, установите наше приложение.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withOpacity(0.7),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),
            // --- Опциональные кнопки со ссылками ---
            // (Раскомментируй, когда будут готовы ссылки на магазины)
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     ElevatedButton.icon(
            //       onPressed: () => _launchURL('https://play.google.com/store/apps/details?id=YOUR_APP_ID'),
            //       icon: const Icon(Icons.android),
            //       label: const Text('Google Play'),
            //     ),
            //     const SizedBox(width: 16),
            //      ElevatedButton.icon(
            //       onPressed: () => _launchURL('https://apps.apple.com/app/idYOUR_APP_ID'),
            //       icon: const Icon(Icons.apple),
            //       label: const Text('App Store'),
            //     ),
            //   ],
            // )
          ],
        ),
      ),
    );
  }

// Вспомогательная функция для открытия ссылок
// Future<void> _launchURL(String url) async {
//   final uri = Uri.parse(url);
//   if (await canLaunchUrl(uri)) {
//     await launchUrl(uri);
//   } else {
//     // Можно показать SnackBar с ошибкой
//     logger.d('Could not launch $url');
//   }
// }
}