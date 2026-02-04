// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get profileCreationErrorTitle => 'Fehler bei der Profilerstellung';

  @override
  String get profileCreationErrorDescription =>
      'Leider ist beim Speichern Ihrer Daten ein Fehler aufgetreten. Bitte versuchen Sie, sich erneut zu registrieren.';

  @override
  String get tryAgain => 'Erneut versuchen';

  @override
  String get connectingHearts => 'Herzen im Universum verbinden...';

  @override
  String get appName => 'Aryonika';

  @override
  String get exitConfirmationTitle => 'Bestätigung';

  @override
  String get exitConfirmationContent =>
      'Sind Sie sicher, dass Sie Aryonika schließen möchten?';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get close => 'Schließen';

  @override
  String get paymentUrlError => 'Fehler: Zahlungs-URL nicht gefunden.';

  @override
  String get channelIdError => 'Fehler: Kanal-ID nicht gefunden.';

  @override
  String documentLoadError(Object error) {
    return 'Ошибка загрузки документа: $error';
  }

  @override
  String get partnerIdError =>
      'Fehler: Partner-ID wird für die Kompatibilitätsberechnung benötigt.';

  @override
  String get bioPlaceholder => 'Hier könnte Ihre Geschichte stehen...';

  @override
  String photoAlbumTitle(Object photoCount) {
    return 'Fotoalbum ($photoCount)';
  }

  @override
  String get photoAlbumSubtitle => 'Ihre besten Momente';

  @override
  String get cosmicEventsTitle => 'Kosmische Ereignisse';

  @override
  String get cosmicEventsSubtitle =>
      'Erfahren Sie mehr über den Einfluss der Planeten';

  @override
  String get inviteFriendTitle => 'Einen Freund einladen';

  @override
  String get inviteFriendSubtitle => 'Gemeinsam Boni erhalten';

  @override
  String get gameCenterTitle => 'Spielcenter';

  @override
  String get gameCenterSubtitle => 'Minispiele und Quests';

  @override
  String get personalForecastTitle => 'Persönliche Vorhersage';

  @override
  String get personalForecastSubtitlePro => 'Analyse der Transite für heute';

  @override
  String get personalForecastSubtitleFree => 'Verfügbar mit PRO-Status';

  @override
  String get cosmicPassportTitle => 'KOSMISCHER PASS';

  @override
  String get numerologyPortraitTitle => 'Numerologisches Porträt';

  @override
  String get yourNumbersOfDestinyTitle => 'Ihre Schicksalszahlen';

  @override
  String get yourNumbersOfDestinySubtitle => 'Entfalten Sie Ihr Potenzial';

  @override
  String get numerologyPath => 'Lebensweg';

  @override
  String get numerologyDestiny => 'Schicksal';

  @override
  String get numerologySoul => 'Seele';

  @override
  String get signOut => 'Abmelden';

  @override
  String get calculatingChart => 'Horoskop wird berechnet...';

  @override
  String get astroDataSignMissing => 'Daten für dieses Zeichen fehlen.';

  @override
  String astroDataDescriptionNotFound(Object signName) {
    return 'Beschreibung für \"$signName\" nicht gefunden.';
  }

  @override
  String astroDataMapNotLoaded(Object mapKey) {
    return 'Daten für \"$mapKey\" nicht geladen.';
  }

  @override
  String get planetSun => 'Sonne';

  @override
  String get planetMoon => 'Mond';

  @override
  String get planetAscendant => 'Aszendent';

  @override
  String get planetMercury => 'Merkur';

  @override
  String get planetVenus => 'Venus';

  @override
  String get planetMars => 'Mars';

  @override
  String get planetSaturn => 'Saturn';

  @override
  String get planetJupiter => 'Jupiter';

  @override
  String get planetUranus => 'Uranus';

  @override
  String get planetNeptune => 'Neptun';

  @override
  String get planetPluto => 'Pluto';

  @override
  String get getProTitle => 'PRO erhalten';

  @override
  String get getProSubtitle => 'Alle Funktionen freischalten';

  @override
  String get proStatusActive => 'PRO-Status ist aktiv';

  @override
  String get proStatusExpired => 'Status ist abgelaufen';

  @override
  String proStatusDaysLeft(Object days) {
    return 'Verbleibende Tage: $days';
  }

  @override
  String proStatusHoursLeft(Object hours) {
    return 'Verbleibende Stunden: $hours';
  }

  @override
  String get proStatusExpiresToday => 'Läuft heute ab';

  @override
  String astroDialogTitle(Object planetName, Object signName) {
    return '$planetName in $signName';
  }

  @override
  String get likesYouTitle => 'Likes Dich';

  @override
  String likesYouTotal(Object count) {
    return 'Gesamte Likes: $count';
  }

  @override
  String get likesYouNone => 'Noch keine Likes';

  @override
  String reportOnUser(Object userName) {
    return '$userName melden';
  }

  @override
  String get reportReasonSpam => 'Spam';

  @override
  String get reportReasonInsultingBehavior => 'Beleidigendes Verhalten';

  @override
  String get reportReasonScam => 'Betrug';

  @override
  String get reportReasonInappropriateContent => 'Unangemessener Inhalt';

  @override
  String get reportDetailsHint => 'Zusätzliche Details (optional)';

  @override
  String get send => 'Senden';

  @override
  String get reportSentSnackbar =>
      'Vielen Dank! Ihre Meldung wurde übermittelt.';

  @override
  String get profileLoadError => 'Profil konnte nicht geladen werden';

  @override
  String get back => 'Zurück';

  @override
  String get report => 'Melden';

  @override
  String userProfilePhotoAlbumTitle(Object photoCount) {
    return 'Fotoalbum ($photoCount)';
  }

  @override
  String get userProfileViewPhotos => 'Fotos ansehen';

  @override
  String get aboutMe => 'Über mich';

  @override
  String get bioEmpty => 'Dieser Benutzer hat noch nichts über sich erzählt.';

  @override
  String get cosmicPassport => 'Kosmischer Pass';

  @override
  String sunInSign(Object signName) {
    return '☀️ Sonne in $signName';
  }

  @override
  String get friendshipStatusFriends => 'Ihr seid Freunde';

  @override
  String get friendshipRemoveTitle => 'Aus Freunden entfernen?';

  @override
  String friendshipRemoveContent(Object userName) {
    return 'Sind Sie sicher, dass Sie $userName aus Ihren Freunden entfernen möchten?';
  }

  @override
  String get remove => 'Entfernen';

  @override
  String get friendshipStatusRequestSent => 'Anfrage gesendet';

  @override
  String get friendshipActionDecline => 'Ablehnen';

  @override
  String get friendshipActionAccept => 'Annehmen';

  @override
  String get friendshipActionAdd => 'Als Freund hinzufügen';

  @override
  String likeSnackbarSuccess(Object userName) {
    return 'Sie haben $userName ein Like gegeben!';
  }

  @override
  String likeSnackbarAlreadyLiked(Object userName) {
    return 'Sie haben $userName bereits ein Like gegeben';
  }

  @override
  String get writeMessage => 'Nachricht schreiben';

  @override
  String get checkCompatibility => 'Kompatibilität prüfen';

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
  String get cosmicConnectionTitle => 'Kosmische Verbindung';

  @override
  String shareText(Object name, Object score) {
    return 'Unsere Kompatibilität mit $name beträgt $score%! ✨\nBerechnet in Aryonika';
  }

  @override
  String get shareErrorSnackbar => 'Beim Teilen ist ein Fehler aufgetreten.';

  @override
  String get compatibilityErrorTitle =>
      'Kompatibilität konnte nicht berechnet werden';

  @override
  String get compatibilityErrorSubtitle =>
      'Die Daten des Partners sind möglicherweise unvollständig oder es ist ein Netzwerkfehler aufgetreten.';

  @override
  String get goBack => 'Zurückgehen';

  @override
  String get sectionCosmicAdvice => 'KOSMISCHER RATSCHLAG';

  @override
  String get sectionDailyInfluence => 'TÄGLICHER EINFLUSS';

  @override
  String get sectionAstrologicalResonance => 'ASTROLOGISCHE RESONANZ';

  @override
  String get sectionNumerologyMatrix => 'NUMEROLOGISCHE MATRIX';

  @override
  String get sectionPalmistryConnection => 'HANDLESEN-VERBINDUNG';

  @override
  String get sectionAboutPerson => 'ÜBER DIE PERSON';

  @override
  String get palmistryNoData =>
      'Einer der Partner hat die Handanalyse noch nicht abgeschlossen. Dies wird eine neue Ebene Ihrer Kompatibilität freischalten!';

  @override
  String palmistryCommonTraits(Object traits) {
    return 'Euch verbindet: $traits. Dies schafft eine solide Grundlage für eure Beziehung.';
  }

  @override
  String palmistryUniqueTraits(Object myTrait, Object partnerTrait) {
    return 'Ihr ergänzt euch gegenseitig: dein Merkmal \'$myTrait\' harmoniert perfekt mit seinem/ihrem \'$partnerTrait\'.';
  }

  @override
  String get harmony => 'Harmonie';

  @override
  String get adviceRareConnection =>
      'Eure Seelen schwingen im Einklang. Dies ist eine seltene kosmische Verbindung, bei der sowohl Persönlichkeiten (Sonne) als auch Emotionen (Mond) harmonieren. Schätzt diesen Schatz.';

  @override
  String get advicePassionChallenge =>
      'Zwischen euch wütet eine Flamme der Leidenschaft, aber eure Persönlichkeiten könnten aneinandergeraten. Lernt, Streit in Energie für Wachstum umzuwandeln, und eure Verbindung wird unzerbrechlich.';

  @override
  String get adviceBestFriends =>
      'Ihr seid beste Freunde, die sich auf einen Blick verstehen und sich wohlfühlen. Die körperliche Anziehung kann mit der Zeit wachsen; das Wichtigste ist eure seelische Nähe.';

  @override
  String get adviceKarmicLesson =>
      'Eure Wege haben sich nicht zufällig gekreuzt. Diese Verbindung birgt wichtige Lektionen für euch beide. Seid geduldig und offen, um zu verstehen, was ihr einander lehren müsst.';

  @override
  String get adviceGreatPotential =>
      'Es gibt eine starke Anziehung zwischen euch und großes Wachstumspotenzial. Lernt voneinander, und eure Verbindung wird stärker. Die Sterne stehen auf eurer Seite.';

  @override
  String get adviceBase =>
      'Studiert einander. Jede Begegnung ist eine Gelegenheit, ein neues Universum zu entdecken. Eure Geschichte fängt gerade erst an.';

  @override
  String get dailyInfluenceCalm =>
      'Kosmische Flaute. Ein großartiger Tag, um einfach die Gesellschaft des anderen ohne äußere Einflüsse zu genießen.';

  @override
  String get dailyAdviceFavorable =>
      'Tipp: Nutzt diese Energie! Ein ausgezeichneter Moment für gemeinsame Pläne.';

  @override
  String get dailyAdviceTense =>
      'Tipp: Seid geduldiger miteinander. Missverständnisse sind möglich.';

  @override
  String get proFeatureLocked =>
      'Eine detaillierte Analyse dieses Aspekts ist in der PRO-Version verfügbar.';

  @override
  String get getProButton => 'PRO holen';

  @override
  String get numerologyLifePath => 'Lebensweg';

  @override
  String get numerologyDestinyNumber => 'Schicksalszahl';

  @override
  String get numerologySoulNumber => 'Seelenzahl';

  @override
  String get shareCardTitle => 'Aryonika';

  @override
  String get shareCardSubtitle => 'KOSMISCHER KOMPATIBILITÄTSBERICHT';

  @override
  String get shareCardHarmony => 'Gesamtharmonie';

  @override
  String get shareCardPersonalityHarmony => 'Persönlichkeitsharmonie (Sonne)';

  @override
  String get shareCardLifePath => 'Lebensweg (Numerologie)';

  @override
  String get shareCardCtaTitle => 'Entdecke deine kosmische\nKompatibilität!';

  @override
  String get shareCardCtaSubtitle => 'Lade Aryonika im RuStore herunter';

  @override
  String get loginTitle => 'Anmelden';

  @override
  String get loginError => 'Anmeldefehler';

  @override
  String get passwordResetTitle => 'Passwort zurücksetzen';

  @override
  String get passwordResetContent =>
      'Geben Sie Ihre E-Mail-Adresse ein, und wir senden Ihnen Anweisungen zum Zurücksetzen Ihres Passworts.';

  @override
  String get emailLabel => 'E-Mail';

  @override
  String get sendButton => 'Senden';

  @override
  String get emailValidationError =>
      'Bitte geben Sie eine gültige E-Mail-Adresse ein.';

  @override
  String get passwordResetSuccess =>
      'E-Mail gesendet! Überprüfen Sie Ihren Posteingang.';

  @override
  String get passwordLabel => 'Passwort';

  @override
  String get loginButton => 'Anmelden';

  @override
  String get forgotPasswordButton => 'Passwort vergessen?';

  @override
  String get noAccountButton => 'Kein Konto? Registrieren';

  @override
  String get registerTitle => 'Konto erstellen';

  @override
  String get unknownError => 'Ein unbekannter Fehler ist aufgetreten';

  @override
  String get confirmPasswordLabel => 'Passwort bestätigen';

  @override
  String get privacyPolicyCheckbox => 'Ich akzeptiere die ';

  @override
  String get termsOfUseLink => 'Nutzungsbedingungen';

  @override
  String get and => ' und die ';

  @override
  String get privacyPolicyLink => 'Datenschutzrichtlinie';

  @override
  String get registerButton => 'Registrieren';

  @override
  String get alreadyHaveAccountButton => 'Bereits ein Konto? Anmelden';

  @override
  String get welcomeTagline =>
      'Dein Schicksal steht in den Sternen geschrieben';

  @override
  String get welcomeCreateAccountButton => 'Einen kosmischen Pass erstellen';

  @override
  String get welcomeLoginButton => 'Ich habe bereits ein Konto';

  @override
  String get introSlide1Title => 'Aryonika — Mehr als nur Dating';

  @override
  String get introSlide1Description =>
      'Entdecken Sie neue Ebenen der Kompatibilität durch Astrologie, Numerologie und Schicksalskarten.';

  @override
  String get introSlide2Title => 'Ihr kosmischer Pass';

  @override
  String get introSlide2Description =>
      'Erfahren Sie alles über Ihr Potenzial und finden Sie denjenigen, der Ihr Universum vervollständigt.';

  @override
  String get introSlide3Title => 'Treten Sie der Galaxie bei';

  @override
  String get introSlide3Description =>
      'Beginnen Sie jetzt Ihre kosmische Reise zur wahren Liebe.';

  @override
  String get introButtonSkip => 'Überspringen';

  @override
  String get introButtonNext => 'Weiter';

  @override
  String get introButtonStart => 'Start';

  @override
  String get onboardingNameTitle => 'Wie heißen Sie?';

  @override
  String get onboardingNameSignOutTooltip => 'Abmelden (zum Testen)';

  @override
  String get onboardingNameSubtitle =>
      'Dieser Name wird für andere Benutzer sichtbar sein.';

  @override
  String get onboardingNameLabel => 'Ihr Name';

  @override
  String get onboardingBioLabel => 'Erzählen Sie uns von sich';

  @override
  String get onboardingBioHint =>
      'Beispiel: Ich liebe Astrologie und #Reisen...';

  @override
  String get onboardingButtonNext => 'Weiter';

  @override
  String get onboardingBirthdateTitle => 'Wann sind Sie geboren?';

  @override
  String get onboardingBirthdateSubtitle =>
      'Dies ist für eine genaue Berechnung Ihres Geburtshoroskops und Ihrer Numerologie erforderlich.';

  @override
  String get datePickerHelpText => 'GEBURTSDATUM AUSWÄHLEN';

  @override
  String get birthdateLabel => 'Geburtsdatum';

  @override
  String get birthdatePlaceholder => 'Zum Auswählen tippen';

  @override
  String get dateFormat => 'd. MMMM yyyy';

  @override
  String get onboardingFinishText1 =>
      'Die Position der Sterne wird analysiert...';

  @override
  String get onboardingFinishText2 =>
      'Ihr numerologischer Code wird berechnet...';

  @override
  String get onboardingFinishText3 => 'Abgleich mit den Schicksalskarten...';

  @override
  String get onboardingFinishText4 => 'Ihr kosmischer Pass wird erstellt...';

  @override
  String get onboardingFinishErrorTitle => 'Fehler';

  @override
  String get onboardingFinishErrorContent =>
      'Ein unbekannter Fehler ist aufgetreten.';

  @override
  String get onboardingFinishErrorButton => 'Zurück';

  @override
  String get onboardingGenderTitle => 'Ihr Geschlecht';

  @override
  String get onboardingGenderSubtitle =>
      'Dies hilft uns, die passendsten Personen für Sie zu finden.';

  @override
  String get genderMale => 'Männer';

  @override
  String get genderFemale => 'Frauen';

  @override
  String get onboardingLocationTitle => 'Geburtsort';

  @override
  String get onboardingLocationSubtitle =>
      'Bitte geben Sie die Stadt an, in der Sie geboren wurden. Dies ist für eine genaue astrologische Berechnung erforderlich.';

  @override
  String get onboardingLocationSearchHint =>
      'Beginnen Sie, eine Stadt einzugeben...';

  @override
  String get onboardingLocationNotFound =>
      'Keine Städte gefunden. Versuchen Sie eine andere Anfrage.';

  @override
  String get onboardingLocationStartSearch =>
      'Starten Sie die Suche, um Ergebnisse zu sehen';

  @override
  String get onboardingLocationSelectFromList =>
      'Wählen Sie eine Stadt aus der Liste oben, um fortzufahren';

  @override
  String get onboardingTimeTitle => 'Geburtszeit';

  @override
  String get onboardingTimeSubtitle =>
      'Wenn Sie die genaue Zeit nicht kennen, stellen Sie sie auf 12:00 Uhr.\nDies liefert dennoch ein gutes Ergebnis.';

  @override
  String get timePickerHelpText => 'GEBURTSDATUMSZEIT AUSWÄHLEN';

  @override
  String get birthTimeLabel => 'Geburtszeit';

  @override
  String get onboardingButtonNextLocation => 'Weiter (Ort auswählen)';

  @override
  String get alphaBannerTitle => 'Alpha-Version';

  @override
  String get alphaBannerContent =>
      'Dieser Bereich wird aktiv entwickelt. Einige Funktionen können instabil sein. Wir arbeiten aktiv an der Lokalisierung, daher können einige Texte noch auf Russisch sein. Vielen Dank für Ihr Verständnis!';

  @override
  String get alphaBannerFeedback =>
      'Wir freuen uns über Ihr Feedback und Ihre Vorschläge in unserem Telegram-Kanal!';

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
  String get cosmicPulseTitle => 'Kosmischer Puls';

  @override
  String get feedIceBreakerTitle => 'Eisbrecher';

  @override
  String get feedOrbitCrossingTitle => 'Orbitalkreuzung';

  @override
  String get feedSpiritualNeighborTitle => 'Spiritueller Nachbar';

  @override
  String get feedGeomagneticStormTitle => 'Geomagnetischer Sturm';

  @override
  String get feedCompatibilityPeakTitle => 'Kompatibilitätsgipfel';

  @override
  String get feedNewChannelSuggestionTitle => 'Neuer Kanal';

  @override
  String get feedPopularPostTitle => 'Beliebter Beitrag';

  @override
  String get feedNewCommentTitle => 'Neuer Kommentar';

  @override
  String get cardOfTheDayTitle => 'Karte des Tages';

  @override
  String get cardOfTheDayDrawing => 'Ziehe deine Karte...';

  @override
  String get cardOfTheDayGetButton => 'Karte ziehen';

  @override
  String get cardOfTheDayYourCard => 'Deine Karte des Tages';

  @override
  String get cardOfTheDayTapToReveal => 'Tippen zum Aufdecken';

  @override
  String get cardOfTheDayReversedSuffix => ' (Umgekehrt)';

  @override
  String get cardOfTheDayDefaultInterpretation =>
      'Erfahre, was der Tag bringt.';

  @override
  String get channelSearchTitle => 'Kanäle suchen';

  @override
  String get channelAnonymousAuthor => 'Anonym';

  @override
  String get errorUserNotAuthorized => 'Benutzer nicht autorisiert';

  @override
  String get errorUnknownServer => 'Unbekannter Serverfehler';

  @override
  String get errorFailedToLoadData => 'Daten konnten nicht geladen werden';

  @override
  String get generalHello => 'Hallo';

  @override
  String get referralErrorProfileNotLoaded =>
      'Fehler: Ihr Profil ist nicht geladen. Bitte versuchen Sie es später erneut.';

  @override
  String get referralErrorAlreadyUsed =>
      'Sie haben bereits einen Empfehlungscode verwendet.';

  @override
  String get referralErrorOwnCode =>
      'Sie können Ihren eigenen Code nicht verwenden.';

  @override
  String get referralScreenTitle => 'Freund einladen';

  @override
  String get referralYourCodeTitle => 'Dein Einladungscode';

  @override
  String get referralYourCodeDescription =>
      'Teile diesen Code mit Freunden. Für jeden Freund, der deinen Code eingibt, erhältst du 1 Tag PRO-Zugang!';

  @override
  String get referralCodeCopied => 'Code in die Zwischenablage kopiert!';

  @override
  String get referralShareCodeButton => 'Code teilen';

  @override
  String referralShareMessage(String code) {
    return 'Hallo! Komm zu Aryonika und finde dein kosmisches Gegenstück. Gib meinen Einladungscode in der App ein, damit wir beide Boni erhalten: $code';
  }

  @override
  String get referralManualBonusNote =>
      'Der PRO-Zugang wird manuell innerhalb von 24 Stunden gewährt, nachdem dein Freund den Code eingegeben hat.';

  @override
  String get referralGotCodeTitle => 'Hast du einen Code?';

  @override
  String get referralGotCodeDescription =>
      'Gib den Code ein, den dir dein Freund gegeben hat, damit er seine Belohnung erhält.';

  @override
  String get referralCodeInputLabel => 'Einladungscode';

  @override
  String get referralCodeValidationError => 'Bitte gib einen Code ein';

  @override
  String get referralApplyCodeButton => 'Code anwenden';

  @override
  String get nav_feed => 'Feed';

  @override
  String get nav_search => 'Suche';

  @override
  String get nav_oracle => 'Orakel';

  @override
  String get nav_chats => 'Chats';

  @override
  String get nav_channels => 'Kanäle';

  @override
  String get nav_profile => 'Profil';

  @override
  String get nav_exit => 'Beenden';

  @override
  String get exitDialog_title => 'Bestätigung';

  @override
  String get exitDialog_content => 'Möchtest du Aryonika wirklich schließen?';

  @override
  String get exitDialog_cancel => 'Abbrechen';

  @override
  String get exitDialog_confirm => 'Schließen';

  @override
  String get oracle_limit_title => 'Anfragelimit';

  @override
  String get oracle_limit_later => 'Später';

  @override
  String get oracle_limit_get_pro => 'Unbegrenzt holen';

  @override
  String get oracle_orb_partner => 'Partner des Tages';

  @override
  String get oracle_orb_roulette => 'Roulette';

  @override
  String get oracle_orb_duet => 'Duett';

  @override
  String get oracle_orb_horoscope => 'Horoskop';

  @override
  String get oracle_orb_weather => 'Geomagnetisch';

  @override
  String get oracle_orb_ask => 'Frage';

  @override
  String get oracle_orb_focus => 'Fokus des Tages';

  @override
  String get oracle_orb_forecast => 'AstroVorschau';

  @override
  String get oracle_orb_card => 'Karte des Tages';

  @override
  String get oracle_orb_tarot => 'Antwort des Universums';

  @override
  String get oracle_orb_palmistry => 'Handlesekunst';

  @override
  String get oracle_duet_title => 'Kosmisches Duett';

  @override
  String get oracle_duet_description =>
      'Prüfe die Kompatibilität nach Geburtsdatum.';

  @override
  String get oracle_duet_button => 'Kompatibilität prüfen';

  @override
  String oracle_unsupported_web_feature(String featureName, Object feature) {
    return 'Funktion \'$feature\' nicht im WEB verfügbar.';
  }

  @override
  String get oracle_pro_card_of_day_title => 'Karte des Tages (PRO)';

  @override
  String get oracle_pro_card_of_day_desc =>
      'Entdecke die Energie deines Tages. Nur in PRO.';

  @override
  String get oracle_pro_focus_of_day_title => 'Fokus des Tages (PRO)';

  @override
  String get oracle_pro_focus_of_day_desc =>
      'Worauf du dich heute konzentrieren solltest. Nur in PRO.';

  @override
  String get oracle_pro_forecast_of_day_title => 'Persönliche Vorschau (PRO)';

  @override
  String get oracle_pro_forecast_of_day_desc =>
      'Detaillierte Analyse der Transite. Nur in PRO.';

  @override
  String get oracle_roulette_title => 'Kosmisches Roulette';

  @override
  String get oracle_roulette_description =>
      'Versuche dein Glück! Finde einen Partner.';

  @override
  String get oracle_roulette_button => 'Roulette drehen';

  @override
  String get oracle_card_of_day_reversed => '(umgekehrt)';

  @override
  String get oracle_card_of_day_get_key => 'Persönlicher Schlüssel';

  @override
  String get oracle_palmistry_title => 'Handlesekunst';

  @override
  String get oracle_palmistry_description => 'KI-Analyse der Handlinien.';

  @override
  String get oracle_palmistry_button => 'Hand scannen';

  @override
  String get oracle_ask_loading => 'Das Orakel denkt...';

  @override
  String get oracle_ask_again => 'Nochmal fragen';

  @override
  String get oracle_focus_loading => 'Fokussiere...';

  @override
  String get oracle_focus_error => 'Ladefehler';

  @override
  String get oracle_focus_no_data => 'Keine Daten';

  @override
  String get oracle_forecast_loading =>
      'Deine persönliche Prognose wird erstellt...';

  @override
  String get oracle_forecast_error => 'Prognose konnte nicht erstellt werden';

  @override
  String get oracle_forecast_try_again => 'Erneut versuchen';

  @override
  String get oracle_forecast_title => 'Tagesprognose';

  @override
  String get oracle_forecast_day_number => 'Deine Tageszahl: ';

  @override
  String get oracle_tarot_title => 'Tarot-Legung (KI)';

  @override
  String get oracle_tarot_hint => 'Deine Frage...';

  @override
  String get oracle_tarot_button => 'Legung machen';

  @override
  String oracle_tarot_your_question(String question) {
    return 'Deine Frage: $question';
  }

  @override
  String get oracle_tarot_loading => 'KI analysiert...';

  @override
  String get oracle_tarot_ask_again => 'Nochmal fragen';

  @override
  String get oracle_tarot_card_reversed_short => ' (umg.)';

  @override
  String get oracle_tarot_combo_message => 'Gesamtbotschaft der Karten:';

  @override
  String get oracle_geomagnetic_title => 'Weltraumwetter';

  @override
  String get oracle_geomagnetic_forecast => 'Vorhersage';

  @override
  String get oracle_weather_title => 'Geomagnetische Aktivität';

  @override
  String get oracle_pro_feature_title => 'Partner des Tages (PRO)';

  @override
  String get oracle_pro_feature_desc =>
      'Wir finden den perfekten Partner. Verfügbar in PRO.';

  @override
  String get oracle_partner_loading => 'Suche Partner...';

  @override
  String get oracle_partner_error => 'Suchfehler';

  @override
  String get oracle_partner_not_found => 'Kein Partner gefunden';

  @override
  String get oracle_partner_profile_error => 'Profilfehler';

  @override
  String get oracle_partner_title => 'Dein Partner des Tages';

  @override
  String oracle_partner_compatibility(String score) {
    return 'Kompatibilität: $score%';
  }

  @override
  String get oracle_ask_title => 'Orakel fragen';

  @override
  String get oracle_ask_hint => 'Was beschäftigt dich?..';

  @override
  String get oracle_ask_button => 'Antwort erhalten';

  @override
  String get oracle_tips_loading => 'Lade Tipps...';

  @override
  String get oracle_tips_title => 'Sterntipps für heute';

  @override
  String oracle_tips_subtitle(String count) {
    return 'Für Kommunikation ($count)';
  }

  @override
  String get oracle_tips_general_advice => 'Sei offen und ehrlich.';

  @override
  String get cardOfTheDayProInApp =>
      '✨ Der persönliche Aspekt ist in der mobilen App verfügbar.';

  @override
  String get numerology_report_title => 'Numerologie-Bericht';

  @override
  String get numerology_report_overall => 'Gesamtpunktzahl';

  @override
  String get numerology_report_you => 'Du';

  @override
  String get numerology_report_partner => 'Partner';

  @override
  String get userProfile_numerology_button => 'Numerologie';

  @override
  String get forecast_astrological_title => 'Astrologische Vorhersage';

  @override
  String get forecast_loading => 'Lade Vorhersage...';

  @override
  String get forecast_error => 'Ladefehler';

  @override
  String get forecast_no_aspects => 'Keine signifikanten Aspekte';

  @override
  String get cosmicEvents_title => 'Kosmische Ereignisse';

  @override
  String get cosmicEvents_loading_error =>
      'Ereignisse konnten nicht geladen werden';

  @override
  String get cosmicEvents_no_events => 'Keine bevorstehenden Ereignisse';

  @override
  String get cosmicEvents_paywall_title => 'Persönliche kosmische Ereignisse';

  @override
  String get cosmicEvents_paywall_description =>
      'Erhalte Zugang zu einzigartigen Ratschlägen, die auf dem Einfluss der Planeten auf dein Geburtshoroskop basieren.';

  @override
  String get cosmicEvents_paywall_button => 'PRO-Status erhalten';

  @override
  String get cosmicEvents_personal_focus => 'Dein persönlicher Fokus:';

  @override
  String get cosmicEvents_pro_placeholder =>
      'Узнайте персональное влияние этого события с PRO-статусом';

  @override
  String get search_no_one_found =>
      'Niemand gefunden\nin diesem Teil der Galaxie.';

  @override
  String get chat_error_user_not_found => 'Fehler: Benutzer nicht gefunden';

  @override
  String get chat_start_with_hint => 'Mit einem Hinweis starten';

  @override
  String get chat_date_format => 'd. MMMM y';

  @override
  String get chat_group_member => 'Mitglied';

  @override
  String get chat_group_members_2_4 => 'Mitglieder';

  @override
  String get chat_group_members_5_0 => 'Mitglieder';

  @override
  String get chat_online_status_long_ago => 'war vor langer Zeit online';

  @override
  String get chat_online_status_online => 'online';

  @override
  String chat_online_status_minutes_ago(String minutes) {
    return 'war vor $minutes Min. online';
  }

  @override
  String chat_online_status_today_at(String time) {
    return 'war heute um $time Uhr online';
  }

  @override
  String chat_online_status_yesterday_at(String time) {
    return 'war gestern um $time Uhr online';
  }

  @override
  String chat_online_status_date(String date) {
    return 'war am $date online';
  }

  @override
  String get chat_delete_dialog_title => 'Chat löschen?';

  @override
  String get chat_delete_dialog_content =>
      'Dieser Chat wird für dich und deinen Gesprächspartner gelöscht. Diese Aktion kann nicht rückgängig gemacht werden.';

  @override
  String get chat_delete_dialog_confirm => 'Löschen';

  @override
  String chat_report_dialog_title(String name) {
    return '$name melden';
  }

  @override
  String get chat_report_details_hint => 'Zusätzliche Details (optional)';

  @override
  String get chat_report_sent_snackbar =>
      'Vielen Dank! Deine Meldung wurde gesendet.';

  @override
  String get chat_menu_report => 'Melden';

  @override
  String get chat_menu_delete => 'Chat löschen';

  @override
  String get chat_group_title_default => 'Gruppenchat';

  @override
  String get chat_group_participants => 'Teilnehmer';

  @override
  String get chat_message_old => 'Nachricht aus einer früheren Version';

  @override
  String get chat_input_hint => 'Nachricht...';

  @override
  String get chat_temp_warning_remaining => 'Dieser temporäre Chat wird in ';

  @override
  String get chat_temp_warning_expired => 'Chat abgelaufen';

  @override
  String get chat_temp_warning_less_than_24h => 'weniger als 24 Stunden';

  @override
  String get encrypted_chat_banner_title => 'Unterhaltung ist geschützt';

  @override
  String get encrypted_chat_banner_desc =>
      'Nachrichten in diesem Chat sind durch Ende-zu-Ende-Verschlüsselung geschützt. Niemand, nicht einmal die Aryonika-Administration, kann sie lesen.';

  @override
  String get search_hint => 'Suche nach Name, Bio...';

  @override
  String get search_tooltip_swipes => 'Swipes';

  @override
  String get search_tooltip_cosmic_web => 'Kosmisches Netz';

  @override
  String get search_tooltip_star_map => 'Sternenkarte';

  @override
  String get search_tooltip_filters => 'Filter';

  @override
  String get search_star_map_placeholder =>
      'Die Sternenkarte ist in Entwicklung...';

  @override
  String get search_priority_header => 'Top-Treffer';

  @override
  String get search_other_header => 'Andere Benutzer';

  @override
  String get payment_title => 'Projekt unterstützen';

  @override
  String get payment_success_snackbar =>
      'Danke für deine Unterstützung! Dein Status wird aktualisiert...';

  @override
  String get payment_fail_snackbar =>
      'Spende konnte nicht verarbeitet werden. Bitte versuche es erneut.';

  @override
  String get paywall_header_title => 'Entdecke das Aryonika-Universum';

  @override
  String get paywall_header_subtitle =>
      'Unterstütze das Projekt und erhalte als Dankeschön alle kosmischen Werkzeuge, um deinen perfekten Partner zu finden.';

  @override
  String get paywall_benefit1_title => 'Sieh, wer dich mag';

  @override
  String get paywall_benefit1_subtitle =>
      'Verpasse keine Chance auf Gegenseitigkeit und beginne das Gespräch zuerst.';

  @override
  String get paywall_benefit2_title => 'Persönliche Tagesprognose';

  @override
  String get paywall_benefit2_subtitle =>
      'Tägliche Analyse deiner Transite und der Fokus des Tages.';

  @override
  String get paywall_benefit3_title => 'Partner des Tages & Roulette';

  @override
  String get paywall_benefit3_subtitle =>
      'Lass die Sterne den kompatibelsten Partner für dich auswählen.';

  @override
  String get paywall_benefit4_title => 'Die Antwort des Universums';

  @override
  String get paywall_benefit4_subtitle =>
      'Stelle deine Frage und erhalte kosmischen Rat.';

  @override
  String get paywall_benefit5_title => 'Kosmisches Wetter';

  @override
  String get paywall_benefit5_subtitle =>
      'Bleib über geomagnetische Stürme und deren Einfluss informiert.';

  @override
  String get paywall_benefit6_title => 'Karte des Tages';

  @override
  String get paywall_benefit6_subtitle =>
      'Erhalte eine tägliche Vorhersage und einen Rat von der Schicksalskarte.';

  @override
  String get paywall_donate_button => 'Projekt unterstützen';

  @override
  String get paywall_referral_button => 'PRO für Freunde erhalten';

  @override
  String get paywall_referral_subtitle =>
      'Lade einen Freund ein und erhalte 1 Tag PRO-Status für jeden, der sich über deinen Link registriert.';

  @override
  String paywall_get_pro_button(String price) {
    return 'Получить Aryonika PRO ($price)';
  }

  @override
  String get paywall_arbitrary_donate_button => 'Projekt unterstützen (Boosty)';

  @override
  String get paywall_arbitrary_donate_subtitle =>
      'Если вам понравился наш проект, вы можете поддержать его, чтобы помочь нам выжить в мире акул и других хищников.';

  @override
  String get chinese_zodiac_title => 'Chinesisches Tierkreiszeichen';

  @override
  String get zodiac_Rat => 'Ratte';

  @override
  String get zodiac_Ox => 'Ochse';

  @override
  String get zodiac_Tiger => 'Tiger';

  @override
  String get zodiac_Rabbit => 'Hase';

  @override
  String get zodiac_Dragon => 'Drache';

  @override
  String get zodiac_Snake => 'Schlange';

  @override
  String get zodiac_Horse => 'Pferd';

  @override
  String get zodiac_Goat => 'Ziege';

  @override
  String get zodiac_Monkey => 'Affe';

  @override
  String get zodiac_Rooster => 'Hahn';

  @override
  String get zodiac_Dog => 'Hund';

  @override
  String get zodiac_Pig => 'Schwein';

  @override
  String get chinese_zodiac_compatibility_button =>
      'Sternzeichen-Kompatibilität';

  @override
  String get compatibility_section_title => 'Kompatibilität';

  @override
  String get userProfile_astro_button => 'Astrologie';

  @override
  String get userProfile_bazi_button => 'Bazi';

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
  String get postActionLike => 'Gefällt mir';

  @override
  String get postActionComment => 'Kommentieren';

  @override
  String get postActionShare => 'Teilen';

  @override
  String get channelDefaultName => 'Kanal';

  @override
  String postShareText(Object channelName, Object postText) {
    return 'Schau dir diesen Beitrag im Kanal „$channelName“ an: $postText';
  }

  @override
  String get postDeleteDialogTitle => 'Beitrag löschen?';

  @override
  String get postDeleteDialogContent =>
      'Diese Aktion kann nicht rückgängig gemacht werden.';

  @override
  String get delete => 'Löschen';

  @override
  String get postMenuDelete => 'Beitrag löschen';

  @override
  String get numerologySectionKeyNumbers => 'Schlüsselzahlen';

  @override
  String get numerologySectionCurrentVibes => 'Aktuelle Schwingungen';

  @override
  String get numerologyTitleLifePath => 'Lebenswegzahl';

  @override
  String get numerologyTitleDestiny => 'Schicksalszahl (Ausdruckszahl)';

  @override
  String get numerologyTitleSoulUrge => 'Seelenwunschzahl';

  @override
  String get numerologyTitlePersonality => 'Persönlichkeitszahl';

  @override
  String get numerologyTitleMaturity => 'Reifezahl';

  @override
  String get numerologyTitleBirthday => 'Geburtstagszahl';

  @override
  String get numerologyTitlePersonalYear => 'Persönliches Jahr';

  @override
  String get numerologyTitlePersonalMonth => 'Persönlicher Monat';

  @override
  String get numerologyTitlePersonalDay => 'Persönlicher Tag';

  @override
  String get numerologyErrorNotEnoughData =>
      'Nicht genügend Daten für die Berechnung.';

  @override
  String get numerologyErrorDescriptionsNotLoaded =>
      'Laden der numerologischen Beschreibungen fehlgeschlagen.';

  @override
  String get chat_error_recipient_not_found => 'Собеседник не найден.';

  @override
  String get chat_error_recipient_profile_load_failed =>
      'Не удалось загрузить профиль собеседника.';

  @override
  String get calculatingNumerology =>
      'Рассчитываем нумерологический портрет...';

  @override
  String get oracle_title => 'Orakel';

  @override
  String get verifyEmailBody =>
      'Мы отправили 6-значный код на ваш email. Пожалуйста, введите его ниже.';

  @override
  String get verifyEmailHint => '------';

  @override
  String get signOutButton => 'Выйти';

  @override
  String get errorInvalidOrExpiredCode => 'Ungültiger oder abgelaufener Code.';

  @override
  String get errorCodeRequired => 'Пожалуйста, введите код подтверждения.';

  @override
  String get errorInternalServer =>
      'Произошла внутренняя ошибка сервера. Попробуйте позже.';

  @override
  String get errorCodeLength => 'Der Code muss 6-stellig sein.';

  @override
  String get verifyEmailTitle => 'E-Mail-Bestätigung';

  @override
  String get verificationCodeLabel => 'Bestätigungscode';

  @override
  String get verificationCodeResent =>
      'Ein neuer Bestätigungscode wurde gesendet!';

  @override
  String get resendCodeAction => 'Code erneut senden';

  @override
  String resendCodeCooldown(int seconds) {
    return 'Erneut senden in ($seconds)s';
  }

  @override
  String verifyEmailInstruction(String email) {
    return 'Wir haben einen 6-stelligen Code an Ihre E-Mail gesendet. Bitte geben Sie ihn unten ein.';
  }

  @override
  String get confirmButton => 'Bestätigen';

  @override
  String get logout => 'Abmelden';

  @override
  String get numerology_score_high => 'Hoch';

  @override
  String get numerology_score_medium => 'Mittel';

  @override
  String get numerology_score_low => 'Niedrig';

  @override
  String get noUsersFound =>
      'По вашему запросу никого не найдено. Попробуйте изменить фильтры.';

  @override
  String get feature_in_development => 'Bald verfügbar!';

  @override
  String get download_our_app => 'Lade unsere App herunter';

  @override
  String get open_web_version => 'WEB-Version öffnen';

  @override
  String get pay_with_card => 'Mit Karte zahlen';

  @override
  String get coming_soon => 'Bald';

  @override
  String get paywall_subscription_terms =>
      'Das Abonnement verlängert sich automatisch. Jederzeit kündbar.';

  @override
  String get searchHint => 'Поиск...';

  @override
  String get nav_friends => 'Друзья';

  @override
  String get oracle_typing => 'schreibt...';

  @override
  String get tarot_reversed => '(Umgekehrt)';

  @override
  String get common_close => 'Schließen';

  @override
  String oracle_limit_pro(Object hours) {
    return '$hours Stunden verbleibend.';
  }

  @override
  String oracle_limit_free(Object days) {
    return 'Kostenloses Limit erreicht. $days Tage verbleibend.';
  }

  @override
  String get oracle_error_stream => 'Verbindungsfehler';

  @override
  String get oracle_error_start => 'Start fehlgeschlagen';

  @override
  String get error_generic =>
      'Ein Fehler ist aufgetreten. Bitte versuchen Sie es später erneut.';

  @override
  String get referral_already_used =>
      'Sie haben bereits einen Empfehlungscode verwendet.';

  @override
  String get referral_own_code =>
      'Sie können Ihren eigenen Code nicht verwenden.';

  @override
  String get referral_success =>
      'Code erfolgreich aktiviert! Sie haben 3 Tage Premium erhalten.';

  @override
  String get tab_astrology => 'Astrologie';

  @override
  String get tab_numerology => 'Numerologie';

  @override
  String get tab_bazi => 'BaZi';

  @override
  String get tab_jyotish => 'Vedisch';

  @override
  String get share_result => 'Ergebnis teilen';

  @override
  String get share_preparing => 'Vorbereitung...';

  @override
  String locked_feature_title(Object title) {
    return 'Bereich $title gesperrt';
  }

  @override
  String get locked_feature_desc =>
      'Dieser Bereich ist nur in der Premium-Version verfügbar.';

  @override
  String get get_access_button => 'Zugang erhalten';

  @override
  String get coming_soon_suffix => 'kommt bald';

  @override
  String get tab_summary => 'Сводка';

  @override
  String get tab_chinese_zodiac => 'Кит. Зодиак';

  @override
  String get summary_verdict_title => 'Общий вердикт';

  @override
  String get webVersionButton => 'Web-Version';

  @override
  String get uploadPhotoDisclaimer =>
      'Mit dem Hochladen eines Fotos bestätigen Sie, dass es keine Nacktheit oder Gewalt enthält. Zuwiderhandlungen führen zu einer dauerhaften Sperrung.';

  @override
  String get iAgree => 'Ich stimme zu';

  @override
  String get testers_banner_title => 'TESTER GESUCHT (4/20)';

  @override
  String get testers_banner_desc =>
      'Helfen Sie uns, Aryonika zu verbessern und erhalten Sie\n✨ LEBENSLANGES PREMIUM ✨';

  @override
  String get testers_email_hint => '(Tippen zum Öffnen, Halten zum Kopieren)';

  @override
  String get numerology_day_1 =>
      'Tag des Neuanfangs. Perfekt, um Projekte zu starten.';

  @override
  String get numerology_day_2 =>
      'Tag der Partnerschaft. Suchen Sie Kompromisse.';

  @override
  String get numerology_day_3 => 'Tag der Kreativität. Drücken Sie sich aus.';

  @override
  String get numerology_day_4 =>
      'Tag der Arbeit. Bringen Sie Ordnung in Ihre Angelegenheiten.';

  @override
  String get numerology_day_5 =>
      'Tag der Veränderung. Seien Sie offen für Neues.';

  @override
  String get numerology_day_6 =>
      'Tag der Harmonie. Zeit für Familie und Zuhause.';

  @override
  String get numerology_day_7 =>
      'Tag der Reflexion. Zeit für Einsamkeit und Analyse.';

  @override
  String get numerology_day_8 =>
      'Tag der Macht. Fokus auf Karriere und Finanzen.';

  @override
  String get numerology_day_9 =>
      'Tag des Abschlusses. Lassen Sie das Alte los.';

  @override
  String get astro_transit_positive_general =>
      'Звезды на вашей стороне. Действуйте смело.';

  @override
  String get advice_general_balance =>
      'Сохраняйте баланс между чувствами и разумом.';

  @override
  String get astro_advice_listen_intuition =>
      'Hören Sie auf Ihre innere Stimme.';

  @override
  String get astro_advice_act_boldly =>
      'Die Energie begünstigt mutiges Handeln.';

  @override
  String get astro_advice_rest_and_reflect => 'Die Sterne raten zur Ruhe.';

  @override
  String get astro_advice_connect_with_nature =>
      'Verbringen Sie Zeit in der Natur.';

  @override
  String get advice_generic_positive =>
      'Das Universum ist heute auf Ihrer Seite.';

  @override
  String get channelLoadError => 'Kanal konnte nicht geladen werden';

  @override
  String get postsTitle => 'Beiträge';

  @override
  String get noPostsYet => 'Noch keine Beiträge in diesem Kanal.';

  @override
  String get createPostTooltip => 'Beitrag erstellen';

  @override
  String get proposePost => 'Nachricht vorschlagen';

  @override
  String get channelsTitle => 'Kanäle';

  @override
  String get noChannelSubscriptions => 'Noch keine Abonnements';

  @override
  String get noMessagesYet => 'Noch keine Nachrichten';

  @override
  String get yesterday => 'Gestern';

  @override
  String get search => 'Suchen';

  @override
  String get adminOnlyFeature =>
      'Das Erstellen von Kanälen ist vorübergehend nur Administratoren vorbehalten.';

  @override
  String get createChannel => 'Kanal erstellen';

  @override
  String get galacticBroadcasts => 'Galaktische Übertragungen';

  @override
  String get noChannelsYet =>
      'Du hast noch nichts abonniert.\nFinde oder erstelle deinen eigenen Kanal!';

  @override
  String get constellationsTitle => 'Konstellationen';

  @override
  String get privateChatsTab => 'Privat';

  @override
  String get channelsTab => 'Kanäle';

  @override
  String get loadingUser => 'Benutzer wird geladen...';

  @override
  String get emptyChatsPlaceholder =>
      'Hier erscheinen deine privaten Chats.\nFinde jemanden Interessantes über die Suche!';

  @override
  String get errorTitle => 'Fehler';

  @override
  String get autoDeleteMessages => 'Nachrichten autom. löschen';

  @override
  String get availableInPro => 'Verfügbar in PRO';

  @override
  String get timerOff => 'Aus';

  @override
  String get timer15min => '15 Minuten';

  @override
  String get timer1hour => '1 Stunde';

  @override
  String get timer4hours => '4 Stunden';

  @override
  String get timer24hours => '24 Stunden';

  @override
  String get timerSet => 'Timer eingestellt';

  @override
  String get disappearingMessages => 'Selbstlöschende Nachrichten';

  @override
  String get communicationTitle => 'Kommunikation';

  @override
  String get errorLoadingReport => 'Fehler beim Laden des Berichts';

  @override
  String get compatibility => 'Kompatibilität';

  @override
  String get strengths => 'Stärken';

  @override
  String get weaknesses => 'Mögliche Schwierigkeiten';

  @override
  String get commentsTitle => 'Kommentare';

  @override
  String get commentsLoadError => 'Fehler beim Laden der Kommentare.';

  @override
  String get noCommentsYet => 'Noch keine Kommentare.';

  @override
  String userIsTyping(Object name) {
    return '$name schreibt...';
  }

  @override
  String twoUsersTyping(Object name1, Object name2) {
    return '$name1 und $name2 schreiben...';
  }

  @override
  String manyUsersTyping(Object count, Object name1, Object name2) {
    return '$name1, $name2 und $count andere schreiben...';
  }

  @override
  String replyingTo(Object name) {
    return 'Antwort an $name';
  }

  @override
  String get writeCommentHint => 'Kommentar schreiben...';

  @override
  String get compatibilityTitle => 'Kosmische Verbindung';

  @override
  String get noData => 'Keine Daten';

  @override
  String get westernAstrology => 'Westliche Astrologie';

  @override
  String get vedicAstrology => 'Vedische Astrologie (Jyotish)';

  @override
  String get numerology => 'Numerologie';

  @override
  String get chineseZodiac => 'Chinesisches Tierkreiszeichen';

  @override
  String get baziElements => 'Ba Zi (Elemente)';

  @override
  String get availableInPremium => 'Verfügbar in Premium';

  @override
  String get verdictSoulmates => 'Seelenverwandte';

  @override
  String get verdictGreatMatch => 'Tolles Paar';

  @override
  String get verdictPotential => 'Hat Potenzial';

  @override
  String get verdictKarmic => 'Karmische Lektion';

  @override
  String get createChannelTitle => 'Sendung erstellen';

  @override
  String get channelNameLabel => 'Name der Sendung';

  @override
  String get channelNameHint => 'Z.B. \'Tägliche Tarot-Prognosen\'';

  @override
  String get errorChannelNameEmpty => 'Name darf nicht leer sein';

  @override
  String get channelHandleLabel => 'Eindeutige ID (@handle)';

  @override
  String get errorChannelHandleShort => 'ID muss länger als 4 Zeichen sein';

  @override
  String get channelDescriptionLabel => 'Beschreibung';

  @override
  String get channelDescriptionHint =>
      'Erzähle uns, worum es in deinem Kanal geht...';

  @override
  String get errorChannelDescriptionEmpty =>
      'Bitte füge eine Beschreibung hinzu';

  @override
  String get createButton => 'Erstellen';

  @override
  String get editProfileTitle => 'Profil bearbeiten';

  @override
  String get profileNotFoundError => 'Fehler: Profil nicht gefunden';

  @override
  String get profileSavedSuccess => 'Profil erfolgreich gespeichert!';

  @override
  String get saveError => 'Fehler beim Speichern';

  @override
  String get avatarUploadError => 'Fehler beim Hochladen des Fotos';

  @override
  String get nameLabel => 'Name';

  @override
  String get bioLabel => 'Über mich';

  @override
  String get birthDataTitle => 'Geburtsdaten';

  @override
  String get birthDataWarning =>
      'Die Änderung dieser Daten führt zu einer vollständigen Neuberechnung Ihres astrologischen und numerologischen Porträts.';

  @override
  String get birthDateLabel => 'Geburtsdatum';

  @override
  String get birthPlaceLabel => 'Geburtsort';

  @override
  String get errorUserNotFound => 'Fehler: Benutzer nicht gefunden';

  @override
  String get feedUpdateError => 'Fehler beim Aktualisieren des Feeds';

  @override
  String get feedEmptyMessage =>
      'Dein Feed ist leer.\nZiehe nach unten, um zu aktualisieren.';

  @override
  String get whereToSearch => 'Wo suchen';

  @override
  String get searchNearby => 'In der Nähe';

  @override
  String get searchCity => 'Stadt';

  @override
  String get searchCountry => 'Land';

  @override
  String get searchWorld => 'Weltweit';

  @override
  String get ageLabel => 'Alter';

  @override
  String get showGenderLabel => 'Zeigen';

  @override
  String get genderAll => 'Alle';

  @override
  String get zodiacFilterLabel => 'Sternzeichen-Elemente';

  @override
  String get resetFilters => 'Zurücksetzen';

  @override
  String get applyFilters => 'Anwenden';

  @override
  String get forecastLoadError =>
      'Vorhersage konnte nicht geladen werden.\nBitte versuche es später erneut.';

  @override
  String get noForecastEvents =>
      'Keine bedeutenden astrologischen Ereignisse heute.\nEin ruhiger Tag!';

  @override
  String get unlockFullForecast => 'Vollständige Vorhersage freischalten';

  @override
  String get myFriendsTab => 'Meine Freunde';

  @override
  String get friendRequestsTab => 'Anfragen';

  @override
  String get noFriendsYet =>
      'Du hast noch keine Freunde. Finde sie über die Suche!';

  @override
  String get noFriendRequests => 'Keine neuen Anfragen.';

  @override
  String get removeFriend => 'Als Freund entfernen';

  @override
  String get gamesComingSoonTitle => 'Spiele & Belohnungen kommen bald!';

  @override
  String get gamesComingSoonDesc =>
      'Wir bereiten spannende Minispiele und Quiz vor. Prüfe deine Kompatibilität, verdiene \"Sternenstaub\" und tausche ihn gegen Premium-Tage oder Geschenke!';

  @override
  String get joinTelegramButton => 'Erfahre es zuerst auf unserem Telegram';

  @override
  String horoscopeForSign(Object sign) {
    return 'Horoskop für $sign';
  }

  @override
  String get horoscopeGeneral => 'Allgemein';

  @override
  String get horoscopeLove => 'Liebe';

  @override
  String get horoscopeBusiness => 'Beruf';

  @override
  String get verdictNotFound => 'Urteil nicht gefunden';

  @override
  String get vedicCompatibilityTitle => 'Vedische Kompatibilität';

  @override
  String get ashtaKutaAnalysis => 'Detaillierte Analyse (Ashta-Kuta)';

  @override
  String get noDescription => 'Beschreibung nicht gefunden.';

  @override
  String get likesYouEmpty =>
      'Personen, die an dir interessiert sind, erscheinen hier';

  @override
  String peopleLikeYou(Object count) {
    return '$count Personen mögen dich!';
  }

  @override
  String get getProToSeeLikes =>
      'Hole dir PRO, um ihre Profile zu sehen und zu chatten.';

  @override
  String get seeLikesButton => 'Likes ansehen';

  @override
  String get someone => 'Jemand';

  @override
  String get selectCityTitle => 'Stadt auswählen';

  @override
  String get searchCityHint => 'Stadtnamen eingeben...';

  @override
  String get nothingFound => 'Nichts gefunden';

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
  String get moderationProposedPosts => 'Vorgeschlagene Beiträge';

  @override
  String get noProposedPosts => 'Keine vorgeschlagenen Beiträge.';

  @override
  String get from => 'Von';

  @override
  String get personalNumerologyTitle => 'Persönliche Numerologie';

  @override
  String get dataNotLoaded => 'Daten nicht geladen';

  @override
  String get loading => 'Laden...';

  @override
  String get lifePathNumber => 'Lebenswegzahl';

  @override
  String get corePersonality => 'Kernpersönlichkeit';

  @override
  String get destinyNumber => 'Schicksalszahl';

  @override
  String get soulNumber => 'Herzenswunschzahl';

  @override
  String get personalityNumber => 'Persönlichkeitszahl';

  @override
  String get timeInfluence => 'Einfluss der Zeit';

  @override
  String get maturityNumber => 'Reifezahl';

  @override
  String get birthdayNumber => 'Geburtstagszahl';

  @override
  String get currentVibrationsPro => 'Aktuelle Schwingungen (PRO)';

  @override
  String get personalYear => 'Persönliches Jahr';

  @override
  String get personalMonth => 'Persönlicher Monat';

  @override
  String get personalDay => 'Persönlicher Tag';

  @override
  String get proVibrationsDesc =>
      'Entdecken Sie Ihre Schwingungen für Jahr, Monat und Tag. Nur im Premium verfügbar.';

  @override
  String get unlockButton => 'Freischalten';

  @override
  String get tapForDetails => 'Tippen für Details';

  @override
  String oracle_weather_desc(Object desc, Object kp) {
    return '$desc (Kp: $kp)';
  }

  @override
  String oracle_geomagnetic_now(Object desc) {
    return 'Jetzt: $desc';
  }

  @override
  String oracle_geomagnetic_index(Object kp) {
    return 'Kp-Index: $kp';
  }

  @override
  String get oracle_question_title => 'Frag das Orakel';

  @override
  String get oracle_question_hint => 'Was bedrückt dich?...';

  @override
  String get oracle_question_button => 'Antwort erhalten';

  @override
  String get palmistry_analysis_title => 'Handanalyse';

  @override
  String get palmistry_choose_option => 'Wählen Sie die passendste Option:';

  @override
  String get palmistry_analysis_saved => 'Analyse gespeichert!';

  @override
  String get palmistry_view_report => 'Vollständigen Bericht anzeigen';

  @override
  String get palmistry_complete_all =>
      'Schließen Sie die Analyse aller Linien ab';

  @override
  String get palmistry_analysis_complete => 'Großartig! Analyse abgeschlossen.';

  @override
  String palmistry_tap_line(Object lineName) {
    return 'Tippen Sie auf \'$lineName\', um mit Ihrer Handfläche zu vergleichen.';
  }

  @override
  String palmistry_searching_line(Object lineName) {
    return 'Suche nach \'$lineName\'...';
  }

  @override
  String get palmistry_preparing => 'Vorbereitung der Analyse...';

  @override
  String get palmistry_report_title => 'Karte Ihres Schicksals';

  @override
  String get palmistry_data_not_found => 'Analysedaten nicht gefunden.';

  @override
  String get palmistry_strong_traits => 'Ihre Stärken';

  @override
  String get privacy => 'Privatsphäre';

  @override
  String get palmistry_show_in_profile => 'Meine Merkmale im Profil anzeigen';

  @override
  String get palmistry_show_in_profile_desc =>
      'Dies hilft anderen, Sie besser kennenzulernen und verbessert die Kompatibilität.';

  @override
  String get palmistry_interpretation => 'Linieninterpretation';

  @override
  String palmistry_your_choice(Object choice) {
    return 'Ihre Wahl: \"$choice\"';
  }

  @override
  String get photoAlbumComingSoon =>
      'Bald können Sie Ihre Fotos hier hochladen.';

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get accountManagement => 'Kontoverwaltung';

  @override
  String get changePassword => 'Passwort ändern';

  @override
  String get restorePassword => 'Passwort zurücksetzen';

  @override
  String get editProfileButton => 'Profil bearbeiten';

  @override
  String get dailyNotifications => 'Tägliche Benachrichtigungen';

  @override
  String get alertsTitle => 'Warnungen';

  @override
  String get geomagneticStorms => 'Geomagnetische Stürme';

  @override
  String get adminPanelTitle => 'Admin-Bereich';

  @override
  String get adminManageUsers => 'Benutzer verwalten';

  @override
  String get offerAgreementLink => 'Angebotsvertrag';

  @override
  String get accountSectionTitle => 'Konto';

  @override
  String get deleteAccountButton => 'Konto löschen';

  @override
  String get closeAppButton => 'App schließen';

  @override
  String get changePasswordDesc =>
      'Bitte geben Sie zur Sicherheit Ihr aktuelles Passwort ein.';

  @override
  String get currentPasswordLabel => 'Aktuelles Passwort';

  @override
  String get newPasswordLabel => 'Neues Passwort';

  @override
  String get passwordChangedSuccess => 'Passwort erfolgreich geändert!';

  @override
  String resetPasswordInstruction(String email) {
    return 'Wir senden Anweisungen zum Zurücksetzen an Ihre E-Mail:\n\n$email';
  }

  @override
  String get signOutDialogTitle => 'Abmelden';

  @override
  String get signOutDialogContent => 'Möchten Sie sich wirklich abmelden?';

  @override
  String get deleteAccountTitle => 'Konto löschen?';

  @override
  String get deleteAccountWarning =>
      'Diese Aktion ist unwiderruflich. Alle Ihre Daten, Chats, Fotos und Käufe werden dauerhaft gelöscht.';

  @override
  String get deleteForeverButton => 'Dauerhaft löschen';

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
  String get cityNotSpecified => 'Stadt nicht angegeben';

  @override
  String get geomagnetic_calm => 'Ruhig';

  @override
  String get geomagnetic_unsettled => 'Unruhig';

  @override
  String get geomagnetic_active => 'Aktiv';

  @override
  String get geomagnetic_storm_minor => 'Kleiner Sturm (G1)';

  @override
  String get geomagnetic_storm_moderate => 'Mäßiger Sturm (G2)';

  @override
  String get geomagnetic_storm_strong => 'Starker Sturm (G3)';

  @override
  String get geomagnetic_storm_severe => 'Schwerer Sturm (G4)';

  @override
  String get geomagnetic_storm_extreme => 'Extremer Sturm (G5)';

  @override
  String get deleteChatTitle => 'Chat löschen?';

  @override
  String get deleteChatConfirmation =>
      'Alle Nachrichten werden unwiderruflich gelöscht.';

  @override
  String get chatDeleted => 'Chat gelöscht';
}
