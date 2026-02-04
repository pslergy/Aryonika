// lib/cubit/edit_profile_state.dart

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lovequest/src/data/models/nominatim_suggestion.dart';
import 'package:lovequest/src/data/models/user_profile_card.dart';

enum EditProfileStatus { initial, saving, success, error }
enum AvatarUploadStatus { initial, uploading, success, error }

class EditProfileState extends Equatable {
  // --- Статусы ---
  final EditProfileStatus status;
  final AvatarUploadStatus avatarStatus;
  final String? errorMessage;

  // --- Исходные данные ---
  final UserProfileCard initialProfile;

  // --- Новые, измененные данные ---
  final String name;
  final String bio;
  final String? newAvatarUrl;
  final DateTime? newBirthDate;
  final TimeOfDay? newBirthTime;
  final NominatimSuggestion? newBirthLocation;

  const EditProfileState({
    this.status = EditProfileStatus.initial,
    this.avatarStatus = AvatarUploadStatus.initial,
    this.errorMessage,
    required this.initialProfile,
    required this.name,
    required this.bio,
    this.newAvatarUrl,
    this.newBirthDate,
    this.newBirthTime,
    this.newBirthLocation,
  });

  // Фабричный конструктор для создания начального состояния из профиля
  factory EditProfileState.fromProfile(UserProfileCard profile) {
    return EditProfileState(
      initialProfile: profile,
      name: profile.name,
      bio: profile.bio,
    );
  }

  // --- Геттеры для проверки изменений ---
  bool get isNameOrBioChanged => name != initialProfile.name || bio != initialProfile.bio;
  bool get isBirthDataChanged => newBirthDate != null || newBirthTime != null || newBirthLocation != null;
  bool get isChanged => isNameOrBioChanged || isBirthDataChanged;

  EditProfileState copyWith({
    EditProfileStatus? status,
    AvatarUploadStatus? avatarStatus,
    String? errorMessage,
    UserProfileCard? initialProfile,
    String? name,
    String? bio,
    String? newAvatarUrl,
    DateTime? newBirthDate,
    TimeOfDay? newBirthTime,
    NominatimSuggestion? newBirthLocation,
  }) {
    return EditProfileState(
      status: status ?? this.status,
      avatarStatus: avatarStatus ?? this.avatarStatus,
      errorMessage: errorMessage, // Ошибку не наследуем, а передаем явно
      initialProfile: initialProfile ?? this.initialProfile,
      name: name ?? this.name,
      bio: bio ?? this.bio,
      newAvatarUrl: newAvatarUrl ?? this.newAvatarUrl,
      newBirthDate: newBirthDate ?? this.newBirthDate,
      newBirthTime: newBirthTime ?? this.newBirthTime,
      newBirthLocation: newBirthLocation ?? this.newBirthLocation,
    );
  }

  @override
  List<Object?> get props => [
    status, avatarStatus, errorMessage, initialProfile, name, bio,
    newAvatarUrl, newBirthDate, newBirthTime, newBirthLocation,
  ];
}