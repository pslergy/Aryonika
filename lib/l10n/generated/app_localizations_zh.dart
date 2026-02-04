// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get profileCreationErrorTitle => '个人资料创建失败';

  @override
  String get profileCreationErrorDescription => '抱歉，保存您的数据时出错。请重试注册。';

  @override
  String get tryAgain => '重试';

  @override
  String get connectingHearts => '连接宇宙中的心灵...';

  @override
  String get appName => 'Aryonika';

  @override
  String get exitConfirmationTitle => '确认';

  @override
  String get exitConfirmationContent => '您确定要关闭 Aryonika 吗？';

  @override
  String get cancel => '取消';

  @override
  String get close => '关闭';

  @override
  String get paymentUrlError => '错误：未找到支付 URL。';

  @override
  String get channelIdError => '错误：未找到频道 ID。';

  @override
  String documentLoadError(Object error) {
    return 'Ошибка загрузки документа: $error';
  }

  @override
  String get partnerIdError => '错误：计算兼容性需要伴侣 ID。';

  @override
  String get bioPlaceholder => '这里可以写你的故事...';

  @override
  String photoAlbumTitle(Object photoCount) {
    return '相册 ($photoCount)';
  }

  @override
  String get photoAlbumSubtitle => '你最美好的瞬间';

  @override
  String get cosmicEventsTitle => '宇宙事件';

  @override
  String get cosmicEventsSubtitle => '了解行星的影响';

  @override
  String get inviteFriendTitle => '邀请朋友';

  @override
  String get inviteFriendSubtitle => '一起获得奖励';

  @override
  String get gameCenterTitle => '游戏中心';

  @override
  String get gameCenterSubtitle => '小游戏和任务';

  @override
  String get personalForecastTitle => '个人预测';

  @override
  String get personalForecastSubtitlePro => '今日行运分析';

  @override
  String get personalForecastSubtitleFree => 'PRO会员可用';

  @override
  String get cosmicPassportTitle => '宇宙护照';

  @override
  String get numerologyPortraitTitle => '数字命理画像';

  @override
  String get yourNumbersOfDestinyTitle => '你的命运数字';

  @override
  String get yourNumbersOfDestinySubtitle => '揭开你的潜力';

  @override
  String get numerologyPath => '路径';

  @override
  String get numerologyDestiny => '命运';

  @override
  String get numerologySoul => '灵魂';

  @override
  String get signOut => '退出账户';

  @override
  String get calculatingChart => '正在计算星盘...';

  @override
  String get astroDataSignMissing => '缺少此星座的数据。';

  @override
  String astroDataDescriptionNotFound(Object signName) {
    return '未找到“$signName”的描述。';
  }

  @override
  String astroDataMapNotLoaded(Object mapKey) {
    return '未加载“$mapKey”的数据。';
  }

  @override
  String get planetSun => '太阳';

  @override
  String get planetMoon => '月亮';

  @override
  String get planetAscendant => '上升星座';

  @override
  String get planetMercury => '水星';

  @override
  String get planetVenus => '金星';

  @override
  String get planetMars => '火星';

  @override
  String get planetSaturn => '土星';

  @override
  String get planetJupiter => '木星';

  @override
  String get planetUranus => '天王星';

  @override
  String get planetNeptune => '海王星';

  @override
  String get planetPluto => '冥王星';

  @override
  String get getProTitle => '获取PRO';

  @override
  String get getProSubtitle => '解锁所有功能';

  @override
  String get proStatusActive => 'PRO状态已激活';

  @override
  String get proStatusExpired => '状态已过期';

  @override
  String proStatusDaysLeft(Object days) {
    return '剩余天数：$days';
  }

  @override
  String proStatusHoursLeft(Object hours) {
    return '剩余小时数：$hours';
  }

  @override
  String get proStatusExpiresToday => '今天到期';

  @override
  String astroDialogTitle(Object planetName, Object signName) {
    return '$planetName 在 $signName';
  }

  @override
  String get likesYouTitle => '喜欢你';

  @override
  String likesYouTotal(Object count) {
    return '总喜欢数：$count';
  }

  @override
  String get likesYouNone => '暂时没有喜欢';

  @override
  String reportOnUser(Object userName) {
    return '举报 $userName';
  }

  @override
  String get reportReasonSpam => '垃圾信息';

  @override
  String get reportReasonInsultingBehavior => '侮辱性行为';

  @override
  String get reportReasonScam => '诈骗';

  @override
  String get reportReasonInappropriateContent => '不当内容';

  @override
  String get reportDetailsHint => '更多细节（可选）';

  @override
  String get send => '发送';

  @override
  String get reportSentSnackbar => '谢谢！您的举报已发送。';

  @override
  String get profileLoadError => '无法加载个人资料';

  @override
  String get back => '返回';

  @override
  String get report => '举报';

  @override
  String userProfilePhotoAlbumTitle(Object photoCount) {
    return '相册 ($photoCount)';
  }

  @override
  String get userProfileViewPhotos => '查看照片';

  @override
  String get aboutMe => '关于我';

  @override
  String get bioEmpty => '用户没有介绍自己。';

  @override
  String get cosmicPassport => '宇宙护照';

  @override
  String sunInSign(Object signName) {
    return '☀️ 太阳在 $signName';
  }

  @override
  String get friendshipStatusFriends => '你们是朋友';

  @override
  String get friendshipRemoveTitle => '从朋友中删除？';

  @override
  String friendshipRemoveContent(Object userName) {
    return '您确定要从朋友中删除 $userName 吗？';
  }

  @override
  String get remove => '删除';

  @override
  String get friendshipStatusRequestSent => '请求已发送';

  @override
  String get friendshipActionDecline => '拒绝';

  @override
  String get friendshipActionAccept => '接受';

  @override
  String get friendshipActionAdd => '加为好友';

  @override
  String likeSnackbarSuccess(Object userName) {
    return '你喜欢了 $userName！';
  }

  @override
  String likeSnackbarAlreadyLiked(Object userName) {
    return '你已经喜欢过 $userName';
  }

  @override
  String get writeMessage => '发送消息';

  @override
  String get checkCompatibility => '检查兼容性';

  @override
  String get yourCosmicInfluence => '你今天的宇宙影响';

  @override
  String get cosmicEventsLoading => '正在计算宇宙事件...';

  @override
  String get cosmicEventsEmpty => '今天宇宙平静。享受和谐吧！';

  @override
  String get cosmicEventsError => '无法计算宇宙事件。请稍后再试。';

  @override
  String get cosmicConnectionTitle => '宇宙连接';

  @override
  String shareText(Object name, Object score) {
    return '我们与 $name 的兼容性为 $score%！✨\n在 Aryonika 计算';
  }

  @override
  String get shareErrorSnackbar => '尝试分享时出错。';

  @override
  String get compatibilityErrorTitle => '无法计算兼容性';

  @override
  String get compatibilityErrorSubtitle => '可能是伴侣的数据不完整或发生了网络错误。';

  @override
  String get goBack => '返回';

  @override
  String get sectionCosmicAdvice => '宇宙建议';

  @override
  String get sectionDailyInfluence => '每日影响';

  @override
  String get sectionAstrologicalResonance => '星座共鸣';

  @override
  String get sectionNumerologyMatrix => '数字命理矩阵';

  @override
  String get sectionPalmistryConnection => '手相联系';

  @override
  String get sectionAboutPerson => '关于此人';

  @override
  String get palmistryNoData => '其中一方尚未完成手相分析。这将开启你们兼容性的新层次！';

  @override
  String palmistryCommonTraits(Object traits) {
    return '你们的共同点是：$traits。这为你们的关系奠定了坚实的基础。';
  }

  @override
  String palmistryUniqueTraits(Object myTrait, Object partnerTrait) {
    return '你们互补：你的特质“$myTrait”与他（她）的“$partnerTrait”完美和谐。';
  }

  @override
  String get harmony => '和谐度';

  @override
  String get adviceRareConnection => '你们的灵魂同频共振。这是一种罕见的宇宙联系，个性和情感都和谐统一。珍惜这份宝藏。';

  @override
  String get advicePassionChallenge =>
      '你们之间充满激情，但个性可能会冲突。学会将争论转化为成长的能量，你们的联系将坚不可摧。';

  @override
  String get adviceBestFriends =>
      '你们是最好的朋友，彼此心有灵犀，感觉舒适。身体上的吸引力可能会随着时间增强，最重要的是你们精神上的亲近。';

  @override
  String get adviceKarmicLesson =>
      '你们的相遇并非偶然。这段关系为双方都带来了重要的课题。保持耐心和开放，去理解你们需要互相教导什么。';

  @override
  String get adviceGreatPotential =>
      '你们之间有强烈的吸引力和巨大的成长潜力。互相学习，你们的联系会变得更强。星星在你们这边。';

  @override
  String get adviceBase => '互相了解。每一次相遇都是发现一个新宇宙的机会。你们的故事才刚刚开始。';

  @override
  String get dailyInfluenceCalm => '宇宙风平浪静。今天非常适合不受外界影响地享受彼此的陪伴。';

  @override
  String get dailyAdviceFavorable => '建议：利用这股能量！这是制定共同计划的绝佳时机。';

  @override
  String get dailyAdviceTense => '建议：对彼此多一些耐心。可能会有误解。';

  @override
  String get proFeatureLocked => '此方面的详细分析在PRO版本中提供。';

  @override
  String get getProButton => '获取PRO';

  @override
  String get numerologyLifePath => '生命路径';

  @override
  String get numerologyDestinyNumber => '命运数字';

  @override
  String get numerologySoulNumber => '灵魂数字';

  @override
  String get shareCardTitle => 'Aryonika';

  @override
  String get shareCardSubtitle => '宇宙兼容性报告';

  @override
  String get shareCardHarmony => '总和谐度';

  @override
  String get shareCardPersonalityHarmony => '个性和谐度 (太阳)';

  @override
  String get shareCardLifePath => '生命路径 (数字命理学)';

  @override
  String get shareCardCtaTitle => '发现你的宇宙\n兼容性！';

  @override
  String get shareCardCtaSubtitle => '在应用商店下载 Aryonika';

  @override
  String get loginTitle => '登录账户';

  @override
  String get loginError => '登录失败';

  @override
  String get passwordResetTitle => '重置密码';

  @override
  String get passwordResetContent => '请输入您的电子邮箱，我们将向您发送重置密码的说明。';

  @override
  String get emailLabel => '电子邮箱';

  @override
  String get sendButton => '发送';

  @override
  String get emailValidationError => '请输入有效的电子邮箱。';

  @override
  String get passwordResetSuccess => '邮件已发送！请检查您的收件箱。';

  @override
  String get passwordLabel => '密码';

  @override
  String get loginButton => '登录';

  @override
  String get forgotPasswordButton => '忘记密码？';

  @override
  String get noAccountButton => '没有账户？创建';

  @override
  String get registerTitle => '创建账户';

  @override
  String get unknownError => '发生未知错误';

  @override
  String get confirmPasswordLabel => '确认密码';

  @override
  String get privacyPolicyCheckbox => '我已阅读并接受 ';

  @override
  String get termsOfUseLink => '使用条款';

  @override
  String get and => ' 和 ';

  @override
  String get privacyPolicyLink => '隐私政策';

  @override
  String get registerButton => '注册';

  @override
  String get alreadyHaveAccountButton => '已有账户？登录';

  @override
  String get welcomeTagline => '你的命运写在星辰里';

  @override
  String get welcomeCreateAccountButton => '创建宇宙护照';

  @override
  String get welcomeLoginButton => '我已有账户';

  @override
  String get introSlide1Title => 'Aryonika - 不仅仅是约会';

  @override
  String get introSlide1Description => '通过占星术、数字命理学和命运卡牌，发现兼容性的新维度。';

  @override
  String get introSlide2Title => '你的宇宙护照';

  @override
  String get introSlide2Description => '了解你的全部潜力，找到那个能补全你宇宙的人。';

  @override
  String get introSlide3Title => '加入银河系';

  @override
  String get introSlide3Description => '立即开始你寻找真爱的宇宙之旅。';

  @override
  String get introButtonSkip => '跳过';

  @override
  String get introButtonNext => '下一步';

  @override
  String get introButtonStart => '开始';

  @override
  String get onboardingNameTitle => '你叫什么名字？';

  @override
  String get onboardingNameSignOutTooltip => '退出（测试用）';

  @override
  String get onboardingNameSubtitle => '其他用户将看到这个名字。';

  @override
  String get onboardingNameLabel => '你的名字';

  @override
  String get onboardingBioLabel => '介绍一下你自己';

  @override
  String get onboardingBioHint => '例如：我喜欢占星术和#旅行...';

  @override
  String get onboardingButtonNext => '下一步';

  @override
  String get onboardingBirthdateTitle => '你什么时候出生？';

  @override
  String get onboardingBirthdateSubtitle => '为了准确计算你的出生星盘和数字命理，这是必需的。';

  @override
  String get datePickerHelpText => '选择出生日期';

  @override
  String get birthdateLabel => '出生日期';

  @override
  String get birthdatePlaceholder => '点击选择';

  @override
  String get dateFormat => 'yyyy年M月d日';

  @override
  String get onboardingFinishText1 => '正在分析星辰位置...';

  @override
  String get onboardingFinishText2 => '正在计算你的数字命理代码...';

  @override
  String get onboardingFinishText3 => '正在核对命运卡牌...';

  @override
  String get onboardingFinishText4 => '正在创建你的宇宙护照...';

  @override
  String get onboardingFinishErrorTitle => '错误';

  @override
  String get onboardingFinishErrorContent => '发生未知错误。';

  @override
  String get onboardingFinishErrorButton => '返回';

  @override
  String get onboardingGenderTitle => '你的性别';

  @override
  String get onboardingGenderSubtitle => '这将帮助我们为你找到最合适的人。';

  @override
  String get genderMale => '男性';

  @override
  String get genderFemale => '女性';

  @override
  String get onboardingLocationTitle => '出生地';

  @override
  String get onboardingLocationSubtitle => '请指明你出生的城市。这对准确的占星计算是必需的。';

  @override
  String get onboardingLocationSearchHint => '开始输入城市...';

  @override
  String get onboardingLocationNotFound => '未找到城市。请尝试其他查询。';

  @override
  String get onboardingLocationStartSearch => '开始搜索以查看结果';

  @override
  String get onboardingLocationSelectFromList => '从以上列表中选择一个城市以继续';

  @override
  String get onboardingTimeTitle => '出生时间';

  @override
  String get onboardingTimeSubtitle => '如果你不知道确切时间，请输入12:00。这仍然会得到很好的结果。';

  @override
  String get timePickerHelpText => '指定出生时间';

  @override
  String get birthTimeLabel => '出生时间';

  @override
  String get onboardingButtonNextLocation => '下一步（选择地点）';

  @override
  String get alphaBannerTitle => 'Alpha 版本';

  @override
  String get alphaBannerContent =>
      '此部分正在积极开发中。某些功能可能不稳定。我们正在积极进行本地化工作，因此部分文本可能仍为英语。感谢您的理解！';

  @override
  String get alphaBannerFeedback => '欢迎在我们的 Telegram 频道提出您的意见和建议！';

  @override
  String get astro_title_sun => '个性兼容性 (太阳)';

  @override
  String get astro_title_moon => '情感兼容性 (月亮)';

  @override
  String get astro_title_chemistry => '占星化学反应 (金星-火星)';

  @override
  String get astro_title_mercury => '沟通风格 (水星)';

  @override
  String get astro_title_saturn => '长期前景 (土星)';

  @override
  String get numerology_title => '数字命理共鸣';

  @override
  String get cosmicPulseTitle => '宇宙脉搏';

  @override
  String get feedIceBreakerTitle => '破冰船';

  @override
  String get feedOrbitCrossingTitle => '轨道交叉';

  @override
  String get feedSpiritualNeighborTitle => '精神邻居';

  @override
  String get feedGeomagneticStormTitle => '地磁风暴';

  @override
  String get feedCompatibilityPeakTitle => '兼容性高峰';

  @override
  String get feedNewChannelSuggestionTitle => '新频道推荐';

  @override
  String get feedPopularPostTitle => '热门帖子';

  @override
  String get feedNewCommentTitle => '新评论';

  @override
  String get cardOfTheDayTitle => '今日卡牌';

  @override
  String get cardOfTheDayDrawing => '正在抽取你的卡牌...';

  @override
  String get cardOfTheDayGetButton => '抽卡';

  @override
  String get cardOfTheDayYourCard => '你的今日卡牌';

  @override
  String get cardOfTheDayTapToReveal => '点击揭示';

  @override
  String get cardOfTheDayReversedSuffix => ' (逆位)';

  @override
  String get cardOfTheDayDefaultInterpretation => '看看今天会发生什么。';

  @override
  String get channelSearchTitle => '搜索直播';

  @override
  String get channelAnonymousAuthor => '匿名';

  @override
  String get errorUserNotAuthorized => '用户未授权';

  @override
  String get errorUnknownServer => '未知服务器错误';

  @override
  String get errorFailedToLoadData => '无法加载数据';

  @override
  String get generalHello => '你好';

  @override
  String get referralErrorProfileNotLoaded => '错误：你的个人资料未加载。请稍后再试。';

  @override
  String get referralErrorAlreadyUsed => '你已经使用过邀请码。';

  @override
  String get referralErrorOwnCode => '不能使用自己的代码。';

  @override
  String get referralScreenTitle => '邀请朋友';

  @override
  String get referralYourCodeTitle => '你的邀请码';

  @override
  String get referralYourCodeDescription =>
      '与朋友分享此代码。每当有朋友输入你的代码，你将获得1天的PRO访问权限！';

  @override
  String get referralCodeCopied => '代码已复制到剪贴板！';

  @override
  String get referralShareCodeButton => '分享代码';

  @override
  String referralShareMessage(String code) {
    return '嗨！加入我在 Aryonika 寻找你的宇宙伴侣。在应用中输入我的邀请码，我们都能获得奖励：$code';
  }

  @override
  String get referralManualBonusNote => 'PRO访问权限将在你的朋友输入代码后的24小时内手动发放。';

  @override
  String get referralGotCodeTitle => '你有邀请码吗？';

  @override
  String get referralGotCodeDescription => '输入朋友给你的代码，让他获得奖励。';

  @override
  String get referralCodeInputLabel => '邀请码';

  @override
  String get referralCodeValidationError => '请输入代码';

  @override
  String get referralApplyCodeButton => '应用代码';

  @override
  String get nav_feed => '动态';

  @override
  String get nav_search => '搜索';

  @override
  String get nav_oracle => '神谕';

  @override
  String get nav_chats => '聊天';

  @override
  String get nav_channels => '频道';

  @override
  String get nav_profile => '个人资料';

  @override
  String get nav_exit => '退出';

  @override
  String get exitDialog_title => '确认';

  @override
  String get exitDialog_content => '您确定要关闭 Aryonika 吗？';

  @override
  String get exitDialog_cancel => '取消';

  @override
  String get exitDialog_confirm => '关闭';

  @override
  String get oracle_limit_title => '请求限制';

  @override
  String get oracle_limit_later => '稍后';

  @override
  String get oracle_limit_get_pro => '获取无限版';

  @override
  String get oracle_orb_partner => '今日伴侣';

  @override
  String get oracle_orb_roulette => '轮盘';

  @override
  String get oracle_orb_duet => '二重奏';

  @override
  String get oracle_orb_horoscope => '运势';

  @override
  String get oracle_orb_weather => '地磁';

  @override
  String get oracle_orb_ask => '提问';

  @override
  String get oracle_orb_focus => '今日焦点';

  @override
  String get oracle_orb_forecast => '星象预测';

  @override
  String get oracle_orb_card => '今日卡牌';

  @override
  String get oracle_orb_tarot => '宇宙的答案';

  @override
  String get oracle_orb_palmistry => '手相';

  @override
  String get oracle_duet_title => '宇宙二重奏';

  @override
  String get oracle_duet_description => '按出生日期检查兼容性。';

  @override
  String get oracle_duet_button => '检查兼容性';

  @override
  String oracle_unsupported_web_feature(String featureName, Object feature) {
    return '网页版暂不支持。';
  }

  @override
  String get oracle_pro_card_of_day_title => '今日卡牌 (PRO)';

  @override
  String get oracle_pro_card_of_day_desc => '发现你今天的能量。仅限 PRO。';

  @override
  String get oracle_pro_focus_of_day_title => '今日焦点 (PRO)';

  @override
  String get oracle_pro_focus_of_day_desc => '了解今天该关注什么。仅限 PRO。';

  @override
  String get oracle_pro_forecast_of_day_title => '个人预测 (PRO)';

  @override
  String get oracle_pro_forecast_of_day_desc => '详细的行运分析。仅限 PRO。';

  @override
  String get oracle_roulette_title => '宇宙轮盘';

  @override
  String get oracle_roulette_description => '试试运气！寻找随机伴侣。';

  @override
  String get oracle_roulette_button => '旋转轮盘';

  @override
  String get oracle_card_of_day_reversed => '（逆位）';

  @override
  String get oracle_card_of_day_get_key => '了解个人关键';

  @override
  String get oracle_palmistry_title => '手相';

  @override
  String get oracle_palmistry_description => 'AI手相分析。';

  @override
  String get oracle_palmistry_button => '扫描手掌';

  @override
  String get oracle_ask_loading => '神谕思考中...';

  @override
  String get oracle_ask_again => '再次提问';

  @override
  String get oracle_focus_loading => '聚焦中...';

  @override
  String get oracle_focus_error => '加载错误';

  @override
  String get oracle_focus_no_data => '无数据';

  @override
  String get oracle_forecast_loading => '正在为你制定个人预测...';

  @override
  String get oracle_forecast_error => '无法制定预测';

  @override
  String get oracle_forecast_try_again => '重试';

  @override
  String get oracle_forecast_title => '每日预测';

  @override
  String get oracle_forecast_day_number => '你的今日数字：';

  @override
  String get oracle_tarot_title => '塔罗解读 (AI)';

  @override
  String get oracle_tarot_hint => '你的问题...';

  @override
  String get oracle_tarot_button => '开始解读';

  @override
  String oracle_tarot_your_question(String question) {
    return '你的问题：$question';
  }

  @override
  String get oracle_tarot_loading => 'AI 正在分析...';

  @override
  String get oracle_tarot_ask_again => '再次提问';

  @override
  String get oracle_tarot_card_reversed_short => '（逆）';

  @override
  String get oracle_tarot_combo_message => '卡牌的总体信息：';

  @override
  String get oracle_geomagnetic_title => '太空天气';

  @override
  String get oracle_geomagnetic_forecast => '未来预报';

  @override
  String get oracle_weather_title => '地磁活动';

  @override
  String get oracle_pro_feature_title => '今日伴侣 (PRO)';

  @override
  String get oracle_pro_feature_desc => '我们为你寻找完美伴侣。PRO 可用。';

  @override
  String get oracle_partner_loading => '正在寻找伴侣...';

  @override
  String get oracle_partner_error => '搜索错误';

  @override
  String get oracle_partner_not_found => '未找到伴侣';

  @override
  String get oracle_partner_profile_error => '个人资料错误';

  @override
  String get oracle_partner_title => '你的今日伴侣';

  @override
  String oracle_partner_compatibility(String score) {
    return '兼容性：$score%';
  }

  @override
  String get oracle_ask_title => '询问神谕';

  @override
  String get oracle_ask_hint => '你关心什么？...';

  @override
  String get oracle_ask_button => '获取答案';

  @override
  String get oracle_tips_loading => '加载提示...';

  @override
  String get oracle_tips_title => '今日星象提示';

  @override
  String oracle_tips_subtitle(String count) {
    return '用于沟通 ($count)';
  }

  @override
  String get oracle_tips_general_advice => '保持开放和真诚。';

  @override
  String get cardOfTheDayProInApp => '✨ 个人方面在移动应用中可用。';

  @override
  String get numerology_report_title => '数字命理报告';

  @override
  String get numerology_report_overall => '总分';

  @override
  String get numerology_report_you => '你';

  @override
  String get numerology_report_partner => '伴侣';

  @override
  String get userProfile_numerology_button => '数字命理';

  @override
  String get forecast_astrological_title => '占星预测';

  @override
  String get forecast_loading => '加载预测...';

  @override
  String get forecast_error => '加载错误';

  @override
  String get forecast_no_aspects => '无重要相位';

  @override
  String get cosmicEvents_title => '宇宙事件';

  @override
  String get cosmicEvents_loading_error => '无法加载事件';

  @override
  String get cosmicEvents_no_events => '没有即将发生的事件';

  @override
  String get cosmicEvents_paywall_title => '个人宇宙事件';

  @override
  String get cosmicEvents_paywall_description => '获取基于行星对您出生星盘影响的独家建议。';

  @override
  String get cosmicEvents_paywall_button => '获取PRO身份';

  @override
  String get cosmicEvents_personal_focus => '您的个人焦点：';

  @override
  String get cosmicEvents_pro_placeholder => '通过PRO状态了解此事件的个人影响';

  @override
  String get search_no_one_found => '在银河系的这个区域\n没有发现任何人。';

  @override
  String get chat_error_user_not_found => '错误：未找到用户';

  @override
  String get chat_start_with_hint => '从提示开始';

  @override
  String get chat_date_format => 'y年M月d日';

  @override
  String get chat_group_member => '名成员';

  @override
  String get chat_group_members_2_4 => '名成员';

  @override
  String get chat_group_members_5_0 => '名成员';

  @override
  String get chat_online_status_long_ago => '很久以前在线';

  @override
  String get chat_online_status_online => '在线';

  @override
  String chat_online_status_minutes_ago(String minutes) {
    return '$minutes分钟前在线';
  }

  @override
  String chat_online_status_today_at(String time) {
    return '今天 $time 在线';
  }

  @override
  String chat_online_status_yesterday_at(String time) {
    return '昨天 $time 在线';
  }

  @override
  String chat_online_status_date(String date) {
    return '$date 在线';
  }

  @override
  String get chat_delete_dialog_title => '删除聊天？';

  @override
  String get chat_delete_dialog_content => '此聊天将为您和您的对话伙伴删除。此操作不可逆。';

  @override
  String get chat_delete_dialog_confirm => '删除';

  @override
  String chat_report_dialog_title(String name) {
    return '举报 $name';
  }

  @override
  String get chat_report_details_hint => '更多细节（可选）';

  @override
  String get chat_report_sent_snackbar => '谢谢！您的举报已发送。';

  @override
  String get chat_menu_report => '举报';

  @override
  String get chat_menu_delete => '删除聊天';

  @override
  String get chat_group_title_default => '群聊';

  @override
  String get chat_group_participants => '成员';

  @override
  String get chat_message_old => '来自旧版本的消息';

  @override
  String get chat_input_hint => '消息...';

  @override
  String get chat_temp_warning_remaining => '此临时聊天将在...后删除';

  @override
  String get chat_temp_warning_expired => '聊天已过期';

  @override
  String get chat_temp_warning_less_than_24h => '不到24小时';

  @override
  String get encrypted_chat_banner_title => '聊天受端到端加密保护';

  @override
  String get encrypted_chat_banner_desc =>
      '此聊天中的消息受端到端加密保护。包括Aryonika管理员在内的任何人都无法读取它们。';

  @override
  String get search_hint => '按姓名、简介搜索...';

  @override
  String get search_tooltip_swipes => '滑动';

  @override
  String get search_tooltip_cosmic_web => '宇宙之网';

  @override
  String get search_tooltip_star_map => '星图';

  @override
  String get search_tooltip_filters => '筛选';

  @override
  String get search_star_map_placeholder => '星图正在开发中...';

  @override
  String get search_priority_header => '最佳匹配';

  @override
  String get search_other_header => '其他用户';

  @override
  String get payment_title => '支持项目';

  @override
  String get payment_success_snackbar => '感谢您的支持！正在更新您的状态...';

  @override
  String get payment_fail_snackbar => '处理捐赠失败。请重试。';

  @override
  String get paywall_header_title => '解锁Aryonika宇宙';

  @override
  String get paywall_header_subtitle => '支持本项目，即可获得所有宇宙工具，助您寻找完美伴侣，以示感谢。';

  @override
  String get paywall_benefit1_title => '查看谁喜欢了你';

  @override
  String get paywall_benefit1_subtitle => '不要错过相互喜欢的机会，率先开启对话。';

  @override
  String get paywall_benefit2_title => '每日个人预测';

  @override
  String get paywall_benefit2_subtitle => '每日分析您的星体运行和当日焦点。';

  @override
  String get paywall_benefit3_title => '今日伴侣与轮盘';

  @override
  String get paywall_benefit3_subtitle => '让星辰为您选择最合适的伴侣。';

  @override
  String get paywall_benefit4_title => '宇宙的答案';

  @override
  String get paywall_benefit4_subtitle => '提出您的问题，获得宇宙的建议。';

  @override
  String get paywall_benefit5_title => '宇宙天气';

  @override
  String get paywall_benefit5_subtitle => '随时了解地磁暴及其影响。';

  @override
  String get paywall_benefit6_title => '今日卡牌';

  @override
  String get paywall_benefit6_subtitle => '获取来自命运卡牌的每日预测和建议。';

  @override
  String get paywall_donate_button => '支持项目';

  @override
  String get paywall_referral_button => '邀请好友得PRO';

  @override
  String get paywall_referral_subtitle => '每邀请一位通过您的链接注册的朋友，即可获得1天PRO身份。';

  @override
  String paywall_get_pro_button(String price) {
    return '获取 Aryonika PRO ($price)';
  }

  @override
  String get paywall_arbitrary_donate_button => '以其他金额支持';

  @override
  String get paywall_arbitrary_donate_subtitle =>
      '如果您喜欢我们的项目，您可以支持它，帮助我们在鲨鱼和其他捕食者的世界中生存。';

  @override
  String get chinese_zodiac_title => '中国生肖';

  @override
  String get zodiac_Rat => '鼠';

  @override
  String get zodiac_Ox => '牛';

  @override
  String get zodiac_Tiger => '虎';

  @override
  String get zodiac_Rabbit => '兔';

  @override
  String get zodiac_Dragon => '龙';

  @override
  String get zodiac_Snake => '蛇';

  @override
  String get zodiac_Horse => '马';

  @override
  String get zodiac_Goat => '羊';

  @override
  String get zodiac_Monkey => '猴';

  @override
  String get zodiac_Rooster => '鸡';

  @override
  String get zodiac_Dog => '狗';

  @override
  String get zodiac_Pig => '猪';

  @override
  String get chinese_zodiac_compatibility_button => '生肖兼容性';

  @override
  String get compatibility_section_title => '兼容性';

  @override
  String get userProfile_astro_button => '占星术';

  @override
  String get userProfile_bazi_button => '八字';

  @override
  String get jyotishCompatibilityTitle => '吠陀兼容性';

  @override
  String get jyotishDetailedAnalysisTitle => '详细分析 (Ashta-Kuta)';

  @override
  String get kuta_tara_name => 'Tara Kuta (命运)';

  @override
  String get kuta_tara_desc => '表示关系中的运气、持续时间和幸福感。这里良好的兼容性就像你们结合的顺风。';

  @override
  String get kuta_yoni_name => 'Yoni Kuta (吸引力)';

  @override
  String get kuta_yoni_desc => '决定身体和性的和谐。高分表示强烈的相互吸引和满足。';

  @override
  String get kuta_graha_maitri_name => 'Graha Maitri (友谊)';

  @override
  String get kuta_graha_maitri_desc => '心理兼容性和友谊。反映你们的人生观有多相似，以及你们是否容易找到共同点。';

  @override
  String get kuta_vashya_name => 'Vashya Kuta (相互控制)';

  @override
  String get kuta_vashya_desc => '显示伴侣之间相互影响和磁性的程度。谁将是领导者，谁是追随者。';

  @override
  String get kuta_gana_name => 'Gana Kuta (气质)';

  @override
  String get kuta_gana_desc => '气质层面的兼容性（神、人、魔）。有助于避免性格冲突。';

  @override
  String get kuta_bhakoot_name => 'Bhakoot Kuta (爱与家庭)';

  @override
  String get kuta_bhakoot_desc => '最重要的指标之一。负责爱的深度、家庭幸福、财务繁荣和拥有孩子的可能性。';

  @override
  String get kuta_nadi_name => 'Nadi Kuta (健康)';

  @override
  String get kuta_nadi_desc => '最重要的标准。负责伴侣及其后代的健康、基因兼容性和长寿。';

  @override
  String get kuta_varna_name => 'Varna Kuta (灵性)';

  @override
  String get kuta_varna_desc => '反映自我兼容性和伴侣的灵性发展。显示在伴侣中谁更能刺激另一方的成长。';

  @override
  String get jyotishVerdictExcellent =>
      '天作之合！你们的月亮星座完美和谐。这种联系承诺了未来的深刻理解、精神成长和幸福。';

  @override
  String get jyotishVerdictGood => '非常好的兼容性。你们有一切机会建立牢固、和谐和幸福的关系。小分歧很容易克服。';

  @override
  String get jyotishVerdictAverage =>
      '正常兼容性。你们的关系既有优势也有成长的空间。结合的成功将取决于你们为关系努力的意愿。';

  @override
  String get jyotishVerdictChallenging =>
      '具有挑战性的兼容性。你们的星盘表明性格和人生道路存在严重差异。需要很多耐心和妥协才能达到和谐。';

  @override
  String get passwordResetNewPasswordTitle => '设置新密码';

  @override
  String get passwordResetNewPasswordLabel => '新密码';

  @override
  String get passwordResetConfirmLabel => '确认密码';

  @override
  String get passwordValidationError => '密码必须至少包含 6 个字符';

  @override
  String get passwordMismatchError => '密码不匹配';

  @override
  String get saveButton => '保存';

  @override
  String get postActionLike => '赞';

  @override
  String get postActionComment => '评论';

  @override
  String get postActionShare => '分享';

  @override
  String get channelDefaultName => '频道';

  @override
  String postShareText(Object channelName, Object postText) {
    return '查看“$channelName”频道中的这篇帖子: $postText';
  }

  @override
  String get postDeleteDialogTitle => '删除帖子？';

  @override
  String get postDeleteDialogContent => '此操作无法撤销。';

  @override
  String get delete => '删除';

  @override
  String get postMenuDelete => '删除帖子';

  @override
  String get numerologySectionKeyNumbers => '关键数字';

  @override
  String get numerologySectionCurrentVibes => '当前振动';

  @override
  String get numerologyTitleLifePath => '生命路径数';

  @override
  String get numerologyTitleDestiny => '命运数 (表现数)';

  @override
  String get numerologyTitleSoulUrge => '灵魂驱力数';

  @override
  String get numerologyTitlePersonality => '人格数';

  @override
  String get numerologyTitleMaturity => '成熟数';

  @override
  String get numerologyTitleBirthday => '生日数';

  @override
  String get numerologyTitlePersonalYear => '个人年';

  @override
  String get numerologyTitlePersonalMonth => '个人月';

  @override
  String get numerologyTitlePersonalDay => '个人日';

  @override
  String get numerologyErrorNotEnoughData => '计算数据不足。';

  @override
  String get numerologyErrorDescriptionsNotLoaded => '加载命理学描述失败。';

  @override
  String get chat_error_recipient_not_found => '未找到收件人。';

  @override
  String get chat_error_recipient_profile_load_failed => '加载收件人个人资料失败。';

  @override
  String get calculatingNumerology => '正在计算数字命理画像...';

  @override
  String get oracle_title => '神谕';

  @override
  String get verifyEmailBody => '我们已向您的电子邮箱发送了一个 6 位数代码。请在下方输入。';

  @override
  String get verifyEmailHint => '------';

  @override
  String get signOutButton => '退出';

  @override
  String get errorInvalidOrExpiredCode => '代码无效或已过期。';

  @override
  String get errorCodeRequired => '请输入验证码。';

  @override
  String get errorInternalServer => '发生内部服务器错误。请稍后再试。';

  @override
  String get errorCodeLength => '代码必须是 6 位数。';

  @override
  String get verifyEmailTitle => '电子邮箱验证';

  @override
  String get verificationCodeLabel => '验证码';

  @override
  String get verificationCodeResent => '新验证码已发送！';

  @override
  String get resendCodeAction => '重新发送代码';

  @override
  String resendCodeCooldown(int seconds) {
    return '($seconds)秒后重新发送';
  }

  @override
  String verifyEmailInstruction(String email) {
    return '我们已向您的电子邮箱发送了一个 6 位数代码：\n$email\n请在下方输入。';
  }

  @override
  String get confirmButton => '确认';

  @override
  String get logout => '退出';

  @override
  String get numerology_score_high => '高';

  @override
  String get numerology_score_medium => '中';

  @override
  String get numerology_score_low => '低';

  @override
  String get noUsersFound => '未找到用户';

  @override
  String get feature_in_development => '即将推出！';

  @override
  String get download_our_app => '下载我们的应用';

  @override
  String get open_web_version => '打开网页版';

  @override
  String get pay_with_card => '刷卡支付';

  @override
  String get coming_soon => '即将推出';

  @override
  String get paywall_subscription_terms => '订阅自动续费。随时取消。';

  @override
  String get searchHint => 'Поиск...';

  @override
  String get nav_friends => '好友';

  @override
  String get oracle_typing => '输入中...';

  @override
  String get tarot_reversed => '(逆位)';

  @override
  String get common_close => '关闭';

  @override
  String oracle_limit_pro(Object hours) {
    return '剩余 $hours 小时。';
  }

  @override
  String oracle_limit_free(Object days) {
    return '免费额度已用完。剩余 $days 天。';
  }

  @override
  String get oracle_error_stream => '连接错误';

  @override
  String get oracle_error_start => '启动失败';

  @override
  String get error_generic => '发生错误。请稍后再试。';

  @override
  String get referral_already_used => '您已经使用了推荐代码。';

  @override
  String get referral_own_code => '您不能使用自己的代码。';

  @override
  String get referral_success => '代码激活成功！您获得了3天的高级会员资格。';

  @override
  String get tab_astrology => '占星术';

  @override
  String get tab_numerology => '数字命理学';

  @override
  String get tab_bazi => '八字';

  @override
  String get tab_jyotish => '吠陀占星术';

  @override
  String get share_result => '分享结果';

  @override
  String get share_preparing => '准备中...';

  @override
  String locked_feature_title(Object title) {
    return '$title 部分已锁定';
  }

  @override
  String get locked_feature_desc => '此部分仅在高级版中可用。';

  @override
  String get get_access_button => '获取访问权限';

  @override
  String get coming_soon_suffix => '即将推出';

  @override
  String get tab_summary => 'Сводка';

  @override
  String get tab_chinese_zodiac => 'Кит. Зодиак';

  @override
  String get summary_verdict_title => 'Общий вердикт';

  @override
  String get webVersionButton => '网页版';

  @override
  String get uploadPhotoDisclaimer => '上传照片即表示您确认其中不包含裸露或暴力内容。违规者将被永久封禁。';

  @override
  String get iAgree => '我同意';

  @override
  String get testers_banner_title => '招募测试员 (4/20)';

  @override
  String get testers_banner_desc => '帮助我们要改进 Aryonika 并获得\n✨ 终身高级版 ✨';

  @override
  String get testers_email_hint => '(点击打开，长按复制)';

  @override
  String get numerology_day_1 => '新的开始。非常适合启动项目。';

  @override
  String get numerology_day_2 => '伙伴关系之日。寻求妥协。';

  @override
  String get numerology_day_3 => '创造力之日。表达自己。';

  @override
  String get numerology_day_4 => '工作之日。整理你的事务。';

  @override
  String get numerology_day_5 => '变革之日。拥抱新鲜事物。';

  @override
  String get numerology_day_6 => '和谐之日。把时间留给家人。';

  @override
  String get numerology_day_7 => '反思之日。独处和分析的时间。';

  @override
  String get numerology_day_8 => '力量之日。关注事业和财务。';

  @override
  String get numerology_day_9 => '完成之日。放下过去。';

  @override
  String get astro_transit_positive_general =>
      'Звезды на вашей стороне. Действуйте смело.';

  @override
  String get advice_general_balance =>
      'Сохраняйте баланс между чувствами и разумом.';

  @override
  String get astro_advice_listen_intuition => '倾听你内心的声音。';

  @override
  String get astro_advice_act_boldly => '能量有利于大胆行动。';

  @override
  String get astro_advice_rest_and_reflect => '星星建议放慢脚步。';

  @override
  String get astro_advice_connect_with_nature => '在大自然中度过时光。';

  @override
  String get advice_generic_positive => '宇宙今天站在你这边。';

  @override
  String get channelLoadError => '无法加载频道';

  @override
  String get postsTitle => '帖子';

  @override
  String get noPostsYet => '此频道尚无帖子。';

  @override
  String get createPostTooltip => '创建帖子';

  @override
  String get proposePost => '提议新闻';

  @override
  String get channelsTitle => '频道';

  @override
  String get noChannelSubscriptions => '尚无订阅';

  @override
  String get noMessagesYet => '尚无消息';

  @override
  String get yesterday => '昨天';

  @override
  String get search => '搜索';

  @override
  String get adminOnlyFeature => '创建频道暂时仅对管理员开放。';

  @override
  String get createChannel => '创建频道';

  @override
  String get galacticBroadcasts => '银河广播';

  @override
  String get noChannelsYet => '你还没有订阅任何内容。\n查找或创建你自己的频道！';

  @override
  String get constellationsTitle => '星座';

  @override
  String get privateChatsTab => '私人';

  @override
  String get channelsTab => '频道';

  @override
  String get loadingUser => '正在加载用户...';

  @override
  String get emptyChatsPlaceholder => '你的私人聊天将显示在这里。\n通过搜索找到有趣的人！';

  @override
  String get errorTitle => '错误';

  @override
  String get autoDeleteMessages => '自动删除消息';

  @override
  String get availableInPro => 'PRO版可用';

  @override
  String get timerOff => '关闭';

  @override
  String get timer15min => '15分钟';

  @override
  String get timer1hour => '1小时';

  @override
  String get timer4hours => '4小时';

  @override
  String get timer24hours => '24小时';

  @override
  String get timerSet => '定时器已设置';

  @override
  String get disappearingMessages => '阅后即焚消息';

  @override
  String get communicationTitle => '交流';

  @override
  String get errorLoadingReport => '加载报告时出错';

  @override
  String get compatibility => '兼容性';

  @override
  String get strengths => '优势';

  @override
  String get weaknesses => '潜在困难';

  @override
  String get commentsTitle => '评论';

  @override
  String get commentsLoadError => '加载评论时出错。';

  @override
  String get noCommentsYet => '尚无评论。';

  @override
  String userIsTyping(Object name) {
    return '$name 正在输入...';
  }

  @override
  String twoUsersTyping(Object name1, Object name2) {
    return '$name1 和 $name2 正在输入...';
  }

  @override
  String manyUsersTyping(Object count, Object name1, Object name2) {
    return '$name1, $name2 和其他 $count 人正在输入...';
  }

  @override
  String replyingTo(Object name) {
    return '回复 $name';
  }

  @override
  String get writeCommentHint => '写评论...';

  @override
  String get compatibilityTitle => '宇宙连接';

  @override
  String get noData => '无数据';

  @override
  String get westernAstrology => '西方占星术';

  @override
  String get vedicAstrology => '吠陀占星术 (Jyotish)';

  @override
  String get numerology => '数字命理学';

  @override
  String get chineseZodiac => '生肖';

  @override
  String get baziElements => '八字 (五行)';

  @override
  String get availableInPremium => '高级版可用';

  @override
  String get verdictSoulmates => '灵魂伴侣';

  @override
  String get verdictGreatMatch => '绝配';

  @override
  String get verdictPotential => '有潜力';

  @override
  String get verdictKarmic => '业力课程';

  @override
  String get createChannelTitle => '创建广播';

  @override
  String get channelNameLabel => '广播名称';

  @override
  String get channelNameHint => '例如，\'每日塔罗预测\'';

  @override
  String get errorChannelNameEmpty => '名称不能为空';

  @override
  String get channelHandleLabel => '唯一 ID (@handle)';

  @override
  String get errorChannelHandleShort => 'ID 必须超过 4 个字符';

  @override
  String get channelDescriptionLabel => '描述';

  @override
  String get channelDescriptionHint => '告诉我们你的频道是关于什么的...';

  @override
  String get errorChannelDescriptionEmpty => '请添加描述';

  @override
  String get createButton => '创建';

  @override
  String get editProfileTitle => '编辑个人资料';

  @override
  String get profileNotFoundError => '错误：未找到个人资料';

  @override
  String get profileSavedSuccess => '个人资料保存成功！';

  @override
  String get saveError => '保存错误';

  @override
  String get avatarUploadError => '照片上传错误';

  @override
  String get nameLabel => '姓名';

  @override
  String get bioLabel => '关于我';

  @override
  String get birthDataTitle => '出生数据';

  @override
  String get birthDataWarning => '更改此数据将导致重新计算您的占星和数字命理画像。';

  @override
  String get birthDateLabel => '出生日期';

  @override
  String get birthPlaceLabel => '出生地点';

  @override
  String get errorUserNotFound => '错误：未找到用户';

  @override
  String get feedUpdateError => '动态更新错误';

  @override
  String get feedEmptyMessage => '你的动态为空。\n向下拉动以刷新。';

  @override
  String get whereToSearch => '搜索地点';

  @override
  String get searchNearby => '附近';

  @override
  String get searchCity => '城市';

  @override
  String get searchCountry => '国家';

  @override
  String get searchWorld => '全球';

  @override
  String get ageLabel => '年龄';

  @override
  String get showGenderLabel => '显示';

  @override
  String get genderAll => '所有';

  @override
  String get zodiacFilterLabel => '星座元素';

  @override
  String get resetFilters => '重置';

  @override
  String get applyFilters => '应用';

  @override
  String get forecastLoadError => '无法加载预测。\n请稍后再试。';

  @override
  String get noForecastEvents => '今天没有重大的占星事件。\n平静的一天！';

  @override
  String get unlockFullForecast => '解锁完整预测';

  @override
  String get myFriendsTab => '我的好友';

  @override
  String get friendRequestsTab => '请求';

  @override
  String get noFriendsYet => '你还没有朋友。在搜索中找到他们！';

  @override
  String get noFriendRequests => '没有新请求。';

  @override
  String get removeFriend => '删除好友';

  @override
  String get gamesComingSoonTitle => '游戏和奖励即将推出！';

  @override
  String get gamesComingSoonDesc =>
      '我们正在准备令人兴奋的小游戏和测验。检查您的兼容性，赚取“星尘”并将其兑换为高级会员天数或独特礼物！';

  @override
  String get joinTelegramButton => '在我们的 Telegram 上第一时间了解';

  @override
  String horoscopeForSign(Object sign) {
    return '$sign 的运势';
  }

  @override
  String get horoscopeGeneral => '综合';

  @override
  String get horoscopeLove => '爱情';

  @override
  String get horoscopeBusiness => '事业';

  @override
  String get verdictNotFound => '未找到结论';

  @override
  String get vedicCompatibilityTitle => '吠陀兼容性';

  @override
  String get ashtaKutaAnalysis => '详细分析 (Ashta-Kuta)';

  @override
  String get noDescription => '未找到描述。';

  @override
  String get likesYouEmpty => '对你感兴趣的人将显示在这里';

  @override
  String peopleLikeYou(Object count) {
    return '有 $count 人喜欢你！';
  }

  @override
  String get getProToSeeLikes => '获取 PRO 状态以查看他们的个人资料并开始聊天。';

  @override
  String get seeLikesButton => '查看赞';

  @override
  String get someone => '某人';

  @override
  String get selectCityTitle => '选择城市';

  @override
  String get searchCityHint => '输入城市名称...';

  @override
  String get nothingFound => '未找到结果';

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
  String get moderationProposedPosts => '提议的帖子';

  @override
  String get noProposedPosts => '没有提议的帖子。';

  @override
  String get from => '来自';

  @override
  String get personalNumerologyTitle => '个人数字命理';

  @override
  String get dataNotLoaded => '数据未加载';

  @override
  String get loading => '加载中...';

  @override
  String get lifePathNumber => '生命路径数';

  @override
  String get corePersonality => '核心个性';

  @override
  String get destinyNumber => '命运数';

  @override
  String get soulNumber => '灵魂数';

  @override
  String get personalityNumber => '个性数';

  @override
  String get timeInfluence => '时间的影响';

  @override
  String get maturityNumber => '成熟数';

  @override
  String get birthdayNumber => '生日数';

  @override
  String get currentVibrationsPro => '当前振动 (PRO)';

  @override
  String get personalYear => '个人年';

  @override
  String get personalMonth => '个人月';

  @override
  String get personalDay => '个人日';

  @override
  String get proVibrationsDesc => '发现您在年、月、日的振动。仅在高级版中可用。';

  @override
  String get unlockButton => '解锁';

  @override
  String get tapForDetails => '点击查看详情';

  @override
  String oracle_weather_desc(Object desc, Object kp) {
    return '$desc (Kp: $kp)';
  }

  @override
  String oracle_geomagnetic_now(Object desc) {
    return '现在：$desc';
  }

  @override
  String oracle_geomagnetic_index(Object kp) {
    return 'Kp 指数：$kp';
  }

  @override
  String get oracle_question_title => '询问神谕';

  @override
  String get oracle_question_hint => '你在担心什么？...';

  @override
  String get oracle_question_button => '获取答案';

  @override
  String get palmistry_analysis_title => '手相分析';

  @override
  String get palmistry_choose_option => '选择最合适的选项：';

  @override
  String get palmistry_analysis_saved => '分析已保存！';

  @override
  String get palmistry_view_report => '查看完整报告';

  @override
  String get palmistry_complete_all => '完成所有线条的分析';

  @override
  String get palmistry_analysis_complete => '太棒了！分析完成。';

  @override
  String palmistry_tap_line(Object lineName) {
    return '点击“$lineName”与您的手掌进行比较。';
  }

  @override
  String palmistry_searching_line(Object lineName) {
    return '正在搜索“$lineName”...';
  }

  @override
  String get palmistry_preparing => '准备分析...';

  @override
  String get palmistry_report_title => '你的命运地图';

  @override
  String get palmistry_data_not_found => '未找到分析数据。';

  @override
  String get palmistry_strong_traits => '你的优势';

  @override
  String get privacy => '隐私';

  @override
  String get palmistry_show_in_profile => '在个人资料中显示我的特征';

  @override
  String get palmistry_show_in_profile_desc => '这将帮助他人更好地了解你并改善兼容性匹配。';

  @override
  String get palmistry_interpretation => '线条解读';

  @override
  String palmistry_your_choice(Object choice) {
    return '你的选择：“$choice”';
  }

  @override
  String get photoAlbumComingSoon => '很快您就可以在这里上传照片了。';

  @override
  String get settingsTitle => '设置';

  @override
  String get accountManagement => '账户管理';

  @override
  String get changePassword => '更改密码';

  @override
  String get restorePassword => '重置密码';

  @override
  String get editProfileButton => '编辑个人资料';

  @override
  String get dailyNotifications => '每日通知';

  @override
  String get alertsTitle => '警报';

  @override
  String get geomagneticStorms => '地磁风暴';

  @override
  String get adminPanelTitle => '管理面板';

  @override
  String get adminManageUsers => '管理用户';

  @override
  String get offerAgreementLink => '服务协议';

  @override
  String get accountSectionTitle => '账户';

  @override
  String get deleteAccountButton => '删除账户';

  @override
  String get closeAppButton => '关闭应用';

  @override
  String get changePasswordDesc => '为了安全起见，请输入您的当前密码。';

  @override
  String get currentPasswordLabel => '当前密码';

  @override
  String get newPasswordLabel => '新密码';

  @override
  String get passwordChangedSuccess => '密码修改成功！';

  @override
  String resetPasswordInstruction(String email) {
    return '我们将向您的邮箱发送重置说明：\n\n$email';
  }

  @override
  String get signOutDialogTitle => '登出';

  @override
  String get signOutDialogContent => '您确定要登出吗？';

  @override
  String get deleteAccountTitle => '删除账户？';

  @override
  String get deleteAccountWarning => '此操作不可逆。您的所有数据、聊天记录、照片和购买记录将被永久删除。';

  @override
  String get deleteForeverButton => '永久删除';

  @override
  String get roulette_trust_fate => '相信命运';

  @override
  String get roulette_desc_short => '星星将为您选择最兼容的伴侣（85%起！）。';

  @override
  String get roulette_no_candidates => '没有候选人可以旋转。';

  @override
  String get roulette_winner_title => '星星做出了选择！';

  @override
  String get roulette_spin_again => '再次旋转';

  @override
  String get roulette_go_to_profile => '转到个人资料';

  @override
  String get cityNotSpecified => '未指定城市';

  @override
  String get geomagnetic_calm => '平静';

  @override
  String get geomagnetic_unsettled => '不稳定';

  @override
  String get geomagnetic_active => '活跃';

  @override
  String get geomagnetic_storm_minor => '小风暴 (G1)';

  @override
  String get geomagnetic_storm_moderate => '中等风暴 (G2)';

  @override
  String get geomagnetic_storm_strong => '强风暴 (G3)';

  @override
  String get geomagnetic_storm_severe => '严重风暴 (G4)';

  @override
  String get geomagnetic_storm_extreme => '极端风暴 (G5)';

  @override
  String get deleteChatTitle => '删除聊天？';

  @override
  String get deleteChatConfirmation => '所有消息将被永久删除。';

  @override
  String get chatDeleted => '聊天已删除';
}
