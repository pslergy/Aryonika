// lib/cubit/app_state.dart
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'package:lovequest/services/numerology_calculator.dart';
import 'package:lovequest/src/data/models/astrology/daily_forecast.dart';
import 'package:lovequest/src/data/models/channel.dart';
import 'package:lovequest/src/data/models/comment.dart';
import 'package:lovequest/src/data/models/daily_hybrid_forecast.dart';
import 'package:lovequest/src/data/models/enums.dart';
import 'package:lovequest/src/data/models/focus_of_the_day.dart';
import 'package:lovequest/src/data/models/moon_rhythm.dart';
import 'package:lovequest/src/data/models/post.dart';
import 'package:lovequest/src/data/models/tarot_card.dart';
import 'package:lovequest/src/data/models/user_profile_card.dart';
import '../repositories/horoscope_repository.dart';
import '../services/logger_service.dart';
import '../src/data/models/aspect_interpretation.dart';
import '../src/data/models/channel_preview.dart';
import '../src/data/models/chat_list_item.dart';
import '../src/data/models/cosmic_event.dart';
import '../src/data/models/geomagnetic_forecast.dart';
import '../src/data/models/message.dart';
import '../src/data/models/message.dart' as chat_models;
import '../src/data/models/nominatim_suggestion.dart';
import '../src/data/models/numerology_report.dart';
import '../src/data/models/oracle_theme.dart';
import '../src/data/models/palmistry_models.dart';
import '../utils/value_wrapper.dart';
import 'channel_state.dart';

enum AuthStatus {
  initial,
  submitting,
  success,
  error,
  awaitingVerification
} // <-- Скопируй этот enum
// --- Этот класс оставляем, он используется для Гороскопа ---

// === ДОБАВЬ ЭТОТ ENUM В НАЧАЛО ФАЙЛА ===
enum ProfileValidationStatus {
  unknown, // Статус еще не проверялся
  valid, // Профиль проверен и он в порядке
  invalid // Профиль проверен и он "битый"
}

// =====================================
class HoroscopeState {
  final bool isLoading;
  final String? horoscopeText;
  final String? error;
  final bool isFromCache;
  const HoroscopeState(
      {this.isLoading = false,
      this.horoscopeText,
      this.error,
      this.isFromCache = false});
}

// --- Основной класс состояния ---
class AppState extends Equatable {
  // --- Общие/Профиль ---
  final UserProfileCard? currentUserProfile;
  final bool isInitialized;
  final LoadingState profileLoadingState;
  final ProfileValidationStatus profileStatus;
  final bool? introSeen;
  final bool isReady;
  final bool isUpdatingSettings;
  final int version;
  final bool isProLoading;
  final Map<String, String> numerologyCompatibility;
  final Map<String, dynamic> transitInterpretations;
  final List<CosmicEvent> cosmicEvents;
  final LoadingState cosmicEventsStatus;
  final MoonRhythmResponse? moonRhythm;
  final LoadingState moonRhythmStatus;
  final Map<String, String> numerologyNumberDescriptions;
  final Map<String, String> jyotishDescriptions;
  final String? unverifiedUserId;

  final List<Map<String, String>> viewedUserPhotos;
  final LoadingState viewedUserPhotosStatus;
  final Map<String, bool> typingStatuses;
  final String unverifiedUserEmail;

  final bool searchInitiated;
  final String email;
  final String password;
  final String confirmPassword;
  final AuthStatus authStatus;
  final String? authErrorMessage;
  final LoadingState numerologyScreenStatus;

  final List<ChannelPreview> channelPreviews;
  final bool isLoadingChannelPreviews;

  final int newLikesCount;
  final ValueWrapper<String?>? tarotLimitMessage; // <-- ИЗМЕНЕНО
  final ValueWrapper<String?>? rouletteLimitMessage;
  final ValueWrapper<String?>? oracleLimitMessage; // <-- ИЗМЕНЕНО
  final PalmistryData? palmistryData;
  final LoadingState palmistryLoadingState;
  final Map<String, String> astroCommunicationTips;

