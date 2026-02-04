// lib/screens/auth/register_screen.dart

import 'package:flutter/gestures.dart'; // <-- ДОБАВЬ ЭТОТ ИМПОРТ
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lovequest/cubit/app_cubit.dart';
import 'package:lovequest/cubit/app_state.dart';
import 'package:lovequest/l10n/generated/app_localizations.dart';

import 'package:lovequest/widgets/common/animated_cosmic_background.dart';
import 'package:url_launcher/url_launcher.dart';


import '../../services/logger_service.dart';
// import 'package:url_launcher/url_launcher.dart'; // <-- РАСКОММЕНТИРУЙ, КОГДА ДОБАВИШЬ ПАКЕТ

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _privacyAccepted = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    FocusScope.of(context).unfocus();
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;
    context.read<AppCubit>().signUpWithEmailPassword(email, password, confirmPassword);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!; // Получаем l10n

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(l10n.registerTitle), // <-- ЗАМЕНА
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: Colors.white70, onPressed: () => context.push('/welcome')),
      ),
      body: AnimatedCosmicBackground(
        child: BlocListener<AppCubit, AppState>(
          listenWhen: (previous, current) => previous.authStatus != current.authStatus,
          listener: (context, state) {
            if (state.authStatus == AuthStatus.success) {
              context.push('/onboarding/name');
            } else if (state.authStatus == AuthStatus.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.authErrorMessage ?? l10n.unknownError), // <-- ЗАМЕНА
                  backgroundColor: Colors.redAccent,
                ),
              );
            }
          },
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: _RegisterForm(
                  l10n: l10n, // Передаем l10n
                  emailController: _emailController,
                  passwordController: _passwordController,
                  confirmPasswordController: _confirmPasswordController,
                  privacyAccepted: _privacyAccepted,
                  onPrivacyChanged: (value) {
                    setState(() { _privacyAccepted = value ?? false; });
                  },
                  onSubmit: _submitForm,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RegisterForm extends StatelessWidget {
  final AppLocalizations l10n;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool privacyAccepted;
  final ValueChanged<bool?> onPrivacyChanged;
  final VoidCallback onSubmit;

  const _RegisterForm({
    required this.l10n,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.privacyAccepted,
    required this.onPrivacyChanged,
    required this.onSubmit,
  });

  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
      logger.d('Could not launch $urlString');
    }
  }
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    final inputDecorationTheme = InputDecoration(
      labelStyle: const TextStyle(color: Colors.white70),
      hintStyle: const TextStyle(color: Colors.white30),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.white30),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.pinkAccent),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.redAccent, width: 2),
      ),
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 20),
        TextFormField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          style: const TextStyle(color: Colors.white),
          decoration: inputDecorationTheme.copyWith(
            labelText: l10n.emailLabel, // <-- ЗАМЕНА
            prefixIcon: const Icon(Icons.alternate_email, color: Colors.white70),
          ),
        ),
        const SizedBox(height: 20),
        TextFormField(
          controller: passwordController,
          obscureText: true,
          style: const TextStyle(color: Colors.white),
          decoration: inputDecorationTheme.copyWith(
            labelText: l10n.passwordLabel, // <-- ЗАМЕНА
            prefixIcon: const Icon(Icons.lock_outline, color: Colors.white70),
          ),
        ),
        const SizedBox(height: 20),
        TextFormField(
          controller: confirmPasswordController,
          obscureText: true,
          style: const TextStyle(color: Colors.white),
          decoration: inputDecorationTheme.copyWith(
            labelText: l10n.confirmPasswordLabel, // <-- ЗАМЕНА
            prefixIcon: const Icon(Icons.lock_reset, color: Colors.white70),
          ),
        ),
        const SizedBox(height: 24),
        CheckboxListTile(
          value: privacyAccepted,
          onChanged: onPrivacyChanged,
          title: RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white70),
              children: [
                TextSpan(text: l10n.privacyPolicyCheckbox),
                TextSpan(
                  text: l10n.termsOfUseLink,
                  style: const TextStyle(color: Colors.cyanAccent, decoration: TextDecoration.underline),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // ЗАМЕНЕНО: Переход внутри приложения
                      context.push('/terms-of-use');
                    },
                ),
                TextSpan(text: l10n.and),
                TextSpan(
                  text: l10n.privacyPolicyLink,
                  style: const TextStyle(color: Colors.cyanAccent, decoration: TextDecoration.underline),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // ЗАМЕНЕНО: Переход внутри приложения
                      context.push('/privacy-policy');
                    },
                ),
              ],
            ),
          ),
          controlAffinity: ListTileControlAffinity.leading,
          activeColor: Colors.pinkAccent,
          checkColor: Colors.white,
          contentPadding: EdgeInsets.zero,
        ),
        const SizedBox(height: 24),
        BlocBuilder<AppCubit, AppState>(
          buildWhen: (p, c) => p.authStatus != c.authStatus,
          builder: (context, state) {
            if (state.authStatus == AuthStatus.submitting) {
              return const Center(child: CircularProgressIndicator(color: Colors.pinkAccent));
            }
            return ElevatedButton(
              onPressed: privacyAccepted ? onSubmit : null,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.pinkAccent,
                disabledBackgroundColor: Colors.grey.withOpacity(0.5),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: Text(
                l10n.registerButton, // <-- ЗАМЕНА
                style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            );
          },
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: () => context.push('/login'),
          child: Text(
            l10n.alreadyHaveAccountButton, // <-- ЗАМЕНА
            style: const TextStyle(color: Colors.white70),
          ),
        )
      ],
    );
  }
}