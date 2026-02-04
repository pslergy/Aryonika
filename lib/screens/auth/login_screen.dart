// lib/screens/auth/login_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lovequest/cubit/app_cubit.dart';
import 'package:lovequest/cubit/app_state.dart';
import 'package:lovequest/l10n/generated/app_localizations.dart';

import 'package:lovequest/widgets/common/animated_cosmic_background.dart';


import '../../services/logger_service.dart';

// Вспомогательная функция для показа SnackBar, чтобы не дублировать код
void showSnackBar(BuildContext context, String? message, {bool isError = false}) {
  final l10n = AppLocalizations.of(context)!;
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message ?? l10n.loginError), // Используем дефолтный текст ошибки
      backgroundColor: isError ? Colors.redAccent : Colors.green,
    ),
  );
}


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    FocusScope.of(context).unfocus();
    // Вызываем метод кубита и ПЕРЕДАЕМ ему актуальные данные из контроллеров
    context.read<AppCubit>().logInWithCredentials(
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  Future<void> _showPasswordResetDialog() async {
    // `await` будет ждать, пока Navigator.pop(result) не вернет значение
    final result = await showDialog<String?>(
      context: context,
      builder: (dialogContext) {
        return _PasswordResetDialog(initialEmail: _emailController.text);
      },
    );

    // Этот код выполнится ПОСЛЕ закрытия диалога
    if (!mounted) return;

    final l10n = AppLocalizations.of(context)!;
    if (result == null) {
      // Если результат null (успех), показываем зеленый SnackBar
      showSnackBar(context, l10n.passwordResetSuccess);
    } else if (result.isNotEmpty) {
      // Если пришла строка с ошибкой
      showSnackBar(context, result, isError: true);
    }
    // Если result - пустая строка (например, просто закрыли диалог), ничего не делаем
  }

  // --- 👇 НОВЫЙ ВСПОМОГАТЕЛЬНЫЙ МЕТОД, ЧТОБЫ НЕ ДУБЛИРОВАТЬ КОД 👇 ---
  Future<void> _performPasswordReset(

      BuildContext dialogContext,
      AppCubit cubit,
      TextEditingController emailController,
      AppLocalizations l10n,
      ) async {
    logger.d("--- DEBUG FLUTTER: 1. _performPasswordReset ВЫЗВАН ---");
    // Скрываем клавиатуру
    FocusScope.of(dialogContext).unfocus();

    final email = emailController.text.trim();
    if (email.isEmpty || !email.contains('@')) {
      if (mounted) { // mounted относится к State, поэтому проверка здесь
        showSnackBar(context, l10n.emailValidationError, isError: true);
      }
      return;
    }

    // Вызываем НОВЫЙ метод из AppCubit
    final result = await cubit.forgotPassword(email);
    logger.d("--- DEBUG FLUTTER: 4. _performPasswordReset ПОЛУЧИЛ РЕЗУЛЬТАТ: $result ---");

    if (!mounted) return;

    // Закрываем диалоговое окно
    Navigator.of(dialogContext).pop();

    if (result == null) {
      // Успех! Сервер всегда возвращает успех.
      showSnackBar(context, l10n.passwordResetSuccess);
    } else {
      // Ошибка (например, нет сети)
      showSnackBar(context, result, isError: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!; // Получаем l10n для всего экрана

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(l10n.loginTitle),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: Colors.white70,
          onPressed: () => context.push('/welcome'),
        ),
      ),
      body: AnimatedCosmicBackground(
        child: BlocListener<AppCubit, AppState>(
          listenWhen: (p, c) => p.authStatus != c.authStatus,
          listener: (context, state) {
            if (state.authStatus == AuthStatus.error) {
              showSnackBar(context, state.authErrorMessage, isError: true);
            }
          },
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: _LoginForm(
                  l10n: l10n, // Передаем l10n в дочерний виджет
                  emailController: _emailController,
                  passwordController: _passwordController,
                  onSubmit: _submitForm,
                  onForgotPassword: _showPasswordResetDialog,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  final AppLocalizations l10n;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onSubmit;
  final VoidCallback onForgotPassword;

  const _LoginForm({
    required this.l10n,
    required this.emailController,
    required this.passwordController,
    required this.onSubmit,
    required this.onForgotPassword,
  });

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
          // --- 👇 ДОБАВЬ ЭТО 👇 ---

          // --- 👆 ---
          decoration: inputDecorationTheme.copyWith(
            labelText: l10n.emailLabel,
            prefixIcon: const Icon(Icons.alternate_email, color: Colors.white70),
          ),
        ),
        const SizedBox(height: 20),
        TextFormField(
          controller: passwordController,
          obscureText: true,
          style: const TextStyle(color: Colors.white),
          // --- 👇 И ЭТО 👇 ---

          // --- 👆 ---
          decoration: inputDecorationTheme.copyWith(
            labelText: l10n.passwordLabel,
            prefixIcon: const Icon(Icons.lock_outline, color: Colors.white70),
          ),
          onFieldSubmitted: (_) => onSubmit(),
        ),
        const SizedBox(height: 32),
        BlocBuilder<AppCubit, AppState>(
          buildWhen: (p, c) => p.authStatus != c.authStatus,
          builder: (context, state) {
            if (state.authStatus == AuthStatus.submitting) {
              return const Center(child: CircularProgressIndicator(color: Colors.pinkAccent));
            }
            return ElevatedButton(
              onPressed: onSubmit,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.pinkAccent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: Text(
                l10n.loginButton,
                style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            );
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: onForgotPassword,
              child: Text(
                l10n.forgotPasswordButton,
                style: const TextStyle(color: Colors.white70),
              ),
            ),
            TextButton(
              onPressed: () => context.push('/register'),
              child: Text(
                l10n.noAccountButton,
                style: const TextStyle(color: Colors.white70),
              ),
            )
          ],
        ),
      ],
    );
  }
}