  // --- Поиск/Фильтры ---
  final List<UserProfileCard> priorityUsers;
  final List<UserProfileCard> otherUsers;
  final bool isSearchLoading;
  final bool isPaginating;
  final bool allUsersLoaded;
  final String searchText;
  final DocumentSnapshot? lastVisibleUserDocument;
  final Set<String> likedUserIds;
  final SearchMode searchMode;
  final String bioKeywordFilter;
  final String countryFilter;
  final String cityFilter;
  final List<OracleTheme> oracleThemes;
  final bool areOracleThemesLoading;

  final int searchOffset;

  // --- Друзья ---
  final List<UserProfileCard> friends;
  final List<UserProfileCard> friendRequests;
  final Map<String, FriendshipStatus> friendshipStatusMap;
  final bool isLoadingFriends;

  // --- Чаты ---
  final List<ChatListItem> chatListItems;
  final String? activeChatId;
  final List<chat_models.Message> activeChatMessages;
  final bool isLoadingMessages;
  final String? chatError;

  final bool isChatListLoading;
  final int totalUnreadCount;

  final bool isLoadingLocations;
  final List<NominatimSuggestion> locationSuggestions;

  // --- Таро (новая, правильная логика) ---
  final List<TarotCard> fullTarotDeck;
  final bool isTarotDeckLoading;

// ===== НАЧАЛО ИЗМЕНЕНИЙ В APPSTATE =====
  final String? tarotQuestion;
  final List<TarotCard> tarotReadingCards; // 3 вытянутые карты
  final Set<int> flippedCardIds; // ID карт, которые пользователь уже перевернул
  final String? tarotCombinationInterpretation; // Толкование именно комбинации
  final LoadingState tarotReadingState;

  // --- Каналы ---
  final List<Channel> channels;
  final bool isLoadingChannels;
  final String channelListFilter;
  final String channelLanguageFilter;
  final Channel? activeChannel;
  final List<Post> activeChannelPosts;
  final bool isLoadingPosts;
  final bool isPaginatingPosts; // Для подгрузки старых постов
  final List<Comment> activePostComments;
  final bool isLoadingComments;

  // --- Создание контента ---
  final bool isCreatingChannel;
  final String? channelCreationError;

  final String? lastCosmicEventsCalculationDate;

  // --- Оракул и интерактив ---
  final PartnerRouletteState rouletteState;
  final List<UserProfileCard> rouletteCandidates;
  final UserProfileCard? rouletteWinner;
  final UserProfileCard? partnerOfTheDay;
  final LoadingState partnerLoadingState;
  final String? oracleAnswer;
  final bool isOracleAnswering;
  final HoroscopeState horoscopeState;

  // --- Лайки ---
  final List<UserProfileCard> usersWhoLikedMe;
  final LoadingState likesYouLoadingState;

  // --- Настройки ---
  final int minAgeFilter;
  final int maxAgeFilter;
  final String genderFilter;
  final ZodiacFilter zodiacFilter;

  // --- Статус пользователя ---
  final bool isOnboardingComplete;
  final int friendRequestCount;

  // --- Расчетные данные ---
  final Map<String, dynamic> astroDescriptions;
  final Map<String, AspectInterpretation> aspectInterpretations;

  final DailyForecast? dailyForecast;
  final LoadingState dailyForecastLoadingState;
  final bool isForecastLoading;
  final DailyHoroscope? horoscope;
  final FocusOfTheDay? focusOfTheDay;
  final LoadingState focusLoadingState;
  final Map<String, dynamic> focusInterpretations;
  final DailyHybridForecast? hybridForecast;
  final LoadingState hybridForecastLoadingState;
  final Map<String, String> compatibilityDescriptions;
  final TarotCard? cardOfTheDay;
  final LoadingState cardOfTheDayStatus;
  final bool isCardOfTheDayFlipped;
  final String? cardOfTheDayInterpretation;
  final bool isPartnerTyping;

  final Post? activePost;

  final ChannelStatus activePostStatus;

  final Map<String, UserProfileCard> viewedProfilesCache; // <-- СТАЛО
  final String? currentViewedUserId;
  final bool isLoadingViewedProfile;
  final bool isCalculatingCompatibility; // Для индикатора загрузки

  final String? geoErrorMessage;

  /// Сообщение для глобального SnackBar (показ ошибок из Cubit без context).
  final String? snackBarMessage;
  final bool snackBarIsError;

  final List<GeomagneticForecast> geomagneticForecast;
  final LoadingState geomagneticForecastStatus;
  final Locale? locale;

