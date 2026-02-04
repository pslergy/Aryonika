// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get profileCreationErrorTitle => '프로필 생성 오류';

  @override
  String get profileCreationErrorDescription =>
      '죄송합니다, 데이터를 저장하는 중 오류가 발생했습니다. 다시 가입을 시도해 주세요.';

  @override
  String get tryAgain => '다시 시도';

  @override
  String get connectingHearts => '우주에서 마음을 연결하는 중...';

  @override
  String get appName => 'Aryonika';

  @override
  String get exitConfirmationTitle => '확인';

  @override
  String get exitConfirmationContent => 'Aryonika을 종료하시겠습니까?';

  @override
  String get cancel => '취소';

  @override
  String get close => '닫기';

  @override
  String get paymentUrlError => '오류: 결제 URL을 찾을 수 없습니다.';

  @override
  String get channelIdError => '오류: 채널 ID를 찾을 수 없습니다.';

  @override
  String documentLoadError(Object error) {
    return 'Ошибка загрузки документа: $error';
  }

  @override
  String get partnerIdError => '오류: 궁합을 계산하려면 파트너 ID가 필요합니다.';

  @override
  String get bioPlaceholder => '여기에 당신의 이야기를 적어보세요...';

  @override
  String photoAlbumTitle(Object photoCount) {
    return '사진 앨범 ($photoCount)';
  }

  @override
  String get photoAlbumSubtitle => '당신의 최고의 순간들';

  @override
  String get cosmicEventsTitle => '우주 이벤트';

  @override
  String get cosmicEventsSubtitle => '행성의 영향에 대해 알아보세요';

  @override
  String get inviteFriendTitle => '친구 초대';

  @override
  String get inviteFriendSubtitle => '함께 보너스를 받으세요';

  @override
  String get gameCenterTitle => '게임 센터';

  @override
  String get gameCenterSubtitle => '미니 게임 및 퀘스트';

  @override
  String get personalForecastTitle => '개인 운세';

  @override
  String get personalForecastSubtitlePro => '오늘의 운행 분석';

  @override
  String get personalForecastSubtitleFree => 'PRO 등급에서 사용 가능';

  @override
  String get cosmicPassportTitle => '우주 여권';

  @override
  String get numerologyPortraitTitle => '수비학 초상화';

  @override
  String get yourNumbersOfDestinyTitle => '당신의 운명 숫자';

  @override
  String get yourNumbersOfDestinySubtitle => '당신의 잠재력을 발견하세요';

  @override
  String get numerologyPath => '경로';

  @override
  String get numerologyDestiny => '운명';

  @override
  String get numerologySoul => '영혼';

  @override
  String get signOut => '로그아웃';

  @override
  String get calculatingChart => '차트를 계산하는 중...';

  @override
  String get astroDataSignMissing => '이 별자리에 대한 데이터가 없습니다.';

  @override
  String astroDataDescriptionNotFound(Object signName) {
    return '\"$signName\"에 대한 설명을 찾을 수 없습니다.';
  }

  @override
  String astroDataMapNotLoaded(Object mapKey) {
    return '\"$mapKey\"에 대한 데이터가 로드되지 않았습니다.';
  }

  @override
  String get planetSun => '태양';

  @override
  String get planetMoon => '달';

  @override
  String get planetAscendant => '어센던트';

  @override
  String get planetMercury => '수성';

  @override
  String get planetVenus => '금성';

  @override
  String get planetMars => '화성';

  @override
  String get planetSaturn => '토성';

  @override
  String get planetJupiter => '목성';

  @override
  String get planetUranus => '천왕성';

  @override
  String get planetNeptune => '해왕성';

  @override
  String get planetPluto => '명왕성';

  @override
  String get getProTitle => 'PRO 얻기';

  @override
  String get getProSubtitle => '모든 기능 잠금 해제';

  @override
  String get proStatusActive => 'PRO 상태 활성';

  @override
  String get proStatusExpired => '상태 만료됨';

  @override
  String proStatusDaysLeft(Object days) {
    return '남은 일수: $days';
  }

  @override
  String proStatusHoursLeft(Object hours) {
    return '남은 시간: $hours';
  }

  @override
  String get proStatusExpiresToday => '오늘 만료';

  @override
  String astroDialogTitle(Object planetName, Object signName) {
    return '$signName의 $planetName';
  }

  @override
  String get likesYouTitle => '나를 좋아함';

  @override
  String likesYouTotal(Object count) {
    return '총 좋아요: $count';
  }

  @override
  String get likesYouNone => '아직 좋아요가 없습니다';

  @override
  String reportOnUser(Object userName) {
    return '$userName 신고하기';
  }

  @override
  String get reportReasonSpam => '스팸';

  @override
  String get reportReasonInsultingBehavior => '모욕적인 행동';

  @override
  String get reportReasonScam => '사기';

  @override
  String get reportReasonInappropriateContent => '부적절한 콘텐츠';

  @override
  String get reportDetailsHint => '추가 정보 (선택 사항)';

  @override
  String get send => '보내기';

  @override
  String get reportSentSnackbar => '감사합니다! 신고가 접수되었습니다.';

  @override
  String get profileLoadError => '프로필을 로드하지 못했습니다';

  @override
  String get back => '뒤로';

  @override
  String get report => '신고하기';

  @override
  String userProfilePhotoAlbumTitle(Object photoCount) {
    return '사진 앨범 ($photoCount)';
  }

  @override
  String get userProfileViewPhotos => '사진 보기';

  @override
  String get aboutMe => '자기소개';

  @override
  String get bioEmpty => '사용자가 자신에 대해 아무것도 쓰지 않았습니다.';

  @override
  String get cosmicPassport => '우주 여권';

  @override
  String sunInSign(Object signName) {
    return '☀️ $signName의 태양';
  }

  @override
  String get friendshipStatusFriends => '친구입니다';

  @override
  String get friendshipRemoveTitle => '친구 목록에서 삭제하시겠습니까?';

  @override
  String friendshipRemoveContent(Object userName) {
    return '정말로 $userName님을 친구 목록에서 삭제하시겠습니까?';
  }

  @override
  String get remove => '삭제';

  @override
  String get friendshipStatusRequestSent => '요청이 전송되었습니다';

  @override
  String get friendshipActionDecline => '거절';

  @override
  String get friendshipActionAccept => '수락';

  @override
  String get friendshipActionAdd => '친구 추가';

  @override
  String likeSnackbarSuccess(Object userName) {
    return '$userName님을 좋아했습니다!';
  }

  @override
  String likeSnackbarAlreadyLiked(Object userName) {
    return '이미 $userName님을 좋아했습니다';
  }

  @override
  String get writeMessage => '메시지 보내기';

  @override
  String get checkCompatibility => '궁합 확인';

  @override
  String get yourCosmicInfluence => '오늘의 당신의 우주적 영향력';

  @override
  String get cosmicEventsLoading => '우주 이벤트를 계산하는 중...';

  @override
  String get cosmicEventsEmpty => '오늘은 우주가 고요합니다. 조화를 즐기세요!';

  @override
  String get cosmicEventsError => '우주 이벤트를 계산하지 못했습니다. 나중에 다시 시도하세요.';

  @override
  String get cosmicConnectionTitle => '우주적 연결';

  @override
  String shareText(Object name, Object score) {
    return '$name님과의 궁합은 $score%입니다! ✨\nAryonika에서 계산됨';
  }

  @override
  String get shareErrorSnackbar => '공유하는 중 오류가 발생했습니다.';

  @override
  String get compatibilityErrorTitle => '궁합을 계산하지 못했습니다';

  @override
  String get compatibilityErrorSubtitle =>
      '파트너의 데이터가 불완전하거나 네트워크 오류가 발생했을 수 있습니다.';

  @override
  String get goBack => '돌아가기';

  @override
  String get sectionCosmicAdvice => '우주의 조언';

  @override
  String get sectionDailyInfluence => '오늘의 영향';

  @override
  String get sectionAstrologicalResonance => '점성술적 공명';

  @override
  String get sectionNumerologyMatrix => '수비학 매트릭스';

  @override
  String get sectionPalmistryConnection => '손금 연결';

  @override
  String get sectionAboutPerson => '상대에 대하여';

  @override
  String get palmistryNoData =>
      '두 사람 중 한 명이 아직 손금 분석을 완료하지 않았습니다. 이것은 당신들의 궁합에 새로운 차원을 열어줄 것입니다!';

  @override
  String palmistryCommonTraits(Object traits) {
    return '당신들을 하나로 묶는 것은 $traits입니다. 이것은 당신들의 관계에 견고한 기반을 만듭니다.';
  }

  @override
  String palmistryUniqueTraits(Object myTrait, Object partnerTrait) {
    return '당신들은 서로를 보완합니다: 당신의 특성 \'$myTrait\'는 상대방의 \'$partnerTrait\'와 아름답게 조화를 이룹니다.';
  }

  @override
  String get harmony => '조화';

  @override
  String get adviceRareConnection =>
      '당신들의 영혼이 함께 공명합니다. 이것은 성격(태양)과 감정(달)이 모두 조화를 이루는 드문 우주적 연결입니다. 이 보물을 소중히 여기세요.';

  @override
  String get advicePassionChallenge =>
      '두 사람 사이에는 열정의 불꽃이 타오르지만, 성격이 충돌할 수 있습니다. 논쟁을 성장의 에너지로 바꾸는 법을 배우면, 당신들의 연결은 깨지지 않을 것입니다.';

  @override
  String get adviceBestFriends =>
      '당신들은 말하지 않아도 서로를 이해하고 편안함을 느끼는 최고의 친구입니다. 육체적 매력은 시간이 지남에 따라 강화될 수 있으며, 가장 중요한 것은 당신들의 영혼적 친밀감입니다.';

  @override
  String get adviceKarmicLesson =>
      '당신들의 길이 우연히 교차한 것이 아닙니다. 이 연결은 두 사람 모두에게 중요한 교훈을 가져다줍니다. 서로에게 무엇을 가르쳐야 하는지 이해하기 위해 인내심을 갖고 열린 마음을 가지세요.';

  @override
  String get adviceGreatPotential =>
      '두 사람 사이에는 강한 끌림과 성장을 위한 훌륭한 잠재력이 있습니다. 서로에게서 배우면, 당신들의 연결은 더 강해질 것입니다. 별들이 당신들 편입니다.';

  @override
  String get adviceBase =>
      '서로를 탐구하세요. 모든 만남은 새로운 우주를 발견할 기회입니다. 당신들의 이야기는 이제 막 시작되었습니다.';

  @override
  String get dailyInfluenceCalm => '우주적 고요함. 외부 영향 없이 서로의 존재를 즐기기에 좋은 날입니다.';

  @override
  String get dailyAdviceFavorable => '조언: 이 에너지를 활용하세요! 공동 계획을 세우기에 좋은 순간입니다.';

  @override
  String get dailyAdviceTense => '조언: 서로에게 더 관대해지세요. 오해가 있을 수 있습니다.';

  @override
  String get proFeatureLocked => '이 측면에 대한 상세 분석은 PRO 버전에서 가능합니다.';

  @override
  String get getProButton => 'PRO 얻기';

  @override
  String get numerologyLifePath => '인생 경로';

  @override
  String get numerologyDestinyNumber => '운명수';

  @override
  String get numerologySoulNumber => '영혼수';

  @override
  String get shareCardTitle => 'Aryonika';

  @override
  String get shareCardSubtitle => '우주 궁합 보고서';

  @override
  String get shareCardHarmony => '전체 조화';

  @override
  String get shareCardPersonalityHarmony => '성격 조화 (태양)';

  @override
  String get shareCardLifePath => '인생 경로 (수비학)';

  @override
  String get shareCardCtaTitle => '당신의 우주 궁합을\n알아보세요!';

  @override
  String get shareCardCtaSubtitle => '앱스토어에서 Aryonika 다운로드';

  @override
  String get loginTitle => '계정 로그인';

  @override
  String get loginError => '로그인 오류';

  @override
  String get passwordResetTitle => '비밀번호 재설정';

  @override
  String get passwordResetContent => '이메일을 입력하시면 비밀번호 재설정 지침을 보내드립니다.';

  @override
  String get emailLabel => '이메일';

  @override
  String get sendButton => '보내기';

  @override
  String get emailValidationError => '올바른 이메일을 입력하세요.';

  @override
  String get passwordResetSuccess => '이메일이 발송되었습니다! 메일함을 확인하세요.';

  @override
  String get passwordLabel => '비밀번호';

  @override
  String get loginButton => '로그인';

  @override
  String get forgotPasswordButton => '비밀번호를 잊으셨나요?';

  @override
  String get noAccountButton => '계정이 없으신가요? 만들기';

  @override
  String get registerTitle => '계정 만들기';

  @override
  String get unknownError => '알 수 없는 오류가 발생했습니다';

  @override
  String get confirmPasswordLabel => '비밀번호 확인';

  @override
  String get privacyPolicyCheckbox => '나는 ';

  @override
  String get termsOfUseLink => '이용약관';

  @override
  String get and => ' 및 ';

  @override
  String get privacyPolicyLink => '개인정보 처리방침';

  @override
  String get registerButton => '을(를) 읽고 동의합니다.';

  @override
  String get alreadyHaveAccountButton => '이미 계정이 있으신가요? 로그인';

  @override
  String get welcomeTagline => '당신의 운명은 별에 쓰여 있습니다';

  @override
  String get welcomeCreateAccountButton => '우주 여권 만들기';

  @override
  String get welcomeLoginButton => '이미 계정이 있습니다';

  @override
  String get introSlide1Title => 'Aryonika - 데이팅 그 이상';

  @override
  String get introSlide1Description =>
      '점성술, 수비학, 운명의 카드를 통해 궁합의 새로운 차원을 발견하세요.';

  @override
  String get introSlide2Title => '당신의 우주 여권';

  @override
  String get introSlide2Description =>
      '당신의 모든 잠재력을 알아보고, 당신의 우주를 완성할 사람을 찾으세요.';

  @override
  String get introSlide3Title => '은하계에 합류하세요';

  @override
  String get introSlide3Description => '지금 바로 진정한 사랑을 향한 우주 여행을 시작하세요.';

  @override
  String get introButtonSkip => '건너뛰기';

  @override
  String get introButtonNext => '다음';

  @override
  String get introButtonStart => '시작하기';

  @override
  String get onboardingNameTitle => '이름이 무엇인가요?';

  @override
  String get onboardingNameSignOutTooltip => '로그아웃 (테스트용)';

  @override
  String get onboardingNameSubtitle => '이 이름이 다른 사용자에게 표시됩니다.';

  @override
  String get onboardingNameLabel => '당신의 이름';

  @override
  String get onboardingBioLabel => '자신에 대해 이야기해주세요';

  @override
  String get onboardingBioHint => '예: 점성술과 #여행을 좋아해요...';

  @override
  String get onboardingButtonNext => '다음';

  @override
  String get onboardingBirthdateTitle => '언제 태어나셨나요?';

  @override
  String get onboardingBirthdateSubtitle => '정확한 출생 차트와 수비학 계산에 필요합니다.';

  @override
  String get datePickerHelpText => '생년월일 선택';

  @override
  String get birthdateLabel => '생년월일';

  @override
  String get birthdatePlaceholder => '선택하려면 클릭하세요';

  @override
  String get dateFormat => 'yyyy년 M월 d일';

  @override
  String get onboardingFinishText1 => '별의 위치를 분석하는 중...';

  @override
  String get onboardingFinishText2 => '당신의 수비학 코드를 계산하는 중...';

  @override
  String get onboardingFinishText3 => '운명의 카드와 대조하는 중...';

  @override
  String get onboardingFinishText4 => '당신의 우주 여권을 만드는 중...';

  @override
  String get onboardingFinishErrorTitle => '오류';

  @override
  String get onboardingFinishErrorContent => '알 수 없는 오류가 발생했습니다.';

  @override
  String get onboardingFinishErrorButton => '돌아가기';

  @override
  String get onboardingGenderTitle => '당신의 성별';

  @override
  String get onboardingGenderSubtitle => '가장 적합한 사람들을 찾는 데 도움이 됩니다.';

  @override
  String get genderMale => '남성';

  @override
  String get genderFemale => '여성';

  @override
  String get onboardingLocationTitle => '출생지';

  @override
  String get onboardingLocationSubtitle => '태어난 도시를 입력하세요. 정확한 점성술 계산에 필요합니다.';

  @override
  String get onboardingLocationSearchHint => '도시를 입력하기 시작하세요...';

  @override
  String get onboardingLocationNotFound => '도시를 찾을 수 없습니다. 다른 검색어를 시도해보세요.';

  @override
  String get onboardingLocationStartSearch => '검색을 시작하여 결과를 확인하세요';

  @override
  String get onboardingLocationSelectFromList => '계속하려면 위 목록에서 도시를 선택하세요';

  @override
  String get onboardingTimeTitle => '출생 시간';

  @override
  String get onboardingTimeSubtitle =>
      '정확한 시간을 모르면 12:00를 입력하세요. 그래도 좋은 결과를 얻을 수 있습니다.';

  @override
  String get timePickerHelpText => '출생 시간 지정';

  @override
  String get birthTimeLabel => '출생 시간';

  @override
  String get onboardingButtonNextLocation => '다음 (장소 선택)';

  @override
  String get alphaBannerTitle => '알파 버전';

  @override
  String get alphaBannerContent =>
      '이 섹션은 현재 활발히 개발 중입니다. 일부 기능이 불안정할 수 있습니다. 현지화 작업도 활발히 진행 중이므로 일부 텍스트는 아직 영어일 수 있습니다. 양해 부탁드립니다!';

  @override
  String get alphaBannerFeedback => '저희 텔레그램 채널에서 여러분의 의견과 제안을 기다리겠습니다!';

  @override
  String get astro_title_sun => '성격 궁합 (태양)';

  @override
  String get astro_title_moon => '감정적 궁합 (달)';

  @override
  String get astro_title_chemistry => '점성술적 케미스트리 (금성-화성)';

  @override
  String get astro_title_mercury => '소통 스타일 (수성)';

  @override
  String get astro_title_saturn => '장기적 전망 (토성)';

  @override
  String get numerology_title => '수비학적 공명';

  @override
  String get cosmicPulseTitle => '우주의 맥박';

  @override
  String get feedIceBreakerTitle => '아이스브레이커';

  @override
  String get feedOrbitCrossingTitle => '궤도 교차';

  @override
  String get feedSpiritualNeighborTitle => '영적 이웃';

  @override
  String get feedGeomagneticStormTitle => '지자기 폭풍';

  @override
  String get feedCompatibilityPeakTitle => '궁합 최고조';

  @override
  String get feedNewChannelSuggestionTitle => '새 채널 제안';

  @override
  String get feedPopularPostTitle => '인기 게시물';

  @override
  String get feedNewCommentTitle => '새 댓글';

  @override
  String get cardOfTheDayTitle => '오늘의 카드';

  @override
  String get cardOfTheDayDrawing => '카드 뽑는 중...';

  @override
  String get cardOfTheDayGetButton => '카드 뽑기';

  @override
  String get cardOfTheDayYourCard => '당신의 오늘의 카드';

  @override
  String get cardOfTheDayTapToReveal => '탭하여 확인';

  @override
  String get cardOfTheDayReversedSuffix => ' (역방향)';

  @override
  String get cardOfTheDayDefaultInterpretation => '오늘 하루를 미리 확인하세요.';

  @override
  String get channelSearchTitle => '방송 검색';

  @override
  String get channelAnonymousAuthor => '익명';

  @override
  String get errorUserNotAuthorized => '사용자가 인증되지 않았습니다';

  @override
  String get errorUnknownServer => '알 수 없는 서버 오류';

  @override
  String get errorFailedToLoadData => '데이터를 로드하지 못했습니다';

  @override
  String get generalHello => '안녕하세요';

  @override
  String get referralErrorProfileNotLoaded =>
      '오류: 프로필이 로드되지 않았습니다. 나중에 다시 시도하세요.';

  @override
  String get referralErrorAlreadyUsed => '이미 초대 코드를 사용했습니다.';

  @override
  String get referralErrorOwnCode => '자신의 코드는 사용할 수 없습니다.';

  @override
  String get referralScreenTitle => '친구 초대';

  @override
  String get referralYourCodeTitle => '당신의 초대 코드';

  @override
  String get referralYourCodeDescription =>
      '이 코드를 친구와 공유하세요. 코드를 입력한 친구 한 명당 1일 PRO 액세스 권한을 드립니다!';

  @override
  String get referralCodeCopied => '코드가 클립보드에 복사되었습니다!';

  @override
  String get referralShareCodeButton => '코드 공유';

  @override
  String referralShareMessage(String code) {
    return '안녕하세요! Aryonika에서 저와 함께 당신의 우주적 짝을 찾아보세요. 앱에서 제 초대 코드를 입력하면 우리 둘 다 보너스를 받을 수 있습니다: $code';
  }

  @override
  String get referralManualBonusNote =>
      '친구가 코드를 입력한 후 24시간 이내에 PRO 액세스 권한이 수동으로 부여됩니다.';

  @override
  String get referralGotCodeTitle => '코드가 있으신가요?';

  @override
  String get referralGotCodeDescription =>
      '친구가 준 코드를 입력하여 친구가 보상을 받을 수 있도록 하세요.';

  @override
  String get referralCodeInputLabel => '초대 코드';

  @override
  String get referralCodeValidationError => '코드를 입력하세요';

  @override
  String get referralApplyCodeButton => '코드 적용';

  @override
  String get nav_feed => '피드';

  @override
  String get nav_search => '검색';

  @override
  String get nav_oracle => '신탁';

  @override
  String get nav_chats => '채팅';

  @override
  String get nav_channels => '채널';

  @override
  String get nav_profile => '프로필';

  @override
  String get nav_exit => '나가기';

  @override
  String get exitDialog_title => '확인';

  @override
  String get exitDialog_content => 'Aryonika을 종료하시겠습니까?';

  @override
  String get exitDialog_cancel => '취소';

  @override
  String get exitDialog_confirm => '닫기';

  @override
  String get oracle_limit_title => '요청 한도';

  @override
  String get oracle_limit_later => '나중에';

  @override
  String get oracle_limit_get_pro => '무제한 얻기';

  @override
  String get oracle_orb_partner => '오늘의 파트너';

  @override
  String get oracle_orb_roulette => '룰렛';

  @override
  String get oracle_orb_duet => '듀엣';

  @override
  String get oracle_orb_horoscope => '운세';

  @override
  String get oracle_orb_weather => '지자기';

  @override
  String get oracle_orb_ask => '질문';

  @override
  String get oracle_orb_focus => '오늘의 초점';

  @override
  String get oracle_orb_forecast => '별자리 예보';

  @override
  String get oracle_orb_card => '오늘의 카드';

  @override
  String get oracle_orb_tarot => '우주의 대답';

  @override
  String get oracle_orb_palmistry => '손금';

  @override
  String get oracle_duet_title => '우주적 듀엣';

  @override
  String get oracle_duet_description => '생년월일로 궁합 확인.';

  @override
  String get oracle_duet_button => '궁합 확인';

  @override
  String oracle_unsupported_web_feature(String featureName, Object feature) {
    return 'WEB에서는 지원하지 않는 기능입니다.';
  }

  @override
  String get oracle_pro_card_of_day_title => '오늘의 카드 (PRO)';

  @override
  String get oracle_pro_card_of_day_desc => '오늘의 에너지를 확인하세요. PRO 전용.';

  @override
  String get oracle_pro_focus_of_day_title => '오늘의 초점 (PRO)';

  @override
  String get oracle_pro_focus_of_day_desc => '오늘 집중해야 할 것. PRO 전용.';

  @override
  String get oracle_pro_forecast_of_day_title => '개인 예보 (PRO)';

  @override
  String get oracle_pro_forecast_of_day_desc => '상세한 이동 분석. PRO 전용.';

  @override
  String get oracle_roulette_title => '우주적 룰렛';

  @override
  String get oracle_roulette_description => '운을 시험해 보세요! 랜덤 파트너 찾기.';

  @override
  String get oracle_roulette_button => '룰렛 돌리기';

  @override
  String get oracle_card_of_day_reversed => '(역방향)';

  @override
  String get oracle_card_of_day_get_key => '개인적인 열쇠 알아보기';

  @override
  String get oracle_palmistry_title => '손금';

  @override
  String get oracle_palmistry_description => 'AI 손금 분석.';

  @override
  String get oracle_palmistry_button => '손 스캔';

  @override
  String get oracle_ask_loading => '오라클이 생각 중...';

  @override
  String get oracle_ask_again => '다시 질문하기';

  @override
  String get oracle_focus_loading => '초점 맞추는 중...';

  @override
  String get oracle_focus_error => '로드 오류';

  @override
  String get oracle_focus_no_data => '데이터 없음';

  @override
  String get oracle_forecast_loading => '개인 예보를 작성하는 중...';

  @override
  String get oracle_forecast_error => '예보를 작성하지 못했습니다';

  @override
  String get oracle_forecast_try_again => '다시 시도';

  @override
  String get oracle_forecast_title => '일일 예보';

  @override
  String get oracle_forecast_day_number => '당신의 오늘의 숫자: ';

  @override
  String get oracle_tarot_title => '타로 리딩 (AI)';

  @override
  String get oracle_tarot_hint => '질문을 입력하세요...';

  @override
  String get oracle_tarot_button => '리딩 하기';

  @override
  String oracle_tarot_your_question(String question) {
    return '당신의 질문: $question';
  }

  @override
  String get oracle_tarot_loading => 'AI 분석 중...';

  @override
  String get oracle_tarot_ask_again => '다시 질문';

  @override
  String get oracle_tarot_card_reversed_short => ' (역)';

  @override
  String get oracle_tarot_combo_message => '카드들의 전체적인 메시지:';

  @override
  String get oracle_geomagnetic_title => '우주 날씨';

  @override
  String get oracle_geomagnetic_forecast => '예보';

  @override
  String get oracle_weather_title => '지자기 활동';

  @override
  String get oracle_pro_feature_title => '오늘의 파트너 (PRO)';

  @override
  String get oracle_pro_feature_desc => '완벽한 파트너를 찾아드립니다. PRO 전용.';

  @override
  String get oracle_partner_loading => '파트너 찾는 중...';

  @override
  String get oracle_partner_error => '검색 오류';

  @override
  String get oracle_partner_not_found => '파트너 없음';

  @override
  String get oracle_partner_profile_error => '프로필 오류';

  @override
  String get oracle_partner_title => '당신의 오늘의 파트너';

  @override
  String oracle_partner_compatibility(String score) {
    return '궁합: $score%';
  }

  @override
  String get oracle_ask_title => '신탁에게 묻기';

  @override
  String get oracle_ask_hint => '무엇이 궁금하신가요?...';

  @override
  String get oracle_ask_button => '답변 받기';

  @override
  String get oracle_tips_loading => '팁 로드 중...';

  @override
  String get oracle_tips_title => '오늘의 별 팁';

  @override
  String oracle_tips_subtitle(String count) {
    return '소통을 위해 ($count)';
  }

  @override
  String get oracle_tips_general_advice => '열린 마음을 가지세요.';

  @override
  String get cardOfTheDayProInApp => '✨ 개인적인 측면은 모바일 앱에서 사용 가능합니다.';

  @override
  String get numerology_report_title => '수비학 보고서';

  @override
  String get numerology_report_overall => '총점';

  @override
  String get numerology_report_you => '당신';

  @override
  String get numerology_report_partner => '파트너';

  @override
  String get userProfile_numerology_button => '수비학';

  @override
  String get forecast_astrological_title => '점성술 예보';

  @override
  String get forecast_loading => '예보 로드 중...';

  @override
  String get forecast_error => '로드 오류';

  @override
  String get forecast_no_aspects => '중요한 측면 없음';

  @override
  String get cosmicEvents_title => '우주 이벤트';

  @override
  String get cosmicEvents_loading_error => '이벤트를 불러오지 못했습니다';

  @override
  String get cosmicEvents_no_events => '예정된 이벤트가 없습니다';

  @override
  String get cosmicEvents_paywall_title => '개인 우주 이벤트';

  @override
  String get cosmicEvents_paywall_description =>
      '당신의 출생 차트에 미치는 행성의 영향에 기반한 독특한 조언을 받아보세요.';

  @override
  String get cosmicEvents_paywall_button => 'PRO 상태 얻기';

  @override
  String get cosmicEvents_personal_focus => '당신의 개인적인 초점:';

  @override
  String get cosmicEvents_pro_placeholder => 'PRO 상태에서 이 이벤트의 개인적 영향을 알아보세요';

  @override
  String get search_no_one_found => '이 은하계 구역에서는\n아무도 발견되지 않았습니다.';

  @override
  String get chat_error_user_not_found => '오류: 사용자를 찾을 수 없습니다';

  @override
  String get chat_start_with_hint => '힌트로 시작하기';

  @override
  String get chat_date_format => 'y년 M월 d일';

  @override
  String get chat_group_member => '참가자';

  @override
  String get chat_group_members_2_4 => '참가자';

  @override
  String get chat_group_members_5_0 => '참가자';

  @override
  String get chat_online_status_long_ago => '오래 전 접속';

  @override
  String get chat_online_status_online => '온라인';

  @override
  String chat_online_status_minutes_ago(String minutes) {
    return '$minutes분 전 접속';
  }

  @override
  String chat_online_status_today_at(String time) {
    return '오늘 $time에 접속';
  }

  @override
  String chat_online_status_yesterday_at(String time) {
    return '어제 $time에 접속';
  }

  @override
  String chat_online_status_date(String date) {
    return '$date에 접속';
  }

  @override
  String get chat_delete_dialog_title => '채팅을 삭제하시겠습니까?';

  @override
  String get chat_delete_dialog_content =>
      '이 채팅은 당신과 상대방 모두에게서 삭제됩니다. 이 작업은 되돌릴 수 없습니다.';

  @override
  String get chat_delete_dialog_confirm => '삭제';

  @override
  String chat_report_dialog_title(String name) {
    return '$name님 신고하기';
  }

  @override
  String get chat_report_details_hint => '추가 정보 (선택 사항)';

  @override
  String get chat_report_sent_snackbar => '감사합니다! 신고가 접수되었습니다.';

  @override
  String get chat_menu_report => '신고하기';

  @override
  String get chat_menu_delete => '채팅 삭제';

  @override
  String get chat_group_title_default => '그룹 채팅';

  @override
  String get chat_group_participants => '참가자';

  @override
  String get chat_message_old => '이전 버전의 메시지';

  @override
  String get chat_input_hint => '메시지...';

  @override
  String get chat_temp_warning_remaining => '이 임시 채팅은... 후에 삭제됩니다';

  @override
  String get chat_temp_warning_expired => '채팅이 만료되었습니다';

  @override
  String get chat_temp_warning_less_than_24h => '24시간 미만';

  @override
  String get encrypted_chat_banner_title => '대화가 보호됩니다';

  @override
  String get encrypted_chat_banner_desc =>
      '이 채팅의 메시지는 종단간 암호화로 보호됩니다. Aryonika 관리자를 포함한 누구도 메시지를 읽을 수 없습니다.';

  @override
  String get search_hint => '이름, 자기소개로 검색...';

  @override
  String get search_tooltip_swipes => '스와이프';

  @override
  String get search_tooltip_cosmic_web => '코스믹 웹';

  @override
  String get search_tooltip_star_map => '별자리 지도';

  @override
  String get search_tooltip_filters => '필터';

  @override
  String get search_star_map_placeholder => '별자리 지도는 개발 중입니다...';

  @override
  String get search_priority_header => '최고의 매치';

  @override
  String get search_other_header => '다른 사용자';

  @override
  String get payment_title => '프로젝트 지원하기';

  @override
  String get payment_success_snackbar => '지원해주셔서 감사합니다! 상태를 업데이트하는 중입니다...';

  @override
  String get payment_fail_snackbar => '기부를 처리하지 못했습니다. 다시 시도해주세요.';

  @override
  String get paywall_header_title => 'Aryonika의 우주를 잠금 해제하세요';

  @override
  String get paywall_header_subtitle =>
      '프로젝트를 지원하고 완벽한 짝을 찾기 위한 모든 우주 도구를 감사의 선물로 받아보세요.';

  @override
  String get paywall_benefit1_title => '누가 당신을 좋아했는지 확인하세요';

  @override
  String get paywall_benefit1_subtitle => '서로 마음이 통할 기회를 놓치지 말고 먼저 대화를 시작하세요.';

  @override
  String get paywall_benefit2_title => '일일 개인 예보';

  @override
  String get paywall_benefit2_subtitle => '매일 당신의 운행과 오늘의 초점에 대한 분석.';

  @override
  String get paywall_benefit3_title => '오늘의 파트너 & 룰렛';

  @override
  String get paywall_benefit3_subtitle => '별들이 당신에게 가장 잘 맞는 파트너를 선택하게 하세요.';

  @override
  String get paywall_benefit4_title => '우주의 대답';

  @override
  String get paywall_benefit4_subtitle => '질문을 하고 우주의 조언을 받으세요.';

  @override
  String get paywall_benefit5_title => '우주 날씨';

  @override
  String get paywall_benefit5_subtitle => '지자기 폭풍과 그 영향에 대한 정보를 확인하세요.';

  @override
  String get paywall_benefit6_title => '오늘의 카드';

  @override
  String get paywall_benefit6_subtitle => '운명의 카드로부터 매일의 예측과 조언을 받으세요.';

  @override
  String get paywall_donate_button => '프로젝트 지원하기';

  @override
  String get paywall_referral_button => '친구 초대하고 PRO 받기';

  @override
  String get paywall_referral_subtitle =>
      '친구를 초대하고 당신의 링크로 가입할 때마다 1일 PRO 상태를 받으세요.';

  @override
  String paywall_get_pro_button(String price) {
    return 'Aryonika PRO 얻기 ($price)';
  }

  @override
  String get paywall_arbitrary_donate_button => '다른 금액으로 후원하기';

  @override
  String get paywall_arbitrary_donate_subtitle =>
      '저희 프로젝트가 마음에 드신다면, 상어와 다른 포식자들의 세계에서 살아남을 수 있도록 지원해 주세요.';

  @override
  String get chinese_zodiac_title => '중국 띠 (십이지신)';

  @override
  String get zodiac_Rat => '쥐';

  @override
  String get zodiac_Ox => '소';

  @override
  String get zodiac_Tiger => '호랑이';

  @override
  String get zodiac_Rabbit => '토끼';

  @override
  String get zodiac_Dragon => '용';

  @override
  String get zodiac_Snake => '뱀';

  @override
  String get zodiac_Horse => '말';

  @override
  String get zodiac_Goat => '양';

  @override
  String get zodiac_Monkey => '원숭이';

  @override
  String get zodiac_Rooster => '닭';

  @override
  String get zodiac_Dog => '개';

  @override
  String get zodiac_Pig => '돼지';

  @override
  String get chinese_zodiac_compatibility_button => '띠 궁합';

  @override
  String get compatibility_section_title => '궁합';

  @override
  String get userProfile_astro_button => '점성술';

  @override
  String get userProfile_bazi_button => '사주팔자';

  @override
  String get jyotishCompatibilityTitle => '베딕 궁합';

  @override
  String get jyotishDetailedAnalysisTitle => '상세 분석 (Ashta-Kuta)';

  @override
  String get kuta_tara_name => '타라 쿠타 (운명)';

  @override
  String get kuta_tara_desc =>
      '관계의 운, 지속 기간, 안녕을 나타냅니다. 여기서 좋은 궁합은 당신들의 결합에 순풍과 같습니다.';

  @override
  String get kuta_yoni_name => '요니 쿠타 (매력)';

  @override
  String get kuta_yoni_desc => '육체적, 성적 조화를 결정합니다. 높은 점수는 강한 상호 매력과 만족을 나타냅니다.';

  @override
  String get kuta_graha_maitri_name => '그라하 마이트리 (우정)';

  @override
  String get kuta_graha_maitri_desc =>
      '심리적 궁합과 우정. 인생관이 얼마나 비슷한지, 공통점을 찾기 얼마나 쉬운지를 반영합니다.';

  @override
  String get kuta_vashya_name => '바샤 쿠타 (상호 통제)';

  @override
  String get kuta_vashya_desc =>
      '커플 내 상호 영향력과 자력의 정도를 보여줍니다. 누가 리더가 되고 누가 따를 것인가.';

  @override
  String get kuta_gana_name => '가나 쿠타 (기질)';

  @override
  String get kuta_gana_desc => '기질 수준의 궁합 (신성, 인간, 악마). 성격 충돌을 피하는 데 도움이 됩니다.';

  @override
  String get kuta_bhakoot_name => '바쿠트 쿠타 (사랑과 가족)';

  @override
  String get kuta_bhakoot_desc =>
      '가장 중요한 지표 중 하나. 사랑의 깊이, 가족의 행복, 재정적 번영, 자녀를 가질 가능성을 담당합니다.';

  @override
  String get kuta_nadi_name => '나디 쿠타 (건강)';

  @override
  String get kuta_nadi_desc => '가장 비중이 큰 기준. 파트너와 자손의 건강, 유전적 호환성, 장수를 담당합니다.';

  @override
  String get kuta_varna_name => '바르나 쿠타 (영성)';

  @override
  String get kuta_varna_desc =>
      '자아 궁합과 파트너의 영적 발전을 반영합니다. 커플 중 누가 상대방의 성장을 더 자극할지 보여줍니다.';

  @override
  String get jyotishVerdictExcellent =>
      '천생연분! 당신들의 달 별자리는 완벽한 조화를 이룹니다. 이 연결은 깊은 이해, 영적 성장, 그리고 앞으로 오랫동안의 행복을 약속합니다.';

  @override
  String get jyotishVerdictGood =>
      '매우 좋은 궁합입니다. 강하고 조화롭고 행복한 관계를 구축할 모든 가능성이 있습니다. 사소한 의견 차이는 쉽게 극복할 수 있습니다.';

  @override
  String get jyotishVerdictAverage =>
      '보통 궁합입니다. 관계에는 강점과 성장의 영역이 모두 있습니다. 결합의 성공은 관계를 위해 노력하려는 의지에 달려 있습니다.';

  @override
  String get jyotishVerdictChallenging =>
      '어려운 궁합입니다. 차트는 성격과 인생 경로에 심각한 차이가 있음을 나타냅니다. 조화를 이루려면 많은 인내와 타협이 필요합니다.';

  @override
  String get passwordResetNewPasswordTitle => '새 비밀번호 설정';

  @override
  String get passwordResetNewPasswordLabel => '새 비밀번호';

  @override
  String get passwordResetConfirmLabel => '비밀번호 확인';

  @override
  String get passwordValidationError => '비밀번호는 6자 이상이어야 합니다';

  @override
  String get passwordMismatchError => '비밀번호가 일치하지 않습니다';

  @override
  String get saveButton => '저장';

  @override
  String get postActionLike => '좋아요';

  @override
  String get postActionComment => '댓글';

  @override
  String get postActionShare => '공유';

  @override
  String get channelDefaultName => '채널';

  @override
  String postShareText(Object channelName, Object postText) {
    return '\"$channelName\" 채널의 이 게시물을 확인해보세요: $postText';
  }

  @override
  String get postDeleteDialogTitle => '게시물을 삭제하시겠습니까?';

  @override
  String get postDeleteDialogContent => '이 작업은 되돌릴 수 없습니다.';

  @override
  String get delete => '삭제';

  @override
  String get postMenuDelete => '게시물 삭제';

  @override
  String get numerologySectionKeyNumbers => '핵심 숫자';

  @override
  String get numerologySectionCurrentVibes => '현재의 진동';

  @override
  String get numerologyTitleLifePath => '인생 경로 수';

  @override
  String get numerologyTitleDestiny => '운명수 (표현수)';

  @override
  String get numerologyTitleSoulUrge => '영혼의 동기 수';

  @override
  String get numerologyTitlePersonality => '성격수';

  @override
  String get numerologyTitleMaturity => '성숙수';

  @override
  String get numerologyTitleBirthday => '생일수';

  @override
  String get numerologyTitlePersonalYear => '개인 연도';

  @override
  String get numerologyTitlePersonalMonth => '개인 월';

  @override
  String get numerologyTitlePersonalDay => '개인 일';

  @override
  String get numerologyErrorNotEnoughData => '계산을 위한 데이터가 부족합니다.';

  @override
  String get numerologyErrorDescriptionsNotLoaded => '수비학 설명을 불러오지 못했습니다.';

  @override
  String get chat_error_recipient_not_found => '상대방을 찾을 수 없습니다.';

  @override
  String get chat_error_recipient_profile_load_failed =>
      '상대방의 프로필을 불러오지 못했습니다.';

  @override
  String get calculatingNumerology => '수비학 초상화 계산 중...';

  @override
  String get oracle_title => '오라클';

  @override
  String get verifyEmailBody => '이메일로 6자리 코드를 보냈습니다. 아래에 입력해주세요.';

  @override
  String get verifyEmailHint => '------';

  @override
  String get signOutButton => '로그아웃';

  @override
  String get errorInvalidOrExpiredCode => '유효하지 않거나 만료된 코드입니다.';

  @override
  String get errorCodeRequired => '인증 코드를 입력해주세요.';

  @override
  String get errorInternalServer => '내부 서버 오류가 발생했습니다. 나중에 다시 시도해주세요.';

  @override
  String get errorCodeLength => '코드는 6자리여야 합니다.';

  @override
  String get verifyEmailTitle => '이메일 인증';

  @override
  String get verificationCodeLabel => '인증 코드';

  @override
  String get verificationCodeResent => '새 인증 코드가 발송되었습니다!';

  @override
  String get resendCodeAction => '코드 다시 보내기';

  @override
  String resendCodeCooldown(int seconds) {
    return '($seconds)초 후 다시 보내기';
  }

  @override
  String verifyEmailInstruction(String email) {
    return '이메일로 6자리 코드를 보냈습니다:\n$email\n아래에 입력해주세요.';
  }

  @override
  String get confirmButton => '확인';

  @override
  String get logout => '로그아웃';

  @override
  String get numerology_score_high => '높음';

  @override
  String get numerology_score_medium => '중간';

  @override
  String get numerology_score_low => '낮음';

  @override
  String get noUsersFound => '사용자를 찾을 수 없습니다';

  @override
  String get feature_in_development => '곧 출시됩니다!';

  @override
  String get download_our_app => '앱 다운로드';

  @override
  String get open_web_version => '웹 버전 열기';

  @override
  String get pay_with_card => '카드로 결제';

  @override
  String get coming_soon => '곧 출시';

  @override
  String get paywall_subscription_terms => '구독은 자동으로 갱신됩니다. 언제든지 취소 가능합니다.';

  @override
  String get searchHint => 'Поиск...';

  @override
  String get nav_friends => '친구';

  @override
  String get oracle_typing => '입력 중...';

  @override
  String get tarot_reversed => '(역방향)';

  @override
  String get common_close => '닫기';

  @override
  String oracle_limit_pro(Object hours) {
    return '$hours시간 남음.';
  }

  @override
  String oracle_limit_free(Object days) {
    return '무료 한도 도달. $days일 남음.';
  }

  @override
  String get oracle_error_stream => '연결 오류';

  @override
  String get oracle_error_start => '시작 실패';

  @override
  String get error_generic => '오류가 발생했습니다. 나중에 다시 시도해 주세요.';

  @override
  String get referral_already_used => '이미 추천 코드를 사용하셨습니다.';

  @override
  String get referral_own_code => '자신의 코드는 사용할 수 없습니다.';

  @override
  String get referral_success => '코드가 활성화되었습니다! 프리미엄 3일을 받으셨습니다.';

  @override
  String get tab_astrology => '점성술';

  @override
  String get tab_numerology => '수비학';

  @override
  String get tab_bazi => '사주 (BaZi)';

  @override
  String get tab_jyotish => '베다 점성술';

  @override
  String get share_result => '결과 공유';

  @override
  String get share_preparing => '준비 중...';

  @override
  String locked_feature_title(Object title) {
    return '$title 섹션 잠김';
  }

  @override
  String get locked_feature_desc => '이 섹션은 프리미엄 버전에서만 사용할 수 있습니다.';

  @override
  String get get_access_button => '액세스 권한 얻기';

  @override
  String get coming_soon_suffix => '준비 중입니다';

  @override
  String get tab_summary => 'Сводка';

  @override
  String get tab_chinese_zodiac => 'Кит. Зодиак';

  @override
  String get summary_verdict_title => 'Общий вердикт';

  @override
  String get webVersionButton => '웹 버전';

  @override
  String get uploadPhotoDisclaimer =>
      '사진을 업로드함으로써 귀하는 해당 사진에 과도한 노출이나 폭력이 포함되어 있지 않음을 확인합니다. 위반자는 영구적으로 차단됩니다.';

  @override
  String get iAgree => '동의합니다';

  @override
  String get testers_banner_title => '테스터 모집 (4/20)';

  @override
  String get testers_banner_desc => 'Aryonika 개선을 도와주시고 받으세요\n✨ 평생 프리미엄 ✨';

  @override
  String get testers_email_hint => '(터치하여 열기, 길게 눌러 복사)';

  @override
  String get numerology_day_1 => '새로운 시작의 날. 프로젝트를 시작하기에 완벽합니다.';

  @override
  String get numerology_day_2 => '파트너십의 날. 타협점을 찾으세요.';

  @override
  String get numerology_day_3 => '창의성의 날. 자신을 표현하세요.';

  @override
  String get numerology_day_4 => '노동의 날. 일상을 정리하세요.';

  @override
  String get numerology_day_5 => '변화의 날. 새로운 것에 마음을 여세요.';

  @override
  String get numerology_day_6 => '조화의 날. 가족과 시간을 보내세요.';

  @override
  String get numerology_day_7 => '성찰의 날. 혼자만의 시간을 가지세요.';

  @override
  String get numerology_day_8 => '힘의 날. 경력과 재정에 집중하세요.';

  @override
  String get numerology_day_9 => '완성의 날. 낡은 것을 놓아주세요.';

  @override
  String get astro_transit_positive_general =>
      'Звезды на вашей стороне. Действуйте смело.';

  @override
  String get advice_general_balance =>
      'Сохраняйте баланс между чувствами и разумом.';

  @override
  String get astro_advice_listen_intuition => '내면의 목소리에 귀를 기울이세요.';

  @override
  String get astro_advice_act_boldly => '에너지가 대담한 행동을 돕습니다.';

  @override
  String get astro_advice_rest_and_reflect => '별들이 휴식을 권합니다.';

  @override
  String get astro_advice_connect_with_nature => '자연 속에서 시간을 보내세요.';

  @override
  String get advice_generic_positive => '오늘 우주는 당신 편입니다.';

  @override
  String get channelLoadError => '채널을 로드하지 못했습니다';

  @override
  String get postsTitle => '게시물';

  @override
  String get noPostsYet => '이 채널에는 아직 게시물이 없습니다.';

  @override
  String get createPostTooltip => '게시물 작성';

  @override
  String get proposePost => '뉴스 제안';

  @override
  String get channelsTitle => '채널';

  @override
  String get noChannelSubscriptions => '아직 구독이 없습니다';

  @override
  String get noMessagesYet => '아직 메시지가 없습니다';

  @override
  String get yesterday => '어제';

  @override
  String get search => '검색';

  @override
  String get adminOnlyFeature => '채널 생성은 당분간 관리자만 가능합니다.';

  @override
  String get createChannel => '채널 만들기';

  @override
  String get galacticBroadcasts => '은하계 방송';

  @override
  String get noChannelsYet => '아직 구독한 채널이 없습니다.\n채널을 찾거나 직접 만들어 보세요!';

  @override
  String get constellationsTitle => '별자리';

  @override
  String get privateChatsTab => '개인';

  @override
  String get channelsTab => '채널';

  @override
  String get loadingUser => '사용자 로드 중...';

  @override
  String get emptyChatsPlaceholder =>
      '여기에 개인 채팅이 표시됩니다.\n검색을 통해 흥미로운 사람을 찾아보세요!';

  @override
  String get errorTitle => '오류';

  @override
  String get autoDeleteMessages => '메시지 자동 삭제';

  @override
  String get availableInPro => 'PRO에서 사용 가능';

  @override
  String get timerOff => '꺼짐';

  @override
  String get timer15min => '15분';

  @override
  String get timer1hour => '1시간';

  @override
  String get timer4hours => '4시간';

  @override
  String get timer24hours => '24시간';

  @override
  String get timerSet => '타이머 설정됨';

  @override
  String get disappearingMessages => '사라지는 메시지';

  @override
  String get communicationTitle => '소통';

  @override
  String get errorLoadingReport => '보고서를 로드하는 중 오류 발생';

  @override
  String get compatibility => '궁합';

  @override
  String get strengths => '강점';

  @override
  String get weaknesses => '잠재적 어려움';

  @override
  String get commentsTitle => '댓글';

  @override
  String get commentsLoadError => '댓글을 로드하는 중 오류가 발생했습니다.';

  @override
  String get noCommentsYet => '아직 댓글이 없습니다.';

  @override
  String userIsTyping(Object name) {
    return '$name 님이 입력 중...';
  }

  @override
  String twoUsersTyping(Object name1, Object name2) {
    return '$name1 님과 $name2 님이 입력 중...';
  }

  @override
  String manyUsersTyping(Object count, Object name1, Object name2) {
    return '$name1, $name2 외 $count명이 입력 중...';
  }

  @override
  String replyingTo(Object name) {
    return '$name 님에게 답장';
  }

  @override
  String get writeCommentHint => '댓글 작성...';

  @override
  String get compatibilityTitle => '우주적 연결';

  @override
  String get noData => '데이터 없음';

  @override
  String get westernAstrology => '서양 점성술';

  @override
  String get vedicAstrology => '베다 점성술 (조티시)';

  @override
  String get numerology => '수비학';

  @override
  String get chineseZodiac => '띠';

  @override
  String get baziElements => '사주팔자 (오행)';

  @override
  String get availableInPremium => '프리미엄에서 사용 가능';

  @override
  String get verdictSoulmates => '천생연분';

  @override
  String get verdictGreatMatch => '훌륭한 매치';

  @override
  String get verdictPotential => '가능성 있음';

  @override
  String get verdictKarmic => '카르마적 교훈';

  @override
  String get createChannelTitle => '방송 만들기';

  @override
  String get channelNameLabel => '방송 이름';

  @override
  String get channelNameHint => '예: \'매일 타로 운세\'';

  @override
  String get errorChannelNameEmpty => '이름은 비워둘 수 없습니다';

  @override
  String get channelHandleLabel => '고유 ID (@handle)';

  @override
  String get errorChannelHandleShort => 'ID는 4자 이상이어야 합니다';

  @override
  String get channelDescriptionLabel => '설명';

  @override
  String get channelDescriptionHint => '채널에 대해 소개해 주세요...';

  @override
  String get errorChannelDescriptionEmpty => '설명을 추가해 주세요';

  @override
  String get createButton => '만들기';

  @override
  String get editProfileTitle => '프로필 수정';

  @override
  String get profileNotFoundError => '오류: 프로필을 찾을 수 없음';

  @override
  String get profileSavedSuccess => '프로필이 성공적으로 저장되었습니다!';

  @override
  String get saveError => '저장 오류';

  @override
  String get avatarUploadError => '사진 업로드 오류';

  @override
  String get nameLabel => '이름';

  @override
  String get bioLabel => '소개';

  @override
  String get birthDataTitle => '출생 데이터';

  @override
  String get birthDataWarning => '이 데이터를 변경하면 점성술 및 수비학 포트폴리오가 완전히 다시 계산됩니다.';

  @override
  String get birthDateLabel => '생년월일';

  @override
  String get birthPlaceLabel => '출생지';

  @override
  String get errorUserNotFound => '오류: 사용자를 찾을 수 없음';

  @override
  String get feedUpdateError => '피드 업데이트 오류';

  @override
  String get feedEmptyMessage => '피드가 비어 있습니다.\n아래로 당겨 새로 고치세요.';

  @override
  String get whereToSearch => '검색 위치';

  @override
  String get searchNearby => '근처';

  @override
  String get searchCity => '도시';

  @override
  String get searchCountry => '국가';

  @override
  String get searchWorld => '전 세계';

  @override
  String get ageLabel => '나이';

  @override
  String get showGenderLabel => '표시';

  @override
  String get genderAll => '모두';

  @override
  String get zodiacFilterLabel => '별자리 요소';

  @override
  String get resetFilters => '초기화';

  @override
  String get applyFilters => '적용';

  @override
  String get forecastLoadError => '운세를 로드하지 못했습니다.\n나중에 다시 시도해 주세요.';

  @override
  String get noForecastEvents => '오늘은 중요한 점성학적 사건이 없습니다.\n평온한 하루!';

  @override
  String get unlockFullForecast => '전체 운세 잠금 해제';

  @override
  String get myFriendsTab => '내 친구';

  @override
  String get friendRequestsTab => '요청';

  @override
  String get noFriendsYet => '아직 친구가 없습니다. 검색에서 찾아보세요!';

  @override
  String get noFriendRequests => '새로운 요청이 없습니다.';

  @override
  String get removeFriend => '친구 삭제';

  @override
  String get gamesComingSoonTitle => '게임 및 보상 곧 출시!';

  @override
  String get gamesComingSoonDesc =>
      '흥미진진한 미니 게임과 퀴즈를 준비하고 있습니다. 궁합을 확인하고 \"별가루\"를 모아 프리미엄 데이나 특별한 선물로 교환하세요!';

  @override
  String get joinTelegramButton => 'Telegram에서 가장 먼저 소식을 받아보세요';

  @override
  String horoscopeForSign(Object sign) {
    return '$sign 별자리 운세';
  }

  @override
  String get horoscopeGeneral => '종합';

  @override
  String get horoscopeLove => '연애';

  @override
  String get horoscopeBusiness => '비즈니스';

  @override
  String get verdictNotFound => '결과를 찾을 수 없음';

  @override
  String get vedicCompatibilityTitle => '베다 궁합';

  @override
  String get ashtaKutaAnalysis => '상세 분석 (Ashta-Kuta)';

  @override
  String get noDescription => '설명을 찾을 수 없습니다.';

  @override
  String get likesYouEmpty => '당신에게 관심 있는 사람들이 여기에 표시됩니다';

  @override
  String peopleLikeYou(Object count) {
    return '$count명이 당신을 좋아합니다!';
  }

  @override
  String get getProToSeeLikes => 'PRO 상태를 얻어 프로필을 확인하고 대화를 시작하세요.';

  @override
  String get seeLikesButton => '좋아요 보기';

  @override
  String get someone => '누군가';

  @override
  String get selectCityTitle => '도시 선택';

  @override
  String get searchCityHint => '도시 이름을 입력하세요...';

  @override
  String get nothingFound => '결과 없음';

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
  String get moderationProposedPosts => '제안된 게시물';

  @override
  String get noProposedPosts => '제안된 게시물이 없습니다.';

  @override
  String get from => '보낸 사람';

  @override
  String get personalNumerologyTitle => '개인 수비학';

  @override
  String get dataNotLoaded => '데이터 로드 실패';

  @override
  String get loading => '로딩 중...';

  @override
  String get lifePathNumber => '인생 경로 숫자';

  @override
  String get corePersonality => '핵심 성격';

  @override
  String get destinyNumber => '운명 숫자';

  @override
  String get soulNumber => '영혼의 숫자';

  @override
  String get personalityNumber => '성격 숫자';

  @override
  String get timeInfluence => '시간의 영향';

  @override
  String get maturityNumber => '성숙 숫자';

  @override
  String get birthdayNumber => '생일 숫자';

  @override
  String get currentVibrationsPro => '현재 진동 (PRO)';

  @override
  String get personalYear => '개인 년';

  @override
  String get personalMonth => '개인 월';

  @override
  String get personalDay => '개인 일';

  @override
  String get proVibrationsDesc => '년, 월, 일의 진동을 확인하세요. 프리미엄에서만 이용 가능합니다.';

  @override
  String get unlockButton => '잠금 해제';

  @override
  String get tapForDetails => '자세히 보기';

  @override
  String oracle_weather_desc(Object desc, Object kp) {
    return '$desc (Kp: $kp)';
  }

  @override
  String oracle_geomagnetic_now(Object desc) {
    return '현재: $desc';
  }

  @override
  String oracle_geomagnetic_index(Object kp) {
    return 'Kp 지수: $kp';
  }

  @override
  String get oracle_question_title => '오라클에게 질문';

  @override
  String get oracle_question_hint => '무엇이 걱정되나요?...';

  @override
  String get oracle_question_button => '답변 받기';

  @override
  String get palmistry_analysis_title => '손금 분석';

  @override
  String get palmistry_choose_option => '가장 적합한 옵션을 선택하세요:';

  @override
  String get palmistry_analysis_saved => '분석 저장됨!';

  @override
  String get palmistry_view_report => '전체 보고서 보기';

  @override
  String get palmistry_complete_all => '모든 선 분석 완료하기';

  @override
  String get palmistry_analysis_complete => '좋아요! 분석 완료.';

  @override
  String palmistry_tap_line(Object lineName) {
    return '\'$lineName\'을(를) 탭하여 손바닥과 비교하세요.';
  }

  @override
  String palmistry_searching_line(Object lineName) {
    return '\'$lineName\' 검색 중...';
  }

  @override
  String get palmistry_preparing => '분석 준비 중...';

  @override
  String get palmistry_report_title => '운명의 지도';

  @override
  String get palmistry_data_not_found => '분석 데이터를 찾을 수 없습니다.';

  @override
  String get palmistry_strong_traits => '당신의 강점';

  @override
  String get privacy => '개인정보 보호';

  @override
  String get palmistry_show_in_profile => '프로필에 내 특성 표시';

  @override
  String get palmistry_show_in_profile_desc =>
      '다른 사람들이 당신을 더 잘 알 수 있게 하고 궁합 매칭을 개선합니다.';

  @override
  String get palmistry_interpretation => '손금 해석';

  @override
  String palmistry_your_choice(Object choice) {
    return '당신의 선택: \"$choice\"';
  }

  @override
  String get photoAlbumComingSoon => '곧 여기에 사진을 업로드할 수 있습니다.';

  @override
  String get settingsTitle => '설정';

  @override
  String get accountManagement => '계정 관리';

  @override
  String get changePassword => '비밀번호 변경';

  @override
  String get restorePassword => '비밀번호 재설정';

  @override
  String get editProfileButton => '프로필 수정';

  @override
  String get dailyNotifications => '일일 알림';

  @override
  String get alertsTitle => '알림';

  @override
  String get geomagneticStorms => '지자기 폭풍';

  @override
  String get adminPanelTitle => '관리자 패널';

  @override
  String get adminManageUsers => '사용자 관리';

  @override
  String get offerAgreementLink => '이용 약관';

  @override
  String get accountSectionTitle => '계정';

  @override
  String get deleteAccountButton => '계정 삭제';

  @override
  String get closeAppButton => '앱 종료';

  @override
  String get changePasswordDesc => '보안을 위해 현재 비밀번호를 입력하세요.';

  @override
  String get currentPasswordLabel => '현재 비밀번호';

  @override
  String get newPasswordLabel => '새 비밀번호';

  @override
  String get passwordChangedSuccess => '비밀번호가 성공적으로 변경되었습니다!';

  @override
  String resetPasswordInstruction(String email) {
    return '비밀번호 재설정 지침을 이메일로 보내드립니다:\n\n$email';
  }

  @override
  String get signOutDialogTitle => '로그아웃';

  @override
  String get signOutDialogContent => '정말 로그아웃하시겠습니까?';

  @override
  String get deleteAccountTitle => '계정을 삭제하시겠습니까?';

  @override
  String get deleteAccountWarning =>
      '이 작업은 되돌릴 수 없습니다. 모든 데이터, 채팅, 사진 및 구매 내역이 영구적으로 삭제됩니다.';

  @override
  String get deleteForeverButton => '영구 삭제';

  @override
  String get roulette_trust_fate => '운명을 믿으세요';

  @override
  String get roulette_desc_short => '별들이 가장 잘 맞는 파트너를 선택합니다 (85% 이상!).';

  @override
  String get roulette_no_candidates => '돌릴 후보가 없습니다.';

  @override
  String get roulette_winner_title => '별들이 선택했습니다!';

  @override
  String get roulette_spin_again => '다시 돌리기';

  @override
  String get roulette_go_to_profile => '프로필로 이동';

  @override
  String get cityNotSpecified => '도시 미지정';

  @override
  String get geomagnetic_calm => '평온';

  @override
  String get geomagnetic_unsettled => '불안정';

  @override
  String get geomagnetic_active => '활발';

  @override
  String get geomagnetic_storm_minor => '약한 폭풍 (G1)';

  @override
  String get geomagnetic_storm_moderate => '중간 폭풍 (G2)';

  @override
  String get geomagnetic_storm_strong => '강한 폭풍 (G3)';

  @override
  String get geomagnetic_storm_severe => '매우 강한 폭풍 (G4)';

  @override
  String get geomagnetic_storm_extreme => '극한 폭풍 (G5)';

  @override
  String get deleteChatTitle => '채팅을 삭제하시겠습니까?';

  @override
  String get deleteChatConfirmation => '모든 메시지가 영구적으로 삭제됩니다.';

  @override
  String get chatDeleted => '채팅이 삭제되었습니다';
}
