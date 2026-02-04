// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get profileCreationErrorTitle => 'Profile Creation Error';

  @override
  String get profileCreationErrorDescription =>
      'Unfortunately, there was a failure while saving your data. Please try to register again.';

  @override
  String get tryAgain => 'Try again';

  @override
  String get connectingHearts => 'Connecting hearts across the universe...';

  @override
  String get appName => 'Aryonika';

  @override
  String get exitConfirmationTitle => 'Confirmation';

  @override
  String get exitConfirmationContent =>
      'Are you sure you want to close Aryonika?';

  @override
  String get cancel => 'Cancel';

  @override
  String get close => 'Close';

  @override
  String get paymentUrlError => 'Error: Payment URL not found.';

  @override
  String get channelIdError => 'Error: Channel ID not found.';

  @override
  String documentLoadError(Object error) {
    return 'Failed to load document: $error';
  }

  @override
  String get partnerIdError =>
      'Error: Partner ID is required for compatibility calculation.';

  @override
  String get bioPlaceholder => 'Your story could be here...';

  @override
  String photoAlbumTitle(Object photoCount) {
    return 'Photo Album ($photoCount)';
  }

  @override
  String get photoAlbumSubtitle => 'Your best moments';

  @override
  String get cosmicEventsTitle => 'Cosmic Events';

  @override
  String get cosmicEventsSubtitle => 'Learn about the influence of the planets';

  @override
  String get inviteFriendTitle => 'Invite a Friend';

  @override
  String get inviteFriendSubtitle => 'Get bonuses together';

  @override
  String get gameCenterTitle => 'Game Center';

  @override
  String get gameCenterSubtitle => 'Mini-games and quests';

  @override
  String get personalForecastTitle => 'Personal Forecast';

  @override
  String get personalForecastSubtitlePro => 'Analysis of transits for today';

  @override
  String get personalForecastSubtitleFree => 'Available with PRO status';

  @override
  String get cosmicPassportTitle => 'COSMIC PASSPORT';

  @override
  String get numerologyPortraitTitle => 'NUMEROLOGY PORTRAIT';

  @override
  String get yourNumbersOfDestinyTitle => 'Your Numbers of Destiny';

  @override
  String get yourNumbersOfDestinySubtitle => 'Unlock your potential';

  @override
  String get numerologyPath => 'Path';

  @override
  String get numerologyDestiny => 'Destiny';

  @override
  String get numerologySoul => 'Soul';

  @override
  String get signOut => 'Sign Out';

  @override
  String get calculatingChart => 'Calculating chart...';

  @override
  String get astroDataSignMissing => 'Data for this sign is missing.';

  @override
  String astroDataDescriptionNotFound(Object signName) {
    return 'Description for \"$signName\" not found.';
  }

  @override
  String astroDataMapNotLoaded(Object mapKey) {
    return 'Data for \"$mapKey\" not loaded.';
  }

  @override
  String get planetSun => 'Sun';

  @override
  String get planetMoon => 'Moon';

  @override
  String get planetAscendant => 'Ascendant';

  @override
  String get planetMercury => 'Mercury';

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
  String get planetNeptune => 'Neptune';

  @override
  String get planetPluto => 'Pluto';

  @override
  String get getProTitle => 'Get PRO';

  @override
  String get getProSubtitle => 'Unlock all features';

  @override
  String get proStatusActive => 'PRO status is active';

  @override
  String get proStatusExpired => 'Status has expired';

  @override
  String proStatusDaysLeft(Object days) {
    return 'Days left: $days';
  }

  @override
  String proStatusHoursLeft(Object hours) {
    return 'Hours left: $hours';
  }

  @override
  String get proStatusExpiresToday => 'Expires today';

  @override
  String astroDialogTitle(Object planetName, Object signName) {
    return '$planetName in $signName';
  }

  @override
  String get likesYouTitle => 'Likes You';

  @override
  String likesYouTotal(Object count) {
    return 'Total likes: $count';
  }

  @override
  String get likesYouNone => 'No likes yet';

  @override
  String reportOnUser(Object userName) {
    return 'Report on $userName';
  }

  @override
  String get reportReasonSpam => 'Spam';

  @override
  String get reportReasonInsultingBehavior => 'Insulting behavior';

  @override
  String get reportReasonScam => 'Scam';

  @override
  String get reportReasonInappropriateContent => 'Inappropriate content';

  @override
  String get reportDetailsHint => 'Additional details (optional)';

  @override
  String get send => 'Send';

  @override
  String get reportSentSnackbar => 'Thank you! Your report has been submitted.';

  @override
  String get profileLoadError => 'Failed to load profile';

  @override
  String get back => 'Back';

  @override
  String get report => 'Report';

  @override
  String userProfilePhotoAlbumTitle(Object photoCount) {
    return 'Photo Album ($photoCount)';
  }

  @override
  String get userProfileViewPhotos => 'View photos';

  @override
  String get aboutMe => 'About Me';

  @override
  String get bioEmpty =>
      'This user hasn\'t shared anything about themselves yet.';

  @override
  String get cosmicPassport => 'Cosmic Passport';

  @override
  String sunInSign(Object signName) {
    return '☀️ Sun in $signName';
  }

  @override
  String get friendshipStatusFriends => 'You are friends';

  @override
  String get friendshipRemoveTitle => 'Remove from friends?';

  @override
  String friendshipRemoveContent(Object userName) {
    return 'Are you sure you want to remove $userName from your friends?';
  }

  @override
  String get remove => 'Remove';

  @override
  String get friendshipStatusRequestSent => 'Request sent';

  @override
  String get friendshipActionDecline => 'Decline';

  @override
  String get friendshipActionAccept => 'Accept';

  @override
  String get friendshipActionAdd => 'Add friend';

  @override
  String likeSnackbarSuccess(Object userName) {
    return 'You liked $userName!';
  }

  @override
  String likeSnackbarAlreadyLiked(Object userName) {
    return 'You have already liked $userName';
  }

  @override
  String get writeMessage => 'Message';

  @override
  String get checkCompatibility => 'Check Compatibility';

  @override
  String get yourCosmicInfluence => 'Your Cosmic Influence Today';

  @override
  String get cosmicEventsLoading => 'Calculating cosmic events...';

  @override
  String get cosmicEventsEmpty =>
      'The cosmos is calm today. Enjoy the harmony!';

  @override
  String get cosmicEventsError =>
      'Couldn\'t calculate cosmic events. Please try again later.';

  @override
  String get cosmicConnectionTitle => 'Cosmic Bond';

  @override
  String shareText(Object name, Object score) {
    return 'Our compatibility with $name is $score%! ✨\nCalculated in Aryonika';
  }

  @override
  String get shareErrorSnackbar => 'An error occurred while trying to share.';

  @override
  String get compatibilityErrorTitle => 'Failed to calculate compatibility';

  @override
  String get compatibilityErrorSubtitle =>
      'Partner\'s data might be incomplete or a network error occurred.';

  @override
  String get goBack => 'Go Back';

  @override
  String get sectionCosmicAdvice => 'COSMIC ADVICE';

  @override
  String get sectionDailyInfluence => 'DAILY INFLUENCE';

  @override
  String get sectionAstrologicalResonance => 'ASTROLOGICAL RESONANCE';

  @override
  String get sectionNumerologyMatrix => 'NUMEROLOGY MATRIX';

  @override
  String get sectionPalmistryConnection => 'PALMISTRY CONNECTION';

  @override
  String get sectionAboutPerson => 'ABOUT THE PERSON';

  @override
  String get palmistryNoData =>
      'One of the partners has not yet completed the palm analysis. This will unlock a new level of your compatibility!';

  @override
  String palmistryCommonTraits(Object traits) {
    return 'You are united by: $traits. This creates a solid foundation for your relationship.';
  }

  @override
  String palmistryUniqueTraits(Object myTrait, Object partnerTrait) {
    return 'You complement each other: your \'$myTrait\' trait harmonizes perfectly with their \'$partnerTrait\'.';
  }

  @override
  String get harmony => 'Harmony';

  @override
  String get adviceRareConnection =>
      'Your souls resonate in unison. This is a rare cosmic connection where both personalities (Sun) and emotions (Moon) are in harmony. Cherish this treasure.';

  @override
  String get advicePassionChallenge =>
      'A flame of passion rages between you, but your personalities may clash. Learn to turn arguments into energy for growth, and your bond will become unbreakable.';

  @override
  String get adviceBestFriends =>
      'You are best friends who understand each other at a glance and feel comfortable together. Physical attraction may grow over time; the main thing is your spiritual closeness.';

  @override
  String get adviceKarmicLesson =>
      'Your paths crossed for a reason. This connection carries important lessons for both of you. Be patient and open to understand what you must teach each other.';

  @override
  String get adviceGreatPotential =>
      'There is a strong attraction between you and great potential for growth. Learn from each other, and your bond will grow stronger. The stars are on your side.';

  @override
  String get adviceBase =>
      'Study each other. Every encounter is an opportunity to discover a new universe. Your story is just beginning.';

  @override
  String get dailyInfluenceCalm =>
      'Cosmic calm. A great day to simply enjoy each other\'s company without external influences.';

  @override
  String get dailyAdviceFavorable =>
      'Advice: Use this energy! An excellent moment for joint plans.';

  @override
  String get dailyAdviceTense =>
      'Advice: Be more patient with each other. Misunderstandings are possible.';

  @override
  String get proFeatureLocked =>
      'A detailed analysis of this aspect is available in the PRO version.';

  @override
  String get getProButton => 'Get PRO';

  @override
  String get numerologyLifePath => 'Life Path';

  @override
  String get numerologyDestinyNumber => 'Destiny Number';

  @override
  String get numerologySoulNumber => 'Soul Number';

  @override
  String get shareCardTitle => 'Aryonika';

  @override
  String get shareCardSubtitle => 'COSMIC COMPATIBILITY REPORT';

  @override
  String get shareCardHarmony => 'Overall Harmony';

  @override
  String get shareCardPersonalityHarmony => 'Personality Harmony (Sun)';

  @override
  String get shareCardLifePath => 'Life Path (Numerology)';

  @override
  String get shareCardCtaTitle => 'Discover your cosmic\ncompatibility!';

  @override
  String get shareCardCtaSubtitle => 'Download Aryonika on RuStore';

  @override
  String get loginTitle => 'Sign In';

  @override
  String get loginError => 'Login Error';

  @override
  String get passwordResetTitle => 'Password Reset';

  @override
  String get passwordResetContent =>
      'Enter your E-mail, and we will send you instructions to reset your password.';

  @override
  String get emailLabel => 'Email';

  @override
  String get sendButton => 'Send';

  @override
  String get emailValidationError => 'Please enter a valid E-mail.';

  @override
  String get passwordResetSuccess => 'Email sent! Check your inbox.';

  @override
  String get passwordLabel => 'Password';

  @override
  String get loginButton => 'Sign In';

  @override
  String get forgotPasswordButton => 'Forgot password?';

  @override
  String get noAccountButton => 'No account? Sign Up';

  @override
  String get registerTitle => 'Create Account';

  @override
  String get unknownError => 'An unknown error occurred';

  @override
  String get confirmPasswordLabel => 'Confirm Password';

  @override
  String get privacyPolicyCheckbox => 'I accept the ';

  @override
  String get termsOfUseLink => 'Terms of Use';

  @override
  String get and => ' and ';

  @override
  String get privacyPolicyLink => 'Privacy Policy';

  @override
  String get registerButton => 'Register';

  @override
  String get alreadyHaveAccountButton => 'Already have an account? Log In';

  @override
  String get welcomeTagline => 'Your destiny is written in the stars';

  @override
  String get welcomeCreateAccountButton => 'Create a Cosmic Passport';

  @override
  String get welcomeLoginButton => 'I already have an account';

  @override
  String get introSlide1Title => 'Aryonika — More Than Dating';

  @override
  String get introSlide1Description =>
      'Discover new levels of compatibility through astrology, numerology, and Destiny Cards.';

  @override
  String get introSlide2Title => 'Your Cosmic Passport';

  @override
  String get introSlide2Description =>
      'Learn all about your potential and find the one who completes your universe.';

  @override
  String get introSlide3Title => 'Join the Galaxy';

  @override
  String get introSlide3Description =>
      'Start your cosmic journey to true love right now.';

  @override
  String get introButtonSkip => 'Skip';

  @override
  String get introButtonNext => 'Next';

  @override
  String get introButtonStart => 'Start';

  @override
  String get onboardingNameTitle => 'What\'s your name?';

  @override
  String get onboardingNameSignOutTooltip => 'Sign Out (for testing)';

  @override
  String get onboardingNameSubtitle =>
      'This name will be visible to other users.';

  @override
  String get onboardingNameLabel => 'Your Name';

  @override
  String get onboardingBioLabel => 'Tell us about yourself';

  @override
  String get onboardingBioHint => 'Example: I love astrology and #travel...';

  @override
  String get onboardingButtonNext => 'Next';

  @override
  String get onboardingBirthdateTitle => 'When were you born?';

  @override
  String get onboardingBirthdateSubtitle =>
      'This is necessary for an accurate calculation of your natal chart and numerology.';

  @override
  String get datePickerHelpText => 'SELECT BIRTH DATE';

  @override
  String get birthdateLabel => 'Date of Birth';

  @override
  String get birthdatePlaceholder => 'Tap to select';

  @override
  String get dateFormat => 'MMMM d, yyyy';

  @override
  String get onboardingFinishText1 => 'Analyzing the position of the stars...';

  @override
  String get onboardingFinishText2 => 'Calculating your numerological code...';

  @override
  String get onboardingFinishText3 => 'Checking with the Destiny Cards...';

  @override
  String get onboardingFinishText4 => 'Creating your cosmic passport...';

  @override
  String get onboardingFinishErrorTitle => 'Error';

  @override
  String get onboardingFinishErrorContent => 'An unknown error occurred.';

  @override
  String get onboardingFinishErrorButton => 'Go Back';

  @override
  String get onboardingGenderTitle => 'Your Gender';

  @override
  String get onboardingGenderSubtitle =>
      'This will help us find the most suitable people for you.';

  @override
  String get genderMale => 'Men';

  @override
  String get genderFemale => 'Women';

  @override
  String get onboardingLocationTitle => 'Place of Birth';

  @override
  String get onboardingLocationSubtitle =>
      'Please specify the city where you were born. This is necessary for an accurate astrological calculation.';

  @override
  String get onboardingLocationSearchHint => 'Start typing a city...';

  @override
  String get onboardingLocationNotFound =>
      'No cities found. Try a different query.';

  @override
  String get onboardingLocationStartSearch => 'Start searching to see results';

  @override
  String get onboardingLocationSelectFromList =>
      'Select a city from the list above to continue';

  @override
  String get onboardingTimeTitle => 'Time of Birth';

  @override
  String get onboardingTimeSubtitle =>
      'If you don\'t know the exact time, set it to 12:00 PM.\nThis will still provide a good result.';

  @override
  String get timePickerHelpText => 'SELECT TIME OF BIRTH';

  @override
  String get birthTimeLabel => 'Time of Birth';

  @override
  String get onboardingButtonNextLocation => 'Next (select location)';

  @override
  String get alphaBannerTitle => 'Alpha Version';

  @override
  String get alphaBannerContent =>
      'This section is under active development. Some features may be unstable. We are actively working on localization, so some texts may still be in Russian. Thank you for your understanding!';

  @override
  String get alphaBannerFeedback =>
      'We appreciate your feedback and suggestions in our Telegram channel!';

  @override
  String get astro_title_sun => 'Personality Compatibility (Sun)';

  @override
  String get astro_title_moon => 'Emotional Compatibility (Moon)';

  @override
  String get astro_title_chemistry => 'Astrological Chemistry (Venus-Mars)';

  @override
  String get astro_title_mercury => 'Communication Style (Mercury)';

  @override
  String get astro_title_saturn => 'Long-term outlook (Saturn)';

  @override
  String get numerology_title => 'Numerological Resonance';

  @override
  String get cosmicPulseTitle => 'Cosmic Pulse';

  @override
  String get feedIceBreakerTitle => 'Icebreaker';

  @override
  String get feedOrbitCrossingTitle => 'Orbit Crossing';

  @override
  String get feedSpiritualNeighborTitle => 'Spiritual Neighbor';

  @override
  String get feedGeomagneticStormTitle => 'Geomagnetic Storm';

  @override
  String get feedCompatibilityPeakTitle => 'Compatibility Peak';

  @override
  String get feedNewChannelSuggestionTitle => 'New Channel';

  @override
  String get feedPopularPostTitle => 'Popular Post';

  @override
  String get feedNewCommentTitle => 'New Comment';

  @override
  String get cardOfTheDayTitle => 'Card of the Day';

  @override
  String get cardOfTheDayDrawing => 'Drawing your card...';

  @override
  String get cardOfTheDayGetButton => 'Draw Card';

  @override
  String get cardOfTheDayYourCard => 'Your Card of the Day';

  @override
  String get cardOfTheDayTapToReveal => 'Tap card to reveal';

  @override
  String get cardOfTheDayReversedSuffix => ' (Reversed)';

  @override
  String get cardOfTheDayDefaultInterpretation =>
      'Find out what the coming day prepares for you.';

  @override
  String get channelSearchTitle => 'Search Channels';

  @override
  String get channelAnonymousAuthor => 'Anonymous';

  @override
  String get errorUserNotAuthorized => 'User not authorized';

  @override
  String get errorUnknownServer => 'Unknown server error';

  @override
  String get errorFailedToLoadData => 'Failed to load data';

  @override
  String get generalHello => 'Hello';

  @override
  String get referralErrorProfileNotLoaded =>
      'Error: your profile is not loaded. Please try again later.';

  @override
  String get referralErrorAlreadyUsed =>
      'You have already used a referral code.';

  @override
  String get referralErrorOwnCode => 'You cannot use your own code.';

  @override
  String get referralScreenTitle => 'Invite a Friend';

  @override
  String get referralYourCodeTitle => 'Your Invitation Code';

  @override
  String get referralYourCodeDescription =>
      'Share this code with friends. For every friend who enters your code, you\'ll receive 1 day of PRO access!';

  @override
  String get referralCodeCopied => 'Code copied to clipboard!';

  @override
  String get referralShareCodeButton => 'Share Code';

  @override
  String referralShareMessage(String code) {
    return 'Hey! Join me on Aryonika to find your cosmic match. Enter my invitation code in the app so we both get bonuses: $code';
  }

  @override
  String get referralManualBonusNote =>
      'PRO access is granted manually within 24 hours after your friend enters the code.';

  @override
  String get referralGotCodeTitle => 'Have a code?';

  @override
  String get referralGotCodeDescription =>
      'Enter the code your friend gave you so they can get their reward.';

  @override
  String get referralCodeInputLabel => 'Invitation Code';

  @override
  String get referralCodeValidationError => 'Please enter a code';

  @override
  String get referralApplyCodeButton => 'Apply Code';

  @override
  String get nav_feed => 'Feed';

  @override
  String get nav_search => 'Search';

  @override
  String get nav_oracle => 'Oracle';

  @override
  String get nav_chats => 'Chats';

  @override
  String get nav_channels => 'Channels';

  @override
  String get nav_profile => 'Profile';

  @override
  String get nav_exit => 'Exit';

  @override
  String get exitDialog_title => 'Confirmation';

  @override
  String get exitDialog_content => 'Are you sure you want to close Aryonika?';

  @override
  String get exitDialog_cancel => 'Cancel';

  @override
  String get exitDialog_confirm => 'Close';

  @override
  String get oracle_limit_title => 'Request Limit';

  @override
  String get oracle_limit_later => 'Later';

  @override
  String get oracle_limit_get_pro => 'Get Unlimited';

  @override
  String get oracle_orb_partner => 'Partner of Day';

  @override
  String get oracle_orb_roulette => 'Roulette';

  @override
  String get oracle_orb_duet => 'Duet';

  @override
  String get oracle_orb_horoscope => 'Horoscope';

  @override
  String get oracle_orb_weather => 'Geomagnetic';

  @override
  String get oracle_orb_ask => 'Question';

  @override
  String get oracle_orb_focus => 'Focus of Day';

  @override
  String get oracle_orb_forecast => 'AstroForecast';

  @override
  String get oracle_orb_card => 'Card of Day';

  @override
  String get oracle_orb_tarot => 'Universe\'s Answer';

  @override
  String get oracle_orb_palmistry => 'Palmistry';

  @override
  String get oracle_duet_title => 'Cosmic Duet';

  @override
  String get oracle_duet_description =>
      'Check compatibility with anyone by birth date.';

  @override
  String get oracle_duet_button => 'Check Compatibility';

  @override
  String oracle_unsupported_web_feature(String featureName, Object feature) {
    return 'Feature \'$feature\' is not yet available on WEB. Download the app.';
  }

  @override
  String get oracle_pro_card_of_day_title => 'Card of Day (PRO)';

  @override
  String get oracle_pro_card_of_day_desc =>
      'Discover your day\'s energy through Tarot arcana. Available in PRO only.';

  @override
  String get oracle_pro_focus_of_day_title => 'Focus of Day (PRO)';

  @override
  String get oracle_pro_focus_of_day_desc =>
      'Find out what to focus on today. Available in PRO only.';

  @override
  String get oracle_pro_forecast_of_day_title => 'Personal Forecast (PRO)';

  @override
  String get oracle_pro_forecast_of_day_desc =>
      'Detailed analysis of planetary transits for you. Available in PRO only.';

  @override
  String get oracle_roulette_title => 'Cosmic Roulette';

  @override
  String get oracle_roulette_description =>
      'Try your luck! Find a random partner with high compatibility.';

  @override
  String get oracle_roulette_button => 'Spin Roulette';

  @override
  String get oracle_card_of_day_reversed => '(reversed)';

  @override
  String get oracle_card_of_day_get_key => 'Get Personal Key';

  @override
  String get oracle_palmistry_title => 'Palmistry';

  @override
  String get oracle_palmistry_description =>
      'AI palm line analysis. Discover your destiny by hand.';

  @override
  String get oracle_palmistry_button => 'Scan Hand';

  @override
  String get oracle_ask_loading => 'Oracle is thinking...';

  @override
  String get oracle_ask_again => 'Ask Again';

  @override
  String get oracle_focus_loading => 'Focusing...';

  @override
  String get oracle_focus_error => 'Failed to load focus';

  @override
  String get oracle_focus_no_data => 'No Data';

  @override
  String get oracle_forecast_loading => 'Composing your personal forecast...';

  @override
  String get oracle_forecast_error => 'Failed to create forecast';

  @override
  String get oracle_forecast_try_again => 'Try Again';

  @override
  String get oracle_forecast_title => 'Daily Forecast';

  @override
  String get oracle_forecast_day_number => 'Your day number: ';

  @override
  String get oracle_tarot_title => 'Tarot Reading (AI)';

  @override
  String get oracle_tarot_hint => 'Your question to the cards...';

  @override
  String get oracle_tarot_button => 'Do Reading';

  @override
  String oracle_tarot_your_question(String question) {
    return 'Your question: $question';
  }

  @override
  String get oracle_tarot_loading => 'AI is analyzing...';

  @override
  String get oracle_tarot_ask_again => 'Ask Again';

  @override
  String get oracle_tarot_card_reversed_short => ' (rev.)';

  @override
  String get oracle_tarot_combo_message => 'Overall message of the cards:';

  @override
  String get oracle_geomagnetic_title => 'Space Weather';

  @override
  String get oracle_geomagnetic_forecast => 'Forecast for coming hours';

  @override
  String get oracle_weather_title => 'Geomagnetic Activity';

  @override
  String get oracle_pro_feature_title => 'Partner of the Day (PRO)';

  @override
  String get oracle_pro_feature_desc =>
      'We find the perfect partner based on your natal chart. Available in PRO.';

  @override
  String get oracle_partner_loading => 'Searching for partner...';

  @override
  String get oracle_partner_error => 'Search Error';

  @override
  String get oracle_partner_not_found => 'No suitable partners found';

  @override
  String get oracle_partner_profile_error => 'Profile Error';

  @override
  String get oracle_partner_title => 'Your Partner of the Day';

  @override
  String oracle_partner_compatibility(String score) {
    return 'Compatibility: $score%';
  }

  @override
  String get oracle_ask_title => 'Ask the Oracle';

  @override
  String get oracle_ask_hint => 'What is on your mind?..';

  @override
  String get oracle_ask_button => 'Get Answer';

  @override
  String get oracle_tips_loading => 'Loading tips...';

  @override
  String get oracle_tips_title => 'Star Tips for Today';

  @override
  String oracle_tips_subtitle(String count) {
    return 'For communication ($count)';
  }

  @override
  String get oracle_tips_general_advice => 'Be open and sincere.';

  @override
  String get cardOfTheDayProInApp =>
      '✨ Personal aspect is available in the mobile app.';

  @override
  String get numerology_report_title => 'Numerology Report';

  @override
  String get numerology_report_overall => 'Overall Score';

  @override
  String get numerology_report_you => 'You';

  @override
  String get numerology_report_partner => 'Partner';

  @override
  String get userProfile_numerology_button => 'Numerology';

  @override
  String get forecast_astrological_title => 'Astrological Forecast';

  @override
  String get forecast_loading => 'Loading forecast...';

  @override
  String get forecast_error => 'Load Error';

  @override
  String get forecast_no_aspects => 'No significant aspects';

  @override
  String get cosmicEvents_title => 'Cosmic Events';

  @override
  String get cosmicEvents_loading_error => 'Failed to load events';

  @override
  String get cosmicEvents_no_events => 'No upcoming events';

  @override
  String get cosmicEvents_paywall_title => 'Personal Cosmic Events';

  @override
  String get cosmicEvents_paywall_description =>
      'Get access to unique advice based on the influence of planets on your natal chart.';

  @override
  String get cosmicEvents_paywall_button => 'Get PRO Status';

  @override
  String get cosmicEvents_personal_focus => 'Your Personal Focus:';

  @override
  String get cosmicEvents_pro_placeholder =>
      'Learn the personal influence of this event with PRO status';

  @override
  String get search_no_one_found => 'No one found\nin this part of the galaxy.';

  @override
  String get chat_error_user_not_found => 'Error: user not found';

  @override
  String get chat_start_with_hint => 'Start with a hint';

  @override
  String get chat_date_format => 'MMMM d, y';

  @override
  String get chat_group_member => 'member';

  @override
  String get chat_group_members_2_4 => 'members';

  @override
  String get chat_group_members_5_0 => 'members';

  @override
  String get chat_online_status_long_ago => 'was online a long time ago';

  @override
  String get chat_online_status_online => 'online';

  @override
  String chat_online_status_minutes_ago(String minutes) {
    return 'was online $minutes min ago';
  }

  @override
  String chat_online_status_today_at(String time) {
    return 'was online today at $time';
  }

  @override
  String chat_online_status_yesterday_at(String time) {
    return 'was online yesterday at $time';
  }

  @override
  String chat_online_status_date(String date) {
    return 'was online on $date';
  }

  @override
  String get chat_delete_dialog_title => 'Delete chat?';

  @override
  String get chat_delete_dialog_content =>
      'This chat will be deleted for you and your conversation partner. This action is irreversible.';

  @override
  String get chat_delete_dialog_confirm => 'Delete';

  @override
  String chat_report_dialog_title(String name) {
    return 'Report $name';
  }

  @override
  String get chat_report_details_hint => 'Additional details (optional)';

  @override
  String get chat_report_sent_snackbar =>
      'Thank you! Your report has been sent.';

  @override
  String get chat_menu_report => 'Report';

  @override
  String get chat_menu_delete => 'Delete chat';

  @override
  String get chat_group_title_default => 'Group Chat';

  @override
  String get chat_group_participants => 'Participants';

  @override
  String get chat_message_old => 'Message from a previous version';

  @override
  String get chat_input_hint => 'Message...';

  @override
  String get chat_temp_warning_remaining =>
      'This temporary chat will be deleted in ';

  @override
  String get chat_temp_warning_expired => 'chat expired';

  @override
  String get chat_temp_warning_less_than_24h => 'less than 24 hours';

  @override
  String get encrypted_chat_banner_title => 'Conversation is protected';

  @override
  String get encrypted_chat_banner_desc =>
      'Messages in this chat are protected by end-to-end encryption. No one, not even the Aryonika administration, can read them.';

  @override
  String get search_hint => 'Search by name, bio...';

  @override
  String get search_tooltip_swipes => 'Swipes';

  @override
  String get search_tooltip_cosmic_web => 'Cosmic Web';

  @override
  String get search_tooltip_star_map => 'Star Map';

  @override
  String get search_tooltip_filters => 'Filters';

  @override
  String get search_star_map_placeholder => 'Star Map is under development...';

  @override
  String get search_priority_header => 'Top Matches';

  @override
  String get search_other_header => 'Other Users';

  @override
  String get payment_title => 'Support the Project';

  @override
  String get payment_success_snackbar =>
      'Thank you for your support! Updating your status...';

  @override
  String get payment_fail_snackbar =>
      'Failed to process the donation. Please try again.';

  @override
  String get paywall_header_title => 'Unlock the Aryonika Universe';

  @override
  String get paywall_header_subtitle =>
      'Support the project and receive all the cosmic tools to find your perfect match as a thank you.';

  @override
  String get paywall_benefit1_title => 'See Who Liked You';

  @override
  String get paywall_benefit1_subtitle =>
      'Don\'t miss a chance for reciprocity and start the conversation first.';

  @override
  String get paywall_benefit2_title => 'Personal Daily Forecast';

  @override
  String get paywall_benefit2_subtitle =>
      'Daily analysis of your transits and the Focus of the Day.';

  @override
  String get paywall_benefit3_title => 'Partner of the Day & Roulette';

  @override
  String get paywall_benefit3_subtitle =>
      'Let the stars choose the most compatible partner for you.';

  @override
  String get paywall_benefit4_title => 'The Universe\'s Answer';

  @override
  String get paywall_benefit4_subtitle =>
      'Ask your question and receive cosmic advice.';

  @override
  String get paywall_benefit5_title => 'Cosmic Weather';

  @override
  String get paywall_benefit5_subtitle =>
      'Stay informed about geomagnetic storms and their influence.';

  @override
  String get paywall_benefit6_title => 'Card of the Day';

  @override
  String get paywall_benefit6_subtitle =>
      'Get a daily prediction and advice from the Card of Destiny.';

  @override
  String get paywall_donate_button => 'Support the Project';

  @override
  String get paywall_referral_button => 'Get PRO for Friends';

  @override
  String get paywall_referral_subtitle =>
      'Invite a friend and get 1 day of PRO status for each one who registers with your link.';

  @override
  String paywall_get_pro_button(String price) {
    return 'Get Aryonika PRO ($price)';
  }

  @override
  String get paywall_arbitrary_donate_button => 'Support with another amount';

  @override
  String get paywall_arbitrary_donate_subtitle =>
      'If you like our project, you can support it to help us survive in a world of sharks and other predators.';

  @override
  String get chinese_zodiac_title => 'Chinese Zodiac';

  @override
  String get zodiac_Rat => 'Rat';

  @override
  String get zodiac_Ox => 'Ox';

  @override
  String get zodiac_Tiger => 'Tiger';

  @override
  String get zodiac_Rabbit => 'Rabbit';

  @override
  String get zodiac_Dragon => 'Dragon';

  @override
  String get zodiac_Snake => 'Snake';

  @override
  String get zodiac_Horse => 'Horse';

  @override
  String get zodiac_Goat => 'Goat';

  @override
  String get zodiac_Monkey => 'Monkey';

  @override
  String get zodiac_Rooster => 'Rooster';

  @override
  String get zodiac_Dog => 'Dog';

  @override
  String get zodiac_Pig => 'Pig';

  @override
  String get chinese_zodiac_compatibility_button => 'Zodiac Compatibility';

  @override
  String get compatibility_section_title => 'Compatibility';

  @override
  String get userProfile_astro_button => 'Astrology';

  @override
  String get userProfile_bazi_button => 'Bazi';

  @override
  String get jyotishCompatibilityTitle => 'Vedic Compatibility';

  @override
  String get jyotishDetailedAnalysisTitle => 'Detailed Analysis (Ashta-Kuta)';

  @override
  String get kuta_tara_name => 'Tara Kuta (Destiny)';

  @override
  String get kuta_tara_desc =>
      'Indicates luck, duration, and well-being in the relationship. Good compatibility here is like a tailwind for your union.';

  @override
  String get kuta_yoni_name => 'Yoni Kuta (Attraction)';

  @override
  String get kuta_yoni_desc =>
      'Determines physical and sexual harmony. A high score indicates strong mutual attraction and satisfaction.';

  @override
  String get kuta_graha_maitri_name => 'Graha Maitri (Friendship)';

  @override
  String get kuta_graha_maitri_desc =>
      'Psychological compatibility and friendship. Reflects how similar your life views are and how easily you find common ground.';

  @override
  String get kuta_vashya_name => 'Vashya Kuta (Mutual Control)';

  @override
  String get kuta_vashya_desc =>
      'Shows the degree of mutual influence and magnetism in the couple. Who will be the leader and who the follower.';

  @override
  String get kuta_gana_name => 'Gana Kuta (Temperament)';

  @override
  String get kuta_gana_desc =>
      'Compatibility at the temperament level (Divine, Human, Demonic). Helps avoid character conflicts.';

  @override
  String get kuta_bhakoot_name => 'Bhakoot Kuta (Love & Family)';

  @override
  String get kuta_bhakoot_desc =>
      'One of the most important indicators. Responsible for the depth of love, family happiness, financial prosperity, and the possibility of having children.';

  @override
  String get kuta_nadi_name => 'Nadi Kuta (Health)';

  @override
  String get kuta_nadi_desc =>
      'The most weighty criterion. Responsible for health, genetic compatibility, and longevity of the partners and their offspring.';

  @override
  String get kuta_varna_name => 'Varna Kuta (Spirituality)';

  @override
  String get kuta_varna_desc =>
      'Reflects ego compatibility and spiritual development of partners. Shows who in the pair will stimulate the other\'s growth more.';

  @override
  String get jyotishVerdictExcellent =>
      'Celestial Union! Your moon signs are in perfect harmony. This connection promises deep understanding, spiritual growth, and happiness for years to come.';

  @override
  String get jyotishVerdictGood =>
      'Very good compatibility. You have every chance to build a strong, harmonious, and happy relationship. Minor disagreements are easily overcome.';

  @override
  String get jyotishVerdictAverage =>
      'Normal compatibility. Your relationship has both strengths and areas for growth. The success of the union will depend on your willingness to work on the relationship.';

  @override
  String get jyotishVerdictChallenging =>
      'Challenging compatibility. Your charts indicate serious differences in characters and life paths. Much patience and compromise will be required to achieve harmony.';

  @override
  String get passwordResetNewPasswordTitle => 'Set a new password';

  @override
  String get passwordResetNewPasswordLabel => 'New Password';

  @override
  String get passwordResetConfirmLabel => 'Confirm Password';

  @override
  String get passwordValidationError =>
      'Password must be at least 6 characters';

  @override
  String get passwordMismatchError => 'Passwords do not match';

  @override
  String get saveButton => 'Save';

  @override
  String get postActionLike => 'Like';

  @override
  String get postActionComment => 'Comment';

  @override
  String get postActionShare => 'Share';

  @override
  String get channelDefaultName => 'channel';

  @override
  String postShareText(Object channelName, Object postText) {
    return 'Check out this post in the \"$channelName\" channel: $postText';
  }

  @override
  String get postDeleteDialogTitle => 'Delete Post?';

  @override
  String get postDeleteDialogContent => 'This action cannot be undone.';

  @override
  String get delete => 'Delete';

  @override
  String get postMenuDelete => 'Delete Post';

  @override
  String get numerologySectionKeyNumbers => 'Key Numbers';

  @override
  String get numerologySectionCurrentVibes => 'Current Vibrations';

  @override
  String get numerologyTitleLifePath => 'Life Path Number';

  @override
  String get numerologyTitleDestiny => 'Destiny (Expression) Number';

  @override
  String get numerologyTitleSoulUrge => 'Soul Urge Number';

  @override
  String get numerologyTitlePersonality => 'Personality Number';

  @override
  String get numerologyTitleMaturity => 'Maturity Number';

  @override
  String get numerologyTitleBirthday => 'Birthday Number';

  @override
  String get numerologyTitlePersonalYear => 'Personal Year';

  @override
  String get numerologyTitlePersonalMonth => 'Personal Month';

  @override
  String get numerologyTitlePersonalDay => 'Personal Day';

  @override
  String get numerologyErrorNotEnoughData => 'Not enough data for calculation.';

  @override
  String get numerologyErrorDescriptionsNotLoaded =>
      'Failed to load numerology descriptions';

  @override
  String get chat_error_recipient_not_found => 'Recipient not found.';

  @override
  String get chat_error_recipient_profile_load_failed =>
      'Failed to load recipient profile.';

  @override
  String get calculatingNumerology => 'Calculating numerology portrait...';

  @override
  String get oracle_title => 'Oracle';

  @override
  String get verifyEmailBody =>
      'We\'ve sent a 6-digit code to your email. Please enter it below.';

  @override
  String get verifyEmailHint => '------';

  @override
  String get signOutButton => 'Sign Out';

  @override
  String get errorInvalidOrExpiredCode =>
      'Invalid or expired verification code. Please try again.';

  @override
  String get errorCodeRequired => 'Please enter the verification code.';

  @override
  String get errorInternalServer =>
      'An internal server error occurred. Please try again later.';

  @override
  String get errorCodeLength => 'The code must be 6 digits long.';

  @override
  String get verifyEmailTitle => 'Email Verification';

  @override
  String get verificationCodeLabel => 'Verification Code';

  @override
  String get verificationCodeResent => 'A new verification code has been sent!';

  @override
  String get resendCodeAction => 'Resend code';

  @override
  String resendCodeCooldown(int seconds) {
    return 'Resend code in ($seconds)s';
  }

  @override
  String verifyEmailInstruction(String email) {
    return 'We\'ve sent a 6-digit code to your email:\n$email\nPlease enter it below.';
  }

  @override
  String get confirmButton => 'Confirm';

  @override
  String get logout => 'Log Out';

  @override
  String get numerology_score_high => 'High';

  @override
  String get numerology_score_medium => 'Medium';

  @override
  String get numerology_score_low => 'Low';

  @override
  String get noUsersFound => 'No users found';

  @override
  String get feature_in_development => 'This section is under development.';

  @override
  String get download_our_app => 'Download our app';

  @override
  String get open_web_version => 'Open WEB version';

  @override
  String get pay_with_card => 'Pay with Card';

  @override
  String get coming_soon => 'Soon';

  @override
  String get paywall_subscription_terms =>
      'Subscription renews automatically. Cancel anytime.';

  @override
  String get searchHint => 'Search...';

  @override
  String get nav_friends => 'Friends';

  @override
  String get oracle_typing => 'typing...';

  @override
  String get tarot_reversed => '(Reversed)';

  @override
  String get common_close => 'Close';

  @override
  String oracle_limit_pro(Object hours) {
    return '$hours hours left until next request.';
  }

  @override
  String oracle_limit_free(Object days) {
    return 'Free limit reached. $days days left until next request.';
  }

  @override
  String get oracle_error_stream => 'Connection Error';

  @override
  String get oracle_error_start => 'Failed to start';

  @override
  String get error_generic => 'An error occurred. Please try again later.';

  @override
  String get referral_already_used => 'You have already used a referral code.';

  @override
  String get referral_own_code => 'You cannot use your own referral code.';

  @override
  String get referral_success =>
      'Code activated successfully! You received 3 days of Premium.';

  @override
  String get tab_astrology => 'Astrology';

  @override
  String get tab_numerology => 'Numerology';

  @override
  String get tab_bazi => 'Ba Zi';

  @override
  String get tab_jyotish => 'Jyotish';

  @override
  String get share_result => 'Share Result';

  @override
  String get share_preparing => 'Preparing...';

  @override
  String locked_feature_title(Object title) {
    return '$title section locked';
  }

  @override
  String get locked_feature_desc => 'Subscribe to see detailed analysis.';

  @override
  String get get_access_button => 'Get Access';

  @override
  String get coming_soon_suffix => '(Coming Soon)';

  @override
  String get tab_summary => 'Summary';

  @override
  String get tab_chinese_zodiac => 'Chinese Zodiac';

  @override
  String get summary_verdict_title => 'Overall Verdict';

  @override
  String get webVersionButton => 'Web Version';

  @override
  String get uploadPhotoDisclaimer =>
      'By uploading a photo, you confirm that it does not contain nudity or violence. Violators will be permanently banned.';

  @override
  String get iAgree => 'I Agree';

  @override
  String get testers_banner_title => 'TESTERS WANTED (4/20)';

  @override
  String get testers_banner_desc =>
      'Help us improve Aryonika and get\n✨ LIFETIME PREMIUM ✨';

  @override
  String get testers_email_hint => '(Tap to open, Hold to copy)';

  @override
  String get numerology_day_1 =>
      'Day of new beginnings. Perfect time to start projects and take initiative.';

  @override
  String get numerology_day_2 =>
      'Day of partnership. Seek compromise, cooperate, and listen to others.';

  @override
  String get numerology_day_3 =>
      'Day of creativity. Express yourself, socialize, and stay optimistic.';

  @override
  String get numerology_day_4 =>
      'Day of work. Organize your affairs, plan ahead, and build stability.';

  @override
  String get numerology_day_5 =>
      'Day of change. Be open to new things, take risks, and seek adventure.';

  @override
  String get numerology_day_6 =>
      'Day of harmony. Dedicate time to family, home, and caring for loved ones.';

  @override
  String get numerology_day_7 =>
      'Day of reflection. Time for solitude, analysis, and spiritual growth.';

  @override
  String get numerology_day_8 =>
      'Day of power. Focus on career, finances, and achievements.';

  @override
  String get numerology_day_9 =>
      'Day of completion. Let go of the old, forgive, and wrap up loose ends.';

  @override
  String get astro_transit_positive_general =>
      'Звезды на вашей стороне. Действуйте смело.';

  @override
  String get advice_general_balance =>
      'Сохраняйте баланс между чувствами и разумом.';

  @override
  String get astro_advice_listen_intuition =>
      'The Moon amplifies your intuition. Listen to your inner voice.';

  @override
  String get astro_advice_act_boldly =>
      'Planetary energy favors action. Do not be afraid to be bold.';

  @override
  String get astro_advice_rest_and_reflect =>
      'The stars advise slowing down. Find time for rest and recovery.';

  @override
  String get astro_advice_connect_with_nature =>
      'A favorable time for grounding. Spend some time in nature.';

  @override
  String get advice_generic_positive =>
      'The Universe is on your side today. Act consciously.';

  @override
  String get channelLoadError => 'Failed to load channel';

  @override
  String get postsTitle => 'Posts';

  @override
  String get noPostsYet => 'No posts in this channel yet.';

  @override
  String get createPostTooltip => 'Create post';

  @override
  String get proposePost => 'Propose news';

  @override
  String get channelsTitle => 'Channels';

  @override
  String get noChannelSubscriptions => 'No subscriptions yet';

  @override
  String get noMessagesYet => 'No messages yet';

  @override
  String get yesterday => 'Yesterday';

  @override
  String get search => 'Search';

  @override
  String get adminOnlyFeature =>
      'Creating channels is temporarily available only to administrators.';

  @override
  String get createChannel => 'Create Channel';

  @override
  String get galacticBroadcasts => 'Galactic Broadcasts';

  @override
  String get noChannelsYet =>
      'You haven\'t subscribed to anything yet.\nFind or create your own channel!';

  @override
  String get constellationsTitle => 'Constellations';

  @override
  String get privateChatsTab => 'Private';

  @override
  String get channelsTab => 'Channels';

  @override
  String get loadingUser => 'Loading user...';

  @override
  String get emptyChatsPlaceholder =>
      'Your private chats will appear here.\nFind someone interesting via search!';

  @override
  String get errorTitle => 'Error';

  @override
  String get autoDeleteMessages => 'Auto-delete messages';

  @override
  String get availableInPro => 'Available in PRO';

  @override
  String get timerOff => 'Off';

  @override
  String get timer15min => '15 minutes';

  @override
  String get timer1hour => '1 hour';

  @override
  String get timer4hours => '4 hours';

  @override
  String get timer24hours => '24 hours';

  @override
  String get timerSet => 'Timer set';

  @override
  String get disappearingMessages => 'Disappearing messages';

  @override
  String get communicationTitle => 'Communication';

  @override
  String get errorLoadingReport => 'Error loading report';

  @override
  String get compatibility => 'Compatibility';

  @override
  String get strengths => 'Strengths';

  @override
  String get weaknesses => 'Potential difficulties';

  @override
  String get commentsTitle => 'Comments';

  @override
  String get commentsLoadError => 'Error loading comments.';

  @override
  String get noCommentsYet => 'No comments yet.';

  @override
  String userIsTyping(Object name) {
    return '$name is typing...';
  }

  @override
  String twoUsersTyping(Object name1, Object name2) {
    return '$name1 and $name2 are typing...';
  }

  @override
  String manyUsersTyping(Object count, Object name1, Object name2) {
    return '$name1, $name2 and $count others are typing...';
  }

  @override
  String replyingTo(Object name) {
    return 'Replying to $name';
  }

  @override
  String get writeCommentHint => 'Write a comment...';

  @override
  String get compatibilityTitle => 'Cosmic Connection';

  @override
  String get noData => 'No data';

  @override
  String get westernAstrology => 'Western Astrology';

  @override
  String get vedicAstrology => 'Vedic Astrology (Jyotish)';

  @override
  String get numerology => 'Numerology';

  @override
  String get chineseZodiac => 'Chinese Zodiac';

  @override
  String get baziElements => 'Ba Zi (Elements)';

  @override
  String get availableInPremium => 'Available in Premium';

  @override
  String get verdictSoulmates => 'Soulmates';

  @override
  String get verdictGreatMatch => 'Great Match';

  @override
  String get verdictPotential => 'Has Potential';

  @override
  String get verdictKarmic => 'Karmic Lesson';

  @override
  String get createChannelTitle => 'Create Broadcast';

  @override
  String get channelNameLabel => 'Broadcast Name';

  @override
  String get channelNameHint => 'E.g., \'Daily Tarot Forecasts\'';

  @override
  String get errorChannelNameEmpty => 'Name cannot be empty';

  @override
  String get channelHandleLabel => 'Unique ID (@handle)';

  @override
  String get errorChannelHandleShort => 'ID must be longer than 4 characters';

  @override
  String get channelDescriptionLabel => 'Description';

  @override
  String get channelDescriptionHint => 'Tell us what your channel is about...';

  @override
  String get errorChannelDescriptionEmpty => 'Please add a description';

  @override
  String get createButton => 'Create';

  @override
  String get editProfileTitle => 'Edit Profile';

  @override
  String get profileNotFoundError => 'Error: Profile not found';

  @override
  String get profileSavedSuccess => 'Profile saved successfully!';

  @override
  String get saveError => 'Save error';

  @override
  String get avatarUploadError => 'Photo upload error';

  @override
  String get nameLabel => 'Name';

  @override
  String get bioLabel => 'About me';

  @override
  String get birthDataTitle => 'Birth Data';

  @override
  String get birthDataWarning =>
      'Changing this data will lead to a complete recalculation of your astrological and numerological portrait.';

  @override
  String get birthDateLabel => 'Date of Birth';

  @override
  String get birthPlaceLabel => 'Place of Birth';

  @override
  String get errorUserNotFound => 'Error: User not found';

  @override
  String get feedUpdateError => 'Feed update error';

  @override
  String get feedEmptyMessage => 'Your feed is empty.\nPull down to refresh.';

  @override
  String get whereToSearch => 'Where to search';

  @override
  String get searchNearby => 'Nearby';

  @override
  String get searchCity => 'City';

  @override
  String get searchCountry => 'Country';

  @override
  String get searchWorld => 'World';

  @override
  String get ageLabel => 'Age';

  @override
  String get showGenderLabel => 'Show';

  @override
  String get genderAll => 'All';

  @override
  String get zodiacFilterLabel => 'Zodiac Elements';

  @override
  String get resetFilters => 'Reset';

  @override
  String get applyFilters => 'Apply';

  @override
  String get forecastLoadError =>
      'Failed to load forecast.\nPlease try again later.';

  @override
  String get noForecastEvents =>
      'No significant astrological events today.\nA calm day!';

  @override
  String get unlockFullForecast => 'Unlock full forecast';

  @override
  String get myFriendsTab => 'My Friends';

  @override
  String get friendRequestsTab => 'Requests';

  @override
  String get noFriendsYet => 'You have no friends yet. Find them in search!';

  @override
  String get noFriendRequests => 'No new requests.';

  @override
  String get removeFriend => 'Remove Friend';

  @override
  String get gamesComingSoonTitle => 'Games & Rewards coming soon!';

  @override
  String get gamesComingSoonDesc =>
      'We are preparing exciting mini-games and quizzes. Check your compatibility, earn \"Stardust\" and exchange it for premium days or unique gifts!';

  @override
  String get joinTelegramButton => 'Be the first to know on our Telegram';

  @override
  String horoscopeForSign(Object sign) {
    return 'Horoscope for $sign';
  }

  @override
  String get horoscopeGeneral => 'General';

  @override
  String get horoscopeLove => 'Love';

  @override
  String get horoscopeBusiness => 'Business';

  @override
  String get verdictNotFound => 'Verdict not found';

  @override
  String get vedicCompatibilityTitle => 'Vedic Compatibility';

  @override
  String get ashtaKutaAnalysis => 'Detailed Analysis (Ashta-Kuta)';

  @override
  String get noDescription => 'Description not found.';

  @override
  String get likesYouEmpty => 'People interested in you will appear here';

  @override
  String peopleLikeYou(Object count) {
    return '$count people like you!';
  }

  @override
  String get getProToSeeLikes =>
      'Get PRO status to see their profiles and start chatting.';

  @override
  String get seeLikesButton => 'See Likes';

  @override
  String get someone => 'Someone';

  @override
  String get selectCityTitle => 'Select City';

  @override
  String get searchCityHint => 'Enter city name...';

  @override
  String get nothingFound => 'Nothing found';

  @override
  String get errorNatalChartMissing =>
      'Error: your natal chart is not calculated.';

  @override
  String get manualCheckTitle => 'Manual Check';

  @override
  String get checkAgainTooltip => 'Check again';

  @override
  String get synastryTitle => 'Partner Synastry';

  @override
  String get synastryDesc =>
      'Enter the person\'s birth data to calculate your detailed compatibility.';

  @override
  String get partnerNameLabel => 'Partner Name';

  @override
  String get tapToSelect => 'Tap to select';

  @override
  String get calculateButton => 'Calculate';

  @override
  String get you => 'You';

  @override
  String summary_desc(Object score, Object verdict) {
    return 'Your union has a potential of $score%. Stars and numbers indicate $verdict.';
  }

  @override
  String get strongConnection => 'a strong connection';

  @override
  String get interestingLessons => 'interesting lessons';

  @override
  String get moderationProposedPosts => 'Proposed Posts';

  @override
  String get noProposedPosts => 'No proposed posts.';

  @override
  String get from => 'From';

  @override
  String get personalNumerologyTitle => 'Personal Numerology';

  @override
  String get dataNotLoaded => 'Data not loaded';

  @override
  String get loading => 'Loading...';

  @override
  String get lifePathNumber => 'Life Path Number';

  @override
  String get corePersonality => 'Core Personality';

  @override
  String get destinyNumber => 'Destiny Number';

  @override
  String get soulNumber => 'Soul Urge Number';

  @override
  String get personalityNumber => 'Personality Number';

  @override
  String get timeInfluence => 'Influence of Time';

  @override
  String get maturityNumber => 'Maturity Number';

  @override
  String get birthdayNumber => 'Birthday Number';

  @override
  String get currentVibrationsPro => 'Current Vibrations (PRO)';

  @override
  String get personalYear => 'Personal Year';

  @override
  String get personalMonth => 'Personal Month';

  @override
  String get personalDay => 'Personal Day';

  @override
  String get proVibrationsDesc =>
      'Discover your vibrations for the Year, Month, and Day. Available in Premium only.';

  @override
  String get unlockButton => 'Unlock';

  @override
  String get tapForDetails => 'Tap for details';

  @override
  String oracle_weather_desc(Object desc, Object kp) {
    return '$desc (Kp: $kp)';
  }

  @override
  String oracle_geomagnetic_now(Object desc) {
    return 'Now: $desc';
  }

  @override
  String oracle_geomagnetic_index(Object kp) {
    return 'Kp Index: $kp';
  }

  @override
  String get oracle_question_title => 'Ask the Oracle';

  @override
  String get oracle_question_hint => 'What worries you?...';

  @override
  String get oracle_question_button => 'Get Answer';

  @override
  String get palmistry_analysis_title => 'Palm Analysis';

  @override
  String get palmistry_choose_option => 'Choose the most suitable option:';

  @override
  String get palmistry_analysis_saved => 'Analysis saved!';

  @override
  String get palmistry_view_report => 'View Full Report';

  @override
  String get palmistry_complete_all => 'Complete analysis of all lines';

  @override
  String get palmistry_analysis_complete => 'Great! Analysis complete.';

  @override
  String palmistry_tap_line(Object lineName) {
    return 'Tap on \'$lineName\' to compare with your palm.';
  }

  @override
  String palmistry_searching_line(Object lineName) {
    return 'Searching for \'$lineName\'...';
  }

  @override
  String get palmistry_preparing => 'Preparing for analysis...';

  @override
  String get palmistry_report_title => 'Map of Your Destiny';

  @override
  String get palmistry_data_not_found => 'Analysis data not found.';

  @override
  String get palmistry_strong_traits => 'Your Strengths';

  @override
  String get privacy => 'Privacy';

  @override
  String get palmistry_show_in_profile => 'Show my traits in profile';

  @override
  String get palmistry_show_in_profile_desc =>
      'This will help others know you better and improve compatibility matching.';

  @override
  String get palmistry_interpretation => 'Line Interpretation';

  @override
  String palmistry_your_choice(Object choice) {
    return 'Your choice: \"$choice\"';
  }

  @override
  String get photoAlbumComingSoon =>
      'Soon you will be able to upload your photos here.';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get accountManagement => 'Account Management';

  @override
  String get changePassword => 'Change Password';

  @override
  String get restorePassword => 'Reset Password';

  @override
  String get editProfileButton => 'Edit Profile';

  @override
  String get dailyNotifications => 'Daily Notifications';

  @override
  String get alertsTitle => 'Alerts';

  @override
  String get geomagneticStorms => 'Geomagnetic Storms';

  @override
  String get adminPanelTitle => 'Admin Panel';

  @override
  String get adminManageUsers => 'Manage Users';

  @override
  String get offerAgreementLink => 'Offer Agreement';

  @override
  String get accountSectionTitle => 'Account';

  @override
  String get deleteAccountButton => 'Delete Account';

  @override
  String get closeAppButton => 'Close App';

  @override
  String get changePasswordDesc =>
      'Please enter your current password for security.';

  @override
  String get currentPasswordLabel => 'Current Password';

  @override
  String get newPasswordLabel => 'New Password';

  @override
  String get passwordChangedSuccess => 'Password successfully changed!';

  @override
  String resetPasswordInstruction(String email) {
    return 'We will send password reset instructions to your E-mail:\n\n$email';
  }

  @override
  String get signOutDialogTitle => 'Sign Out';

  @override
  String get signOutDialogContent => 'Are you sure you want to sign out?';

  @override
  String get deleteAccountTitle => 'Delete Account?';

  @override
  String get deleteAccountWarning =>
      'This action is irreversible. All your data, chats, photos, and purchases will be permanently deleted.';

  @override
  String get deleteForeverButton => 'Delete Forever';

  @override
  String get roulette_trust_fate => 'Trust Fate';

  @override
  String get roulette_desc_short =>
      'The stars will choose the most compatible partner for you (from 85%!).';

  @override
  String get roulette_no_candidates => 'No candidates to spin.';

  @override
  String get roulette_winner_title => 'The stars have made their choice!';

  @override
  String get roulette_spin_again => 'Spin Again';

  @override
  String get roulette_go_to_profile => 'Go to Profile';

  @override
  String get cityNotSpecified => 'City not specified';

  @override
  String get geomagnetic_calm => 'Calm';

  @override
  String get geomagnetic_unsettled => 'Unsettled';

  @override
  String get geomagnetic_active => 'Active';

  @override
  String get geomagnetic_storm_minor => 'Minor Storm (G1)';

  @override
  String get geomagnetic_storm_moderate => 'Moderate Storm (G2)';

  @override
  String get geomagnetic_storm_strong => 'Strong Storm (G3)';

  @override
  String get geomagnetic_storm_severe => 'Severe Storm (G4)';

  @override
  String get geomagnetic_storm_extreme => 'Extreme Storm (G5)';

  @override
  String get deleteChatTitle => 'Delete chat?';

  @override
  String get deleteChatConfirmation =>
      'All messages will be permanently deleted.';

  @override
  String get chatDeleted => 'Chat deleted';
}
