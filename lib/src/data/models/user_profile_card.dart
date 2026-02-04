// lib/src/data/models/user_profile_card.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:lovequest/src/data/models/astrology/natal_chart.dart';
import 'package:lovequest/src/data/models/jyotish_chart.dart';
import 'package:lovequest/src/data/models/user_settings.dart';

import 'numerology_report.dart';

// --- ЕДИНАЯ ВСПОМОГАТЕЛЬНАЯ ФУНКЦИЯ ДЛЯ ДАТ ---
DateTime? _dateTimeFromDynamic(dynamic json) {
  if (json == null) return null;
  if (json is String) return DateTime.tryParse(json);
  if (json is Timestamp) return json.toDate();
  if (json is int) return DateTime.fromMillisecondsSinceEpoch(json);
  return null;
}

class UserProfileCard extends Equatable {
  final String id;
  final String name;
  final String surname;
  final String bio;
  final String avatar;
  final String gender;
  final String seekingGender;
  final String role;
  final int? compatibilityScore;
  final bool showPalmistryInProfile;
  final String? oneSignalPlayerId;
  final UserSettings? settings;
  final int stardust;
  final Map<String, int> giftsInventory;
  final Map<String, String> palmistryData;
  final List<String> palmistryTraits;
  final int photoCount;
  final int birthDateMillis;
  final String birthTime;
  final GeoPoint? birthLocation;
  final String birthCity;
  final String birthCountry;
  final GeoPoint? currentLocation;
  final String country;
  final String city;
  final Map<String, dynamic>? currentLocationPlus;
  final NatalChart? natalChart;
  final PersonalNumerologyReport? numerologyData;
  final String sunSign;
  final List<String> likedUsers;
  final List<String> likedByUsers;
  final List<String> hiddenLikes;
  final List<String> friends;
  final List<String> friendRequestsSent;
  final List<String> friendRequestsReceived;
  final bool hasUsedTrial;
  final List<String> groupIds;
  final List<String> subscribedChannelIds;
  final bool isBanned;
  final List<String> bioKeywords;
  final List<String> bioHashtags;
  final String? referralCode;
  final bool hasUsedReferralCode;
  final List<String> searchKeywords;
  final String languageCode;
  final String chineseZodiac;
  final JyotishChart? jyotishChart;
  final bool isEmailVerified; // <-- Поле есть

  // --- ПОЛЯ С ТИПОМ DateTime? ---
  final DateTime? trialEndsAt;
  final DateTime? premiumEndsAt;
  final DateTime? lastOnline;

  // --- ГЕТТЕРЫ ---
  int get age {
    if (birthDateMillis == 0) return 0;
    final dob = DateTime.fromMillisecondsSinceEpoch(birthDateMillis);
    final today = DateTime.now();
    int age = today.year - dob.year;
    if (today.month < dob.month || (today.month == dob.month && today.day < dob.day)) {
      age--;
    }
    return age > 0 ? age : 0;
  }

  bool get isProUser {
    final now = DateTime.now();
    final isTrialActive = trialEndsAt != null && trialEndsAt!.isAfter(now);
    final isPremiumActive = premiumEndsAt != null && premiumEndsAt!.isAfter(now);
    return isTrialActive || isPremiumActive;
  }

  DateTime? get proEndDate {
    if (trialEndsAt == null && premiumEndsAt == null) return null;
    if (trialEndsAt != null && premiumEndsAt != null) {
      return trialEndsAt!.isAfter(premiumEndsAt!) ? trialEndsAt : premiumEndsAt;
    }
    return trialEndsAt ?? premiumEndsAt;
  }

