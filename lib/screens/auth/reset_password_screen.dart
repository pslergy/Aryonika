// lib/screens/auth/reset_password_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lovequest/cubit/app_cubit.dart';
import 'package:lovequest/cubit/app_state.dart';
import 'package:lovequest/l10n/generated/app_localizations.dart';

import 'package:lovequest/screens/auth/login_screen.dart'; // для showSnackBar
import 'package:lovequest/widgets/common/animated_cosmic_background.dart';



class ResetPasswordScreen extends StatefulWidget {
  final String token;
  const ResetPasswordScreen({super.key, required this.token});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final cubit = context.read<AppCubit>();
    final result = await cubit.resetPassword(
      token: widget.token,
      newPassword: _passwordController.text,
    );

    if (!mounted) return;

    if (result == null) {
      // Успех
      showSnackBar(context, "Пароль успешно изменен!");
      context.push('/login');
    } else {
      // Ошибка
      showSnackBar(context, result, isError: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.passwordResetNewPasswordTitle)),
      body: AnimatedCosmicBackground(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(labelText: l10n.passwordResetNewPasswordLabel),
                    validator: (value) {
                      if (value == null || value.length < 6) {
                        return l10n.passwordValidationError;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(labelText: l10n.passwordResetConfirmLabel),
                    validator: (value) {
                      if (value != _passwordController.text) {
                        return l10n.passwordMismatchError;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 32),
                  BlocBuilder<AppCubit, AppState>(
                    builder: (context, state) {
                      if (state.authStatus == AuthStatus.submitting) {
                        return const CircularProgressIndicator();
                      }
                      return ElevatedButton(
                        onPressed: _submit,
                        child: Text(l10n.saveButton),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}