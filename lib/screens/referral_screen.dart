// lib/screens/referral_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovequest/cubit/app_cubit.dart';
import 'package:lovequest/cubit/app_state.dart';
import 'package:lovequest/l10n/generated/app_localizations.dart';
 // Импорт для локализации
import 'package:lovequest/widgets/common/animated_cosmic_background.dart';
import 'package:share_plus/share_plus.dart';



class ReferralScreen extends StatefulWidget {
  const ReferralScreen({super.key});

  @override
  State<ReferralScreen> createState() => _ReferralScreenState();
}

class _ReferralScreenState extends State<ReferralScreen> {
  final _codeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  void _applyCode() async {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState?.validate() ?? false) {
      // 1. Показываем диалог
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      try {
        // 2. Делаем запрос
        final resultMessage = await context.read<AppCubit>().applyReferralCode(
            _codeController.text,
            context
        );

        // 3. Закрываем диалог (если успех)
        if (mounted && Navigator.canPop(context)) {
          Navigator.of(context).pop();
        }

        // 4. Показываем SnackBar успеха
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(resultMessage), backgroundColor: Colors.green)
          );
          // Очищаем поле, если это не ошибка
          if (!resultMessage.toLowerCase().contains("ошибка") && !resultMessage.toLowerCase().contains("error")) {
            _codeController.clear();
          }
        }

      } catch (e) {
        // 5. Обработка ошибок (даже если Cubit кинул exception)

        // СНАЧАЛА ЗАКРЫВАЕМ ДИАЛОГ!
        if (mounted && Navigator.canPop(context)) {
          Navigator.of(context).pop();
        }

        if (mounted) {
          final errorText = e.toString().replaceAll("Exception: ", "");
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(errorText), backgroundColor: Colors.red)
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.referralScreenTitle),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: AnimatedCosmicBackground(
        child: BlocBuilder<AppCubit, AppState>(
          builder: (context, state) {
            final profile = state.currentUserProfile;
            if (profile == null) {
              return const Center(child: CircularProgressIndicator());
            }

            return ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                _buildYourCodeCard(context, profile.referralCode, l10n),
                const SizedBox(height: 32),
                if (!profile.hasUsedReferralCode)
                  _buildEnterCodeCard(l10n), // Передаем l10n
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildYourCodeCard(BuildContext context, String? referralCode, AppLocalizations l10n) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              l10n.referralYourCodeTitle,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              l10n.referralYourCodeDescription,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey, height: 1.4),
            ),
            const SizedBox(height: 20),
            if (referralCode != null)
              ActionChip(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                avatar: const Icon(Icons.copy, size: 18),
                label: Text(
                  referralCode,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 3),
                ),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: referralCode));
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(l10n.referralCodeCopied))
                  );
                },
              )
            else
              const CircularProgressIndicator(),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12)),
              icon: const Icon(Icons.share),
              label: Text(l10n.referralShareCodeButton),
              onPressed: referralCode != null ? () {
                Share.share(l10n.referralShareMessage(referralCode));
              } : null,
            ),
            const SizedBox(height: 16),
            Text(
              l10n.referralManualBonusNote,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildEnterCodeCard(AppLocalizations l10n) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l10n.referralGotCodeTitle,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                l10n.referralGotCodeDescription,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _codeController,
                textAlign: TextAlign.center,
                style: const TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  labelText: l10n.referralCodeInputLabel,
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return l10n.referralCodeValidationError;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
                onPressed: _applyCode,
                child: Text(l10n.referralApplyCodeButton),
              )
            ],
          ),
        ),
      ),
    );
  }
}