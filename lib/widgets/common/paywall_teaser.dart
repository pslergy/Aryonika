// lib/widgets/common/paywall_teaser.dart
import 'package:flutter/material.dart';

class PaywallTeaser extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onClick;
  final Widget child; // Для отображения заблюренного контента

  const PaywallTeaser({
    super.key,
    required this.title,
    required this.description,
    required this.onClick,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onClick,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Icon(Icons.lock, color: Colors.yellow[700]),
              const SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(
                  color: Colors.yellow[700],
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white.withOpacity(0.8)),
              ),
              const SizedBox(height: 16),
              child,
            ],
          ),
        ),
      ),
    );
  }
}