  bool get isProUser {
    // Он просто проверяет статус в текущем профиле
    return currentUserProfile?.isProUser ?? false;
  }

  const AppState({
    this.currentUserProfile,
    this.isInitialized = false,
    this.profileLoadingState = LoadingState.idle,
    required this.isReady,
    required this.transitInterpretations,
    this.locale,
    this.jyotishDescriptions = const {},
    this.cosmicEvents = const [], // <-- ДОБАВЬ ЗДЕСЬ
    this.cosmicEventsStatus = LoadingState.idle, // <-- ДОБАВЬ ЗДЕСЬ
    this.dailyForecastLoadingState = LoadingState.initial,
    this.activeChatMessages = const [],
    this.viewedUserPhotos = const [],
    this.viewedUserPhotosStatus = LoadingState.idle,
    this.version = 0,
    this.priorityUsers = const [],
    this.otherUsers = const [],
    this.isSearchLoading = false,
    this.isPaginating = false,
    this.allUsersLoaded = false,
    this.searchText = '',
    this.lastVisibleUserDocument,
    this.likedUserIds = const {},
    this.friends = const [],
    this.friendRequests = const [],
    this.friendshipStatusMap = const {},
    this.isLoadingFriends = false,
    this.chatListItems = const [],
    this.lastCosmicEventsCalculationDate,
    this.aspectInterpretations = const {},
    this.oracleLimitMessage,
    this.newLikesCount = 0,
    this.tarotLimitMessage,
    this.rouletteLimitMessage,
    this.chatError,
    this.searchOffset = 0,
    this.isUpdatingSettings = false,
    this.isProLoading = false,
    this.numerologyCompatibility = const {},
    this.moonRhythm,
    this.moonRhythmStatus = LoadingState.initial,
    this.typingStatuses = const {},
    this.numerologyNumberDescriptions = const {},
    this.numerologyScreenStatus = LoadingState.idle,
    this.channelPreviews = const [],
    this.isLoadingChannelPreviews = false,
    this.unverifiedUserId,
    this.unverifiedUserEmail = '',
    this.isPartnerTyping = false,
    this.totalUnreadCount = 0,
    this.fullTarotDeck = const [],
    this.isTarotDeckLoading = false,
    this.tarotQuestion,
    this.tarotReadingCards = const [],
    this.flippedCardIds = const {}, // <-- Добавьте это
    this.tarotCombinationInterpretation, // <-- Переименуйте tarotInterpretation
    this.tarotReadingState = LoadingState.idle,
    this.channels = const [],
    this.isLoadingChannels = false,
    this.channelListFilter = 'recommended',
    this.channelLanguageFilter = 'my_lang',
    this.activeChannelPosts = const [],
    this.isLoadingPosts = false,
    this.activeChannel,
    this.activePostComments = const [],
    this.searchMode = SearchMode.all,
    this.bioKeywordFilter = '',
    this.countryFilter = '',
    this.cityFilter = '',
    this.cardOfTheDay,
    this.cardOfTheDayStatus = LoadingState.idle,
    this.cardOfTheDayInterpretation,
    this.oracleThemes = const [],
    this.areOracleThemesLoading = false,
    this.profileStatus = ProfileValidationStatus.unknown,
    this.introSeen,
    this.astroCommunicationTips = const {},
    this.isPaginatingPosts = false,
    this.isLoadingLocations = false,
    this.locationSuggestions = const [],
    this.isLoadingComments = false,
    this.isCreatingChannel = false,
    this.channelCreationError,
    this.rouletteState = PartnerRouletteState.idle,
    this.rouletteCandidates = const [],
    this.rouletteWinner,
    this.usersWhoLikedMe = const [],
    this.likesYouLoadingState = LoadingState.idle,
    this.minAgeFilter = 18,
    this.maxAgeFilter = 99,
    this.genderFilter = 'all',
    this.zodiacFilter = ZodiacFilter.all,
    this.partnerOfTheDay,
    this.partnerLoadingState = LoadingState.idle,
    this.horoscopeState = const HoroscopeState(),
    this.oracleAnswer,
    this.isOracleAnswering = false,
    this.isOnboardingComplete = false,
    this.friendRequestCount = 0,
    this.astroDescriptions = const {},
    this.dailyForecast,
    this.isForecastLoading = false,
    this.horoscope,
    this.focusOfTheDay,
    this.focusLoadingState = LoadingState.idle,
    this.focusInterpretations = const {},
    this.hybridForecast,
    this.hybridForecastLoadingState = LoadingState.idle,
    this.compatibilityDescriptions = const {},
    this.isChatListLoading = false,
    this.activeChatId,
    this.isLoadingMessages = false,
    this.activePost, // <-- ДОБАВИТЬ В КОНСТРУКТОР
    // <-- ДОБАВИТЬ В КОНСТРУКТОР
    this.activePostStatus = ChannelStatus.initial,
    this.viewedProfilesCache = const {}, // <-- СТАЛО
    this.currentViewedUserId,
    this.isLoadingViewedProfile = false,
    this.isCalculatingCompatibility = false,
    this.geoErrorMessage,
    this.snackBarMessage,
    this.snackBarIsError = false,
    this.geomagneticForecast = const [],
    this.geomagneticForecastStatus = LoadingState.idle,
    this.searchInitiated = false,
    this.isCardOfTheDayFlipped = false,
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.authStatus = AuthStatus.initial,
    this.authErrorMessage,
    this.palmistryData,
    this.palmistryLoadingState = LoadingState.idle,
  });

