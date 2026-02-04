// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get profileCreationErrorTitle => 'प्रोफ़ाइल बनाने में त्रुटि';

  @override
  String get profileCreationErrorDescription =>
      'क्षमा करें, आपका डेटा सहेजते समय एक त्रुटि हुई। कृपया फिर से पंजीकरण करने का प्रयास करें।';

  @override
  String get tryAgain => 'पुनः प्रयास करें';

  @override
  String get connectingHearts => 'ब्रह्मांड में दिलों को जोड़ रहे हैं...';

  @override
  String get appName => 'Aryonika';

  @override
  String get exitConfirmationTitle => 'पुष्टिकरण';

  @override
  String get exitConfirmationContent =>
      'क्या आप वाकई Aryonika बंद करना चाहते हैं?';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get close => 'बंद करें';

  @override
  String get paymentUrlError => 'त्रुटि: भुगतान URL नहीं मिला।';

  @override
  String get channelIdError => 'त्रुटि: चैनल आईडी नहीं मिली।';

  @override
  String documentLoadError(Object error) {
    return 'Ошибка загрузки документа: $error';
  }

  @override
  String get partnerIdError =>
      'त्रुटि: संगतता की गणना के लिए पार्टनर आईडी आवश्यक है।';

  @override
  String get bioPlaceholder => 'यहाँ आपकी कहानी हो सकती है...';

  @override
  String photoAlbumTitle(Object photoCount) {
    return 'फोटो एलबम ($photoCount)';
  }

  @override
  String get photoAlbumSubtitle => 'आपके बेहतरीन पल';

  @override
  String get cosmicEventsTitle => 'ब्रह्मांडीय घटनाएँ';

  @override
  String get cosmicEventsSubtitle => 'ग्रहों के प्रभाव के बारे में जानें';

  @override
  String get inviteFriendTitle => 'मित्र को आमंत्रित करें';

  @override
  String get inviteFriendSubtitle => 'एक साथ बोनस प्राप्त करें';

  @override
  String get gameCenterTitle => 'गेम सेंटर';

  @override
  String get gameCenterSubtitle => 'मिनी-गेम्स और क्वेस्ट';

  @override
  String get personalForecastTitle => 'व्यक्तिगत पूर्वानुमान';

  @override
  String get personalForecastSubtitlePro => 'आज के लिए गोचर विश्लेषण';

  @override
  String get personalForecastSubtitleFree => 'प्रो-स्टेटस के साथ उपलब्ध';

  @override
  String get cosmicPassportTitle => 'ब्रह्मांडीय पासपोर्ट';

  @override
  String get numerologyPortraitTitle => 'अंकशास्त्रीय चित्र';

  @override
  String get yourNumbersOfDestinyTitle => 'आपके भाग्य के अंक';

  @override
  String get yourNumbersOfDestinySubtitle => 'अपनी क्षमता को उजागर करें';

  @override
  String get numerologyPath => 'पथ';

  @override
  String get numerologyDestiny => 'भाग्य';

  @override
  String get numerologySoul => 'आत्मा';

  @override
  String get signOut => 'खाते से बाहर निकलें';

  @override
  String get calculatingChart => 'कुंडली की गणना हो रही है...';

  @override
  String get astroDataSignMissing => 'इस राशि के लिए डेटा उपलब्ध नहीं है।';

  @override
  String astroDataDescriptionNotFound(Object signName) {
    return '\"$signName\" के लिए विवरण नहीं मिला।';
  }

  @override
  String astroDataMapNotLoaded(Object mapKey) {
    return '\"$mapKey\" के लिए डेटा लोड नहीं हुआ।';
  }

  @override
  String get planetSun => 'सूर्य';

  @override
  String get planetMoon => 'चंद्रमा';

  @override
  String get planetAscendant => 'लग्न';

  @override
  String get planetMercury => 'बुध';

  @override
  String get planetVenus => 'शुक्र';

  @override
  String get planetMars => 'मंगल';

  @override
  String get planetSaturn => 'शनि';

  @override
  String get planetJupiter => 'बृहस्पति';

  @override
  String get planetUranus => 'अरुण';

  @override
  String get planetNeptune => 'वरुण';

  @override
  String get planetPluto => 'यम';

  @override
  String get getProTitle => 'प्रो प्राप्त करें';

  @override
  String get getProSubtitle => 'सभी सुविधाएँ अनलॉक करें';

  @override
  String get proStatusActive => 'प्रो-स्टेटस सक्रिय है';

  @override
  String get proStatusExpired => 'स्टेटस समाप्त हो गया है';

  @override
  String proStatusDaysLeft(Object days) {
    return 'शेष दिन: $days';
  }

  @override
  String proStatusHoursLeft(Object hours) {
    return 'शेष घंटे: $hours';
  }

  @override
  String get proStatusExpiresToday => 'आज समाप्त हो रहा है';

  @override
  String astroDialogTitle(Object planetName, Object signName) {
    return '$signName राशि में $planetName';
  }

  @override
  String get likesYouTitle => 'आपको पसंद करते हैं';

  @override
  String likesYouTotal(Object count) {
    return 'कुल पसंद: $count';
  }

  @override
  String get likesYouNone => 'अभी तक कोई पसंद नहीं';

  @override
  String reportOnUser(Object userName) {
    return '$userName पर रिपोर्ट करें';
  }

  @override
  String get reportReasonSpam => 'स्पैम';

  @override
  String get reportReasonInsultingBehavior => 'अपमानजनक व्यवहार';

  @override
  String get reportReasonScam => 'धोखाधड़ी';

  @override
  String get reportReasonInappropriateContent => 'अनुचित सामग्री';

  @override
  String get reportDetailsHint => 'अतिरिक्त विवरण (वैकल्पिक)';

  @override
  String get send => 'भेजें';

  @override
  String get reportSentSnackbar => 'धन्यवाद! आपकी शिकायत भेज दी गई है।';

  @override
  String get profileLoadError => 'प्रोफ़ाइल लोड करने में विफल';

  @override
  String get back => 'वापस';

  @override
  String get report => 'रिपोर्ट करें';

  @override
  String userProfilePhotoAlbumTitle(Object photoCount) {
    return 'फोटो एलबम ($photoCount)';
  }

  @override
  String get userProfileViewPhotos => 'तस्वीरें देखें';

  @override
  String get aboutMe => 'मेरे बारे में';

  @override
  String get bioEmpty => 'उपयोगकर्ता ने अपने बारे में कुछ नहीं बताया है।';

  @override
  String get cosmicPassport => 'ब्रह्मांडीय पासपोर्ट';

  @override
  String sunInSign(Object signName) {
    return '☀️ $signName राशि में सूर्य';
  }

  @override
  String get friendshipStatusFriends => 'आप मित्र हैं';

  @override
  String get friendshipRemoveTitle => 'मित्रों से हटाएँ?';

  @override
  String friendshipRemoveContent(Object userName) {
    return 'क्या आप वाकई $userName को मित्रों से हटाना चाहते हैं?';
  }

  @override
  String get remove => 'हटाएँ';

  @override
  String get friendshipStatusRequestSent => 'अनुरोध भेजा गया';

  @override
  String get friendshipActionDecline => 'अस्वीकार करें';

  @override
  String get friendshipActionAccept => 'स्वीकार करें';

  @override
  String get friendshipActionAdd => 'मित्र बनाएं';

  @override
  String likeSnackbarSuccess(Object userName) {
    return 'आपने $userName को पसंद किया!';
  }

  @override
  String likeSnackbarAlreadyLiked(Object userName) {
    return 'आप पहले ही $userName को पसंद कर चुके हैं';
  }

  @override
  String get writeMessage => 'संदेश लिखें';

  @override
  String get checkCompatibility => 'संगतता जांचें';

  @override
  String get yourCosmicInfluence => 'आज आपका ब्रह्मांडीय प्रभाव';

  @override
  String get cosmicEventsLoading => 'ब्रह्मांडीय घटनाओं की गणना हो रही है...';

  @override
  String get cosmicEventsEmpty => 'आज ब्रह्मांड शांत है। सामंजस्य का आनंद लें!';

  @override
  String get cosmicEventsError =>
      'ब्रह्मांडीय घटनाओं की गणना करने में विफल। बाद में प्रयास करें।';

  @override
  String get cosmicConnectionTitle => 'ब्रह्मांडीय संबंध';

  @override
  String shareText(Object name, Object score) {
    return '$name के साथ हमारी अनुकूलता $score% है! ✨\nAryonika में गणना की गई';
  }

  @override
  String get shareErrorSnackbar =>
      'साझा करने का प्रयास करते समय एक त्रुटि हुई।';

  @override
  String get compatibilityErrorTitle => 'संगतता की गणना करने में विफल';

  @override
  String get compatibilityErrorSubtitle =>
      'हो सकता है कि पार्टनर का डेटा अधूरा हो या कोई नेटवर्क त्रुटि हुई हो।';

  @override
  String get goBack => 'वापस जाएं';

  @override
  String get sectionCosmicAdvice => 'ब्रह्मांडीय सलाह';

  @override
  String get sectionDailyInfluence => 'दिन का प्रभाव';

  @override
  String get sectionAstrologicalResonance => 'ज्योतिषीय अनुनाद';

  @override
  String get sectionNumerologyMatrix => 'अंकशास्त्रीय मैट्रिक्स';

  @override
  String get sectionPalmistryConnection => 'हस्तरेखा संबंध';

  @override
  String get sectionAboutPerson => 'व्यक्ति के बारे में';

  @override
  String get palmistryNoData =>
      'एक साथी ने अभी तक हस्तरेखा विश्लेषण पूरा नहीं किया है। यह आपकी संगतता का एक नया स्तर खोलेगा!';

  @override
  String palmistryCommonTraits(Object traits) {
    return 'आप $traits से एकजुट हैं। यह आपके रिश्ते के लिए एक मजबूत नींव बनाता है।';
  }

  @override
  String palmistryUniqueTraits(Object myTrait, Object partnerTrait) {
    return 'आप एक-दूसरे के पूरक हैं: आपका गुण \'$myTrait\' उनके \'$partnerTrait\' के साथ खूबसूरती से मेल खाता है।';
  }

  @override
  String get harmony => 'सामंजस्य';

  @override
  String get adviceRareConnection =>
      'आपकी आत्माएं एक सुर में गूंजती हैं। यह एक दुर्लभ ब्रह्मांडीय संबंध है, जहाँ व्यक्तित्व (सूर्य) और भावनाएं (चंद्रमा) दोनों सामंजस्य में हैं। इस खजाने की सराहना करें।';

  @override
  String get advicePassionChallenge =>
      'आपके बीच जुनून की आग जल रही है, लेकिन आपके व्यक्तित्व में टकराव हो सकता है। विवादों को विकास के लिए ऊर्जा में बदलना सीखें, और आपका बंधन अटूट हो जाएगा।';

  @override
  String get adviceBestFriends =>
      'आप सबसे अच्छे दोस्त हैं जो एक-दूसरे को आधा शब्द में समझते हैं और सहज महसूस करते हैं। शारीरिक आकर्षण समय के साथ बढ़ सकता है, मुख्य बात आपकी आध्यात्मिक निकटता है।';

  @override
  String get adviceKarmicLesson =>
      'आपके रास्ते संयोग से नहीं मिले हैं। यह संबंध दोनों के लिए महत्वपूर्ण सबक लेकर आता है। यह समझने के लिए धैर्य और खुले रहें कि आपको एक-दूसरे को क्या सिखाना है।';

  @override
  String get adviceGreatPotential =>
      'आपके बीच एक मजबूत आकर्षण और विकास की महान क्षमता है। एक-दूसरे से सीखें, और आपका बंधन मजबूत होगा। सितारे आपके पक्ष में हैं।';

  @override
  String get adviceBase =>
      'एक-दूसरे का अध्ययन करें। हर मुलाकात एक नए ब्रह्मांड को खोजने का अवसर है। आपकी कहानी अभी शुरू हो रही है।';

  @override
  String get dailyInfluenceCalm =>
      'ब्रह्मांडीय शांति। बाहरी प्रभावों के बिना एक-दूसरे की संगति का आनंद लेने के लिए एक महान दिन।';

  @override
  String get dailyAdviceFavorable =>
      'सलाह: इस ऊर्जा का उपयोग करें! संयुक्त योजनाओं के लिए एक शानदार क्षण।';

  @override
  String get dailyAdviceTense =>
      'सलाह: एक-दूसरे के प्रति अधिक सहिष्णु बनें। गलतफहमी संभव है।';

  @override
  String get proFeatureLocked =>
      'इस पहलू का विस्तृत विश्लेषण प्रो-संस्करण में उपलब्ध है।';

  @override
  String get getProButton => 'प्रो प्राप्त करें';

  @override
  String get numerologyLifePath => 'जीवन पथ';

  @override
  String get numerologyDestinyNumber => 'भाग्य अंक';

  @override
  String get numerologySoulNumber => 'आत्मा अंक';

  @override
  String get shareCardTitle => 'Aryonika';

  @override
  String get shareCardSubtitle => 'ब्रह्मांडीय संगतता रिपोर्ट';

  @override
  String get shareCardHarmony => 'कुल सामंजस्य';

  @override
  String get shareCardPersonalityHarmony => 'व्यक्तित्व सामंजस्य (सूर्य)';

  @override
  String get shareCardLifePath => 'जीवन पथ (अंकशास्त्र)';

  @override
  String get shareCardCtaTitle => 'अपनी ब्रह्मांडीय\nसंगतता जानें!';

  @override
  String get shareCardCtaSubtitle => 'ऐप स्टोर से Aryonika डाउनलोड करें';

  @override
  String get loginTitle => 'खाते में प्रवेश करें';

  @override
  String get loginError => 'लॉगिन त्रुटि';

  @override
  String get passwordResetTitle => 'पासवर्ड पुनर्प्राप्ति';

  @override
  String get passwordResetContent =>
      'अपना ई-मेल दर्ज करें, और हम आपको पासवर्ड रीसेट करने के लिए निर्देश भेजेंगे।';

  @override
  String get emailLabel => 'ई-मेल';

  @override
  String get sendButton => 'भेजें';

  @override
  String get emailValidationError => 'कृपया एक मान्य ई-मेल दर्ज करें।';

  @override
  String get passwordResetSuccess => 'पत्र भेजा गया! अपना मेल जांचें।';

  @override
  String get passwordLabel => 'पासवर्ड';

  @override
  String get loginButton => 'लॉग इन करें';

  @override
  String get forgotPasswordButton => 'पासवर्ड भूल गए?';

  @override
  String get noAccountButton => 'खाता नहीं है? बनाएं';

  @override
  String get registerTitle => 'खाता बनाना';

  @override
  String get unknownError => 'एक अज्ञात त्रुटि हुई';

  @override
  String get confirmPasswordLabel => 'पासवर्ड की पुष्टि कीजिये';

  @override
  String get privacyPolicyCheckbox => 'मैं ';

  @override
  String get termsOfUseLink => 'उपयोग की शर्तें';

  @override
  String get and => ' और ';

  @override
  String get privacyPolicyLink => 'गोपनीयता नीति';

  @override
  String get registerButton => 'पंजीकरण करें';

  @override
  String get alreadyHaveAccountButton => 'पहले से ही एक खाता है? लॉग इन करें';

  @override
  String get welcomeTagline => 'आपकी किस्मत सितारों में लिखी है';

  @override
  String get welcomeCreateAccountButton => 'ब्रह्मांडीय पासपोर्ट बनाएं';

  @override
  String get welcomeLoginButton => 'मेरा पहले से ही एक खाता है';

  @override
  String get introSlide1Title => 'Aryonika — डेटिंग से कहीं बढ़कर';

  @override
  String get introSlide1Description =>
      'ज्योतिष, अंकशास्त्र और भाग्य के कार्ड के माध्यम से संगतता के नए पहलुओं की खोज करें।';

  @override
  String get introSlide2Title => 'आपका ब्रह्मांडीय पासपोर्ट';

  @override
  String get introSlide2Description =>
      'अपनी पूरी क्षमता के बारे में जानें और उसे खोजें जो आपके ब्रह्मांड को पूरा करेगा।';

  @override
  String get introSlide3Title => 'आकाशगंगा में शामिल हों';

  @override
  String get introSlide3Description =>
      'सच्चे प्यार की अपनी ब्रह्मांडीय यात्रा अभी शुरू करें।';

  @override
  String get introButtonSkip => 'छोड़ें';

  @override
  String get introButtonNext => 'अगला';

  @override
  String get introButtonStart => 'शुरू करें';

  @override
  String get onboardingNameTitle => 'आपका नाम क्या है?';

  @override
  String get onboardingNameSignOutTooltip => 'लॉग आउट (परीक्षण के लिए)';

  @override
  String get onboardingNameSubtitle =>
      'यह नाम अन्य उपयोगकर्ताओं को दिखाई देगा।';

  @override
  String get onboardingNameLabel => 'आपका नाम';

  @override
  String get onboardingBioLabel => 'अपने बारे में बताएं';

  @override
  String get onboardingBioHint => 'उदाहरण: मुझे ज्योतिष और #यात्रा पसंद है...';

  @override
  String get onboardingButtonNext => 'अगला';

  @override
  String get onboardingBirthdateTitle => 'आपका जन्म कब हुआ?';

  @override
  String get onboardingBirthdateSubtitle =>
      'यह आपकी जन्म कुंडली और अंकशास्त्र की सटीक गणना के लिए आवश्यक है।';

  @override
  String get datePickerHelpText => 'जन्म तिथि चुनें';

  @override
  String get birthdateLabel => 'जन्म की तारीख';

  @override
  String get birthdatePlaceholder => 'चुनने के लिए क्लिक करें';

  @override
  String get dateFormat => 'd MMMM yyyy';

  @override
  String get onboardingFinishText1 =>
      'सितारों की स्थिति का विश्लेषण कर रहे हैं...';

  @override
  String get onboardingFinishText2 =>
      'आपके अंकशास्त्रीय कोड की गणना कर रहे हैं...';

  @override
  String get onboardingFinishText3 => 'भाग्य के कार्ड से जाँच कर रहे हैं...';

  @override
  String get onboardingFinishText4 =>
      'आपका ब्रह्मांडीय पासपोर्ट बना रहे हैं...';

  @override
  String get onboardingFinishErrorTitle => 'त्रुटि';

  @override
  String get onboardingFinishErrorContent => 'एक अज्ञात त्रुटि हुई।';

  @override
  String get onboardingFinishErrorButton => 'वापस';

  @override
  String get onboardingGenderTitle => 'आपका लिंग';

  @override
  String get onboardingGenderSubtitle =>
      'यह हमें आपके लिए सबसे उपयुक्त लोगों को खोजने में मदद करेगा।';

  @override
  String get genderMale => 'पुरुष';

  @override
  String get genderFemale => 'महिलाएं';

  @override
  String get onboardingLocationTitle => 'जन्म स्थान';

  @override
  String get onboardingLocationSubtitle =>
      'वह शहर बताएं जहां आपका जन्म हुआ था। यह सटीक ज्योतिषीय गणना के लिए आवश्यक है।';

  @override
  String get onboardingLocationSearchHint => 'शहर टाइप करना शुरू करें...';

  @override
  String get onboardingLocationNotFound =>
      'कोई शहर नहीं मिला। कोई और खोज प्रयास करें।';

  @override
  String get onboardingLocationStartSearch =>
      'परिणाम देखने के लिए खोजना शुरू करें';

  @override
  String get onboardingLocationSelectFromList =>
      'जारी रखने के लिए ऊपर दी गई सूची से एक शहर चुनें';

  @override
  String get onboardingTimeTitle => 'जन्म का समय';

  @override
  String get onboardingTimeSubtitle =>
      'यदि आप सही समय नहीं जानते हैं, तो 12:00 दर्ज करें। यह अभी भी एक अच्छा परिणाम देगा।';

  @override
  String get timePickerHelpText => 'जन्म का समय निर्दिष्ट करें';

  @override
  String get birthTimeLabel => 'जन्म का समय';

  @override
  String get onboardingButtonNextLocation => 'अगला (स्थान चुनें)';

  @override
  String get alphaBannerTitle => 'अल्फा संस्करण';

  @override
  String get alphaBannerContent =>
      'यह खंड सक्रिय विकास के अधीन है। कुछ सुविधाएँ अस्थिर रूप से काम कर सकती हैं। हम स्थानीयकरण पर सक्रिय रूप से काम कर रहे हैं, इसलिए कुछ पाठ अभी भी अंग्रेजी में हो सकते हैं। समझने के लिए धन्यवाद!';

  @override
  String get alphaBannerFeedback =>
      'हम हमारे टेलीग्राम चैनल में आपकी टिप्पणियों और सुझावों के लिए आभारी होंगे!';

  @override
  String get astro_title_sun => 'व्यक्तित्व संगतता (सूर्य)';

  @override
  String get astro_title_moon => 'भावनात्मक संगतता (चंद्रमा)';

  @override
  String get astro_title_chemistry => 'ज्योतिषीय रसायन (शुक्र-मंगल)';

  @override
  String get astro_title_mercury => 'संचार शैली (बुध)';

  @override
  String get astro_title_saturn => 'दीर्घकालिक परिप्रेक्ष्य (शनि)';

  @override
  String get numerology_title => 'अंकशास्त्रीय अनुनाद';

  @override
  String get cosmicPulseTitle => 'लौकिक नाड़ी';

  @override
  String get feedIceBreakerTitle => 'आइस ब्रेकर';

  @override
  String get feedOrbitCrossingTitle => 'कक्षा पार';

  @override
  String get feedSpiritualNeighborTitle => 'आध्यात्मिक पड़ोसी';

  @override
  String get feedGeomagneticStormTitle => 'भू-चुंबकीय तूफान';

  @override
  String get feedCompatibilityPeakTitle => 'संगतता शिखर';

  @override
  String get feedNewChannelSuggestionTitle => 'नया चैनल सुझाव';

  @override
  String get feedPopularPostTitle => 'लोकप्रिय पोस्ट';

  @override
  String get feedNewCommentTitle => 'नई टिप्पणी';

  @override
  String get cardOfTheDayTitle => 'दिन का कार्ड';

  @override
  String get cardOfTheDayDrawing => 'आपका कार्ड निकाल रहा है...';

  @override
  String get cardOfTheDayGetButton => 'कार्ड निकालें';

  @override
  String get cardOfTheDayYourCard => 'आपका दिन का कार्ड';

  @override
  String get cardOfTheDayTapToReveal => 'प्रकट करने के लिए टैप करें';

  @override
  String get cardOfTheDayReversedSuffix => ' (उल्टा)';

  @override
  String get cardOfTheDayDefaultInterpretation => 'जानें कि दिन क्या लाएगा।';

  @override
  String get channelSearchTitle => 'प्रसारण खोजें';

  @override
  String get channelAnonymousAuthor => 'अज्ञात';

  @override
  String get errorUserNotAuthorized => 'उपयोगकर्ता अधिकृत नहीं है';

  @override
  String get errorUnknownServer => 'अज्ञात सर्वर त्रुटि';

  @override
  String get errorFailedToLoadData => 'डेटा लोड करने में विफल';

  @override
  String get generalHello => 'नमस्ते';

  @override
  String get referralErrorProfileNotLoaded =>
      'त्रुटि: आपकी प्रोफ़ाइल लोड नहीं हुई है। बाद में प्रयास करें।';

  @override
  String get referralErrorAlreadyUsed =>
      'आप पहले ही आमंत्रण कोड का उपयोग कर चुके हैं।';

  @override
  String get referralErrorOwnCode =>
      'आप अपना खुद का कोड इस्तेमाल नहीं कर सकते।';

  @override
  String get referralScreenTitle => 'मित्र को आमंत्रित करें';

  @override
  String get referralYourCodeTitle => 'आपका आमंत्रण कोड';

  @override
  String get referralYourCodeDescription =>
      'इस कोड को दोस्तों के साथ साझा करें। हर दोस्त जो आपका कोड दर्ज करेगा, उसके लिए आपको 1 दिन का प्रो-एक्सेस मिलेगा!';

  @override
  String get referralCodeCopied => 'कोड क्लिपबोर्ड पर कॉपी किया गया!';

  @override
  String get referralShareCodeButton => 'कोड साझा करें';

  @override
  String referralShareMessage(String code) {
    return 'नमस्ते! Aryonika में मेरे साथ जुड़ें और अपना ब्रह्मांडीय साथी खोजें। ऐप में मेरा आमंत्रण कोड दर्ज करें ताकि हम दोनों को बोनस मिले: $code';
  }

  @override
  String get referralManualBonusNote =>
      'आपके मित्र द्वारा कोड दर्ज करने के 24 घंटे के भीतर प्रो-एक्सेस मैन्युअल रूप से दिया जाता है।';

  @override
  String get referralGotCodeTitle => 'क्या आपके पास कोड है?';

  @override
  String get referralGotCodeDescription =>
      'अपने मित्र द्वारा दिया गया कोड दर्ज करें ताकि उसे उसका इनाम मिल सके।';

  @override
  String get referralCodeInputLabel => 'आमंत्रण कोड';

  @override
  String get referralCodeValidationError => 'कृपया कोड दर्ज करें';

  @override
  String get referralApplyCodeButton => 'कोड लागू करें';

  @override
  String get nav_feed => 'फ़ीड';

  @override
  String get nav_search => 'खोज';

  @override
  String get nav_oracle => 'ओरेकल';

  @override
  String get nav_chats => 'चैट';

  @override
  String get nav_channels => 'चैनल';

  @override
  String get nav_profile => 'प्रोफ़ाइल';

  @override
  String get nav_exit => 'बाहर निकलें';

  @override
  String get exitDialog_title => 'पुष्टिकरण';

  @override
  String get exitDialog_content => 'क्या आप वाकई Aryonika बंद करना चाहते हैं?';

  @override
  String get exitDialog_cancel => 'रद्द करें';

  @override
  String get exitDialog_confirm => 'बंद करें';

  @override
  String get oracle_limit_title => 'अनुरोध सीमा';

  @override
  String get oracle_limit_later => 'बाद में';

  @override
  String get oracle_limit_get_pro => 'असीमित प्राप्त करें';

  @override
  String get oracle_orb_partner => 'दिन का साथी';

  @override
  String get oracle_orb_roulette => 'रूले';

  @override
  String get oracle_orb_duet => 'युगल';

  @override
  String get oracle_orb_horoscope => 'राशिफल';

  @override
  String get oracle_orb_weather => 'भू-चुंबकीय';

  @override
  String get oracle_orb_ask => 'प्रश्न';

  @override
  String get oracle_orb_focus => 'दिन का फोकस';

  @override
  String get oracle_orb_forecast => 'खगोल पूर्वानुमान';

  @override
  String get oracle_orb_card => 'दिन का कार्ड';

  @override
  String get oracle_orb_tarot => 'ब्रह्मांड का उत्तर';

  @override
  String get oracle_orb_palmistry => 'हस्तरेखा';

  @override
  String get oracle_duet_title => 'लौकिक युगल';

  @override
  String get oracle_duet_description => 'जन्म तिथि से अनुकूलता की जाँच करें।';

  @override
  String get oracle_duet_button => 'अनुकूलता जाँचें';

  @override
  String oracle_unsupported_web_feature(String featureName, Object feature) {
    return 'WEB पर उपलब्ध नहीं।';
  }

  @override
  String get oracle_pro_card_of_day_title => 'दिन का कार्ड (PRO)';

  @override
  String get oracle_pro_card_of_day_desc =>
      'अपने दिन की ऊर्जा जानें। केवल PRO में।';

  @override
  String get oracle_pro_focus_of_day_title => 'दिन का फोकस (PRO)';

  @override
  String get oracle_pro_focus_of_day_desc =>
      'जानें कि आज किस पर ध्यान केंद्रित करना है। केवल PRO में।';

  @override
  String get oracle_pro_forecast_of_day_title => 'व्यक्तिगत पूर्वानुमान (PRO)';

  @override
  String get oracle_pro_forecast_of_day_desc =>
      'विस्तृत पारगमन विश्लेषण। केवल PRO में।';

  @override
  String get oracle_roulette_title => 'लौकिक रूले';

  @override
  String get oracle_roulette_description =>
      'अपनी किस्मत आज़माएं! एक साथी खोजें।';

  @override
  String get oracle_roulette_button => 'रूले घुमाएं';

  @override
  String get oracle_card_of_day_reversed => '(उल्टा)';

  @override
  String get oracle_card_of_day_get_key => 'व्यक्तिगत कुंजी जानें';

  @override
  String get oracle_palmistry_title => 'हस्तरेखा';

  @override
  String get oracle_palmistry_description =>
      'AI द्वारा हाथ की रेखाओं का विश्लेषण।';

  @override
  String get oracle_palmistry_button => 'हाथ स्कैन करें';

  @override
  String get oracle_ask_loading => 'ओरेकल सोच रहा है...';

  @override
  String get oracle_ask_again => 'फिर से पूछें';

  @override
  String get oracle_focus_loading => 'फोकस कर रहा है...';

  @override
  String get oracle_focus_error => 'लोड त्रुटि';

  @override
  String get oracle_focus_no_data => 'कोई डेटा नहीं';

  @override
  String get oracle_forecast_loading =>
      'आपका व्यक्तिगत पूर्वानुमान बना रहा हूँ...';

  @override
  String get oracle_forecast_error => 'पूर्वानुमान बनाने में विफल';

  @override
  String get oracle_forecast_try_again => 'पुनः प्रयास करें';

  @override
  String get oracle_forecast_title => 'दैनिक पूर्वानुमान';

  @override
  String get oracle_forecast_day_number => 'आपका दिन का अंक: ';

  @override
  String get oracle_tarot_title => 'टैरो रीडिंग (AI)';

  @override
  String get oracle_tarot_hint => 'आपका प्रश्न...';

  @override
  String get oracle_tarot_button => 'रीडिंग करें';

  @override
  String oracle_tarot_your_question(String question) {
    return 'आपका प्रश्न: $question';
  }

  @override
  String get oracle_tarot_loading => 'AI विश्लेषण कर रहा है...';

  @override
  String get oracle_tarot_ask_again => 'फिर से पूछें';

  @override
  String get oracle_tarot_card_reversed_short => ' (उल्टा)';

  @override
  String get oracle_tarot_combo_message => 'कार्डों का समग्र संदेश:';

  @override
  String get oracle_geomagnetic_title => 'अंतरिक्ष मौसम';

  @override
  String get oracle_geomagnetic_forecast => 'पूर्वानुमान';

  @override
  String get oracle_weather_title => 'भू-चुंबकीय गतिविधि';

  @override
  String get oracle_pro_feature_title => 'दिन का साथी (PRO)';

  @override
  String get oracle_pro_feature_desc =>
      'हम सही साथी ढूंढते हैं। PRO में उपलब्ध।';

  @override
  String get oracle_partner_loading => 'साथी खोज रहा है...';

  @override
  String get oracle_partner_error => 'खोज त्रुटि';

  @override
  String get oracle_partner_not_found => 'कोई साथी नहीं मिला';

  @override
  String get oracle_partner_profile_error => 'प्रोफ़ाइल त्रुटि';

  @override
  String get oracle_partner_title => 'आपका दिन का साथी';

  @override
  String oracle_partner_compatibility(String score) {
    return 'अनुकूलता: $score%';
  }

  @override
  String get oracle_ask_title => 'ओरेकल से प्रश्न';

  @override
  String get oracle_ask_hint => 'आपको क्या चिंतित करता है?...';

  @override
  String get oracle_ask_button => 'उत्तर प्राप्त करें';

  @override
  String get oracle_tips_loading => 'सुझाव लोड हो रहे हैं...';

  @override
  String get oracle_tips_title => 'आज के लिए स्टार टिप्स';

  @override
  String oracle_tips_subtitle(String count) {
    return 'संचार के लिए ($count)';
  }

  @override
  String get oracle_tips_general_advice => 'खुले और ईमानदार रहें।';

  @override
  String get cardOfTheDayProInApp =>
      '✨ व्यक्तिगत पहलू मोबाइल ऐप में उपलब्ध है।';

  @override
  String get numerology_report_title => 'अंकशास्त्र रिपोर्ट';

  @override
  String get numerology_report_overall => 'कुल स्कोर';

  @override
  String get numerology_report_you => 'आप';

  @override
  String get numerology_report_partner => 'साथी';

  @override
  String get userProfile_numerology_button => 'अंक ज्योतिष';

  @override
  String get forecast_astrological_title => 'ज्योतिषीय पूर्वानुमान';

  @override
  String get forecast_loading => 'पूर्वानुमान लोड हो रहा है...';

  @override
  String get forecast_error => 'लोड त्रुटि';

  @override
  String get forecast_no_aspects => 'कोई महत्वपूर्ण पहलू नहीं';

  @override
  String get cosmicEvents_title => 'ब्रह्मांडीय घटनाएँ';

  @override
  String get cosmicEvents_loading_error => 'घटनाओं को लोड करने में विफल';

  @override
  String get cosmicEvents_no_events => 'कोई आगामी घटना नहीं है';

  @override
  String get cosmicEvents_paywall_title => 'व्यक्तिगत ब्रह्मांडीय घटनाएँ';

  @override
  String get cosmicEvents_paywall_description =>
      'अपनी जन्म कुंडली पर ग्रहों के प्रभाव पर आधारित अद्वितीय सलाह तक पहुँच प्राप्त करें।';

  @override
  String get cosmicEvents_paywall_button => 'प्रो दर्जा प्राप्त करें';

  @override
  String get cosmicEvents_personal_focus => 'आपका व्यक्तिगत फ़ोकस:';

  @override
  String get cosmicEvents_pro_placeholder =>
      'प्रो-स्टेटस के साथ इस घटना का व्यक्तिगत प्रभाव जानें';

  @override
  String get search_no_one_found => 'आकाशगंगा के इस हिस्से में\nकोई नहीं मिला।';

  @override
  String get chat_error_user_not_found => 'त्रुटि: उपयोगकर्ता नहीं मिला';

  @override
  String get chat_start_with_hint => 'संकेत से शुरू करें';

  @override
  String get chat_date_format => 'd MMMM yyyy';

  @override
  String get chat_group_member => 'सदस्य';

  @override
  String get chat_group_members_2_4 => 'सदस्य';

  @override
  String get chat_group_members_5_0 => 'सदस्य';

  @override
  String get chat_online_status_long_ago => 'बहुत पहले ऑनलाइन थे';

  @override
  String get chat_online_status_online => 'ऑनलाइन हैं';

  @override
  String chat_online_status_minutes_ago(String minutes) {
    return '$minutes मिनट पहले ऑनलाइन थे';
  }

  @override
  String chat_online_status_today_at(String time) {
    return 'आज $time पर ऑनलाइन थे';
  }

  @override
  String chat_online_status_yesterday_at(String time) {
    return 'कल $time पर ऑनलाइन थे';
  }

  @override
  String chat_online_status_date(String date) {
    return '$date को ऑनलाइन थे';
  }

  @override
  String get chat_delete_dialog_title => 'चैट हटाएं?';

  @override
  String get chat_delete_dialog_content =>
      'यह चैट आपके और आपके वार्ताकार दोनों के लिए हटा दी जाएगी। यह कार्रवाई अपरिवर्तनीय है।';

  @override
  String get chat_delete_dialog_confirm => 'हटाएं';

  @override
  String chat_report_dialog_title(String name) {
    return '$name पर रिपोर्ट करें';
  }

  @override
  String get chat_report_details_hint => 'अतिरिक्त विवरण (वैकल्पिक)';

  @override
  String get chat_report_sent_snackbar => 'धन्यवाद! आपकी शिकायत भेज दी गई है।';

  @override
  String get chat_menu_report => 'रिपोर्ट करें';

  @override
  String get chat_menu_delete => 'चैट हटाएं';

  @override
  String get chat_group_title_default => 'समूह चैट';

  @override
  String get chat_group_participants => 'प्रतिभागी';

  @override
  String get chat_message_old => 'पिछले संस्करण का संदेश';

  @override
  String get chat_input_hint => 'संदेश...';

  @override
  String get chat_temp_warning_remaining =>
      'यह अस्थायी चैट... के बाद हटा दी जाएगी';

  @override
  String get chat_temp_warning_expired => 'चैट की समय सीमा समाप्त हो गई';

  @override
  String get chat_temp_warning_less_than_24h => '24 घंटे से कम';

  @override
  String get encrypted_chat_banner_title => 'बातचीत सुरक्षित है';

  @override
  String get encrypted_chat_banner_desc =>
      'इस चैट में संदेश एंड-टू-एंड एन्क्रिप्शन द्वारा सुरक्षित हैं। कोई भी, यहाँ तक कि Aryonika प्रशासन भी, उन्हें नहीं पढ़ सकता है।';

  @override
  String get search_hint => 'नाम, बायो द्वारा खोजें...';

  @override
  String get search_tooltip_swipes => 'स्वाइप';

  @override
  String get search_tooltip_cosmic_web => 'कॉस्मिक वेब';

  @override
  String get search_tooltip_star_map => 'स्टार मैप';

  @override
  String get search_tooltip_filters => 'फ़िल्टर';

  @override
  String get search_star_map_placeholder => 'स्टार मैप निर्माणाधीन है...';

  @override
  String get search_priority_header => 'शीर्ष मिलान';

  @override
  String get search_other_header => 'अन्य उपयोगकर्ता';

  @override
  String get payment_title => 'परियोजना का समर्थन करें';

  @override
  String get payment_success_snackbar =>
      'आपके समर्थन के लिए धन्यवाद! आपकी स्थिति अपडेट हो रही है...';

  @override
  String get payment_fail_snackbar =>
      'दान संसाधित करने में विफल। कृपया पुनः प्रयास करें।';

  @override
  String get paywall_header_title => 'Aryonika ब्रह्मांड को अनलॉक करें';

  @override
  String get paywall_header_subtitle =>
      'परियोजना का समर्थन करें और धन्यवाद के रूप में अपना आदर्श साथी खोजने के लिए सभी ब्रह्मांडीय उपकरण प्राप्त करें।';

  @override
  String get paywall_benefit1_title => 'देखें कि आपको किसने पसंद किया';

  @override
  String get paywall_benefit1_subtitle =>
      'पारस्परिक अवसर न चूकें और पहले बातचीत शुरू करें।';

  @override
  String get paywall_benefit2_title => 'दैनिक व्यक्तिगत पूर्वानुमान';

  @override
  String get paywall_benefit2_subtitle =>
      'आपके गोचर और दिन के फोकस का दैनिक विश्लेषण।';

  @override
  String get paywall_benefit3_title => 'दिन का साथी और रूले';

  @override
  String get paywall_benefit3_subtitle =>
      'सितारों को आपके लिए सबसे संगत साथी चुनने दें।';

  @override
  String get paywall_benefit4_title => 'ब्रह्मांड का उत्तर';

  @override
  String get paywall_benefit4_subtitle =>
      'अपना प्रश्न पूछें और ब्रह्मांडीय सलाह प्राप्त करें।';

  @override
  String get paywall_benefit5_title => 'ब्रह्मांडीय मौसम';

  @override
  String get paywall_benefit5_subtitle =>
      'भू-चुंबकीय तूफानों और उनके प्रभाव के बारे में सूचित रहें।';

  @override
  String get paywall_benefit6_title => 'दिन का कार्ड';

  @override
  String get paywall_benefit6_subtitle =>
      'भाग्य के कार्ड से दैनिक भविष्यवाणी और सलाह प्राप्त करें।';

  @override
  String get paywall_donate_button => 'परियोजना का समर्थन करें';

  @override
  String get paywall_referral_button => 'दोस्तों के लिए PRO प्राप्त करें';

  @override
  String get paywall_referral_subtitle =>
      'एक दोस्त को आमंत्रित करें और आपके लिंक से पंजीकरण करने वाले प्रत्येक व्यक्ति के लिए 1 दिन का PRO स्टेटस प्राप्त करें।';

  @override
  String paywall_get_pro_button(String price) {
    return 'Aryonika PRO प्राप्त करें ($price)';
  }

  @override
  String get paywall_arbitrary_donate_button => 'किसी अन्य राशि से समर्थन करें';

  @override
  String get paywall_arbitrary_donate_subtitle =>
      'यदि आपको हमारी परियोजना पसंद है, तो आप इसका समर्थन कर सकते हैं ताकि हम शार्क और अन्य शिकारियों की दुनिया में जीवित रह सकें।';

  @override
  String get chinese_zodiac_title => 'चीनी राशि चक्र';

  @override
  String get zodiac_Rat => 'चूहा';

  @override
  String get zodiac_Ox => 'बैल';

  @override
  String get zodiac_Tiger => 'बाघ';

  @override
  String get zodiac_Rabbit => 'खरगोश';

  @override
  String get zodiac_Dragon => 'ड्रैगन';

  @override
  String get zodiac_Snake => 'सांप';

  @override
  String get zodiac_Horse => 'घोड़ा';

  @override
  String get zodiac_Goat => 'बकरी';

  @override
  String get zodiac_Monkey => 'बंदर';

  @override
  String get zodiac_Rooster => 'मुर्गा';

  @override
  String get zodiac_Dog => 'कुत्ता';

  @override
  String get zodiac_Pig => 'सुअर';

  @override
  String get chinese_zodiac_compatibility_button => 'राशि चक्र संगतता';

  @override
  String get compatibility_section_title => 'संगतता';

  @override
  String get userProfile_astro_button => 'ज्योतिष';

  @override
  String get userProfile_bazi_button => 'बाज़ी';

  @override
  String get jyotishCompatibilityTitle => 'वैदिक संगतता';

  @override
  String get jyotishDetailedAnalysisTitle => 'विस्तृत विश्लेषण (अष्ट-कूट)';

  @override
  String get kuta_tara_name => 'तारा कूट (भाग्य)';

  @override
  String get kuta_tara_desc =>
      'रिश्ते में भाग्य, अवधि और भलाई को इंगित करता है। यहाँ अच्छी संगतता आपके मिलन के लिए एक अनुकूल हवा की तरह है।';

  @override
  String get kuta_yoni_name => 'योनि कूट (आकर्षण)';

  @override
  String get kuta_yoni_desc =>
      'शारीरिक और यौन सामंजस्य निर्धारित करता है। एक उच्च अंक मजबूत आपसी आकर्षण और संतुष्टि को इंगित करता है।';

  @override
  String get kuta_graha_maitri_name => 'ग्रह मैत्री (मित्रता)';

  @override
  String get kuta_graha_maitri_desc =>
      'मनोवैज्ञानिक संगतता और मित्रता। यह दर्शाता है कि जीवन के प्रति आपके विचार कितने समान हैं और आपके लिए सामान्य आधार खोजना कितना आसान है।';

  @override
  String get kuta_vashya_name => 'वश्य कूट (आपसी नियंत्रण)';

  @override
  String get kuta_vashya_desc =>
      'जोड़े में आपसी प्रभाव और चुंबकत्व की डिग्री दिखाता है। कौन नेता होगा और कौन अनुयायी।';

  @override
  String get kuta_gana_name => 'गण कूट (स्वभाव)';

  @override
  String get kuta_gana_desc =>
      'स्वभाव के स्तर पर संगतता (दिव्य, मानवीय, राक्षसी)। चरित्र संघर्षों से बचने में मदद करता है।';

  @override
  String get kuta_bhakoot_name => 'भकूट कूट (प्रेम और परिवार)';

  @override
  String get kuta_bhakoot_desc =>
      'सबसे महत्वपूर्ण संकेतकों में से एक। प्रेम की गहराई, पारिवारिक सुख, वित्तीय समृद्धि और बच्चे होने की संभावना के लिए जिम्मेदार।';

  @override
  String get kuta_nadi_name => 'नाड़ी कूट (स्वास्थ्य)';

  @override
  String get kuta_nadi_desc =>
      'सबसे भारी मानदंड। भागीदारों और उनकी संतानों के स्वास्थ्य, आनुवंशिक संगतता और दीर्घायु के लिए जिम्मेदार।';

  @override
  String get kuta_varna_name => 'वर्ण कूट (अध्यात्म)';

  @override
  String get kuta_varna_desc =>
      'अहंकार संगतता और भागीदारों के आध्यात्मिक विकास को दर्शाता है। दिखाता है कि जोड़ी में कौन दूसरे के विकास को अधिक प्रोत्साहित करेगा।';

  @override
  String get jyotishVerdictExcellent =>
      'दिव्य मिलन! आपकी चंद्र राशियाँ पूर्ण सामंजस्य में हैं। यह संबंध आने वाले वर्षों के लिए गहरी समझ, आध्यात्मिक विकास और खुशी का वादा करता है।';

  @override
  String get jyotishVerdictGood =>
      'बहुत अच्छी संगतता। आपके पास एक मजबूत, सामंजस्यपूर्ण और खुशहाल रिश्ता बनाने का हर मौका है। छोटी असहमति आसानी से दूर हो जाती है।';

  @override
  String get jyotishVerdictAverage =>
      'सामान्य संगतता। आपके रिश्ते में ताकत और विकास के क्षेत्र दोनों हैं। संघ की सफलता रिश्ते पर काम करने की आपकी इच्छा पर निर्भर करेगी।';

  @override
  String get jyotishVerdictChallenging =>
      'चुनौतीपूर्ण संगतता। आपकी कुंडली चरित्र और जीवन पथ में गंभीर अंतर का संकेत देती है। सामंजस्य प्राप्त करने के लिए बहुत धैर्य और समझौते की आवश्यकता होगी।';

  @override
  String get passwordResetNewPasswordTitle => 'नया पासवर्ड सेट करें';

  @override
  String get passwordResetNewPasswordLabel => 'नया पासवर्ड';

  @override
  String get passwordResetConfirmLabel => 'पासवर्ड की पुष्टि करें';

  @override
  String get passwordValidationError =>
      'पासवर्ड कम से कम 6 अक्षरों का होना चाहिए';

  @override
  String get passwordMismatchError => 'पासवर्ड मेल नहीं खाते';

  @override
  String get saveButton => 'सहेजें';

  @override
  String get postActionLike => 'पसंद करें';

  @override
  String get postActionComment => 'टिप्पणी करें';

  @override
  String get postActionShare => 'साझा करें';

  @override
  String get channelDefaultName => 'चैनल';

  @override
  String postShareText(Object channelName, Object postText) {
    return '\"$channelName\" चैनल में इस पोस्ट को देखें: $postText';
  }

  @override
  String get postDeleteDialogTitle => 'पोस्ट हटाएं?';

  @override
  String get postDeleteDialogContent => 'यह कार्रवाई पूर्ववत नहीं की जा सकती।';

  @override
  String get delete => 'हटाएं';

  @override
  String get postMenuDelete => 'पोस्ट हटाएं';

  @override
  String get numerologySectionKeyNumbers => 'मुख्य संख्याएँ';

  @override
  String get numerologySectionCurrentVibes => 'वर्तमान कंपन';

  @override
  String get numerologyTitleLifePath => 'जीवन पथ संख्या';

  @override
  String get numerologyTitleDestiny => 'भाग्य संख्या (अभिव्यक्ति संख्या)';

  @override
  String get numerologyTitleSoulUrge => 'आत्मिक इच्छा संख्या';

  @override
  String get numerologyTitlePersonality => 'व्यक्तित्व संख्या';

  @override
  String get numerologyTitleMaturity => 'परिपक्वता संख्या';

  @override
  String get numerologyTitleBirthday => 'जन्मदिन संख्या';

  @override
  String get numerologyTitlePersonalYear => 'व्यक्तिगत वर्ष';

  @override
  String get numerologyTitlePersonalMonth => 'व्यक्तिगत महीना';

  @override
  String get numerologyTitlePersonalDay => 'व्यक्तिगत दिन';

  @override
  String get numerologyErrorNotEnoughData => 'गणना के लिए अपर्याप्त डेटा।';

  @override
  String get numerologyErrorDescriptionsNotLoaded =>
      'अंक ज्योतिष विवरण लोड करने में विफल।';

  @override
  String get chat_error_recipient_not_found => 'प्राप्तकर्ता नहीं मिला।';

  @override
  String get chat_error_recipient_profile_load_failed =>
      'प्राप्तकर्ता प्रोफ़ाइल लोड करने में विफल।';

  @override
  String get calculatingNumerology => 'अंकशास्त्रीय चित्र की गणना हो रही है...';

  @override
  String get oracle_title => 'ओरेकल';

  @override
  String get verifyEmailBody =>
      'हमने आपके ईमेल पर 6-अंकीय कोड भेजा है। कृपया इसे नीचे दर्ज करें।';

  @override
  String get verifyEmailHint => '------';

  @override
  String get signOutButton => 'लॉग आउट करें';

  @override
  String get errorInvalidOrExpiredCode => 'अमान्य या समाप्त कोड।';

  @override
  String get errorCodeRequired => 'कृपया सत्यापन कोड दर्ज करें।';

  @override
  String get errorInternalServer =>
      'एक आंतरिक सर्वर त्रुटि हुई। कृपया बाद में पुनः प्रयास करें।';

  @override
  String get errorCodeLength => 'कोड 6 अंकों का होना चाहिए।';

  @override
  String get verifyEmailTitle => 'ई-मेल सत्यापन';

  @override
  String get verificationCodeLabel => 'सत्यापन कोड';

  @override
  String get verificationCodeResent => 'एक नया सत्यापन कोड भेजा गया है!';

  @override
  String get resendCodeAction => 'कोड पुनः भेजें';

  @override
  String resendCodeCooldown(int seconds) {
    return 'पुनः भेजें ($seconds) सेकंड में';
  }

  @override
  String verifyEmailInstruction(String email) {
    return 'हमने आपके ई-मेल पर 6-अंकीय कोड भेजा है:\n$email\nकृपया इसे नीचे दर्ज करें।';
  }

  @override
  String get confirmButton => 'पुष्टि करें';

  @override
  String get logout => 'लॉग आउट';

  @override
  String get numerology_score_high => 'उच्च';

  @override
  String get numerology_score_medium => 'मध्यम';

  @override
  String get numerology_score_low => 'कम';

  @override
  String get noUsersFound => 'कोई उपयोगकर्ता नहीं मिला';

  @override
  String get feature_in_development => 'जल्द ही उपलब्ध होगा!';

  @override
  String get download_our_app => 'हमारा ऐप डाउनलोड करें';

  @override
  String get open_web_version => 'WEB संस्करण खोलें';

  @override
  String get pay_with_card => 'कार्ड से भुगतान करें';

  @override
  String get coming_soon => 'जल्द ही';

  @override
  String get paywall_subscription_terms =>
      'सदस्यता स्वचालित रूप से नवीनीकृत होती है। कभी भी रद्द करें।';

  @override
  String get searchHint => 'Поиск...';

  @override
  String get nav_friends => 'मित्र';

  @override
  String get oracle_typing => 'टाइप कर रहा है...';

  @override
  String get tarot_reversed => '(उल्टा)';

  @override
  String get common_close => 'बंद करें';

  @override
  String oracle_limit_pro(Object hours) {
    return '$hours घंटे शेष।';
  }

  @override
  String oracle_limit_free(Object days) {
    return 'निःशुल्क सीमा समाप्त। $days दिन शेष।';
  }

  @override
  String get oracle_error_stream => 'कनेक्शन त्रुटि';

  @override
  String get oracle_error_start => 'शुरू करने में विफल';

  @override
  String get error_generic => 'एक त्रुटि हुई। कृपया बाद में पुनः प्रयास करें।';

  @override
  String get referral_already_used =>
      'आपने पहले ही एक रेफरल कोड का उपयोग कर लिया है।';

  @override
  String get referral_own_code => 'आप अपना स्वयं का कोड उपयोग नहीं कर सकते।';

  @override
  String get referral_success =>
      'कोड सफलतापूर्वक सक्रिय हो गया! आपको 3 दिन का प्रीमियम मिला है।';

  @override
  String get tab_astrology => 'ज्योतिष';

  @override
  String get tab_numerology => 'अंकज्योतिष';

  @override
  String get tab_bazi => 'बाज़ी';

  @override
  String get tab_jyotish => 'वैदिक';

  @override
  String get share_result => 'परिणाम साझा करें';

  @override
  String get share_preparing => 'तैयारी...';

  @override
  String locked_feature_title(Object title) {
    return '$title अनुभाग लॉक है';
  }

  @override
  String get locked_feature_desc =>
      'यह अनुभाग केवल प्रीमियम संस्करण में उपलब्ध है।';

  @override
  String get get_access_button => 'पहुँच प्राप्त करें';

  @override
  String get coming_soon_suffix => 'जल्द आ रहा है';

  @override
  String get tab_summary => 'Сводка';

  @override
  String get tab_chinese_zodiac => 'Кит. Зодиак';

  @override
  String get summary_verdict_title => 'Общий вердикт';

  @override
  String get webVersionButton => 'वेब संस्करण';

  @override
  String get uploadPhotoDisclaimer =>
      'फ़ोटो अपलोड करके, आप पुष्टि करते हैं कि इसमें नग्नता या हिंसा नहीं है। उल्लंघन करने वालों को स्थायी रूप से प्रतिबंधित कर दिया जाएगा।';

  @override
  String get iAgree => 'मैं सहमत हूँ';

  @override
  String get testers_banner_title => 'टेस्टर्स की आवश्यकता (4/20)';

  @override
  String get testers_banner_desc =>
      'Aryonika को बेहतर बनाने में मदद करें और पाएं\n✨ लाइफटाइम प्रीमियम ✨';

  @override
  String get testers_email_hint =>
      '(खोलने के लिए टैप करें, कॉपी करने के लिए दबाकर रखें)';

  @override
  String get numerology_day_1 => 'नई शुरुआत का दिन।';

  @override
  String get numerology_day_2 => 'साझेदारी का दिन। समझौता करें।';

  @override
  String get numerology_day_3 => 'रचनात्मकता का दिन। खुद को व्यक्त करें।';

  @override
  String get numerology_day_4 => 'काम का दिन। अपने मामलों को व्यवस्थित करें।';

  @override
  String get numerology_day_5 => 'परिवर्तन का दिन। नई चीजों के लिए खुले रहें।';

  @override
  String get numerology_day_6 => 'सद्भाव का दिन। परिवार को समय दें।';

  @override
  String get numerology_day_7 => 'चिंतन का दिन। एकांत का समय।';

  @override
  String get numerology_day_8 => 'शक्ति का दिन। करियर पर ध्यान दें।';

  @override
  String get numerology_day_9 => 'पूर्णता का दिन। पुरानी बातों को जाने दें।';

  @override
  String get astro_transit_positive_general =>
      'Звезды на вашей стороне. Действуйте смело.';

  @override
  String get advice_general_balance =>
      'Сохраняйте баланс между чувствами и разумом.';

  @override
  String get astro_advice_listen_intuition => 'अपनी अंतरात्मा की आवाज सुनें।';

  @override
  String get astro_advice_act_boldly => 'ऊर्जा साहसिक कार्यों के पक्ष में है।';

  @override
  String get astro_advice_rest_and_reflect =>
      'सितारे आराम करने की सलाह देते हैं।';

  @override
  String get astro_advice_connect_with_nature => 'प्रकृति में समय बिताएं।';

  @override
  String get advice_generic_positive => 'ब्रह्मांड आज आपके पक्ष में है।';

  @override
  String get channelLoadError => 'चैनल लोड करने में विफल';

  @override
  String get postsTitle => 'पोस्ट';

  @override
  String get noPostsYet => 'इस चैनल में अभी तक कोई पोस्ट नहीं है।';

  @override
  String get createPostTooltip => 'पोस्ट बनाएं';

  @override
  String get proposePost => 'समाचार प्रस्तावित करें';

  @override
  String get channelsTitle => 'चैनल';

  @override
  String get noChannelSubscriptions => 'अभी तक कोई सदस्यता नहीं';

  @override
  String get noMessagesYet => 'अभी तक कोई संदेश नहीं';

  @override
  String get yesterday => 'कल';

  @override
  String get search => 'खोज';

  @override
  String get adminOnlyFeature =>
      'चैनल बनाना अस्थायी रूप से केवल प्रशासकों के लिए उपलब्ध है।';

  @override
  String get createChannel => 'चैनल बनाएं';

  @override
  String get galacticBroadcasts => 'गैलेक्टिक प्रसारण';

  @override
  String get noChannelsYet =>
      'आपने अभी तक किसी चीज़ की सदस्यता नहीं ली है।\nअपना चैनल खोजें या बनाएं!';

  @override
  String get constellationsTitle => 'नक्षत्र';

  @override
  String get privateChatsTab => 'निजी';

  @override
  String get channelsTab => 'चैनल';

  @override
  String get loadingUser => 'उपयोगकर्ता लोड हो रहा है...';

  @override
  String get emptyChatsPlaceholder =>
      'आपकी निजी चैट यहाँ दिखाई देंगी।\nखोज के माध्यम से किसी दिलचस्प व्यक्ति को खोजें!';

  @override
  String get errorTitle => 'त्रुटि';

  @override
  String get autoDeleteMessages => 'संदेशों को स्वतः हटाएं';

  @override
  String get availableInPro => 'PRO में उपलब्ध';

  @override
  String get timerOff => 'बंद';

  @override
  String get timer15min => '15 मिनट';

  @override
  String get timer1hour => '1 घंटा';

  @override
  String get timer4hours => '4 घंटे';

  @override
  String get timer24hours => '24 घंटे';

  @override
  String get timerSet => 'टाइमर सेट';

  @override
  String get disappearingMessages => 'गायब होने वाले संदेश';

  @override
  String get communicationTitle => 'संचार';

  @override
  String get errorLoadingReport => 'रिपोर्ट लोड करने में त्रुटि';

  @override
  String get compatibility => 'अनुकूलता';

  @override
  String get strengths => 'ताकत';

  @override
  String get weaknesses => 'संभावित कठिनाइयाँ';

  @override
  String get commentsTitle => 'टिप्पणियाँ';

  @override
  String get commentsLoadError => 'टिप्पणियाँ लोड करने में त्रुटि।';

  @override
  String get noCommentsYet => 'अभी तक कोई टिप्पणी नहीं।';

  @override
  String userIsTyping(Object name) {
    return '$name टाइप कर रहे हैं...';
  }

  @override
  String twoUsersTyping(Object name1, Object name2) {
    return '$name1 और $name2 टाइप कर रहे हैं...';
  }

  @override
  String manyUsersTyping(Object count, Object name1, Object name2) {
    return '$name1, $name2 और $count अन्य टाइप कर रहे हैं...';
  }

  @override
  String replyingTo(Object name) {
    return '$name को उत्तर दे रहे हैं';
  }

  @override
  String get writeCommentHint => 'एक टिप्पणी लिखें...';

  @override
  String get compatibilityTitle => 'लौकिक संबंध';

  @override
  String get noData => 'कोई डेटा नहीं';

  @override
  String get westernAstrology => 'पश्चिमी ज्योतिष';

  @override
  String get vedicAstrology => 'वैदिक ज्योतिष (ज्योतिष)';

  @override
  String get numerology => 'अंक ज्योतिष';

  @override
  String get chineseZodiac => 'चीनी राशि';

  @override
  String get baziElements => 'बा जी (तत्व)';

  @override
  String get availableInPremium => 'प्रीमियम में उपलब्ध';

  @override
  String get verdictSoulmates => 'आत्मीय साथी';

  @override
  String get verdictGreatMatch => 'शानदार मेल';

  @override
  String get verdictPotential => 'संभावना है';

  @override
  String get verdictKarmic => 'कर्म पाठ';

  @override
  String get createChannelTitle => 'प्रसारण बनाएं';

  @override
  String get channelNameLabel => 'प्रसारण का नाम';

  @override
  String get channelNameHint => 'जैसे, \'दैनिक टैरो पूर्वानुमान\'';

  @override
  String get errorChannelNameEmpty => 'नाम खाली नहीं हो सकता';

  @override
  String get channelHandleLabel => 'अद्वितीय आईडी (@handle)';

  @override
  String get errorChannelHandleShort => 'आईडी 4 अक्षरों से लंबी होनी चाहिए';

  @override
  String get channelDescriptionLabel => 'विवरण';

  @override
  String get channelDescriptionHint =>
      'हमें बताएं कि आपका चैनल किस बारे में है...';

  @override
  String get errorChannelDescriptionEmpty => 'कृपया विवरण जोड़ें';

  @override
  String get createButton => 'बनाएं';

  @override
  String get editProfileTitle => 'प्रोफ़ाइल संपादित करें';

  @override
  String get profileNotFoundError => 'त्रुटि: प्रोफ़ाइल नहीं मिली';

  @override
  String get profileSavedSuccess => 'प्रोफ़ाइल सफलतापूर्वक सहेजी गई!';

  @override
  String get saveError => 'सहेजने में त्रुटि';

  @override
  String get avatarUploadError => 'फ़ोटो अपलोड त्रुटि';

  @override
  String get nameLabel => 'नाम';

  @override
  String get bioLabel => 'मेरे बारे में';

  @override
  String get birthDataTitle => 'जन्म डेटा';

  @override
  String get birthDataWarning =>
      'इस डेटा को बदलने से आपके ज्योतिषीय और अंक ज्योतिषीय पोर्ट्रेट की पूरी तरह से पुनर्गणना होगी।';

  @override
  String get birthDateLabel => 'जन्म तिथि';

  @override
  String get birthPlaceLabel => 'जन्म स्थान';

  @override
  String get errorUserNotFound => 'त्रुटि: उपयोगकर्ता नहीं मिला';

  @override
  String get feedUpdateError => 'फ़ीड अपडेट त्रुटि';

  @override
  String get feedEmptyMessage =>
      'आपका फ़ीड खाली है।\nताज़ा करने के लिए नीचे खींचें।';

  @override
  String get whereToSearch => 'कहाँ खोजें';

  @override
  String get searchNearby => 'आस-पास';

  @override
  String get searchCity => 'शहर';

  @override
  String get searchCountry => 'देश';

  @override
  String get searchWorld => 'दुनिया';

  @override
  String get ageLabel => 'आयु';

  @override
  String get showGenderLabel => 'दिखाएं';

  @override
  String get genderAll => 'सभी';

  @override
  String get zodiacFilterLabel => 'राशि तत्व';

  @override
  String get resetFilters => 'रीसेट करें';

  @override
  String get applyFilters => 'लागू करें';

  @override
  String get forecastLoadError =>
      'पूर्वानुमान लोड करने में विफल।\nकृपया बाद में पुनः प्रयास करें।';

  @override
  String get noForecastEvents =>
      'आज कोई महत्वपूर्ण ज्योतिषीय घटना नहीं है।\nएक शांत दिन!';

  @override
  String get unlockFullForecast => 'पूरा पूर्वानुमान अनलॉक करें';

  @override
  String get myFriendsTab => 'मेरे मित्र';

  @override
  String get friendRequestsTab => 'अनुरोध';

  @override
  String get noFriendsYet =>
      'अभी आपका कोई मित्र नहीं है। उन्हें खोज में खोजें!';

  @override
  String get noFriendRequests => 'कोई नया अनुरोध नहीं।';

  @override
  String get removeFriend => 'मित्र को हटाएं';

  @override
  String get gamesComingSoonTitle => 'गेम और पुरस्कार जल्द आ रहे हैं!';

  @override
  String get gamesComingSoonDesc =>
      'हम रोमांचक मिनी-गेम और क्विज़ तैयार कर रहे हैं। अपनी अनुकूलता जांचें, \"स्टारडस्ट\" कमाएं और इसे प्रीमियम दिनों या अद्वितीय उपहारों के लिए एक्सचेंज करें!';

  @override
  String get joinTelegramButton => 'हमारे टेलीग्राम पर सबसे पहले जानें';

  @override
  String horoscopeForSign(Object sign) {
    return '$sign के लिए राशिफल';
  }

  @override
  String get horoscopeGeneral => 'सामान्य';

  @override
  String get horoscopeLove => 'प्रेम';

  @override
  String get horoscopeBusiness => 'व्यवसाय';

  @override
  String get verdictNotFound => 'निर्णय नहीं मिला';

  @override
  String get vedicCompatibilityTitle => 'वैदिक अनुकूलता';

  @override
  String get ashtaKutaAnalysis => 'विस्तृत विश्लेषण (अष्टकूट)';

  @override
  String get noDescription => 'विवरण नहीं मिला।';

  @override
  String get likesYouEmpty => 'आप में रुचि रखने वाले लोग यहाँ दिखाई देंगे';

  @override
  String peopleLikeYou(Object count) {
    return '$count लोग आपको पसंद करते हैं!';
  }

  @override
  String get getProToSeeLikes =>
      'उनकी प्रोफ़ाइल देखने और चैट शुरू करने के लिए PRO प्राप्त करें।';

  @override
  String get seeLikesButton => 'लाइक्स देखें';

  @override
  String get someone => 'कोई';

  @override
  String get selectCityTitle => 'शहर चुनें';

  @override
  String get searchCityHint => 'शहर का नाम दर्ज करें...';

  @override
  String get nothingFound => 'कुछ नहीं मिला';

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
  String get moderationProposedPosts => 'प्रस्तावित पोस्ट';

  @override
  String get noProposedPosts => 'कोई प्रस्तावित पोस्ट नहीं।';

  @override
  String get from => 'द्वारा';

  @override
  String get personalNumerologyTitle => 'व्यक्तिगत अंक ज्योतिष';

  @override
  String get dataNotLoaded => 'डेटा लोड नहीं हुआ';

  @override
  String get loading => 'लोड हो रहा है...';

  @override
  String get lifePathNumber => 'जीवन पथ संख्या';

  @override
  String get corePersonality => 'मूल व्यक्तित्व';

  @override
  String get destinyNumber => 'भाग्य संख्या';

  @override
  String get soulNumber => 'आत्मा संख्या';

  @override
  String get personalityNumber => 'व्यक्तित्व संख्या';

  @override
  String get timeInfluence => 'समय का प्रभाव';

  @override
  String get maturityNumber => 'परिपक्वता संख्या';

  @override
  String get birthdayNumber => 'जन्मदिन संख्या';

  @override
  String get currentVibrationsPro => 'वर्तमान कंपन (PRO)';

  @override
  String get personalYear => 'व्यक्तिगत वर्ष';

  @override
  String get personalMonth => 'व्यक्तिगत महीना';

  @override
  String get personalDay => 'व्यक्तिगत दिन';

  @override
  String get proVibrationsDesc =>
      'वर्ष, महीने और दिन के लिए अपने कंपन की खोज करें। केवल प्रीमियम में उपलब्ध है।';

  @override
  String get unlockButton => 'अनलॉक करें';

  @override
  String get tapForDetails => 'विवरण के लिए टैप करें';

  @override
  String oracle_weather_desc(Object desc, Object kp) {
    return '$desc (Kp: $kp)';
  }

  @override
  String oracle_geomagnetic_now(Object desc) {
    return 'अभी: $desc';
  }

  @override
  String oracle_geomagnetic_index(Object kp) {
    return 'Kp सूचकांक: $kp';
  }

  @override
  String get oracle_question_title => 'ओरेकल से पूछें';

  @override
  String get oracle_question_hint => 'आपको क्या चिंता है?...';

  @override
  String get oracle_question_button => 'उत्तर प्राप्त करें';

  @override
  String get palmistry_analysis_title => 'हस्तरेखा विश्लेषण';

  @override
  String get palmistry_choose_option => 'सबसे उपयुक्त विकल्प चुनें:';

  @override
  String get palmistry_analysis_saved => 'विश्लेषण सहेजा गया!';

  @override
  String get palmistry_view_report => 'पूर्ण रिपोर्ट देखें';

  @override
  String get palmistry_complete_all => 'सभी रेखाओं का विश्लेषण पूरा करें';

  @override
  String get palmistry_analysis_complete => 'बहुत बढ़िया! विश्लेषण पूरा हुआ।';

  @override
  String palmistry_tap_line(Object lineName) {
    return 'अपनी हथेली से तुलना करने के लिए \'$lineName\' पर टैप करें।';
  }

  @override
  String palmistry_searching_line(Object lineName) {
    return '\'$lineName\' खोज रहा है...';
  }

  @override
  String get palmistry_preparing => 'विश्लेषण की तैयारी...';

  @override
  String get palmistry_report_title => 'आपकी नियति का मानचित्र';

  @override
  String get palmistry_data_not_found => 'विश्लेषण डेटा नहीं मिला।';

  @override
  String get palmistry_strong_traits => 'आपकी ताकत';

  @override
  String get privacy => 'गोपनीयता';

  @override
  String get palmistry_show_in_profile => 'प्रोफ़ाइल में मेरे लक्षण दिखाएं';

  @override
  String get palmistry_show_in_profile_desc =>
      'यह दूसरों को आपको बेहतर जानने में मदद करेगा और अनुकूलता मिलान में सुधार करेगा।';

  @override
  String get palmistry_interpretation => 'रेखा व्याख्या';

  @override
  String palmistry_your_choice(Object choice) {
    return 'आपकी पसंद: \"$choice\"';
  }

  @override
  String get photoAlbumComingSoon =>
      'जल्द ही आप अपनी तस्वीरें यहाँ अपलोड कर सकेंगे।';

  @override
  String get settingsTitle => 'सेटिंग्स';

  @override
  String get accountManagement => 'खाता प्रबंधन';

  @override
  String get changePassword => 'पासवर्ड बदलें';

  @override
  String get restorePassword => 'पासवर्ड रीसेट करें';

  @override
  String get editProfileButton => 'प्रोफ़ाइल संपादित करें';

  @override
  String get dailyNotifications => 'दैनिक सूचनाएं';

  @override
  String get alertsTitle => 'अलर्ट';

  @override
  String get geomagneticStorms => 'भू-चुंबकीय तूफान';

  @override
  String get adminPanelTitle => 'एडमिन पैनल';

  @override
  String get adminManageUsers => 'उपयोगकर्ताओं को प्रबंधित करें';

  @override
  String get offerAgreementLink => 'ऑफर समझौता';

  @override
  String get accountSectionTitle => 'खाता';

  @override
  String get deleteAccountButton => 'खाता हटाएं';

  @override
  String get closeAppButton => 'ऐप बंद करें';

  @override
  String get changePasswordDesc =>
      'सुरक्षा के लिए अपना वर्तमान पासवर्ड दर्ज करें।';

  @override
  String get currentPasswordLabel => 'वर्तमान पासवर्ड';

  @override
  String get newPasswordLabel => 'नया पासवर्ड';

  @override
  String get passwordChangedSuccess => 'पासवर्ड सफलतापूर्वक बदला गया!';

  @override
  String resetPasswordInstruction(String email) {
    return 'हम आपके ई-मेल पर रीसेट निर्देश भेजेंगे:\n\n$email';
  }

  @override
  String get signOutDialogTitle => 'लॉग आउट';

  @override
  String get signOutDialogContent => 'क्या आप वाकई लॉग आउट करना चाहते हैं?';

  @override
  String get deleteAccountTitle => 'खाता हटाएं?';

  @override
  String get deleteAccountWarning =>
      'यह क्रिया अपरिवर्तनीय है। आपका सारा डेटा, चैट, फोटो और खरीदारी स्थायी रूप से हटा दी जाएगी।';

  @override
  String get deleteForeverButton => 'हमेशा के लिए हटाएं';

  @override
  String get roulette_trust_fate => 'किस्मत पर भरोसा करें';

  @override
  String get roulette_desc_short =>
      'सितारे आपके लिए सबसे अनुकूल साथी चुनेंगे (85% से!)।';

  @override
  String get roulette_no_candidates => 'घुमाने के लिए कोई उम्मीदवार नहीं।';

  @override
  String get roulette_winner_title => 'सितारों ने अपना चुनाव कर लिया है!';

  @override
  String get roulette_spin_again => 'फिर से घुमाएं';

  @override
  String get roulette_go_to_profile => 'प्रोफ़ाइल पर जाएं';

  @override
  String get cityNotSpecified => 'शहर निर्दिष्ट नहीं';

  @override
  String get geomagnetic_calm => 'शांत';

  @override
  String get geomagnetic_unsettled => 'अस्थिर';

  @override
  String get geomagnetic_active => 'सक्रिय';

  @override
  String get geomagnetic_storm_minor => 'मामूली तूफान (G1)';

  @override
  String get geomagnetic_storm_moderate => 'मध्यम तूफान (G2)';

  @override
  String get geomagnetic_storm_strong => 'मजबूत तूफान (G3)';

  @override
  String get geomagnetic_storm_severe => 'गंभीर तूफान (G4)';

  @override
  String get geomagnetic_storm_extreme => 'चरम तूफान (G5)';

  @override
  String get deleteChatTitle => 'चैट हटाएं?';

  @override
  String get deleteChatConfirmation =>
      'सभी संदेश स्थायी रूप से हटा दिए जाएंगे।';

  @override
  String get chatDeleted => 'चैट हटा दी गई';
}
