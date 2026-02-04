// lib/widgets/common/feature_placeholder.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FeaturePlaceholder extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String? buttonText;
  final String? buttonUrl;

  const FeaturePlaceholder({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    this.buttonText,
    this.buttonUrl,
  });

  Future<void> _launchUrl() async {
    if (buttonUrl == null) return;
    final uri = Uri.parse(buttonUrl!);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: Colors.white.withOpacity(0.5)),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 15,
                height: 1.5,
              ),
            ),
            if (buttonText != null && buttonUrl != null) ...[
              const SizedBox(height: 24),
              TextButton.icon(
                icon: const Icon(Icons.telegram, color: Colors.cyanAccent),
                label: Text(
                  buttonText!,
                  style: const TextStyle(color: Colors.cyanAccent),
                ),
                onPressed: _launchUrl,
              ),
            ],
          ],
        ),
      ),
    );
  }
}