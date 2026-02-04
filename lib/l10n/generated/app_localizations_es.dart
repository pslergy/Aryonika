// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get profileCreationErrorTitle => 'Error al crear el perfil';

  @override
  String get profileCreationErrorDescription =>
      'Lamentablemente, hubo un error al guardar sus datos. Por favor, intente registrarse de nuevo.';

  @override
  String get tryAgain => 'Intentar de nuevo';

  @override
  String get connectingHearts =>
      'Conectando corazones a través del universo...';

  @override
  String get appName => 'Aryonika';

  @override
  String get exitConfirmationTitle => 'Confirmación';

  @override
  String get exitConfirmationContent =>
      '¿Está seguro de que quiere cerrar Aryonika?';

  @override
  String get cancel => 'Cancelar';

  @override
  String get close => 'Cerrar';

  @override
  String get paymentUrlError => 'Error: No se encontró la URL de pago.';

  @override
  String get channelIdError => 'Error: No se encontró el ID del canal.';

  @override
  String documentLoadError(Object error) {
    return 'Ошибка загрузки документа: $error';
  }

  @override
  String get partnerIdError =>
      'Error: Se requiere el ID del socio para el cálculo de compatibilidad.';

  @override
  String get bioPlaceholder => 'Tu historia podría estar aquí...';

  @override
  String photoAlbumTitle(Object photoCount) {
    return 'Álbum de fotos ($photoCount)';
  }

  @override
  String get photoAlbumSubtitle => 'Tus mejores momentos';

  @override
  String get cosmicEventsTitle => 'Eventos Cósmicos';

  @override
  String get cosmicEventsSubtitle =>
      'Aprende sobre la influencia de los planetas';

  @override
  String get inviteFriendTitle => 'Invitar a un amigo';

  @override
  String get inviteFriendSubtitle => 'Obtengan bonificaciones juntos';

  @override
  String get gameCenterTitle => 'Centro de Juegos';

  @override
  String get gameCenterSubtitle => 'Minijuegos y misiones';

  @override
  String get personalForecastTitle => 'Pronóstico Personal';

  @override
  String get personalForecastSubtitlePro => 'Análisis de tránsitos para hoy';

  @override
  String get personalForecastSubtitleFree => 'Disponible con el estado PRO';

  @override
  String get cosmicPassportTitle => 'PASAPORTE CÓSMICO';

  @override
  String get numerologyPortraitTitle => 'RETRATO NUMEROLÓGICO';

  @override
  String get yourNumbersOfDestinyTitle => 'Tus Números del Destino';

  @override
  String get yourNumbersOfDestinySubtitle => 'Desbloquea tu potencial';

  @override
  String get numerologyPath => 'Camino de Vida';

  @override
  String get numerologyDestiny => 'Destino';

  @override
  String get numerologySoul => 'Alma';

  @override
  String get signOut => 'Cerrar sesión';

  @override
  String get calculatingChart => 'Calculando carta...';

  @override
  String get astroDataSignMissing => 'Faltan datos para este signo.';

  @override
  String astroDataDescriptionNotFound(Object signName) {
    return 'No se encontró la descripción para \"$signName\".';
  }

  @override
  String astroDataMapNotLoaded(Object mapKey) {
    return 'No se cargaron los datos para \"$mapKey\".';
  }

  @override
  String get planetSun => 'Sol';

  @override
  String get planetMoon => 'Luna';

  @override
  String get planetAscendant => 'Ascendente';

  @override
  String get planetMercury => 'Mercurio';

  @override
  String get planetVenus => 'Venus';

  @override
  String get planetMars => 'Marte';

  @override
  String get planetSaturn => 'Saturno';

  @override
  String get planetJupiter => 'Júpiter';

  @override
  String get planetUranus => 'Urano';

  @override
  String get planetNeptune => 'Neptuno';

  @override
  String get planetPluto => 'Plutón';

  @override
  String get getProTitle => 'Obtener PRO';

  @override
  String get getProSubtitle => 'Desbloquea todas las funciones';

  @override
  String get proStatusActive => 'El estado PRO está activo';

  @override
  String get proStatusExpired => 'El estado ha expirado';

  @override
  String proStatusDaysLeft(Object days) {
    return 'Días restantes: $days';
  }

  @override
  String proStatusHoursLeft(Object hours) {
    return 'Horas restantes: $hours';
  }

  @override
  String get proStatusExpiresToday => 'Expira hoy';

  @override
  String astroDialogTitle(Object planetName, Object signName) {
    return '$planetName en $signName';
  }

  @override
  String get likesYouTitle => 'Le gustas';

  @override
  String likesYouTotal(Object count) {
    return 'Total de \'me gusta\': $count';
  }

  @override
  String get likesYouNone => 'Aún no hay \'me gusta\'';

  @override
  String reportOnUser(Object userName) {
    return 'Reportar a $userName';
  }

  @override
  String get reportReasonSpam => 'Spam';

  @override
  String get reportReasonInsultingBehavior => 'Comportamiento ofensivo';

  @override
  String get reportReasonScam => 'Estafa';

  @override
  String get reportReasonInappropriateContent => 'Contenido inapropiado';

  @override
  String get reportDetailsHint => 'Detalles adicionales (opcional)';

  @override
  String get send => 'Enviar';

  @override
  String get reportSentSnackbar => '¡Gracias! Tu reporte ha sido enviado.';

  @override
  String get profileLoadError => 'Error al cargar el perfil';

  @override
  String get back => 'Volver';

  @override
  String get report => 'Reportar';

  @override
  String userProfilePhotoAlbumTitle(Object photoCount) {
    return 'Álbum de fotos ($photoCount)';
  }

  @override
  String get userProfileViewPhotos => 'Ver fotos';

  @override
  String get aboutMe => 'Sobre mí';

  @override
  String get bioEmpty =>
      'Este usuario aún no ha compartido nada sobre sí mismo.';

  @override
  String get cosmicPassport => 'Pasaporte Cósmico';

  @override
  String sunInSign(Object signName) {
    return '☀️ Sol en $signName';
  }

  @override
  String get friendshipStatusFriends => 'Son amigos';

  @override
  String get friendshipRemoveTitle => '¿Eliminar de amigos?';

  @override
  String friendshipRemoveContent(Object userName) {
    return '¿Estás seguro de que quieres eliminar a $userName de tus amigos?';
  }

  @override
  String get remove => 'Eliminar';

  @override
  String get friendshipStatusRequestSent => 'Solicitud enviada';

  @override
  String get friendshipActionDecline => 'Rechazar';

  @override
  String get friendshipActionAccept => 'Aceptar';

  @override
  String get friendshipActionAdd => 'Añadir amigo';

  @override
  String likeSnackbarSuccess(Object userName) {
    return '¡Te gusta $userName!';
  }

  @override
  String likeSnackbarAlreadyLiked(Object userName) {
    return 'Ya te gusta $userName';
  }

  @override
  String get writeMessage => 'Escribir mensaje';

  @override
  String get checkCompatibility => 'Verificar compatibilidad';

  @override
  String get yourCosmicInfluence => 'Tu Influencia Cósmica Hoy';

  @override
  String get cosmicEventsLoading => 'Calculando eventos cósmicos...';

  @override
  String get cosmicEventsEmpty =>
      'El cosmos está en calma hoy. ¡Disfruta de la armonía!';

  @override
  String get cosmicEventsError =>
      'No se pudieron calcular los eventos cósmicos. Inténtalo de nuevo más tarde.';

  @override
  String get cosmicConnectionTitle => 'Vínculo Cósmico';

  @override
  String shareText(Object name, Object score) {
    return '¡Nuestra compatibilidad con $name es del $score%! ✨\nCalculado en Aryonika';
  }

  @override
  String get shareErrorSnackbar => 'Ocurrió un error al intentar compartir.';

  @override
  String get compatibilityErrorTitle => 'No se pudo calcular la compatibilidad';

  @override
  String get compatibilityErrorSubtitle =>
      'Los datos del socio pueden estar incompletos o ocurrió un error de red.';

  @override
  String get goBack => 'Regresar';

  @override
  String get sectionCosmicAdvice => 'CONSEJO CÓSMICO';

  @override
  String get sectionDailyInfluence => 'INFLUENCIA DIARIA';

  @override
  String get sectionAstrologicalResonance => 'RESONANCIA ASTROLÓGICA';

  @override
  String get sectionNumerologyMatrix => 'MATRIZ NUMEROLÓGICA';

  @override
  String get sectionPalmistryConnection => 'CONEXIÓN DE QUIROMANCIA';

  @override
  String get sectionAboutPerson => 'SOBRE LA PERSONA';

  @override
  String get palmistryNoData =>
      'Uno de los socios aún no ha completado el análisis de la palma. ¡Esto desbloqueará un nuevo nivel de su compatibilidad!';

  @override
  String palmistryCommonTraits(Object traits) {
    return 'Los une: $traits. Esto crea una base sólida para su relación.';
  }

  @override
  String palmistryUniqueTraits(Object myTrait, Object partnerTrait) {
    return 'Se complementan mutuamente: tu rasgo \'$myTrait\' armoniza perfectamente con su rasgo \'$partnerTrait\'.';
  }

  @override
  String get harmony => 'Armonía';

  @override
  String get adviceRareConnection =>
      'Sus almas resuenan al unísono. Esta es una rara conexión cósmica donde tanto las personalidades (Sol) como las emociones (Luna) están en armonía. Valoren este tesoro.';

  @override
  String get advicePassionChallenge =>
      'Una llama de pasión arde entre ustedes, pero sus personalidades pueden chocar. Aprendan a convertir las discusiones en energía para crecer, y su vínculo se volverá inquebrantable.';

  @override
  String get adviceBestFriends =>
      'Son los mejores amigos, se entienden con una mirada y se sienten cómodos juntos. La atracción física puede crecer con el tiempo; lo principal es su cercanía espiritual.';

  @override
  String get adviceKarmicLesson =>
      'Sus caminos se cruzaron por una razón. Esta conexión trae lecciones importantes para ambos. Sean pacientes y abiertos para entender lo que deben enseñarse mutuamente.';

  @override
  String get adviceGreatPotential =>
      'Hay una fuerte atracción entre ustedes y un gran potencial para crecer. Aprendan el uno del otro, y su vínculo se fortalecerá. Las estrellas están de su lado.';

  @override
  String get adviceBase =>
      'Estúdiense mutuamente. Cada encuentro es una oportunidad para descubrir un nuevo universo. Su historia apenas comienza.';

  @override
  String get dailyInfluenceCalm =>
      'Calma cósmica. Un gran día para simplemente disfrutar de la compañía del otro sin influencias externas.';

  @override
  String get dailyAdviceFavorable =>
      'Consejo: ¡Usen esta energía! Un excelente momento para planes conjuntos.';

  @override
  String get dailyAdviceTense =>
      'Consejo: Sean más pacientes el uno con el otro. Es posible que haya malentendidos.';

  @override
  String get proFeatureLocked =>
      'El análisis detallado de este aspecto está disponible en la versión PRO.';

  @override
  String get getProButton => 'Obtener PRO';

  @override
  String get numerologyLifePath => 'Camino de Vida';

  @override
  String get numerologyDestinyNumber => 'Número de Destino';

  @override
  String get numerologySoulNumber => 'Número del Alma';

  @override
  String get shareCardTitle => 'Aryonika';

  @override
  String get shareCardSubtitle => 'INFORME DE COMPATIBILIDAD CÓSMICA';

  @override
  String get shareCardHarmony => 'Armonía General';

  @override
  String get shareCardPersonalityHarmony => 'Armonía de Personalidades (Sol)';

  @override
  String get shareCardLifePath => 'Camino de Vida (Numerología)';

  @override
  String get shareCardCtaTitle => '¡Descubre tu compatibilidad\ncósmica!';

  @override
  String get shareCardCtaSubtitle => 'Descarga Aryonika en RuStore';

  @override
  String get loginTitle => 'Iniciar Sesión';

  @override
  String get loginError => 'Error de inicio de sesión';

  @override
  String get passwordResetTitle => 'Restablecer contraseña';

  @override
  String get passwordResetContent =>
      'Ingrese su correo electrónico y le enviaremos instrucciones para restablecer su contraseña.';

  @override
  String get emailLabel => 'Correo electrónico';

  @override
  String get sendButton => 'Enviar';

  @override
  String get emailValidationError =>
      'Por favor, ingrese un correo electrónico válido.';

  @override
  String get passwordResetSuccess =>
      '¡Correo enviado! Revisa tu bandeja de entrada.';

  @override
  String get passwordLabel => 'Contraseña';

  @override
  String get loginButton => 'Iniciar Sesión';

  @override
  String get forgotPasswordButton => '¿Olvidaste tu contraseña?';

  @override
  String get noAccountButton => '¿No tienes cuenta? Regístrate';

  @override
  String get registerTitle => 'Crear Cuenta';

  @override
  String get unknownError => 'Ocurrió un error desconocido';

  @override
  String get confirmPasswordLabel => 'Confirmar contraseña';

  @override
  String get privacyPolicyCheckbox => 'He leído y acepto los ';

  @override
  String get termsOfUseLink => 'Términos de Uso';

  @override
  String get and => ' y la ';

  @override
  String get privacyPolicyLink => 'Política de Privacidad';

  @override
  String get registerButton => 'Registrarse';

  @override
  String get alreadyHaveAccountButton =>
      '¿Ya tienes una cuenta? Iniciar Sesión';

  @override
  String get welcomeTagline => 'Tu destino está escrito en las estrellas';

  @override
  String get welcomeCreateAccountButton => 'Crear un pasaporte cósmico';

  @override
  String get welcomeLoginButton => 'Ya tengo una cuenta';

  @override
  String get introSlide1Title => 'Aryonika — Más que citas';

  @override
  String get introSlide1Description =>
      'Descubre nuevos niveles de compatibilidad a través de la astrología, la numerología y las Cartas del Destino.';

  @override
  String get introSlide2Title => 'Tu Pasaporte Cósmico';

  @override
  String get introSlide2Description =>
      'Aprende todo sobre tu potencial y encuentra a quien complete tu universo.';

  @override
  String get introSlide3Title => 'Únete a la Galaxia';

  @override
  String get introSlide3Description =>
      'Comienza tu viaje cósmico hacia el amor verdadero ahora mismo.';

  @override
  String get introButtonSkip => 'Saltar';

  @override
  String get introButtonNext => 'Siguiente';

  @override
  String get introButtonStart => 'Comenzar';

  @override
  String get onboardingNameTitle => '¿Cómo te llamas?';

  @override
  String get onboardingNameSignOutTooltip => 'Cerrar sesión (para pruebas)';

  @override
  String get onboardingNameSubtitle =>
      'Este nombre será visible para otros usuarios.';

  @override
  String get onboardingNameLabel => 'Tu nombre';

  @override
  String get onboardingBioLabel => 'Cuéntanos sobre ti';

  @override
  String get onboardingBioHint =>
      'Ejemplo: Me encanta la astrología y #viajar...';

  @override
  String get onboardingButtonNext => 'Siguiente';

  @override
  String get onboardingBirthdateTitle => '¿Cuándo naciste?';

  @override
  String get onboardingBirthdateSubtitle =>
      'Esto es necesario para un cálculo preciso de tu carta natal y numerología.';

  @override
  String get datePickerHelpText => 'SELECCIONE LA FECHA DE NACIMIENTO';

  @override
  String get birthdateLabel => 'Fecha de nacimiento';

  @override
  String get birthdatePlaceholder => 'Toca para seleccionar';

  @override
  String get dateFormat => 'd \'de\' MMMM \'de\' yyyy';

  @override
  String get onboardingFinishText1 =>
      'Analizando la posición de las estrellas...';

  @override
  String get onboardingFinishText2 => 'Calculando tu código numerológico...';

  @override
  String get onboardingFinishText3 => 'Consultando las Cartas del Destino...';

  @override
  String get onboardingFinishText4 => 'Creando tu pasaporte cósmico...';

  @override
  String get onboardingFinishErrorTitle => 'Error';

  @override
  String get onboardingFinishErrorContent => 'Ocurrió un error desconocido.';

  @override
  String get onboardingFinishErrorButton => 'Volver';

  @override
  String get onboardingGenderTitle => 'Tu género';

  @override
  String get onboardingGenderSubtitle =>
      'Esto nos ayudará a encontrar las personas más adecuadas para ti.';

  @override
  String get genderMale => 'Hombres';

  @override
  String get genderFemale => 'Mujeres';

  @override
  String get onboardingLocationTitle => 'Lugar de nacimiento';

  @override
  String get onboardingLocationSubtitle =>
      'Por favor, especifique la ciudad donde nació. Esto es necesario para un cálculo astrológico preciso.';

  @override
  String get onboardingLocationSearchHint => 'Empiece a escribir una ciudad...';

  @override
  String get onboardingLocationNotFound =>
      'No se encontraron ciudades. Intente con otra búsqueda.';

  @override
  String get onboardingLocationStartSearch =>
      'Comience a buscar para ver los resultados';

  @override
  String get onboardingLocationSelectFromList =>
      'Seleccione una ciudad de la lista de arriba para continuar';

  @override
  String get onboardingTimeTitle => 'Hora de nacimiento';

  @override
  String get onboardingTimeSubtitle =>
      'Si no sabes la hora exacta, ajústala a las 12:00.\nEsto todavía dará un buen resultado.';

  @override
  String get timePickerHelpText => 'SELECCIONE LA HORA DE NACIMIENTO';

  @override
  String get birthTimeLabel => 'Hora de nacimiento';

  @override
  String get onboardingButtonNextLocation => 'Siguiente (seleccionar lugar)';

  @override
  String get alphaBannerTitle => 'Versión Alfa';

  @override
  String get alphaBannerContent =>
      'Esta sección está en desarrollo activo. Algunas funciones pueden ser inestables. Estamos trabajando activamente en la localización, por lo que algunos textos aún pueden estar en ruso. ¡Gracias por su comprensión!';

  @override
  String get alphaBannerFeedback =>
      '¡Agradecemos sus comentarios y sugerencias en nuestro canal de Telegram!';

  @override
  String get astro_title_sun => 'Compatibilidad de Personalidad (Sol)';

  @override
  String get astro_title_moon => 'Compatibilidad Emocional (Luna)';

  @override
  String get astro_title_chemistry => 'Química Astrológica (Venus-Marte)';

  @override
  String get astro_title_mercury => 'Estilo de Comunicación (Mercurio)';

  @override
  String get astro_title_saturn => 'Perspectiva a largo plazo (Saturno)';

  @override
  String get numerology_title => 'Resonancia Numerológica';

  @override
  String get cosmicPulseTitle => 'Pulso Cósmico';

  @override
  String get feedIceBreakerTitle => 'Rompehielos';

  @override
  String get feedOrbitCrossingTitle => 'Cruce de Órbita';

  @override
  String get feedSpiritualNeighborTitle => 'Vecino Espiritual';

  @override
  String get feedGeomagneticStormTitle => 'Tormenta Geomagnética';

  @override
  String get feedCompatibilityPeakTitle => 'Pico de Compatibilidad';

  @override
  String get feedNewChannelSuggestionTitle => 'Nuevo Canal';

  @override
  String get feedPopularPostTitle => 'Publicación Popular';

  @override
  String get feedNewCommentTitle => 'Nuevo Comentario';

  @override
  String get cardOfTheDayTitle => 'Carta del Día';

  @override
  String get cardOfTheDayDrawing => 'Sacando tu carta...';

  @override
  String get cardOfTheDayGetButton => 'Sacar Carta';

  @override
  String get cardOfTheDayYourCard => 'Tu Carta del Día';

  @override
  String get cardOfTheDayTapToReveal => 'Toca para revelar';

  @override
  String get cardOfTheDayReversedSuffix => ' (Invertida)';

  @override
  String get cardOfTheDayDefaultInterpretation =>
      'Descubre lo que el día te depara.';

  @override
  String get channelSearchTitle => 'Buscar Canales';

  @override
  String get channelAnonymousAuthor => 'Anónimo';

  @override
  String get errorUserNotAuthorized => 'Usuario no autorizado';

  @override
  String get errorUnknownServer => 'Error de servidor desconocido';

  @override
  String get errorFailedToLoadData => 'No se pudieron cargar los datos';

  @override
  String get generalHello => 'Hola';

  @override
  String get referralErrorProfileNotLoaded =>
      'Error: tu perfil no está cargado. Por favor, inténtalo de nuevo más tarde.';

  @override
  String get referralErrorAlreadyUsed =>
      'Ya has utilizado un código de referencia.';

  @override
  String get referralErrorOwnCode => 'No puedes usar tu propio código.';

  @override
  String get referralScreenTitle => 'Invitar a un amigo';

  @override
  String get referralYourCodeTitle => 'Tu código de invitación';

  @override
  String get referralYourCodeDescription =>
      'Comparte este código con amigos. ¡Por cada amigo que ingrese tu código, recibirás 1 día de acceso PRO!';

  @override
  String get referralCodeCopied => '¡Código copiado al portapapeles!';

  @override
  String get referralShareCodeButton => 'Compartir código';

  @override
  String referralShareMessage(String code) {
    return '¡Hola! Únete a mí en Aryonika para encontrar a tu pareja cósmica. Ingresa mi código de invitación en la aplicación para que ambos obtengamos bonificaciones: $code';
  }

  @override
  String get referralManualBonusNote =>
      'El acceso PRO se otorga manualmente dentro de las 24 horas posteriores a que tu amigo ingrese el código.';

  @override
  String get referralGotCodeTitle => '¿Tienes un código?';

  @override
  String get referralGotCodeDescription =>
      'Ingresa el código que te dio tu amigo para que reciba su recompensa.';

  @override
  String get referralCodeInputLabel => 'Código de invitación';

  @override
  String get referralCodeValidationError => 'Por favor, ingresa un código';

  @override
  String get referralApplyCodeButton => 'Aplicar código';

  @override
  String get nav_feed => 'Feed';

  @override
  String get nav_search => 'Buscar';

  @override
  String get nav_oracle => 'Oráculo';

  @override
  String get nav_chats => 'Chats';

  @override
  String get nav_channels => 'Canales';

  @override
  String get nav_profile => 'Perfil';

  @override
  String get nav_exit => 'Salir';

  @override
  String get exitDialog_title => 'Confirmación';

  @override
  String get exitDialog_content =>
      '¿Estás seguro de que quieres cerrar Aryonika?';

  @override
  String get exitDialog_cancel => 'Cancelar';

  @override
  String get exitDialog_confirm => 'Cerrar';

  @override
  String get oracle_limit_title => 'Límite de Solicitudes';

  @override
  String get oracle_limit_later => 'Más tarde';

  @override
  String get oracle_limit_get_pro => 'Obtener Ilimitado';

  @override
  String get oracle_orb_partner => 'Pareja del Día';

  @override
  String get oracle_orb_roulette => 'Ruleta';

  @override
  String get oracle_orb_duet => 'Dúo';

  @override
  String get oracle_orb_horoscope => 'Horóscopo';

  @override
  String get oracle_orb_weather => 'Geomagnético';

  @override
  String get oracle_orb_ask => 'Pregunta';

  @override
  String get oracle_orb_focus => 'Enfoque del Día';

  @override
  String get oracle_orb_forecast => 'AstroPronóstico';

  @override
  String get oracle_orb_card => 'Carta del Día';

  @override
  String get oracle_orb_tarot => 'Respuesta del Universo';

  @override
  String get oracle_orb_palmistry => 'Quiromancia';

  @override
  String get oracle_duet_title => 'Dúo Cósmico';

  @override
  String get oracle_duet_description =>
      'Comprueba la compatibilidad por fecha de nacimiento.';

  @override
  String get oracle_duet_button => 'Comprobar Compatibilidad';

  @override
  String oracle_unsupported_web_feature(String featureName, Object feature) {
    return 'Función \'$feature\' no disponible en WEB.';
  }

  @override
  String get oracle_pro_card_of_day_title => 'Carta del Día (PRO)';

  @override
  String get oracle_pro_card_of_day_desc =>
      'Descubre la energía de tu día. Disponible en PRO.';

  @override
  String get oracle_pro_focus_of_day_title => 'Enfoque del Día (PRO)';

  @override
  String get oracle_pro_focus_of_day_desc =>
      'Descubre en qué enfocarte hoy. Disponible en PRO.';

  @override
  String get oracle_pro_forecast_of_day_title => 'Pronóstico Personal (PRO)';

  @override
  String get oracle_pro_forecast_of_day_desc =>
      'Análisis detallado de tránsitos. Disponible en PRO.';

  @override
  String get oracle_roulette_title => 'Ruleta Cósmica';

  @override
  String get oracle_roulette_description =>
      '¡Prueba tu suerte! Encuentra una pareja aleatoria.';

  @override
  String get oracle_roulette_button => 'Girar Ruleta';

  @override
  String get oracle_card_of_day_reversed => '(invertida)';

  @override
  String get oracle_card_of_day_get_key => 'Obtener Clave Personal';

  @override
  String get oracle_palmistry_title => 'Quiromancia';

  @override
  String get oracle_palmistry_description =>
      'Análisis de líneas de la mano por IA.';

  @override
  String get oracle_palmistry_button => 'Escanear Mano';

  @override
  String get oracle_ask_loading => 'El Oráculo está pensando...';

  @override
  String get oracle_ask_again => 'Preguntar de nuevo';

  @override
  String get oracle_focus_loading => 'Enfocando...';

  @override
  String get oracle_focus_error => 'Error de carga';

  @override
  String get oracle_focus_no_data => 'Sin datos';

  @override
  String get oracle_forecast_loading => 'Componiendo tu pronóstico personal...';

  @override
  String get oracle_forecast_error => 'No se pudo crear el pronóstico';

  @override
  String get oracle_forecast_try_again => 'Intentar de Nuevo';

  @override
  String get oracle_forecast_title => 'Pronóstico Diario';

  @override
  String get oracle_forecast_day_number => 'Tu número del día: ';

  @override
  String get oracle_tarot_title => 'Lectura de Tarot (IA)';

  @override
  String get oracle_tarot_hint => 'Tu pregunta...';

  @override
  String get oracle_tarot_button => 'Hacer Lectura';

  @override
  String oracle_tarot_your_question(String question) {
    return 'Tu pregunta: $question';
  }

  @override
  String get oracle_tarot_loading => 'IA analizando...';

  @override
  String get oracle_tarot_ask_again => 'Preguntar de nuevo';

  @override
  String get oracle_tarot_card_reversed_short => ' (inv.)';

  @override
  String get oracle_tarot_combo_message => 'Mensaje general de las cartas:';

  @override
  String get oracle_geomagnetic_title => 'Clima Espacial';

  @override
  String get oracle_geomagnetic_forecast => 'Pronóstico próximo';

  @override
  String get oracle_weather_title => 'Actividad Geomagnética';

  @override
  String get oracle_pro_feature_title => 'Pareja del Día (PRO)';

  @override
  String get oracle_pro_feature_desc =>
      'Encontramos la pareja perfecta. Disponible en PRO.';

  @override
  String get oracle_partner_loading => 'Buscando pareja...';

  @override
  String get oracle_partner_error => 'Error de búsqueda';

  @override
  String get oracle_partner_not_found => 'No se encontraron parejas';

  @override
  String get oracle_partner_profile_error => 'Error de perfil';

  @override
  String get oracle_partner_title => 'Tu Pareja del Día';

  @override
  String oracle_partner_compatibility(String score) {
    return 'Compatibilidad: $score%';
  }

  @override
  String get oracle_ask_title => 'Preguntar al Oráculo';

  @override
  String get oracle_ask_hint => '¿Qué te preocupa?..';

  @override
  String get oracle_ask_button => 'Obtener Respuesta';

  @override
  String get oracle_tips_loading => 'Cargando consejos...';

  @override
  String get oracle_tips_title => 'Consejos Estelares';

  @override
  String oracle_tips_subtitle(String count) {
    return 'Para comunicación ($count)';
  }

  @override
  String get oracle_tips_general_advice => 'Sé abierto y sincero.';

  @override
  String get cardOfTheDayProInApp =>
      '✨ El aspecto personal está disponible en la aplicación móvil.';

  @override
  String get numerology_report_title => 'Informe de Numerología';

  @override
  String get numerology_report_overall => 'Puntuación General';

  @override
  String get numerology_report_you => 'Tú';

  @override
  String get numerology_report_partner => 'Pareja';

  @override
  String get userProfile_numerology_button => 'Numerología';

  @override
  String get forecast_astrological_title => 'Pronóstico Astrológico';

  @override
  String get forecast_loading => 'Cargando pronóstico...';

  @override
  String get forecast_error => 'Error de carga';

  @override
  String get forecast_no_aspects => 'Sin aspectos significativos';

  @override
  String get cosmicEvents_title => 'Eventos Cósmicos';

  @override
  String get cosmicEvents_loading_error => 'No se pudieron cargar los eventos';

  @override
  String get cosmicEvents_no_events => 'No hay eventos próximos';

  @override
  String get cosmicEvents_paywall_title => 'Eventos Cósmicos Personales';

  @override
  String get cosmicEvents_paywall_description =>
      'Obtén acceso a consejos únicos basados en la influencia de los planetas en tu carta natal.';

  @override
  String get cosmicEvents_paywall_button => 'Obtener Estatus PRO';

  @override
  String get cosmicEvents_personal_focus => 'Tu Enfoque Personal:';

  @override
  String get cosmicEvents_pro_placeholder =>
      'Descubre la influencia personal de este evento con el estado PRO';

  @override
  String get search_no_one_found =>
      'No se encontró a nadie\nen esta parte de la galaxia.';

  @override
  String get chat_error_user_not_found => 'Error: usuario no encontrado';

  @override
  String get chat_start_with_hint => 'Empezar con una sugerencia';

  @override
  String get chat_date_format => 'd \'de\' MMMM \'de\' y';

  @override
  String get chat_group_member => 'miembro';

  @override
  String get chat_group_members_2_4 => 'miembros';

  @override
  String get chat_group_members_5_0 => 'miembros';

  @override
  String get chat_online_status_long_ago => 'última vez hace mucho tiempo';

  @override
  String get chat_online_status_online => 'en línea';

  @override
  String chat_online_status_minutes_ago(String minutes) {
    return 'última vez hace $minutes min';
  }

  @override
  String chat_online_status_today_at(String time) {
    return 'última vez hoy a las $time';
  }

  @override
  String chat_online_status_yesterday_at(String time) {
    return 'última vez ayer a las $time';
  }

  @override
  String chat_online_status_date(String date) {
    return 'última vez el $date';
  }

  @override
  String get chat_delete_dialog_title => '¿Eliminar chat?';

  @override
  String get chat_delete_dialog_content =>
      'Este chat se eliminará para ti y para tu interlocutor. Esta acción es irreversible.';

  @override
  String get chat_delete_dialog_confirm => 'Eliminar';

  @override
  String chat_report_dialog_title(String name) {
    return 'Reportar a $name';
  }

  @override
  String get chat_report_details_hint => 'Detalles adicionales (opcional)';

  @override
  String get chat_report_sent_snackbar =>
      '¡Gracias! Tu reporte ha sido enviado.';

  @override
  String get chat_menu_report => 'Reportar';

  @override
  String get chat_menu_delete => 'Eliminar chat';

  @override
  String get chat_group_title_default => 'Chat de grupo';

  @override
  String get chat_group_participants => 'Participantes';

  @override
  String get chat_message_old => 'Mensaje de una versión anterior';

  @override
  String get chat_input_hint => 'Mensaje...';

  @override
  String get chat_temp_warning_remaining =>
      'Este chat temporal se eliminará en ';

  @override
  String get chat_temp_warning_expired => 'el chat ha expirado';

  @override
  String get chat_temp_warning_less_than_24h => 'menos de 24 horas';

  @override
  String get encrypted_chat_banner_title => 'Conversación protegida';

  @override
  String get encrypted_chat_banner_desc =>
      'Los mensajes en este chat están protegidos con cifrado de extremo a extremo. Nadie, ni siquiera la administración de Aryonika, puede leerlos.';

  @override
  String get search_hint => 'Buscar por nombre, biografía...';

  @override
  String get search_tooltip_swipes => 'Swipes';

  @override
  String get search_tooltip_cosmic_web => 'Red Cósmica';

  @override
  String get search_tooltip_star_map => 'Mapa Estelar';

  @override
  String get search_tooltip_filters => 'Filtros';

  @override
  String get search_star_map_placeholder =>
      'El Mapa Estelar está en desarrollo...';

  @override
  String get search_priority_header => 'Mejores coincidencias';

  @override
  String get search_other_header => 'Otros usuarios';

  @override
  String get payment_title => 'Apoyar el proyecto';

  @override
  String get payment_success_snackbar =>
      '¡Gracias por tu apoyo! Actualizando tu estado...';

  @override
  String get payment_fail_snackbar =>
      'No se pudo procesar la donación. Inténtalo de nuevo.';

  @override
  String get paywall_header_title => 'Descubre el Universo Aryonika';

  @override
  String get paywall_header_subtitle =>
      'Apoya el proyecto y recibe como agradecimiento todas las herramientas cósmicas para encontrar a tu pareja ideal.';

  @override
  String get paywall_benefit1_title => 'Mira a quién le gustas';

  @override
  String get paywall_benefit1_subtitle =>
      'No pierdas la oportunidad de ser correspondido y empieza tú la conversación.';

  @override
  String get paywall_benefit2_title => 'Pronóstico personal diario';

  @override
  String get paywall_benefit2_subtitle =>
      'Análisis diario de tus tránsitos y el Foco del Día.';

  @override
  String get paywall_benefit3_title => 'Pareja del Día y Ruleta';

  @override
  String get paywall_benefit3_subtitle =>
      'Deja que las estrellas elijan por ti la pareja más compatible.';

  @override
  String get paywall_benefit4_title => 'La respuesta del Universo';

  @override
  String get paywall_benefit4_subtitle =>
      'Haz tu pregunta y recibe un consejo cósmico.';

  @override
  String get paywall_benefit5_title => 'Clima cósmico';

  @override
  String get paywall_benefit5_subtitle =>
      'Mantente al tanto de las tormentas geomagnéticas y su influencia.';

  @override
  String get paywall_benefit6_title => 'Carta del Día';

  @override
  String get paywall_benefit6_subtitle =>
      'Recibe una predicción y un consejo diario de la Carta del Destino.';

  @override
  String get paywall_donate_button => 'Apoyar el proyecto';

  @override
  String get paywall_referral_button => 'Obtén PRO por amigos';

  @override
  String get paywall_referral_subtitle =>
      'Invita a un amigo y obtén 1 día de estado PRO por cada uno que se registre con tu enlace.';

  @override
  String paywall_get_pro_button(String price) {
    return 'Obtener Aryonika PRO ($price)';
  }

  @override
  String get paywall_arbitrary_donate_button => 'Apoyar con otra cantidad';

  @override
  String get paywall_arbitrary_donate_subtitle =>
      'Si te gusta nuestro proyecto, puedes apoyarlo para ayudarnos a sobrevivir en un mundo de tiburones y otros depredadores.';

  @override
  String get chinese_zodiac_title => 'Zodíaco Chino';

  @override
  String get zodiac_Rat => 'Rata';

  @override
  String get zodiac_Ox => 'Buey';

  @override
  String get zodiac_Tiger => 'Tigre';

  @override
  String get zodiac_Rabbit => 'Conejo';

  @override
  String get zodiac_Dragon => 'Dragón';

  @override
  String get zodiac_Snake => 'Serpiente';

  @override
  String get zodiac_Horse => 'Caballo';

  @override
  String get zodiac_Goat => 'Cabra';

  @override
  String get zodiac_Monkey => 'Mono';

  @override
  String get zodiac_Rooster => 'Gallo';

  @override
  String get zodiac_Dog => 'Perro';

  @override
  String get zodiac_Pig => 'Cerdo';

  @override
  String get chinese_zodiac_compatibility_button =>
      'Compatibilidad del Zodíaco';

  @override
  String get compatibility_section_title => 'Compatibilidad';

  @override
  String get userProfile_astro_button => 'Astrología';

  @override
  String get userProfile_bazi_button => 'Bazi';

  @override
  String get jyotishCompatibilityTitle => 'Compatibilidad Védica';

  @override
  String get jyotishDetailedAnalysisTitle => 'Análisis Detallado (Ashta-Kuta)';

  @override
  String get kuta_tara_name => 'Tara Kuta (Destino)';

  @override
  String get kuta_tara_desc =>
      'Indica la suerte, duración y bienestar en la relación. Una buena compatibilidad aquí es como viento a favor para su unión.';

  @override
  String get kuta_yoni_name => 'Yoni Kuta (Atracción)';

  @override
  String get kuta_yoni_desc =>
      'Determina la armonía física y sexual. Una puntuación alta indica una fuerte atracción mutua y satisfacción.';

  @override
  String get kuta_graha_maitri_name => 'Graha Maitri (Amistad)';

  @override
  String get kuta_graha_maitri_desc =>
      'Compatibilidad psicológica y amistad. Refleja cuán similares son sus visiones de la vida y cuán fácil les resulta encontrar puntos en común.';

  @override
  String get kuta_vashya_name => 'Vashya Kuta (Control Mutuo)';

  @override
  String get kuta_vashya_desc =>
      'Muestra el grado de influencia mutua y magnetismo en la pareja. Quién será el líder y quién el seguidor.';

  @override
  String get kuta_gana_name => 'Gana Kuta (Temperamento)';

  @override
  String get kuta_gana_desc =>
      'Compatibilidad a nivel de temperamento (Divino, Humano, Demoníaco). Ayuda a evitar conflictos de carácter.';

  @override
  String get kuta_bhakoot_name => 'Bhakoot Kuta (Amor y Familia)';

  @override
  String get kuta_bhakoot_desc =>
      'Uno de los indicadores más importantes. Responsable de la profundidad del amor, la felicidad familiar, la prosperidad financiera y la posibilidad de tener hijos.';

  @override
  String get kuta_nadi_name => 'Nadi Kuta (Salud)';

  @override
  String get kuta_nadi_desc =>
      'El criterio más importante. Responsable de la salud, compatibilidad genética y longevidad de los socios y su descendencia.';

  @override
  String get kuta_varna_name => 'Varna Kuta (Espiritualidad)';

  @override
  String get kuta_varna_desc =>
      'Refleja la compatibilidad del ego y el desarrollo espiritual de los socios. Muestra quién en la pareja estimulará más el crecimiento del otro.';

  @override
  String get jyotishVerdictExcellent =>
      '¡Unión Celestial! Sus signos lunares están en perfecta armonía. Esta conexión promete una profunda comprensión, crecimiento espiritual y felicidad por muchos años.';

  @override
  String get jyotishVerdictGood =>
      'Muy buena compatibilidad. Tienen todas las posibilidades de construir una relación fuerte, armoniosa y feliz. Los pequeños desacuerdos son fáciles de superar.';

  @override
  String get jyotishVerdictAverage =>
      'Compatibilidad normal. Su relación tiene tanto fortalezas como áreas de crecimiento. El éxito de la unión dependerá de su disposición a trabajar en la relación.';

  @override
  String get jyotishVerdictChallenging =>
      'Compatibilidad desafiante. Sus cartas indican serias diferencias en caracteres y caminos de vida. Se requerirá mucha paciencia y compromiso para lograr la armonía.';

  @override
  String get passwordResetNewPasswordTitle => 'Establecer nueva contraseña';

  @override
  String get passwordResetNewPasswordLabel => 'Nueva Contraseña';

  @override
  String get passwordResetConfirmLabel => 'Confirmar Contraseña';

  @override
  String get passwordValidationError =>
      'La contraseña debe tener al menos 6 caracteres';

  @override
  String get passwordMismatchError => 'Las contraseñas no coinciden';

  @override
  String get saveButton => 'Guardar';

  @override
  String get postActionLike => 'Me gusta';

  @override
  String get postActionComment => 'Comentar';

  @override
  String get postActionShare => 'Compartir';

  @override
  String get channelDefaultName => 'Canal';

  @override
  String postShareText(Object channelName, Object postText) {
    return 'Echa un vistazo a esta publicación en el canal «$channelName»: $postText';
  }

  @override
  String get postDeleteDialogTitle => '¿Eliminar publicación?';

  @override
  String get postDeleteDialogContent => 'Esta acción no se puede deshacer.';

  @override
  String get delete => 'Eliminar';

  @override
  String get postMenuDelete => 'Eliminar publicación';

  @override
  String get numerologySectionKeyNumbers => 'Números Clave';

  @override
  String get numerologySectionCurrentVibes => 'Vibraciones Actuales';

  @override
  String get numerologyTitleLifePath => 'Número del Camino de Vida';

  @override
  String get numerologyTitleDestiny => 'Número del Destino (de Expresión)';

  @override
  String get numerologyTitleSoulUrge => 'Número del Impulso del Alma';

  @override
  String get numerologyTitlePersonality => 'Número de la Personalidad';

  @override
  String get numerologyTitleMaturity => 'Número de Madurez';

  @override
  String get numerologyTitleBirthday => 'Número de Cumpleaños';

  @override
  String get numerologyTitlePersonalYear => 'Año Personal';

  @override
  String get numerologyTitlePersonalMonth => 'Mes Personal';

  @override
  String get numerologyTitlePersonalDay => 'Día Personal';

  @override
  String get numerologyErrorNotEnoughData =>
      'No hay suficientes datos para el cálculo.';

  @override
  String get numerologyErrorDescriptionsNotLoaded =>
      'Error al cargar las descripciones de numerología.';

  @override
  String get chat_error_recipient_not_found => 'Destinatario no encontrado.';

  @override
  String get chat_error_recipient_profile_load_failed =>
      'Error al cargar el perfil del destinatario.';

  @override
  String get calculatingNumerology => 'Calculando retrato numerológico...';

  @override
  String get oracle_title => 'Oráculo';

  @override
  String get verifyEmailBody =>
      'Hemos enviado un código de 6 dígitos a tu correo. Por favor, ingrésalo a continuación.';

  @override
  String get verifyEmailHint => '------';

  @override
  String get signOutButton => 'Cerrar sesión';

  @override
  String get errorInvalidOrExpiredCode => 'Código inválido o caducado.';

  @override
  String get errorCodeRequired =>
      'Por favor, ingresa el código de verificación.';

  @override
  String get errorInternalServer =>
      'Ocurrió un error interno del servidor. Por favor, inténtalo de nuevo más tarde.';

  @override
  String get errorCodeLength => 'El código debe tener 6 dígitos.';

  @override
  String get verifyEmailTitle => 'Verificación de Correo';

  @override
  String get verificationCodeLabel => 'Código de Verificación';

  @override
  String get verificationCodeResent =>
      '¡Se ha enviado un nuevo código de verificación!';

  @override
  String get resendCodeAction => 'Reenviar código';

  @override
  String resendCodeCooldown(int seconds) {
    return 'Reenviar código en ($seconds)s';
  }

  @override
  String verifyEmailInstruction(String email) {
    return 'Hemos enviado un código de 6 dígitos a tu correo:\n$email\nPor favor, ingrésalo a continuación.';
  }

  @override
  String get confirmButton => 'Confirmar';

  @override
  String get logout => 'Cerrar Sesión';

  @override
  String get numerology_score_high => 'Alta';

  @override
  String get numerology_score_medium => 'Media';

  @override
  String get numerology_score_low => 'Baja';

  @override
  String get noUsersFound => 'No se encontraron usuarios';

  @override
  String get feature_in_development => '¡Disponible pronto!';

  @override
  String get download_our_app => 'Descarga nuestra app';

  @override
  String get open_web_version => 'Abrir versión WEB';

  @override
  String get pay_with_card => 'Pagar con tarjeta';

  @override
  String get coming_soon => 'Pronto';

  @override
  String get paywall_subscription_terms =>
      'La suscripción se renueva automáticamente. Cancela cuando quieras.';

  @override
  String get searchHint => 'Поиск...';

  @override
  String get nav_friends => 'Amigos';

  @override
  String get oracle_typing => 'escribiendo...';

  @override
  String get tarot_reversed => '(Invertida)';

  @override
  String get common_close => 'Cerrar';

  @override
  String oracle_limit_pro(Object hours) {
    return 'Quedan $hours horas.';
  }

  @override
  String oracle_limit_free(Object days) {
    return 'Límite gratuito alcanzado. Quedan $days días.';
  }

  @override
  String get oracle_error_stream => 'Error de conexión';

  @override
  String get oracle_error_start => 'Fallo al iniciar';

  @override
  String get error_generic =>
      'Ocurrió un error. Por favor inténtalo más tarde.';

  @override
  String get referral_already_used => 'Ya has usado un código de referencia.';

  @override
  String get referral_own_code => 'No puedes usar tu propio código.';

  @override
  String get referral_success =>
      '¡Código activado! Recibiste 3 días de Premium.';

  @override
  String get tab_astrology => 'Astrología';

  @override
  String get tab_numerology => 'Numerología';

  @override
  String get tab_bazi => 'BaZi';

  @override
  String get tab_jyotish => 'Védica';

  @override
  String get share_result => 'Compartir resultado';

  @override
  String get share_preparing => 'Preparando...';

  @override
  String locked_feature_title(Object title) {
    return 'Sección $title bloqueada';
  }

  @override
  String get locked_feature_desc =>
      'Esta sección solo está disponible en la versión Premium.';

  @override
  String get get_access_button => 'Obtener acceso';

  @override
  String get coming_soon_suffix => 'próximamente';

  @override
  String get tab_summary => 'Сводка';

  @override
  String get tab_chinese_zodiac => 'Кит. Зодиак';

  @override
  String get summary_verdict_title => 'Общий вердикт';

  @override
  String get webVersionButton => 'Versión Web';

  @override
  String get uploadPhotoDisclaimer =>
      'Al subir una foto, confirmas que no contiene desnudez ni violencia. Los infractores serán bloqueados permanentemente.';

  @override
  String get iAgree => 'Estoy de acuerdo';

  @override
  String get testers_banner_title => 'SE BUSCAN PROBADORES (4/20)';

  @override
  String get testers_banner_desc =>
      'Ayúdanos a mejorar Aryonika y obtén\n✨ PREMIUM DE POR VIDA ✨';

  @override
  String get testers_email_hint => '(Toque para abrir, Mantenga para copiar)';

  @override
  String get numerology_day_1 =>
      'Día de nuevos comienzos. Perfecto para iniciar proyectos.';

  @override
  String get numerology_day_2 => 'Día de la asociación. Busca compromisos.';

  @override
  String get numerology_day_3 => 'Día de la creatividad. Exprésate.';

  @override
  String get numerology_day_4 => 'Día del trabajo. Organiza tus asuntos.';

  @override
  String get numerology_day_5 => 'Día del cambio. Ábrete a lo nuevo.';

  @override
  String get numerology_day_6 => 'Día de la armonía. Tiempo para la familia.';

  @override
  String get numerology_day_7 => 'Día de reflexión. Tiempo para la soledad.';

  @override
  String get numerology_day_8 => 'Día de poder. Enfoque en carrera y finanzas.';

  @override
  String get numerology_day_9 => 'Día de finalización. Deja ir lo viejo.';

  @override
  String get astro_transit_positive_general =>
      'Звезды на вашей стороне. Действуйте смело.';

  @override
  String get advice_general_balance =>
      'Сохраняйте баланс между чувствами и разумом.';

  @override
  String get astro_advice_listen_intuition => 'Escucha tu voz interior.';

  @override
  String get astro_advice_act_boldly => 'La energía favorece la acción audaz.';

  @override
  String get astro_advice_rest_and_reflect =>
      'Las estrellas aconsejan descansar.';

  @override
  String get astro_advice_connect_with_nature =>
      'Pasa tiempo en la naturaleza.';

  @override
  String get advice_generic_positive => 'El Universo está de tu lado hoy.';

  @override
  String get channelLoadError => 'Error al cargar el canal';

  @override
  String get postsTitle => 'Publicaciones';

  @override
  String get noPostsYet => 'Aún no hay publicaciones en este canal.';

  @override
  String get createPostTooltip => 'Crear publicación';

  @override
  String get proposePost => 'Proponer noticia';

  @override
  String get channelsTitle => 'Canales';

  @override
  String get noChannelSubscriptions => 'Aún no hay suscripciones';

  @override
  String get noMessagesYet => 'Aún no hay mensajes';

  @override
  String get yesterday => 'Ayer';

  @override
  String get search => 'Buscar';

  @override
  String get adminOnlyFeature =>
      'La creación de canales está temporalmente disponible solo para administradores.';

  @override
  String get createChannel => 'Crear canal';

  @override
  String get galacticBroadcasts => 'Transmisiones Galácticas';

  @override
  String get noChannelsYet =>
      'Aún no te has suscrito a nada.\n¡Encuentra o crea tu propio canal!';

  @override
  String get constellationsTitle => 'Constelaciones';

  @override
  String get privateChatsTab => 'Privado';

  @override
  String get channelsTab => 'Canales';

  @override
  String get loadingUser => 'Cargando usuario...';

  @override
  String get emptyChatsPlaceholder =>
      'Tus chats privados aparecerán aquí.\n¡Encuentra a alguien interesante a través de la búsqueda!';

  @override
  String get errorTitle => 'Error';

  @override
  String get autoDeleteMessages => 'Auto-eliminar mensajes';

  @override
  String get availableInPro => 'Disponible en PRO';

  @override
  String get timerOff => 'Apagado';

  @override
  String get timer15min => '15 minutos';

  @override
  String get timer1hour => '1 hora';

  @override
  String get timer4hours => '4 horas';

  @override
  String get timer24hours => '24 horas';

  @override
  String get timerSet => 'Temporizador configurado';

  @override
  String get disappearingMessages => 'Mensajes que desaparecen';

  @override
  String get communicationTitle => 'Comunicación';

  @override
  String get errorLoadingReport => 'Error al cargar el informe';

  @override
  String get compatibility => 'Compatibilidad';

  @override
  String get strengths => 'Fortalezas';

  @override
  String get weaknesses => 'Dificultades potenciales';

  @override
  String get commentsTitle => 'Comentarios';

  @override
  String get commentsLoadError => 'Error al cargar los comentarios.';

  @override
  String get noCommentsYet => 'Aún no hay comentarios.';

  @override
  String userIsTyping(Object name) {
    return '$name está escribiendo...';
  }

  @override
  String twoUsersTyping(Object name1, Object name2) {
    return '$name1 y $name2 están escribiendo...';
  }

  @override
  String manyUsersTyping(Object count, Object name1, Object name2) {
    return '$name1, $name2 y $count otros están escribiendo...';
  }

  @override
  String replyingTo(Object name) {
    return 'Respondiendo a $name';
  }

  @override
  String get writeCommentHint => 'Escribir un comentario...';

  @override
  String get compatibilityTitle => 'Conexión Cósmica';

  @override
  String get noData => 'Sin datos';

  @override
  String get westernAstrology => 'Astrología Occidental';

  @override
  String get vedicAstrology => 'Astrología Védica (Jyotish)';

  @override
  String get numerology => 'Numerología';

  @override
  String get chineseZodiac => 'Zodíaco Chino';

  @override
  String get baziElements => 'Ba Zi (Elementos)';

  @override
  String get availableInPremium => 'Disponible en Premium';

  @override
  String get verdictSoulmates => 'Almas Gemelas';

  @override
  String get verdictGreatMatch => 'Gran Pareja';

  @override
  String get verdictPotential => 'Tiene Potencial';

  @override
  String get verdictKarmic => 'Lección Kármica';

  @override
  String get createChannelTitle => 'Crear transmisión';

  @override
  String get channelNameLabel => 'Nombre de la transmisión';

  @override
  String get channelNameHint => 'P. ej., \'Pronósticos Diarios de Tarot\'';

  @override
  String get errorChannelNameEmpty => 'El nombre no puede estar vacío';

  @override
  String get channelHandleLabel => 'ID Único (@handle)';

  @override
  String get errorChannelHandleShort => 'El ID debe tener más de 4 caracteres';

  @override
  String get channelDescriptionLabel => 'Descripción';

  @override
  String get channelDescriptionHint => 'Cuéntanos de qué trata tu canal...';

  @override
  String get errorChannelDescriptionEmpty => 'Por favor, añade una descripción';

  @override
  String get createButton => 'Crear';

  @override
  String get editProfileTitle => 'Editar perfil';

  @override
  String get profileNotFoundError => 'Error: Perfil no encontrado';

  @override
  String get profileSavedSuccess => '¡Perfil guardado exitosamente!';

  @override
  String get saveError => 'Error al guardar';

  @override
  String get avatarUploadError => 'Error al subir la foto';

  @override
  String get nameLabel => 'Nombre';

  @override
  String get bioLabel => 'Sobre mí';

  @override
  String get birthDataTitle => 'Datos de nacimiento';

  @override
  String get birthDataWarning =>
      'Cambiar estos datos llevará a un recálculo completo de tu retrato astrológico y numerológico.';

  @override
  String get birthDateLabel => 'Fecha de nacimiento';

  @override
  String get birthPlaceLabel => 'Lugar de nacimiento';

  @override
  String get errorUserNotFound => 'Error: Usuario no encontrado';

  @override
  String get feedUpdateError => 'Error al actualizar el feed';

  @override
  String get feedEmptyMessage =>
      'Tu feed está vacío.\nDesliza hacia abajo para actualizar.';

  @override
  String get whereToSearch => 'Dónde buscar';

  @override
  String get searchNearby => 'Cerca';

  @override
  String get searchCity => 'Ciudad';

  @override
  String get searchCountry => 'País';

  @override
  String get searchWorld => 'Mundo';

  @override
  String get ageLabel => 'Edad';

  @override
  String get showGenderLabel => 'Mostrar';

  @override
  String get genderAll => 'Todos';

  @override
  String get zodiacFilterLabel => 'Elementos del Zodíaco';

  @override
  String get resetFilters => 'Restablecer';

  @override
  String get applyFilters => 'Aplicar';

  @override
  String get forecastLoadError =>
      'Error al cargar el pronóstico.\nInténtalo de nuevo más tarde.';

  @override
  String get noForecastEvents =>
      'No hay eventos astrológicos significativos hoy.\n¡Un día tranquilo!';

  @override
  String get unlockFullForecast => 'Desbloquear pronóstico completo';

  @override
  String get myFriendsTab => 'Mis Amigos';

  @override
  String get friendRequestsTab => 'Solicitudes';

  @override
  String get noFriendsYet =>
      'Aún no tienes amigos. ¡Encuéntralos en la búsqueda!';

  @override
  String get noFriendRequests => 'No hay nuevas solicitudes.';

  @override
  String get removeFriend => 'Eliminar de amigos';

  @override
  String get gamesComingSoonTitle => '¡Juegos y Recompensas próximamente!';

  @override
  String get gamesComingSoonDesc =>
      'Estamos preparando emocionantes minijuegos y cuestionarios. ¡Comprueba tu compatibilidad, gana \"Polvo de Estrellas\" y cámbialo por días premium o regalos únicos!';

  @override
  String get joinTelegramButton => 'Entérate primero en nuestro Telegram';

  @override
  String horoscopeForSign(Object sign) {
    return 'Horóscopo para $sign';
  }

  @override
  String get horoscopeGeneral => 'General';

  @override
  String get horoscopeLove => 'Amor';

  @override
  String get horoscopeBusiness => 'Negocios';

  @override
  String get verdictNotFound => 'Veredicto no encontrado';

  @override
  String get vedicCompatibilityTitle => 'Compatibilidad Védica';

  @override
  String get ashtaKutaAnalysis => 'Análisis Detallado (Ashta-Kuta)';

  @override
  String get noDescription => 'Descripción no encontrada.';

  @override
  String get likesYouEmpty => 'Las personas interesadas en ti aparecerán aquí';

  @override
  String peopleLikeYou(Object count) {
    return '¡Le gustas a $count personas!';
  }

  @override
  String get getProToSeeLikes => 'Obtén PRO para ver sus perfiles y chatear.';

  @override
  String get seeLikesButton => 'Ver Likes';

  @override
  String get someone => 'Alguien';

  @override
  String get selectCityTitle => 'Seleccionar ciudad';

  @override
  String get searchCityHint => 'Ingrese el nombre de la ciudad...';

  @override
  String get nothingFound => 'Nada encontrado';

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
  String get moderationProposedPosts => 'Publicaciones propuestas';

  @override
  String get noProposedPosts => 'No hay publicaciones propuestas.';

  @override
  String get from => 'De';

  @override
  String get personalNumerologyTitle => 'Numerología Personal';

  @override
  String get dataNotLoaded => 'Datos no cargados';

  @override
  String get loading => 'Cargando...';

  @override
  String get lifePathNumber => 'Número de Camino de Vida';

  @override
  String get corePersonality => 'Núcleo de Personalidad';

  @override
  String get destinyNumber => 'Número de Destino';

  @override
  String get soulNumber => 'Número del Alma';

  @override
  String get personalityNumber => 'Número de Personalidad';

  @override
  String get timeInfluence => 'Influencia del Tiempo';

  @override
  String get maturityNumber => 'Número de Madurez';

  @override
  String get birthdayNumber => 'Número de Cumpleaños';

  @override
  String get currentVibrationsPro => 'Vibraciones Actuales (PRO)';

  @override
  String get personalYear => 'Año Personal';

  @override
  String get personalMonth => 'Mes Personal';

  @override
  String get personalDay => 'Día Personal';

  @override
  String get proVibrationsDesc =>
      'Descubre tus vibraciones para el Año, Mes y Día. Disponible solo en Premium.';

  @override
  String get unlockButton => 'Desbloquear';

  @override
  String get tapForDetails => 'Toca para detalles';

  @override
  String oracle_weather_desc(Object desc, Object kp) {
    return '$desc (Kp: $kp)';
  }

  @override
  String oracle_geomagnetic_now(Object desc) {
    return 'Ahora: $desc';
  }

  @override
  String oracle_geomagnetic_index(Object kp) {
    return 'Índice Kp: $kp';
  }

  @override
  String get oracle_question_title => 'Pregunta al Oráculo';

  @override
  String get oracle_question_hint => '¿Qué te preocupa?...';

  @override
  String get oracle_question_button => 'Obtener Respuesta';

  @override
  String get palmistry_analysis_title => 'Análisis de Palma';

  @override
  String get palmistry_choose_option => 'Elige la opción más adecuada:';

  @override
  String get palmistry_analysis_saved => '¡Análisis guardado!';

  @override
  String get palmistry_view_report => 'Ver informe completo';

  @override
  String get palmistry_complete_all =>
      'Completa el análisis de todas las líneas';

  @override
  String get palmistry_analysis_complete => '¡Genial! Análisis completo.';

  @override
  String palmistry_tap_line(Object lineName) {
    return 'Toca en \'$lineName\' para comparar con tu palma.';
  }

  @override
  String palmistry_searching_line(Object lineName) {
    return 'Buscando \'$lineName\'...';
  }

  @override
  String get palmistry_preparing => 'Preparando el análisis...';

  @override
  String get palmistry_report_title => 'Mapa de Tu Destino';

  @override
  String get palmistry_data_not_found => 'Datos de análisis no encontrados.';

  @override
  String get palmistry_strong_traits => 'Tus Fortalezas';

  @override
  String get privacy => 'Privacidad';

  @override
  String get palmistry_show_in_profile => 'Mostrar mis rasgos en el perfil';

  @override
  String get palmistry_show_in_profile_desc =>
      'Esto permitirá a otros conocerte mejor y mejorará la compatibilidad.';

  @override
  String get palmistry_interpretation => 'Interpretación de Líneas';

  @override
  String palmistry_your_choice(Object choice) {
    return 'Tu elección: \"$choice\"';
  }

  @override
  String get photoAlbumComingSoon => 'Pronto podrás subir tus fotos aquí.';

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get accountManagement => 'Gestión de cuenta';

  @override
  String get changePassword => 'Cambiar contraseña';

  @override
  String get restorePassword => 'Restablecer contraseña';

  @override
  String get editProfileButton => 'Editar perfil';

  @override
  String get dailyNotifications => 'Notificaciones diarias';

  @override
  String get alertsTitle => 'Alertas';

  @override
  String get geomagneticStorms => 'Tormentas geomagnéticas';

  @override
  String get adminPanelTitle => 'Panel de administración';

  @override
  String get adminManageUsers => 'Gestionar usuarios';

  @override
  String get offerAgreementLink => 'Acuerdo de oferta';

  @override
  String get accountSectionTitle => 'Cuenta';

  @override
  String get deleteAccountButton => 'Eliminar cuenta';

  @override
  String get closeAppButton => 'Cerrar aplicación';

  @override
  String get changePasswordDesc =>
      'Por favor, ingrese su contraseña actual por seguridad.';

  @override
  String get currentPasswordLabel => 'Contraseña actual';

  @override
  String get newPasswordLabel => 'Nueva contraseña';

  @override
  String get passwordChangedSuccess => '¡Contraseña cambiada con éxito!';

  @override
  String resetPasswordInstruction(String email) {
    return 'Enviaremos instrucciones de restablecimiento a su E-mail:\n\n$email';
  }

  @override
  String get signOutDialogTitle => 'Cerrar sesión';

  @override
  String get signOutDialogContent =>
      '¿Estás seguro de que quieres cerrar sesión?';

  @override
  String get deleteAccountTitle => '¿Eliminar cuenta?';

  @override
  String get deleteAccountWarning =>
      'Esta acción es irreversible. Todos tus datos, chats, fotos y compras se eliminarán permanentemente.';

  @override
  String get deleteForeverButton => 'Eliminar para siempre';

  @override
  String get roulette_trust_fate => 'Vertraue dem Schicksal';

  @override
  String get roulette_desc_short =>
      'Die Sterne wählen den kompatibelsten Partner für dich (ab 85%!).';

  @override
  String get roulette_no_candidates => 'Keine Kandidaten zum Drehen.';

  @override
  String get roulette_winner_title => 'Die Sterne haben ihre Wahl getroffen!';

  @override
  String get roulette_spin_again => 'Nochmal drehen';

  @override
  String get roulette_go_to_profile => 'Zum Profil gehen';

  @override
  String get cityNotSpecified => 'Ciudad no especificada';

  @override
  String get geomagnetic_calm => 'Tranquilo';

  @override
  String get geomagnetic_unsettled => 'Inestable';

  @override
  String get geomagnetic_active => 'Activo';

  @override
  String get geomagnetic_storm_minor => 'Tormenta Menor (G1)';

  @override
  String get geomagnetic_storm_moderate => 'Tormenta Moderada (G2)';

  @override
  String get geomagnetic_storm_strong => 'Tormenta Fuerte (G3)';

  @override
  String get geomagnetic_storm_severe => 'Tormenta Severa (G4)';

  @override
  String get geomagnetic_storm_extreme => 'Tormenta Extrema (G5)';

  @override
  String get deleteChatTitle => '¿Eliminar chat?';

  @override
  String get deleteChatConfirmation =>
      'Todos los mensajes se eliminarán permanentemente.';

  @override
  String get chatDeleted => 'Chat eliminado';
}
