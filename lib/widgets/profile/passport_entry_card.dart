// lib/widgets/profile/passport_entry_card.dart
import 'package:flutter/material.dart';

class PassportEntryCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String description;
  final bool isLocked;
  final VoidCallback? onLockedClick;

  const PassportEntryCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.description,
    this.isLocked = false,
    this.onLockedClick,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLocked ? onLockedClick : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 28),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(color: Colors.white, fontSize: 16)),
                  Text(
                    description,
                    style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 14),
                  ),
                ],
              ),
            ),
            if (isLocked)
              Icon(Icons.lock, color: Colors.yellow[700]?.withOpacity(0.7)),
          ],
        ),
      ),
    );
  }
}