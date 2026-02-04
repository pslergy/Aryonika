// lib/screens/profile_settings_screen.dart

import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lovequest/l10n/generated/app_localizations.dart'; // <-- Импорт локализации

import '../cubit/app_cubit.dart';
import '../cubit/app_state.dart';
import '../widgets/common/animated_cosmic_background.dart';

void showSnackBar(BuildContext context, String message, {bool isError = false}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: isError ? Colors.redAccent : Colors.green,
    ),
  );
}

class ProfileSettingsScreen extends StatelessWidget {
  const ProfileSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(l10n.settingsTitle, style: const TextStyle(color: Colors.white)), // "Настройки"
        leading: const BackButton(color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: AnimatedCosmicBackground(
        child: SafeArea(
          child: BlocBuilder<AppCubit, AppState>(
            buildWhen: (previous, current) {
              final oldSettings = previous.currentUserProfile?.settings?.notifications;
              final newSettings = current.currentUserProfile?.settings?.notifications;
              return !const DeepCollectionEquality().equals(oldSettings?.toMap(), newSettings?.toMap());
            },
            builder: (context, state) {
              final settings = state.currentUserProfile?.settings?.notifications;

              return ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  _SettingsCard(
                    children: [
                      _SectionTitle(l10n.accountManagement), // "Управление аккаунтом"
                      _SettingsButton(
                        text: l10n.changePassword, // "Сменить пароль"
                        icon: Icons.lock_outline,
                        onClick: () => _showChangePasswordDialog(context, l10n),
                      ),
                      const _Divider(),
                      _SettingsButton(
                        text: l10n.restorePassword, // "Восстановить пароль"
                        icon: Icons.email_outlined,
                        onClick: () => _showResetPasswordDialog(context, l10n),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  _SettingsCard(
                    child: _SettingsButton(
                      text: l10n.editProfileButton, // "Редактировать профиль"
                      icon: Icons.edit_outlined,
                      onClick: () => context.push('/profile/edit'),
                    ),
                  ),
                  const SizedBox(height: 16),

                  _SettingsCard(
                    children: [
                      _SectionTitle(l10n.dailyNotifications), // "Ежедневные уведомления"
                      if (settings == null)
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Center(child: CupertinoActivityIndicator(color: Colors.white)),
                        )
                      else ...[
                        _NotificationSwitch(
                          key: const ValueKey('notif_horoscope'),
                          text: l10n.oracle_orb_horoscope, // "Гороскоп"
                          icon: Icons.wb_sunny_outlined,
                          value: settings.horoscope,
                          onChanged: (value) {
                            context.read<AppCubit>().updateNotificationSettings(
                              context: context,
                              horoscope: value,
                            );
                          },
                        ),
                        const _Divider(),
                        _NotificationSwitch(
                          key: const ValueKey('notif_card_of_day'),
                          text: l10n.oracle_pro_card_of_day_title, // "Карта Дня"
                          icon: Icons.style_outlined,
                          value: settings.cardOfTheDay,
                          onChanged: (value) {
                            context.read<AppCubit>().updateNotificationSettings(
                              context: context,
                              cardOfTheDay: value,
                            );
                          },
                        ),
                        const _Divider(),
                        _NotificationSwitch(
                          key: const ValueKey('notif_focus_of_day'),
                          text: l10n.oracle_pro_focus_of_day_title, // "Фокус Дня"
                          icon: Icons.center_focus_strong_outlined,
                          value: settings.focusOfTheDay,
                          onChanged: (value) {
                            context.read<AppCubit>().updateNotificationSettings(
                              context: context,
                              focusOfTheDay: value,
                            );
                          },
                        ),
                        const _Divider(),
                        _NotificationSwitch(
                          key: const ValueKey('notif_partner_of_day'),
                          text: l10n.oracle_pro_feature_title, // "Партнер Дня"
                          icon: Icons.favorite_outline,
                          value: settings.partnerOfTheDay,
                          onChanged: (value) {
                            context.read<AppCubit>().updateNotificationSettings(
                              context: context,
                              partnerOfTheDay: value,
                            );
                          },
                        ),
                        const _Divider(),
                        _NotificationSwitch(
                          key: const ValueKey('notif_hybrid_forecast'),
                          text: l10n.personalForecastTitle, // "Персональный прогноз"
                          icon: Icons.rocket_launch_outlined,
                          value: settings.hybridForecast,
                          onChanged: (value) {
                            context.read<AppCubit>().updateNotificationSettings(
                              context: context,
                              hybridForecast: value,
                            );
                          },
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 16),

                  _SettingsCard(
                    children: [
                      _SectionTitle(l10n.alertsTitle), // "Оповещения"
                      if (settings == null)
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Center(child: CupertinoActivityIndicator(color: Colors.white)),
                        )
                      else
                        _NotificationSwitch(
                          key: const ValueKey('notif_geomagnetic'),
                          text: l10n.geomagneticStorms, // "Геомагнитные бури"
                          icon: Icons.waves_outlined,
                          value: settings.geomagneticAlerts,
                          onChanged: (value) {
                            context.read<AppCubit>().updateNotificationSettings(
                              context: context,
                              geomagneticAlerts: value,
                            );
                          },
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  if (state.currentUserProfile?.role == 'admin')
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: _SettingsCard(
                        children: [
                          _SectionTitle(l10n.adminPanelTitle, icon: Icons.admin_panel_settings, color: Colors.pinkAccent), // "Панель Администратора"
                          _SettingsButton(
                            text: l10n.adminManageUsers, // "Управление пользователями"
                            icon: Icons.groups_outlined,
                            onClick: () {
                              showSnackBar(context, l10n.feature_in_development); // "Функция в разработке"
                            },
                          ),
                        ],
                      ),
                    ),

                  _SettingsButton(
                    text: l10n.privacyPolicyLink, // "Политика конфиденциальности"
                    icon: Icons.policy_outlined,
                    onClick: () => context.push('/privacy-policy'),
                  ),

                  const _Divider(),

                  _SettingsButton(
                    text: l10n.termsOfUseLink, // "Условия использования"
                    icon: Icons.gavel_outlined,
                    onClick: () => context.push('/terms-of-use'),
                  ),

                  const _Divider(),

                  _SettingsButton(
                    text: l10n.offerAgreementLink, // "Договор оферты"
                    icon: Icons.assignment_outlined,
                    onClick: () => context.push('/offer-agreement'),
                  ),

                  const SizedBox(height: 16),

                  _SettingsCard(
                    children: [
                      _SectionTitle(l10n.accountSectionTitle, color: Colors.redAccent), // "Аккаунт"
                      _SettingsButton(
                        text: l10n.signOut, // "Выйти из аккаунта"
                        icon: Icons.logout,
                        contentColor: Colors.white,
                        onClick: () {
                          _showSignOutDialog(context, l10n);
                        },
                      ),
                      const _Divider(),
                      _SettingsButton(
                        text: l10n.deleteAccountButton, // "Удалить аккаунт"
                        icon: Icons.delete_forever,
                        contentColor: Colors.redAccent,
                        onClick: () {
                          _showDeleteAccountDialog(context, l10n);
                        },
                      ),
                    ],
                  ),

                  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) ...[
                    const SizedBox(height: 16),
                    _SettingsCard(
                      child: _SettingsButton(
                        text: l10n.closeAppButton, // "Закрыть приложение"
                        icon: Icons.exit_to_app,
                        contentColor: Colors.white70,
                        onClick: () {
                          _showExitAppDialog(context, l10n);
                        },
                      ),
                    ),
                  ],

                  const SizedBox(height: 32),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void _showChangePasswordDialog(BuildContext context, AppLocalizations l10n) {
    final currentPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final cubit = context.read<AppCubit>();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E1E3D).withOpacity(0.95),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: BorderSide(color: Colors.white.withOpacity(0.2)),
          ),
          title: Text(l10n.changePassword, style: const TextStyle(color: Colors.white)), // "Смена пароля"
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(l10n.changePasswordDesc, style: const TextStyle(color: Colors.white70)), // "Для безопасности введите..."
              const SizedBox(height: 16),
              TextField(
                controller: currentPasswordController,
                obscureText: true,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(labelText: l10n.currentPasswordLabel), // "Текущий пароль"
              ),
              const SizedBox(height: 8),
              TextField(
                controller: newPasswordController,
                obscureText: true,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(labelText: l10n.newPasswordLabel), // "Новый пароль"
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text(l10n.cancel, style: const TextStyle(color: Colors.white)),
              onPressed: () => Navigator.of(dialogContext).pop(),
            ),
            ElevatedButton(
              child: Text(l10n.confirmButton), // "Подтвердить"
              onPressed: () async {
                final result = await cubit.updatePassword(
                  currentPassword: currentPasswordController.text.trim(),
                  newPassword: newPasswordController.text.trim(),
                );

                if (!dialogContext.mounted) return;

                if (result == null) {
                  Navigator.of(dialogContext).pop();
                  showSnackBar(context, l10n.passwordChangedSuccess); // "Пароль успешно изменен!"
                } else {
                  showSnackBar(dialogContext, result, isError: true);
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showResetPasswordDialog(BuildContext context, AppLocalizations l10n) {
    final cubit = context.read<AppCubit>();
    final email = cubit.state.email.isNotEmpty
        ? cubit.state.email
        : cubit.auth.currentUser?.email ?? '';

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E1E3D).withOpacity(0.95),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: BorderSide(color: Colors.white.withOpacity(0.2)),
          ),
          title: Text(l10n.restorePassword, style: const TextStyle(color: Colors.white)),
          content: Text(
              l10n.resetPasswordInstruction(email), // "Мы отправим инструкцию..."
              style: const TextStyle(color: Colors.white70)
          ),
          actions: [
            TextButton(
              child: Text(l10n.cancel, style: const TextStyle(color: Colors.white)),
              onPressed: () => Navigator.of(dialogContext).pop(),
            ),
            ElevatedButton(
              child: Text(l10n.sendButton),
              onPressed: () async {
                final result = await cubit.forgotPassword(email);

                if (!dialogContext.mounted) return;
                Navigator.of(dialogContext).pop();

                if (result == null) {
                  showSnackBar(context, l10n.passwordResetSuccess);
                } else {
                  showSnackBar(context, result, isError: true);
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showSignOutDialog(BuildContext context, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E3D).withOpacity(0.95),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(color: Colors.white.withOpacity(0.2)),
        ),
        title: Text(l10n.signOutDialogTitle, style: const TextStyle(color: Colors.white)), // "Выход из аккаунта"
        content: Text(l10n.signOutDialogContent, style: const TextStyle(color: Colors.white70)), // "Вы уверены...?"
        actions: [
          TextButton(
            child: Text(l10n.cancel, style: const TextStyle(color: Colors.white)),
            onPressed: () => Navigator.of(dialogContext).pop(),
          ),
          TextButton(
            child: Text(l10n.signOutButton, style: const TextStyle(color: Colors.redAccent)), // "Выйти"
            onPressed: () {
              Navigator.of(dialogContext).pop();
              context.read<AppCubit>().signOut();
            },
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: const Color(0xFF2A0E0E).withOpacity(0.98),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(color: Colors.redAccent.withOpacity(0.4)),
        ),
        title: Text(l10n.deleteAccountTitle, style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)), // "Удалить аккаунт?"
        content: Text(
            l10n.deleteAccountWarning, // "Это действие необратимо..."
            style: const TextStyle(color: Colors.white70)
        ),
        actions: [
          TextButton(
            child: Text(l10n.cancel, style: const TextStyle(color: Colors.white)),
            onPressed: () => Navigator.of(dialogContext).pop(),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text(l10n.deleteForeverButton, style: const TextStyle(color: Colors.white)), // "Удалить навсегда"
            onPressed: () {
              Navigator.of(dialogContext).pop();
              context.read<AppCubit>().deleteAccount();
            },
          ),
        ],
      ),
    );
  }

  void _showExitAppDialog(BuildContext context, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E1E3D).withOpacity(0.95),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: BorderSide(color: Colors.white.withOpacity(0.2)),
          ),
          title: Text(l10n.exitConfirmationTitle, style: const TextStyle(color: Colors.white)),
          content: Text(l10n.exitConfirmationContent, style: const TextStyle(color: Colors.white70)),
          actions: <Widget>[
            TextButton(
              child: Text(l10n.cancel, style: const TextStyle(color: Colors.white)),
              onPressed: () => Navigator.of(dialogContext).pop(),
            ),
            TextButton(
              child: Text(l10n.close, style: const TextStyle(color: Colors.redAccent)),
              onPressed: () => SystemNavigator.pop(),
            ),
          ],
        );
      },
    );
  }
}

// ... _SettingsCard, _SettingsButton, _SectionTitle, _Divider, _NotificationSwitch остаются без изменений ...
// (Они просто вспомогательные и не содержат текста)

class _SettingsCard extends StatelessWidget {
  final Widget? child;
  final List<Widget>? children;
  const _SettingsCard({this.child, this.children});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white.withOpacity(0.05),
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.white.withOpacity(0.1), width: 1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: child ?? Column(children: children!),
      ),
    );
  }
}

class _SettingsButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color contentColor;
  final VoidCallback onClick;

  const _SettingsButton({
    required this.text,
    required this.icon,
    this.contentColor = Colors.white,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
        child: Row(
          children: [
            Icon(icon, color: contentColor),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                style: TextStyle(color: contentColor, fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.white24, size: 16),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final IconData? icon;
  final Color? color;
  const _SectionTitle(this.title, {this.icon, this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, color: color ?? Colors.white70, size: 20),
            const SizedBox(width: 8),
          ],
          Text(
            title.toUpperCase(),
            style: TextStyle(
              color: color ?? Colors.white54,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();
  @override
  Widget build(BuildContext context) {
    return Divider(color: Colors.white.withOpacity(0.1), height: 1, indent: 16, endIndent: 16);
  }
}

class _NotificationSwitch extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _NotificationSwitch({
    super.key,
    required this.text,
    required this.icon,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isUpdating = context.select((AppCubit cubit) => cubit.state.isUpdatingSettings);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 6.0, 8.0, 6.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          if (isUpdating)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: SizedBox(
                  width: 24, height: 24,
                  child: CupertinoActivityIndicator(color: Colors.white70)
              ),
            )
          else
            CupertinoSwitch(
              value: value,
              onChanged: isUpdating ? null : onChanged,
              activeColor: Theme.of(context).colorScheme.secondary,
            ),
        ],
      ),
    );
  }
}