  AppState copyWith({
    UserProfileCard? currentUserProfile,
    Map<String, UserProfileCard>? viewedProfilesCache, // <-- СТАЛО
    String? currentViewedUserId,
    bool? isInitialized,
    LoadingState? profileLoadingState,
    Map<String, AspectInterpretation>? aspectInterpretations,
    ProfileValidationStatus? profileStatus,
    bool? isReady,
    bool? isUpdatingSettings,
    int? version,
    int? searchOffset,
    bool? isProLoading,
    Map<String, String>? jyotishDescriptions,
    Map<String, dynamic>? transitInterpretations, // <-- ДОБАВЬ ЗДЕСЬ
    List<CosmicEvent>? cosmicEvents, // <-- ДОБАВЬ ЗДЕСЬ
    LoadingState? cosmicEventsStatus, // <-- ДОБАВЬ ЗДЕСЬ
    Map<String, String>? numerologyCompatibility,
    Locale? locale,
    LoadingState? dailyForecastLoadingState,
    MoonRhythmResponse? moonRhythm,
    LoadingState? moonRhythmStatus,
    Map<String, bool>? typingStatuses,
    Map<String, String>? numerologyNumberDescriptions,
    String? unverifiedUserId,
    String? unverifiedUserEmail,
    List<ChannelPreview>? channelPreviews,
    bool? isLoadingChannelPreviews,
    LoadingState? numerologyScreenStatus,
    List<Map<String, String>>? viewedUserPhotos,
    LoadingState? viewedUserPhotosStatus,
    bool? isPartnerTyping,
    List<UserProfileCard>? priorityUsers,
    List<UserProfileCard>? otherUsers,
    bool? isSearchLoading,
    bool? isPaginating,
    bool? allUsersLoaded,
    SearchMode? searchMode,
    String? bioKeywordFilter,
    String? countryFilter,
    String? cityFilter,
    String? lastCosmicEventsCalculationDate,
    List<OracleTheme>? oracleThemes,
    bool? areOracleThemesLoading,
    ValueWrapper<String?>? oracleLimitMessage,
    int? newLikesCount,
    ValueWrapper<String?>? tarotLimitMessage,
    ValueWrapper<String?>? rouletteLimitMessage,
    ValueWrapper<String?>? chatError,
    bool? introSeen,
    Map<String, Map<String, String>>? numerologyCompatibilityDescriptions,
    String? searchText,
    DocumentSnapshot? lastVisibleUserDocument,
    Set<String>? likedUserIds,
    List<UserProfileCard>? friends,
    List<UserProfileCard>? friendRequests,
    Map<String, FriendshipStatus>? friendshipStatusMap,
    bool? isLoadingFriends,
    PalmistryData? palmistryData,
    LoadingState? palmistryLoadingState,
    Map<String, String>? astroCommunicationTips,
    bool? isChatListLoading,
    int? totalUnreadCount,
    List<TarotCard>? fullTarotDeck,
    bool? isTarotDeckLoading,
    String? tarotQuestion,
    List<TarotCard>? tarotReadingCards,
    Set<int>? flippedCardIds, // <-- Добавьте это
    String? tarotCombinationInterpretation, // <-- Переименуйте
    LoadingState? tarotReadingState,
    List<Channel>? channels,
    bool? isLoadingChannels,
    String? channelListFilter,
    String? channelLanguageFilter,
    Channel? activeChannel,
    List<Post>? activeChannelPosts,
    bool? isLoadingPosts,
    bool? isPaginatingPosts,
    List<Comment>? activePostComments,
    bool? isLoadingComments,
    bool? isCreatingChannel,
    String? channelCreationError,
    PartnerRouletteState? rouletteState,
    List<UserProfileCard>? rouletteCandidates,
    UserProfileCard? rouletteWinner,
    List<UserProfileCard>? usersWhoLikedMe,
    LoadingState? likesYouLoadingState,
    int? minAgeFilter,
    int? maxAgeFilter,
    String? genderFilter,
    ZodiacFilter? zodiacFilter,
    UserProfileCard? partnerOfTheDay,
    LoadingState? partnerLoadingState,
    HoroscopeState? horoscopeState,
    ValueWrapper<String?>? oracleAnswer,
    bool? isOracleAnswering,
    bool? isOnboardingComplete,
    int? friendRequestCount,
    Map<String, dynamic>? astroDescriptions,
    NumerologyReport? numerologyReport,
    Map<String, dynamic>? numerologyTranslations,
    DailyForecast? dailyForecast,
    bool? isForecastLoading,
    DailyHoroscope? horoscope,
    FocusOfTheDay? focusOfTheDay,
    LoadingState? focusLoadingState,
    Map<String, dynamic>? focusInterpretations,
    DailyHybridForecast? hybridForecast,
    LoadingState? hybridForecastLoadingState,
    Map<String, String>? compatibilityDescriptions,
    Post? activePost, // <-- ДОБАВИТЬ В COPYWITH
    // <-- ДОБАВИТЬ В COPYWITH
    ChannelStatus? activePostStatus,
    List<ChatListItem>? chatListItems,
    String? activeChatId,
    // ===== ГЛАВНОЕ ИСПРАВЛЕНИЕ ЗДЕСЬ =====
    // Убираем знак `?`. Теперь copyWith ожидает List<Message>, а не List<Message>?
    List<chat_models.Message>? activeChatMessages,
    // ===================================
    bool? isLoadingMessages,
    TarotCard? cardOfTheDay,
    bool? isCardOfTheDayFlipped,
    LoadingState? cardOfTheDayStatus,
    String? cardOfTheDayInterpretation,
    String? email,
    String? password,
    String? confirmPassword,
    AuthStatus? authStatus,
    String? authErrorMessage,
    bool? isLoadingViewedProfile,
    bool? isCalculatingCompatibility,
    String? geoErrorMessage,
    String? snackBarMessage,
    bool? snackBarIsError,
    bool? clearSnackBar,
    bool? isLoadingLocations,
    List<NominatimSuggestion>? locationSuggestions,
    List<GeomagneticForecast>? geomagneticForecast,
    LoadingState? geomagneticForecastStatus,
    bool? searchInitiated,
  }) {
    return AppState(
      currentUserProfile: currentUserProfile ?? this.currentUserProfile,
      viewedProfilesCache: viewedProfilesCache ?? this.viewedProfilesCache,
      currentViewedUserId: currentViewedUserId ?? this.currentViewedUserId,
      isInitialized: isInitialized ?? this.isInitialized,
      profileLoadingState: profileLoadingState ?? this.profileLoadingState,
      numerologyCompatibility:
          numerologyCompatibility ?? this.numerologyCompatibility,
      searchOffset: searchOffset ?? this.searchOffset,

      viewedUserPhotos: viewedUserPhotos ?? this.viewedUserPhotos,
      viewedUserPhotosStatus:
          viewedUserPhotosStatus ?? this.viewedUserPhotosStatus,
      isUpdatingSettings: isUpdatingSettings ?? this.isUpdatingSettings,
      version: version ?? this.version,
      isProLoading: isProLoading ?? this.isProLoading,
      locale: locale ?? this.locale,
      dailyForecastLoadingState:
          dailyForecastLoadingState ?? this.dailyForecastLoadingState,
      moonRhythm: moonRhythm ?? this.moonRhythm,
      moonRhythmStatus: moonRhythmStatus ?? this.moonRhythmStatus,

      channelPreviews: channelPreviews ?? this.channelPreviews,
      isLoadingChannelPreviews:
          isLoadingChannelPreviews ?? this.isLoadingChannelPreviews,
      unverifiedUserEmail: unverifiedUserEmail ?? this.unverifiedUserEmail,
      numerologyScreenStatus:
          numerologyScreenStatus ?? this.numerologyScreenStatus,
      numerologyNumberDescriptions:
          numerologyNumberDescriptions ?? this.numerologyNumberDescriptions,
      priorityUsers: priorityUsers ?? this.priorityUsers,
      otherUsers: otherUsers ?? this.otherUsers,
      typingStatuses: typingStatuses ?? this.typingStatuses,
      jyotishDescriptions: jyotishDescriptions ?? this.jyotishDescriptions,
      unverifiedUserId: unverifiedUserId ?? this.unverifiedUserId,

      isSearchLoading: isSearchLoading ?? this.isSearchLoading,
      aspectInterpretations:
          aspectInterpretations ?? this.aspectInterpretations,
      isPaginating: isPaginating ?? this.isPaginating,
      allUsersLoaded: allUsersLoaded ?? this.allUsersLoaded,
      searchText: searchText ?? this.searchText,
      lastVisibleUserDocument:
          lastVisibleUserDocument ?? this.lastVisibleUserDocument,
      likedUserIds: likedUserIds ?? this.likedUserIds,
      friends: friends ?? this.friends,
      friendRequests: friendRequests ?? this.friendRequests,
      friendshipStatusMap: friendshipStatusMap ?? this.friendshipStatusMap,
      isLoadingFriends: isLoadingFriends ?? this.isLoadingFriends,
      email: email ?? this.email,
      isReady: isReady ?? this.isReady,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      authStatus: authStatus ?? this.authStatus,
      authErrorMessage: authErrorMessage ?? this.authErrorMessage,
      oracleThemes: oracleThemes ?? this.oracleThemes,
      areOracleThemesLoading:
          areOracleThemesLoading ?? this.areOracleThemesLoading,
      chatError: chatError != null ? chatError.value : this.chatError,

      isChatListLoading: isChatListLoading ?? this.isChatListLoading,
      totalUnreadCount: totalUnreadCount ?? this.totalUnreadCount,
      fullTarotDeck: fullTarotDeck ?? this.fullTarotDeck,
      isTarotDeckLoading: isTarotDeckLoading ?? this.isTarotDeckLoading,
      tarotQuestion: tarotQuestion ?? this.tarotQuestion,
      tarotReadingCards: tarotReadingCards ?? this.tarotReadingCards,
      flippedCardIds: flippedCardIds ?? this.flippedCardIds, // <-- Добавьте это
      tarotCombinationInterpretation: tarotCombinationInterpretation ??
          this.tarotCombinationInterpretation, // <-- Переименуйте
      tarotReadingState: tarotReadingState ?? this.tarotReadingState,
      cosmicEvents: cosmicEvents ?? this.cosmicEvents,
      cosmicEventsStatus: cosmicEventsStatus ?? this.cosmicEventsStatus,
      oracleLimitMessage: oracleLimitMessage ?? this.oracleLimitMessage,
      tarotLimitMessage: tarotLimitMessage ?? this.tarotLimitMessage,
      rouletteLimitMessage: rouletteLimitMessage ?? this.rouletteLimitMessage,
      profileStatus: profileStatus ?? this.profileStatus,
      transitInterpretations:
          transitInterpretations ?? this.transitInterpretations,
      isPartnerTyping:
          isPartnerTyping ?? this.isPartnerTyping, // <-- ДОБАВЬ ЗДЕСЬ

      channels: channels ?? this.channels,
      isLoadingChannels: isLoadingChannels ?? this.isLoadingChannels,
      channelListFilter: channelListFilter ?? this.channelListFilter,
      channelLanguageFilter:
          channelLanguageFilter ?? this.channelLanguageFilter,
      activeChannelPosts: activeChannelPosts ?? this.activeChannelPosts,
      isLoadingPosts: isLoadingPosts ?? this.isLoadingPosts,
      activeChannel: activeChannel ?? this.activeChannel,
      lastCosmicEventsCalculationDate: lastCosmicEventsCalculationDate ??
          this.lastCosmicEventsCalculationDate,
      newLikesCount: newLikesCount ?? this.newLikesCount,
      introSeen: introSeen ?? this.introSeen,
      palmistryData: palmistryData ?? this.palmistryData,
      palmistryLoadingState:
          palmistryLoadingState ?? this.palmistryLoadingState,

      isPaginatingPosts: isPaginatingPosts ?? this.isPaginatingPosts,
      isLoadingComments: isLoadingComments ?? this.isLoadingComments,
      isCreatingChannel: isCreatingChannel ?? this.isCreatingChannel,
      channelCreationError: channelCreationError ?? this.channelCreationError,

      rouletteState: rouletteState ?? this.rouletteState,
      rouletteCandidates: rouletteCandidates ?? this.rouletteCandidates,
      rouletteWinner: rouletteWinner ?? this.rouletteWinner,
      usersWhoLikedMe: usersWhoLikedMe ?? this.usersWhoLikedMe,
      likesYouLoadingState: likesYouLoadingState ?? this.likesYouLoadingState,
      minAgeFilter: minAgeFilter ?? this.minAgeFilter,
      maxAgeFilter: maxAgeFilter ?? this.maxAgeFilter,
      genderFilter: genderFilter ?? this.genderFilter,
      zodiacFilter: zodiacFilter ?? this.zodiacFilter,
      partnerOfTheDay: partnerOfTheDay ?? this.partnerOfTheDay,
      partnerLoadingState: partnerLoadingState ?? this.partnerLoadingState,
      horoscopeState: horoscopeState ?? this.horoscopeState,
      oracleAnswer:
          oracleAnswer != null ? oracleAnswer.value : this.oracleAnswer,

      isOracleAnswering: isOracleAnswering ?? this.isOracleAnswering,
      isOnboardingComplete: isOnboardingComplete ?? this.isOnboardingComplete,
      friendRequestCount: friendRequestCount ?? this.friendRequestCount,
      astroDescriptions: astroDescriptions ?? this.astroDescriptions,

      dailyForecast: dailyForecast ?? this.dailyForecast,
      astroCommunicationTips:
          astroCommunicationTips ?? this.astroCommunicationTips,
      isForecastLoading: isForecastLoading ?? this.isForecastLoading,
      horoscope: horoscope ?? this.horoscope,
      focusOfTheDay: focusOfTheDay ?? this.focusOfTheDay,
      focusLoadingState: focusLoadingState ?? this.focusLoadingState,
      focusInterpretations: focusInterpretations ?? this.focusInterpretations,
      hybridForecast: hybridForecast ?? this.hybridForecast,
      hybridForecastLoadingState:
          hybridForecastLoadingState ?? this.hybridForecastLoadingState,
      compatibilityDescriptions:
          compatibilityDescriptions ?? this.compatibilityDescriptions,
      activePost: activePost ?? this.activePost,
      activePostComments: activePostComments ?? this.activePostComments,
      activePostStatus: activePostStatus ?? this.activePostStatus,

      isLoadingViewedProfile:
          isLoadingViewedProfile ?? this.isLoadingViewedProfile,
      isCalculatingCompatibility:
          isCalculatingCompatibility ?? this.isCalculatingCompatibility,
      geoErrorMessage: geoErrorMessage,
      snackBarMessage: (clearSnackBar == true) ? null : (snackBarMessage ?? this.snackBarMessage),
      snackBarIsError: (clearSnackBar == true) ? false : (snackBarIsError ?? this.snackBarIsError),
      chatListItems: chatListItems ?? this.chatListItems,

      activeChatId: activeChatId ?? this.activeChatId,
      activeChatMessages: activeChatMessages ?? this.activeChatMessages,
      isLoadingMessages: isLoadingMessages ?? this.isLoadingMessages,
      geomagneticForecast: geomagneticForecast ?? this.geomagneticForecast,
      geomagneticForecastStatus:
          geomagneticForecastStatus ?? this.geomagneticForecastStatus,
      cardOfTheDay: cardOfTheDay ?? this.cardOfTheDay,
      isCardOfTheDayFlipped:
          isCardOfTheDayFlipped ?? this.isCardOfTheDayFlipped,
      cardOfTheDayStatus: cardOfTheDayStatus ?? this.cardOfTheDayStatus,
      cardOfTheDayInterpretation:
          cardOfTheDayInterpretation ?? this.cardOfTheDayInterpretation,
      isLoadingLocations: isLoadingLocations ?? this.isLoadingLocations,
      locationSuggestions: locationSuggestions ?? this.locationSuggestions,
    );
  }

