// lib/main.dart

import 'dart:ui' show PlatformDispatcher;
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:logger/logger.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:window_manager/window_manager.dart';

// Твои импорты
import 'package:lovequest/cubit/numerology_cubit.dart';
import 'package:lovequest/repositories/api_repository.dart';
import 'package:lovequest/repositories/auth_repository.dart';
import 'package:lovequest/repositories/firestore_repository.dart';
import 'package:lovequest/services/cloudinary_service.dart';
import 'package:lovequest/services/logger_service.dart';
import 'package:lovequest/services/natal_chart_calculator.dart';
import 'package:lovequest/services/localization_service.dart';

import 'app.dart'; // В этом файле живет класс MyApp
import 'cubit/app_cubit.dart';
import 'cubit/onboarding_cubit.dart';
import 'cubit/app_state.dart';
import 'firebase_options.dart';

// Для Windows (оставляем как было, на мобилках не мешает)
final requestCloseNotifier = ValueNotifier<bool>(false);

class MyWindowListener extends WindowListener {
  @override
  void onWindowClose() {
    requestCloseNotifier.value = true;
  }
}

class SimpleBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (bloc is AppCubit) {
      // Логирование изменений стейта
    }
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('>>> BLOC OBSERVER ERROR in ${bloc.runtimeType}: $error');
    FirebaseCrashlytics.instance.recordError(error, stackTrace,
        reason: 'BLOC: ${bloc.runtimeType}', fatal: false);
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> main() async {
  Bloc.observer = SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Crashlytics: перехват фатальных ошибок Flutter (в release — без лишнего шума)
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    FirebaseCrashlytics.instance.recordFlutterFatalError(details);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  await LocalizationService.instance.initialize();

  // OneSignal: ID из --dart-define=ONESIGNAL_APP_ID=... или значение по умолчанию (не коммитить в публичный репо!)
  const oneSignalAppId = String.fromEnvironment('ONESIGNAL_APP_ID',
      defaultValue: 'e13b7721-c57d-474e-9885-b680f59013cf');
  if (!kIsWeb &&
      (Platform.isAndroid || Platform.isIOS) &&
      oneSignalAppId.isNotEmpty) {
    logger.d("--- Инициализация OneSignal для Mobile ---");
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    OneSignal.initialize(oneSignalAppId);
    OneSignal.Notifications.requestPermission(true);
  }

  // Инициализация Windows
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = const WindowOptions(
        size: Size(1280, 720),
        center: true,
        backgroundColor: Colors.transparent,
        skipTaskbar: false,
        titleBarStyle: TitleBarStyle.normal,
        title: "Aryonika");
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
    await windowManager.setPreventClose(true);
    windowManager.addListener(MyWindowListener());
  }

  final authRepository = AuthRepository(firebaseAuth: FirebaseAuth.instance);
  final apiRepository = ApiRepository(); // Используем Singleton
  final cloudinaryService = CloudinaryService();
  final chartCalculator = NatalChartCalculator();
  final firestoreRepository = FirestoreRepository();

  final appCubit = await AppCubit.create(
    authRepository: authRepository,
    firestoreRepository: firestoreRepository,
    chartCalculator: chartCalculator,
  );

  if (kReleaseMode) {
    Logger.level = Level.nothing;
  } else {
    Logger.level = Level.debug;
  }

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: authRepository),
        RepositoryProvider.value(value: apiRepository),
        RepositoryProvider.value(value: cloudinaryService),
        RepositoryProvider.value(value: firestoreRepository),
        RepositoryProvider.value(value: chartCalculator),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: appCubit),
          BlocProvider<NumerologyCubit>(
            create: (context) => NumerologyCubit(
              appCubit: context.read<AppCubit>(),
              apiRepository: context.read<ApiRepository>(),
            ),
          ),
          BlocProvider<OnboardingCubit>(
            create: (context) =>
                OnboardingCubit(appCubit: context.read<AppCubit>()),
          ),
        ],
        // ВАЖНО: Запускаем MyApp напрямую. Это чинит свайп назад.
        child: const MyApp(),
      ),
    ),
  );
}
