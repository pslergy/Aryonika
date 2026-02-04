// lib/app.dart

import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovequest/cubit/app_cubit.dart';
import 'package:lovequest/cubit/app_state.dart';
import 'package:lovequest/l10n/generated/app_localizations.dart';

import 'package:lovequest/repositories/api_repository.dart';
import 'package:lovequest/screens/auth/verify_email_screen.dart';
import 'package:lovequest/screens/auth/welcome_screen.dart';
import 'package:lovequest/screens/auth_wrapper_screen.dart';
import 'package:lovequest/screens/card_of_the_day_screen.dart';
import 'package:lovequest/screens/channel_settings_screen.dart';
import 'package:lovequest/screens/cosmic_events_screen.dart';
import 'package:lovequest/screens/feed_screen.dart';
import 'package:lovequest/screens/games_placeholder_screen.dart';
import 'package:lovequest/screens/intro_screen.dart';
import 'package:lovequest/screens/jyotish_compatibility_screen.dart';
import 'package:lovequest/screens/legal/legal_document_screen.dart';
import 'package:lovequest/screens/likes_you_screen.dart';
import 'package:lovequest/screens/location_selection_screen.dart';
import 'package:lovequest/screens/moderation_screen.dart';
import 'package:lovequest/screens/numerology_compatibility_screen.dart';
import 'package:lovequest/screens/numerology_screen.dart';
import 'package:lovequest/screens/palmistry_analysis_screen.dart';
import 'package:lovequest/screens/palmistry_report_screen.dart';
import 'package:lovequest/screens/payment_screen.dart';
import 'package:lovequest/screens/paywall_screen.dart';
import 'package:lovequest/screens/photo_album_screen.dart';
import 'package:lovequest/screens/referral_screen.dart';

import 'package:lovequest/screens/channel_detail_screen.dart';
import 'package:lovequest/screens/comments_screen.dart';
import 'package:lovequest/screens/compatibility_report_screen.dart';
import 'package:lovequest/screens/create_channel_screen.dart';
import 'package:lovequest/screens/edit_profile_screen.dart';
import 'package:lovequest/screens/forecast_screen.dart';
import 'package:lovequest/screens/horoscope_screen.dart';
import 'package:lovequest/screens/main_screen.dart';
import 'package:lovequest/screens/auth/login_screen.dart';
import 'package:lovequest/screens/auth/register_screen.dart';
import 'package:lovequest/screens/manual_compatibility_screen.dart';
import 'package:lovequest/screens/onboarding/onboarding_name_screen.dart';
import 'package:lovequest/screens/onboarding/onboarding_birthdate_screen.dart';
import 'package:lovequest/screens/onboarding/onboarding_gender_screen.dart';
import 'package:lovequest/screens/onboarding/onboarding_time_screen.dart';
import 'package:lovequest/screens/onboarding/onboarding_manual_location_screen.dart';
import 'package:lovequest/screens/onboarding/onboarding_finish_screen.dart';
import 'package:lovequest/screens/chat_list_screen.dart';
import 'package:lovequest/screens/profile_settings_screen.dart';
import 'package:lovequest/screens/roulette_screen.dart';
import 'package:lovequest/screens/search_screen.dart';
import 'package:lovequest/screens/oracle_screen.dart';
import 'package:lovequest/screens/friends_screen.dart';
import 'package:lovequest/screens/channels_screen.dart';
import 'package:lovequest/screens/profile_screen.dart';
import 'package:lovequest/screens/user_profile_screen.dart';
import 'package:lovequest/screens/chat_screen.dart';
import 'package:lovequest/screens/star_map_screen.dart';

import 'package:lovequest/services/cloudinary_service.dart';

import 'cubit/channel_cubit.dart';

import 'screens/auth/reset_password_screen.dart';
import 'screens/bazi_compatibility_screen.dart';
import 'screens/chinese_zodiac_compatibility_screen.dart';