  // === 3. ДОБАВЬ ЭТОТ ГЕТТЕР ===

  // ============================
  AppState clearGeoError() {
    // Мы просто создаем копию ТЕКУЩЕГО состояния,
    // но с одним измененным полем.
    return copyWith(
      geoErrorMessage: null,
    );
  }

  UserProfileCard? get currentViewedProfile {
    if (currentViewedUserId == null) {
      return null;
    }
    return viewedProfilesCache[currentViewedUserId];
  }

  @override
  List<Object?> get props => [
        currentUserProfile, isInitialized, profileLoadingState, locale,
        numerologyScreenStatus, isPartnerTyping, searchOffset,
        priorityUsers,
        otherUsers, isSearchLoading, isPaginating, allUsersLoaded, searchText,
        lastVisibleUserDocument, likedUserIds,
        friends, friendRequests, friendshipStatusMap, isLoadingFriends,
        chatListItems, isChatListLoading, totalUnreadCount,
        fullTarotDeck, isTarotDeckLoading, tarotQuestion, tarotReadingCards,
        flippedCardIds, tarotCombinationInterpretation, tarotReadingState,
        channels, isLoadingChannels, channelListFilter, channelLanguageFilter,
        activeChannelPosts, isLoadingPosts, activePostComments,
        isLoadingComments, numerologyNumberDescriptions,
        isCreatingChannel, channelCreationError,
        rouletteState, rouletteCandidates, rouletteWinner,
        usersWhoLikedMe, likesYouLoadingState, jyotishDescriptions,
        minAgeFilter, maxAgeFilter, genderFilter, zodiacFilter, version,
        partnerOfTheDay, partnerLoadingState, moonRhythm, unverifiedUserId,
        moonRhythmStatus, channelPreviews,
        isLoadingChannelPreviews,
        horoscopeState, oracleAnswer, isOracleAnswering,
        isOnboardingComplete, friendRequestCount, astroCommunicationTips,
        astroDescriptions, transitInterpretations, introSeen,
        dailyForecast, isForecastLoading, horoscope,
        focusOfTheDay, focusLoadingState, focusInterpretations, typingStatuses,
        hybridForecast,
        hybridForecastLoadingState,
        profileStatus,
        transitInterpretations,
        dailyForecastLoadingState,
        unverifiedUserEmail, // <-- ДОБАВЬ ЗДЕСЬ
        // <-- ДОБАВЬ ЗДЕСЬ

        compatibilityDescriptions, isPaginatingPosts, activeChannel,
        isUpdatingSettings,
        activePost,
        activePostStatus,
        currentViewedUserId,
        lastCosmicEventsCalculationDate,
        oracleLimitMessage,
        newLikesCount,
        tarotLimitMessage,
        rouletteLimitMessage,
        // --- Вот наши новые поля ---
        viewedProfilesCache, isProLoading,
        // --- Старые поля, относящиеся к этому экрану ---
        isLoadingViewedProfile, isCalculatingCompatibility,
        numerologyCompatibility,
        geoErrorMessage,
        snackBarMessage,
        snackBarIsError,
        activeChatId,
        activeChatMessages,
        isLoadingMessages,
        geomagneticForecast,
        geomagneticForecastStatus,
        cardOfTheDay,
        cardOfTheDayStatus,
        cardOfTheDayInterpretation,
        searchInitiated, isCardOfTheDayFlipped, email, password,
        confirmPassword, authStatus, cosmicEvents,
        cosmicEventsStatus,
        aspectInterpretations,
        oracleThemes,
        areOracleThemesLoading,
        chatError,
        palmistryData,
        palmistryLoadingState,
        viewedUserPhotos,
        viewedUserPhotosStatus,
      ];
}
