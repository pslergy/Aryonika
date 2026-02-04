import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('hi'),
    Locale('ko'),
    Locale('ru'),
    Locale('zh')
  ];

  /// No description provided for @profileCreationErrorTitle.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка создания профиля'**
  String get profileCreationErrorTitle;

  /// No description provided for @profileCreationErrorDescription.
  ///
  /// In ru, this message translates to:
  /// **'К сожалению, при сохранении ваших данных произошел сбой. Пожалуйста, попробуйте пройти регистрацию еще раз.'**
  String get profileCreationErrorDescription;

  /// No description provided for @tryAgain.
  ///
  /// In ru, this message translates to:
  /// **'Попробовать снова'**
  String get tryAgain;

  /// No description provided for @connectingHearts.
  ///
  /// In ru, this message translates to:
  /// **'Соединяем сердца во Вселенной...'**
  String get connectingHearts;

  /// No description provided for @appName.
  ///
  /// In ru, this message translates to:
  /// **'Aryonika'**
  String get appName;

  /// No description provided for @exitConfirmationTitle.
  ///
  /// In ru, this message translates to:
  /// **'Подтверждение'**
  String get exitConfirmationTitle;

  /// No description provided for @exitConfirmationContent.
  ///
  /// In ru, this message translates to:
  /// **'Вы уверены, что хотите закрыть Aryonika?'**
  String get exitConfirmationContent;

  /// No description provided for @cancel.
  ///
  /// In ru, this message translates to:
  /// **'Отмена'**
  String get cancel;

  /// No description provided for @close.
  ///
  /// In ru, this message translates to:
  /// **'Закрыть'**
  String get close;

  /// No description provided for @paymentUrlError.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка: URL для оплаты не найден.'**
  String get paymentUrlError;

  /// No description provided for @channelIdError.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка: ID канала не найден.'**
  String get channelIdError;

  /// No description provided for @documentLoadError.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка загрузки документа: {error}'**
  String documentLoadError(Object error);

  /// No description provided for @partnerIdError.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка: Необходим ID партнера для расчета совместимости.'**
  String get partnerIdError;

  /// No description provided for @bioPlaceholder.
  ///
  /// In ru, this message translates to:
  /// **'Здесь могла бы быть ваша история...'**
  String get bioPlaceholder;

  /// No description provided for @photoAlbumTitle.
  ///
  /// In ru, this message translates to:
  /// **'Фотоальбом ({photoCount})'**
  String photoAlbumTitle(Object photoCount);

  /// No description provided for @photoAlbumSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Ваши лучшие моменты'**
  String get photoAlbumSubtitle;

  /// No description provided for @cosmicEventsTitle.
  ///
  /// In ru, this message translates to:
  /// **'Космические События'**
  String get cosmicEventsTitle;

  /// No description provided for @cosmicEventsSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Узнайте о влиянии планет'**
  String get cosmicEventsSubtitle;

  /// No description provided for @inviteFriendTitle.
  ///
  /// In ru, this message translates to:
  /// **'Пригласить друга'**
  String get inviteFriendTitle;

  /// No description provided for @inviteFriendSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Получайте бонусы вместе'**
  String get inviteFriendSubtitle;

  /// No description provided for @gameCenterTitle.
  ///
  /// In ru, this message translates to:
  /// **'Игровой центр'**
  String get gameCenterTitle;

  /// No description provided for @gameCenterSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Мини-игры и квесты'**
  String get gameCenterSubtitle;

  /// No description provided for @personalForecastTitle.
  ///
  /// In ru, this message translates to:
  /// **'Персональный прогноз'**
  String get personalForecastTitle;

  /// No description provided for @personalForecastSubtitlePro.
  ///
  /// In ru, this message translates to:
  /// **'Анализ транзитов на сегодня'**
  String get personalForecastSubtitlePro;

  /// No description provided for @personalForecastSubtitleFree.
  ///
  /// In ru, this message translates to:
  /// **'Доступно с PRO-статусом'**
  String get personalForecastSubtitleFree;

  /// No description provided for @cosmicPassportTitle.
  ///
  /// In ru, this message translates to:
  /// **'КОСМИЧЕСКИЙ ПАСПОРТ'**
  String get cosmicPassportTitle;

  /// No description provided for @numerologyPortraitTitle.
  ///
  /// In ru, this message translates to:
  /// **'НУМЕРОЛОГИЧЕСКИЙ ПОРТРЕТ'**
  String get numerologyPortraitTitle;

  /// No description provided for @yourNumbersOfDestinyTitle.
  ///
  /// In ru, this message translates to:
  /// **'Ваши числа судьбы'**
  String get yourNumbersOfDestinyTitle;

  /// No description provided for @yourNumbersOfDestinySubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Раскройте свой потенциал'**
  String get yourNumbersOfDestinySubtitle;

  /// No description provided for @numerologyPath.
  ///
  /// In ru, this message translates to:
  /// **'Путь'**
  String get numerologyPath;

  /// No description provided for @numerologyDestiny.
  ///
  /// In ru, this message translates to:
  /// **'Судьба'**
  String get numerologyDestiny;

  /// No description provided for @numerologySoul.
  ///
  /// In ru, this message translates to:
  /// **'Душа'**
  String get numerologySoul;

  /// No description provided for @signOut.
  ///
  /// In ru, this message translates to:
  /// **'Выйти из аккаунта'**
  String get signOut;

  /// No description provided for @calculatingChart.
  ///
  /// In ru, this message translates to:
  /// **'Рассчитываем карту...'**
  String get calculatingChart;

  /// No description provided for @astroDataSignMissing.
  ///
  /// In ru, this message translates to:
  /// **'Данные для этого знака отсутствуют.'**
  String get astroDataSignMissing;

  /// No description provided for @astroDataDescriptionNotFound.
  ///
  /// In ru, this message translates to:
  /// **'Описание для \"{signName}\" не найдено.'**
  String astroDataDescriptionNotFound(Object signName);

  /// No description provided for @astroDataMapNotLoaded.
  ///
  /// In ru, this message translates to:
  /// **'Данные для \"{mapKey}\" не загружены.'**
  String astroDataMapNotLoaded(Object mapKey);

  /// No description provided for @planetSun.
  ///
  /// In ru, this message translates to:
  /// **'Солнце'**
  String get planetSun;

  /// No description provided for @planetMoon.
  ///
  /// In ru, this message translates to:
  /// **'Луна'**
  String get planetMoon;

  /// No description provided for @planetAscendant.
  ///
  /// In ru, this message translates to:
  /// **'Асцендент'**
  String get planetAscendant;

  /// No description provided for @planetMercury.
  ///
  /// In ru, this message translates to:
  /// **'Меркурий'**
  String get planetMercury;

  /// No description provided for @planetVenus.
  ///
  /// In ru, this message translates to:
  /// **'Венера'**
  String get planetVenus;

  /// No description provided for @planetMars.
  ///
  /// In ru, this message translates to:
  /// **'Марс'**
  String get planetMars;

  /// No description provided for @planetSaturn.
  ///
  /// In ru, this message translates to:
  /// **'Сатурн'**
  String get planetSaturn;

  /// No description provided for @planetJupiter.
  ///
  /// In ru, this message translates to:
  /// **'Юпитер'**
  String get planetJupiter;

  /// No description provided for @planetUranus.
  ///
  /// In ru, this message translates to:
  /// **'Уран'**
  String get planetUranus;

  /// No description provided for @planetNeptune.
  ///
  /// In ru, this message translates to:
  /// **'Нептун'**
  String get planetNeptune;

  /// No description provided for @planetPluto.
  ///
  /// In ru, this message translates to:
  /// **'Плутон'**
  String get planetPluto;

  /// No description provided for @getProTitle.
  ///
  /// In ru, this message translates to:
  /// **'Получить PRO'**
  String get getProTitle;

  /// No description provided for @getProSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Разблокируйте все функции'**
  String get getProSubtitle;

  /// No description provided for @proStatusActive.
  ///
  /// In ru, this message translates to:
  /// **'PRO-статус активен'**
  String get proStatusActive;

  /// No description provided for @proStatusExpired.
  ///
  /// In ru, this message translates to:
  /// **'Статус истек'**
  String get proStatusExpired;

  /// No description provided for @proStatusDaysLeft.
  ///
  /// In ru, this message translates to:
  /// **'Осталось дней: {days}'**
  String proStatusDaysLeft(Object days);

  /// No description provided for @proStatusHoursLeft.
  ///
  /// In ru, this message translates to:
  /// **'Осталось часов: {hours}'**
  String proStatusHoursLeft(Object hours);

  /// No description provided for @proStatusExpiresToday.
  ///
  /// In ru, this message translates to:
  /// **'Заканчивается сегодня'**
  String get proStatusExpiresToday;

  /// No description provided for @astroDialogTitle.
  ///
  /// In ru, this message translates to:
  /// **'{planetName} в знаке {signName}'**
  String astroDialogTitle(Object planetName, Object signName);

  /// No description provided for @likesYouTitle.
  ///
  /// In ru, this message translates to:
  /// **'Вам симпатии'**
  String get likesYouTitle;

  /// No description provided for @likesYouTotal.
  ///
  /// In ru, this message translates to:
  /// **'Всего симпатий: {count}'**
  String likesYouTotal(Object count);

  /// No description provided for @likesYouNone.
  ///
  /// In ru, this message translates to:
  /// **'Пока нет симпатий'**
  String get likesYouNone;

  /// No description provided for @reportOnUser.
  ///
  /// In ru, this message translates to:
  /// **'Пожаловаться на {userName}'**
  String reportOnUser(Object userName);

  /// No description provided for @reportReasonSpam.
  ///
  /// In ru, this message translates to:
  /// **'Спам'**
  String get reportReasonSpam;

  /// No description provided for @reportReasonInsultingBehavior.
  ///
  /// In ru, this message translates to:
  /// **'Оскорбительное поведение'**
  String get reportReasonInsultingBehavior;

  /// No description provided for @reportReasonScam.
  ///
  /// In ru, this message translates to:
  /// **'Мошенничество'**
  String get reportReasonScam;

  /// No description provided for @reportReasonInappropriateContent.
  ///
  /// In ru, this message translates to:
  /// **'Неприемлемый контент'**
  String get reportReasonInappropriateContent;

  /// No description provided for @reportDetailsHint.
  ///
  /// In ru, this message translates to:
  /// **'Дополнительные детали (необязательно)'**
  String get reportDetailsHint;

  /// No description provided for @send.
  ///
  /// In ru, this message translates to:
  /// **'Отправить'**
  String get send;

  /// No description provided for @reportSentSnackbar.
  ///
  /// In ru, this message translates to:
  /// **'Спасибо! Ваша жалоба отправлена.'**
  String get reportSentSnackbar;

  /// No description provided for @profileLoadError.
  ///
  /// In ru, this message translates to:
  /// **'Не удалось загрузить профиль'**
  String get profileLoadError;

  /// No description provided for @back.
  ///
  /// In ru, this message translates to:
  /// **'Назад'**
  String get back;

  /// No description provided for @report.
  ///
  /// In ru, this message translates to:
  /// **'Пожаловаться'**
  String get report;

  /// No description provided for @userProfilePhotoAlbumTitle.
  ///
  /// In ru, this message translates to:
  /// **'Фотоальбом ({photoCount})'**
  String userProfilePhotoAlbumTitle(Object photoCount);

  /// No description provided for @userProfileViewPhotos.
  ///
  /// In ru, this message translates to:
  /// **'Посмотреть фотографии'**
  String get userProfileViewPhotos;

  /// No description provided for @aboutMe.
  ///
  /// In ru, this message translates to:
  /// **'О себе'**
  String get aboutMe;

  /// No description provided for @bioEmpty.
  ///
  /// In ru, this message translates to:
  /// **'Пользователь ничего не рассказал о себе.'**
  String get bioEmpty;

  /// No description provided for @cosmicPassport.
  ///
  /// In ru, this message translates to:
  /// **'Космический паспорт'**
  String get cosmicPassport;

  /// No description provided for @sunInSign.
  ///
  /// In ru, this message translates to:
  /// **'☀️ Солнце в знаке {signName}'**
  String sunInSign(Object signName);

  /// No description provided for @friendshipStatusFriends.
  ///
  /// In ru, this message translates to:
  /// **'Вы друзья'**
  String get friendshipStatusFriends;

  /// No description provided for @friendshipRemoveTitle.
  ///
  /// In ru, this message translates to:
  /// **'Удалить из друзей?'**
  String get friendshipRemoveTitle;

  /// No description provided for @friendshipRemoveContent.
  ///
  /// In ru, this message translates to:
  /// **'Вы уверены, что хотите удалить {userName} из друзей?'**
  String friendshipRemoveContent(Object userName);

  /// No description provided for @remove.
  ///
  /// In ru, this message translates to:
  /// **'Удалить'**
  String get remove;

  /// No description provided for @friendshipStatusRequestSent.
  ///
  /// In ru, this message translates to:
  /// **'Заявка отправлена'**
  String get friendshipStatusRequestSent;

  /// No description provided for @friendshipActionDecline.
  ///
  /// In ru, this message translates to:
  /// **'Отклонить'**
  String get friendshipActionDecline;

  /// No description provided for @friendshipActionAccept.
  ///
  /// In ru, this message translates to:
  /// **'Принять'**
  String get friendshipActionAccept;

  /// No description provided for @friendshipActionAdd.
  ///
  /// In ru, this message translates to:
  /// **'Добавить в друзья'**
  String get friendshipActionAdd;

  /// No description provided for @likeSnackbarSuccess.
  ///
  /// In ru, this message translates to:
  /// **'Вы лайкнули {userName}!'**
  String likeSnackbarSuccess(Object userName);

  /// No description provided for @likeSnackbarAlreadyLiked.
  ///
  /// In ru, this message translates to:
  /// **'Вы уже лайкнули {userName}'**
  String likeSnackbarAlreadyLiked(Object userName);

  /// No description provided for @writeMessage.
  ///
  /// In ru, this message translates to:
  /// **'Написать'**
  String get writeMessage;

  /// No description provided for @checkCompatibility.
  ///
  /// In ru, this message translates to:
  /// **'Проверить совместимость'**
  String get checkCompatibility;

  /// No description provided for @yourCosmicInfluence.
  ///
  /// In ru, this message translates to:
  /// **'Ваше Космическое Влияние Сегодня'**
  String get yourCosmicInfluence;

  /// No description provided for @cosmicEventsLoading.
  ///
  /// In ru, this message translates to:
  /// **'Рассчитываем космические события...'**
  String get cosmicEventsLoading;

  /// No description provided for @cosmicEventsEmpty.
  ///
  /// In ru, this message translates to:
  /// **'Сегодня космос спокоен. Наслаждайтесь гармонией!'**
  String get cosmicEventsEmpty;

  /// No description provided for @cosmicEventsError.
  ///
  /// In ru, this message translates to:
  /// **'Не удалось рассчитать космические события. Попробуйте позже.'**
  String get cosmicEventsError;

  /// No description provided for @cosmicConnectionTitle.
  ///
  /// In ru, this message translates to:
  /// **'Космическая Связь'**
  String get cosmicConnectionTitle;

  /// No description provided for @shareText.
  ///
  /// In ru, this message translates to:
  /// **'Наша совместимость с {name} — {score}%! ✨\nРассчитано в Aryonika'**
  String shareText(Object name, Object score);

  /// No description provided for @shareErrorSnackbar.
  ///
  /// In ru, this message translates to:
  /// **'Произошла ошибка при попытке поделиться.'**
  String get shareErrorSnackbar;

  /// No description provided for @compatibilityErrorTitle.
  ///
  /// In ru, this message translates to:
  /// **'Не удалось рассчитать совместимость'**
  String get compatibilityErrorTitle;

  /// No description provided for @compatibilityErrorSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Возможно, данные партнера неполные или произошла сетевая ошибка.'**
  String get compatibilityErrorSubtitle;

  /// No description provided for @goBack.
  ///
  /// In ru, this message translates to:
  /// **'Вернуться назад'**
  String get goBack;

  /// No description provided for @sectionCosmicAdvice.
  ///
  /// In ru, this message translates to:
  /// **'КОСМИЧЕСКИЙ СОВЕТ'**
  String get sectionCosmicAdvice;

  /// No description provided for @sectionDailyInfluence.
  ///
  /// In ru, this message translates to:
  /// **'ВЛИЯНИЕ ДНЯ'**
  String get sectionDailyInfluence;

  /// No description provided for @sectionAstrologicalResonance.
  ///
  /// In ru, this message translates to:
  /// **'АСТРОЛОГИЧЕСКИЙ РЕЗОНАНС'**
  String get sectionAstrologicalResonance;

  /// No description provided for @sectionNumerologyMatrix.
  ///
  /// In ru, this message translates to:
  /// **'НУМЕРОЛОГИЧЕСКАЯ МАТРИЦА'**
  String get sectionNumerologyMatrix;

  /// No description provided for @sectionPalmistryConnection.
  ///
  /// In ru, this message translates to:
  /// **'ХИРОМАНТИЧЕСКАЯ СВЯЗЬ'**
  String get sectionPalmistryConnection;

  /// No description provided for @sectionAboutPerson.
  ///
  /// In ru, this message translates to:
  /// **'О ЧЕЛОВЕКЕ'**
  String get sectionAboutPerson;

  /// No description provided for @palmistryNoData.
  ///
  /// In ru, this message translates to:
  /// **'Один из партнеров еще не прошел анализ ладони. Это откроет новый уровень вашей совместимости!'**
  String get palmistryNoData;

  /// No description provided for @palmistryCommonTraits.
  ///
  /// In ru, this message translates to:
  /// **'Вас объединяет: {traits}. Это создает прочный фундамент для ваших отношений.'**
  String palmistryCommonTraits(Object traits);

  /// No description provided for @palmistryUniqueTraits.
  ///
  /// In ru, this message translates to:
  /// **'Вы дополняете друг друга: ваша черта \'{myTrait}\' прекрасно гармонирует с его(ее) \'{partnerTrait}\'.'**
  String palmistryUniqueTraits(Object myTrait, Object partnerTrait);

  /// No description provided for @harmony.
  ///
  /// In ru, this message translates to:
  /// **'Гармония'**
  String get harmony;

  /// No description provided for @adviceRareConnection.
  ///
  /// In ru, this message translates to:
  /// **'Ваши души резонируют в унисон. Это редкая космическая связь, где гармонируют и личности (Солнце), и эмоции (Луна). Цените это сокровище.'**
  String get adviceRareConnection;

  /// No description provided for @advicePassionChallenge.
  ///
  /// In ru, this message translates to:
  /// **'Между вами бушует пламя страсти, но ваши личности могут конфликтовать. Учитесь превращать споры в энергию для роста, и ваша связь станет нерушимой.'**
  String get advicePassionChallenge;

  /// No description provided for @adviceBestFriends.
  ///
  /// In ru, this message translates to:
  /// **'Вы - лучшие друзья, которые понимают друг друга с полуслова и чувствуют себя комфортно. Физическое притяжение может со временем усилиться, главное — ваша душевная близость.'**
  String get adviceBestFriends;

  /// No description provided for @adviceKarmicLesson.
  ///
  /// In ru, this message translates to:
  /// **'Ваши пути пересеклись не случайно. Эта связь несет важные уроки для обоих. Будьте терпеливы и открыты, чтобы понять, чему вы должны научить друг друга.'**
  String get adviceKarmicLesson;

  /// No description provided for @adviceGreatPotential.
  ///
  /// In ru, this message translates to:
  /// **'Между вами есть сильное притяжение и отличный потенциал для роста. Учитесь друг у друга, и ваша связь станет крепче. Звезды на вашей стороне.'**
  String get adviceGreatPotential;

  /// No description provided for @adviceBase.
  ///
  /// In ru, this message translates to:
  /// **'Изучайте друг друга. Каждая встреча — это возможность открыть новую вселенную. Ваша история только начинается.'**
  String get adviceBase;

  /// No description provided for @dailyInfluenceCalm.
  ///
  /// In ru, this message translates to:
  /// **'Космический штиль. Отличный день, чтобы просто наслаждаться обществом друг друга без внешних влияний.'**
  String get dailyInfluenceCalm;

  /// No description provided for @dailyAdviceFavorable.
  ///
  /// In ru, this message translates to:
  /// **'Совет: Используйте эту энергию! Отличный момент для совместных планов.'**
  String get dailyAdviceFavorable;

  /// No description provided for @dailyAdviceTense.
  ///
  /// In ru, this message translates to:
  /// **'Совет: Будьте терпимее друг к другу. Возможны недопонимания.'**
  String get dailyAdviceTense;

  /// No description provided for @proFeatureLocked.
  ///
  /// In ru, this message translates to:
  /// **'Подробный анализ этого аспекта доступен в PRO-версии.'**
  String get proFeatureLocked;

  /// No description provided for @getProButton.
  ///
  /// In ru, this message translates to:
  /// **'Получить PRO'**
  String get getProButton;

  /// No description provided for @numerologyLifePath.
  ///
  /// In ru, this message translates to:
  /// **'Путь жизни'**
  String get numerologyLifePath;

  /// No description provided for @numerologyDestinyNumber.
  ///
  /// In ru, this message translates to:
  /// **'Число Судьбы'**
  String get numerologyDestinyNumber;

  /// No description provided for @numerologySoulNumber.
  ///
  /// In ru, this message translates to:
  /// **'Число Души'**
  String get numerologySoulNumber;

  /// No description provided for @shareCardTitle.
  ///
  /// In ru, this message translates to:
  /// **'Aryonika'**
  String get shareCardTitle;

  /// No description provided for @shareCardSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'ОТЧЕТ КОСМИЧЕСКОЙ СОВМЕСТИМОСТИ'**
  String get shareCardSubtitle;

  /// No description provided for @shareCardHarmony.
  ///
  /// In ru, this message translates to:
  /// **'Общая гармония'**
  String get shareCardHarmony;

  /// No description provided for @shareCardPersonalityHarmony.
  ///
  /// In ru, this message translates to:
  /// **'Гармония личностей (Солнце)'**
  String get shareCardPersonalityHarmony;

  /// No description provided for @shareCardLifePath.
  ///
  /// In ru, this message translates to:
  /// **'Путь Жизни (Нумерология)'**
  String get shareCardLifePath;

  /// No description provided for @shareCardCtaTitle.
  ///
  /// In ru, this message translates to:
  /// **'Узнай свою космическую\nсовместимость!'**
  String get shareCardCtaTitle;

  /// No description provided for @shareCardCtaSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Скачай Aryonika в RuStore'**
  String get shareCardCtaSubtitle;

  /// No description provided for @loginTitle.
  ///
  /// In ru, this message translates to:
  /// **'Вход в аккаунт'**
  String get loginTitle;

  /// No description provided for @loginError.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка входа'**
  String get loginError;

  /// No description provided for @passwordResetTitle.
  ///
  /// In ru, this message translates to:
  /// **'Восстановление пароля'**
  String get passwordResetTitle;

  /// No description provided for @passwordResetContent.
  ///
  /// In ru, this message translates to:
  /// **'Введите ваш E-mail, и мы отправим на него инструкцию для сброса пароля.'**
  String get passwordResetContent;

  /// No description provided for @emailLabel.
  ///
  /// In ru, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// No description provided for @sendButton.
  ///
  /// In ru, this message translates to:
  /// **'Отправить'**
  String get sendButton;

  /// No description provided for @emailValidationError.
  ///
  /// In ru, this message translates to:
  /// **'Пожалуйста, введите корректный E-mail.'**
  String get emailValidationError;

  /// No description provided for @passwordResetSuccess.
  ///
  /// In ru, this message translates to:
  /// **'Письмо отправлено! Проверьте вашу почту.'**
  String get passwordResetSuccess;

  /// No description provided for @passwordLabel.
  ///
  /// In ru, this message translates to:
  /// **'Пароль'**
  String get passwordLabel;

  /// No description provided for @loginButton.
  ///
  /// In ru, this message translates to:
  /// **'Войти'**
  String get loginButton;

  /// No description provided for @forgotPasswordButton.
  ///
  /// In ru, this message translates to:
  /// **'Забыли пароль?'**
  String get forgotPasswordButton;

  /// No description provided for @noAccountButton.
  ///
  /// In ru, this message translates to:
  /// **'Нет аккаунта? Создать'**
  String get noAccountButton;

  /// No description provided for @registerTitle.
  ///
  /// In ru, this message translates to:
  /// **'Создать аккаунт'**
  String get registerTitle;

  /// No description provided for @unknownError.
  ///
  /// In ru, this message translates to:
  /// **'Произошла неизвестная ошибка'**
  String get unknownError;

  /// No description provided for @confirmPasswordLabel.
  ///
  /// In ru, this message translates to:
  /// **'Подтвердите пароль'**
  String get confirmPasswordLabel;

  /// No description provided for @privacyPolicyCheckbox.
  ///
  /// In ru, this message translates to:
  /// **'Я принимаю '**
  String get privacyPolicyCheckbox;

  /// No description provided for @termsOfUseLink.
  ///
  /// In ru, this message translates to:
  /// **'Условия использования'**
  String get termsOfUseLink;

  /// No description provided for @and.
  ///
  /// In ru, this message translates to:
  /// **' и '**
  String get and;

  /// No description provided for @privacyPolicyLink.
  ///
  /// In ru, this message translates to:
  /// **'Политику конфиденциальности'**
  String get privacyPolicyLink;

  /// No description provided for @registerButton.
  ///
  /// In ru, this message translates to:
  /// **'Зарегистрироваться'**
  String get registerButton;

  /// No description provided for @alreadyHaveAccountButton.
  ///
  /// In ru, this message translates to:
  /// **'Уже есть аккаунт? Войти'**
  String get alreadyHaveAccountButton;

  /// No description provided for @welcomeTagline.
  ///
  /// In ru, this message translates to:
  /// **'Твоя судьба написана на звездах'**
  String get welcomeTagline;

  /// No description provided for @welcomeCreateAccountButton.
  ///
  /// In ru, this message translates to:
  /// **'Создать космический паспорт'**
  String get welcomeCreateAccountButton;

  /// No description provided for @welcomeLoginButton.
  ///
  /// In ru, this message translates to:
  /// **'У меня уже есть аккаунт'**
  String get welcomeLoginButton;

  /// No description provided for @introSlide1Title.
  ///
  /// In ru, this message translates to:
  /// **'Aryonika — больше, чем знакомства'**
  String get introSlide1Title;

  /// No description provided for @introSlide1Description.
  ///
  /// In ru, this message translates to:
  /// **'Откройте новые грани совместимости через астрологию, нумерологию и Карты Судьбы.'**
  String get introSlide1Description;

  /// No description provided for @introSlide2Title.
  ///
  /// In ru, this message translates to:
  /// **'Ваш Космический Паспорт'**
  String get introSlide2Title;

  /// No description provided for @introSlide2Description.
  ///
  /// In ru, this message translates to:
  /// **'Узнайте всё о своем потенциале и найдите того, кто дополнит вашу Вселенную.'**
  String get introSlide2Description;

  /// No description provided for @introSlide3Title.
  ///
  /// In ru, this message translates to:
  /// **'Присоединяйтесь к Галактике'**
  String get introSlide3Title;

  /// No description provided for @introSlide3Description.
  ///
  /// In ru, this message translates to:
  /// **'Начните свое космическое путешествие к настоящей любви прямо сейчас.'**
  String get introSlide3Description;

  /// No description provided for @introButtonSkip.
  ///
  /// In ru, this message translates to:
  /// **'Пропустить'**
  String get introButtonSkip;

  /// No description provided for @introButtonNext.
  ///
  /// In ru, this message translates to:
  /// **'Далее'**
  String get introButtonNext;

  /// No description provided for @introButtonStart.
  ///
  /// In ru, this message translates to:
  /// **'Начать'**
  String get introButtonStart;

  /// No description provided for @onboardingNameTitle.
  ///
  /// In ru, this message translates to:
  /// **'Как вас зовут?'**
  String get onboardingNameTitle;

  /// No description provided for @onboardingNameSignOutTooltip.
  ///
  /// In ru, this message translates to:
  /// **'Выйти (для теста)'**
  String get onboardingNameSignOutTooltip;

  /// No description provided for @onboardingNameSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Это имя будут видеть другие пользователи.'**
  String get onboardingNameSubtitle;

  /// No description provided for @onboardingNameLabel.
  ///
  /// In ru, this message translates to:
  /// **'Ваше имя'**
  String get onboardingNameLabel;

  /// No description provided for @onboardingBioLabel.
  ///
  /// In ru, this message translates to:
  /// **'Расскажите о себе'**
  String get onboardingBioLabel;

  /// No description provided for @onboardingBioHint.
  ///
  /// In ru, this message translates to:
  /// **'Например: Люблю астрологию и #путешествия...'**
  String get onboardingBioHint;

  /// No description provided for @onboardingButtonNext.
  ///
  /// In ru, this message translates to:
  /// **'Далее'**
  String get onboardingButtonNext;

  /// No description provided for @onboardingBirthdateTitle.
  ///
  /// In ru, this message translates to:
  /// **'Когда вы родились?'**
  String get onboardingBirthdateTitle;

  /// No description provided for @onboardingBirthdateSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Это необходимо для точного расчета\nнатальной карты и нумерологии.'**
  String get onboardingBirthdateSubtitle;

  /// No description provided for @datePickerHelpText.
  ///
  /// In ru, this message translates to:
  /// **'ВЫБЕРИТЕ ДАТУ РОЖДЕНИЯ'**
  String get datePickerHelpText;

  /// No description provided for @birthdateLabel.
  ///
  /// In ru, this message translates to:
  /// **'Дата рождения'**
  String get birthdateLabel;

  /// No description provided for @birthdatePlaceholder.
  ///
  /// In ru, this message translates to:
  /// **'Нажмите, чтобы выбрать'**
  String get birthdatePlaceholder;

  /// No description provided for @dateFormat.
  ///
  /// In ru, this message translates to:
  /// **'d MMMM yyyy'**
  String get dateFormat;

  /// No description provided for @onboardingFinishText1.
  ///
  /// In ru, this message translates to:
  /// **'Анализируем положение звезд...'**
  String get onboardingFinishText1;

  /// No description provided for @onboardingFinishText2.
  ///
  /// In ru, this message translates to:
  /// **'Рассчитываем ваш нумерологический код...'**
  String get onboardingFinishText2;

  /// No description provided for @onboardingFinishText3.
  ///
  /// In ru, this message translates to:
  /// **'Сверяемся с Картами Судьбы...'**
  String get onboardingFinishText3;

  /// No description provided for @onboardingFinishText4.
  ///
  /// In ru, this message translates to:
  /// **'Создаем ваш космический паспорт...'**
  String get onboardingFinishText4;

  /// No description provided for @onboardingFinishErrorTitle.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка'**
  String get onboardingFinishErrorTitle;

  /// No description provided for @onboardingFinishErrorContent.
  ///
  /// In ru, this message translates to:
  /// **'Произошла неизвестная ошибка.'**
  String get onboardingFinishErrorContent;

  /// No description provided for @onboardingFinishErrorButton.
  ///
  /// In ru, this message translates to:
  /// **'Вернуться'**
  String get onboardingFinishErrorButton;

  /// No description provided for @onboardingGenderTitle.
  ///
  /// In ru, this message translates to:
  /// **'Ваш пол'**
  String get onboardingGenderTitle;

  /// No description provided for @onboardingGenderSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Это поможет нам подобрать для вас\nнаиболее подходящих людей.'**
  String get onboardingGenderSubtitle;

  /// No description provided for @genderMale.
  ///
  /// In ru, this message translates to:
  /// **'Мужчин'**
  String get genderMale;

  /// No description provided for @genderFemale.
  ///
  /// In ru, this message translates to:
  /// **'Женщин'**
  String get genderFemale;

  /// No description provided for @onboardingLocationTitle.
  ///
  /// In ru, this message translates to:
  /// **'Место рождения'**
  String get onboardingLocationTitle;

  /// No description provided for @onboardingLocationSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Укажите город, в котором вы родились. Это необходимо для точного астрологического расчета.'**
  String get onboardingLocationSubtitle;

  /// No description provided for @onboardingLocationSearchHint.
  ///
  /// In ru, this message translates to:
  /// **'Начните вводить город...'**
  String get onboardingLocationSearchHint;

  /// No description provided for @onboardingLocationNotFound.
  ///
  /// In ru, this message translates to:
  /// **'Городов не найдено. Попробуйте другой запрос.'**
  String get onboardingLocationNotFound;

  /// No description provided for @onboardingLocationStartSearch.
  ///
  /// In ru, this message translates to:
  /// **'Начните поиск, чтобы увидеть результаты'**
  String get onboardingLocationStartSearch;

  /// No description provided for @onboardingLocationSelectFromList.
  ///
  /// In ru, this message translates to:
  /// **'Выберите город из списка выше, чтобы продолжить'**
  String get onboardingLocationSelectFromList;

  /// No description provided for @onboardingTimeTitle.
  ///
  /// In ru, this message translates to:
  /// **'Время рождения'**
  String get onboardingTimeTitle;

  /// No description provided for @onboardingTimeSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Если вы не знаете точное время, укажите 12:00.\nЭто все равно даст хороший результат.'**
  String get onboardingTimeSubtitle;

  /// No description provided for @timePickerHelpText.
  ///
  /// In ru, this message translates to:
  /// **'УКАЖИТЕ ВРЕМЯ РОЖДЕНИЯ'**
  String get timePickerHelpText;

  /// No description provided for @birthTimeLabel.
  ///
  /// In ru, this message translates to:
  /// **'Время рождения'**
  String get birthTimeLabel;

  /// No description provided for @onboardingButtonNextLocation.
  ///
  /// In ru, this message translates to:
  /// **'Далее (выбрать место)'**
  String get onboardingButtonNextLocation;

  /// No description provided for @alphaBannerTitle.
  ///
  /// In ru, this message translates to:
  /// **'Альфа-версия'**
  String get alphaBannerTitle;

  /// No description provided for @alphaBannerContent.
  ///
  /// In ru, this message translates to:
  /// **'Этот раздел находится в активной разработке. Некоторые функции могут работать нестабильно. Мы активно работаем над локализацией, поэтому часть текстов может быть еще на английском языке. Спасибо за понимание!'**
  String get alphaBannerContent;

  /// No description provided for @alphaBannerFeedback.
  ///
  /// In ru, this message translates to:
  /// **'Будем благодарны за ваши замечания и пожелания в нашем Telegram-канале!'**
  String get alphaBannerFeedback;

  /// No description provided for @astro_title_sun.
  ///
  /// In ru, this message translates to:
  /// **'Совместимость личностей (Солнце)'**
  String get astro_title_sun;

  /// No description provided for @astro_title_moon.
  ///
  /// In ru, this message translates to:
  /// **'Эмоциональная совместимость (Луна)'**
  String get astro_title_moon;

  /// No description provided for @astro_title_chemistry.
  ///
  /// In ru, this message translates to:
  /// **'Астрологическая химия (Венера-Марс)'**
  String get astro_title_chemistry;

  /// No description provided for @astro_title_mercury.
  ///
  /// In ru, this message translates to:
  /// **'Стиль общения (Меркурий)'**
  String get astro_title_mercury;

  /// No description provided for @astro_title_saturn.
  ///
  /// In ru, this message translates to:
  /// **'Долгосрочная перспектива (Сатурн)'**
  String get astro_title_saturn;

  /// No description provided for @numerology_title.
  ///
  /// In ru, this message translates to:
  /// **'Нумерологический резонанс'**
  String get numerology_title;

  /// No description provided for @cosmicPulseTitle.
  ///
  /// In ru, this message translates to:
  /// **'Cosmic Pulse'**
  String get cosmicPulseTitle;

  /// No description provided for @feedIceBreakerTitle.
  ///
  /// In ru, this message translates to:
  /// **'Ледокол'**
  String get feedIceBreakerTitle;

  /// No description provided for @feedOrbitCrossingTitle.
  ///
  /// In ru, this message translates to:
  /// **'Пересечение Орбит'**
  String get feedOrbitCrossingTitle;

  /// No description provided for @feedSpiritualNeighborTitle.
  ///
  /// In ru, this message translates to:
  /// **'Духовный Сосед'**
  String get feedSpiritualNeighborTitle;

  /// No description provided for @feedGeomagneticStormTitle.
  ///
  /// In ru, this message translates to:
  /// **'Геомагнитные Бури'**
  String get feedGeomagneticStormTitle;

  /// No description provided for @feedCompatibilityPeakTitle.
  ///
  /// In ru, this message translates to:
  /// **'Пик Совместимости'**
  String get feedCompatibilityPeakTitle;

  /// No description provided for @feedNewChannelSuggestionTitle.
  ///
  /// In ru, this message translates to:
  /// **'Новый Канал'**
  String get feedNewChannelSuggestionTitle;

  /// No description provided for @feedPopularPostTitle.
  ///
  /// In ru, this message translates to:
  /// **'Популярный Пост'**
  String get feedPopularPostTitle;

  /// No description provided for @feedNewCommentTitle.
  ///
  /// In ru, this message translates to:
  /// **'Новый Комментарий'**
  String get feedNewCommentTitle;

  /// No description provided for @cardOfTheDayTitle.
  ///
  /// In ru, this message translates to:
  /// **'Карта Дня'**
  String get cardOfTheDayTitle;

  /// No description provided for @cardOfTheDayDrawing.
  ///
  /// In ru, this message translates to:
  /// **'Вытягиваю вашу карту...'**
  String get cardOfTheDayDrawing;

  /// No description provided for @cardOfTheDayGetButton.
  ///
  /// In ru, this message translates to:
  /// **'Вытянуть карту'**
  String get cardOfTheDayGetButton;

  /// No description provided for @cardOfTheDayYourCard.
  ///
  /// In ru, this message translates to:
  /// **'Ваша карта дня'**
  String get cardOfTheDayYourCard;

  /// No description provided for @cardOfTheDayTapToReveal.
  ///
  /// In ru, this message translates to:
  /// **'Нажмите на карту, чтобы перевернуть'**
  String get cardOfTheDayTapToReveal;

  /// No description provided for @cardOfTheDayReversedSuffix.
  ///
  /// In ru, this message translates to:
  /// **' (Перевернутая)'**
  String get cardOfTheDayReversedSuffix;

  /// No description provided for @cardOfTheDayDefaultInterpretation.
  ///
  /// In ru, this message translates to:
  /// **'Узнайте, что день грядущий вам готовит.'**
  String get cardOfTheDayDefaultInterpretation;

  /// No description provided for @channelSearchTitle.
  ///
  /// In ru, this message translates to:
  /// **'Поиск трансляций'**
  String get channelSearchTitle;

  /// No description provided for @channelAnonymousAuthor.
  ///
  /// In ru, this message translates to:
  /// **'Аноним'**
  String get channelAnonymousAuthor;

  /// No description provided for @errorUserNotAuthorized.
  ///
  /// In ru, this message translates to:
  /// **'Пользователь не авторизован'**
  String get errorUserNotAuthorized;

  /// No description provided for @errorUnknownServer.
  ///
  /// In ru, this message translates to:
  /// **'Неизвестная ошибка сервера'**
  String get errorUnknownServer;

  /// No description provided for @errorFailedToLoadData.
  ///
  /// In ru, this message translates to:
  /// **'Не удалось загрузить данные'**
  String get errorFailedToLoadData;

  /// No description provided for @generalHello.
  ///
  /// In ru, this message translates to:
  /// **'Привет'**
  String get generalHello;

  /// No description provided for @referralErrorProfileNotLoaded.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка: ваш профиль не загружен. Попробуйте позже.'**
  String get referralErrorProfileNotLoaded;

  /// No description provided for @referralErrorAlreadyUsed.
  ///
  /// In ru, this message translates to:
  /// **'Вы уже использовали код приглашения.'**
  String get referralErrorAlreadyUsed;

  /// No description provided for @referralErrorOwnCode.
  ///
  /// In ru, this message translates to:
  /// **'Нельзя использовать свой собственный код.'**
  String get referralErrorOwnCode;

  /// No description provided for @referralScreenTitle.
  ///
  /// In ru, this message translates to:
  /// **'Пригласить друга'**
  String get referralScreenTitle;

  /// No description provided for @referralYourCodeTitle.
  ///
  /// In ru, this message translates to:
  /// **'Ваш код приглашения'**
  String get referralYourCodeTitle;

  /// No description provided for @referralYourCodeDescription.
  ///
  /// In ru, this message translates to:
  /// **'Поделитесь этим кодом с друзьями. За каждого друга, который введет ваш код, вы получите 1 день PRO-доступа!'**
  String get referralYourCodeDescription;

  /// No description provided for @referralCodeCopied.
  ///
  /// In ru, this message translates to:
  /// **'Код скопирован в буфер обмена!'**
  String get referralCodeCopied;

  /// No description provided for @referralShareCodeButton.
  ///
  /// In ru, this message translates to:
  /// **'Поделиться кодом'**
  String get referralShareCodeButton;

  /// No description provided for @referralShareMessage.
  ///
  /// In ru, this message translates to:
  /// **'Привет! Присоединяйся ко мне в Aryonika, чтобы найти свою космическую пару. Введи мой код приглашения в приложении, чтобы мы оба получили бонусы: {code}'**
  String referralShareMessage(String code);

  /// No description provided for @referralManualBonusNote.
  ///
  /// In ru, this message translates to:
  /// **'PRO-доступ начисляется вручную в течение 24 часов после того, как ваш друг введет код.'**
  String get referralManualBonusNote;

  /// No description provided for @referralGotCodeTitle.
  ///
  /// In ru, this message translates to:
  /// **'У вас есть код?'**
  String get referralGotCodeTitle;

  /// No description provided for @referralGotCodeDescription.
  ///
  /// In ru, this message translates to:
  /// **'Введите код, который вам дал друг, чтобы он получил свою награду.'**
  String get referralGotCodeDescription;

  /// No description provided for @referralCodeInputLabel.
  ///
  /// In ru, this message translates to:
  /// **'Код приглашения'**
  String get referralCodeInputLabel;

  /// No description provided for @referralCodeValidationError.
  ///
  /// In ru, this message translates to:
  /// **'Пожалуйста, введите код'**
  String get referralCodeValidationError;

  /// No description provided for @referralApplyCodeButton.
  ///
  /// In ru, this message translates to:
  /// **'Применить код'**
  String get referralApplyCodeButton;

  /// No description provided for @nav_feed.
  ///
  /// In ru, this message translates to:
  /// **'Лента'**
  String get nav_feed;

  /// No description provided for @nav_search.
  ///
  /// In ru, this message translates to:
  /// **'Поиск'**
  String get nav_search;

  /// No description provided for @nav_oracle.
  ///
  /// In ru, this message translates to:
  /// **'Оракул'**
  String get nav_oracle;

  /// No description provided for @nav_chats.
  ///
  /// In ru, this message translates to:
  /// **'Чаты'**
  String get nav_chats;

  /// No description provided for @nav_channels.
  ///
  /// In ru, this message translates to:
  /// **'Каналы'**
  String get nav_channels;

  /// No description provided for @nav_profile.
  ///
  /// In ru, this message translates to:
  /// **'Профиль'**
  String get nav_profile;

  /// No description provided for @nav_exit.
  ///
  /// In ru, this message translates to:
  /// **'Выход'**
  String get nav_exit;

  /// No description provided for @exitDialog_title.
  ///
  /// In ru, this message translates to:
  /// **'Подтверждение'**
  String get exitDialog_title;

  /// No description provided for @exitDialog_content.
  ///
  /// In ru, this message translates to:
  /// **'Вы уверены, что хотите закрыть Aryonika?'**
  String get exitDialog_content;

  /// No description provided for @exitDialog_cancel.
  ///
  /// In ru, this message translates to:
  /// **'Отмена'**
  String get exitDialog_cancel;

  /// No description provided for @exitDialog_confirm.
  ///
  /// In ru, this message translates to:
  /// **'Закрыть'**
  String get exitDialog_confirm;

  /// No description provided for @oracle_limit_title.
  ///
  /// In ru, this message translates to:
  /// **'Лимит запросов'**
  String get oracle_limit_title;

  /// No description provided for @oracle_limit_later.
  ///
  /// In ru, this message translates to:
  /// **'Позже'**
  String get oracle_limit_later;

  /// No description provided for @oracle_limit_get_pro.
  ///
  /// In ru, this message translates to:
  /// **'Получить безлимит'**
  String get oracle_limit_get_pro;

  /// No description provided for @oracle_orb_partner.
  ///
  /// In ru, this message translates to:
  /// **'Партнер Дня'**
  String get oracle_orb_partner;

  /// No description provided for @oracle_orb_roulette.
  ///
  /// In ru, this message translates to:
  /// **'Рулетка'**
  String get oracle_orb_roulette;

  /// No description provided for @oracle_orb_duet.
  ///
  /// In ru, this message translates to:
  /// **'Дуэт'**
  String get oracle_orb_duet;

  /// No description provided for @oracle_orb_horoscope.
  ///
  /// In ru, this message translates to:
  /// **'Гороскоп'**
  String get oracle_orb_horoscope;

  /// No description provided for @oracle_orb_weather.
  ///
  /// In ru, this message translates to:
  /// **'Геомагнит.'**
  String get oracle_orb_weather;

  /// No description provided for @oracle_orb_ask.
  ///
  /// In ru, this message translates to:
  /// **'Вопрос'**
  String get oracle_orb_ask;

  /// No description provided for @oracle_orb_focus.
  ///
  /// In ru, this message translates to:
  /// **'Фокус Дня'**
  String get oracle_orb_focus;

  /// No description provided for @oracle_orb_forecast.
  ///
  /// In ru, this message translates to:
  /// **'АстроПрогноз'**
  String get oracle_orb_forecast;

  /// No description provided for @oracle_orb_card.
  ///
  /// In ru, this message translates to:
  /// **'Карта Дня'**
  String get oracle_orb_card;

  /// No description provided for @oracle_orb_tarot.
  ///
  /// In ru, this message translates to:
  /// **'Ответ вселенной'**
  String get oracle_orb_tarot;

  /// No description provided for @oracle_orb_palmistry.
  ///
  /// In ru, this message translates to:
  /// **'Хиромантия'**
  String get oracle_orb_palmistry;

  /// No description provided for @oracle_duet_title.
  ///
  /// In ru, this message translates to:
  /// **'Космический Дуэт'**
  String get oracle_duet_title;

  /// No description provided for @oracle_duet_description.
  ///
  /// In ru, this message translates to:
  /// **'Проверьте совместимость с любым человеком по дате рождения.'**
  String get oracle_duet_description;

  /// No description provided for @oracle_duet_button.
  ///
  /// In ru, this message translates to:
  /// **'Проверить совместимость'**
  String get oracle_duet_button;

  /// No description provided for @oracle_unsupported_web_feature.
  ///
  /// In ru, this message translates to:
  /// **'Функция \'{feature}\' пока недоступна в WEB версии. Скачайте приложение.'**
  String oracle_unsupported_web_feature(String featureName, Object feature);

  /// No description provided for @oracle_pro_card_of_day_title.
  ///
  /// In ru, this message translates to:
  /// **'Карта Дня (PRO)'**
  String get oracle_pro_card_of_day_title;

  /// No description provided for @oracle_pro_card_of_day_desc.
  ///
  /// In ru, this message translates to:
  /// **'Узнайте энергию своего дня через арканы Таро. Доступно только в PRO.'**
  String get oracle_pro_card_of_day_desc;

  /// No description provided for @oracle_pro_focus_of_day_title.
  ///
  /// In ru, this message translates to:
  /// **'Фокус Дня (PRO)'**
  String get oracle_pro_focus_of_day_title;

  /// No description provided for @oracle_pro_focus_of_day_desc.
  ///
  /// In ru, this message translates to:
  /// **'Узнайте, на чем сегодня стоит сфокусироваться. Доступно только в PRO.'**
  String get oracle_pro_focus_of_day_desc;

  /// No description provided for @oracle_pro_forecast_of_day_title.
  ///
  /// In ru, this message translates to:
  /// **'Персональный прогноз (PRO)'**
  String get oracle_pro_forecast_of_day_title;

  /// No description provided for @oracle_pro_forecast_of_day_desc.
  ///
  /// In ru, this message translates to:
  /// **'Подробный разбор транзитов планет для вас. Доступно только в PRO.'**
  String get oracle_pro_forecast_of_day_desc;

  /// No description provided for @oracle_roulette_title.
  ///
  /// In ru, this message translates to:
  /// **'Космическая Рулетка'**
  String get oracle_roulette_title;

  /// No description provided for @oracle_roulette_description.
  ///
  /// In ru, this message translates to:
  /// **'Испытайте удачу! Найдите случайного партнера с высокой совместимостью.'**
  String get oracle_roulette_description;

  /// No description provided for @oracle_roulette_button.
  ///
  /// In ru, this message translates to:
  /// **'Крутить рулетку'**
  String get oracle_roulette_button;

  /// No description provided for @oracle_card_of_day_reversed.
  ///
  /// In ru, this message translates to:
  /// **'(перевернутая)'**
  String get oracle_card_of_day_reversed;

  /// No description provided for @oracle_card_of_day_get_key.
  ///
  /// In ru, this message translates to:
  /// **'Узнать персональный ключ'**
  String get oracle_card_of_day_get_key;

  /// No description provided for @oracle_palmistry_title.
  ///
  /// In ru, this message translates to:
  /// **'Хиромантия'**
  String get oracle_palmistry_title;

  /// No description provided for @oracle_palmistry_description.
  ///
  /// In ru, this message translates to:
  /// **'Анализ линий на ладони с помощью AI. Узнайте свою судьбу по руке.'**
  String get oracle_palmistry_description;

  /// No description provided for @oracle_palmistry_button.
  ///
  /// In ru, this message translates to:
  /// **'Сканировать руку'**
  String get oracle_palmistry_button;

  /// No description provided for @oracle_ask_loading.
  ///
  /// In ru, this message translates to:
  /// **'Оракул думает...'**
  String get oracle_ask_loading;

  /// No description provided for @oracle_ask_again.
  ///
  /// In ru, this message translates to:
  /// **'Спросить еще раз'**
  String get oracle_ask_again;

  /// No description provided for @oracle_focus_loading.
  ///
  /// In ru, this message translates to:
  /// **'Настраиваю фокус...'**
  String get oracle_focus_loading;

  /// No description provided for @oracle_focus_error.
  ///
  /// In ru, this message translates to:
  /// **'Не удалось загрузить фокус'**
  String get oracle_focus_error;

  /// No description provided for @oracle_focus_no_data.
  ///
  /// In ru, this message translates to:
  /// **'Данные отсутствуют'**
  String get oracle_focus_no_data;

  /// No description provided for @oracle_forecast_loading.
  ///
  /// In ru, this message translates to:
  /// **'Составляю ваш личный прогноз...'**
  String get oracle_forecast_loading;

  /// No description provided for @oracle_forecast_error.
  ///
  /// In ru, this message translates to:
  /// **'Не удалось составить прогноз'**
  String get oracle_forecast_error;

  /// No description provided for @oracle_forecast_try_again.
  ///
  /// In ru, this message translates to:
  /// **'Попробовать снова'**
  String get oracle_forecast_try_again;

  /// No description provided for @oracle_forecast_title.
  ///
  /// In ru, this message translates to:
  /// **'Прогноз на День'**
  String get oracle_forecast_title;

  /// No description provided for @oracle_forecast_day_number.
  ///
  /// In ru, this message translates to:
  /// **'Число вашего дня: '**
  String get oracle_forecast_day_number;

  /// No description provided for @oracle_tarot_title.
  ///
  /// In ru, this message translates to:
  /// **'Расклад Таро (AI)'**
  String get oracle_tarot_title;

  /// No description provided for @oracle_tarot_hint.
  ///
  /// In ru, this message translates to:
  /// **'Ваш вопрос картам...'**
  String get oracle_tarot_hint;

  /// No description provided for @oracle_tarot_button.
  ///
  /// In ru, this message translates to:
  /// **'Сделать расклад'**
  String get oracle_tarot_button;

  /// No description provided for @oracle_tarot_your_question.
  ///
  /// In ru, this message translates to:
  /// **'Ваш вопрос: {question}'**
  String oracle_tarot_your_question(String question);

  /// No description provided for @oracle_tarot_loading.
  ///
  /// In ru, this message translates to:
  /// **'AI анализирует расклад...'**
  String get oracle_tarot_loading;

  /// No description provided for @oracle_tarot_ask_again.
  ///
  /// In ru, this message translates to:
  /// **'Спросить еще'**
  String get oracle_tarot_ask_again;

  /// No description provided for @oracle_tarot_card_reversed_short.
  ///
  /// In ru, this message translates to:
  /// **' (перев.)'**
  String get oracle_tarot_card_reversed_short;

  /// No description provided for @oracle_tarot_combo_message.
  ///
  /// In ru, this message translates to:
  /// **'Общее послание карт:'**
  String get oracle_tarot_combo_message;

  /// No description provided for @oracle_geomagnetic_title.
  ///
  /// In ru, this message translates to:
  /// **'Космическая Погода'**
  String get oracle_geomagnetic_title;

  /// No description provided for @oracle_geomagnetic_forecast.
  ///
  /// In ru, this message translates to:
  /// **'Прогноз на ближайшие часы'**
  String get oracle_geomagnetic_forecast;

  /// No description provided for @oracle_weather_title.
  ///
  /// In ru, this message translates to:
  /// **'Геомагнитная обстановка'**
  String get oracle_weather_title;

  /// No description provided for @oracle_pro_feature_title.
  ///
  /// In ru, this message translates to:
  /// **'Партнер Дня (PRO)'**
  String get oracle_pro_feature_title;

  /// No description provided for @oracle_pro_feature_desc.
  ///
  /// In ru, this message translates to:
  /// **'Мы подбираем идеального партнера по вашей натальной карте. Доступно в PRO.'**
  String get oracle_pro_feature_desc;

  /// No description provided for @oracle_partner_loading.
  ///
  /// In ru, this message translates to:
  /// **'Ищу партнера...'**
  String get oracle_partner_loading;

  /// No description provided for @oracle_partner_error.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка поиска'**
  String get oracle_partner_error;

  /// No description provided for @oracle_partner_not_found.
  ///
  /// In ru, this message translates to:
  /// **'Подходящие партнеры не найдены'**
  String get oracle_partner_not_found;

  /// No description provided for @oracle_partner_profile_error.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка профиля'**
  String get oracle_partner_profile_error;

  /// No description provided for @oracle_partner_title.
  ///
  /// In ru, this message translates to:
  /// **'Ваш Партнер Дня'**
  String get oracle_partner_title;

  /// No description provided for @oracle_partner_compatibility.
  ///
  /// In ru, this message translates to:
  /// **'Совместимость: {score}%'**
  String oracle_partner_compatibility(String score);

  /// No description provided for @oracle_ask_title.
  ///
  /// In ru, this message translates to:
  /// **'Вопрос Оракулу'**
  String get oracle_ask_title;

  /// No description provided for @oracle_ask_hint.
  ///
  /// In ru, this message translates to:
  /// **'Что вас волнует?..'**
  String get oracle_ask_hint;

  /// No description provided for @oracle_ask_button.
  ///
  /// In ru, this message translates to:
  /// **'Получить ответ'**
  String get oracle_ask_button;

  /// No description provided for @oracle_tips_loading.
  ///
  /// In ru, this message translates to:
  /// **'Загрузка советов...'**
  String get oracle_tips_loading;

  /// No description provided for @oracle_tips_title.
  ///
  /// In ru, this message translates to:
  /// **'Советы звезд на сегодня'**
  String get oracle_tips_title;

  /// No description provided for @oracle_tips_subtitle.
  ///
  /// In ru, this message translates to:
  /// **'Для общения ({count})'**
  String oracle_tips_subtitle(String count);

  /// No description provided for @oracle_tips_general_advice.
  ///
  /// In ru, this message translates to:
  /// **'Будьте открыты и искренни.'**
  String get oracle_tips_general_advice;

  /// No description provided for @cardOfTheDayProInApp.
  ///
  /// In ru, this message translates to:
  /// **'✨ Персональный аспект доступен в мобильном приложении.'**
  String get cardOfTheDayProInApp;

  /// No description provided for @numerology_report_title.
  ///
  /// In ru, this message translates to:
  /// **'Отчет по нумерологии'**
  String get numerology_report_title;

  /// No description provided for @numerology_report_overall.
  ///
  /// In ru, this message translates to:
  /// **'Общий балл'**
  String get numerology_report_overall;

  /// No description provided for @numerology_report_you.
  ///
  /// In ru, this message translates to:
  /// **'Вы'**
  String get numerology_report_you;

  /// No description provided for @numerology_report_partner.
  ///
  /// In ru, this message translates to:
  /// **'Партнер'**
  String get numerology_report_partner;

  /// No description provided for @userProfile_numerology_button.
  ///
  /// In ru, this message translates to:
  /// **'Нумерология'**
  String get userProfile_numerology_button;

  /// No description provided for @forecast_astrological_title.
  ///
  /// In ru, this message translates to:
  /// **'Астрологический прогноз'**
  String get forecast_astrological_title;

  /// No description provided for @forecast_loading.
  ///
  /// In ru, this message translates to:
  /// **'Загрузка прогноза...'**
  String get forecast_loading;

  /// No description provided for @forecast_error.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка загрузки'**
  String get forecast_error;

  /// No description provided for @forecast_no_aspects.
  ///
  /// In ru, this message translates to:
  /// **'Нет значимых аспектов'**
  String get forecast_no_aspects;

  /// No description provided for @cosmicEvents_title.
  ///
  /// In ru, this message translates to:
  /// **'Космические События'**
  String get cosmicEvents_title;

  /// No description provided for @cosmicEvents_loading_error.
  ///
  /// In ru, this message translates to:
  /// **'Не удалось загрузить события'**
  String get cosmicEvents_loading_error;

  /// No description provided for @cosmicEvents_no_events.
  ///
  /// In ru, this message translates to:
  /// **'Нет предстоящих событий'**
  String get cosmicEvents_no_events;

  /// No description provided for @cosmicEvents_paywall_title.
  ///
  /// In ru, this message translates to:
  /// **'Персональные космические события'**
  String get cosmicEvents_paywall_title;

  /// No description provided for @cosmicEvents_paywall_description.
  ///
  /// In ru, this message translates to:
  /// **'Получите доступ к уникальным советам, основанным на влиянии планет на вашу натальную карту.'**
  String get cosmicEvents_paywall_description;

  /// No description provided for @cosmicEvents_paywall_button.
  ///
  /// In ru, this message translates to:
  /// **'Получить PRO-статус'**
  String get cosmicEvents_paywall_button;

  /// No description provided for @cosmicEvents_personal_focus.
  ///
  /// In ru, this message translates to:
  /// **'Ваш персональный фокус:'**
  String get cosmicEvents_personal_focus;

  /// No description provided for @cosmicEvents_pro_placeholder.
  ///
  /// In ru, this message translates to:
  /// **'Узнайте персональное влияние этого события с PRO-статусом'**
  String get cosmicEvents_pro_placeholder;

  /// No description provided for @search_no_one_found.
  ///
  /// In ru, this message translates to:
  /// **'Никого не найдено\nв этой части галактики.'**
  String get search_no_one_found;

  /// No description provided for @chat_error_user_not_found.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка: пользователь не найден'**
  String get chat_error_user_not_found;

  /// No description provided for @chat_start_with_hint.
  ///
  /// In ru, this message translates to:
  /// **'Начать с подсказки'**
  String get chat_start_with_hint;

  /// No description provided for @chat_date_format.
  ///
  /// In ru, this message translates to:
  /// **'yMMMMd'**
  String get chat_date_format;

  /// No description provided for @chat_group_member.
  ///
  /// In ru, this message translates to:
  /// **'участник'**
  String get chat_group_member;

  /// No description provided for @chat_group_members_2_4.
  ///
  /// In ru, this message translates to:
  /// **'участника'**
  String get chat_group_members_2_4;

  /// No description provided for @chat_group_members_5_0.
  ///
  /// In ru, this message translates to:
  /// **'участников'**
  String get chat_group_members_5_0;

  /// No description provided for @chat_online_status_long_ago.
  ///
  /// In ru, this message translates to:
  /// **'был(а) давно'**
  String get chat_online_status_long_ago;

  /// No description provided for @chat_online_status_online.
  ///
  /// In ru, this message translates to:
  /// **'в сети'**
  String get chat_online_status_online;

  /// No description provided for @chat_online_status_minutes_ago.
  ///
  /// In ru, this message translates to:
  /// **'был(а) {minutes} мин. назад'**
  String chat_online_status_minutes_ago(String minutes);

  /// No description provided for @chat_online_status_today_at.
  ///
  /// In ru, this message translates to:
  /// **'был(а) сегодня в {time}'**
  String chat_online_status_today_at(String time);

  /// No description provided for @chat_online_status_yesterday_at.
  ///
  /// In ru, this message translates to:
  /// **'был(а) вчера в {time}'**
  String chat_online_status_yesterday_at(String time);

  /// No description provided for @chat_online_status_date.
  ///
  /// In ru, this message translates to:
  /// **'был(а) {date}'**
  String chat_online_status_date(String date);

  /// No description provided for @chat_delete_dialog_title.
  ///
  /// In ru, this message translates to:
  /// **'Удалить чат?'**
  String get chat_delete_dialog_title;

  /// No description provided for @chat_delete_dialog_content.
  ///
  /// In ru, this message translates to:
  /// **'Этот чат будет удален для вас и вашего собеседника. Это действие необратимо.'**
  String get chat_delete_dialog_content;

  /// No description provided for @chat_delete_dialog_confirm.
  ///
  /// In ru, this message translates to:
  /// **'Удалить'**
  String get chat_delete_dialog_confirm;

  /// No description provided for @chat_report_dialog_title.
  ///
  /// In ru, this message translates to:
  /// **'Пожаловаться на {name}'**
  String chat_report_dialog_title(String name);

  /// No description provided for @chat_report_details_hint.
  ///
  /// In ru, this message translates to:
  /// **'Дополнительные детали (необязательно)'**
  String get chat_report_details_hint;

  /// No description provided for @chat_report_sent_snackbar.
  ///
  /// In ru, this message translates to:
  /// **'Спасибо! Ваша жалоба отправлена.'**
  String get chat_report_sent_snackbar;

  /// No description provided for @chat_menu_report.
  ///
  /// In ru, this message translates to:
  /// **'Пожаловаться'**
  String get chat_menu_report;

  /// No description provided for @chat_menu_delete.
  ///
  /// In ru, this message translates to:
  /// **'Удалить чат'**
  String get chat_menu_delete;

  /// No description provided for @chat_group_title_default.
  ///
  /// In ru, this message translates to:
  /// **'Общий чат'**
  String get chat_group_title_default;

  /// No description provided for @chat_group_participants.
  ///
  /// In ru, this message translates to:
  /// **'Участники'**
  String get chat_group_participants;

  /// No description provided for @chat_message_old.
  ///
  /// In ru, this message translates to:
  /// **'Сообщение из предыдущей версии'**
  String get chat_message_old;

  /// No description provided for @chat_input_hint.
  ///
  /// In ru, this message translates to:
  /// **'Сообщение...'**
  String get chat_input_hint;

  /// No description provided for @chat_temp_warning_remaining.
  ///
  /// In ru, this message translates to:
  /// **'Этот временный чат будет удален через '**
  String get chat_temp_warning_remaining;

  /// No description provided for @chat_temp_warning_expired.
  ///
  /// In ru, this message translates to:
  /// **'чат истек'**
  String get chat_temp_warning_expired;

  /// No description provided for @chat_temp_warning_less_than_24h.
  ///
  /// In ru, this message translates to:
  /// **'менее 24 часов'**
  String get chat_temp_warning_less_than_24h;

  /// No description provided for @encrypted_chat_banner_title.
  ///
  /// In ru, this message translates to:
  /// **'Переписка защищена'**
  String get encrypted_chat_banner_title;

  /// No description provided for @encrypted_chat_banner_desc.
  ///
  /// In ru, this message translates to:
  /// **'Сообщения в этом чате защищены сквозным шифрованием. Никто, даже администрация Aryonika, не может их прочитать.'**
  String get encrypted_chat_banner_desc;

  /// No description provided for @search_hint.
  ///
  /// In ru, this message translates to:
  /// **'Поиск по имени, био...'**
  String get search_hint;

  /// No description provided for @search_tooltip_swipes.
  ///
  /// In ru, this message translates to:
  /// **'Свайпы'**
  String get search_tooltip_swipes;

  /// No description provided for @search_tooltip_cosmic_web.
  ///
  /// In ru, this message translates to:
  /// **'Космический Веб'**
  String get search_tooltip_cosmic_web;

  /// No description provided for @search_tooltip_star_map.
  ///
  /// In ru, this message translates to:
  /// **'Звездная Карта'**
  String get search_tooltip_star_map;

  /// No description provided for @search_tooltip_filters.
  ///
  /// In ru, this message translates to:
  /// **'Фильтры'**
  String get search_tooltip_filters;

  /// No description provided for @search_star_map_placeholder.
  ///
  /// In ru, this message translates to:
  /// **'Звездная Карта в разработке...'**
  String get search_star_map_placeholder;

  /// No description provided for @search_priority_header.
  ///
  /// In ru, this message translates to:
  /// **'Наиболее подходящие'**
  String get search_priority_header;

  /// No description provided for @search_other_header.
  ///
  /// In ru, this message translates to:
  /// **'Другие пользователи'**
  String get search_other_header;

  /// No description provided for @payment_title.
  ///
  /// In ru, this message translates to:
  /// **'Поддержка проекта'**
  String get payment_title;

  /// No description provided for @payment_success_snackbar.
  ///
  /// In ru, this message translates to:
  /// **'Оплата прошла успешно! Обновляем ваш статус...'**
  String get payment_success_snackbar;

  /// No description provided for @payment_fail_snackbar.
  ///
  /// In ru, this message translates to:
  /// **'Оплата не удалась. Попробуйте снова.'**
  String get payment_fail_snackbar;

  /// No description provided for @paywall_header_title.
  ///
  /// In ru, this message translates to:
  /// **'Откройте Вселенную Aryonika'**
  String get paywall_header_title;

  /// No description provided for @paywall_header_subtitle.
  ///
  /// In ru, this message translates to:
  /// **'Поддержите проект и используйте все космические инструменты для поиска идеальной пары.'**
  String get paywall_header_subtitle;

  /// No description provided for @paywall_benefit1_title.
  ///
  /// In ru, this message translates to:
  /// **'Смотрите, кто вас лайкнул'**
  String get paywall_benefit1_title;

  /// No description provided for @paywall_benefit1_subtitle.
  ///
  /// In ru, this message translates to:
  /// **'Не упускайте шанс на взаимность и начните диалог первыми.'**
  String get paywall_benefit1_subtitle;

  /// No description provided for @paywall_benefit2_title.
  ///
  /// In ru, this message translates to:
  /// **'Персональный прогноз на день'**
  String get paywall_benefit2_title;

  /// No description provided for @paywall_benefit2_subtitle.
  ///
  /// In ru, this message translates to:
  /// **'Ежедневный анализ ваших транзитов и Фокус Дня.'**
  String get paywall_benefit2_subtitle;

  /// No description provided for @paywall_benefit3_title.
  ///
  /// In ru, this message translates to:
  /// **'Партнёр Дня и Рулетка'**
  String get paywall_benefit3_title;

  /// No description provided for @paywall_benefit3_subtitle.
  ///
  /// In ru, this message translates to:
  /// **'Позвольте звездам выбрать для вас наиболее совместимого партнера.'**
  String get paywall_benefit3_subtitle;

  /// No description provided for @paywall_benefit4_title.
  ///
  /// In ru, this message translates to:
  /// **'Ответ Вселенной'**
  String get paywall_benefit4_title;

  /// No description provided for @paywall_benefit4_subtitle.
  ///
  /// In ru, this message translates to:
  /// **'Задайте свой вопрос и получите космический совет.'**
  String get paywall_benefit4_subtitle;

  /// No description provided for @paywall_benefit5_title.
  ///
  /// In ru, this message translates to:
  /// **'Космическая погода'**
  String get paywall_benefit5_title;

  /// No description provided for @paywall_benefit5_subtitle.
  ///
  /// In ru, this message translates to:
  /// **'Будьте в курсе геомагнитных бурь и их влияния.'**
  String get paywall_benefit5_subtitle;

  /// No description provided for @paywall_benefit6_title.
  ///
  /// In ru, this message translates to:
  /// **'Карта Дня'**
  String get paywall_benefit6_title;

  /// No description provided for @paywall_benefit6_subtitle.
  ///
  /// In ru, this message translates to:
  /// **'Получайте ежедневное предсказание и совет от Карты Судьбы.'**
  String get paywall_benefit6_subtitle;

  /// No description provided for @paywall_donate_button.
  ///
  /// In ru, this message translates to:
  /// **'Поддержать проект'**
  String get paywall_donate_button;

  /// No description provided for @paywall_referral_button.
  ///
  /// In ru, this message translates to:
  /// **'Получить PRO за друзей'**
  String get paywall_referral_button;

  /// No description provided for @paywall_referral_subtitle.
  ///
  /// In ru, this message translates to:
  /// **'Пригласите друга и получите 1 день PRO-статуса за каждого, кто зарегистрируется по вашей ссылке.'**
  String get paywall_referral_subtitle;

  /// No description provided for @paywall_get_pro_button.
  ///
  /// In ru, this message translates to:
  /// **'Получить Aryonika PRO ({price})'**
  String paywall_get_pro_button(String price);

  /// No description provided for @paywall_arbitrary_donate_button.
  ///
  /// In ru, this message translates to:
  /// **'Поддержать другой суммой'**
  String get paywall_arbitrary_donate_button;

  /// No description provided for @paywall_arbitrary_donate_subtitle.
  ///
  /// In ru, this message translates to:
  /// **'Если вам понравился наш проект, вы можете поддержать его, чтобы помочь нам выжить в мире акул и других хищников.'**
  String get paywall_arbitrary_donate_subtitle;

  /// No description provided for @chinese_zodiac_title.
  ///
  /// In ru, this message translates to:
  /// **'Китайский гороскоп'**
  String get chinese_zodiac_title;

  /// No description provided for @zodiac_Rat.
  ///
  /// In ru, this message translates to:
  /// **'Крыса'**
  String get zodiac_Rat;

  /// No description provided for @zodiac_Ox.
  ///
  /// In ru, this message translates to:
  /// **'Бык'**
  String get zodiac_Ox;

  /// No description provided for @zodiac_Tiger.
  ///
  /// In ru, this message translates to:
  /// **'Тигр'**
  String get zodiac_Tiger;

  /// No description provided for @zodiac_Rabbit.
  ///
  /// In ru, this message translates to:
  /// **'Кролик'**
  String get zodiac_Rabbit;

  /// No description provided for @zodiac_Dragon.
  ///
  /// In ru, this message translates to:
  /// **'Дракон'**
  String get zodiac_Dragon;

  /// No description provided for @zodiac_Snake.
  ///
  /// In ru, this message translates to:
  /// **'Змея'**
  String get zodiac_Snake;

  /// No description provided for @zodiac_Horse.
  ///
  /// In ru, this message translates to:
  /// **'Лошадь'**
  String get zodiac_Horse;

  /// No description provided for @zodiac_Goat.
  ///
  /// In ru, this message translates to:
  /// **'Коза'**
  String get zodiac_Goat;

  /// No description provided for @zodiac_Monkey.
  ///
  /// In ru, this message translates to:
  /// **'Обезьяна'**
  String get zodiac_Monkey;

  /// No description provided for @zodiac_Rooster.
  ///
  /// In ru, this message translates to:
  /// **'Петух'**
  String get zodiac_Rooster;

  /// No description provided for @zodiac_Dog.
  ///
  /// In ru, this message translates to:
  /// **'Собака'**
  String get zodiac_Dog;

  /// No description provided for @zodiac_Pig.
  ///
  /// In ru, this message translates to:
  /// **'Свинья'**
  String get zodiac_Pig;

  /// No description provided for @chinese_zodiac_compatibility_button.
  ///
  /// In ru, this message translates to:
  /// **'Совместимость по гороскопу'**
  String get chinese_zodiac_compatibility_button;

  /// No description provided for @compatibility_section_title.
  ///
  /// In ru, this message translates to:
  /// **'Совместимость'**
  String get compatibility_section_title;

  /// No description provided for @userProfile_astro_button.
  ///
  /// In ru, this message translates to:
  /// **'Астрология'**
  String get userProfile_astro_button;

  /// No description provided for @userProfile_bazi_button.
  ///
  /// In ru, this message translates to:
  /// **'Бацзы'**
  String get userProfile_bazi_button;

  /// No description provided for @jyotishCompatibilityTitle.
  ///
  /// In ru, this message translates to:
  /// **'Ведическая совместимость'**
  String get jyotishCompatibilityTitle;

  /// No description provided for @jyotishDetailedAnalysisTitle.
  ///
  /// In ru, this message translates to:
  /// **'Детальный анализ (Ашта-Кута)'**
  String get jyotishDetailedAnalysisTitle;

  /// No description provided for @kuta_tara_name.
  ///
  /// In ru, this message translates to:
  /// **'Тара Кута (Судьба)'**
  String get kuta_tara_name;

  /// No description provided for @kuta_tara_desc.
  ///
  /// In ru, this message translates to:
  /// **'Показывает удачу, продолжительность и благополучие в отношениях. Хорошая совместимость здесь — как попутный ветер для вашего союза.'**
  String get kuta_tara_desc;

  /// No description provided for @kuta_yoni_name.
  ///
  /// In ru, this message translates to:
  /// **'Йони Кута (Влечение)'**
  String get kuta_yoni_name;

  /// No description provided for @kuta_yoni_desc.
  ///
  /// In ru, this message translates to:
  /// **'Определяет физическую и сексуальную гармонию. Высокий балл указывает на сильное взаимное притяжение и удовлетворенность.'**
  String get kuta_yoni_desc;

  /// No description provided for @kuta_graha_maitri_name.
  ///
  /// In ru, this message translates to:
  /// **'Граха Майтри (Дружба)'**
  String get kuta_graha_maitri_name;

  /// No description provided for @kuta_graha_maitri_desc.
  ///
  /// In ru, this message translates to:
  /// **'Психологическая совместимость и дружба. Отражает, насколько схожи ваши взгляды на жизнь и легко ли вам находить общий язык.'**
  String get kuta_graha_maitri_desc;

  /// No description provided for @kuta_vashya_name.
  ///
  /// In ru, this message translates to:
  /// **'Вашья Кута (Взаимный контроль)'**
  String get kuta_vashya_name;

  /// No description provided for @kuta_vashya_desc.
  ///
  /// In ru, this message translates to:
  /// **'Показывает степень взаимного влияния и магнетизма в паре. Кто будет ведущим, а кто ведомым.'**
  String get kuta_vashya_desc;

  /// No description provided for @kuta_gana_name.
  ///
  /// In ru, this message translates to:
  /// **'Гана Кута (Темперамент)'**
  String get kuta_gana_name;

  /// No description provided for @kuta_gana_desc.
  ///
  /// In ru, this message translates to:
  /// **'Совместимость на уровне темперамента (Божественный, Человеческий, Демонический). Помогает избежать конфликтов характеров.'**
  String get kuta_gana_desc;

  /// No description provided for @kuta_bhakoot_name.
  ///
  /// In ru, this message translates to:
  /// **'Бхакут Кута (Любовь и Семья)'**
  String get kuta_bhakoot_name;

  /// No description provided for @kuta_bhakoot_desc.
  ///
  /// In ru, this message translates to:
  /// **'Один из самых важных показателей. Отвечает за глубину любви, семейное счастье, финансовое процветание и возможность иметь детей.'**
  String get kuta_bhakoot_desc;

  /// No description provided for @kuta_nadi_name.
  ///
  /// In ru, this message translates to:
  /// **'Нади Кута (Здоровье)'**
  String get kuta_nadi_name;

  /// No description provided for @kuta_nadi_desc.
  ///
  /// In ru, this message translates to:
  /// **'Самый весомый критерий. Отвечает за здоровье, генетическую совместимость и долголетие партнеров и их потомства.'**
  String get kuta_nadi_desc;

  /// No description provided for @kuta_varna_name.
  ///
  /// In ru, this message translates to:
  /// **'Варна Кута (Духовность)'**
  String get kuta_varna_name;

  /// No description provided for @kuta_varna_desc.
  ///
  /// In ru, this message translates to:
  /// **'Отражает совместимость эго и духовное развитие партнеров. Показывает, кто в паре будет больше стимулировать рост другого.'**
  String get kuta_varna_desc;

  /// No description provided for @jyotishVerdictExcellent.
  ///
  /// In ru, this message translates to:
  /// **'Небесный союз! Ваши лунные знаки находятся в идеальной гармонии. Эта связь обещает глубокое понимание, духовный рост и счастье на долгие годы.'**
  String get jyotishVerdictExcellent;

  /// No description provided for @jyotishVerdictGood.
  ///
  /// In ru, this message translates to:
  /// **'Очень хорошая совместимость. У вас есть все шансы построить крепкие, гармоничные и счастливые отношения. Мелкие разногласия легко преодолимы.'**
  String get jyotishVerdictGood;

  /// No description provided for @jyotishVerdictAverage.
  ///
  /// In ru, this message translates to:
  /// **'Нормальная совместимость. В ваших отношениях есть как сильные стороны, так и зоны роста. Успех союза будет зависеть от вашей готовности работать над отношениями.'**
  String get jyotishVerdictAverage;

  /// No description provided for @jyotishVerdictChallenging.
  ///
  /// In ru, this message translates to:
  /// **'Сложная совместимость. Ваши карты указывают на серьезные различия в характерах и жизненных путях. Потребуется много терпения и компромиссов, чтобы достичь гармонии.'**
  String get jyotishVerdictChallenging;

  /// No description provided for @passwordResetNewPasswordTitle.
  ///
  /// In ru, this message translates to:
  /// **'Установите новый пароль'**
  String get passwordResetNewPasswordTitle;

  /// No description provided for @passwordResetNewPasswordLabel.
  ///
  /// In ru, this message translates to:
  /// **'Новый пароль'**
  String get passwordResetNewPasswordLabel;

  /// No description provided for @passwordResetConfirmLabel.
  ///
  /// In ru, this message translates to:
  /// **'Подтвердите пароль'**
  String get passwordResetConfirmLabel;

  /// No description provided for @passwordValidationError.
  ///
  /// In ru, this message translates to:
  /// **'Пароль должен быть не менее 6 символов'**
  String get passwordValidationError;

  /// No description provided for @passwordMismatchError.
  ///
  /// In ru, this message translates to:
  /// **'Пароли не совпадают'**
  String get passwordMismatchError;

  /// No description provided for @saveButton.
  ///
  /// In ru, this message translates to:
  /// **'Сохранить'**
  String get saveButton;

  /// No description provided for @postActionLike.
  ///
  /// In ru, this message translates to:
  /// **'Нравится'**
  String get postActionLike;

  /// No description provided for @postActionComment.
  ///
  /// In ru, this message translates to:
  /// **'Комментарий'**
  String get postActionComment;

  /// No description provided for @postActionShare.
  ///
  /// In ru, this message translates to:
  /// **'Поделиться'**
  String get postActionShare;

  /// No description provided for @channelDefaultName.
  ///
  /// In ru, this message translates to:
  /// **'канал'**
  String get channelDefaultName;

  /// No description provided for @postShareText.
  ///
  /// In ru, this message translates to:
  /// **'Посмотри пост в канале \"{channelName}\": {postText}'**
  String postShareText(Object channelName, Object postText);

  /// No description provided for @postDeleteDialogTitle.
  ///
  /// In ru, this message translates to:
  /// **'Удалить пост?'**
  String get postDeleteDialogTitle;

  /// No description provided for @postDeleteDialogContent.
  ///
  /// In ru, this message translates to:
  /// **'Это действие нельзя будет отменить.'**
  String get postDeleteDialogContent;

  /// No description provided for @delete.
  ///
  /// In ru, this message translates to:
  /// **'Удалить'**
  String get delete;

  /// No description provided for @postMenuDelete.
  ///
  /// In ru, this message translates to:
  /// **'Удалить пост'**
  String get postMenuDelete;

  /// No description provided for @numerologySectionKeyNumbers.
  ///
  /// In ru, this message translates to:
  /// **'Ключевые числа'**
  String get numerologySectionKeyNumbers;

  /// No description provided for @numerologySectionCurrentVibes.
  ///
  /// In ru, this message translates to:
  /// **'Текущие вибрации'**
  String get numerologySectionCurrentVibes;

  /// No description provided for @numerologyTitleLifePath.
  ///
  /// In ru, this message translates to:
  /// **'Число Жизненного Пути'**
  String get numerologyTitleLifePath;

  /// No description provided for @numerologyTitleDestiny.
  ///
  /// In ru, this message translates to:
  /// **'Число Судьбы (Экспрессии)'**
  String get numerologyTitleDestiny;

  /// No description provided for @numerologyTitleSoulUrge.
  ///
  /// In ru, this message translates to:
  /// **'Число Души'**
  String get numerologyTitleSoulUrge;

  /// No description provided for @numerologyTitlePersonality.
  ///
  /// In ru, this message translates to:
  /// **'Число Личности'**
  String get numerologyTitlePersonality;

  /// No description provided for @numerologyTitleMaturity.
  ///
  /// In ru, this message translates to:
  /// **'Число Зрелости'**
  String get numerologyTitleMaturity;

  /// No description provided for @numerologyTitleBirthday.
  ///
  /// In ru, this message translates to:
  /// **'Число Дня Рождения'**
  String get numerologyTitleBirthday;

  /// No description provided for @numerologyTitlePersonalYear.
  ///
  /// In ru, this message translates to:
  /// **'Личный Год'**
  String get numerologyTitlePersonalYear;

  /// No description provided for @numerologyTitlePersonalMonth.
  ///
  /// In ru, this message translates to:
  /// **'Личный Месяц'**
  String get numerologyTitlePersonalMonth;

  /// No description provided for @numerologyTitlePersonalDay.
  ///
  /// In ru, this message translates to:
  /// **'Личный День'**
  String get numerologyTitlePersonalDay;

  /// No description provided for @numerologyErrorNotEnoughData.
  ///
  /// In ru, this message translates to:
  /// **'Недостаточно данных для расчета.'**
  String get numerologyErrorNotEnoughData;

  /// No description provided for @numerologyErrorDescriptionsNotLoaded.
  ///
  /// In ru, this message translates to:
  /// **'Не удалось загрузить описания для нумерологии'**
  String get numerologyErrorDescriptionsNotLoaded;

  /// No description provided for @chat_error_recipient_not_found.
  ///
  /// In ru, this message translates to:
  /// **'Собеседник не найден.'**
  String get chat_error_recipient_not_found;

  /// No description provided for @chat_error_recipient_profile_load_failed.
  ///
  /// In ru, this message translates to:
  /// **'Не удалось загрузить профиль собеседника.'**
  String get chat_error_recipient_profile_load_failed;

  /// No description provided for @calculatingNumerology.
  ///
  /// In ru, this message translates to:
  /// **'Рассчитываем нумерологический портрет...'**
  String get calculatingNumerology;

  /// No description provided for @oracle_title.
  ///
  /// In ru, this message translates to:
  /// **'Оракул'**
  String get oracle_title;

  /// No description provided for @verifyEmailBody.
  ///
  /// In ru, this message translates to:
  /// **'Мы отправили 6-значный код на ваш email. Пожалуйста, введите его ниже.'**
  String get verifyEmailBody;

  /// No description provided for @verifyEmailHint.
  ///
  /// In ru, this message translates to:
  /// **'------'**
  String get verifyEmailHint;

  /// No description provided for @signOutButton.
  ///
  /// In ru, this message translates to:
  /// **'Выйти'**
  String get signOutButton;

  /// No description provided for @errorInvalidOrExpiredCode.
  ///
  /// In ru, this message translates to:
  /// **'Неверный или просроченный код подтверждения. Попробуйте снова.'**
  String get errorInvalidOrExpiredCode;

  /// No description provided for @errorCodeRequired.
  ///
  /// In ru, this message translates to:
  /// **'Пожалуйста, введите код подтверждения.'**
  String get errorCodeRequired;

  /// No description provided for @errorInternalServer.
  ///
  /// In ru, this message translates to:
  /// **'Произошла внутренняя ошибка сервера. Попробуйте позже.'**
  String get errorInternalServer;

  /// No description provided for @errorCodeLength.
  ///
  /// In ru, this message translates to:
  /// **'Код должен состоять из 6 цифр.'**
  String get errorCodeLength;

  /// No description provided for @verifyEmailTitle.
  ///
  /// In ru, this message translates to:
  /// **'Подтверждение E-mail'**
  String get verifyEmailTitle;

  /// No description provided for @verificationCodeLabel.
  ///
  /// In ru, this message translates to:
  /// **'Код подтверждения'**
  String get verificationCodeLabel;

  /// No description provided for @verificationCodeResent.
  ///
  /// In ru, this message translates to:
  /// **'Новый код подтверждения отправлен!'**
  String get verificationCodeResent;

  /// No description provided for @resendCodeAction.
  ///
  /// In ru, this message translates to:
  /// **'Отправить код еще раз'**
  String get resendCodeAction;

  /// No description provided for @resendCodeCooldown.
  ///
  /// In ru, this message translates to:
  /// **'Отправить еще раз через ({seconds})'**
  String resendCodeCooldown(int seconds);

  /// No description provided for @verifyEmailInstruction.
  ///
  /// In ru, this message translates to:
  /// **'Мы отправили 6-значный код на ваш E-mail:\n{email}\nПожалуйста, введите его ниже.'**
  String verifyEmailInstruction(String email);

  /// No description provided for @confirmButton.
  ///
  /// In ru, this message translates to:
  /// **'Подтвердить'**
  String get confirmButton;

  /// No description provided for @logout.
  ///
  /// In ru, this message translates to:
  /// **'Выйти'**
  String get logout;

  /// No description provided for @numerology_score_high.
  ///
  /// In ru, this message translates to:
  /// **'Высокая'**
  String get numerology_score_high;

  /// No description provided for @numerology_score_medium.
  ///
  /// In ru, this message translates to:
  /// **'Средняя'**
  String get numerology_score_medium;

  /// No description provided for @numerology_score_low.
  ///
  /// In ru, this message translates to:
  /// **'Низкая'**
  String get numerology_score_low;

  /// No description provided for @noUsersFound.
  ///
  /// In ru, this message translates to:
  /// **'По вашему запросу никого не найдено. Попробуйте изменить фильтры.'**
  String get noUsersFound;

  /// No description provided for @feature_in_development.
  ///
  /// In ru, this message translates to:
  /// **'Этот раздел находится в разработке.'**
  String get feature_in_development;

  /// No description provided for @download_our_app.
  ///
  /// In ru, this message translates to:
  /// **'Скачайте наше приложение'**
  String get download_our_app;

  /// No description provided for @open_web_version.
  ///
  /// In ru, this message translates to:
  /// **'Открыть WEB версию'**
  String get open_web_version;

  /// No description provided for @pay_with_card.
  ///
  /// In ru, this message translates to:
  /// **'Оплатить картой'**
  String get pay_with_card;

  /// No description provided for @coming_soon.
  ///
  /// In ru, this message translates to:
  /// **'Скоро'**
  String get coming_soon;

  /// No description provided for @paywall_subscription_terms.
  ///
  /// In ru, this message translates to:
  /// **'Подписка продлевается автоматически. Отмена в любое время.'**
  String get paywall_subscription_terms;

  /// No description provided for @searchHint.
  ///
  /// In ru, this message translates to:
  /// **'Поиск...'**
  String get searchHint;

  /// No description provided for @nav_friends.
  ///
  /// In ru, this message translates to:
  /// **'Друзья'**
  String get nav_friends;

  /// No description provided for @oracle_typing.
  ///
  /// In ru, this message translates to:
  /// **'печатает...'**
  String get oracle_typing;

  /// No description provided for @tarot_reversed.
  ///
  /// In ru, this message translates to:
  /// **'(Перевернутая)'**
  String get tarot_reversed;

  /// No description provided for @common_close.
  ///
  /// In ru, this message translates to:
  /// **'Закрыть'**
  String get common_close;

  /// No description provided for @oracle_limit_pro.
  ///
  /// In ru, this message translates to:
  /// **'До следующего запроса осталось {hours} ч.'**
  String oracle_limit_pro(Object hours);

  /// No description provided for @oracle_limit_free.
  ///
  /// In ru, this message translates to:
  /// **'Вы использовали бесплатный лимит. До следующего запроса осталось {days} дн.'**
  String oracle_limit_free(Object days);

  /// No description provided for @oracle_error_stream.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка соединения'**
  String get oracle_error_stream;

  /// No description provided for @oracle_error_start.
  ///
  /// In ru, this message translates to:
  /// **'Не удалось начать'**
  String get oracle_error_start;

  /// No description provided for @error_generic.
  ///
  /// In ru, this message translates to:
  /// **'Произошла ошибка. Попробуйте позже.'**
  String get error_generic;

  /// No description provided for @referral_already_used.
  ///
  /// In ru, this message translates to:
  /// **'Вы уже использовали реферальный код.'**
  String get referral_already_used;

  /// No description provided for @referral_own_code.
  ///
  /// In ru, this message translates to:
  /// **'Нельзя использовать свой собственный код.'**
  String get referral_own_code;

  /// No description provided for @referral_success.
  ///
  /// In ru, this message translates to:
  /// **'Код успешно активирован! Вам начислено 3 дня Premium.'**
  String get referral_success;

  /// No description provided for @tab_astrology.
  ///
  /// In ru, this message translates to:
  /// **'Астрология'**
  String get tab_astrology;

  /// No description provided for @tab_numerology.
  ///
  /// In ru, this message translates to:
  /// **'Нумерология'**
  String get tab_numerology;

  /// No description provided for @tab_bazi.
  ///
  /// In ru, this message translates to:
  /// **'Бацзы'**
  String get tab_bazi;

  /// No description provided for @tab_jyotish.
  ///
  /// In ru, this message translates to:
  /// **'Джйотиш'**
  String get tab_jyotish;

  /// No description provided for @share_result.
  ///
  /// In ru, this message translates to:
  /// **'Поделиться результатом'**
  String get share_result;

  /// No description provided for @share_preparing.
  ///
  /// In ru, this message translates to:
  /// **'Подготовка...'**
  String get share_preparing;

  /// No description provided for @locked_feature_title.
  ///
  /// In ru, this message translates to:
  /// **'Раздел {title} закрыт'**
  String locked_feature_title(Object title);

  /// No description provided for @locked_feature_desc.
  ///
  /// In ru, this message translates to:
  /// **'Оформите подписку, чтобы увидеть детальный разбор.'**
  String get locked_feature_desc;

  /// No description provided for @get_access_button.
  ///
  /// In ru, this message translates to:
  /// **'Получить доступ'**
  String get get_access_button;

  /// No description provided for @coming_soon_suffix.
  ///
  /// In ru, this message translates to:
  /// **'(Скоро)'**
  String get coming_soon_suffix;

  /// No description provided for @tab_summary.
  ///
  /// In ru, this message translates to:
  /// **'Сводка'**
  String get tab_summary;

  /// No description provided for @tab_chinese_zodiac.
  ///
  /// In ru, this message translates to:
  /// **'Кит. Зодиак'**
  String get tab_chinese_zodiac;

  /// No description provided for @summary_verdict_title.
  ///
  /// In ru, this message translates to:
  /// **'Общий вердикт'**
  String get summary_verdict_title;

  /// No description provided for @webVersionButton.
  ///
  /// In ru, this message translates to:
  /// **'Веб-версия'**
  String get webVersionButton;

  /// No description provided for @uploadPhotoDisclaimer.
  ///
  /// In ru, this message translates to:
  /// **'Загружая фото, вы подтверждаете, что оно не содержит наготы или насилия. Нарушители будут заблокированы навсегда.'**
  String get uploadPhotoDisclaimer;

  /// No description provided for @iAgree.
  ///
  /// In ru, this message translates to:
  /// **'Согласен'**
  String get iAgree;

  /// No description provided for @testers_banner_title.
  ///
  /// In ru, this message translates to:
  /// **'ИЩЕМ ТЕСТИРОВЩИКОВ (4/20)'**
  String get testers_banner_title;

  /// No description provided for @testers_banner_desc.
  ///
  /// In ru, this message translates to:
  /// **'Помогите улучшить Aryonika и получите\n✨ ВЕЧНЫЙ ПРЕМИУМ ✨'**
  String get testers_banner_desc;

  /// No description provided for @testers_email_hint.
  ///
  /// In ru, this message translates to:
  /// **'(Нажмите, чтобы открыть; Удерживайте, чтобы скопировать)'**
  String get testers_email_hint;

  /// No description provided for @numerology_day_1.
  ///
  /// In ru, this message translates to:
  /// **'День начинаний. Идеально для старта проектов.'**
  String get numerology_day_1;

  /// No description provided for @numerology_day_2.
  ///
  /// In ru, this message translates to:
  /// **'День партнерства. Ищите компромиссы.'**
  String get numerology_day_2;

  /// No description provided for @numerology_day_3.
  ///
  /// In ru, this message translates to:
  /// **'День творчества и самовыражения.'**
  String get numerology_day_3;

  /// No description provided for @numerology_day_4.
  ///
  /// In ru, this message translates to:
  /// **'День труда и организации. Наведите порядок.'**
  String get numerology_day_4;

  /// No description provided for @numerology_day_5.
  ///
  /// In ru, this message translates to:
  /// **'День перемен и приключений. Рискуйте.'**
  String get numerology_day_5;

  /// No description provided for @numerology_day_6.
  ///
  /// In ru, this message translates to:
  /// **'День семьи и гармонии.'**
  String get numerology_day_6;

  /// No description provided for @numerology_day_7.
  ///
  /// In ru, this message translates to:
  /// **'День размышлений и уединения.'**
  String get numerology_day_7;

  /// No description provided for @numerology_day_8.
  ///
  /// In ru, this message translates to:
  /// **'День силы и денег. Действуйте масштабно.'**
  String get numerology_day_8;

  /// No description provided for @numerology_day_9.
  ///
  /// In ru, this message translates to:
  /// **'День завершения дел. Отпустите старое.'**
  String get numerology_day_9;

  /// No description provided for @astro_transit_positive_general.
  ///
  /// In ru, this message translates to:
  /// **'Звезды на вашей стороне. Действуйте смело.'**
  String get astro_transit_positive_general;

  /// No description provided for @advice_general_balance.
  ///
  /// In ru, this message translates to:
  /// **'Сохраняйте баланс между чувствами и разумом.'**
  String get advice_general_balance;

  /// No description provided for @astro_advice_listen_intuition.
  ///
  /// In ru, this message translates to:
  /// **'Луна усиливает вашу интуицию. Слушайте внутренний голос.'**
  String get astro_advice_listen_intuition;

  /// No description provided for @astro_advice_act_boldly.
  ///
  /// In ru, this message translates to:
  /// **'Энергия планет способствует действиям. Не бойтесь проявлять смелость.'**
  String get astro_advice_act_boldly;

  /// No description provided for @astro_advice_rest_and_reflect.
  ///
  /// In ru, this message translates to:
  /// **'Звезды советуют замедлиться. Найдите время для отдыха и восстановления.'**
  String get astro_advice_rest_and_reflect;

  /// No description provided for @astro_advice_connect_with_nature.
  ///
  /// In ru, this message translates to:
  /// **'Благоприятное время для заземления. Проведите время на природе.'**
  String get astro_advice_connect_with_nature;

  /// No description provided for @advice_generic_positive.
  ///
  /// In ru, this message translates to:
  /// **'Сегодня Вселенная на вашей стороне. Действуйте осознанно.'**
  String get advice_generic_positive;

  /// No description provided for @channelLoadError.
  ///
  /// In ru, this message translates to:
  /// **'Не удалось загрузить канал'**
  String get channelLoadError;

  /// No description provided for @postsTitle.
  ///
  /// In ru, this message translates to:
  /// **'Публикации'**
  String get postsTitle;

  /// No description provided for @noPostsYet.
  ///
  /// In ru, this message translates to:
  /// **'В этом канале пока нет публикаций.'**
  String get noPostsYet;

  /// No description provided for @createPostTooltip.
  ///
  /// In ru, this message translates to:
  /// **'Создать пост'**
  String get createPostTooltip;

  /// No description provided for @proposePost.
  ///
  /// In ru, this message translates to:
  /// **'Предложить новость'**
  String get proposePost;

  /// No description provided for @channelsTitle.
  ///
  /// In ru, this message translates to:
  /// **'Каналы'**
  String get channelsTitle;

  /// No description provided for @noChannelSubscriptions.
  ///
  /// In ru, this message translates to:
  /// **'У вас пока нет подписок'**
  String get noChannelSubscriptions;

  /// No description provided for @noMessagesYet.
  ///
  /// In ru, this message translates to:
  /// **'Нет сообщений'**
  String get noMessagesYet;

  /// No description provided for @yesterday.
  ///
  /// In ru, this message translates to:
  /// **'Вчера'**
  String get yesterday;

  /// No description provided for @search.
  ///
  /// In ru, this message translates to:
  /// **'Поиск'**
  String get search;

  /// No description provided for @adminOnlyFeature.
  ///
  /// In ru, this message translates to:
  /// **'Создание каналов временно доступно только администраторам.'**
  String get adminOnlyFeature;

  /// No description provided for @createChannel.
  ///
  /// In ru, this message translates to:
  /// **'Создать канал'**
  String get createChannel;

  /// No description provided for @galacticBroadcasts.
  ///
  /// In ru, this message translates to:
  /// **'Галактические Трансляции'**
  String get galacticBroadcasts;

  /// No description provided for @noChannelsYet.
  ///
  /// In ru, this message translates to:
  /// **'Вы пока ни на что не подписаны.\nНайдите или создайте свой канал!'**
  String get noChannelsYet;

  /// No description provided for @constellationsTitle.
  ///
  /// In ru, this message translates to:
  /// **'Созвездия'**
  String get constellationsTitle;

  /// No description provided for @privateChatsTab.
  ///
  /// In ru, this message translates to:
  /// **'Личные'**
  String get privateChatsTab;

  /// No description provided for @channelsTab.
  ///
  /// In ru, this message translates to:
  /// **'Каналы'**
  String get channelsTab;

  /// No description provided for @loadingUser.
  ///
  /// In ru, this message translates to:
  /// **'Загрузка пользователя...'**
  String get loadingUser;

  /// No description provided for @emptyChatsPlaceholder.
  ///
  /// In ru, this message translates to:
  /// **'Здесь будут ваши личные чаты.\nНайдите кого-нибудь интересного через поиск!'**
  String get emptyChatsPlaceholder;

  /// No description provided for @errorTitle.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка'**
  String get errorTitle;

  /// No description provided for @autoDeleteMessages.
  ///
  /// In ru, this message translates to:
  /// **'Автоудаление сообщений'**
  String get autoDeleteMessages;

  /// No description provided for @availableInPro.
  ///
  /// In ru, this message translates to:
  /// **'Доступно в PRO'**
  String get availableInPro;

  /// No description provided for @timerOff.
  ///
  /// In ru, this message translates to:
  /// **'Отключено'**
  String get timerOff;

  /// No description provided for @timer15min.
  ///
  /// In ru, this message translates to:
  /// **'15 минут'**
  String get timer15min;

  /// No description provided for @timer1hour.
  ///
  /// In ru, this message translates to:
  /// **'1 час'**
  String get timer1hour;

  /// No description provided for @timer4hours.
  ///
  /// In ru, this message translates to:
  /// **'4 часа'**
  String get timer4hours;

  /// No description provided for @timer24hours.
  ///
  /// In ru, this message translates to:
  /// **'24 часа'**
  String get timer24hours;

  /// No description provided for @timerSet.
  ///
  /// In ru, this message translates to:
  /// **'Таймер установлен'**
  String get timerSet;

  /// No description provided for @disappearingMessages.
  ///
  /// In ru, this message translates to:
  /// **'Исчезающие сообщения'**
  String get disappearingMessages;

  /// No description provided for @communicationTitle.
  ///
  /// In ru, this message translates to:
  /// **'Общение'**
  String get communicationTitle;

  /// No description provided for @errorLoadingReport.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка загрузки отчета'**
  String get errorLoadingReport;

  /// No description provided for @compatibility.
  ///
  /// In ru, this message translates to:
  /// **'Совместимость'**
  String get compatibility;

  /// No description provided for @strengths.
  ///
  /// In ru, this message translates to:
  /// **'Сильные стороны'**
  String get strengths;

  /// No description provided for @weaknesses.
  ///
  /// In ru, this message translates to:
  /// **'Возможные трудности'**
  String get weaknesses;

  /// No description provided for @commentsTitle.
  ///
  /// In ru, this message translates to:
  /// **'Комментарии'**
  String get commentsTitle;

  /// No description provided for @commentsLoadError.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка загрузки комментариев.'**
  String get commentsLoadError;

  /// No description provided for @noCommentsYet.
  ///
  /// In ru, this message translates to:
  /// **'Здесь пока нет комментариев.'**
  String get noCommentsYet;

  /// No description provided for @userIsTyping.
  ///
  /// In ru, this message translates to:
  /// **'{name} печатает...'**
  String userIsTyping(Object name);

  /// No description provided for @twoUsersTyping.
  ///
  /// In ru, this message translates to:
  /// **'{name1} и {name2} печатают...'**
  String twoUsersTyping(Object name1, Object name2);

  /// No description provided for @manyUsersTyping.
  ///
  /// In ru, this message translates to:
  /// **'{name1}, {name2} и еще {count} печатают...'**
  String manyUsersTyping(Object count, Object name1, Object name2);

  /// No description provided for @replyingTo.
  ///
  /// In ru, this message translates to:
  /// **'Ответ для {name}'**
  String replyingTo(Object name);

  /// No description provided for @writeCommentHint.
  ///
  /// In ru, this message translates to:
  /// **'Написать комментарий...'**
  String get writeCommentHint;

  /// No description provided for @compatibilityTitle.
  ///
  /// In ru, this message translates to:
  /// **'Космическая Связь'**
  String get compatibilityTitle;

  /// No description provided for @noData.
  ///
  /// In ru, this message translates to:
  /// **'Нет данных'**
  String get noData;

  /// No description provided for @westernAstrology.
  ///
  /// In ru, this message translates to:
  /// **'Западная Астрология'**
  String get westernAstrology;

  /// No description provided for @vedicAstrology.
  ///
  /// In ru, this message translates to:
  /// **'Ведическая (Джйотиш)'**
  String get vedicAstrology;

  /// No description provided for @numerology.
  ///
  /// In ru, this message translates to:
  /// **'Нумерология'**
  String get numerology;

  /// No description provided for @chineseZodiac.
  ///
  /// In ru, this message translates to:
  /// **'Китайский Зодиак'**
  String get chineseZodiac;

  /// No description provided for @baziElements.
  ///
  /// In ru, this message translates to:
  /// **'Бацзы (Стихии)'**
  String get baziElements;

  /// No description provided for @availableInPremium.
  ///
  /// In ru, this message translates to:
  /// **'Доступно в Premium'**
  String get availableInPremium;

  /// No description provided for @verdictSoulmates.
  ///
  /// In ru, this message translates to:
  /// **'Родственные Души'**
  String get verdictSoulmates;

  /// No description provided for @verdictGreatMatch.
  ///
  /// In ru, this message translates to:
  /// **'Отличная Пара'**
  String get verdictGreatMatch;

  /// No description provided for @verdictPotential.
  ///
  /// In ru, this message translates to:
  /// **'Есть Потенциал'**
  String get verdictPotential;

  /// No description provided for @verdictKarmic.
  ///
  /// In ru, this message translates to:
  /// **'Кармический Урок'**
  String get verdictKarmic;

  /// No description provided for @createChannelTitle.
  ///
  /// In ru, this message translates to:
  /// **'Создание Трансляции'**
  String get createChannelTitle;

  /// No description provided for @channelNameLabel.
  ///
  /// In ru, this message translates to:
  /// **'Название трансляции'**
  String get channelNameLabel;

  /// No description provided for @channelNameHint.
  ///
  /// In ru, this message translates to:
  /// **'Например, \'Ежедневные прогнозы Карт Судьбы\''**
  String get channelNameHint;

  /// No description provided for @errorChannelNameEmpty.
  ///
  /// In ru, this message translates to:
  /// **'Название не может быть пустым'**
  String get errorChannelNameEmpty;

  /// No description provided for @channelHandleLabel.
  ///
  /// In ru, this message translates to:
  /// **'Уникальный ID (@handle)'**
  String get channelHandleLabel;

  /// No description provided for @errorChannelHandleShort.
  ///
  /// In ru, this message translates to:
  /// **'ID должен быть длиннее 4 символов'**
  String get errorChannelHandleShort;

  /// No description provided for @channelDescriptionLabel.
  ///
  /// In ru, this message translates to:
  /// **'Описание'**
  String get channelDescriptionLabel;

  /// No description provided for @channelDescriptionHint.
  ///
  /// In ru, this message translates to:
  /// **'Расскажите, о чем ваш канал...'**
  String get channelDescriptionHint;

  /// No description provided for @errorChannelDescriptionEmpty.
  ///
  /// In ru, this message translates to:
  /// **'Добавьте описание'**
  String get errorChannelDescriptionEmpty;

  /// No description provided for @createButton.
  ///
  /// In ru, this message translates to:
  /// **'Создать'**
  String get createButton;

  /// No description provided for @editProfileTitle.
  ///
  /// In ru, this message translates to:
  /// **'Редактирование профиля'**
  String get editProfileTitle;

  /// No description provided for @profileNotFoundError.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка: профиль не найден'**
  String get profileNotFoundError;

  /// No description provided for @profileSavedSuccess.
  ///
  /// In ru, this message translates to:
  /// **'Профиль успешно сохранен!'**
  String get profileSavedSuccess;

  /// No description provided for @saveError.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка сохранения'**
  String get saveError;

  /// No description provided for @avatarUploadError.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка загрузки фото'**
  String get avatarUploadError;

  /// No description provided for @nameLabel.
  ///
  /// In ru, this message translates to:
  /// **'Имя'**
  String get nameLabel;

  /// No description provided for @bioLabel.
  ///
  /// In ru, this message translates to:
  /// **'О себе'**
  String get bioLabel;

  /// No description provided for @birthDataTitle.
  ///
  /// In ru, this message translates to:
  /// **'Данные рождения'**
  String get birthDataTitle;

  /// No description provided for @birthDataWarning.
  ///
  /// In ru, this message translates to:
  /// **'Изменение этих данных приведет к полному пересчету вашего астрологического и нумерологического портрета.'**
  String get birthDataWarning;

  /// No description provided for @birthDateLabel.
  ///
  /// In ru, this message translates to:
  /// **'Дата рождения'**
  String get birthDateLabel;

  /// No description provided for @birthPlaceLabel.
  ///
  /// In ru, this message translates to:
  /// **'Место рождения'**
  String get birthPlaceLabel;

  /// No description provided for @errorUserNotFound.
  ///
  /// In ru, this message translates to:
  /// **'Error: User not found'**
  String get errorUserNotFound;

  /// No description provided for @feedUpdateError.
  ///
  /// In ru, this message translates to:
  /// **'Feed update error'**
  String get feedUpdateError;

  /// No description provided for @feedEmptyMessage.
  ///
  /// In ru, this message translates to:
  /// **'Your feed is empty.\nPull down to refresh.'**
  String get feedEmptyMessage;

  /// No description provided for @whereToSearch.
  ///
  /// In ru, this message translates to:
  /// **'Где искать'**
  String get whereToSearch;

  /// No description provided for @searchNearby.
  ///
  /// In ru, this message translates to:
  /// **'Рядом'**
  String get searchNearby;

  /// No description provided for @searchCity.
  ///
  /// In ru, this message translates to:
  /// **'Город'**
  String get searchCity;

  /// No description provided for @searchCountry.
  ///
  /// In ru, this message translates to:
  /// **'Страна'**
  String get searchCountry;

  /// No description provided for @searchWorld.
  ///
  /// In ru, this message translates to:
  /// **'Весь мир'**
  String get searchWorld;

  /// No description provided for @ageLabel.
  ///
  /// In ru, this message translates to:
  /// **'Возраст'**
  String get ageLabel;

  /// No description provided for @showGenderLabel.
  ///
  /// In ru, this message translates to:
  /// **'Показывать'**
  String get showGenderLabel;

  /// No description provided for @genderAll.
  ///
  /// In ru, this message translates to:
  /// **'Всех'**
  String get genderAll;

  /// No description provided for @zodiacFilterLabel.
  ///
  /// In ru, this message translates to:
  /// **'Фильтр по стихиям'**
  String get zodiacFilterLabel;

  /// No description provided for @resetFilters.
  ///
  /// In ru, this message translates to:
  /// **'Сбросить'**
  String get resetFilters;

  /// No description provided for @applyFilters.
  ///
  /// In ru, this message translates to:
  /// **'Применить'**
  String get applyFilters;

  /// No description provided for @forecastLoadError.
  ///
  /// In ru, this message translates to:
  /// **'Не удалось загрузить прогноз.\nПопробуйте позже.'**
  String get forecastLoadError;

  /// No description provided for @noForecastEvents.
  ///
  /// In ru, this message translates to:
  /// **'На сегодня нет значимых астрологических событий.\nСпокойный день!'**
  String get noForecastEvents;

  /// No description provided for @unlockFullForecast.
  ///
  /// In ru, this message translates to:
  /// **'Разблокировать полный прогноз'**
  String get unlockFullForecast;

  /// No description provided for @myFriendsTab.
  ///
  /// In ru, this message translates to:
  /// **'Мои друзья'**
  String get myFriendsTab;

  /// No description provided for @friendRequestsTab.
  ///
  /// In ru, this message translates to:
  /// **'Заявки'**
  String get friendRequestsTab;

  /// No description provided for @noFriendsYet.
  ///
  /// In ru, this message translates to:
  /// **'У вас пока нет друзей. Найдите их в поиске!'**
  String get noFriendsYet;

  /// No description provided for @noFriendRequests.
  ///
  /// In ru, this message translates to:
  /// **'Нет новых заявок.'**
  String get noFriendRequests;

  /// No description provided for @removeFriend.
  ///
  /// In ru, this message translates to:
  /// **'Удалить из друзей'**
  String get removeFriend;

  /// No description provided for @gamesComingSoonTitle.
  ///
  /// In ru, this message translates to:
  /// **'Игры и Награды скоро появятся!'**
  String get gamesComingSoonTitle;

  /// No description provided for @gamesComingSoonDesc.
  ///
  /// In ru, this message translates to:
  /// **'Мы готовим увлекательные мини-игры и квизы. Проверяйте свою совместимость, зарабатывайте \"Звездную пыль\" и обменивайте ее на премиум-дни или уникальные подарки!'**
  String get gamesComingSoonDesc;

  /// No description provided for @joinTelegramButton.
  ///
  /// In ru, this message translates to:
  /// **'Узнавайте первыми в нашем Telegram'**
  String get joinTelegramButton;

  /// No description provided for @horoscopeForSign.
  ///
  /// In ru, this message translates to:
  /// **'Гороскоп для знака {sign}'**
  String horoscopeForSign(Object sign);

  /// No description provided for @horoscopeGeneral.
  ///
  /// In ru, this message translates to:
  /// **'Общий'**
  String get horoscopeGeneral;

  /// No description provided for @horoscopeLove.
  ///
  /// In ru, this message translates to:
  /// **'Любовный'**
  String get horoscopeLove;

  /// No description provided for @horoscopeBusiness.
  ///
  /// In ru, this message translates to:
  /// **'Деловой'**
  String get horoscopeBusiness;

  /// No description provided for @verdictNotFound.
  ///
  /// In ru, this message translates to:
  /// **'Вердикт не найден'**
  String get verdictNotFound;

  /// No description provided for @vedicCompatibilityTitle.
  ///
  /// In ru, this message translates to:
  /// **'Ведическая совместимость'**
  String get vedicCompatibilityTitle;

  /// No description provided for @ashtaKutaAnalysis.
  ///
  /// In ru, this message translates to:
  /// **'Детальный анализ (Ашта-Кута)'**
  String get ashtaKutaAnalysis;

  /// No description provided for @noDescription.
  ///
  /// In ru, this message translates to:
  /// **'Описание не найдено.'**
  String get noDescription;

  /// No description provided for @likesYouEmpty.
  ///
  /// In ru, this message translates to:
  /// **'Здесь будут те, кто вами заинтересуется'**
  String get likesYouEmpty;

  /// No description provided for @peopleLikeYou.
  ///
  /// In ru, this message translates to:
  /// **'Вы нравитесь {count} людям!'**
  String peopleLikeYou(Object count);

  /// No description provided for @getProToSeeLikes.
  ///
  /// In ru, this message translates to:
  /// **'Получите PRO-статус, чтобы увидеть их профили и начать общение.'**
  String get getProToSeeLikes;

  /// No description provided for @seeLikesButton.
  ///
  /// In ru, this message translates to:
  /// **'Посмотреть'**
  String get seeLikesButton;

  /// No description provided for @someone.
  ///
  /// In ru, this message translates to:
  /// **'Кто-то'**
  String get someone;

  /// No description provided for @selectCityTitle.
  ///
  /// In ru, this message translates to:
  /// **'Выберите город'**
  String get selectCityTitle;

  /// No description provided for @searchCityHint.
  ///
  /// In ru, this message translates to:
  /// **'Введите название города...'**
  String get searchCityHint;

  /// No description provided for @nothingFound.
  ///
  /// In ru, this message translates to:
  /// **'Ничего не найдено'**
  String get nothingFound;

  /// No description provided for @errorNatalChartMissing.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка: ваша натальная карта не рассчитана.'**
  String get errorNatalChartMissing;

  /// No description provided for @manualCheckTitle.
  ///
  /// In ru, this message translates to:
  /// **'Ручная проверка'**
  String get manualCheckTitle;

  /// No description provided for @checkAgainTooltip.
  ///
  /// In ru, this message translates to:
  /// **'Проверить еще раз'**
  String get checkAgainTooltip;

  /// No description provided for @synastryTitle.
  ///
  /// In ru, this message translates to:
  /// **'Синастрия Партнеров'**
  String get synastryTitle;

  /// No description provided for @synastryDesc.
  ///
  /// In ru, this message translates to:
  /// **'Введите данные рождения человека, чтобы рассчитать вашу детальную совместимость.'**
  String get synastryDesc;

  /// No description provided for @partnerNameLabel.
  ///
  /// In ru, this message translates to:
  /// **'Имя партнера'**
  String get partnerNameLabel;

  /// No description provided for @tapToSelect.
  ///
  /// In ru, this message translates to:
  /// **'Нажмите, чтобы выбрать'**
  String get tapToSelect;

  /// No description provided for @calculateButton.
  ///
  /// In ru, this message translates to:
  /// **'Рассчитать'**
  String get calculateButton;

  /// No description provided for @you.
  ///
  /// In ru, this message translates to:
  /// **'Вы'**
  String get you;

  /// No description provided for @summary_desc.
  ///
  /// In ru, this message translates to:
  /// **'Ваш союз имеет потенциал {score}%. Звезды и числа указывают на {verdict}.'**
  String summary_desc(Object score, Object verdict);

  /// No description provided for @strongConnection.
  ///
  /// In ru, this message translates to:
  /// **'сильную связь'**
  String get strongConnection;

  /// No description provided for @interestingLessons.
  ///
  /// In ru, this message translates to:
  /// **'интересные уроки'**
  String get interestingLessons;

  /// No description provided for @moderationProposedPosts.
  ///
  /// In ru, this message translates to:
  /// **'Предложенные посты'**
  String get moderationProposedPosts;

  /// No description provided for @noProposedPosts.
  ///
  /// In ru, this message translates to:
  /// **'Нет предложенных постов.'**
  String get noProposedPosts;

  /// No description provided for @from.
  ///
  /// In ru, this message translates to:
  /// **'От'**
  String get from;

  /// No description provided for @personalNumerologyTitle.
  ///
  /// In ru, this message translates to:
  /// **'Личная Нумерология'**
  String get personalNumerologyTitle;

  /// No description provided for @dataNotLoaded.
  ///
  /// In ru, this message translates to:
  /// **'Данные не загружены'**
  String get dataNotLoaded;

  /// No description provided for @loading.
  ///
  /// In ru, this message translates to:
  /// **'Загрузка...'**
  String get loading;

  /// No description provided for @lifePathNumber.
  ///
  /// In ru, this message translates to:
  /// **'Число Жизненного Пути'**
  String get lifePathNumber;

  /// No description provided for @corePersonality.
  ///
  /// In ru, this message translates to:
  /// **'Ядро Личности'**
  String get corePersonality;

  /// No description provided for @destinyNumber.
  ///
  /// In ru, this message translates to:
  /// **'Число Судьбы'**
  String get destinyNumber;

  /// No description provided for @soulNumber.
  ///
  /// In ru, this message translates to:
  /// **'Число Души'**
  String get soulNumber;

  /// No description provided for @personalityNumber.
  ///
  /// In ru, this message translates to:
  /// **'Число Личности'**
  String get personalityNumber;

  /// No description provided for @timeInfluence.
  ///
  /// In ru, this message translates to:
  /// **'Влияние Времени'**
  String get timeInfluence;

  /// No description provided for @maturityNumber.
  ///
  /// In ru, this message translates to:
  /// **'Число Зрелости'**
  String get maturityNumber;

  /// No description provided for @birthdayNumber.
  ///
  /// In ru, this message translates to:
  /// **'День Рождения'**
  String get birthdayNumber;

  /// No description provided for @currentVibrationsPro.
  ///
  /// In ru, this message translates to:
  /// **'Текущие Вибрации (PRO)'**
  String get currentVibrationsPro;

  /// No description provided for @personalYear.
  ///
  /// In ru, this message translates to:
  /// **'Личный Год'**
  String get personalYear;

  /// No description provided for @personalMonth.
  ///
  /// In ru, this message translates to:
  /// **'Личный Месяц'**
  String get personalMonth;

  /// No description provided for @personalDay.
  ///
  /// In ru, this message translates to:
  /// **'Личный День'**
  String get personalDay;

  /// No description provided for @proVibrationsDesc.
  ///
  /// In ru, this message translates to:
  /// **'Узнайте свои вибрации на Год, Месяц и День. Доступно только в Premium версии.'**
  String get proVibrationsDesc;

  /// No description provided for @unlockButton.
  ///
  /// In ru, this message translates to:
  /// **'Разблокировать'**
  String get unlockButton;

  /// No description provided for @tapForDetails.
  ///
  /// In ru, this message translates to:
  /// **'Нажмите подробнее'**
  String get tapForDetails;

  /// No description provided for @oracle_weather_desc.
  ///
  /// In ru, this message translates to:
  /// **'{desc} (Kp: {kp})'**
  String oracle_weather_desc(Object desc, Object kp);

  /// No description provided for @oracle_geomagnetic_now.
  ///
  /// In ru, this message translates to:
  /// **'Сейчас: {desc}'**
  String oracle_geomagnetic_now(Object desc);

  /// No description provided for @oracle_geomagnetic_index.
  ///
  /// In ru, this message translates to:
  /// **'Индекс Kp: {kp}'**
  String oracle_geomagnetic_index(Object kp);

  /// No description provided for @oracle_question_title.
  ///
  /// In ru, this message translates to:
  /// **'Вопрос Оракулу'**
  String get oracle_question_title;

  /// No description provided for @oracle_question_hint.
  ///
  /// In ru, this message translates to:
  /// **'Что вас волнует?...'**
  String get oracle_question_hint;

  /// No description provided for @oracle_question_button.
  ///
  /// In ru, this message translates to:
  /// **'Получить ответ'**
  String get oracle_question_button;

  /// No description provided for @palmistry_analysis_title.
  ///
  /// In ru, this message translates to:
  /// **'Анализ Ладони'**
  String get palmistry_analysis_title;

  /// No description provided for @palmistry_choose_option.
  ///
  /// In ru, this message translates to:
  /// **'Выберите наиболее подходящий вариант:'**
  String get palmistry_choose_option;

  /// No description provided for @palmistry_analysis_saved.
  ///
  /// In ru, this message translates to:
  /// **'Анализ сохранен!'**
  String get palmistry_analysis_saved;

  /// No description provided for @palmistry_view_report.
  ///
  /// In ru, this message translates to:
  /// **'Посмотреть полный отчет'**
  String get palmistry_view_report;

  /// No description provided for @palmistry_complete_all.
  ///
  /// In ru, this message translates to:
  /// **'Завершите анализ всех линий'**
  String get palmistry_complete_all;

  /// No description provided for @palmistry_analysis_complete.
  ///
  /// In ru, this message translates to:
  /// **'Отлично! Анализ завершен.'**
  String get palmistry_analysis_complete;

  /// No description provided for @palmistry_tap_line.
  ///
  /// In ru, this message translates to:
  /// **'Нажмите на \'{lineName}\', чтобы сравнить со своей ладонью.'**
  String palmistry_tap_line(Object lineName);

  /// No description provided for @palmistry_searching_line.
  ///
  /// In ru, this message translates to:
  /// **'Идет поиск \'{lineName}\'...'**
  String palmistry_searching_line(Object lineName);

  /// No description provided for @palmistry_preparing.
  ///
  /// In ru, this message translates to:
  /// **'Подготовка к анализу...'**
  String get palmistry_preparing;

  /// No description provided for @palmistry_report_title.
  ///
  /// In ru, this message translates to:
  /// **'Карта Вашей Судьбы'**
  String get palmistry_report_title;

  /// No description provided for @palmistry_data_not_found.
  ///
  /// In ru, this message translates to:
  /// **'Данные анализа не найдены.'**
  String get palmistry_data_not_found;

  /// No description provided for @palmistry_strong_traits.
  ///
  /// In ru, this message translates to:
  /// **'Ваши сильные стороны'**
  String get palmistry_strong_traits;

  /// No description provided for @privacy.
  ///
  /// In ru, this message translates to:
  /// **'Приватность'**
  String get privacy;

  /// No description provided for @palmistry_show_in_profile.
  ///
  /// In ru, this message translates to:
  /// **'Показывать мои черты в профиле'**
  String get palmistry_show_in_profile;

  /// No description provided for @palmistry_show_in_profile_desc.
  ///
  /// In ru, this message translates to:
  /// **'Это позволит другим лучше узнать вас и улучшит подбор совместимости.'**
  String get palmistry_show_in_profile_desc;

  /// No description provided for @palmistry_interpretation.
  ///
  /// In ru, this message translates to:
  /// **'Расшифровка линий'**
  String get palmistry_interpretation;

  /// No description provided for @palmistry_your_choice.
  ///
  /// In ru, this message translates to:
  /// **'Ваш выбор: \"{choice}\"'**
  String palmistry_your_choice(Object choice);

  /// No description provided for @photoAlbumComingSoon.
  ///
  /// In ru, this message translates to:
  /// **'Скоро вы сможете загружать сюда свои фото.'**
  String get photoAlbumComingSoon;

  /// No description provided for @settingsTitle.
  ///
  /// In ru, this message translates to:
  /// **'Настройки'**
  String get settingsTitle;

  /// No description provided for @accountManagement.
  ///
  /// In ru, this message translates to:
  /// **'Управление аккаунтом'**
  String get accountManagement;

  /// No description provided for @changePassword.
  ///
  /// In ru, this message translates to:
  /// **'Сменить пароль'**
  String get changePassword;

  /// No description provided for @restorePassword.
  ///
  /// In ru, this message translates to:
  /// **'Восстановить пароль'**
  String get restorePassword;

  /// No description provided for @editProfileButton.
  ///
  /// In ru, this message translates to:
  /// **'Редактировать профиль'**
  String get editProfileButton;

  /// No description provided for @dailyNotifications.
  ///
  /// In ru, this message translates to:
  /// **'Ежедневные уведомления'**
  String get dailyNotifications;

  /// No description provided for @alertsTitle.
  ///
  /// In ru, this message translates to:
  /// **'Оповещения'**
  String get alertsTitle;

  /// No description provided for @geomagneticStorms.
  ///
  /// In ru, this message translates to:
  /// **'Геомагнитные бури'**
  String get geomagneticStorms;

  /// No description provided for @adminPanelTitle.
  ///
  /// In ru, this message translates to:
  /// **'Панель Администратора'**
  String get adminPanelTitle;

  /// No description provided for @adminManageUsers.
  ///
  /// In ru, this message translates to:
  /// **'Управление пользователями'**
  String get adminManageUsers;

  /// No description provided for @offerAgreementLink.
  ///
  /// In ru, this message translates to:
  /// **'Договор оферты'**
  String get offerAgreementLink;

  /// No description provided for @accountSectionTitle.
  ///
  /// In ru, this message translates to:
  /// **'Аккаунт'**
  String get accountSectionTitle;

  /// No description provided for @deleteAccountButton.
  ///
  /// In ru, this message translates to:
  /// **'Удалить аккаунт'**
  String get deleteAccountButton;

  /// No description provided for @closeAppButton.
  ///
  /// In ru, this message translates to:
  /// **'Закрыть приложение'**
  String get closeAppButton;

  /// No description provided for @changePasswordDesc.
  ///
  /// In ru, this message translates to:
  /// **'Для безопасности введите ваш текущий пароль.'**
  String get changePasswordDesc;

  /// No description provided for @currentPasswordLabel.
  ///
  /// In ru, this message translates to:
  /// **'Текущий пароль'**
  String get currentPasswordLabel;

  /// No description provided for @newPasswordLabel.
  ///
  /// In ru, this message translates to:
  /// **'Новый пароль'**
  String get newPasswordLabel;

  /// No description provided for @passwordChangedSuccess.
  ///
  /// In ru, this message translates to:
  /// **'Пароль успешно изменен!'**
  String get passwordChangedSuccess;

  /// No description provided for @resetPasswordInstruction.
  ///
  /// In ru, this message translates to:
  /// **'Мы отправим инструкцию для сброса пароля на ваш E-mail: \n\n{email}'**
  String resetPasswordInstruction(String email);

  /// No description provided for @signOutDialogTitle.
  ///
  /// In ru, this message translates to:
  /// **'Выход из аккаунта'**
  String get signOutDialogTitle;

  /// No description provided for @signOutDialogContent.
  ///
  /// In ru, this message translates to:
  /// **'Вы уверены, что хотите выйти?'**
  String get signOutDialogContent;

  /// No description provided for @deleteAccountTitle.
  ///
  /// In ru, this message translates to:
  /// **'Удалить аккаунт?'**
  String get deleteAccountTitle;

  /// No description provided for @deleteAccountWarning.
  ///
  /// In ru, this message translates to:
  /// **'Это действие необратимо. Все ваши данные, переписки, фото и покупки будут удалены навсегда.'**
  String get deleteAccountWarning;

  /// No description provided for @deleteForeverButton.
  ///
  /// In ru, this message translates to:
  /// **'Удалить навсегда'**
  String get deleteForeverButton;

  /// No description provided for @roulette_trust_fate.
  ///
  /// In ru, this message translates to:
  /// **'Доверьтесь судьбе'**
  String get roulette_trust_fate;

  /// No description provided for @roulette_desc_short.
  ///
  /// In ru, this message translates to:
  /// **'Звезды выберут для вас самого совместимого партнера (от 85%!).'**
  String get roulette_desc_short;

  /// No description provided for @roulette_no_candidates.
  ///
  /// In ru, this message translates to:
  /// **'Нет кандидатов для вращения.'**
  String get roulette_no_candidates;

  /// No description provided for @roulette_winner_title.
  ///
  /// In ru, this message translates to:
  /// **'Звезды сделали свой выбор!'**
  String get roulette_winner_title;

  /// No description provided for @roulette_spin_again.
  ///
  /// In ru, this message translates to:
  /// **'Крутить еще раз'**
  String get roulette_spin_again;

  /// No description provided for @roulette_go_to_profile.
  ///
  /// In ru, this message translates to:
  /// **'Перейти в профиль'**
  String get roulette_go_to_profile;

  /// No description provided for @cityNotSpecified.
  ///
  /// In ru, this message translates to:
  /// **'Город не указан'**
  String get cityNotSpecified;

  /// No description provided for @geomagnetic_calm.
  ///
  /// In ru, this message translates to:
  /// **'Спокойно'**
  String get geomagnetic_calm;

  /// No description provided for @geomagnetic_unsettled.
  ///
  /// In ru, this message translates to:
  /// **'Нестабильно'**
  String get geomagnetic_unsettled;

  /// No description provided for @geomagnetic_active.
  ///
  /// In ru, this message translates to:
  /// **'Активно'**
  String get geomagnetic_active;

  /// No description provided for @geomagnetic_storm_minor.
  ///
  /// In ru, this message translates to:
  /// **'Малая буря (G1)'**
  String get geomagnetic_storm_minor;

  /// No description provided for @geomagnetic_storm_moderate.
  ///
  /// In ru, this message translates to:
  /// **'Умеренная буря (G2)'**
  String get geomagnetic_storm_moderate;

  /// No description provided for @geomagnetic_storm_strong.
  ///
  /// In ru, this message translates to:
  /// **'Сильная буря (G3)'**
  String get geomagnetic_storm_strong;

  /// No description provided for @geomagnetic_storm_severe.
  ///
  /// In ru, this message translates to:
  /// **'Жестокая буря (G4)'**
  String get geomagnetic_storm_severe;

  /// No description provided for @geomagnetic_storm_extreme.
  ///
  /// In ru, this message translates to:
  /// **'Экстрем. буря (G5)'**
  String get geomagnetic_storm_extreme;

  /// No description provided for @deleteChatTitle.
  ///
  /// In ru, this message translates to:
  /// **'Удалить чат?'**
  String get deleteChatTitle;

  /// No description provided for @deleteChatConfirmation.
  ///
  /// In ru, this message translates to:
  /// **'Вся переписка будет удалена безвозвратно.'**
  String get deleteChatConfirmation;

  /// No description provided for @chatDeleted.
  ///
  /// In ru, this message translates to:
  /// **'Чат удален'**
  String get chatDeleted;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'de',
        'en',
        'es',
        'fr',
        'hi',
        'ko',
        'ru',
        'zh'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'hi':
      return AppLocalizationsHi();
    case 'ko':
      return AppLocalizationsKo();
    case 'ru':
      return AppLocalizationsRu();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
