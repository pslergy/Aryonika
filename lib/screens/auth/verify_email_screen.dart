// lib/screens/auth/verify_email_screen.dart

import 'dart:async'; // <--- 1. ДОБАВЬ ЭТОТ ИМПОРТ ДЛЯ TIMER

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovequest/cubit/app_cubit.dart';
import 'package:lovequest/cubit/app_state.dart';
import 'package:lovequest/l10n/generated/app_localizations.dart'; // <--- 2. ПРОВЕРЬ, ЧТО ЭТОТ ПУТЬ ПРАВИЛЬНЫЙ

// Вспомогательная функция для показа SnackBar
// (Её можно вынести в отдельный файл с UI-хелперами, чтобы не дублировать)
void showSnackBar(BuildContext context, String message, {bool isError = false}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: isError ? Colors.redAccent : Colors.green,
      behavior: SnackBarBehavior.floating, // Делает SnackBar более современным
    ),
  );
}

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final _codeController = TextEditingController();
  Timer? _timer;
  int _cooldownSeconds = 60;
  bool _isCooldownActive = false;

  @override
  void dispose() {
    _codeController.dispose();
    _timer?.cancel(); // Важно отменить таймер, чтобы избежать утечек памяти
    super.dispose();
  }

  void _submitCode() {
    FocusScope.of(context).unfocus();
    // 3. Используем async/await для более чистого кода и обработки ошибок
    _verifyCodeAsync();
  }

  // 4. Оборачиваем логику в async-метод для обработки результата
  Future<void> _verifyCodeAsync() async {
    final l10n = AppLocalizations.of(context)!;
    final result = await context.read<AppCubit>().verifyEmailWithCode(_codeController.text.trim());

    // Этот код выполнится ПОСЛЕ того, как Cubit завершит работу
    if (mounted && result != null) {
      // Если Cubit вернул строку с ошибкой, показываем её
      // Для перевода можно использовать ключи, как мы обсуждали
      String errorMessage = result;
      if (result == 'errorCodeLength') errorMessage = l10n.errorCodeLength;
      if (result == 'error_invalid_or_expired_code') errorMessage = l10n.errorInvalidOrExpiredCode;

      showSnackBar(context, errorMessage, isError: true);
    }
    // Если result == null, значит, верификация прошла успешно,
    // и GoRouter сам перенаправит пользователя. Ничего делать не нужно.
  }


  void _resendCode() async {
    if (_isCooldownActive) return;

    final cubit = context.read<AppCubit>();
    final l10n = AppLocalizations.of(context)!;

    // Показываем индикатор загрузки прямо на кнопке
    setState(() => _isCooldownActive = true);

    final result = await cubit.resendVerificationCode();

    if (mounted) {
      if (result == null) {
        showSnackBar(context, l10n.verificationCodeResent);
        _startCooldown(); // Запускаем таймер только после успешной отправки
      } else {
        showSnackBar(context, result, isError: true);
        // Если была ошибка, снова делаем кнопку активной
        setState(() => _isCooldownActive = false);
      }
    }
  }

  void _startCooldown() {
    setState(() {
      _cooldownSeconds = 60;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_cooldownSeconds > 0) {
        setState(() {
          _cooldownSeconds--;
        });
      } else {
        timer.cancel();
        setState(() {
          _isCooldownActive = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.verifyEmailTitle),
        // Добавим кнопку "Выход", если пользователь хочет вернуться
        leading: IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () => context.read<AppCubit>().signOut(),
          tooltip: l10n.logout,
        ),
      ),


      // Убираем BlocListener, так как теперь обрабатываем ошибки напрямую в _verifyCodeAsync
      body: Center( // Оборачиваем в Center, чтобы форма не прилипала кверху на больших экранах
        child: SingleChildScrollView( // Для маленьких экранов
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              BlocSelector<AppCubit, AppState, String>(
                selector: (state) => state.unverifiedUserEmail,
                builder: (context, email) {
                  // Если email еще не загрузился, можно показать заглушку
                  if (email.isEmpty) {
                    return const SizedBox(height: 48); // Пустое место, пока email грузится
                  }
                  return Text(
                    // Вот правильный вызов функции с параметром
                    l10n.verifyEmailInstruction(email),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,
                  );
                },
              ),
              const SizedBox(height: 24),
              // Можно использовать Pinput для более красивого ввода
              TextField(
                controller: _codeController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                maxLength: 6,
                style: Theme.of(context).textTheme.headlineMedium,
                decoration: InputDecoration(
                  labelText: l10n.verificationCodeLabel,
                  counterText: "", // Скрываем счетчик "0/6"
                ),
                onSubmitted: (_) => _submitCode(),
              ),
              const SizedBox(height: 32),
              BlocBuilder<AppCubit, AppState>(
                // Следим только за authStatus для перерисовки кнопки
                buildWhen: (p, c) => p.authStatus != c.authStatus,
                builder: (context, state) {
                  final isLoading = state.authStatus == AuthStatus.submitting;
                  return ElevatedButton(
                    onPressed: isLoading ? null : _submitCode,
                    child: isLoading
                        ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)
                    )
                        : Text(l10n.confirmButton),
                  );
                },
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: _isCooldownActive ? null : _resendCode,
                child: Text(
                  _isCooldownActive && _cooldownSeconds > 0
                      ? l10n.resendCodeCooldown(_cooldownSeconds)
                      : l10n.resendCodeAction,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Не забудь добавить новые строки в `app_ru.arb` (и другие языки)
/*
{
    ...,
    "logout": "Выйти",
    "errorCodeLength": "Код должен состоять из 6 цифр.",
    "errorInvalidOrExpiredCode": "Неверный или просроченный код."
}
*/