// lib/screens/edit_profile_screen.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:lovequest/cubit/app_state.dart';
import 'package:lovequest/l10n/generated/app_localizations.dart'; // <-- Импорт локализации
import 'package:lovequest/widgets/common/user_avatar.dart';
import '../cubit/app_cubit.dart';
import '../cubit/edit_profile_state.dart';
import 'package:lovequest/cubit/edit_profile_cubit.dart';
import 'package:lovequest/src/data/models/nominatim_suggestion.dart';
import '../services/cloudinary_service.dart';

// Вынес showSnackBar в отдельный хелпер (если он еще не там) или использую локальный
void _showSnackBar(BuildContext context, String message, {bool isError = false}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    backgroundColor: isError ? Colors.redAccent : Colors.green,
  ));
}

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (context) => EditProfileCubit(
        cloudinaryService: context.read<CloudinaryService>(),
        initialProfile: context.read<AppCubit>().state.currentUserProfile!,
        appCubit: context.read<AppCubit>(),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.editProfileTitle), // "Редактирование профиля"
          actions: [
            BlocBuilder<EditProfileCubit, EditProfileState>(
              builder: (context, state) {
                if (state.status == EditProfileStatus.saving) {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)),
                  );
                }
                return IconButton(
                  icon: const Icon(Icons.check),
                  onPressed: state.isChanged
                      ? () => context.read<EditProfileCubit>().saveChanges()
                      : null,
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<AppCubit, AppState>(
          buildWhen: (p, c) => p.currentUserProfile != c.currentUserProfile,
          builder: (context, appState) {
            final currentUser = appState.currentUserProfile;
            if (currentUser == null) return Center(child: Text(l10n.profileNotFoundError)); // "Ошибка: профиль не найден"

            return BlocConsumer<EditProfileCubit, EditProfileState>(
              listener: (context, editState) {
                if (editState.status == EditProfileStatus.success) {
                  _showSnackBar(context, l10n.profileSavedSuccess); // "Профиль успешно сохранен!"
                  if (context.canPop()) context.pop();
                }
                if (editState.status == EditProfileStatus.error) {
                  _showSnackBar(context, editState.errorMessage ?? l10n.saveError, isError: true); // "Ошибка сохранения"
                }
                if (editState.avatarStatus == AvatarUploadStatus.error) {
                  _showSnackBar(context, editState.errorMessage ?? l10n.avatarUploadError, isError: true); // "Ошибка загрузки фото"
                }
              },
              builder: (context, editState) {
                final displayProfile = currentUser.copyWith(
                  name: editState.name,
                  bio: editState.bio,
                  avatar: editState.newAvatarUrl ?? currentUser.avatar,
                );
                final isLoadingAvatar = editState.avatarStatus == AvatarUploadStatus.uploading;

                return ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          UserAvatar(user: displayProfile, radius: 60),
                          if (isLoadingAvatar)
                            const Positioned.fill(
                              child: CircleAvatar(
                                backgroundColor: Colors.black54,
                                child: CircularProgressIndicator(color: Colors.white),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      initialValue: editState.name,
                      decoration: InputDecoration(labelText: l10n.nameLabel), // "Имя"
                      onChanged: (value) => context.read<EditProfileCubit>().onNameChanged(value),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: editState.bio,
                      decoration: InputDecoration(labelText: l10n.bioLabel), // "О себе"
                      maxLines: 5,
                      onChanged: (value) => context.read<EditProfileCubit>().onBioChanged(value),
                    ),
                    const SizedBox(height: 24),
                    const Divider(),
                    const SizedBox(height: 16),
                    Text(l10n.birthDataTitle, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), // "Данные рождения"
                    Text(
                      l10n.birthDataWarning, // "Изменение этих данных..."
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    const SizedBox(height: 16),
                    ListTile(
                      leading: const Icon(Icons.calendar_today),
                      title: Text(l10n.birthDateLabel), // "Дата рождения"
                      subtitle: Text(
                          DateFormat('d MMMM yyyy', Localizations.localeOf(context).languageCode).format(
                              editState.newBirthDate ?? DateTime.fromMillisecondsSinceEpoch(editState.initialProfile.birthDateMillis)
                          )
                      ),
                      onTap: () async {
                        final pickedDate = await showDatePicker(
                          context: context,
                          initialDate: editState.newBirthDate ?? DateTime.fromMillisecondsSinceEpoch(editState.initialProfile.birthDateMillis),
                          firstDate: DateTime(1940),
                          lastDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
                        );
                        if (pickedDate != null && context.mounted) {
                          context.read<EditProfileCubit>().onBirthDateChanged(pickedDate);
                        }
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.location_on),
                      title: Text(l10n.birthPlaceLabel), // "Место рождения"
                      subtitle: Text(
                          editState.newBirthLocation?.displayName ?? editState.initialProfile.birthCity
                      ),
                      onTap: () async {
                        final selectedLocation = await context.push<NominatimSuggestion>('/select-location');
                        if (selectedLocation != null && context.mounted) {
                          context.read<EditProfileCubit>().onBirthLocationChanged(selectedLocation);
                        }
                      },
                    ),
                    const SizedBox(height: 24),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}