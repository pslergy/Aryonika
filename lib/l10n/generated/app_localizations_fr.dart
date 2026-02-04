// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get profileCreationErrorTitle => 'Erreur de création du profil';

  @override
  String get profileCreationErrorDescription =>
      'Malheureusement, une erreur est survenue lors de l\'enregistrement de vos données. Veuillez réessayer de vous inscrire.';

  @override
  String get tryAgain => 'Réessayer';

  @override
  String get connectingHearts => 'Connecter les cœurs à travers l\'univers...';

  @override
  String get appName => 'Aryonika';

  @override
  String get exitConfirmationTitle => 'Confirmation';

  @override
  String get exitConfirmationContent =>
      'Êtes-vous sûr de vouloir fermer Aryonika ?';

  @override
  String get cancel => 'Annuler';

  @override
  String get close => 'Fermer';

  @override
  String get paymentUrlError => 'Erreur : URL de paiement non trouvée.';

  @override
  String get channelIdError => 'Erreur : ID de canal non trouvé.';

  @override
  String documentLoadError(Object error) {
    return 'Ошибка загрузки документа: $error';
  }

  @override
  String get partnerIdError =>
      'Erreur : L\'ID du partenaire est requis pour le calcul de compatibilité.';

  @override
  String get bioPlaceholder => 'Votre histoire pourrait être ici...';

  @override
  String photoAlbumTitle(Object photoCount) {
    return 'Album photo ($photoCount)';
  }

  @override
  String get photoAlbumSubtitle => 'Vos meilleurs moments';

  @override
  String get cosmicEventsTitle => 'Événements Cosmiques';

  @override
  String get cosmicEventsSubtitle => 'Découvrez l\'influence des planètes';

  @override
  String get inviteFriendTitle => 'Inviter un ami';

  @override
  String get inviteFriendSubtitle => 'Obtenez des bonus ensemble';

  @override
  String get gameCenterTitle => 'Centre de Jeux';

  @override
  String get gameCenterSubtitle => 'Mini-jeux et quêtes';

  @override
  String get personalForecastTitle => 'Prévisions Personnelles';

  @override
  String get personalForecastSubtitlePro =>
      'Analyse des transits pour aujourd\'hui';

  @override
  String get personalForecastSubtitleFree => 'Disponible avec le statut PRO';

  @override
  String get cosmicPassportTitle => 'PASSEPORT COSMIQUE';

  @override
  String get numerologyPortraitTitle => 'PORTRAIT NUMÉROLOGIQUE';

  @override
  String get yourNumbersOfDestinyTitle => 'Vos Nombres du Destin';

  @override
  String get yourNumbersOfDestinySubtitle => 'Libérez votre potentiel';

  @override
  String get numerologyPath => 'Chemin de Vie';

  @override
  String get numerologyDestiny => 'Destin';

  @override
  String get numerologySoul => 'Âme';

  @override
  String get signOut => 'Se déconnecter';

  @override
  String get calculatingChart => 'Calcul de la carte...';

  @override
  String get astroDataSignMissing => 'Données manquantes pour ce signe.';

  @override
  String astroDataDescriptionNotFound(Object signName) {
    return 'Description pour \"$signName\" non trouvée.';
  }

  @override
  String astroDataMapNotLoaded(Object mapKey) {
    return 'Données pour \"$mapKey\" non chargées.';
  }

  @override
  String get planetSun => 'Soleil';

  @override
  String get planetMoon => 'Lune';

  @override
  String get planetAscendant => 'Ascendant';

  @override
  String get planetMercury => 'Mercure';

  @override
  String get planetVenus => 'Vénus';

  @override
  String get planetMars => 'Mars';

  @override
  String get planetSaturn => 'Saturne';

  @override
  String get planetJupiter => 'Jupiter';

  @override
  String get planetUranus => 'Uranus';

  @override
  String get planetNeptune => 'Neptune';

  @override
  String get planetPluto => 'Pluton';

  @override
  String get getProTitle => 'Obtenir PRO';

  @override
  String get getProSubtitle => 'Débloquez toutes les fonctionnalités';

  @override
  String get proStatusActive => 'Statut PRO actif';

  @override
  String get proStatusExpired => 'Le statut a expiré';

  @override
  String proStatusDaysLeft(Object days) {
    return 'Jours restants : $days';
  }

  @override
  String proStatusHoursLeft(Object hours) {
    return 'Heures restantes : $hours';
  }

  @override
  String get proStatusExpiresToday => 'Expire aujourd\'hui';

  @override
  String astroDialogTitle(Object planetName, Object signName) {
    return '$planetName en $signName';
  }

  @override
  String get likesYouTitle => 'Ils vous aiment';

  @override
  String likesYouTotal(Object count) {
    return 'Total des \'j\'aime\' : $count';
  }

  @override
  String get likesYouNone => 'Aucun \'j\'aime\' pour le moment';

  @override
  String reportOnUser(Object userName) {
    return 'Signaler $userName';
  }

  @override
  String get reportReasonSpam => 'Spam';

  @override
  String get reportReasonInsultingBehavior => 'Comportement insultant';

  @override
  String get reportReasonScam => 'Arnaque';

  @override
  String get reportReasonInappropriateContent => 'Contenu inapproprié';

  @override
  String get reportDetailsHint => 'Détails supplémentaires (facultatif)';

  @override
  String get send => 'Envoyer';

  @override
  String get reportSentSnackbar => 'Merci ! Votre signalement a été envoyé.';

  @override
  String get profileLoadError => 'Échec du chargement du profil';

  @override
  String get back => 'Retour';

  @override
  String get report => 'Signaler';

  @override
  String userProfilePhotoAlbumTitle(Object photoCount) {
    return 'Album photo ($photoCount)';
  }

  @override
  String get userProfileViewPhotos => 'Voir les photos';

  @override
  String get aboutMe => 'À propos de moi';

  @override
  String get bioEmpty =>
      'Cet utilisateur n\'a encore rien partagé à son sujet.';

  @override
  String get cosmicPassport => 'Passeport Cosmique';

  @override
  String sunInSign(Object signName) {
    return '☀️ Soleil en $signName';
  }

  @override
  String get friendshipStatusFriends => 'Vous êtes amis';

  @override
  String get friendshipRemoveTitle => 'Retirer des amis ?';

  @override
  String friendshipRemoveContent(Object userName) {
    return 'Êtes-vous sûr de vouloir retirer $userName de vos amis ?';
  }

  @override
  String get remove => 'Retirer';

  @override
  String get friendshipStatusRequestSent => 'Demande envoyée';

  @override
  String get friendshipActionDecline => 'Refuser';

  @override
  String get friendshipActionAccept => 'Accepter';

  @override
  String get friendshipActionAdd => 'Ajouter comme ami';

  @override
  String likeSnackbarSuccess(Object userName) {
    return 'Vous avez aimé $userName !';
  }

  @override
  String likeSnackbarAlreadyLiked(Object userName) {
    return 'Vous avez déjà aimé $userName';
  }

  @override
  String get writeMessage => 'Écrire un message';

  @override
  String get checkCompatibility => 'Vérifier la compatibilité';

  @override
  String get yourCosmicInfluence => 'Votre Influence Cosmique Aujourd\'hui';

  @override
  String get cosmicEventsLoading => 'Calcul des événements cosmiques...';

  @override
  String get cosmicEventsEmpty =>
      'Le cosmos est calme aujourd\'hui. Profitez de l\'harmonie !';

  @override
  String get cosmicEventsError =>
      'Impossible de calculer les événements cosmiques. Veuillez réessayer plus tard.';

  @override
  String get cosmicConnectionTitle => 'Lien Cosmique';

  @override
  String shareText(Object name, Object score) {
    return 'Notre compatibilité avec $name est de $score% ! ✨\nCalculé dans Aryonika';
  }

  @override
  String get shareErrorSnackbar => 'Une erreur est survenue lors du partage.';

  @override
  String get compatibilityErrorTitle => 'Échec du calcul de la compatibilité';

  @override
  String get compatibilityErrorSubtitle =>
      'Les données du partenaire sont peut-être incomplètes ou une erreur réseau est survenue.';

  @override
  String get goBack => 'Retourner';

  @override
  String get sectionCosmicAdvice => 'CONSEIL COSMIQUE';

  @override
  String get sectionDailyInfluence => 'INFLUENCE DU JOUR';

  @override
  String get sectionAstrologicalResonance => 'RÉSONANCE ASTROLOGIQUE';

  @override
  String get sectionNumerologyMatrix => 'MATRICE NUMÉROLOGIQUE';

  @override
  String get sectionPalmistryConnection => 'CONNEXION CHIROMANTIQUE';

  @override
  String get sectionAboutPerson => 'À PROPOS DE LA PERSONNE';

  @override
  String get palmistryNoData =>
      'L\'un des partenaires n\'a pas encore effectué l\'analyse de la paume. Cela débloquera un nouveau niveau de votre compatibilité !';

  @override
  String palmistryCommonTraits(Object traits) {
    return 'Vous êtes unis par : $traits. Cela crée une base solide pour votre relation.';
  }

  @override
  String palmistryUniqueTraits(Object myTrait, Object partnerTrait) {
    return 'Vous vous complétez : votre trait \'$myTrait\' s\'harmonise parfaitement avec son trait \'$partnerTrait\'.';
  }

  @override
  String get harmony => 'Harmonie';

  @override
  String get adviceRareConnection =>
      'Vos âmes résonnent à l\'unisson. C\'est une connexion cosmique rare où les personnalités (Soleil) et les émotions (Lune) sont en harmonie. Chérissez ce trésor.';

  @override
  String get advicePassionChallenge =>
      'Une flamme de passion fait rage entre vous, mais vos personnalités peuvent s\'affronter. Apprenez à transformer les disputes en énergie pour grandir, et votre lien deviendra indestructible.';

  @override
  String get adviceBestFriends =>
      'Vous êtes les meilleurs amis du monde, vous vous comprenez d\'un seul regard et vous sentez à l\'aise ensemble. L\'attirance physique peut grandir avec le temps ; l\'essentiel est votre proximité spirituelle.';

  @override
  String get adviceKarmicLesson =>
      'Vos chemins se sont croisés pour une raison. Cette connexion apporte des leçons importantes pour vous deux. Soyez patients et ouverts pour comprendre ce que vous devez vous apprendre mutuellement.';

  @override
  String get adviceGreatPotential =>
      'Il y a une forte attirance entre vous et un grand potentiel de croissance. Apprenez l\'un de l\'autre, et votre lien se renforcera. Les étoiles sont de votre côté.';

  @override
  String get adviceBase =>
      'Étudiez-vous mutuellement. Chaque rencontre est une opportunité de découvrir un nouvel univers. Votre histoire ne fait que commencer.';

  @override
  String get dailyInfluenceCalm =>
      'Calme cosmique. Une excellente journée pour simplement profiter de la compagnie de l\'autre sans influences extérieures.';

  @override
  String get dailyAdviceFavorable =>
      'Conseil : Utilisez cette énergie ! Un excellent moment pour des projets communs.';

  @override
  String get dailyAdviceTense =>
      'Conseil : Soyez plus patients l\'un envers l\'autre. Des malentendus sont possibles.';

  @override
  String get proFeatureLocked =>
      'Une analyse détaillée de cet aspect est disponible dans la version PRO.';

  @override
  String get getProButton => 'Obtenir PRO';

  @override
  String get numerologyLifePath => 'Chemin de Vie';

  @override
  String get numerologyDestinyNumber => 'Nombre de Destin';

  @override
  String get numerologySoulNumber => 'Nombre d\'Âme';

  @override
  String get shareCardTitle => 'Aryonika';

  @override
  String get shareCardSubtitle => 'RAPPORT DE COMPATIBILITÉ COSMIQUE';

  @override
  String get shareCardHarmony => 'Harmonie globale';

  @override
  String get shareCardPersonalityHarmony =>
      'Harmonie des personnalités (Soleil)';

  @override
  String get shareCardLifePath => 'Chemin de Vie (Numérologie)';

  @override
  String get shareCardCtaTitle => 'Découvrez votre compatibilité\ncosmique !';

  @override
  String get shareCardCtaSubtitle => 'Téléchargez Aryonika sur RuStore';

  @override
  String get loginTitle => 'Se connecter';

  @override
  String get loginError => 'Erreur de connexion';

  @override
  String get passwordResetTitle => 'Réinitialisation du mot de passe';

  @override
  String get passwordResetContent =>
      'Entrez votre E-mail, et nous vous enverrons les instructions pour réinitialiser votre mot de passe.';

  @override
  String get emailLabel => 'E-mail';

  @override
  String get sendButton => 'Envoyer';

  @override
  String get emailValidationError => 'Veuillez entrer un E-mail valide.';

  @override
  String get passwordResetSuccess =>
      'E-mail envoyé ! Vérifiez votre boîte de réception.';

  @override
  String get passwordLabel => 'Mot de passe';

  @override
  String get loginButton => 'Se connecter';

  @override
  String get forgotPasswordButton => 'Mot de passe oublié ?';

  @override
  String get noAccountButton => 'Pas de compte ? S\'inscrire';

  @override
  String get registerTitle => 'Créer un compte';

  @override
  String get unknownError => 'Une erreur inconnue est survenue';

  @override
  String get confirmPasswordLabel => 'Confirmez le mot de passe';

  @override
  String get privacyPolicyCheckbox => 'J\'ai lu et j\'accepte les ';

  @override
  String get termsOfUseLink => 'Conditions d\'utilisation';

  @override
  String get and => ' et la ';

  @override
  String get privacyPolicyLink => 'Politique de confidentialité';

  @override
  String get registerButton => 'S\'inscrire';

  @override
  String get alreadyHaveAccountButton => 'Déjà un compte ? Se connecter';

  @override
  String get welcomeTagline => 'Ton destin est écrit dans les étoiles';

  @override
  String get welcomeCreateAccountButton => 'Créer un passeport cosmique';

  @override
  String get welcomeLoginButton => 'J\'ai déjà un compte';

  @override
  String get introSlide1Title => 'Aryonika — Plus que des rencontres';

  @override
  String get introSlide1Description =>
      'Découvrez de nouveaux niveaux de compatibilité grâce à l\'astrologie, la numérologie et les Cartes du Destin.';

  @override
  String get introSlide2Title => 'Votre passeport cosmique';

  @override
  String get introSlide2Description =>
      'Apprenez tout sur votre potentiel et trouvez celui qui complète votre univers.';

  @override
  String get introSlide3Title => 'Rejoignez la galaxie';

  @override
  String get introSlide3Description =>
      'Commencez votre voyage cosmique vers le véritable amour dès maintenant.';

  @override
  String get introButtonSkip => 'Passer';

  @override
  String get introButtonNext => 'Suivant';

  @override
  String get introButtonStart => 'Commencer';

  @override
  String get onboardingNameTitle => 'Comment vous appelez-vous ?';

  @override
  String get onboardingNameSignOutTooltip => 'Se déconnecter (pour tester)';

  @override
  String get onboardingNameSubtitle =>
      'Ce nom sera visible par les autres utilisateurs.';

  @override
  String get onboardingNameLabel => 'Votre nom';

  @override
  String get onboardingBioLabel => 'Parlez-nous de vous';

  @override
  String get onboardingBioHint =>
      'Exemple : J\'aime l\'astrologie et les #voyages...';

  @override
  String get onboardingButtonNext => 'Suivant';

  @override
  String get onboardingBirthdateTitle => 'Quand êtes-vous né(e) ?';

  @override
  String get onboardingBirthdateSubtitle =>
      'Ceci est nécessaire pour un calcul précis de votre thème natal et de votre numérologie.';

  @override
  String get datePickerHelpText => 'SÉLECTIONNEZ LA DATE DE NAISSANCE';

  @override
  String get birthdateLabel => 'Date de naissance';

  @override
  String get birthdatePlaceholder => 'Appuyez pour sélectionner';

  @override
  String get dateFormat => 'd MMMM yyyy';

  @override
  String get onboardingFinishText1 => 'Analyse de la position des étoiles...';

  @override
  String get onboardingFinishText2 => 'Calcul de votre code numérologique...';

  @override
  String get onboardingFinishText3 =>
      'Vérification avec les Cartes du Destin...';

  @override
  String get onboardingFinishText4 => 'Création de votre passeport cosmique...';

  @override
  String get onboardingFinishErrorTitle => 'Erreur';

  @override
  String get onboardingFinishErrorContent =>
      'Une erreur inconnue est survenue.';

  @override
  String get onboardingFinishErrorButton => 'Retour';

  @override
  String get onboardingGenderTitle => 'Votre sexe';

  @override
  String get onboardingGenderSubtitle =>
      'Cela nous aidera à trouver les personnes les plus appropriées pour vous.';

  @override
  String get genderMale => 'Hommes';

  @override
  String get genderFemale => 'Femmes';

  @override
  String get onboardingLocationTitle => 'Lieu de naissance';

  @override
  String get onboardingLocationSubtitle =>
      'Veuillez indiquer la ville où vous êtes né(e). Ceci est nécessaire pour un calcul astrologique précis.';

  @override
  String get onboardingLocationSearchHint => 'Commencez à taper une ville...';

  @override
  String get onboardingLocationNotFound =>
      'Aucune ville trouvée. Essayez une autre recherche.';

  @override
  String get onboardingLocationStartSearch =>
      'Commencez la recherche pour voir les résultats';

  @override
  String get onboardingLocationSelectFromList =>
      'Sélectionnez une ville dans la liste ci-dessus pour continuer';

  @override
  String get onboardingTimeTitle => 'Heure de naissance';

  @override
  String get onboardingTimeSubtitle =>
      'Si vous ne connaissez pas l\'heure exacte, réglez-la sur 12:00.\nCela donnera quand même un bon résultat.';

  @override
  String get timePickerHelpText => 'SÉLECTIONNEZ L\'HEURE DE NAISSANCE';

  @override
  String get birthTimeLabel => 'Heure de naissance';

  @override
  String get onboardingButtonNextLocation => 'Suivant (choisir le lieu)';

  @override
  String get alphaBannerTitle => 'Version Alpha';

  @override
  String get alphaBannerContent =>
      'Cette section est en développement actif. Certaines fonctionnalités peuvent être instables. Nous travaillons activement à la localisation, certains textes peuvent donc encore être en russe. Merci de votre compréhension !';

  @override
  String get alphaBannerFeedback =>
      'Nous apprécions vos commentaires et suggestions sur notre chaîne Telegram !';

  @override
  String get astro_title_sun => 'Compatibilité de la Personnalité (Soleil)';

  @override
  String get astro_title_moon => 'Compatibilité Émotionnelle (Lune)';

  @override
  String get astro_title_chemistry => 'Chimie Astrologique (Vénus-Mars)';

  @override
  String get astro_title_mercury => 'Style de Communication (Mercure)';

  @override
  String get astro_title_saturn => 'Perspective à long terme (Saturne)';

  @override
  String get numerology_title => 'Résonance Numérologique';

  @override
  String get cosmicPulseTitle => 'Pouls Cosmique';

  @override
  String get feedIceBreakerTitle => 'Brise-glace';

  @override
  String get feedOrbitCrossingTitle => 'Croisement d\'orbites';

  @override
  String get feedSpiritualNeighborTitle => 'Voisin spirituel';

  @override
  String get feedGeomagneticStormTitle => 'Orage géomagnétique';

  @override
  String get feedCompatibilityPeakTitle => 'Pic de compatibilité';

  @override
  String get feedNewChannelSuggestionTitle => 'Nouveau Canal';

  @override
  String get feedPopularPostTitle => 'Post populaire';

  @override
  String get feedNewCommentTitle => 'Nouveau commentaire';

  @override
  String get cardOfTheDayTitle => 'Carte du Jour';

  @override
  String get cardOfTheDayDrawing => 'Tirage de votre carte...';

  @override
  String get cardOfTheDayGetButton => 'Tirer une carte';

  @override
  String get cardOfTheDayYourCard => 'Votre Carte du Jour';

  @override
  String get cardOfTheDayTapToReveal => 'Appuyez pour révéler';

  @override
  String get cardOfTheDayReversedSuffix => ' (Renversée)';

  @override
  String get cardOfTheDayDefaultInterpretation =>
      'Découvrez ce que le jour vous réserve.';

  @override
  String get channelSearchTitle => 'Rechercher des Canaux';

  @override
  String get channelAnonymousAuthor => 'Anonyme';

  @override
  String get errorUserNotAuthorized => 'Utilisateur non autorisé';

  @override
  String get errorUnknownServer => 'Erreur serveur inconnue';

  @override
  String get errorFailedToLoadData => 'Échec du chargement des données';

  @override
  String get generalHello => 'Bonjour';

  @override
  String get referralErrorProfileNotLoaded =>
      'Erreur : votre profil n\'est pas chargé. Veuillez réessayer plus tard.';

  @override
  String get referralErrorAlreadyUsed =>
      'Vous avez déjà utilisé un code de parrainage.';

  @override
  String get referralErrorOwnCode =>
      'Vous ne pouvez pas utiliser votre propre code.';

  @override
  String get referralScreenTitle => 'Inviter un ami';

  @override
  String get referralYourCodeTitle => 'Votre code d\'invitation';

  @override
  String get referralYourCodeDescription =>
      'Partagez ce code avec des amis. Pour chaque ami qui saisit votre code, vous recevrez 1 jour d\'accès PRO !';

  @override
  String get referralCodeCopied => 'Code copié dans le presse-papiers !';

  @override
  String get referralShareCodeButton => 'Partager le code';

  @override
  String referralShareMessage(String code) {
    return 'Salut ! Rejoins-moi sur Aryonika pour trouver ton âme sœur cosmique. Saisis mon code d\'invitation dans l\'application pour que nous recevions tous les deux des bonus : $code';
  }

  @override
  String get referralManualBonusNote =>
      'L\'accès PRO est accordé manuellement dans les 24 heures suivant la saisie du code par votre ami.';

  @override
  String get referralGotCodeTitle => 'Vous avez un code ?';

  @override
  String get referralGotCodeDescription =>
      'Saisissez le code que votre ami vous a donné pour qu\'il reçoive sa récompense.';

  @override
  String get referralCodeInputLabel => 'Code d\'invitation';

  @override
  String get referralCodeValidationError => 'Veuillez saisir un code';

  @override
  String get referralApplyCodeButton => 'Appliquer le code';

  @override
  String get nav_feed => 'Fil';

  @override
  String get nav_search => 'Recherche';

  @override
  String get nav_oracle => 'Oracle';

  @override
  String get nav_chats => 'Chats';

  @override
  String get nav_channels => 'Canaux';

  @override
  String get nav_profile => 'Profil';

  @override
  String get nav_exit => 'Quitter';

  @override
  String get exitDialog_title => 'Confirmation';

  @override
  String get exitDialog_content =>
      'Êtes-vous sûr de vouloir quitter Aryonika ?';

  @override
  String get exitDialog_cancel => 'Annuler';

  @override
  String get exitDialog_confirm => 'Quitter';

  @override
  String get oracle_limit_title => 'Limite de Requêtes';

  @override
  String get oracle_limit_later => 'Plus tard';

  @override
  String get oracle_limit_get_pro => 'Obtenir l\'illimité';

  @override
  String get oracle_orb_partner => 'Partenaire du Jour';

  @override
  String get oracle_orb_roulette => 'Roulette';

  @override
  String get oracle_orb_duet => 'Duo';

  @override
  String get oracle_orb_horoscope => 'Horoscope';

  @override
  String get oracle_orb_weather => 'Géomagnétique';

  @override
  String get oracle_orb_ask => 'Question';

  @override
  String get oracle_orb_focus => 'Focus du Jour';

  @override
  String get oracle_orb_forecast => 'AstroPrévisions';

  @override
  String get oracle_orb_card => 'Carte du Jour';

  @override
  String get oracle_orb_tarot => 'Réponse de l\'Univers';

  @override
  String get oracle_orb_palmistry => 'Chiromancie';

  @override
  String get oracle_duet_title => 'Duo Cosmique';

  @override
  String get oracle_duet_description =>
      'Vérifiez la compatibilité par date de naissance.';

  @override
  String get oracle_duet_button => 'Vérifier la compatibilité';

  @override
  String oracle_unsupported_web_feature(String featureName, Object feature) {
    return 'Fonction \'$feature\' indisponible sur le WEB.';
  }

  @override
  String get oracle_pro_card_of_day_title => 'Carte du Jour (PRO)';

  @override
  String get oracle_pro_card_of_day_desc =>
      'Découvrez l\'énergie de votre journée. Disponible en PRO.';

  @override
  String get oracle_pro_focus_of_day_title => 'Focus du Jour (PRO)';

  @override
  String get oracle_pro_focus_of_day_desc =>
      'Sachez sur quoi vous concentrer. Disponible en PRO.';

  @override
  String get oracle_pro_forecast_of_day_title => 'Prévisions Perso (PRO)';

  @override
  String get oracle_pro_forecast_of_day_desc =>
      'Analyse détaillée des transits. Disponible en PRO.';

  @override
  String get oracle_roulette_title => 'Roulette Cosmique';

  @override
  String get oracle_roulette_description =>
      'Tentez votre chance ! Trouvez un partenaire aléatoire.';

  @override
  String get oracle_roulette_button => 'Tourner la roulette';

  @override
  String get oracle_card_of_day_reversed => '(inversée)';

  @override
  String get oracle_card_of_day_get_key => 'Obtenir la Clé Personnelle';

  @override
  String get oracle_palmistry_title => 'Chiromancie';

  @override
  String get oracle_palmistry_description =>
      'Analyse des lignes de la main par IA.';

  @override
  String get oracle_palmistry_button => 'Scanner la main';

  @override
  String get oracle_ask_loading => 'L\'Oracle réfléchit...';

  @override
  String get oracle_ask_again => 'Demander encore';

  @override
  String get oracle_focus_loading => 'Mise au point...';

  @override
  String get oracle_focus_error => 'Erreur de chargement';

  @override
  String get oracle_focus_no_data => 'Pas de données';

  @override
  String get oracle_forecast_loading =>
      'Composition de vos prévisions personnelles...';

  @override
  String get oracle_forecast_error => 'Échec de la création des prévisions';

  @override
  String get oracle_forecast_try_again => 'Réessayer';

  @override
  String get oracle_forecast_title => 'Prévisions du Jour';

  @override
  String get oracle_forecast_day_number => 'Votre numéro du jour : ';

  @override
  String get oracle_tarot_title => 'Tirage Tarot (IA)';

  @override
  String get oracle_tarot_hint => 'Votre question...';

  @override
  String get oracle_tarot_button => 'Faire le tirage';

  @override
  String oracle_tarot_your_question(String question) {
    return 'Votre question : $question';
  }

  @override
  String get oracle_tarot_loading => 'L\'IA analyse...';

  @override
  String get oracle_tarot_ask_again => 'Demander encore';

  @override
  String get oracle_tarot_card_reversed_short => ' (inv.)';

  @override
  String get oracle_tarot_combo_message => 'Message global des cartes :';

  @override
  String get oracle_geomagnetic_title => 'Météo Spatiale';

  @override
  String get oracle_geomagnetic_forecast => 'Prévisions à venir';

  @override
  String get oracle_weather_title => 'Activité Géomagnétique';

  @override
  String get oracle_pro_feature_title => 'Partenaire du Jour (PRO)';

  @override
  String get oracle_pro_feature_desc =>
      'Nous trouvons le partenaire idéal. Disponible en PRO.';

  @override
  String get oracle_partner_loading => 'Recherche de partenaire...';

  @override
  String get oracle_partner_error => 'Erreur de recherche';

  @override
  String get oracle_partner_not_found => 'Aucun partenaire trouvé';

  @override
  String get oracle_partner_profile_error => 'Erreur de profil';

  @override
  String get oracle_partner_title => 'Votre Partenaire du Jour';

  @override
  String oracle_partner_compatibility(String score) {
    return 'Compatibilité : $score%';
  }

  @override
  String get oracle_ask_title => 'Question à l\'Oracle';

  @override
  String get oracle_ask_hint => 'Qu\'est-ce qui vous préoccupe ?..';

  @override
  String get oracle_ask_button => 'Obtenir une réponse';

  @override
  String get oracle_tips_loading => 'Chargement des conseils...';

  @override
  String get oracle_tips_title => 'Conseils des étoiles';

  @override
  String oracle_tips_subtitle(String count) {
    return 'Pour la communication ($count)';
  }

  @override
  String get oracle_tips_general_advice => 'Soyez ouvert et sincère.';

  @override
  String get cardOfTheDayProInApp =>
      '✨ L\'aspect personnel est disponible dans l\'application mobile.';

  @override
  String get numerology_report_title => 'Rapport de Numérologie';

  @override
  String get numerology_report_overall => 'Score Global';

  @override
  String get numerology_report_you => 'Vous';

  @override
  String get numerology_report_partner => 'Partenaire';

  @override
  String get userProfile_numerology_button => 'Numérologie';

  @override
  String get forecast_astrological_title => 'Prévisions Astrologiques';

  @override
  String get forecast_loading => 'Chargement...';

  @override
  String get forecast_error => 'Erreur de chargement';

  @override
  String get forecast_no_aspects => 'Aucun aspect significatif';

  @override
  String get cosmicEvents_title => 'Événements Cosmiques';

  @override
  String get cosmicEvents_loading_error => 'Échec du chargement des événements';

  @override
  String get cosmicEvents_no_events => 'Aucun événement à venir';

  @override
  String get cosmicEvents_paywall_title => 'Événements Cosmiques Personnels';

  @override
  String get cosmicEvents_paywall_description =>
      'Accédez à des conseils uniques basés sur l\'influence des planètes sur votre thème natal.';

  @override
  String get cosmicEvents_paywall_button => 'Obtenir le Statut PRO';

  @override
  String get cosmicEvents_personal_focus => 'Votre Focus Personnel :';

  @override
  String get cosmicEvents_pro_placeholder =>
      'Découvrez l\'influence personnelle de cet événement avec le statut PRO';

  @override
  String get search_no_one_found =>
      'Personne n\'a été trouvé\ndans cette partie de la galaxie.';

  @override
  String get chat_error_user_not_found => 'Erreur : utilisateur non trouvé';

  @override
  String get chat_start_with_hint => 'Commencer avec une suggestion';

  @override
  String get chat_date_format => 'd MMMM y';

  @override
  String get chat_group_member => 'membre';

  @override
  String get chat_group_members_2_4 => 'membres';

  @override
  String get chat_group_members_5_0 => 'membres';

  @override
  String get chat_online_status_long_ago => 'en ligne il y a longtemps';

  @override
  String get chat_online_status_online => 'en ligne';

  @override
  String chat_online_status_minutes_ago(String minutes) {
    return 'en ligne il y a $minutes min';
  }

  @override
  String chat_online_status_today_at(String time) {
    return 'en ligne aujourd\'hui à $time';
  }

  @override
  String chat_online_status_yesterday_at(String time) {
    return 'en ligne hier à $time';
  }

  @override
  String chat_online_status_date(String date) {
    return 'en ligne le $date';
  }

  @override
  String get chat_delete_dialog_title => 'Supprimer la conversation ?';

  @override
  String get chat_delete_dialog_content =>
      'Cette conversation sera supprimée pour vous et votre interlocuteur. Cette action est irréversible.';

  @override
  String get chat_delete_dialog_confirm => 'Supprimer';

  @override
  String chat_report_dialog_title(String name) {
    return 'Signaler $name';
  }

  @override
  String get chat_report_details_hint => 'Détails supplémentaires (facultatif)';

  @override
  String get chat_report_sent_snackbar =>
      'Merci ! Votre signalement a été envoyé.';

  @override
  String get chat_menu_report => 'Signaler';

  @override
  String get chat_menu_delete => 'Supprimer la conversation';

  @override
  String get chat_group_title_default => 'Discussion de groupe';

  @override
  String get chat_group_participants => 'Participants';

  @override
  String get chat_message_old => 'Message d\'une version précédente';

  @override
  String get chat_input_hint => 'Message...';

  @override
  String get chat_temp_warning_remaining =>
      'Cette conversation temporaire sera supprimée dans ';

  @override
  String get chat_temp_warning_expired => 'la conversation a expiré';

  @override
  String get chat_temp_warning_less_than_24h => 'moins de 24 heures';

  @override
  String get encrypted_chat_banner_title => 'Conversation protégée';

  @override
  String get encrypted_chat_banner_desc =>
      'Les messages de cette conversation sont protégés par un chiffrement de bout en bout. Personne, pas même l\'administration de Aryonika, ne peut les lire.';

  @override
  String get search_hint => 'Rechercher par nom, bio...';

  @override
  String get search_tooltip_swipes => 'Swipes';

  @override
  String get search_tooltip_cosmic_web => 'Toile Cosmique';

  @override
  String get search_tooltip_star_map => 'Carte du Ciel';

  @override
  String get search_tooltip_filters => 'Filtres';

  @override
  String get search_star_map_placeholder =>
      'La Carte du Ciel est en cours de développement...';

  @override
  String get search_priority_header => 'Meilleures correspondances';

  @override
  String get search_other_header => 'Autres utilisateurs';

  @override
  String get payment_title => 'Soutenir le projet';

  @override
  String get payment_success_snackbar =>
      'Merci pour votre soutien ! Mise à jour de votre statut...';

  @override
  String get payment_fail_snackbar =>
      'Le don n\'a pas pu être traité. Veuillez réessayer.';

  @override
  String get paywall_header_title => 'Découvrez l\'Univers Aryonika';

  @override
  String get paywall_header_subtitle =>
      'Soutenez le projet et recevez en remerciement tous les outils cosmiques pour trouver votre partenaire idéal.';

  @override
  String get paywall_benefit1_title => 'Voyez qui vous a liké';

  @override
  String get paywall_benefit1_subtitle =>
      'Ne manquez pas une chance de réciprocité et engagez la conversation en premier.';

  @override
  String get paywall_benefit2_title => 'Prévisions personnelles du jour';

  @override
  String get paywall_benefit2_subtitle =>
      'Analyse quotidienne de vos transits et le Focus du Jour.';

  @override
  String get paywall_benefit3_title => 'Partenaire du Jour & Roulette';

  @override
  String get paywall_benefit3_subtitle =>
      'Laissez les étoiles choisir pour vous le partenaire le plus compatible.';

  @override
  String get paywall_benefit4_title => 'La réponse de l\'Univers';

  @override
  String get paywall_benefit4_subtitle =>
      'Posez votre question et recevez un conseil cosmique.';

  @override
  String get paywall_benefit5_title => 'Météo cosmique';

  @override
  String get paywall_benefit5_subtitle =>
      'Restez informé des tempêtes géomagnétiques et de leur influence.';

  @override
  String get paywall_benefit6_title => 'Carte du Jour';

  @override
  String get paywall_benefit6_subtitle =>
      'Recevez une prédiction et un conseil quotidien de la Carte du Destin.';

  @override
  String get paywall_donate_button => 'Soutenir le projet';

  @override
  String get paywall_referral_button => 'Obtenir PRO grâce à des amis';

  @override
  String get paywall_referral_subtitle =>
      'Invitez un ami et obtenez 1 jour de statut PRO pour chaque personne qui s\'inscrit avec votre lien.';

  @override
  String paywall_get_pro_button(String price) {
    return 'Obtenir Aryonika PRO ($price)';
  }

  @override
  String get paywall_arbitrary_donate_button =>
      'Soutenir avec un autre montant';

  @override
  String get paywall_arbitrary_donate_subtitle =>
      'Si vous aimez notre projet, vous pouvez le soutenir pour nous aider à survivre dans un monde de requins et autres prédateurs.';

  @override
  String get chinese_zodiac_title => 'Zodiaque Chinois';

  @override
  String get zodiac_Rat => 'Rat';

  @override
  String get zodiac_Ox => 'Bœuf';

  @override
  String get zodiac_Tiger => 'Tigre';

  @override
  String get zodiac_Rabbit => 'Lapin';

  @override
  String get zodiac_Dragon => 'Dragon';

  @override
  String get zodiac_Snake => 'Serpent';

  @override
  String get zodiac_Horse => 'Cheval';

  @override
  String get zodiac_Goat => 'Chèvre';

  @override
  String get zodiac_Monkey => 'Singe';

  @override
  String get zodiac_Rooster => 'Coq';

  @override
  String get zodiac_Dog => 'Chien';

  @override
  String get zodiac_Pig => 'Cochon';

  @override
  String get chinese_zodiac_compatibility_button => 'Compatibilité du Zodiaque';

  @override
  String get compatibility_section_title => 'Compatibilité';

  @override
  String get userProfile_astro_button => 'Astrologie';

  @override
  String get userProfile_bazi_button => 'Bazi';

  @override
  String get jyotishCompatibilityTitle => 'Compatibilité Védique';

  @override
  String get jyotishDetailedAnalysisTitle => 'Analyse Détaillée (Ashta-Kuta)';

  @override
  String get kuta_tara_name => 'Tara Kuta (Destin)';

  @override
  String get kuta_tara_desc =>
      'Indique la chance, la durée et le bien-être dans la relation. Une bonne compatibilité ici est comme un vent favorable pour votre union.';

  @override
  String get kuta_yoni_name => 'Yoni Kuta (Attraction)';

  @override
  String get kuta_yoni_desc =>
      'Détermine l\'harmonie physique et sexuelle. Un score élevé indique une forte attraction mutuelle et de la satisfaction.';

  @override
  String get kuta_graha_maitri_name => 'Graha Maitri (Amitié)';

  @override
  String get kuta_graha_maitri_desc =>
      'Compatibilité psychologique et amitié. Reflète à quel point vos visions de la vie sont similaires et s\'il est facile pour vous de trouver un terrain d\'entente.';

  @override
  String get kuta_vashya_name => 'Vashya Kuta (Contrôle Mutuel)';

  @override
  String get kuta_vashya_desc =>
      'Montre le degré d\'influence mutuelle et de magnétisme dans le couple. Qui sera le leader et qui le suiveur.';

  @override
  String get kuta_gana_name => 'Gana Kuta (Tempérament)';

  @override
  String get kuta_gana_desc =>
      'Compatibilité au niveau du tempérament (Divin, Humain, Démoniaque). Aide à éviter les conflits de caractère.';

  @override
  String get kuta_bhakoot_name => 'Bhakoot Kuta (Amour et Famille)';

  @override
  String get kuta_bhakoot_desc =>
      'L\'un des indicateurs les plus importants. Responsable de la profondeur de l\'amour, du bonheur familial, de la prospérité financière et de la possibilité d\'avoir des enfants.';

  @override
  String get kuta_nadi_name => 'Nadi Kuta (Santé)';

  @override
  String get kuta_nadi_desc =>
      'Le critère le plus pondéré. Responsable de la santé, de la compatibilité génétique et de la longévité des partenaires et de leur descendance.';

  @override
  String get kuta_varna_name => 'Varna Kuta (Spiritualité)';

  @override
  String get kuta_varna_desc =>
      'Reflète la compatibilité de l\'ego et le développement spirituel des partenaires. Montre qui dans le couple stimulera le plus la croissance de l\'autre.';

  @override
  String get jyotishVerdictExcellent =>
      'Union Céleste ! Vos signes lunaires sont en parfaite harmonie. Ce lien promet une compréhension profonde, une croissance spirituelle et du bonheur pour les années à venir.';

  @override
  String get jyotishVerdictGood =>
      'Très bonne compatibilité. Vous avez toutes les chances de construire une relation forte, harmonieuse et heureuse. Les petits désaccords sont faciles à surmonter.';

  @override
  String get jyotishVerdictAverage =>
      'Compatibilité normale. Votre relation a à la fois des forces et des zones de croissance. Le succès de l\'union dépendra de votre volonté de travailler sur la relation.';

  @override
  String get jyotishVerdictChallenging =>
      'Compatibilité difficile. Vos cartes indiquent de sérieuses différences de caractères et de chemins de vie. Beaucoup de patience et de compromis seront nécessaires pour atteindre l\'harmonie.';

  @override
  String get passwordResetNewPasswordTitle => 'Définir un nouveau mot de passe';

  @override
  String get passwordResetNewPasswordLabel => 'Nouveau mot de passe';

  @override
  String get passwordResetConfirmLabel => 'Confirmer le mot de passe';

  @override
  String get passwordValidationError =>
      'Le mot de passe doit comporter au moins 6 caractères';

  @override
  String get passwordMismatchError => 'Les mots de passe ne correspondent pas';

  @override
  String get saveButton => 'Enregistrer';

  @override
  String get postActionLike => 'J\'aime';

  @override
  String get postActionComment => 'Commenter';

  @override
  String get postActionShare => 'Partager';

  @override
  String get channelDefaultName => 'Canal';

  @override
  String postShareText(Object channelName, Object postText) {
    return 'Découvrez cette publication dans le canal « $channelName » : $postText';
  }

  @override
  String get postDeleteDialogTitle => 'Supprimer la publication ?';

  @override
  String get postDeleteDialogContent =>
      'Cette action ne peut pas être annulée.';

  @override
  String get delete => 'Supprimer';

  @override
  String get postMenuDelete => 'Supprimer la publication';

  @override
  String get numerologySectionKeyNumbers => 'Nombres Clés';

  @override
  String get numerologySectionCurrentVibes => 'Vibrations Actuelles';

  @override
  String get numerologyTitleLifePath => 'Nombre du Chemin de Vie';

  @override
  String get numerologyTitleDestiny => 'Nombre de Destinée (d\'Expression)';

  @override
  String get numerologyTitleSoulUrge => 'Nombre d\'Élan Spirituel';

  @override
  String get numerologyTitlePersonality => 'Nombre de la Personnalité';

  @override
  String get numerologyTitleMaturity => 'Nombre de Maturité';

  @override
  String get numerologyTitleBirthday => 'Nombre d\'Anniversaire';

  @override
  String get numerologyTitlePersonalYear => 'Année Personnelle';

  @override
  String get numerologyTitlePersonalMonth => 'Mois Personnel';

  @override
  String get numerologyTitlePersonalDay => 'Jour Personnel';

  @override
  String get numerologyErrorNotEnoughData =>
      'Données insuffisantes pour le calcul.';

  @override
  String get numerologyErrorDescriptionsNotLoaded =>
      'Échec du chargement des descriptions numérologiques.';

  @override
  String get chat_error_recipient_not_found => 'Destinataire introuvable.';

  @override
  String get chat_error_recipient_profile_load_failed =>
      'Échec du chargement du profil du destinataire.';

  @override
  String get calculatingNumerology => 'Calcul du portrait numérologique...';

  @override
  String get oracle_title => 'Oracle';

  @override
  String get verifyEmailBody =>
      'Nous avons envoyé un code à 6 chiffres à votre e-mail. Veuillez le saisir ci-dessous.';

  @override
  String get verifyEmailHint => '------';

  @override
  String get signOutButton => 'Se déconnecter';

  @override
  String get errorInvalidOrExpiredCode => 'Code invalide ou expiré.';

  @override
  String get errorCodeRequired => 'Veuillez saisir le code de vérification.';

  @override
  String get errorInternalServer =>
      'Une erreur interne du serveur est survenue. Veuillez réessayer plus tard.';

  @override
  String get errorCodeLength => 'Le code doit comporter 6 chiffres.';

  @override
  String get verifyEmailTitle => 'Vérification de l\'E-mail';

  @override
  String get verificationCodeLabel => 'Code de Vérification';

  @override
  String get verificationCodeResent =>
      'Un nouveau code de vérification a été envoyé !';

  @override
  String get resendCodeAction => 'Renvoyer le code';

  @override
  String resendCodeCooldown(int seconds) {
    return 'Renvoyer dans ($seconds)s';
  }

  @override
  String verifyEmailInstruction(String email) {
    return 'Nous avons envoyé un code à 6 chiffres à votre e-mail :\n$email\nVeuillez le saisir ci-dessous.';
  }

  @override
  String get confirmButton => 'Confirmer';

  @override
  String get logout => 'Se Déconnecter';

  @override
  String get numerology_score_high => 'Élevée';

  @override
  String get numerology_score_medium => 'Moyenne';

  @override
  String get numerology_score_low => 'Faible';

  @override
  String get noUsersFound => 'Aucun utilisateur trouvé';

  @override
  String get feature_in_development => 'Bientôt disponible !';

  @override
  String get download_our_app => 'Téléchargez notre application';

  @override
  String get open_web_version => 'Ouvrir version WEB';

  @override
  String get pay_with_card => 'Payer par carte';

  @override
  String get coming_soon => 'Bientôt';

  @override
  String get paywall_subscription_terms =>
      'L\'abonnement se renouvelle automatiquement. Annulable à tout moment.';

  @override
  String get searchHint => 'Поиск...';

  @override
  String get nav_friends => 'Amis';

  @override
  String get oracle_typing => 'écrit...';

  @override
  String get tarot_reversed => '(Renversée)';

  @override
  String get common_close => 'Fermer';

  @override
  String oracle_limit_pro(Object hours) {
    return '$hours heures restantes.';
  }

  @override
  String oracle_limit_free(Object days) {
    return 'Limite gratuite atteinte. $days jours restants.';
  }

  @override
  String get oracle_error_stream => 'Erreur de connexion';

  @override
  String get oracle_error_start => 'Échec du démarrage';

  @override
  String get error_generic =>
      'Une erreur s\'est produite. Veuillez réessayer plus tard.';

  @override
  String get referral_already_used =>
      'Vous avez déjà utilisé un code de parrainage.';

  @override
  String get referral_own_code =>
      'Vous ne pouvez pas utiliser votre propre code.';

  @override
  String get referral_success =>
      'Code activé avec succès ! Vous avez reçu 3 jours de Premium.';

  @override
  String get tab_astrology => 'Astrologie';

  @override
  String get tab_numerology => 'Numérologie';

  @override
  String get tab_bazi => 'BaZi';

  @override
  String get tab_jyotish => 'Védique';

  @override
  String get share_result => 'Partager le résultat';

  @override
  String get share_preparing => 'Préparation...';

  @override
  String locked_feature_title(Object title) {
    return 'Section $title verrouillée';
  }

  @override
  String get locked_feature_desc =>
      'Cette section est disponible uniquement dans la version Premium.';

  @override
  String get get_access_button => 'Obtenir l\'accès';

  @override
  String get coming_soon_suffix => 'arrive bientôt';

  @override
  String get tab_summary => 'Сводка';

  @override
  String get tab_chinese_zodiac => 'Кит. Зодиак';

  @override
  String get summary_verdict_title => 'Общий вердикт';

  @override
  String get webVersionButton => 'Version Web';

  @override
  String get uploadPhotoDisclaimer =>
      'En téléchargeant une photo, vous confirmez qu\'elle ne contient ni nudité ni violence. Les contrevenants seront bannis définitivement.';

  @override
  String get iAgree => 'J\'accepte';

  @override
  String get testers_banner_title => 'TESTEURS RECHERCHÉS (4/20)';

  @override
  String get testers_banner_desc =>
      'Aidez-nous à améliorer Aryonika et obtenez\n✨ PREMIUM À VIE ✨';

  @override
  String get testers_email_hint =>
      '(Appuyez pour ouvrir, Maintenez pour copier)';

  @override
  String get numerology_day_1 =>
      'Jour des nouveaux départs. Parfait pour lancer des projets.';

  @override
  String get numerology_day_2 => 'Jour de partenariat. Cherchez des compromis.';

  @override
  String get numerology_day_3 => 'Jour de créativité. Exprimez-vous.';

  @override
  String get numerology_day_4 => 'Jour de travail. Organisez vos affaires.';

  @override
  String get numerology_day_5 =>
      'Jour de changement. Soyez ouvert à la nouveauté.';

  @override
  String get numerology_day_6 => 'Jour d\'harmonie. Temps pour la famille.';

  @override
  String get numerology_day_7 => 'Jour de réflexion. Temps pour la solitude.';

  @override
  String get numerology_day_8 => 'Jour de pouvoir. Focus sur la carrière.';

  @override
  String get numerology_day_9 =>
      'Jour d\'achèvement. Laissez partir l\'ancien.';

  @override
  String get astro_transit_positive_general =>
      'Звезды на вашей стороне. Действуйте смело.';

  @override
  String get advice_general_balance =>
      'Сохраняйте баланс между чувствами и разумом.';

  @override
  String get astro_advice_listen_intuition => 'Écoutez votre voix intérieure.';

  @override
  String get astro_advice_act_boldly =>
      'L\'énergie favorise l\'action audacieuse.';

  @override
  String get astro_advice_rest_and_reflect =>
      'Les étoiles conseillent de ralentir.';

  @override
  String get astro_advice_connect_with_nature =>
      'Passez du temps dans la nature.';

  @override
  String get advice_generic_positive =>
      'L\'Univers est de votre côté aujourd\'hui.';

  @override
  String get channelLoadError => 'Échec du chargement du canal';

  @override
  String get postsTitle => 'Publications';

  @override
  String get noPostsYet => 'Aucune publication dans ce canal pour le moment.';

  @override
  String get createPostTooltip => 'Créer un message';

  @override
  String get proposePost => 'Proposer une nouvelle';

  @override
  String get channelsTitle => 'Chaînes';

  @override
  String get noChannelSubscriptions => 'Pas encore d\'abonnements';

  @override
  String get noMessagesYet => 'Pas encore de messages';

  @override
  String get yesterday => 'Hier';

  @override
  String get search => 'Rechercher';

  @override
  String get adminOnlyFeature =>
      'La création de chaînes est temporairement réservée aux administrateurs.';

  @override
  String get createChannel => 'Créer une chaîne';

  @override
  String get galacticBroadcasts => 'Diffusions Galactiques';

  @override
  String get noChannelsYet =>
      'Vous n\'êtes encore abonné à rien.\nTrouvez ou créez votre propre chaîne !';

  @override
  String get constellationsTitle => 'Constellations';

  @override
  String get privateChatsTab => 'Privé';

  @override
  String get channelsTab => 'Chaînes';

  @override
  String get loadingUser => 'Chargement de l\'utilisateur...';

  @override
  String get emptyChatsPlaceholder =>
      'Vos discussions privées apparaîtront ici.\nTrouvez quelqu\'un d\'intéressant via la recherche !';

  @override
  String get errorTitle => 'Erreur';

  @override
  String get autoDeleteMessages => 'Suppression auto';

  @override
  String get availableInPro => 'Disponible en PRO';

  @override
  String get timerOff => 'Désactivé';

  @override
  String get timer15min => '15 minutes';

  @override
  String get timer1hour => '1 heure';

  @override
  String get timer4hours => '4 heures';

  @override
  String get timer24hours => '24 heures';

  @override
  String get timerSet => 'Minuterie réglée';

  @override
  String get disappearingMessages => 'Messages éphémères';

  @override
  String get communicationTitle => 'Communication';

  @override
  String get errorLoadingReport => 'Erreur lors du chargement du rapport';

  @override
  String get compatibility => 'Compatibilité';

  @override
  String get strengths => 'Points forts';

  @override
  String get weaknesses => 'Difficultés potentielles';

  @override
  String get commentsTitle => 'Commentaires';

  @override
  String get commentsLoadError => 'Erreur lors du chargement des commentaires.';

  @override
  String get noCommentsYet => 'Pas encore de commentaires.';

  @override
  String userIsTyping(Object name) {
    return '$name est en train d\'écrire...';
  }

  @override
  String twoUsersTyping(Object name1, Object name2) {
    return '$name1 et $name2 écrivent...';
  }

  @override
  String manyUsersTyping(Object count, Object name1, Object name2) {
    return '$name1, $name2 et $count autres écrivent...';
  }

  @override
  String replyingTo(Object name) {
    return 'Réponse à $name';
  }

  @override
  String get writeCommentHint => 'Écrire un commentaire...';

  @override
  String get compatibilityTitle => 'Connexion Cosmique';

  @override
  String get noData => 'Pas de données';

  @override
  String get westernAstrology => 'Astrologie Occidentale';

  @override
  String get vedicAstrology => 'Astrologie Védique (Jyotish)';

  @override
  String get numerology => 'Numérologie';

  @override
  String get chineseZodiac => 'Zodiaque Chinois';

  @override
  String get baziElements => 'Ba Zi (Éléments)';

  @override
  String get availableInPremium => 'Disponible en Premium';

  @override
  String get verdictSoulmates => 'Âmes Sœurs';

  @override
  String get verdictGreatMatch => 'Excellent Accord';

  @override
  String get verdictPotential => 'A du Potentiel';

  @override
  String get verdictKarmic => 'Leçon Karmique';

  @override
  String get createChannelTitle => 'Créer une diffusion';

  @override
  String get channelNameLabel => 'Nom de la diffusion';

  @override
  String get channelNameHint => 'Par ex., \'Prévisions Tarot Quotidiennes\'';

  @override
  String get errorChannelNameEmpty => 'Le nom ne peut pas être vide';

  @override
  String get channelHandleLabel => 'ID Unique (@handle)';

  @override
  String get errorChannelHandleShort =>
      'L\'ID doit comporter plus de 4 caractères';

  @override
  String get channelDescriptionLabel => 'Description';

  @override
  String get channelDescriptionHint =>
      'Dites-nous de quoi parle votre chaîne...';

  @override
  String get errorChannelDescriptionEmpty => 'Veuillez ajouter une description';

  @override
  String get createButton => 'Créer';

  @override
  String get editProfileTitle => 'Modifier le profil';

  @override
  String get profileNotFoundError => 'Erreur : Profil non trouvé';

  @override
  String get profileSavedSuccess => 'Profil enregistré avec succès !';

  @override
  String get saveError => 'Erreur d\'enregistrement';

  @override
  String get avatarUploadError => 'Erreur de téléchargement de la photo';

  @override
  String get nameLabel => 'Nom';

  @override
  String get bioLabel => 'À propos de moi';

  @override
  String get birthDataTitle => 'Données de naissance';

  @override
  String get birthDataWarning =>
      'La modification de ces données entraînera un recalcul complet de votre portrait astrologique et numérologique.';

  @override
  String get birthDateLabel => 'Date de naissance';

  @override
  String get birthPlaceLabel => 'Lieu de naissance';

  @override
  String get errorUserNotFound => 'Erreur : Utilisateur non trouvé';

  @override
  String get feedUpdateError => 'Erreur de mise à jour du flux';

  @override
  String get feedEmptyMessage =>
      'Votre flux est vide.\nTirez vers le bas pour actualiser.';

  @override
  String get whereToSearch => 'Où chercher';

  @override
  String get searchNearby => 'À proximité';

  @override
  String get searchCity => 'Ville';

  @override
  String get searchCountry => 'Pays';

  @override
  String get searchWorld => 'Monde';

  @override
  String get ageLabel => 'Âge';

  @override
  String get showGenderLabel => 'Montrer';

  @override
  String get genderAll => 'Tous';

  @override
  String get zodiacFilterLabel => 'Éléments du Zodiaque';

  @override
  String get resetFilters => 'Réinitialiser';

  @override
  String get applyFilters => 'Appliquer';

  @override
  String get forecastLoadError =>
      'Échec du chargement des prévisions.\nVeuillez réessayer plus tard.';

  @override
  String get noForecastEvents =>
      'Aucun événement astrologique significatif aujourd\'hui.\nUne journée calme !';

  @override
  String get unlockFullForecast => 'Débloquer les prévisions complètes';

  @override
  String get myFriendsTab => 'Mes Amis';

  @override
  String get friendRequestsTab => 'Demandes';

  @override
  String get noFriendsYet =>
      'Vous n\'avez pas encore d\'amis. Trouvez-les dans la recherche !';

  @override
  String get noFriendRequests => 'Aucune nouvelle demande.';

  @override
  String get removeFriend => 'Retirer des amis';

  @override
  String get gamesComingSoonTitle => 'Jeux et Récompenses bientôt !';

  @override
  String get gamesComingSoonDesc =>
      'Nous préparons des mini-jeux et des quiz passionnants. Vérifiez votre compatibilité, gagnez de la \"Poussière d\'étoile\" et échangez-la contre du premium ou des cadeaux !';

  @override
  String get joinTelegramButton =>
      'Soyez le premier informé sur notre Telegram';

  @override
  String horoscopeForSign(Object sign) {
    return 'Horoscope pour $sign';
  }

  @override
  String get horoscopeGeneral => 'Général';

  @override
  String get horoscopeLove => 'Amour';

  @override
  String get horoscopeBusiness => 'Travail';

  @override
  String get verdictNotFound => 'Verdict non trouvé';

  @override
  String get vedicCompatibilityTitle => 'Compatibilité Védique';

  @override
  String get ashtaKutaAnalysis => 'Analyse Détaillée (Ashta-Kuta)';

  @override
  String get noDescription => 'Description non trouvée.';

  @override
  String get likesYouEmpty =>
      'Les personnes intéressées par vous apparaîtront ici';

  @override
  String peopleLikeYou(Object count) {
    return '$count personnes vous aiment !';
  }

  @override
  String get getProToSeeLikes =>
      'Obtenez le statut PRO pour voir leurs profils et discuter.';

  @override
  String get seeLikesButton => 'Voir les Likes';

  @override
  String get someone => 'Quelqu\'un';

  @override
  String get selectCityTitle => 'Sélectionner la ville';

  @override
  String get searchCityHint => 'Entrez le nom de la ville...';

  @override
  String get nothingFound => 'Rien trouvé';

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
  String get moderationProposedPosts => 'Messages proposés';

  @override
  String get noProposedPosts => 'Aucun message proposé.';

  @override
  String get from => 'De';

  @override
  String get personalNumerologyTitle => 'Numérologie Personnelle';

  @override
  String get dataNotLoaded => 'Données non chargées';

  @override
  String get loading => 'Chargement...';

  @override
  String get lifePathNumber => 'Chemin de Vie';

  @override
  String get corePersonality => 'Noyau de la Personnalité';

  @override
  String get destinyNumber => 'Nombre de Destinée';

  @override
  String get soulNumber => 'Nombre de l\'Âme';

  @override
  String get personalityNumber => 'Nombre de Personnalité';

  @override
  String get timeInfluence => 'Influence du Temps';

  @override
  String get maturityNumber => 'Nombre de Maturité';

  @override
  String get birthdayNumber => 'Nombre de Naissance';

  @override
  String get currentVibrationsPro => 'Vibrations Actuelles (PRO)';

  @override
  String get personalYear => 'Année Personnelle';

  @override
  String get personalMonth => 'Mois Personnel';

  @override
  String get personalDay => 'Jour Personnel';

  @override
  String get proVibrationsDesc =>
      'Découvrez vos vibrations pour l\'Année, le Mois et le Jour. Disponible en Premium uniquement.';

  @override
  String get unlockButton => 'Débloquer';

  @override
  String get tapForDetails => 'Appuyez pour les détails';

  @override
  String oracle_weather_desc(Object desc, Object kp) {
    return '$desc (Kp : $kp)';
  }

  @override
  String oracle_geomagnetic_now(Object desc) {
    return 'Maintenant : $desc';
  }

  @override
  String oracle_geomagnetic_index(Object kp) {
    return 'Indice Kp : $kp';
  }

  @override
  String get oracle_question_title => 'Demander à l\'Oracle';

  @override
  String get oracle_question_hint => 'Qu\'est-ce qui vous préoccupe ?...';

  @override
  String get oracle_question_button => 'Obtenir la réponse';

  @override
  String get palmistry_analysis_title => 'Analyse de la Paume';

  @override
  String get palmistry_choose_option =>
      'Choisissez l\'option la plus appropriée :';

  @override
  String get palmistry_analysis_saved => 'Analyse enregistrée !';

  @override
  String get palmistry_view_report => 'Voir le rapport complet';

  @override
  String get palmistry_complete_all =>
      'Terminez l\'analyse de toutes les lignes';

  @override
  String get palmistry_analysis_complete => 'Super ! Analyse terminée.';

  @override
  String palmistry_tap_line(Object lineName) {
    return 'Appuyez sur \'$lineName\' pour comparer avec votre paume.';
  }

  @override
  String palmistry_searching_line(Object lineName) {
    return 'Recherche de \'$lineName\'...';
  }

  @override
  String get palmistry_preparing => 'Préparation de l\'analyse...';

  @override
  String get palmistry_report_title => 'Carte de Votre Destin';

  @override
  String get palmistry_data_not_found => 'Données d\'analyse non trouvées.';

  @override
  String get palmistry_strong_traits => 'Vos Points Forts';

  @override
  String get privacy => 'Confidentialité';

  @override
  String get palmistry_show_in_profile => 'Afficher mes traits dans le profil';

  @override
  String get palmistry_show_in_profile_desc =>
      'Cela permettra aux autres de mieux vous connaître et d\'améliorer la compatibilité.';

  @override
  String get palmistry_interpretation => 'Interprétation des Lignes';

  @override
  String palmistry_your_choice(Object choice) {
    return 'Votre choix : \"$choice\"';
  }

  @override
  String get photoAlbumComingSoon =>
      'Bientôt, vous pourrez télécharger vos photos ici.';

  @override
  String get settingsTitle => 'Paramètres';

  @override
  String get accountManagement => 'Gestion du compte';

  @override
  String get changePassword => 'Changer le mot de passe';

  @override
  String get restorePassword => 'Réinitialiser le mot de passe';

  @override
  String get editProfileButton => 'Modifier le profil';

  @override
  String get dailyNotifications => 'Notifications quotidiennes';

  @override
  String get alertsTitle => 'Alertes';

  @override
  String get geomagneticStorms => 'Tempêtes géomagnétiques';

  @override
  String get adminPanelTitle => 'Panneau d\'administration';

  @override
  String get adminManageUsers => 'Gérer les utilisateurs';

  @override
  String get offerAgreementLink => 'Contrat d\'offre';

  @override
  String get accountSectionTitle => 'Compte';

  @override
  String get deleteAccountButton => 'Supprimer le compte';

  @override
  String get closeAppButton => 'Fermer l\'application';

  @override
  String get changePasswordDesc =>
      'Veuillez entrer votre mot de passe actuel par sécurité.';

  @override
  String get currentPasswordLabel => 'Mot de passe actuel';

  @override
  String get newPasswordLabel => 'Nouveau mot de passe';

  @override
  String get passwordChangedSuccess => 'Mot de passe modifié avec succès !';

  @override
  String resetPasswordInstruction(String email) {
    return 'Nous enverrons les instructions de réinitialisation à votre E-mail :\n\n$email';
  }

  @override
  String get signOutDialogTitle => 'Se déconnecter';

  @override
  String get signOutDialogContent =>
      'Êtes-vous sûr de vouloir vous déconnecter ?';

  @override
  String get deleteAccountTitle => 'Supprimer le compte ?';

  @override
  String get deleteAccountWarning =>
      'Cette action est irréversible. Toutes vos données, discussions, photos et achats seront supprimés définitivement.';

  @override
  String get deleteForeverButton => 'Supprimer définitivement';

  @override
  String get roulette_trust_fate => 'Faites confiance au destin';

  @override
  String get roulette_desc_short =>
      'Les étoiles choisiront le partenaire le plus compatible pour vous (à partir de 85% !).';

  @override
  String get roulette_no_candidates => 'Aucun candidat pour tourner.';

  @override
  String get roulette_winner_title => 'Les étoiles ont fait leur choix !';

  @override
  String get roulette_spin_again => 'Tourner encore';

  @override
  String get roulette_go_to_profile => 'Aller au profil';

  @override
  String get cityNotSpecified => 'Ville non spécifiée';

  @override
  String get geomagnetic_calm => 'Calme';

  @override
  String get geomagnetic_unsettled => 'Instable';

  @override
  String get geomagnetic_active => 'Actif';

  @override
  String get geomagnetic_storm_minor => 'Tempête Mineure (G1)';

  @override
  String get geomagnetic_storm_moderate => 'Tempête Modérée (G2)';

  @override
  String get geomagnetic_storm_strong => 'Tempête Forte (G3)';

  @override
  String get geomagnetic_storm_severe => 'Tempête Sévère (G4)';

  @override
  String get geomagnetic_storm_extreme => 'Tempête Extrême (G5)';

  @override
  String get deleteChatTitle => 'Supprimer la discussion ?';

  @override
  String get deleteChatConfirmation =>
      'Tous les messages seront définitivement supprimés.';

  @override
  String get chatDeleted => 'Discussion supprimée';
}