  // --- КОНСТРУКТОР ---
  const UserProfileCard({
    required this.id,
    this.name = '', this.surname = '', this.bio = '',
    this.gender = 'non-binary', this.seekingGender = 'all',
    this.oneSignalPlayerId, this.photoCount = 0, this.avatar = '',
    this.chineseZodiac = '', this.birthDateMillis = 0, this.birthTime = '12:00',
    this.birthLocation, this.birthCity = '', this.birthCountry = '',
    this.currentLocation, this.stardust = 0, this.giftsInventory = const {},
    this.searchKeywords = const [], this.settings, this.languageCode = 'ru',
    this.numerologyData, this.likedUsers = const [],
    this.likedByUsers = const [], this.hiddenLikes = const [],
    this.palmistryData = const {}, this.palmistryTraits = const [],
    this.hasUsedTrial = false, this.trialEndsAt, this.premiumEndsAt,
    this.groupIds = const [], this.subscribedChannelIds = const [],
    this.sunSign = '', this.natalChart, this.isBanned = false, this.role = 'user',
    this.bioKeywords = const [], this.bioHashtags = const [],
    this.lastOnline, this.country = '', this.city = '',
    this.currentLocationPlus, this.compatibilityScore,
    this.friends = const [], this.friendRequestsSent = const [],
    this.friendRequestsReceived = const [], this.referralCode,
    this.hasUsedReferralCode = false, this.showPalmistryInProfile = false,
    this.jyotishChart,
    this.isEmailVerified = false, // <-- Добавлено в конструктор
  });

  // --- ФАБРИЧНЫЙ КОНСТРУКТОР fromJson ---
  factory UserProfileCard.fromJson(Map<String, dynamic> json) {

    int _parseInt(dynamic value, {int defaultValue = 0}) {
      if (value == null) return defaultValue;
      if (value is int) return value;
      if (value is double) return value.toInt();
      if (value is String) return int.tryParse(value) ?? defaultValue;
      return defaultValue;
    }

    double _parseDouble(dynamic value) {
      if (value == null) return 0.0;
      if (value is double) return value;
      if (value is int) return value.toDouble();
      if (value is String) return double.tryParse(value) ?? 0.0;
      return 0.0;
    }

    // --- УМНЫЙ ПАРСЕР ГЕОЛОКАЦИИ ---
    GeoPoint? _parseGeo(dynamic geoJson, String? latKey, String? lonKey) {
      if (geoJson is GeoPoint) return geoJson;
      if (geoJson is Map) {
        final lat = geoJson['latitude'] ?? geoJson['lat'];
        final lon = geoJson['longitude'] ?? geoJson['lon'];
        if (lat != null && lon != null) {
          return GeoPoint(_parseDouble(lat), _parseDouble(lon));
        }
      }
      if (geoJson is String && geoJson.contains('POINT')) {
        try {
          final coords = geoJson.split('(')[1].split(')')[0].split(' ');
          final lon = double.parse(coords[0]);
          final lat = double.parse(coords[1]);
          return GeoPoint(lat, lon);
        } catch (e) {
          print("Error parsing WKT: $e");
        }
      }
      if (latKey != null && lonKey != null) {
        final lat = json[latKey];
        final lon = json[lonKey];
        if (lat != null && lon != null) {
          return GeoPoint(_parseDouble(lat), _parseDouble(lon));
        }
      }
      return null;
    }

    return UserProfileCard(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      surname: json['surname'] as String? ?? '',
      bio: json['bio'] as String? ?? '',
      avatar: json['avatar'] as String? ?? json['avatarUrl'] as String? ?? '',
      gender: json['gender'] as String? ?? 'non-binary',
      seekingGender: json['seekingGender'] as String? ?? 'all',
      role: json['role'] as String? ?? 'user',
      compatibilityScore: _parseInt(json['compatibilityScore'], defaultValue: 50),
      showPalmistryInProfile: json['showPalmistryInProfile'] as bool? ?? false,
      oneSignalPlayerId: json['oneSignalPlayerId'] as String?,
      settings: UserSettings.fromMap(json['settings'] as Map<String, dynamic>?),
      stardust: _parseInt(json['stardust']),
      giftsInventory: Map<String, int>.from(json['giftsInventory'] ?? {}),
      palmistryData: Map<String, String>.from(json['palmistryData'] ?? {}),
      palmistryTraits: List<String>.from(json['palmistryTraits'] ?? []),
      photoCount: _parseInt(json['photoCount']),
      birthDateMillis: _parseInt(json['birthDateMillis']),
      birthTime: json['birthTime'] as String? ?? '12:00',
      birthLocation: _parseGeo(json['birthLocation'], 'birthLatitude', 'birthLongitude'),
      currentLocation: _parseGeo(json['currentLocation'], 'currentLatitude', 'currentLongitude'),
      birthCity: json['birthCity'] as String? ?? '',
      birthCountry: json['birthCountry'] as String? ?? '',
      currentLocationPlus: json['currentLocationPlus'] as Map<String, dynamic>?,
      country: json['country'] as String? ?? '',
      city: json['city'] as String? ?? '',
      jyotishChart: json['jyotishChart'] != null ? JyotishChart.fromJson(json['jyotishChart']) : null,
      natalChart: json['natalChart'] != null ? NatalChart.fromMap(json['natalChart']) : null,
      numerologyData: json['numerologyData'] != null ? PersonalNumerologyReport.fromJson(json['numerologyData']) : null,
      sunSign: json['sunSign'] as String? ?? '',
      likedUsers: List<String>.from(json['likedUsers'] ?? []),
      likedByUsers: List<String>.from(json['likedByUsers'] ?? []),
      hiddenLikes: List<String>.from(json['hiddenLikes'] ?? []),
      friends: List<String>.from(json['friends'] ?? []),
      friendRequestsSent: List<String>.from(json['friendRequestsSent'] ?? []),
      friendRequestsReceived: List<String>.from(json['friendRequestsReceived'] ?? []),
      hasUsedTrial: json['hasUsedTrial'] as bool? ?? false,
      trialEndsAt: _dateTimeFromDynamic(json['trialEndsAt']),
      premiumEndsAt: _dateTimeFromDynamic(json['premiumEndsAt']),
      groupIds: List<String>.from(json['groupIds'] ?? []),
      subscribedChannelIds: List<String>.from(json['subscribedChannelIds'] ?? []),
      isBanned: json['isBanned'] as bool? ?? false,
      bioKeywords: List<String>.from(json['bioKeywords'] ?? []),
      bioHashtags: List<String>.from(json['bioHashtags'] ?? []),
      lastOnline: _dateTimeFromDynamic(json['lastOnline']),
      referralCode: json['referralCode'] as String?,
      hasUsedReferralCode: json['hasUsedReferralCode'] as bool? ?? false,
      searchKeywords: List<String>.from(json['searchKeywords'] ?? []),
      languageCode: json['languageCode'] as String? ?? 'ru',
      chineseZodiac: json['chineseZodiac'] as String? ?? '',
      isEmailVerified: json['isEmailVerified'] ?? json['is_email_verified'] ?? false,
    );
  }

