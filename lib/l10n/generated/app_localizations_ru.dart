// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get profileCreationErrorTitle => 'Ошибка создания профиля';

  @override
  String get profileCreationErrorDescription =>
      'К сожалению, при сохранении ваших данных произошел сбой. Пожалуйста, попробуйте пройти регистрацию еще раз.';

  @override
  String get tryAgain => 'Попробовать снова';

  @override
  String get connectingHearts => 'Соединяем сердца во Вселенной...';

  @override
  String get appName => 'Aryonika';

  @override
  String get exitConfirmationTitle => 'Подтверждение';

  @override
  String get exitConfirmationContent =>
      'Вы уверены, что хотите закрыть Aryonika?';

  @override
  String get cancel => 'Отмена';

  @override
  String get close => 'Закрыть';

  @override
  String get paymentUrlError => 'Ошибка: URL для оплаты не найден.';

  @override
  String get channelIdError => 'Ошибка: ID канала не найден.';

  @override
  String documentLoadError(Object error) {
    return 'Ошибка загрузки документа: $error';
  }

  @override
  String get partnerIdError =>
      'Ошибка: Необходим ID партнера для расчета совместимости.';

  @override
  String get bioPlaceholder => 'Здесь могла бы быть ваша история...';

  @override
  String photoAlbumTitle(Object photoCount) {
    return 'Фотоальбом ($photoCount)';
  }

  @override
  String get photoAlbumSubtitle => 'Ваши лучшие моменты';

  @override
  String get cosmicEventsTitle => 'Космические События';

  @override
  String get cosmicEventsSubtitle => 'Узнайте о влиянии планет';

  @override
  String get inviteFriendTitle => 'Пригласить друга';

  @override
  String get inviteFriendSubtitle => 'Получайте бонусы вместе';

  @override
  String get gameCenterTitle => 'Игровой центр';

  @override
  String get gameCenterSubtitle => 'Мини-игры и квесты';

  @override
  String get personalForecastTitle => 'Персональный прогноз';

  @override
  String get personalForecastSubtitlePro => 'Анализ транзитов на сегодня';

  @override
  String get personalForecastSubtitleFree => 'Доступно с PRO-статусом';

  @override
  String get cosmicPassportTitle => 'КОСМИЧЕСКИЙ ПАСПОРТ';

  @override
  String get numerologyPortraitTitle => 'НУМЕРОЛОГИЧЕСКИЙ ПОРТРЕТ';

  @override
  String get yourNumbersOfDestinyTitle => 'Ваши числа судьбы';

  @override
  String get yourNumbersOfDestinySubtitle => 'Раскройте свой потенциал';

  @override
  String get numerologyPath => 'Путь';

  @override
  String get numerologyDestiny => 'Судьба';

  @override
  String get numerologySoul => 'Душа';

  @override
  String get signOut => 'Выйти из аккаунта';

  @override
  String get calculatingChart => 'Рассчитываем карту...';

  @override
  String get astroDataSignMissing => 'Данные для этого знака отсутствуют.';

  @override
  String astroDataDescriptionNotFound(Object signName) {
    return 'Описание для \"$signName\" не найдено.';
  }

  @override
  String astroDataMapNotLoaded(Object mapKey) {
    return 'Данные для \"$mapKey\" не загружены.';
  }

  @override
  String get planetSun => 'Солнце';

  @override
  String get planetMoon => 'Луна';

  @override
  String get planetAscendant => 'Асцендент';

  @override
  String get planetMercury => 'Меркурий';

  @override
  String get planetVenus => 'Венера';

  @override
  String get planetMars => 'Марс';

  @override
  String get planetSaturn => 'Сатурн';

  @override
  String get planetJupiter => 'Юпитер';

  @override
  String get planetUranus => 'Уран';

  @override
  String get planetNeptune => 'Нептун';

  @override
  String get planetPluto => 'Плутон';

  @override
  String get getProTitle => 'Получить PRO';

  @override
  String get getProSubtitle => 'Разблокируйте все функции';

  @override
  String get proStatusActive => 'PRO-статус активен';

  @override
  String get proStatusExpired => 'Статус истек';

  @override
  String proStatusDaysLeft(Object days) {
    return 'Осталось дней: $days';
  }

  @override
  String proStatusHoursLeft(Object hours) {
    return 'Осталось часов: $hours';
  }

  @override
  String get proStatusExpiresToday => 'Заканчивается сегодня';

  @override
  String astroDialogTitle(Object planetName, Object signName) {
    return '$planetName в знаке $signName';
  }

  @override
  String get likesYouTitle => 'Вам симпатии';

  @override
  String likesYouTotal(Object count) {
    return 'Всего симпатий: $count';
  }

  @override
  String get likesYouNone => 'Пока нет симпатий';

  @override
  String reportOnUser(Object userName) {
    return 'Пожаловаться на $userName';
  }

  @override
  String get reportReasonSpam => 'Спам';

  @override
  String get reportReasonInsultingBehavior => 'Оскорбительное поведение';

  @override
  String get reportReasonScam => 'Мошенничество';

  @override
  String get reportReasonInappropriateContent => 'Неприемлемый контент';

  @override
  String get reportDetailsHint => 'Дополнительные детали (необязательно)';

  @override
  String get send => 'Отправить';

  @override
  String get reportSentSnackbar => 'Спасибо! Ваша жалоба отправлена.';

  @override
  String get profileLoadError => 'Не удалось загрузить профиль';

  @override
  String get back => 'Назад';

  @override
  String get report => 'Пожаловаться';

  @override
  String userProfilePhotoAlbumTitle(Object photoCount) {
    return 'Фотоальбом ($photoCount)';
  }

  @override
  String get userProfileViewPhotos => 'Посмотреть фотографии';

  @override
  String get aboutMe => 'О себе';

  @override
  String get bioEmpty => 'Пользователь ничего не рассказал о себе.';

  @override
  String get cosmicPassport => 'Космический паспорт';

  @override
  String sunInSign(Object signName) {
    return '☀️ Солнце в знаке $signName';
  }

  @override
  String get friendshipStatusFriends => 'Вы друзья';

  @override
  String get friendshipRemoveTitle => 'Удалить из друзей?';

  @override
  String friendshipRemoveContent(Object userName) {
    return 'Вы уверены, что хотите удалить $userName из друзей?';
  }

  @override
  String get remove => 'Удалить';

  @override
  String get friendshipStatusRequestSent => 'Заявка отправлена';

  @override
  String get friendshipActionDecline => 'Отклонить';

  @override
  String get friendshipActionAccept => 'Принять';

  @override
  String get friendshipActionAdd => 'Добавить в друзья';

  @override
  String likeSnackbarSuccess(Object userName) {
    return 'Вы лайкнули $userName!';
  }

  @override
  String likeSnackbarAlreadyLiked(Object userName) {
    return 'Вы уже лайкнули $userName';
  }

  @override
  String get writeMessage => 'Написать';

  @override
  String get checkCompatibility => 'Проверить совместимость';

  @override
  String get yourCosmicInfluence => 'Ваше Космическое Влияние Сегодня';

  @override
  String get cosmicEventsLoading => 'Рассчитываем космические события...';

  @override
  String get cosmicEventsEmpty =>
      'Сегодня космос спокоен. Наслаждайтесь гармонией!';

  @override
  String get cosmicEventsError =>
      'Не удалось рассчитать космические события. Попробуйте позже.';

  @override
  String get cosmicConnectionTitle => 'Космическая Связь';

  @override
  String shareText(Object name, Object score) {
    return 'Наша совместимость с $name — $score%! ✨\nРассчитано в Aryonika';
  }

  @override
  String get shareErrorSnackbar => 'Произошла ошибка при попытке поделиться.';

  @override
  String get compatibilityErrorTitle => 'Не удалось рассчитать совместимость';

  @override
  String get compatibilityErrorSubtitle =>
      'Возможно, данные партнера неполные или произошла сетевая ошибка.';

  @override
  String get goBack => 'Вернуться назад';

  @override
  String get sectionCosmicAdvice => 'КОСМИЧЕСКИЙ СОВЕТ';

  @override
  String get sectionDailyInfluence => 'ВЛИЯНИЕ ДНЯ';

  @override
  String get sectionAstrologicalResonance => 'АСТРОЛОГИЧЕСКИЙ РЕЗОНАНС';

  @override
  String get sectionNumerologyMatrix => 'НУМЕРОЛОГИЧЕСКАЯ МАТРИЦА';

  @override
  String get sectionPalmistryConnection => 'ХИРОМАНТИЧЕСКАЯ СВЯЗЬ';

  @override
  String get sectionAboutPerson => 'О ЧЕЛОВЕКЕ';

  @override
  String get palmistryNoData =>
      'Один из партнеров еще не прошел анализ ладони. Это откроет новый уровень вашей совместимости!';

  @override
  String palmistryCommonTraits(Object traits) {
    return 'Вас объединяет: $traits. Это создает прочный фундамент для ваших отношений.';
  }

  @override
  String palmistryUniqueTraits(Object myTrait, Object partnerTrait) {
    return 'Вы дополняете друг друга: ваша черта \'$myTrait\' прекрасно гармонирует с его(ее) \'$partnerTrait\'.';
  }

  @override
  String get harmony => 'Гармония';

  @override
  String get adviceRareConnection =>
      'Ваши души резонируют в унисон. Это редкая космическая связь, где гармонируют и личности (Солнце), и эмоции (Луна). Цените это сокровище.';

  @override
  String get advicePassionChallenge =>
      'Между вами бушует пламя страсти, но ваши личности могут конфликтовать. Учитесь превращать споры в энергию для роста, и ваша связь станет нерушимой.';

  @override
  String get adviceBestFriends =>
      'Вы - лучшие друзья, которые понимают друг друга с полуслова и чувствуют себя комфортно. Физическое притяжение может со временем усилиться, главное — ваша душевная близость.';

  @override
  String get adviceKarmicLesson =>
      'Ваши пути пересеклись не случайно. Эта связь несет важные уроки для обоих. Будьте терпеливы и открыты, чтобы понять, чему вы должны научить друг друга.';

  @override
  String get adviceGreatPotential =>
      'Между вами есть сильное притяжение и отличный потенциал для роста. Учитесь друг у друга, и ваша связь станет крепче. Звезды на вашей стороне.';

  @override
  String get adviceBase =>
      'Изучайте друг друга. Каждая встреча — это возможность открыть новую вселенную. Ваша история только начинается.';

  @override
  String get dailyInfluenceCalm =>
      'Космический штиль. Отличный день, чтобы просто наслаждаться обществом друг друга без внешних влияний.';

  @override
  String get dailyAdviceFavorable =>
      'Совет: Используйте эту энергию! Отличный момент для совместных планов.';

  @override
  String get dailyAdviceTense =>
      'Совет: Будьте терпимее друг к другу. Возможны недопонимания.';

  @override
  String get proFeatureLocked =>
      'Подробный анализ этого аспекта доступен в PRO-версии.';

  @override
  String get getProButton => 'Получить PRO';

  @override
  String get numerologyLifePath => 'Путь жизни';

  @override
  String get numerologyDestinyNumber => 'Число Судьбы';

  @override
  String get numerologySoulNumber => 'Число Души';

  @override
  String get shareCardTitle => 'Aryonika';

  @override
  String get shareCardSubtitle => 'ОТЧЕТ КОСМИЧЕСКОЙ СОВМЕСТИМОСТИ';

  @override
  String get shareCardHarmony => 'Общая гармония';

  @override
  String get shareCardPersonalityHarmony => 'Гармония личностей (Солнце)';

  @override
  String get shareCardLifePath => 'Путь Жизни (Нумерология)';

  @override
  String get shareCardCtaTitle => 'Узнай свою космическую\nсовместимость!';

  @override
  String get shareCardCtaSubtitle => 'Скачай Aryonika в RuStore';

  @override
  String get loginTitle => 'Вход в аккаунт';

  @override
  String get loginError => 'Ошибка входа';

  @override
  String get passwordResetTitle => 'Восстановление пароля';

  @override
  String get passwordResetContent =>
      'Введите ваш E-mail, и мы отправим на него инструкцию для сброса пароля.';

  @override
  String get emailLabel => 'Email';

  @override
  String get sendButton => 'Отправить';

  @override
  String get emailValidationError => 'Пожалуйста, введите корректный E-mail.';

  @override
  String get passwordResetSuccess => 'Письмо отправлено! Проверьте вашу почту.';

  @override
  String get passwordLabel => 'Пароль';

  @override
  String get loginButton => 'Войти';

  @override
  String get forgotPasswordButton => 'Забыли пароль?';

  @override
  String get noAccountButton => 'Нет аккаунта? Создать';

  @override
  String get registerTitle => 'Создать аккаунт';

  @override
  String get unknownError => 'Произошла неизвестная ошибка';

  @override
  String get confirmPasswordLabel => 'Подтвердите пароль';

  @override
  String get privacyPolicyCheckbox => 'Я принимаю ';

  @override
  String get termsOfUseLink => 'Условия использования';

  @override
  String get and => ' и ';

  @override
  String get privacyPolicyLink => 'Политику конфиденциальности';

  @override
  String get registerButton => 'Зарегистрироваться';

  @override
  String get alreadyHaveAccountButton => 'Уже есть аккаунт? Войти';

  @override
  String get welcomeTagline => 'Твоя судьба написана на звездах';

  @override
  String get welcomeCreateAccountButton => 'Создать космический паспорт';

  @override
  String get welcomeLoginButton => 'У меня уже есть аккаунт';

  @override
  String get introSlide1Title => 'Aryonika — больше, чем знакомства';

  @override
  String get introSlide1Description =>
      'Откройте новые грани совместимости через астрологию, нумерологию и Карты Судьбы.';

  @override
  String get introSlide2Title => 'Ваш Космический Паспорт';

  @override
  String get introSlide2Description =>
      'Узнайте всё о своем потенциале и найдите того, кто дополнит вашу Вселенную.';

  @override
  String get introSlide3Title => 'Присоединяйтесь к Галактике';

  @override
  String get introSlide3Description =>
      'Начните свое космическое путешествие к настоящей любви прямо сейчас.';

  @override
  String get introButtonSkip => 'Пропустить';

  @override
  String get introButtonNext => 'Далее';

  @override
  String get introButtonStart => 'Начать';

  @override
  String get onboardingNameTitle => 'Как вас зовут?';

  @override
  String get onboardingNameSignOutTooltip => 'Выйти (для теста)';

  @override
  String get onboardingNameSubtitle =>
      'Это имя будут видеть другие пользователи.';

  @override
  String get onboardingNameLabel => 'Ваше имя';

  @override
  String get onboardingBioLabel => 'Расскажите о себе';

  @override
  String get onboardingBioHint =>
      'Например: Люблю астрологию и #путешествия...';

  @override
  String get onboardingButtonNext => 'Далее';

  @override
  String get onboardingBirthdateTitle => 'Когда вы родились?';

  @override
  String get onboardingBirthdateSubtitle =>
      'Это необходимо для точного расчета\nнатальной карты и нумерологии.';

  @override
  String get datePickerHelpText => 'ВЫБЕРИТЕ ДАТУ РОЖДЕНИЯ';

  @override
  String get birthdateLabel => 'Дата рождения';

  @override
  String get birthdatePlaceholder => 'Нажмите, чтобы выбрать';

  @override
  String get dateFormat => 'd MMMM yyyy';

  @override
  String get onboardingFinishText1 => 'Анализируем положение звезд...';

  @override
  String get onboardingFinishText2 =>
      'Рассчитываем ваш нумерологический код...';

  @override
  String get onboardingFinishText3 => 'Сверяемся с Картами Судьбы...';

  @override
  String get onboardingFinishText4 => 'Создаем ваш космический паспорт...';

  @override
  String get onboardingFinishErrorTitle => 'Ошибка';

  @override
  String get onboardingFinishErrorContent => 'Произошла неизвестная ошибка.';

  @override
  String get onboardingFinishErrorButton => 'Вернуться';

  @override
  String get onboardingGenderTitle => 'Ваш пол';

  @override
  String get onboardingGenderSubtitle =>
      'Это поможет нам подобрать для вас\nнаиболее подходящих людей.';

  @override
  String get genderMale => 'Мужчин';

  @override
  String get genderFemale => 'Женщин';

  @override
  String get onboardingLocationTitle => 'Место рождения';

  @override
  String get onboardingLocationSubtitle =>
      'Укажите город, в котором вы родились. Это необходимо для точного астрологического расчета.';

  @override
  String get onboardingLocationSearchHint => 'Начните вводить город...';

  @override
  String get onboardingLocationNotFound =>
      'Городов не найдено. Попробуйте другой запрос.';

  @override
  String get onboardingLocationStartSearch =>
      'Начните поиск, чтобы увидеть результаты';

  @override
  String get onboardingLocationSelectFromList =>
      'Выберите город из списка выше, чтобы продолжить';

  @override
  String get onboardingTimeTitle => 'Время рождения';

  @override
  String get onboardingTimeSubtitle =>
      'Если вы не знаете точное время, укажите 12:00.\nЭто все равно даст хороший результат.';

  @override
  String get timePickerHelpText => 'УКАЖИТЕ ВРЕМЯ РОЖДЕНИЯ';

  @override
  String get birthTimeLabel => 'Время рождения';

  @override
  String get onboardingButtonNextLocation => 'Далее (выбрать место)';

  @override
  String get alphaBannerTitle => 'Альфа-версия';

  @override
  String get alphaBannerContent =>
      'Этот раздел находится в активной разработке. Некоторые функции могут работать нестабильно. Мы активно работаем над локализацией, поэтому часть текстов может быть еще на английском языке. Спасибо за понимание!';

  @override
  String get alphaBannerFeedback =>
      'Будем благодарны за ваши замечания и пожелания в нашем Telegram-канале!';

  @override
  String get astro_title_sun => 'Совместимость личностей (Солнце)';

  @override
  String get astro_title_moon => 'Эмоциональная совместимость (Луна)';

  @override
  String get astro_title_chemistry => 'Астрологическая химия (Венера-Марс)';

  @override
  String get astro_title_mercury => 'Стиль общения (Меркурий)';

  @override
  String get astro_title_saturn => 'Долгосрочная перспектива (Сатурн)';

  @override
  String get numerology_title => 'Нумерологический резонанс';

  @override
  String get cosmicPulseTitle => 'Cosmic Pulse';

  @override
  String get feedIceBreakerTitle => 'Ледокол';

  @override
  String get feedOrbitCrossingTitle => 'Пересечение Орбит';

  @override
  String get feedSpiritualNeighborTitle => 'Духовный Сосед';

  @override
  String get feedGeomagneticStormTitle => 'Геомагнитные Бури';

  @override
  String get feedCompatibilityPeakTitle => 'Пик Совместимости';

  @override
  String get feedNewChannelSuggestionTitle => 'Новый Канал';

  @override
  String get feedPopularPostTitle => 'Популярный Пост';

  @override
  String get feedNewCommentTitle => 'Новый Комментарий';

  @override
  String get cardOfTheDayTitle => 'Карта Дня';

  @override
  String get cardOfTheDayDrawing => 'Вытягиваю вашу карту...';

  @override
  String get cardOfTheDayGetButton => 'Вытянуть карту';

  @override
  String get cardOfTheDayYourCard => 'Ваша карта дня';

  @override
  String get cardOfTheDayTapToReveal => 'Нажмите на карту, чтобы перевернуть';

  @override
  String get cardOfTheDayReversedSuffix => ' (Перевернутая)';

  @override
  String get cardOfTheDayDefaultInterpretation =>
      'Узнайте, что день грядущий вам готовит.';

  @override
  String get channelSearchTitle => 'Поиск трансляций';

  @override
  String get channelAnonymousAuthor => 'Аноним';

  @override
  String get errorUserNotAuthorized => 'Пользователь не авторизован';

  @override
  String get errorUnknownServer => 'Неизвестная ошибка сервера';

  @override
  String get errorFailedToLoadData => 'Не удалось загрузить данные';

  @override
  String get generalHello => 'Привет';

  @override
  String get referralErrorProfileNotLoaded =>
      'Ошибка: ваш профиль не загружен. Попробуйте позже.';

  @override
  String get referralErrorAlreadyUsed => 'Вы уже использовали код приглашения.';

  @override
  String get referralErrorOwnCode =>
      'Нельзя использовать свой собственный код.';

  @override
  String get referralScreenTitle => 'Пригласить друга';

  @override
  String get referralYourCodeTitle => 'Ваш код приглашения';

  @override
  String get referralYourCodeDescription =>
      'Поделитесь этим кодом с друзьями. За каждого друга, который введет ваш код, вы получите 1 день PRO-доступа!';

  @override
  String get referralCodeCopied => 'Код скопирован в буфер обмена!';

  @override
  String get referralShareCodeButton => 'Поделиться кодом';

  @override
  String referralShareMessage(String code) {
    return 'Привет! Присоединяйся ко мне в Aryonika, чтобы найти свою космическую пару. Введи мой код приглашения в приложении, чтобы мы оба получили бонусы: $code';
  }

  @override
  String get referralManualBonusNote =>
      'PRO-доступ начисляется вручную в течение 24 часов после того, как ваш друг введет код.';

  @override
  String get referralGotCodeTitle => 'У вас есть код?';

  @override
  String get referralGotCodeDescription =>
      'Введите код, который вам дал друг, чтобы он получил свою награду.';

  @override
  String get referralCodeInputLabel => 'Код приглашения';

  @override
  String get referralCodeValidationError => 'Пожалуйста, введите код';

  @override
  String get referralApplyCodeButton => 'Применить код';

  @override
  String get nav_feed => 'Лента';

  @override
  String get nav_search => 'Поиск';

  @override
  String get nav_oracle => 'Оракул';

  @override
  String get nav_chats => 'Чаты';

  @override
  String get nav_channels => 'Каналы';

  @override
  String get nav_profile => 'Профиль';

  @override
  String get nav_exit => 'Выход';

  @override
  String get exitDialog_title => 'Подтверждение';

  @override
  String get exitDialog_content => 'Вы уверены, что хотите закрыть Aryonika?';

  @override
  String get exitDialog_cancel => 'Отмена';

  @override
  String get exitDialog_confirm => 'Закрыть';

  @override
  String get oracle_limit_title => 'Лимит запросов';

  @override
  String get oracle_limit_later => 'Позже';

  @override
  String get oracle_limit_get_pro => 'Получить безлимит';

  @override
  String get oracle_orb_partner => 'Партнер Дня';

  @override
  String get oracle_orb_roulette => 'Рулетка';

  @override
  String get oracle_orb_duet => 'Дуэт';

  @override
  String get oracle_orb_horoscope => 'Гороскоп';

  @override
  String get oracle_orb_weather => 'Геомагнит.';

  @override
  String get oracle_orb_ask => 'Вопрос';

  @override
  String get oracle_orb_focus => 'Фокус Дня';

  @override
  String get oracle_orb_forecast => 'АстроПрогноз';

  @override
  String get oracle_orb_card => 'Карта Дня';

  @override
  String get oracle_orb_tarot => 'Ответ вселенной';

  @override
  String get oracle_orb_palmistry => 'Хиромантия';

  @override
  String get oracle_duet_title => 'Космический Дуэт';

  @override
  String get oracle_duet_description =>
      'Проверьте совместимость с любым человеком по дате рождения.';

  @override
  String get oracle_duet_button => 'Проверить совместимость';

  @override
  String oracle_unsupported_web_feature(String featureName, Object feature) {
    return 'Функция \'$feature\' пока недоступна в WEB версии. Скачайте приложение.';
  }

  @override
  String get oracle_pro_card_of_day_title => 'Карта Дня (PRO)';

  @override
  String get oracle_pro_card_of_day_desc =>
      'Узнайте энергию своего дня через арканы Таро. Доступно только в PRO.';

  @override
  String get oracle_pro_focus_of_day_title => 'Фокус Дня (PRO)';

  @override
  String get oracle_pro_focus_of_day_desc =>
      'Узнайте, на чем сегодня стоит сфокусироваться. Доступно только в PRO.';

  @override
  String get oracle_pro_forecast_of_day_title => 'Персональный прогноз (PRO)';

  @override
  String get oracle_pro_forecast_of_day_desc =>
      'Подробный разбор транзитов планет для вас. Доступно только в PRO.';

  @override
  String get oracle_roulette_title => 'Космическая Рулетка';

  @override
  String get oracle_roulette_description =>
      'Испытайте удачу! Найдите случайного партнера с высокой совместимостью.';

  @override
  String get oracle_roulette_button => 'Крутить рулетку';

  @override
  String get oracle_card_of_day_reversed => '(перевернутая)';

  @override
  String get oracle_card_of_day_get_key => 'Узнать персональный ключ';

  @override
  String get oracle_palmistry_title => 'Хиромантия';

  @override
  String get oracle_palmistry_description =>
      'Анализ линий на ладони с помощью AI. Узнайте свою судьбу по руке.';

  @override
  String get oracle_palmistry_button => 'Сканировать руку';

  @override
  String get oracle_ask_loading => 'Оракул думает...';

  @override
  String get oracle_ask_again => 'Спросить еще раз';

  @override
  String get oracle_focus_loading => 'Настраиваю фокус...';

  @override
  String get oracle_focus_error => 'Не удалось загрузить фокус';

  @override
  String get oracle_focus_no_data => 'Данные отсутствуют';

  @override
  String get oracle_forecast_loading => 'Составляю ваш личный прогноз...';

  @override
  String get oracle_forecast_error => 'Не удалось составить прогноз';

  @override
  String get oracle_forecast_try_again => 'Попробовать снова';

  @override
  String get oracle_forecast_title => 'Прогноз на День';

  @override
  String get oracle_forecast_day_number => 'Число вашего дня: ';

  @override
  String get oracle_tarot_title => 'Расклад Таро (AI)';

  @override
  String get oracle_tarot_hint => 'Ваш вопрос картам...';

  @override
  String get oracle_tarot_button => 'Сделать расклад';

  @override
  String oracle_tarot_your_question(String question) {
    return 'Ваш вопрос: $question';
  }

  @override
  String get oracle_tarot_loading => 'AI анализирует расклад...';

  @override
  String get oracle_tarot_ask_again => 'Спросить еще';

  @override
  String get oracle_tarot_card_reversed_short => ' (перев.)';

  @override
  String get oracle_tarot_combo_message => 'Общее послание карт:';

  @override
  String get oracle_geomagnetic_title => 'Космическая Погода';

  @override
  String get oracle_geomagnetic_forecast => 'Прогноз на ближайшие часы';

  @override
  String get oracle_weather_title => 'Геомагнитная обстановка';

  @override
  String get oracle_pro_feature_title => 'Партнер Дня (PRO)';

  @override
  String get oracle_pro_feature_desc =>
      'Мы подбираем идеального партнера по вашей натальной карте. Доступно в PRO.';

  @override
  String get oracle_partner_loading => 'Ищу партнера...';

  @override
  String get oracle_partner_error => 'Ошибка поиска';

  @override
  String get oracle_partner_not_found => 'Подходящие партнеры не найдены';

  @override
  String get oracle_partner_profile_error => 'Ошибка профиля';

  @override
  String get oracle_partner_title => 'Ваш Партнер Дня';

  @override
  String oracle_partner_compatibility(String score) {
    return 'Совместимость: $score%';
  }

  @override
  String get oracle_ask_title => 'Вопрос Оракулу';

  @override
  String get oracle_ask_hint => 'Что вас волнует?..';

  @override
  String get oracle_ask_button => 'Получить ответ';

  @override
  String get oracle_tips_loading => 'Загрузка советов...';

  @override
  String get oracle_tips_title => 'Советы звезд на сегодня';

  @override
  String oracle_tips_subtitle(String count) {
    return 'Для общения ($count)';
  }

  @override
  String get oracle_tips_general_advice => 'Будьте открыты и искренни.';

  @override
  String get cardOfTheDayProInApp =>
      '✨ Персональный аспект доступен в мобильном приложении.';

  @override
  String get numerology_report_title => 'Отчет по нумерологии';

  @override
  String get numerology_report_overall => 'Общий балл';

  @override
  String get numerology_report_you => 'Вы';

  @override
  String get numerology_report_partner => 'Партнер';

  @override
  String get userProfile_numerology_button => 'Нумерология';

  @override
  String get forecast_astrological_title => 'Астрологический прогноз';

  @override
  String get forecast_loading => 'Загрузка прогноза...';

  @override
  String get forecast_error => 'Ошибка загрузки';

  @override
  String get forecast_no_aspects => 'Нет значимых аспектов';

  @override
  String get cosmicEvents_title => 'Космические События';

  @override
  String get cosmicEvents_loading_error => 'Не удалось загрузить события';

  @override
  String get cosmicEvents_no_events => 'Нет предстоящих событий';

  @override
  String get cosmicEvents_paywall_title => 'Персональные космические события';

  @override
  String get cosmicEvents_paywall_description =>
      'Получите доступ к уникальным советам, основанным на влиянии планет на вашу натальную карту.';

  @override
  String get cosmicEvents_paywall_button => 'Получить PRO-статус';

  @override
  String get cosmicEvents_personal_focus => 'Ваш персональный фокус:';

  @override
  String get cosmicEvents_pro_placeholder =>
      'Узнайте персональное влияние этого события с PRO-статусом';

  @override
  String get search_no_one_found =>
      'Никого не найдено\nв этой части галактики.';

  @override
  String get chat_error_user_not_found => 'Ошибка: пользователь не найден';

  @override
  String get chat_start_with_hint => 'Начать с подсказки';

  @override
  String get chat_date_format => 'yMMMMd';

  @override
  String get chat_group_member => 'участник';

  @override
  String get chat_group_members_2_4 => 'участника';

  @override
  String get chat_group_members_5_0 => 'участников';

  @override
  String get chat_online_status_long_ago => 'был(а) давно';

  @override
  String get chat_online_status_online => 'в сети';

  @override
  String chat_online_status_minutes_ago(String minutes) {
    return 'был(а) $minutes мин. назад';
  }

  @override
  String chat_online_status_today_at(String time) {
    return 'был(а) сегодня в $time';
  }

  @override
  String chat_online_status_yesterday_at(String time) {
    return 'был(а) вчера в $time';
  }

  @override
  String chat_online_status_date(String date) {
    return 'был(а) $date';
  }

  @override
  String get chat_delete_dialog_title => 'Удалить чат?';

  @override
  String get chat_delete_dialog_content =>
      'Этот чат будет удален для вас и вашего собеседника. Это действие необратимо.';

  @override
  String get chat_delete_dialog_confirm => 'Удалить';

  @override
  String chat_report_dialog_title(String name) {
    return 'Пожаловаться на $name';
  }

  @override
  String get chat_report_details_hint =>
      'Дополнительные детали (необязательно)';

  @override
  String get chat_report_sent_snackbar => 'Спасибо! Ваша жалоба отправлена.';

  @override
  String get chat_menu_report => 'Пожаловаться';

  @override
  String get chat_menu_delete => 'Удалить чат';

  @override
  String get chat_group_title_default => 'Общий чат';

  @override
  String get chat_group_participants => 'Участники';

  @override
  String get chat_message_old => 'Сообщение из предыдущей версии';

  @override
  String get chat_input_hint => 'Сообщение...';

  @override
  String get chat_temp_warning_remaining =>
      'Этот временный чат будет удален через ';

  @override
  String get chat_temp_warning_expired => 'чат истек';

  @override
  String get chat_temp_warning_less_than_24h => 'менее 24 часов';

  @override
  String get encrypted_chat_banner_title => 'Переписка защищена';

  @override
  String get encrypted_chat_banner_desc =>
      'Сообщения в этом чате защищены сквозным шифрованием. Никто, даже администрация Aryonika, не может их прочитать.';

  @override
  String get search_hint => 'Поиск по имени, био...';

  @override
  String get search_tooltip_swipes => 'Свайпы';

  @override
  String get search_tooltip_cosmic_web => 'Космический Веб';

  @override
  String get search_tooltip_star_map => 'Звездная Карта';

  @override
  String get search_tooltip_filters => 'Фильтры';

  @override
  String get search_star_map_placeholder => 'Звездная Карта в разработке...';

  @override
  String get search_priority_header => 'Наиболее подходящие';

  @override
  String get search_other_header => 'Другие пользователи';

  @override
  String get payment_title => 'Поддержка проекта';

  @override
  String get payment_success_snackbar =>
      'Оплата прошла успешно! Обновляем ваш статус...';

  @override
  String get payment_fail_snackbar => 'Оплата не удалась. Попробуйте снова.';

  @override
  String get paywall_header_title => 'Откройте Вселенную Aryonika';

  @override
  String get paywall_header_subtitle =>
      'Поддержите проект и используйте все космические инструменты для поиска идеальной пары.';

  @override
  String get paywall_benefit1_title => 'Смотрите, кто вас лайкнул';

  @override
  String get paywall_benefit1_subtitle =>
      'Не упускайте шанс на взаимность и начните диалог первыми.';

  @override
  String get paywall_benefit2_title => 'Персональный прогноз на день';

  @override
  String get paywall_benefit2_subtitle =>
      'Ежедневный анализ ваших транзитов и Фокус Дня.';

  @override
  String get paywall_benefit3_title => 'Партнёр Дня и Рулетка';

  @override
  String get paywall_benefit3_subtitle =>
      'Позвольте звездам выбрать для вас наиболее совместимого партнера.';

  @override
  String get paywall_benefit4_title => 'Ответ Вселенной';

  @override
  String get paywall_benefit4_subtitle =>
      'Задайте свой вопрос и получите космический совет.';

  @override
  String get paywall_benefit5_title => 'Космическая погода';

  @override
  String get paywall_benefit5_subtitle =>
      'Будьте в курсе геомагнитных бурь и их влияния.';

  @override
  String get paywall_benefit6_title => 'Карта Дня';

  @override
  String get paywall_benefit6_subtitle =>
      'Получайте ежедневное предсказание и совет от Карты Судьбы.';

  @override
  String get paywall_donate_button => 'Поддержать проект';

  @override
  String get paywall_referral_button => 'Получить PRO за друзей';

  @override
  String get paywall_referral_subtitle =>
      'Пригласите друга и получите 1 день PRO-статуса за каждого, кто зарегистрируется по вашей ссылке.';

  @override
  String paywall_get_pro_button(String price) {
    return 'Получить Aryonika PRO ($price)';
  }

  @override
  String get paywall_arbitrary_donate_button => 'Поддержать другой суммой';

  @override
  String get paywall_arbitrary_donate_subtitle =>
      'Если вам понравился наш проект, вы можете поддержать его, чтобы помочь нам выжить в мире акул и других хищников.';

  @override
  String get chinese_zodiac_title => 'Китайский гороскоп';

  @override
  String get zodiac_Rat => 'Крыса';

  @override
  String get zodiac_Ox => 'Бык';

  @override
  String get zodiac_Tiger => 'Тигр';

  @override
  String get zodiac_Rabbit => 'Кролик';

  @override
  String get zodiac_Dragon => 'Дракон';

  @override
  String get zodiac_Snake => 'Змея';

  @override
  String get zodiac_Horse => 'Лошадь';

  @override
  String get zodiac_Goat => 'Коза';

  @override
  String get zodiac_Monkey => 'Обезьяна';

  @override
  String get zodiac_Rooster => 'Петух';

  @override
  String get zodiac_Dog => 'Собака';

  @override
  String get zodiac_Pig => 'Свинья';

  @override
  String get chinese_zodiac_compatibility_button =>
      'Совместимость по гороскопу';

  @override
  String get compatibility_section_title => 'Совместимость';

  @override
  String get userProfile_astro_button => 'Астрология';

  @override
  String get userProfile_bazi_button => 'Бацзы';

  @override
  String get jyotishCompatibilityTitle => 'Ведическая совместимость';

  @override
  String get jyotishDetailedAnalysisTitle => 'Детальный анализ (Ашта-Кута)';

  @override
  String get kuta_tara_name => 'Тара Кута (Судьба)';

  @override
  String get kuta_tara_desc =>
      'Показывает удачу, продолжительность и благополучие в отношениях. Хорошая совместимость здесь — как попутный ветер для вашего союза.';

  @override
  String get kuta_yoni_name => 'Йони Кута (Влечение)';

  @override
  String get kuta_yoni_desc =>
      'Определяет физическую и сексуальную гармонию. Высокий балл указывает на сильное взаимное притяжение и удовлетворенность.';

  @override
  String get kuta_graha_maitri_name => 'Граха Майтри (Дружба)';

  @override
  String get kuta_graha_maitri_desc =>
      'Психологическая совместимость и дружба. Отражает, насколько схожи ваши взгляды на жизнь и легко ли вам находить общий язык.';

  @override
  String get kuta_vashya_name => 'Вашья Кута (Взаимный контроль)';

  @override
  String get kuta_vashya_desc =>
      'Показывает степень взаимного влияния и магнетизма в паре. Кто будет ведущим, а кто ведомым.';

  @override
  String get kuta_gana_name => 'Гана Кута (Темперамент)';

  @override
  String get kuta_gana_desc =>
      'Совместимость на уровне темперамента (Божественный, Человеческий, Демонический). Помогает избежать конфликтов характеров.';

  @override
  String get kuta_bhakoot_name => 'Бхакут Кута (Любовь и Семья)';

  @override
  String get kuta_bhakoot_desc =>
      'Один из самых важных показателей. Отвечает за глубину любви, семейное счастье, финансовое процветание и возможность иметь детей.';

  @override
  String get kuta_nadi_name => 'Нади Кута (Здоровье)';

  @override
  String get kuta_nadi_desc =>
      'Самый весомый критерий. Отвечает за здоровье, генетическую совместимость и долголетие партнеров и их потомства.';

  @override
  String get kuta_varna_name => 'Варна Кута (Духовность)';

  @override
  String get kuta_varna_desc =>
      'Отражает совместимость эго и духовное развитие партнеров. Показывает, кто в паре будет больше стимулировать рост другого.';

  @override
  String get jyotishVerdictExcellent =>
      'Небесный союз! Ваши лунные знаки находятся в идеальной гармонии. Эта связь обещает глубокое понимание, духовный рост и счастье на долгие годы.';

  @override
  String get jyotishVerdictGood =>
      'Очень хорошая совместимость. У вас есть все шансы построить крепкие, гармоничные и счастливые отношения. Мелкие разногласия легко преодолимы.';

  @override
  String get jyotishVerdictAverage =>
      'Нормальная совместимость. В ваших отношениях есть как сильные стороны, так и зоны роста. Успех союза будет зависеть от вашей готовности работать над отношениями.';

  @override
  String get jyotishVerdictChallenging =>
      'Сложная совместимость. Ваши карты указывают на серьезные различия в характерах и жизненных путях. Потребуется много терпения и компромиссов, чтобы достичь гармонии.';

  @override
  String get passwordResetNewPasswordTitle => 'Установите новый пароль';

  @override
  String get passwordResetNewPasswordLabel => 'Новый пароль';

  @override
  String get passwordResetConfirmLabel => 'Подтвердите пароль';

  @override
  String get passwordValidationError =>
      'Пароль должен быть не менее 6 символов';

  @override
  String get passwordMismatchError => 'Пароли не совпадают';

  @override
  String get saveButton => 'Сохранить';

  @override
  String get postActionLike => 'Нравится';

  @override
  String get postActionComment => 'Комментарий';

  @override
  String get postActionShare => 'Поделиться';

  @override
  String get channelDefaultName => 'канал';

  @override
  String postShareText(Object channelName, Object postText) {
    return 'Посмотри пост в канале \"$channelName\": $postText';
  }

  @override
  String get postDeleteDialogTitle => 'Удалить пост?';

  @override
  String get postDeleteDialogContent => 'Это действие нельзя будет отменить.';

  @override
  String get delete => 'Удалить';

  @override
  String get postMenuDelete => 'Удалить пост';

  @override
  String get numerologySectionKeyNumbers => 'Ключевые числа';

  @override
  String get numerologySectionCurrentVibes => 'Текущие вибрации';

  @override
  String get numerologyTitleLifePath => 'Число Жизненного Пути';

  @override
  String get numerologyTitleDestiny => 'Число Судьбы (Экспрессии)';

  @override
  String get numerologyTitleSoulUrge => 'Число Души';

  @override
  String get numerologyTitlePersonality => 'Число Личности';

  @override
  String get numerologyTitleMaturity => 'Число Зрелости';

  @override
  String get numerologyTitleBirthday => 'Число Дня Рождения';

  @override
  String get numerologyTitlePersonalYear => 'Личный Год';

  @override
  String get numerologyTitlePersonalMonth => 'Личный Месяц';

  @override
  String get numerologyTitlePersonalDay => 'Личный День';

  @override
  String get numerologyErrorNotEnoughData => 'Недостаточно данных для расчета.';

  @override
  String get numerologyErrorDescriptionsNotLoaded =>
      'Не удалось загрузить описания для нумерологии';

  @override
  String get chat_error_recipient_not_found => 'Собеседник не найден.';

  @override
  String get chat_error_recipient_profile_load_failed =>
      'Не удалось загрузить профиль собеседника.';

  @override
  String get calculatingNumerology =>
      'Рассчитываем нумерологический портрет...';

  @override
  String get oracle_title => 'Оракул';

  @override
  String get verifyEmailBody =>
      'Мы отправили 6-значный код на ваш email. Пожалуйста, введите его ниже.';

  @override
  String get verifyEmailHint => '------';

  @override
  String get signOutButton => 'Выйти';

  @override
  String get errorInvalidOrExpiredCode =>
      'Неверный или просроченный код подтверждения. Попробуйте снова.';

  @override
  String get errorCodeRequired => 'Пожалуйста, введите код подтверждения.';

  @override
  String get errorInternalServer =>
      'Произошла внутренняя ошибка сервера. Попробуйте позже.';

  @override
  String get errorCodeLength => 'Код должен состоять из 6 цифр.';

  @override
  String get verifyEmailTitle => 'Подтверждение E-mail';

  @override
  String get verificationCodeLabel => 'Код подтверждения';

  @override
  String get verificationCodeResent => 'Новый код подтверждения отправлен!';

  @override
  String get resendCodeAction => 'Отправить код еще раз';

  @override
  String resendCodeCooldown(int seconds) {
    return 'Отправить еще раз через ($seconds)';
  }

  @override
  String verifyEmailInstruction(String email) {
    return 'Мы отправили 6-значный код на ваш E-mail:\n$email\nПожалуйста, введите его ниже.';
  }

  @override
  String get confirmButton => 'Подтвердить';

  @override
  String get logout => 'Выйти';

  @override
  String get numerology_score_high => 'Высокая';

  @override
  String get numerology_score_medium => 'Средняя';

  @override
  String get numerology_score_low => 'Низкая';

  @override
  String get noUsersFound =>
      'По вашему запросу никого не найдено. Попробуйте изменить фильтры.';

  @override
  String get feature_in_development => 'Этот раздел находится в разработке.';

  @override
  String get download_our_app => 'Скачайте наше приложение';

  @override
  String get open_web_version => 'Открыть WEB версию';

  @override
  String get pay_with_card => 'Оплатить картой';

  @override
  String get coming_soon => 'Скоро';

  @override
  String get paywall_subscription_terms =>
      'Подписка продлевается автоматически. Отмена в любое время.';

  @override
  String get searchHint => 'Поиск...';

  @override
  String get nav_friends => 'Друзья';

  @override
  String get oracle_typing => 'печатает...';

  @override
  String get tarot_reversed => '(Перевернутая)';

  @override
  String get common_close => 'Закрыть';

  @override
  String oracle_limit_pro(Object hours) {
    return 'До следующего запроса осталось $hours ч.';
  }

  @override
  String oracle_limit_free(Object days) {
    return 'Вы использовали бесплатный лимит. До следующего запроса осталось $days дн.';
  }

  @override
  String get oracle_error_stream => 'Ошибка соединения';

  @override
  String get oracle_error_start => 'Не удалось начать';

  @override
  String get error_generic => 'Произошла ошибка. Попробуйте позже.';

  @override
  String get referral_already_used => 'Вы уже использовали реферальный код.';

  @override
  String get referral_own_code => 'Нельзя использовать свой собственный код.';

  @override
  String get referral_success =>
      'Код успешно активирован! Вам начислено 3 дня Premium.';

  @override
  String get tab_astrology => 'Астрология';

  @override
  String get tab_numerology => 'Нумерология';

  @override
  String get tab_bazi => 'Бацзы';

  @override
  String get tab_jyotish => 'Джйотиш';

  @override
  String get share_result => 'Поделиться результатом';

  @override
  String get share_preparing => 'Подготовка...';

  @override
  String locked_feature_title(Object title) {
    return 'Раздел $title закрыт';
  }

  @override
  String get locked_feature_desc =>
      'Оформите подписку, чтобы увидеть детальный разбор.';

  @override
  String get get_access_button => 'Получить доступ';

  @override
  String get coming_soon_suffix => '(Скоро)';

  @override
  String get tab_summary => 'Сводка';

  @override
  String get tab_chinese_zodiac => 'Кит. Зодиак';

  @override
  String get summary_verdict_title => 'Общий вердикт';

  @override
  String get webVersionButton => 'Веб-версия';

  @override
  String get uploadPhotoDisclaimer =>
      'Загружая фото, вы подтверждаете, что оно не содержит наготы или насилия. Нарушители будут заблокированы навсегда.';

  @override
  String get iAgree => 'Согласен';

  @override
  String get testers_banner_title => 'ИЩЕМ ТЕСТИРОВЩИКОВ (4/20)';

  @override
  String get testers_banner_desc =>
      'Помогите улучшить Aryonika и получите\n✨ ВЕЧНЫЙ ПРЕМИУМ ✨';

  @override
  String get testers_email_hint =>
      '(Нажмите, чтобы открыть; Удерживайте, чтобы скопировать)';

  @override
  String get numerology_day_1 =>
      'День начинаний. Идеально для старта проектов.';

  @override
  String get numerology_day_2 => 'День партнерства. Ищите компромиссы.';

  @override
  String get numerology_day_3 => 'День творчества и самовыражения.';

  @override
  String get numerology_day_4 => 'День труда и организации. Наведите порядок.';

  @override
  String get numerology_day_5 => 'День перемен и приключений. Рискуйте.';

  @override
  String get numerology_day_6 => 'День семьи и гармонии.';

  @override
  String get numerology_day_7 => 'День размышлений и уединения.';

  @override
  String get numerology_day_8 => 'День силы и денег. Действуйте масштабно.';

  @override
  String get numerology_day_9 => 'День завершения дел. Отпустите старое.';

  @override
  String get astro_transit_positive_general =>
      'Звезды на вашей стороне. Действуйте смело.';

  @override
  String get advice_general_balance =>
      'Сохраняйте баланс между чувствами и разумом.';

  @override
  String get astro_advice_listen_intuition =>
      'Луна усиливает вашу интуицию. Слушайте внутренний голос.';

  @override
  String get astro_advice_act_boldly =>
      'Энергия планет способствует действиям. Не бойтесь проявлять смелость.';

  @override
  String get astro_advice_rest_and_reflect =>
      'Звезды советуют замедлиться. Найдите время для отдыха и восстановления.';

  @override
  String get astro_advice_connect_with_nature =>
      'Благоприятное время для заземления. Проведите время на природе.';

  @override
  String get advice_generic_positive =>
      'Сегодня Вселенная на вашей стороне. Действуйте осознанно.';

  @override
  String get channelLoadError => 'Не удалось загрузить канал';

  @override
  String get postsTitle => 'Публикации';

  @override
  String get noPostsYet => 'В этом канале пока нет публикаций.';

  @override
  String get createPostTooltip => 'Создать пост';

  @override
  String get proposePost => 'Предложить новость';

  @override
  String get channelsTitle => 'Каналы';

  @override
  String get noChannelSubscriptions => 'У вас пока нет подписок';

  @override
  String get noMessagesYet => 'Нет сообщений';

  @override
  String get yesterday => 'Вчера';

  @override
  String get search => 'Поиск';

  @override
  String get adminOnlyFeature =>
      'Создание каналов временно доступно только администраторам.';

  @override
  String get createChannel => 'Создать канал';

  @override
  String get galacticBroadcasts => 'Галактические Трансляции';

  @override
  String get noChannelsYet =>
      'Вы пока ни на что не подписаны.\nНайдите или создайте свой канал!';

  @override
  String get constellationsTitle => 'Созвездия';

  @override
  String get privateChatsTab => 'Личные';

  @override
  String get channelsTab => 'Каналы';

  @override
  String get loadingUser => 'Загрузка пользователя...';

  @override
  String get emptyChatsPlaceholder =>
      'Здесь будут ваши личные чаты.\nНайдите кого-нибудь интересного через поиск!';

  @override
  String get errorTitle => 'Ошибка';

  @override
  String get autoDeleteMessages => 'Автоудаление сообщений';

  @override
  String get availableInPro => 'Доступно в PRO';

  @override
  String get timerOff => 'Отключено';

  @override
  String get timer15min => '15 минут';

  @override
  String get timer1hour => '1 час';

  @override
  String get timer4hours => '4 часа';

  @override
  String get timer24hours => '24 часа';

  @override
  String get timerSet => 'Таймер установлен';

  @override
  String get disappearingMessages => 'Исчезающие сообщения';

  @override
  String get communicationTitle => 'Общение';

  @override
  String get errorLoadingReport => 'Ошибка загрузки отчета';

  @override
  String get compatibility => 'Совместимость';

  @override
  String get strengths => 'Сильные стороны';

  @override
  String get weaknesses => 'Возможные трудности';

  @override
  String get commentsTitle => 'Комментарии';

  @override
  String get commentsLoadError => 'Ошибка загрузки комментариев.';

  @override
  String get noCommentsYet => 'Здесь пока нет комментариев.';

  @override
  String userIsTyping(Object name) {
    return '$name печатает...';
  }

  @override
  String twoUsersTyping(Object name1, Object name2) {
    return '$name1 и $name2 печатают...';
  }

  @override
  String manyUsersTyping(Object count, Object name1, Object name2) {
    return '$name1, $name2 и еще $count печатают...';
  }

  @override
  String replyingTo(Object name) {
    return 'Ответ для $name';
  }

  @override
  String get writeCommentHint => 'Написать комментарий...';

  @override
  String get compatibilityTitle => 'Космическая Связь';

  @override
  String get noData => 'Нет данных';

  @override
  String get westernAstrology => 'Западная Астрология';

  @override
  String get vedicAstrology => 'Ведическая (Джйотиш)';

  @override
  String get numerology => 'Нумерология';

  @override
  String get chineseZodiac => 'Китайский Зодиак';

  @override
  String get baziElements => 'Бацзы (Стихии)';

  @override
  String get availableInPremium => 'Доступно в Premium';

  @override
  String get verdictSoulmates => 'Родственные Души';

  @override
  String get verdictGreatMatch => 'Отличная Пара';

  @override
  String get verdictPotential => 'Есть Потенциал';

  @override
  String get verdictKarmic => 'Кармический Урок';

  @override
  String get createChannelTitle => 'Создание Трансляции';

  @override
  String get channelNameLabel => 'Название трансляции';

  @override
  String get channelNameHint => 'Например, \'Ежедневные прогнозы Карт Судьбы\'';

  @override
  String get errorChannelNameEmpty => 'Название не может быть пустым';

  @override
  String get channelHandleLabel => 'Уникальный ID (@handle)';

  @override
  String get errorChannelHandleShort => 'ID должен быть длиннее 4 символов';

  @override
  String get channelDescriptionLabel => 'Описание';

  @override
  String get channelDescriptionHint => 'Расскажите, о чем ваш канал...';

  @override
  String get errorChannelDescriptionEmpty => 'Добавьте описание';

  @override
  String get createButton => 'Создать';

  @override
  String get editProfileTitle => 'Редактирование профиля';

  @override
  String get profileNotFoundError => 'Ошибка: профиль не найден';

  @override
  String get profileSavedSuccess => 'Профиль успешно сохранен!';

  @override
  String get saveError => 'Ошибка сохранения';

  @override
  String get avatarUploadError => 'Ошибка загрузки фото';

  @override
  String get nameLabel => 'Имя';

  @override
  String get bioLabel => 'О себе';

  @override
  String get birthDataTitle => 'Данные рождения';

  @override
  String get birthDataWarning =>
      'Изменение этих данных приведет к полному пересчету вашего астрологического и нумерологического портрета.';

  @override
  String get birthDateLabel => 'Дата рождения';

  @override
  String get birthPlaceLabel => 'Место рождения';

  @override
  String get errorUserNotFound => 'Error: User not found';

  @override
  String get feedUpdateError => 'Feed update error';

  @override
  String get feedEmptyMessage => 'Your feed is empty.\nPull down to refresh.';

  @override
  String get whereToSearch => 'Где искать';

  @override
  String get searchNearby => 'Рядом';

  @override
  String get searchCity => 'Город';

  @override
  String get searchCountry => 'Страна';

  @override
  String get searchWorld => 'Весь мир';

  @override
  String get ageLabel => 'Возраст';

  @override
  String get showGenderLabel => 'Показывать';

  @override
  String get genderAll => 'Всех';

  @override
  String get zodiacFilterLabel => 'Фильтр по стихиям';

  @override
  String get resetFilters => 'Сбросить';

  @override
  String get applyFilters => 'Применить';

  @override
  String get forecastLoadError =>
      'Не удалось загрузить прогноз.\nПопробуйте позже.';

  @override
  String get noForecastEvents =>
      'На сегодня нет значимых астрологических событий.\nСпокойный день!';

  @override
  String get unlockFullForecast => 'Разблокировать полный прогноз';

  @override
  String get myFriendsTab => 'Мои друзья';

  @override
  String get friendRequestsTab => 'Заявки';

  @override
  String get noFriendsYet => 'У вас пока нет друзей. Найдите их в поиске!';

  @override
  String get noFriendRequests => 'Нет новых заявок.';

  @override
  String get removeFriend => 'Удалить из друзей';

  @override
  String get gamesComingSoonTitle => 'Игры и Награды скоро появятся!';

  @override
  String get gamesComingSoonDesc =>
      'Мы готовим увлекательные мини-игры и квизы. Проверяйте свою совместимость, зарабатывайте \"Звездную пыль\" и обменивайте ее на премиум-дни или уникальные подарки!';

  @override
  String get joinTelegramButton => 'Узнавайте первыми в нашем Telegram';

  @override
  String horoscopeForSign(Object sign) {
    return 'Гороскоп для знака $sign';
  }

  @override
  String get horoscopeGeneral => 'Общий';

  @override
  String get horoscopeLove => 'Любовный';

  @override
  String get horoscopeBusiness => 'Деловой';

  @override
  String get verdictNotFound => 'Вердикт не найден';

  @override
  String get vedicCompatibilityTitle => 'Ведическая совместимость';

  @override
  String get ashtaKutaAnalysis => 'Детальный анализ (Ашта-Кута)';

  @override
  String get noDescription => 'Описание не найдено.';

  @override
  String get likesYouEmpty => 'Здесь будут те, кто вами заинтересуется';

  @override
  String peopleLikeYou(Object count) {
    return 'Вы нравитесь $count людям!';
  }

  @override
  String get getProToSeeLikes =>
      'Получите PRO-статус, чтобы увидеть их профили и начать общение.';

  @override
  String get seeLikesButton => 'Посмотреть';

  @override
  String get someone => 'Кто-то';

  @override
  String get selectCityTitle => 'Выберите город';

  @override
  String get searchCityHint => 'Введите название города...';

  @override
  String get nothingFound => 'Ничего не найдено';

  @override
  String get errorNatalChartMissing =>
      'Ошибка: ваша натальная карта не рассчитана.';

  @override
  String get manualCheckTitle => 'Ручная проверка';

  @override
  String get checkAgainTooltip => 'Проверить еще раз';

  @override
  String get synastryTitle => 'Синастрия Партнеров';

  @override
  String get synastryDesc =>
      'Введите данные рождения человека, чтобы рассчитать вашу детальную совместимость.';

  @override
  String get partnerNameLabel => 'Имя партнера';

  @override
  String get tapToSelect => 'Нажмите, чтобы выбрать';

  @override
  String get calculateButton => 'Рассчитать';

  @override
  String get you => 'Вы';

  @override
  String summary_desc(Object score, Object verdict) {
    return 'Ваш союз имеет потенциал $score%. Звезды и числа указывают на $verdict.';
  }

  @override
  String get strongConnection => 'сильную связь';

  @override
  String get interestingLessons => 'интересные уроки';

  @override
  String get moderationProposedPosts => 'Предложенные посты';

  @override
  String get noProposedPosts => 'Нет предложенных постов.';

  @override
  String get from => 'От';

  @override
  String get personalNumerologyTitle => 'Личная Нумерология';

  @override
  String get dataNotLoaded => 'Данные не загружены';

  @override
  String get loading => 'Загрузка...';

  @override
  String get lifePathNumber => 'Число Жизненного Пути';

  @override
  String get corePersonality => 'Ядро Личности';

  @override
  String get destinyNumber => 'Число Судьбы';

  @override
  String get soulNumber => 'Число Души';

  @override
  String get personalityNumber => 'Число Личности';

  @override
  String get timeInfluence => 'Влияние Времени';

  @override
  String get maturityNumber => 'Число Зрелости';

  @override
  String get birthdayNumber => 'День Рождения';

  @override
  String get currentVibrationsPro => 'Текущие Вибрации (PRO)';

  @override
  String get personalYear => 'Личный Год';

  @override
  String get personalMonth => 'Личный Месяц';

  @override
  String get personalDay => 'Личный День';

  @override
  String get proVibrationsDesc =>
      'Узнайте свои вибрации на Год, Месяц и День. Доступно только в Premium версии.';

  @override
  String get unlockButton => 'Разблокировать';

  @override
  String get tapForDetails => 'Нажмите подробнее';

  @override
  String oracle_weather_desc(Object desc, Object kp) {
    return '$desc (Kp: $kp)';
  }

  @override
  String oracle_geomagnetic_now(Object desc) {
    return 'Сейчас: $desc';
  }

  @override
  String oracle_geomagnetic_index(Object kp) {
    return 'Индекс Kp: $kp';
  }

  @override
  String get oracle_question_title => 'Вопрос Оракулу';

  @override
  String get oracle_question_hint => 'Что вас волнует?...';

  @override
  String get oracle_question_button => 'Получить ответ';

  @override
  String get palmistry_analysis_title => 'Анализ Ладони';

  @override
  String get palmistry_choose_option => 'Выберите наиболее подходящий вариант:';

  @override
  String get palmistry_analysis_saved => 'Анализ сохранен!';

  @override
  String get palmistry_view_report => 'Посмотреть полный отчет';

  @override
  String get palmistry_complete_all => 'Завершите анализ всех линий';

  @override
  String get palmistry_analysis_complete => 'Отлично! Анализ завершен.';

  @override
  String palmistry_tap_line(Object lineName) {
    return 'Нажмите на \'$lineName\', чтобы сравнить со своей ладонью.';
  }

  @override
  String palmistry_searching_line(Object lineName) {
    return 'Идет поиск \'$lineName\'...';
  }

  @override
  String get palmistry_preparing => 'Подготовка к анализу...';

  @override
  String get palmistry_report_title => 'Карта Вашей Судьбы';

  @override
  String get palmistry_data_not_found => 'Данные анализа не найдены.';

  @override
  String get palmistry_strong_traits => 'Ваши сильные стороны';

  @override
  String get privacy => 'Приватность';

  @override
  String get palmistry_show_in_profile => 'Показывать мои черты в профиле';

  @override
  String get palmistry_show_in_profile_desc =>
      'Это позволит другим лучше узнать вас и улучшит подбор совместимости.';

  @override
  String get palmistry_interpretation => 'Расшифровка линий';

  @override
  String palmistry_your_choice(Object choice) {
    return 'Ваш выбор: \"$choice\"';
  }

  @override
  String get photoAlbumComingSoon =>
      'Скоро вы сможете загружать сюда свои фото.';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get accountManagement => 'Управление аккаунтом';

  @override
  String get changePassword => 'Сменить пароль';

  @override
  String get restorePassword => 'Восстановить пароль';

  @override
  String get editProfileButton => 'Редактировать профиль';

  @override
  String get dailyNotifications => 'Ежедневные уведомления';

  @override
  String get alertsTitle => 'Оповещения';

  @override
  String get geomagneticStorms => 'Геомагнитные бури';

  @override
  String get adminPanelTitle => 'Панель Администратора';

  @override
  String get adminManageUsers => 'Управление пользователями';

  @override
  String get offerAgreementLink => 'Договор оферты';

  @override
  String get accountSectionTitle => 'Аккаунт';

  @override
  String get deleteAccountButton => 'Удалить аккаунт';

  @override
  String get closeAppButton => 'Закрыть приложение';

  @override
  String get changePasswordDesc =>
      'Для безопасности введите ваш текущий пароль.';

  @override
  String get currentPasswordLabel => 'Текущий пароль';

  @override
  String get newPasswordLabel => 'Новый пароль';

  @override
  String get passwordChangedSuccess => 'Пароль успешно изменен!';

  @override
  String resetPasswordInstruction(String email) {
    return 'Мы отправим инструкцию для сброса пароля на ваш E-mail: \n\n$email';
  }

  @override
  String get signOutDialogTitle => 'Выход из аккаунта';

  @override
  String get signOutDialogContent => 'Вы уверены, что хотите выйти?';

  @override
  String get deleteAccountTitle => 'Удалить аккаунт?';

  @override
  String get deleteAccountWarning =>
      'Это действие необратимо. Все ваши данные, переписки, фото и покупки будут удалены навсегда.';

  @override
  String get deleteForeverButton => 'Удалить навсегда';

  @override
  String get roulette_trust_fate => 'Доверьтесь судьбе';

  @override
  String get roulette_desc_short =>
      'Звезды выберут для вас самого совместимого партнера (от 85%!).';

  @override
  String get roulette_no_candidates => 'Нет кандидатов для вращения.';

  @override
  String get roulette_winner_title => 'Звезды сделали свой выбор!';

  @override
  String get roulette_spin_again => 'Крутить еще раз';

  @override
  String get roulette_go_to_profile => 'Перейти в профиль';

  @override
  String get cityNotSpecified => 'Город не указан';

  @override
  String get geomagnetic_calm => 'Спокойно';

  @override
  String get geomagnetic_unsettled => 'Нестабильно';

  @override
  String get geomagnetic_active => 'Активно';

  @override
  String get geomagnetic_storm_minor => 'Малая буря (G1)';

  @override
  String get geomagnetic_storm_moderate => 'Умеренная буря (G2)';

  @override
  String get geomagnetic_storm_strong => 'Сильная буря (G3)';

  @override
  String get geomagnetic_storm_severe => 'Жестокая буря (G4)';

  @override
  String get geomagnetic_storm_extreme => 'Экстрем. буря (G5)';

  @override
  String get deleteChatTitle => 'Удалить чат?';

  @override
  String get deleteChatConfirmation =>
      'Вся переписка будет удалена безвозвратно.';

  @override
  String get chatDeleted => 'Чат удален';
}