// --- 1. КЛАСС-ПОМОЩНИК ---
class GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription<AppState> _subscription;

  GoRouterRefreshStream(AppCubit appCubit) {
    _subscription = appCubit.stream.listen((_) {
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

// --- 2. ВИДЖЕТ-СЛУШАТЕЛЬ ДЛЯ ЛОКАЛИЗАЦИИ ---
class LocaleListener extends StatefulWidget {
  final Widget child;
  const LocaleListener({super.key, required this.child});

  @override
  State<LocaleListener> createState() => _LocaleListenerState();
}

class _LocaleListenerState extends State<LocaleListener> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final locale = Localizations.localeOf(context);
    context.read<AppCubit>().setLocale(locale);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

// --- 3. ГЛАВНЫЙ ВИДЖЕТ ---
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    final appCubit = context.read<AppCubit>();
    final shellNavigatorKey = GlobalKey<NavigatorState>();

    _router = GoRouter(
      navigatorKey: MyApp.navigatorKey,
      initialLocation: '/',
      refreshListenable: GoRouterRefreshStream(appCubit),
      routes: [
        // --- 1. АВТОРИЗАЦИЯ И ONBOARDING (В корне) ---
        GoRoute(path: '/intro', builder: (context, state) => const IntroScreen()),
        GoRoute(path: '/', builder: (context, state) => const AuthWrapperScreen()),
        GoRoute(path: '/welcome', builder: (context, state) => const WelcomeScreen()),
        GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
        GoRoute(path: '/register', builder: (context, state) => const RegisterScreen()),
        GoRoute(path: '/verify-email', builder: (context, state) => const VerifyEmailScreen()),

        GoRoute(
          path: '/reset-password',
          builder: (context, state) {
            final token = state.uri.queryParameters['token'];
            if (token != null) return ResetPasswordScreen(token: token);
            return const LoginScreen();
          },
        ),

        // Legal Docs
        GoRoute(
          path: '/privacy-policy',
          builder: (context, state) {
            final l10n = AppLocalizations.of(context)!;
            final locale = Localizations.localeOf(context).languageCode;
            String assetPath = 'assets/docs/privacy_policy_$locale.md';
            if (!['en', 'ru'].contains(locale)) assetPath = 'assets/docs/privacy_policy_en.md';
            return LegalDocumentScreen(title: l10n.privacyPolicyLink, assetPath: assetPath);
          },
        ),
        GoRoute(
          path: '/terms-of-use',
          builder: (context, state) {
            final l10n = AppLocalizations.of(context)!;
            final locale = Localizations.localeOf(context).languageCode;
            String assetPath = 'assets/docs/terms_of_use_$locale.md';
            if (!['en', 'ru'].contains(locale)) assetPath = 'assets/docs/terms_of_use_en.md';
            return LegalDocumentScreen(title: l10n.termsOfUseLink, assetPath: assetPath);
          },
        ),
        GoRoute(
          path: '/offer-agreement',
          builder: (context, state) {
            final locale = Localizations.localeOf(context).languageCode;
            String assetPath = 'assets/docs/offer-agreement_$locale.md';
            if (!['en', 'ru'].contains(locale)) assetPath = 'assets/docs/offer-agreement_en.md';
            return LegalDocumentScreen(title: "Договор оферты", assetPath: assetPath);
          },
        ),

        // Onboarding Pages
        GoRoute(path: '/onboarding/name', pageBuilder: (context, state) => const NoTransitionPage(child: OnboardingNameScreen())),
        GoRoute(path: '/onboarding/birthdate', pageBuilder: (context, state) => const NoTransitionPage(child: OnboardingBirthdateScreen())),
        GoRoute(path: '/onboarding/gender', pageBuilder: (context, state) => const NoTransitionPage(child: OnboardingGenderScreen())),
        GoRoute(path: '/onboarding/time', pageBuilder: (context, state) => const NoTransitionPage(child: OnboardingTimeScreen())),
        GoRoute(path: '/onboarding/location', pageBuilder: (context, state) => const NoTransitionPage(child: OnboardingManualLocationScreen())),
        GoRoute(path: '/onboarding/finish', pageBuilder: (context, state) => const NoTransitionPage(child: OnboardingFinishScreen())),


        // --- 2. ДЕТАЛЬНЫЕ ЭКРАНЫ (ВЫНЕСЕНЫ В КОРЕНЬ ДЛЯ СВАЙПА) ---
        // Эти экраны открываются поверх всего, и свайп работает корректно.

        GoRoute(
          path: '/user_profile/:userId',
          parentNavigatorKey: MyApp.navigatorKey,
          pageBuilder: (context, state) {
            final userId = state.pathParameters['userId']!;
            String? iceBreaker;
            if (state.extra is String) iceBreaker = state.extra as String?;

            return CupertinoPage(
              child: UserProfileScreen(
                key: ValueKey(userId),
                userId: userId,
                iceBreaker: iceBreaker,
              ),
            );
          },
        ),

        GoRoute(
          path: '/chat/:chatId',
          parentNavigatorKey: MyApp.navigatorKey,
          pageBuilder: (context, state) {
            final chatId = state.pathParameters['chatId']!;
            final extra = state.extra;
            final initialMessage = extra is String ? extra : null;

            // Используем CupertinoPage, она имеет встроенную поддержку свайпа
            return CupertinoPage(
              child: ChatScreenProvider(
                key: ValueKey(chatId),
                chatId: chatId,
                initialMessage: initialMessage,
              ),
            );
          },
        ),

        GoRoute(
          path: '/comments/:channelId/:postId',
          parentNavigatorKey: MyApp.navigatorKey,
          builder: (context, state) {
            final channelId = state.pathParameters['channelId']!;
            final postId = state.pathParameters['postId']!;
            return BlocProvider(
              create: (context) => ChannelCubit(
                apiRepository: context.read<ApiRepository>(),
                cloudinaryService: context.read<CloudinaryService>(),
                channelId: channelId,
              )..loadCommentsForPost(postId),
              child: CommentsScreen(channelId: channelId, postId: postId),
            );
          },
        ),

        GoRoute(
          path: '/channel-details/:channelId',
          name: 'channel_detail',
          parentNavigatorKey: MyApp.navigatorKey,
          builder: (context, state) {
            final channelId = state.pathParameters['channelId']!;
            return BlocProvider(
              create: (context) => ChannelCubit(
                apiRepository: context.read<ApiRepository>(),
                cloudinaryService: context.read<CloudinaryService>(),
                channelId: channelId,
              )..loadInitialData(),
              child: ChannelDetailScreen(channelId: channelId),
            );
          },
        ),

        GoRoute(
          path: '/referral',
          builder: (context, state) => const ReferralScreen(),
        ),

        GoRoute(
          path: '/channel-settings/:channelId',
          parentNavigatorKey: MyApp.navigatorKey,
          builder: (context, state) {
            final channelId = state.pathParameters['channelId']!;
            return BlocProvider(
              create: (context) => ChannelCubit(
                apiRepository: context.read<ApiRepository>(),
                cloudinaryService: context.read<CloudinaryService>(),
                channelId: channelId,
              )..loadInitialData(),
              child: ChannelSettingsScreen(channelId: channelId),
            );
          },
        ),

        GoRoute(
          path: '/channel-moderation/:channelId',
          parentNavigatorKey: MyApp.navigatorKey,
          builder: (context, state) {
            final channelId = state.pathParameters['channelId']!;
            return BlocProvider(
              create: (context) => ChannelCubit(
                apiRepository: context.read<ApiRepository>(),
                cloudinaryService: context.read<CloudinaryService>(),
                channelId: channelId,
              ),
              child: ChannelModerationScreen(channelId: channelId),
            );
          },
        ),

        GoRoute(path: '/profile/settings', parentNavigatorKey: MyApp.navigatorKey, builder: (context, state) => const ProfileSettingsScreen()),
        GoRoute(path: '/profile/edit', parentNavigatorKey: MyApp.navigatorKey, builder: (context, state) => const EditProfileScreen()),
        GoRoute(path: '/profile/likes-you', parentNavigatorKey: MyApp.navigatorKey, builder: (context, state) => const LikesYouScreen()),
        GoRoute(path: '/profile/games', parentNavigatorKey: MyApp.navigatorKey, builder: (context, state) => const GamesPlaceholderScreen()),
        GoRoute(path: '/profile/referral', parentNavigatorKey: MyApp.navigatorKey, builder: (context, state) => const ReferralScreen()),
        GoRoute(path: '/paywall', parentNavigatorKey: MyApp.navigatorKey, builder: (context, state) => const PaywallScreen()),
        GoRoute(path: '/forecast', parentNavigatorKey: MyApp.navigatorKey, builder: (context, state) => const ForecastScreen()),
        GoRoute(path: '/card-of-the-day', parentNavigatorKey: MyApp.navigatorKey, builder: (context, state) => const CardOfTheDayScreen()),
        GoRoute(path: '/cosmic-events', parentNavigatorKey: MyApp.navigatorKey, builder: (context, state) => const CosmicEventsScreen()),
        GoRoute(path: '/horoscope', parentNavigatorKey: MyApp.navigatorKey, builder: (context, state) => const HoroscopeScreen()),
        GoRoute(path: '/palmistry_report', parentNavigatorKey: MyApp.navigatorKey, builder: (context, state) => const PalmistryReportScreen()),
        GoRoute(path: '/palmistry', parentNavigatorKey: MyApp.navigatorKey, builder: (context, state) => const PalmistryAnalysisScreen()),
        GoRoute(path: '/star_map', parentNavigatorKey: MyApp.navigatorKey, builder: (context, state) => const StarMapScreen()),
        GoRoute(path: '/roulette', parentNavigatorKey: MyApp.navigatorKey, builder: (context, state) => const RouletteScreen()),
        GoRoute(path: '/manual_compatibility', parentNavigatorKey: MyApp.navigatorKey, builder: (context, state) => const ManualCompatibilityScreenProvider()),
        GoRoute(path: '/create_channel', parentNavigatorKey: MyApp.navigatorKey, builder: (context, state) => const CreateChannelScreen()),
        GoRoute(path: '/select-location', parentNavigatorKey: MyApp.navigatorKey, builder: (context, state) => const LocationSelectionScreen()),

        GoRoute(
          path: '/album/:userId',
          parentNavigatorKey: MyApp.navigatorKey,
          builder: (context, state) {
            final userId = state.pathParameters['userId']!;
            return PhotoAlbumScreen(userId: userId);
          },
        ),

        GoRoute(
          path: '/compatibility/:partnerId',
          parentNavigatorKey: MyApp.navigatorKey,
          builder: (context, state) {
            final l10n = AppLocalizations.of(context)!;
            final partnerId = state.pathParameters['partnerId'];
            if (partnerId == null || partnerId.isEmpty) return Scaffold(body: Center(child: Text(l10n.partnerIdError)));
            return CompatibilityReportScreen(partnerId: partnerId);
          },
        ),

        GoRoute(path: '/chinese_zodiac_compatibility/:partnerId', parentNavigatorKey: MyApp.navigatorKey, builder: (context, state) {
          final partnerId = state.pathParameters['partnerId']!;
          return ChineseZodiacCompatibilityScreen(partnerId: partnerId);
        }),
        GoRoute(path: '/bazi_compatibility/:partnerId', parentNavigatorKey: MyApp.navigatorKey, builder: (context, state) {
          final partnerId = state.pathParameters['partnerId']!;
          return BaziCompatibilityScreen(partnerId: partnerId);
        }),
        GoRoute(path: '/jyotish_compatibility/:userId', parentNavigatorKey: MyApp.navigatorKey, builder: (context, state) {
          final userId = state.pathParameters['userId']!;
          return JyotishCompatibilityScreen(userId: userId);
        }),
        GoRoute(path: '/numerology', parentNavigatorKey: MyApp.navigatorKey, builder: (context, state) => const NumerologyScreen(partnerId: '')),
        GoRoute(
          path: '/numerology-compatibility/:partnerId',
          parentNavigatorKey: MyApp.navigatorKey,
          pageBuilder: (context, state) {
            final partnerId = state.pathParameters['partnerId'];
            if (partnerId == null) return const MaterialPage(child: Scaffold(body: Center(child: Text('Error: Partner ID missing'))));
            return MaterialPage(child: NumerologyCompatibilityScreenWrapper(partnerId: partnerId));
          },
        ),
        GoRoute(
          path: '/payment',
          parentNavigatorKey: MyApp.navigatorKey,
          builder: (context, state) {
            final l10n = AppLocalizations.of(context)!;
            final url = state.extra as String?;
            if (url == null) return Scaffold(body: Center(child: Text(l10n.paymentUrlError)));
            return PaymentScreen(paymentUrl: url);
          },
        ),


        // --- 3. НИЖНЯЯ НАВИГАЦИЯ (ShellRoute) ---
        ShellRoute(
          navigatorKey: shellNavigatorKey,
          pageBuilder: (context, state, child) => NoTransitionPage(
            key: state.pageKey,
            child: MainScreen(child: child),
          ),
          routes: [
            GoRoute(path: '/feed', builder: (context, state) => const FeedScreenProvider()),
            GoRoute(path: '/chats', builder: (context, state) => const ChatListScreen()),
            GoRoute(path: '/search', builder: (context, state) => const SearchScreen()),
            GoRoute(
              path: '/oracle',
              builder: (context, state) {
                final focusParam = state.uri.queryParameters['focus'];
                OracleFocus initialFocus = OracleFocus.horoscope;
                // Простая логика парсинга
                if (focusParam == 'cardOfTheDay') initialFocus = OracleFocus.cardOfTheDay;
                else if (focusParam == 'focusOfTheDay') initialFocus = OracleFocus.focusOfTheDay;
                else if (focusParam == 'dailyForecast') initialFocus = OracleFocus.dailyForecast;
                else if (focusParam == 'partner') initialFocus = OracleFocus.partner;
                else if (focusParam == 'roulette') initialFocus = OracleFocus.roulette;
                else if (focusParam == 'duet') initialFocus = OracleFocus.duet;
                else if (focusParam == 'geomagnetic') initialFocus = OracleFocus.geomagnetic;
                else if (focusParam == 'oracleQuestion') initialFocus = OracleFocus.oracleQuestion;
                else if (focusParam == 'tarotQuestion') initialFocus = OracleFocus.tarotQuestion;
                else if (focusParam == 'palmistry') initialFocus = OracleFocus.palmistry;

                return OracleScreen(initialFocus: initialFocus);
              },
            ),
            GoRoute(path: '/friends', builder: (context, state) => const FriendsScreen()),
            GoRoute(path: '/channels', builder: (context, state) => const ChannelsScreen()),
            GoRoute(path: '/profile', builder: (context, state) => const ProfileScreen()),
          ],
        ),
      ],

      // --- 4. REDIRECT ---
      redirect: (BuildContext context, GoRouterState state) {
        final appState = context.read<AppCubit>().state;
        final location = state.matchedLocation;

        if (!appState.isReady) return '/';
        if (appState.authStatus == AuthStatus.awaitingVerification) return location == '/verify-email' ? null : '/verify-email';
        if (appState.introSeen != true) return location == '/intro' ? null : '/intro';

        final isLoggedIn = appState.currentUserProfile != null;
        final hasCompletedOnboarding = appState.isOnboardingComplete;

        final authRoutes = ['/welcome', '/login', '/register', '/privacy-policy', '/terms-of-use', '/offer-agreement'];

        if (!isLoggedIn) {
          return authRoutes.contains(location) ? null : '/welcome';
        }

        if (!hasCompletedOnboarding) {
          return location.startsWith('/onboarding') ? null : '/onboarding/name';
        }

        final staleRoutes = ['/', '/intro', '/welcome', '/login', '/register'];
        if (staleRoutes.contains(location) || location.startsWith('/onboarding')) {
          return '/feed';
        }

        return null;
      },
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) appCubit.setRouter(_router);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appName,

      // --- ВКЛЮЧАЕМ СВАЙПЫ ---
      theme: ThemeData.dark().copyWith(
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),

      routerConfig: _router,
      builder: (context, child) => LocaleListener(
        child: BlocListener<AppCubit, AppState>(
          listenWhen: (prev, curr) => curr.snackBarMessage != null && curr.snackBarMessage != prev.snackBarMessage,
          listener: (context, state) {
            final message = state.snackBarMessage;
            if (message == null) return;
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(message),
                  backgroundColor: state.snackBarIsError ? Colors.redAccent : Colors.green,
                ),
              );
            context.read<AppCubit>().clearSnackBarMessage();
          },
          child: child!,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onWindowClose() {
    SystemNavigator.pop();
  }
}