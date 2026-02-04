// lib/screens/exit_placeholder_screen.dart

import 'package:flutter/material.dart';

class ExitPlaceholderScreen extends StatelessWidget {
  const ExitPlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Этот экран никогда не должен быть виден.
    // Мы используем его только как точку входа в навигации.
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}