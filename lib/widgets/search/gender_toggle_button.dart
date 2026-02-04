// lib/widgets/search/gender_toggle_button.dart
import 'package:flutter/material.dart';

class GenderToggleButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onClick;

  const GenderToggleButton({
    super.key,
    required this.text,
    required this.icon,
    required this.isSelected,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: OutlinedButton.icon(
        onPressed: onClick,
        icon: Icon(icon, size: 20),
        label: Text(text),
        style: OutlinedButton.styleFrom(
          foregroundColor: isSelected ? Colors.black : Colors.white,
          backgroundColor: isSelected ? Colors.yellow[700] : Colors.white.withOpacity(0.1),
          side: BorderSide(color: Colors.yellow[700]!.withOpacity(0.5)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }
}