// ==============================================================
// ✨ НОВЫЙ, ПРАВИЛЬНЫЙ ВИДЖЕТ ДЛЯ ДИАЛОГА СБРОСА ПАРОЛЯ
// ==============================================================
class _PasswordResetDialog extends StatefulWidget {
  final String initialEmail;
  const _PasswordResetDialog({required this.initialEmail});

  @override
  State<_PasswordResetDialog> createState() => _PasswordResetDialogState();
}

class _PasswordResetDialogState extends State<_PasswordResetDialog> {
  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    // Инициализируем контроллер один раз при создании виджета
    _emailController = TextEditingController(text: widget.initialEmail);
  }

  @override
  void dispose() {
    // Уничтожаем контроллер, когда виджет убирается с экрана
    _emailController.dispose();
    super.dispose();
  }

  // Вспомогательный метод для отправки, чтобы не дублировать код
  Future<String?> _submit() async {
    final l10n = AppLocalizations.of(context)!;
    final email = _emailController.text.trim();

    if (email.isEmpty || !email.contains('@')) {
      return l10n.emailValidationError;
    }

    // Возвращаем результат вызова cubit
    return await context.read<AppCubit>().forgotPassword(email);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(l10n.passwordResetTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(l10n.passwordResetContent),
          const SizedBox(height: 16),
          TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            autofocus: true,
            decoration: InputDecoration(labelText: l10n.emailLabel),
            onSubmitted: (_) async {
              // Логика для отправки по нажатию Enter
              final result = await _submit();
              if (mounted) {
                Navigator.of(context).pop(result);
              }
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          child: Text(l10n.cancel),
          onPressed: () => Navigator.of(context).pop(), // Просто закрываем диалог
        ),
        // BlocBuilder следит за состоянием AppCubit, чтобы показать индикатор
        BlocBuilder<AppCubit, AppState>(
          builder: (context, state) {
            if (state.authStatus == AuthStatus.submitting) {
              return const ElevatedButton(
                onPressed: null, // Кнопка неактивна во время загрузки
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                ),
              );
            }
            return ElevatedButton(
              onPressed: () async {
                // Логика для нажатия на кнопку "Отправить"
                final result = await _submit();
                if (mounted) {
                  // Закрываем диалог и возвращаем результат (null или строку с ошибкой)
                  Navigator.of(context).pop(result);
                }
              },
              child: Text(l10n.sendButton),
            );
          },
        ),
      ],
    );
  }
}