  // --- ВОТ ИСПРАВЛЕННЫЙ copyWith ---
  UserProfileCard copyWith({
    String? id, String? name, String? surname, String? bio, String? avatar,
    String? gender, String? seekingGender, String? role, int? compatibilityScore,
    bool? showPalmistryInProfile, String? oneSignalPlayerId, UserSettings? settings,
    int? stardust, Map<String, int>? giftsInventory, Map<String, String>? palmistryData,
    List<String>? palmistryTraits, int? photoCount, int? birthDateMillis,
    String? birthTime, GeoPoint? birthLocation, String? birthCity, String? birthCountry,
    GeoPoint? currentLocation, Map<String, dynamic>? currentLocationPlus, String? country,
    String? city, NatalChart? natalChart, PersonalNumerologyReport? numerologyData,
    String? sunSign, List<String>? likedUsers, List<String>? likedByUsers,
    List<String>? hiddenLikes, List<String>? friends, List<String>? friendRequestsSent,
    List<String>? friendRequestsReceived, bool? hasUsedTrial, List<String>? groupIds,
    List<String>? subscribedChannelIds, bool? isBanned, List<String>? bioKeywords,
    List<String>? bioHashtags, String? referralCode, bool? hasUsedReferralCode,
    List<String>? searchKeywords, String? languageCode, String? chineseZodiac,
    JyotishChart? jyotishChart, DateTime? trialEndsAt, DateTime? premiumEndsAt,
    DateTime? lastOnline,
    bool? isEmailVerified, // <--- 1. ДОБАВЛЕНО В АРГУМЕНТЫ
  }) {
    return UserProfileCard(
      id: id ?? this.id,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      bio: bio ?? this.bio,
      avatar: avatar ?? this.avatar,
      gender: gender ?? this.gender,
      seekingGender: seekingGender ?? this.seekingGender,
      role: role ?? this.role,
      compatibilityScore: compatibilityScore ?? this.compatibilityScore,
      showPalmistryInProfile: showPalmistryInProfile ?? this.showPalmistryInProfile,
      oneSignalPlayerId: oneSignalPlayerId ?? this.oneSignalPlayerId,
      settings: settings ?? this.settings,
      stardust: stardust ?? this.stardust,
      giftsInventory: giftsInventory ?? this.giftsInventory,
      palmistryData: palmistryData ?? this.palmistryData,
      palmistryTraits: palmistryTraits ?? this.palmistryTraits,
      photoCount: photoCount ?? this.photoCount,
      birthDateMillis: birthDateMillis ?? this.birthDateMillis,
      birthTime: birthTime ?? this.birthTime,
      birthLocation: birthLocation ?? this.birthLocation,
      birthCity: birthCity ?? this.birthCity,
      birthCountry: birthCountry ?? this.birthCountry,
      currentLocation: currentLocation ?? this.currentLocation,
      currentLocationPlus: currentLocationPlus ?? this.currentLocationPlus,
      country: country ?? this.country,
      city: city ?? this.city,
      natalChart: natalChart ?? this.natalChart,
      numerologyData: numerologyData ?? this.numerologyData,
      sunSign: sunSign ?? this.sunSign,
      likedUsers: likedUsers ?? this.likedUsers,
      likedByUsers: likedByUsers ?? this.likedByUsers,
      hiddenLikes: hiddenLikes ?? this.hiddenLikes,
      friends: friends ?? this.friends,
      friendRequestsSent: friendRequestsSent ?? this.friendRequestsSent,
      friendRequestsReceived: friendRequestsReceived ?? this.friendRequestsReceived,
      hasUsedTrial: hasUsedTrial ?? this.hasUsedTrial,
      groupIds: groupIds ?? this.groupIds,
      subscribedChannelIds: subscribedChannelIds ?? this.subscribedChannelIds,
      isBanned: isBanned ?? this.isBanned,
      bioKeywords: bioKeywords ?? this.bioKeywords,
      bioHashtags: bioHashtags ?? this.bioHashtags,
      referralCode: referralCode ?? this.referralCode,
      hasUsedReferralCode: hasUsedReferralCode ?? this.hasUsedReferralCode,
      searchKeywords: searchKeywords ?? this.searchKeywords,
      languageCode: languageCode ?? this.languageCode,
      chineseZodiac: chineseZodiac ?? this.chineseZodiac,
      jyotishChart: jyotishChart ?? this.jyotishChart,
      trialEndsAt: trialEndsAt ?? this.trialEndsAt,
      premiumEndsAt: premiumEndsAt ?? this.premiumEndsAt,
      lastOnline: lastOnline ?? this.lastOnline,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified, // <--- 2. ДОБАВЛЕНО СЮДА
    );
  }

  @override
  List<Object?> get props => [
    id, name, surname, bio, avatar, gender, seekingGender, role,
    compatibilityScore, showPalmistryInProfile, oneSignalPlayerId,
    settings, stardust, giftsInventory, palmistryData, palmistryTraits,
    photoCount, birthDateMillis, birthTime, birthLocation, birthCity,
    birthCountry, currentLocation, country, city, currentLocationPlus,
    natalChart, numerologyData, sunSign, likedUsers, likedByUsers,
    hiddenLikes, friends, friendRequestsSent, friendRequestsReceived,
    hasUsedTrial, groupIds, subscribedChannelIds, isBanned,
    bioKeywords, bioHashtags, referralCode, hasUsedReferralCode,
    searchKeywords, languageCode, chineseZodiac, jyotishChart,
    trialEndsAt, premiumEndsAt, lastOnline,
    isEmailVerified, // <--- 3. ДОБАВЛЕНО В СПИСОК СРАВНЕНИЯ
  ];
}