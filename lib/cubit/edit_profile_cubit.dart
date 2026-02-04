// lib/cubit/edit_profile_cubit.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lovequest/cubit/app_cubit.dart';
import 'package:lovequest/cubit/edit_profile_state.dart';
import 'package:lovequest/services/cloudinary_service.dart';
import 'package:lovequest/src/data/models/nominatim_suggestion.dart';
import 'package:lovequest/src/data/models/user_profile_card.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final CloudinaryService _cloudinaryService;
  final AppCubit _appCubit;

  EditProfileCubit({
    required CloudinaryService cloudinaryService,
    required AppCubit appCubit,
    required UserProfileCard initialProfile,
  })  : _cloudinaryService = cloudinaryService,
        _appCubit = appCubit,
        super(EditProfileState.fromProfile(initialProfile));

  // --- Методы для обновления полей в UI ---
  void onNameChanged(String name) => emit(state.copyWith(name: name));
  void onBioChanged(String bio) => emit(state.copyWith(bio: bio));
  void onBirthDateChanged(DateTime date) => emit(state.copyWith(newBirthDate: date));
  void onBirthLocationChanged(NominatimSuggestion location) => emit(state.copyWith(newBirthLocation: location));
  // TODO: Добавить метод onBirthTimeChanged, если у тебя есть выбор времени

  // --- Метод для загрузки аватара ---
  Future<void> pickAndUploadAvatar() async {
    try {
      emit(state.copyWith(avatarStatus: AvatarUploadStatus.uploading));
      final imageFile = await ImagePicker().pickImage(
        source: ImageSource.gallery, imageQuality: 80, maxWidth: 1080,
      );
      if (imageFile == null) {
        emit(state.copyWith(avatarStatus: AvatarUploadStatus.initial));
        return;
      }
      final imageUrl = await _cloudinaryService.uploadImage(imageFile: imageFile);
      if (imageUrl == null) throw Exception("Не удалось загрузить фото.");

      // Сохраняем URL только в локальном стейте, пока пользователь не нажмет "Сохранить"
      emit(state.copyWith(
        newAvatarUrl: imageUrl,
        avatarStatus: AvatarUploadStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(avatarStatus: AvatarUploadStatus.error, errorMessage: "Ошибка загрузки фото: $e"));
    }
  }

  // --- Метод для сохранения всех изменений ---
  Future<void> saveChanges() async {
    if (!state.isChanged) return;
    emit(state.copyWith(status: EditProfileStatus.saving));

    try {
      final dataToSave = <String, dynamic>{};
      if (state.name != state.initialProfile.name) dataToSave['name'] = state.name;
      if (state.bio != state.initialProfile.bio) dataToSave['bio'] = state.bio;
      if (state.newAvatarUrl != null) dataToSave['avatarUrl'] = state.newAvatarUrl;

      // Если менялись только имя/био/аватар
      if (dataToSave.isNotEmpty && !state.isBirthDataChanged) {
        await _appCubit.updateUserProfile(dataToSave);
      }

      // Если менялись данные рождения
      if (state.isBirthDataChanged) {
        await saveBirthDataChanges();
      }

      emit(state.copyWith(status: EditProfileStatus.success));
    } catch (e) {
      emit(state.copyWith(status: EditProfileStatus.error, errorMessage: e.toString()));
    }
  }

  // --- Отдельный метод для сохранения данных рождения ---
  Future<void> saveBirthDataChanges() async {
    if (!state.isBirthDataChanged) return;

    // Этот метод не меняет статус на saving, так как вызывается из saveChanges

    final dataToSave = <String, dynamic>{};
    if (state.newAvatarUrl != null) {
      dataToSave['avatarUrl'] = state.newAvatarUrl;
    }

    if (state.newBirthDate != null) {
      final oldTime = TimeOfDay.fromDateTime(DateTime.fromMillisecondsSinceEpoch(state.initialProfile.birthDateMillis));
      final newDateTime = DateTime(
        state.newBirthDate!.year, state.newBirthDate!.month, state.newBirthDate!.day,
        state.newBirthTime?.hour ?? oldTime.hour,
        state.newBirthTime?.minute ?? oldTime.minute,
      );
      dataToSave['birthDateMillis'] = newDateTime.millisecondsSinceEpoch;
    }

    if (state.newBirthTime != null) {
      dataToSave['birthTime'] = '${state.newBirthTime!.hour.toString().padLeft(2, '0')}:${state.newBirthTime!.minute.toString().padLeft(2, '0')}';
    }

    if (state.newBirthLocation != null) {
      dataToSave['birthLocation'] = {
        'latitude': double.tryParse(state.newBirthLocation!.latitude),
        'longitude': double.tryParse(state.newBirthLocation!.longitude),
      };
      dataToSave['birthCity'] = state.newBirthLocation!.address?.city ?? state.newBirthLocation!.displayName;
      dataToSave['birthCountry'] = state.newBirthLocation!.address?.country;
    }

    // Вызываем специальный метод в AppCubit
    await _appCubit.updateBirthData(dataToSave);
  }
}