# tool/populate_aspects.py

import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

# --- 1. ИНИЦИАЛИЗАЦИЯ FIREBASE ---

# Указываем путь к нашему ключу сервисного аккаунта
cred = credentials.Certificate('tool/serviceAccountKey.json') 

# Инициализируем приложение с правами администратора
firebase_admin.initialize_app(cred)

# Получаем доступ к Firestore
db = firestore.client()

logger.d('✅ Firebase инициализирован. Начинаю загрузку интерпретаций...')

# --- 2. ДАННЫЕ ДЛЯ ЗАГРУЗКИ ---
# Данные теперь в формате словаря Python

  // --- СПИСОК ИНТЕРПРЕТАЦИЙ ДЛЯ ЗАГРУЗКИ ---
  // Добавляй сюда новые аспекты по мере необходимости
  final interpretations = [
    // --- НАПРЯЖЕННЫЕ АСПЕКТЫ ---
    AspectInterpretation(
      id: 'MARS_SQUARE_SATURN',
      title: {
        'ru': 'Конфликт Марса и Сатурна',
        'en': 'Mars Square Saturn',
        'fr': 'Mars Carré Saturne',
        'de': 'Mars-Quadrat-Saturn'
      },
      descriptionGeneral: {
        'ru': 'Период фрустрации и препятствий. Ваша энергия (Марс) сталкивается с ограничениями (Сатурн). Не время для новых начинаний. Проявите терпение.',
        'en': 'A period of frustration and obstacles. Your energy (Mars) clashes with limitations (Saturn). Not a time for new beginnings. Be patient.',
        'fr': 'Une période de frustration et d\'obstacles. Votre énergie (Mars) se heurte à des limitations (Saturne). Ce n\'est pas le moment pour de nouveaux départs. Soyez patient.',
        'de': 'Eine Zeit der Frustration und Hindernisse. Ihre Energie (Mars) kollidiert mit Einschränkungen (Saturn). Keine Zeit für Neuanfänge. Seien Sie geduldig.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Это напрямую затрагивает вашу личность. Возможны приступы неуверенности в себе, раздражительность и ощущение, что вы "бьетесь головой о стену".',
          '2': 'Будьте осторожны с финансами. Возможны непредвиденные траты или ощущение нехватки ресурсов. Упорный труд может не приносить ожидаемого результата.',
          '3': 'Трудности в общении, споры и недопонимания. Ваши слова могут восприниматься как агрессивные. Отложите важные переговоры.',
          '4': 'Напряжение и конфликты в доме или с семьей. Проблемы с недвижимостью или ремонтом, которые никак не решаются.',
          '5': 'Творческий или романтический кризис. Ощущение отсутствия радости и вдохновения. В отношениях возможна холодность и отчуждение.',
          '6': 'Проблемы на работе, конфликты с коллегами или начальством. Ощущение перегруженности и отсутствия энергии. Берегите здоровье.',
          '7.': 'Конфликты с партнерами. Проявите терпение и не давите на других, это может привести к разрыву или серьезной ссоре.',
          '8': 'Кризис в интимных отношениях или в вопросах общих финансов. Возможны споры из-за долгов, налогов или наследства.',
          '9': 'Планы на путешествия или обучение могут сорваться. Ваши убеждения могут столкнуться с жесткой реальностью. Избегайте споров о религии и политике.',
          '10': 'Препятствия в карьере. Конфликты с начальством или властными фигурами. Ваши амбиции сталкиваются с ограничениями.',
          '11': 'Конфликты с друзьями или в коллективе. Ощущение, что ваши надежды и мечты нереализуемы. Чувство одиночества.',
          '12': 'Внутренние страхи и старые комплексы выходят на поверхность. Ощущение бессилия. Важно не заниматься самобичеванием.'
        },
        'en': {
          '1': 'This directly affects your personality. Bouts of self-doubt, irritability, and a feeling of "hitting your head against a wall" are possible.',
          '2': 'Be careful with finances. Unexpected expenses or a sense of resource scarcity are possible. Hard work may not bring the expected results.',
          '3': 'Difficulties in communication, arguments, and misunderstandings. Your words may be perceived as aggressive. Postpone important negotiations.',
          '4': 'Tension and conflicts at home or with family. Problems with real estate or repairs that seem endless.',
          '5': 'A creative or romantic crisis. A feeling of joylessness and lack of inspiration. Coldness and alienation are possible in relationships.',
          '6': 'Problems at work, conflicts with colleagues or superiors. Feeling overwhelmed and lacking energy. Take care of your health.',
          '7': 'Conflicts with partners. Be patient and do not pressure others, as it could lead to a breakup or a serious argument.',
          '8': 'A crisis in intimate relationships or in matters of joint finances. Disputes over debts, taxes, or inheritance are possible.',
          '9': 'Travel or education plans may fall through. Your beliefs may clash with harsh reality. Avoid arguments about religion and politics.',
          '10': 'Obstacles in your career. Conflicts with superiors or authority figures. Your ambitions face limitations.',
          '11': 'Conflicts with friends or in a group. A feeling that your hopes and dreams are unattainable. A sense of loneliness.',
          '12': 'Inner fears and old complexes surface. A feeling of powerlessness. It is important not to engage in self-criticism.'
        },
        'fr': {
          '1': 'Cela affecte directement votre personnalité. Des accès de doute, d\'irritabilité et le sentiment de "se heurter à un mur" sont possibles.',
          '2': 'Soyez prudent avec les finances. Des dépenses imprévues ou un sentiment de manque de ressources sont possibles. Le travail acharné peut ne pas donner les résultats escomptés.',
          '3': 'Difficultés de communication, disputes et malentendus. Vos paroles peuvent être perçues comme agressives. Reportez les négociations importantes.',
          '4': 'Tensions et conflits à la maison ou en famille. Problèmes immobiliers ou de réparations qui semblent sans fin.',
          '5': 'Crise créative ou romantique. Un sentiment de manque de joie et d\'inspiration. Froideur et aliénation sont possibles dans les relations.',
          '6': 'Problèmes au travail, conflits avec des collègues ou des supérieurs. Sensation d\'être débordé et de manquer d\'énergie. Prenez soin de votre santé.',
          '7': 'Conflits avec les partenaires. Soyez patient et ne mettez pas la pression sur les autres, cela pourrait mener à une rupture ou une dispute sérieuse.',
          '8': 'Crise dans les relations intimes ou les finances communes. Des litiges concernant les dettes, les impôts ou l\'héritage sont possibles.',
          '9': 'Les projets de voyage ou d\'études peuvent échouer. Vos croyances peuvent se heurter à une dure réalité. Évitez les disputes sur la religion et la politique.',
          '10': 'Obstacles dans votre carrière. Conflits avec des supérieurs ou des figures d\'autorité. Vos ambitions se heurtent à des limites.',
          '11': 'Conflits avec des amis ou en groupe. Le sentiment que vos espoirs et vos rêves sont inaccessibles. Un sentiment de solitude.',
          '12': 'Les peurs intérieures et les vieux complexes refont surface. Un sentiment d\'impuissance. Il est important de ne pas s\'autocritiquer.'
        },
        'de': {
          '1': 'Dies wirkt sich direkt auf Ihre Persönlichkeit aus. Anfälle von Selbstzweifeln, Reizbarkeit und das Gefühl, "mit dem Kopf gegen die Wand zu rennen", sind möglich.',
          '2': 'Seien Sie vorsichtig mit den Finanzen. Unerwartete Ausgaben oder ein Gefühl der Ressourcenknappheit sind möglich. Harte Arbeit bringt möglicherweise nicht die erwarteten Ergebnisse.',
          '3': 'Schwierigkeiten in der Kommunikation, Streitigkeiten und Missverständnisse. Ihre Worte können als aggressiv empfunden werden. Verschieben Sie wichtige Verhandlungen.',
          '4': 'Spannungen und Konflikte zu Hause oder mit der Familie. Probleme mit Immobilien oder Reparaturen, die endlos erscheinen.',
          '5': 'Eine kreative oder romantische Krise. Ein Gefühl der Freudlosigkeit und mangelnder Inspiration. Kälte und Entfremdung sind in Beziehungen möglich.',
          '6': 'Probleme bei der Arbeit, Konflikte mit Kollegen oder Vorgesetzten. Gefühl der Überforderung und Energielosigkeit. Achten Sie auf Ihre Gesundheit.',
          '7': 'Konflikte mit Partnern. Seien Sie geduldig und üben Sie keinen Druck auf andere aus, da dies zu einer Trennung oder einem ernsthaften Streit führen könnte.',
          '8': 'Eine Krise in intimen Beziehungen oder bei gemeinsamen Finanzen. Streitigkeiten über Schulden, Steuern oder Erbschaften sind möglich.',
          '9': 'Reise- oder Bildungspläne könnten scheitern. Ihre Überzeugungen könnten mit der harten Realität kollidieren. Vermeiden Sie Streit über Religion und Politik.',
          '10': 'Hindernisse in Ihrer Karriere. Konflikte mit Vorgesetzten oder Autoritätspersonen. Ihre Ambitionen stoßen an Grenzen.',
          '11': 'Konflikte mit Freunden oder in einer Gruppe. Das Gefühl, dass Ihre Hoffnungen und Träume unerreichbar sind. Ein Gefühl der Einsamkeit.',
          '12': 'Innere Ängste und alte Komplexe kommen an die Oberfläche. Ein Gefühl der Ohnmacht. Es ist wichtig, sich nicht selbst zu kritisieren.'
        }
      },
    ),
    AspectInterpretation(
      id: 'SUN_SQUARE_MOON',
      title: {
        'ru': 'Конфликт Солнца и Луны',
        'en': 'Sun Square Moon',
        'fr': 'Soleil Carré Lune',
        'de': 'Sonne-Quadrat-Mond'
      },
      descriptionGeneral: {
        'ru': 'Внутренний конфликт между желаниями (Солнце) и потребностями (Луна). Сложно принять решение. Эмоциональное напряжение.',
        'en': 'Internal conflict between wants (Sun) and needs (Moon). Difficult to make decisions. Emotional tension.',
        'fr': 'Conflit interne entre les désirs (Soleil) et les besoins (Lune). Difficile de prendre des décisions. Tension émotionnelle.',
        'de': 'Innerer Konflikt zwischen Wünschen (Sonne) und Bedürfnissen (Mond). Schwierig, Entscheidungen zu treffen. Emotionale Spannung.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Ощущение раздвоенности, сложно понять, чего вы на самом деле хотите от себя и от жизни. Ваши действия могут противоречить вашим чувствам.',
          '2': 'Конфликт между желанием потратить деньги на удовольствия (Солнце) и потребностью в финансовой безопасности (Луна).',
          '3': 'Сложно выразить свои истинные чувства словами. Возможны недопонимания с близкими из-за несоответствия слов и эмоций.',
          '4': 'Конфликты в семье или с родителями. Ваши личные амбиции (Солнце) могут идти вразрез с семейными потребностями (Луна).',
          '5': 'В романтических отношениях сложно совместить желание быть в центре внимания и потребность в эмоциональной защищенности.',
          '6': 'Рабочие обязанности (Солнце) вступают в конфликт с вашим самочувствием и потребностью в отдыхе (Луна). Риск выгорания.',
          '7': 'Ваши личные цели конфликтуют с потребностями вашего партнера или динамикой отношений в целом.',
          '8': 'Внутренний конфликт в вопросах доверия и близости. Желание контроля сталкивается с потребностью в уязвимости.',
          '9': 'Ваши жизненные убеждения и философия (Солнце) могут не соответствовать вашим глубинным эмоциональным установкам (Луна).',
          '10': 'Трудности в карьере. Ваши амбиции и желание признания могут не совпадать с вашим эмоциональным состоянием и потребностью в уюте.',
          '11': 'Конфликт между личными целями и потребностями дружеского коллектива. Сложно найти баланс между "я" и "мы".',
          '12': 'Подсознательные страхи и старые привычки (Луна) мешают вам проявить свою индивидуальность и волю (Солнце).'
        },
        'en': {
          '1': 'A feeling of being torn, it\'s hard to understand what you really want from yourself and life. Your actions may contradict your feelings.',
          '2': 'A conflict between the desire to spend money on pleasures (Sun) and the need for financial security (Moon).',
          '3': 'It\'s difficult to express your true feelings in words. Misunderstandings with loved ones are possible due to a mismatch between words and emotions.',
          '4': 'Conflicts in the family or with parents. Your personal ambitions (Sun) may conflict with family needs (Moon).',
          '5': 'In romantic relationships, it\'s hard to combine the desire to be the center of attention with the need for emotional security.',
          '6': 'Work duties (Sun) conflict with your well-being and need for rest (Moon). Risk of burnout.',
          '7': 'Your personal goals conflict with the needs of your partner or the dynamics of the relationship as a whole.',
          '8': 'Internal conflict on issues of trust and intimacy. The desire for control clashes with the need for vulnerability.',
          '9': 'Your life beliefs and philosophy (Sun) may not align with your deep emotional attitudes (Moon).',
          '10': 'Difficulties in your career. Your ambitions and desire for recognition may not match your emotional state and need for comfort.',
          '11': 'A conflict between personal goals and the needs of your friend group. It\'s hard to find a balance between "I" and "we".',
          '12': 'Subconscious fears and old habits (Moon) prevent you from expressing your individuality and will (Sun).'
        },
        'fr': {
          '1': 'Un sentiment de déchirement, il est difficile de comprendre ce que vous voulez vraiment de vous-même et de la vie. Vos actions peuvent contredire vos sentiments.',
          '2': 'Un conflit entre le désir de dépenser de l\'argent pour des plaisirs (Soleil) et le besoin de sécurité financière (Lune).',
          '3': 'Il est difficile d\'exprimer vos vrais sentiments avec des mots. Des malentendus avec vos proches sont possibles en raison d\'une inadéquation entre les mots et les émotions.',
          '4': 'Conflits dans la famille ou avec les parents. Vos ambitions personnelles (Soleil) peuvent entrer en conflit avec les besoins familiaux (Lune).',
          '5': 'Dans les relations amoureuses, il est difficile de combiner le désir d\'être au centre de l\'attention avec le besoin de sécurité émotionnelle.',
          '6': 'Les obligations professionnelles (Soleil) entrent en conflit avec votre bien-être et votre besoin de repos (Lune). Risque d\'épuisement professionnel.',
          '7': 'Vos objectifs personnels entrent en conflit avec les besoins de votre partenaire ou la dynamique de la relation dans son ensemble.',
          '8': 'Conflit interne sur les questions de confiance et d\'intimité. Le désir de contrôle se heurte au besoin de vulnérabilité.',
          '9': 'Vos croyances et votre philosophie de vie (Soleil) peuvent ne pas correspondre à vos attitudes émotionnelles profondes (Lune).',
          '10': 'Difficultés dans votre carrière. Vos ambitions et votre désir de reconnaissance peuvent ne pas correspondre à votre état émotionnel et à votre besoin de confort.',
          '11': 'Un conflit entre les objectifs personnels et les besoins de votre groupe d\'amis. Il est difficile de trouver un équilibre entre "je" et "nous".',
          '12': 'Les peurs subconscientes et les vieilles habitudes (Lune) vous empêchent d\'exprimer votre individualité et votre volonté (Soleil).'
        },
        'de': {
          '1': 'Ein Gefühl der Zerrissenheit, es ist schwer zu verstehen, was Sie wirklich von sich und dem Leben wollen. Ihre Handlungen können Ihren Gefühlen widersprechen.',
          '2': 'Ein Konflikt zwischen dem Wunsch, Geld für Vergnügen auszugeben (Sonne), und dem Bedürfnis nach finanzieller Sicherheit (Mond).',
          '3': 'Es ist schwierig, Ihre wahren Gefühle in Worte zu fassen. Missverständnisse mit nahestehenden Personen sind aufgrund einer Diskrepanz zwischen Worten und Emotionen möglich.',
          '4': 'Konflikte in der Familie oder mit den Eltern. Ihre persönlichen Ambitionen (Sonne) können mit den familiären Bedürfnissen (Mond) in Konflikt geraten.',
          '5': 'In romantischen Beziehungen ist es schwer, den Wunsch, im Mittelpunkt zu stehen, mit dem Bedürfnis nach emotionaler Sicherheit zu verbinden.',
          '6': 'Arbeitsverpflichtungen (Sonne) stehen im Konflikt mit Ihrem Wohlbefinden und Ihrem Ruhebedürfnis (Mond). Burnout-Gefahr.',
          '7': 'Ihre persönlichen Ziele stehen im Konflikt mit den Bedürfnissen Ihres Partners oder der Dynamik der Beziehung als Ganzes.',
          '8': 'Innerer Konflikt in Fragen des Vertrauens und der Intimität. Der Wunsch nach Kontrolle kollidiert mit dem Bedürfnis nach Verletzlichkeit.',
          '9': 'Ihre Lebensüberzeugungen und Philosophie (Sonne) stimmen möglicherweise nicht mit Ihren tiefen emotionalen Einstellungen (Mond) überein.',
          '10': 'Schwierigkeiten in Ihrer Karriere. Ihre Ambitionen und Ihr Wunsch nach Anerkennung passen möglicherweise nicht zu Ihrem emotionalen Zustand und Ihrem Bedürfnis nach Geborgenheit.',
          '11': 'Ein Konflikt zwischen persönlichen Zielen und den Bedürfnissen Ihrer Freundesgruppe. Es ist schwer, ein Gleichgewicht zwischen "Ich" und "Wir" zu finden.',
          '12': 'Unterbewusste Ängste und alte Gewohnheiten (Mond) hindern Sie daran, Ihre Individualität und Ihren Willen (Sonne) auszudrücken.'
        }
      },
    ),

    // --- ГАРМОНИЧНЫЕ АСПЕКТЫ ---
    AspectInterpretation(
      id: 'VENUS_TRINE_JUPITER',
      title: {
        'ru': 'Гармония Венеры и Юпитера',
        'en': 'Venus Trine Jupiter',
        'fr': 'Vénus Trigone Jupiter',
        'de': 'Venus-Trigon-Jupiter'
      },
      descriptionGeneral: {
        'ru': 'Один из лучших дней для любви, общения и финансов! Удача на вашей стороне. Время для свиданий, приятных покупок и развлечений.',
        'en': 'One of the best days for love, social activities, and finances! Luck is on your side. Time for dates, pleasant shopping, and entertainment.',
        'fr': 'L\'un des meilleurs jours pour l\'amour, les activités sociales et les finances ! La chance est de votre côté. C\'est le moment pour les rendez-vous, le shopping agréable et les divertissements.',
        'de': 'Einer der besten Tage für Liebe, soziale Aktivitäten und Finanzen! Das Glück ist auf Ihrer Seite. Zeit für Verabredungen, angenehmes Einkaufen und Unterhaltung.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Вы обаятельны и привлекательны. Отличный день, чтобы произвести хорошее впечатление, сходить на свидание или обновить имидж.',
          '2': 'Финансовая удача! Возможны неожиданные доходы, подарки или очень удачные покупки. Хорошее время для инвестиций в красоту.',
          '3': 'Приятное общение, флирт, получение хороших новостей. Легко выражать свои симпатии и договариваться.',
          '4': 'Гармония и уют в доме. Отличный день для семейного праздника, украшения дома или покупки красивых вещей для интерьера.',
          '5': 'Идеальное время для флирта, романтики, творчества и развлечений. Наслаждайтесь жизнью! Вероятность яркого свидания очень высока.',
          '6': 'Приятная атмосфера на работе, хорошие отношения с коллегами. Работа доставляет удовольствие. Можно позволить себе что-то вкусное.',
          '7': 'Полная гармония в партнерских отношениях. Отличный день для свидания, предложения руки и сердца или просто приятного времени вместе.',
          '8': 'Усиление сексуального притяжения и эмоциональной близости. Возможна финансовая удача через партнера.',
          '9': 'Романтическое знакомство в поездке или с человеком издалека. Расширение кругозора через искусство и красоту.',
          '10': 'Успех в карьере благодаря обаянию. Легко завоевать симпатию начальства или публики. Повышение социального статуса.',
          '11': 'Успех в компании друзей, новые приятные знакомства. Ваши надежды и мечты в любви могут легко осуществиться.',
          '12': 'Ощущение тихого счастья и внутренней гармонии. Тайный роман или просто наслаждение одиночеством и красотой.'
        },
        'en': {
          '1': 'You are charming and attractive. An excellent day to make a good impression, go on a date, or update your image.',
          '2': 'Financial luck! Unexpected income, gifts, or very successful purchases are possible. A good time to invest in beauty.',
          '3': 'Pleasant communication, flirting, receiving good news. It\'s easy to express your affections and make agreements.',
          '4': 'Harmony and comfort at home. An excellent day for a family celebration, decorating the house, or buying beautiful things for the interior.',
          '5': 'The perfect time for flirting, romance, creativity, and entertainment. Enjoy life! The probability of a memorable date is very high.',
          '6': 'A pleasant atmosphere at work, good relationships with colleagues. Work brings pleasure. You can treat yourself to something tasty.',
          '7': 'Complete harmony in partnerships. An excellent day for a date, a marriage proposal, or just spending pleasant time together.',
          '8': 'Strengthening of sexual attraction and emotional intimacy. Financial luck through a partner is possible.',
          '9': 'A romantic encounter during a trip or with someone from far away. Broadening your horizons through art and beauty.',
          '10': 'Career success through charm. It\'s easy to win the favor of superiors or the public. An increase in social status.',
          '11': 'Success in the company of friends, new pleasant acquaintances. Your hopes and dreams in love can easily come true.',
          '12': 'A feeling of quiet happiness and inner harmony. A secret romance or simply enjoying solitude and beauty.'
        },
        'fr': {
          '1': 'Vous êtes charmant et attrayant. Une excellente journée pour faire bonne impression, avoir un rendez-vous ou renouveler votre image.',
          '2': 'Chance financière ! Des revenus inattendus, des cadeaux ou des achats très réussis sont possibles. Un bon moment pour investir dans la beauté.',
          '3': 'Communication agréable, flirt, réception de bonnes nouvelles. Il est facile d\'exprimer vos affections et de conclure des accords.',
          '4': 'Harmonie et confort à la maison. Une excellente journée pour une fête de famille, décorer la maison ou acheter de belles choses pour l\'intérieur.',
          '5': 'Le moment idéal pour le flirt, la romance, la créativité et le divertissement. Profitez de la vie ! La probabilité d\'un rendez-vous mémorable est très élevée.',
          '6': 'Une atmosphère agréable au travail, de bonnes relations avec les collègues. Le travail apporte du plaisir. Vous pouvez vous offrir quelque chose de savoureux.',
          '7': 'Harmonie complète dans les partenariats. Une excellente journée pour un rendez-vous, une demande en mariage ou simplement passer un agréable moment ensemble.',
          '8': 'Renforcement de l\'attirance sexuelle et de l\'intimité émotionnelle. Une chance financière par le biais d\'un partenaire est possible.',
          '9': 'Une rencontre romantique lors d\'un voyage ou avec quelqu\'un de loin. Élargir vos horizons à travers l\'art et la beauté.',
          '10': 'Succès professionnel grâce au charme. Il est facile de gagner la faveur des supérieurs ou du public. Une augmentation du statut social.',
          '11': 'Succès en compagnie d\'amis, nouvelles connaissances agréables. Vos espoirs et vos rêves en amour peuvent facilement se réaliser.',
          '12': 'Un sentiment de bonheur tranquille et d\'harmonie intérieure. Une romance secrète ou simplement profiter de la solitude et de la beauté.'
        },
        'de': {
          '1': 'Sie sind charmant und attraktiv. Ein ausgezeichneter Tag, um einen guten Eindruck zu hinterlassen, ein Date zu haben oder Ihr Image zu aktualisieren.',
          '2': 'Finanzielles Glück! Unerwartete Einnahmen, Geschenke oder sehr erfolgreiche Einkäufe sind möglich. Eine gute Zeit, um in Schönheit zu investieren.',
          '3': 'Angenehme Kommunikation, Flirten, gute Nachrichten erhalten. Es ist einfach, Ihre Zuneigung auszudrücken und Vereinbarungen zu treffen.',
          '4': 'Harmonie und Komfort zu Hause. Ein ausgezeichneter Tag für eine Familienfeier, die Dekoration des Hauses oder den Kauf schöner Dinge für die Einrichtung.',
          '5': 'Die perfekte Zeit zum Flirten, für Romantik, Kreativität und Unterhaltung. Genießen Sie das Leben! Die Wahrscheinlichkeit eines unvergesslichen Dates ist sehr hoch.',
          '6': 'Eine angenehme Atmosphäre bei der Arbeit, gute Beziehungen zu Kollegen. Die Arbeit macht Freude. Sie können sich etwas Leckeres gönnen.',
          '7': 'Vollständige Harmonie in Partnerschaften. Ein ausgezeichneter Tag für ein Date, einen Heiratsantrag oder einfach nur eine angenehme Zeit zusammen.',
          '8': 'Stärkung der sexuellen Anziehung und emotionalen Intimität. Finanzielles Glück durch einen Partner ist möglich.',
          '9': 'Eine romantische Begegnung während einer Reise oder mit jemandem aus der Ferne. Erweiterung Ihres Horizonts durch Kunst und Schönheit.',
          '10': 'Beruflicher Erfolg durch Charme. Es ist leicht, die Gunst von Vorgesetzten oder der Öffentlichkeit zu gewinnen. Eine Erhöhung des sozialen Status.',
          '11': 'Erfolg im Freundeskreis, neue angenehme Bekanntschaften. Ihre Hoffnungen und Träume in der Liebe können leicht wahr werden.',
          '12': 'Ein Gefühl von stillem Glück und innerer Harmonie. Eine heimliche Romanze oder einfach die Einsamkeit und Schönheit genießen.'
        }
      },
    ),
    AspectInterpretation(
      id: 'SUN_CONJUNCTION_MERCURY',
      title: {
        'ru': 'Соединение Солнца и Меркурия',
        'en': 'Sun Conjunct Mercury',
        'fr': 'Soleil Conjoint Mercure',
        'de': 'Sonne-Konjunktion-Merkur'
      },
      descriptionGeneral: {
        'ru': 'Мышление ясное и четкое. Отличный день для важных разговоров, переговоров, обучения и коротких поездок.',
        'en': 'Thinking is clear and sharp. An excellent day for important conversations, negotiations, learning, and short trips.',
        'fr': 'La pensée est claire et nette. Une excellente journée pour les conversations importantes, les négociations, l\'apprentissage et les courts voyages.',
        'de': 'Das Denken ist klar und scharf. Ein ausgezeichneter Tag für wichtige Gespräche, Verhandlungen, Lernen und kurze Reisen.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Ясность мыслей о себе и своих целях. Легко выразить свою точку зрения и произвести впечатление умного человека.',
          '2': 'Отличное время для планирования бюджета, анализа финансовых возможностей и переговоров о зарплате.',
          '3': 'Ваше слово имеет вес. Легко доносить свои мысли до окружающих, успешные переговоры, удачное время для учебы и письма.',
          '4': 'Важные разговоры с семьей. Хорошее время для решения вопросов, связанных с домом и недвижимостью.',
          '5': 'Остроумный флирт и интеллектуальное общение с объектом симпатии. Легко выразить свои чувства словами.',
          '6': 'Порядок в мыслях помогает навести порядок на работе. Эффективное решение задач, удачные обсуждения с коллегами.',
          '7': 'Идеальный день для серьезного разговора с партнером, обсуждения планов на будущее. Благоприятно для заключения договоров.',
          '8': 'Глубокие и проникновенные беседы. Возможность докопаться до сути проблемы и найти решение в сложных вопросах.',
          '9': 'Благоприятно для обучения, расширения кругозора, планирования дальних поездок и общения с иностранцами.',
          '10': 'Успешные переговоры с начальством, блестящие идеи по поводу карьеры. Ваше мнение будет услышано и оценено.',
          '11': 'Активное общение с друзьями, планирование совместных мероприятий. Ваши идеи находят поддержку в коллективе.',
          '12': 'Время для размышлений и самоанализа. Запись своих мыслей в дневник поможет обрести ясность и понять скрытые мотивы.'
        },
        'en': {
          '1': 'Clarity of thought about yourself and your goals. It\'s easy to express your point of view and make an impression as an intelligent person.',
          '2': 'An excellent time for budget planning, analyzing financial opportunities, and salary negotiations.',
          '3': 'Your word carries weight. It\'s easy to convey your thoughts to others, successful negotiations, a good time for studying and writing.',
          '4': 'Important conversations with family. A good time to resolve issues related to home and real estate.',
          '5': 'Witty flirting and intellectual communication with your crush. It\'s easy to express your feelings in words.',
          '6': 'Order in your thoughts helps bring order to your work. Efficient problem-solving, successful discussions with colleagues.',
          '7': 'An ideal day for a serious conversation with your partner, discussing future plans. Favorable for signing contracts.',
          '8': 'Deep and insightful conversations. An opportunity to get to the heart of a problem and find a solution to complex issues.',
          '9': 'Favorable for learning, broadening your horizons, planning long trips, and communicating with foreigners.',
          '10': 'Successful negotiations with superiors, brilliant career ideas. Your opinion will be heard and appreciated.',
          '11': 'Active communication with friends, planning joint activities. Your ideas find support within the group.',
          '12': 'A time for reflection and self-analysis. Writing down your thoughts in a journal will help you gain clarity and understand hidden motives.'
        },
        'fr': {
          '1': 'Clarté de pensée sur vous-même et vos objectifs. Il est facile d\'exprimer votre point de vue et de donner l\'impression d\'être une personne intelligente.',
          '2': 'Un excellent moment pour planifier le budget, analyser les opportunités financières et négocier son salaire.',
          '3': 'Votre parole a du poids. Il est facile de transmettre vos pensées aux autres, négociations réussies, un bon moment pour étudier et écrire.',
          '4': 'Conversations importantes en famille. Un bon moment pour résoudre les problèmes liés à la maison et à l\'immobilier.',
          '5': 'Flirt spirituel et communication intellectuelle avec l\'objet de votre affection. Il est facile d\'exprimer vos sentiments avec des mots.',
          '6': 'L\'ordre dans vos pensées aide à mettre de l\'ordre dans votre travail. Résolution efficace des problèmes, discussions fructueuses avec les collègues.',
          '7': 'Une journée idéale pour une conversation sérieuse avec votre partenaire, discuter des projets d\'avenir. Favorable à la signature de contrats.',
          '8': 'Conversations profondes et perspicaces. Une opportunité d\'aller au fond d\'un problème et de trouver une solution à des questions complexes.',
          '9': 'Favorable à l\'apprentissage, à l\'élargissement de vos horizons, à la planification de longs voyages et à la communication avec des étrangers.',
          '10': 'Négociations réussies avec les supérieurs, idées de carrière brillantes. Votre opinion sera entendue et appréciée.',
          '11': 'Communication active avec des amis, planification d\'activités communes. Vos idées trouvent un soutien au sein du groupe.',
          '12': 'Un temps pour la réflexion et l\'auto-analyse. Écrire vos pensées dans un journal vous aidera à gagner en clarté et à comprendre les motivations cachées.'
        },
        'de': {
          '1': 'Klarheit der Gedanken über sich selbst und Ihre Ziele. Es ist leicht, Ihren Standpunkt auszudrücken und den Eindruck einer intelligenten Person zu machen.',
          '2': 'Eine ausgezeichnete Zeit für die Budgetplanung, die Analyse finanzieller Möglichkeiten und Gehaltsverhandlungen.',
          '3': 'Ihr Wort hat Gewicht. Es ist leicht, Ihre Gedanken anderen zu vermitteln, erfolgreiche Verhandlungen, eine gute Zeit zum Studieren und Schreiben.',
          '4': 'Wichtige Gespräche mit der Familie. Eine gute Zeit, um Probleme im Zusammenhang mit Haus und Immobilien zu lösen.',
          '5': 'Witziges Flirten und intellektuelle Kommunikation mit Ihrem Schwarm. Es ist leicht, Ihre Gefühle in Worte zu fassen.',
          '6': 'Ordnung in Ihren Gedanken hilft, Ordnung bei der Arbeit zu schaffen. Effiziente Problemlösung, erfolgreiche Diskussionen mit Kollegen.',
          '7': 'Ein idealer Tag für ein ernstes Gespräch mit Ihrem Partner, um Zukunftspläne zu besprechen. Günstig für Vertragsunterzeichnungen.',
          '8': 'Tiefe und aufschlussreiche Gespräche. Eine Gelegenheit, dem Kern eines Problems auf den Grund zu gehen und eine Lösung für komplexe Fragen zu finden.',
          '9': 'Günstig zum Lernen, zur Horizonterweiterung, zur Planung langer Reisen und zur Kommunikation mit Ausländern.',
          '10': 'Erfolgreiche Verhandlungen mit Vorgesetzten, brillante Karriereideen. Ihre Meinung wird gehört und geschätzt.',
          '11': 'Aktive Kommunikation mit Freunden, Planung gemeinsamer Aktivitäten. Ihre Ideen finden in der Gruppe Unterstützung.',
          '12': 'Eine Zeit der Reflexion und Selbstanalyse. Das Aufschreiben Ihrer Gedanken in einem Tagebuch wird Ihnen helfen, Klarheit zu gewinnen und verborgene Motive zu verstehen.'
        }
      },
    ),
        // === НОВЫЙ БЛОК 1 ===
    AspectInterpretation(
      id: 'VENUS_SQUARE_PLUTO',
      title: {
        'ru': 'Конфликт Венеры и Плутона',
        'en': 'Venus Square Pluto',
        'fr': 'Vénus Carré Pluton',
        'de': 'Venus-Quadrat-Pluto'
      },
      descriptionGeneral: {
        'ru': 'Высокое напряжение в любви. Страсти, ревность, манипуляции и борьба за власть. Отношения проходят проверку на прочность. Возможны сильные, но болезненные переживания.',
        'en': 'High tension in love. Passions, jealousy, manipulations, and power struggles. Relationships are tested. Intense but painful experiences are possible.',
        'fr': 'Haute tension en amour. Passions, jalousie, manipulations et luttes de pouvoir. Les relations sont mises à l\'épreuve. Des expériences intenses mais douloureuses sont possibles.',
        'de': 'Hohe Spannung in der Liebe. Leidenschaften, Eifersucht, Manipulationen und Machtkämpfe. Beziehungen werden auf die Probe gestellt. Intensive, aber schmerzhafte Erfahrungen sind möglich.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Ваша привлекательность становится полем для драмы. Возможны навязчивые мысли о своей внешности или использование ее для манипуляций.',
          '2': 'Одержимость деньгами или страх их потерять. Возможны финансовые манипуляции в отношениях. Не стоит брать или давать в долг.',
          '3': 'Слова становятся оружием. Ревнивые допросы, язвительные замечания или попытки манипулировать информацией.',
          '4': 'Борьба за власть в семье. На поверхность могут выйти старые семейные тайны или обиды, создавая напряженную атмосферу.',
          '5': 'Романтические отношения превращаются в драму. Сильная страсть, но и сильная ревность, контроль и эмоциональные качели.',
          '6': 'Служебный роман с элементами драмы или борьба за власть с коллегами (особенно женщинами). Одержимость работой.',
          '7': 'Прямой конфликт с партнером. Ревность, подозрения, попытки контролировать друг друга. Отношения могут либо трансформироваться, либо разрушиться.',
          '8': 'Кризис в интимной жизни или в вопросах общих финансов. Сексуальная энергия очень высока, но может использоваться для манипуляций.',
          '9': 'Конфликт убеждений с партнером. Попытки "переделать" его мировоззрение могут привести к серьезным ссорам.',
          '10': 'Ваша личная жизнь может стать достоянием общественности, вызывая скандал. Возможны интриги на работе.',
          '11': 'Ревность и манипуляции в кругу друзей. Друг может пытаться контролировать вас или вмешиваться в ваши отношения.',
          '12': 'Тайные, мучительные любовные связи. Ваши скрытые страхи и комплексы в отношениях выходят наружу.'
        },
        'en': {
          '1': 'Your attractiveness becomes a stage for drama. Obsessive thoughts about your appearance or using it for manipulation are possible.',
          '2': 'Obsession with money or fear of losing it. Financial manipulation in relationships is possible. It\'s not a good time to borrow or lend money.',
          '3': 'Words become weapons. Jealous interrogations, sarcastic remarks, or attempts to manipulate information.',
          '4': 'Power struggles within the family. Old family secrets or resentments may surface, creating a tense atmosphere.',
          '5': 'Romantic relationships turn into drama. Intense passion, but also intense jealousy, control, and emotional rollercoasters.',
          '6': 'An office romance with elements of drama or a power struggle with colleagues (especially female ones). Obsession with work.',
          '7': 'Direct conflict with a partner. Jealousy, suspicion, attempts to control each other. The relationship must either transform or be destroyed.',
          '8': 'A crisis in your intimate life or in matters of joint finances. Sexual energy is very high but can be used for manipulation.',
          '9': 'A conflict of beliefs with a partner. Attempts to "remake" their worldview can lead to serious quarrels.',
          '10': 'Your personal life may become public, causing a scandal. Intrigues at work are possible.',
          '11': 'Jealousy and manipulation within your circle of friends. A friend may try to control you or interfere in your relationship.',
          '12': 'Secret, agonizing love affairs. Your hidden fears and complexes in relationships come to the surface.'
        },
        'fr': {
          '1': 'Votre attrait devient une scène de drame. Des pensées obsessionnelles sur votre apparence ou son utilisation à des fins de manipulation sont possibles.',
          '2': 'Obsession de l\'argent ou peur de le perdre. La manipulation financière dans les relations est possible. Ce n\'est pas le moment d\'emprunter ou de prêter de l\'argent.',
          '3': 'Les mots deviennent des armes. Interrogatoires jaloux, remarques sarcastiques ou tentatives de manipuler l\'information.',
          '4': 'Luttes de pouvoir au sein de la famille. De vieux secrets de famille ou des ressentiments peuvent refaire surface, créant une atmosphère tendue.',
          '5': 'Les relations amoureuses se transforment en drame. Passion intense, mais aussi jalousie intense, contrôle et montagnes russes émotionnelles.',
          '6': 'Une romance au bureau avec des éléments de drame ou une lutte de pouvoir avec des collègues (surtout féminins). Obsession du travail.',
          '7': 'Conflit direct avec un partenaire. Jalousie, suspicion, tentatives de se contrôler mutuellement. La relation doit soit se transformer, soit être détruite.',
          '8': 'Crise dans votre vie intime ou dans les questions de finances communes. L\'énergie sexuelle est très élevée mais peut être utilisée à des fins de manipulation.',
          '9': 'Un conflit de croyances avec un partenaire. Tenter de "refaire" sa vision du monde peut entraîner de graves querelles.',
          '10': 'Votre vie personnelle peut devenir publique, provoquant un scandale. Des intrigues au travail sont possibles.',
          '11': 'Jalousie et manipulation au sein de votre cercle d\'amis. Un ami peut essayer de vous contrôler ou d\'interférer dans votre relation.',
          '12': 'Amours secrètes et angoissantes. Vos peurs et complexes cachés dans les relations refont surface.'
        },
        'de': {
          '1': 'Ihre Anziehungskraft wird zur Bühne für Dramen. Zwanghafte Gedanken über Ihr Aussehen oder dessen manipulative Nutzung sind möglich.',
          '2': 'Besessenheit von Geld oder die Angst, es zu verlieren. Finanzielle Manipulation in Beziehungen ist möglich. Es ist keine gute Zeit, Geld zu leihen oder zu verleihen.',
          '3': 'Worte werden zu Waffen. Eifersüchtige Verhöre, sarkastische Bemerkungen oder Versuche, Informationen zu manipulieren.',
          '4': 'Machtkämpfe innerhalb der Familie. Alte Familiengeheimnisse oder Groll können an die Oberfläche kommen und eine angespannte Atmosphäre schaffen.',
          '5': 'Romantische Beziehungen werden zum Drama. Intensive Leidenschaft, aber auch intensive Eifersucht, Kontrolle und emotionale Achterbahnfahrten.',
          '6': 'Eine Büro-Romanze mit dramatischen Elementen oder ein Machtkampf mit Kollegen (besonders weiblichen). Besessenheit von der Arbeit.',
          '7': 'Direkter Konflikt mit einem Partner. Eifersucht, Misstrauen, Versuche, sich gegenseitig zu kontrollieren. Die Beziehung muss sich entweder transformieren oder wird zerstört.',
          '8': 'Eine Krise in Ihrem Intimleben oder in Fragen gemeinsamer Finanzen. Die sexuelle Energie ist sehr hoch, kann aber zur Manipulation missbraucht werden.',
          '9': 'Ein Glaubenskonflikt mit einem Partner. Versuche, seine Weltanschauung zu "ändern", können zu ernsthaften Streitigkeiten führen.',
          '10': 'Ihr Privatleben könnte öffentlich werden und einen Skandal verursachen. Intrigen bei der Arbeit sind möglich.',
          '11': 'Eifersucht und Manipulation im Freundeskreis. Ein Freund könnte versuchen, Sie zu kontrollieren oder sich in Ihre Beziehung einzumischen.',
          '12': 'Geheime, quälende Liebesaffären. Ihre verborgenen Ängste und Komplexe in Beziehungen kommen an die Oberfläche.'
        }
      }
    ),
    AspectInterpretation(
      id: 'SUN_OPPOSITION_SATURN',
      title: {
        'ru': 'Противостояние Солнца и Сатурна',
        'en': 'Sun Opposition Saturn',
        'fr': 'Soleil Opposition Saturne',
        'de': 'Sonne-Opposition-Saturn'
      },
      descriptionGeneral: {
        'ru': 'День испытаний и ограничений. Ваши желания (Солнце) сталкиваются с суровой реальностью или давлением со стороны авторитетов (Сатурн). Возможна критика, неуверенность в себе, задержки.',
        'en': 'A day of tests and limitations. Your desires (Sun) clash with harsh reality or pressure from authority figures (Saturn). Criticism, self-doubt, and delays are possible.',
        'fr': 'Une journée d\'épreuves et de limitations. Vos désirs (Soleil) se heurtent à la dure réalité ou à la pression de figures d\'autorité (Saturne). La critique, le doute de soi et les retards sont possibles.',
        'de': 'Ein Tag der Prüfungen und Einschränkungen. Ihre Wünsche (Sonne) kollidieren mit der harten Realität oder dem Druck von Autoritätspersonen (Saturn). Kritik, Selbstzweifel und Verzögerungen sind möglich.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Сильный удар по самооценке. Вы можете столкнуться с критикой или почувствовать себя некомпетентным. Не лучшее время для самопрезентации.',
          '2': 'Финансовые трудности. Планы по заработку могут столкнуться с препятствиями. Ощущение, что тяжелый труд не ценится.',
          '3': 'Сложности в общении. Ваши идеи могут быть отвергнуты или раскритикованы. Новости могут быть удручающими.',
          '4': 'Конфликт с родителями (особенно с отцом) или давление семейных обязанностей. Ощущение тяжести в собственном доме.',
          '5': 'Отсутствие радости и вдохновения. Романтические отношения могут казаться обузой, а хобби не приносить удовольствия.',
          '6': 'Проблемы на работе. Начальство может быть особенно требовательным или критичным. Перегрузка обязанностями и усталость.',
          '7': 'Противостояние с партнером. Он может выступать в роли критика или ограничителя. Ощущение холодности и дистанции.',
          '8': 'Давление долговых обязательств или налогов. В интимной сфере возможна холодность или страх близости.',
          '9': 'Ваши убеждения проходят проверку на прочность. Планы на путешествие или обучение могут быть отложены или отменены.',
          '10': 'Прямой конфликт с начальством или властями. Карьерные амбиции сталкиваются с серьезными препятствиями.',
          '11': 'Разочарование в друзьях или в своих мечтах. Друзья могут критиковать вас, а цели казаться недостижимыми.',
          '12': 'Обострение старых страхов и комплексов. Ощущение одиночества и пессимизм. Важно не уходить в самоизоляцию.'
        },
        'en': {
          '1': 'A major blow to self-esteem. You may face criticism or feel incompetent. Not the best time for self-presentation.',
          '2': 'Financial difficulties. Earning plans may face obstacles. A feeling that hard work is not appreciated.',
          '3': 'Difficulties in communication. Your ideas may be rejected or criticized. The news may be depressing.',
          '4': 'Conflict with parents (especially the father) or the pressure of family responsibilities. A feeling of heaviness in your own home.',
          '5': 'A lack of joy and inspiration. Romantic relationships may feel like a burden, and hobbies may not bring pleasure.',
          '6': 'Problems at work. Superiors may be particularly demanding or critical. Overload of duties and fatigue.',
          '7': 'Confrontation with a partner. They may act as a critic or a limiter. A feeling of coldness and distance.',
          '8': 'Pressure from debt obligations or taxes. In the intimate sphere, coldness or fear of intimacy is possible.',
          '9': 'Your beliefs are put to the test. Travel or education plans may be postponed or canceled.',
          '10': 'Direct conflict with superiors or authorities. Career ambitions face serious obstacles.',
          '11': 'Disappointment in friends or in your dreams. Friends may criticize you, and goals may seem unattainable.',
          '12': 'Exacerbation of old fears and complexes. A feeling of loneliness and pessimism. It is important not to self-isolate.'
        },
        'fr': {
          '1': 'Un coup dur pour l\'estime de soi. Vous pourriez faire face à des critiques ou vous sentir incompétent. Ce n\'est pas le meilleur moment pour se présenter.',
          '2': 'Difficultés financières. Les plans de revenus peuvent rencontrer des obstacles. Le sentiment que le travail acharné n\'est pas apprécié.',
          '3': 'Difficultés de communication. Vos idées peuvent être rejetées ou critiquées. Les nouvelles peuvent être déprimantes.',
          '4': 'Conflit avec les parents (surtout le père) ou pression des responsabilités familiales. Un sentiment de lourdeur dans votre propre maison.',
          '5': 'Un manque de joie et d\'inspiration. Les relations amoureuses peuvent sembler un fardeau, et les passe-temps ne pas apporter de plaisir.',
          '6': 'Problèmes au travail. Les supérieurs peuvent être particulièrement exigeants ou critiques. Surcharge de devoirs et fatigue.',
          '7': 'Confrontation avec un partenaire. Il peut agir comme un critique ou un limiteur. Un sentiment de froideur et de distance.',
          '8': 'Pression des dettes ou des impôts. Dans la sphère intime, la froideur ou la peur de l\'intimité est possible.',
          '9': 'Vos croyances sont mises à l\'épreuve. Les projets de voyage ou d\'études peuvent être reportés ou annulés.',
          '10': 'Conflit direct avec les supérieurs ou les autorités. Les ambitions de carrière se heurtent à de sérieux obstacles.',
          '11': 'Déception envers des amis ou dans vos rêves. Les amis peuvent vous critiquer, et les objectifs peuvent sembler inaccessibles.',
          '12': 'Exacerbation des vieilles peurs et des complexes. Un sentiment de solitude et de pessimisme. Il est important de ne pas s\'isoler.'
        },
        'de': {
          '1': 'Ein schwerer Schlag für das Selbstwertgefühl. Sie könnten Kritik ausgesetzt sein oder sich inkompetent fühlen. Nicht die beste Zeit für Selbstdarstellung.',
          '2': 'Finanzielle Schwierigkeiten. Verdienstpläne könnten auf Hindernisse stoßen. Das Gefühl, dass harte Arbeit nicht geschätzt wird.',
          '3': 'Schwierigkeiten in der Kommunikation. Ihre Ideen könnten abgelehnt oder kritisiert werden. Die Nachrichten könnten deprimierend sein.',
          '4': 'Konflikt mit den Eltern (insbesondere dem Vater) oder der Druck familiärer Pflichten. Ein Gefühl der Schwere im eigenen Zuhause.',
          '5': 'Ein Mangel an Freude und Inspiration. Romantische Beziehungen können sich wie eine Last anfühlen und Hobbys keine Freude bereiten.',
          '6': 'Probleme bei der Arbeit. Vorgesetzte könnten besonders anspruchsvoll oder kritisch sein. Überlastung durch Pflichten und Müdigkeit.',
          '7': 'Konfrontation mit einem Partner. Er könnte als Kritiker oder Begrenzer auftreten. Ein Gefühl von Kälte und Distanz.',
          '8': 'Druck durch Schulden oder Steuern. Im intimen Bereich sind Kälte oder Angst vor Nähe möglich.',
          '9': 'Ihre Überzeugungen werden auf die Probe gestellt. Reise- oder Bildungspläne könnten verschoben oder abgesagt werden.',
          '10': 'Direkter Konflikt mit Vorgesetzten oder Behörden. Karriereambitionen stoßen auf ernsthafte Hindernisse.',
          '11': 'Enttäuschung von Freunden oder in Ihren Träumen. Freunde könnten Sie kritisieren und Ziele unerreichbar erscheinen.',
          '12': 'Verschärfung alter Ängste und Komplexe. Ein Gefühl von Einsamkeit und Pessimismus. Es ist wichtig, sich nicht zu isolieren.'
        }
      }
    ),
    AspectInterpretation(
      id: 'MOON_TRINE_NEPTUNE',
      title: {
        'ru': 'Гармония Луны и Нептуна',
        'en': 'Moon Trine Neptune',
        'fr': 'Lune Trigone Neptune',
        'de': 'Mond-Trigon-Neptun'
      },
      descriptionGeneral: {
        'ru': 'День мечтательности, интуиции и романтики. Ваше воображение и сострадание усилены. Идеально для творчества, медитации, музыки и душевных разговоров.',
        'en': 'A day of dreaminess, intuition, and romance. Your imagination and compassion are enhanced. Ideal for creativity, meditation, music, and heartfelt conversations.',
        'fr': 'Une journée de rêverie, d\'intuition et de romance. Votre imagination et votre compassion sont renforcées. Idéal pour la créativité, la méditation, la musique et les conversations sincères.',
        'de': 'Ein Tag der Träumerei, Intuition und Romantik. Ihre Vorstellungskraft und Ihr Mitgefühl sind gesteigert. Ideal für Kreativität, Meditation, Musik und herzliche Gespräche.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Вы излучаете мягкость, загадочность и сострадание. Ваша интуиция о себе и своих потребностях очень сильна.',
          '2': 'Интуиция помогает в финансовых вопросах. Можно найти деньги на мечту или потратить их на что-то красивое и вдохновляющее.',
          '3': 'Нежное и понимающее общение. Легко говорить на душевные темы, писать стихи или просто мечтать вместе.',
          '4': 'Идеальный день для создания уютной и одухотворенной атмосферы дома. Гармония в семье, глубокое взаимопонимание.',
          '5': 'Очень романтическое настроение. Свидание может быть похоже на сказку. Отличное время для творчества, музыки, кино.',
          '6': 'Возможность проявить сострадание на работе. Работа может приносить духовное удовлетворение. Хороший день для оздоровительных практик.',
          '7': 'Глубокая духовная и эмоциональная связь с партнером. Ощущение, что вы понимаете друг друга без слов.',
          '8': 'Сильная интуиция и сны. Глубокое слияние с партнером на эмоциональном и интимном уровне. Доверяйте своим предчувствиям.',
          '9': 'Мечты о дальних странах. Интерес к духовным практикам, религии и философии. Вдохновение приходит издалека.',
          '10': 'Ваша интуиция помогает в карьере. Вы можете произвести очень благоприятное, одухотворенное впечатление на публику или начальство.',
          '11': 'Душевная встреча с друзьями. Вы можете стать источником вдохновения для других. Мечты легко находят поддержку.',
          '12': 'Глубокое погружение в свой внутренний мир. Медитация, музыка, уединение на природе принесут умиротворение и инсайты.'
        },
        'en': {
          '1': 'You radiate softness, mystery, and compassion. Your intuition about yourself and your needs is very strong.',
          '2': 'Intuition helps in financial matters. You might find money for a dream or spend it on something beautiful and inspiring.',
          '3': 'Gentle and understanding communication. It\'s easy to talk about soulful topics, write poetry, or just dream together.',
          '4': 'An ideal day to create a cozy and spiritual atmosphere at home. Harmony in the family, deep mutual understanding.',
          '5': 'A very romantic mood. A date can be like a fairy tale. A great time for creativity, music, and movies.',
          '6': 'An opportunity to show compassion at work. Work can bring spiritual satisfaction. A good day for wellness practices.',
          '7': 'A deep spiritual and emotional connection with your partner. A feeling that you understand each other without words.',
          '8': 'Strong intuition and dreams. A deep merging with your partner on an emotional and intimate level. Trust your hunches.',
          '9': 'Dreams of distant lands. Interest in spiritual practices, religion, and philosophy. Inspiration comes from afar.',
          '10': 'Your intuition helps in your career. You can make a very favorable, spiritual impression on the public or superiors.',
          '11': 'A soulful meeting with friends. You can become a source of inspiration for others. Dreams easily find support.',
          '12': 'A deep dive into your inner world. Meditation, music, and solitude in nature will bring peace and insights.'
        },
        'fr': {
          '1': 'Vous rayonnez de douceur, de mystère et de compassion. Votre intuition sur vous-même et vos besoins est très forte.',
          '2': 'L\'intuition aide dans les affaires financières. Vous pourriez trouver de l\'argent pour un rêve ou le dépenser pour quelque chose de beau et d\'inspirant.',
          '3': 'Communication douce et compréhensive. Il est facile de parler de sujets profonds, d\'écrire de la poésie ou simplement de rêver ensemble.',
          '4': 'Une journée idéale pour créer une atmosphère chaleureuse et spirituelle à la maison. Harmonie dans la famille, profonde compréhension mutuelle.',
          '5': 'Une humeur très romantique. Un rendez-vous peut être comme un conte de fées. Un excellent moment pour la créativité, la musique et le cinéma.',
          '6': 'Une opportunité de faire preuve de compassion au travail. Le travail peut apporter une satisfaction spirituelle. Une bonne journée pour les pratiques de bien-être.',
          '7': 'Une connexion spirituelle et émotionnelle profonde avec votre partenaire. Le sentiment de se comprendre sans mots.',
          '8': 'Forte intuition et rêves. Une fusion profonde avec votre partenaire sur un plan émotionnel et intime. Faites confiance à vos intuitions.',
          '9': 'Rêves de terres lointaines. Intérêt pour les pratiques spirituelles, la religion et la philosophie. L\'inspiration vient de loin.',
          '10': 'Votre intuition vous aide dans votre carrière. Vous pouvez faire une impression très favorable et spirituelle sur le public ou les supérieurs.',
          '11': 'Une rencontre émouvante avec des amis. Vous pouvez devenir une source d\'inspiration pour les autres. Les rêves trouvent facilement un soutien.',
          '12': 'Une plongée profonde dans votre monde intérieur. La méditation, la musique et la solitude dans la nature apporteront paix et perspicacité.'
        },
        'de': {
          '1': 'Sie strahlen Weichheit, Geheimnis und Mitgefühl aus. Ihre Intuition über sich selbst und Ihre Bedürfnisse ist sehr stark.',
          '2': 'Intuition hilft in finanziellen Angelegenheiten. Sie könnten Geld für einen Traum finden oder es für etwas Schönes und Inspirierendes ausgeben.',
          '3': 'Sanfte und verständnisvolle Kommunikation. Es ist leicht, über seelenvolle Themen zu sprechen, Gedichte zu schreiben oder einfach zusammen zu träumen.',
          '4': 'Ein idealer Tag, um eine gemütliche und spirituelle Atmosphäre zu Hause zu schaffen. Harmonie in der Familie, tiefes gegenseitiges Verständnis.',
          '5': 'Eine sehr romantische Stimmung. Ein Date kann wie ein Märchen sein. Eine großartige Zeit für Kreativität, Musik und Filme.',
          '6': 'Eine Gelegenheit, bei der Arbeit Mitgefühl zu zeigen. Arbeit kann spirituelle Erfüllung bringen. Ein guter Tag für Wellness-Praktiken.',
          '7': 'Eine tiefe spirituelle und emotionale Verbindung mit Ihrem Partner. Das Gefühl, dass Sie sich ohne Worte verstehen.',
          '8': 'Starke Intuition und Träume. Eine tiefe Verschmelzung mit Ihrem Partner auf emotionaler und intimer Ebene. Vertrauen Sie Ihren Vorahnungen.',
          '9': 'Träume von fernen Ländern. Interesse an spirituellen Praktiken, Religion und Philosophie. Inspiration kommt von weit her.',
          '10': 'Ihre Intuition hilft Ihnen in Ihrer Karriere. Sie können einen sehr günstigen, spirituellen Eindruck auf die Öffentlichkeit oder Vorgesetzte machen.',
          '11': 'Ein seelenvolles Treffen mit Freunden. Sie können zu einer Inspirationsquelle für andere werden. Träume finden leicht Unterstützung.',
          '12': 'Ein tiefer Tauchgang in Ihre innere Welt. Meditation, Musik und Einsamkeit in der Natur werden Frieden und Einsichten bringen.'
        }
      }
    ),
    AspectInterpretation(
      id: 'MERCURY_SEXTILE_JUPITER',
      title: {
        'ru': 'Шанс от Меркурия и Юпитера',
        'en': 'Mercury Sextile Jupiter',
        'fr': 'Mercure Sextile Jupiter',
        'de': 'Merkur-Sextil-Jupiter'
      },
      descriptionGeneral: {
        'ru': 'День оптимизма и хороших новостей! Мышление позитивное и широкое. Отличные возможности для обучения, переговоров, планирования поездок и заключения сделок.',
        'en': 'A day of optimism and good news! Thinking is positive and broad. Excellent opportunities for learning, negotiations, planning trips, and making deals.',
        'fr': 'Une journée d\'optimisme et de bonnes nouvelles ! La pensée est positive et large. Excellentes opportunités pour l\'apprentissage, les négociations, la planification de voyages et la conclusion d\'accords.',
        'de': 'Ein Tag des Optimismus und guter Nachrichten! Das Denken ist positiv und weitreichend. Ausgezeichnete Möglichkeiten zum Lernen, für Verhandlungen, zur Reiseplanung und zum Abschluss von Geschäften.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Вы полны оптимизма и красноречивы. Легко произвести впечатление эрудированного и позитивного человека. Хороший день для выступлений.',
          '2': 'Появляются хорошие идеи, как увеличить доход. Успешные переговоры о деньгах, возможность заключить выгодную сделку.',
          '3': 'Очень благоприятный день для общения, учебы, письма и коротких поездок. Легко договориться и получить нужную информацию.',
          '4': 'Позитивные разговоры с семьей. Хорошая возможность обсудить планы по расширению жилья или семейному путешествию.',
          '5': 'Остроумный и оптимистичный флирт. Легко найти общий язык с объектом симпатии. Хорошие новости, связанные с детьми или творчеством.',
          '6': 'Отличные возможности на работе. Легко решаются сложные задачи, удается договориться с коллегами и начальством.',
          '7': 'Открытый и честный диалог с партнером. Хороший день для обсуждения совместных планов, заключения брака или других договоренностей.',
          '8': 'Возможность получить хорошую новость о кредите, налогах или наследстве. Разговоры на глубокие темы приносят оптимизм.',
          '9': 'Идеально для планирования путешествий, начала обучения или общения с иностранцами. Ваши идеи получают широкий отклик.',
          '10': 'Успешный разговор с начальством, который может привести к повышению или новым возможностям в карьере.',
          '11': 'Приятное и познавательное общение с друзьями. Хорошая возможность поделиться своими идеями и получить поддержку.',
          '12': 'Оптимистичные мысли приходят через уединение и размышления. Понимание чего-то важного о себе может принести радость.'
        },
        'en': {
          '1': 'You are full of optimism and eloquence. It\'s easy to make an impression as a knowledgeable and positive person. A good day for public speaking.',
          '2': 'Good ideas on how to increase your income emerge. Successful money negotiations, an opportunity to make a profitable deal.',
          '3': 'A very favorable day for communication, study, writing, and short trips. It\'s easy to reach an agreement and get the needed information.',
          '4': 'Positive conversations with family. A good opportunity to discuss plans for home expansion or a family trip.',
          '5': 'Witty and optimistic flirting. It\'s easy to find common ground with your crush. Good news related to children or creativity.',
          '6': 'Excellent opportunities at work. Complex tasks are easily solved, and it\'s easy to agree with colleagues and superiors.',
          '7': 'An open and honest dialogue with your partner. A good day to discuss joint plans, get married, or make other agreements.',
          '8': 'An opportunity to get good news about a loan, taxes, or inheritance. Conversations on deep topics bring optimism.',
          '9': 'Ideal for planning travel, starting studies, or communicating with foreigners. Your ideas receive a wide response.',
          '10': 'A successful conversation with your boss that could lead to a promotion or new career opportunities.',
          '11': 'Pleasant and informative communication with friends. A good opportunity to share your ideas and get support.',
          '12': 'Optimistic thoughts come through solitude and reflection. Understanding something important about yourself can bring joy.'
        },
        'fr': {
          '1': 'Vous êtes plein d\'optimisme et d\'éloquence. Il est facile de donner l\'impression d\'être une personne savante et positive. Une bonne journée pour parler en public.',
          '2': 'De bonnes idées pour augmenter vos revenus émergent. Négociations financières réussies, une opportunité de conclure un accord rentable.',
          '3': 'Une journée très favorable à la communication, aux études, à l\'écriture et aux courts voyages. Il est facile de parvenir à un accord et d\'obtenir les informations nécessaires.',
          '4': 'Conversations positives en famille. Une bonne occasion de discuter des plans d\'agrandissement de la maison ou d\'un voyage en famille.',
          '5': 'Flirt spirituel et optimiste. Il est facile de trouver un terrain d\'entente avec l\'objet de votre affection. Bonne nouvelle concernant les enfants ou la créativité.',
          '6': 'Excellentes opportunités au travail. Les tâches complexes sont facilement résolues, et il est facile de s\'entendre avec les collègues et les supérieurs.',
          '7': 'Un dialogue ouvert et honnête avec votre partenaire. Une bonne journée pour discuter de projets communs, se marier ou conclure d\'autres accords.',
          '8': 'Une opportunité d\'avoir de bonnes nouvelles concernant un prêt, des impôts ou un héritage. Les conversations sur des sujets profonds apportent de l\'optimisme.',
          '9': 'Idéal pour planifier des voyages, commencer des études ou communiquer avec des étrangers. Vos idées reçoivent un large écho.',
          '10': 'Une conversation réussie avec votre patron qui pourrait mener à une promotion ou à de nouvelles opportunités de carrière.',
          '11': 'Communication agréable et instructive avec des amis. Une bonne occasion de partager vos idées et d\'obtenir du soutien.',
          '12': 'Les pensées optimistes viennent par la solitude et la réflexion. Comprendre quelque chose d\'important sur vous-même peut apporter de la joie.'
        },
        'de': {
          '1': 'Sie sind voller Optimismus und Eloquenz. Es ist leicht, den Eindruck einer sachkundigen und positiven Person zu hinterlassen. Ein guter Tag für öffentliche Reden.',
          '2': 'Gute Ideen zur Einkommenssteigerung tauchen auf. Erfolgreiche Geldverhandlungen, eine Gelegenheit für ein profitables Geschäft.',
          '3': 'Ein sehr günstiger Tag für Kommunikation, Studium, Schreiben und kurze Reisen. Es ist leicht, eine Einigung zu erzielen und die benötigten Informationen zu erhalten.',
          '4': 'Positive Gespräche mit der Familie. Eine gute Gelegenheit, Pläne für eine Hauserweiterung oder eine Familienreise zu besprechen.',
          '5': 'Witziges und optimistisches Flirten. Es ist leicht, eine gemeinsame Basis mit Ihrem Schwarm zu finden. Gute Nachrichten in Bezug auf Kinder oder Kreativität.',
          '6': 'Ausgezeichnete Möglichkeiten bei der Arbeit. Komplexe Aufgaben werden leicht gelöst, und es ist einfach, sich mit Kollegen und Vorgesetzten zu einigen.',
          '7': 'Ein offener und ehrlicher Dialog mit Ihrem Partner. Ein guter Tag, um gemeinsame Pläne zu besprechen, zu heiraten oder andere Vereinbarungen zu treffen.',
          '8': 'Eine Gelegenheit, gute Nachrichten über einen Kredit, Steuern oder eine Erbschaft zu erhalten. Gespräche über tiefe Themen bringen Optimismus.',
          '9': 'Ideal für die Planung von Reisen, den Beginn eines Studiums oder die Kommunikation mit Ausländern. Ihre Ideen finden breite Resonanz.',
          '10': 'Ein erfolgreiches Gespräch mit Ihrem Chef, das zu einer Beförderung oder neuen Karrieremöglichkeiten führen könnte.',
          '11': 'Angenehme und informative Kommunikation mit Freunden. Eine gute Gelegenheit, Ihre Ideen zu teilen und Unterstützung zu erhalten.',
          '12': 'Optimistische Gedanken kommen durch Einsamkeit und Nachdenken. Etwas Wichtiges über sich selbst zu verstehen, kann Freude bereiten.'
        }
      }
    ),
        // === НОВЫЙ БЛОК 2 ===
    AspectInterpretation(
      id: 'MARS_SQUARE_URANUS',
      title: {
        'ru': 'Конфликт Марса и Урана',
        'en': 'Mars Square Uranus',
        'fr': 'Mars Carré Uranus',
        'de': 'Mars-Quadrat-Uranus'
      },
      descriptionGeneral: {
        'ru': 'Очень взрывной и непредсказуемый день. Энергия (Марс) сталкивается с бунтарством (Уран). Высокий риск ссор "на ровном месте", несчастных случаев и импульсивных поступков. Желание свободы любой ценой.',
        'en': 'A very explosive and unpredictable day. Energy (Mars) clashes with rebellion (Uranus). High risk of quarrels "out of the blue," accidents, and impulsive actions. A desire for freedom at any cost.',
        'fr': 'Une journée très explosive et imprévisible. L\'énergie (Mars) se heurte à la rébellion (Uranus). Risque élevé de querelles "à l\'improviste", d\'accidents et d\'actes impulsifs. Un désir de liberté à tout prix.',
        'de': 'Ein sehr explosiver und unvorhersehbarer Tag. Energie (Mars) kollidiert mit Rebellion (Uranus). Hohes Risiko für Streit "aus heiterem Himmel", Unfälle und impulsive Handlungen. Ein Wunsch nach Freiheit um jeden Preis.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Действия опережают мысль. Вы склонны к риску, бунтарству и можете шокировать окружающих. Осторожно, высокий травматизм.',
          '2': 'Рискованные финансовые решения. Желание потратить деньги на что-то необычное. Возможны внезапные поломки техники или непредвиденные расходы.',
          '3': 'Резкие и провокационные высказывания. Ссоры с окружением "на ровном месте". Будьте очень осторожны за рулем и с техникой.',
          '4': 'Внезапные конфликты в семье. Желание "сбежать" из дома или все кардинально поменять. Возможны поломки электроприборов.',
          '5': 'Импульсивные романтические увлечения или резкий разрыв. Внезапные ссоры с любимым человеком. Тяга к рискованным развлечениям.',
          '6': 'Конфликты на работе, желание все бросить. Возможны сбои в работе техники, которые нарушают все планы. Берегите здоровье.',
          '7': 'Внезапные ссоры с партнером, угроза разрыва. Партнер может вести себя непредсказуемо и провокационно. Не время для выяснения отношений.',
          '8': 'Высокая, но нестабильная сексуальная энергия. Возможны рискованные финансовые операции, которые могут привести к потерям. Опасность кризисных ситуаций.',
          '9': 'Резкая смена планов на путешествие. Конфликты на почве убеждений. Желание бросить учебу или поспорить с преподавателем.',
          '10': 'Конфликт с начальством, угроза увольнения. Ваши импульсивные действия могут навредить вашей репутации.',
          '11': 'Ссоры с друзьями. Вы можете резко выйти из группы или сообщества. Планы на будущее рушатся.',
          '12': 'Внезапные вспышки гнева, источник которого неясен. Подсознательное беспокойство может выливаться в странные, импульсивные поступки.'
        },
        'en': {
          '1': 'Actions precede thought. You are prone to risk, rebellion, and may shock others. Be careful, high risk of injury.',
          '2': 'Risky financial decisions. A desire to spend money on something unusual. Sudden equipment breakdowns or unforeseen expenses are possible.',
          '3': 'Harsh and provocative statements. Quarrels with your circle "out of the blue." Be very careful while driving and with technology.',
          '4': 'Sudden conflicts in the family. A desire to "run away" from home or change everything drastically. Breakdowns of electrical appliances are possible.',
          '5': 'Impulsive romantic interests or a sudden breakup. Sudden quarrels with a loved one. A craving for risky entertainment.',
          '6': 'Conflicts at work, a desire to quit everything. Equipment failures that disrupt all plans are possible. Take care of your health.',
          '7': 'Sudden quarrels with a partner, threat of a breakup. The partner may behave unpredictably and provocatively. Not the time to sort things out.',
          '8': 'High but unstable sexual energy. Risky financial operations that can lead to losses are possible. Danger of crisis situations.',
          '9': 'A sharp change in travel plans. Conflicts based on beliefs. A desire to drop out of studies or argue with a teacher.',
          '10': 'Conflict with a boss, threat of dismissal. Your impulsive actions could harm your reputation.',
          '11': 'Quarrels with friends. You might abruptly leave a group or community. Future plans are collapsing.',
          '12': 'Sudden outbursts of anger with an unclear source. Subconscious anxiety can result in strange, impulsive actions.'
        },
        'fr': {
          '1': 'Les actions précèdent la pensée. Vous êtes enclin au risque, à la rébellion et pourriez choquer les autres. Attention, risque élevé de blessure.',
          '2': 'Décisions financières risquées. Un désir de dépenser de l\'argent pour quelque chose d\'inhabituel. Des pannes d\'équipement soudaines ou des dépenses imprévues sont possibles.',
          '3': 'Déclarations dures et provocatrices. Querelles avec votre entourage "à l\'improviste". Soyez très prudent en conduisant et avec la technologie.',
          '4': 'Conflits soudains dans la famille. Un désir de "fuir" la maison ou de tout changer radicalement. Des pannes d\'appareils électriques sont possibles.',
          '5': 'Engouements romantiques impulsifs ou rupture soudaine. Querelles soudaines avec un être cher. Une envie de divertissements risqués.',
          '6': 'Conflits au travail, un désir de tout quitter. Des pannes d\'équipement qui perturbent tous les plans sont possibles. Prenez soin de votre santé.',
          '7': 'Querelles soudaines avec un partenaire, menace de rupture. Le partenaire peut se comporter de manière imprévisible et provocatrice. Ce n\'est pas le moment de régler les comptes.',
          '8': 'Énergie sexuelle élevée mais instable. Des opérations financières risquées pouvant entraîner des pertes sont possibles. Danger de situations de crise.',
          '9': 'Un changement brusque dans les plans de voyage. Conflits basés sur les croyances. Un désir d\'abandonner les études ou de se disputer avec un professeur.',
          '10': 'Conflit avec un patron, menace de licenciement. Vos actions impulsives pourraient nuire à votre réputation.',
          '11': 'Querelles avec des amis. Vous pourriez quitter brusquement un groupe ou une communauté. Les projets futurs s\'effondrent.',
          '12': 'Accès de colère soudains dont la source n\'est pas claire. L\'anxiété subconsciente peut se traduire par des actions étranges et impulsives.'
        },
        'de': {
          '1': 'Handlungen gehen dem Denken voraus. Sie neigen zu Risiko, Rebellion und könnten andere schockieren. Seien Sie vorsichtig, hohes Verletzungsrisiko.',
          '2': 'Riskante finanzielle Entscheidungen. Der Wunsch, Geld für etwas Ungewöhnliches auszugeben. Plötzliche Geräteausfälle oder unvorhergesehene Ausgaben sind möglich.',
          '3': 'Harte und provokante Aussagen. Streit mit Ihrem Umfeld "aus heiterem Himmel". Seien Sie sehr vorsichtig beim Fahren und mit Technik.',
          '4': 'Plötzliche Konflikte in der Familie. Der Wunsch, von zu Hause "wegzulaufen" oder alles drastisch zu ändern. Ausfälle von Elektrogeräten sind möglich.',
          '5': 'Impulsive romantische Interessen oder eine plötzliche Trennung. Plötzlicher Streit mit einem geliebten Menschen. Ein Verlangen nach riskanter Unterhaltung.',
          '6': 'Konflikte bei der Arbeit, der Wunsch, alles hinzuschmeißen. Geräteausfälle, die alle Pläne durchkreuzen, sind möglich. Achten Sie auf Ihre Gesundheit.',
          '7': 'Plötzlicher Streit mit einem Partner, drohende Trennung. Der Partner kann sich unvorhersehbar und provokativ verhalten. Keine Zeit für Klärungsgespräche.',
          '8': 'Hohe, aber instabile sexuelle Energie. Riskante Finanzoperationen, die zu Verlusten führen können, sind möglich. Gefahr von Krisensituationen.',
          '9': 'Eine abrupte Änderung der Reisepläne. Konflikte aufgrund von Überzeugungen. Der Wunsch, das Studium abzubrechen oder mit einem Lehrer zu streiten.',
          '10': 'Konflikt mit einem Chef, drohende Entlassung. Ihre impulsiven Handlungen könnten Ihrem Ruf schaden.',
          '11': 'Streit mit Freunden. Sie könnten abrupt eine Gruppe oder Gemeinschaft verlassen. Zukunftspläne brechen zusammen.',
          '12': 'Plötzliche Wutausbrüche mit unklarer Quelle. Unterbewusste Angst kann sich in seltsamen, impulsiven Handlungen äußern.'
        }
      }
    ),
    AspectInterpretation(
      id: 'MERCURY_SQUARE_NEPTUNE',
      title: {
        'ru': 'Конфликт Меркурия и Нептуна',
        'en': 'Mercury Square Neptune',
        'fr': 'Mercure Carré Neptune',
        'de': 'Merkur-Quadrat-Neptun'
      },
      descriptionGeneral: {
        'ru': 'День "тумана в голове". Мышление путаное, сложно сконцентрироваться. Высока вероятность недопониманий, обмана, ошибок по невнимательности и самообмана. Проверяйте всю информацию.',
        'en': 'A "brain fog" day. Thinking is confused, it\'s difficult to concentrate. High probability of misunderstandings, deception, careless mistakes, and self-deception. Double-check all information.',
        'fr': 'Une journée de "brouillard cérébral". La pensée est confuse, il est difficile de se concentrer. Forte probabilité de malentendus, de tromperie, d\'erreurs d\'inattention et d\'auto-illusion. Vérifiez toutes les informations.',
        'de': 'Ein "Gehirnnebel"-Tag. Das Denken ist verwirrt, es ist schwierig, sich zu konzentrieren. Hohe Wahrscheinlichkeit von Missverständnissen, Täuschung, Flüchtigkeitsfehlern und Selbsttäuschung. Überprüfen Sie alle Informationen.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Сложно понять себя и ясно выразить свои мысли. Вы можете казаться рассеянным или ненадежным. Не лучшее время для принятия важных решений.',
          '2': 'Риск финансовых потерь из-за обмана или невнимательности. Не стоит совершать покупки, особенно онлайн. Возможна путаница со счетами.',
          '3': 'Недопонимания в общении. Информация искажается, доходят слухи и сплетни. Можно забыть о важной встрече или перепутать детали.',
          '4': 'Обман или недомолвки в семье. Сложно договориться с домочадцами. Возможны проблемы с документами на недвижимость.',
          '5': 'Идеализация партнера или самообман в любви. Вы можете видеть то, чего нет. Не верьте красивым словам, смотрите на поступки.',
          '6': 'Ошибки в работе из-за невнимательности. Сложно сосредоточиться на рутинных задачах. Не стоит подписывать важные документы.',
          '7': 'Обман или недопонимание со стороны партнера. Он может быть неискренним или вы сами его идеализируете. Диалог не клеится.',
          '8': 'Риск быть обманутым в финансовых вопросах (кредиты, налоги). Тайны и интриги могут запутать отношения.',
          '9': 'Идеи и планы на будущее слишком расплывчаты и нереалистичны. Возможен обман в поездке или проблемы с визой/билетами.',
          '10': 'Путаница в карьерных целях. Начальство может дать нечеткие указания. Риск интриг, которые могут повредить репутации.',
          '11': 'Разочарование в друзьях. Кто-то из них может быть неискренним. Мечты и надежды кажутся несбыточными.',
          '12': 'Ваши страхи и иллюзии мешают мыслить ясно. Легко уйти в мир фантазий и оторваться от реальности. Не доверяйте своей интуиции сегодня.'
        },
        'en': {
          '1': 'It\'s hard to understand yourself and express your thoughts clearly. You may seem absent-minded or unreliable. Not the best time to make important decisions.',
          '2': 'Risk of financial loss due to deception or carelessness. Avoid shopping, especially online. Confusion with bills is possible.',
          '3': 'Misunderstandings in communication. Information is distorted, rumors and gossip spread. You might forget an important meeting or mix up details.',
          '4': 'Deception or omissions in the family. It\'s difficult to agree with household members. Problems with real estate documents are possible.',
          '5': 'Idealizing a partner or self-deception in love. You may see what isn\'t there. Don\'t believe beautiful words, look at actions.',
          '6': 'Mistakes at work due to inattention. It\'s hard to focus on routine tasks. Do not sign important documents.',
          '7': 'Deception or misunderstanding from a partner. They may be insincere, or you are idealizing them. Dialogue is not working out.',
          '8': 'Risk of being deceived in financial matters (loans, taxes). Secrets and intrigues can complicate relationships.',
          '9': 'Ideas and plans for the future are too vague and unrealistic. Deception during a trip or problems with visas/tickets are possible.',
          '10': 'Confusion in career goals. Superiors may give unclear instructions. Risk of intrigues that could damage your reputation.',
          '11': 'Disappointment in friends. One of them may be insincere. Dreams and hopes seem unattainable.',
          '12': 'Your fears and illusions prevent clear thinking. It\'s easy to escape into a fantasy world and lose touch with reality. Don\'t trust your intuition today.'
        },
        'fr': {
          '1': 'Difficile de se comprendre et d\'exprimer clairement ses pensées. Vous pouvez paraître distrait ou peu fiable. Ce n\'est pas le meilleur moment pour prendre des décisions importantes.',
          '2': 'Risque de perte financière due à la tromperie ou à la négligence. Évitez les achats, surtout en ligne. Une confusion avec les factures est possible.',
          '3': 'Malentendus dans la communication. L\'information est déformée, les rumeurs et les ragots se répandent. Vous pourriez oublier une réunion importante ou confondre les détails.',
          '4': 'Tromperie ou omissions dans la famille. Il est difficile de s\'entendre avec les membres du ménage. Des problèmes avec les documents immobiliers sont possibles.',
          '5': 'Idéalisation d\'un partenaire ou auto-illusion en amour. Vous pouvez voir ce qui n\'est pas là. Ne croyez pas les belles paroles, regardez les actions.',
          '6': 'Erreurs au travail dues à l\'inattention. Difficile de se concentrer sur les tâches routinières. Ne signez pas de documents importants.',
          '7': 'Tromperie ou malentendu de la part d\'un partenaire. Il peut être sincère, ou vous l\'idéalisez. Le dialogue ne fonctionne pas.',
          '8': 'Risque d\'être trompé dans les affaires financières (prêts, impôts). Les secrets et les intrigues peuvent compliquer les relations.',
          '9': 'Les idées et les plans pour l\'avenir sont trop vagues et irréalistes. Une tromperie lors d\'un voyage ou des problèmes de visa/billets sont possibles.',
          '10': 'Confusion dans les objectifs de carrière. Les supérieurs peuvent donner des instructions peu claires. Risque d\'intrigues qui pourraient nuire à votre réputation.',
          '11': 'Déception envers des amis. L\'un d\'eux peut ne pas être sincère. Les rêves et les espoirs semblent inaccessibles.',
          '12': 'Vos peurs et illusions empêchent de penser clairement. Il est facile de s\'échapper dans un monde imaginaire et de perdre le contact avec la réalité. Ne faites pas confiance à votre intuition aujourd\'hui.'
        },
        'de': {
          '1': 'Es ist schwer, sich selbst zu verstehen und seine Gedanken klar auszudrücken. Sie wirken möglicherweise zerstreut oder unzuverlässig. Keine gute Zeit, um wichtige Entscheidungen zu treffen.',
          '2': 'Risiko finanzieller Verluste durch Täuschung oder Unachtsamkeit. Vermeiden Sie Einkäufe, insbesondere online. Verwirrung bei Rechnungen ist möglich.',
          '3': 'Missverständnisse in der Kommunikation. Informationen werden verzerrt, Gerüchte und Klatsch verbreiten sich. Sie könnten ein wichtiges Treffen vergessen oder Details verwechseln.',
          '4': 'Täuschung oder Auslassungen in der Familie. Es ist schwierig, sich mit Haushaltsmitgliedern zu einigen. Probleme mit Immobiliendokumenten sind möglich.',
          '5': 'Idealisierung eines Partners oder Selbsttäuschung in der Liebe. Sie sehen vielleicht, was nicht da ist. Glauben Sie nicht schönen Worten, schauen Sie auf Taten.',
          '6': 'Fehler bei der Arbeit aufgrund von Unaufmerksamkeit. Es ist schwer, sich auf Routineaufgaben zu konzentrieren. Unterzeichnen Sie keine wichtigen Dokumente.',
          '7': 'Täuschung oder Missverständnis seitens eines Partners. Er könnte unaufrichtig sein, oder Sie idealisieren ihn. Der Dialog kommt nicht zustande.',
          '8': 'Risiko, in Finanzangelegenheiten (Kredite, Steuern) betrogen zu werden. Geheimnisse und Intrigen können Beziehungen verkomplizieren.',
          '9': 'Ideen und Pläne für die Zukunft sind zu vage und unrealistisch. Täuschung während einer Reise oder Probleme mit Visa/Tickets sind möglich.',
          '10': 'Verwirrung bei den Karrierezielen. Vorgesetzte geben möglicherweise unklare Anweisungen. Risiko von Intrigen, die Ihrem Ruf schaden könnten.',
          '11': 'Enttäuschung von Freunden. Einer von ihnen könnte unaufrichtig sein. Träume und Hoffnungen scheinen unerreichbar.',
          '12': 'Ihre Ängste und Illusionen verhindern klares Denken. Es ist leicht, in eine Fantasiewelt zu fliehen und den Bezug zur Realität zu verlieren. Vertrauen Sie heute nicht Ihrer Intuition.'
        }
      }
    ),
    AspectInterpretation(
      id: 'SUN_TRINE_JUPITER',
      title: {
        'ru': 'Гармония Солнца и Юпитера',
        'en': 'Sun Trine Jupiter',
        'fr': 'Soleil Trigone Jupiter',
        'de': 'Sonne-Trigon-Jupiter'
      },
      descriptionGeneral: {
        'ru': 'День удачи, оптимизма и щедрости! Все получается легко и без усилий. Отличное время для начинаний, важных встреч, путешествий и получения признания. Верьте в себя!',
        'en': 'A day of luck, optimism, and generosity! Everything comes easily and effortlessly. An excellent time for beginnings, important meetings, travel, and receiving recognition. Believe in yourself!',
        'fr': 'Une journée de chance, d\'optimisme et de générosité ! Tout vient facilement et sans effort. Un excellent moment pour les débuts, les réunions importantes, les voyages et pour recevoir de la reconnaissance. Croyez en vous !',
        'de': 'Ein Tag des Glücks, Optimismus und der Großzügigkeit! Alles gelingt leicht und mühelos. Eine ausgezeichnete Zeit für Anfänge, wichtige Treffen, Reisen und um Anerkennung zu erhalten. Glauben Sie an sich!'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Вы полны уверенности и оптимизма. Люди тянутся к вам. Отличный день для самопрезентации и начала любых личных проектов.',
          '2': 'Финансовая удача! Возможны премии, подарки, неожиданные поступления. Благоприятное время для крупных покупок и инвестиций.',
          '3': 'Успех в переговорах и обучении. Ваши идеи находят поддержку. Хорошие новости, удачные поездки.',
          '4': 'Счастье и гармония в доме. Отличный день для семейных торжеств, покупки недвижимости или начала ремонта.',
          '5': 'Удача в любви и творчестве! Яркое романтическое свидание, выигрыш в лотерею. Время для радости и развлечений.',
          '6': 'Успех на работе. Легко справляетесь с обязанностями, получаете похвалу от начальства. Улучшение здоровья.',
          '7': 'Гармония и взаимопонимание с партнером. Благоприятно для заключения брака, подписания контрактов и публичных выступлений.',
          '8': 'Финансовая удача через партнера, получение наследства, одобрение кредита. Глубокое взаимопонимание в интимной сфере.',
          '9': 'Идеальный день для начала путешествия, поступления в вуз, публикации научных работ. Расширение кругозора.',
          '10': 'Триумф в карьере! Признание заслуг, повышение, удача в достижении самых амбициозных целей.',
          '11': 'Исполнение желаний. Друзья помогают в реализации ваших планов. Успех в коллективной деятельности.',
          '12': 'Ощущение внутренней гармонии и защиты высших сил. Интуиция подсказывает верные решения. Удача приходит неожиданно.'
        },
        'en': {
          '1': 'You are full of confidence and optimism. People are drawn to you. An excellent day for self-presentation and starting any personal projects.',
          '2': 'Financial luck! Bonuses, gifts, unexpected income are possible. A favorable time for large purchases and investments.',
          '3': 'Success in negotiations and learning. Your ideas find support. Good news, successful trips.',
          '4': 'Happiness and harmony at home. An excellent day for family celebrations, buying real estate, or starting renovations.',
          '5': 'Luck in love and creativity! a memorable romantic date, winning the lottery. A time for joy and entertainment.',
          '6': 'Success at work. You easily handle your duties, receive praise from superiors. Health improvement.',
          '7': 'Harmony and mutual understanding with your partner. Favorable for marriage, signing contracts, and public speaking.',
          '8': 'Financial luck through a partner, receiving an inheritance, loan approval. Deep understanding in the intimate sphere.',
          '9': 'An ideal day to start a trip, enter a university, publish scientific papers. Broadening your horizons.',
          '10': 'Triumph in your career! Recognition of merits, promotion, luck in achieving the most ambitious goals.',
          '11': 'Fulfillment of wishes. Friends help in realizing your plans. Success in collective activities.',
          '12': 'A feeling of inner harmony and protection from higher powers. Intuition suggests the right decisions. Luck comes unexpectedly.'
        },
        'fr': {
          '1': 'Vous êtes plein de confiance et d\'optimisme. Les gens sont attirés par vous. Une excellente journée pour la présentation de soi et le démarrage de projets personnels.',
          '2': 'Chance financière ! Primes, cadeaux, revenus inattendus sont possibles. Un moment favorable pour les gros achats et les investissements.',
          '3': 'Succès dans les négociations et l\'apprentissage. Vos idées trouvent un soutien. Bonnes nouvelles, voyages réussis.',
          '4': 'Bonheur et harmonie à la maison. Une excellente journée pour les célébrations familiales, l\'achat d\'un bien immobilier ou le début de rénovations.',
          '5': 'Chance en amour et en créativité ! Un rendez-vous romantique mémorable, un gain à la loterie. Un temps pour la joie et le divertissement.',
          '6': 'Succès au travail. Vous gérez facilement vos tâches, recevez des éloges de vos supérieurs. Amélioration de la santé.',
          '7': 'Harmonie et compréhension mutuelle avec votre partenaire. Favorable pour le mariage, la signature de contrats et les discours publics.',
          '8': 'Chance financière par l\'intermédiaire d\'un partenaire, réception d\'un héritage, approbation d\'un prêt. Profonde compréhension dans la sphère intime.',
          '9': 'Une journée idéale pour commencer un voyage, entrer à l\'université, publier des travaux scientifiques. Élargir ses horizons.',
          '10': 'Triomphe dans votre carrière ! Reconnaissance des mérites, promotion, chance dans la réalisation des objectifs les plus ambitieux.',
          '11': 'Réalisation des souhaits. Les amis aident à la réalisation de vos plans. Succès dans les activités collectives.',
          '12': 'Un sentiment d\'harmonie intérieure et de protection des puissances supérieures. L\'intuition suggère les bonnes décisions. La chance arrive de manière inattendue.'
        },
        'de': {
          '1': 'Sie sind voller Selbstvertrauen und Optimismus. Die Menschen fühlen sich zu Ihnen hingezogen. Ein ausgezeichneter Tag für Selbstdarstellung und den Beginn persönlicher Projekte.',
          '2': 'Finanzielles Glück! Boni, Geschenke, unerwartete Einnahmen sind möglich. Eine günstige Zeit für große Anschaffungen und Investitionen.',
          '3': 'Erfolg bei Verhandlungen und beim Lernen. Ihre Ideen finden Unterstützung. Gute Nachrichten, erfolgreiche Reisen.',
          '4': 'Glück und Harmonie zu Hause. Ein ausgezeichneter Tag für Familienfeiern, den Kauf von Immobilien oder den Beginn von Renovierungsarbeiten.',
          '5': 'Glück in der Liebe und Kreativität! Ein unvergessliches romantisches Date, ein Lottogewinn. Eine Zeit der Freude und Unterhaltung.',
          '6': 'Erfolg bei der Arbeit. Sie erledigen Ihre Aufgaben mühelos und erhalten Lob von Vorgesetzten. Verbesserung der Gesundheit.',
          '7': 'Harmonie und gegenseitiges Verständnis mit Ihrem Partner. Günstig für Heirat, Vertragsunterzeichnungen und öffentliche Reden.',
          '8': 'Finanzielles Glück durch einen Partner, Erbschaft, Kreditgenehmigung. Tiefes Verständnis im intimen Bereich.',
          '9': 'Ein idealer Tag, um eine Reise zu beginnen, eine Universität zu besuchen, wissenschaftliche Arbeiten zu veröffentlichen. Erweiterung des Horizonts.',
          '10': 'Triumph in Ihrer Karriere! Anerkennung von Verdiensten, Beförderung, Glück beim Erreichen der ehrgeizigsten Ziele.',
          '11': 'Erfüllung von Wünschen. Freunde helfen bei der Verwirklichung Ihrer Pläne. Erfolg bei kollektiven Aktivitäten.',
          '12': 'Ein Gefühl innerer Harmonie und des Schutzes durch höhere Mächte. Die Intuition schlägt die richtigen Entscheidungen vor. Das Glück kommt unerwartet.'
        }
      }
    ),
    AspectInterpretation(
      id: 'VENUS_SEXTILE_MARS',
      title: {
        'ru': 'Шанс от Венеры и Марса',
        'en': 'Venus Sextile Mars',
        'fr': 'Vénus Sextile Mars',
        'de': 'Venus-Sextil-Mars'
      },
      descriptionGeneral: {
        'ru': 'День флирта, страсти и гармоничной энергии. Любовь (Венера) и действие (Марс) работают в унисон. Отличное время для свиданий, проявления инициативы в отношениях и творческой деятельности.',
        'en': 'A day of flirtation, passion, and harmonious energy. Love (Venus) and action (Mars) work in unison. An excellent time for dates, taking initiative in relationships, and creative activities.',
        'fr': 'Une journée de flirt, de passion et d\'énergie harmonieuse. L\'amour (Vénus) et l\'action (Mars) travaillent à l\'unisson. Un excellent moment pour les rendez-vous, prendre des initiatives dans les relations et les activités créatives.',
        'de': 'Ein Tag des Flirts, der Leidenschaft und harmonischer Energie. Liebe (Venus) und Aktion (Mars) arbeiten im Einklang. Eine ausgezeichnete Zeit für Verabredungen, die Initiative in Beziehungen zu ergreifen und für kreative Aktivitäten.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Ваша привлекательность и уверенность в себе на высоте. Легко проявить инициативу и произвести нужное впечатление.',
          '2': 'Хорошая возможность заработать на своем творчестве или хобби. Активные действия приносят финансовый результат.',
          '3': 'Смелый и успешный флирт. Легко завязать разговор и выразить свою симпатию. Короткая поездка может оказаться романтичной.',
          '4': 'Активная деятельность по украшению дома. Хороший день для того, чтобы вместе с партнером заняться домашними делами.',
          '5': 'Идеальный аспект для свиданий и романтики! Сильное взаимное притяжение, страсть и гармония. Легко сделать первый шаг.',
          '6': 'Приятная и продуктивная атмосфера на работе. Возможен легкий флирт с коллегой, который поднимает настроение.',
          '7': 'Отличный баланс между вашими желаниями и желаниями партнера. Хорошая возможность для совместной активной деятельности (спорт, танец).',
          '8': 'Усиление сексуальной гармонии и притяжения. Откровенный разговор на интимные темы проходит легко и сближает.',
          '9': 'Возможность романтического знакомства в путешествии или через интернет. Общие интересы и страсть к приключениям.',
          '10': 'Ваше обаяние и энергия помогают достичь карьерных целей. Успех в проектах, связанных с искусством, модой, развлечениями.',
          '11': 'Вечеринка с друзьями может стать местом для романтического знакомства. Легко найти единомышленников для творческих проектов.',
          '12': 'Тайное романтическое приключение. Ваша интуиция подсказывает, как и когда действовать в любви.'
        },
        'en': {
          '1': 'Your attractiveness and self-confidence are at their peak. It\'s easy to take the initiative and make the right impression.',
          '2': 'A good opportunity to earn from your creativity or hobby. Active efforts bring financial results.',
          '3': 'Bold and successful flirting. It\'s easy to start a conversation and express your affection. A short trip could turn out to be romantic.',
          '4': 'Active efforts to decorate the home. A good day to do household chores together with your partner.',
          '5': 'The perfect aspect for dates and romance! Strong mutual attraction, passion, and harmony. It\'s easy to make the first move.',
          '6': 'A pleasant and productive atmosphere at work. A light flirtation with a colleague might lift your spirits.',
          '7': 'An excellent balance between your desires and your partner\'s. A good opportunity for joint active pursuits (sports, dancing).',
          '8': 'Enhancement of sexual harmony and attraction. An open conversation about intimate topics goes smoothly and brings you closer.',
          '9': 'A chance for a romantic encounter while traveling or online. Shared interests and a passion for adventure.',
          '10': 'Your charm and energy help you achieve your career goals. Success in projects related to art, fashion, and entertainment.',
          '11': 'A party with friends could be the place for a romantic meeting. It\'s easy to find like-minded people for creative projects.',
          '12': 'A secret romantic adventure. Your intuition tells you how and when to act in love.'
        },
        'fr': {
          '1': 'Votre attrait et votre confiance en vous sont à leur apogée. Il est facile de prendre l\'initiative et de faire la bonne impression.',
          '2': 'Une bonne opportunité de gagner de l\'argent grâce à votre créativité ou votre passe-temps. Les efforts actifs apportent des résultats financiers.',
          '3': 'Flirt audacieux et réussi. Il est facile d\'entamer une conversation et d\'exprimer votre affection. Un court voyage pourrait s\'avérer romantique.',
          '4': 'Efforts actifs pour décorer la maison. Une bonne journée pour faire les tâches ménagères avec votre partenaire.',
          '5': 'L\'aspect parfait pour les rendez-vous et la romance ! Forte attraction mutuelle, passion et harmonie. Il est facile de faire le premier pas.',
          '6': 'Une atmosphère agréable et productive au travail. Un léger flirt avec un collègue pourrait vous remonter le moral.',
          '7': 'Un excellent équilibre entre vos désirs et ceux de votre partenaire. Une bonne opportunité pour des activités communes actives (sport, danse).',
          '8': 'Amélioration de l\'harmonie et de l\'attirance sexuelle. Une conversation ouverte sur des sujets intimes se déroule sans heurt et vous rapproche.',
          '9': 'Une chance de rencontre romantique en voyage ou en ligne. Des intérêts communs et une passion pour l\'aventure.',
          '10': 'Votre charme et votre énergie vous aident à atteindre vos objectifs de carrière. Succès dans les projets liés à l\'art, la mode et le divertissement.',
          '11': 'Une fête entre amis pourrait être le lieu d\'une rencontre romantique. Il est facile de trouver des personnes partageant les mêmes idées pour des projets créatifs.',
          '12': 'Une aventure romantique secrète. Votre intuition vous dit comment et quand agir en amour.'
        },
        'de': {
          '1': 'Ihre Attraktivität und Ihr Selbstvertrauen sind auf dem Höhepunkt. Es ist leicht, die Initiative zu ergreifen und den richtigen Eindruck zu hinterlassen.',
          '2': 'Eine gute Gelegenheit, mit Ihrer Kreativität oder Ihrem Hobby Geld zu verdienen. Aktive Bemühungen bringen finanzielle Ergebnisse.',
          '3': 'Kühnes und erfolgreiches Flirten. Es ist leicht, ein Gespräch zu beginnen und Ihre Zuneigung auszudrücken. Ein kurzer Ausflug könnte romantisch werden.',
          '4': 'Aktive Bemühungen, das Zuhause zu dekorieren. Ein guter Tag, um gemeinsam mit Ihrem Partner Hausarbeiten zu erledigen.',
          '5': 'Der perfekte Aspekt für Dates und Romantik! Starke gegenseitige Anziehung, Leidenschaft und Harmonie. Es ist leicht, den ersten Schritt zu tun.',
          '6': 'Eine angenehme und produktive Atmosphäre bei der Arbeit. Ein leichter Flirt mit einem Kollegen könnte Ihre Stimmung heben.',
          '7': 'Ein ausgezeichnetes Gleichgewicht zwischen Ihren Wünschen und denen Ihres Partners. Eine gute Gelegenheit für gemeinsame aktive Unternehmungen (Sport, Tanzen).',
          '8': 'Verbesserung der sexuellen Harmonie und Anziehung. Ein offenes Gespräch über intime Themen verläuft reibungslos und bringt Sie näher zusammen.',
          '9': 'Eine Chance auf eine romantische Begegnung auf Reisen oder online. Gemeinsame Interessen und eine Leidenschaft für Abenteuer.',
          '10': 'Ihr Charme und Ihre Energie helfen Ihnen, Ihre Karriereziele zu erreichen. Erfolg bei Projekten im Zusammenhang mit Kunst, Mode und Unterhaltung.',
          '11': 'Eine Party mit Freunden könnte der Ort für ein romantisches Treffen sein. Es ist leicht, Gleichgesinnte für kreative Projekte zu finden.',
          '12': 'Ein geheimes romantisches Abenteuer. Ihre Intuition sagt Ihnen, wie und wann Sie in der Liebe handeln sollen.'
        }
      }
    ),
        // === НОВЫЙ БЛОК 3 ===
    AspectInterpretation(
      id: 'VENUS_OPPOSITION_SATURN',
      title: {
        'ru': 'Противостояние Венеры и Сатурна',
        'en': 'Venus Opposition Saturn',
        'fr': 'Vénus Opposition Saturne',
        'de': 'Venus-Opposition-Saturn'
      },
      descriptionGeneral: {
        'ru': 'День проверки отношений на прочность. Чувства (Венера) сталкиваются с реальностью, долгом и ограничениями (Сатурн). Возможно ощущение одиночества, холодности, финансовые трудности.',
        'en': 'A day for testing the strength of relationships. Feelings (Venus) confront reality, duty, and limitations (Saturn). A sense of loneliness, coldness, or financial difficulties is possible.',
        'fr': 'Une journée pour tester la solidité des relations. Les sentiments (Vénus) se heurtent à la réalité, au devoir et aux limitations (Saturne). Un sentiment de solitude, de froideur ou des difficultés financières sont possibles.',
        'de': 'Ein Tag, an dem Beziehungen auf die Probe gestellt werden. Gefühle (Venus) treffen auf Realität, Pflicht und Einschränkungen (Saturn). Ein Gefühl von Einsamkeit, Kälte oder finanziellen Schwierigkeiten ist möglich.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Вы можете чувствовать себя непривлекательным или слишком серьезным. Низкая самооценка мешает наслаждаться жизнью и общением.',
          '2': 'Финансовые ограничения. Приходится экономить на удовольствиях. Ощущение, что денег не хватает на то, что хочется.',
          '3': 'Сложности в выражении симпатии. Общение может быть холодным и формальным. Неприятные новости от близких.',
          '4': 'Ощущение долга перед семьей давит на вас. Атмосфера в доме может быть прохладной. Не хватает тепла и поддержки.',
          '5': 'Любовь и романтика воспринимаются как тяжелая работа или обязанность. Отсутствие легкости и радости в отношениях.',
          '6': 'Отношения с коллегами могут быть натянутыми и формальными. Работа не приносит удовольствия, только чувство долга.',
          '7': 'Партнер кажется холодным, критикующим или отстраненным. Отношения проходят серьезную проверку реальностью.',
          '8': 'Страх близости или финансовые проблемы с партнером создают дистанцию. В интимной сфере возможна холодность.',
          '9': 'Чувство долга мешает планам на путешествие или обучение. Разница в возрасте или статусе в отношениях ощущается особенно остро.',
          '10': 'Работа и карьерные обязанности мешают личной жизни. Сложно найти баланс между долгом и удовольствием.',
          '11': 'Ощущение одиночества в кругу друзей. Друзья могут казаться слишком требовательными или критичными.',
          '12': 'Старые страхи одиночества и отвержения выходят на поверхность. Вы можете закрыться от других, чтобы избежать боли.'
        },
        'en': {
          '1': 'You might feel unattractive or too serious. Low self-esteem prevents you from enjoying life and socializing.',
          '2': 'Financial constraints. You have to save on pleasures. A feeling that there isn\'t enough money for what you want.',
          '3': 'Difficulties in expressing affection. Communication may be cold and formal. Unpleasant news from loved ones.',
          '4': 'A sense of duty to your family weighs on you. The atmosphere at home may be cool. Lack of warmth and support.',
          '5': 'Love and romance are perceived as hard work or an obligation. A lack of lightness and joy in relationships.',
          '6': 'Relationships with colleagues may be strained and formal. Work brings no pleasure, only a sense of duty.',
          '7': 'A partner seems cold, critical, or distant. The relationship is undergoing a serious reality check.',
          '8': 'Fear of intimacy or financial problems with a partner creates distance. Coldness is possible in the intimate sphere.',
          '9': 'A sense of duty interferes with travel or education plans. Age or status differences in a relationship feel particularly acute.',
          '10': 'Work and career responsibilities interfere with personal life. It\'s difficult to find a balance between duty and pleasure.',
          '11': 'A feeling of loneliness within your circle of friends. Friends may seem too demanding or critical.',
          '12': 'Old fears of loneliness and rejection surface. You might shut yourself off from others to avoid pain.'
        },
        'fr': {
          '1': 'Vous pourriez vous sentir peu attrayant ou trop sérieux. Une faible estime de soi vous empêche de profiter de la vie et des relations sociales.',
          '2': 'Contraintes financières. Vous devez économiser sur les plaisirs. Le sentiment de ne pas avoir assez d\'argent pour ce que vous voulez.',
          '3': 'Difficultés à exprimer son affection. La communication peut être froide et formelle. Nouvelles désagréables de la part des proches.',
          '4': 'Un sentiment de devoir envers votre famille pèse sur vous. L\'atmosphère à la maison peut être fraîche. Manque de chaleur et de soutien.',
          '5': 'L\'amour et la romance sont perçus comme un travail difficile ou une obligation. Un manque de légèreté et de joie dans les relations.',
          '6': 'Les relations avec les collègues peuvent être tendues et formelles. Le travail n\'apporte aucun plaisir, seulement un sens du devoir.',
          '7': 'Un partenaire semble froid, critique ou distant. La relation subit un sérieux test de réalité.',
          '8': 'La peur de l\'intimité ou les problèmes financiers avec un partenaire créent de la distance. De la froideur est possible dans la sphère intime.',
          '9': 'Un sentiment de devoir interfère avec les projets de voyage ou d\'éducation. Les différences d\'âge ou de statut dans une relation sont particulièrement ressenties.',
          '10': 'Le travail et les responsabilités professionnelles interfèrent avec la vie personnelle. Il est difficile de trouver un équilibre entre le devoir et le plaisir.',
          '11': 'Un sentiment de solitude au sein de votre cercle d\'amis. Les amis peuvent sembler trop exigeants ou critiques.',
          '12': 'De vieilles peurs de la solitude et du rejet refont surface. Vous pourriez vous fermer aux autres pour éviter la douleur.'
        },
        'de': {
          '1': 'Sie fühlen sich vielleicht unattraktiv oder zu ernst. Geringes Selbstwertgefühl hindert Sie daran, das Leben und soziale Kontakte zu genießen.',
          '2': 'Finanzielle Einschränkungen. Sie müssen bei Vergnügungen sparen. Das Gefühl, nicht genug Geld für das zu haben, was Sie wollen.',
          '3': 'Schwierigkeiten, Zuneigung auszudrücken. Die Kommunikation kann kalt und formell sein. Unangenehme Nachrichten von Angehörigen.',
          '4': 'Ein Gefühl der Pflicht gegenüber Ihrer Familie lastet auf Ihnen. Die Atmosphäre zu Hause kann kühl sein. Mangel an Wärme und Unterstützung.',
          '5': 'Liebe und Romantik werden als harte Arbeit oder Verpflichtung empfunden. Ein Mangel an Leichtigkeit und Freude in Beziehungen.',
          '6': 'Die Beziehungen zu Kollegen können angespannt und formell sein. Die Arbeit bringt keine Freude, nur ein Pflichtgefühl.',
          '7': 'Ein Partner wirkt kalt, kritisch oder distanziert. Die Beziehung durchläuft einen ernsthaften Realitätscheck.',
          '8': 'Angst vor Intimität oder finanzielle Probleme mit einem Partner schaffen Distanz. Kälte ist im intimen Bereich möglich.',
          '9': 'Ein Pflichtgefühl stört Reise- oder Bildungspläne. Alters- oder Statusunterschiede in einer Beziehung werden besonders deutlich.',
          '10': 'Arbeit und berufliche Verpflichtungen stören das Privatleben. Es ist schwierig, ein Gleichgewicht zwischen Pflicht und Vergnügen zu finden.',
          '11': 'Ein Gefühl der Einsamkeit im Freundeskreis. Freunde können zu anspruchsvoll oder kritisch erscheinen.',
          '12': 'Alte Ängste vor Einsamkeit und Ablehnung kommen an die Oberfläche. Sie könnten sich von anderen verschließen, um Schmerz zu vermeiden.'
        }
      }
    ),
    AspectInterpretation(
      id: 'SUN_SQUARE_PLUTO',
      title: {
        'ru': 'Конфликт Солнца и Плутона',
        'en': 'Sun Square Pluto',
        'fr': 'Soleil Carré Pluton',
        'de': 'Sonne-Quadrat-Pluto'
      },
      descriptionGeneral: {
        'ru': 'Кризисный день, связанный с борьбой за власть. Ваше эго (Солнце) сталкивается с мощным давлением, манипуляциями или необходимостью трансформации (Плутон). Скрытое выходит на поверхность.',
        'en': 'A crisis day related to power struggles. Your ego (Sun) faces intense pressure, manipulation, or the need for transformation (Pluto). The hidden comes to the surface.',
        'fr': 'Une journée de crise liée aux luttes de pouvoir. Votre ego (Soleil) fait face à une pression intense, à la manipulation ou au besoin de transformation (Pluton). Ce qui est caché remonte à la surface.',
        'de': 'Ein Krisentag im Zusammenhang mit Machtkämpfen. Ihr Ego (Sonne) sieht sich intensivem Druck, Manipulation oder der Notwendigkeit einer Transformation (Pluto) ausgesetzt. Das Verborgene kommt an die Oberfläche.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Кризис самоидентификации. Вы можете столкнуться с необходимостью кардинально изменить что-то в себе. Избегайте высокомерия и давления на других.',
          '2': 'Финансовый кризис или борьба за ресурсы. Возможны крупные потери или, наоборот, одержимость заработком любой ценой.',
          '3': 'Жесткие и манипулятивные споры. Ваши слова могут ранить очень глубоко. Осторожно, на поверхность может выйти компрометирующая информация.',
          '4': 'Борьба за власть в семье. Давление со стороны родственников. Могут вскрыться старые семейные тайны.',
          '5': 'Драматические события в любви. Ревность, манипуляции, страсть на грани одержимости. Отношения могут пройти через серьезный кризис.',
          '6': 'Конфликты на работе, интриги, попытки "подсидеть". Может возникнуть навязчивое желание все контролировать. Риски для здоровья.',
          '7': 'Открытая борьба за власть с партнером. Один из вас пытается доминировать и контролировать другого. Отношения требуют глубокой трансформации.',
          '8': 'Кризис, связанный с общими финансами, долгами или интимной жизнью. Вопросы жизни и смерти могут ощущаться очень остро.',
          '9': 'Фанатичное отстаивание своих убеждений. Вы можете пытаться навязать свою точку зрения другим, что приведет к конфликту.',
          '10': 'Конфликт с начальством или властными структурами. Ваша карьера и репутация могут быть под угрозой. Борьба за влияние.',
          '11': 'Давление со стороны друзей или коллектива. Дружба может быть разрушена из-за борьбы за лидерство или предательства.',
          '12': 'Ваши внутренние "демоны" и страхи выходят наружу. Вы можете столкнуться с последствиями своих тайных действий. Время психологической чистки.'
        },
        'en': {
          '1': 'A crisis of self-identity. You may face the need to radically change something about yourself. Avoid arrogance and pressuring others.',
          '2': 'A financial crisis or a struggle for resources. Major losses or, conversely, an obsession with earning at any cost are possible.',
          '3': 'Harsh and manipulative arguments. Your words can hurt very deeply. Be careful, compromising information may surface.',
          '4': 'A power struggle within the family. Pressure from relatives. Old family secrets may be revealed.',
          '5': 'Dramatic events in love. Jealousy, manipulation, passion bordering on obsession. Relationships may go through a serious crisis.',
          '6': 'Conflicts at work, intrigues, attempts to undermine. An obsessive desire to control everything may arise. Health risks.',
          '7': 'An open power struggle with a partner. One of you tries to dominate and control the other. The relationship requires deep transformation.',
          '8': 'A crisis related to joint finances, debts, or intimate life. Issues of life and death may feel very acute.',
          '9': 'Fanatical defense of your beliefs. You may try to impose your point of view on others, leading to conflict.',
          '10': 'Conflict with superiors or authority structures. Your career and reputation may be at risk. A struggle for influence.',
          '11': 'Pressure from friends or a group. A friendship may be destroyed due to a leadership struggle or betrayal.',
          '12': 'Your inner "demons" and fears come out. You may face the consequences of your secret actions. A time for psychological cleansing.'
        },
        'fr': {
          '1': 'Crise d\'identité. Vous pourriez être confronté à la nécessité de changer radicalement quelque chose en vous. Évitez l\'arrogance et la pression sur les autres.',
          '2': 'Crise financière ou lutte pour les ressources. Des pertes importantes ou, à l\'inverse, une obsession de gagner à tout prix sont possibles.',
          '3': 'Disputes dures et manipulatrices. Vos mots peuvent blesser très profondément. Attention, des informations compromettantes peuvent faire surface.',
          '4': 'Lutte de pouvoir au sein de la famille. Pression des proches. De vieux secrets de famille pourraient être révélés.',
          '5': 'Événements dramatiques en amour. Jalousie, manipulation, passion à la limite de l\'obsession. Les relations peuvent traverser une grave crise.',
          '6': 'Conflits au travail, intrigues, tentatives de saper l\'autorité. Un désir obsessionnel de tout contrôler peut survenir. Risques pour la santé.',
          '7': 'Lutte de pouvoir ouverte avec un partenaire. L\'un de vous essaie de dominer et de contrôler l\'autre. La relation nécessite une transformation profonde.',
          '8': 'Crise liée aux finances communes, aux dettes ou à la vie intime. Les questions de vie et de mort peuvent être ressenties de manière très aiguë.',
          '9': 'Défense fanatique de vos croyances. Vous pourriez essayer d\'imposer votre point de vue aux autres, ce qui mènera à un conflit.',
          '10': 'Conflit avec des supérieurs ou des structures d\'autorité. Votre carrière et votre réputation peuvent être en danger. Une lutte pour l\'influence.',
          '11': 'Pression d\'amis ou d\'un groupe. Une amitié peut être détruite par une lutte de pouvoir ou une trahison.',
          '12': 'Vos "démons" intérieurs et vos peurs sortent. Vous pourriez faire face aux conséquences de vos actions secrètes. Un temps de nettoyage psychologique.'
        },
        'de': {
          '1': 'Eine Krise der Selbstidentität. Sie könnten vor der Notwendigkeit stehen, etwas an sich radikal zu ändern. Vermeiden Sie Arroganz und Druck auf andere.',
          '2': 'Eine Finanzkrise oder ein Kampf um Ressourcen. Große Verluste oder umgekehrt eine Besessenheit, um jeden Preis zu verdienen, sind möglich.',
          '3': 'Harte und manipulative Auseinandersetzungen. Ihre Worte können sehr tief verletzen. Seien Sie vorsichtig, kompromittierende Informationen könnten auftauchen.',
          '4': 'Ein Machtkampf innerhalb der Familie. Druck von Verwandten. Alte Familiengeheimnisse könnten aufgedeckt werden.',
          '5': 'Dramatische Ereignisse in der Liebe. Eifersucht, Manipulation, Leidenschaft an der Grenze zur Besessenheit. Beziehungen können eine schwere Krise durchmachen.',
          '6': 'Konflikte bei der Arbeit, Intrigen, Versuche zu untergraben. Ein zwanghafter Wunsch, alles zu kontrollieren, kann aufkommen. Gesundheitsrisiken.',
          '7': 'Ein offener Machtkampf mit einem Partner. Einer von Ihnen versucht, den anderen zu dominieren und zu kontrollieren. Die Beziehung erfordert eine tiefe Transformation.',
          '8': 'Eine Krise im Zusammenhang mit gemeinsamen Finanzen, Schulden oder dem Intimleben. Fragen von Leben und Tod können sich sehr akut anfühlen.',
          '9': 'Fanatische Verteidigung Ihrer Überzeugungen. Sie könnten versuchen, anderen Ihre Sichtweise aufzuzwingen, was zu Konflikten führt.',
          '10': 'Konflikt mit Vorgesetzten oder Autoritätsstrukturen. Ihre Karriere und Ihr Ruf könnten gefährdet sein. Ein Kampf um Einfluss.',
          '11': 'Druck von Freunden oder einer Gruppe. Eine Freundschaft könnte durch einen Machtkampf oder Verrat zerstört werden.',
          '12': 'Ihre inneren "Dämonen" und Ängste kommen zum Vorschein. Sie könnten mit den Konsequenzen Ihrer geheimen Handlungen konfrontiert werden. Eine Zeit der psychologischen Reinigung.'
        }
      }
    ),
    AspectInterpretation(
      id: 'MERCURY_TRINE_SATURN',
      title: {
        'ru': 'Гармония Меркурия и Сатурна',
        'en': 'Mercury Trine Saturn',
        'fr': 'Mercure Trigone Saturne',
        'de': 'Merkur-Trigon-Saturn'
      },
      descriptionGeneral: {
        'ru': 'День ясного и дисциплинированного ума. Мышление (Меркурий) получает структуру и основательность (Сатурн). Идеально для серьезного планирования, подписания контрактов и работы, требующей концентрации.',
        'en': 'A day of clear and disciplined mind. Thinking (Mercury) gets structure and thoroughness (Saturn). Ideal for serious planning, signing contracts, and work requiring concentration.',
        'fr': 'Une journée d\'esprit clair et discipliné. La pensée (Mercure) acquiert structure et rigueur (Saturne). Idéal pour la planification sérieuse, la signature de contrats et le travail exigeant de la concentration.',
        'de': 'Ein Tag des klaren und disziplinierten Geistes. Das Denken (Merkur) erhält Struktur und Gründlichkeit (Saturn). Ideal für ernsthafte Planung, Vertragsunterzeichnungen und konzentrationsfordernde Arbeit.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Вы производите впечатление надежного и компетентного человека. Ваши слова весомы. Отличное время для принятия ответственных решений.',
          '2': 'Прекрасный день для долгосрочного финансового планирования, открытия сберегательного счета или заключения выгодной сделки.',
          '3': 'Конструктивный и серьезный разговор. Легко доносить свою точку зрения, учиться, работать с документами.',
          '4': 'Обсуждение серьезных семейных планов (покупка дома, ремонт). Хороший день для решения вопросов с пожилыми родственниками.',
          '5': 'Серьезный разговор с партнером о будущем отношений, который принесет ясность и стабильность. Практический подход к творчеству.',
          '6': 'Высокая концентрация и продуктивность на работе. Легко справляетесь с рутинными и сложными задачами. Хорошо для планирования диеты.',
          '7': 'Заключение долгосрочных договоренностей с партнером (брак, бизнес). Разговор будет конструктивным и приведет к конкретным решениям.',
          '8': 'Успешное решение вопросов, связанных с налогами, страховкой, кредитами. Глубокий, осмысленный разговор на сложные темы.',
          '9': 'Планирование дальней поездки или начала серьезного обучения. Легко усваивается сложный материал.',
          '10': 'Успешный разговор с начальством о ваших карьерных планах. Ваши идеи будут восприняты как продуманные и реалистичные.',
          '11': 'Обсуждение долгосрочных планов с друзьями. Вы можете получить мудрый совет от старшего друга.',
          '12': 'Глубокие размышления приводят к важным и практическим выводам. Хорошее время для планирования в уединении.'
        },
        'en': {
          '1': 'You give the impression of a reliable and competent person. Your words carry weight. An excellent time for making responsible decisions.',
          '2': 'A great day for long-term financial planning, opening a savings account, or making a profitable deal.',
          '3': 'A constructive and serious conversation. It\'s easy to convey your point of view, learn, and work with documents.',
          '4': 'Discussing serious family plans (buying a house, renovations). A good day to resolve issues with elderly relatives.',
          '5': 'A serious conversation with a partner about the future of the relationship that will bring clarity and stability. A practical approach to creativity.',
          '6': 'High concentration and productivity at work. You easily handle routine and complex tasks. Good for planning a diet.',
          '7': 'Making long-term agreements with a partner (marriage, business). The conversation will be constructive and lead to concrete decisions.',
          '8': 'Successful resolution of issues related to taxes, insurance, loans. A deep, meaningful conversation on complex topics.',
          '9': 'Planning a long trip or the start of serious studies. Complex material is easily absorbed.',
          '10': 'A successful conversation with your boss about your career plans. Your ideas will be perceived as well-thought-out and realistic.',
          '11': 'Discussing long-term plans with friends. You might get wise advice from an older friend.',
          '12': 'Deep reflections lead to important and practical conclusions. A good time for planning in solitude.'
        },
        'fr': {
          '1': 'Vous donnez l\'impression d\'une personne fiable et compétente. Vos paroles ont du poids. Un excellent moment pour prendre des décisions responsables.',
          '2': 'Une excellente journée pour la planification financière à long terme, l\'ouverture d\'un compte d\'épargne ou la conclusion d\'une bonne affaire.',
          '3': 'Une conversation constructive et sérieuse. Il est facile de faire passer votre point de vue, d\'apprendre et de travailler avec des documents.',
          '4': 'Discussion de plans familiaux sérieux (achat d\'une maison, rénovations). Une bonne journée pour résoudre les problèmes avec les parents âgés.',
          '5': 'Une conversation sérieuse avec un partenaire sur l\'avenir de la relation qui apportera clarté et stabilité. Une approche pratique de la créativité.',
          '6': 'Grande concentration et productivité au travail. Vous gérez facilement les tâches routinières et complexes. Bon pour planifier un régime.',
          '7': 'Conclusion d\'accords à long terme avec un partenaire (mariage, affaires). La conversation sera constructive et mènera à des décisions concrètes.',
          '8': 'Résolution réussie des problèmes liés aux impôts, assurances, prêts. Une conversation profonde et significative sur des sujets complexes.',
          '9': 'Planification d\'un long voyage ou début d\'études sérieuses. Le matériel complexe est facilement absorbé.',
          '10': 'Une conversation réussie avec votre patron sur vos plans de carrière. Vos idées seront perçues comme réfléchies et réalistes.',
          '11': 'Discussion de plans à long terme avec des amis. Vous pourriez recevoir de sages conseils d\'un ami plus âgé.',
          '12': 'Des réflexions profondes mènent à des conclusions importantes et pratiques. Un bon moment pour planifier en solitude.'
        },
        'de': {
          '1': 'Sie machen den Eindruck einer zuverlässigen und kompetenten Person. Ihre Worte haben Gewicht. Eine ausgezeichnete Zeit, um verantwortungsvolle Entscheidungen zu treffen.',
          '2': 'Ein großartiger Tag für langfristige Finanzplanung, die Eröffnung eines Sparkontos oder einen profitablen Deal.',
          '3': 'Ein konstruktives und ernsthaftes Gespräch. Es ist leicht, Ihren Standpunkt zu vermitteln, zu lernen und mit Dokumenten zu arbeiten.',
          '4': 'Besprechung ernster Familienpläne (Hauskauf, Renovierungen). Ein guter Tag, um Probleme mit älteren Verwandten zu lösen.',
          '5': 'Ein ernstes Gespräch mit einem Partner über die Zukunft der Beziehung, das Klarheit und Stabilität bringt. Ein praktischer Ansatz für Kreativität.',
          '6': 'Hohe Konzentration und Produktivität bei der Arbeit. Sie bewältigen leicht Routine- und komplexe Aufgaben. Gut zur Planung einer Diät.',
          '7': 'Abschluss langfristiger Vereinbarungen mit einem Partner (Ehe, Geschäft). Das Gespräch wird konstruktiv sein und zu konkreten Entscheidungen führen.',
          '8': 'Erfolgreiche Lösung von Problemen im Zusammenhang mit Steuern, Versicherungen, Krediten. Ein tiefes, bedeutungsvolles Gespräch über komplexe Themen.',
          '9': 'Planung einer langen Reise oder des Beginns eines ernsthaften Studiums. Komplexes Material wird leicht aufgenommen.',
          '10': 'Ein erfolgreiches Gespräch mit Ihrem Chef über Ihre Karrierepläne. Ihre Ideen werden als durchdacht und realistisch wahrgenommen.',
          '11': 'Besprechung langfristiger Pläne mit Freunden. Sie könnten weisen Rat von einem älteren Freund erhalten.',
          '12': 'Tiefe Reflexionen führen zu wichtigen und praktischen Schlussfolgerungen. Eine gute Zeit, um in Einsamkeit zu planen.'
        }
      }
    ),
    AspectInterpretation(
      id: 'MOON_SEXTILE_JUPITER',
      title: {
        'ru': 'Шанс от Луны и Юпитера',
        'en': 'Moon Sextile Jupiter',
        'fr': 'Lune Sextile Jupiter',
        'de': 'Mond-Sextil-Jupiter'
      },
      descriptionGeneral: {
        'ru': 'День хорошего настроения и эмоциональной щедрости. Легко чувствовать себя счастливым и делиться этим с другими. Хорошие возможности для общения, семейных дел и отдыха.',
        'en': 'A day of good mood and emotional generosity. It\'s easy to feel happy and share it with others. Good opportunities for socializing, family matters, and relaxation.',
        'fr': 'Une journée de bonne humeur et de générosité émotionnelle. Il est facile de se sentir heureux et de le partager avec les autres. Bonnes opportunités pour socialiser, les affaires familiales et la détente.',
        'de': 'Ein Tag guter Laune und emotionaler Großzügigkeit. Es ist leicht, sich glücklich zu fühlen und dies mit anderen zu teilen. Gute Gelegenheiten für Geselligkeit, Familienangelegenheiten und Entspannung.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Вы излучаете оптимизм и дружелюбие. Люди чувствуют себя комфортно рядом с вами. Легко получить поддержку.',
          '2': 'Возможность получить небольшой финансовый бонус или найти способ улучшить свое материальное положение через проявление заботы.',
          '3': 'Приятные и душевные разговоры. Легко найти общий язык с соседями и родственниками. Хорошие новости.',
          '4': 'Прекрасный день для отдыха дома с семьей. Ощущение уюта, безопасности и эмоционального комфорта.',
          '5': 'Легкий флирт и хорошее настроение в романтических отношениях. Возможность приятно провести время, сходить на свидание.',
          '6': 'Хорошие отношения с коллегами, приятная атмосфера на работе. Возможность немного расслабиться и не перенапрягаться.',
          '7': 'Партнер проявляет щедрость и заботу. Хорошая возможность для душевного разговора и укрепления эмоциональной связи.',
          '8': 'Эмоциональное доверие с партнером растет. Возможность получить финансовую поддержку от партнера или семьи.',
          '9': 'Появляются оптимистичные планы на путешествие. Хорошее настроение от чтения интересной книги или просмотра фильма.',
          '10': 'Ваша заботливость и эмпатия могут быть замечены начальством. Хорошие отношения с вышестоящими.',
          '11': 'Душевная встреча с друзьями. Вы можете оказать или получить эмоциональную поддержку в дружеском кругу.',
          '12': 'Ощущение внутреннего спокойствия и веры в лучшее. Хороший день для отдыха, медитации и благотворительности.'
        },
        'en': {
          '1': 'You radiate optimism and friendliness. People feel comfortable around you. It\'s easy to get support.',
          '2': 'An opportunity to receive a small financial bonus or find a way to improve your financial situation through care.',
          '3': 'Pleasant and heartfelt conversations. It\'s easy to find common ground with neighbors and relatives. Good news.',
          '4': 'A wonderful day to relax at home with family. A feeling of coziness, security, and emotional comfort.',
          '5': 'Light flirting and a good mood in romantic relationships. An opportunity to have a pleasant time, go on a date.',
          '6': 'Good relationships with colleagues, a pleasant atmosphere at work. An opportunity to relax a bit and not overexert yourself.',
          '7': 'Your partner shows generosity and care. A good opportunity for a heartfelt conversation and strengthening the emotional bond.',
          '8': 'Emotional trust with your partner is growing. An opportunity to receive financial support from a partner or family.',
          '9': 'Optimistic travel plans emerge. A good mood from reading an interesting book or watching a movie.',
          '10': 'Your caring and empathetic nature may be noticed by superiors. Good relationships with those in charge.',
          '11': 'A soulful meeting with friends. You can give or receive emotional support within your circle of friends.',
          '12': 'A feeling of inner peace and faith in the best. A good day for rest, meditation, and charity.'
        },
        'fr': {
          '1': 'Vous rayonnez d\'optimisme et de convivialité. Les gens se sentent à l\'aise avec vous. Il est facile d\'obtenir du soutien.',
          '2': 'Une opportunité de recevoir un petit bonus financier ou de trouver un moyen d\'améliorer votre situation financière en prenant soin des autres.',
          '3': 'Conversations agréables et sincères. Il est facile de trouver un terrain d\'entente avec les voisins et les parents. Bonnes nouvelles.',
          '4': 'Une merveilleuse journée pour se détendre à la maison en famille. Un sentiment de confort, de sécurité et de bien-être émotionnel.',
          '5': 'Flirt léger et bonne humeur dans les relations amoureuses. Une opportunité de passer un agréable moment, d\'avoir un rendez-vous.',
          '6': 'Bonnes relations avec les collègues, atmosphère agréable au travail. Une opportunité de se détendre un peu et de ne pas se surmener.',
          '7': 'Votre partenaire fait preuve de générosité et d\'attention. Une bonne occasion pour une conversation sincère et pour renforcer le lien émotionnel.',
          '8': 'La confiance émotionnelle avec votre partenaire grandit. Une opportunité de recevoir un soutien financier d\'un partenaire ou de la famille.',
          '9': 'Des projets de voyage optimistes émergent. Une bonne humeur grâce à la lecture d\'un livre intéressant ou au visionnage d\'un film.',
          '10': 'Votre nature attentionnée et empathique peut être remarquée par vos supérieurs. Bonnes relations avec les responsables.',
          '11': 'Une rencontre émouvante avec des amis. Vous pouvez donner ou recevoir un soutien émotionnel au sein de votre cercle d\'amis.',
          '12': 'Un sentiment de paix intérieure et de foi en le meilleur. Une bonne journée pour le repos, la méditation et la charité.'
        },
        'de': {
          '1': 'Sie strahlen Optimismus und Freundlichkeit aus. Die Menschen fühlen sich in Ihrer Nähe wohl. Es ist leicht, Unterstützung zu bekommen.',
          '2': 'Eine Gelegenheit, einen kleinen finanziellen Bonus zu erhalten oder einen Weg zu finden, Ihre finanzielle Situation durch Fürsorge zu verbessern.',
          '3': 'Angenehme und herzliche Gespräche. Es ist leicht, eine gemeinsame Basis mit Nachbarn und Verwandten zu finden. Gute Nachrichten.',
          '4': 'Ein wunderbarer Tag, um zu Hause mit der Familie zu entspannen. Ein Gefühl von Gemütlichkeit, Sicherheit und emotionalem Komfort.',
          '5': 'Leichtes Flirten und gute Laune in romantischen Beziehungen. Eine Gelegenheit, eine angenehme Zeit zu verbringen, ein Date zu haben.',
          '6': 'Gute Beziehungen zu Kollegen, eine angenehme Atmosphäre bei der Arbeit. Eine Gelegenheit, sich ein wenig zu entspannen und nicht zu überanstrengen.',
          '7': 'Ihr Partner zeigt Großzügigkeit und Fürsorge. Eine gute Gelegenheit für ein herzliches Gespräch und die Stärkung der emotionalen Bindung.',
          '8': 'Das emotionale Vertrauen zu Ihrem Partner wächst. Eine Gelegenheit, finanzielle Unterstützung von einem Partner oder der Familie zu erhalten.',
          '9': 'Optimistische Reisepläne entstehen. Gute Laune durch das Lesen eines interessanten Buches oder das Anschauen eines Films.',
          '1-': 'Ihre fürsorgliche und einfühlsame Art könnte von Vorgesetzten bemerkt werden. Gute Beziehungen zu den Verantwortlichen.',
          '11': 'Ein seelenvolles Treffen mit Freunden. Sie können in Ihrem Freundeskreis emotionale Unterstützung geben oder erhalten.',
          '12': 'Ein Gefühl des inneren Friedens und des Glaubens an das Beste. Ein guter Tag für Ruhe, Meditation und Wohltätigkeit.'
        }
      }
    ),
        // === НОВЫЙ БЛОК 4 ===
    AspectInterpretation(
      id: 'VENUS_SQUARE_URANUS',
      title: {
        'ru': 'Конфликт Венеры и Урана',
        'en': 'Venus Square Uranus',
        'fr': 'Vénus Carré Uranus',
        'de': 'Venus-Quadrat-Uranus'
      },
      descriptionGeneral: {
        'ru': 'День внезапных и нестабильных событий в любви и финансах. Возможны неожиданные увлечения, резкие разрывы, импульсивные траты. Сильное желание свободы и новизны в отношениях.',
        'en': 'A day of sudden and unstable events in love and finances. Unexpected attractions, sudden breakups, and impulsive spending are possible. A strong desire for freedom and novelty in relationships.',
        'fr': 'Une journée d\'événements soudains et instables en amour et en finances. Des attirances inattendues, des ruptures soudaines et des dépenses impulsives sont possibles. Un fort désir de liberté et de nouveauté dans les relations.',
        'de': 'Ein Tag plötzlicher und instabiler Ereignisse in Liebe und Finanzen. Unerwartete Anziehungen, plötzliche Trennungen und impulsive Ausgaben sind möglich. Ein starker Wunsch nach Freiheit und Neuheit in Beziehungen.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Желание кардинально сменить имидж, шокировать окружающих. Ваше поведение в любви непредсказуемо. Возможны внезапные решения, о которых вы можете пожалеть.',
          '2': 'Импульсивные и ненужные покупки, особенно техники или модных вещей. Финансовая нестабильность, внезапные потери или неожиданные, но сомнительные доходы.',
          '3': 'Неожиданные новости, касающиеся отношений. Флирт в соцсетях может привести к непредсказуемым последствиям. Резкие слова могут спровоцировать разрыв.',
          '4': 'Внезапное желание "все поменять" дома, что может привести к конфликту с семьей. Неожиданные гости могут нарушить ваши планы.',
          '5': 'Внезапная влюбленность "с первого взгляда" или неожиданный разрыв с партнером. Отношения могут быть захватывающими, но очень нестабильными.',
          '6': 'Неожиданный флирт на работе. Желание бросить рутинные обязанности ради чего-то более интересного. Внезапные изменения в рабочем графике.',
          '7': 'Партнер требует больше свободы или ведет себя непредсказуемо. Отношениям нужна "встряска", но есть риск разрыва из-за импульсивности.',
          '8': 'Внезапное и сильное сексуальное влечение. Рискованные финансовые авантюры. Не стоит брать кредиты или давать в долг.',
          '9': 'Неожиданный роман в поездке или с иностранцем. Ваши взгляды на отношения могут резко измениться.',
          '10': 'Служебный роман может стать достоянием общественности и повредить репутации. Внезапные изменения в статусе отношений.',
          '11': 'Конфликты с друзьями из-за любовных дел. Дружба может внезапно перерасти в роман или так же внезапно закончиться.',
          '12': 'Раскрытие тайной любовной связи. Неожиданные озарения о ваших истинных потребностях в любви, которые могут вас шокировать.'
        },
        'en': {
          '1': 'A desire to radically change your image, to shock others. Your behavior in love is unpredictable. Sudden decisions that you might regret are possible.',
          '2': 'Impulsive and unnecessary purchases, especially of gadgets or trendy items. Financial instability, sudden losses, or unexpected but questionable income.',
          '3': 'Unexpected news concerning relationships. Flirting on social media can lead to unpredictable consequences. Harsh words can provoke a breakup.',
          '4': 'A sudden desire to "change everything" at home, which can lead to conflict with family. Unexpected guests may disrupt your plans.',
          '5': 'Sudden love "at first sight" or an unexpected breakup with a partner. Relationships can be exciting but very unstable.',
          '6': 'An unexpected flirtation at work. A desire to drop routine duties for something more interesting. Sudden changes in the work schedule.',
          '7': 'A partner demands more freedom or behaves unpredictably. The relationship needs a "shake-up," but there is a risk of a breakup due to impulsiveness.',
          '8': 'Sudden and strong sexual attraction. Risky financial ventures. It is not advisable to take out loans or lend money.',
          '9': 'An unexpected romance during a trip or with a foreigner. Your views on relationships may change dramatically.',
          '10': 'An office romance may become public and damage your reputation. Sudden changes in relationship status.',
          '11': 'Conflicts with friends over love affairs. A friendship can suddenly turn into a romance or end just as abruptly.',
          '12': 'The revelation of a secret love affair. Sudden insights about your true needs in love that might shock you.'
        },
        'fr': {
          '1': 'Un désir de changer radicalement votre image, de choquer les autres. Votre comportement en amour est imprévisible. Des décisions soudaines que vous pourriez regretter sont possibles.',
          '2': 'Achats impulsifs et inutiles, en particulier de gadgets ou d\'articles à la mode. Instabilité financière, pertes soudaines ou revenus inattendus mais douteux.',
          '3': 'Nouvelles inattendues concernant les relations. Flirter sur les réseaux sociaux peut entraîner des conséquences imprévisibles. Des mots durs peuvent provoquer une rupture.',
          '4': 'Un désir soudain de "tout changer" à la maison, ce qui peut entraîner un conflit avec la famille. Des invités inattendus peuvent perturber vos plans.',
          '5': 'Coup de foudre soudain ou rupture inattendue avec un partenaire. Les relations peuvent être excitantes mais très instables.',
          '6': 'Un flirt inattendu au travail. Un désir d\'abandonner les tâches routinières pour quelque chose de plus intéressant. Changements soudains dans l\'horaire de travail.',
          '7': 'Un partenaire demande plus de liberté ou se comporte de manière imprévisible. La relation a besoin d\'un "choc", mais il y a un risque de rupture dû à l\'impulsivité.',
          '8': 'Attirance sexuelle soudaine et forte. Aventures financières risquées. Il n\'est pas conseillé de contracter des emprunts ou de prêter de l\'argent.',
          '9': 'Une romance inattendue lors d\'un voyage ou avec un étranger. Votre vision des relations peut changer radicalement.',
          '10': 'Une romance au bureau peut devenir publique et nuire à votre réputation. Changements soudains dans le statut de la relation.',
          '11': 'Conflits avec des amis à cause d\'affaires de cœur. Une amitié peut soudainement se transformer en romance ou se terminer tout aussi brusquement.',
          '12': 'La révélation d\'une liaison amoureuse secrète. Des prises de conscience soudaines sur vos vrais besoins en amour qui pourraient vous choquer.'
        },
        'de': {
          '1': 'Der Wunsch, Ihr Image radikal zu ändern, andere zu schockieren. Ihr Verhalten in der Liebe ist unvorhersehbar. Plötzliche Entscheidungen, die Sie bereuen könnten, sind möglich.',
          '2': 'Impulsive und unnötige Käufe, insbesondere von Geräten oder modischen Artikeln. Finanzielle Instabilität, plötzliche Verluste oder unerwartete, aber fragwürdige Einnahmen.',
          '3': 'Unerwartete Nachrichten bezüglich Beziehungen. Flirten in sozialen Medien kann zu unvorhersehbaren Konsequenzen führen. Harte Worte können eine Trennung provozieren.',
          '4': 'Ein plötzlicher Wunsch, zu Hause "alles zu ändern", was zu Konflikten mit der Familie führen kann. Unerwartete Gäste können Ihre Pläne durchkreuzen.',
          '5': 'Plötzliche Liebe "auf den ersten Blick" oder eine unerwartete Trennung von einem Partner. Beziehungen können aufregend, aber sehr instabil sein.',
          '6': 'Ein unerwarteter Flirt bei der Arbeit. Der Wunsch, Routineaufgaben für etwas Interessanteres aufzugeben. Plötzliche Änderungen im Arbeitsplan.',
          '7': 'Ein Partner fordert mehr Freiheit oder verhält sich unvorhersehbar. Die Beziehung braucht einen "Ruck", aber es besteht die Gefahr einer Trennung aufgrund von Impulsivität.',
          '8': 'Plötzliche und starke sexuelle Anziehung. Riskante finanzielle Unternehmungen. Es ist nicht ratsam, Kredite aufzunehmen oder Geld zu leihen.',
          '9': 'Eine unerwartete Romanze während einer Reise oder mit einem Ausländer. Ihre Ansichten über Beziehungen können sich dramatisch ändern.',
          '10': 'Eine Büro-Romanze könnte öffentlich werden und Ihrem Ruf schaden. Plötzliche Änderungen im Beziehungsstatus.',
          '11': 'Konflikte mit Freunden wegen Liebesangelegenheiten. Eine Freundschaft kann sich plötzlich in eine Romanze verwandeln oder ebenso abrupt enden.',
          '12': 'Die Enthüllung einer geheimen Liebesaffäre. Plötzliche Einsichten über Ihre wahren Bedürfnisse in der Liebe, die Sie schockieren könnten.'
        }
      }
    ),
    AspectInterpretation(
      id: 'MOON_SQUARE_MARS',
      title: {
        'ru': 'Конфликт Луны и Марса',
        'en': 'Moon Square Mars',
        'fr': 'Lune Carré Mars',
        'de': 'Mond-Quadrat-Mars'
      },
      descriptionGeneral: {
        'ru': 'День повышенной эмоциональной возбудимости и раздражительности. Ваши потребности (Луна) конфликтуют с вашими действиями (Марс). Легко вспылить, поссориться из-за мелочей. Особенно остро в быту.',
        'en': 'A day of heightened emotional excitability and irritability. Your needs (Moon) conflict with your actions (Mars). It\'s easy to flare up and argue over trifles. Especially acute in domestic life.',
        'fr': 'Une journée d\'excitabilité émotionnelle et d\'irritabilité accrues. Vos besoins (Lune) entrent en conflit avec vos actions (Mars). Il est facile de s\'emporter et de se disputer pour des broutilles. Particulièrement aigu dans la vie domestique.',
        'de': 'Ein Tag erhöhter emotionaler Erregbarkeit und Reizbarkeit. Ihre Bedürfnisse (Mond) stehen im Konflikt mit Ihren Handlungen (Mars). Es ist leicht, aufzubrausen und über Kleinigkeiten zu streiten. Besonders akut im häuslichen Leben.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Вы нетерпеливы и склонны к резким реакциям. Сложно контролировать гнев. Ваши эмоции и действия идут вразнобой.',
          '2': 'Импульсивные траты под влиянием эмоций. Ссоры из-за денег. Финансовая неосторожность может привести к потерям.',
          '3': 'Резкие слова, о которых потом можно пожалеть. Ссоры с соседями, братьями/сестрами. Будьте осторожны за рулем.',
          '4': 'Домашние ссоры, особенно с женщинами в семье (мать, жена). Бытовые проблемы вызывают сильное раздражение.',
          '5': 'Конфликты с любимым человеком на почве ревности или неудовлетворенности. Развлечения могут закончиться ссорой.',
          '6': 'Раздражение на работе, конфликты с коллегами. Нетерпение мешает выполнять рутинные задачи. Риск бытовых травм.',
          '7': 'Прямой конфликт с партнером. Раздражительность и нетерпение могут привести к серьезной ссоре. Выяснение отношений непродуктивно.',
          '8': 'Эмоциональное напряжение в интимной сфере. Споры из-за общих финансов. Желание рискнуть может быть вызвано внутренним дискомфортом.',
          '9': 'Споры на идеологической почве. Ваше плохое настроение может мешать учебе или планам на поездку.',
          '10': 'Эмоции мешают карьере. Конфликт с начальством (особенно с женщиной-руководителем). Недовольство своим положением.',
          '11': 'Ссоры с друзьями. Вы можете слишком бурно реагировать на их слова или поступки.',
          '12': 'Сдерживаемый гнев и подсознательное раздражение. Вы можете сами не понимать, что вас злит, но это приводит к пассивной агрессии.'
        },
        'en': {
          '1': 'You are impatient and prone to sharp reactions. It\'s hard to control your anger. Your emotions and actions are out of sync.',
          '2': 'Impulsive spending under the influence of emotions. Arguments over money. Financial carelessness can lead to losses.',
          '3': 'Harsh words that you might later regret. Quarrels with neighbors, siblings. Be careful while driving.',
          '4': 'Domestic quarrels, especially with women in the family (mother, wife). Household problems cause strong irritation.',
          '5': 'Conflicts with a loved one due to jealousy or dissatisfaction. Entertainment can end in an argument.',
          '6': 'Irritation at work, conflicts with colleagues. Impatience hinders the performance of routine tasks. Risk of household injuries.',
          '7': 'Direct conflict with a partner. Irritability and impatience can lead to a serious quarrel. Sorting things out is unproductive.',
          '8': 'Emotional tension in the intimate sphere. Disputes over joint finances. A desire to take risks may be caused by internal discomfort.',
          '9': 'Arguments on ideological grounds. Your bad mood can interfere with your studies or travel plans.',
          '10': 'Emotions interfere with your career. Conflict with a boss (especially a female supervisor). Dissatisfaction with your position.',
          '11': 'Quarrels with friends. You might overreact to their words or actions.',
          '12': 'Suppressed anger and subconscious irritation. You may not understand what is angering you, but it leads to passive aggression.'
        },
        'fr': {
          '1': 'Vous êtes impatient et enclin à des réactions vives. Il est difficile de contrôler votre colère. Vos émotions et vos actions sont désynchronisées.',
          '2': 'Dépenses impulsives sous l\'influence des émotions. Disputes à propos de l\'argent. L\'imprudence financière peut entraîner des pertes.',
          '3': 'Paroles dures que vous pourriez regretter plus tard. Querelles avec les voisins, les frères et sœurs. Soyez prudent en conduisant.',
          '4': 'Querelles domestiques, en particulier avec les femmes de la famille (mère, épouse). Les problèmes ménagers provoquent une forte irritation.',
          '5': 'Conflits avec un être cher à cause de la jalousie ou de l\'insatisfaction. Le divertissement peut se terminer par une dispute.',
          '6': 'Irritation au travail, conflits avec les collègues. L\'impatience entrave l\'exécution des tâches routinières. Risque de blessures domestiques.',
          '7': 'Conflit direct avec un partenaire. L\'irritabilité et l\'impatience peuvent mener à une grave querelle. Régler les comptes est improductif.',
          '8': 'Tension émotionnelle dans la sphère intime. Disputes sur les finances communes. Un désir de prendre des risques peut être causé par un inconfort interne.',
          '9': 'Disputes sur des bases idéologiques. Votre mauvaise humeur peut nuire à vos études ou à vos projets de voyage.',
          '10': 'Les émotions nuisent à votre carrière. Conflit avec un patron (surtout une supérieure). Insatisfaction de votre position.',
          '11': 'Querelles avec des amis. Vous pourriez réagir de manière excessive à leurs paroles ou à leurs actions.',
          '12': 'Colère refoulée et irritation subconsciente. Vous ne comprenez peut-être pas ce qui vous met en colère, mais cela conduit à une agression passive.'
        },
        'de': {
          '1': 'Sie sind ungeduldig und neigen zu scharfen Reaktionen. Es ist schwer, Ihre Wut zu kontrollieren. Ihre Emotionen und Handlungen sind nicht synchron.',
          '2': 'Impulsive Ausgaben unter dem Einfluss von Emotionen. Streit ums Geld. Finanzielle Unachtsamkeit kann zu Verlusten führen.',
          '3': 'Harte Worte, die Sie später bereuen könnten. Streit mit Nachbarn, Geschwistern. Seien Sie vorsichtig beim Fahren.',
          '4': 'Häusliche Streitigkeiten, besonders mit Frauen in der Familie (Mutter, Ehefrau). Haushaltsprobleme verursachen starke Reizungen.',
          '5': 'Konflikte mit einem geliebten Menschen aufgrund von Eifersucht oder Unzufriedenheit. Unterhaltung kann in einem Streit enden.',
          '6': 'Reizungen bei der Arbeit, Konflikte mit Kollegen. Ungeduld behindert die Ausführung von Routineaufgaben. Risiko von Haushaltsverletzungen.',
          '7': 'Direkter Konflikt mit einem Partner. Reizbarkeit und Ungeduld können zu einem ernsthaften Streit führen. Klärungsversuche sind unproduktiv.',
          '8': 'Emotionale Spannung im intimen Bereich. Streit über gemeinsame Finanzen. Der Wunsch, Risiken einzugehen, kann durch inneres Unbehagen verursacht werden.',
          '9': 'Streitigkeiten aus ideologischen Gründen. Ihre schlechte Laune kann Ihr Studium oder Ihre Reisepläne beeinträchtigen.',
          '10': 'Emotionen beeinträchtigen Ihre Karriere. Konflikt mit einem Chef (insbesondere einer Vorgesetzten). Unzufriedenheit mit Ihrer Position.',
          '11': 'Streit mit Freunden. Sie könnten übermäßig auf ihre Worte oder Handlungen reagieren.',
          '12': 'Unterdrückter Zorn und unterbewusste Reizung. Sie verstehen vielleicht nicht, was Sie wütend macht, aber es führt zu passiver Aggression.'
        }
      }
    ),
    AspectInterpretation(
      id: 'MERCURY_TRINE_URANUS',
      title: {
        'ru': 'Гармония Меркурия и Урана',
        'en': 'Mercury Trine Uranus',
        'fr': 'Mercure Trigone Uranus',
        'de': 'Merkur-Trigon-Uranus'
      },
      descriptionGeneral: {
        'ru': 'День озарений и гениальных идей! Мышление (Меркурий) становится оригинальным и изобретательным (Уран). Отлично для мозгового штурма, изучения технологий, общения с друзьями и неожиданных открытий.',
        'en': 'A day of insights and brilliant ideas! Thinking (Mercury) becomes original and inventive (Uranus). Excellent for brainstorming, studying technology, socializing with friends, and unexpected discoveries.',
        'fr': 'Une journée de perspicacité et d\'idées brillantes ! La pensée (Mercure) devient originale et inventive (Uranus). Excellent pour le brainstorming, l\'étude de la technologie, la socialisation avec des amis et les découvertes inattendues.',
        'de': 'Ein Tag der Einsichten und brillanten Ideen! Das Denken (Merkur) wird originell und erfinderisch (Uranus). Ausgezeichnet für Brainstorming, das Studium von Technologie, den Umgang mit Freunden und unerwartete Entdeckungen.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Ваши идеи оригинальны и вызывают интерес. Легко произвести впечатление прогрессивного и умного человека.',
          '2': 'Гениальные идеи о том, как заработать, особенно через интернет или новые технологии. Неожиданные финансовые поступления.',
          '3': 'Остроумное и увлекательное общение. Неожиданные новости или знакомства. Идеи приходят "из воздуха".',
          '4': 'Оригинальные идеи по обустройству дома. Неожиданное решение давней семейной проблемы. Приятные сюрпризы от домочадцев.',
          '5': 'Нестандартный, увлекательный флирт. Свидание может быть очень необычным и запоминающимся. Внезапные творческие озарения.',
          '6': 'Инновационные решения для рабочих задач. Легко осваиваете новую технику или программы. Работа приносит интересные сюрпризы.',
          '7': 'Свежие идеи для отношений. Разговор с партнером может привести к неожиданным и позитивным решениям. Знакомство с необычным человеком.',
          '8': 'Глубокие инсайты и озарения. Вы можете внезапно понять скрытую суть вещей. Неожиданные решения финансовых вопросов.',
          '9': 'Внезапное желание отправиться в путешествие или начать изучать что-то новое. Обучение проходит легко и увлекательно.',
          '10': 'Блестящие, нестандартные идеи для карьеры. Успешное внедрение новых технологий или методов в работу.',
          '11': 'Увлекательные беседы с друзьями, совместный мозговой штурм. Неожиданная помощь от друзей в реализации вашей мечты.',
          '12': 'Интуиция работает как никогда. Озарения приходят во сне или во время медитации. Внезапное понимание своих скрытых талантов.'
        },
        'en': {
          '1': 'Your ideas are original and arouse interest. It\'s easy to make an impression as a progressive and intelligent person.',
          '2': 'Brilliant ideas on how to make money, especially through the internet or new technologies. Unexpected financial income.',
          '3': 'Witty and engaging communication. Unexpected news or acquaintances. Ideas come "out of thin air."',
          '4': 'Original ideas for home improvement. An unexpected solution to a long-standing family problem. Pleasant surprises from household members.',
          '5': 'Unconventional, exciting flirting. A date can be very unusual and memorable. Sudden creative insights.',
          '6': 'Innovative solutions for work tasks. You easily master new equipment or software. Work brings interesting surprises.',
          '7': 'Fresh ideas for the relationship. A conversation with a partner can lead to unexpected and positive decisions. Meeting an unusual person.',
          '8': 'Deep insights and revelations. You may suddenly understand the hidden essence of things. Unexpected solutions to financial issues.',
          '9': 'A sudden desire to go on a trip or start learning something new. Learning is easy and exciting.',
          '10': 'Brilliant, unconventional ideas for your career. Successful implementation of new technologies or methods at work.',
          '11': 'Engaging conversations with friends, joint brainstorming. Unexpected help from friends in realizing your dream.',
          '12': 'Intuition is working like never before. Insights come in dreams or during meditation. A sudden understanding of your hidden talents.'
        },
        'fr': {
          '1': 'Vos idées sont originales et suscitent l\'intérêt. Il est facile de donner l\'impression d\'être une personne progressiste et intelligente.',
          '2': 'Idées brillantes sur la façon de gagner de l\'argent, en particulier via Internet ou les nouvelles technologies. Revenus financiers inattendus.',
          '3': 'Communication spirituelle et engageante. Nouvelles ou connaissances inattendues. Les idées viennent "de nulle part".',
          '4': 'Idées originales pour l\'amélioration de la maison. Une solution inattendue à un problème familial de longue date. Agréables surprises des membres du ménage.',
          '5': 'Flirt non conventionnel et excitant. Un rendez-vous peut être très inhabituel et mémorable. Perspicacités créatives soudaines.',
          '6': 'Solutions innovantes pour les tâches de travail. Vous maîtrisez facilement de nouveaux équipements ou logiciels. Le travail apporte des surprises intéressantes.',
          '7': 'Idées nouvelles pour la relation. Une conversation avec un partenaire peut conduire à des décisions inattendues et positives. Rencontre avec une personne inhabituelle.',
          '8': 'Perspicacités et révélations profondes. Vous pouvez soudainement comprendre l\'essence cachée des choses. Solutions inattendues aux problèmes financiers.',
          '9': 'Un désir soudain de partir en voyage ou de commencer à apprendre quelque chose de nouveau. L\'apprentissage est facile et excitant.',
          '10': 'Idées brillantes et non conventionnelles pour votre carrière. Mise en œuvre réussie de nouvelles technologies ou méthodes de travail.',
          '11': 'Conversations engageantes avec des amis, brainstorming commun. Aide inattendue d\'amis pour réaliser votre rêve.',
          '12': 'L\'intuition fonctionne comme jamais auparavant. Les idées viennent en rêve ou pendant la méditation. Une compréhension soudaine de vos talents cachés.'
        },
        'de': {
          '1': 'Ihre Ideen sind originell und wecken Interesse. Es ist leicht, den Eindruck einer fortschrittlichen und intelligenten Person zu hinterlassen.',
          '2': 'Brillante Ideen, wie man Geld verdienen kann, insbesondere über das Internet oder neue Technologien. Unerwartete finanzielle Einnahmen.',
          '3': 'Witzige und ansprechende Kommunikation. Unerwartete Nachrichten oder Bekanntschaften. Ideen kommen "aus heiterem Himmel".',
          '4': 'Originelle Ideen für die Heimwerkerung. Eine unerwartete Lösung für ein langjähriges Familienproblem. Angenehme Überraschungen von Haushaltsmitgliedern.',
          '5': 'Unkonventionelles, aufregendes Flirten. Ein Date kann sehr ungewöhnlich und unvergesslich sein. Plötzliche kreative Einsichten.',
          '6': 'Innovative Lösungen für Arbeitsaufgaben. Sie beherrschen leicht neue Geräte oder Software. Die Arbeit bringt interessante Überraschungen.',
          '7': 'Frische Ideen für die Beziehung. Ein Gespräch mit einem Partner kann zu unerwarteten und positiven Entscheidungen führen. Treffen mit einer ungewöhnlichen Person.',
          '8': 'Tiefe Einsichten und Offenbarungen. Sie können plötzlich das verborgene Wesen der Dinge verstehen. Unerwartete Lösungen für finanzielle Probleme.',
          '9': 'Ein plötzlicher Wunsch, eine Reise zu unternehmen oder etwas Neues zu lernen. Das Lernen ist einfach und aufregend.',
          '10': 'Brillante, unkonventionelle Ideen für Ihre Karriere. Erfolgreiche Umsetzung neuer Technologien oder Methoden bei der Arbeit.',
          '11': 'Anregende Gespräche mit Freunden, gemeinsames Brainstorming. Unerwartete Hilfe von Freunden bei der Verwirklichung Ihres Traums.',
          '12': 'Die Intuition funktioniert wie nie zuvor. Einsichten kommen im Traum oder während der Meditation. Ein plötzliches Verständnis Ihrer verborgenen Talente.'
        }
      }
    ),
    AspectInterpretation(
      id: 'MOON_TRINE_SATURN',
      title: {
        'ru': 'Гармония Луны и Сатурна',
        'en': 'Moon Trine Saturn',
        'fr': 'Lune Trigone Saturne',
        'de': 'Mond-Trigon-Saturn'
      },
      descriptionGeneral: {
        'ru': 'День эмоциональной стабильности и зрелости. Ваши чувства (Луна) и чувство долга (Сатурн) находятся в гармонии. Легко принимать взвешенные решения, проявлять заботу через практические дела.',
        'en': 'A day of emotional stability and maturity. Your feelings (Moon) and sense of duty (Saturn) are in harmony. It\'s easy to make balanced decisions and show care through practical actions.',
        'fr': 'Une journée de stabilité émotionnelle et de maturité. Vos sentiments (Lune) et votre sens du devoir (Saturne) sont en harmonie. Il est facile de prendre des décisions équilibrées et de montrer de l\'attention par des actions pratiques.',
        'de': 'Ein Tag der emotionalen Stabilität und Reife. Ihre Gefühle (Mond) und Ihr Pflichtbewusstsein (Saturn) sind in Harmonie. Es ist leicht, ausgewogene Entscheidungen zu treffen und Fürsorge durch praktische Taten zu zeigen.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Вы кажетесь надежным и спокойным человеком. Ваши эмоциональные реакции сдержанны и адекватны. Люди вам доверяют.',
          '2': 'Практичный подход к финансам. Хороший день для планирования бюджета, сбережений и обдуманных покупок.',
          '3': 'Спокойное и конструктивное общение. Легко договориться по серьезным вопросам. Хороший совет от старшего родственника.',
          '4': 'Стабильность и порядок в доме. Хороший день для решения бытовых задач и заботы о старших членах семьи.',
          '5': 'Отношения строятся на доверии и верности. Хорошее время для серьезного разговора о будущем. Стабильность в чувствах.',
          '6': 'Вы ответственно и спокойно выполняете свою работу. Хорошие отношения с коллегами, основанные на взаимном уважении.',
          '7': 'Надежность и стабильность в партнерстве. Вы и ваш партнер можете положиться друг на друга. Хороший день для долгосрочных планов.',
          '8': 'Эмоциональная зрелость помогает решать сложные вопросы доверия и финансов. Ощущение безопасности в отношениях.',
          '9': 'Серьезный и практичный подход к учебе или планированию поездки. Вы строите реалистичные и долгосрочные планы.',
          '10': 'Ваша эмоциональная стабильность и надежность замечаются начальством. Укрепление профессиональной репутации.',
          '11': 'Вы можете положиться на своих друзей, особенно на старых и проверенных. Мудрый совет или практическая помощь от них.',
          '12': 'Внутреннее спокойствие и принятие. Легко справляетесь со своими страхами. Ощущение, что все под контролем.'
        },
        'en': {
          '1': 'You appear as a reliable and calm person. Your emotional reactions are restrained and appropriate. People trust you.',
          '2': 'A practical approach to finances. A good day for budget planning, savings, and thoughtful purchases.',
          '3': 'Calm and constructive communication. It\'s easy to agree on serious matters. Good advice from an older relative.',
          '4': 'Stability and order at home. A good day for solving household tasks and caring for older family members.',
          '5': 'Relationships are built on trust and loyalty. A good time for a serious talk about the future. Stability in feelings.',
          '6': 'You perform your work responsibly and calmly. Good relationships with colleagues based on mutual respect.',
          '7': 'Reliability and stability in partnership. You and your partner can rely on each other. A good day for long-term plans.',
          '8': 'Emotional maturity helps resolve complex issues of trust and finance. A feeling of security in the relationship.',
          '9': 'A serious and practical approach to studying or planning a trip. You are making realistic and long-term plans.',
          '10': 'Your emotional stability and reliability are noticed by your superiors. Strengthening of your professional reputation.',
          '11': 'You can rely on your friends, especially old and trusted ones. Wise advice or practical help from them.',
          '12': 'Inner peace and acceptance. You easily cope with your fears. A feeling that everything is under control.'
        },
        'fr': {
          '1': 'Vous apparaissez comme une personne fiable et calme. Vos réactions émotionnelles sont retenues et appropriées. Les gens vous font confiance.',
          '2': 'Une approche pratique des finances. Une bonne journée pour la planification budgétaire, l\'épargne et les achats réfléchis.',
          '3': 'Communication calme et constructive. Il est facile de se mettre d\'accord sur des questions sérieuses. Bons conseils d\'un parent plus âgé.',
          '4': 'Stabilité et ordre à la maison. Une bonne journée pour résoudre les tâches ménagères et s\'occuper des membres plus âgés de la famille.',
          '5': 'Les relations sont basées sur la confiance et la loyauté. Un bon moment pour une conversation sérieuse sur l\'avenir. Stabilité des sentiments.',
          '6': 'Vous effectuez votre travail de manière responsable et calme. Bonnes relations avec les collègues basées sur le respect mutuel.',
          '7': 'Fiabilité et stabilité dans le partenariat. Vous et votre partenaire pouvez compter l\'un sur l\'autre. Une bonne journée pour les plans à long terme.',
          '8': 'La maturité émotionnelle aide à résoudre les problèmes complexes de confiance et de finances. Un sentiment de sécurité dans la relation.',
          '9': 'Une approche sérieuse et pratique pour étudier ou planifier un voyage. Vous faites des plans réalistes et à long terme.',
          '10': 'Votre stabilité émotionnelle et votre fiabilité sont remarquées par vos supérieurs. Renforcement de votre réputation professionnelle.',
          '11': 'Vous pouvez compter sur vos amis, en particulier les anciens et les plus fiables. Des conseils judicieux ou une aide pratique de leur part.',
          '12': 'Paix intérieure et acceptation. Vous gérez facilement vos peurs. Le sentiment que tout est sous contrôle.'
        },
        'de': {
          '1': 'Sie wirken wie eine zuverlässige und ruhige Person. Ihre emotionalen Reaktionen sind zurückhaltend und angemessen. Die Leute vertrauen Ihnen.',
          '2': 'Ein praktischer Ansatz für Finanzen. Ein guter Tag für Budgetplanung, Sparen und durchdachte Einkäufe.',
          '3': 'Ruhige und konstruktive Kommunikation. Es ist leicht, sich in ernsten Angelegenheiten zu einigen. Guter Rat von einem älteren Verwandten.',
          '4': 'Stabilität und Ordnung zu Hause. Ein guter Tag, um Haushaltsaufgaben zu erledigen und sich um ältere Familienmitglieder zu kümmern.',
          '5': 'Beziehungen basieren auf Vertrauen und Loyalität. Eine gute Zeit für ein ernstes Gespräch über die Zukunft. Stabilität der Gefühle.',
          '6': 'Sie erledigen Ihre Arbeit verantwortungsbewusst und ruhig. Gute Beziehungen zu Kollegen, die auf gegenseitigem Respekt beruhen.',
          '7': 'Zuverlässigkeit und Stabilität in der Partnerschaft. Sie und Ihr Partner können sich aufeinander verlassen. Ein guter Tag für langfristige Pläne.',
          '8': 'Emotionale Reife hilft bei der Lösung komplexer Vertrauens- und Finanzfragen. Ein Gefühl der Sicherheit in der Beziehung.',
          '9': 'Ein ernsthafter und praktischer Ansatz zum Studieren oder Planen einer Reise. Sie machen realistische und langfristige Pläne.',
          '10': 'Ihre emotionale Stabilität und Zuverlässigkeit werden von Ihren Vorgesetzten bemerkt. Stärkung Ihres beruflichen Rufs.',
          '11': 'Sie können sich auf Ihre Freunde verlassen, insbesondere auf alte und vertrauenswürdige. Weiser Rat oder praktische Hilfe von ihnen.',
          '12': 'Innerer Frieden und Akzeptanz. Sie kommen leicht mit Ihren Ängsten zurecht. Ein Gefühl, dass alles unter Kontrolle ist.'
        }
      }
    ),
        // === НОВЫЙ БЛОК 5 ===
    AspectInterpretation(
      id: 'MARS_SQUARE_JUPITER',
      title: {
        'ru': 'Конфликт Марса и Юпитера',
        'en': 'Mars Square Jupiter',
        'fr': 'Mars Carré Jupiter',
        'de': 'Mars-Quadrat-Jupiter'
      },
      descriptionGeneral: {
        'ru': 'День чрезмерного оптимизма, который ведет к рискованным и необдуманным действиям. Вы склонны переоценивать свои силы и давать невыполнимые обещания. Избегайте азарта и высокомерия.',
        'en': 'A day of excessive optimism that leads to risky and reckless actions. You tend to overestimate your abilities and make promises you can\'t keep. Avoid gambling and arrogance.',
        'fr': 'Une journée d\'optimisme excessif qui mène à des actions risquées et imprudentes. Vous avez tendance à surestimer vos capacités et à faire des promesses que vous ne pouvez pas tenir. Évitez les jeux de hasard et l\'arrogance.',
        'de': 'Ein Tag exzessiven Optimismus, der zu riskanten und unüberlegten Handlungen führt. Sie neigen dazu, Ihre Fähigkeiten zu überschätzen und Versprechen zu machen, die Sie nicht halten können. Vermeiden Sie Glücksspiel und Arroganz.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Ваша самоуверенность зашкаливает и может перерасти в высокомерие. Склонность к риску и необдуманным поступкам ради демонстрации своей крутизны.',
          '2': 'Финансовый авантюризм. Желание "сорвать куш" может привести к крупным потерям. Неоправданно щедрые траты.',
          '3': 'Вы склонны хвастаться и поучать других. Споры, в которых вы пытаетесь доказать свою правоту любой ценой. Не давайте обещаний.',
          '4': 'Слишком амбициозные и дорогие планы по обустройству дома. Конфликты с семьей из-за вашего эгоизма или желания командовать.',
          '5': 'Безрассудство в любви. Вы можете быть слишком настойчивы или давать слишком много обещаний. Риск проиграть крупную сумму в азартные игры.',
          '6': 'Вы берете на себя слишком много работы, переоценивая свои силы. Конфликты с коллегами из-за вашего всезнайства.',
          '7': 'Конфликты с партнером из-за невыполненных обещаний или разных взглядов. Вы можете давить на партнера своим авторитетом.',
          '8': 'Рискованные финансовые операции, сексуальная неосторожность. Не стоит брать кредиты или участвовать в сомнительных схемах.',
          '9': 'Фанатичное отстаивание своих убеждений. Споры о религии или политике. Планы на путешествие могут быть слишком грандиозными и нереалистичными.',
          '10': 'Конфликт с начальством из-за чрезмерных амбиций. Вы можете пообещать сделать проект, с которым не справитесь, и подвести команду.',
          '11': 'Ссоры с друзьями из-за разных взглядов или невыполненных обещаний. Ваши планы могут быть слишком оторваны от реальности.',
          '12': 'Ваши действия, основанные на слепой вере, могут привести к саморазрушению. Опасайтесь закулисных интриг, в которые вас втягивают.'
        },
        'en': {
          '1': 'Your self-confidence is off the charts and can turn into arrogance. A tendency to take risks and act recklessly to show off.',
          '2': 'Financial adventurism. The desire to "hit the jackpot" can lead to major losses. Unjustifiably generous spending.',
          '3': 'You are prone to boasting and lecturing others. Arguments where you try to prove you are right at any cost. Do not make promises.',
          '4': 'Overly ambitious and expensive home improvement plans. Conflicts with family due to your selfishness or desire to command.',
          '5': 'Recklessness in love. You might be too pushy or make too many promises. Risk of losing a large sum in gambling.',
          '6': 'You take on too much work, overestimating your abilities. Conflicts with colleagues because you act like a know-it-all.',
          '7': 'Conflicts with a partner over unfulfilled promises or different views. You might pressure your partner with your authority.',
          '8': 'Risky financial transactions, sexual carelessness. It is not advisable to take out loans or participate in dubious schemes.',
          '9': 'Fanatical defense of your beliefs. Arguments about religion or politics. Travel plans may be too grandiose and unrealistic.',
          '10': 'Conflict with a boss due to excessive ambition. You might promise to complete a project you can\'t handle, letting the team down.',
          '11': 'Quarrels with friends over different views or unfulfilled promises. Your plans may be too detached from reality.',
          '12': 'Your actions based on blind faith can lead to self-destruction. Beware of behind-the-scenes intrigues you are drawn into.'
        },
        'fr': {
          '1': 'Votre confiance en vous est excessive et peut se transformer en arrogance. Une tendance à prendre des risques et à agir imprudemment pour vous faire valoir.',
          '2': 'Aventurisme financier. Le désir de "toucher le jackpot" peut entraîner des pertes importantes. Dépenses injustifiablement généreuses.',
          '3': 'Vous êtes enclin à vous vanter et à faire la leçon aux autres. Des disputes où vous essayez de prouver que vous avez raison à tout prix. Ne faites pas de promesses.',
          '4': 'Projets d\'amélioration de l\'habitat trop ambitieux et coûteux. Conflits avec la famille en raison de votre égoïsme ou de votre désir de commander.',
          '5': 'Imprudence en amour. Vous pourriez être trop insistant ou faire trop de promesses. Risque de perdre une grosse somme au jeu.',
          '6': 'Vous assumez trop de travail, surestimant vos capacités. Conflits avec les collègues parce que vous agissez en "je-sais-tout".',
          '7': 'Conflits avec un partenaire à cause de promesses non tenues ou de points de vue différents. Vous pourriez faire pression sur votre partenaire avec votre autorité.',
          '8': 'Transactions financières risquées, imprudence sexuelle. Il est déconseillé de contracter des emprunts ou de participer à des projets douteux.',
          '9': 'Défense fanatique de vos croyances. Disputes sur la religion ou la politique. Les projets de voyage peuvent être trop grandioses et irréalistes.',
          '10': 'Conflit avec un patron en raison d\'une ambition excessive. Vous pourriez promettre de réaliser un projet que vous ne pouvez pas gérer, laissant tomber l\'équipe.',
          '11': 'Querelles avec des amis à cause de points de vue différents ou de promesses non tenues. Vos projets peuvent être trop détachés de la réalité.',
          '12': 'Vos actions basées sur une foi aveugle peuvent mener à l\'autodestruction. Méfiez-vous des intrigues en coulisses dans lesquelles vous êtes entraîné.'
        },
        'de': {
          '1': 'Ihr Selbstvertrauen ist übersteigert und kann in Arroganz umschlagen. Eine Tendenz, Risiken einzugehen und rücksichtslos zu handeln, um anzugeben.',
          '2': 'Finanzielles Abenteurertum. Der Wunsch, "den Jackpot zu knacken", kann zu großen Verlusten führen. Ungerechtfertigt großzügige Ausgaben.',
          '3': 'Sie neigen dazu, zu prahlen und andere zu belehren. Auseinandersetzungen, bei denen Sie um jeden Preis Recht behalten wollen. Machen Sie keine Versprechungen.',
          '4': 'Übermäßig ehrgeizige und teure Heimwerkerpläne. Konflikte mit der Familie aufgrund Ihrer Selbstsucht oder Ihres Wunsches zu befehlen.',
          '5': 'Rücksichtslosigkeit in der Liebe. Sie könnten zu aufdringlich sein oder zu viele Versprechungen machen. Risiko, eine große Summe beim Glücksspiel zu verlieren.',
          '6': 'Sie übernehmen zu viel Arbeit und überschätzen Ihre Fähigkeiten. Konflikte mit Kollegen, weil Sie sich wie ein Besserwisser verhalten.',
          '7': 'Konflikte mit einem Partner wegen unerfüllter Versprechen oder unterschiedlicher Ansichten. Sie könnten Ihren Partner mit Ihrer Autorität unter Druck setzen.',
          '8': 'Riskante Finanztransaktionen, sexuelle Unachtsamkeit. Es ist nicht ratsam, Kredite aufzunehmen oder an dubiosen Machenschaften teilzunehmen.',
          '9': 'Fanatische Verteidigung Ihrer Überzeugungen. Auseinandersetzungen über Religion oder Politik. Reisepläne können zu grandios und unrealistisch sein.',
          '10': 'Konflikt mit einem Chef aufgrund übermäßigen Ehrgeizes. Sie könnten versprechen, ein Projekt abzuschließen, das Sie nicht bewältigen können, und das Team im Stich lassen.',
          '11': 'Streit mit Freunden wegen unterschiedlicher Ansichten oder unerfüllter Versprechen. Ihre Pläne könnten zu realitätsfern sein.',
          '12': 'Ihre Handlungen, die auf blindem Glauben beruhen, können zur Selbstzerstörung führen. Hüten Sie sich vor Intrigen hinter den Kulissen, in die Sie hineingezogen werden.'
        }
      }
    ),
    AspectInterpretation(
      id: 'VENUS_OPPOSITION_NEPTUNE',
      title: {
        'ru': 'Противостояние Венеры и Нептуна',
        'en': 'Venus Opposition Neptune',
        'fr': 'Vénus Opposition Neptune',
        'de': 'Venus-Opposition-Neptun'
      },
      descriptionGeneral: {
        'ru': 'День иллюзий и разочарований в любви и финансах. Вы склонны видеть то, что хотите, а не то, что есть на самом деле. Неясность в отношениях, риск обмана или самообмана.',
        'en': 'A day of illusions and disappointments in love and finances. You tend to see what you want to see, not what is real. Ambiguity in relationships, risk of deception or self-deception.',
        'fr': 'Une journée d\'illusions et de déceptions en amour et en finances. Vous avez tendance à voir ce que vous voulez voir, et non la réalité. Ambigüité dans les relations, risque de tromperie ou d\'auto-illusion.',
        'de': 'Ein Tag der Illusionen und Enttäuschungen in Liebe und Finanzen. Sie neigen dazu zu sehen, was Sie sehen wollen, nicht was wirklich ist. Unklarheit in Beziehungen, Gefahr von Täuschung oder Selbsttäuschung.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Вы можете обманываться насчет своей внешности или производимого впечатления. Неясность в самоощущении.',
          '2': 'Финансовый хаос. Деньги могут "утекать сквозь пальцы". Риск быть обманутым или стать жертвой мошенников.',
          '3': 'Вы можете неверно истолковать слова партнера или сами говорить намеками. Путаница в общении.',
          '4': 'Неясная или идеализированная ситуация в семье. Вы можете закрывать глаза на реальные проблемы дома.',
          '5': 'Классический аспект "розовых очков" в любви. Вы влюбляетесь не в человека, а в выдуманный образ, что ведет к разочарованию.',
          '6': 'Путаница в рабочих обязанностях. Вы можете стать жертвой интриг коллег или просто витать в облаках вместо работы.',
          '7': 'Вы идеализируете партнера или, наоборот, он обманывает ваши ожидания. Границы в отношениях размыты.',
          '8': 'Обман в вопросах общих финансов. Тайны и недомолвки в интимной жизни.',
          '9': 'Ваши идеалы и убеждения в любви слишком оторваны от реальности. Разочарование в духовном учителе или поездке.',
          '10': 'Неясные карьерные перспективы. Ваши отношения могут стать предметом сплетен, что вредит репутации.',
          '11': 'Разочарование в друге. Вы можете понять, что ваша дружба была основана на иллюзиях.',
          '12': 'Тайный роман, основанный на самообмане. Вы можете быть "жертвой" в отношениях, не осознавая этого.'
        },
        'en': {
          '1': 'You might be deceiving yourself about your appearance or the impression you make. A lack of clarity in self-perception.',
          '2': 'Financial chaos. Money can "slip through your fingers." Risk of being deceived or falling victim to scammers.',
          '3': 'You might misinterpret your partner\'s words or speak in hints yourself. Confusion in communication.',
          '4': 'An unclear or idealized family situation. You might be turning a blind eye to real problems at home.',
          '5': 'The classic "rose-colored glasses" aspect in love. You fall for an imagined image, not the real person, leading to disappointment.',
          '6': 'Confusion in work duties. You might become a victim of colleagues\' intrigues or simply daydream instead of working.',
          '7': 'You idealize your partner, or they deceive your expectations. Boundaries in the relationship are blurred.',
          '8': 'Deception in matters of joint finances. Secrets and omissions in your intimate life.',
          '9': 'Your ideals and beliefs about love are too detached from reality. Disappointment in a spiritual teacher or a trip.',
          '10': 'Unclear career prospects. Your relationship could become the subject of gossip, harming your reputation.',
          '11': 'Disappointment in a friend. You may realize that your friendship was based on illusions.',
          '12': 'A secret romance based on self-deception. You might be the "victim" in the relationship without realizing it.'
        },
        'fr': {
          '1': 'Vous pourriez vous tromper sur votre apparence ou l\'impression que vous donnez. Un manque de clarté dans la perception de soi.',
          '2': 'Chaos financier. L\'argent peut vous "filer entre les doigts". Risque d\'être trompé ou de devenir la victime d\'escrocs.',
          '3': 'Vous pourriez mal interpréter les paroles de votre partenaire ou parler vous-même à demi-mot. Confusion dans la communication.',
          '4': 'Situation familiale floue ou idéalisée. Vous pourriez fermer les yeux sur de vrais problèmes à la maison.',
          '5': 'L\'aspect classique des "lunettes roses" en amour. Vous tombez amoureux d\'une image imaginaire, pas de la personne réelle, ce qui mène à la déception.',
          '6': 'Confusion dans les tâches professionnelles. Vous pourriez être victime d\'intrigues de collègues ou simplement rêvasser au lieu de travailler.',
          '7': 'Vous idéalisez votre partenaire, ou il trompe vos attentes. Les frontières dans la relation sont floues.',
          '8': 'Tromperie en matière de finances communes. Secrets et omissions dans votre vie intime.',
          '9': 'Vos idéaux et croyances sur l\'amour sont trop détachés de la réalité. Déception envers un guide spirituel ou un voyage.',
          '10': 'Perspectives de carrière floues. Votre relation pourrait faire l\'objet de commérages, nuisant à votre réputation.',
          '11': 'Déception envers un ami. Vous pourriez réaliser que votre amitié était basée sur des illusions.',
          '12': 'Une romance secrète basée sur l\'auto-illusion. Vous pourriez être la "victime" dans la relation sans vous en rendre compte.'
        },
        'de': {
          '1': 'Sie könnten sich über Ihr Aussehen oder den Eindruck, den Sie machen, täuschen. Eine Unklarheit in der Selbstwahrnehmung.',
          '2': 'Finanzielles Chaos. Geld kann Ihnen "durch die Finger rinnen". Gefahr, betrogen oder Opfer von Betrügern zu werden.',
          '3': 'Sie könnten die Worte Ihres Partners falsch interpretieren oder selbst in Andeutungen sprechen. Verwirrung in der Kommunikation.',
          '4': 'Eine unklare oder idealisierte Familiensituation. Sie könnten die Augen vor echten Problemen zu Hause verschließen.',
          '5': 'Der klassische "rosarote Brille"-Aspekt in der Liebe. Sie verlieben sich in ein Fantasiebild, nicht in die reale Person, was zu Enttäuschungen führt.',
          '6': 'Verwirrung bei den Arbeitsaufgaben. Sie könnten Opfer von Intrigen von Kollegen werden oder einfach tagträumen anstatt zu arbeiten.',
          '7': 'Sie idealisieren Ihren Partner, oder er enttäuscht Ihre Erwartungen. Die Grenzen in der Beziehung sind verschwommen.',
          '8': 'Täuschung in Fragen der gemeinsamen Finanzen. Geheimnisse und Auslassungen in Ihrem Intimleben.',
          '9': 'Ihre Ideale und Überzeugungen über die Liebe sind zu realitätsfern. Enttäuschung von einem spirituellen Lehrer oder einer Reise.',
          '10': 'Unklare Karriereaussichten. Ihre Beziehung könnte zum Gegenstand von Klatsch werden, was Ihrem Ruf schadet.',
          '11': 'Enttäuschung von einem Freund. Sie könnten erkennen, dass Ihre Freundschaft auf Illusionen beruhte.',
          '12': 'Eine heimliche Romanze, die auf Selbsttäuschung basiert. Sie könnten das "Opfer" in der Beziehung sein, ohne es zu merken.'
        }
      }
    ),
    AspectInterpretation(
      id: 'MERCURY_SEXTILE_VENUS',
      title: {
        'ru': 'Шанс от Меркурия и Венеры',
        'en': 'Mercury Sextile Venus',
        'fr': 'Mercure Sextile Vénus',
        'de': 'Merkur-Sextil-Venus'
      },
      descriptionGeneral: {
        'ru': 'День приятного и дипломатичного общения. Легко выражать свои симпатии, находить компромиссы и говорить комплименты. Отлично для свиданий, переговоров, светских мероприятий и творческой работы со словом.',
        'en': 'A day of pleasant and diplomatic communication. It\'s easy to express your affections, find compromises, and give compliments. Excellent for dates, negotiations, social events, and creative writing.',
        'fr': 'Une journée de communication agréable et diplomatique. Il est facile d\'exprimer son affection, de trouver des compromis et de faire des compliments. Excellent pour les rendez-vous, les négociations, les événements sociaux et l\'écriture créative.',
        'de': 'Ein Tag der angenehmen und diplomatischen Kommunikation. Es ist leicht, seine Zuneigung auszudrücken, Kompromisse zu finden und Komplimente zu machen. Ausgezeichnet für Verabredungen, Verhandlungen, gesellschaftliche Veranstaltungen und kreatives Schreiben.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Вы очаровательны в общении. Ваши слова звучат приятно и убедительно. Легко произвести хорошее впечатление.',
          '2': 'Хорошая возможность договориться о повышении зарплаты или найти дополнительный доход через общение. Удачные покупки.',
          '3': 'Вы само обаяние в разговоре! Легкий флирт, приятные новости, удачные короткие поездки. Хорошо для написания писем или постов.',
          '4': 'Гармоничное общение в семье. Легко договориться о бытовых вопросах и создать приятную атмосферу дома.',
          '5': 'Идеально для первого свидания. Разговор будет легким и приятным. Легко признаться в своих чувствах или сделать комплимент.',
          '6': 'Приятная атмосфера в рабочем коллективе. Легко договориться с коллегами и сгладить любые острые углы.',
          '7': 'Дипломатичный и приятный диалог с партнером. Легко прийти к согласию. Хороший день для обсуждения отношений.',
          '8': 'Возможность тактично обсудить сложные темы (финансы, интимная жизнь), что укрепит доверие.',
          '9': 'Приятное общение с людьми издалека. Хороший день для изучения языков или искусства.',
          '10': 'Ваше умение говорить красиво и дипломатично может помочь в карьере. Успешные переговоры с начальством.',
          '11': 'Приятная встреча с друзьями. Вы можете стать душой компании благодаря своему остроумию и такту.',
          '12': 'Разговор по душам, который помогает раскрыть тайны и прийти к внутренней гармонии. Приятные размышления в уединении.'
        },
        'en': {
          '1': 'You are charming in conversation. Your words sound pleasant and convincing. It\'s easy to make a good impression.',
          '2': 'A good opportunity to negotiate a raise or find additional income through communication. Successful shopping.',
          '3': 'You are the epitome of charm in conversation! Light flirting, pleasant news, successful short trips. Good for writing letters or posts.',
          '4': 'Harmonious communication in the family. It\'s easy to agree on household matters and create a pleasant atmosphere at home.',
          '5': 'Ideal for a first date. The conversation will be light and pleasant. It\'s easy to confess your feelings or give a compliment.',
          '6': 'A pleasant atmosphere in the work team. It\'s easy to agree with colleagues and smooth over any rough edges.',
          '7': 'A diplomatic and pleasant dialogue with your partner. It\'s easy to reach an agreement. A good day to discuss the relationship.',
          '8': 'An opportunity to tactfully discuss difficult topics (finances, intimate life), which will strengthen trust.',
          '9': 'Pleasant communication with people from afar. A good day for learning languages or art.',
          '10': 'Your ability to speak beautifully and diplomatically can help your career. Successful negotiations with superiors.',
          '11': 'A pleasant meeting with friends. You can become the life of the party thanks to your wit and tact.',
          '12': 'A heart-to-heart conversation that helps reveal secrets and achieve inner harmony. Pleasant reflections in solitude.'
        },
        'fr': {
          '1': 'Vous êtes charmant en conversation. Vos paroles sont agréables et convaincantes. Il est facile de faire bonne impression.',
          '2': 'Une bonne occasion de négocier une augmentation ou de trouver un revenu supplémentaire grâce à la communication. Achats réussis.',
          '3': 'Vous êtes le charme incarné en conversation ! Flirt léger, nouvelles agréables, courts voyages réussis. Bon pour écrire des lettres ou des publications.',
          '4': 'Communication harmonieuse en famille. Il est facile de se mettre d\'accord sur les questions ménagères et de créer une atmosphère agréable à la maison.',
          '5': 'Idéal pour un premier rendez-vous. La conversation sera légère et agréable. Il est facile d\'avouer ses sentiments ou de faire un compliment.',
          '6': 'Ambiance agréable dans l\'équipe de travail. Il est facile de s\'entendre avec les collègues et d\'arrondir les angles.',
          '7': 'Un dialogue diplomatique et agréable avec votre partenaire. Il est facile de parvenir à un accord. Une bonne journée pour discuter de la relation.',
          '8': 'Une occasion de discuter avec tact de sujets difficiles (finances, vie intime), ce qui renforcera la confiance.',
          '9': 'Communication agréable avec des personnes de loin. Une bonne journée pour apprendre les langues ou l\'art.',
          '10': 'Votre capacité à parler avec élégance et diplomatie peut aider votre carrière. Négociations réussies avec les supérieurs.',
          '11': 'Une rencontre agréable avec des amis. Vous pouvez devenir l\'âme de la fête grâce à votre esprit et votre tact.',
          '12': 'Une conversation à cœur ouvert qui aide à révéler des secrets et à atteindre l\'harmonie intérieure. Réflexions agréables en solitude.'
        },
        'de': {
          '1': 'Sie sind im Gespräch charmant. Ihre Worte klingen angenehm und überzeugend. Es ist leicht, einen guten Eindruck zu hinterlassen.',
          '2': 'Eine gute Gelegenheit, eine Gehaltserhöhung auszuhandeln oder durch Kommunikation zusätzliches Einkommen zu finden. Erfolgreiche Einkäufe.',
          '3': 'Sie sind der Inbegriff von Charme im Gespräch! Leichter Flirt, angenehme Nachrichten, erfolgreiche Kurztrips. Gut zum Schreiben von Briefen oder Beiträgen.',
          '4': 'Harmonische Kommunikation in der Familie. Es ist leicht, sich über Haushaltsangelegenheiten zu einigen und eine angenehme Atmosphäre zu Hause zu schaffen.',
          '5': 'Ideal für ein erstes Date. Das Gespräch wird leicht und angenehm sein. Es ist leicht, seine Gefühle zu gestehen oder ein Kompliment zu machen.',
          '6': 'Eine angenehme Atmosphäre im Arbeitsteam. Es ist leicht, sich mit Kollegen zu einigen und eventuelle Ecken und Kanten zu glätten.',
          '7': 'Ein diplomatischer und angenehmer Dialog mit Ihrem Partner. Es ist leicht, eine Einigung zu erzielen. Ein guter Tag, um die Beziehung zu besprechen.',
          '8': 'Eine Gelegenheit, schwierige Themen (Finanzen, Intimleben) taktvoll zu besprechen, was das Vertrauen stärken wird.',
          '9': 'Angenehme Kommunikation mit Menschen aus der Ferne. Ein guter Tag, um Sprachen oder Kunst zu lernen.',
          '10': 'Ihre Fähigkeit, schön und diplomatisch zu sprechen, kann Ihrer Karriere helfen. Erfolgreiche Verhandlungen mit Vorgesetzten.',
          '11': 'Ein angenehmes Treffen mit Freunden. Dank Ihres Witzes und Takts können Sie zum Mittelpunkt der Gesellschaft werden.',
          '12': 'Ein offenes Gespräch, das hilft, Geheimnisse zu lüften und innere Harmonie zu erreichen. Angenehme Reflexionen in der Einsamkeit.'
        }
      }
    ),
    AspectInterpretation(
      id: 'SUN_TRINE_MARS',
      title: {
        'ru': 'Гармония Солнца и Марса',
        'en': 'Sun Trine Mars',
        'fr': 'Soleil Trigone Mars',
        'de': 'Sonne-Trigon-Mars'
      },
      descriptionGeneral: {
        'ru': 'День высокой энергии, уверенности и продуктивности. Ваши желания (Солнце) и действия (Марс) полностью согласованы. Отличное время для начала новых дел, спорта, проявления инициативы и достижения целей.',
        'en': 'A day of high energy, confidence, and productivity. Your desires (Sun) and actions (Mars) are fully aligned. An excellent time for starting new things, sports, taking initiative, and achieving goals.',
        'fr': 'Une journée de grande énergie, de confiance et de productivité. Vos désirs (Soleil) et vos actions (Mars) sont entièrement alignés. Un excellent moment pour commencer de nouvelles choses, faire du sport, prendre des initiatives et atteindre des objectifs.',
        'de': 'Ein Tag hoher Energie, Zuversicht und Produktivität. Ihre Wünsche (Sonne) und Handlungen (Mars) sind vollständig aufeinander abgestimmt. Eine ausgezeichnete Zeit, um neue Dinge zu beginnen, Sport zu treiben, die Initiative zu ergreifen und Ziele zu erreichen.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Вы полны жизненных сил и уверенности. Легко браться за любые дела и вести за собой других. Физическая активность приносит удовольствие.',
          '2': 'Энергичные и успешные действия по увеличению дохода. Вы знаете, чего хотите, и добиваетесь этого.',
          '3': 'Вы говорите прямо, честно и убедительно. Легко отстоять свою точку зрения. Успешные короткие поездки.',
          '4': 'Энергии хватает на решение любых домашних дел. Хороший день для начала ремонта или активного отдыха с семьей.',
          '5': 'Смелость и уверенность в любви. Легко сделать первый шаг или проявить инициативу в отношениях. Успех в спорте.',
          '6': 'Высокая продуктивность на работе. Вы легко справляетесь с большим объемом задач. Отличное самочувствие.',
          '7': 'Вы и ваш партнер действуете как одна команда. Легко договориться о совместных действиях и достичь общих целей.',
          '8': 'Гармония в интимной жизни. Смелость в решении сложных финансовых вопросов. Вы чувствуете свою силу.',
          '9': 'Энергии и энтузиазма хватает для начала путешествия или учебы. Вы уверенно отстаиваете свои убеждения.',
          '10': 'Решительные действия ведут к успеху в карьере. Вы можете проявить себя как лидер и добиться признания.',
          '11': 'Вы можете стать лидером в кругу друзей. Легко организовать совместное мероприятие. Друзья поддерживают ваши начинания.',
          '12': 'Ваша внутренняя сила и уверенность помогают справиться с любыми скрытыми страхами. Интуитивные действия оказываются верными.'
        },
        'en': {
          '1': 'You are full of vitality and confidence. It\'s easy to take on any task and lead others. Physical activity brings pleasure.',
          '2': 'Energetic and successful actions to increase income. You know what you want and you achieve it.',
          '3': 'You speak directly, honestly, and convincingly. It\'s easy to defend your point of view. Successful short trips.',
          '4': 'Enough energy to handle any household chores. A good day to start renovations or have an active family holiday.',
          '5': 'Courage and confidence in love. It\'s easy to make the first move or take the initiative in a relationship. Success in sports.',
          '6': 'High productivity at work. You easily handle a large volume of tasks. Excellent well-being.',
          '7': 'You and your partner act as one team. It\'s easy to agree on joint actions and achieve common goals.',
          '8': 'Harmony in your intimate life. Courage in solving complex financial issues. You feel your strength.',
          '9': 'Enough energy and enthusiasm to start a trip or studies. You confidently defend your beliefs.',
          '10': 'Decisive actions lead to career success. You can prove yourself as a leader and achieve recognition.',
          '11': 'You can become a leader among your friends. It\'s easy to organize a joint event. Friends support your initiatives.',
          '12': 'Your inner strength and confidence help you cope with any hidden fears. Intuitive actions turn out to be correct.'
        },
        'fr': {
          '1': 'Vous êtes plein de vitalité et de confiance. Il est facile de s\'attaquer à n\'importe quelle tâche et de diriger les autres. L\'activité physique apporte du plaisir.',
          '2': 'Actions énergiques et réussies pour augmenter les revenus. Vous savez ce que vous voulez et vous l\'obtenez.',
          '3': 'Vous parlez directement, honnêtement et de manière convaincante. Il est facile de défendre votre point de vue. Voyages courts réussis.',
          '4': 'Assez d\'énergie pour gérer toutes les tâches ménagères. Une bonne journée pour commencer des rénovations ou passer des vacances actives en famille.',
          '5': 'Courage et confiance en amour. Il est facile de faire le premier pas ou de prendre l\'initiative dans une relation. Succès dans le sport.',
          '6': 'Grande productivité au travail. Vous gérez facilement un grand volume de tâches. Excellent bien-être.',
          '7': 'Vous et votre partenaire agissez comme une seule équipe. Il est facile de se mettre d\'accord sur des actions communes et d\'atteindre des objectifs communs.',
          '8': 'Harmonie dans votre vie intime. Courage pour résoudre des problèmes financiers complexes. Vous sentez votre force.',
          '9': 'Assez d\'énergie et d\'enthousiasme pour commencer un voyage ou des études. Vous défendez vos convictions avec confiance.',
          '10': 'Des actions décisives mènent au succès professionnel. Vous pouvez vous affirmer en tant que leader et obtenir la reconnaissance.',
          '11': 'Vous pouvez devenir un leader parmi vos amis. Il est facile d\'organiser un événement commun. Les amis soutiennent vos initiatives.',
          '12': 'Votre force intérieure et votre confiance vous aident à surmonter toutes les peurs cachées. Les actions intuitives s\'avèrent correctes.'
        },
        'de': {
          '1': 'Sie sind voller Vitalität und Selbstvertrauen. Es ist leicht, jede Aufgabe anzugehen und andere zu führen. Körperliche Aktivität bereitet Freude.',
          '2': 'Energische und erfolgreiche Maßnahmen zur Einkommenssteigerung. Sie wissen, was Sie wollen, und Sie erreichen es.',
          '3': 'Sie sprechen direkt, ehrlich und überzeugend. Es ist leicht, Ihren Standpunkt zu verteidigen. Erfolgreiche Kurztrips.',
          '4': 'Genug Energie, um alle Hausarbeiten zu erledigen. Ein guter Tag, um mit Renovierungsarbeiten zu beginnen oder einen aktiven Familienurlaub zu verbringen.',
          '5': 'Mut und Selbstvertrauen in der Liebe. Es ist leicht, den ersten Schritt zu tun oder die Initiative in einer Beziehung zu ergreifen. Erfolg im Sport.',
          '6': 'Hohe Produktivität bei der Arbeit. Sie bewältigen mühelos ein großes Aufgabenvolumen. Ausgezeichnetes Wohlbefinden.',
          '7': 'Sie und Ihr Partner handeln als ein Team. Es ist leicht, sich auf gemeinsame Aktionen zu einigen und gemeinsame Ziele zu erreichen.',
          '8': 'Harmonie in Ihrem Intimleben. Mut bei der Lösung komplexer finanzieller Probleme. Sie spüren Ihre Stärke.',
          '9': 'Genug Energie und Enthusiasmus, um eine Reise oder ein Studium zu beginnen. Sie verteidigen selbstbewusst Ihre Überzeugungen.',
          '10': 'Entschlossenes Handeln führt zum beruflichen Erfolg. Sie können sich als Führungskraft beweisen und Anerkennung erlangen.',
          '11': 'Sie können unter Ihren Freunden eine Führungspersönlichkeit werden. Es ist leicht, eine gemeinsame Veranstaltung zu organisieren. Freunde unterstützen Ihre Initiativen.',
          '12': 'Ihre innere Stärke und Ihr Selbstvertrauen helfen Ihnen, alle verborgenen Ängste zu bewältigen. Intuitive Handlungen erweisen sich als richtig.'
        }
      }
    ),
        // === НОВЫЙ БЛОК 6 ===
    AspectInterpretation(
      id: 'VENUS_SQUARE_SATURN',
      title: {
        'ru': 'Конфликт Венеры и Сатурна',
        'en': 'Venus Square Saturn',
        'fr': 'Vénus Carré Saturne',
        'de': 'Venus-Quadrat-Saturn'
      },
      descriptionGeneral: {
        'ru': 'День эмоциональной холодности, ограничений в любви и финансах. Чувства (Венера) сталкиваются с препятствиями и чувством долга (Сатурн). Возможно ощущение одиночества, критика, задержки.',
        'en': 'A day of emotional coldness, limitations in love and finances. Feelings (Venus) encounter obstacles and a sense of duty (Saturn). A feeling of loneliness, criticism, and delays are possible.',
        'fr': 'Une journée de froideur émotionnelle, de limitations en amour et en finances. Les sentiments (Vénus) rencontrent des obstacles et un sens du devoir (Saturne). Un sentiment de solitude, de critique et de retards sont possibles.',
        'de': 'Ein Tag emotionaler Kälte, Einschränkungen in Liebe und Finanzen. Gefühle (Venus) stoßen auf Hindernisse und ein Pflichtgefühl (Saturn). Ein Gefühl von Einsamkeit, Kritik und Verzögerungen ist möglich.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Вы чувствуете себя скованно и неуверенно в своей привлекательности. Сложно проявлять симпатию и наслаждаться общением.',
          '2': 'Финансовые трудности. Приходится отказывать себе в удовольствиях. Покупки не приносят радости, только чувство вины.',
          '3': 'Сложно найти нужные слова, чтобы выразить чувства. Разговор может быть сухим и формальным. Неприятные новости.',
          '4': 'Ощущение холода и дистанции в семье. Чувство долга перед родными мешает личным желаниям.',
          '5': 'Любовь воспринимается как тяжелая ноша. Свидание может быть неудачным, вы чувствуете себя скованно и не можете расслабиться.',
          '6': 'Отношения с коллегами напряженные. Работа не приносит удовольствия, только усталость. Экономия на себе.',
          '7': 'Партнер кажется критичным и требовательным. Отношения проверяются на прочность через трудности и ограничения.',
          '8': 'Страх близости или финансовые обязательства создают стену между вами и партнером. Снижение либидо.',
          '9': 'Разница в возрасте, статусе или взглядах с партнером становится причиной проблем. Планы на поездку могут сорваться.',
          '10': 'Карьера мешает личной жизни, или наоборот. Сложно найти баланс между работой и отношениями.',
          '11': 'Ощущение одиночества в кругу друзей. Друг может раскритиковать ваш выбор или вкус.',
          '12': 'Старые страхи и комплексы, связанные с любовью и самооценкой, обостряются. Склонность к самоизоляции.'
        },
        'en': {
          '1': 'You feel constrained and insecure about your attractiveness. It\'s hard to show affection and enjoy communication.',
          '2': 'Financial difficulties. You have to deny yourself pleasures. Purchases bring no joy, only guilt.',
          '3': 'It\'s hard to find the right words to express feelings. Conversation can be dry and formal. Unpleasant news.',
          '4': 'A feeling of coldness and distance in the family. A sense of duty to relatives interferes with personal desires.',
          '5': 'Love is perceived as a heavy burden. A date might be unsuccessful; you feel stiff and unable to relax.',
          '6': 'Strained relationships with colleagues. Work brings no pleasure, only fatigue. Skimping on yourself.',
          '7': 'A partner seems critical and demanding. The relationship is tested for strength through difficulties and limitations.',
          '8': 'Fear of intimacy or financial obligations create a wall between you and your partner. Decreased libido.',
          '9': 'Differences in age, status, or views with a partner become a source of problems. Travel plans may be disrupted.',
          '10': 'Career interferes with personal life, or vice versa. It\'s difficult to find a balance between work and relationships.',
          '11': 'A feeling of loneliness in a circle of friends. A friend might criticize your choice or taste.',
          '12': 'Old fears and complexes related to love and self-esteem are exacerbated. A tendency towards self-isolation.'
        },
        'fr': {
          '1': 'Vous vous sentez contraint et peu sûr de votre attrait. Il est difficile de montrer de l\'affection et de profiter de la communication.',
          '2': 'Difficultés financières. Vous devez vous priver de plaisirs. Les achats n\'apportent aucune joie, seulement de la culpabilité.',
          '3': 'Difficile de trouver les mots justes pour exprimer ses sentiments. La conversation peut être sèche et formelle. Nouvelles désagréables.',
          '4': 'Un sentiment de froideur et de distance dans la famille. Un sentiment de devoir envers les parents interfère avec les désirs personnels.',
          '5': 'L\'amour est perçu comme un lourd fardeau. Un rendez-vous peut être infructueux ; vous vous sentez raide et incapable de vous détendre.',
          '6': 'Relations tendues avec les collègues. Le travail n\'apporte aucun plaisir, seulement de la fatigue. Lésiner sur soi-même.',
          '7': 'Un partenaire semble critique et exigeant. La relation est mise à l\'épreuve de sa solidité par des difficultés et des limitations.',
          '8': 'La peur de l\'intimité ou les obligations financières créent un mur entre vous et votre partenaire. Diminution de la libido.',
          '9': 'Les différences d\'âge, de statut ou d\'opinions avec un partenaire deviennent une source de problèmes. Les projets de voyage peuvent être perturbés.',
          '10': 'La carrière interfère avec la vie personnelle, ou vice versa. Il est difficile de trouver un équilibre entre le travail et les relations.',
          '11': 'Un sentiment de solitude dans un cercle d\'amis. Un ami pourrait critiquer votre choix ou vos goûts.',
          '12': 'Les vieilles peurs et complexes liés à l\'amour et à l\'estime de soi sont exacerbés. Tendance à l\'auto-isolement.'
        },
        'de': {
          '1': 'Sie fühlen sich eingeschränkt und unsicher über Ihre Attraktivität. Es ist schwer, Zuneigung zu zeigen und Kommunikation zu genießen.',
          '2': 'Finanzielle Schwierigkeiten. Sie müssen sich Vergnügen versagen. Einkäufe bringen keine Freude, nur Schuldgefühle.',
          '3': 'Es ist schwer, die richtigen Worte zu finden, um Gefühle auszudrücken. Das Gespräch kann trocken und formell sein. Unangenehme Nachrichten.',
          '4': 'Ein Gefühl von Kälte und Distanz in der Familie. Ein Pflichtgefühl gegenüber Verwandten stört persönliche Wünsche.',
          '5': 'Liebe wird als schwere Last empfunden. Ein Date könnte erfolglos sein; Sie fühlen sich steif und können sich nicht entspannen.',
          '6': 'Angespannte Beziehungen zu Kollegen. Die Arbeit bringt keine Freude, nur Müdigkeit. An sich selbst sparen.',
          '7': 'Ein Partner wirkt kritisch und fordernd. Die Beziehung wird durch Schwierigkeiten und Einschränkungen auf ihre Stärke geprüft.',
          '8': 'Angst vor Intimität oder finanzielle Verpflichtungen errichten eine Mauer zwischen Ihnen und Ihrem Partner. Verminderte Libido.',
          '9': 'Unterschiede in Alter, Status oder Ansichten mit einem Partner werden zur Problemquelle. Reisepläne können durchkreuzt werden.',
          '10': 'Die Karriere stört das Privatleben oder umgekehrt. Es ist schwierig, ein Gleichgewicht zwischen Arbeit und Beziehungen zu finden.',
          '11': 'Ein Gefühl der Einsamkeit im Freundeskreis. Ein Freund könnte Ihre Wahl oder Ihren Geschmack kritisieren.',
          '12': 'Alte Ängste und Komplexe in Bezug auf Liebe und Selbstwertgefühl werden verschärft. Eine Tendenz zur Selbstisolation.'
        }
      }
    ),
    AspectInterpretation(
      id: 'MERCURY_OPPOSITION_PLUTO',
      title: {
        'ru': 'Противостояние Меркурия и Плутона',
        'en': 'Mercury Opposition Pluto',
        'fr': 'Mercure Opposition Pluton',
        'de': 'Merkur-Opposition-Pluto'
      },
      descriptionGeneral: {
        'ru': 'День напряженных и манипулятивных разговоров. Информация (Меркурий) становится инструментом борьбы за власть (Плутон). Возможны споры, попытки давления, раскрытие тайн. Избегайте ультиматумов.',
        'en': 'A day of tense and manipulative conversations. Information (Mercury) becomes a tool in a power struggle (Pluto). Arguments, pressure tactics, and revealing secrets are possible. Avoid ultimatums.',
        'fr': 'Une journée de conversations tendues et manipulatrices. L\'information (Mercure) devient un outil dans une lutte de pouvoir (Pluton). Des disputes, des tactiques de pression et la révélation de secrets sont possibles. Évitez les ultimatums.',
        'de': 'Ein Tag angespannter und manipulativer Gespräche. Informationen (Merkur) werden zu einem Werkzeug im Machtkampf (Pluto). Auseinandersetzungen, Druckmittel und die Enthüllung von Geheimnissen sind möglich. Vermeiden Sie Ultimaten.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Ваши слова воспринимаются как давление. Вы можете быть слишком резки и навязчивы в своих идеях, что вызывает сопротивление.',
          '2': 'Тяжелые переговоры о деньгах. Возможен шантаж или давление в финансовых вопросах.',
          '3': 'Конфликт с окружением, который может перерасти в настоящую войну. Раскрытие неприятной информации, сплетни.',
          '4': 'Борьба за власть с членами семьи. Психологическое давление, попытки манипулировать друг другом.',
          '5': 'Ревность и допросы в отношениях. Партнер может пытаться контролировать вас через слова. Тяжелый разговор с детьми.',
          '6': 'Интриги и борьба за влияние на работе. Конфликт с коллегами, который может иметь серьезные последствия.',
          '7': 'Партнер пытается навязать вам свою волю. Открытое противостояние, ультиматумы и выяснение "кто главный".',
          '8': 'Споры из-за общих финансов, налогов или наследства. Раскрытие тайн, которые могут разрушить доверие.',
          '9': 'Жесткая идеологическая борьба. Вы или ваш оппонент пытаетесь "сломать" друг друга своими аргументами.',
          '10': 'Конфликт с начальством, который может стоить вам карьеры. Давление со стороны властных структур.',
          '11': 'Манипуляции в кругу друзей. Друг может использовать информацию против вас.',
          '12': 'Навязчивые и разрушительные мысли. Вы можете стать жертвой чужих интриг или собственных страхов.'
        },
        'en': {
          '1': 'Your words are perceived as pressure. You might be too harsh and obsessive with your ideas, causing resistance.',
          '2': 'Tough negotiations about money. Blackmail or pressure in financial matters is possible.',
          '3': 'A conflict with your surroundings that could escalate into a real war. Disclosure of unpleasant information, gossip.',
          '4': 'A power struggle with family members. Psychological pressure, attempts to manipulate each other.',
          '5': 'Jealousy and interrogations in a relationship. A partner may try to control you with words. A difficult conversation with children.',
          '6': 'Intrigues and struggles for influence at work. A conflict with colleagues that could have serious consequences.',
          '7': 'A partner tries to impose their will on you. Open confrontation, ultimatums, and finding out "who\'s the boss."',
          '8': 'Disputes over joint finances, taxes, or inheritance. Revealing secrets that could destroy trust.',
          '9': 'A fierce ideological battle. You or your opponent tries to "break" each other with arguments.',
          '10': 'A conflict with your boss that could cost you your career. Pressure from authority structures.',
          '11': 'Manipulation within your circle of friends. A friend might use information against you.',
          '12': 'Obsessive and destructive thoughts. You might become a victim of others\' intrigues or your own fears.'
        },
        'fr': {
          '1': 'Vos paroles sont perçues comme une pression. Vous pourriez être trop dur et obsessionnel avec vos idées, provoquant de la résistance.',
          '2': 'Négociations difficiles sur l\'argent. Chantage ou pression dans les affaires financières sont possibles.',
          '3': 'Un conflit avec votre entourage qui pourrait dégénérer en véritable guerre. Divulgation d\'informations désagréables, commérages.',
          '4': 'Lutte de pouvoir avec les membres de la famille. Pression psychologique, tentatives de se manipuler mutuellement.',
          '5': 'Jalousie et interrogatoires dans une relation. Un partenaire peut essayer de vous contrôler avec des mots. Conversation difficile avec les enfants.',
          '6': 'Intrigues et luttes d\'influence au travail. Un conflit avec des collègues qui pourrait avoir de graves conséquences.',
          '7': 'Un partenaire essaie de vous imposer sa volonté. Confrontation ouverte, ultimatums et découverte de "qui est le chef".',
          '8': 'Litiges sur les finances communes, les impôts ou l\'héritage. Révélation de secrets qui pourraient détruire la confiance.',
          '9': 'Une bataille idéologique féroce. Vous ou votre adversaire essayez de vous "briser" mutuellement avec des arguments.',
          '10': 'Un conflit avec votre patron qui pourrait vous coûter votre carrière. Pression des structures d\'autorité.',
          '11': 'Manipulation au sein de votre cercle d\'amis. Un ami pourrait utiliser des informations contre vous.',
          '12': 'Pensées obsessionnelles et destructrices. Vous pourriez devenir victime des intrigues des autres ou de vos propres peurs.'
        },
        'de': {
          '1': 'Ihre Worte werden als Druck empfunden. Sie könnten zu hart und besessen von Ihren Ideen sein, was Widerstand hervorruft.',
          '2': 'Harte Verhandlungen über Geld. Erpressung oder Druck in finanziellen Angelegenheiten sind möglich.',
          '3': 'Ein Konflikt mit Ihrer Umgebung, der zu einem echten Krieg eskalieren könnte. Enthüllung unangenehmer Informationen, Klatsch.',
          '4': 'Ein Machtkampf mit Familienmitgliedern. Psychologischer Druck, Versuche, sich gegenseitig zu manipulieren.',
          '5': 'Eifersucht und Verhöre in einer Beziehung. Ein Partner könnte versuchen, Sie mit Worten zu kontrollieren. Ein schwieriges Gespräch mit Kindern.',
          '6': 'Intrigen und Einflusskämpfe bei der Arbeit. Ein Konflikt mit Kollegen, der schwerwiegende Folgen haben könnte.',
          '7': 'Ein Partner versucht, Ihnen seinen Willen aufzuzwingen. Offene Konfrontation, Ultimaten und die Klärung, "wer der Boss ist".',
          '8': 'Streitigkeiten über gemeinsame Finanzen, Steuern oder Erbschaften. Enthüllung von Geheimnissen, die das Vertrauen zerstören könnten.',
          '9': 'Ein heftiger ideologischer Kampf. Sie oder Ihr Gegner versuchen, sich gegenseitig mit Argumenten zu "brechen".',
          '10': 'Ein Konflikt mit Ihrem Chef, der Sie Ihre Karriere kosten könnte. Druck von Autoritätsstrukturen.',
          '11': 'Manipulation im Freundeskreis. Ein Freund könnte Informationen gegen Sie verwenden.',
          '12': 'Zwanghafte und destruktive Gedanken. Sie könnten Opfer von Intrigen anderer oder Ihrer eigenen Ängste werden.'
        }
      }
    ),
    AspectInterpretation(
      id: 'VENUS_CONJUNCTION_JUPITER',
      title: {
        'ru': 'Соединение Венеры и Юпитера',
        'en': 'Venus Conjunct Jupiter',
        'fr': 'Vénus Conjointe Jupiter',
        'de': 'Venus-Konjunktion-Jupiter'
      },
      descriptionGeneral: {
        'ru': 'Один из самых счастливых дней в году! "Малое" и "Большое" счастье соединяются. Удача в любви, финансах, общении. День щедрости, оптимизма и удовольствий. Позвольте себе радоваться жизни.',
        'en': 'One of the happiest days of the year! The "Lesser" and "Greater" benefics unite. Luck in love, finances, and socializing. A day of generosity, optimism, and pleasure. Allow yourself to enjoy life.',
        'fr': 'L\'un des jours les plus heureux de l\'année ! Le "Petit" et le "Grand" bénéfique s\'unissent. Chance en amour, en finances et en socialisation. Une journée de générosité, d\'optimisme et de plaisir. Permettez-vous de profiter de la vie.',
        'de': 'Einer der glücklichsten Tage des Jahres! Der "kleine" und der "große" Wohltäter vereinen sich. Glück in der Liebe, den Finanzen und im gesellschaftlichen Leben. Ein Tag der Großzügigkeit, des Optimismus und des Vergnügens. Erlauben Sie sich, das Leben zu genießen.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Вы неотразимы! Ваше обаяние и щедрость привлекают к вам людей. Идеальный день для свидания, публичных выступлений и заботы о себе.',
          '2': 'Большая финансовая удача! Возможны крупные денежные поступления, дорогие подарки, очень выгодные покупки. Время для щедрости.',
          '3': 'Общение приносит огромную радость и пользу. Удачные переговоры, приятные знакомства, хорошие новости.',
          '4': 'Счастье и изобилие в доме. Отличный день для большого семейного праздника, покупки недвижимости или предметов роскоши для дома.',
          '5': 'Невероятная удача в любви! Свидание мечты, яркий роман, выигрыш в лотерею. Максимум удовольствий и развлечений.',
          '6': 'Очень приятная и позитивная атмосфера на работе. Легко справляетесь с делами, получаете похвалу и бонусы. Можно позволить себе расслабиться.',
          '7': 'Полная гармония в партнерстве. Идеальный день для свадьбы, помолвки или просто незабываемого дня вместе.',
          '8': 'Удача в вопросах общих финансов, инвестиций, наследства. Глубокая эмоциональная и физическая близость с партнером.',
          '9': 'Идеальный день для начала путешествия мечты. Успех в учебе, издательском деле. Расширение горизонтов приносит счастье.',
          '10': 'Большой успех и признание в карьере. Ваше обаяние помогает достичь самых высоких целей. Повышение социального статуса.',
          '11': 'Исполнение самых смелых желаний! Друзья и покровители помогают вам. Успех в любой коллективной деятельности.',
          '12': 'Ощущение, что вас ведут высшие силы. Удача приходит из неожиданных источников. Отличный день для благотворительности.'
        },
        'en': {
          '1': 'You are irresistible! Your charm and generosity attract people to you. An ideal day for a date, public speaking, and self-care.',
          '2': 'Great financial luck! Large cash inflows, expensive gifts, and very profitable purchases are possible. A time for generosity.',
          '3': 'Communication brings immense joy and benefits. Successful negotiations, pleasant acquaintances, good news.',
          '4': 'Happiness and abundance at home. An excellent day for a big family celebration, buying real estate, or luxury items for the home.',
          '5': 'Incredible luck in love! A dream date, a vibrant romance, winning the lottery. Maximum pleasure and entertainment.',
          '6': 'A very pleasant and positive atmosphere at work. You handle tasks easily, receive praise and bonuses. You can afford to relax.',
          '7': 'Complete harmony in partnership. An ideal day for a wedding, engagement, or just an unforgettable day together.',
          '8': 'Luck in matters of joint finances, investments, inheritance. Deep emotional and physical intimacy with a partner.',
          '9': 'An ideal day to start a dream trip. Success in studies, publishing. Expanding your horizons brings happiness.',
          '10': 'Great success and recognition in your career. Your charm helps you achieve the highest goals. Increased social status.',
          '11': 'Fulfillment of the boldest wishes! Friends and patrons help you. Success in any collective activity.',
          '12': 'A feeling that you are being guided by higher powers. Luck comes from unexpected sources. An excellent day for charity.'
        },
        'fr': {
          '1': 'Vous êtes irrésistible ! Votre charme et votre générosité attirent les gens vers vous. Une journée idéale pour un rendez-vous, une prise de parole en public et prendre soin de soi.',
          '2': 'Grande chance financière ! D\'importantes rentrées d\'argent, des cadeaux coûteux et des achats très rentables sont possibles. Un temps pour la générosité.',
          '3': 'La communication apporte une joie et des avantages immenses. Négociations réussies, connaissances agréables, bonnes nouvelles.',
          '4': 'Bonheur et abondance à la maison. Une excellente journée pour une grande fête de famille, l\'achat d\'un bien immobilier ou d\'articles de luxe pour la maison.',
          '5': 'Chance incroyable en amour ! Un rendez-vous de rêve, une romance vibrante, un gain à la loterie. Maximum de plaisir et de divertissement.',
          '6': 'Une atmosphère très agréable et positive au travail. Vous gérez facilement les tâches, recevez des éloges et des bonus. Vous pouvez vous permettre de vous détendre.',
          '7': 'Harmonie complète dans le partenariat. Une journée idéale pour un mariage, des fiançailles ou simplement une journée inoubliable ensemble.',
          '8': 'Chance en matière de finances communes, d\'investissements, d\'héritage. Intimité émotionnelle et physique profonde avec un partenaire.',
          '9': 'Une journée idéale pour commencer un voyage de rêve. Succès dans les études, l\'édition. Élargir ses horizons apporte le bonheur.',
          '10': 'Grand succès et reconnaissance dans votre carrière. Votre charme vous aide à atteindre les objectifs les plus élevés. Statut social accru.',
          '11': 'Réalisation des souhaits les plus audacieux ! Les amis et les mécènes vous aident. Succès dans toute activité collective.',
          '12': 'Le sentiment d\'être guidé par des puissances supérieures. La chance vient de sources inattendues. Une excellente journée pour la charité.'
        },
        'de': {
          '1': 'Sie sind unwiderstehlich! Ihr Charme und Ihre Großzügigkeit ziehen die Menschen an. Ein idealer Tag für ein Date, öffentliche Reden und Selbstpflege.',
          '2': 'Großes finanzielles Glück! Große Geldzuflüsse, teure Geschenke und sehr profitable Käufe sind möglich. Eine Zeit der Großzügigkeit.',
          '3': 'Kommunikation bringt immense Freude und Vorteile. Erfolgreiche Verhandlungen, angenehme Bekanntschaften, gute Nachrichten.',
          '4': 'Glück und Überfluss zu Hause. Ein ausgezeichneter Tag für eine große Familienfeier, den Kauf von Immobilien oder Luxusartikeln für das Zuhause.',
          '5': 'Unglaubliches Glück in der Liebe! Ein Traum-Date, eine lebendige Romanze, ein Lottogewinn. Maximales Vergnügen und Unterhaltung.',
          '6': 'Eine sehr angenehme und positive Atmosphäre bei der Arbeit. Sie erledigen Aufgaben leicht, erhalten Lob und Boni. Sie können es sich leisten, sich zu entspannen.',
          '7': 'Vollständige Harmonie in der Partnerschaft. Ein idealer Tag für eine Hochzeit, Verlobung oder einfach einen unvergesslichen Tag zusammen.',
          '8': 'Glück in Fragen gemeinsamer Finanzen, Investitionen, Erbschaften. Tiefe emotionale und körperliche Intimität mit einem Partner.',
          '9': 'Ein idealer Tag, um eine Traumreise zu beginnen. Erfolg im Studium, im Verlagswesen. Die Erweiterung des Horizonts bringt Glück.',
          '10': 'Großer Erfolg und Anerkennung in Ihrer Karriere. Ihr Charme hilft Ihnen, die höchsten Ziele zu erreichen. Erhöhter sozialer Status.',
          '11': 'Erfüllung der kühnsten Wünsche! Freunde und Gönner helfen Ihnen. Erfolg bei jeder kollektiven Aktivität.',
          '12': 'Das Gefühl, von höheren Mächten geführt zu werden. Glück kommt aus unerwarteten Quellen. Ein ausgezeichneter Tag für wohltätige Zwecke.'
        }
      }
    ),
    AspectInterpretation(
      id: 'SUN_SEXTILE_SATURN',
      title: {
        'ru': 'Шанс от Солнца и Сатурна',
        'en': 'Sun Sextile Saturn',
        'fr': 'Soleil Sextile Saturne',
        'de': 'Sonne-Sextil-Saturn'
      },
      descriptionGeneral: {
        'ru': 'День для практичных и планомерных достижений. Ваша воля (Солнце) получает поддержку дисциплины (Сатурн). Хорошая возможность получить признание за свой труд, заручиться поддержкой авторитетов.',
        'en': 'A day for practical and systematic achievements. Your will (Sun) is supported by discipline (Saturn). A good opportunity to gain recognition for your work and enlist the support of authorities.',
        'fr': 'Une journée pour des réalisations pratiques et systématiques. Votre volonté (Soleil) est soutenue par la discipline (Saturne). Une bonne occasion d\'obtenir la reconnaissance pour votre travail et de solliciter le soutien des autorités.',
        'de': 'Ein Tag für praktische und systematische Erfolge. Ihr Wille (Sonne) wird durch Disziplin (Saturn) unterstützt. Eine gute Gelegenheit, Anerkennung für Ihre Arbeit zu erlangen und die Unterstützung von Autoritäten zu gewinnen.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Вы производите впечатление зрелого и ответственного человека. Хороший день для того, чтобы взять на себя лидерство в серьезном проекте.',
          '2': 'Хорошая возможность стабилизировать свои финансы. Упорный труд приносит заслуженную награду. Удачные покупки практичных вещей.',
          '3': 'Конструктивный диалог, который приводит к конкретным результатам. Хорошая возможность получить мудрый совет от старшего человека.',
          '4': 'Возможность укрепить фундамент вашего дома и семьи. Успешное решение вопросов с недвижимостью или пожилыми родственниками.',
          '5': 'Возможность перевести отношения на более серьезный и стабильный уровень. Практичный подход к творчеству приносит плоды.',
          '6': 'Ваш профессионализм и усердие будут замечены. Хороший день для того, чтобы навести порядок в делах и составить план.',
          '7': 'Партнерство становится более стабильным и надежным. Хорошая возможность для заключения долгосрочных соглашений.',
          '8': 'Возможность успешно решить вопросы, связанные со страховкой, налогами или кредитами. Вы чувствуете контроль над ситуацией.',
          '9': 'Хорошая возможность для начала серьезного обучения или планирования деловой поездки. Ваши планы реалистичны.',
          '10': 'Вы можете получить поддержку от начальства или укрепить свой авторитет. Ваш труд и ответственность вознаграждаются.',
          '11': 'Старые и проверенные друзья окажут поддержку. Хорошая возможность для реализации долгосрочных совместных планов.',
          '12': 'Работа в уединении приносит хорошие результаты. Вы можете справиться со своими страхами через дисциплину и самоанализ.'
        },
        'en': {
          '1': 'You give the impression of a mature and responsible person. A good day to take the lead in a serious project.',
          '2': 'A good opportunity to stabilize your finances. Hard work brings a well-deserved reward. Successful purchases of practical items.',
          '3': 'A constructive dialogue that leads to concrete results. A good opportunity to get wise advice from an older person.',
          '4': 'An opportunity to strengthen the foundation of your home and family. Successful resolution of issues with real estate or elderly relatives.',
          '5': 'An opportunity to take a relationship to a more serious and stable level. A practical approach to creativity bears fruit.',
          '6': 'Your professionalism and diligence will be noticed. A good day to put things in order and make a plan.',
          '7': 'The partnership becomes more stable and reliable. A good opportunity for making long-term agreements.',
          '8': 'An opportunity to successfully resolve issues related to insurance, taxes, or loans. You feel in control of the situation.',
          '9': 'A good opportunity to start serious studies or plan a business trip. Your plans are realistic.',
          '10': 'You can get support from your superiors or strengthen your authority. Your hard work and responsibility are rewarded.',
          '11': 'Old and trusted friends will provide support. A good opportunity to implement long-term joint plans.',
          '12': 'Work in solitude yields good results. You can cope with your fears through discipline and self-analysis.'
        },
        'fr': {
          '1': 'Vous donnez l\'impression d\'une personne mature et responsable. Une bonne journée pour prendre la direction d\'un projet sérieux.',
          '2': 'Une bonne occasion de stabiliser vos finances. Le travail acharné apporte une récompense bien méritée. Achats réussis d\'articles pratiques.',
          '3': 'Un dialogue constructif qui mène à des résultats concrets. Une bonne occasion d\'obtenir de sages conseils d\'une personne plus âgée.',
          '4': 'Une opportunité de renforcer les fondations de votre foyer et de votre famille. Résolution réussie des problèmes immobiliers ou avec des parents âgés.',
          '5': 'Une opportunité de faire passer une relation à un niveau plus sérieux et stable. Une approche pratique de la créativité porte ses fruits.',
          '6': 'Votre professionnalisme et votre diligence seront remarqués. Une bonne journée pour mettre de l\'ordre dans vos affaires et faire un plan.',
          '7': 'Le partenariat devient plus stable et fiable. Une bonne occasion de conclure des accords à long terme.',
          '8': 'Une opportunité de résoudre avec succès les problèmes liés à l\'assurance, aux impôts ou aux prêts. Vous vous sentez en contrôle de la situation.',
          '9': 'Une bonne occasion de commencer des études sérieuses ou de planifier un voyage d\'affaires. Vos projets sont réalistes.',
          '10': 'Vous pouvez obtenir le soutien de vos supérieurs ou renforcer votre autorité. Votre travail acharné et votre responsabilité sont récompensés.',
          '11': 'De vieux et fidèles amis vous apporteront leur soutien. Une bonne occasion de mettre en œuvre des plans communs à long terme.',
          '12': 'Le travail en solitude donne de bons résultats. Vous pouvez surmonter vos peurs par la discipline et l\'auto-analyse.'
        },
        'de': {
          '1': 'Sie machen den Eindruck einer reifen und verantwortungsbewussten Person. Ein guter Tag, um die Führung in einem ernsten Projekt zu übernehmen.',
          '2': 'Eine gute Gelegenheit, Ihre Finanzen zu stabilisieren. Harte Arbeit bringt eine wohlverdiente Belohnung. Erfolgreiche Käufe praktischer Gegenstände.',
          '3': 'Ein konstruktiver Dialog, der zu konkreten Ergebnissen führt. Eine gute Gelegenheit, weisen Rat von einer älteren Person zu erhalten.',
          '4': 'Eine Gelegenheit, das Fundament Ihres Hauses und Ihrer Familie zu stärken. Erfolgreiche Lösung von Problemen mit Immobilien oder älteren Verwandten.',
          '5': 'Eine Gelegenheit, eine Beziehung auf eine ernstere und stabilere Ebene zu bringen. Ein praktischer Ansatz zur Kreativität trägt Früchte.',
          '6': 'Ihre Professionalität und Ihr Fleiß werden bemerkt. Ein guter Tag, um Ordnung zu schaffen und einen Plan zu machen.',
          '7': 'Die Partnerschaft wird stabiler und zuverlässiger. Eine gute Gelegenheit für langfristige Vereinbarungen.',
          '8': 'Eine Gelegenheit, Probleme im Zusammenhang mit Versicherungen, Steuern oder Krediten erfolgreich zu lösen. Sie fühlen sich in Kontrolle der Situation.',
          '9': 'Eine gute Gelegenheit, ein ernsthaftes Studium zu beginnen oder eine Geschäftsreise zu planen. Ihre Pläne sind realistisch.',
          '10': 'Sie können Unterstützung von Ihren Vorgesetzten erhalten oder Ihre Autorität stärken. Ihre harte Arbeit und Verantwortung werden belohnt.',
          '11': 'Alte und vertrauenswürdige Freunde werden Unterstützung leisten. Eine gute Gelegenheit, langfristige gemeinsame Pläne umzusetzen.',
          '12': 'Arbeit in der Einsamkeit liefert gute Ergebnisse. Sie können Ihre Ängste durch Disziplin und Selbstanalyse bewältigen.'
        }
      }
    ),
        // === НОВЫЙ БЛОК 7 ===
    AspectInterpretation(
      id: 'MARS_SQUARE_NEPTUNE',
      title: {
        'ru': 'Конфликт Марса и Нептуна',
        'en': 'Mars Square Neptune',
        'fr': 'Mars Carré Neptune',
        'de': 'Mars-Quadrat-Neptun'
      },
      descriptionGeneral: {
        'ru': 'День растерянности и нехватки энергии. Ваши действия (Марс) путаны и неэффективны из-за иллюзий (Нептун). Возможен самообман, обман со стороны других, лень и тайные интриги. Не время для начинаний.',
        'en': 'A day of confusion and lack of energy. Your actions (Mars) are confused and ineffective due to illusions (Neptune). Self-deception, deception from others, laziness, and secret intrigues are possible. Not a time for beginnings.',
        'fr': 'Une journée de confusion et de manque d\'énergie. Vos actions (Mars) sont confuses et inefficaces à cause des illusions (Neptune). L\'auto-illusion, la tromperie des autres, la paresse et les intrigues secrètes sont possibles. Ce n\'est pas le moment de commencer quoi que ce soit.',
        'de': 'Ein Tag der Verwirrung und des Energiemangels. Ihre Handlungen (Mars) sind aufgrund von Illusionen (Neptun) verwirrt und ineffektiv. Selbsttäuschung, Täuschung durch andere, Faulheit und geheime Intrigen sind möglich. Keine Zeit für Anfänge.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Вы чувствуете себя слабым, неуверенным и не понимаете, чего хотите. Ваши действия могут быть нелогичными и приводить к странным последствиям.',
          '2': 'Риск финансовых потерь из-за мошенничества или собственной невнимательности. Деньги могут "утекать" незаметно.',
          '3': 'Путаница в общении, ложь, недомолвки. Сложно донести свою мысль. Есть риск заблудиться или попасть в неприятности в дороге.',
          '4': 'Странная и неясная атмосфера дома. Возможны тайные интриги в семье, проблемы с водопроводом или утечки.',
          '5': 'Обман в любви. Вы можете идеализировать партнера или стать жертвой его неискренности. Творческий кризис, отсутствие вдохновения.',
          '6': 'Полный упадок сил на работе. Сложно заставить себя что-то делать. Риск ошибок, интриг со стороны коллег. Берегите здоровье.',
          '7': 'Партнер может быть нечестен с вами, или вы сами обманываетесь на его счет. Отношения туманны и неопределенны.',
          '8': 'Тайные сексуальные связи, основанные на иллюзиях. Риск быть втянутым в финансовые махинации.',
          '9': 'Ваши идеалы и убеждения не выдерживают проверки реальностью. Планы на путешествие могут сорваться из-за путаницы.',
          '10': 'Неясные карьерные перспективы. Риск стать жертвой подковерных игр и интриг, которые вредят вашей репутации.',
          '11': 'Обман со стороны друзей. Вы можете разочароваться в ком-то из своего окружения. Цели и мечты кажутся недостижимыми.',
          '12': 'Ваши тайные враги активизируются. Склонность к саморазрушительному поведению. Обостряются фобии и зависимости.'
        },
        'en': {
          '1': 'You feel weak, insecure, and don\'t understand what you want. Your actions might be illogical and lead to strange consequences.',
          '2': 'Risk of financial loss due to fraud or your own carelessness. Money can "slip away" unnoticed.',
          '3': 'Confusion in communication, lies, omissions. It\'s hard to get your point across. There is a risk of getting lost or getting into trouble on the road.',
          '4': 'A strange and unclear atmosphere at home. Secret family intrigues, problems with plumbing or leaks are possible.',
          '5': 'Deception in love. You might idealize your partner or become a victim of their insincerity. Creative crisis, lack of inspiration.',
          '6': 'A complete lack of energy at work. It\'s hard to make yourself do anything. Risk of mistakes, intrigues from colleagues. Take care of your health.',
          '7': 'A partner may be dishonest with you, or you are deceiving yourself about them. The relationship is foggy and uncertain.',
          '8': 'Secret sexual relationships based on illusions. Risk of being drawn into financial fraud.',
          '9': 'Your ideals and beliefs do not stand up to reality. Travel plans may be disrupted due to confusion.',
          '10': 'Unclear career prospects. Risk of becoming a victim of behind-the-scenes games and intrigues that harm your reputation.',
          '11': 'Deception from friends. You may be disappointed in someone from your circle. Goals and dreams seem unattainable.',
          '12': 'Your secret enemies become active. A tendency for self-destructive behavior. Phobias and addictions are exacerbated.'
        },
        'fr': {
          '1': 'Vous vous sentez faible, peu sûr de vous et ne comprenez pas ce que vous voulez. Vos actions peuvent être illogiques et entraîner des conséquences étranges.',
          '2': 'Risque de perte financière due à la fraude ou à votre propre négligence. L\'argent peut "s\'échapper" sans que vous vous en aperceviez.',
          '3': 'Confusion dans la communication, mensonges, omissions. Difficile de faire passer votre message. Risque de se perdre ou d\'avoir des ennuis sur la route.',
          '4': 'Ambiance étrange et floue à la maison. Des intrigues familiales secrètes, des problèmes de plomberie ou des fuites sont possibles.',
          '5': 'Tromperie en amour. Vous pourriez idéaliser votre partenaire ou être victime de son manque de sincérité. Crise créative, manque d\'inspiration.',
          '6': 'Manque total d\'énergie au travail. Difficile de se motiver. Risque d\'erreurs, d\'intrigues de la part des collègues. Prenez soin de votre santé.',
          '7': 'Un partenaire peut être malhonnête avec vous, ou vous vous trompez à son sujet. La relation est floue et incertaine.',
          '8': 'Relations sexuelles secrètes basées sur des illusions. Risque d\'être entraîné dans une fraude financière.',
          '9': 'Vos idéaux et vos croyances ne résistent pas à la réalité. Les projets de voyage peuvent être perturbés par la confusion.',
          '10': 'Perspectives de carrière floues. Risque de devenir victime de jeux de coulisses et d\'intrigues qui nuisent à votre réputation.',
          '11': 'Tromperie de la part d\'amis. Vous pourriez être déçu par quelqu\'un de votre entourage. Les objectifs et les rêves semblent inaccessibles.',
          '12': 'Vos ennemis secrets s\'activent. Tendance à un comportement autodestructeur. Les phobies et les dépendances sont exacerbées.'
        },
        'de': {
          '1': 'Sie fühlen sich schwach, unsicher und verstehen nicht, was Sie wollen. Ihre Handlungen könnten unlogisch sein und zu seltsamen Konsequenzen führen.',
          '2': 'Risiko von Finanzverlusten durch Betrug oder eigene Unachtsamkeit. Geld kann unbemerkt "entschlüpfen".',
          '3': 'Verwirrung in der Kommunikation, Lügen, Auslassungen. Es ist schwer, seinen Standpunkt klarzumachen. Es besteht die Gefahr, sich zu verirren oder unterwegs in Schwierigkeiten zu geraten.',
          '4': 'Eine seltsame und unklare Atmosphäre zu Hause. Geheime Familienintrigen, Probleme mit den Leitungen oder Lecks sind möglich.',
          '5': 'Täuschung in der Liebe. Sie könnten Ihren Partner idealisieren oder Opfer seiner Unaufrichtigkeit werden. Kreative Krise, mangelnde Inspiration.',
          '6': 'Ein völliger Energiemangel bei der Arbeit. Es ist schwer, sich zu etwas zu zwingen. Risiko von Fehlern, Intrigen von Kollegen. Achten Sie auf Ihre Gesundheit.',
          '7': 'Ein Partner könnte unehrlich zu Ihnen sein, oder Sie täuschen sich über ihn. Die Beziehung ist neblig und unsicher.',
          '8': 'Geheime sexuelle Beziehungen, die auf Illusionen beruhen. Risiko, in Finanzbetrug verwickelt zu werden.',
          '9': 'Ihre Ideale und Überzeugungen halten der Realität nicht stand. Reisepläne können aufgrund von Verwirrung gestört werden.',
          '10': 'Unklare Karriereaussichten. Gefahr, Opfer von Machtspielen und Intrigen hinter den Kulissen zu werden, die Ihrem Ruf schaden.',
          '11': 'Täuschung von Freunden. Sie könnten von jemandem aus Ihrem Kreis enttäuscht werden. Ziele und Träume scheinen unerreichbar.',
          '12': 'Ihre geheimen Feinde werden aktiv. Eine Tendenz zu selbstzerstörerischem Verhalten. Phobien und Süchte werden verschärft.'
        }
      }
    ),
    AspectInterpretation(
      id: 'SUN_SQUARE_JUPITER',
      title: {
        'ru': 'Конфликт Солнца и Юпитера',
        'en': 'Sun Square Jupiter',
        'fr': 'Soleil Carré Jupiter',
        'de': 'Sonne-Quadrat-Jupiter'
      },
      descriptionGeneral: {
        'ru': 'День чрезмерной самоуверенности и неоправданного оптимизма. Ваше эго (Солнце) раздувается (Юпитер), что ведет к хвастовству, лени и невыполненным обещаниям. Избегайте излишеств.',
        'en': 'A day of overconfidence and unwarranted optimism. Your ego (Sun) gets inflated (Jupiter), leading to boasting, laziness, and unfulfilled promises. Avoid excesses.',
        'fr': 'Une journée d\'excès de confiance et d\'optimisme injustifié. Votre ego (Soleil) est gonflé (Jupiter), ce qui mène à la vantardise, à la paresse et aux promesses non tenues. Évitez les excès.',
        'de': 'Ein Tag des übermäßigen Selbstvertrauens und ungerechtfertigten Optimismus. Ihr Ego (Sonne) wird aufgeblasen (Jupiter), was zu Angeberei, Faulheit und unerfüllten Versprechen führt. Vermeiden Sie Exzesse.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Вы склонны к высокомерию и демонстративному поведению. Трудно адекватно оценить себя и свои возможности.',
          '2': 'Неоправданные траты, потакание своим слабостям. Вы можете потратить больше, чем можете себе позволить, чтобы произвести впечатление.',
          '3': 'Пустые обещания и хвастовство. Вы можете говорить много, но по делу – мало. Споры из-за желания доказать свою правоту.',
          '4': 'Слишком грандиозные и нереалистичные планы, связанные с домом. Обещания семье, которые вы не сможете выполнить.',
          '5': 'В любви вы можете быть слишком навязчивы или давать невыполнимые обещания. Риск проигрыша в азартные игры.',
          '6': 'Лень и нежелание заниматься рутиной. Вы можете взяться за слишком большой проект на работе и не справиться с ним.',
          '7': 'Конфликт с партнером на почве разных взглядов или невыполненных обещаний. Тенденция поучать партнера.',
          '8': 'Рискованные финансовые решения, неоправданные кредиты. Переоценка своих возможностей в совместном бюджете.',
          '9': 'Догматизм и фанатичность. Вы считаете свое мнение единственно верным. Нереалистичные планы на путешествия.',
          '10': 'Конфликт с начальством из-за вашей самоуверенности. Вы можете пообещать слишком много, что повредит репутации.',
          '11': 'Высокомерное поведение с друзьями. Вы можете считать себя лучше других. Нереалистичные совместные планы.',
          '12': 'Потакание своим слабостям в уединении. Вы можете обманывать себя насчет своих истинных возможностей.'
        },
        'en': {
          '1': 'You are prone to arrogance and demonstrative behavior. It\'s difficult to assess yourself and your capabilities adequately.',
          '2': 'Unjustified spending, indulging your weaknesses. You might spend more than you can afford to make an impression.',
          '3': 'Empty promises and boasting. You might talk a lot but say little of substance. Arguments due to the desire to prove you are right.',
          '4': 'Overly grandiose and unrealistic plans related to your home. Promises to your family that you cannot fulfill.',
          '5': 'In love, you might be too pushy or make unfulfillable promises. Risk of losing at gambling.',
          '6': 'Laziness and unwillingness to do routine work. You might take on too large a project at work and fail to handle it.',
          '7': 'Conflict with a partner over different views or unfulfilled promises. A tendency to lecture your partner.',
          '8': 'Risky financial decisions, unjustified loans. Overestimation of your capabilities in the joint budget.',
          '9': 'Dogmatism and fanaticism. You consider your opinion to be the only correct one. Unrealistic travel plans.',
          '10': 'Conflict with your boss due to your overconfidence. You might promise too much, which will harm your reputation.',
          '11': 'Arrogant behavior with friends. You might consider yourself better than others. Unrealistic joint plans.',
          '12': 'Indulging your weaknesses in solitude. You might deceive yourself about your true capabilities.'
        },
        'fr': {
          '1': 'Vous êtes enclin à l\'arrogance et au comportement démonstratif. Il est difficile de vous évaluer et d\'évaluer vos capacités de manière adéquate.',
          '2': 'Dépenses injustifiées, complaisance envers vos faiblesses. Vous pourriez dépenser plus que vous ne pouvez vous le permettre pour impressionner.',
          '3': 'Promesses vides et vantardise. Vous parlez beaucoup mais dites peu de choses substantielles. Disputes dues au désir de prouver que vous avez raison.',
          '4': 'Plans trop grandioses et irréalistes liés à votre maison. Promesses à votre famille que vous ne pouvez pas tenir.',
          '5': 'En amour, vous pourriez être trop insistant ou faire des promesses irréalisables. Risque de perdre au jeu.',
          '6': 'Paresse et refus de faire le travail de routine. Vous pourriez entreprendre un projet trop vaste au travail et ne pas y arriver.',
          '7': 'Conflit avec un partenaire sur des points de vue différents ou des promesses non tenues. Tendance à sermonner votre partenaire.',
          '8': 'Décisions financières risquées, prêts injustifiés. Surestimation de vos capacités dans le budget commun.',
          '9': 'Dogmatisme et fanatisme. Vous considérez votre opinion comme la seule correcte. Plans de voyage irréalistes.',
          '10': 'Conflit avec votre patron en raison de votre excès de confiance. Vous pourriez promettre trop, ce qui nuira à votre réputation.',
          '11': 'Comportement arrogant avec des amis. Vous pourriez vous considérer meilleur que les autres. Plans communs irréalistes.',
          '12': 'Complaisance envers vos faiblesses en solitude. Vous pourriez vous tromper sur vos véritables capacités.'
        },
        'de': {
          '1': 'Sie neigen zu Arroganz und demonstrativem Verhalten. Es ist schwierig, sich und seine Fähigkeiten angemessen einzuschätzen.',
          '2': 'Ungerechtfertigte Ausgaben, Nachgeben gegenüber Ihren Schwächen. Sie könnten mehr ausgeben, als Sie sich leisten können, um Eindruck zu schinden.',
          '3': 'Leere Versprechungen und Angeberei. Sie reden vielleicht viel, sagen aber wenig Substanzielles. Auseinandersetzungen aufgrund des Wunsches, Recht zu haben.',
          '4': 'Übermäßig grandiose und unrealistische Pläne für Ihr Zuhause. Versprechen an Ihre Familie, die Sie nicht halten können.',
          '5': 'In der Liebe könnten Sie zu aufdringlich sein oder unerfüllbare Versprechungen machen. Risiko, beim Glücksspiel zu verlieren.',
          '6': 'Faulheit und Unwillen, Routinearbeit zu erledigen. Sie könnten ein zu großes Projekt bei der Arbeit übernehmen und es nicht bewältigen.',
          '7': 'Konflikt mit einem Partner wegen unterschiedlicher Ansichten oder unerfüllter Versprechen. Eine Tendenz, Ihren Partner zu belehren.',
          '8': 'Riskante finanzielle Entscheidungen, ungerechtfertigte Kredite. Überschätzung Ihrer Fähigkeiten im gemeinsamen Budget.',
          '9': 'Dogmatismus und Fanatismus. Sie halten Ihre Meinung für die einzig richtige. Unrealistische Reisepläne.',
          '10': 'Konflikt mit Ihrem Chef aufgrund Ihres übermäßigen Selbstvertrauens. Sie könnten zu viel versprechen, was Ihrem Ruf schadet.',
          '11': 'Arrogantes Verhalten gegenüber Freunden. Sie könnten sich für besser als andere halten. Unrealistische gemeinsame Pläne.',
          '12': 'Nachgeben gegenüber Ihren Schwächen in der Einsamkeit. Sie könnten sich über Ihre wahren Fähigkeiten täuschen.'
        }
      }
    ),
    AspectInterpretation(
      id: 'VENUS_TRINE_PLUTO',
      title: {
        'ru': 'Гармония Венеры и Плутона',
        'en': 'Venus Trine Pluto',
        'fr': 'Vénus Trigone Pluton',
        'de': 'Venus-Trigon-Pluto'
      },
      descriptionGeneral: {
        'ru': 'День глубоких и интенсивных чувств. Любовь (Венера) приобретает силу и глубину трансформации (Плутон). Возможность исцелить отношения, достичь невероятной близости и страсти.',
        'en': 'A day of deep and intense feelings. Love (Venus) gains the power and depth of transformation (Pluto). An opportunity to heal relationships, achieve incredible intimacy and passion.',
        'fr': 'Une journée de sentiments profonds et intenses. L\'amour (Vénus) acquiert le pouvoir et la profondeur de la transformation (Pluton). Une opportunité de guérir les relations, d\'atteindre une intimité et une passion incroyables.',
        'de': 'Ein Tag tiefer und intensiver Gefühle. Die Liebe (Venus) gewinnt die Kraft und Tiefe der Transformation (Pluto). Eine Gelegenheit, Beziehungen zu heilen, unglaubliche Intimität und Leidenschaft zu erreichen.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Ваша привлекательность обладает магнетической силой. Вы способны глубоко влиять на других своим обаянием.',
          '2': 'Возможность крупных финансовых поступлений. Вы интуитивно чувствуете, куда вложить деньги для их преумножения. Финансовое могущество.',
          '3': 'Ваши слова обладают целительной силой. Глубокий и честный разговор может кардинально изменить отношения к лучшему.',
          '4': 'Глубокая трансформация и исцеление семейных отношений. Вы можете разрешить давние проблемы и укрепить родовые связи.',
          '5': 'Всепоглощающая страсть и глубокая эмоциональная связь в любви. Отношения могут выйти на совершенно новый уровень.',
          '6': 'Вы способны трансформировать рабочую атмосферу к лучшему. Глубокое удовлетворение от своей работы.',
          '7': 'Отношения с партнером становятся глубже и интенсивнее. Вы чувствуете почти мистическую связь друг с другом. Исцеление партнерства.',
          '8': 'Невероятно сильное сексуальное притяжение и эмоциональная близость. Успех в вопросах совместных финансов, инвестиций.',
          '9': 'Путешествие или обучение может привести к глубокой внутренней трансформации. Ваши взгляды на любовь меняются.',
          '10': 'Ваше обаяние и харизма помогают вам добиться власти и влияния в карьере.',
          '11': 'Глубокие и искренние отношения с друзьями. Вы можете стать катализатором позитивных изменений в вашем коллективе.',
          '12': 'Исцеление глубоких психологических травм через любовь и принятие. Ваша интуиция и способность к состраданию очень сильны.'
        },
        'en': {
          '1': 'Your attractiveness has a magnetic power. You are able to deeply influence others with your charm.',
          '2': 'The possibility of large financial inflows. You intuitively feel where to invest money to multiply it. Financial power.',
          '3': 'Your words have healing power. A deep and honest conversation can radically change a relationship for the better.',
          '4': 'Deep transformation and healing of family relationships. You can resolve long-standing problems and strengthen family ties.',
          '5': 'All-consuming passion and a deep emotional connection in love. The relationship can reach a completely new level.',
          '6': 'You are able to transform the work atmosphere for the better. Deep satisfaction from your work.',
          '7': 'The relationship with your partner becomes deeper and more intense. You feel an almost mystical connection with each other. Healing of the partnership.',
          '8': 'Incredibly strong sexual attraction and emotional intimacy. Success in matters of joint finances, investments.',
          '9': 'A trip or study can lead to deep inner transformation. Your views on love are changing.',
          '10': 'Your charm and charisma help you achieve power and influence in your career.',
          '11': 'Deep and sincere relationships with friends. You can be a catalyst for positive change in your group.',
          '12': 'Healing of deep psychological traumas through love and acceptance. Your intuition and capacity for compassion are very strong.'
        },
        'fr': {
          '1': 'Votre attrait a un pouvoir magnétique. Vous êtes capable d\'influencer profondément les autres avec votre charme.',
          '2': 'La possibilité d\'importantes rentrées financières. Vous sentez intuitivement où investir de l\'argent pour le multiplier. Pouvoir financier.',
          '3': 'Vos paroles ont un pouvoir de guérison. Une conversation profonde et honnête peut radicalement changer une relation pour le mieux.',
          '4': 'Transformation profonde et guérison des relations familiales. Vous pouvez résoudre des problèmes de longue date et renforcer les liens familiaux.',
          '5': 'Passion dévorante et lien émotionnel profond en amour. La relation peut atteindre un tout nouveau niveau.',
          '6': 'Vous êtes capable de transformer l\'atmosphère de travail pour le mieux. Profonde satisfaction de votre travail.',
          '7': 'La relation avec votre partenaire devient plus profonde et plus intense. Vous ressentez une connexion presque mystique l\'un avec l\'autre. Guérison du partenariat.',
          '8': 'Attirance sexuelle et intimité émotionnelle incroyablement fortes. Succès en matière de finances communes, d\'investissements.',
          '9': 'Un voyage ou des études peuvent conduire à une profonde transformation intérieure. Votre vision de l\'amour change.',
          '10': 'Votre charme et votre charisme vous aident à atteindre le pouvoir et l\'influence dans votre carrière.',
          '11': 'Relations profondes et sincères avec des amis. Vous pouvez être un catalyseur de changement positif dans votre groupe.',
          '12': 'Guérison de traumatismes psychologiques profonds par l\'amour et l\'acceptation. Votre intuition et votre capacité de compassion sont très fortes.'
        },
        'de': {
          '1': 'Ihre Anziehungskraft hat eine magnetische Kraft. Sie sind in der Lage, andere mit Ihrem Charme tief zu beeinflussen.',
          '2': 'Die Möglichkeit großer finanzieller Zuflüsse. Sie spüren intuitiv, wo Sie Geld investieren müssen, um es zu vermehren. Finanzielle Macht.',
          '3': 'Ihre Worte haben heilende Kraft. Ein tiefes und ehrliches Gespräch kann eine Beziehung radikal zum Besseren verändern.',
          '4': 'Tiefe Transformation und Heilung von Familienbeziehungen. Sie können langjährige Probleme lösen und Familienbande stärken.',
          '5': 'Alles verzehrende Leidenschaft und eine tiefe emotionale Verbindung in der Liebe. Die Beziehung kann ein völlig neues Niveau erreichen.',
          '6': 'Sie sind in der Lage, die Arbeitsatmosphäre zum Besseren zu verändern. Tiefe Zufriedenheit mit Ihrer Arbeit.',
          '7': 'Die Beziehung zu Ihrem Partner wird tiefer und intensiver. Sie spüren eine fast mystische Verbindung zueinander. Heilung der Partnerschaft.',
          '8': 'Unglaublich starke sexuelle Anziehung und emotionale Intimität. Erfolg in Fragen gemeinsamer Finanzen, Investitionen.',
          '9': 'Eine Reise oder ein Studium kann zu einer tiefen inneren Transformation führen. Ihre Ansichten über die Liebe ändern sich.',
          '10': 'Ihr Charme und Ihr Charisma helfen Ihnen, Macht und Einfluss in Ihrer Karriere zu erlangen.',
          '11': 'Tiefe und aufrichtige Beziehungen zu Freunden. Sie können ein Katalysator für positive Veränderungen in Ihrer Gruppe sein.',
          '12': 'Heilung tiefer psychologischer Traumata durch Liebe und Akzeptanz. Ihre Intuition und Ihr Mitgefühl sind sehr stark.'
        }
      }
    ),
    AspectInterpretation(
      id: 'VENUS_TRINE_URANUS',
      title: {
        'ru': 'Гармония Венеры и Урана',
        'en': 'Venus Trine Uranus',
        'fr': 'Vénus Trigone Uranus',
        'de': 'Venus-Trigon-Uranus'
      },
      descriptionGeneral: {
        'ru': 'День приятных сюрпризов, волнующих знакомств и неожиданных радостей. Любовь (Венера) получает заряд новизны и свободы (Уран). Отлично для свиданий, вечеринок и экспериментов с имиджем.',
        'en': 'A day of pleasant surprises, exciting acquaintances, and unexpected joys. Love (Venus) gets a charge of novelty and freedom (Uranus). Excellent for dates, parties, and experimenting with your image.',
        'fr': 'Une journée de belles surprises, de rencontres excitantes et de joies inattendues. L\'amour (Vénus) reçoit une charge de nouveauté et de liberté (Uranus). Excellent pour les rendez-vous, les fêtes et l\'expérimentation de votre image.',
        'de': 'Ein Tag voller angenehmer Überraschungen, aufregender Bekanntschaften und unerwarteter Freuden. Die Liebe (Venus) erhält einen Schub an Neuheit und Freiheit (Uranus). Ausgezeichnet für Verabredungen, Partys und Experimente mit Ihrem Image.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Вы привлекательны своей оригинальностью. Легко заводите новые знакомства. Удачный день для смены прически или стиля.',
          '2': 'Неожиданная финансовая удача, возможно через интернет или друзей. Удачные покупки необычных вещей или техники.',
          '3': 'Интересные и неожиданные знакомства. Приятные сюрпризы в коротких поездках. Внезапная хорошая новость.',
          '4': 'Неожиданные, но приятные гости. Внезапное желание купить что-то красивое и современное для дома.',
          '5': 'Внезапная влюбленность или неожиданное и очень приятное свидание. Отношения получают глоток свежего воздуха.',
          '6': 'Приятные сюрпризы на работе. Рутина нарушается чем-то интересным. Легкий и приятный флирт с коллегой.',
          '7': 'Партнер может приятно удивить вас. Хороший день, чтобы попробовать что-то новое вместе. Неожиданное знакомство.',
          '8': 'Приятные эксперименты в интимной жизни. Неожиданная финансовая поддержка со стороны партнера.',
          '9': 'Внезапное и удачное предложение о поездке. Знакомство с иностранцем или человеком другой культуры.',
          '10': 'Неожиданный успех в карьере, особенно в творческих или IT-сферах. Ваша оригинальность будет оценена.',
          '11': 'Веселая и неожиданная встреча с друзьями. Новое знакомство в компании может перерасти в нечто большее.',
          '12': 'Внезапное озарение, связанное с любовью. Тайный поклонник может проявить себя самым неожиданным образом.'
        },
        'en': {
          '1': 'You are attractive due to your originality. You easily make new acquaintances. A good day to change your hairstyle or style.',
          '2': 'Unexpected financial luck, possibly through the internet or friends. Successful purchases of unusual items or technology.',
          '3': 'Interesting and unexpected acquaintances. Pleasant surprises on short trips. Sudden good news.',
          '4': 'Unexpected but pleasant guests. A sudden desire to buy something beautiful and modern for the home.',
          '5': 'Sudden infatuation or an unexpected and very pleasant date. The relationship gets a breath of fresh air.',
          '6': 'Pleasant surprises at work. The routine is broken by something interesting. A light and pleasant flirtation with a colleague.',
          '7': 'Your partner might pleasantly surprise you. A good day to try something new together. An unexpected acquaintance.',
          '8': 'Pleasant experiments in your intimate life. Unexpected financial support from a partner.',
          '9': 'A sudden and favorable travel offer. Meeting a foreigner or a person from another culture.',
          '10': 'Unexpected success in your career, especially in creative or IT fields. Your originality will be appreciated.',
          '11': 'A fun and unexpected meeting with friends. A new acquaintance in the group could develop into something more.',
          '12': 'A sudden insight related to love. A secret admirer might reveal themselves in the most unexpected way.'
        },
        'fr': {
          '1': 'Vous êtes attrayant par votre originalité. Vous vous faites facilement de nouvelles connaissances. Une bonne journée pour changer de coiffure ou de style.',
          '2': 'Chance financière inattendue, peut-être via Internet ou des amis. Achats réussis d\'articles inhabituels ou de technologie.',
          '3': 'Connaissances intéressantes et inattendues. Agréables surprises lors de courts voyages. Bonne nouvelle soudaine.',
          '4': 'Invités inattendus mais agréables. Un désir soudain d\'acheter quelque chose de beau et de moderne pour la maison.',
          '5': 'Engouement soudain ou rendez-vous inattendu et très agréable. La relation prend un nouveau souffle.',
          '6': 'Agréables surprises au travail. La routine est brisée par quelque chose d\'intéressant. Un flirt léger et agréable avec un collègue.',
          '7': 'Votre partenaire pourrait vous surprendre agréablement. Une bonne journée pour essayer quelque chose de nouveau ensemble. Une connaissance inattendue.',
          '8': 'Expériences agréables dans votre vie intime. Soutien financier inattendu d\'un partenaire.',
          '9': 'Une offre de voyage soudaine et favorable. Rencontre avec un étranger ou une personne d\'une autre culture.',
          '10': 'Succès inattendu dans votre carrière, en particulier dans les domaines créatifs ou informatiques. Votre originalité sera appréciée.',
          '11': 'Une rencontre amusante et inattendue avec des amis. Une nouvelle connaissance dans le groupe pourrait se transformer en quelque chose de plus.',
          '12': 'Une prise de conscience soudaine liée à l\'amour. Un admirateur secret pourrait se révéler de la manière la plus inattendue.'
        },
        'de': {
          '1': 'Sie sind durch Ihre Originalität attraktiv. Sie knüpfen leicht neue Bekanntschaften. Ein guter Tag, um Ihre Frisur oder Ihren Stil zu ändern.',
          '2': 'Unerwartetes finanzielles Glück, möglicherweise über das Internet oder Freunde. Erfolgreiche Käufe von ungewöhnlichen Gegenständen oder Technik.',
          '3': 'Interessante und unerwartete Bekanntschaften. Angenehme Überraschungen auf kurzen Reisen. Plötzliche gute Nachrichten.',
          '4': 'Unerwartete, aber angenehme Gäste. Ein plötzlicher Wunsch, etwas Schönes und Modernes für das Zuhause zu kaufen.',
          '5': 'Plötzliche Verliebtheit oder ein unerwartetes und sehr angenehmes Date. Die Beziehung bekommt frischen Wind.',
          '6': 'Angenehme Überraschungen bei der Arbeit. Die Routine wird durch etwas Interessantes unterbrochen. Ein leichter und angenehmer Flirt mit einem Kollegen.',
          '7': 'Ihr Partner könnte Sie angenehm überraschen. Ein guter Tag, um gemeinsam etwas Neues auszuprobieren. Eine unerwartete Bekanntschaft.',
          '8': 'Angenehme Experimente in Ihrem Intimleben. Unerwartete finanzielle Unterstützung von einem Partner.',
          '9': 'Ein plötzliches und günstiges Reiseangebot. Begegnung mit einem Ausländer oder einer Person aus einer anderen Kultur.',
          '10': 'Unerwarteter Erfolg in Ihrer Karriere, besonders in kreativen oder IT-Bereichen. Ihre Originalität wird geschätzt.',
          '11': 'Ein lustiges und unerwartetes Treffen mit Freunden. Eine neue Bekanntschaft in der Gruppe könnte sich zu mehr entwickeln.',
          '12': 'Eine plötzliche Einsicht in Bezug auf die Liebe. Ein heimlicher Verehrer könnte sich auf die unerwartetste Weise offenbaren.'
        }
      }
    ),
        // === НОВЫЙ БЛОК 8 ===
    AspectInterpretation(
      id: 'MARS_OPPOSITION_PLUTO',
      title: {
        'ru': 'Противостояние Марса и Плутона',
        'en': 'Mars Opposition Pluto',
        'fr': 'Mars Opposition Pluton',
        'de': 'Mars-Opposition-Pluto'
      },
      descriptionGeneral: {
        'ru': 'День жесточайшей борьбы за власть и контроля. Ваши действия (Марс) сталкиваются с чужой волей и манипуляциями (Плутон). Высокий риск серьезных конфликтов, одержимости и разрушительных поступков.',
        'en': 'A day of fierce struggle for power and control. Your actions (Mars) clash with someone else\'s will and manipulation (Pluto). High risk of serious conflicts, obsession, and destructive actions.',
        'fr': 'Une journée de lutte acharnée pour le pouvoir et le contrôle. Vos actions (Mars) se heurtent à la volonté et à la manipulation de quelqu\'un d\'autre (Pluton). Risque élevé de conflits graves, d\'obsession et d\'actions destructrices.',
        'de': 'Ein Tag des erbitterten Kampfes um Macht und Kontrolle. Ihre Handlungen (Mars) kollidieren mit dem Willen und der Manipulation eines anderen (Pluto). Hohes Risiko für ernsthafte Konflikte, Besessenheit und destruktive Handlungen.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Вы сталкиваетесь с прямым давлением со стороны других людей. Кто-то пытается сломить вашу волю. Избегайте опасных мест и ситуаций.',
          '2': 'Жестокая борьба за финансовые ресурсы. Возможны угрозы, шантаж или крупные потери из-за чужих действий.',
          '3': 'Словесная дуэль, в которой оппонент не гнушается грязными приемами. На вас может быть вылит поток компромата.',
          '4': 'Открытый конфликт с членом семьи, который перерастает в борьбу за доминирование. Давление со стороны родственников.',
          '5': 'Отношения превращаются в поле битвы. Ревность, манипуляции и попытки подчинить себе партнера. Опасная страсть.',
          '6': 'Открытая вражда с коллегой или подчиненным. Кто-то пытается подорвать ваш авторитет на работе. Риск для здоровья из-за перенапряжения.',
          '7': 'Прямое столкновение с партнером или открытым врагом. Это битва "кто кого". Компромисс почти невозможен.',
          '8': 'Серьезный кризис в вопросах общих финансов или интимной жизни. Возможны крупные долги или болезненный разрыв.',
          '9': 'Идеологическая война. Вы сталкиваетесь с человеком, чьи убеждения полностью противоположны вашим и он пытается вас "уничтожить".',
          '10': 'Жесткое противостояние с начальством или властями. Ваша карьера под угрозой из-за действий влиятельного противника.',
          '11': 'Предательство со стороны друга. Конфликт в группе, который может привести к ее распаду.',
          '12': 'Вы сталкиваетесь с тайным, но очень сильным врагом. Ваши собственные подавленные желания могут привести к саморазрушению.'
        },
        'en': {
          '1': 'You are facing direct pressure from other people. Someone is trying to break your will. Avoid dangerous places and situations.',
          '2': 'A fierce struggle for financial resources. Threats, blackmail, or major losses due to others\' actions are possible.',
          '3': 'A verbal duel in which an opponent does not shy away from dirty tricks. A flood of compromising information may be unleashed on you.',
          '4': 'An open conflict with a family member that escalates into a struggle for dominance. Pressure from relatives.',
          '5': 'A relationship turns into a battlefield. Jealousy, manipulation, and attempts to subordinate a partner. Dangerous passion.',
          '6': 'Open hostility with a colleague or subordinate. Someone is trying to undermine your authority at work. Health risk due to overexertion.',
          '7': 'A direct confrontation with a partner or an open enemy. It\'s a "who will win" battle. Compromise is almost impossible.',
          '8': 'A serious crisis in matters of joint finances or intimate life. Large debts or a painful breakup are possible.',
          '9': 'An ideological war. You are facing a person whose beliefs are completely opposite to yours, and they are trying to "destroy" you.',
          '10': 'A harsh confrontation with your boss or authorities. Your career is threatened by the actions of an influential opponent.',
          '11': 'Betrayal by a friend. A conflict within a group that could lead to its dissolution.',
          '12': 'You are facing a secret but very powerful enemy. Your own suppressed desires can lead to self-destruction.'
        },
        'fr': {
          '1': 'Vous faites face à une pression directe de la part d\'autres personnes. Quelqu\'un essaie de briser votre volonté. Évitez les endroits et les situations dangereuses.',
          '2': 'Une lutte acharnée pour les ressources financières. Menaces, chantage ou pertes importantes dues aux actions des autres sont possibles.',
          '3': 'Un duel verbal dans lequel un adversaire n\'hésite pas à utiliser des coups bas. Un flot d\'informations compromettantes peut être déversé sur vous.',
          '4': 'Un conflit ouvert avec un membre de la famille qui dégénère en lutte pour la domination. Pression des parents.',
          '5': 'Une relation se transforme en champ de bataille. Jalousie, manipulation et tentatives de soumettre un partenaire. Passion dangereuse.',
          '6': 'Hostilité ouverte avec un collègue ou un subordonné. Quelqu\'un essaie de saper votre autorité au travail. Risque pour la santé dû au surmenage.',
          '7': 'Une confrontation directe avec un partenaire ou un ennemi déclaré. C\'est une bataille pour savoir "qui va gagner". Le compromis est presque impossible.',
          '8': 'Une crise grave en matière de finances communes ou de vie intime. D\'importantes dettes ou une rupture douloureuse sont possibles.',
          '9': 'Une guerre idéologique. Vous faites face à une personne dont les croyances sont complètement opposées aux vôtres, et elle essaie de vous "détruire".',
          '10': 'Une confrontation sévère avec votre patron ou les autorités. Votre carrière est menacée par les actions d\'un adversaire influent.',
          '11': 'Trahison d\'un ami. Un conflit au sein d\'un groupe qui pourrait conduire à sa dissolution.',
          '12': 'Vous faites face à un ennemi secret mais très puissant. Vos propres désirs refoulés peuvent mener à l\'autodestruction.'
        },
        'de': {
          '1': 'Sie stehen unter direktem Druck von anderen Menschen. Jemand versucht, Ihren Willen zu brechen. Vermeiden Sie gefährliche Orte und Situationen.',
          '2': 'Ein erbitterter Kampf um finanzielle Ressourcen. Drohungen, Erpressung oder große Verluste durch die Handlungen anderer sind möglich.',
          '3': 'Ein verbales Duell, bei dem ein Gegner nicht vor schmutzigen Tricks zurückschreckt. Eine Flut kompromittierender Informationen könnte über Sie hereinbrechen.',
          '4': 'Ein offener Konflikt mit einem Familienmitglied, der sich zu einem Kampf um die Vorherrschaft ausweitet. Druck von Verwandten.',
          '5': 'Eine Beziehung wird zum Schlachtfeld. Eifersucht, Manipulation und Versuche, einen Partner zu unterwerfen. Gefährliche Leidenschaft.',
          '6': 'Offene Feindseligkeit mit einem Kollegen oder Untergebenen. Jemand versucht, Ihre Autorität bei der Arbeit zu untergraben. Gesundheitsrisiko durch Überanstrengung.',
          '7': 'Eine direkte Konfrontation mit einem Partner oder einem offenen Feind. Es ist ein Kampf "wer gewinnt". Ein Kompromiss ist fast unmöglich.',
          '8': 'Eine schwere Krise in Fragen gemeinsamer Finanzen oder des Intimlebens. Große Schulden oder eine schmerzhafte Trennung sind möglich.',
          '9': 'Ein ideologischer Krieg. Sie stehen einer Person gegenüber, deren Überzeugungen Ihren völlig entgegengesetzt sind, und sie versucht, Sie zu "zerstören".',
          '10': 'Eine harte Konfrontation mit Ihrem Chef oder den Behörden. Ihre Karriere ist durch die Handlungen eines einflussreichen Gegners bedroht.',
          '11': 'Verrat durch einen Freund. Ein Konflikt innerhalb einer Gruppe, der zu ihrer Auflösung führen könnte.',
          '12': 'Sie stehen einem geheimen, aber sehr mächtigen Feind gegenüber. Ihre eigenen unterdrückten Wünsche können zur Selbstzerstörung führen.'
        }
      }
    ),
    AspectInterpretation(
      id: 'SUN_OPPOSITION_URANUS',
      title: {
        'ru': 'Противостояние Солнца и Урана',
        'en': 'Sun Opposition Uranus',
        'fr': 'Soleil Opposition Uranus',
        'de': 'Sonne-Opposition-Uranus'
      },
      descriptionGeneral: {
        'ru': 'День неожиданных срывов планов и бунтарства. Ваши цели (Солнце) сталкиваются с внезапными переменами или чужим желанием свободы (Уран). Высока нервозность, непредсказуемость событий.',
        'en': 'A day of unexpected disruptions and rebellion. Your goals (Sun) clash with sudden changes or someone else\'s desire for freedom (Uranus). High nervousness, unpredictability of events.',
        'fr': 'Une journée de perturbations inattendues et de rébellion. Vos objectifs (Soleil) se heurtent à des changements soudains ou au désir de liberté de quelqu\'un d\'autre (Uranus). Grande nervosité, imprévisibilité des événements.',
        'de': 'Ein Tag unerwarteter Störungen und Rebellion. Ihre Ziele (Sonne) kollidieren mit plötzlichen Veränderungen oder dem Freiheitswunsch eines anderen (Uranus). Hohe Nervosität, Unvorhersehbarkeit der Ereignisse.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Вы сами или кто-то другой шокирует вас непредсказуемым поведением. Внезапное желание все бросить и начать с чистого листа.',
          '2': 'Неожиданные финансовые потери или, наоборот, внезапные, но нестабильные доходы. Планы по заработку рушатся.',
          '3': 'Неожиданные новости, которые меняют все планы. Срыв поездки. Конфликты с окружением из-за вашего или их непредсказуемого поведения.',
          '4': 'Внезапные перемены в доме или семье. Кто-то может неожиданно съехать или, наоборот, приехать. Срыв планов, связанных с недвижимостью.',
          '5': 'Внезапный разрыв отношений или неожиданная влюбленность. Партнер может требовать свободы или шокировать вас своим поведением.',
          '6': 'Хаос на работе. Внезапное увольнение или смена обязанностей. Планы рушатся из-за технических сбоев или неожиданных событий.',
          '7': 'Партнер ведет себя непредсказуемо, что может привести к разрыву. Вы сталкиваетесь с людьми, которые подрывают ваши планы.',
          '8': 'Неожиданный финансовый кризис (например, требование вернуть долг). Планы, связанные с общими ресурсами, срываются.',
          '9': 'Внезапный срыв путешествия или проблемы в учебе. Ваши убеждения могут быть шокирующим образом оспорены.',
          '10': 'Карьерные планы рушатся. Внезапный конфликт с начальством или событие, которое меняет ваш статус.',
          '11': 'Внезапный конфликт с другом или разрыв с целой группой людей. Ваши надежды и мечты сталкиваются с неожиданными препятствиями.',
          '12': 'Неожиданно вскрываются тайны, которые портят все планы. Ваше подсознание бунтует, вызывая тревогу и странные поступки.'
        },
        'en': {
          '1': 'You or someone else shocks you with unpredictable behavior. A sudden desire to drop everything and start anew.',
          '2': 'Unexpected financial losses or, conversely, sudden but unstable income. Earning plans collapse.',
          '3': 'Unexpected news that changes all plans. A trip is canceled. Conflicts with your circle due to your or their unpredictable behavior.',
          '4': 'Sudden changes at home or in the family. Someone might unexpectedly move out or arrive. Real estate plans are disrupted.',
          '5': 'A sudden breakup or an unexpected infatuation. A partner may demand freedom or shock you with their behavior.',
          '6': 'Chaos at work. A sudden dismissal or change of duties. Plans are ruined by technical failures or unexpected events.',
          '7': 'A partner behaves unpredictably, which could lead to a breakup. You encounter people who undermine your plans.',
          '8': 'An unexpected financial crisis (e.g., a demand to repay a debt). Plans related to joint resources are thwarted.',
          '9': 'A sudden trip cancellation or problems in studies. Your beliefs may be challenged in a shocking way.',
          '10': 'Career plans collapse. A sudden conflict with a boss or an event that changes your status.',
          '11': 'A sudden conflict with a friend or a break with an entire group of people. Your hopes and dreams face unexpected obstacles.',
          '12': 'Secrets are unexpectedly revealed, ruining all plans. Your subconscious is rebelling, causing anxiety and strange actions.'
        },
        'fr': {
          '1': 'Vous ou quelqu\'un d\'autre vous choque par un comportement imprévisible. Un désir soudain de tout laisser tomber et de repartir à zéro.',
          '2': 'Pertes financières inattendues ou, à l\'inverse, revenus soudains mais instables. Les plans de revenus s\'effondrent.',
          '3': 'Nouvelles inattendues qui changent tous les plans. Un voyage est annulé. Conflits avec votre entourage en raison de votre comportement imprévisible ou du leur.',
          '4': 'Changements soudains à la maison ou dans la famille. Quelqu\'un pourrait déménager ou arriver de manière inattendue. Les plans immobiliers sont perturbés.',
          '5': 'Une rupture soudaine ou un engouement inattendu. Un partenaire peut exiger de la liberté ou vous choquer par son comportement.',
          '6': 'Chaos au travail. Un licenciement soudain ou un changement de fonctions. Les plans sont ruinés par des pannes techniques ou des événements inattendus.',
          '7': 'Un partenaire se comporte de manière imprévisible, ce qui pourrait conduire à une rupture. Vous rencontrez des gens qui sapent vos plans.',
          '8': 'Une crise financière inattendue (par exemple, une demande de remboursement de dette). Les plans liés aux ressources communes sont contrecarrés.',
          '9': 'Une annulation soudaine de voyage ou des problèmes dans les études. Vos croyances peuvent être remises en question de manière choquante.',
          '10': 'Les plans de carrière s\'effondrent. Un conflit soudain avec un patron ou un événement qui change votre statut.',
          '11': 'Un conflit soudain avec un ami ou une rupture avec tout un groupe de personnes. Vos espoirs et vos rêves font face à des obstacles inattendus.',
          '12': 'Des secrets sont révélés de manière inattendue, ruinant tous les plans. Votre subconscient se rebelle, provoquant anxiété et actions étranges.'
        },
        'de': {
          '1': 'Sie oder jemand anderes schockiert Sie mit unvorhersehbarem Verhalten. Ein plötzlicher Wunsch, alles hinzuwerfen und neu anzufangen.',
          '2': 'Unerwartete finanzielle Verluste oder umgekehrt plötzliche, aber instabile Einnahmen. Verdienstpläne scheitern.',
          '3': 'Unerwartete Nachrichten, die alle Pläne ändern. Eine Reise wird abgesagt. Konflikte mit Ihrem Umfeld aufgrund Ihres oder deren unvorhersehbaren Verhaltens.',
          '4': 'Plötzliche Veränderungen zu Hause oder in der Familie. Jemand könnte unerwartet ausziehen oder ankommen. Immobilienpläne werden durchkreuzt.',
          '5': 'Eine plötzliche Trennung oder eine unerwartete Verliebtheit. Ein Partner könnte Freiheit fordern oder Sie mit seinem Verhalten schockieren.',
          '6': 'Chaos bei der Arbeit. Eine plötzliche Kündigung oder ein Wechsel der Aufgaben. Pläne werden durch technische Ausfälle oder unerwartete Ereignisse zunichte gemacht.',
          '7': 'Ein Partner verhält sich unvorhersehbar, was zu einer Trennung führen könnte. Sie begegnen Menschen, die Ihre Pläne untergraben.',
          '8': 'Eine unerwartete Finanzkrise (z. B. eine Forderung zur Rückzahlung einer Schuld). Pläne im Zusammenhang mit gemeinsamen Ressourcen werden vereitelt.',
          '9': 'Eine plötzliche Reiseabsage oder Probleme im Studium. Ihre Überzeugungen könnten auf schockierende Weise in Frage gestellt werden.',
          '10': 'Karrierepläne scheitern. Ein plötzlicher Konflikt mit einem Chef oder ein Ereignis, das Ihren Status ändert.',
          '11': 'Ein plötzlicher Konflikt mit einem Freund oder ein Bruch mit einer ganzen Gruppe von Menschen. Ihre Hoffnungen und Träume stoßen auf unerwartete Hindernisse.',
          '12': 'Geheimnisse werden unerwartet aufgedeckt und ruinieren alle Pläne. Ihr Unterbewusstsein rebelliert und verursacht Angst und seltsame Handlungen.'
        }
      }
    ),
    AspectInterpretation(
      id: 'MERCURY_TRINE_JUPITER',
      title: {
        'ru': 'Гармония Меркурия и Юпитера',
        'en': 'Mercury Trine Jupiter',
        'fr': 'Mercure Trigone Jupiter',
        'de': 'Merkur-Trigon-Jupiter'
      },
      descriptionGeneral: {
        'ru': 'День большого оптимизма и удачных идей. Мышление (Меркурий) становится широким и позитивным (Юпитер). Легко даются переговоры, обучение, планирование. Отличный день для хороших новостей!',
        'en': 'A day of great optimism and successful ideas. Thinking (Mercury) becomes broad and positive (Jupiter). Negotiations, learning, and planning come easily. An excellent day for good news!',
        'fr': 'Une journée de grand optimisme et d\'idées réussies. La pensée (Mercure) devient large et positive (Jupiter). Les négociations, l\'apprentissage et la planification sont faciles. Une excellente journée pour de bonnes nouvelles !',
        'de': 'Ein Tag großen Optimismus und erfolgreicher Ideen. Das Denken (Merkur) wird weit und positiv (Jupiter). Verhandlungen, Lernen und Planen fallen leicht. Ein ausgezeichneter Tag für gute Nachrichten!'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Вы полны позитивных идей и красноречивы. Легко убеждать и вдохновлять других. Ваше мировоззрение оптимистично.',
          '2': 'Блестящие идеи о том, как заработать. Успешные переговоры о зарплате или сделке. Финансовые новости радуют.',
          '3': 'Невероятно удачный день для общения, учебы и поездок. Информация усваивается легко, переговоры проходят гладко.',
          '4': 'Прекрасные новости, касающиеся семьи или дома. Легко договориться с родными о планах на расширение или путешествие.',
          '5': 'Оптимистичный и щедрый флирт. Легко найти общий язык с объектом симпатии. Хорошие новости от детей.',
          '6': 'Успех в рабочих делах. Легко решаете любые задачи и находите общий язык с коллегами. Работа в радость.',
          '7': 'Полное взаимопонимание с партнером. Легко обсуждать любые, даже самые глобальные планы. Удачный день для заключения договоров.',
          '8': 'Успешное решение вопросов с крупными финансами (кредиты, инвестиции). Разговор по душам приносит облегчение и оптимизм.',
          '9': 'Идеально для начала путешествия, поступления в вуз, общения с иностранцами. Ваши идеи находят широкую поддержку.',
          '10': 'Большой успех в переговорах с начальством. Ваши идеи могут привести к повышению или расширению полномочий.',
          '11': 'Ваши мечты и планы легко находят поддержку у друзей. Отличный день для планирования будущего.',
          '12': 'Ваш внутренний голос дает оптимистичные подсказки. Вы легко находите ответы на сложные вопросы через размышления.'
        },
        'en': {
          '1': 'You are full of positive ideas and are eloquent. It\'s easy to persuade and inspire others. Your worldview is optimistic.',
          '2': 'Brilliant ideas on how to earn money. Successful salary or deal negotiations. Financial news is pleasing.',
          '3': 'An incredibly lucky day for communication, study, and travel. Information is easily absorbed, negotiations go smoothly.',
          '4': 'Wonderful news regarding family or home. It\'s easy to agree with relatives on plans for expansion or a trip.',
          '5': 'Optimistic and generous flirting. It\'s easy to find common ground with your crush. Good news from children.',
          '6': 'Success in work matters. You easily solve any tasks and find a common language with colleagues. Work is a joy.',
          '7': 'Complete mutual understanding with your partner. It\'s easy to discuss any plans, even the most global ones. A good day for signing contracts.',
          '8': 'Successful resolution of issues with large finances (loans, investments). A heart-to-heart conversation brings relief and optimism.',
          '9': 'Ideal for starting a trip, entering a university, communicating with foreigners. Your ideas find wide support.',
          '10': 'Great success in negotiations with your boss. Your ideas could lead to a promotion or expanded responsibilities.',
          '11': 'Your dreams and plans easily find support from friends. An excellent day for planning the future.',
          '12': 'Your inner voice gives optimistic prompts. You easily find answers to complex questions through reflection.'
        },
        'fr': {
          '1': 'Vous êtes plein d\'idées positives et êtes éloquent. Il est facile de persuader et d\'inspirer les autres. Votre vision du monde est optimiste.',
          '2': 'Idées brillantes sur la façon de gagner de l\'argent. Négociations de salaire ou de contrat réussies. Les nouvelles financières sont réjouissantes.',
          '3': 'Une journée incroyablement chanceuse pour la communication, les études et les voyages. L\'information est facilement absorbée, les négociations se déroulent sans heurts.',
          '4': 'Merveilleuses nouvelles concernant la famille ou la maison. Il est facile de se mettre d\'accord avec les parents sur les plans d\'agrandissement ou de voyage.',
          '5': 'Flirt optimiste et généreux. Il est facile de trouver un terrain d\'entente avec l\'objet de votre affection. Bonnes nouvelles des enfants.',
          '6': 'Succès dans les affaires professionnelles. Vous résolvez facilement toutes les tâches et trouvez un langage commun avec les collègues. Le travail est une joie.',
          '7': 'Compréhension mutuelle complète avec votre partenaire. Il est facile de discuter de tous les plans, même les plus globaux. Une bonne journée pour signer des contrats.',
          '8': 'Résolution réussie des problèmes de grosses finances (prêts, investissements). Une conversation à cœur ouvert apporte soulagement et optimisme.',
          '9': 'Idéal pour commencer un voyage, entrer à l\'université, communiquer avec des étrangers. Vos idées trouvent un large soutien.',
          '10': 'Grand succès dans les négociations avec votre patron. Vos idées pourraient mener à une promotion ou à des responsabilités élargies.',
          '11': 'Vos rêves et vos projets trouvent facilement le soutien de vos amis. Une excellente journée pour planifier l\'avenir.',
          '12': 'Votre voix intérieure donne des conseils optimistes. Vous trouvez facilement des réponses à des questions complexes par la réflexion.'
        },
        'de': {
          '1': 'Sie sind voller positiver Ideen und redegewandt. Es ist leicht, andere zu überzeugen und zu inspirieren. Ihre Weltanschauung ist optimistisch.',
          '2': 'Brillante Ideen, wie man Geld verdienen kann. Erfolgreiche Gehalts- oder Vertragsverhandlungen. Finanznachrichten sind erfreulich.',
          '3': 'Ein unglaublich glücklicher Tag für Kommunikation, Studium und Reisen. Informationen werden leicht aufgenommen, Verhandlungen verlaufen reibungslos.',
          '4': 'Wunderbare Nachrichten bezüglich Familie oder Zuhause. Es ist leicht, sich mit Verwandten über Pläne zur Erweiterung oder eine Reise zu einigen.',
          '5': 'Optimistisches und großzügiges Flirten. Es ist leicht, eine gemeinsame Basis mit Ihrem Schwarm zu finden. Gute Nachrichten von Kindern.',
          '6': 'Erfolg in Arbeitsangelegenheiten. Sie lösen mühelos alle Aufgaben und finden eine gemeinsame Sprache mit Kollegen. Arbeit macht Freude.',
          '7': 'Vollständiges gegenseitiges Verständnis mit Ihrem Partner. Es ist leicht, alle Pläne zu besprechen, selbst die globalsten. Ein guter Tag zum Unterzeichnen von Verträgen.',
          '8': 'Erfolgreiche Lösung von Problemen mit großen Finanzen (Kredite, Investitionen). Ein offenes Gespräch bringt Erleichterung und Optimismus.',
          '9': 'Ideal, um eine Reise zu beginnen, eine Universität zu besuchen, mit Ausländern zu kommunizieren. Ihre Ideen finden breite Unterstützung.',
          '10': 'Großer Erfolg bei Verhandlungen mit Ihrem Chef. Ihre Ideen könnten zu einer Beförderung oder erweiterten Verantwortlichkeiten führen.',
          '11': 'Ihre Träume und Pläne finden leicht Unterstützung von Freunden. Ein ausgezeichneter Tag, um die Zukunft zu planen.',
          '12': 'Ihre innere Stimme gibt optimistische Hinweise. Sie finden leicht Antworten auf komplexe Fragen durch Nachdenken.'
        }
      }
    ),
    AspectInterpretation(
      id: 'VENUS_SEXTILE_NEPTUNE',
      title: {
        'ru': 'Шанс от Венеры и Нептуна',
        'en': 'Venus Sextile Neptune',
        'fr': 'Vénus Sextile Neptune',
        'de': 'Venus-Sextil-Neptun'
      },
      descriptionGeneral: {
        'ru': 'День романтики, вдохновения и сострадания. Появляется возможность для нежной и духовной связи. Отлично для свиданий, творчества, музыки, медитации и благотворительности.',
        'en': 'A day of romance, inspiration, and compassion. An opportunity for a tender and spiritual connection arises. Excellent for dates, creativity, music, meditation, and charity.',
        'fr': 'Une journée de romance, d\'inspiration et de compassion. Une opportunité pour une connexion tendre et spirituelle se présente. Excellent pour les rendez-vous, la créativité, la musique, la méditation et la charité.',
        'de': 'Ein Tag der Romantik, Inspiration und des Mitgefühls. Es ergibt sich die Möglichkeit für eine zarte und spirituelle Verbindung. Ausgezeichnet für Verabredungen, Kreativität, Musik, Meditation und Wohltätigkeit.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Вы излучаете загадочность и мягкость. Ваша эмпатия и тонкое чувство прекрасного привлекают людей.',
          '2': 'Возможность заработать на творчестве или получить деньги из неожиданного источника. Интуиция подсказывает, как распорядиться финансами.',
          '3': 'Нежный и поэтичный разговор. Легко говорить о чувствах, понимать других без слов. Романтическая переписка.',
          '4': 'Возможность создать очень гармоничную и умиротворяющую атмосферу дома. Душевная близость с семьей.',
          '5': 'Очень романтичное свидание, полное нежности и взаимопонимания. Возможность влюбиться в кого-то очень тонко чувствующего.',
          '6': 'Возможность проявить сострадание и помочь коллеге. Творческий подход к работе. Приятная, расслабленная атмосфера.',
          '7': 'Шанс достичь глубокого духовного единения с партнером. Отношения наполняются нежностью и романтикой.',
          '8': 'Тонкая интуитивная связь с партнером, глубокое слияние душ. Сны могут дать подсказки об отношениях.',
          '9': 'Возможность романтического знакомства в поездке или вдохновение от искусства. Интерес к духовным аспектам любви.',
          '10': 'Ваш творческий подход и эмпатия могут быть замечены. Успех в профессиях, связанных с искусством, психологией, благотворительностью.',
          '11': 'Душевная встреча с друзьями-единомышленниками. Возможность встретить свою любовь в кругу друзей.',
          '12': 'Тайный роман может принести много нежных чувств. Медитация и уединение помогают обрести внутреннюю гармонию в любви.'
        },
        'en': {
          '1': 'You radiate mystery and gentleness. Your empathy and subtle sense of beauty attract people.',
          '2': 'An opportunity to earn from creativity or receive money from an unexpected source. Intuition suggests how to manage finances.',
          '3': 'A gentle and poetic conversation. It\'s easy to talk about feelings, to understand others without words. Romantic correspondence.',
          '4': 'An opportunity to create a very harmonious and peaceful atmosphere at home. Soulful intimacy with family.',
          '5': 'A very romantic date, full of tenderness and mutual understanding. A chance to fall in love with someone very sensitive.',
          '6': 'An opportunity to show compassion and help a colleague. A creative approach to work. A pleasant, relaxed atmosphere.',
          '7': 'A chance to achieve a deep spiritual union with your partner. The relationship is filled with tenderness and romance.',
          '8': 'A subtle intuitive connection with your partner, a deep merging of souls. Dreams can give clues about the relationship.',
          '9': 'A chance for a romantic acquaintance on a trip or inspiration from art. Interest in the spiritual aspects of love.',
          '10': 'Your creative approach and empathy may be noticed. Success in professions related to art, psychology, charity.',
          '11': 'A soulful meeting with like-minded friends. A chance to meet your love among friends.',
          '12': 'A secret romance can bring many tender feelings. Meditation and solitude help to find inner harmony in love.'
        },
        'fr': {
          '1': 'Vous rayonnez de mystère et de douceur. Votre empathie et votre sens subtil de la beauté attirent les gens.',
          '2': 'Une opportunité de gagner de l\'argent grâce à la créativité ou de recevoir de l\'argent d\'une source inattendue. L\'intuition suggère comment gérer les finances.',
          '3': 'Une conversation douce et poétique. Il est facile de parler de sentiments, de comprendre les autres sans mots. Correspondance romantique.',
          '4': 'Une opportunité de créer une atmosphère très harmonieuse et paisible à la maison. Intimité profonde avec la famille.',
          '5': 'Un rendez-vous très romantique, plein de tendresse et de compréhension mutuelle. Une chance de tomber amoureux de quelqu\'un de très sensible.',
          '6': 'Une opportunité de faire preuve de compassion et d\'aider un collègue. Une approche créative du travail. Une atmosphère agréable et détendue.',
          '7': 'Une chance d\'atteindre une union spirituelle profonde avec votre partenaire. La relation est remplie de tendresse et de romantisme.',
          '8': 'Une connexion intuitive subtile avec votre partenaire, une fusion profonde des âmes. Les rêves peuvent donner des indices sur la relation.',
          '9': 'Une chance de rencontre romantique en voyage ou d\'inspiration artistique. Intérêt pour les aspects spirituels de l\'amour.',
          '10': 'Votre approche créative et votre empathie peuvent être remarquées. Succès dans les professions liées à l\'art, la psychologie, la charité.',
          '11': 'Une rencontre émouvante avec des amis partageant les mêmes idées. Une chance de rencontrer votre amour parmi des amis.',
          '12': 'Une romance secrète peut apporter beaucoup de tendres sentiments. La méditation et la solitude aident à trouver l\'harmonie intérieure en amour.'
        },
        'de': {
          '1': 'Sie strahlen Geheimnis und Sanftheit aus. Ihre Empathie und Ihr subtiles Gespür für Schönheit ziehen Menschen an.',
          '2': 'Eine Gelegenheit, mit Kreativität zu verdienen oder Geld aus einer unerwarteten Quelle zu erhalten. Die Intuition sagt, wie man mit Finanzen umgeht.',
          '3': 'Ein sanftes und poetisches Gespräch. Es ist leicht, über Gefühle zu sprechen, andere ohne Worte zu verstehen. Romantische Korrespondenz.',
          '4': 'Eine Gelegenheit, eine sehr harmonische und friedliche Atmosphäre zu Hause zu schaffen. Seelenvolle Intimität mit der Familie.',
          '5': 'Ein sehr romantisches Date, voller Zärtlichkeit und gegenseitigem Verständnis. Eine Chance, sich in jemanden sehr Sensiblen zu verlieben.',
          '6': 'Eine Gelegenheit, Mitgefühl zu zeigen und einem Kollegen zu helfen. Ein kreativer Ansatz zur Arbeit. Eine angenehme, entspannte Atmosphäre.',
          '7': 'Eine Chance, eine tiefe spirituelle Einheit mit Ihrem Partner zu erreichen. Die Beziehung ist erfüllt von Zärtlichkeit und Romantik.',
          '8': 'Eine subtile intuitive Verbindung zu Ihrem Partner, eine tiefe Verschmelzung der Seelen. Träume können Hinweise auf die Beziehung geben.',
          '9': 'Eine Chance für eine romantische Bekanntschaft auf einer Reise oder Inspiration durch Kunst. Interesse an den spirituellen Aspekten der Liebe.',
          '10': 'Ihr kreativer Ansatz und Ihre Empathie könnten bemerkt werden. Erfolg in Berufen im Zusammenhang mit Kunst, Psychologie, Wohltätigkeit.',
          '11': 'Ein seelenvolles Treffen mit gleichgesinnten Freunden. Eine Chance, Ihre Liebe im Freundeskreis zu treffen.',
          '12': 'Eine geheime Romanze kann viele zärtliche Gefühle hervorrufen. Meditation und Einsamkeit helfen, innere Harmonie in der Liebe zu finden.'
        }
      }
    ),
        // === НОВЫЙ БЛОК 9 ===
    AspectInterpretation(
      id: 'MARS_OPPOSITION_SATURN',
      title: {
        'ru': 'Противостояние Марса и Сатурна',
        'en': 'Mars Opposition Saturn',
        'fr': 'Mars Opposition Saturne',
        'de': 'Mars-Opposition-Saturn'
      },
      descriptionGeneral: {
        'ru': 'День "газ-тормоз". Ваши действия (Марс) сталкиваются с жесткими ограничениями и противодействием со стороны других людей (Сатурн). Фрустрация, задержки и конфликты с авторитетами.',
        'en': 'A "gas-brake" day. Your actions (Mars) face harsh limitations and opposition from other people (Saturn). Frustration, delays, and conflicts with authority figures.',
        'fr': 'Une journée "accélérateur-frein". Vos actions (Mars) se heurtent à de dures limitations et à l\'opposition d\'autres personnes (Saturne). Frustration, retards et conflits avec les figures d\'autorité.',
        'de': 'Ein "Gas-Bremse"-Tag. Ihre Handlungen (Mars) stoßen auf harte Einschränkungen und Widerstand von anderen Menschen (Saturn). Frustration, Verzögerungen und Konflikte mit Autoritätspersonen.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Ваши личные инициативы наталкиваются на сопротивление. Кто-то или что-то мешает вам проявить себя. Ощущение, что вас сдерживают.',
          '2': 'Попытки заработать сталкиваются с препятствиями. Конфликт с начальством или клиентами из-за денег.',
          '3': 'Ваши слова и идеи встречают жесткую критику. Тяжелый и непродуктивный разговор. Трудности в поездках.',
          '4': 'Конфликт с родителями или старшими родственниками. Ваши действия могут идти вразрез с семейными устоями.',
          '5': 'Ваши романтические или творческие порывы наталкиваются на холодность и ограничения. Партнер может быть слишком строг.',
          '6': 'Конфликт с коллегами или начальством, который мешает работе. Ощущение, что вас заставляют делать то, чего вы не хотите.',
          '7': 'Прямое противостояние с партнером. Он выступает в роли "тормоза" для ваших инициатив. Отношения проверяются на прочность.',
          '8': 'Ваши действия могут привести к финансовым потерям или кризису. Конфликт из-за общих ресурсов или долгов.',
          '9': 'Ваши планы на путешествие или учебу сталкиваются с серьезными препятствиями. Конфликт с учителем или наставником.',
          '10': 'Ваши действия идут вразрез с требованиями начальства или общественных норм. Серьезный конфликт, который может повредить карьере.',
          '11': 'Конфликт с другом (часто старшим по возрасту), который пытается вас контролировать или ограничивать.',
          '12': 'Ваши действия блокируются скрытыми врагами или собственными страхами. Ощущение бессилия и фрустрации.'
        },
        'en': {
          '1': 'Your personal initiatives are met with resistance. Someone or something is preventing you from expressing yourself. A feeling of being held back.',
          '2': 'Attempts to earn money face obstacles. A conflict with a boss or clients over money.',
          '3': 'Your words and ideas are met with harsh criticism. A difficult and unproductive conversation. Difficulties in travel.',
          '4': 'A conflict with parents or older relatives. Your actions may go against family traditions.',
          '5': 'Your romantic or creative impulses are met with coldness and limitations. A partner may be too strict.',
          '6': 'A conflict with colleagues or a boss that interferes with work. A feeling of being forced to do what you don\'t want to do.',
          '7': 'A direct confrontation with a partner. They act as a "brake" on your initiatives. The relationship is tested for strength.',
          '8': 'Your actions can lead to financial loss or a crisis. A conflict over shared resources or debts.',
          '9': 'Your travel or study plans face serious obstacles. A conflict with a teacher or mentor.',
          '10': 'Your actions go against the demands of your boss or social norms. A serious conflict that could damage your career.',
          '11': 'A conflict with a friend (often older) who tries to control or limit you.',
          '12': 'Your actions are blocked by hidden enemies or your own fears. A feeling of powerlessness and frustration.'
        },
        'fr': {
          '1': 'Vos initiatives personnelles se heurtent à de la résistance. Quelqu\'un ou quelque chose vous empêche de vous exprimer. Le sentiment d\'être retenu.',
          '2': 'Les tentatives de gagner de l\'argent rencontrent des obstacles. Un conflit avec un patron ou des clients à propos de l\'argent.',
          '3': 'Vos paroles et vos idées sont accueillies par de vives critiques. Une conversation difficile et improductive. Des difficultés en voyage.',
          '4': 'Un conflit avec les parents ou les proches plus âgés. Vos actions peuvent aller à l\'encontre des traditions familiales.',
          '5': 'Vos impulsions romantiques ou créatives se heurtent à la froideur et aux limitations. Un partenaire peut être trop strict.',
          '6': 'Un conflit avec des collègues ou un patron qui interfère avec le travail. Le sentiment d\'être forcé de faire ce que vous ne voulez pas.',
          '7': 'Une confrontation directe avec un partenaire. Il agit comme un "frein" à vos initiatives. La relation est mise à l\'épreuve.',
          '8': 'Vos actions peuvent entraîner des pertes financières ou une crise. Un conflit sur les ressources partagées ou les dettes.',
          '9': 'Vos projets de voyage ou d\'études se heurtent à de sérieux obstacles. Un conflit avec un professeur ou un mentor.',
          '10': 'Vos actions vont à l\'encontre des exigences de votre patron ou des normes sociales. Un conflit grave qui pourrait nuire à votre carrière.',
          '11': 'Un conflit avec un ami (souvent plus âgé) qui essaie de vous contrôler ou de vous limiter.',
          '12': 'Vos actions sont bloquées par des ennemis cachés ou vos propres peurs. Un sentiment d\'impuissance et de frustration.'
        },
        'de': {
          '1': 'Ihre persönlichen Initiativen stoßen auf Widerstand. Jemand oder etwas hindert Sie daran, sich auszudrücken. Ein Gefühl, zurückgehalten zu werden.',
          '2': 'Versuche, Geld zu verdienen, stoßen auf Hindernisse. Ein Konflikt mit einem Chef oder Kunden wegen Geld.',
          '3': 'Ihre Worte und Ideen stoßen auf scharfe Kritik. Ein schwieriges und unproduktives Gespräch. Schwierigkeiten bei Reisen.',
          '4': 'Ein Konflikt mit Eltern oder älteren Verwandten. Ihre Handlungen könnten gegen Familientraditionen verstoßen.',
          '5': 'Ihre romantischen oder kreativen Impulse stoßen auf Kälte und Einschränkungen. Ein Partner könnte zu streng sein.',
          '6': 'Ein Konflikt mit Kollegen oder einem Chef, der die Arbeit stört. Ein Gefühl, gezwungen zu sein, das zu tun, was man nicht will.',
          '7': 'Eine direkte Konfrontation mit einem Partner. Er fungiert als "Bremse" für Ihre Initiativen. Die Beziehung wird auf die Probe gestellt.',
          '8': 'Ihre Handlungen können zu finanziellen Verlusten oder einer Krise führen. Ein Konflikt um gemeinsame Ressourcen oder Schulden.',
          '9': 'Ihre Reise- oder Studienpläne stoßen auf ernsthafte Hindernisse. Ein Konflikt mit einem Lehrer oder Mentor.',
          '10': 'Ihre Handlungen verstoßen gegen die Anforderungen Ihres Chefs oder soziale Normen. Ein ernster Konflikt, der Ihrer Karriere schaden könnte.',
          '11': 'Ein Konflikt mit einem Freund (oft älter), der versucht, Sie zu kontrollieren oder einzuschränken.',
          '12': 'Ihre Handlungen werden von verborgenen Feinden oder Ihren eigenen Ängsten blockiert. Ein Gefühl von Ohnmacht und Frustration.'
        }
      }
    ),
    AspectInterpretation(
      id: 'VENUS_SQUARE_JUPITER',
      title: {
        'ru': 'Конфликт Венеры и Юпитера',
        'en': 'Venus Square Jupiter',
        'fr': 'Vénus Carré Jupiter',
        'de': 'Venus-Quadrat-Jupiter'
      },
      descriptionGeneral: {
        'ru': 'День потакания своим слабостям. Склонность к излишествам в еде, тратах и чувствах. Лень, гедонизм и невыполненные обещания. Трудно отказать себе в удовольствиях, даже если это вредно.',
        'en': 'A day of indulging your weaknesses. A tendency towards excess in food, spending, and feelings. Laziness, hedonism, and unfulfilled promises. It\'s hard to deny yourself pleasures, even if it\'s harmful.',
        'fr': 'Une journée pour céder à vos faiblesses. Tendance à l\'excès dans la nourriture, les dépenses et les sentiments. Paresse, hédonisme et promesses non tenues. Difficile de se refuser des plaisirs, même si c\'est nocif.',
        'de': 'Ein Tag, an dem Sie Ihren Schwächen nachgeben. Eine Tendenz zu Exzessen bei Essen, Ausgaben und Gefühlen. Faulheit, Hedonismus und unerfüllte Versprechen. Es ist schwer, sich Vergnügen zu versagen, auch wenn es schädlich ist.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Вы склонны переоценивать свою привлекательность и обаяние. Потакание себе во всем может повредить имиджу.',
          '2': 'Неоправданные траты на предметы роскоши и развлечения. Желание жить "на широкую ногу" может привести к финансовым проблемам.',
          '3': 'Пустые обещания, лесть и неискренние комплименты. Вы можете говорить то, что от вас хотят услышать, а не то, что вы думаете.',
          '4': 'Лень в домашних делах. Желание создать "красивую картинку" в семье, игнорируя реальные проблемы.',
          '5': 'Погоня за удовольствиями. Вы можете давать слишком много обещаний в любви, которые не сможете выполнить. Риск переедания.',
          '6': 'Лень на работе. Вы предпочитаете приятное общение выполнению обязанностей. Потакание вредным привычкам.',
          '7': 'Вы или ваш партнер можете быть слишком ленивы или давать пустые обещания. Отношениям не хватает искренности.',
          '8': 'Неосторожность в вопросах совместных финансов. Вы можете потратить общие деньги на сиюминутные удовольствия.',
          '9': 'Ваши взгляды на любовь и отношения могут быть слишком идеалистичными и оторванными от реальности.',
          '10': 'Ваше желание "красивой жизни" может идти вразрез с карьерными обязанностями. Репутация может пострадать из-за лени.',
          '11': 'Чрезмерные траты на развлечения с друзьями. Дружба может быть поверхностной, основанной на совместных удовольствиях.',
          '12': 'Тайные удовольствия и потакание своим слабостям. Вы можете обманывать себя насчет истинного положения дел.'
        },
        'en': {
          '1': 'You tend to overestimate your attractiveness and charm. Indulging yourself in everything can damage your image.',
          '2': 'Unjustified spending on luxury items and entertainment. The desire to live "large" can lead to financial problems.',
          '3': 'Empty promises, flattery, and insincere compliments. You might say what people want to hear, not what you think.',
          '4': 'Laziness in household chores. A desire to create a "pretty picture" in the family while ignoring real problems.',
          '5': 'The pursuit of pleasure. You might make too many promises in love that you can\'t keep. Risk of overeating.',
          '6': 'Laziness at work. You prefer pleasant conversation to fulfilling your duties. Indulgence in bad habits.',
          '7': 'You or your partner may be too lazy or make empty promises. The relationship lacks sincerity.',
          '8': 'Carelessness in matters of joint finances. You might spend shared money on fleeting pleasures.',
          '9': 'Your views on love and relationships might be too idealistic and detached from reality.',
          '10': 'Your desire for the "good life" may conflict with your career responsibilities. Your reputation could suffer due to laziness.',
          '11': 'Excessive spending on entertainment with friends. Friendships may be superficial, based on shared pleasures.',
          '12': 'Secret pleasures and indulging your weaknesses. You might be deceiving yourself about the true state of affairs.'
        },
        'fr': {
          '1': 'Vous avez tendance à surestimer votre attrait et votre charme. Vous faire plaisir en tout peut nuire à votre image.',
          '2': 'Dépenses injustifiées pour des articles de luxe et des divertissements. Le désir de vivre "sur un grand pied" peut entraîner des problèmes financiers.',
          '3': 'Promesses vides, flatterie et compliments peu sincères. Vous pourriez dire ce que les gens veulent entendre, pas ce que vous pensez.',
          '4': 'Paresse dans les tâches ménagères. Un désir de créer une "belle image" dans la famille tout en ignorant les vrais problèmes.',
          '5': 'La poursuite du plaisir. Vous pourriez faire trop de promesses en amour que vous ne pouvez pas tenir. Risque de suralimentation.',
          '6': 'Paresse au travail. Vous préférez une conversation agréable à l\'accomplissement de vos devoirs. Complaisance dans les mauvaises habitudes.',
          '7': 'Vous ou votre partenaire pouvez être trop paresseux ou faire des promesses en l\'air. La relation manque de sincérité.',
          '8': 'Négligence en matière de finances communes. Vous pourriez dépenser de l\'argent partagé pour des plaisirs éphémères.',
          '9': 'Vos vues sur l\'amour et les relations pourraient être trop idéalistes et détachées de la réalité.',
          '10': 'Votre désir de "la belle vie" peut entrer en conflit avec vos responsabilités professionnelles. Votre réputation pourrait souffrir de la paresse.',
          '11': 'Dépenses excessives pour des divertissements avec des amis. Les amitiés peuvent être superficielles, basées sur des plaisirs partagés.',
          '12': 'Plaisirs secrets et complaisance envers vos faiblesses. Vous pourriez vous tromper sur la véritable situation.'
        },
        'de': {
          '1': 'Sie neigen dazu, Ihre Attraktivität und Ihren Charme zu überschätzen. Sich in allem nachzugeben, kann Ihrem Image schaden.',
          '2': 'Ungerechtfertigte Ausgaben für Luxusartikel und Unterhaltung. Der Wunsch, "auf großem Fuß" zu leben, kann zu finanziellen Problemen führen.',
          '3': 'Leere Versprechungen, Schmeicheleien und unaufrichtige Komplimente. Sie sagen vielleicht, was die Leute hören wollen, nicht, was Sie denken.',
          '4': 'Faulheit bei der Hausarbeit. Der Wunsch, ein "schönes Bild" in der Familie zu schaffen, während man echte Probleme ignoriert.',
          '5': 'Das Streben nach Vergnügen. Sie könnten in der Liebe zu viele Versprechungen machen, die Sie nicht halten können. Gefahr des Überessens.',
          '6': 'Faulheit bei der Arbeit. Sie bevorzugen angenehme Gespräche anstelle der Erfüllung Ihrer Pflichten. Nachsicht bei schlechten Gewohnheiten.',
          '7': 'Sie oder Ihr Partner sind möglicherweise zu faul oder machen leere Versprechungen. Der Beziehung fehlt es an Aufrichtigkeit.',
          '8': 'Unachtsamkeit in Fragen gemeinsamer Finanzen. Sie könnten gemeinsames Geld für flüchtige Vergnügen ausgeben.',
          '9': 'Ihre Ansichten über Liebe und Beziehungen könnten zu idealistisch und realitätsfern sein.',
          '10': 'Ihr Wunsch nach dem "guten Leben" kann mit Ihren beruflichen Pflichten in Konflikt geraten. Ihr Ruf könnte unter Faulheit leiden.',
          '11': 'Übermäßige Ausgaben für Unterhaltung mit Freunden. Freundschaften können oberflächlich sein und auf gemeinsamen Vergnügen beruhen.',
          '12': 'Geheime Vergnügen und Nachgeben gegenüber Ihren Schwächen. Sie könnten sich über den wahren Stand der Dinge täuschen.'
        }
      }
    ),
    AspectInterpretation(
      id: 'SUN_TRINE_URANUS',
      title: {
        'ru': 'Гармония Солнца и Урана',
        'en': 'Sun Trine Uranus',
        'fr': 'Soleil Trigone Uranus',
        'de': 'Sonne-Trigon-Uranus'
      },
      descriptionGeneral: {
        'ru': 'День приятных сюрпризов и творческих озарений. Ваша индивидуальность (Солнце) легко и гармонично проявляется через оригинальность (Уран). Отличное время для перемен, общения с друзьями и экспериментов.',
        'en': 'A day of pleasant surprises and creative insights. Your individuality (Sun) is easily and harmoniously expressed through originality (Uranus). An excellent time for changes, socializing with friends, and experiments.',
        'fr': 'Une journée de belles surprises et d\'idées créatives. Votre individualité (Soleil) s\'exprime facilement et harmonieusement à travers l\'originalité (Uranus). Un excellent moment pour les changements, la socialisation avec des amis et les expériences.',
        'de': 'Ein Tag voller angenehmer Überraschungen und kreativer Einsichten. Ihre Individualität (Sonne) drückt sich leicht und harmonisch durch Originalität (Uranus) aus. Eine ausgezeichnete Zeit für Veränderungen, Geselligkeit mit Freunden und Experimente.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Ваша уникальность и оригинальность привлекают к вам людей. Легко проявить себя с неожиданной, но позитивной стороны.',
          '2': 'Неожиданные финансовые возможности, часто связанные с технологиями, интернетом или друзьями.',
          '3': 'Блестящие, нестандартные идеи. Легко заводить новые интересные знакомства. Неожиданные, но приятные поездки.',
          '4': 'Позитивные перемены в доме. Вы можете спонтанно решить сделать перестановку или купить новый гаджет, что порадует семью.',
          '5': 'Внезапная влюбленность или приятный сюрприз от партнера. Отношениям придается новизна и волнение.',
          '6': 'Новые технологии или методы помогают вам в работе. Легко вносите позитивные изменения в свой распорядок дня.',
          '7': 'Партнер может приятно удивить вас. Отношения получают заряд свободы и новизны. Легко познакомиться с кем-то необычным.',
          '8': 'Неожиданные позитивные сдвиги в вопросах общих финансов. Внезапное озарение помогает решить сложную проблему.',
          '9': 'Спонтанное решение отправиться в путешествие оказывается очень удачным. Новые идеи меняют ваше мировоззрение к лучшему.',
          '10': 'Ваши оригинальные идеи получают признание в карьере. Неожиданное, но приятное изменение вашего статуса.',
          '11': 'Исполнение желаний через друзей или коллектив. Внезапные и радостные события, связанные с друзьями.',
          '12': 'Внезапное озарение помогает вам освободиться от старых страхов. Интуиция подсказывает оригинальные и верные решения.'
        },
        'en': {
          '1': 'Your uniqueness and originality attract people to you. It\'s easy to show an unexpected but positive side of yourself.',
          '2': 'Unexpected financial opportunities, often related to technology, the internet, or friends.',
          '3': 'Brilliant, unconventional ideas. It\'s easy to make new and interesting acquaintances. Unexpected but pleasant trips.',
          '4': 'Positive changes at home. You might spontaneously decide to rearrange furniture or buy a new gadget, which will please the family.',
          '5': 'A sudden infatuation or a pleasant surprise from your partner. The relationship gets a boost of novelty and excitement.',
          '6': 'New technologies or methods help you at work. You easily make positive changes to your daily routine.',
          '7': 'Your partner might pleasantly surprise you. The relationship gets a charge of freedom and novelty. It\'s easy to meet someone unusual.',
          '8': 'Unexpected positive shifts in matters of joint finances. A sudden insight helps solve a complex problem.',
          '9': 'A spontaneous decision to go on a trip turns out to be very successful. New ideas change your worldview for the better.',
          '10': 'Your original ideas receive recognition in your career. An unexpected but pleasant change in your status.',
          '11': 'Fulfillment of desires through friends or a group. Sudden and joyful events related to friends.',
          '12': 'A sudden insight helps you break free from old fears. Intuition suggests original and correct solutions.'
        },
        'fr': {
          '1': 'Votre unicité et votre originalité attirent les gens vers vous. Il est facile de montrer un côté inattendu mais positif de vous-même.',
          '2': 'Opportunités financières inattendues, souvent liées à la technologie, à Internet ou à des amis.',
          '3': 'Idées brillantes et non conventionnelles. Il est facile de faire de nouvelles connaissances intéressantes. Voyages inattendus mais agréables.',
          '4': 'Changements positifs à la maison. Vous pourriez décider spontanément de réorganiser les meubles ou d\'acheter un nouveau gadget, ce qui plaira à la famille.',
          '5': 'Un engouement soudain ou une agréable surprise de votre partenaire. La relation reçoit un élan de nouveauté et d\'excitation.',
          '6': 'De nouvelles technologies ou méthodes vous aident au travail. Vous apportez facilement des changements positifs à votre routine quotidienne.',
          '7': 'Votre partenaire pourrait vous surprendre agréablement. La relation reçoit une charge de liberté et de nouveauté. Il est facile de rencontrer quelqu\'un d\'inhabituel.',
          '8': 'Changements positifs inattendus en matière de finances communes. Une prise de conscience soudaine aide à résoudre un problème complexe.',
          '9': 'Une décision spontanée de partir en voyage s\'avère très réussie. De nouvelles idées changent votre vision du monde pour le mieux.',
          '10': 'Vos idées originales sont reconnues dans votre carrière. Un changement inattendu mais agréable de votre statut.',
          '11': 'Réalisation des désirs grâce à des amis ou à un groupe. Événements soudains et joyeux liés aux amis.',
          '12': 'Une prise de conscience soudaine vous aide à vous libérer de vieilles peurs. L\'intuition suggère des solutions originales et correctes.'
        },
        'de': {
          '1': 'Ihre Einzigartigkeit und Originalität ziehen die Menschen an. Es ist leicht, eine unerwartete, aber positive Seite von sich zu zeigen.',
          '2': 'Unerwartete finanzielle Möglichkeiten, oft im Zusammenhang mit Technologie, dem Internet oder Freunden.',
          '3': 'Brillante, unkonventionelle Ideen. Es ist leicht, neue und interessante Bekanntschaften zu machen. Unerwartete, aber angenehme Reisen.',
          '4': 'Positive Veränderungen zu Hause. Sie könnten spontan beschließen, Möbel umzustellen oder ein neues Gerät zu kaufen, was die Familie erfreuen wird.',
          '5': 'Eine plötzliche Verliebtheit oder eine angenehme Überraschung von Ihrem Partner. Die Beziehung erhält einen Schub an Neuheit und Aufregung.',
          '6': 'Neue Technologien oder Methoden helfen Ihnen bei der Arbeit. Sie nehmen leicht positive Änderungen an Ihrem Tagesablauf vor.',
          '7': 'Ihr Partner könnte Sie angenehm überraschen. Die Beziehung erhält eine Ladung Freiheit und Neuheit. Es ist leicht, jemanden Ungewöhnlichen zu treffen.',
          '8': 'Unerwartete positive Verschiebungen in Fragen gemeinsamer Finanzen. Eine plötzliche Einsicht hilft, ein komplexes Problem zu lösen.',
          '9': 'Eine spontane Entscheidung, auf eine Reise zu gehen, erweist sich als sehr erfolgreich. Neue Ideen verändern Ihre Weltanschauung zum Besseren.',
          '10': 'Ihre originellen Ideen finden in Ihrer Karriere Anerkennung. Eine unerwartete, aber angenehme Veränderung Ihres Status.',
          '11': 'Erfüllung von Wünschen durch Freunde oder eine Gruppe. Plötzliche und freudige Ereignisse im Zusammenhang mit Freunden.',
          '12': 'Eine plötzliche Einsicht hilft Ihnen, sich von alten Ängsten zu befreien. Die Intuition schlägt originelle und richtige Lösungen vor.'
        }
      }
    ),
    AspectInterpretation(
      id: 'MERCURY_SEXTILE_MARS',
      title: {
        'ru': 'Шанс от Меркурия и Марса',
        'en': 'Mercury Sextile Mars',
        'fr': 'Mercure Sextile Mars',
        'de': 'Merkur-Sextil-Mars'
      },
      descriptionGeneral: {
        'ru': 'День быстрого ума и решительных слов. Мысли (Меркурий) легко превращаются в действия (Марс). Отлично для деловых переговоров, учебы, отстаивания своей точки зрения и принятия быстрых решений.',
        'en': 'A day of quick wit and decisive words. Thoughts (Mercury) easily turn into actions (Mars). Excellent for business negotiations, studying, defending your point of view, and making quick decisions.',
        'fr': 'Une journée d\'esprit vif et de paroles décisives. Les pensées (Mercure) se transforment facilement en actions (Mars). Excellent pour les négociations commerciales, les études, la défense de son point de vue et la prise de décisions rapides.',
        'de': 'Ein Tag des schnellen Verstandes und entscheidender Worte. Gedanken (Merkur) verwandeln sich leicht in Handlungen (Mars). Ausgezeichnet für Geschäftsverhandlungen, Studium, das Verteidigen des eigenen Standpunkts und schnelle Entscheidungen.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Вы говорите и действуете уверенно и прямолинейно. Легко убедить других в своей правоте.',
          '2': 'Быстрые и точные решения в финансовых вопросах. Хорошая возможность найти новый источник дохода благодаря своей предприимчивости.',
          '3': 'Вы сообразительны и остроумны. Легко даются споры, дебаты, экзамены. Успешные короткие поездки.',
          '4': 'Возможность быстро и эффективно решить бытовые проблемы. Прямой и честный разговор с семьей.',
          '5': 'Смелый и прямой флирт. Хорошая возможность проявить инициативу в любви. Успех в интеллектуальных играх и спорте.',
          '6': 'Высокая продуктивность и сообразительность на работе. Легко справляетесь с задачами, требующими быстрой реакции.',
          '7': 'Честный и открытый диалог с партнером. Легко договориться о совместных действиях и планах.',
          '8': 'Возможность быстро разобраться в сложной финансовой или психологической проблеме. Решительность в интимных вопросах.',
          '9': 'Быстрое усвоение новой информации. Успешная сдача экзаменов. Хорошая возможность спланировать и начать путешествие.',
          '10': 'Решительный разговор с начальством, который может привести к успеху. Ваши идеи быстро находят применение в карьере.',
          '11': 'Вы можете стать "мозговым центром" в компании друзей. Легко организовать совместную деятельность.',
          '12': 'Быстрое и точное понимание своих скрытых мотивов. Интуиция и логика работают вместе.'
        },
        'en': {
          '1': 'You speak and act with confidence and directness. It\'s easy to convince others you are right.',
          '2': 'Quick and accurate decisions in financial matters. A good opportunity to find a new source of income thanks to your enterprise.',
          '3': 'You are quick-witted and sharp. Arguments, debates, and exams come easily. Successful short trips.',
          '4': 'An opportunity to quickly and efficiently solve household problems. A direct and honest conversation with family.',
          '5': 'Bold and direct flirting. A good opportunity to take the initiative in love. Success in intellectual games and sports.',
          '6': 'High productivity and quick-wittedness at work. You easily handle tasks that require a quick reaction.',
          '7': 'An honest and open dialogue with your partner. It\'s easy to agree on joint actions and plans.',
          '8': 'An opportunity to quickly figure out a complex financial or psychological problem. Decisiveness in intimate matters.',
          '9': 'Quick absorption of new information. Successful passing of exams. A good opportunity to plan and start a trip.',
          '10': 'A decisive conversation with your boss that can lead to success. Your ideas quickly find application in your career.',
          '11': 'You can become the "think tank" in your group of friends. It\'s easy to organize a joint activity.',
          '12': 'A quick and accurate understanding of your hidden motives. Intuition and logic work together.'
        },
        'fr': {
          '1': 'Vous parlez et agissez avec confiance et franchise. Il est facile de convaincre les autres que vous avez raison.',
          '2': 'Décisions rapides et précises en matière financière. Une bonne occasion de trouver une nouvelle source de revenus grâce à votre esprit d\'entreprise.',
          '3': 'Vous êtes vif d\'esprit et perspicace. Les disputes, les débats et les examens sont faciles. Voyages courts réussis.',
          '4': 'Une occasion de résoudre rapidement et efficacement les problèmes ménagers. Une conversation directe et honnête avec la famille.',
          '5': 'Flirt audacieux et direct. Une bonne occasion de prendre l\'initiative en amour. Succès dans les jeux intellectuels et les sports.',
          '6': 'Grande productivité et vivacité d\'esprit au travail. Vous gérez facilement les tâches qui nécessitent une réaction rapide.',
          '7': 'Un dialogue honnête et ouvert avec votre partenaire. Il est facile de se mettre d\'accord sur des actions et des plans communs.',
          '8': 'Une occasion de démêler rapidement un problème financier ou psychologique complexe. Décision dans les affaires intimes.',
          '9': 'Absorption rapide de nouvelles informations. Réussite aux examens. Une bonne occasion de planifier et de commencer un voyage.',
          '10': 'Une conversation décisive avec votre patron qui peut mener au succès. Vos idées trouvent rapidement une application dans votre carrière.',
          '11': 'Vous pouvez devenir le "cerveau" de votre groupe d\'amis. Il est facile d\'organiser une activité commune.',
          '12': 'Une compréhension rapide et précise de vos motivations cachées. L\'intuition et la logique travaillent ensemble.'
        },
        'de': {
          '1': 'Sie sprechen und handeln selbstbewusst und direkt. Es ist leicht, andere von Ihrer Richtigkeit zu überzeugen.',
          '2': 'Schnelle und genaue Entscheidungen in finanziellen Angelegenheiten. Eine gute Gelegenheit, dank Ihrer Unternehmungslust eine neue Einnahmequelle zu finden.',
          '3': 'Sie sind schlagfertig und scharfsinnig. Auseinandersetzungen, Debatten und Prüfungen fallen Ihnen leicht. Erfolgreiche Kurztrips.',
          '4': 'Eine Gelegenheit, Haushaltsprobleme schnell und effizient zu lösen. Ein direktes und ehrliches Gespräch mit der Familie.',
          '5': 'Kühnes und direktes Flirten. Eine gute Gelegenheit, die Initiative in der Liebe zu ergreifen. Erfolg bei intellektuellen Spielen und Sport.',
          '6': 'Hohe Produktivität und Schlagfertigkeit bei der Arbeit. Sie bewältigen leicht Aufgaben, die eine schnelle Reaktion erfordern.',
          '7': 'Ein ehrlicher und offener Dialog mit Ihrem Partner. Es ist leicht, sich auf gemeinsame Aktionen und Pläne zu einigen.',
          '8': 'Eine Gelegenheit, ein komplexes finanzielles oder psychologisches Problem schnell zu durchschauen. Entschlossenheit in intimen Angelegenheiten.',
          '9': 'Schnelle Aufnahme neuer Informationen. Erfolgreiches Bestehen von Prüfungen. Eine gute Gelegenheit, eine Reise zu planen und zu beginnen.',
          '10': 'Ein entscheidendes Gespräch mit Ihrem Chef, das zum Erfolg führen kann. Ihre Ideen finden schnell Anwendung in Ihrer Karriere.',
          '11': 'Sie können zum "Denkzentrum" in Ihrer Freundesgruppe werden. Es ist leicht, eine gemeinsame Aktivität zu organisieren.',
          '12': 'Ein schnelles und genaues Verständnis Ihrer verborgenen Motive. Intuition und Logik arbeiten zusammen.'
        }
      }
    ),
        // === НОВЫЙ БЛОК 10 ===
    AspectInterpretation(
      id: 'VENUS_OPPOSITION_PLUTO',
      title: {
        'ru': 'Противостояние Венеры и Плутона',
        'en': 'Venus Opposition Pluto',
        'fr': 'Vénus Opposition Pluton',
        'de': 'Venus-Opposition-Pluto'
      },
      descriptionGeneral: {
        'ru': 'День мощных эмоциональных потрясений в любви и финансах. Отношения проверяются на прочность через ревность, манипуляции и борьбу за власть. Страсти кипят, возможны болезненные разрывы.',
        'en': 'A day of powerful emotional upheavals in love and finances. Relationships are tested through jealousy, manipulation, and power struggles. Passions run high, and painful breakups are possible.',
        'fr': 'Une journée de puissants bouleversements émotionnels en amour et en finances. Les relations sont mises à l\'épreuve par la jalousie, la manipulation et les luttes de pouvoir. Les passions sont vives et des ruptures douloureuses sont possibles.',
        'de': 'Ein Tag starker emotionaler Umwälzungen in Liebe und Finanzen. Beziehungen werden durch Eifersucht, Manipulation und Machtkämpfe auf die Probe gestellt. Leidenschaften kochen hoch, und schmerzhafte Trennungen sind möglich.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Ваша привлекательность становится причиной конфликтов и ревности. Кто-то может пытаться манипулировать вами или контролировать вас.',
          '2': 'Жестокая борьба за деньги. Финансовые отношения с партнером могут быть очень напряженными. Риск крупных потерь из-за чужих действий.',
          '3': 'Разговор превращается в допрос. Попытки выведать информацию, манипуляции словами. Раскрытие неприятных тайн.',
          '4': 'Борьба за власть и контроль в семье. Кто-то из домочадцев может оказывать на вас сильное психологическое давление.',
          '5': 'Любовь и страсть превращаются в одержимость. Сильная ревность, контроль, эмоциональный шантаж. Отношения на грани разрыва.',
          '6': 'Конфликт с коллегой (часто женщиной), который перерастает в настоящую войну. Интриги и подковерные игры на работе.',
          '7': 'Открытое противостояние с партнером. Он пытается вас контролировать, а вы сопротивляетесь. Кризис в отношениях.',
          '8': 'Серьезный кризис в интимной жизни или совместных финансах. Сексуальная энергия может использоваться для манипуляций.',
          '9': 'Конфликт убеждений с партнером. Попытки "переделать" друг друга могут привести к болезненному разрыву.',
          '10': 'Ваши личные отношения могут стать причиной скандала и повредить карьере. Конфликт с влиятельным человеком.',
          '11': 'Предательство или манипуляции со стороны друга. Дружба может быть разрушена из-за ревности или борьбы за влияние.',
          '12': 'Тайные любовные связи приводят к страданиям. Ваши скрытые комплексы и страхи проецируются на партнера.'
        },
        'en': {
          '1': 'Your attractiveness becomes a cause of conflict and jealousy. Someone may try to manipulate or control you.',
          '2': 'A fierce struggle for money. Financial relationships with a partner can be very tense. Risk of major losses due to others\' actions.',
          '3': 'A conversation turns into an interrogation. Attempts to extract information, manipulation with words. Revelation of unpleasant secrets.',
          '4': 'A power struggle and control within the family. One of the household members may exert strong psychological pressure on you.',
          '5': 'Love and passion turn into obsession. Intense jealousy, control, emotional blackmail. A relationship on the verge of a breakup.',
          '6': 'A conflict with a colleague (often female) that escalates into a real war. Intrigues and underhand games at work.',
          '7': 'An open confrontation with a partner. They try to control you, and you resist. A crisis in the relationship.',
          '8': 'A serious crisis in your intimate life or joint finances. Sexual energy can be used for manipulation.',
          '9': 'A conflict of beliefs with a partner. Attempts to "remake" each other can lead to a painful breakup.',
          '10': 'Your personal relationships can cause a scandal and damage your career. A conflict with an influential person.',
          '11': 'Betrayal or manipulation by a friend. A friendship can be destroyed by jealousy or a power struggle.',
          '12': 'Secret love affairs lead to suffering. Your hidden complexes and fears are projected onto your partner.'
        },
        'fr': {
          '1': 'Votre attrait devient une cause de conflit et de jalousie. Quelqu\'un peut essayer de vous manipuler ou de vous contrôler.',
          '2': 'Une lutte acharnée pour l\'argent. Les relations financières avec un partenaire peuvent être très tendues. Risque de pertes importantes dues aux actions des autres.',
          '3': 'Une conversation se transforme en interrogatoire. Tentatives d\'extraire des informations, manipulation par les mots. Révélation de secrets désagréables.',
          '4': 'Une lutte de pouvoir et de contrôle au sein de la famille. Un des membres du ménage peut exercer une forte pression psychologique sur vous.',
          '5': 'L\'amour et la passion se transforment en obsession. Jalousie intense, contrôle, chantage émotionnel. Une relation au bord de la rupture.',
          '6': 'Un conflit avec un collègue (souvent une femme) qui dégénère en véritable guerre. Intrigues et jeux de coulisses au travail.',
          '7': 'Une confrontation ouverte avec un partenaire. Il essaie de vous contrôler, et vous résistez. Une crise dans la relation.',
          '8': 'Une crise grave dans votre vie intime ou vos finances communes. L\'énergie sexuelle peut être utilisée à des fins de manipulation.',
          '9': 'Un conflit de croyances avec un partenaire. Les tentatives de se "refaire" mutuellement peuvent conduire à une rupture douloureuse.',
          '10': 'Vos relations personnelles peuvent provoquer un scandale et nuire à votre carrière. Un conflit avec une personne influente.',
          '11': 'Trahison ou manipulation par un ami. Une amitié peut être détruite par la jalousie ou une lutte de pouvoir.',
          '12': 'Les liaisons amoureuses secrètes mènent à la souffrance. Vos complexes et peurs cachés sont projetés sur votre partenaire.'
        },
        'de': {
          '1': 'Ihre Attraktivität wird zur Ursache von Konflikten und Eifersucht. Jemand könnte versuchen, Sie zu manipulieren oder zu kontrollieren.',
          '2': 'Ein erbitterter Kampf ums Geld. Finanzielle Beziehungen mit einem Partner können sehr angespannt sein. Risiko großer Verluste durch die Handlungen anderer.',
          '3': 'Ein Gespräch wird zum Verhör. Versuche, Informationen zu entlocken, Manipulation mit Worten. Enthüllung unangenehmer Geheimnisse.',
          '4': 'Ein Macht- und Kontrollkampf innerhalb der Familie. Einer der Haushaltsmitglieder könnte starken psychologischen Druck auf Sie ausüben.',
          '5': 'Liebe und Leidenschaft werden zur Besessenheit. Intensive Eifersucht, Kontrolle, emotionale Erpressung. Eine Beziehung am Rande des Zusammenbruchs.',
          '6': 'Ein Konflikt mit einem Kollegen (oft weiblich), der zu einem echten Krieg eskaliert. Intrigen und Machtspiele bei der Arbeit.',
          '7': 'Eine offene Konfrontation mit einem Partner. Er versucht, Sie zu kontrollieren, und Sie wehren sich. Eine Krise in der Beziehung.',
          '8': 'Eine schwere Krise in Ihrem Intimleben oder den gemeinsamen Finanzen. Sexuelle Energie kann zur Manipulation missbraucht werden.',
          '9': 'Ein Glaubenskonflikt mit einem Partner. Versuche, sich gegenseitig zu "verändern", können zu einer schmerzhaften Trennung führen.',
          '10': 'Ihre persönlichen Beziehungen können einen Skandal verursachen und Ihrer Karriere schaden. Ein Konflikt mit einer einflussreichen Person.',
          '11': 'Verrat oder Manipulation durch einen Freund. Eine Freundschaft kann durch Eifersucht oder einen Machtkampf zerstört werden.',
          '12': 'Geheime Liebesaffären führen zu Leid. Ihre verborgenen Komplexe und Ängste werden auf Ihren Partner projiziert.'
        }
      }
    ),
    AspectInterpretation(
      id: 'MARS_OPPOSITION_URANUS',
      title: {
        'ru': 'Противостояние Марса и Урана',
        'en': 'Mars Opposition Uranus',
        'fr': 'Mars Opposition Uranus',
        'de': 'Mars-Opposition-Uranus'
      },
      descriptionGeneral: {
        'ru': 'Экстремально взрывной и непредсказуемый день. Ваши действия (Марс) сталкиваются с бунтарством и хаосом со стороны других (Уран). Высочайший риск конфликтов, несчастных случаев, аварий. Действуйте крайне осторожно.',
        'en': 'An extremely explosive and unpredictable day. Your actions (Mars) clash with rebellion and chaos from others (Uranus). The highest risk of conflicts, accidents, and crashes. Act with extreme caution.',
        'fr': 'Une journée extrêmement explosive et imprévisible. Vos actions (Mars) se heurtent à la rébellion et au chaos des autres (Uranus). Risque très élevé de conflits, d\'accidents et de collisions. Agissez avec une extrême prudence.',
        'de': 'Ein extrem explosiver und unvorhersehbarer Tag. Ihre Handlungen (Mars) kollidieren mit Rebellion und Chaos von anderen (Uranus). Höchstes Risiko für Konflikte, Unfälle und Zusammenstöße. Handeln Sie äußerst vorsichtig.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Кто-то провоцирует вас на импульсивные и опасные поступки. Не поддавайтесь на провокации. Риск травм.',
          '2': 'Неожиданные события могут привести к крупным финансовым потерям. Риск поломки дорогой техники.',
          '3': 'Конфликт с окружением может вспыхнуть моментально. Будьте предельно осторожны за рулем.',
          '4': 'Внезапные и разрушительные конфликты в семье. Кто-то из домашних может вести себя совершенно непредсказуемо.',
          '5': 'Внезапный и шокирующий разрыв отношений. Партнер может совершить нечто совершенно неожиданное. Избегайте рискованных развлечений.',
          '6': 'Хаос на работе. Ваши действия наталкиваются на сопротивление коллег, что может привести к срыву всех планов.',
          '7': 'Партнер или оппонент ведет себя как бунтарь, провоцируя вас на конфликт. Очень высокий риск разрыва отношений.',
          '8': 'Опасность кризисных ситуаций, связанных с финансами или риском для жизни. Избегайте экстрима.',
          '9': 'Ваши действия и убеждения сталкиваются с яростным сопротивлением. Срыв поездки из-за непредвиденных обстоятельств.',
          '10': 'Конфликт с начальством, который может привести к внезапному увольнению. Ваши действия могут разрушить вашу репутацию.',
          '11': 'Резкий и неожиданный разрыв с друзьями. Кто-то из друзей может предать вас или повести себя шокирующе.',
          '12': 'Тайные враги наносят неожиданный удар. Ваши собственные неконтролируемые импульсы могут привести к саморазрушению.'
        },
        'en': {
          '1': 'Someone is provoking you into impulsive and dangerous actions. Do not give in to provocation. Risk of injury.',
          '2': 'Unexpected events can lead to major financial losses. Risk of expensive equipment breaking down.',
          '3': 'A conflict with your surroundings can erupt instantly. Be extremely careful while driving.',
          '4': 'Sudden and destructive conflicts in the family. A household member may behave completely unpredictably.',
          '5': 'A sudden and shocking breakup. A partner might do something completely unexpected. Avoid risky entertainment.',
          '6': 'Chaos at work. Your actions meet resistance from colleagues, which can lead to the collapse of all plans.',
          '7': 'A partner or opponent acts like a rebel, provoking you into conflict. A very high risk of a breakup.',
          '8': 'Danger of crisis situations related to finances or life risk. Avoid extreme activities.',
          '9': 'Your actions and beliefs are met with fierce resistance. A trip is canceled due to unforeseen circumstances.',
          '10': 'A conflict with your boss that could lead to a sudden dismissal. Your actions could destroy your reputation.',
          '11': 'A sharp and unexpected break with friends. One of your friends might betray you or behave shockingly.',
          '12': 'Secret enemies deliver a surprise attack. Your own uncontrollable impulses can lead to self-destruction.'
        },
        'fr': {
          '1': 'Quelqu\'un vous provoque à des actions impulsives et dangereuses. Ne cédez pas à la provocation. Risque de blessure.',
          '2': 'Des événements inattendus peuvent entraîner des pertes financières importantes. Risque de panne d\'équipement coûteux.',
          '3': 'Un conflit avec votre entourage peut éclater instantanément. Soyez extrêmement prudent au volant.',
          '4': 'Conflits soudains et destructeurs dans la famille. Un membre du ménage peut se comporter de manière totalement imprévisible.',
          '5': 'Une rupture soudaine et choquante. Un partenaire pourrait faire quelque chose de complètement inattendu. Évitez les divertissements risqués.',
          '6': 'Chaos au travail. Vos actions rencontrent la résistance de vos collègues, ce qui peut entraîner l\'effondrement de tous les plans.',
          '7': 'Un partenaire ou un adversaire se comporte comme un rebelle, vous provoquant au conflit. Un risque très élevé de rupture.',
          '8': 'Danger de situations de crise liées aux finances ou au risque de vie. Évitez les activités extrêmes.',
          '9': 'Vos actions et vos croyances se heurtent à une résistance féroce. Un voyage est annulé en raison de circonstances imprévues.',
          '10': 'Un conflit avec votre patron qui pourrait entraîner un licenciement soudain. Vos actions pourraient détruire votre réputation.',
          '11': 'Une rupture brutale et inattendue avec des amis. Un de vos amis pourrait vous trahir ou se comporter de manière choquante.',
          '12': 'Des ennemis secrets lancent une attaque surprise. Vos propres impulsions incontrôlables peuvent mener à l\'autodestruction.'
        },
        'de': {
          '1': 'Jemand provoziert Sie zu impulsiven und gefährlichen Handlungen. Geben Sie der Provokation nicht nach. Verletzungsgefahr.',
          '2': 'Unerwartete Ereignisse können zu großen finanziellen Verlusten führen. Risiko, dass teure Geräte kaputtgehen.',
          '3': 'Ein Konflikt mit Ihrer Umgebung kann augenblicklich ausbrechen. Seien Sie extrem vorsichtig beim Fahren.',
          '4': 'Plötzliche und zerstörerische Konflikte in der Familie. Ein Haushaltsmitglied kann sich völlig unvorhersehbar verhalten.',
          '5': 'Eine plötzliche und schockierende Trennung. Ein Partner könnte etwas völlig Unerwartetes tun. Vermeiden Sie riskante Unterhaltung.',
          '6': 'Chaos bei der Arbeit. Ihre Handlungen stoßen auf Widerstand von Kollegen, was zum Scheitern aller Pläne führen kann.',
          '7': 'Ein Partner oder Gegner verhält sich wie ein Rebell und provoziert Sie zum Konflikt. Ein sehr hohes Risiko einer Trennung.',
          '8': 'Gefahr von Krisensituationen im Zusammenhang mit Finanzen oder Lebensgefahr. Vermeiden Sie extreme Aktivitäten.',
          '9': 'Ihre Handlungen und Überzeugungen stoßen auf heftigen Widerstand. Eine Reise wird aufgrund unvorhergesehener Umstände abgesagt.',
          '10': 'Ein Konflikt mit Ihrem Chef, der zu einer plötzlichen Entlassung führen könnte. Ihre Handlungen könnten Ihren Ruf zerstören.',
          '11': 'Ein scharfer und unerwarteter Bruch mit Freunden. Einer Ihrer Freunde könnte Sie verraten oder sich schockierend verhalten.',
          '12': 'Geheime Feinde führen einen Überraschungsangriff durch. Ihre eigenen unkontrollierbaren Impulse können zur Selbstzerstörung führen.'
        }
      }
    ),
    AspectInterpretation(
      id: 'SUN_SEXTILE_JUPITER',
      title: {
        'ru': 'Шанс от Солнца и Юпитера',
        'en': 'Sun Sextile Jupiter',
        'fr': 'Soleil Sextile Jupiter',
        'de': 'Sonne-Sextil-Jupiter'
      },
      descriptionGeneral: {
        'ru': 'День удачных возможностей и хорошего настроения. Появляются шансы для роста и расширения. Отличное время для общения, начала новых проектов, получения поддержки и планирования путешествий.',
        'en': 'A day of lucky opportunities and good mood. Chances for growth and expansion appear. An excellent time for socializing, starting new projects, getting support, and planning travel.',
        'fr': 'Une journée d\'opportunités chanceuses et de bonne humeur. Des chances de croissance et d\'expansion apparaissent. Un excellent moment pour socialiser, démarrer de nouveaux projets, obtenir du soutien et planifier des voyages.',
        'de': 'Ein Tag glücklicher Gelegenheiten und guter Laune. Chancen für Wachstum und Expansion ergeben sich. Eine ausgezeichnete Zeit für Geselligkeit, den Start neuer Projekte, die Unterstützungssuche und die Reiseplanung.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Ваш оптимизм и уверенность в себе открывают перед вами новые двери. Легко получить поддержку и произвести хорошее впечатление.',
          '2': 'Появляются возможности для улучшения финансового положения. Удачные сделки, возможность найти новый источник дохода.',
          '3': 'Общение приносит удачу. Хорошие новости, удачные переговоры и знакомства. Появляются интересные идеи.',
          '4': 'Хорошие возможности, связанные с домом или семьей. Удачная покупка недвижимости или позитивные изменения в семье.',
          '5': 'Шанс на приятное романтическое знакомство или удачное свидание. Возможность выиграть в лотерею или просто хорошо провести время.',
          '6': 'Возможности для улучшения условий труда или отношений с коллегами. Работа приносит удовольствие и признание.',
          '7': 'Появляется возможность для гармоничного партнерства. Удачный день для переговоров и поиска компромиссов.',
          '8': 'Шанс получить финансовую выгоду через партнера, наследство или инвестиции. Удачное решение сложных вопросов.',
          '9': 'Отличные возможности для путешествий, обучения, расширения кругозора. Ваши идеи получают поддержку.',
          '10': 'Появляется шанс для карьерного роста. Начальство или влиятельные люди могут заметить вас и предложить что-то хорошее.',
          '11': 'Друзья могут предоставить вам удачную возможность. Ваши надежды и мечты получают шанс на реализацию.',
          '12': 'Интуиция подсказывает, где вас ждет удача. Помощь может прийти из самого неожиданного источника.'
        },
        'en': {
          '1': 'Your optimism and self-confidence open new doors for you. It\'s easy to get support and make a good impression.',
          '2': 'Opportunities to improve your financial situation arise. Successful deals, a chance to find a new source of income.',
          '3': 'Communication brings luck. Good news, successful negotiations, and acquaintances. Interesting ideas appear.',
          '4': 'Good opportunities related to home or family. A successful real estate purchase or positive changes in the family.',
          '5': 'A chance for a pleasant romantic acquaintance or a successful date. An opportunity to win the lottery or just have a good time.',
          '6': 'Opportunities to improve working conditions or relationships with colleagues. Work brings pleasure and recognition.',
          '7': 'An opportunity for a harmonious partnership appears. A good day for negotiations and finding compromises.',
          '8': 'A chance to gain financial benefit through a partner, inheritance, or investment. Successful resolution of complex issues.',
          '9': 'Excellent opportunities for travel, learning, and broadening your horizons. Your ideas receive support.',
          '10': 'A chance for career growth appears. Superiors or influential people may notice you and offer something good.',
          '11': 'Friends may provide you with a lucky opportunity. Your hopes and dreams get a chance to be realized.',
          '12': 'Intuition tells you where luck awaits you. Help may come from the most unexpected source.'
        },
        'fr': {
          '1': 'Votre optimisme et votre confiance en vous vous ouvrent de nouvelles portes. Il est facile d\'obtenir du soutien et de faire bonne impression.',
          '2': 'Des opportunités d\'améliorer votre situation financière se présentent. Des transactions réussies, une chance de trouver une nouvelle source de revenus.',
          '3': 'La communication porte chance. Bonnes nouvelles, négociations et connaissances réussies. Des idées intéressantes apparaissent.',
          '4': 'Bonnes opportunités liées à la maison ou à la famille. Un achat immobilier réussi ou des changements positifs dans la famille.',
          '5': 'Une chance pour une agréable rencontre romantique ou un rendez-vous réussi. Une opportunité de gagner à la loterie ou simplement de passer un bon moment.',
          '6': 'Opportunités d\'améliorer les conditions de travail ou les relations avec les collègues. Le travail apporte plaisir et reconnaissance.',
          '7': 'Une opportunité pour un partenariat harmonieux se présente. Une bonne journée pour les négociations et la recherche de compromis.',
          '8': 'Une chance d\'obtenir un avantage financier par l\'intermédiaire d\'un partenaire, d\'un héritage ou d\'un investissement. Résolution réussie de problèmes complexes.',
          '9': 'Excellentes opportunités de voyager, d\'apprendre et d\'élargir vos horizons. Vos idées reçoivent un soutien.',
          '10': 'Une chance de croissance de carrière apparaît. Des supérieurs ou des personnes influentes peuvent vous remarquer et vous offrir quelque chose de bien.',
          '11': 'Les amis peuvent vous offrir une opportunité chanceuse. Vos espoirs et vos rêves ont une chance de se réaliser.',
          '12': 'L\'intuition vous dit où la chance vous attend. L\'aide peut venir de la source la plus inattendue.'
        },
        'de': {
          '1': 'Ihr Optimismus und Ihr Selbstvertrauen öffnen Ihnen neue Türen. Es ist leicht, Unterstützung zu bekommen und einen guten Eindruck zu hinterlassen.',
          '2': 'Es ergeben sich Möglichkeiten, Ihre finanzielle Situation zu verbessern. Erfolgreiche Geschäfte, eine Chance, eine neue Einnahmequelle zu finden.',
          '3': 'Kommunikation bringt Glück. Gute Nachrichten, erfolgreiche Verhandlungen und Bekanntschaften. Interessante Ideen tauchen auf.',
          '4': 'Gute Gelegenheiten im Zusammenhang mit Zuhause oder Familie. Ein erfolgreicher Immobilienkauf oder positive Veränderungen in der Familie.',
          '5': 'Eine Chance auf eine angenehme romantische Bekanntschaft oder ein erfolgreiches Date. Eine Gelegenheit, im Lotto zu gewinnen oder einfach eine gute Zeit zu haben.',
          '6': 'Möglichkeiten zur Verbesserung der Arbeitsbedingungen oder der Beziehungen zu Kollegen. Die Arbeit bringt Freude und Anerkennung.',
          '7': 'Es ergibt sich die Möglichkeit für eine harmonische Partnerschaft. Ein guter Tag für Verhandlungen und Kompromisssuche.',
          '8': 'Eine Chance, durch einen Partner, eine Erbschaft oder eine Investition einen finanziellen Vorteil zu erzielen. Erfolgreiche Lösung komplexer Probleme.',
          '9': 'Ausgezeichnete Möglichkeiten zum Reisen, Lernen und Erweitern des Horizonts. Ihre Ideen erhalten Unterstützung.',
          '1-': 'Es ergibt sich eine Chance für den beruflichen Aufstieg. Vorgesetzte oder einflussreiche Personen könnten Sie bemerken und Ihnen etwas Gutes anbieten.',
          '11': 'Freunde könnten Ihnen eine glückliche Gelegenheit bieten. Ihre Hoffnungen und Träume bekommen eine Chance, verwirklicht zu werden.',
          '12': 'Die Intuition sagt Ihnen, wo das Glück auf Sie wartet. Hilfe kann aus der unerwartetsten Quelle kommen.'
        }
      }
    ),
    AspectInterpretation(
      id: 'MOON_TRINE_MARS',
      title: {
        'ru': 'Гармония Луны и Марса',
        'en': 'Moon Trine Mars',
        'fr': 'Lune Trigone Mars',
        'de': 'Mond-Trigon-Mars'
      },
      descriptionGeneral: {
        'ru': 'День гармонии между чувствами и действиями. Ваши эмоции (Луна) и воля (Марс) работают в унисон. Легко проявить инициативу, защитить свои интересы и действовать в соответствии со своими потребностями.',
        'en': 'A day of harmony between feelings and actions. Your emotions (Moon) and will (Mars) work in unison. It\'s easy to take the initiative, protect your interests, and act according to your needs.',
        'fr': 'Une journée d\'harmonie entre les sentiments et les actions. Vos émotions (Lune) et votre volonté (Mars) travaillent à l\'unisson. Il est facile de prendre des initiatives, de protéger vos intérêts et d\'agir selon vos besoins.',
        'de': 'Ein Tag der Harmonie zwischen Gefühlen und Handlungen. Ihre Emotionen (Mond) und Ihr Wille (Mars) arbeiten im Einklang. Es ist leicht, die Initiative zu ergreifen, Ihre Interessen zu schützen und nach Ihren Bedürfnissen zu handeln.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Вы чувствуете себя уверенно и энергично. Ваши действия отражают ваши истинные чувства. Легко быть собой.',
          '2': 'Интуиция и решительность помогают в финансовых делах. Вы точно знаете, на что потратить деньги, и делаете это.',
          '3': 'Вы говорите прямо и честно, но без агрессии. Легко отстоять свою точку зрения и договориться.',
          '4': 'Энергичные и продуктивные действия по дому. Легко защитить интересы своей семьи. Гармония в домашних делах.',
          '5': 'Легко и естественно проявить инициативу в любви. Ваши чувства и сексуальное желание находятся в гармонии.',
          '6': 'Работа спорится. Вы с энтузиазмом беретесь за дела и быстро их выполняете. Хорошее самочувствие.',
          '7': 'Вы и ваш партнер действуете слаженно. Легко найти компромисс между личными потребностями и желаниями партнера.',
          '8': 'Гармония в интимной жизни. Вы чувствуете, чего хотите, и не боитесь это показать. Уверенность в решении финансовых вопросов.',
          '9': 'Ваши действия соответствуют вашим убеждениям. Легко начать путешествие или обучение, которое вам по душе.',
          '10': 'Вы интуитивно чувствуете, какие действия приведут к успеху в карьере. Ваша эмоциональная вовлеченность помогает в работе.',
          '11': 'Вы можете стать душой компании и вдохновить друзей на совместные действия. Легко отстаивать интересы группы.',
          '12': 'Ваша интуиция и внутренние порывы находятся в гармонии. Вы доверяете своим инстинктам, и они вас не подводят.'
        },
        'en': {
          '1': 'You feel confident and energetic. Your actions reflect your true feelings. It\'s easy to be yourself.',
          '2': 'Intuition and determination help in financial matters. You know exactly what to spend money on and you do it.',
          '3': 'You speak directly and honestly, but without aggression. It\'s easy to defend your point of view and reach an agreement.',
          '4': 'Energetic and productive actions at home. It\'s easy to protect your family\'s interests. Harmony in domestic affairs.',
          '5': 'It\'s easy and natural to take the initiative in love. Your feelings and sexual desire are in harmony.',
          '6': 'Work goes smoothly. You tackle tasks with enthusiasm and complete them quickly. Good well-being.',
          '7': 'You and your partner act in concert. It\'s easy to find a compromise between personal needs and your partner\'s desires.',
          '8': 'Harmony in your intimate life. You feel what you want and are not afraid to show it. Confidence in resolving financial issues.',
          '9': 'Your actions are in line with your beliefs. It\'s easy to start a trip or studies that you enjoy.',
          '10': 'You intuitively feel which actions will lead to career success. Your emotional involvement helps in your work.',
          '11': 'You can be the life of the party and inspire friends to joint action. It\'s easy to defend the group\'s interests.',
          '12': 'Your intuition and inner impulses are in harmony. You trust your instincts, and they do not let you down.'
        },
        'fr': {
          '1': 'Vous vous sentez confiant et énergique. Vos actions reflètent vos vrais sentiments. Il est facile d\'être soi-même.',
          '2': 'L\'intuition et la détermination aident dans les affaires financières. Vous savez exactement à quoi dépenser de l\'argent et vous le faites.',
          '3': 'Vous parlez directement et honnêtement, mais sans agression. Il est facile de défendre votre point de vue et de parvenir à un accord.',
          '4': 'Actions énergiques et productives à la maison. Il est facile de protéger les intérêts de votre famille. Harmonie dans les affaires domestiques.',
          '5': 'Il est facile et naturel de prendre l\'initiative en amour. Vos sentiments et votre désir sexuel sont en harmonie.',
          '6': 'Le travail se passe bien. Vous vous attaquez aux tâches avec enthousiasme et les terminez rapidement. Bon bien-être.',
          '7': 'Vous et votre partenaire agissez de concert. Il est facile de trouver un compromis entre les besoins personnels et les désirs de votre partenaire.',
          '8': 'Harmonie dans votre vie intime. Vous sentez ce que vous voulez et n\'avez pas peur de le montrer. Confiance dans la résolution des problèmes financiers.',
          '9': 'Vos actions sont conformes à vos croyances. Il est facile de commencer un voyage ou des études qui vous plaisent.',
          '10': 'Vous sentez intuitivement quelles actions mèneront au succès professionnel. Votre implication émotionnelle aide dans votre travail.',
          '11': 'Vous pouvez être l\'âme de la fête et inspirer des amis à une action commune. Il est facile de défendre les intérêts du groupe.',
          '12': 'Votre intuition et vos impulsions intérieures sont en harmonie. Vous faites confiance à vos instincts, et ils ne vous laissent pas tomber.'
        },
        'de': {
          '1': 'Sie fühlen sich selbstbewusst und energiegeladen. Ihre Handlungen spiegeln Ihre wahren Gefühle wider. Es ist leicht, man selbst zu sein.',
          '2': 'Intuition und Entschlossenheit helfen in finanziellen Angelegenheiten. Sie wissen genau, wofür Sie Geld ausgeben müssen, und Sie tun es.',
          '3': 'Sie sprechen direkt und ehrlich, aber ohne Aggression. Es ist leicht, seinen Standpunkt zu verteidigen und eine Einigung zu erzielen.',
          '4': 'Energische und produktive Handlungen zu Hause. Es ist leicht, die Interessen Ihrer Familie zu schützen. Harmonie in häuslichen Angelegenheiten.',
          '5': 'Es ist leicht und natürlich, die Initiative in der Liebe zu ergreifen. Ihre Gefühle und Ihr sexuelles Verlangen sind in Harmonie.',
          '6': 'Die Arbeit geht reibungslos. Sie gehen Aufgaben mit Begeisterung an und erledigen sie schnell. Gutes Wohlbefinden.',
          '7': 'Sie und Ihr Partner handeln im Einklang. Es ist leicht, einen Kompromiss zwischen persönlichen Bedürfnissen und den Wünschen Ihres Partners zu finden.',
          '8': 'Harmonie in Ihrem Intimleben. Sie spüren, was Sie wollen, und haben keine Angst, es zu zeigen. Vertrauen in die Lösung finanzieller Probleme.',
          '9': 'Ihre Handlungen stehen im Einklang mit Ihren Überzeugungen. Es ist leicht, eine Reise oder ein Studium zu beginnen, das Ihnen gefällt.',
          '10': 'Sie spüren intuitiv, welche Handlungen zum beruflichen Erfolg führen werden. Ihr emotionales Engagement hilft bei Ihrer Arbeit.',
          '11': 'Sie können der Mittelpunkt der Gesellschaft sein und Freunde zu gemeinsamen Aktionen inspirieren. Es ist leicht, die Interessen der Gruppe zu verteidigen.',
          '12': 'Ihre Intuition und Ihre inneren Impulse sind in Harmonie. Sie vertrauen Ihren Instinkten, und sie lassen Sie nicht im Stich.'
        }
      }
    ),
        // === НОВЫЙ БЛОК 11 ===
    AspectInterpretation(
      id: 'MERCURY_SQUARE_MARS',
      title: {
        'ru': 'Конфликт Меркурия и Марса',
        'en': 'Mercury Square Mars',
        'fr': 'Mercure Carré Mars',
        'de': 'Merkur-Quadrat-Mars'
      },
      descriptionGeneral: {
        'ru': 'День "острого языка" и споров. Мысли (Меркурий) становятся агрессивными (Марс). Высокий риск ссор, резкой критики, сарказма и необдуманных слов. Думайте, прежде чем говорить.',
        'en': 'A day of "sharp tongues" and arguments. Thoughts (Mercury) become aggressive (Mars). High risk of quarrels, sharp criticism, sarcasm, and thoughtless words. Think before you speak.',
        'fr': 'Une journée de "langues acérées" et de disputes. Les pensées (Mercure) deviennent agressives (Mars). Risque élevé de querelles, de critiques acerbes, de sarcasmes et de paroles irréfléchies. Pensez avant de parler.',
        'de': 'Ein Tag der "scharfen Zungen" und Auseinandersetzungen. Gedanken (Merkur) werden aggressiv (Mars). Hohes Risiko für Streit, scharfe Kritik, Sarkasmus und unüberlegte Worte. Denken Sie nach, bevor Sie sprechen.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Вы нетерпеливы и резки в суждениях. Ваши слова могут ранить других. Склонность перебивать и спорить.',
          '2': 'Споры и конфликты из-за денег. Вы можете слишком агрессивно отстаивать свои финансовые интересы.',
          '3': 'Высокий риск ссор с соседями, братьями/сестрами. Очень агрессивный стиль вождения. Избегайте споров в соцсетях.',
          '4': 'Ссоры и скандалы в семье. Вы можете быть слишком резки с домочадцами. Бытовые проблемы вызывают гнев.',
          '5': 'Конфликт с любимым человеком. Слова становятся оружием, вы можете сказать что-то, о чем пожалеете. Споры с детьми.',
          '6': 'Конфликты и споры на работе. Ваша критика может быть слишком жесткой. Риск травм из-за спешки.',
          '7': 'Открытый спор с партнером. Вы оба пытаетесь доказать свою правоту и не слышите друг друга. Не лучшее время для переговоров.',
          '8': 'Споры из-за общих финансов, долгов, наследства. Неосторожные слова могут разрушить доверие в интимных отношениях.',
          '9': 'Вы агрессивно отстаиваете свои убеждения. Споры на тему политики или религии. Конфликт с преподавателем.',
          '10': 'Конфликт с начальством. Ваши резкие слова могут повредить вашей карьере. Публичные споры.',
          '11': 'Ссоры с друзьями. Вы можете быть слишком нетерпимы к их мнению.',
          '12': 'Ваш внутренний диалог полон критики и самобичевания. Подавленный гнев может прорываться в виде сарказма.'
        },
        'en': {
          '1': 'You are impatient and harsh in your judgments. Your words can hurt others. A tendency to interrupt and argue.',
          '2': 'Disputes and conflicts over money. You might defend your financial interests too aggressively.',
          '3': 'High risk of quarrels with neighbors, siblings. A very aggressive driving style. Avoid arguments on social media.',
          '4': 'Quarrels and scandals in the family. You might be too harsh with your household members. Household problems cause anger.',
          '5': 'Conflict with a loved one. Words become weapons, you might say something you will regret. Arguments with children.',
          '6': 'Conflicts and disputes at work. Your criticism might be too harsh. Risk of injury due to haste.',
          '7': 'An open argument with a partner. You both try to prove you are right and don\'t listen to each other. Not the best time for negotiations.',
          '8': 'Disputes over joint finances, debts, inheritance. Careless words can destroy trust in an intimate relationship.',
          '9': 'You aggressively defend your beliefs. Arguments on politics or religion. Conflict with a teacher.',
          '10': 'Conflict with your boss. Your harsh words could damage your career. Public disputes.',
          '11': 'Quarrels with friends. You might be too intolerant of their opinions.',
          '12': 'Your inner dialogue is full of criticism and self-flagellation. Suppressed anger may erupt as sarcasm.'
        },
        'fr': {
          '1': 'Vous êtes impatient et dur dans vos jugements. Vos paroles peuvent blesser les autres. Tendance à interrompre et à discuter.',
          '2': 'Litiges et conflits d\'argent. Vous pourriez défendre vos intérêts financiers de manière trop agressive.',
          '3': 'Risque élevé de querelles avec les voisins, les frères et sœurs. Un style de conduite très agressif. Évitez les disputes sur les réseaux sociaux.',
          '4': 'Querelles et scandales dans la famille. Vous pourriez être trop dur avec les membres de votre foyer. Les problèmes ménagers provoquent la colère.',
          '5': 'Conflit avec un être cher. Les mots deviennent des armes, vous pourriez dire quelque chose que vous regretterez. Disputes avec les enfants.',
          '6': 'Conflits et disputes au travail. Votre critique pourrait être trop sévère. Risque de blessure dû à la précipitation.',
          '7': 'Une dispute ouverte avec un partenaire. Vous essayez tous les deux de prouver que vous avez raison et ne vous écoutez pas. Pas le meilleur moment pour les négociations.',
          '8': 'Litiges sur les finances communes, les dettes, l\'héritage. Des paroles imprudentes peuvent détruire la confiance dans une relation intime.',
          '9': 'Vous défendez agressivement vos croyances. Disputes sur la politique ou la religion. Conflit avec un enseignant.',
          '10': 'Conflit avec votre patron. Vos paroles dures pourraient nuire à votre carrière. Litiges publics.',
          '11': 'Querelles avec des amis. Vous pourriez être trop intolérant à leurs opinions.',
          '12': 'Votre dialogue intérieur est plein de critiques et d\'autoflagellation. La colère refoulée peut éclater sous forme de sarcasme.'
        },
        'de': {
          '1': 'Sie sind ungeduldig und hart in Ihren Urteilen. Ihre Worte können andere verletzen. Eine Tendenz, zu unterbrechen und zu streiten.',
          '2': 'Streitigkeiten und Konflikte um Geld. Sie könnten Ihre finanziellen Interessen zu aggressiv verteidigen.',
          '3': 'Hohes Risiko von Streit mit Nachbarn, Geschwistern. Ein sehr aggressiver Fahrstil. Vermeiden Sie Auseinandersetzungen in sozialen Medien.',
          '4': 'Streit und Skandale in der Familie. Sie könnten zu hart zu Ihren Haushaltsmitgliedern sein. Haushaltsprobleme verursachen Ärger.',
          '5': 'Konflikt mit einem geliebten Menschen. Worte werden zu Waffen, Sie könnten etwas sagen, das Sie bereuen werden. Streit mit Kindern.',
          '6': 'Konflikte und Auseinandersetzungen bei der Arbeit. Ihre Kritik könnte zu hart sein. Verletzungsgefahr durch Eile.',
          '7': 'Ein offener Streit mit einem Partner. Sie versuchen beide, Recht zu behalten und hören einander nicht zu. Keine gute Zeit für Verhandlungen.',
          '8': 'Streitigkeiten über gemeinsame Finanzen, Schulden, Erbschaften. Unvorsichtige Worte können das Vertrauen in einer intimen Beziehung zerstören.',
          '9': 'Sie verteidigen aggressiv Ihre Überzeugungen. Auseinandersetzungen über Politik oder Religion. Konflikt mit einem Lehrer.',
          '10': 'Konflikt mit Ihrem Chef. Ihre harten Worte könnten Ihrer Karriere schaden. Öffentliche Auseinandersetzungen.',
          '11': 'Streit mit Freunden. Sie könnten zu intolerant gegenüber ihren Meinungen sein.',
          '12': 'Ihr innerer Dialog ist voller Kritik und Selbstgeißelung. Unterdrückter Ärger kann als Sarkasmus ausbrechen.'
        }
      }
    ),
    AspectInterpretation(
      id: 'SUN_OPPOSITION_NEPTUNE',
      title: {
        'ru': 'Противостояние Солнца и Нептуна',
        'en': 'Sun Opposition Neptune',
        'fr': 'Soleil Opposition Neptune',
        'de': 'Sonne-Opposition-Neptun'
      },
      descriptionGeneral: {
        'ru': 'День потери ориентиров и жизненной энергии. Ваше "Я" (Солнце) растворяется в тумане иллюзий (Нептун). Апатия, самообман, неясность целей, риск стать жертвой обмана со стороны других.',
        'en': 'A day of losing direction and vital energy. Your "self" (Sun) dissolves in a fog of illusions (Neptune). Apathy, self-deception, unclear goals, risk of being deceived by others.',
        'fr': 'Une journée de perte de repères et d\'énergie vitale. Votre "moi" (Soleil) se dissout dans un brouillard d\'illusions (Neptune). Apathie, auto-illusion, objectifs flous, risque d\'être trompé par les autres.',
        'de': 'Ein Tag des Orientierungsverlusts und der Lebensenergie. Ihr "Ich" (Sonne) löst sich in einem Nebel von Illusionen (Neptun) auf. Apathie, Selbsttäuschung, unklare Ziele, Gefahr, von anderen betrogen zu werden.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Вы не понимаете, кто вы и чего хотите. Неуверенность в себе, склонность "плыть по течению". Другие могут легко обмануть вас.',
          '2': 'Хаос в финансах. Вы можете стать жертвой мошенников или просто потерять деньги из-за невнимательности. Неясные источники дохода.',
          '3': 'Обман в общении. Вы можете неверно понять информацию или вас могут сознательно ввести в заблуждение.',
          '4': 'Неясная ситуация в семье. Кто-то из домочадцев может быть неискренен. Вы идеализируете свою семью, не видя проблем.',
          '5': 'Вы идеализируете своего партнера, что ведет к разочарованию. Риск быть обманутым в любви. Творческий ступор.',
          '6': 'Полный упадок сил. Нет энергии и желания работать. Вы можете стать жертвой интриг на работе.',
          '7': 'Партнер может обманывать вас или быть крайне ненадежным. Вы "растворяетесь" в отношениях, теряя себя.',
          '8': 'Риск обмана в вопросах совместных финансов, страховок, налогов. Тайные связи могут разрушить доверие.',
          '9': 'Разочарование в своих идеалах или духовном учителе. Ваши убеждения могут оказаться иллюзией.',
          '10': 'Неясность в карьерных целях. Ваша репутация может пострадать из-за сплетен или обмана со стороны других.',
          '11': 'Друг может оказаться не тем, за кого себя выдает. Ваши надежды и мечты оказываются иллюзорными.',
          '12': 'Вы становитесь жертвой собственных или чужих иллюзий. Обострение зависимостей. Полная потеря контакта с реальностью.'
        },
        'en': {
          '1': 'You don\'t understand who you are or what you want. Self-doubt, a tendency to "go with the flow." Others can easily deceive you.',
          '2': 'Chaos in finances. You might become a victim of scammers or simply lose money due to carelessness. Unclear sources of income.',
          '3': 'Deception in communication. You might misunderstand information or be deliberately misled.',
          '4': 'An unclear situation in the family. A household member might be insincere. You idealize your family, not seeing the problems.',
          '5': 'You idealize your partner, which leads to disappointment. Risk of being deceived in love. Creative block.',
          '6': 'A complete lack of energy. No energy or desire to work. You might become a victim of intrigues at work.',
          '7': 'A partner may deceive you or be extremely unreliable. You "dissolve" in the relationship, losing yourself.',
          '8': 'Risk of deception in matters of joint finances, insurance, taxes. Secret affairs can destroy trust.',
          '9': 'Disappointment in your ideals or a spiritual teacher. Your beliefs may turn out to be an illusion.',
          '10': 'Uncertainty in career goals. Your reputation can suffer from gossip or deception by others.',
          '11': 'A friend may not be who they seem. Your hopes and dreams turn out to be illusory.',
          '12': 'You become a victim of your own or others\' illusions. Worsening of addictions. A complete loss of contact with reality.'
        },
        'fr': {
          '1': 'Vous ne comprenez pas qui vous êtes ni ce que vous voulez. Doute de soi, tendance à "suivre le courant". Les autres peuvent facilement vous tromper.',
          '2': 'Chaos dans les finances. Vous pourriez devenir victime d\'escrocs ou simplement perdre de l\'argent par négligence. Sources de revenus floues.',
          '3': 'Tromperie dans la communication. Vous pourriez mal comprendre une information ou être délibérément induit en erreur.',
          '4': 'Situation familiale floue. Un membre du ménage pourrait ne pas être sincère. Vous idéalisez votre famille, sans voir les problèmes.',
          '5': 'Vous idéalisez votre partenaire, ce qui mène à la déception. Risque d\'être trompé en amour. Blocage créatif.',
          '6': 'Manque total d\'énergie. Pas d\'énergie ni de désir de travailler. Vous pourriez devenir victime d\'intrigues au travail.',
          '7': 'Un partenaire peut vous tromper ou être extrêmement peu fiable. Vous vous "dissolvez" dans la relation, vous perdant vous-même.',
          '8': 'Risque de tromperie en matière de finances communes, d\'assurances, d\'impôts. Les liaisons secrètes peuvent détruire la confiance.',
          '9': 'Déception envers vos idéaux ou un guide spirituel. Vos croyances peuvent se révéler être une illusion.',
          '10': 'Incertitude quant aux objectifs de carrière. Votre réputation peut souffrir des commérages ou de la tromperie des autres.',
          '11': 'Un ami peut ne pas être celui qu\'il semble être. Vos espoirs et vos rêves se révèlent illusoires.',
          '12': 'Vous devenez victime de vos propres illusions ou de celles des autres. Aggravation des dépendances. Perte totale de contact avec la réalité.'
        },
        'de': {
          '1': 'Sie verstehen nicht, wer Sie sind oder was Sie wollen. Selbstzweifel, eine Tendenz, "mit dem Strom zu schwimmen". Andere können Sie leicht täuschen.',
          '2': 'Chaos in den Finanzen. Sie könnten Opfer von Betrügern werden oder einfach durch Unachtsamkeit Geld verlieren. Unklare Einkommensquellen.',
          '3': 'Täuschung in der Kommunikation. Sie könnten Informationen missverstehen oder absichtlich in die Irre geführt werden.',
          '4': 'Eine unklare Situation in der Familie. Ein Haushaltsmitglied könnte unaufrichtig sein. Sie idealisieren Ihre Familie und sehen die Probleme nicht.',
          '5': 'Sie idealisieren Ihren Partner, was zu Enttäuschungen führt. Gefahr, in der Liebe betrogen zu werden. Kreative Blockade.',
          '6': 'Ein völliger Energiemangel. Keine Energie oder Lust zu arbeiten. Sie könnten Opfer von Intrigen bei der Arbeit werden.',
          '7': 'Ein Partner könnte Sie täuschen oder äußerst unzuverlässig sein. Sie "lösen sich" in der Beziehung auf und verlieren sich selbst.',
          '8': 'Täuschungsrisiko bei gemeinsamen Finanzen, Versicherungen, Steuern. Geheime Affären können das Vertrauen zerstören.',
          '9': 'Enttäuschung von Ihren Idealen oder einem spirituellen Lehrer. Ihre Überzeugungen könnten sich als Illusion herausstellen.',
          '10': 'Unsicherheit bei den Karrierezielen. Ihr Ruf kann unter Klatsch oder Täuschung durch andere leiden.',
          '11': 'Ein Freund ist vielleicht nicht der, für den er sich ausgibt. Ihre Hoffnungen und Träume erweisen sich als illusorisch.',
          '12': 'Sie werden Opfer Ihrer eigenen oder fremder Illusionen. Verschlimmerung von Süchten. Ein völliger Verlust des Kontakts zur Realität.'
        }
      }
    ),
    AspectInterpretation(
      id: 'LUNA_SEXTILE_VENUS',
      title: {
        'ru': 'Шанс от Луны и Венеры',
        'en': 'Moon Sextile Venus',
        'fr': 'Lune Sextile Vénus',
        'de': 'Mond-Sextil-Venus'
      },
      descriptionGeneral: {
        'ru': 'День душевного комфорта, гармонии и приятного общения. Потребности (Луна) и желания (Венера) легко находят удовлетворение. Отлично для свиданий, заботы о себе, покупок и отдыха.',
        'en': 'A day of emotional comfort, harmony, and pleasant communication. Needs (Moon) and desires (Venus) are easily satisfied. Excellent for dates, self-care, shopping, and relaxation.',
        'fr': 'Une journée de confort émotionnel, d\'harmonie et de communication agréable. Les besoins (Lune) et les désirs (Vénus) sont facilement satisfaits. Excellent pour les rendez-vous, prendre soin de soi, le shopping et la détente.',
        'de': 'Ein Tag des emotionalen Komforts, der Harmonie und angenehmer Kommunikation. Bedürfnisse (Mond) und Wünsche (Venus) werden leicht befriedigt. Ausgezeichnet für Verabredungen, Selbstpflege, Einkaufen und Entspannung.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Вы обаятельны и миролюбивы. Легко находите общий язык с другими, особенно с женщинами.',
          '2': 'Возможность получить небольшой доход или сделать удачную покупку, которая принесет радость и комфорт.',
          '3': 'Очень приятное и легкое общение. Легко выразить свои чувства и симпатии, сделать комплимент.',
          '4': 'Гармония и уют в доме. Отличный день, чтобы пригласить гостей или просто насладиться домашним комфортом.',
          '5': 'Нежное и романтическое свидание. Легко проявить заботу и получить ее в ответ. Хорошее время для творчества.',
          '6': 'Приятная и дружелюбная атмосфера на работе. Легко договориться с коллегами. Работа приносит удовольствие.',
          '7': 'Полное взаимопонимание с партнером. Отношения наполнены нежностью, заботой и гармонией.',
          '8': 'Эмоциональная и физическая близость с партнером приносит радость. Возможность получить финансовую поддержку.',
          '9': 'Приятные новости издалека. Хороший день для планирования романтического путешествия.',
          '10': 'Ваше обаяние и дипломатичность помогают в карьере. Хорошие отношения с начальством.',
          '11': 'Душевная встреча с подругами. Легко получить эмоциональную поддержку и хороший совет.',
          '12': 'Ощущение внутреннего умиротворения. Хороший день для отдыха, медитации и наслаждения красотой в уединении.'
        },
        'en': {
          '1': 'You are charming and peaceful. It\'s easy to find common ground with others, especially with women.',
          '2': 'An opportunity to receive a small income or make a successful purchase that brings joy and comfort.',
          '3': 'Very pleasant and light communication. It\'s easy to express your feelings and affections, to give a compliment.',
          '4': 'Harmony and coziness at home. An excellent day to invite guests or simply enjoy home comfort.',
          '5': 'A tender and romantic date. It\'s easy to show care and receive it in return. A good time for creativity.',
          '6': 'A pleasant and friendly atmosphere at work. It\'s easy to agree with colleagues. Work brings pleasure.',
          '7': 'Complete mutual understanding with your partner. The relationship is filled with tenderness, care, and harmony.',
          '8': 'Emotional and physical intimacy with a partner brings joy. An opportunity to receive financial support.',
          '9': 'Pleasant news from afar. A good day to plan a romantic trip.',
          '10': 'Your charm and diplomacy help in your career. Good relations with superiors.',
          '11': 'A heartfelt meeting with female friends. It\'s easy to get emotional support and good advice.',
          '12': 'A feeling of inner peace. A good day for rest, meditation, and enjoying beauty in solitude.'
        },
        'fr': {
          '1': 'Vous êtes charmant et paisible. Il est facile de trouver un terrain d\'entente avec les autres, en particulier avec les femmes.',
          '2': 'Une opportunité de recevoir un petit revenu ou de faire un achat réussi qui apporte joie et confort.',
          '3': 'Communication très agréable et légère. Il est facile d\'exprimer ses sentiments et ses affections, de faire un compliment.',
          '4': 'Harmonie et confort à la maison. Une excellente journée pour inviter des invités ou simplement profiter du confort de la maison.',
          '5': 'Un rendez-vous tendre et romantique. Il est facile de montrer de l\'attention et d\'en recevoir en retour. Un bon moment pour la créativité.',
          '6': 'Une atmosphère agréable et amicale au travail. Il est facile de s\'entendre avec les collègues. Le travail apporte du plaisir.',
          '7': 'Compréhension mutuelle complète avec votre partenaire. La relation est remplie de tendresse, de soin et d\'harmonie.',
          '8': 'L\'intimité émotionnelle et physique avec un partenaire apporte de la joie. Une opportunité de recevoir un soutien financier.',
          '9': 'Nouvelles agréables de loin. Une bonne journée pour planifier un voyage romantique.',
          '10': 'Votre charme et votre diplomatie aident dans votre carrière. Bonnes relations avec les supérieurs.',
          '11': 'Une rencontre sincère avec des amies. Il est facile d\'obtenir un soutien émotionnel et de bons conseils.',
          '12': 'Un sentiment de paix intérieure. Une bonne journée pour le repos, la méditation et profiter de la beauté en solitude.'
        },
        'de': {
          '1': 'Sie sind charmant und friedlich. Es ist leicht, eine gemeinsame Basis mit anderen zu finden, besonders mit Frauen.',
          '2': 'Eine Gelegenheit, ein kleines Einkommen zu erzielen oder einen erfolgreichen Kauf zu tätigen, der Freude und Komfort bringt.',
          '3': 'Sehr angenehme und leichte Kommunikation. Es ist leicht, seine Gefühle und Zuneigungen auszudrücken, ein Kompliment zu machen.',
          '4': 'Harmonie und Gemütlichkeit zu Hause. Ein ausgezeichneter Tag, um Gäste einzuladen oder einfach den häuslichen Komfort zu genießen.',
          '5': 'Ein zärtliches und romantisches Date. Es ist leicht, Fürsorge zu zeigen und sie im Gegenzug zu erhalten. Eine gute Zeit für Kreativität.',
          '6': 'Eine angenehme und freundliche Atmosphäre bei der Arbeit. Es ist leicht, sich mit Kollegen zu einigen. Die Arbeit bringt Freude.',
          '7': 'Vollständiges gegenseitiges Verständnis mit Ihrem Partner. Die Beziehung ist erfüllt von Zärtlichkeit, Fürsorge und Harmonie.',
          '8': 'Emotionale und körperliche Intimität mit einem Partner bringt Freude. Eine Gelegenheit, finanzielle Unterstützung zu erhalten.',
          '9': 'Angenehme Nachrichten aus der Ferne. Ein guter Tag, um eine romantische Reise zu planen.',
          '10': 'Ihr Charme und Ihre Diplomatie helfen in Ihrer Karriere. Gute Beziehungen zu Vorgesetzten.',
          '11': 'Ein herzliches Treffen mit Freundinnen. Es ist leicht, emotionale Unterstützung und guten Rat zu bekommen.',
          '12': 'Ein Gefühl des inneren Friedens. Ein guter Tag für Ruhe, Meditation und das Genießen von Schönheit in der Einsamkeit.'
        }
      }
    ),
    AspectInterpretation(
      id: 'MARS_TRINE_JUPITER',
      title: {
        'ru': 'Гармония Марса и Юпитера',
        'en': 'Mars Trine Jupiter',
        'fr': 'Mars Trigone Jupiter',
        'de': 'Mars-Trigon-Jupiter'
      },
      descriptionGeneral: {
        'ru': 'День большой удачи в действиях. Энергия (Марс) и оптимизм (Юпитер) работают вместе. Все начинания успешны. Отличное время для спорта, бизнеса, путешествий и принятия смелых решений.',
        'en': 'A day of great luck in actions. Energy (Mars) and optimism (Jupiter) work together. All undertakings are successful. An excellent time for sports, business, travel, and making bold decisions.',
        'fr': 'Une journée de grande chance dans les actions. L\'énergie (Mars) et l\'optimisme (Jupiter) travaillent ensemble. Toutes les entreprises sont couronnées de succès. Un excellent moment pour le sport, les affaires, les voyages et la prise de décisions audacieuses.',
        'de': 'Ein Tag großen Glücks bei Handlungen. Energie (Mars) und Optimismus (Jupiter) arbeiten zusammen. Alle Unternehmungen sind erfolgreich. Eine ausgezeichnete Zeit für Sport, Geschäft, Reisen und mutige Entscheidungen.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Вы полны энтузиазма, энергии и веры в себя. Легко браться за самые смелые проекты и вести за собой людей.',
          '2': 'Ваши смелые и активные действия приносят большую финансовую удачу. Отличный день для начала бизнес-проекта.',
          '3': 'Вы говорите убедительно и вдохновляюще. Успех в переговорах, учебе, сдаче экзаменов. Удачная поездка.',
          '4': 'Энергии хватает на самые масштабные домашние проекты (начало строительства, крупный ремонт).',
          '5': 'Большая удача в любви. Ваша смелость и щедрость покоряют сердца. Успех в спортивных соревнованиях.',
          '6': 'Вы легко справляетесь с огромным объемом работы. Ваш энтузиазм заражает коллег. Успешное начало нового проекта.',
          '7': 'Совместные действия с партнером приносят большой успех. Вы отлично дополняете друг друга. Успех в суде.',
          '8': 'Большая удача в вопросах крупных финансов, инвестиций, бизнеса. Ваша смелость вознаграждается.',
          '9': 'Идеальный день для начала дальнего путешествия или поступления в вуз. Ваши идеи находят широкую поддержку.',
          '10': 'Ваши решительные действия ведут к большому успеху и признанию в карьере. Возможно повышение или начало своего дела.',
          '11': 'Ваши друзья поддерживают ваши самые смелые начинания. Успех в коллективных проектах.',
          '12': 'Ваша интуиция и вера в себя помогают преодолеть любые препятствия. Удача приходит из неожиданных источников.'
        },
        'en': {
          '1': 'You are full of enthusiasm, energy, and self-belief. It\'s easy to take on the boldest projects and lead people.',
          '2': 'Your bold and active actions bring great financial luck. An excellent day to start a business project.',
          '3': 'You speak convincingly and inspiringly. Success in negotiations, studies, exams. A successful trip.',
          '4': 'Enough energy for the most large-scale home projects (starting construction, major renovations).',
          '5': 'Great luck in love. Your courage and generosity win hearts. Success in sports competitions.',
          '6': 'You easily handle a huge amount of work. Your enthusiasm is contagious to colleagues. A successful start to a new project.',
          '7': 'Joint actions with a partner bring great success. You complement each other perfectly. Success in court.',
          '8': 'Great luck in matters of large finances, investments, business. Your courage is rewarded.',
          '9': 'An ideal day to start a long journey or enter a university. Your ideas find wide support.',
          '10': 'Your decisive actions lead to great success and recognition in your career. A promotion or starting your own business is possible.',
          '11': 'Your friends support your boldest undertakings. Success in collective projects.',
          '12': 'Your intuition and self-belief help you overcome any obstacles. Luck comes from unexpected sources.'
        },
        'fr': {
          '1': 'Vous êtes plein d\'enthousiasme, d\'énergie et de confiance en vous. Il est facile de s\'attaquer aux projets les plus audacieux et de diriger les gens.',
          '2': 'Vos actions audacieuses et actives apportent une grande chance financière. Une excellente journée pour démarrer un projet d\'entreprise.',
          '3': 'Vous parlez de manière convaincante et inspirante. Succès dans les négociations, les études, les examens. Un voyage réussi.',
          '4': 'Assez d\'énergie pour les projets domestiques les plus ambitieux (début de construction, rénovations majeures).',
          '5': 'Grande chance en amour. Votre courage et votre générosité conquièrent les cœurs. Succès dans les compétitions sportives.',
          '6': 'Vous gérez facilement une énorme quantité de travail. Votre enthousiasme est contagieux pour les collègues. Un démarrage réussi d\'un nouveau projet.',
          '7': 'Les actions conjointes avec un partenaire apportent un grand succès. Vous vous complétez parfaitement. Succès au tribunal.',
          '8': 'Grande chance en matière de grandes finances, d\'investissements, d\'affaires. Votre courage est récompensé.',
          '9': 'Une journée idéale pour commencer un long voyage ou entrer à l\'université. Vos idées trouvent un large soutien.',
          '10': 'Vos actions décisives mènent à un grand succès et à la reconnaissance dans votre carrière. Une promotion ou le démarrage de votre propre entreprise est possible.',
          '11': 'Vos amis soutiennent vos entreprises les plus audacieuses. Succès dans les projets collectifs.',
          '12': 'Votre intuition et votre confiance en vous vous aident à surmonter tous les obstacles. La chance vient de sources inattendues.'
        },
        'de': {
          '1': 'Sie sind voller Begeisterung, Energie und Selbstvertrauen. Es ist leicht, die kühnsten Projekte in Angriff zu nehmen und Menschen zu führen.',
          '2': 'Ihre kühnen und aktiven Handlungen bringen großes finanzielles Glück. Ein ausgezeichneter Tag, um ein Geschäftsprojekt zu starten.',
          '3': 'Sie sprechen überzeugend und inspirierend. Erfolg bei Verhandlungen, Studium, Prüfungen. Eine erfolgreiche Reise.',
          '4': 'Genug Energie für die größten Heimprojekte (Baubeginn, größere Renovierungen).',
          '5': 'Großes Glück in der Liebe. Ihr Mut und Ihre Großzügigkeit erobern Herzen. Erfolg bei Sportwettkämpfen.',
          '6': 'Sie bewältigen mühelos eine riesige Menge an Arbeit. Ihre Begeisterung ist ansteckend für Kollegen. Ein erfolgreicher Start eines neuen Projekts.',
          '7': 'Gemeinsame Aktionen mit einem Partner bringen großen Erfolg. Sie ergänzen sich perfekt. Erfolg vor Gericht.',
          '8': 'Großes Glück in Fragen großer Finanzen, Investitionen, Geschäfte. Ihr Mut wird belohnt.',
          '9': 'Ein idealer Tag, um eine lange Reise zu beginnen oder eine Universität zu besuchen. Ihre Ideen finden breite Unterstützung.',
          '10': 'Ihre entscheidenden Handlungen führen zu großem Erfolg und Anerkennung in Ihrer Karriere. Eine Beförderung oder die Gründung eines eigenen Unternehmens ist möglich.',
          '11': 'Ihre Freunde unterstützen Ihre kühnsten Unternehmungen. Erfolg bei kollektiven Projekten.',
          '12': 'Ihre Intuition und Ihr Selbstvertrauen helfen Ihnen, alle Hindernisse zu überwinden. Glück kommt aus unerwarteten Quellen.'
        }
      }
    ),
            // === НОВЫЙ БЛОК 12 ===
    AspectInterpretation(
      id: 'SUN_TRINE_MOON',
      title: {
        'ru': 'Гармония Солнца и Луны',
        'en': 'Sun Trine Moon',
        'fr': 'Soleil Trigone Lune',
        'de': 'Sonne-Trigon-Mond'
      },
      descriptionGeneral: {
        'ru': 'День внутренней гармонии и целостности. Ваши желания (Солнце) и потребности (Луна) находятся в полном согласии. Легко принимать решения, быть собой и получать поддержку от окружающих.',
        'en': 'A day of inner harmony and integrity. Your wants (Sun) and needs (Moon) are in full agreement. It\'s easy to make decisions, be yourself, and receive support from others.',
        'fr': 'Une journée d\'harmonie intérieure et d\'intégrité. Vos désirs (Soleil) et vos besoins (Lune) sont en parfait accord. Il est facile de prendre des décisions, d\'être soi-même et de recevoir le soutien des autres.',
        'de': 'Ein Tag der inneren Harmonie und Integrität. Ihre Wünsche (Sonne) und Bedürfnisse (Mond) sind in völliger Übereinstimmung. Es ist leicht, Entscheidungen zu treffen, man selbst zu sein und Unterstützung von anderen zu erhalten.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Вы чувствуете себя уверенно и целостно. Ваши действия и эмоции полностью совпадают. Отличный день, чтобы проявить себя.',
          '2': 'Финансовые дела идут гладко. Вы тратите деньги на то, что вам действительно нужно и что приносит радость.',
          '3': 'Искреннее и легкое общение. Вы легко находите общий язык с людьми, потому что ваши слова отражают ваши истинные чувства.',
          '4': 'Гармония в семье и доме. Отличные отношения с родителями. Ощущение эмоциональной безопасности.',
          '5': 'Легкость и естественность в любви и творчестве. Вы наслаждаетесь жизнью без внутреннего конфликта.',
          '6': 'Работа доставляет удовольствие. Вы легко находите баланс между обязанностями и заботой о своем самочувствии.',
          '7': 'Полное взаимопонимание с партнером. Отношения строятся на искренности и взаимной поддержке.',
          '8': 'Глубокое эмоциональное доверие с партнером. Легко обсуждать даже самые сложные и интимные темы.',
          '9': 'Ваши планы на будущее и внутренние устремления находятся в гармонии. Легко дается учеба и планирование поездок.',
          '10': 'Ваши карьерные цели не противоречат вашим внутренним потребностям. Успех приходит естественно, без напряжения.',
          '11': 'Гармоничные отношения с друзьями. Вы чувствуете себя частью коллектива, сохраняя свою индивидуальность.',
          '12': 'Внутренний покой и принятие себя. Отличный день для медитации и отдыха, который восстанавливает силы.'
        },
        'en': {
          '1': 'You feel confident and whole. Your actions and emotions are perfectly aligned. An excellent day to express yourself.',
          '2': 'Financial matters go smoothly. You spend money on what you truly need and what brings you joy.',
          '3': 'Sincere and easy communication. You easily find common ground with people because your words reflect your true feelings.',
          '4': 'Harmony in the family and home. Excellent relationships with parents. A sense of emotional security.',
          '5': 'Ease and naturalness in love and creativity. You enjoy life without internal conflict.',
          '6': 'Work is a pleasure. You easily find a balance between duties and taking care of your well-being.',
          '7': 'Complete mutual understanding with your partner. The relationship is built on sincerity and mutual support.',
          '8': 'Deep emotional trust with your partner. It\'s easy to discuss even the most complex and intimate topics.',
          '9': 'Your future plans and inner aspirations are in harmony. Studying and planning trips come easily.',
          '10': 'Your career goals do not contradict your inner needs. Success comes naturally, without strain.',
          '11': 'Harmonious relationships with friends. You feel part of the group while maintaining your individuality.',
          '12': 'Inner peace and self-acceptance. An excellent day for meditation and rest that restores your energy.'
        },
        'fr': {
          '1': 'Vous vous sentez confiant et entier. Vos actions et vos émotions sont parfaitement alignées. Une excellente journée pour vous exprimer.',
          '2': 'Les affaires financières se déroulent sans accroc. Vous dépensez de l\'argent pour ce dont vous avez vraiment besoin et ce qui vous apporte de la joie.',
          '3': 'Communication sincère et facile. Vous trouvez facilement un terrain d\'entente avec les gens car vos paroles reflètent vos vrais sentiments.',
          '4': 'Harmonie dans la famille et à la maison. Excellentes relations avec les parents. Un sentiment de sécurité émotionnelle.',
          '5': 'Aisance et naturel en amour et en créativité. Vous profitez de la vie sans conflit intérieur.',
          '6': 'Le travail est un plaisir. Vous trouvez facilement un équilibre entre les devoirs et le soin de votre bien-être.',
          '7': 'Compréhension mutuelle totale avec votre partenaire. La relation est bâtie sur la sincérité et le soutien mutuel.',
          '8': 'Confiance émotionnelle profonde avec votre partenaire. Il est facile de discuter des sujets les plus complexes et intimes.',
          '9': 'Vos projets d\'avenir et vos aspirations intérieures sont en harmonie. Les études et la planification de voyages sont faciles.',
          '10': 'Vos objectifs de carrière ne contredisent pas vos besoins intérieurs. Le succès vient naturellement, sans effort.',
          '11': 'Relations harmonieuses avec les amis. Vous vous sentez membre du groupe tout en conservant votre individualité.',
          '12': 'Paix intérieure et acceptation de soi. Une excellente journée pour la méditation et le repos qui restaure votre énergie.'
        },
        'de': {
          '1': 'Sie fühlen sich selbstbewusst und ganz. Ihre Handlungen und Emotionen sind perfekt aufeinander abgestimmt. Ein ausgezeichneter Tag, um sich auszudrücken.',
          '2': 'Finanzielle Angelegenheiten verlaufen reibungslos. Sie geben Geld für das aus, was Sie wirklich brauchen und was Ihnen Freude bereitet.',
          '3': 'Aufrichtige und leichte Kommunikation. Sie finden leicht eine gemeinsame Basis mit Menschen, weil Ihre Worte Ihre wahren Gefühle widerspiegeln.',
          '4': 'Harmonie in der Familie und zu Hause. Ausgezeichnete Beziehungen zu den Eltern. Ein Gefühl emotionaler Sicherheit.',
          '5': 'Leichtigkeit und Natürlichkeit in Liebe und Kreativität. Sie genießen das Leben ohne inneren Konflikt.',
          '6': 'Arbeit ist ein Vergnügen. Sie finden leicht ein Gleichgewicht zwischen Pflichten und der Sorge um Ihr Wohlbefinden.',
          '7': 'Vollständiges gegenseitiges Verständnis mit Ihrem Partner. Die Beziehung basiert auf Aufrichtigkeit und gegenseitiger Unterstützung.',
          '8': 'Tiefes emotionales Vertrauen zu Ihrem Partner. Es ist leicht, selbst die komplexesten und intimsten Themen zu besprechen.',
          '9': 'Ihre Zukunftspläne und inneren Bestrebungen sind in Harmonie. Studieren und Reiseplanung fallen leicht.',
          '10': 'Ihre Karriereziele stehen nicht im Widerspruch zu Ihren inneren Bedürfnissen. Erfolg kommt natürlich, ohne Anstrengung.',
          '11': 'Harmonische Beziehungen zu Freunden. Sie fühlen sich als Teil der Gruppe, während Sie Ihre Individualität bewahren.',
          '12': 'Innerer Frieden und Selbstakzeptanz. Ein ausgezeichneter Tag für Meditation und Ruhe, die Ihre Energie wiederherstellt.'
        }
      }
    ),
    AspectInterpretation(
      id: 'MERCURY_SQUARE_SATURN',
      title: {
        'ru': 'Конфликт Меркурия и Сатурна',
        'en': 'Mercury Square Saturn',
        'fr': 'Mercure Carré Saturne',
        'de': 'Merkur-Quadrat-Saturn'
      },
      descriptionGeneral: {
        'ru': 'День "тяжелых мыслей" и трудностей в общении. Мышление (Меркурий) сталкивается с ограничениями (Сатурн). Пессимизм, критика, задержки, плохие новости. Сложно договориться.',
        'en': 'A day of "heavy thoughts" and communication difficulties. Thinking (Mercury) clashes with limitations (Saturn). Pessimism, criticism, delays, bad news. Difficult to reach an agreement.',
        'fr': 'Une journée de "pensées lourdes" et de difficultés de communication. La pensée (Mercure) se heurte aux limitations (Saturne). Pessimisme, critiques, retards, mauvaises nouvelles. Difficile de parvenir à un accord.',
        'de': 'Ein Tag der "schweren Gedanken" und Kommunikationsschwierigkeiten. Das Denken (Merkur) kollidiert mit Einschränkungen (Saturn). Pessimismus, Kritik, Verzögerungen, schlechte Nachrichten. Schwierig, eine Einigung zu erzielen.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Вы склонны к самокритике и пессимизму. Трудно выразить свои мысли, вы чувствуете себя неуверенно.',
          '2': 'Трудности с финансами, задержки выплат. Не лучшее время для переговоров о деньгах.',
          '3': 'Блоки в общении. Разговор не клеится, ваши слова воспринимаются в штыки. Задержки в поездках.',
          '4': 'Трудный разговор с родителями или старшими родственниками. Ощущение давления и непонимания.',
          '5': 'Сложно говорить о чувствах. В отношениях возможны холодность и недопонимание.',
          '6': 'Критика со стороны начальства, трудности в выполнении работы. Ощущение, что ваши усилия не ценят.',
          '7': 'Формальное и холодное общение с партнером. Сложно найти компромисс, каждый стоит на своем.',
          '8': 'Тревожные мысли о долгах, налогах. Обсуждение серьезных тем вызывает напряжение.',
          '9': 'Трудности в учебе, сложно сконцентрироваться. Ваши идеи могут быть раскритикованы как непрактичные.',
          '10': 'Конфликт с начальством или властями. Ваши слова могут быть использованы против вас. Задержки в карьере.',
          '11': 'Недопонимание с друзьями. Вы можете получить критику или отказ в поддержке.',
          '12': 'Вы можете зациклиться на негативных мыслях. Пессимизм и страхи мешают мыслить ясно.'
        },
        'en': {
          '1': 'You are prone to self-criticism and pessimism. It\'s hard to express your thoughts; you feel insecure.',
          '2': 'Financial difficulties, payment delays. Not the best time for money negotiations.',
          '3': 'Communication blocks. Conversation doesn\'t flow, your words are met with hostility. Delays in travel.',
          '4': 'A difficult conversation with parents or older relatives. A feeling of pressure and misunderstanding.',
          '5': 'It\'s hard to talk about feelings. Coldness and misunderstanding are possible in relationships.',
          '6': 'Criticism from superiors, difficulties in performing work. A feeling that your efforts are not appreciated.',
          '7': 'Formal and cold communication with a partner. It\'s hard to find a compromise; everyone sticks to their guns.',
          '8': 'Anxious thoughts about debts, taxes. Discussing serious topics causes tension.',
          '9': 'Difficulties in studying, hard to concentrate. Your ideas might be criticized as impractical.',
          '10': 'Conflict with superiors or authorities. Your words could be used against you. Career delays.',
          '11': 'Misunderstanding with friends. You might receive criticism or a refusal of support.',
          '12': 'You might get stuck on negative thoughts. Pessimism and fears prevent clear thinking.'
        },
        'fr': {
          '1': 'Vous êtes enclin à l\'autocritique et au pessimisme. Difficile d\'exprimer vos pensées ; vous vous sentez peu sûr de vous.',
          '2': 'Difficultés financières, retards de paiement. Ce n\'est pas le meilleur moment pour des négociations financières.',
          '3': 'Blocages de communication. La conversation ne coule pas, vos paroles sont accueillies avec hostilité. Retards de voyage.',
          '4': 'Conversation difficile avec les parents ou les proches plus âgés. Un sentiment de pression et d\'incompréhension.',
          '5': 'Difficile de parler de sentiments. Froideur et incompréhension sont possibles dans les relations.',
          '6': 'Critiques des supérieurs, difficultés à effectuer le travail. Le sentiment que vos efforts ne sont pas appréciés.',
          '7': 'Communication formelle et froide avec un partenaire. Difficile de trouver un compromis ; chacun reste sur ses positions.',
          '8': 'Pensées anxieuses sur les dettes, les impôts. Discuter de sujets sérieux provoque des tensions.',
          '9': 'Difficultés à étudier, difficile de se concentrer. Vos idées pourraient être critiquées comme étant irréalisables.',
          '10': 'Conflit avec les supérieurs ou les autorités. Vos paroles pourraient être utilisées contre vous. Retards de carrière.',
          '11': 'Incompréhension avec des amis. Vous pourriez recevoir des critiques ou un refus de soutien.',
          '12': 'Vous pourriez rester bloqué sur des pensées négatives. Le pessimisme et les peurs empêchent de penser clairement.'
        },
        'de': {
          '1': 'Sie neigen zu Selbstkritik und Pessimismus. Es ist schwer, Ihre Gedanken auszudrücken; Sie fühlen sich unsicher.',
          '2': 'Finanzielle Schwierigkeiten, Zahlungsverzögerungen. Keine gute Zeit für Geldverhandlungen.',
          '3': 'Kommunikationsblockaden. Das Gespräch fließt nicht, Ihre Worte werden feindselig aufgenommen. Reiseverzögerungen.',
          '4': 'Ein schwieriges Gespräch mit Eltern oder älteren Verwandten. Ein Gefühl von Druck und Unverständnis.',
          '5': 'Es ist schwer, über Gefühle zu sprechen. Kälte und Missverständnisse sind in Beziehungen möglich.',
          '6': 'Kritik von Vorgesetzten, Schwierigkeiten bei der Arbeit. Das Gefühl, dass Ihre Bemühungen nicht geschätzt werden.',
          '7': 'Formelle und kalte Kommunikation mit einem Partner. Es ist schwer, einen Kompromiss zu finden; jeder beharrt auf seinem Standpunkt.',
          '8': 'Ängstliche Gedanken über Schulden, Steuern. Die Diskussion ernster Themen verursacht Spannungen.',
          '9': 'Schwierigkeiten beim Lernen, Konzentrationsschwierigkeiten. Ihre Ideen könnten als unpraktisch kritisiert werden.',
          '10': 'Konflikt mit Vorgesetzten oder Behörden. Ihre Worte könnten gegen Sie verwendet werden. Karriereverzögerungen.',
          '11': 'Missverständnis mit Freunden. Sie könnten Kritik oder eine Ablehnung der Unterstützung erhalten.',
          '12': 'Sie könnten bei negativen Gedanken hängen bleiben. Pessimismus und Ängste verhindern klares Denken.'
        }
      }
    ),
    AspectInterpretation(
      id: 'VENUS_CONJUNCTION_NEPTUNE',
      title: {
        'ru': 'Соединение Венеры и Нептуна',
        'en': 'Venus Conjunct Neptune',
        'fr': 'Vénus Conjointe Neptune',
        'de': 'Venus-Konjunktion-Neptun'
      },
      descriptionGeneral: {
        'ru': 'День сказочной любви, идеализма и творческого вдохновения. Границы реальности стираются. Идеально для романтики, искусства, музыки, но есть риск самообмана и "розовых очков".',
        'en': 'A day of fairytale love, idealism, and creative inspiration. The boundaries of reality blur. Ideal for romance, art, music, but there is a risk of self-deception and "rose-colored glasses."',
        'fr': 'Une journée d\'amour de conte de fées, d\'idéalisme et d\'inspiration créative. Les frontières de la réalité s\'estompent. Idéal pour la romance, l\'art, la musique, mais il y a un risque d\'auto-illusion et de "lunettes roses".',
        'de': 'Ein Tag der märchenhaften Liebe, des Idealismus und der kreativen Inspiration. Die Grenzen der Realität verschwimmen. Ideal für Romantik, Kunst, Musik, aber es besteht die Gefahr der Selbsttäuschung und der "rosaroten Brille".'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Вы кажетесь загадочным, утонченным и очень привлекательным. Легко очаровать кого угодно, но и самому легко обмануться.',
          '2': 'Деньги могут прийти из самых неожиданных, почти мистических источников. Но есть и риск потратить их на иллюзию.',
          '3': 'Поэтичные и нежные слова. Легко говорить о высоком, но сложно обсуждать конкретику. Романтическая переписка.',
          '4': 'Вы стремитесь к идеальной гармонии в доме. Духовная связь с семьей очень сильна.',
          '5': 'Вы можете испытать "любовь с первого взгляда", которая кажется вам идеальной. Свидание будет похоже на сказку.',
          '6': 'Творческий подход к работе. Вы можете проявить сострадание к коллегам. Но есть риск витать в облаках.',
          '7': 'Вы полностью растворяетесь в партнере, идеализируя его. Глубокая духовная связь, но важно не терять себя.',
          '8': 'Глубочайшее эмоциональное и духовное слияние с партнером. Но будьте осторожны в финансовых вопросах, риск обмана.',
          '9': 'Романтическая мечта может стать реальностью, особенно в путешествии. Сильная тяга к духовности и искусству.',
          '10': 'Ваш творческий талант и обаяние могут принести вам популярность. Но карьерные цели могут быть слишком расплывчаты.',
          '11': 'Вы можете встретить "родственную душу" в кругу друзей. Идеалистические мечты о будущем.',
          '12': 'Тайная любовь может быть очень возвышенной. Сильная интуиция, вещие сны. Глубокое погружение в мир искусства.'
        },
        'en': {
          '1': 'You seem mysterious, refined, and very attractive. It\'s easy to charm anyone, but also easy to be deceived yourself.',
          '2': 'Money may come from the most unexpected, almost mystical sources. But there is also a risk of spending it on an illusion.',
          '3': 'Poetic and gentle words. It\'s easy to talk about lofty things, but difficult to discuss specifics. Romantic correspondence.',
          '4': 'You strive for ideal harmony at home. The spiritual connection with your family is very strong.',
          '5': 'You might experience "love at first sight" that seems perfect to you. The date will be like a fairytale.',
          '6': 'A creative approach to work. You can show compassion to colleagues. But there is a risk of having your head in the clouds.',
          '7': 'You completely dissolve into your partner, idealizing them. A deep spiritual connection, but it\'s important not to lose yourself.',
          '8': 'The deepest emotional and spiritual merging with a partner. But be careful in financial matters, risk of deception.',
          '9': 'A romantic dream can become a reality, especially while traveling. A strong attraction to spirituality and art.',
          '10': 'Your creative talent and charm can bring you popularity. But career goals might be too vague.',
          '11': 'You might meet a "soulmate" in your circle of friends. Idealistic dreams about the future.',
          '12': 'A secret love can be very sublime. Strong intuition, prophetic dreams. Deep immersion in the world of art.'
        },
        'fr': {
          '1': 'Vous semblez mystérieux, raffiné et très attrayant. Il est facile de charmer n\'importe qui, mais aussi facile de se tromper soi-même.',
          '2': 'L\'argent peut provenir des sources les plus inattendues, presque mystiques. Mais il y a aussi un risque de le dépenser pour une illusion.',
          '3': 'Paroles poétiques et douces. Facile de parler de choses élevées, mais difficile de discuter de détails. Correspondance romantique.',
          '4': 'Vous aspirez à une harmonie idéale à la maison. Le lien spirituel avec votre famille est très fort.',
          '5': 'Vous pourriez vivre un "coup de foudre" qui vous semble parfait. Le rendez-vous sera comme un conte de fées.',
          '6': 'Une approche créative du travail. Vous pouvez faire preuve de compassion envers vos collègues. Mais il y a un risque d\'avoir la tête dans les nuages.',
          '7': 'Vous vous dissolvez complètement dans votre partenaire, en l\'idéalisant. Un lien spirituel profond, mais il est important de ne pas se perdre.',
          '8': 'La fusion émotionnelle et spirituelle la plus profonde avec un partenaire. Mais soyez prudent en matière financière, risque de tromperie.',
          '9': 'Un rêve romantique peut devenir réalité, surtout en voyage. Une forte attirance pour la spiritualité et l\'art.',
          '10': 'Votre talent créatif et votre charme peuvent vous apporter la popularité. Mais les objectifs de carrière peuvent être trop vagues.',
          '11': 'Vous pourriez rencontrer une "âme sœur" dans votre cercle d\'amis. Rêves idéalistes sur l\'avenir.',
          '12': 'Un amour secret peut être très sublime. Forte intuition, rêves prophétiques. Immersion profonde dans le monde de l\'art.'
        },
        'de': {
          '1': 'Sie wirken geheimnisvoll, raffiniert und sehr attraktiv. Es ist leicht, jeden zu bezaubern, aber auch leicht, sich selbst zu täuschen.',
          '2': 'Geld kann aus den unerwartetsten, fast mystischen Quellen kommen. Aber es besteht auch die Gefahr, es für eine Illusion auszugeben.',
          '3': 'Poetische und sanfte Worte. Es ist leicht, über hohe Dinge zu sprechen, aber schwierig, Einzelheiten zu besprechen. Romantische Korrespondenz.',
          '4': 'Sie streben nach idealer Harmonie zu Hause. Die spirituelle Verbindung zu Ihrer Familie ist sehr stark.',
          '5': 'Sie könnten "Liebe auf den ersten Blick" erleben, die Ihnen perfekt erscheint. Das Date wird wie ein Märchen sein.',
          '6': 'Ein kreativer Ansatz zur Arbeit. Sie können Mitgefühl für Kollegen zeigen. Aber es besteht die Gefahr, mit dem Kopf in den Wolken zu sein.',
          '7': 'Sie lösen sich vollständig in Ihrem Partner auf und idealisieren ihn. Eine tiefe spirituelle Verbindung, aber es ist wichtig, sich nicht selbst zu verlieren.',
          '8': 'Die tiefste emotionale und spirituelle Verschmelzung mit einem Partner. Aber seien Sie vorsichtig in finanziellen Angelegenheiten, Betrugsrisiko.',
          '9': 'Ein romantischer Traum kann Wirklichkeit werden, besonders auf Reisen. Eine starke Anziehungskraft auf Spiritualität und Kunst.',
          '10': 'Ihr kreatives Talent und Ihr Charme können Ihnen Popularität bringen. Aber Karriereziele könnten zu vage sein.',
          '11': 'Sie könnten einen "Seelenverwandten" in Ihrem Freundeskreis treffen. Idealistische Träume von der Zukunft.',
          '12': 'Eine geheime Liebe kann sehr erhaben sein. Starke Intuition, prophetische Träume. Tiefes Eintauchen in die Welt der Kunst.'
        }
      }
    ),
    AspectInterpretation(
      id: 'SUN_OPPOSITION_MARS',
      title: {
        'ru': 'Противостояние Солнца и Марса',
        'en': 'Sun Opposition Mars',
        'fr': 'Soleil Opposition Mars',
        'de': 'Sonne-Opposition-Mars'
      },
      descriptionGeneral: {
        'ru': 'День открытых конфликтов и борьбы эго. Ваша воля (Солнце) сталкивается с прямой агрессией (Марс) со стороны других. Высокий риск ссор, конкуренции и импульсивных поступков. Нужен компромисс.',
        'en': 'A day of open conflicts and ego battles. Your will (Sun) clashes with direct aggression (Mars) from others. High risk of quarrels, competition, and impulsive actions. Compromise is needed.',
        'fr': 'Une journée de conflits ouverts et de batailles d\'ego. Votre volonté (Soleil) se heurte à l\'agression directe (Mars) des autres. Risque élevé de querelles, de compétition et d\'actions impulsives. Un compromis est nécessaire.',
        'de': 'Ein Tag offener Konflikte und Ego-Kämpfe. Ihr Wille (Sonne) kollidiert mit direkter Aggression (Mars) von anderen. Hohes Risiko für Streit, Wettbewerb und impulsive Handlungen. Ein Kompromiss ist erforderlich.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Вы сталкиваетесь с прямым противодействием вашим инициативам. Кто-то бросает вам вызов.',
          '2': 'Конфликт из-за денег или ценностей. Кто-то пытается оспорить то, что принадлежит вам.',
          '3': 'Жесткий спор, в котором оппонент не намерен уступать. Будьте осторожны, разговор может перейти в ссору.',
          '4': 'Открытый конфликт в семье, борьба за лидерство. Ваши личные цели идут вразрез с целями домочадцев.',
          '5': 'Конфликт с любимым человеком, который перерастает в соревнование "кто кого".',
          '6': 'Противостояние с коллегами на работе. Конкуренция очень высока и может быть нечестной.',
          '7': 'Ваш партнер или оппонент бросает вам прямой вызов. Необходимо искать компромисс, иначе возможен разрыв.',
          '8': 'Конфликт из-за общих ресурсов или долгов. Ваши действия могут привести к кризису.',
          '9': 'Ваши убеждения сталкиваются с агрессивным неприятием. Идеологический спор.',
          '10': 'Прямой конфликт с начальником или конкурентом. Ваши амбиции сталкиваются с чужими.',
          '11': 'Ссора с другом, в которой каждый пытается доказать свою правоту. Конкуренция в группе.',
          '12': 'Вы боретесь с тайным врагом или собственными саморазрушительными импульсами.'
        },
        'en': {
          '1': 'You face direct opposition to your initiatives. Someone is challenging you.',
          '2': 'A conflict over money or values. Someone is trying to challenge what belongs to you.',
          '3': 'A harsh argument where the opponent has no intention of backing down. Be careful, the conversation could turn into a quarrel.',
          '4': 'An open conflict in the family, a struggle for leadership. Your personal goals conflict with those of your household.',
          '5': 'A conflict with a loved one that turns into a "who will win" competition.',
          '6': 'Confrontation with colleagues at work. Competition is very high and may be unfair.',
          '7': 'Your partner or opponent issues a direct challenge to you. A compromise must be sought, otherwise a breakup is possible.',
          '8': 'A conflict over shared resources or debts. Your actions could lead to a crisis.',
          '9': 'Your beliefs are met with aggressive rejection. An ideological dispute.',
          '10': 'A direct conflict with a boss or competitor. Your ambitions clash with someone else\'s.',
          '11': 'A quarrel with a friend where everyone tries to prove they are right. Competition within the group.',
          '12': 'You are fighting a secret enemy or your own self-destructive impulses.'
        },
        'fr': {
          '1': 'Vous faites face à une opposition directe à vos initiatives. Quelqu\'un vous met au défi.',
          '2': 'Un conflit d\'argent ou de valeurs. Quelqu\'un essaie de contester ce qui vous appartient.',
          '3': 'Une dispute âpre où l\'adversaire n\'a aucune intention de céder. Attention, la conversation pourrait tourner à la querelle.',
          '4': 'Un conflit ouvert dans la famille, une lutte pour le leadership. Vos objectifs personnels entrent en conflit avec ceux de votre foyer.',
          '5': 'Un conflit avec un être cher qui se transforme en compétition pour savoir "qui va gagner".',
          '6': 'Confrontation avec des collègues au travail. La compétition est très élevée et peut être déloyale.',
          '7': 'Votre partenaire ou adversaire vous lance un défi direct. Un compromis doit être recherché, sinon une rupture est possible.',
          '8': 'Un conflit sur les ressources partagées ou les dettes. Vos actions pourraient mener à une crise.',
          '9': 'Vos croyances se heurtent à un rejet agressif. Un différend idéologique.',
          '10': 'Un conflit direct avec un patron ou un concurrent. Vos ambitions se heurtent à celles de quelqu\'un d\'autre.',
          '11': 'Une querelle avec un ami où chacun essaie de prouver qu\'il a raison. Compétition au sein du groupe.',
          '12': 'Vous combattez un ennemi secret ou vos propres impulsions autodestructrices.'
        },
        'de': {
          '1': 'Sie stoßen auf direkten Widerstand gegen Ihre Initiativen. Jemand fordert Sie heraus.',
          '2': 'Ein Konflikt um Geld oder Werte. Jemand versucht, das in Frage zu stellen, was Ihnen gehört.',
          '3': 'Ein harter Streit, bei dem der Gegner nicht die Absicht hat nachzugeben. Seien Sie vorsichtig, das Gespräch könnte in einen Streit ausarten.',
          '4': 'Ein offener Konflikt in der Familie, ein Kampf um die Führung. Ihre persönlichen Ziele stehen im Konflikt mit denen Ihres Haushalts.',
          '5': 'Ein Konflikt mit einem geliebten Menschen, der sich zu einem Wettbewerb "wer gewinnt" entwickelt.',
          '6': 'Konfrontation mit Kollegen bei der Arbeit. Der Wettbewerb ist sehr hoch und kann unfair sein.',
          '7': 'Ihr Partner oder Gegner fordert Sie direkt heraus. Ein Kompromiss muss gesucht werden, sonst ist eine Trennung möglich.',
          '8': 'Ein Konflikt um gemeinsame Ressourcen oder Schulden. Ihre Handlungen könnten zu einer Krise führen.',
          '9': 'Ihre Überzeugungen stoßen auf aggressive Ablehnung. Ein ideologischer Streit.',
          '10': 'Ein direkter Konflikt mit einem Chef oder Konkurrenten. Ihre Ambitionen kollidieren mit denen eines anderen.',
          '11': 'Ein Streit mit einem Freund, bei dem jeder versucht, Recht zu behalten. Wettbewerb innerhalb der Gruppe.',
          '12': 'Sie kämpfen gegen einen geheimen Feind oder Ihre eigenen selbstzerstörerischen Impulse.'
        }
      }
    ),
            // === НОВЫЙ БЛОК 13 ===
    AspectInterpretation(
      id: 'MOON_SQUARE_SATURN',
      title: {
        'ru': 'Конфликт Луны и Сатурна',
        'en': 'Moon Square Saturn',
        'fr': 'Lune Carré Saturne',
        'de': 'Mond-Quadrat-Saturn'
      },
      descriptionGeneral: {
        'ru': 'День эмоционального холода и пессимизма. Ваши потребности (Луна) сталкиваются с чувством долга и ограничениями (Сатурн). Возможно ощущение одиночества, грусти, нехватки поддержки.',
        'en': 'A day of emotional coldness and pessimism. Your needs (Moon) clash with a sense of duty and limitations (Saturn). A feeling of loneliness, sadness, and lack of support is possible.',
        'fr': 'Une journée de froideur émotionnelle et de pessimisme. Vos besoins (Lune) se heurtent à un sens du devoir et à des limitations (Saturne). Un sentiment de solitude, de tristesse et de manque de soutien est possible.',
        'de': 'Ein Tag emotionaler Kälte und Pessimismus. Ihre Bedürfnisse (Mond) kollidieren mit Pflichtgefühl und Einschränkungen (Saturn). Ein Gefühl von Einsamkeit, Traurigkeit und mangelnder Unterstützung ist möglich.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Вы чувствуете себя одиноким и неуверенным. Эмоциональная скованность мешает быть собой.',
          '2': 'Финансовые трудности давят на эмоциональное состояние. Страх нехватки ресурсов.',
          '3': 'Сложно выразить свои чувства, общение кажется холодным и формальным. Плохие новости.',
          '4': 'Тяжелая, давящая атмосфера в доме. Ощущение долга перед семьей, но нехватка тепла.',
          '5': 'Отсутствие радости и легкости в любви. Романтика кажется обязанностью. Охлаждение чувств.',
          '6': 'Работа воспринимается как тяжелая рутина. Эмоциональное выгорание, чувство усталости.',
          '7': 'Эмоциональная дистанция с партнером. Он может казаться холодным или критикующим.',
          '8': 'Беспокойство о долгах или совместных финансах. Страх близости, эмоциональная закрытость.',
          '9': 'Пессимистичный взгляд на будущее. Планы кажутся нереализуемыми, не хватает веры в себя.',
          '10': 'Давление профессиональных обязанностей. Критика со стороны начальства или ощущение, что вас не ценят.',
          '11': 'Ощущение одиночества в кругу друзей. Кажется, что вас не понимают и не поддерживают.',
          '12': 'Всплывают старые обиды и страхи. Склонность к самоизоляции и унынию.'
        },
        'en': {
          '1': 'You feel lonely and insecure. Emotional stiffness prevents you from being yourself.',
          '2': 'Financial difficulties weigh on your emotional state. Fear of resource scarcity.',
          '3': 'It\'s hard to express your feelings; communication seems cold and formal. Bad news.',
          '4': 'A heavy, oppressive atmosphere at home. A sense of duty to the family, but a lack of warmth.',
          '5': 'A lack of joy and lightness in love. Romance feels like an obligation. A cooling of feelings.',
          '6': 'Work is perceived as a heavy routine. Emotional burnout, a feeling of fatigue.',
          '7': 'Emotional distance with a partner. They may seem cold or critical.',
          '8': 'Anxiety about debts or joint finances. Fear of intimacy, emotional closure.',
          '9': 'A pessimistic view of the future. Plans seem unattainable, lacking self-belief.',
          '10': 'Pressure from professional duties. Criticism from superiors or a feeling of being unappreciated.',
          '11': 'A feeling of loneliness in a circle of friends. It seems you are not understood or supported.',
          '12': 'Old resentments and fears surface. A tendency towards self-isolation and despondency.'
        },
        'fr': {
          '1': 'Vous vous sentez seul et peu sûr de vous. La raideur émotionnelle vous empêche d\'être vous-même.',
          '2': 'Les difficultés financières pèsent sur votre état émotionnel. Peur du manque de ressources.',
          '3': 'Difficile d\'exprimer ses sentiments ; la communication semble froide et formelle. Mauvaises nouvelles.',
          '4': 'Une atmosphère lourde et oppressante à la maison. Un sentiment de devoir envers la famille, mais un manque de chaleur.',
          '5': 'Un manque de joie et de légèreté en amour. La romance ressemble à une obligation. Un refroidissement des sentiments.',
          '6': 'Le travail est perçu comme une lourde routine. Épuisement émotionnel, sensation de fatigue.',
          '7': 'Distance émotionnelle avec un partenaire. Il peut paraître froid ou critique.',
          '8': 'Anxiété concernant les dettes ou les finances communes. Peur de l\'intimité, fermeture émotionnelle.',
          '9': 'Une vision pessimiste de l\'avenir. Les projets semblent irréalisables, manque de confiance en soi.',
          '10': 'Pression des obligations professionnelles. Critiques des supérieurs ou sentiment de ne pas être apprécié.',
          '11': 'Un sentiment de solitude dans un cercle d\'amis. Il semble que vous ne soyez ni compris ni soutenu.',
          '12': 'De vieux ressentiments et de vieilles peurs refont surface. Tendance à l\'auto-isolement et au découragement.'
        },
        'de': {
          '1': 'Sie fühlen sich einsam und unsicher. Emotionale Steifheit hindert Sie daran, Sie selbst zu sein.',
          '2': 'Finanzielle Schwierigkeiten belasten Ihren emotionalen Zustand. Angst vor Ressourcenknappheit.',
          '3': 'Es ist schwer, seine Gefühle auszudrücken; die Kommunikation wirkt kalt und formell. Schlechte Nachrichten.',
          '4': 'Eine schwere, drückende Atmosphäre zu Hause. Ein Gefühl der Pflicht gegenüber der Familie, aber ein Mangel an Wärme.',
          '5': 'Ein Mangel an Freude und Leichtigkeit in der Liebe. Romantik fühlt sich wie eine Verpflichtung an. Eine Abkühlung der Gefühle.',
          '6': 'Die Arbeit wird als schwere Routine empfunden. Emotionales Burnout, ein Gefühl der Müdigkeit.',
          '7': 'Emotionale Distanz zu einem Partner. Er mag kalt oder kritisch erscheinen.',
          '8': 'Angst vor Schulden oder gemeinsamen Finanzen. Angst vor Intimität, emotionale Verschlossenheit.',
          '9': 'Eine pessimistische Sicht auf die Zukunft. Pläne scheinen unerreichbar, es mangelt an Selbstvertrauen.',
          '10': 'Druck durch berufliche Pflichten. Kritik von Vorgesetzten oder das Gefühl, nicht geschätzt zu werden.',
          '11': 'Ein Gefühl der Einsamkeit im Freundeskreis. Es scheint, als würden Sie nicht verstanden oder unterstützt.',
          '12': 'Alte Ressentiments und Ängste tauchen auf. Eine Tendenz zur Selbstisolation und Mutlosigkeit.'
        }
      }
    ),
    AspectInterpretation(
      id: 'VENUS_TRINE_SATURN',
      title: {
        'ru': 'Гармония Венеры и Сатурна',
        'en': 'Venus Trine Saturn',
        'fr': 'Vénus Trigone Saturne',
        'de': 'Venus-Trigon-Saturn'
      },
      descriptionGeneral: {
        'ru': 'День стабильности, верности и серьезного подхода к отношениям и финансам. Чувства (Венера) обретают форму и надежность (Сатурн). Отлично для долгосрочных планов, укрепления связей.',
        'en': 'A day of stability, loyalty, and a serious approach to relationships and finances. Feelings (Venus) take shape and reliability (Saturn). Excellent for long-term plans, strengthening bonds.',
        'fr': 'Une journée de stabilité, de loyauté et d\'approche sérieuse des relations et des finances. Les sentiments (Vénus) prennent forme et fiabilité (Saturne). Excellent pour les plans à long terme, le renforcement des liens.',
        'de': 'Ein Tag der Stabilität, Loyalität und eines ernsthaften Umgangs mit Beziehungen und Finanzen. Gefühle (Venus) erhalten Form und Zuverlässigkeit (Saturn). Ausgezeichnet für langfristige Pläne, die Stärkung von Bindungen.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Вы производите впечатление надежного и серьезного человека. Легко выстроить доверительные отношения.',
          '2': 'Финансовая стабильность. Отличный день для обдуманных покупок, инвестиций и планирования бюджета.',
          '3': 'Спокойный и конструктивный разговор о чувствах, который укрепляет отношения.',
          '4': 'Укрепление фундамента семьи. Забота о старших приносит удовлетворение. Практические улучшения в доме.',
          '5': 'Отношения переходят на новый, более серьезный уровень. Верность и преданность. Любовь, проверенная временем.',
          '6': 'Стабильные и уважительные отношения с коллегами. Работа выполняется качественно и без спешки.',
          '7': 'Идеальный день для помолвки, брака или принятия других серьезных совместных обязательств.',
          '8': 'Надежность в совместных финансах. Глубокое доверие и стабильность в интимных отношениях.',
          '9': 'Отношения с человеком старше по возрасту или статусу складываются гармонично. Реалистичные планы на будущее.',
          '10': 'Ваша надежность и профессионализм способствуют укреплению репутации. Возможен служебный роман с серьезными перспективами.',
          '11': 'Старые, проверенные друзья оказывают неоценимую поддержку. Долгосрочные планы с единомышленниками.',
          '12': 'Внутреннее спокойствие и принятие прошлого опыта в любви, что дает мудрость и стабильность.'
        },
        'en': {
          '1': 'You give the impression of a reliable and serious person. It\'s easy to build trusting relationships.',
          '2': 'Financial stability. An excellent day for thoughtful purchases, investments, and budget planning.',
          '3': 'A calm and constructive conversation about feelings that strengthens the relationship.',
          '4': 'Strengthening the family foundation. Caring for elders brings satisfaction. Practical improvements at home.',
          '5': 'The relationship moves to a new, more serious level. Fidelity and devotion. Love tested by time.',
          '6': 'Stable and respectful relationships with colleagues. Work is done well and without rushing.',
          '7': 'An ideal day for an engagement, marriage, or making other serious joint commitments.',
          '8': 'Reliability in joint finances. Deep trust and stability in intimate relationships.',
          '9': 'A relationship with an older or higher-status person develops harmoniously. Realistic plans for the future.',
          '10': 'Your reliability and professionalism help strengthen your reputation. An office romance with serious prospects is possible.',
          '11': 'Old, trusted friends provide invaluable support. Long-term plans with like-minded people.',
          '12': 'Inner peace and acceptance of past love experiences, which brings wisdom and stability.'
        },
        'fr': {
          '1': 'Vous donnez l\'impression d\'une personne fiable et sérieuse. Il est facile de nouer des relations de confiance.',
          '2': 'Stabilité financière. Une excellente journée pour des achats réfléchis, des investissements et la planification budgétaire.',
          '3': 'Une conversation calme et constructive sur les sentiments qui renforce la relation.',
          '4': 'Renforcement des fondations familiales. Prendre soin des aînés apporte de la satisfaction. Améliorations pratiques à la maison.',
          '5': 'La relation passe à un niveau nouveau et plus sérieux. Fidélité et dévouement. L\'amour à l\'épreuve du temps.',
          '6': 'Relations stables et respectueuses avec les collègues. Le travail est bien fait et sans précipitation.',
          '7': 'Une journée idéale pour des fiançailles, un mariage ou la prise d\'autres engagements communs sérieux.',
          '8': 'Fiabilité dans les finances communes. Confiance profonde et stabilité dans les relations intimes.',
          '9': 'Une relation avec une personne plus âgée ou de statut supérieur se développe harmonieusement. Des projets réalistes pour l\'avenir.',
          '10': 'Votre fiabilité et votre professionnalisme contribuent à renforcer votre réputation. Une romance au bureau avec de sérieuses perspectives est possible.',
          '11': 'De vieux amis de confiance apportent un soutien inestimable. Projets à long terme avec des personnes partageant les mêmes idées.',
          '12': 'Paix intérieure et acceptation des expériences amoureuses passées, ce qui apporte sagesse et stabilité.'
        },
        'de': {
          '1': 'Sie machen den Eindruck einer zuverlässigen und ernsthaften Person. Es ist leicht, vertrauensvolle Beziehungen aufzubauen.',
          '2': 'Finanzielle Stabilität. Ein ausgezeichneter Tag für durchdachte Einkäufe, Investitionen und Budgetplanung.',
          '3': 'Ein ruhiges und konstruktives Gespräch über Gefühle, das die Beziehung stärkt.',
          '4': 'Stärkung des Familienfundaments. Die Pflege älterer Menschen bringt Befriedigung. Praktische Verbesserungen zu Hause.',
          '5': 'Die Beziehung erreicht ein neues, ernsteres Niveau. Treue und Hingabe. Liebe, die die Zeit überdauert.',
          '6': 'Stabile und respektvolle Beziehungen zu Kollegen. Die Arbeit wird gut und ohne Eile erledigt.',
          '7': 'Ein idealer Tag für eine Verlobung, Heirat oder andere ernsthafte gemeinsame Verpflichtungen.',
          '8': 'Zuverlässigkeit bei gemeinsamen Finanzen. Tiefes Vertrauen und Stabilität in intimen Beziehungen.',
          '9': 'Eine Beziehung zu einer älteren oder statushöheren Person entwickelt sich harmonisch. Realistische Zukunftspläne.',
          '10': 'Ihre Zuverlässigkeit und Professionalität tragen zur Stärkung Ihres Rufs bei. Eine Büro-Romanze mit ernsthaften Aussichten ist möglich.',
          '11': 'Alte, vertrauenswürdige Freunde bieten unschätzbare Unterstützung. Langfristige Pläne mit Gleichgesinnten.',
          '12': 'Innerer Frieden und Akzeptanz vergangener Liebeserfahrungen, was Weisheit und Stabilität bringt.'
        }
      }
    ),
    AspectInterpretation(
      id: 'MARS_OPPOSITION_NEPTUNE',
      title: {
        'ru': 'Противостояние Марса и Нептуна',
        'en': 'Mars Opposition Neptune',
        'fr': 'Mars Opposition Neptune',
        'de': 'Mars-Opposition-Neptun'
      },
      descriptionGeneral: {
        'ru': 'День хаотичных и неэффективных действий. Ваша энергия (Марс) распыляется в тумане обмана или самообмана (Нептун). Риск стать жертвой интриг или действовать на основе иллюзий.',
        'en': 'A day of chaotic and ineffective actions. Your energy (Mars) is dissipated in a fog of deception or self-deception (Neptune). Risk of falling victim to intrigues or acting on illusions.',
        'fr': 'Une journée d\'actions chaotiques et inefficaces. Votre énergie (Mars) se dissipe dans un brouillard de tromperie ou d\'auto-illusion (Neptune). Risque de devenir la victime d\'intrigues ou d\'agir sur la base d\'illusions.',
        'de': 'Ein Tag chaotischer und ineffektiver Handlungen. Ihre Energie (Mars) verflüchtigt sich in einem Nebel aus Täuschung oder Selbsttäuschung (Neptun). Gefahr, Opfer von Intrigen zu werden oder auf der Grundlage von Illusionen zu handeln.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Вы чувствуете себя слабым и дезориентированным. Другие люди могут легко сбить вас с толку или обмануть.',
          '2': 'Ваши действия могут привести к финансовым потерям. Кто-то может обмануть вас с деньгами.',
          '3': 'Обман в общении. Не верьте всему, что говорят. Партнер или собеседник может быть неискренен.',
          '4': 'Тайные интриги и обман в семье. Кто-то из домочадцев действует за вашей спиной.',
          '5': 'Вы можете быть обмануты в любви. Партнер может оказаться не тем, за кого себя выдает.',
          '6': 'Коллеги плетут интриги за вашей спиной. Упадок сил, нет энергии для работы.',
          '7': 'Партнер ведет двойную игру или вы проецируете на него свои иллюзии. Отношения очень туманны.',
          '8': 'Риск быть втянутым в финансовые махинации другими людьми. Обман в интимных отношениях.',
          '9': 'Ваши действия основаны на ложных идеалах, которые навязаны другими. Разочарование в учителе.',
          '10': 'Кто-то пытается подорвать вашу репутацию с помощью интриг. Неясные карьерные цели.',
          '11': 'Друг может обмануть ваше доверие. Вы можете быть втянуты в сомнительные дела.',
          '12': 'Вы становитесь жертвой тайных врагов или собственных саморазрушительных тенденций.'
        },
        'en': {
          '1': 'You feel weak and disoriented. Other people can easily confuse or deceive you.',
          '2': 'Your actions could lead to financial losses. Someone might deceive you with money.',
          '3': 'Deception in communication. Don\'t believe everything you hear. A partner or interlocutor may be insincere.',
          '4': 'Secret intrigues and deception in the family. A household member is acting behind your back.',
          '5': 'You may be deceived in love. Your partner may not be who they seem.',
          '6': 'Colleagues are plotting behind your back. A lack of energy, no strength for work.',
          '7': 'Your partner is playing a double game, or you are projecting your illusions onto them. The relationship is very foggy.',
          '8': 'Risk of being drawn into financial fraud by other people. Deception in intimate relationships.',
          '9': 'Your actions are based on false ideals imposed by others. Disappointment in a teacher.',
          '10': 'Someone is trying to undermine your reputation with intrigues. Unclear career goals.',
          '11': 'A friend may betray your trust. You might get involved in questionable affairs.',
          '12': 'You become a victim of secret enemies or your own self-destructive tendencies.'
        },
        'fr': {
          '1': 'Vous vous sentez faible et désorienté. D\'autres personnes peuvent facilement vous embrouiller ou vous tromper.',
          '2': 'Vos actions pourraient entraîner des pertes financières. Quelqu\'un pourrait vous tromper avec de l\'argent.',
          '3': 'Tromperie dans la communication. Ne croyez pas tout ce que vous entendez. Un partenaire ou un interlocuteur peut manquer de sincérité.',
          '4': 'Intrigues secrètes et tromperie dans la famille. Un membre du ménage agit dans votre dos.',
          '5': 'Vous risquez d\'être trompé en amour. Votre partenaire n\'est peut-être pas celui qu\'il semble être.',
          '6': 'Des collègues complotent dans votre dos. Manque d\'énergie, pas de force pour travailler.',
          '7': 'Votre partenaire joue un double jeu, ou vous projetez vos illusions sur lui. La relation est très floue.',
          '8': 'Risque d\'être entraîné dans une fraude financière par d\'autres personnes. Tromperie dans les relations intimes.',
          '9': 'Vos actions sont basées sur de faux idéaux imposés par d\'autres. Déception envers un enseignant.',
          '10': 'Quelqu\'un essaie de saper votre réputation par des intrigues. Objectifs de carrière flous.',
          '11': 'Un ami peut trahir votre confiance. Vous pourriez vous impliquer dans des affaires douteuses.',
          '12': 'Vous devenez la victime d\'ennemis secrets ou de vos propres tendances autodestructrices.'
        },
        'de': {
          '1': 'Sie fühlen sich schwach und desorientiert. Andere Menschen können Sie leicht verwirren oder täuschen.',
          '2': 'Ihre Handlungen könnten zu finanziellen Verlusten führen. Jemand könnte Sie mit Geld betrügen.',
          '3': 'Täuschung in der Kommunikation. Glauben Sie nicht alles, was Sie hören. Ein Partner oder Gesprächspartner könnte unaufrichtig sein.',
          '4': 'Geheime Intrigen und Täuschung in der Familie. Ein Haushaltsmitglied handelt hinter Ihrem Rücken.',
          '5': 'Sie könnten in der Liebe betrogen werden. Ihr Partner ist möglicherweise nicht der, für den er sich ausgibt.',
          '6': 'Kollegen intrigieren hinter Ihrem Rücken. Energiemangel, keine Kraft zum Arbeiten.',
          '7': 'Ihr Partner spielt ein doppeltes Spiel, oder Sie projizieren Ihre Illusionen auf ihn. Die Beziehung ist sehr neblig.',
          '8': 'Gefahr, von anderen in Finanzbetrug verwickelt zu werden. Täuschung in intimen Beziehungen.',
          '9': 'Ihre Handlungen basieren auf falschen Idealen, die von anderen auferlegt wurden. Enttäuschung von einem Lehrer.',
          '10': 'Jemand versucht, Ihren Ruf durch Intrigen zu untergraben. Unklare Karriereziele.',
          '11': 'Ein Freund könnte Ihr Vertrauen missbrauchen. Sie könnten in fragwürdige Angelegenheiten verwickelt werden.',
          '12': 'Sie werden Opfer geheimer Feinde oder Ihrer eigenen selbstzerstörerischen Tendenzen.'
        }
      }
    ),
    AspectInterpretation(
      id: 'MERCURY_TRINE_PLUTO',
      title: {
        'ru': 'Гармония Меркурия и Плутона',
        'en': 'Mercury Trine Pluto',
        'fr': 'Mercure Trigone Pluton',
        'de': 'Merkur-Trigon-Pluto'
      },
      descriptionGeneral: {
        'ru': 'День глубокого мышления и влиятельных слов. Ваш ум (Меркурий) способен проникнуть в самую суть вещей (Плутон). Отлично для расследований, психоанализа, серьезных переговоров.',
        'en': 'A day of deep thinking and influential words. Your mind (Mercury) is able to penetrate to the very essence of things (Pluto). Excellent for investigations, psychoanalysis, serious negotiations.',
        'fr': 'Une journée de pensée profonde et de mots influents. Votre esprit (Mercure) est capable de pénétrer jusqu\'à l\'essence même des choses (Pluton). Excellent pour les enquêtes, la psychanalyse, les négociations sérieuses.',
        'de': 'Ein Tag des tiefen Denkens und einflussreicher Worte. Ihr Verstand (Merkur) ist in der Lage, zum eigentlichen Wesen der Dinge (Pluto) vorzudringen. Ausgezeichnet für Ermittlungen, Psychoanalyse, ernsthafte Verhandlungen.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Ваши слова обладают силой и убедительностью. Вы легко можете влиять на мнение других.',
          '2': 'Глубокое понимание финансовых процессов. Вы видите скрытые возможности для заработка.',
          '3': 'Разговор, который помогает докопаться до истины. Вы легко раскрываете тайны и мотивы других.',
          '4': 'Глубокий и честный разговор с семьей, который исцеляет старые раны. Раскрытие семейной тайны во благо.',
          '5': 'Страстный и глубокий разговор с любимым человеком, который выводит отношения на новый уровень.',
          '6': 'Вы способны решить самую сложную и запутанную рабочую задачу. Видите все "подводные камни".',
          '7': 'Честный и глубокий диалог с партнером, который трансформирует ваши отношения к лучшему.',
          '8': 'Идеальный день для психотерапии. Легко разобраться в своих скрытых страхах и комплексах.',
          '9': 'Глубокое погружение в учебу, которое кардинально меняет ваше мировоззрение.',
          '10': 'Ваши проницательные идеи производят сильное впечатление на начальство. Вы можете получить больше власти.',
          '11': 'Вы можете стать неформальным лидером в группе благодаря своей проницательности и умению убеждать.',
          '12': 'Глубокий самоанализ. Вы легко докапываетесь до сути своих подсознательных мотивов.'
        },
        'en': {
          '1': 'Your words have power and persuasiveness. You can easily influence the opinions of others.',
          '2': 'A deep understanding of financial processes. You see hidden opportunities for earning.',
          '3': 'A conversation that helps get to the truth. You easily uncover the secrets and motives of others.',
          '4': 'A deep and honest conversation with family that heals old wounds. Revealing a family secret for the better.',
          '5': 'A passionate and deep conversation with a loved one that takes the relationship to a new level.',
          '6': 'You are able to solve the most complex and confusing work task. You see all the "hidden pitfalls."',
          '7': 'An honest and deep dialogue with a partner that transforms your relationship for the better.',
          '8': 'An ideal day for psychotherapy. It\'s easy to understand your hidden fears and complexes.',
          '9': 'A deep dive into studies that fundamentally changes your worldview.',
          '10': 'Your insightful ideas make a strong impression on your superiors. You may gain more power.',
          '11': 'You can become an informal leader in a group thanks to your insight and persuasiveness.',
          '12': 'Deep self-analysis. You easily get to the bottom of your subconscious motives.'
        },
        'fr': {
          '1': 'Vos paroles ont du pouvoir et de la persuasion. Vous pouvez facilement influencer les opinions des autres.',
          '2': 'Une profonde compréhension des processus financiers. Vous voyez des opportunités cachées de revenus.',
          '3': 'Une conversation qui aide à découvrir la vérité. Vous découvrez facilement les secrets et les motivations des autres.',
          '4': 'Une conversation profonde et honnête avec la famille qui guérit de vieilles blessures. Révéler un secret de famille pour le mieux.',
          '5': 'Une conversation passionnée et profonde avec un être cher qui amène la relation à un nouveau niveau.',
          '6': 'Vous êtes capable de résoudre la tâche de travail la plus complexe et la plus confuse. Vous voyez tous les "pièges cachés".',
          '7': 'Un dialogue honnête et profond avec un partenaire qui transforme votre relation pour le mieux.',
          '8': 'Une journée idéale pour la psychothérapie. Il est facile de comprendre vos peurs et complexes cachés.',
          '9': 'Une plongée profonde dans les études qui change fondamentalement votre vision du monde.',
          '10': 'Vos idées perspicaces font une forte impression sur vos supérieurs. Vous pourriez gagner plus de pouvoir.',
          '11': 'Vous pouvez devenir un leader informel dans un groupe grâce à votre perspicacité et votre persuasion.',
          '12': 'Auto-analyse approfondie. Vous allez facilement au fond de vos motivations subconscientes.'
        },
        'de': {
          '1': 'Ihre Worte haben Macht und Überzeugungskraft. Sie können die Meinungen anderer leicht beeinflussen.',
          '2': 'Ein tiefes Verständnis für Finanzprozesse. Sie sehen verborgene Verdienstmöglichkeiten.',
          '3': 'Ein Gespräch, das hilft, zur Wahrheit zu gelangen. Sie decken leicht die Geheimnisse und Motive anderer auf.',
          '4': 'Ein tiefes und ehrliches Gespräch mit der Familie, das alte Wunden heilt. Ein Familiengeheimnis zum Besseren lüften.',
          '5': 'Ein leidenschaftliches und tiefes Gespräch mit einem geliebten Menschen, das die Beziehung auf eine neue Ebene hebt.',
          '6': 'Sie sind in der Lage, die komplexeste und verwirrendste Arbeitsaufgabe zu lösen. Sie sehen alle "versteckten Fallstricke".',
          '7': 'Ein ehrlicher und tiefer Dialog mit einem Partner, der Ihre Beziehung zum Besseren verändert.',
          '8': 'Ein idealer Tag für Psychotherapie. Es ist leicht, Ihre verborgenen Ängste und Komplexe zu verstehen.',
          '9': 'Ein tiefes Eintauchen in das Studium, das Ihre Weltanschauung grundlegend verändert.',
          '10': 'Ihre einsichtsvollen Ideen machen einen starken Eindruck auf Ihre Vorgesetzten. Sie könnten mehr Macht erlangen.',
          '11': 'Sie können dank Ihrer Einsicht und Überzeugungskraft ein informeller Anführer in einer Gruppe werden.',
          '12': 'Tiefe Selbstanalyse. Sie gehen leicht den Dingen Ihrer unbewussten Motive auf den Grund.'
        }
      }
    ),
            // === НОВЫЙ БЛОК 14 ===
    AspectInterpretation(
      id: 'MOON_SQUARE_URANUS',
      title: {
        'ru': 'Конфликт Луны и Урана',
        'en': 'Moon Square Uranus',
        'fr': 'Lune Carré Uranus',
        'de': 'Mond-Quadrat-Uranus'
      },
      descriptionGeneral: {
        'ru': 'День эмоциональной нестабильности и нервозности. Ваши потребности (Луна) конфликтуют с желанием свободы (Уран). Внезапные смены настроения, импульсивные поступки, неожиданные бытовые события.',
        'en': 'A day of emotional instability and nervousness. Your needs (Moon) conflict with the desire for freedom (Uranus). Sudden mood swings, impulsive actions, unexpected domestic events.',
        'fr': 'Une journée d\'instabilité émotionnelle et de nervosité. Vos besoins (Lune) entrent en conflit avec le désir de liberté (Uranus). Sautes d\'humeur soudaines, actions impulsives, événements domestiques inattendus.',
        'de': 'Ein Tag emotionaler Instabilität und Nervosität. Ihre Bedürfnisse (Mond) kollidieren mit dem Wunsch nach Freiheit (Uranus). Plötzliche Stimmungsschwankungen, impulsive Handlungen, unerwartete häusliche Ereignisse.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Ваши эмоциональные реакции непредсказуемы. Внезапные капризы и желание сделать все по-своему.',
          '2': 'Импульсивные траты. Желание потратить деньги на что-то необычное может привести к сожалению.',
          '3': 'Вы можете сказать что-то резкое, не подумав. Неожиданные новости, которые выбивают из колеи.',
          '4': 'Внезапные перемены или ссоры в доме. Желание "сбежать" от семейной рутины. Конфликт с матерью.',
          '5': 'Эмоциональные качели в любви. Внезапные ссоры или потребность в свободе от партнера.',
          '6': 'Раздражение от рутинной работы. Внезапные изменения в рабочем графике, срыв планов.',
          '7': 'Партнер может вести себя непредсказуемо, что вызывает у вас эмоциональный дискомфорт.',
          '8': 'Эмоциональная нестабильность может привести к рискованным финансовым или интимным решениям.',
          '9': 'Внезапное желание бросить учебу или отменить поездку из-за плохого настроения.',
          '10': 'Ваши капризы и эмоциональная нестабильность могут повредить репутации. Конфликт с начальницей.',
          '11': 'Внезапные ссоры с друзьями из-за пустяков. Вы можете чувствовать себя непонятым.',
          '12': 'Подсознательная тревога и беспокойство. Внезапные страхи, которым трудно найти причину.'
        },
        'en': {
          '1': 'Your emotional reactions are unpredictable. Sudden whims and a desire to do everything your own way.',
          '2': 'Impulsive spending. The desire to spend money on something unusual can lead to regret.',
          '3': 'You might say something harsh without thinking. Unexpected news that throws you off balance.',
          '4': 'Sudden changes or quarrels at home. A desire to "escape" from family routine. Conflict with mother.',
          '5': 'Emotional rollercoasters in love. Sudden quarrels or a need for freedom from a partner.',
          '6': 'Irritation from routine work. Sudden changes in the work schedule, disruption of plans.',
          '7': 'A partner may behave unpredictably, causing you emotional discomfort.',
          '8': 'Emotional instability can lead to risky financial or intimate decisions.',
          '9': 'A sudden desire to quit studying or cancel a trip due to a bad mood.',
          '10': 'Your whims and emotional instability could damage your reputation. Conflict with a female boss.',
          '11': 'Sudden quarrels with friends over trifles. You may feel misunderstood.',
          '12': 'Subconscious anxiety and restlessness. Sudden fears that are hard to explain.'
        },
        'fr': {
          '1': 'Vos réactions émotionnelles sont imprévisibles. Des caprices soudains et un désir de tout faire à votre façon.',
          '2': 'Dépenses impulsives. Le désir de dépenser de l\'argent pour quelque chose d\'inhabituel peut entraîner des regrets.',
          '3': 'Vous pourriez dire quelque chose de dur sans réfléchir. Des nouvelles inattendues qui vous déstabilisent.',
          '4': 'Changements soudains ou querelles à la maison. Un désir de "s\'échapper" de la routine familiale. Conflit avec la mère.',
          '5': 'Montagnes russes émotionnelles en amour. Querelles soudaines ou besoin de liberté par rapport à un partenaire.',
          '6': 'Irritation face au travail de routine. Changements soudains dans l\'horaire de travail, perturbation des plans.',
          '7': 'Un partenaire peut se comporter de manière imprévisible, ce qui vous cause un inconfort émotionnel.',
          '8': 'L\'instabilité émotionnelle peut conduire à des décisions financières ou intimes risquées.',
          '9': 'Un désir soudain d\'arrêter les études ou d\'annuler un voyage à cause d\'une mauvaise humeur.',
          '10': 'Vos caprices et votre instabilité émotionnelle pourraient nuire à votre réputation. Conflit avec une patronne.',
          '11': 'Querelles soudaines avec des amis pour des broutilles. Vous pourriez vous sentir incompris.',
          '12': 'Anxiété et agitation subconscientes. Peurs soudaines difficiles à expliquer.'
        },
        'de': {
          '1': 'Ihre emotionalen Reaktionen sind unvorhersehbar. Plötzliche Launen und der Wunsch, alles auf Ihre Weise zu tun.',
          '2': 'Impulsive Ausgaben. Der Wunsch, Geld für etwas Ungewöhnliches auszugeben, kann zu Bedauern führen.',
          '3': 'Sie könnten etwas Hartes sagen, ohne nachzudenken. Unerwartete Nachrichten, die Sie aus dem Gleichgewicht bringen.',
          '4': 'Plötzliche Veränderungen oder Streit zu Hause. Ein Wunsch, der Familienroutine zu "entkommen". Konflikt mit der Mutter.',
          '5': 'Emotionale Achterbahnfahrten in der Liebe. Plötzlicher Streit oder das Bedürfnis nach Freiheit von einem Partner.',
          '6': 'Reizung durch Routinearbeit. Plötzliche Änderungen im Arbeitsplan, Störung der Pläne.',
          '7': 'Ein Partner kann sich unvorhersehbar verhalten, was Ihnen emotionales Unbehagen bereitet.',
          '8': 'Emotionale Instabilität kann zu riskanten finanziellen oder intimen Entscheidungen führen.',
          '9': 'Ein plötzlicher Wunsch, das Studium abzubrechen oder eine Reise wegen schlechter Laune abzusagen.',
          '10': 'Ihre Launen und emotionale Instabilität könnten Ihrem Ruf schaden. Konflikt mit einer Chefin.',
          '11': 'Plötzlicher Streit mit Freunden über Kleinigkeiten. Sie könnten sich missverstanden fühlen.',
          '12': 'Unterbewusste Angst und Unruhe. Plötzliche Ängste, die schwer zu erklären sind.'
        }
      }
    ),
    AspectInterpretation(
      id: 'MOON_SQUARE_PLUTO',
      title: {
        'ru': 'Конфликт Луны и Плутона',
        'en': 'Moon Square Pluto',
        'fr': 'Lune Carré Pluton',
        'de': 'Mond-Quadrat-Pluto'
      },
      descriptionGeneral: {
        'ru': 'День интенсивных и навязчивых эмоций. Ваши потребности (Луна) сталкиваются с желанием контроля (Плутон). Ревность, манипуляции, эмоциональное давление. Скрытые чувства выходят наружу.',
        'en': 'A day of intense and obsessive emotions. Your needs (Moon) clash with the desire for control (Pluto). Jealousy, manipulation, emotional pressure. Hidden feelings come to the surface.',
        'fr': 'Une journée d\'émotions intenses et obsessionnelles. Vos besoins (Lune) se heurtent au désir de contrôle (Pluton). Jalousie, manipulation, pression émotionnelle. Les sentiments cachés remontent à la surface.',
        'de': 'Ein Tag intensiver und zwanghafter Emotionen. Ihre Bedürfnisse (Mond) kollidieren mit dem Wunsch nach Kontrolle (Pluto). Eifersucht, Manipulation, emotionaler Druck. Verborgene Gefühle kommen an die Oberfläche.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Вы можете быть одержимы своими чувствами. Эмоциональное давление на себя или на других.',
          '2': 'Манипуляции, связанные с деньгами. Страх бедности или одержимость контролем над ресурсами.',
          '3': 'Слова используются как инструмент манипуляции. Ревнивые допросы, попытки выведать чужие тайны.',
          '4': 'Тяжелая эмоциональная атмосфера в семье. Эмоциональный шантаж, борьба за власть с матерью/женщиной.',
          '5': 'Сильная ревность и желание контролировать любимого человека. Любовь превращается в драму.',
          '6': 'Эмоциональное давление на работе. Интриги, попытки манипулировать коллегами. Риск психосоматических проблем.',
          '7': 'Борьба за власть с партнером. Эмоциональные манипуляции для контроля над отношениями.',
          '8': 'Кризис в интимной жизни. Навязчивые желания. Споры из-за общих финансов.',
          '9': 'Фанатичное отстаивание своих убеждений. Попытки эмоционально "задавить" оппонента.',
          '10': 'Эмоциональное давление со стороны начальства. Ваша репутация может пострадать из-за интриг.',
          '11': 'Ревность и манипуляции в дружбе. Кто-то пытается контролировать вас или разрушить ваши отношения.',
          '12': 'Всплывают глубоко скрытые страхи и травмы. Саморазрушительные эмоции, навязчивые состояния.'
        },
        'en': {
          '1': 'You may be obsessed with your feelings. Emotional pressure on yourself or others.',
          '2': 'Money-related manipulations. Fear of poverty or obsession with controlling resources.',
          '3': 'Words are used as a tool of manipulation. Jealous interrogations, attempts to uncover others\' secrets.',
          '4': 'A heavy emotional atmosphere in the family. Emotional blackmail, a power struggle with a mother/woman.',
          '5': 'Intense jealousy and a desire to control a loved one. Love turns into drama.',
          '6': 'Emotional pressure at work. Intrigues, attempts to manipulate colleagues. Risk of psychosomatic problems.',
          '7': 'A power struggle with a partner. Emotional manipulation to control the relationship.',
          '8': 'A crisis in your intimate life. Obsessive desires. Disputes over joint finances.',
          '9': 'Fanatical defense of your beliefs. Attempts to emotionally "crush" an opponent.',
          '10': 'Emotional pressure from superiors. Your reputation may suffer due to intrigues.',
          '11': 'Jealousy and manipulation in friendship. Someone is trying to control you or destroy your relationships.',
          '12': 'Deeply hidden fears and traumas surface. Self-destructive emotions, obsessive states.'
        },
        'fr': {
          '1': 'Vous pouvez être obsédé par vos sentiments. Pression émotionnelle sur vous-même ou sur les autres.',
          '2': 'Manipulations liées à l\'argent. Peur de la pauvreté ou obsession du contrôle des ressources.',
          '3': 'Les mots sont utilisés comme un outil de manipulation. Interrogatoires jaloux, tentatives de découvrir les secrets des autres.',
          '4': 'Atmosphère émotionnelle lourde dans la famille. Chantage affectif, lutte de pouvoir avec une mère/femme.',
          '5': 'Jalousie intense et désir de contrôler un être cher. L\'amour se transforme en drame.',
          '6': 'Pression émotionnelle au travail. Intrigues, tentatives de manipuler les collègues. Risque de problèmes psychosomatiques.',
          '7': 'Lutte de pouvoir avec un partenaire. Manipulation émotionnelle pour contrôler la relation.',
          '8': 'Crise dans votre vie intime. Désirs obsessionnels. Disputes sur les finances communes.',
          '9': 'Défense fanatique de vos croyances. Tentatives de "broyer" émotionnellement un adversaire.',
          '10': 'Pression émotionnelle de la part des supérieurs. Votre réputation peut souffrir à cause d\'intrigues.',
          '11': 'Jalousie et manipulation en amitié. Quelqu\'un essaie de vous contrôler ou de détruire vos relations.',
          '12': 'Des peurs et des traumatismes profondément cachés refont surface. Émotions autodestructrices, états obsessionnels.'
        },
        'de': {
          '1': 'Sie könnten von Ihren Gefühlen besessen sein. Emotionaler Druck auf sich selbst oder andere.',
          '2': 'Geldbezogene Manipulationen. Angst vor Armut oder Besessenheit, Ressourcen zu kontrollieren.',
          '3': 'Worte werden als Manipulationswerkzeug benutzt. Eifersüchtige Verhöre, Versuche, die Geheimnisse anderer aufzudecken.',
          '4': 'Eine schwere emotionale Atmosphäre in der Familie. Emotionale Erpressung, ein Machtkampf mit einer Mutter/Frau.',
          '5': 'Intensive Eifersucht und der Wunsch, einen geliebten Menschen zu kontrollieren. Liebe wird zum Drama.',
          '6': 'Emotionaler Druck bei der Arbeit. Intrigen, Versuche, Kollegen zu manipulieren. Risiko psychosomatischer Probleme.',
          '7': 'Ein Machtkampf mit einem Partner. Emotionale Manipulation, um die Beziehung zu kontrollieren.',
          '8': 'Eine Krise in Ihrem Intimleben. Zwanghafte Wünsche. Streitigkeiten über gemeinsame Finanzen.',
          '9': 'Fanatische Verteidigung Ihrer Überzeugungen. Versuche, einen Gegner emotional zu "zerquetschen".',
          '10': 'Emotionaler Druck von Vorgesetzten. Ihr Ruf könnte durch Intrigen leiden.',
          '11': 'Eifersucht und Manipulation in der Freundschaft. Jemand versucht, Sie zu kontrollieren oder Ihre Beziehungen zu zerstören.',
          '12': 'Tief verborgene Ängste und Traumata kommen an die Oberfläche. Selbstzerstörerische Emotionen, zwanghafte Zustände.'
        }
      }
    ),
    AspectInterpretation(
      id: 'MERCURY_SEXTILE_PLUTO',
      title: {
        'ru': 'Шанс от Меркурия и Плутона',
        'en': 'Mercury Sextile Pluto',
        'fr': 'Mercure Sextile Pluton',
        'de': 'Merkur-Sextil-Pluto'
      },
      descriptionGeneral: {
        'ru': 'День дает возможность для глубокого понимания и проницательности. Появляется шанс докопаться до сути, раскрыть тайну или провести очень влиятельный разговор.',
        'en': 'The day provides an opportunity for deep understanding and insight. There is a chance to get to the bottom of things, uncover a secret, or have a very influential conversation.',
        'fr': 'La journée offre une opportunité de compréhension et de perspicacité profondes. Il y a une chance d\'aller au fond des choses, de découvrir un secret ou d\'avoir une conversation très influente.',
        'de': 'Der Tag bietet eine Gelegenheit für tiefes Verständnis und Einsicht. Es besteht die Chance, den Dingen auf den Grund zu gehen, ein Geheimnis aufzudecken oder ein sehr einflussreiches Gespräch zu führen.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Возможность понять свои глубинные мотивы. Ваши слова могут оказать сильное влияние.',
          '2': 'Шанс найти скрытый финансовый ресурс или понять, как трансформировать свое финансовое положение.',
          '3': 'Появляется возможность провести разговор, который все прояснит. Успех в исследованиях.',
          '4': 'Шанс узнать семейную тайну или провести глубокий разговор с родными, который улучшит отношения.',
          '5': 'Возможность для очень глубокого и откровенного разговора с любимым человеком.',
          '6': 'Шанс найти корень проблемы на работе и предложить эффективное решение.',
          '7': 'Возможность через честный диалог трансформировать и углубить отношения с партнером.',
          '8': 'Хорошая возможность для психотерапии, самоанализа или решения сложных финансовых вопросов.',
          '9': 'Шанс глубоко погрузиться в интересующую вас тему и сделать важное открытие.',
          '10': 'Возможность произвести впечатление на начальство своей проницательностью и глубоким пониманием дела.',
          '11': 'Шанс для глубокого и трансформирующего разговора с другом.',
          '12': 'Появляется возможность понять свои скрытые страхи и подсознательные программы.'
        },
        'en': {
          '1': 'An opportunity to understand your deep motives. Your words can have a strong influence.',
          '2': 'A chance to find a hidden financial resource or understand how to transform your financial situation.',
          '3': 'An opportunity arises for a conversation that will clarify everything. Success in research.',
          '4': 'A chance to learn a family secret or have a deep conversation with relatives that improves the relationship.',
          '5': 'An opportunity for a very deep and frank conversation with a loved one.',
          '6': 'A chance to find the root of a problem at work and propose an effective solution.',
          '7': 'An opportunity to transform and deepen the relationship with a partner through honest dialogue.',
          '8': 'A good opportunity for psychotherapy, self-analysis, or solving complex financial issues.',
          '9': 'A chance to dive deep into a topic of interest and make an important discovery.',
          '10': 'An opportunity to impress your superiors with your insight and deep understanding of the matter.',
          '11': 'A chance for a deep and transformative conversation with a friend.',
          '12': 'An opportunity to understand your hidden fears and subconscious programs arises.'
        },
        'fr': {
          '1': 'Une opportunité de comprendre vos motivations profondes. Vos paroles peuvent avoir une forte influence.',
          '2': 'Une chance de trouver une ressource financière cachée ou de comprendre comment transformer votre situation financière.',
          '3': 'Une opportunité se présente pour une conversation qui clarifiera tout. Succès dans la recherche.',
          '4': 'Une chance d\'apprendre un secret de famille ou d\'avoir une conversation profonde avec des proches qui améliore la relation.',
          '5': 'Une opportunité pour une conversation très profonde et franche avec un être cher.',
          '6': 'Une chance de trouver la racine d\'un problème au travail et de proposer une solution efficace.',
          '7': 'Une opportunité de transformer et d\'approfondir la relation avec un partenaire par un dialogue honnête.',
          '8': 'Une bonne opportunité pour la psychothérapie, l\'auto-analyse ou la résolution de problèmes financiers complexes.',
          '9': 'Une chance de plonger profondément dans un sujet d\'intérêt et de faire une découverte importante.',
          '10': 'Une opportunité d\'impressionner vos supérieurs par votre perspicacité et votre profonde compréhension du sujet.',
          '11': 'Une chance pour une conversation profonde et transformatrice avec un ami.',
          '12': 'Une opportunité de comprendre vos peurs cachées et vos programmes subconscients se présente.'
        },
        'de': {
          '1': 'Eine Gelegenheit, Ihre tiefen Motive zu verstehen. Ihre Worte können einen starken Einfluss haben.',
          '2': 'Eine Chance, eine verborgene finanzielle Ressource zu finden oder zu verstehen, wie Sie Ihre finanzielle Situation verändern können.',
          '3': 'Es ergibt sich die Gelegenheit für ein Gespräch, das alles klären wird. Erfolg in der Forschung.',
          '4': 'Eine Chance, ein Familiengeheimnis zu erfahren oder ein tiefes Gespräch mit Verwandten zu führen, das die Beziehung verbessert.',
          '5': 'Eine Gelegenheit für ein sehr tiefes und offenes Gespräch mit einem geliebten Menschen.',
          '6': 'Eine Chance, die Wurzel eines Problems bei der Arbeit zu finden und eine effektive Lösung vorzuschlagen.',
          '7': 'Eine Gelegenheit, die Beziehung zu einem Partner durch ehrlichen Dialog zu transformieren und zu vertiefen.',
          '8': 'Eine gute Gelegenheit für Psychotherapie, Selbstanalyse oder die Lösung komplexer finanzieller Probleme.',
          '9': 'Eine Chance, tief in ein interessierendes Thema einzutauchen und eine wichtige Entdeckung zu machen.',
          '10': 'Eine Gelegenheit, Ihre Vorgesetzten mit Ihrer Einsicht und Ihrem tiefen Verständnis der Sache zu beeindrucken.',
          '11': 'Eine Chance für ein tiefes und transformierendes Gespräch mit einem Freund.',
          '12': 'Es ergibt sich die Gelegenheit, Ihre verborgenen Ängste und unbewussten Programme zu verstehen.'
        }
      }
    ),
    AspectInterpretation(
      id: 'MARS_TRINE_NEPTUNE',
      title: {
        'ru': 'Гармония Марса и Нептуна',
        'en': 'Mars Trine Neptune',
        'fr': 'Mars Trigone Neptune',
        'de': 'Mars-Trigon-Neptun'
      },
      descriptionGeneral: {
        'ru': 'День вдохновенных и интуитивных действий. Ваша энергия (Марс) направляется высшими идеалами (Нептун). Отлично для творчества, помощи другим, духовных практик и действий, основанных на интуиции.',
        'en': 'A day of inspired and intuitive actions. Your energy (Mars) is guided by higher ideals (Neptune). Excellent for creativity, helping others, spiritual practices, and actions based on intuition.',
        'fr': 'Une journée d\'actions inspirées et intuitives. Votre énergie (Mars) est guidée par des idéaux supérieurs (Neptune). Excellent pour la créativité, l\'aide aux autres, les pratiques spirituelles et les actions basées sur l\'intuition.',
        'de': 'Ein Tag inspirierter und intuitiver Handlungen. Ihre Energie (Mars) wird von höheren Idealen (Neptun) geleitet. Ausgezeichnet für Kreativität, Hilfe für andere, spirituelle Praktiken und auf Intuition basierende Handlungen.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Вы действуете мягко, но уверенно, следуя своей интуиции. Ваше сострадание вдохновляет других.',
          '2': 'Интуиция подсказывает, как заработать. Действия, связанные с творчеством или благотворительностью, приносят доход.',
          '3': 'Ваши слова вдохновляют и исцеляют. Легко говорить на духовные темы, писать стихи.',
          '4': 'Действия, направленные на создание гармоничной и одухотворенной атмосферы дома.',
          '5': 'Очень романтичные и возвышенные поступки в любви. Вы действуете, чтобы воплотить свою мечту в реальность.',
          '6': 'Работа, особенно творческая или связанная с помощью, приносит глубокое удовлетворение.',
          '7': 'Вы действуете в унисон с духовными потребностями вашего партнера. Отношения наполняются волшебством.',
          '8': 'Глубокая интуитивная и сексуальная связь с партнером. Вы чувствуете его желания без слов.',
          '9': 'Действия, основанные на ваших высших идеалах. Удачное время для паломничества или волонтерства.',
          '10': 'Успех в профессиях, связанных с искусством, исцелением, психологией. Вы интуитивно выбираете верный путь.',
          '11': 'Вы вдохновляете друзей на бескорыстные и добрые поступки. Совместные мечты легко воплощаются.',
          '12': 'Действия в уединении (творчество, медитация) приносят глубокую гармонию. Интуиция очень сильна.'
        },
        'en': {
          '1': 'You act gently but confidently, following your intuition. Your compassion inspires others.',
          '2': 'Intuition tells you how to earn money. Actions related to creativity or charity bring income.',
          '3': 'Your words inspire and heal. It\'s easy to talk on spiritual topics, to write poetry.',
          '4': 'Actions aimed at creating a harmonious and spiritual atmosphere at home.',
          '5': 'Very romantic and sublime actions in love. You act to make your dream a reality.',
          '6': 'Work, especially creative or helping-related, brings deep satisfaction.',
          '7': 'You act in unison with your partner\'s spiritual needs. The relationship is filled with magic.',
          '8': 'A deep intuitive and sexual connection with a partner. You feel their desires without words.',
          '9': 'Actions based on your highest ideals. A good time for a pilgrimage or volunteering.',
          '10': 'Success in professions related to art, healing, psychology. You intuitively choose the right path.',
          '11': 'You inspire friends to selfless and kind deeds. Joint dreams are easily realized.',
          '12': 'Actions in solitude (creativity, meditation) bring deep harmony. Intuition is very strong.'
        },
        'fr': {
          '1': 'Vous agissez doucement mais avec confiance, en suivant votre intuition. Votre compassion inspire les autres.',
          '2': 'L\'intuition vous dit comment gagner de l\'argent. Les actions liées à la créativité ou à la charité rapportent des revenus.',
          '3': 'Vos paroles inspirent et guérissent. Il est facile de parler de sujets spirituels, d\'écrire de la poésie.',
          '4': 'Actions visant à créer une atmosphère harmonieuse et spirituelle à la maison.',
          '5': 'Actions très romantiques et sublimes en amour. Vous agissez pour faire de votre rêve une réalité.',
          '6': 'Le travail, en particulier créatif ou lié à l\'aide, apporte une profonde satisfaction.',
          '7': 'Vous agissez à l\'unisson avec les besoins spirituels de votre partenaire. La relation est remplie de magie.',
          '8': 'Un lien intuitif et sexuel profond avec un partenaire. Vous sentez ses désirs sans mots.',
          '9': 'Actions basées sur vos idéaux les plus élevés. Un bon moment pour un pèlerinage ou du bénévolat.',
          '10': 'Succès dans les professions liées à l\'art, la guérison, la psychologie. Vous choisissez intuitivement le bon chemin.',
          '11': 'Vous inspirez des amis à des actes désintéressés et bienveillants. Les rêves communs se réalisent facilement.',
          '12': 'Les actions en solitude (créativité, méditation) apportent une harmonie profonde. L\'intuition est très forte.'
        },
        'de': {
          '1': 'Sie handeln sanft, aber selbstbewusst und folgen Ihrer Intuition. Ihr Mitgefühl inspiriert andere.',
          '2': 'Die Intuition sagt Ihnen, wie Sie Geld verdienen können. Handlungen im Zusammenhang mit Kreativität oder Wohltätigkeit bringen Einkommen.',
          '3': 'Ihre Worte inspirieren und heilen. Es ist leicht, über spirituelle Themen zu sprechen, Gedichte zu schreiben.',
          '4': 'Handlungen, die darauf abzielen, eine harmonische und spirituelle Atmosphäre zu Hause zu schaffen.',
          '5': 'Sehr romantische und erhabene Handlungen in der Liebe. Sie handeln, um Ihren Traum Wirklichkeit werden zu lassen.',
          '6': 'Arbeit, besonders kreative oder helfende, bringt tiefe Befriedigung.',
          '7': 'Sie handeln im Einklang mit den spirituellen Bedürfnissen Ihres Partners. Die Beziehung ist von Magie erfüllt.',
          '8': 'Eine tiefe intuitive und sexuelle Verbindung zu einem Partner. Sie spüren seine Wünsche ohne Worte.',
          '9': 'Handlungen, die auf Ihren höchsten Idealen basieren. Eine gute Zeit für eine Pilgerreise oder Freiwilligenarbeit.',
          '10': 'Erfolg in Berufen im Zusammenhang mit Kunst, Heilung, Psychologie. Sie wählen intuitiv den richtigen Weg.',
          '11': 'Sie inspirieren Freunde zu selbstlosen und freundlichen Taten. Gemeinsame Träume werden leicht verwirklicht.',
          '12': 'Handlungen in der Einsamkeit (Kreativität, Meditation) bringen tiefe Harmonie. Die Intuition ist sehr stark.'
        }
      }
    ),
            // === НОВЫЙ БЛОК 15 ===
    AspectInterpretation(
      id: 'MERCURY_TRINE_MARS',
      title: {
        'ru': 'Гармония Меркурия и Марса',
        'en': 'Mercury Trine Mars',
        'fr': 'Mercure Trigone Mars',
        'de': 'Merkur-Trigon-Mars'
      },
      descriptionGeneral: {
        'ru': 'День, когда ум и воля работают в унисон. Мысли ясные, острые и легко переходят в действия. Отличное время для дебатов, принятия быстрых решений и честных разговоров.',
        'en': 'A day when mind and will work in unison. Thoughts are clear, sharp, and easily translate into actions. An excellent time for debates, making quick decisions, and honest conversations.',
        'fr': 'Une journée où l\'esprit et la volonté travaillent à l\'unisson. Les pensées sont claires, vives et se traduisent facilement en actions. Un excellent moment pour les débats, la prise de décisions rapides et les conversations honnêtes.',
        'de': 'Ein Tag, an dem Verstand und Wille im Einklang arbeiten. Gedanken sind klar, scharf und lassen sich leicht in Handlungen umsetzen. Eine ausgezeichnete Zeit für Debatten, schnelle Entscheidungen und ehrliche Gespräche.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Вы говорите и действуете уверенно. Ваши слова убедительны и подкреплены волей.',
          '2': 'Быстрые и умные решения в финансовых вопросах. Легко отстоять свои финансовые интересы.',
          '3': 'Вы остроумны и убедительны в споре. Легко даются экзамены и сложные переговоры.',
          '4': 'Эффективное решение бытовых проблем. Честный и продуктивный разговор с семьей.',
          '5': 'Прямой, но обаятельный флирт. Легко выразить свои намерения и добиться взаимности.',
          '6': 'Высокая продуктивность. Вы быстро соображаете и эффективно решаете рабочие задачи.',
          '7': 'Открытый и конструктивный диалог с партнером. Легко договориться о совместных действиях.',
          '8': 'Способность быстро докопаться до сути сложной проблемы и найти решение.',
          '9': 'Быстрое и эффективное обучение. Вы легко защищаете свою точку зрения и убеждения.',
          '10': 'Убедительный разговор с начальством, который приводит к успеху. Ваши идеи быстро реализуются.',
          '11': 'Вы можете стать интеллектуальным лидером в компании друзей, легко организуя всех.',
          '12': 'Вы быстро и точно понимаете свои скрытые мотивы. Интуиция и логика работают слаженно.'
        },
        'en': {
          '1': 'You speak and act with confidence. Your words are persuasive and backed by will.',
          '2': 'Quick and smart decisions in financial matters. It\'s easy to defend your financial interests.',
          '3': 'You are witty and persuasive in arguments. Exams and difficult negotiations come easily.',
          '4': 'Effective solving of household problems. An honest and productive conversation with family.',
          '5': 'Direct but charming flirting. It\'s easy to express your intentions and achieve reciprocity.',
          '6': 'High productivity. You think quickly and efficiently solve work tasks.',
          '7': 'An open and constructive dialogue with your partner. It\'s easy to agree on joint actions.',
          '8': 'The ability to quickly get to the heart of a complex problem and find a solution.',
          '9': 'Fast and effective learning. You easily defend your point of view and beliefs.',
          '10': 'A persuasive conversation with your boss that leads to success. Your ideas are quickly implemented.',
          '11': 'You can become the intellectual leader in a group of friends, easily organizing everyone.',
          '12': 'You quickly and accurately understand your hidden motives. Intuition and logic work in harmony.'
        },
        'fr': {
          '1': 'Vous parlez et agissez avec confiance. Vos paroles sont persuasives et soutenues par la volonté.',
          '2': 'Décisions rapides et intelligentes en matière financière. Il est facile de défendre vos intérêts financiers.',
          '3': 'Vous êtes spirituel et persuasif dans les discussions. Les examens et les négociations difficiles sont faciles.',
          '4': 'Résolution efficace des problèmes ménagers. Une conversation honnête et productive avec la famille.',
          '5': 'Flirt direct mais charmant. Il est facile d\'exprimer vos intentions et d\'obtenir la réciprocité.',
          '6': 'Haute productivité. Vous réfléchissez vite et résolvez efficacement les tâches professionnelles.',
          '7': 'Un dialogue ouvert et constructif avec votre partenaire. Il est facile de se mettre d\'accord sur des actions communes.',
          '8': 'La capacité d\'aller rapidement au cœur d\'un problème complexe et de trouver une solution.',
          '9': 'Apprentissage rapide et efficace. Vous défendez facilement votre point de vue et vos croyances.',
          '10': 'Une conversation persuasive avec votre patron qui mène au succès. Vos idées sont rapidement mises en œuvre.',
          '11': 'Vous pouvez devenir le leader intellectuel d\'un groupe d\'amis, organisant facilement tout le monde.',
          '12': 'Vous comprenez rapidement et précisément vos motivations cachées. L\'intuition et la logique fonctionnent en harmonie.'
        },
        'de': {
          '1': 'Sie sprechen und handeln mit Zuversicht. Ihre Worte sind überzeugend und von Willen getragen.',
          '2': 'Schnelle und kluge Entscheidungen in finanziellen Angelegenheiten. Es ist leicht, Ihre finanziellen Interessen zu verteidigen.',
          '3': 'Sie sind witzig und überzeugend in Auseinandersetzungen. Prüfungen und schwierige Verhandlungen fallen Ihnen leicht.',
          '4': 'Effektive Lösung von Haushaltsproblemen. Ein ehrliches und produktives Gespräch mit der Familie.',
          '5': 'Direktes, aber charmantes Flirten. Es ist leicht, Ihre Absichten auszudrücken und Gegenseitigkeit zu erreichen.',
          '6': 'Hohe Produktivität. Sie denken schnell und lösen Arbeitsaufgaben effizient.',
          '7': 'Ein offener und konstruktiver Dialog mit Ihrem Partner. Es ist leicht, sich auf gemeinsame Aktionen zu einigen.',
          '8': 'Die Fähigkeit, schnell zum Kern eines komplexen Problems vorzudringen und eine Lösung zu finden.',
          '9': 'Schnelles und effektives Lernen. Sie verteidigen leicht Ihren Standpunkt und Ihre Überzeugungen.',
          '10': 'Ein überzeugendes Gespräch mit Ihrem Chef, das zum Erfolg führt. Ihre Ideen werden schnell umgesetzt.',
          '11': 'Sie können zum intellektuellen Anführer in einer Gruppe von Freunden werden und alle leicht organisieren.',
          '12': 'Sie verstehen schnell und genau Ihre verborgenen Motive. Intuition und Logik arbeiten harmonisch zusammen.'
        }
      }
    ),
    AspectInterpretation(
      id: 'MOON_OPPOSITION_SATURN',
      title: {
        'ru': 'Противостояние Луны и Сатурна',
        'en': 'Moon Opposition Saturn',
        'fr': 'Lune Opposition Saturne',
        'de': 'Mond-Opposition-Saturn'
      },
      descriptionGeneral: {
        'ru': 'Тяжелый эмоциональный день. Ваши потребности в заботе (Луна) сталкиваются с холодностью или критикой со стороны других (Сатурн). Ощущение одиночества, подавленности, непонимания.',
        'en': 'A difficult emotional day. Your needs for care (Moon) clash with coldness or criticism from others (Saturn). A feeling of loneliness, depression, and misunderstanding.',
        'fr': 'Une journée émotionnellement difficile. Vos besoins de soins (Lune) se heurtent à la froideur ou à la critique des autres (Saturne). Un sentiment de solitude, de dépression et d\'incompréhension.',
        'de': 'Ein emotional schwieriger Tag. Ihre Bedürfnisse nach Fürsorge (Mond) kollidieren mit Kälte oder Kritik von anderen (Saturn). Ein Gefühl von Einsamkeit, Depression und Missverständnis.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Вы чувствуете себя изолированным и подавленным. Другие люди могут казаться вам слишком строгими и критичными.',
          '2': 'Финансовые заботы вызывают сильное уныние. Кажется, что ваши усилия никто не ценит.',
          '3': 'Трудный и холодный разговор. Вы не находите эмоциональной поддержки у собеседника.',
          '4': 'Давящая атмосфера в доме. Конфликт с матерью или другим членом семьи, который вас критикует.',
          '5': 'Охлаждение в романтических отношениях. Партнер может быть отстраненным и не проявлять чувств.',
          '6': 'Давление обязанностей на работе. Критика со стороны коллег или начальства.',
          '7': 'Партнер выступает в роли критика или ограничителя. Вы чувствуете себя одиноким в отношениях.',
          '8': 'Финансовые обязательства или страхи мешают эмоциональной близости.',
          '9': 'Ваши планы и мечты сталкиваются с суровой реальностью. Пессимистичный взгляд на будущее.',
          '10': 'Конфликт с начальством (особенно женщиной). Карьерные обязанности кажутся непосильной ношей.',
          '11': 'Вы не чувствуете поддержки от друзей. Ощущение, что вас отталкивают или не понимают.',
          '12': 'Обострение старых страхов одиночества. Вы можете закрыться от мира, чувствуя себя непонятым.'
        },
        'en': {
          '1': 'You feel isolated and depressed. Other people may seem too strict and critical to you.',
          '2': 'Financial worries cause deep despondency. It seems that no one appreciates your efforts.',
          '3': 'A difficult and cold conversation. You find no emotional support from the other person.',
          '4': 'An oppressive atmosphere at home. A conflict with your mother or another family member who criticizes you.',
          '5': 'A cooling in romantic relationships. Your partner may be distant and show no feelings.',
          '6': 'The pressure of duties at work. Criticism from colleagues or superiors.',
          '7': 'Your partner acts as a critic or limiter. You feel lonely in the relationship.',
          '8': 'Financial obligations or fears hinder emotional intimacy.',
          '9': 'Your plans and dreams clash with harsh reality. A pessimistic view of the future.',
          '10': 'A conflict with your boss (especially a woman). Career duties seem an unbearable burden.',
          '11': 'You don\'t feel supported by your friends. A feeling of being pushed away or misunderstood.',
          '12': 'Old fears of loneliness are exacerbated. You might shut yourself off from the world, feeling misunderstood.'
        },
        'fr': {
          '1': 'Vous vous sentez isolé et déprimé. Les autres peuvent vous paraître trop stricts et critiques.',
          '2': 'Les soucis financiers provoquent un profond découragement. Il semble que personne n\'apprécie vos efforts.',
          '3': 'Une conversation difficile et froide. Vous ne trouvez aucun soutien émotionnel de la part de l\'autre personne.',
          '4': 'Une atmosphère oppressante à la maison. Un conflit avec votre mère ou un autre membre de la famille qui vous critique.',
          '5': 'Un refroidissement dans les relations amoureuses. Votre partenaire peut être distant et ne montrer aucun sentiment.',
          '6': 'La pression des obligations au travail. Critiques de la part des collègues ou des supérieurs.',
          '7': 'Votre partenaire agit comme un critique ou un limiteur. Vous vous sentez seul dans la relation.',
          '8': 'Les obligations financières ou les peurs entravent l\'intimité émotionnelle.',
          '9': 'Vos projets et vos rêves se heurtent à la dure réalité. Une vision pessimiste de l\'avenir.',
          '10': 'Un conflit avec votre patron (surtout une femme). Les obligations professionnelles semblent un fardeau insupportable.',
          '11': 'Vous ne vous sentez pas soutenu par vos amis. Le sentiment d\'être repoussé ou incompris.',
          '12': 'Les vieilles peurs de la solitude sont exacerbées. Vous pourriez vous couper du monde, vous sentant incompris.'
        },
        'de': {
          '1': 'Sie fühlen sich isoliert und deprimiert. Andere Menschen mögen Ihnen zu streng und kritisch erscheinen.',
          '2': 'Finanzielle Sorgen verursachen tiefe Mutlosigkeit. Es scheint, als ob niemand Ihre Bemühungen zu schätzen weiß.',
          '3': 'Ein schwieriges und kaltes Gespräch. Sie finden keine emotionale Unterstützung von der anderen Person.',
          '4': 'Eine bedrückende Atmosphäre zu Hause. Ein Konflikt mit Ihrer Mutter oder einem anderen Familienmitglied, das Sie kritisiert.',
          '5': 'Eine Abkühlung in romantischen Beziehungen. Ihr Partner ist möglicherweise distanziert und zeigt keine Gefühle.',
          '6': 'Der Druck der Pflichten bei der Arbeit. Kritik von Kollegen oder Vorgesetzten.',
          '7': 'Ihr Partner fungiert als Kritiker oder Begrenzer. Sie fühlen sich in der Beziehung einsam.',
          '8': 'Finanzielle Verpflichtungen oder Ängste behindern die emotionale Intimität.',
          '9': 'Ihre Pläne und Träume kollidieren mit der harten Realität. Eine pessimistische Sicht auf die Zukunft.',
          '10': 'Ein Konflikt mit Ihrem Chef (besonders einer Frau). Berufliche Pflichten scheinen eine unerträgliche Last zu sein.',
          '11': 'Sie fühlen sich von Ihren Freunden nicht unterstützt. Ein Gefühl, weggestoßen oder missverstanden zu werden.',
          '12': 'Alte Ängste vor Einsamkeit werden verschärft. Sie könnten sich von der Welt abschotten und sich missverstanden fühlen.'
        }
      }
    ),
    AspectInterpretation(
      id: 'VENUS_SEXTILE_URANUS',
      title: {
        'ru': 'Шанс от Венеры и Урана',
        'en': 'Venus Sextile Uranus',
        'fr': 'Vénus Sextile Uranus',
        'de': 'Venus-Sextil-Uranus'
      },
      descriptionGeneral: {
        'ru': 'День спонтанных радостей и приятных неожиданностей. Появляется возможность освежить отношения, познакомиться с кем-то необычным или получить внезапный финансовый бонус.',
        'en': 'A day of spontaneous joys and pleasant surprises. An opportunity arises to refresh a relationship, meet someone unusual, or receive a sudden financial bonus.',
        'fr': 'Une journée de joies spontanées et d\'agréables surprises. Une opportunité se présente de rafraîchir une relation, de rencontrer quelqu\'un d\'inhabituel ou de recevoir un bonus financier soudain.',
        'de': 'Ein Tag spontaner Freuden und angenehmer Überraschungen. Es ergibt sich die Möglichkeit, eine Beziehung aufzufrischen, jemanden Ungewöhnlichen kennenzulernen oder einen plötzlichen finanziellen Bonus zu erhalten.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Возможность удачно поэкспериментировать с имиджем. Ваша оригинальность привлекает внимание.',
          '2': 'Шанс на неожиданный доход, возможно через интернет или друзей.',
          '3': 'Неожиданное и приятное знакомство или новость. Спонтанная короткая поездка.',
          '4': 'Приятные сюрпризы дома. Внезапные, но желанные гости.',
          '5': 'Возможность для волнующего и необычного свидания. Внезапный флирт.',
          '6': 'Приятные неожиданности на работе, которые нарушают рутину в хорошем смысле.',
          '7': 'Партнер может предложить что-то новое и интересное. Шанс познакомиться с кем-то оригинальным.',
          '8': 'Возможность получить неожиданную финансовую поддержку от партнера.',
          '9': 'Внезапно может подвернуться отличная возможность для путешествия.',
          '10': 'Шанс проявить свою креативность и получить за это признание в карьере.',
          '11': 'Спонтанная и веселая встреча с друзьями. Новые знакомства в компании.',
          '12': 'Неожиданное озарение, касающееся ваших чувств. Тайный поклонник может дать о себе знать.'
        },
        'en': {
          '1': 'An opportunity to successfully experiment with your image. Your originality attracts attention.',
          '2': 'A chance for unexpected income, possibly through the internet or friends.',
          '3': 'An unexpected and pleasant acquaintance or news. A spontaneous short trip.',
          '4': 'Pleasant surprises at home. Sudden but welcome guests.',
          '5': 'An opportunity for an exciting and unusual date. A sudden flirtation.',
          '6': 'Pleasant surprises at work that break the routine in a good way.',
          '7': 'A partner might suggest something new and interesting. A chance to meet someone original.',
          '8': 'An opportunity to receive unexpected financial support from a partner.',
          '9': 'An excellent opportunity for a trip might suddenly arise.',
          '10': 'A chance to show your creativity and receive recognition for it in your career.',
          '11': 'A spontaneous and fun meeting with friends. New acquaintances in the group.',
          '12': 'An unexpected insight concerning your feelings. A secret admirer might make themselves known.'
        },
        'fr': {
          '1': 'Une occasion d\'expérimenter avec succès votre image. Votre originalité attire l\'attention.',
          '2': 'Une chance de revenus inattendus, peut-être via Internet ou des amis.',
          '3': 'Une connaissance ou une nouvelle inattendue et agréable. Un court voyage spontané.',
          '4': 'Agréables surprises à la maison. Invités soudains mais bienvenus.',
          '5': 'Une opportunité pour un rendez-vous excitant et inhabituel. Un flirt soudain.',
          '6': 'Agréables surprises au travail qui brisent la routine de manière positive.',
          '7': 'Un partenaire pourrait suggérer quelque chose de nouveau et d\'intéressant. Une chance de rencontrer quelqu\'un d\'original.',
          '8': 'Une opportunité de recevoir un soutien financier inattendu de la part d\'un partenaire.',
          '9': 'Une excellente opportunité de voyage pourrait se présenter soudainement.',
          '10': 'Une chance de montrer votre créativité et d\'en être reconnu dans votre carrière.',
          '11': 'Une rencontre spontanée et amusante avec des amis. Nouvelles connaissances dans le groupe.',
          '12': 'Une prise de conscience inattendue concernant vos sentiments. Un admirateur secret pourrait se faire connaître.'
        },
        'de': {
          '1': 'Eine Gelegenheit, erfolgreich mit Ihrem Image zu experimentieren. Ihre Originalität zieht Aufmerksamkeit auf sich.',
          '2': 'Eine Chance auf unerwartetes Einkommen, möglicherweise über das Internet oder Freunde.',
          '3': 'Eine unerwartete und angenehme Bekanntschaft oder Nachricht. Eine spontane Kurzreise.',
          '4': 'Angenehme Überraschungen zu Hause. Plötzliche, aber willkommene Gäste.',
          '5': 'Eine Gelegenheit für ein aufregendes und ungewöhnliches Date. Ein plötzlicher Flirt.',
          '6': 'Angenehme Überraschungen bei der Arbeit, die die Routine auf gute Weise durchbrechen.',
          '7': 'Ein Partner könnte etwas Neues und Interessantes vorschlagen. Eine Chance, jemanden Originelles kennenzulernen.',
          '8': 'Eine Gelegenheit, unerwartete finanzielle Unterstützung von einem Partner zu erhalten.',
          '9': 'Eine ausgezeichnete Reisemöglichkeit könnte sich plötzlich ergeben.',
          '10': 'Eine Chance, Ihre Kreativität zu zeigen und dafür in Ihrer Karriere Anerkennung zu erhalten.',
          '11': 'Ein spontanes und lustiges Treffen mit Freunden. Neue Bekanntschaften in der Gruppe.',
          '12': 'Eine unerwartete Einsicht bezüglich Ihrer Gefühle. Ein heimlicher Verehrer könnte sich bemerkbar machen.'
        }
      }
    ),
    AspectInterpretation(
      id: 'MARS_CONJUNCTION_PLUTO',
      title: {
        'ru': 'Соединение Марса и Плутона',
        'en': 'Mars Conjunct Pluto',
        'fr': 'Mars Conjoint Pluton',
        'de': 'Mars-Konjunktion-Pluto'
      },
      descriptionGeneral: {
        'ru': 'День невероятной концентрации воли и энергии. Ваши действия (Марс) обладают огромной силой (Плутон). Можно свернуть горы, но есть риск одержимости, безжалостности и разрушительных поступков.',
        'en': 'A day of incredible concentration of will and energy. Your actions (Mars) possess immense power (Pluto). You can move mountains, but there is a risk of obsession, ruthlessness, and destructive actions.',
        'fr': 'Une journée d\'incroyable concentration de volonté et d\'énergie. Vos actions (Mars) possèdent une puissance immense (Pluton). Vous pouvez déplacer des montagnes, mais il y a un risque d\'obsession, de cruauté et d\'actions destructrices.',
        'de': 'Ein Tag unglaublicher Konzentration von Willen und Energie. Ihre Handlungen (Mars) besitzen immense Kraft (Pluto). Sie können Berge versetzen, aber es besteht die Gefahr von Besessenheit, Rücksichtslosigkeit und zerstörerischen Handlungen.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Вы чувствуете в себе огромную силу и решимость. Важно направить эту энергию в конструктивное русло, а не на давление.',
          '2': 'Одержимость заработком или контролем над финансами. Готовность пойти на все ради достижения цели.',
          '3': 'Ваши слова обладают огромной силой убеждения. Но есть риск "продавить" собеседника.',
          '4': 'Желание провести кардинальные перемены в доме. Борьба за власть в семье.',
          '5': 'Всепоглощающая страсть в любви. Отношения становятся очень интенсивными.',
          '6': 'Фанатичная работоспособность. Вы можете "пробить" любой проект, но рискуете выгореть.',
          '7': 'Попытка полностью подчинить партнера своей воле или трансформировать отношения.',
          '8': 'Колоссальная сексуальная энергия. Мощная трансформация через кризис или глубокие переживания.',
          '9': 'Фанатичное стремление доказать свою правоту и навязать свои убеждения.',
          '10': 'Беспощадная борьба за власть и высокий статус в карьере. Вы не остановитесь ни перед чем.',
          '11': 'Вы можете стать абсолютным лидером в группе, подчинив всех своей воле.',
          '12': 'Мощная работа с подсознанием. Вы можете либо победить своих "демонов", либо поддаться им.'
        },
        'en': {
          '1': 'You feel immense strength and determination within you. It\'s important to direct this energy constructively, not towards pressure.',
          '2': 'An obsession with earning or controlling finances. A willingness to do anything to achieve a goal.',
          '3': 'Your words have immense persuasive power. But there is a risk of "steamrolling" the other person.',
          '4': 'A desire for radical changes at home. A power struggle within the family.',
          '5': 'All-consuming passion in love. Relationships become very intense.',
          '6': 'Fanatical work ethic. You can "push through" any project, but you risk burning out.',
          '7': 'An attempt to completely subordinate your partner to your will or transform the relationship.',
          '8': 'Colossal sexual energy. A powerful transformation through crisis or deep experiences.',
          '9': 'A fanatical desire to prove you are right and impose your beliefs.',
          '10': 'A ruthless struggle for power and high status in your career. You will stop at nothing.',
          '11': 'You can become the absolute leader in a group, subordinating everyone to your will.',
          '12': 'Powerful work with the subconscious. You can either conquer your "demons" or succumb to them.'
        },
        'fr': {
          '1': 'Vous sentez une force et une détermination immenses en vous. Il est important de diriger cette énergie de manière constructive, et non vers la pression.',
          '2': 'Une obsession de gagner de l\'argent ou de contrôler les finances. Une volonté de tout faire pour atteindre un objectif.',
          '3': 'Vos paroles ont un immense pouvoir de persuasion. Mais il y a un risque d\'"écraser" l\'autre personne.',
          '4': 'Un désir de changements radicaux à la maison. Une lutte de pouvoir au sein de la famille.',
          '5': 'Passion dévorante en amour. Les relations deviennent très intenses.',
          '6': 'Éthique de travail fanatique. Vous pouvez "faire passer" n\'importe quel projet, mais vous risquez l\'épuisement professionnel.',
          '7': 'Une tentative de subordonner complètement votre partenaire à votre volonté ou de transformer la relation.',
          '8': 'Énergie sexuelle colossale. Une transformation puissante par la crise ou des expériences profondes.',
          '9': 'Un désir fanatique de prouver que vous avez raison et d\'imposer vos croyances.',
          '10': 'Une lutte impitoyable pour le pouvoir et un statut élevé dans votre carrière. Vous ne reculerez devant rien.',
          '11': 'Vous pouvez devenir le leader absolu d\'un groupe, soumettant tout le monde à votre volonté.',
          '12': 'Travail puissant avec le subconscient. Vous pouvez soit vaincre vos "démons", soit y succomber.'
        },
        'de': {
          '1': 'Sie spüren immense Stärke und Entschlossenheit in sich. Es ist wichtig, diese Energie konstruktiv zu lenken, nicht auf Druck.',
          '2': 'Eine Besessenheit vom Verdienen oder Kontrollieren der Finanzen. Die Bereitschaft, alles zu tun, um ein Ziel zu erreichen.',
          '3': 'Ihre Worte haben immense Überzeugungskraft. Aber es besteht die Gefahr, die andere Person zu "überrollen".',
          '4': 'Ein Wunsch nach radikalen Veränderungen zu Hause. Ein Machtkampf innerhalb der Familie.',
          '5': 'Alles verzehrende Leidenschaft in der Liebe. Beziehungen werden sehr intensiv.',
          '6': 'Fanatische Arbeitsmoral. Sie können jedes Projekt "durchboxen", aber Sie riskieren ein Burnout.',
          '7': 'Ein Versuch, Ihren Partner vollständig Ihrem Willen zu unterwerfen oder die Beziehung zu transformieren.',
          '8': 'Kolossale sexuelle Energie. Eine kraftvolle Transformation durch Krisen oder tiefe Erfahrungen.',
          '9': 'Ein fanatischer Wunsch, Recht zu haben und seine Überzeugungen durchzusetzen.',
          '10': 'Ein rücksichtsloser Kampf um Macht und hohen Status in Ihrer Karriere. Sie werden vor nichts zurückschrecken.',
          '11': 'Sie können zum absoluten Anführer in einer Gruppe werden und alle Ihrem Willen unterwerfen.',
          '12': 'Kraftvolle Arbeit mit dem Unterbewusstsein. Sie können entweder Ihre "Dämonen" besiegen oder ihnen erliegen.'
        }
      }
    ),
            // === НОВЫЙ БЛОК 16 ===
    AspectInterpretation(
      id: 'JUPITER_SQUARE_PLUTO',
      title: {
        'ru': 'Конфликт Юпитера и Плутона',
        'en': 'Jupiter Square Pluto',
        'fr': 'Jupiter Carré Pluton',
        'de': 'Jupiter-Quadrat-Pluto'
      },
      descriptionGeneral: {
        'ru': 'День борьбы за власть и влияние. Ваши амбиции (Юпитер) сталкиваются с мощными силами и желанием тотального контроля (Плутон). Риск злоупотребления властью, фанатизма и финансовых авантюр.',
        'en': 'A day of struggle for power and influence. Your ambitions (Jupiter) clash with powerful forces and a desire for total control (Pluto). Risk of power abuse, fanaticism, and financial gambles.',
        'fr': 'Une journée de lutte pour le pouvoir et l\'influence. Vos ambitions (Jupiter) se heurtent à des forces puissantes et à un désir de contrôle total (Pluton). Risque d\'abus de pouvoir, de fanatisme et de paris financiers.',
        'de': 'Ein Tag des Kampfes um Macht und Einfluss. Ihre Ambitionen (Jupiter) kollidieren mit mächtigen Kräften und dem Wunsch nach totaler Kontrolle (Pluto). Risiko von Machtmissbrauch, Fanatismus und finanziellen Wagnissen.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Ваше желание расширить свое влияние может привести к серьезным конфликтам. Остерегайтесь высокомерия.',
          '2': 'Одержимость большими деньгами. Риск ввязаться в сомнительные финансовые схемы ради огромной прибыли.',
          '3': 'Вы пытаетесь навязать свою точку зрения любой ценой. Идеологические споры, которые перерастают во вражду.',
          '4': 'Борьба за власть в семье. Конфликты из-за недвижимости или наследства.',
          '5': 'В любви вы можете быть слишком властным. Риск крупных потерь в азартных играх.',
          '6': 'Конфликт с коллегами или начальством из-за желания перестроить все по-своему.',
          '7': 'Жесткая борьба с партнером или конкурентом. Юридические баталии.',
          '8': 'Конфликты из-за крупных сумм, кредитов, налогов. Борьба за контроль над общими ресурсами.',
          '9': 'Фанатичное отстаивание своих убеждений. Вы готовы "уничтожить" оппонента в споре.',
          '10': 'Серьезный конфликт с властными структурами. Ваши карьерные амбиции сталкиваются с мощным сопротивлением.',
          '11': 'Идеологические конфликты с друзьями. Попытки навязать свое лидерство в группе.',
          '12': 'Ваши тайные амбиции могут привести к саморазрушению. Борьба с могущественными скрытыми врагами.'
        },
        'en': {
          '1': 'Your desire to expand your influence can lead to serious conflicts. Beware of arrogance.',
          '2': 'An obsession with big money. Risk of getting involved in dubious financial schemes for huge profits.',
          '3': 'You try to impose your point of view at any cost. Ideological disputes that escalate into hostility.',
          '4': 'A power struggle in the family. Conflicts over real estate or inheritance.',
          '5': 'In love, you can be too domineering. Risk of large losses in gambling.',
          '6': 'A conflict with colleagues or superiors due to a desire to reorganize everything your way.',
          '7': 'A fierce struggle with a partner or competitor. Legal battles.',
          '8': 'Conflicts over large sums, loans, taxes. A struggle for control over shared resources.',
          '9': 'A fanatical defense of your beliefs. You are ready to "destroy" an opponent in an argument.',
          '10': 'A serious conflict with authority structures. Your career ambitions face powerful resistance.',
          '11': 'Ideological conflicts with friends. Attempts to impose your leadership on the group.',
          '12': 'Your secret ambitions can lead to self-destruction. A struggle with powerful hidden enemies.'
        },
        'fr': {
          '1': 'Votre désir d\'étendre votre influence peut entraîner de graves conflits. Méfiez-vous de l\'arrogance.',
          '2': 'Une obsession pour l\'argent. Risque de s\'impliquer dans des montages financiers douteux pour des profits énormes.',
          '3': 'Vous essayez d\'imposer votre point de vue à tout prix. Des disputes idéologiques qui dégénèrent en hostilité.',
          '4': 'Une lutte de pouvoir dans la famille. Conflits immobiliers ou successoraux.',
          '5': 'En amour, vous pouvez être trop autoritaire. Risque de grosses pertes au jeu.',
          '6': 'Un conflit avec des collègues ou des supérieurs en raison d\'un désir de tout réorganiser à votre façon.',
          '7': 'Une lutte acharnée avec un partenaire ou un concurrent. Batailles juridiques.',
          '8': 'Conflits sur de grosses sommes, des prêts, des impôts. Une lutte pour le contrôle des ressources partagées.',
          '9': 'Une défense fanatique de vos croyances. Vous êtes prêt à "détruire" un adversaire dans une dispute.',
          '10': 'Un conflit sérieux avec les structures d\'autorité. Vos ambitions de carrière se heurtent à une forte résistance.',
          '11': 'Conflits idéologiques avec des amis. Tentatives d\'imposer votre leadership au groupe.',
          '12': 'Vos ambitions secrètes peuvent conduire à l\'autodestruction. Une lutte contre de puissants ennemis cachés.'
        },
        'de': {
          '1': 'Ihr Wunsch, Ihren Einfluss zu erweitern, kann zu ernsthaften Konflikten führen. Hüten Sie sich vor Arroganz.',
          '2': 'Eine Besessenheit von großem Geld. Das Risiko, sich für riesige Gewinne in dubiose Finanzsysteme zu verwickeln.',
          '3': 'Sie versuchen, Ihren Standpunkt um jeden Preis durchzusetzen. Ideologische Auseinandersetzungen, die in Feindseligkeit ausarten.',
          '4': 'Ein Machtkampf in der Familie. Konflikte um Immobilien oder Erbschaften.',
          '5': 'In der Liebe können Sie zu herrschsüchtig sein. Risiko großer Verluste beim Glücksspiel.',
          '6': 'Ein Konflikt mit Kollegen oder Vorgesetzten aufgrund des Wunsches, alles auf Ihre Weise neu zu organisieren.',
          '7': 'Ein heftiger Kampf mit einem Partner oder Konkurrenten. Rechtsstreitigkeiten.',
          '8': 'Konflikte um große Summen, Kredite, Steuern. Ein Kampf um die Kontrolle über gemeinsame Ressourcen.',
          '9': 'Eine fanatische Verteidigung Ihrer Überzeugungen. Sie sind bereit, einen Gegner in einem Streit zu "zerstören".',
          '10': 'Ein ernster Konflikt mit Autoritätsstrukturen. Ihre Karriereambitionen stoßen auf starken Widerstand.',
          '11': 'Ideologische Konflikte mit Freunden. Versuche, der Gruppe Ihre Führung aufzuzwingen.',
          '12': 'Ihre geheimen Ambitionen können zur Selbstzerstörung führen. Ein Kampf mit mächtigen verborgenen Feinden.'
        }
      }
    ),
    AspectInterpretation(
      id: 'VENUS_CONJUNCTION_SATURN',
      title: {
        'ru': 'Соединение Венеры и Сатурна',
        'en': 'Venus Conjunct Saturn',
        'fr': 'Vénus Conjointe Saturne',
        'de': 'Venus-Konjunktion-Saturn'
      },
      descriptionGeneral: {
        'ru': 'День "проверки реальностью" в любви и финансах. Чувства становятся серьезными, на первый план выходят долг и ответственность. Возможно ощущение холодности, но это хорошее время для принятия серьезных решений.',
        'en': 'A day of a "reality check" in love and finances. Feelings become serious, with duty and responsibility coming to the forefront. A sense of coldness is possible, but it is a good time for making serious decisions.',
        'fr': 'Une journée de "test de réalité" en amour et en finances. Les sentiments deviennent sérieux, le devoir et la responsabilité passant au premier plan. Un sentiment de froideur est possible, mais c\'est un bon moment pour prendre des décisions sérieuses.',
        'de': 'Ein Tag des "Realitätschecks" in Liebe und Finanzen. Gefühle werden ernst, Pflicht und Verantwortung treten in den Vordergrund. Ein Gefühl der Kälte ist möglich, aber es ist eine gute Zeit, um ernste Entscheidungen zu treffen.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Вы кажетесь серьезным и сдержанным. Не лучшее время для флирта, но хорошее для демонстрации своей надежности.',
          '2': 'Серьезный и трезвый подход к финансам. Приходится экономить, но это закладывает основу для будущей стабильности.',
          '3': 'Трудный, но важный разговор об отношениях. Сложно выразить теплые чувства, но легко говорить об обязательствах.',
          '4': 'Чувство долга перед семьей. Атмосфера в доме может быть прохладной, но стабильной.',
          '5': 'Время для серьезного шага в отношениях (предложение, знакомство с родителями). Любовь без "розовых очков".',
          '6': 'Формальные, но стабильные отношения с коллегами. Работа не приносит радости, но выполняется ответственно.',
          '7': 'Ключевой момент в партнерстве. Время для официального оформления отношений или принятия серьезных обязательств.',
          '8': 'Реалистичный взгляд на совместные финансы. Возможно охлаждение в интимной сфере из-за забот.',
          '9': 'Отношения с человеком старше или из другой страны проходят проверку на прочность.',
          '10': 'Карьера требует жертв в личной жизни. Серьезные деловые партнерства.',
          '11': 'Отношения с друзьями становятся более прохладными, но и более ответственными.',
          '12': 'Вы сталкиваетесь со своими страхами одиночества, что помогает повзрослеть в отношениях.'
        },
        'en': {
          '1': 'You seem serious and reserved. Not the best time for flirting, but good for demonstrating your reliability.',
          '2': 'A serious and sober approach to finances. You have to save money, but this lays the foundation for future stability.',
          '3': 'A difficult but important conversation about the relationship. It\'s hard to express warm feelings, but easy to talk about commitments.',
          '4': 'A sense of duty to the family. The atmosphere at home may be cool but stable.',
          '5': 'Time for a serious step in a relationship (proposal, meeting the parents). Love without "rose-colored glasses."',
          '6': 'Formal but stable relationships with colleagues. Work brings no joy but is done responsibly.',
          '7': 'A key moment in a partnership. Time to formalize the relationship or make serious commitments.',
          '8': 'A realistic view of joint finances. A cooling in the intimate sphere is possible due to worries.',
          '9': 'A relationship with an older person or someone from another country is being tested.',
          '10': 'A career requires sacrifices in personal life. Serious business partnerships.',
          '11': 'Relationships with friends become cooler but also more responsible.',
          '12': 'You face your fears of loneliness, which helps you mature in relationships.'
        },
        'fr': {
          '1': 'Vous semblez sérieux et réservé. Ce n\'est pas le meilleur moment pour flirter, mais c\'est bien pour démontrer votre fiabilité.',
          '2': 'Une approche sérieuse et sobre des finances. Vous devez économiser, mais cela jette les bases d\'une stabilité future.',
          '3': 'Une conversation difficile mais importante sur la relation. Difficile d\'exprimer des sentiments chaleureux, mais facile de parler d\'engagements.',
          '4': 'Un sens du devoir envers la famille. L\'atmosphère à la maison peut être fraîche mais stable.',
          '5': 'Il est temps de faire un pas sérieux dans une relation (demande en mariage, rencontre des parents). L\'amour sans "lunettes roses".',
          '6': 'Relations formelles mais stables avec les collègues. Le travail n\'apporte aucune joie mais est fait de manière responsable.',
          '7': 'Un moment clé dans un partenariat. Il est temps d\'officialiser la relation ou de prendre des engagements sérieux.',
          '8': 'Une vision réaliste des finances communes. Un refroidissement dans la sphère intime est possible en raison des soucis.',
          '9': 'Une relation avec une personne plus âgée ou d\'un autre pays est mise à l\'épreuve.',
          '10': 'Une carrière exige des sacrifices dans la vie personnelle. Des partenariats commerciaux sérieux.',
          '11': 'Les relations avec les amis deviennent plus froides mais aussi plus responsables.',
          '12': 'Vous affrontez vos peurs de la solitude, ce qui vous aide à mûrir dans les relations.'
        },
        'de': {
          '1': 'Sie wirken ernst und zurückhaltend. Nicht die beste Zeit zum Flirten, aber gut, um Ihre Zuverlässigkeit zu demonstrieren.',
          '2': 'Ein ernster und nüchterner Umgang mit Finanzen. Sie müssen sparen, aber das legt den Grundstein für zukünftige Stabilität.',
          '3': 'Ein schwieriges, aber wichtiges Gespräch über die Beziehung. Es ist schwer, warme Gefühle auszudrücken, aber leicht, über Verpflichtungen zu sprechen.',
          '4': 'Ein Pflichtgefühl gegenüber der Familie. die Atmosphäre zu Hause mag kühl, aber stabil sein.',
          '5': 'Zeit für einen ernsthaften Schritt in einer Beziehung (Antrag, Treffen mit den Eltern). Liebe ohne "rosarote Brille".',
          '6': 'Formelle, aber stabile Beziehungen zu Kollegen. Die Arbeit macht keine Freude, wird aber verantwortungsbewusst erledigt.',
          '7': 'Ein entscheidender Moment in einer Partnerschaft. Zeit, die Beziehung zu formalisieren oder ernsthafte Verpflichtungen einzugehen.',
          '8': 'Eine realistische Sicht auf gemeinsame Finanzen. Eine Abkühlung im intimen Bereich ist aufgrund von Sorgen möglich.',
          '9': 'Eine Beziehung zu einer älteren Person oder jemandem aus einem anderen Land wird auf die Probe gestellt.',
          '10': 'Eine Karriere erfordert Opfer im Privatleben. Ernsthafte Geschäftspartnerschaften.',
          '11': 'Beziehungen zu Freunden werden kühler, aber auch verantwortungsbewusster.',
          '12': 'Sie stellen sich Ihren Ängsten vor Einsamkeit, was Ihnen hilft, in Beziehungen zu reifen.'
        }
      }
    ),
    AspectInterpretation(
      id: 'MOON_OPPOSITION_URANUS',
      title: {
        'ru': 'Противостояние Луны и Урана',
        'en': 'Moon Opposition Uranus',
        'fr': 'Lune Opposition Uranus',
        'de': 'Mond-Opposition-Uranus'
      },
      descriptionGeneral: {
        'ru': 'День эмоциональных потрясений и срыва планов. Неожиданные события или непредсказуемое поведение других людей (особенно женщин) нарушают ваш покой. Сильная потребность в свободе.',
        'en': 'A day of emotional shocks and disrupted plans. Unexpected events or the unpredictable behavior of others (especially women) disturb your peace. A strong need for freedom.',
        'fr': 'Une journée de chocs émotionnels et de plans perturbés. Des événements inattendus ou le comportement imprévisible des autres (en particulier des femmes) troublent votre paix. Un fort besoin de liberté.',
        'de': 'Ein Tag emotionaler Schocks und gestörter Pläne. Unerwartete Ereignisse oder das unvorhersehbare Verhalten anderer (insbesondere Frauen) stören Ihren Frieden. Ein starkes Bedürfnis nach Freiheit.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Ваше эмоциональное состояние крайне нестабильно из-за действий других людей. Вы можете повести себя шокирующе.',
          '2': 'Внезапные финансовые события (чаще потери) нарушают ваше чувство безопасности.',
          '3': 'Шокирующие новости. Ссора с родственником или соседом, который ведет себя неадекватно.',
          '4': 'Полный хаос дома. Неожиданные события в семье (например, внезапный приезд гостя) рушат все планы.',
          '5': 'Партнер требует свободы, что приводит к эмоциональному разрыву. Внезапные ссоры.',
          '6': 'Неожиданные события на работе полностью меняют ваш распорядок дня. Конфликт с коллегой.',
          '7': 'Партнер ведет себя непредсказуемо, что ставит отношения под угрозу. Возможен внезапный разрыв.',
          '8': 'Внезапный эмоциональный или финансовый кризис, спровоцированный другими людьми.',
          '9': 'Ваши планы на поездку или учебу внезапно срываются.',
          '10': 'Неожиданные события, которые вредят вашей репутации. Конфликт с начальницей.',
          '11': 'Внезапный разрыв с другом или всей компанией из-за их непредсказуемого поведения.',
          '12': 'Внезапная тревога, паническая атака. Вы можете стать жертвой неожиданных козней тайных врагов.'
        },
        'en': {
          '1': 'Your emotional state is extremely unstable due to the actions of others. You might behave shockingly.',
          '2': 'Sudden financial events (more often losses) disrupt your sense of security.',
          '3': 'Shocking news. A quarrel with a relative or neighbor who behaves inappropriately.',
          '4': 'Complete chaos at home. Unexpected family events (e.g., a sudden guest arrival) ruin all plans.',
          '5': 'A partner demands freedom, leading to an emotional breakup. Sudden quarrels.',
          '6': 'Unexpected events at work completely change your daily routine. A conflict with a colleague.',
          '7': 'A partner behaves unpredictably, which jeopardizes the relationship. A sudden breakup is possible.',
          '8': 'A sudden emotional or financial crisis provoked by other people.',
          '9': 'Your travel or study plans are suddenly disrupted.',
          '10': 'Unexpected events that harm your reputation. A conflict with a female boss.',
          '11': 'A sudden break with a friend or the entire group due to their unpredictable behavior.',
          '12': 'Sudden anxiety, a panic attack. You might fall victim to the unexpected machinations of secret enemies.'
        },
        'fr': {
          '1': 'Votre état émotionnel est extrêmement instable en raison des actions des autres. Vous pourriez vous comporter de manière choquante.',
          '2': 'Des événements financiers soudains (le plus souvent des pertes) perturbent votre sentiment de sécurité.',
          '3': 'Nouvelles choquantes. Une querelle avec un parent ou un voisin qui se comporte de manière inappropriée.',
          '4': 'Chaos complet à la maison. Des événements familiaux inattendus (par ex., l\'arrivée soudaine d\'un invité) ruinent tous les plans.',
          '5': 'Un partenaire demande la liberté, ce qui conduit à une rupture émotionnelle. Querelles soudaines.',
          '6': 'Des événements inattendus au travail changent complètement votre routine quotidienne. Un conflit avec un collègue.',
          '7': 'Un partenaire se comporte de manière imprévisible, ce qui met la relation en péril. Une rupture soudaine est possible.',
          '8': 'Une crise émotionnelle ou financière soudaine provoquée par d\'autres personnes.',
          '9': 'Vos projets de voyage ou d\'études sont soudainement perturbés.',
          '10': 'Des événements inattendus qui nuisent à votre réputation. Un conflit avec une patronne.',
          '11': 'Une rupture soudaine avec un ami ou tout le groupe en raison de leur comportement imprévisible.',
          '12': 'Anxiété soudaine, crise de panique. Vous pourriez être victime des machinations inattendues d\'ennemis secrets.'
        },
        'de': {
          '1': 'Ihr emotionaler Zustand ist aufgrund der Handlungen anderer extrem instabil. Sie könnten sich schockierend verhalten.',
          '2': 'Plötzliche finanzielle Ereignisse (häufiger Verluste) stören Ihr Sicherheitsgefühl.',
          '3': 'Schockierende Nachrichten. Ein Streit mit einem Verwandten oder Nachbarn, der sich unangemessen verhält.',
          '4': 'Vollständiges Chaos zu Hause. Unerwartete Familienereignisse (z. B. die plötzliche Ankunft eines Gastes) ruinieren alle Pläne.',
          '5': 'Ein Partner fordert Freiheit, was zu einer emotionalen Trennung führt. Plötzlicher Streit.',
          '6': 'Unerwartete Ereignisse bei der Arbeit verändern Ihren Tagesablauf komplett. Ein Konflikt mit einem Kollegen.',
          '7': 'Ein Partner verhält sich unvorhersehbar, was die Beziehung gefährdet. Eine plötzliche Trennung ist möglich.',
          '8': 'Eine plötzliche emotionale oder finanzielle Krise, die von anderen provoziert wird.',
          '9': 'Ihre Reise- oder Studienpläne werden plötzlich durchkreuzt.',
          '10': 'Unerwartete Ereignisse, die Ihrem Ruf schaden. Ein Konflikt mit einer Chefin.',
          '11': 'Ein plötzlicher Bruch mit einem Freund oder der ganzen Gruppe aufgrund ihres unvorhersehbaren Verhaltens.',
          '12': 'Plötzliche Angst, eine Panikattacke. Sie könnten Opfer der unerwarteten Machenschaften geheimer Feinde werden.'
        }
      }
    ),
    AspectInterpretation(
      id: 'MERCURY_TRINE_NEPTUNE',
      title: {
        'ru': 'Гармония Меркурия и Нептуна',
        'en': 'Mercury Trine Neptune',
        'fr': 'Mercure Trigone Neptune',
        'de': 'Merkur-Trigon-Neptun'
      },
      descriptionGeneral: {
        'ru': 'День вдохновенного мышления и интуитивного общения. Воображение (Нептун) и интеллект (Меркурий) в гармонии. Идеально для творчества, музыки, поэзии и душевных разговоров.',
        'en': 'A day of inspired thinking and intuitive communication. Imagination (Neptune) and intellect (Mercury) are in harmony. Ideal for creativity, music, poetry, and heartfelt conversations.',
        'fr': 'Une journée de pensée inspirée et de communication intuitive. L\'imagination (Neptune) et l\'intellect (Mercure) sont en harmonie. Idéal pour la créativité, la musique, la poésie et les conversations sincères.',
        'de': 'Ein Tag des inspirierten Denkens und der intuitiven Kommunikation. Vorstellungskraft (Neptun) und Intellekt (Merkur) sind in Harmonie. Ideal für Kreativität, Musik, Poesie und herzliche Gespräche.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Вы производите впечатление мечтательного и утонченного человека. Легко говорить о своих мечтах и чувствах.',
          '2': 'Интуиция подсказывает верные финансовые решения, особенно в творческих сферах.',
          '3': 'Ваша речь поэтична и вдохновляюща. Легко понимать других без слов.',
          '4': 'Создание одухотворенной и мирной атмосферы дома. Глубокое взаимопонимание с семьей.',
          '5': 'Очень романтичный и нежный разговор с любимым человеком. Идеально для признания в любви.',
          '6': 'Творческий подход к работе. Вы можете проявить сострадание и помочь коллегам.',
          '7': 'Глубокая духовная связь с партнером. Вы чувствуете его на расстоянии.',
          '8': 'Сильная интуиция, вещие сны. Глубокое понимание скрытых мотивов.',
          '9': 'Вдохновение от искусства, музыки, религии. Изучение эзотерических тем.',
          '10': 'Ваши творческие идеи и интуиция помогают в карьере. Успех в психологии, искусстве.',
          '11': 'Душевная встреча с друзьями-единомышленниками, которые разделяют ваши идеалы.',
          '12': 'Глубокое погружение в свой внутренний мир через медитацию или творчество. Яркие сны.'
        },
        'en': {
          '1': 'You give the impression of a dreamy and refined person. It\'s easy to talk about your dreams and feelings.',
          '2': 'Intuition suggests the right financial decisions, especially in creative fields.',
          '3': 'Your speech is poetic and inspiring. It\'s easy to understand others without words.',
          '4': 'Creating a spiritual and peaceful atmosphere at home. Deep mutual understanding with family.',
          '5': 'A very romantic and tender conversation with a loved one. Ideal for confessing your love.',
          '6': 'A creative approach to work. You can show compassion and help colleagues.',
          '7': 'A deep spiritual connection with your partner. You feel them from a distance.',
          '8': 'Strong intuition, prophetic dreams. A deep understanding of hidden motives.',
          '9': 'Inspiration from art, music, religion. Studying esoteric topics.',
          '10': 'Your creative ideas and intuition help in your career. Success in psychology, art.',
          '11': 'A soulful meeting with like-minded friends who share your ideals.',
          '12': 'A deep dive into your inner world through meditation or creativity. Vivid dreams.'
        },
        'fr': {
          '1': 'Vous donnez l\'impression d\'une personne rêveuse et raffinée. Il est facile de parler de vos rêves et de vos sentiments.',
          '2': 'L\'intuition suggère les bonnes décisions financières, surtout dans les domaines créatifs.',
          '3': 'Votre discours est poétique et inspirant. Il est facile de comprendre les autres sans mots.',
          '4': 'Créer une atmosphère spirituelle et paisible à la maison. Profonde compréhension mutuelle avec la famille.',
          '5': 'Une conversation très romantique et tendre avec un être cher. Idéal pour avouer son amour.',
          '6': 'Une approche créative du travail. Vous pouvez faire preuve de compassion et aider vos collègues.',
          '7': 'Un lien spirituel profond avec votre partenaire. Vous le sentez à distance.',
          '8': 'Forte intuition, rêves prophétiques. Une profonde compréhension des motivations cachées.',
          '9': 'Inspiration de l\'art, de la musique, de la religion. Étude de sujets ésotériques.',
          '10': 'Vos idées créatives et votre intuition aident dans votre carrière. Succès en psychologie, en art.',
          '11': 'Une rencontre émouvante avec des amis partageant les mêmes idées et vos idéaux.',
          '12': 'Une plongée profonde dans votre monde intérieur par la méditation ou la créativité. Rêves vifs.'
        },
        'de': {
          '1': 'Sie machen den Eindruck einer träumerischen und raffinierten Person. Es ist leicht, über Ihre Träume und Gefühle zu sprechen.',
          '2': 'Die Intuition schlägt die richtigen finanziellen Entscheidungen vor, besonders in kreativen Bereichen.',
          '3': 'Ihre Rede ist poetisch und inspirierend. Es ist leicht, andere ohne Worte zu verstehen.',
          '4': 'Schaffung einer spirituellen und friedlichen Atmosphäre zu Hause. Tiefes gegenseitiges Verständnis mit der Familie.',
          '5': 'Ein sehr romantisches und zärtliches Gespräch mit einem geliebten Menschen. Ideal, um Ihre Liebe zu gestehen.',
          '6': 'Ein kreativer Ansatz zur Arbeit. Sie können Mitgefühl zeigen und Kollegen helfen.',
          '7': 'Eine tiefe spirituelle Verbindung zu Ihrem Partner. Sie spüren ihn aus der Ferne.',
          '8': 'Starke Intuition, prophetische Träume. Ein tiefes Verständnis für verborgene Motive.',
          '9': 'Inspiration durch Kunst, Musik, Religion. Studium esoterischer Themen.',
          '10': 'Ihre kreativen Ideen und Ihre Intuition helfen in Ihrer Karriere. Erfolg in Psychologie, Kunst.',
          '11': 'Ein seelenvolles Treffen mit gleichgesinnten Freunden, die Ihre Ideale teilen.',
          '12': 'Ein tiefer Einblick in Ihre innere Welt durch Meditation oder Kreativität. Lebhafte Träume.'
        }
      }
    ),

            // === НОВЫЙ БЛОК 17 ===
    AspectInterpretation(
      id: 'MERCURY_CONJUNCTION_VENUS',
      title: {
        'ru': 'Соединение Меркурия и Венеры',
        'en': 'Mercury Conjunct Venus',
        'fr': 'Mercure Conjoint Vénus',
        'de': 'Merkur-Konjunktion-Venus'
      },
      descriptionGeneral: {
        'ru': 'День приятного, дипломатичного и обаятельного общения. Мысли и слова окрашены в тона красоты и гармонии. Отлично для свиданий, переговоров, покупок красивых вещей и выражения симпатии.',
        'en': 'A day of pleasant, diplomatic, and charming communication. Thoughts and words are colored with tones of beauty and harmony. Excellent for dates, negotiations, buying beautiful things, and expressing affection.',
        'fr': 'Une journée de communication agréable, diplomatique et charmante. Les pensées et les mots sont colorés de tons de beauté et d\'harmonie. Excellent pour les rendez-vous, les négociations, l\'achat de belles choses et l\'expression de l\'affection.',
        'de': 'Ein Tag angenehmer, diplomatischer und charmanter Kommunikation. Gedanken und Worte sind in Tönen von Schönheit und Harmonie gefärbt. Ausgezeichnet für Verabredungen, Verhandlungen, den Kauf schöner Dinge und den Ausdruck von Zuneigung.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Вы само обаяние. Легко произвести хорошее впечатление, договориться и сгладить любые конфликты.',
          '2': 'Удачные переговоры о деньгах. Хороший вкус помогает делать удачные и красивые покупки.',
          '3': 'Идеальный день для флирта, комплиментов и любовных писем. Ваша речь звучит особенно приятно.',
          '4': 'Гармоничное общение в семье. Легко договориться об украшении дома или совместном отдыхе.',
          '5': 'Разговор на свидании будет легким и приятным. Легко найти общие темы и выразить свои чувства.',
          '6': 'Приятная и дружелюбная атмосфера на работе. Легко договориться с коллегами.',
          '7': 'Дипломатия и взаимопонимание с партнером. Идеальный день для обсуждения отношений.',
          '8': 'Тактичный и деликатный разговор на сложные темы (финансы, интимная жизнь) сближает.',
          '9': 'Наслаждение от общения об искусстве, культуре. Приятные новости издалека.',
          '10': 'Ваше обаяние и дипломатичность помогают в карьере. Успешный разговор с начальством.',
          '11': 'Вы душа компании. Легко находите общий язык со всеми друзьями и знакомыми.',
          '12': 'Приятные размышления в уединении. Хорошее время для написания стихов или ведения дневника.'
        },
        'en': {
          '1': 'You are pure charm. It\'s easy to make a good impression, reach agreements, and smooth over any conflicts.',
          '2': 'Successful negotiations about money. Good taste helps in making successful and beautiful purchases.',
          '3': 'An ideal day for flirting, compliments, and love letters. Your speech sounds particularly pleasant.',
          '4': 'Harmonious communication in the family. It\'s easy to agree on home decoration or a joint vacation.',
          '5': 'The conversation on a date will be light and pleasant. It\'s easy to find common topics and express your feelings.',
          '6': 'A pleasant and friendly atmosphere at work. It\'s easy to come to an agreement with colleagues.',
          '7': 'Diplomacy and mutual understanding with a partner. An ideal day to discuss the relationship.',
          '8': 'A tactful and delicate conversation on difficult topics (finances, intimate life) brings you closer.',
          '9': 'Enjoyment from conversations about art and culture. Pleasant news from afar.',
          '10': 'Your charm and diplomacy help in your career. A successful conversation with your boss.',
          '11': 'You are the life of the party. You easily find common ground with all friends and acquaintances.',
          '12': 'Pleasant reflections in solitude. A good time for writing poetry or journaling.'
        },
        'fr': {
          '1': 'Vous êtes le charme incarné. Il est facile de faire bonne impression, de parvenir à des accords et d\'aplanir les conflits.',
          '2': 'Négociations réussies sur l\'argent. Le bon goût aide à faire des achats réussis et beaux.',
          '3': 'Une journée idéale pour le flirt, les compliments et les lettres d\'amour. Votre discours est particulièrement agréable.',
          '4': 'Communication harmonieuse en famille. Il est facile de se mettre d\'accord sur la décoration de la maison ou des vacances communes.',
          '5': 'La conversation lors d\'un rendez-vous sera légère et agréable. Il est facile de trouver des sujets communs et d\'exprimer ses sentiments.',
          '6': 'Une atmosphère agréable et amicale au travail. Il est facile de se mettre d\'accord avec les collègues.',
          '7': 'Diplomatie et compréhension mutuelle avec un partenaire. Une journée idéale pour discuter de la relation.',
          '8': 'Une conversation pleine de tact et de délicatesse sur des sujets difficiles (finances, vie intime) vous rapproche.',
          '9': 'Plaisir des conversations sur l\'art et la culture. Agréables nouvelles de loin.',
          '10': 'Votre charme et votre diplomatie vous aident dans votre carrière. Une conversation réussie avec votre patron.',
          '11': 'Vous êtes l\'âme de la fête. Vous trouvez facilement un terrain d\'entente avec tous vos amis et connaissances.',
          '12': 'Réflexions agréables en solitude. Un bon moment pour écrire de la poésie ou tenir un journal.'
        },
        'de': {
          '1': 'Sie sind der pure Charme. Es ist leicht, einen guten Eindruck zu hinterlassen, Vereinbarungen zu treffen und Konflikte zu glätten.',
          '2': 'Erfolgreiche Verhandlungen über Geld. Guter Geschmack hilft bei erfolgreichen und schönen Einkäufen.',
          '3': 'Ein idealer Tag für Flirts, Komplimente und Liebesbriefe. Ihre Rede klingt besonders angenehm.',
          '4': 'Harmonische Kommunikation in der Familie. Es ist leicht, sich über die Dekoration des Hauses oder einen gemeinsamen Urlaub zu einigen.',
          '5': 'Das Gespräch bei einem Date wird leicht und angenehm sein. Es ist leicht, gemeinsame Themen zu finden und seine Gefühle auszudrücken.',
          '6': 'Eine angenehme und freundliche Atmosphäre bei der Arbeit. Es ist leicht, mit Kollegen eine Einigung zu erzielen.',
          '7': 'Diplomatie und gegenseitiges Verständnis mit einem Partner. Ein idealer Tag, um die Beziehung zu besprechen.',
          '8': 'Ein taktvolles und delikates Gespräch über schwierige Themen (Finanzen, Intimleben) bringt Sie näher zusammen.',
          '9': 'Genuss an Gesprächen über Kunst und Kultur. Angenehme Nachrichten aus der Ferne.',
          '10': 'Ihr Charme und Ihre Diplomatie helfen in Ihrer Karriere. Ein erfolgreiches Gespräch mit Ihrem Chef.',
          '11': 'Sie sind der Mittelpunkt der Gesellschaft. Sie finden leicht eine gemeinsame Basis mit allen Freunden und Bekannten.',
          '12': 'Angenehme Reflexionen in der Einsamkeit. Eine gute Zeit, um Gedichte zu schreiben oder ein Tagebuch zu führen.'
        }
      }
    ),
    AspectInterpretation(
      id: 'MERCURY_SQUARE_PLUTO',
      title: {
        'ru': 'Конфликт Меркурия и Плутона',
        'en': 'Mercury Square Pluto',
        'fr': 'Mercure Carré Pluton',
        'de': 'Merkur-Quadrat-Pluto'
      },
      descriptionGeneral: {
        'ru': 'День напряженного ума и словесных баталий. Мысли становятся навязчивыми, а слова – инструментом давления. Высокий риск манипуляций, споров, раскрытия неприятных тайн.',
        'en': 'A day of a tense mind and verbal battles. Thoughts become obsessive, and words become a tool of pressure. High risk of manipulation, arguments, and revealing unpleasant secrets.',
        'fr': 'Une journée d\'esprit tendu et de batailles verbales. Les pensées deviennent obsessionnelles et les mots un outil de pression. Risque élevé de manipulation, de disputes et de révélation de secrets désagréables.',
        'de': 'Ein Tag eines angespannten Geistes und verbaler Kämpfe. Gedanken werden zwanghaft und Worte zu einem Druckmittel. Hohes Risiko von Manipulation, Streit und der Aufdeckung unangenehmer Geheimnisse.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Вы можете быть одержимы какой-то идеей и пытаться навязать ее другим.',
          '2': 'Жесткие переговоры о деньгах, вплоть до шантажа. Финансовое давление.',
          '3': 'Словесная атака, попытка "уничтожить" оппонента аргументами. Раскрытие компромата.',
          '4': 'Психологическое давление в семье. Попытки манипулировать домочадцами.',
          '5': 'Ревнивые допросы в любви. Слова используются для контроля над партнером.',
          '6': 'Интриги и подковерные игры на работе. Конфликт, который может иметь серьезные последствия.',
          '7': 'Словесная борьба за власть с партнером. Ультиматумы, жесткие требования.',
          '8': 'Навязчивые мысли о сексе, смерти, долгах. Кризис, вызванный информацией.',
          '9': 'Фанатизм в отстаивании своих убеждений. Нетерпимость к чужому мнению.',
          '10': 'Конфликт с начальством. Ваши слова могут быть использованы против вас.',
          '11': 'Манипуляции в кругу друзей. Использование информации для получения власти.',
          '12': 'Самобичевание, разрушительные мысли. Вы можете стать жертвой клеветы.'
        },
        'en': {
          '1': 'You may be obsessed with an idea and try to impose it on others.',
          '2': 'Tough negotiations about money, up to blackmail. Financial pressure.',
          '3': 'A verbal attack, an attempt to "destroy" an opponent with arguments. Disclosure of compromising information.',
          '4': 'Psychological pressure in the family. Attempts to manipulate household members.',
          '5': 'Jealous interrogations in love. Words are used to control a partner.',
          '6': 'Intrigues and underhand games at work. A conflict that can have serious consequences.',
          '7': 'A verbal power struggle with a partner. Ultimatums, harsh demands.',
          '8': 'Obsessive thoughts about sex, death, debts. A crisis caused by information.',
          '9': 'Fanaticism in defending your beliefs. Intolerance of others\' opinions.',
          '10': 'A conflict with your boss. Your words could be used against you.',
          '11': 'Manipulation within a circle of friends. Using information to gain power.',
          '12': 'Self-flagellation, destructive thoughts. You may become a victim of slander.'
        },
        'fr': {
          '1': 'Vous pouvez être obsédé par une idée et essayer de l\'imposer aux autres.',
          '2': 'Négociations difficiles sur l\'argent, jusqu\'au chantage. Pression financière.',
          '3': 'Une attaque verbale, une tentative de "détruire" un adversaire avec des arguments. Divulgation d\'informations compromettantes.',
          '4': 'Pression psychologique dans la famille. Tentatives de manipuler les membres du ménage.',
          '5': 'Interrogatoires jaloux en amour. Les mots sont utilisés pour contrôler un partenaire.',
          '6': 'Intrigues et jeux de coulisses au travail. Un conflit qui peut avoir de graves conséquences.',
          '7': 'Une lutte de pouvoir verbale avec un partenaire. Ultimatums, exigences sévères.',
          '8': 'Pensées obsessionnelles sur le sexe, la mort, les dettes. Une crise provoquée par l\'information.',
          '9': 'Fanatisme dans la défense de vos croyances. Intolérance aux opinions des autres.',
          '10': 'Un conflit avec votre patron. Vos paroles pourraient être utilisées contre vous.',
          '11': 'Manipulation au sein d\'un cercle d\'amis. Utilisation de l\'information pour gagner du pouvoir.',
          '12': 'Auto-flagellation, pensées destructrices. Vous pourriez devenir victime de calomnie.'
        },
        'de': {
          '1': 'Sie könnten von einer Idee besessen sein und versuchen, sie anderen aufzuzwingen.',
          '2': 'Harte Verhandlungen über Geld, bis hin zur Erpressung. Finanzieller Druck.',
          '3': 'Ein verbaler Angriff, ein Versuch, einen Gegner mit Argumenten zu "zerstören". Offenlegung kompromittierender Informationen.',
          '4': 'Psychologischer Druck in der Familie. Versuche, Haushaltsmitglieder zu manipulieren.',
          '5': 'Eifersüchtige Verhöre in der Liebe. Worte werden benutzt, um einen Partner zu kontrollieren.',
          '6': 'Intrigen und Machtspiele bei der Arbeit. Ein Konflikt, der schwerwiegende Folgen haben kann.',
          '7': 'Ein verbaler Machtkampf mit einem Partner. Ultimaten, harte Forderungen.',
          '8': 'Zwanghafte Gedanken über Sex, Tod, Schulden. Eine durch Informationen verursachte Krise.',
          '9': 'Fanatismus bei der Verteidigung Ihrer Überzeugungen. Intoleranz gegenüber den Meinungen anderer.',
          '10': 'Ein Konflikt mit Ihrem Chef. Ihre Worte könnten gegen Sie verwendet werden.',
          '11': 'Manipulation im Freundeskreis. Informationen nutzen, um Macht zu erlangen.',
          '12': 'Selbstgeißelung, zerstörerische Gedanken. Sie könnten Opfer von Verleumdung werden.'
        }
      }
    ),
    AspectInterpretation(
      id: 'VENUS_TRINE_NEPTUNE',
      title: {
        'ru': 'Гармония Венеры и Нептуна',
        'en': 'Venus Trine Neptune',
        'fr': 'Vénus Trigone Neptune',
        'de': 'Venus-Trigon-Neptun'
      },
      descriptionGeneral: {
        'ru': 'День волшебной романтики, духовной любви и творческого вдохновения. Идеализация и сострадание на пике. Прекрасное время для искусства, музыки и мечтаний.',
        'en': 'A day of magical romance, spiritual love, and creative inspiration. Idealization and compassion are at their peak. A wonderful time for art, music, and dreaming.',
        'fr': 'Une journée de romance magique, d\'amour spirituel et d\'inspiration créative. L\'idéalisation et la compassion sont à leur comble. Un moment merveilleux pour l\'art, la musique et le rêve.',
        'de': 'Ein Tag magischer Romantik, spiritueller Liebe und kreativer Inspiration. Idealisierung und Mitgefühl sind auf ihrem Höhepunkt. Eine wunderbare Zeit für Kunst, Musik und Träumen.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Вы излучаете загадочность и сострадание. Ваша аура притягивает людей.',
          '2': 'Интуиция помогает в финансовых делах. Вы можете заработать на своем творчестве.',
          '3': 'Поэтичная речь, душевные разговоры. Легко выразить самые тонкие оттенки чувств.',
          '4': 'Создание идеальной, умиротворяющей атмосферы дома. Глубокое единение с семьей.',
          '5': 'Свидание-мечта. Вы влюбляетесь в идеальный образ и чувствуете сказочную любовь.',
          '6': 'Работа приносит духовное удовлетворение. Вы можете помочь коллегам, проявив сочувствие.',
          '7': 'Глубокая духовная и эмоциональная связь с партнером. Вы понимаете друг друга без слов.',
          '8': 'Мистическое слияние душ. Сильная интуиция, вещие сны об отношениях.',
          '9': 'Любовь к прекрасному, искусству, музыке. Романтическое вдохновение издалека.',
          '10': 'Ваш творческий талант и обаяние приносят успех и популярность.',
          '11': 'Вы встречаете "родственную душу". Идеалистическая дружба и любовь.',
          '12': 'Глубокое исцеление через любовь и прощение. Тайный роман может быть очень возвышенным.'
        },
        'en': {
          '1': 'You radiate mystery and compassion. Your aura attracts people.',
          '2': 'Intuition helps in financial matters. You can earn from your creativity.',
          '3': 'Poetic speech, soulful conversations. It\'s easy to express the finest shades of feelings.',
          '4': 'Creating a perfect, peaceful atmosphere at home. Deep unity with family.',
          '5': 'A dream date. You fall in love with an ideal image and feel a fairytale love.',
          '6': 'Work brings spiritual satisfaction. You can help colleagues by showing empathy.',
          '7': 'A deep spiritual and emotional connection with your partner. You understand each other without words.',
          '8': 'A mystical merging of souls. Strong intuition, prophetic dreams about the relationship.',
          '9': 'Love for the beautiful, art, music. Romantic inspiration from afar.',
          '10': 'Your creative talent and charm bring success and popularity.',
          '11': 'You meet a "soulmate." Idealistic friendship and love.',
          '12': 'Deep healing through love and forgiveness. A secret romance can be very sublime.'
        },
        'fr': {
          '1': 'Vous rayonnez de mystère et de compassion. Votre aura attire les gens.',
          '2': 'L\'intuition aide dans les affaires financières. Vous pouvez gagner de l\'argent grâce à votre créativité.',
          '3': 'Discours poétique, conversations profondes. Il est facile d\'exprimer les plus fines nuances de sentiments.',
          '4': 'Créer une atmosphère parfaite et paisible à la maison. Unité profonde avec la famille.',
          '5': 'Un rendez-vous de rêve. Vous tombez amoureux d\'une image idéale et ressentez un amour de conte de fées.',
          '6': 'Le travail apporte une satisfaction spirituelle. Vous pouvez aider vos collègues en faisant preuve d\'empathie.',
          '7': 'Un lien spirituel et émotionnel profond avec votre partenaire. Vous vous comprenez sans mots.',
          '8': 'Une fusion mystique des âmes. Forte intuition, rêves prophétiques sur la relation.',
          '9': 'Amour du beau, de l\'art, de la musique. Inspiration romantique de loin.',
          '10': 'Votre talent créatif et votre charme apportent succès et popularité.',
          '11': 'Vous rencontrez une "âme sœur". Amitié et amour idéalistes.',
          '12': 'Guérison profonde par l\'amour et le pardon. Une romance secrète peut être très sublime.'
        },
        'de': {
          '1': 'Sie strahlen Geheimnis und Mitgefühl aus. Ihre Aura zieht Menschen an.',
          '2': 'Die Intuition hilft in finanziellen Angelegenheiten. Sie können mit Ihrer Kreativität Geld verdienen.',
          '3': 'Poetische Sprache, seelenvolle Gespräche. Es ist leicht, die feinsten Gefühlsschattierungen auszudrücken.',
          '4': 'Schaffung einer perfekten, friedlichen Atmosphäre zu Hause. Tiefe Einheit mit der Familie.',
          '5': 'Ein Traum-Date. Sie verlieben sich in ein Idealbild und spüren eine märchenhafte Liebe.',
          '6': 'Die Arbeit bringt spirituelle Befriedigung. Sie können Kollegen helfen, indem Sie Empathie zeigen.',
          '7': 'Eine tiefe spirituelle und emotionale Verbindung zu Ihrem Partner. Sie verstehen sich ohne Worte.',
          '8': 'Eine mystische Verschmelzung der Seelen. Starke Intuition, prophetische Träume über die Beziehung.',
          '9': 'Liebe zum Schönen, zur Kunst, zur Musik. Romantische Inspiration aus der Ferne.',
          '10': 'Ihr kreatives Talent und Ihr Charme bringen Erfolg und Popularität.',
          '11': 'Sie treffen einen "Seelenverwandten". Idealistische Freundschaft und Liebe.',
          '12': 'Tiefe Heilung durch Liebe und Vergebung. Eine geheime Romanze kann sehr erhaben sein.'
        }
      }
    ),
    AspectInterpretation(
      id: 'MARS_OPPOSITION_JUPITER',
      title: {
        'ru': 'Противостояние Марса и Юпитера',
        'en': 'Mars Opposition Jupiter',
        'fr': 'Mars Opposition Jupiter',
        'de': 'Mars-Opposition-Jupiter'
      },
      descriptionGeneral: {
        'ru': 'День чрезмерной энергии и неоправданного оптимизма. Вы склонны браться за слишком многое и давать обещания, которые не можете выполнить. Риск безрассудных поступков и конфликтов из-за высокомерия.',
        'en': 'A day of excessive energy and unwarranted optimism. You tend to take on too much and make promises you can\'t keep. Risk of reckless actions and conflicts due to arrogance.',
        'fr': 'Une journée d\'énergie excessive et d\'optimisme injustifié. Vous avez tendance à en faire trop et à faire des promesses que vous ne pouvez pas tenir. Risque d\'actions imprudentes et de conflits dus à l\'arrogance.',
        'de': 'Ein Tag übermäßiger Energie und ungerechtfertigten Optimismus. Sie neigen dazu, zu viel zu übernehmen und Versprechen zu machen, die Sie nicht halten können. Risiko von rücksichtslosem Handeln und Konflikten aufgrund von Arroganz.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Ваша самоуверенность переходит в высокомерие. Конфликты с теми, кто пытается ограничить вашу экспансию.',
          '2': 'Неоправданная щедрость и рискованные финансовые авантюры. Вы тратите больше, чем следует.',
          '3': 'Вы склонны поучать других и давать невыполнимые обещания. Споры на идеологической почве.',
          '4': 'Слишком грандиозные планы на дом, которые вызывают конфликт с семьей.',
          '5': 'Излишняя настойчивость в любви. Партнер может быть подавлен вашим энтузиазмом. Риск проигрыша в азартные игры.',
          '6': 'Вы взваливаете на себя слишком много работы, с которой не можете справиться, чем подводите других.',
          '7': 'Конфликт с партнером, который не разделяет вашего энтузиазма. Вы давите на него своим авторитетом.',
          '8': 'Риск влезть в крупные долги из-за чрезмерного оптимизма.',
          '9': 'Фанатичное отстаивание своих убеждений в споре с оппонентом.',
          '10': 'Конфликт с начальством из-за того, что вы пообещали слишком много.',
          '11': 'Вы можете поссориться с друзьями, пытаясь навязать им свои грандиозные, но нереалистичные планы.',
          '12': 'Ваши действия, основанные на слепой вере, могут привести к проблемам. Кто-то тайно мешает вашим планам.'
        },
        'en': {
          '1': 'Your self-confidence turns into arrogance. Conflicts with those who try to limit your expansion.',
          '2': 'Unwarranted generosity and risky financial ventures. You spend more than you should.',
          '3': 'You tend to lecture others and make unfulfillable promises. Ideological disputes.',
          '4': 'Overly grandiose plans for the home that cause conflict with the family.',
          '5': 'Excessive persistence in love. A partner may be overwhelmed by your enthusiasm. Risk of gambling losses.',
          '6': 'You take on too much work that you can\'t handle, letting others down.',
          '7': 'A conflict with a partner who does not share your enthusiasm. You pressure them with your authority.',
          '8': 'Risk of getting into large debts due to excessive optimism.',
          '9': 'A fanatical defense of your beliefs in an argument with an opponent.',
          '10': 'A conflict with your boss because you promised too much.',
          '11': 'You might quarrel with friends by trying to impose your grandiose but unrealistic plans on them.',
          '12': 'Your actions based on blind faith can lead to problems. Someone is secretly thwarting your plans.'
        },
        'fr': {
          '1': 'Votre confiance en vous se transforme en arrogance. Conflits avec ceux qui tentent de limiter votre expansion.',
          '2': 'Générosité injustifiée et entreprises financières risquées. Vous dépensez plus que vous ne le devriez.',
          '3': 'Vous avez tendance à sermonner les autres et à faire des promesses irréalisables. Disputes idéologiques.',
          '4': 'Plans trop grandioses pour la maison qui provoquent des conflits avec la famille.',
          '5': 'Persistance excessive en amour. Un partenaire peut être dépassé par votre enthousiasme. Risque de pertes au jeu.',
          '6': 'Vous assumez trop de travail que vous ne pouvez pas gérer, laissant tomber les autres.',
          '7': 'Un conflit avec un partenaire qui ne partage pas votre enthousiasme. Vous le pressez de votre autorité.',
          '8': 'Risque de s\'endetter lourdement en raison d\'un optimisme excessif.',
          '9': 'Une défense fanatique de vos croyances dans une dispute avec un adversaire.',
          '10': 'Un conflit avec votre patron parce que vous avez trop promis.',
          '11': 'Vous pourriez vous quereller avec des amis en essayant de leur imposer vos plans grandioses mais irréalistes.',
          '12': 'Vos actions basées sur une foi aveugle peuvent entraîner des problèmes. Quelqu\'un contrecarre secrètement vos plans.'
        },
        'de': {
          '1': 'Ihr Selbstvertrauen wird zu Arroganz. Konflikte mit denen, die versuchen, Ihre Expansion zu begrenzen.',
          '2': 'Ungerechtfertigte Großzügigkeit und riskante finanzielle Unternehmungen. Sie geben mehr aus, als Sie sollten.',
          '3': 'Sie neigen dazu, andere zu belehren und unerfüllbare Versprechen zu machen. Ideologische Auseinandersetzungen.',
          '4': 'Übermäßig grandiose Pläne für das Zuhause, die Konflikte mit der Familie verursachen.',
          '5': 'Übermäßige Hartnäckigkeit in der Liebe. Ein Partner könnte von Ihrer Begeisterung überwältigt sein. Risiko von Glücksspielverlusten.',
          '6': 'Sie übernehmen zu viel Arbeit, die Sie nicht bewältigen können, und lassen andere im Stich.',
          '7': 'Ein Konflikt mit einem Partner, der Ihre Begeisterung nicht teilt. Sie setzen ihn mit Ihrer Autorität unter Druck.',
          '8': 'Risiko, sich aufgrund übermäßigen Optimismus hoch zu verschulden.',
          '9': 'Eine fanatische Verteidigung Ihrer Überzeugungen in einem Streit mit einem Gegner.',
          '10': 'Ein Konflikt mit Ihrem Chef, weil Sie zu viel versprochen haben.',
          '11': 'Sie könnten sich mit Freunden streiten, indem Sie versuchen, ihnen Ihre grandiosen, aber unrealistischen Pläne aufzuzwingen.',
          '12': 'Ihre Handlungen, die auf blindem Glauben beruhen, können zu Problemen führen. Jemand durchkreuzt heimlich Ihre Pläne.'
        }
      }
    ),

            // === НОВЫЙ БЛОК 18 ===
    AspectInterpretation(
      id: 'SUN_CONJUNCT_SATURN',
      title: {
        'ru': 'Соединение Солнца и Сатурна',
        'en': 'Sun Conjunct Saturn',
        'fr': 'Soleil Conjoint Saturne',
        'de': 'Sonne-Konjunktion-Saturn'
      },
      descriptionGeneral: {
        'ru': 'День серьезной работы и ответственности. Ваши амбиции (Солнце) проходят проверку на прочность (Сатурн). Возможны задержки, критика и усталость, но это время для закладки прочного фундамента.',
        'en': 'A day of serious work and responsibility. Your ambitions (Sun) are being tested for strength (Saturn). Delays, criticism, and fatigue are possible, but this is a time for laying a solid foundation.',
        'fr': 'Une journée de travail sérieux et de responsabilité. Vos ambitions (Soleil) sont mises à l'épreuve de leur solidité (Saturne). Des retards, des critiques et de la fatigue sont possibles, mais c\'est le moment de poser des fondations solides.',
        'de': 'Ein Tag ernster Arbeit und Verantwortung. Ihre Ambitionen (Sonne) werden auf ihre Stärke geprüft (Saturn). Verzögerungen, Kritik und Müdigkeit sind möglich, aber dies ist eine Zeit, um ein solides Fundament zu legen.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Вы чувствуете на себе груз ответственности. Низкая самооценка, но и возможность стать более зрелым.',
          '2': 'Финансовые ограничения. Приходится много работать за небольшое вознаграждение.',
          '3': 'Трудности в общении, пессимистичный настрой. Серьезный и важный разговор.',
          '4': 'Большая ответственность за семью или дом. Конфликт с отцом или старшими.',
          '5': 'Охлаждение в романтических отношениях. Любовь воспринимается как тяжелый труд.',
          '6': 'Много тяжелой и ответственной работы. Риск переутомления и выгорания.',
          '7': 'Серьезная проверка партнерских отношений. Принятие важных совместных обязательств.',
          '8': 'Давление долгов и обязательств. Страх, связанный с финансовыми или интимными вопросами.',
          '9': 'Планы на будущее сталкиваются с суровой реальностью. Трудности в учебе.',
          '10': 'Огромная ответственность в карьере. Критика со стороны начальства, серьезные испытания.',
          '11': 'Отношения с друзьями проходят проверку. Чувство долга перед коллективом.',
          '12': 'Обострение страхов и комплексов. Ощущение одиночества и тяжести на душе.'
        },
        'en': {
          '1': 'You feel the weight of responsibility on you. Low self-esteem, but also an opportunity to become more mature.',
          '2': 'Financial constraints. You have to work hard for little reward.',
          '3': 'Difficulties in communication, a pessimistic mood. A serious and important conversation.',
          '4': 'Great responsibility for family or home. Conflict with a father or elders.',
          '5': 'A cooling in romantic relationships. Love is perceived as hard work.',
          '6': 'A lot of hard and responsible work. Risk of overwork and burnout.',
          '7': 'A serious test of partnerships. Making important joint commitments.',
          '8': 'The pressure of debts and obligations. Fear related to financial or intimate matters.',
          '9': 'Future plans clash with harsh reality. Difficulties in studies.',
          '10': 'Huge responsibility in your career. Criticism from superiors, serious tests.',
          '11': 'Relationships with friends are being tested. A sense of duty to the group.',
          '12': 'Exacerbation of fears and complexes. A feeling of loneliness and heaviness in the soul.'
        },
        'fr': {
          '1': 'Vous sentez le poids de la responsabilité sur vous. Faible estime de soi, mais aussi une opportunité de devenir plus mature.',
          '2': 'Contraintes financières. Il faut travailler dur pour une faible récompense.',
          '3': 'Difficultés de communication, humeur pessimiste. Une conversation sérieuse et importante.',
          '4': 'Grande responsabilité pour la famille ou la maison. Conflit avec un père ou des aînés.',
          '5': 'Un refroidissement dans les relations amoureuses. L\'amour est perçu comme un travail difficile.',
          '6': 'Beaucoup de travail dur et responsable. Risque de surmenage et d\'épuisement professionnel.',
          '7': 'Un test sérieux des partenariats. Prise d\'engagements communs importants.',
          '8': 'La pression des dettes et des obligations. Peur liée à des questions financières ou intimes.',
          '9': 'Les projets d\'avenir se heurtent à la dure réalité. Difficultés dans les études.',
          '10': 'Énorme responsabilité dans votre carrière. Critiques des supérieurs, épreuves sérieuses.',
          '11': 'Les relations avec les amis sont mises à l\'épreuve. Un sens du devoir envers le groupe.',
          '12': 'Exacerbation des peurs et des complexes. Un sentiment de solitude et de lourdeur dans l\'âme.'
        },
        'de': {
          '1': 'Sie spüren die Last der Verantwortung auf sich. Geringes Selbstwertgefühl, aber auch eine Chance, reifer zu werden.',
          '2': 'Finanzielle Einschränkungen. Man muss hart für wenig Lohn arbeiten.',
          '3': 'Schwierigkeiten in der Kommunikation, eine pessimistische Stimmung. Ein ernstes und wichtiges Gespräch.',
          '4': 'Große Verantwortung für Familie oder Zuhause. Konflikt mit einem Vater oder Älteren.',
          '5': 'Eine Abkühlung in romantischen Beziehungen. Liebe wird als harte Arbeit empfunden.',
          '6': 'Viel harte und verantwortungsvolle Arbeit. Gefahr von Überarbeitung und Burnout.',
          '7': 'Ein ernsthafter Test von Partnerschaften. Wichtige gemeinsame Verpflichtungen eingehen.',
          '8': 'Der Druck von Schulden und Verpflichtungen. Angst im Zusammenhang mit finanziellen oder intimen Angelegenheiten.',
          '9': 'Zukunftspläne kollidieren mit der harten Realität. Schwierigkeiten im Studium.',
          '10': 'Riesige Verantwortung in Ihrer Karriere. Kritik von Vorgesetzten, ernste Prüfungen.',
          '11': 'Beziehungen zu Freunden werden auf die Probe gestellt. Ein Pflichtgefühl gegenüber der Gruppe.',
          '12': 'Verschärfung von Ängsten und Komplexen. Ein Gefühl von Einsamkeit und Schwere in der Seele.'
        }
      }
    ),
    AspectInterpretation(
      id: 'MERCURY_SQUARE_URANUS',
      title: {
        'ru': 'Конфликт Меркурия и Урана',
        'en': 'Mercury Square Uranus',
        'fr': 'Mercure Carré Uranus',
        'de': 'Merkur-Quadrat-Uranus'
      },
      descriptionGeneral: {
        'ru': 'День нервозного ума и срыва планов. Мышление становится беспокойным, а информация – непредсказуемой. Внезапные новости, резкие слова, поломки техники. Не время для важных переговоров.',
        'en': 'A day of a nervous mind and disrupted plans. Thinking becomes restless, and information unpredictable. Sudden news, harsh words, technical breakdowns. Not a time for important negotiations.',
        'fr': 'Une journée d\'esprit nerveux et de plans perturbés. La pensée devient agitée et l\'information imprévisible. Nouvelles soudaines, paroles dures, pannes techniques. Ce n\'est pas le moment pour des négociations importantes.',
        'de': 'Ein Tag eines nervösen Geistes und gestörter Pläne. Das Denken wird unruhig und Informationen unvorhersehbar. Plötzliche Nachrichten, harte Worte, technische Pannen. Keine Zeit für wichtige Verhandlungen.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Ваши идеи слишком радикальны и вызывают сопротивление. Нервозность, нетерпеливость.',
          '2': 'Неожиданные финансовые новости, чаще неприятные. Спонтанные, но неудачные покупки.',
          '3': 'Вы можете сказать что-то резкое и шокирующее, не подумав. Срыв поездок, ссоры.',
          '4': 'Внезапные и неприятные события дома. Конфликты с семьей из-за вашего желания свободы.',
          '5': 'Резкие слова могут привести к внезапной ссоре или разрыву в любви.',
          '6': 'Хаос на работе из-за сбоев техники или внезапных новостей. Нервная обстановка.',
          '7': 'Партнер ведет себя непредсказуемо, что приводит к конфликту. Срыв договоренностей.',
          '8': 'Неожиданные новости, связанные с долгами или кредитами, вызывают стресс.',
          '9': 'Ваши прогрессивные идеи наталкиваются на жесткое неприятие. Срыв планов на учебу.',
          '10': 'Конфликт с начальством. Ваши слова или идеи могут быть восприняты как бунт.',
          '11': 'Внезапная ссора с другом. Ваши планы на будущее могут резко измениться.',
          '12': 'Внезапные озарения могут быть тревожными. Нервное напряжение, бессонница.'
        },
        'en': {
          '1': 'Your ideas are too radical and cause resistance. Nervousness, impatience.',
          '2': 'Unexpected financial news, more often unpleasant. Spontaneous but unsuccessful purchases.',
          '3': 'You might say something harsh and shocking without thinking. Disrupted trips, quarrels.',
          '4': 'Sudden and unpleasant events at home. Conflicts with family over your desire for freedom.',
          '5': 'Harsh words can lead to a sudden quarrel or breakup in love.',
          '6': 'Chaos at work due to technical failures or sudden news. A nervous atmosphere.',
          '7': 'A partner behaves unpredictably, leading to conflict. Breakdown of agreements.',
          '8': 'Unexpected news related to debts or loans causes stress.',
          '9': 'Your progressive ideas are met with harsh rejection. Disruption of study plans.',
          '10': 'A conflict with your boss. Your words or ideas might be perceived as rebellion.',
          '11': 'A sudden quarrel with a friend. Your future plans may change abruptly.',
          '12': 'Sudden insights can be disturbing. Nervous tension, insomnia.'
        },
        'fr': {
          '1': 'Vos idées sont trop radicales et provoquent de la résistance. Nervosité, impatience.',
          '2': 'Nouvelles financières inattendues, le plus souvent désagréables. Achats spontanés mais infructueux.',
          '3': 'Vous pourriez dire quelque chose de dur et de choquant sans réfléchir. Voyages perturbés, querelles.',
          '4': 'Événements soudains et désagréables à la maison. Conflits avec la famille à cause de votre désir de liberté.',
          '5': 'Des paroles dures peuvent entraîner une querelle soudaine ou une rupture amoureuse.',
          '6': 'Chaos au travail dû à des pannes techniques ou à des nouvelles soudaines. Une atmosphère nerveuse.',
          '7': 'Un partenaire se comporte de manière imprévisible, ce qui entraîne un conflit. Rupture des accords.',
          '8': 'Des nouvelles inattendues liées aux dettes ou aux prêts provoquent du stress.',
          '9': 'Vos idées progressistes se heurtent à un rejet sévère. Perturbation des plans d\'études.',
          '10': 'Un conflit avec votre patron. Vos paroles ou vos idées pourraient être perçues comme une rébellion.',
          '11': 'Une querelle soudaine avec un ami. Vos projets d\'avenir peuvent changer brusquement.',
          '12': 'Des prises de conscience soudaines peuvent être troublantes. Tension nerveuse, insomnie.'
        },
        'de': {
          '1': 'Ihre Ideen sind zu radikal und stoßen auf Widerstand. Nervosität, Ungeduld.',
          '2': 'Unerwartete Finanznachrichten, meist unangenehm. Spontane, aber erfolglose Käufe.',
          '3': 'Sie könnten etwas Hartes und Schockierendes sagen, ohne nachzudenken. Gestörte Reisen, Streitigkeiten.',
          '4': 'Plötzliche und unangenehme Ereignisse zu Hause. Konflikte mit der Familie wegen Ihres Wunsches nach Freiheit.',
          '5': 'Harte Worte können zu einem plötzlichen Streit oder einer Trennung in der Liebe führen.',
          '6': 'Chaos bei der Arbeit aufgrund technischer Ausfälle oder plötzlicher Nachrichten. Eine nervöse Atmosphäre.',
          '7': 'Ein Partner verhält sich unvorhersehbar, was zu Konflikten führt. Bruch von Vereinbarungen.',
          '8': 'Unerwartete Nachrichten im Zusammenhang mit Schulden oder Krediten verursachen Stress.',
          '9': 'Ihre fortschrittlichen Ideen stoßen auf scharfe Ablehnung. Störung der Studienpläne.',
          '10': 'Ein Konflikt mit Ihrem Chef. Ihre Worte oder Ideen könnten als Rebellion wahrgenommen werden.',
          '11': 'Ein plötzlicher Streit mit einem Freund. Ihre Zukunftspläne können sich abrupt ändern.',
          '12': 'Plötzliche Einsichten können beunruhigend sein. Nervöse Anspannung, Schlaflosigkeit.'
        }
      }
    ),
    AspectInterpretation(
      id: 'MOON_TRINE_PLUTO',
      title: {
        'ru': 'Гармония Луны и Плутона',
        'en': 'Moon Trine Pluto',
        'fr': 'Lune Trigone Pluton',
        'de': 'Mond-Trigon-Pluto'
      },
      descriptionGeneral: {
        'ru': 'День глубокой эмоциональной силы и интуиции. Вы легко считываете скрытые мотивы и докапываетесь до сути. Хорошее время для самоанализа, исцеления старых травм и глубоких, честных разговоров.',
        'en': 'A day of deep emotional strength and intuition. You easily read hidden motives and get to the heart of matters. A good time for self-analysis, healing old traumas, and deep, honest conversations.',
        'fr': 'Une journée de force émotionnelle profonde et d\'intuition. Vous lisez facilement les motivations cachées et allez au fond des choses. Un bon moment pour l\'auto-analyse, la guérison de vieux traumatismes et des conversations profondes et honnêtes.',
        'de': 'Ein Tag tiefer emotionaler Stärke und Intuition. Sie lesen leicht verborgene Motive und kommen zum Kern der Dinge. Eine gute Zeit für Selbstanalyse, die Heilung alter Traumata und tiefe, ehrliche Gespräche.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Вы чувствуете свою внутреннюю силу и уверенность. Ваша эмоциональная глубина притягивает.',
          '2': 'Интуиция помогает найти скрытые финансовые ресурсы или удачно инвестировать.',
          '3': 'Глубокий разговор, который может трансформировать отношения. Вы видите собеседника насквозь.',
          '4': 'Исцеление семейных отношений. Вы можете разрешить давний конфликт, поняв его корень.',
          '5': 'Глубокая и страстная эмоциональная связь в любви. Отношения выходят на новый уровень.',
          '6': 'Вы можете трансформировать рабочие процессы к лучшему, видя суть проблем.',
          '7': 'Полное эмоциональное доверие с партнером. Отношения становятся глубже и прочнее.',
          '8': 'Прекрасный день для психотерапии. Вы легко докапываетесь до своих скрытых страхов.',
          '9': 'Глубокое погружение в учебу, которое дает мощную трансформацию мировоззрения.',
          '10': 'Ваша проницательность и эмоциональная сила производят впечатление на начальство.',
          '11': 'Глубокие и искренние отношения с друзьями. Вы можете помочь другу в трудную минуту.',
          '12': 'Мощная интуиция, вещие сны. Вы легко понимаете свои подсознательные процессы.'
        },
        'en': {
          '1': 'You feel your inner strength and confidence. Your emotional depth is attractive.',
          '2': 'Intuition helps to find hidden financial resources or invest successfully.',
          '3': 'A deep conversation that can transform a relationship. You see right through the other person.',
          '4': 'Healing family relationships. You can resolve a long-standing conflict by understanding its root.',
          '5': 'A deep and passionate emotional connection in love. The relationship reaches a new level.',
          '6': 'You can transform work processes for the better by seeing the essence of problems.',
          '7': 'Complete emotional trust with a partner. The relationship becomes deeper and stronger.',
          '8': 'A perfect day for psychotherapy. You easily get to the bottom of your hidden fears.',
          '9': 'A deep dive into studies that provides a powerful transformation of your worldview.',
          '10': 'Your insight and emotional strength impress your superiors.',
          '11': 'Deep and sincere relationships with friends. You can help a friend in a difficult moment.',
          '12': 'Powerful intuition, prophetic dreams. You easily understand your subconscious processes.'
        },
        'fr': {
          '1': 'Vous sentez votre force intérieure et votre confiance. Votre profondeur émotionnelle est attrayante.',
          '2': 'L\'intuition aide à trouver des ressources financières cachées ou à investir avec succès.',
          '3': 'Une conversation profonde qui peut transformer une relation. Vous voyez à travers l\'autre personne.',
          '4': 'Guérison des relations familiales. Vous pouvez résoudre un conflit de longue date en comprenant sa racine.',
          '5': 'Un lien émotionnel profond et passionné en amour. La relation atteint un nouveau niveau.',
          '6': 'Vous pouvez transformer les processus de travail pour le mieux en voyant l\'essence des problèmes.',
          '7': 'Confiance émotionnelle totale avec un partenaire. La relation devient plus profonde et plus forte.',
          '8': 'Une journée parfaite pour la psychothérapie. Vous allez facilement au fond de vos peurs cachées.',
          '9': 'Une plongée profonde dans les études qui offre une puissante transformation de votre vision du monde.',
          '10': 'Votre perspicacité et votre force émotionnelle impressionnent vos supérieurs.',
          '11': 'Relations profondes et sincères avec des amis. Vous pouvez aider un ami dans un moment difficile.',
          '12': 'Intuition puissante, rêves prophétiques. Vous comprenez facilement vos processus subconscients.'
        },
        'de': {
          '1': 'Sie spüren Ihre innere Stärke und Ihr Selbstvertrauen. Ihre emotionale Tiefe ist anziehend.',
          '2': 'Die Intuition hilft, verborgene finanzielle Ressourcen zu finden oder erfolgreich zu investieren.',
          '3': 'Ein tiefes Gespräch, das eine Beziehung verändern kann. Sie durchschauen die andere Person.',
          '4': 'Heilung von Familienbeziehungen. Sie können einen langjährigen Konflikt lösen, indem Sie seine Wurzel verstehen.',
          '5': 'Eine tiefe und leidenschaftliche emotionale Verbindung in der Liebe. Die Beziehung erreicht ein neues Niveau.',
          '6': 'Sie können Arbeitsprozesse zum Besseren verändern, indem Sie das Wesen der Probleme erkennen.',
          '7': 'Vollständiges emotionales Vertrauen zu einem Partner. Die Beziehung wird tiefer und stärker.',
          '8': 'Ein perfekter Tag für Psychotherapie. Sie kommen leicht Ihren verborgenen Ängsten auf den Grund.',
          '9': 'Ein tiefes Eintauchen in das Studium, das eine kraftvolle Transformation Ihrer Weltanschauung bewirkt.',
          '10': 'Ihre Einsicht und emotionale Stärke beeindrucken Ihre Vorgesetzten.',
          '11': 'Tiefe und aufrichtige Beziehungen zu Freunden. Sie können einem Freund in einem schwierigen Moment helfen.',
          '12': 'Starke Intuition, prophetische Träume. Sie verstehen leicht Ihre unbewussten Prozesse.'
        }
      }
    ),
    AspectInterpretation(
      id: 'VENUS_OPPOSITION_URANUS',
      title: {
        'ru': 'Противостояние Венеры и Урана',
        'en': 'Venus Opposition Uranus',
        'fr': 'Vénus Opposition Uranus',
        'de': 'Venus-Opposition-Uranus'
      },
      descriptionGeneral: {
        'ru': 'День внезапных разрывов и нестабильности в любви. Ваше желание гармонии (Венера) сталкивается с чужим бунтарством (Уран). Неожиданные события, импульсивные траты, тяга к свободе.',
        'en': 'A day of sudden breakups and instability in love. Your desire for harmony (Venus) clashes with someone else\'s rebellion (Uranus). Unexpected events, impulsive spending, a craving for freedom.',
        'fr': 'Une journée de ruptures soudaines et d\'instabilité en amour. Votre désir d\'harmonie (Vénus) se heurte à la rébellion de quelqu\'un d\'autre (Uranus). Événements inattendus, dépenses impulsives, une envie de liberté.',
        'de': 'Ein Tag plötzlicher Trennungen und Instabilität in der Liebe. Ihr Wunsch nach Harmonie (Venus) kollidiert mit der Rebellion eines anderen (Uranus). Unerwartete Ereignisse, impulsive Ausgaben, ein Verlangen nach Freiheit.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Кто-то или что-то заставляет вас внезапно менять свои вкусы или имидж.',
          '2': 'Неожиданные финансовые потери. Партнер может совершить импульсивную покупку, которая ударит по бюджету.',
          '3': 'Шокирующие новости об отношениях. Внезапный разрыв из-за неосторожных слов.',
          '4': 'Неожиданные события в семье нарушают гармонию. Кто-то может внезапно уехать.',
          '5': 'Партнер требует свободы, что приводит к разрыву. Внезапная, но нестабильная влюбленность.',
          '6': 'Неожиданный и неуместный флирт на работе может привести к проблемам.',
          '7': 'Партнер ведет себя непредсказуемо, что ставит отношения под угрозу. Высокий риск разрыва.',
          '8': 'Внезапный финансовый кризис из-за действий партнера. Неожиданные события в интимной жизни.',
          '9': 'Ваши взгляды на любовь и отношения внезапно оспариваются.',
          '10': 'Ваша личная жизнь может стать причиной внезапного скандала, который вредит репутации.',
          '11': 'Внезапный разрыв с другом из-за любовных дел или денег.',
          '12': 'Раскрытие тайной связи самым неожиданным и неприятным образом.'
        },
        'en': {
          '1': 'Someone or something makes you suddenly change your tastes or image.',
          '2': 'Unexpected financial losses. A partner might make an impulsive purchase that hits the budget.',
          '3': 'Shocking news about a relationship. A sudden breakup due to careless words.',
          '4': 'Unexpected events in the family disrupt harmony. Someone might suddenly leave.',
          '5': 'A partner demands freedom, which leads to a breakup. A sudden but unstable infatuation.',
          '6': 'An unexpected and inappropriate flirtation at work can lead to problems.',
          '7': 'A partner behaves unpredictably, which jeopardizes the relationship. High risk of a breakup.',
          '8': 'A sudden financial crisis due to a partner\'s actions. Unexpected events in your intimate life.',
          '9': 'Your views on love and relationships are suddenly challenged.',
          '10': 'Your personal life can cause a sudden scandal that harms your reputation.',
          '11': 'A sudden break with a friend over love affairs or money.',
          '12': 'The revelation of a secret affair in the most unexpected and unpleasant way.'
        },
        'fr': {
          '1': 'Quelqu\'un ou quelque chose vous fait changer soudainement de goûts ou d\'image.',
          '2': 'Pertes financières inattendues. Un partenaire pourrait faire un achat impulsif qui pèse sur le budget.',
          '3': 'Nouvelles choquantes sur une relation. Une rupture soudaine due à des paroles imprudentes.',
          '4': 'Des événements inattendus dans la famille perturbent l\'harmonie. Quelqu\'un pourrait partir soudainement.',
          '5': 'Un partenaire demande la liberté, ce qui conduit à une rupture. Un engouement soudain mais instable.',
          '6': 'Un flirt inattendu et inapproprié au travail peut entraîner des problèmes.',
          '7': 'Un partenaire se comporte de manière imprévisible, ce qui met la relation en péril. Risque élevé de rupture.',
          '8': 'Une crise financière soudaine due aux actions d\'un partenaire. Événements inattendus dans votre vie intime.',
          '9': 'Vos vues sur l\'amour et les relations sont soudainement remises en question.',
          '10': 'Votre vie personnelle peut provoquer un scandale soudain qui nuit à votre réputation.',
          '11': 'Une rupture soudaine avec un ami à cause d\'affaires de cœur ou d\'argent.',
          '12': 'La révélation d\'une liaison secrète de la manière la plus inattendue et la plus désagréable.'
        },
        'de': {
          '1': 'Jemand oder etwas lässt Sie plötzlich Ihren Geschmack oder Ihr Image ändern.',
          '2': 'Unerwartete finanzielle Verluste. Ein Partner könnte einen impulsiven Kauf tätigen, der das Budget belastet.',
          '3': 'Schockierende Nachrichten über eine Beziehung. Eine plötzliche Trennung aufgrund unvorsichtiger Worte.',
          '4': 'Unerwartete Ereignisse in der Familie stören die Harmonie. Jemand könnte plötzlich gehen.',
          '5': 'Ein Partner fordert Freiheit, was zu einer Trennung führt. Eine plötzliche, aber instabile Verliebtheit.',
          '6': 'Ein unerwarteter und unpassender Flirt bei der Arbeit kann zu Problemen führen.',
          '7': 'Ein Partner verhält sich unvorhersehbar, was die Beziehung gefährdet. Hohes Trennungsrisiko.',
          '8': 'Eine plötzliche Finanzkrise aufgrund der Handlungen eines Partners. Unerwartete Ereignisse in Ihrem Intimleben.',
          '9': 'Ihre Ansichten über Liebe und Beziehungen werden plötzlich in Frage gestellt.',
          '10': 'Ihr Privatleben kann einen plötzlichen Skandal verursachen, der Ihrem Ruf schadet.',
          '11': 'Ein plötzlicher Bruch mit einem Freund wegen Liebesangelegenheiten oder Geld.',
          '12': 'Die Enthüllung einer geheimen Affäre auf die unerwartetste und unangenehmste Weise.'
        }
      }
    ),
            // === НОВЫЙ БЛОК 19 ===
    AspectInterpretation(
      id: 'MOON_OPPOSITION_PLUTO',
      title: {
        'ru': 'Противостояние Луны и Плутона',
        'en': 'Moon Opposition Pluto',
        'fr': 'Lune Opposition Pluton',
        'de': 'Mond-Opposition-Pluto'
      },
      descriptionGeneral: {
        'ru': 'День глубокого эмоционального кризиса. Ваши потребности (Луна) сталкиваются с чужим давлением и манипуляциями (Плутон). Ревность, эмоциональный шантаж, вскрытие старых травм.',
        'en': 'A day of deep emotional crisis. Your needs (Moon) clash with someone else\'s pressure and manipulation (Pluto). Jealousy, emotional blackmail, uncovering of old traumas.',
        'fr': 'Une journée de crise émotionnelle profonde. Vos besoins (Lune) se heurtent à la pression et à la manipulation de quelqu\'un d\'autre (Pluton). Jalousie, chantage affectif, découverte de vieux traumatismes.',
        'de': 'Ein Tag tiefer emotionaler Krise. Ihre Bedürfnisse (Mond) kollidieren mit dem Druck und der Manipulation eines anderen (Pluto). Eifersucht, emotionale Erpressung, Aufdeckung alter Traumata.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Вы сталкиваетесь с сильным эмоциональным давлением со стороны другого человека.',
          '2': 'Конфликт из-за денег или ресурсов, который вызывает сильные и тяжелые эмоции.',
          '3': 'Тяжелый разговор, в котором собеседник пытается манипулировать вашими чувствами.',
          '4': 'Борьба за власть и эмоциональный контроль в семье, особенно с матерью или женщиной.',
          '5': 'Сильная ревность и манипуляции в любви. Партнер пытается контролировать ваши чувства.',
          '6': 'Эмоциональное давление со стороны коллег. Тяжелая, токсичная атмосфера на работе.',
          '7': 'Партнер пытается эмоционально подавить вас. Открытый конфликт, основанный на манипуляциях.',
          '8': 'Кризис, связанный с совместными финансами, который вскрывает глубокие эмоциональные проблемы.',
          '9': 'Кто-то пытается агрессивно навязать вам свои убеждения, давя на ваши чувства.',
          '10': 'Конфликт с начальством (особенно с женщиной), которое злоупотребляет своей властью.',
          '11': 'Друг пытается манипулировать вами или контролировать ваши отношения.',
          '12': 'Ваши самые глубокие страхи и травмы выходят на поверхность через конфликт с другим человеком.'
        },
        'en': {
          '1': 'You are facing strong emotional pressure from another person.',
          '2': 'A conflict over money or resources that causes strong and heavy emotions.',
          '3': 'A difficult conversation in which the other person tries to manipulate your feelings.',
          '4': 'A power struggle and emotional control in the family, especially with a mother or a woman.',
          '5': 'Intense jealousy and manipulation in love. A partner tries to control your feelings.',
          '6': 'Emotional pressure from colleagues. A heavy, toxic atmosphere at work.',
          '7': 'A partner tries to emotionally suppress you. An open conflict based on manipulation.',
          '8': 'A crisis related to joint finances that reveals deep emotional problems.',
          '9': 'Someone is trying to aggressively impose their beliefs on you by pressuring your feelings.',
          '10': 'A conflict with a boss (especially a woman) who is abusing their power.',
          '11': 'A friend tries to manipulate you or control your relationships.',
          '12': 'Your deepest fears and traumas surface through a conflict with another person.'
        },
        'fr': {
          '1': 'Vous faites face à une forte pression émotionnelle de la part d\'une autre personne.',
          '2': 'Un conflit d\'argent ou de ressources qui provoque des émotions fortes et lourdes.',
          '3': 'Une conversation difficile dans laquelle l\'autre personne essaie de manipuler vos sentiments.',
          '4': 'Une lutte de pouvoir et de contrôle émotionnel dans la famille, en particulier avec une mère ou une femme.',
          '5': 'Jalousie intense et manipulation en amour. Un partenaire essaie de contrôler vos sentiments.',
          '6': 'Pression émotionnelle de la part des collègues. Une atmosphère lourde et toxique au travail.',
          '7': 'Un partenaire essaie de vous réprimer émotionnellement. Un conflit ouvert basé sur la manipulation.',
          '8': 'Une crise liée aux finances communes qui révèle de profonds problèmes émotionnels.',
          '9': 'Quelqu\'un essaie de vous imposer agressiveмent ses croyances en faisant pression sur vos sentiments.',
          '10': 'Un conflit avec un patron (surtout une femme) qui abuse de son pouvoir.',
          '11': 'Un ami essaie de vous manipuler ou de contrôler vos relations.',
          '12': 'Vos peurs et traumatismes les plus profonds refont surface à travers un conflit avec une autre personne.'
        },
        'de': {
          '1': 'Sie stehen unter starkem emotionalen Druck von einer anderen Person.',
          '2': 'Ein Konflikt um Geld oder Ressourcen, der starke und schwere Emotionen hervorruft.',
          '3': 'Ein schwieriges Gespräch, in dem die andere Person versucht, Ihre Gefühle zu manipulieren.',
          '4': 'Ein Machtkampf und emotionale Kontrolle in der Familie, besonders mit einer Mutter oder einer Frau.',
          '5': 'Intensive Eifersucht und Manipulation in der Liebe. Ein Partner versucht, Ihre Gefühle zu kontrollieren.',
          '6': 'Emotionaler Druck von Kollegen. Eine schwere, toxische Atmosphäre bei der Arbeit.',
          '7': 'Ein Partner versucht, Sie emotional zu unterdrücken. Ein offener Konflikt, der auf Manipulation basiert.',
          '8': 'Eine Krise im Zusammenhang mit gemeinsamen Finanzen, die tiefe emotionale Probleme aufdeckt.',
          '9': 'Jemand versucht, Ihnen aggressiv seine Überzeugungen aufzudrängen, indem er Ihre Gefühle unter Druck setzt.',
          '10': 'Ein Konflikt mit einem Chef (besonders einer Frau), der seine Macht missbraucht.',
          '11': 'Ein Freund versucht, Sie zu manipulieren oder Ihre Beziehungen zu kontrollieren.',
          '12': 'Ihre tiefsten Ängste und Traumata kommen durch einen Konflikt mit einer anderen Person an die Oberfläche.'
        }
      }
    ),
    AspectInterpretation(
      id: 'MARS_SEXTILE_PLUTO',
      title: {
        'ru': 'Шанс от Марса и Плутона',
        'en': 'Mars Sextile Pluto',
        'fr': 'Mars Sextile Pluton',
        'de': 'Mars-Sextil-Pluto'
      },
      descriptionGeneral: {
        'ru': 'День дает возможность для мощных и решительных действий, которые могут привести к глубокой трансформации. Появляется шанс использовать свою силу конструктивно для достижения цели.',
        'en': 'The day provides an opportunity for powerful and decisive actions that can lead to deep transformation. A chance arises to use your power constructively to achieve a goal.',
        'fr': 'La journée offre une opportunité d\'actions puissantes et décisives qui peuvent conduire à une transformation profonde. Une chance se présente d\'utiliser votre pouvoir de manière constructive pour atteindre un objectif.',
        'de': 'Der Tag bietet eine Gelegenheit für kraftvolle und entscheidende Handlungen, die zu einer tiefen Transformation führen können. Es ergibt sich die Chance, Ihre Kraft konstruktiv einzusetzen, um ein Ziel zu erreichen.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Возможность проявить свою внутреннюю силу и волю для достижения личных целей.',
          '2': 'Шанс кардинально улучшить свое финансовое положение через решительные действия.',
          '3': 'Возможность провести очень влиятельный разговор, который изменит ситуацию.',
          '4': 'Шанс решить застарелую семейную проблему или начать крупный проект дома (ремонт, стройка).',
          '5': 'Возможность вывести отношения на новый, более страстный и глубокий уровень.',
          '6': 'Шанс "пробить" сложный рабочий проект и продемонстрировать свою эффективность.',
          '7': 'Возможность через совместные решительные действия трансформировать партнерство.',
          '8': 'Шанс успешно решить сложный финансовый вопрос (кредит, инвестиции) или углубить интимную связь.',
          '9': 'Возможность через учебу или путешествие получить мощный трансформационный опыт.',
          '10': 'Шанс продемонстрировать свою силу и волю, что приведет к укреплению авторитета и карьерному росту.',
          '11': 'Возможность стать лидером в группе и направить общую энергию на достижение важной цели.',
          '12': 'Шанс через самоанализ или работу с психологом победить свои внутренние страхи.'
        },
        'en': {
          '1': 'An opportunity to demonstrate your inner strength and will to achieve personal goals.',
          '2': 'A chance to radically improve your financial situation through decisive action.',
          '3': 'An opportunity to have a very influential conversation that will change the situation.',
          '4': 'A chance to solve a long-standing family problem or start a major home project (renovation, construction).',
          '5': 'An opportunity to take a relationship to a new, more passionate and deeper level.',
          '6': 'A chance to "break through" a difficult work project and demonstrate your effectiveness.',
          '7': 'An opportunity to transform a partnership through joint decisive action.',
          '8': 'A chance to successfully resolve a complex financial issue (loan, investment) or deepen an intimate bond.',
          '9': 'An opportunity to gain a powerful transformational experience through study or travel.',
          '10': 'A chance to demonstrate your strength and will, which will lead to strengthening authority and career growth.',
          '11': 'An opportunity to become a leader in a group and direct the collective energy towards achieving an important goal.',
          '12': 'A chance to overcome your inner fears through self-analysis or work with a psychologist.'
        },
        'fr': {
          '1': 'Une opportunité de démontrer votre force intérieure et votre volonté d\'atteindre des objectifs personnels.',
          '2': 'Une chance d\'améliorer radicalement votre situation financière par une action décisive.',
          '3': 'Une opportunité d\'avoir une conversation très influente qui changera la situation.',
          '4': 'Une chance de résoudre un problème familial de longue date ou de démarrer un grand projet à la maison (rénovation, construction).',
          '5': 'Une opportunité d\'amener une relation à un niveau nouveau, plus passionné et plus profond.',
          '6': 'Une chance de "percer" un projet de travail difficile et de démontrer votre efficacité.',
          '7': 'Une opportunité de transformer un partenariat par une action commune décisive.',
          '8': 'Une chance de résoudre avec succès un problème financier complexe (prêt, investissement) ou d\'approfondir un lien intime.',
          '9': 'Une opportunité d\'acquérir une expérience transformationnelle puissante par l\'étude ou le voyage.',
          '10': 'Une chance de démontrer votre force et votre volonté, ce qui conduira au renforcement de l\'autorité et à la croissance de carrière.',
          '11': 'Une opportunité de devenir un leader dans un groupe et de diriger l\'énergie collective vers la réalisation d\'un objectif important.',
          '12': 'Une chance de surmonter vos peurs intérieures par l\'auto-analyse ou le travail avec un psychologue.'
        },
        'de': {
          '1': 'Eine Gelegenheit, Ihre innere Stärke und Ihren Willen zur Erreichung persönlicher Ziele zu demonstrieren.',
          '2': 'Eine Chance, Ihre finanzielle Situation durch entschlossenes Handeln radikal zu verbessern.',
          '3': 'Eine Gelegenheit, ein sehr einflussreiches Gespräch zu führen, das die Situation verändern wird.',
          '4': 'Eine Chance, ein langjähriges Familienproblem zu lösen oder ein großes Heimprojekt zu starten (Renovierung, Bau).',
          '5': 'Eine Gelegenheit, eine Beziehung auf ein neues, leidenschaftlicheres und tieferes Niveau zu heben.',
          '6': 'Eine Chance, ein schwieriges Arbeitsprojekt "durchzubrechen" und Ihre Effektivität zu demonstrieren.',
          '7': 'Eine Gelegenheit, eine Partnerschaft durch gemeinsames entschlossenes Handeln zu transformieren.',
          '8': 'Eine Chance, ein komplexes Finanzproblem (Kredit, Investition) erfolgreich zu lösen oder eine intime Bindung zu vertiefen.',
          '9': 'Eine Gelegenheit, durch Studium oder Reisen eine kraftvolle transformative Erfahrung zu machen.',
          '10': 'Eine Chance, Ihre Stärke und Ihren Willen zu demonstrieren, was zur Stärkung der Autorität und zum beruflichen Aufstieg führen wird.',
          '11': 'Eine Gelegenheit, eine Führungspersönlichkeit in einer Gruppe zu werden und die kollektive Energie auf die Erreichung eines wichtigen Ziels zu lenken.',
          '12': 'Eine Chance, Ihre inneren Ängste durch Selbstanalyse oder die Arbeit mit einem Psychologen zu überwinden.'
        }
      }
    ),
    AspectInterpretation(
      id: 'VENUS_CONJUNCTION_MARS',
      title: {
        'ru': 'Соединение Венеры и Марса',
        'en': 'Venus Conjunct Mars',
        'fr': 'Vénus Conjointe Mars',
        'de': 'Venus-Konjunktion-Mars'
      },
      descriptionGeneral: {
        'ru': 'День страсти, влечения и романтической инициативы. Мужская (Марс) и женская (Венера) энергии соединяются. Идеальное время для свиданий, признаний в любви и начала новых отношений.',
        'en': 'A day of passion, attraction, and romantic initiative. Masculine (Mars) and feminine (Venus) energies unite. An ideal time for dates, confessions of love, and starting new relationships.',
        'fr': 'Une journée de passion, d\'attirance et d\'initiative romantique. Les énergies masculine (Mars) et féminine (Vénus) s\'unissent. Un moment idéal pour les rendez-vous, les déclarations d\'amour et le début de nouvelles relations.',
        'de': 'Ein Tag der Leidenschaft, Anziehung und romantischen Initiative. Männliche (Mars) und weibliche (Venus) Energien vereinen sich. Eine ideale Zeit für Verabredungen, Liebesgeständnisse und den Beginn neuer Beziehungen.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Вы неотразимы и полны сексуальной энергии. Легко проявить инициативу и покорить чье-то сердце.',
          '2': 'Страстное желание заработать или потратить деньги на то, что доставляет удовольствие.',
          '3': 'Активный и страстный флирт. Вы говорите то, что чувствуете, и это привлекает.',
          '4': 'Страсти кипят в домашних стенах. Хороший день для активного совместного досуга.',
          '5': 'Идеальный аспект для любви и секса. Сильное взаимное притяжение, яркое и страстное свидание.',
          '6': 'Возможен служебный роман. Отношения с коллегами становятся более теплыми и динамичными.',
          '7': 'Полная гармония и страсть в партнерстве. Вы и ваш партнер на одной волне.',
          '8': 'Пик сексуальной энергии и влечения. Глубокая страсть, которая может трансформировать отношения.',
          '9': 'Романтическое приключение в поездке. Знакомство с ярким и страстным человеком.',
          '10': 'Ваше обаяние и энергия помогают достичь успеха. Возможен роман с кем-то выше по статусу.',
          '11': 'Дружба может легко перерасти в страстный роман. Вечеринка с друзьями может стать судьбоносной.',
          '12': 'Тайный и очень страстный роман. Ваши скрытые желания выходят на поверхность.'
        },
        'en': {
          '1': 'You are irresistible and full of sexual energy. It\'s easy to take the initiative and win someone\'s heart.',
          '2': 'A passionate desire to earn or spend money on what brings pleasure.',
          '3': 'Active and passionate flirting. You say what you feel, and it\'s attractive.',
          '4': 'Passions run high within the home. A good day for active joint leisure.',
          '5': 'The perfect aspect for love and sex. Strong mutual attraction, a bright and passionate date.',
          '6': 'An office romance is possible. Relationships with colleagues become warmer and more dynamic.',
          '7': 'Complete harmony and passion in a partnership. You and your partner are on the same wavelength.',
          '8': 'A peak of sexual energy and attraction. Deep passion that can transform a relationship.',
          '9': 'A romantic adventure on a trip. Meeting a vibrant and passionate person.',
          '10': 'Your charm and energy help you achieve success. A romance with someone of higher status is possible.',
          '11': 'A friendship can easily turn into a passionate romance. A party with friends can be fateful.',
          '12': 'A secret and very passionate romance. Your hidden desires come to the surface.'
        },
        'fr': {
          '1': 'Vous êtes irrésistible et plein d\'énergie sexuelle. Il est facile de prendre l\'initiative et de gagner le cœur de quelqu\'un.',
          '2': 'Un désir passionné de gagner ou de dépenser de l\'argent pour ce qui procure du plaisir.',
          '3': 'Flirt actif et passionné. Vous dites ce que vous ressentez, et c\'est attrayant.',
          '4': 'Les passions sont vives à la maison. Une bonne journée pour des loisirs communs actifs.',
          '5': 'L\'aspect parfait pour l\'amour et le sexe. Forte attraction mutuelle, un rendez-vous brillant et passionné.',
          '6': 'Une romance au bureau est possible. Les relations avec les collègues deviennent plus chaleureuses et dynamiques.',
          '7': 'Harmonie et passion complètes dans un partenariat. Vous et votre partenaire êtes sur la même longueur d\'onde.',
          '8': 'Un pic d\'énergie sexuelle et d\'attirance. Une passion profonde qui peut transformer une relation.',
          '9': 'Une aventure romantique en voyage. Rencontre avec une personne vibrante et passionnée.',
          '10': 'Votre charme et votre énergie vous aident à réussir. Une romance avec quelqu\'un de statut supérieur est possible.',
          '11': 'Une amitié peut facilement se transformer en une romance passionnée. Une fête entre amis peut être fatidique.',
          '12': 'Une romance secrète et très passionnée. Vos désirs cachés remontent à la surface.'
        },
        'de': {
          '1': 'Sie sind unwiderstehlich und voller sexueller Energie. Es ist leicht, die Initiative zu ergreifen und jemandes Herz zu gewinnen.',
          '2': 'Ein leidenschaftlicher Wunsch, Geld zu verdienen oder für das auszugeben, was Freude bereitet.',
          '3': 'Aktives und leidenschaftliches Flirten. Sie sagen, was Sie fühlen, und das ist attraktiv.',
          '4': 'Die Leidenschaften kochen zu Hause hoch. Ein guter Tag für aktive gemeinsame Freizeit.',
          '5': 'Der perfekte Aspekt für Liebe und Sex. Starke gegenseitige Anziehung, ein helles und leidenschaftliches Date.',
          '6': 'Eine Büro-Romanze ist möglich. Die Beziehungen zu Kollegen werden wärmer und dynamischer.',
          '7': 'Vollständige Harmonie und Leidenschaft in einer Partnerschaft. Sie und Ihr Partner sind auf der gleichen Wellenlänge.',
          '8': 'Ein Höhepunkt an sexueller Energie und Anziehung. Tiefe Leidenschaft, die eine Beziehung verändern kann.',
          '9': 'Ein romantisches Abenteuer auf einer Reise. Treffen mit einer lebendigen und leidenschaftlichen Person.',
          '10': 'Ihr Charme und Ihre Energie helfen Ihnen, Erfolg zu haben. Eine Romanze mit jemandem von höherem Status ist möglich.',
          '11': 'Eine Freundschaft kann sich leicht in eine leidenschaftliche Romanze verwandeln. Eine Party mit Freunden kann schicksalhaft sein.',
          '12': 'Eine geheime und sehr leidenschaftliche Romanze. Ihre verborgenen Wünsche kommen an die Oberfläche.'
        }
      }
    ),
    AspectInterpretation(
      id: 'JUPITER_OPPOSITION_SATURN',
      title: {
        'ru': 'Противостояние Юпитера и Сатурна',
        'en': 'Jupiter Opposition Saturn',
        'fr': 'Jupiter Opposition Saturne',
        'de': 'Jupiter-Opposition-Saturn'
      },
      descriptionGeneral: {
        'ru': 'День борьбы между оптимизмом и пессимизмом, расширением и ограничением. Ваши планы (Юпитер) сталкиваются с суровой реальностью и препятствиями (Сатурн). Необходим баланс.',
        'en': 'A day of struggle between optimism and pessimism, expansion and limitation. Your plans (Jupiter) clash with harsh reality and obstacles (Saturn). Balance is needed.',
        'fr': 'Une journée de lutte entre l\'optimisme et le pessimisme, l\'expansion et la limitation. Vos projets (Jupiter) se heurtent à la dure réalité et aux obstacles (Saturne). Un équilibre est nécessaire.',
        'de': 'Ein Tag des Kampfes zwischen Optimismus und Pessimismus, Expansion und Begrenzung. Ihre Pläne (Jupiter) kollidieren mit der harten Realität und Hindernissen (Saturn). Ausgewogenheit ist erforderlich.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Вы разрываетесь между желанием рискнуть и страхом неудачи. Неуверенность в своих силах.',
          '2': 'Конфликт между желанием потратить деньги на развитие и необходимостью экономить.',
          '3': 'Ваши оптимистичные идеи сталкиваются с критикой и скептицизмом со стороны других.',
          '4': 'Планы по расширению жилья или переезду наталкиваются на препятствия или семейное сопротивление.',
          '5': 'Желание радоваться жизни и развлекаться сталкивается с чувством долга или нехваткой ресурсов.',
          '6': 'Конфликт между желанием взяться за большой проект и рутинными обязанностями.',
          '7': 'Партнер может быть либо слишком оптимистичен, либо слишком пессимистичен, что создает дисбаланс.',
          '8': 'Желание взять кредит или инвестировать сталкивается со страхом долгов и ограничений.',
          '9': 'Ваши философские взгляды проходят проверку реальностью. Планы на путешествие могут быть сорваны.',
          '10': 'Карьерные амбиции сталкиваются с реальными ограничениями или противодействием начальства.',
          '11': 'Ваши мечты кажутся либо слишком грандиозными, либо совершенно нереализуемыми.',
          '12': 'Ваша вера сталкивается с вашими страхами. Внутренний конфликт между надеждой и сомнением.'
        },
        'en': {
          '1': 'You are torn between the desire to take a risk and the fear of failure. Lack of self-confidence.',
          '2': 'A conflict between the desire to spend money on development and the need to save.',
          '3': 'Your optimistic ideas are met with criticism and skepticism from others.',
          '4': 'Plans to expand housing or move are met with obstacles or family resistance.',
          '5': 'The desire to enjoy life and have fun clashes with a sense of duty or lack of resources.',
          '6': 'A conflict between the desire to take on a large project and routine duties.',
          '7': 'A partner may be either too optimistic or too pessimistic, creating an imbalance.',
          '8': 'The desire to take out a loan or invest clashes with the fear of debt and limitations.',
          '9': 'Your philosophical views are put to a reality check. Travel plans may be disrupted.',
          '10': 'Career ambitions clash with real limitations or opposition from superiors.',
          '11': 'Your dreams seem either too grandiose or completely unattainable.',
          '12': 'Your faith clashes with your fears. An internal conflict between hope and doubt.'
        },
        'fr': {
          '1': 'Vous êtes déchiré entre le désir de prendre un risque et la peur de l\'échec. Manque de confiance en soi.',
          '2': 'Un conflit entre le désir de dépenser de l\'argent pour le développement et la nécessité d\'épargner.',
          '3': 'Vos idées optimistes se heurtent à la critique et au scepticisme des autres.',
          '4': 'Les projets d\'agrandissement du logement ou de déménagement se heurtent à des obstacles ou à la résistance de la famille.',
          '5': 'Le désir de profiter de la vie et de s\'amuser se heurte à un sens du devoir ou à un manque de ressources.',
          '6': 'Un conflit entre le désir de s\'attaquer à un grand projet et les tâches routinières.',
          '7': 'Un partenaire peut être soit trop optimiste, soit trop pessimiste, ce qui crée un déséquilibre.',
          '8': 'Le désir de contracter un prêt ou d\'investir se heurte à la peur de l\'endettement et des limitations.',
          '9': 'Vos vues philosophiques sont mises à l\'épreuve de la réalité. Les projets de voyage peuvent être perturbés.',
          '10': 'Les ambitions de carrière se heurtent à des limitations réelles ou à l\'opposition des supérieurs.',
          '11': 'Vos rêves semblent soit trop grandioses, soit complètement irréalisables.',
          '12': 'Votre foi se heurte à vos peurs. Un conflit interne entre l\'espoir et le doute.'
        },
        'de': {
          '1': 'Sie sind hin- und hergerissen zwischen dem Wunsch, ein Risiko einzugehen, und der Angst vor dem Scheitern. Mangel an Selbstvertrauen.',
          '2': 'Ein Konflikt zwischen dem Wunsch, Geld für Entwicklung auszugeben, und der Notwendigkeit zu sparen.',
          '3': 'Ihre optimistischen Ideen stoßen auf Kritik und Skepsis von anderen.',
          '4': 'Pläne zur Erweiterung des Wohnraums oder zum Umzug stoßen auf Hindernisse oder familiären Widerstand.',
          '5': 'Der Wunsch, das Leben zu genießen und Spaß zu haben, kollidiert mit Pflichtgefühl oder Ressourcenmangel.',
          '6': 'Ein Konflikt zwischen dem Wunsch, ein großes Projekt in Angriff zu nehmen, und Routineaufgaben.',
          '7': 'Ein Partner kann entweder zu optimistisch oder zu pessimistisch sein, was ein Ungleichgewicht schafft.',
          '8': 'Der Wunsch, einen Kredit aufzunehmen oder zu investieren, kollidiert mit der Angst vor Schulden und Einschränkungen.',
          '9': 'Ihre philosophischen Ansichten werden einem Realitätscheck unterzogen. Reisepläne können durchkreuzt werden.',
          '10': 'Karriereambitionen kollidieren mit realen Einschränkungen oder dem Widerstand von Vorgesetzten.',
          '11': 'Ihre Träume erscheinen entweder zu grandios oder völlig unerreichbar.',
          '12': 'Ihr Glaube kollidiert mit Ihren Ängsten. Ein interner Konflikt zwischen Hoffnung und Zweifel.'
        }
      }
    ),
            // === НОВЫЙ БЛОК 20 ===
    AspectInterpretation(
      id: 'MOON_OPPOSITION_NEPTUNE',
      title: {
        'ru': 'Противостояние Луны и Нептуна',
        'en': 'Moon Opposition Neptune',
        'fr': 'Lune Opposition Neptune',
        'de': 'Mond-Opposition-Neptun'
      },
      descriptionGeneral: {
        'ru': 'День эмоциональной путаницы и самообмана. Ваши чувства (Луна) искажаются иллюзиями (Нептун). Трудно понять, что реально, а что нет. Риск быть обманутым, особенно женщиной.',
        'en': 'A day of emotional confusion and self-deception. Your feelings (Moon) are distorted by illusions (Neptune). It\'s hard to know what is real and what is not. Risk of being deceived, especially by a woman.',
        'fr': 'Une journée de confusion émotionnelle et d\'auto-illusion. Vos sentiments (Lune) sont déformés par les illusions (Neptune). Difficile de savoir ce qui est réel et ce qui ne l\'est pas. Risque d\'être trompé, surtout par une femme.',
        'de': 'Ein Tag emotionaler Verwirrung und Selbsttäuschung. Ihre Gefühle (Mond) werden durch Illusionen (Neptun) verzerrt. Es ist schwer zu wissen, was real ist und was nicht. Gefahr, betrogen zu werden, besonders von einer Frau.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Вы чувствуете себя потерянным и не понимаете своих истинных эмоций. Кто-то может обманывать вас.',
          '2': 'Риск финансовых потерь из-за обмана или мошенничества. Деньги "утекают" незаметно.',
          '3': 'Недопонимания в общении. Собеседник может быть неискренним или вы неверно его понимаете.',
          '4': 'Обман или неясная ситуация в семье. Вы можете идеализировать кого-то из родных.',
          '5': 'Вы видите в партнере то, чего нет. "Розовые очки", которые ведут к разочарованию.',
          '6': 'Упадок сил, лень, нежелание работать. Кто-то из коллег может плести интриги.',
          '7': 'Партнер может быть нечестен с вами. Отношения очень туманны и неопределенны.',
          '8': 'Обман в вопросах совместных финансов. Тайные связи, основанные на иллюзиях.',
          '9': 'Разочарование в своих идеалах. Вы можете понять, что верили в иллюзию.',
          '10': 'Неясные карьерные перспективы. Кто-то может распускать о вас ложные слухи.',
          '11': 'Разочарование в друге. Вы можете понять, что ваша дружба была неискренней.',
          '12': 'Вы становитесь жертвой чужих интриг или собственных иллюзий. Обострение зависимостей.'
        },
        'en': {
          '1': 'You feel lost and don\'t understand your true emotions. Someone might be deceiving you.',
          '2': 'Risk of financial loss due to deception or fraud. Money "slips away" unnoticed.',
          '3': 'Misunderstandings in communication. The other person may be insincere or you may misunderstand them.',
          '4': 'Deception or an unclear situation in the family. You might be idealizing a relative.',
          '5': 'You see in your partner what is not there. "Rose-colored glasses" that lead to disappointment.',
          '6': 'Lack of energy, laziness, unwillingness to work. A colleague might be plotting intrigues.',
          '7': 'A partner may be dishonest with you. The relationship is very foggy and uncertain.',
          '8': 'Deception in matters of joint finances. Secret affairs based on illusions.',
          '9': 'Disappointment in your ideals. You may realize you were believing in an illusion.',
          '10': 'Unclear career prospects. Someone may be spreading false rumors about you.',
          '11': 'Disappointment in a friend. You may realize your friendship was insincere.',
          '12': 'You become a victim of others\' intrigues or your own illusions. Worsening of addictions.'
        },
        'fr': {
          '1': 'Vous vous sentez perdu et ne comprenez pas vos vraies émotions. Quelqu\'un pourrait vous tromper.',
          '2': 'Risque de perte financière due à la tromperie ou à la fraude. L\'argent "s\'échappe" sans qu\'on s\'en aperçoive.',
          '3': 'Malentendus dans la communication. L\'autre personne peut manquer de sincérité ou vous la comprenez mal.',
          '4': 'Tromperie ou situation floue dans la famille. Vous pourriez idéaliser un parent.',
          '5': 'Vous voyez chez votre partenaire ce qui n\'existe pas. Des "lunettes roses" qui mènent à la déception.',
          '6': 'Manque d\'énergie, paresse, refus de travailler. Un collègue pourrait manigancer des intrigues.',
          '7': 'Un partenaire peut être malhonnête avec vous. La relation est très floue et incertaine.',
          '8': 'Tromperie en matière de finances communes. Liaisons secrètes basées sur des illusions.',
          '9': 'Déception de vos idéaux. Vous pourriez réaliser que vous croyiez en une illusion.',
          '10': 'Perspectives de carrière floues. Quelqu\'un pourrait répandre de fausses rumeurs à votre sujet.',
          '11': 'Déception envers un ami. Vous pourriez réaliser que votre amitié n\'était pas sincère.',
          '12': 'Vous devenez victime des intrigues des autres ou de vos propres illusions. Aggravation des dépendances.'
        },
        'de': {
          '1': 'Sie fühlen sich verloren und verstehen Ihre wahren Emotionen nicht. Jemand könnte Sie täuschen.',
          '2': 'Risiko eines finanziellen Verlusts durch Täuschung oder Betrug. Geld "entgleitet" unbemerkt.',
          '3': 'Missverständnisse in der Kommunikation. Die andere Person könnte unaufrichtig sein oder Sie verstehen sie falsch.',
          '4': 'Täuschung oder eine unklare Situation in der Familie. Sie könnten einen Verwandten idealisieren.',
          '5': 'Sie sehen in Ihrem Partner, was nicht da ist. Eine "rosarote Brille", die zu Enttäuschungen führt.',
          '6': 'Energiemangel, Faulheit, Arbeitsunlust. Ein Kollege könnte Intrigen spinnen.',
          '7': 'Ein Partner könnte unehrlich zu Ihnen sein. Die Beziehung ist sehr neblig und unsicher.',
          '8': 'Täuschung in Fragen gemeinsamer Finanzen. Geheime Affären, die auf Illusionen beruhen.',
          '9': 'Enttäuschung von Ihren Idealen. Sie könnten erkennen, dass Sie an eine Illusion geglaubt haben.',
          '10': 'Unklare Karriereaussichten. Jemand könnte falsche Gerüchte über Sie verbreiten.',
          '11': 'Enttäuschung von einem Freund. Sie könnten erkennen, dass Ihre Freundschaft unaufrichtig war.',
          '12': 'Sie werden Opfer von Intrigen anderer oder Ihrer eigenen Illusionen. Verschlimmerung von Süchten.'
        }
      }
    ),
    AspectInterpretation(
      id: 'MARS_CONJUNCT_SATURN',
      title: {
        'ru': 'Соединение Марса и Сатурна',
        'en': 'Mars Conjunct Saturn',
        'fr': 'Mars Conjoint Saturne',
        'de': 'Mars-Konjunktion-Saturn'
      },
      descriptionGeneral: {
        'ru': 'Очень сложный день. Ваши действия (Марс) наталкиваются на непреодолимые препятствия (Сатурн). Огромная фрустрация, задержки, ощущение "удара о стену". Требуется огромное терпение и дисциплина.',
        'en': 'A very difficult day. Your actions (Mars) encounter insurmountable obstacles (Saturn). Huge frustration, delays, a feeling of "hitting a wall." Tremendous patience and discipline are required.',
        'fr': 'Une journée très difficile. Vos actions (Mars) se heurtent à des obstacles insurmontables (Saturne). Énorme frustration, retards, sensation de "se heurter à un mur". Une patience et une discipline extraordinaires sont requises.',
        'de': 'Ein sehr schwieriger Tag. Ihre Handlungen (Mars) stoßen auf unüberwindbare Hindernisse (Saturn). Enorme Frustration, Verzögerungen, ein Gefühl, "gegen eine Wand zu laufen". Enorme Geduld und Disziplin sind erforderlich.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Все ваши инициативы блокируются. Ощущение бессилия и скованности. Повышенный травматизм.',
          '2': 'Финансовые блоки. Упорный труд не приносит результата, задержки зарплаты.',
          '3': 'Очень трудное общение. Ваши слова не слышат или блокируют. Срыв поездок.',
          '4': 'Тяжелая и давящая атмосфера дома. Конфликты со старшими. Препятствия в ремонте.',
          '5': 'Полный блок в творчестве и романтике. Охлаждение чувств, невозможность радоваться.',
          '6': 'Работа превращается в каторгу. Вы делаете много, но не видите результата. Конфликт с начальством.',
          '7': 'Стена непонимания с партнером. Отношения проходят серьезнейшую проверку.',
          '8': 'Финансовый кризис. Долги, налоги, обязательства давят как никогда.',
          '9': 'Ваши планы на путешествие или учебу полностью блокируются.',
          '10': 'Серьезнейшие препятствия в карьере. Конфликт с властями, угроза увольнения.',
          '11': 'Планы и мечты рушатся. Друзья не могут или не хотят помочь.',
          '12': 'Ваши внутренние страхи и комплексы парализуют вашу волю. Ощущение полного тупика.'
        },
        'en': {
          '1': 'All your initiatives are blocked. A feeling of powerlessness and constraint. Increased risk of injury.',
          '2': 'Financial blocks. Hard work brings no results, salary delays.',
          '3': 'Very difficult communication. Your words are not heard or are blocked. Disruption of trips.',
          '4': 'A heavy and oppressive atmosphere at home. Conflicts with elders. Obstacles in repairs.',
          '5': 'A complete block in creativity and romance. A cooling of feelings, inability to rejoice.',
          '6': 'Work turns into hard labor. You do a lot but see no results. Conflict with the boss.',
          '7': 'A wall of misunderstanding with a partner. The relationship is undergoing a most serious test.',
          '8': 'Financial crisis. Debts, taxes, and obligations are more pressing than ever.',
          '9': 'Your travel or study plans are completely blocked.',
          '10': 'The most serious obstacles in your career. Conflict with authorities, threat of dismissal.',
          '11': 'Plans and dreams are collapsing. Friends cannot or will not help.',
          '12': 'Your inner fears and complexes paralyze your will. A feeling of a complete dead end.'
        },
        'fr': {
          '1': 'Toutes vos initiatives sont bloquées. Un sentiment d\'impuissance et de contrainte. Risque accru de blessure.',
          '2': 'Blocages financiers. Le travail acharné n\'apporte aucun résultat, retards de salaire.',
          '3': 'Communication très difficile. Vos paroles ne sont pas entendues ou sont bloquées. Perturbation des voyages.',
          '4': 'Une atmosphère lourde et oppressante à la maison. Conflits avec les aînés. Obstacles dans les réparations.',
          '5': 'Un blocage complet dans la créativité et la romance. Un refroidissement des sentiments, une incapacité à se réjouir.',
          '6': 'Le travail se transforme en travaux forcés. Vous faites beaucoup mais ne voyez aucun résultat. Conflit avec le patron.',
          '7': 'Un mur d\'incompréhension avec un partenaire. La relation subit une épreuve des plus sérieuses.',
          '8': 'Crise financière. Les dettes, les impôts et les obligations sont plus pressants que jamais.',
          '9': 'Vos projets de voyage ou d\'études sont complètement bloqués.',
          '10': 'Les obstacles les plus sérieux dans votre carrière. Conflit avec les autorités, menace de licenciement.',
          '11': 'Les projets et les rêves s\'effondrent. Les amis ne peuvent ou ne veulent pas aider.',
          '12': 'Vos peurs et complexes intérieurs paralysent votre volonté. Un sentiment d\'impasse totale.'
        },
        'de': {
          '1': 'Alle Ihre Initiativen sind blockiert. Ein Gefühl der Ohnmacht und der Einschränkung. Erhöhtes Verletzungsrisiko.',
          '2': 'Finanzielle Blockaden. Harte Arbeit bringt keine Ergebnisse, Gehaltsverzögerungen.',
          '3': 'Sehr schwierige Kommunikation. Ihre Worte werden nicht gehört oder blockiert. Störung von Reisen.',
          '4': 'Eine schwere und bedrückende Atmosphäre zu Hause. Konflikte mit Älteren. Hindernisse bei Reparaturen.',
          '5': 'Eine vollständige Blockade in Kreativität und Romantik. Eine Abkühlung der Gefühle, Unfähigkeit zur Freude.',
          '6': 'Die Arbeit wird zur Zwangsarbeit. Sie tun viel, sehen aber keine Ergebnisse. Konflikt mit dem Chef.',
          '7': 'Eine Mauer des Missverständnisses mit einem Partner. Die Beziehung durchläuft eine sehr ernste Prüfung.',
          '8': 'Finanzkrise. Schulden, Steuern und Verpflichtungen sind drängender denn je.',
          '9': 'Ihre Reise- oder Studienpläne sind vollständig blockiert.',
          '10': 'Die schwerwiegendsten Hindernisse in Ihrer Karriere. Konflikt mit Behörden, drohende Entlassung.',
          '11': 'Pläne und Träume zerplatzen. Freunde können oder wollen nicht helfen.',
          '12': 'Ihre inneren Ängste und Komplexe lähmen Ihren Willen. Ein Gefühl einer völligen Sackgasse.'
        }
      }
    ),
    AspectInterpretation(
      id: 'JUPITER_SEXTILE_PLUTO',
      title: {
        'ru': 'Шанс от Юпитера и Плутона',
        'en': 'Jupiter Sextile Pluto',
        'fr': 'Jupiter Sextile Pluton',
        'de': 'Jupiter-Sextil-Pluto'
      },
      descriptionGeneral: {
        'ru': 'День дает возможность для глубоких позитивных трансформаций и расширения своего влияния. Появляется шанс использовать свою власть и ресурсы во благо для достижения больших целей.',
        'en': 'The day provides an opportunity for deep positive transformations and expanding one\'s influence. A chance arises to use your power and resources for good to achieve great goals.',
        'fr': 'La journée offre une opportunité de transformations positives profondes et d\'expansion de son influence. Une chance se présente d\'utiliser son pouvoir et ses ressources pour le bien afin d\'atteindre de grands objectifs.',
        'de': 'Der Tag bietet eine Gelegenheit für tiefgreifende positive Transformationen und die Erweiterung des eigenen Einflusses. Es ergibt sich die Chance, Ihre Macht und Ressourcen zum Guten zu nutzen, um große Ziele zu erreichen.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Появляется возможность усилить свой авторитет и личное влияние на окружающих.',
          '2': 'Шанс найти мощный финансовый ресурс или кардинально улучшить свое материальное положение.',
          '3': 'Ваши слова обретают огромную силу. Возможность провести очень влиятельные переговоры.',
          '4': 'Шанс укрепить фундамент семьи, решить вопросы с недвижимостью или наследством.',
          '5': 'Возможность для глубокой и страстной трансформации в любви. Удача в крупных ставках.',
          '6': 'Шанс реорганизовать свою работу так, чтобы она стала гораздо эффективнее.',
          '7': 'Возможность найти влиятельного партнера или укрепить существующие отношения.',
          '8': 'Удачное время для крупных инвестиций, решения вопросов с кредитами и налогами.',
          '9': 'Ваши идеи и убеждения могут получить мощную поддержку и распространение.',
          '10': 'Большой шанс для карьерного роста. Вы можете получить больше власти и влияния.',
          '11': 'Возможность найти влиятельных друзей или покровителей.',
          '12': 'Шанс через духовные практики или психологическую работу достичь мощной внутренней трансформации.'
        },
        'en': {
          '1': 'An opportunity arises to strengthen your authority and personal influence on others.',
          '2': 'A chance to find a powerful financial resource or radically improve your financial situation.',
          '3': 'Your words gain immense power. An opportunity to conduct very influential negotiations.',
          '4': 'A chance to strengthen the family foundation, resolve issues with real estate or inheritance.',
          '5': 'An opportunity for a deep and passionate transformation in love. Luck in high-stakes betting.',
          '6': 'A chance to reorganize your work to make it much more effective.',
          '7': 'An opportunity to find an influential partner or strengthen existing relationships.',
          '8': 'A good time for large investments, resolving issues with loans and taxes.',
          '9': 'Your ideas and beliefs can receive powerful support and dissemination.',
          '10': 'A great chance for career growth. You can gain more power and influence.',
          '11': 'An opportunity to find influential friends or patrons.',
          '12': 'A chance to achieve a powerful inner transformation through spiritual practices or psychological work.'
        },
        'fr': {
          '1': 'Une opportunité se présente de renforcer votre autorité et votre influence personnelle sur les autres.',
          '2': 'Une chance de trouver une ressource financière puissante ou d\'améliorer radicalement votre situation financière.',
          '3': 'Vos paroles acquièrent un pouvoir immense. Une opportunité de mener des négociations très influentes.',
          '4': 'Une chance de renforcer les fondations de la famille, de résoudre des problèmes immobiliers ou de succession.',
          '5': 'Une opportunité pour une transformation profonde et passionnée en amour. Chance dans les paris à gros enjeux.',
          '6': 'Une chance de réorganiser votre travail pour le rendre beaucoup plus efficace.',
          '7': 'Une opportunité de trouver un partenaire influent ou de renforcer les relations existantes.',
          '8': 'Un bon moment pour les grands investissements, la résolution des problèmes de prêts et d\'impôts.',
          '9': 'Vos idées et croyances peuvent recevoir un soutien et une diffusion puissants.',
          '10': 'Une grande chance de croissance de carrière. Vous pouvez gagner plus de pouvoir et d\'influence.',
          '11': 'Une opportunité de trouver des amis ou des mécènes influents.',
          '12': 'Une chance de réaliser une puissante transformation intérieure par des pratiques spirituelles ou un travail psychologique.'
        },
        'de': {
          '1': 'Es ergibt sich die Gelegenheit, Ihre Autorität und Ihren persönlichen Einfluss auf andere zu stärken.',
          '2': 'Eine Chance, eine starke finanzielle Ressource zu finden oder Ihre finanzielle Situation radikal zu verbessern.',
          '3': 'Ihre Worte gewinnen immense Macht. Eine Gelegenheit, sehr einflussreiche Verhandlungen zu führen.',
          '4': 'Eine Chance, das Familienfundament zu stärken, Probleme mit Immobilien oder Erbschaften zu lösen.',
          '5': 'Eine Gelegenheit für eine tiefe und leidenschaftliche Transformation in der Liebe. Glück bei Wetten mit hohen Einsätzen.',
          '6': 'Eine Chance, Ihre Arbeit neu zu organisieren, um sie wesentlich effektiver zu machen.',
          '7': 'Eine Gelegenheit, einen einflussreichen Partner zu finden oder bestehende Beziehungen zu stärken.',
          '8': 'Eine gute Zeit für große Investitionen, die Lösung von Problemen mit Krediten und Steuern.',
          '9': 'Ihre Ideen und Überzeugungen können starke Unterstützung und Verbreitung finden.',
          '10': 'Eine große Chance für den beruflichen Aufstieg. Sie können mehr Macht und Einfluss gewinnen.',
          '11': 'Eine Gelegenheit, einflussreiche Freunde oder Gönner zu finden.',
          '12': 'Eine Chance, durch spirituelle Praktiken oder psychologische Arbeit eine kraftvolle innere Transformation zu erreichen.'
        }
      }
    ),
            // === НОВЫЙ БЛОК 21 ===
    AspectInterpretation(
      id: 'JUPITER_SEXTILE_URANUS',
      title: {
        'ru': 'Шанс от Юпитера и Урана',
        'en': 'Jupiter Sextile Uranus',
        'fr': 'Jupiter Sextile Uranus',
        'de': 'Jupiter-Sextil-Uranus'
      },
      descriptionGeneral: {
        'ru': 'День счастливых случайностей и неожиданных возможностей для роста. Появляется шанс попробовать что-то новое, что приведет к успеху. Будьте открыты к экспериментам и переменам!',
        'en': 'A day of happy coincidences and unexpected opportunities for growth. A chance arises to try something new that will lead to success. Be open to experiments and changes!',
        'fr': 'Une journée d\'heureuses coïncidences et d\'opportunités de croissance inattendues. Une chance se présente d\'essayer quelque chose de nouveau qui mènera au succès. Soyez ouvert aux expériences et aux changements !',
        'de': 'Ein Tag glücklicher Zufälle und unerwarteter Wachstumschancen. Es ergibt sich die Chance, etwas Neues auszuprobieren, das zum Erfolg führen wird. Seien Sie offen für Experimente und Veränderungen!'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Неожиданная возможность проявить себя с новой стороны, что принесет вам популярность.',
          '2': 'Шанс на внезапный финансовый выигрыш или удачную находку. Новые технологии могут принести доход.',
          '3': 'Неожиданное знакомство или новость открывает новые горизонты. Внезапные гениальные идеи.',
          '4': 'Возможность для внезапных, но позитивных перемен в доме. Удачная покупка техники.',
          '5': 'Шанс на неожиданное и волнующее романтическое приключение. Внезапная удача в хобби.',
          '6': 'Неожиданные улучшения на работе. Новые технологии или методы облегчают ваш труд.',
          '7': 'Возможность познакомиться с очень необычным и интересным человеком. Отношения получают глоток свежего воздуха.',
          '8': 'Шанс на неожиданную финансовую удачу через партнера, инвестиции или наследство.',
          '9': 'Внезапная возможность отправиться в путешествие мечты. Новые идеи кардинально меняют мировоззрение.',
          '10': 'Неожиданный карьерный шанс. Ваши оригинальные идеи могут быть замечены и вознаграждены.',
          '11': 'Друзья могут преподнести приятный сюрприз или подкинуть удачную возможность.',
          '12': 'Внезапное озарение помогает освободиться от старых ограничений. Удача приходит тайно.'
        },
        'en': {
          '1': 'An unexpected opportunity to show a new side of yourself, which will bring you popularity.',
          '2': 'A chance for a sudden financial win or a lucky find. New technologies can bring income.',
          '3': 'An unexpected acquaintance or news opens up new horizons. Sudden brilliant ideas.',
          '4': 'An opportunity for sudden but positive changes at home. A successful purchase of electronics.',
          '5': 'A chance for an unexpected and exciting romantic adventure. Sudden luck in a hobby.',
          '6': 'Unexpected improvements at work. New technologies or methods make your work easier.',
          '7': 'An opportunity to meet a very unusual and interesting person. Relationships get a breath of fresh air.',
          '8': 'A chance for unexpected financial luck through a partner, investments, or inheritance.',
          '9': 'A sudden opportunity to go on a dream trip. New ideas radically change your worldview.',
          '10': 'An unexpected career chance. Your original ideas may be noticed and rewarded.',
          '11': 'Friends may offer a pleasant surprise or a lucky opportunity.',
          '12': 'A sudden insight helps to break free from old limitations. Luck comes secretly.'
        },
        'fr': {
          '1': 'Une opportunité inattendue de montrer une nouvelle facette de vous-même, ce qui vous apportera de la popularité.',
          '2': 'Une chance de gain financier soudain ou une trouvaille chanceuse. Les nouvelles technologies peuvent apporter des revenus.',
          '3': 'Une connaissance ou une nouvelle inattendue ouvre de nouveaux horizons. Idées brillantes soudaines.',
          '4': 'Une opportunité de changements soudains mais positifs à la maison. Un achat d\'électronique réussi.',
          '5': 'Une chance pour une aventure romantique inattendue et excitante. Chance soudaine dans un passe-temps.',
          '6': 'Améliorations inattendues au travail. De nouvelles technologies ou méthodes facilitent votre travail.',
          '7': 'Une opportunité de rencontrer une personne très inhabituelle et intéressante. Les relations reçoivent un nouveau souffle.',
          '8': 'Une chance de chance financière inattendue par l\'intermédiaire d\'un partenaire, d\'investissements ou d\'un héritage.',
          '9': 'Une opportunité soudaine de faire un voyage de rêve. De nouvelles idées changent radicalement votre vision du monde.',
          '10': 'Une chance de carrière inattendue. Vos idées originales peuvent être remarquées et récompensées.',
          '11': 'Les amis peuvent offrir une agréable surprise ou une opportunité chanceuse.',
          '12': 'Une prise de conscience soudaine aide à se libérer des anciennes limitations. La chance vient secrètement.'
        },
        'de': {
          '1': 'Eine unerwartete Gelegenheit, eine neue Seite von sich zu zeigen, die Ihnen Popularität bringen wird.',
          '2': 'Eine Chance auf einen plötzlichen finanziellen Gewinn oder einen glücklichen Fund. Neue Technologien können Einkommen bringen.',
          '3': 'Eine unerwartete Bekanntschaft oder Nachricht eröffnet neue Horizonte. Plötzliche brillante Ideen.',
          '4': 'Eine Gelegenheit für plötzliche, aber positive Veränderungen zu Hause. Ein erfolgreicher Kauf von Elektronik.',
          '5': 'Eine Chance auf ein unerwartetes und aufregendes romantisches Abenteuer. Plötzliches Glück in einem Hobby.',
          '6': 'Unerwartete Verbesserungen bei der Arbeit. Neue Technologien oder Methoden erleichtern Ihre Arbeit.',
          '7': 'Eine Gelegenheit, eine sehr ungewöhnliche und interessante Person zu treffen. Beziehungen bekommen frischen Wind.',
          '8': 'Eine Chance auf unerwartetes finanzielles Glück durch einen Partner, Investitionen oder eine Erbschaft.',
          '9': 'Eine plötzliche Gelegenheit, eine Traumreise zu unternehmen. Neue Ideen verändern Ihre Weltanschauung radikal.',
          '10': 'Eine unerwartete Karrierechance. Ihre originellen Ideen können bemerkt und belohnt werden.',
          '11': 'Freunde können eine angenehme Überraschung oder eine glückliche Gelegenheit bieten.',
          '12': 'Eine plötzliche Einsicht hilft, sich von alten Beschränkungen zu befreien. Glück kommt heimlich.'
        }
      }
    ),
    AspectInterpretation(
      id: 'MERCURY_OPPOSITION_URANUS',
      title: {
        'ru': 'Противостояние Меркурия и Урана',
        'en': 'Mercury Opposition Uranus',
        'fr': 'Mercure Opposition Uranus',
        'de': 'Merkur-Opposition-Uranus'
      },
      descriptionGeneral: {
        'ru': 'День ментального хаоса и срыва договоренностей. Ваши идеи сталкиваются с непредсказуемым поведением других. Нервозность, споры, шокирующие новости. Избегайте подписания документов.',
        'en': 'A day of mental chaos and broken agreements. Your ideas clash with the unpredictable behavior of others. Nervousness, arguments, shocking news. Avoid signing documents.',
        'fr': 'Une journée de chaos mental et d\'accords rompus. Vos idées se heurtent au comportement imprévisible des autres. Nervosité, disputes, nouvelles choquantes. Évitez de signer des documents.',
        'de': 'Ein Tag des mentalen Chaos und gebrochener Vereinbarungen. Ihre Ideen kollidieren mit dem unvorhersehbaren Verhalten anderer. Nervosität, Auseinandersetzungen, schockierende Nachrichten. Vermeiden Sie das Unterzeichnen von Dokumenten.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Ваши слова и идеи могут быть восприняты как слишком эксцентричные. Кто-то постоянно сбивает вас с мысли.',
          '2': 'Неожиданные новости, которые негативно влияют на ваши финансы. Срыв сделки.',
          '3': 'Ссора с другом или родственником, который ведет себя непредсказуемо. Опасность на дороге.',
          '4': 'Внезапные и неприятные новости, касающиеся семьи или дома. Поломка техники.',
          '5': 'Неожиданный и неприятный разговор с любимым человеком, который может привести к разрыву.',
          '6': 'Хаос на работе. Договоренности с коллегами срываются в последний момент.',
          '7': 'Партнер ведет себя совершенно непредсказуемо, что рушит все ваши совместные планы.',
          '8': 'Шокирующая информация, которая приводит к финансовому или эмоциональному кризису.',
          '9': 'Ваши идеи сталкиваются с резким и неожиданным сопротивлением. Срыв поездки.',
          '10': 'Неожиданные события, которые ставят под угрозу вашу карьеру. Конфликт с начальством.',
          '11': 'Ссора и разрыв с другом из-за разных взглядов или непредсказуемого поступка.',
          '12': 'Внезапная тревожная информация из тайных источников. Нервное напряжение.'
        },
        'en': {
          '1': 'Your words and ideas may be perceived as too eccentric. Someone is constantly interrupting your train of thought.',
          '2': 'Unexpected news that negatively affects your finances. A deal falls through.',
          '3': 'A quarrel with a friend or relative who behaves unpredictably. Danger on the road.',
          '4': 'Sudden and unpleasant news concerning family or home. Equipment breakdown.',
          '5': 'An unexpected and unpleasant conversation with a loved one that could lead to a breakup.',
          '6': 'Chaos at work. Agreements with colleagues fall through at the last minute.',
          '7': 'A partner behaves completely unpredictably, ruining all your joint plans.',
          '8': 'Shocking information that leads to a financial or emotional crisis.',
          '9': 'Your ideas meet with sharp and unexpected resistance. A trip is canceled.',
          '10': 'Unexpected events that threaten your career. A conflict with your boss.',
          '11': 'A quarrel and breakup with a friend due to different views or an unpredictable act.',
          '12': 'Sudden alarming information from secret sources. Nervous tension.'
        },
        'fr': {
          '1': 'Vos paroles et vos idées peuvent être perçues comme trop excentriques. Quelqu\'un interrompt constamment le fil de votre pensée.',
          '2': 'Nouvelles inattendues qui affectent négativement vos finances. Un accord échoue.',
          '3': 'Une querelle avec un ami ou un parent qui se comporte de manière imprévisible. Danger sur la route.',
          '4': 'Nouvelles soudaines et désagréables concernant la famille ou la maison. Panne d\'équipement.',
          '5': 'Une conversation inattendue et désagréable avec un être cher qui pourrait conduire à une rupture.',
          '6': 'Chaos au travail. Les accords avec les collègues échouent à la dernière minute.',
          '7': 'Un partenaire se comporte de manière totalement imprévisible, ruinant tous vos plans communs.',
          '8': 'Informations choquantes qui mènent à une crise financière ou émotionnelle.',
          '9': 'Vos idées rencontrent une résistance vive et inattendue. Un voyage est annulé.',
          '10': 'Événements inattendus qui menacent votre carrière. Un conflit avec votre patron.',
          '11': 'Une querelle et une rupture avec un ami en raison de points de vue différents ou d\'un acte imprévisible.',
          '12': 'Informations alarmantes soudaines provenant de sources secrètes. Tension nerveuse.'
        },
        'de': {
          '1': 'Ihre Worte und Ideen können als zu exzentrisch empfunden werden. Jemand unterbricht ständig Ihren Gedankengang.',
          '2': 'Unerwartete Nachrichten, die sich negativ auf Ihre Finanzen auswirken. Ein Geschäft platzt.',
          '3': 'Ein Streit mit einem Freund oder Verwandten, der sich unvorhersehbar verhält. Gefahr auf der Straße.',
          '4': 'Plötzliche und unangenehme Nachrichten bezüglich Familie oder Zuhause. Geräteausfall.',
          '5': 'Ein unerwartetes und unangenehmes Gespräch mit einem geliebten Menschen, das zu einer Trennung führen könnte.',
          '6': 'Chaos bei der Arbeit. Vereinbarungen mit Kollegen scheitern in letzter Minute.',
          '7': 'Ein Partner verhält sich völlig unvorhersehbar und durchkreuzt alle Ihre gemeinsamen Pläne.',
          '8': 'Schockierende Informationen, die zu einer finanziellen oder emotionalen Krise führen.',
          '9': 'Ihre Ideen stoßen auf scharfen und unerwarteten Widerstand. Eine Reise wird abgesagt.',
          '10': 'Unerwartete Ereignisse, die Ihre Karriere bedrohen. Ein Konflikt mit Ihrem Chef.',
          '11': 'Ein Streit und eine Trennung von einem Freund aufgrund unterschiedlicher Ansichten oder einer unvorhersehbaren Handlung.',
          '12': 'Plötzliche alarmierende Informationen aus geheimen Quellen. Nervöse Anspannung.'
        }
      }
    ),
    AspectInterpretation(
      id: 'SUN_CONJUNCT_URANUS',
      title: {
        'ru': 'Соединение Солнца и Урана',
        'en': 'Sun Conjunct Uranus',
        'fr': 'Soleil Conjoint Uranus',
        'de': 'Sonne-Konjunktion-Uranus'
      },
      descriptionGeneral: {
        'ru': 'День бунтарства, свободы и внезапных перемен. Ваше "Я" (Солнце) требует обновления (Уран). Сильное желание сбросить оковы, сделать что-то неожиданное. Возможны гениальные озарения.',
        'en': 'A day of rebellion, freedom, and sudden changes. Your "self" (Sun) demands renewal (Uranus). A strong desire to break free, to do something unexpected. Brilliant insights are possible.',
        'fr': 'Une journée de rébellion, de liberté et de changements soudains. Votre "moi" (Soleil) demande un renouveau (Uranus). Un fort désir de se libérer, de faire quelque chose d\'inattendu. Des intuitions brillantes sont possibles.',
        'de': 'Ein Tag der Rebellion, Freiheit und plötzlichen Veränderungen. Ihr "Ich" (Sonne) verlangt nach Erneuerung (Uranus). Ein starker Wunsch, sich zu befreien, etwas Unerwartetes zu tun. Brillante Einsichten sind möglich.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Вы полны желания перемен. Резкая смена имиджа, поведения. Вы можете шокировать окружающих.',
          '2': 'Внезапные финансовые события. Можно как неожиданно заработать, так и все потратить.',
          '3': 'Гениальные, революционные идеи. Вы можете сказать что-то, что изменит все.',
          '4': 'Желание кардинальных перемен в доме. Внезапный переезд или разрыв с семейными традициями.',
          '5': 'Внезапная влюбленность или резкий разрыв. Отношениям нужна свобода.',
          '6': 'Желание бросить рутинную работу. Внезапные изменения в рабочем процессе.',
          '7': 'Резкие и неожиданные события в партнерстве. Возможно как внезапное знакомство, так и разрыв.',
          '8': 'Внезапный кризис, который приводит к глубокой трансформации.',
          '9': 'Резкая смена мировоззрения. Внезапное решение отправиться в путешествие.',
          '10': 'Революция в карьере. Вы можете резко сменить профессию или бросить вызов начальству.',
          '11': 'Вы можете стать центром притяжения для друзей-единомышленников или резко порвать с группой.',
          '12': 'Внезапное озарение, которое вскрывает ваши тайны или освобождает от страхов.'
        },
        'en': {
          '1': 'You are full of a desire for change. A sharp change in image, behavior. You might shock others.',
          '2': 'Sudden financial events. You can either make unexpected money or spend it all.',
          '3': 'Brilliant, revolutionary ideas. You might say something that changes everything.',
          '4': 'A desire for radical changes at home. A sudden move or a break with family traditions.',
          '5': 'A sudden infatuation or a sharp breakup. Relationships need freedom.',
          '6': 'A desire to quit a routine job. Sudden changes in the work process.',
          '7': 'Sharp and unexpected events in a partnership. Both a sudden acquaintance and a breakup are possible.',
          '8': 'A sudden crisis that leads to a deep transformation.',
          '9': 'A sharp change in worldview. A sudden decision to go on a trip.',
          '10': 'A revolution in your career. You might abruptly change your profession or challenge your boss.',
          '11': 'You can become a center of attraction for like-minded friends or abruptly break with a group.',
          '12': 'A sudden insight that reveals your secrets or frees you from fears.'
        },
        'fr': {
          '1': 'Vous êtes plein d\'un désir de changement. Un changement brusque d\'image, de comportement. Vous pourriez choquer les autres.',
          '2': 'Événements financiers soudains. Vous pouvez soit gagner de l\'argent de manière inattendue, soit tout dépenser.',
          '3': 'Idées brillantes et révolutionnaires. Vous pourriez dire quelque chose qui change tout.',
          '4': 'Un désir de changements radicaux à la maison. Un déménagement soudain ou une rupture avec les traditions familiales.',
          '5': 'Un engouement soudain ou une rupture brutale. Les relations ont besoin de liberté.',
          '6': 'Un désir de quitter un travail routinier. Changements soudains dans le processus de travail.',
          '7': 'Événements brusques et inattendus dans un partenariat. Une connaissance soudaine et une rupture sont possibles.',
          '8': 'Une crise soudaine qui conduit à une profonde transformation.',
          '9': 'Un changement brusque de vision du monde. Une décision soudaine de partir en voyage.',
          '10': 'Une révolution dans votre carrière. Vous pourriez changer brusquement de profession ou défier votre patron.',
          '11': 'Vous pouvez devenir un centre d\'attraction pour des amis partageant les mêmes idées ou rompre brusquement avec un groupe.',
          '12': 'Une prise de conscience soudaine qui révèle vos secrets ou vous libère de vos peurs.'
        },
        'de': {
          '1': 'Sie sind voller Wunsch nach Veränderung. Eine scharfe Veränderung des Images, des Verhaltens. Sie könnten andere schockieren.',
          '2': 'Plötzliche finanzielle Ereignisse. Sie können entweder unerwartet Geld verdienen oder alles ausgeben.',
          '3': 'Brillante, revolutionäre Ideen. Sie könnten etwas sagen, das alles verändert.',
          '4': 'Ein Wunsch nach radikalen Veränderungen zu Hause. Ein plötzlicher Umzug oder ein Bruch mit Familientraditionen.',
          '5': 'Eine plötzliche Verliebtheit oder eine scharfe Trennung. Beziehungen brauchen Freiheit.',
          '6': 'Ein Wunsch, einen Routinejob zu kündigen. Plötzliche Änderungen im Arbeitsprozess.',
          '7': 'Scharfe und unerwartete Ereignisse in einer Partnerschaft. Sowohl eine plötzliche Bekanntschaft als auch eine Trennung sind möglich.',
          '8': 'Eine plötzliche Krise, die zu einer tiefen Transformation führt.',
          '9': 'Eine scharfe Veränderung der Weltanschauung. Eine plötzliche Entscheidung, auf eine Reise zu gehen.',
          '10': 'Eine Revolution in Ihrer Karriere. Sie könnten abrupt Ihren Beruf wechseln oder Ihren Chef herausfordern.',
          '11': 'Sie können zum Anziehungspunkt für gleichgesinnte Freunde werden oder abrupt mit einer Gruppe brechen.',
          '12': 'Eine plötzliche Einsicht, die Ihre Geheimnisse enthüllt oder Sie von Ängsten befreit.'
        }
      }
    ),
    AspectInterpretation(
      id: 'VENUS_SEXTILE_PLUTO',
      title: {
        'ru': 'Шанс от Венеры и Плутона',
        'en': 'Venus Sextile Pluto',
        'fr': 'Vénus Sextile Pluton',
        'de': 'Venus-Sextil-Pluto'
      },
      descriptionGeneral: {
        'ru': 'День дает возможность для глубокой трансформации чувств и отношений. Появляется шанс исцелить старые раны, достичь большей близости и укрепить финансовое положение.',
        'en': 'The day provides an opportunity for a deep transformation of feelings and relationships. A chance arises to heal old wounds, achieve greater intimacy, and strengthen one\'s financial position.',
        'fr': 'La journée offre une opportunité pour une transformation profonde des sentiments et des relations. Une chance se présente de guérir de vieilles blessures, d\'atteindre une plus grande intimité et de renforcer sa situation financière.',
        'de': 'Der Tag bietet die Möglichkeit für eine tiefe Transformation von Gefühlen und Beziehungen. Es ergibt sich die Chance, alte Wunden zu heilen, größere Intimität zu erreichen und die eigene finanzielle Position zu stärken.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Ваше обаяние обретает магнетическую глубину. Появляется возможность изменить свой имидж к лучшему.',
          '2': 'Шанс найти мощный финансовый ресурс или выгодно инвестировать.',
          '3': 'Возможность для глубокого и исцеляющего разговора, который изменит отношения.',
          '4': 'Шанс решить застарелую семейную проблему и укрепить отношения с родными.',
          '5': 'Появляется возможность вывести романтические отношения на новый, более глубокий и страстный уровень.',
          '6': 'Шанс внести позитивные и глубокие изменения в свою работу или отношения с коллегами.',
          '7': 'Возможность через честный и глубокий диалог исцелить и укрепить партнерство.',
          '8': 'Шанс на глубокую интимную близость. Возможность решить сложный финансовый вопрос.',
          '9': 'Обучение или поездка могут дать вам возможность для мощной внутренней трансформации.',
          '10': 'Ваше обаяние и проницательность могут дать вам шанс укрепить свое влияние в карьере.',
          '11': 'Возможность для очень глубокого и искреннего разговора с другом.',
          '12': 'Шанс через самоанализ понять и исцелить свои глубокие страхи, связанные с любовью.'
        },
        'en': {
          '1': 'Your charm acquires a magnetic depth. An opportunity arises to change your image for the better.',
          '2': 'A chance to find a powerful financial resource or make a profitable investment.',
          '3': 'An opportunity for a deep and healing conversation that will change a relationship.',
          '4': 'A chance to solve a long-standing family problem and strengthen relationships with relatives.',
          '5': 'An opportunity arises to take a romantic relationship to a new, deeper, and more passionate level.',
          '6': 'A chance to make positive and deep changes in your work or relationships with colleagues.',
          '7': 'An opportunity to heal and strengthen a partnership through honest and deep dialogue.',
          '8': 'A chance for deep intimacy. An opportunity to solve a complex financial issue.',
          '9': 'Studying or a trip can give you an opportunity for a powerful inner transformation.',
          '10': 'Your charm and insight can give you a chance to strengthen your influence in your career.',
          '11': 'An opportunity for a very deep and sincere conversation with a friend.',
          '12': 'A chance to understand and heal your deep fears related to love through self-analysis.'
        },
        'fr': {
          '1': 'Votre charme acquiert une profondeur magnétique. Une opportunité se présente de changer votre image pour le mieux.',
          '2': 'Une chance de trouver une ressource financière puissante ou de faire un investissement rentable.',
          '3': 'Une opportunité pour une conversation profonde et curative qui changera une relation.',
          '4': 'Une chance de résoudre un problème familial de longue date et de renforcer les relations avec les proches.',
          '5': 'Une opportunité se présente de porter une relation amoureuse à un niveau nouveau, plus profond et plus passionné.',
          '6': 'Une chance d\'apporter des changements positifs et profonds dans votre travail ou vos relations avec vos collègues.',
          '7': 'Une opportunité de guérir et de renforcer un partenariat par un dialogue honnête et profond.',
          '8': 'Une chance d\'intimité profonde. Une opportunité de résoudre un problème financier complexe.',
          '9': 'Les études ou un voyage peuvent vous donner l\'occasion d\'une puissante transformation intérieure.',
          '10': 'Votre charme et votre perspicacité peuvent vous donner une chance de renforcer votre influence dans votre carrière.',
          '11': 'Une opportunité pour une conversation très profonde et sincère avec un ami.',
          '12': 'Une chance de comprendre et de guérir vos peurs profondes liées à l\'amour par l\'auto-analyse.'
        },
        'de': {
          '1': 'Ihr Charme erhält eine magnetische Tiefe. Es ergibt sich die Möglichkeit, Ihr Image zum Besseren zu verändern.',
          '2': 'Eine Chance, eine starke finanzielle Ressource zu finden oder eine rentable Investition zu tätigen.',
          '3': 'Eine Gelegenheit für ein tiefes und heilsames Gespräch, das eine Beziehung verändern wird.',
          '4': 'Eine Chance, ein langjähriges Familienproblem zu lösen und die Beziehungen zu Verwandten zu stärken.',
          '5': 'Es ergibt sich die Möglichkeit, eine romantische Beziehung auf ein neues, tieferes und leidenschaftlicheres Niveau zu heben.',
          '6': 'Eine Chance, positive und tiefgreifende Veränderungen in Ihrer Arbeit oder Ihren Beziehungen zu Kollegen vorzunehmen.',
          '7': 'Eine Gelegenheit, eine Partnerschaft durch ehrlichen und tiefen Dialog zu heilen und zu stärken.',
          '8': 'Eine Chance auf tiefe Intimität. Eine Gelegenheit, ein komplexes finanzielles Problem zu lösen.',
          '9': 'Ein Studium oder eine Reise kann Ihnen die Möglichkeit zu einer kraftvollen inneren Transformation geben.',
          '10': 'Ihr Charme und Ihre Einsicht können Ihnen die Chance geben, Ihren Einfluss in Ihrer Karriere zu stärken.',
          '11': 'Eine Gelegenheit für ein sehr tiefes und aufrichtiges Gespräch mit einem Freund.',
          '12': 'Eine Chance, durch Selbstanalyse Ihre tiefen Ängste im Zusammenhang mit der Liebe zu verstehen und zu heilen.'
        }
      }
    ),
            // === НОВЫЙ БЛОК 22 ===
    AspectInterpretation(
      id: 'MOON_CONJUNCT_MARS',
      title: {
        'ru': 'Соединение Луны и Марса',
        'en': 'Moon Conjunct Mars',
        'fr': 'Lune Conjointe Mars',
        'de': 'Mond-Konjunktion-Mars'
      },
      descriptionGeneral: {
        'ru': 'День сильных и импульсивных эмоций. Ваши чувства (Луна) и действия (Марс) сливаются воедино. Легко вспылить, но также и действовать решительно, защищая свои интересы. Будьте осторожны с резкостью.',
        'en': 'A day of strong and impulsive emotions. Your feelings (Moon) and actions (Mars) merge into one. It\'s easy to flare up, but also to act decisively to protect your interests. Be careful with harshness.',
        'fr': 'Une journée d\'émotions fortes et impulsives. Vos sentiments (Lune) et vos actions (Mars) fusionnent. Il est facile de s\'emporter, mais aussi d\'agir de manière décisive pour protéger ses intérêts. Attention à la brusquerie.',
        'de': 'Ein Tag starker und impulsiver Emotionen. Ihre Gefühle (Mond) und Handlungen (Mars) verschmelzen zu einer Einheit. Es ist leicht, aufzubrausen, aber auch, entschlossen zu handeln, um seine Interessen zu schützen. Seien Sie vorsichtig mit Härte.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Вы очень эмоциональны и прямолинейны. Ваши реакции быстры и инстинктивны.',
          '2': 'Импульсивные покупки под влиянием сиюминутных желаний. Решительность в финансовых вопросах.',
          '3': 'Вы говорите прямо то, что чувствуете. Возможна резкость в общении, но и предельная честность.',
          '4': 'Эмоциональная и активная обстановка дома. Легко вспылить из-за бытовых мелочей.',
          '5': 'Страстные, но потенциально конфликтные эмоции в любви. Вы не скрываете своих желаний.',
          '6': 'Вы с энтузиазмом беретесь за работу, но можете быть нетерпеливы к коллегам.',
          '7': 'Очень эмоциональные и прямые взаимодействия с партнером. Легко как поссориться, так и страстно помириться.',
          '8': 'Сильные сексуальные импульсы. Решительность в решении кризисных ситуаций.',
          '9': 'Вы эмоционально и активно отстаиваете свои убеждения.',
          '10': 'Ваши эмоции сильно влияют на ваши карьерные действия. Возможен конфликт с начальством.',
          '11': 'Вы можете стать эмоциональным лидером в группе друзей, но и спровоцировать ссору.',
          '12': 'Ваши подавленные эмоции могут прорываться в виде внезапных и импульсивных поступков.'
        },
        'en': {
          '1': 'You are very emotional and straightforward. Your reactions are quick and instinctive.',
          '2': 'Impulsive purchases under the influence of immediate desires. Decisiveness in financial matters.',
          '3': 'You speak directly what you feel. Harshness in communication is possible, but also extreme honesty.',
          '4': 'An emotional and active atmosphere at home. It\'s easy to flare up over domestic trifles.',
          '5': 'Passionate but potentially conflicting emotions in love. You don\'t hide your desires.',
          '6': 'You tackle work with enthusiasm but can be impatient with colleagues.',
          '7': 'Very emotional and direct interactions with a partner. It\'s easy to both quarrel and passionately make up.',
          '8': 'Strong sexual impulses. Decisiveness in resolving crisis situations.',
          '9': 'You emotionally and actively defend your beliefs.',
          '10': 'Your emotions strongly influence your career actions. Conflict with a boss is possible.',
          '11': 'You can become an emotional leader in a group of friends, but also provoke a quarrel.',
          '12': 'Your suppressed emotions can break out in the form of sudden and impulsive actions.'
        },
        'fr': {
          '1': 'Vous êtes très émotif et direct. Vos réactions sont rapides et instinctives.',
          '2': 'Achats impulsifs sous l\'influence de désirs immédiats. Décision en matière financière.',
          '3': 'Vous dites directement ce que vous ressentez. Une certaine brusquerie dans la communication est possible, mais aussi une extrême honnêteté.',
          '4': 'Une atmosphère émotionnelle et active à la maison. Il est facile de s\'emporter pour des broutilles domestiques.',
          '5': 'Émotions passionnées mais potentiellement conflictuelles en amour. Vous ne cachez pas vos désirs.',
          '6': 'Vous abordez le travail avec enthousiasme mais pouvez être impatient avec vos collègues.',
          '7': 'Interactions très émotives et directes avec un partenaire. Il est facile de se quereller et de se réconcilier passionnément.',
          '8': 'Fortes impulsions sexuelles. Décision dans la résolution des situations de crise.',
          '9': 'Vous défendez émotionnellement et activement vos convictions.',
          '10': 'Vos émotions influencent fortement vos actions professionnelles. Un conflit avec un patron est possible.',
          '11': 'Vous pouvez devenir un leader émotionnel dans un groupe d\'amis, mais aussi provoquer une querelle.',
          '12': 'Vos émotions refoulées peuvent éclater sous forme d\'actions soudaines et impulsives.'
        },
        'de': {
          '1': 'Sie sind sehr emotional und direkt. Ihre Reaktionen sind schnell und instinktiv.',
          '2': 'Impulsive Käufe unter dem Einfluss unmittelbarer Wünsche. Entschlossenheit in finanziellen Angelegenheiten.',
          '3': 'Sie sagen direkt, was Sie fühlen. Härte in der Kommunikation ist möglich, aber auch extreme Ehrlichkeit.',
          '4': 'Eine emotionale und aktive Atmosphäre zu Hause. Es ist leicht, über häusliche Kleinigkeiten aufzubrausen.',
          '5': 'Leidenschaftliche, aber potenziell konfliktreiche Emotionen in der Liebe. Sie verbergen Ihre Wünsche nicht.',
          '6': 'Sie gehen mit Begeisterung an die Arbeit, können aber ungeduldig mit Kollegen sein.',
          '7': 'Sehr emotionale und direkte Interaktionen mit einem Partner. Es ist leicht, sowohl zu streiten als auch sich leidenschaftlich zu versöhnen.',
          '8': 'Starke sexuelle Impulse. Entschlossenheit bei der Lösung von Krisensituationen.',
          '9': 'Sie verteidigen emotional und aktiv Ihre Überzeugungen.',
          '10': 'Ihre Emotionen beeinflussen stark Ihre Karrierehandlungen. Ein Konflikt mit einem Chef ist möglich.',
          '11': 'Sie können ein emotionaler Anführer in einer Gruppe von Freunden werden, aber auch einen Streit provozieren.',
          '12': 'Ihre unterdrückten Emotionen können in Form von plötzlichen und impulsiven Handlungen ausbrechen.'
        }
      }
    ),
    AspectInterpretation(
      id: 'JUPITER_SQUARE_URANUS',
      title: {
        'ru': 'Конфликт Юпитера и Урана',
        'en': 'Jupiter Square Uranus',
        'fr': 'Jupiter Carré Uranus',
        'de': 'Jupiter-Quadrat-Uranus'
      },
      descriptionGeneral: {
        'ru': 'День внезапных срывов и неожиданных поворотов. Ваши планы на расширение (Юпитер) сталкиваются с хаосом и бунтарством (Уран). Риск невыполненных обещаний из-за непредвиденных обстоятельств.',
        'en': 'A day of sudden disruptions and unexpected turns. Your plans for expansion (Jupiter) clash with chaos and rebellion (Uranus). Risk of unfulfilled promises due to unforeseen circumstances.',
        'fr': 'Une journée de perturbations soudaines et de virages inattendus. Vos projets d\'expansion (Jupiter) se heurtent au chaos et à la rébellion (Uranus). Risque de promesses non tenues en raison de circonstances imprévues.',
        'de': 'Ein Tag plötzlicher Störungen und unerwarteter Wendungen. Ihre Expansionspläne (Jupiter) kollidieren mit Chaos und Rebellion (Uranus). Risiko unerfüllter Versprechen aufgrund unvorhergesehener Umstände.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Внезапное желание свободы может разрушить ваши долгосрочные планы.',
          '2': 'Риск неожиданных финансовых потерь. Ваши планы на заработок могут быть сорваны.',
          '3': 'Неожиданные новости могут заставить вас резко поменять свои убеждения или планы.',
          '4': 'Внезапные события в доме (например, поломка) срывают ваши планы.',
          '5': 'Внезапная влюбленность может пойти вразрез с вашими жизненными принципами.',
          '6': 'Хаос на работе. Неожиданные задачи рушат все ваши планы и обещания.',
          '7': 'Непредсказуемое поведение партнера может привести к срыву совместных планов.',
          '8': 'Риск ввязаться в финансовую авантюру, которая закончится внезапным провалом.',
          '9': 'Ваши планы на путешествие или учебу могут быть неожиданно сорваны.',
          '10': 'Внезапные события могут поставить под угрозу вашу карьеру и репутацию.',
          '11': 'Ваши грандиозные планы могут быть разрушены непредсказуемым поведением друзей.',
          '12': 'Неожиданно вскрывшиеся тайны могут разрушить ваши планы и подорвать вашу веру.'
        },
        'en': {
          '1': 'A sudden desire for freedom can destroy your long-term plans.',
          '2': 'Risk of unexpected financial losses. Your earning plans may be disrupted.',
          '3': 'Unexpected news may force you to abruptly change your beliefs or plans.',
          '4': 'Sudden events at home (e.g., a breakdown) disrupt your plans.',
          '5': 'A sudden infatuation may go against your life principles.',
          '6': 'Chaos at work. Unexpected tasks ruin all your plans and promises.',
          '7': 'A partner\'s unpredictable behavior can lead to the disruption of joint plans.',
          '8': 'Risk of getting involved in a financial venture that ends in a sudden failure.',
          '9': 'Your travel or study plans may be unexpectedly disrupted.',
          '10': 'Sudden events can threaten your career and reputation.',
          '11': 'Your grandiose plans can be destroyed by the unpredictable behavior of friends.',
          '12': 'Unexpectedly revealed secrets can destroy your plans and undermine your faith.'
        },
        'fr': {
          '1': 'Un désir soudain de liberté peut détruire vos projets à long terme.',
          '2': 'Risque de pertes financières inattendues. Vos plans de revenus peuvent être perturbés.',
          '3': 'Des nouvelles inattendues peuvent vous forcer à changer brusquement vos croyances ou vos projets.',
          '4': 'Des événements soudains à la maison (par ex., une panne) perturbent vos projets.',
          '5': 'Un engouement soudain peut aller à l\'encontre de vos principes de vie.',
          '6': 'Chaos au travail. Des tâches inattendues ruinent tous vos projets et promesses.',
          '7': 'Le comportement imprévisible d\'un partenaire peut entraîner la perturbation des projets communs.',
          '8': 'Risque de s\'impliquer dans une entreprise financière qui se termine par un échec soudain.',
          '9': 'Vos projets de voyage ou d\'études peuvent être soudainement perturbés.',
          '10': 'Des événements soudains peuvent menacer votre carrière et votre réputation.',
          '11': 'Vos plans grandioses peuvent être détruits par le comportement imprévisible de vos amis.',
          '12': 'Des secrets révélés de manière inattendue peuvent détruire vos projets et saper votre foi.'
        },
        'de': {
          '1': 'Ein plötzlicher Wunsch nach Freiheit kann Ihre langfristigen Pläne zerstören.',
          '2': 'Risiko unerwarteter finanzieller Verluste. Ihre Verdienstpläne können durchkreuzt werden.',
          '3': 'Unerwartete Nachrichten können Sie zwingen, Ihre Überzeugungen oder Pläne abrupt zu ändern.',
          '4': 'Plötzliche Ereignisse zu Hause (z. B. eine Panne) durchkreuzen Ihre Pläne.',
          '5': 'Eine plötzliche Verliebtheit kann gegen Ihre Lebensprinzipien verstoßen.',
          '6': 'Chaos bei der Arbeit. Unerwartete Aufgaben ruinieren alle Ihre Pläne und Versprechen.',
          '7': 'Das unvorhersehbare Verhalten eines Partners kann zur Störung gemeinsamer Pläne führen.',
          '8': 'Risiko, sich auf ein finanzielles Unterfangen einzulassen, das in einem plötzlichen Misserfolg endet.',
          '9': 'Ihre Reise- oder Studienpläne können unerwartet durchkreuzt werden.',
          '10': 'Plötzliche Ereignisse können Ihre Karriere und Ihren Ruf bedrohen.',
          '11': 'Ihre grandiosen Pläne können durch das unvorhersehbare Verhalten von Freunden zerstört werden.',
          '12': 'Unerwartet enthüllte Geheimnisse können Ihre Pläne zerstören und Ihren Glauben untergraben.'
        }
      }
    ),
    AspectInterpretation(
      id: 'SATURN_TRINE_PLUTO',
      title: {
        'ru': 'Гармония Сатурна и Плутона',
        'en': 'Saturn Trine Pluto',
        'fr': 'Saturne Trigone Pluton',
        'de': 'Saturn-Trigon-Pluto'
      },
      descriptionGeneral: {
        'ru': 'День для мощных и долгосрочных достижений. Дисциплина (Сатурн) и воля (Плутон) работают вместе, позволяя вам провести глубокие и основательные изменения в своей жизни.',
        'en': 'A day for powerful and long-term achievements. Discipline (Saturn) and will (Pluto) work together, allowing you to make deep and fundamental changes in your life.',
        'fr': 'Une journée pour des réalisations puissantes et à long terme. La discipline (Saturne) et la volonté (Pluton) travaillent ensemble, vous permettant d\'apporter des changements profonds et fondamentaux dans votre vie.',
        'de': 'Ein Tag für kraftvolle und langfristige Errungenschaften. Disziplin (Saturn) und Wille (Pluto) arbeiten zusammen und ermöglichen es Ihnen, tiefe und grundlegende Veränderungen in Ihrem Leben vorzunehmen.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Вы способны на глубокую внутреннюю работу, которая укрепляет ваш характер и волю.',
          '2': 'Отличное время для создания прочного финансового фундамента. Успешные долгосрочные инвестиции.',
          '3': 'Ваши слова обретают вес и глубину. Вы можете провести очень важный и конструктивный разговор.',
          '4': 'Успешное решение застарелых семейных проблем. Закладка фундамента для дома или семейного бизнеса.',
          '5': 'Отношения становятся более глубокими и прочными. Вы готовы к серьезным обязательствам.',
          '6': 'Вы можете провести глубокую реорганизацию своей работы, которая принесет долгосрочные плоды.',
          '7': 'Партнерство становится очень прочным и надежным. Вы вместе можете свернуть горы.',
          '8': 'Успешное решение сложных финансовых вопросов (крупные кредиты, наследство).',
          '9': 'Глубокое и основательное изучение сложной темы, которое меняет вашу жизнь.',
          '10': 'Вы можете заложить фундамент для большого карьерного успеха. Укрепление власти и авторитета.',
          '11': 'Долгосрочные и надежные планы с друзьями-единомышленниками.',
          '12': 'Успешная и глубокая работа со своими страхами, которая дает вам огромную внутреннюю силу.'
        },
        'en': {
          '1': 'You are capable of deep inner work that strengthens your character and will.',
          '2': 'An excellent time to create a solid financial foundation. Successful long-term investments.',
          '3': 'Your words gain weight and depth. You can have a very important and constructive conversation.',
          '4': 'Successful resolution of long-standing family problems. Laying the foundation for a home or family business.',
          '5': 'Relationships become deeper and stronger. You are ready for serious commitments.',
          '6': 'You can conduct a deep reorganization of your work that will bring long-term benefits.',
          '7': 'The partnership becomes very strong and reliable. Together you can move mountains.',
          '8': 'Successful resolution of complex financial issues (large loans, inheritance).',
          '9': 'A deep and thorough study of a complex topic that changes your life.',
          '10': 'You can lay the foundation for great career success. Strengthening power and authority.',
          '11': 'Long-term and reliable plans with like-minded friends.',
          '12': 'Successful and deep work with your fears, which gives you immense inner strength.'
        },
        'fr': {
          '1': 'Vous êtes capable d\'un travail intérieur profond qui renforce votre caractère et votre volonté.',
          '2': 'Un excellent moment pour créer une base financière solide. Investissements à long terme réussis.',
          '3': 'Vos paroles prennent du poids et de la profondeur. Vous pouvez avoir une conversation très importante et constructive.',
          '4': 'Résolution réussie de problèmes familiaux de longue date. Poser les fondations d\'une maison ou d\'une entreprise familiale.',
          '5': 'Les relations deviennent plus profondes et plus fortes. Vous êtes prêt pour des engagements sérieux.',
          '6': 'Vous pouvez mener une réorganisation profonde de votre travail qui portera ses fruits à long terme.',
          '7': 'Le partenariat devient très solide et fiable. Ensemble, vous pouvez déplacer des montagnes.',
          '8': 'Résolution réussie de problèmes financiers complexes (gros prêts, héritage).',
          '9': 'Une étude approfondie et minutieuse d\'un sujet complexe qui change votre vie.',
          '10': 'Vous pouvez poser les bases d\'un grand succès professionnel. Renforcement du pouvoir et de l\'autorité.',
          '11': 'Plans à long terme et fiables avec des amis partageant les mêmes idées.',
          '12': 'Un travail réussi et profond sur vos peurs, qui vous donne une immense force intérieure.'
        },
        'de': {
          '1': 'Sie sind zu tiefer innerer Arbeit fähig, die Ihren Charakter und Willen stärkt.',
          '2': 'Eine ausgezeichnete Zeit, um ein solides finanzielles Fundament zu schaffen. Erfolgreiche langfristige Investitionen.',
          '3': 'Ihre Worte gewinnen an Gewicht und Tiefe. Sie können ein sehr wichtiges und konstruktives Gespräch führen.',
          '4': 'Erfolgreiche Lösung langjähriger Familienprobleme. Grundsteinlegung für ein Haus oder ein Familienunternehmen.',
          '5': 'Beziehungen werden tiefer und stärker. Sie sind bereit für ernsthafte Verpflichtungen.',
          '6': 'Sie können eine tiefgreifende Reorganisation Ihrer Arbeit durchführen, die langfristige Vorteile bringen wird.',
          '7': 'Die Partnerschaft wird sehr stark und zuverlässig. Zusammen können Sie Berge versetzen.',
          '8': 'Erfolgreiche Lösung komplexer finanzieller Probleme (große Kredite, Erbschaft).',
          '9': 'Ein tiefes und gründliches Studium eines komplexen Themas, das Ihr Leben verändert.',
          '10': 'Sie können den Grundstein für großen beruflichen Erfolg legen. Stärkung von Macht und Autorität.',
          '11': 'Langfristige und zuverlässige Pläne mit gleichgesinnten Freunden.',
          '12': 'Erfolgreiche und tiefe Arbeit mit Ihren Ängsten, die Ihnen immense innere Stärke verleiht.'
        }
      }
    ),
    AspectInterpretation(
      id: 'MERCURY_OPPOSITION_SATURN',
      title: {
        'ru': 'Противостояние Меркурия и Сатурна',
        'en': 'Mercury Opposition Saturn',
        'fr': 'Mercure Opposition Saturne',
        'de': 'Merkur-Opposition-Saturn'
      },
      descriptionGeneral: {
        'ru': 'День ментальных блоков и трудностей в общении. Ваши идеи (Меркурий) сталкиваются с критикой и ограничениями (Сатурн). Плохие новости, задержки, пессимизм. Сложно договориться.',
        'en': 'A day of mental blocks and communication difficulties. Your ideas (Mercury) clash with criticism and limitations (Saturn). Bad news, delays, pessimism. Difficult to reach an agreement.',
        'fr': 'Une journée de blocages mentaux et de difficultés de communication. Vos idées (Mercure) se heurtent à la critique et aux limitations (Saturne). Mauvaises nouvelles, retards, pessimisme. Difficile de parvenir à un accord.',
        'de': 'Ein Tag der mentalen Blockaden und Kommunikationsschwierigkeiten. Ihre Ideen (Merkur) kollidieren mit Kritik und Einschränkungen (Saturn). Schlechte Nachrichten, Verzögerungen, Pessimismus. Schwierig, eine Einigung zu erzielen.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Вы склонны к самокритике. Другие люди могут критиковать ваши идеи, что подрывает уверенность.',
          '2': 'Трудные переговоры о деньгах. Новости о финансах могут быть удручающими.',
          '3': 'Разговор заходит в тупик. Собеседник не слышит вас или жестко критикует. Срыв поездки.',
          '4': 'Трудный разговор с родителями (особенно отцом). Давление семейных обязанностей.',
          '5': 'Сложно выразить свои чувства. Разговор с любимым человеком может быть холодным и формальным.',
          '6': 'Критика со стороны начальства. Работа кажется трудной и неблагодарной.',
          '7': 'Партнер выступает в роли критика, блокируя ваши идеи. Стена непонимания.',
          '8': 'Тревожные мысли о долгах. Новости, связанные с налогами или страховкой, могут быть плохими.',
          '9': 'Ваши идеи и планы сталкиваются с жесткой реальностью. Трудности в учебе.',
          '10': 'Конфликт с начальством или властями. Ваши слова могут быть неверно истолкованы.',
          '11': 'Друг может раскритиковать ваши планы, что вызывает уныние.',
          '12': 'Вы можете зациклиться на негативных мыслях и страхах. Ментальный ступор.'
        },
        'en': {
          '1': 'You are prone to self-criticism. Other people may criticize your ideas, which undermines your confidence.',
          '2': 'Difficult negotiations about money. News about finances can be depressing.',
          '3': 'The conversation reaches a dead end. The other person doesn\'t hear you or criticizes you harshly. A trip is canceled.',
          '4': 'A difficult conversation with parents (especially the father). The pressure of family duties.',
          '5': 'It\'s hard to express your feelings. A conversation with a loved one can be cold and formal.',
          '6': 'Criticism from superiors. Work seems difficult and unrewarding.',
          '7': 'A partner acts as a critic, blocking your ideas. A wall of misunderstanding.',
          '8': 'Anxious thoughts about debts. News related to taxes or insurance can be bad.',
          '9': 'Your ideas and plans clash with harsh reality. Difficulties in studies.',
          '10': 'A conflict with superiors or authorities. Your words may be misinterpreted.',
          '11': 'A friend may criticize your plans, which causes despondency.',
          '12': 'You can get stuck on negative thoughts and fears. A mental block.'
        },
        'fr': {
          '1': 'Vous êtes enclin à l\'autocritique. D\'autres personnes peuvent critiquer vos idées, ce qui mine votre confiance.',
          '2': 'Négociations difficiles sur l\'argent. Les nouvelles sur les finances peuvent être déprimantes.',
          '3': 'La conversation est dans une impasse. L\'autre personne ne vous entend pas ou vous critique sévèrement. Un voyage est annulé.',
          '4': 'Une conversation difficile avec les parents (surtout le père). La pression des obligations familiales.',
          '5': 'Difficile d\'exprimer ses sentiments. Une conversation avec un être cher peut être froide et formelle.',
          '6': 'Critiques des supérieurs. Le travail semble difficile et peu gratifiant.',
          '7': 'Un partenaire agit en tant que critique, bloquant vos idées. Un mur d\'incompréhension.',
          '8': 'Pensées anxieuses sur les dettes. Les nouvelles liées aux impôts ou aux assurances peuvent être mauvaises.',
          '9': 'Vos idées et vos projets se heurtent à la dure réalité. Difficultés dans les études.',
          '10': 'Un conflit avec les supérieurs ou les autorités. Vos paroles peuvent être mal interprétées.',
          '11': 'Un ami peut critiquer vos projets, ce qui provoque le découragement.',
          '12': 'Vous pouvez rester bloqué sur des pensées et des peurs négatives. Un blocage mental.'
        },
        'de': {
          '1': 'Sie neigen zur Selbstkritik. Andere Menschen kritisieren möglicherweise Ihre Ideen, was Ihr Selbstvertrauen untergräbt.',
          '2': 'Schwierige Verhandlungen über Geld. Nachrichten über Finanzen können deprimierend sein.',
          '3': 'Das Gespräch gerät in eine Sackgasse. Die andere Person hört Ihnen nicht zu oder kritisiert Sie scharf. Eine Reise wird abgesagt.',
          '4': 'Ein schwieriges Gespräch mit den Eltern (insbesondere dem Vater). Der Druck familiärer Pflichten.',
          '5': 'Es ist schwer, seine Gefühle auszudrücken. Ein Gespräch mit einem geliebten Menschen kann kalt und formell sein.',
          '6': 'Kritik von Vorgesetzten. Die Arbeit erscheint schwierig und undankbar.',
          '7': 'Ein Partner fungiert als Kritiker und blockiert Ihre Ideen. Eine Mauer des Missverständnisses.',
          '8': 'Ängstliche Gedanken über Schulden. Nachrichten im Zusammenhang mit Steuern oder Versicherungen können schlecht sein.',
          '9': 'Ihre Ideen und Pläne kollidieren mit der harten Realität. Schwierigkeiten im Studium.',
          '10': 'Ein Konflikt mit Vorgesetzten oder Behörden. Ihre Worte können falsch interpretiert werden.',
          '11': 'Ein Freund kritisiert möglicherweise Ihre Pläne, was zu Mutlosigkeit führt.',
          '12': 'Sie können bei negativen Gedanken und Ängsten stecken bleiben. Eine mentale Blockade.'
        }
      }
    ),
            // === НОВЫЙ БЛОК 23 ===
    AspectInterpretation(
      id: 'SATURN_CONJUNCT_URANUS',
      title: {
        'ru': 'Соединение Сатурна и Урана',
        'en': 'Saturn Conjunct Uranus',
        'fr': 'Saturne Conjoint Uranus',
        'de': 'Saturn-Konjunktion-Uranus'
      },
      descriptionGeneral: {
        'ru': 'День столкновения старого и нового. Потребность в стабильности (Сатурн) конфликтует со стремлением к переменам (Уран). Напряжение, которое ведет либо к построению новых структур, либо к внезапному разрушению старых.',
        'en': 'A day of collision between the old and the new. The need for stability (Saturn) conflicts with the drive for change (Uranus). Tension that leads either to building new structures or to the sudden destruction of old ones.',
        'fr': 'Une journée de collision entre l\'ancien et le nouveau. Le besoin de stabilité (Saturne) entre en conflit avec l\'élan de changement (Uranus). Une tension qui mène soit à la construction de nouvelles structures, soit à la destruction soudaine des anciennes.',
        'de': 'Ein Tag des Zusammenpralls von Altem und Neuem. Das Bedürfnis nach Stabilität (Saturn) steht im Konflikt mit dem Drang nach Veränderung (Uranus). Spannung, die entweder zum Aufbau neuer Strukturen oder zur plötzlichen Zerstörung alter führt.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Личностный кризис. Вы разрываетесь между желанием сохранить все как есть и необходимостью кардинальных перемен в себе.',
          '2': 'Финансовая нестабильность. Старые источники дохода могут внезапно иссякнуть, заставляя искать новые.',
          '3': 'Конфликт между старыми идеями и новыми, революционными взглядами. Трудности в общении.',
          '4': 'Резкие и вынужденные перемены в доме или семье. Конфликт поколений.',
          '5': 'Отношения проходят серьезную проверку. Желание стабильности конфликтует с потребностью в свободе.',
          '6': 'Кризис на работе. Старые методы больше не работают, а новые вызывают сопротивление.',
          '7': 'Напряжение в партнерстве. Один хочет стабильности, другой – перемен. Возможен внезапный разрыв.',
          '8': 'Кризис, связанный со старыми долгами и новыми финансовыми рисками.',
          '9': 'Старые убеждения рушатся под натиском новой информации. Срыв планов на поездку.',
          '10': 'Серьезный кризис в карьере. Конфликт с консервативным начальством из-за ваших новаторских идей.',
          '11': 'Конфликт в группе друзей между "старичками" и "новичками". Ваши цели резко меняются.',
          '12': 'Внутреннее напряжение между страхом перемен и пониманием их необходимости.'
        },
        'en': {
          '1': 'A personal crisis. You are torn between wanting to keep things as they are and the need for radical self-change.',
          '2': 'Financial instability. Old sources of income may suddenly dry up, forcing you to look for new ones.',
          '3': 'A conflict between old ideas and new, revolutionary views. Communication difficulties.',
          '4': 'Sharp and forced changes at home or in the family. A generation gap conflict.',
          '5': 'Relationships are undergoing a serious test. The desire for stability conflicts with the need for freedom.',
          '6': 'A crisis at work. Old methods no longer work, and new ones meet with resistance.',
          '7': 'Tension in the partnership. One wants stability, the other wants change. A sudden breakup is possible.',
          '8': 'A crisis related to old debts and new financial risks.',
          '9': 'Old beliefs crumble under the onslaught of new information. Disruption of travel plans.',
          '10': 'A serious crisis in your career. A conflict with conservative superiors over your innovative ideas.',
          '11': 'A conflict in a group of friends between "old-timers" and "newcomers." Your goals change abruptly.',
          '12': 'Internal tension between the fear of change and the understanding of its necessity.'
        },
        'fr': {
          '1': 'Une crise personnelle. Vous êtes déchiré entre le désir de maintenir les choses telles qu\'elles sont et le besoin d\'un changement radical de soi.',
          '2': 'Instabilité financière. Les anciennes sources de revenus peuvent soudainement se tarir, vous forçant à en chercher de nouvelles.',
          '3': 'Un conflit entre les vieilles idées et les nouvelles vues révolutionnaires. Difficultés de communication.',
          '4': 'Changements brusques et forcés à la maison ou dans la famille. Un conflit de générations.',
          '5': 'Les relations subissent un test sérieux. Le désir de stabilité entre en conflit avec le besoin de liberté.',
          '6': 'Une crise au travail. Les anciennes méthodes ne fonctionnent plus, et les nouvelles rencontrent de la résistance.',
          '7': 'Tension dans le partenariat. L\'un veut la stabilité, l\'autre le changement. Une rupture soudaine est possible.',
          '8': 'Une crise liée aux anciennes dettes et aux nouveaux risques financiers.',
          '9': 'Les vieilles croyances s\'effondrent sous l\'assaut de nouvelles informations. Perturbation des projets de voyage.',
          '10': 'Une crise grave dans votre carrière. Un conflit avec des supérieurs conservateurs à propos de vos idées novatrices.',
          '11': 'Un conflit dans un groupe d\'amis entre les "anciens" et les "nouveaux". Vos objectifs changent brusquement.',
          '12': 'Tension interne entre la peur du changement et la compréhension de sa nécessité.'
        },
        'de': {
          '1': 'Eine persönliche Krise. Sie sind hin- und hergerissen zwischen dem Wunsch, die Dinge so zu belassen, wie sie sind, und dem Bedürfnis nach radikaler Selbstveränderung.',
          '2': 'Finanzielle Instabilität. Alte Einkommensquellen können plötzlich versiegen, was Sie zwingt, nach neuen zu suchen.',
          '3': 'Ein Konflikt zwischen alten Ideen und neuen, revolutionären Ansichten. Kommunikationsschwierigkeiten.',
          '4': 'Scharfe und erzwungene Veränderungen zu Hause oder in der Familie. Ein Generationenkonflikt.',
          '5': 'Beziehungen werden einer ernsthaften Prüfung unterzogen. Der Wunsch nach Stabilität steht im Konflikt mit dem Bedürfnis nach Freiheit.',
          '6': 'Eine Krise bei der Arbeit. Alte Methoden funktionieren nicht mehr, und neue stoßen auf Widerstand.',
          '7': 'Spannung in der Partnerschaft. Einer will Stabilität, der andere Veränderung. Eine plötzliche Trennung ist möglich.',
          '8': 'Eine Krise im Zusammenhang mit alten Schulden und neuen finanziellen Risiken.',
          '9': 'Alte Überzeugungen zerbröckeln unter dem Ansturm neuer Informationen. Störung von Reiseplänen.',
          '10': 'Eine ernste Krise in Ihrer Karriere. Ein Konflikt mit konservativen Vorgesetzten über Ihre innovativen Ideen.',
          '11': 'Ein Konflikt in einer Gruppe von Freunden zwischen "Alteingesessenen" und "Neulingen". Ihre Ziele ändern sich abrupt.',
          '12': 'Innere Spannung zwischen der Angst vor Veränderung und dem Verständnis für ihre Notwendigkeit.'
        }
      }
    ),
    AspectInterpretation(
      id: 'NEPTUNE_TRINE_PLUTO',
      title: {
        'ru': 'Гармония Нептуна и Плутона',
        'en': 'Neptune Trine Pluto',
        'fr': 'Neptune Trigone Pluton',
        'de': 'Neptun-Trigon-Pluto'
      },
      descriptionGeneral: {
        'ru': 'Поколенческий аспект, дающий возможность для глубокой духовной трансформации. Интуиция (Нептун) и воля (Плутон) работают в гармонии, позволяя исцелять старые раны и менять мир к лучшему.',
        'en': 'A generational aspect that provides an opportunity for deep spiritual transformation. Intuition (Neptune) and will (Pluto) work in harmony, allowing for the healing of old wounds and changing the world for the better.',
        'fr': 'Un aspect générationnel qui offre une opportunité de transformation spirituelle profonde. L\'intuition (Neptune) et la volonté (Pluton) travaillent en harmonie, permettant de guérir de vieilles blessures et de changer le monde pour le mieux.',
        'de': 'Ein generationenübergreifender Aspekt, der eine Gelegenheit zur tiefen spirituellen Transformation bietet. Intuition (Neptun) und Wille (Pluto) arbeiten in Harmonie und ermöglichen die Heilung alter Wunden und die Veränderung der Welt zum Besseren.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Глубокая интуиция помогает вам трансформировать свою личность и оказывать тонкое, но мощное влияние на других.',
          '2': 'Вы интуитивно чувствуете глобальные финансовые тренды, что помогает вам преумножать ресурсы.',
          '3': 'Ваши слова обладают целительной силой. Вы способны вдохновить людей на глубокие перемены.',
          '4': 'Возможность для глубокого исцеления семейных и родовых травм.',
          '5': 'Творчество становится инструментом глубокой трансформации. Любовь обретает духовное измерение.',
          '6': 'Вы способны привнести духовность и исцеляющую энергию в свою повседневную работу.',
          '7': 'Вы стремитесь к глубокому, духовному и трансформирующему партнерству.',
          '8': 'Невероятная интуиция в кризисных ситуациях. Способность к психологическому и духовному исцелению.',
          '9': 'Ваши духовные поиски приводят к глубокой трансформации вашего мировоззрения.',
          '10': 'Вы можете реализовать свое призвание через помощь другим, искусство или духовные практики.',
          '11': 'Вы притягиваете друзей, которые разделяют ваши духовные идеалы и готовы вместе менять мир.',
          '12': 'Прямой доступ к коллективному бессознательному. Мощные медитативные и духовные практики.'
        },
        'en': {
          '1': 'Deep intuition helps you transform your personality and exert a subtle but powerful influence on others.',
          '2': 'You intuitively sense global financial trends, which helps you multiply resources.',
          '3': 'Your words have healing power. You are able to inspire people to make profound changes.',
          '4': 'An opportunity for deep healing of family and ancestral traumas.',
          '5': 'Creativity becomes a tool for deep transformation. Love acquires a spiritual dimension.',
          '6': 'You are able to bring spirituality and healing energy into your daily work.',
          '7': 'You strive for a deep, spiritual, and transformative partnership.',
          '8': 'Incredible intuition in crisis situations. The ability for psychological and spiritual healing.',
          '9': 'Your spiritual quests lead to a profound transformation of your worldview.',
          '10': 'You can realize your calling through helping others, art, or spiritual practices.',
          '11': 'You attract friends who share your spiritual ideals and are ready to change the world together.',
          '12': 'Direct access to the collective unconscious. Powerful meditative and spiritual practices.'
        },
        'fr': {
          '1': 'Une intuition profonde vous aide à transformer votre personnalité et à exercer une influence subtile mais puissante sur les autres.',
          '2': 'Vous sentez intuitivement les tendances financières mondiales, ce qui vous aide à multiplier les ressources.',
          '3': 'Vos paroles ont un pouvoir de guérison. Vous êtes capable d\'inspirer les gens à opérer des changements profonds.',
          '4': 'Une opportunité de guérison profonde des traumatismes familiaux et ancestraux.',
          '5': 'La créativité devient un outil de transformation profonde. L\'amour acquiert une dimension spirituelle.',
          '6': 'Vous êtes capable d\'apporter de la spiritualité et une énergie de guérison dans votre travail quotidien.',
          '7': 'Vous aspirez à un partenariat profond, spirituel et transformateur.',
          '8': 'Une intuition incroyable dans les situations de crise. La capacité de guérison psychologique et spirituelle.',
          '9': 'Vos quêtes spirituelles conduisent à une transformation profonde de votre vision du monde.',
          '10': 'Vous pouvez réaliser votre vocation en aidant les autres, par l\'art ou les pratiques spirituelles.',
          '11': 'Vous attirez des amis qui partagent vos idéaux spirituels et sont prêts à changer le monde ensemble.',
          '12': 'Accès direct à l\'inconscient collectif. Pratiques méditatives et spirituelles puissantes.'
        },
        'de': {
          '1': 'Tiefe Intuition hilft Ihnen, Ihre Persönlichkeit zu transformieren und einen subtilen, aber kraftvollen Einfluss auf andere auszuüben.',
          '2': 'Sie spüren intuitiv globale Finanztrends, was Ihnen hilft, Ressourcen zu vermehren.',
          '3': 'Ihre Worte haben heilende Kraft. Sie sind in der Lage, Menschen zu tiefgreifenden Veränderungen zu inspirieren.',
          '4': 'Eine Gelegenheit zur tiefen Heilung von Familien- und Ahnen-Traumata.',
          '5': 'Kreativität wird zu einem Werkzeug der tiefen Transformation. Liebe erhält eine spirituelle Dimension.',
          '6': 'Sie sind in der Lage, Spiritualität und heilende Energie in Ihre tägliche Arbeit zu bringen.',
          '7': 'Sie streben nach einer tiefen, spirituellen und transformierenden Partnerschaft.',
          '8': 'Unglaubliche Intuition in Krisensituationen. Die Fähigkeit zur psychologischen und spirituellen Heilung.',
          '9': 'Ihre spirituellen Suchen führen zu einer tiefgreifenden Transformation Ihrer Weltanschauung.',
          '10': 'Sie können Ihre Berufung verwirklichen, indem Sie anderen helfen, durch Kunst oder spirituelle Praktiken.',
          '11': 'Sie ziehen Freunde an, die Ihre spirituellen Ideale teilen und bereit sind, die Welt gemeinsam zu verändern.',
          '12': 'Direkter Zugang zum kollektiven Unbewussten. Kraftvolle meditative und spirituelle Praktiken.'
        }
      }
    ),
    AspectInterpretation(
      id: 'JUPITER_OPPOSITION_URANUS',
      title: {
        'ru': 'Противостояние Юпитера и Урана',
        'en': 'Jupiter Opposition Uranus',
        'fr': 'Jupiter Opposition Uranus',
        'de': 'Jupiter-Opposition-Uranus'
      },
      descriptionGeneral: {
        'ru': 'День конфликта между планами и реальностью. Ваше желание роста (Юпитер) сталкивается с внезапными и непредсказуемыми событиями (Уран), которые все рушат. Бунт против авторитетов и правил.',
        'en': 'A day of conflict between plans and reality. Your desire for growth (Jupiter) clashes with sudden and unpredictable events (Uranus) that ruin everything. Rebellion against authorities and rules.',
        'fr': 'Une journée de conflit entre les plans et la réalité. Votre désir de croissance (Jupiter) se heurte à des événements soudains et imprévisibles (Uranus) qui ruinent tout. Rébellion contre les autorités et les règles.',
        'de': 'Ein Tag des Konflikts zwischen Plänen und Realität. Ihr Wunsch nach Wachstum (Jupiter) kollidiert mit plötzlichen und unvorhersehbaren Ereignissen (Uranus), die alles ruinieren. Rebellion gegen Autoritäten und Regeln.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Ваши личные планы и убеждения сталкиваются с неожиданным сопротивлением.',
          '2': 'Внезапные события могут привести к финансовым потерям, срывая ваши планы на обогащение.',
          '3': 'Шокирующие новости или идеи других людей заставляют вас пересмотреть свои взгляды.',
          '4': 'Неожиданные события в семье или с недвижимостью полностью рушат ваши планы.',
          '5': 'Внезапная влюбленность или событие в жизни детей идет вразрез с вашими планами.',
          '6': 'Хаос на работе, вызванный другими людьми, мешает вам следовать своему плану.',
          '7': 'Партнер или оппонент ведет себя непредсказуемо, что срывает все договоренности.',
          '8': 'Ваши финансовые планы (кредиты, инвестиции) рушатся из-за непредвиденных обстоятельств.',
          '9': 'Внезапные события срывают вашу поездку или мешают учебе.',
          '10': 'Неожиданный бунт против начальства или правил может повредить вашей карьере.',
          '11': 'Ваши планы и мечты сталкиваются с непредсказуемым поведением друзей.',
          '12': 'Тайные враги или неожиданные события из прошлого рушат ваши планы.'
        },
        'en': {
          '1': 'Your personal plans and beliefs are met with unexpected resistance.',
          '2': 'Sudden events can lead to financial losses, disrupting your plans for enrichment.',
          '3': 'Shocking news or other people\'s ideas force you to reconsider your views.',
          '4': 'Unexpected events in the family or with real estate completely ruin your plans.',
          '5': 'A sudden infatuation or an event in your children\'s lives goes against your plans.',
          '6': 'Chaos at work, caused by other people, prevents you from following your plan.',
          '7': 'A partner or opponent behaves unpredictably, which disrupts all agreements.',
          '8': 'Your financial plans (loans, investments) collapse due to unforeseen circumstances.',
          '9': 'Sudden events disrupt your trip or interfere with your studies.',
          '10': 'An unexpected rebellion against superiors or rules can damage your career.',
          '11': 'Your plans and dreams clash with the unpredictable behavior of friends.',
          '12': 'Secret enemies or unexpected events from the past ruin your plans.'
        },
        'fr': {
          '1': 'Vos projets et croyances personnels se heurtent à une résistance inattendue.',
          '2': 'Des événements soudains peuvent entraîner des pertes financières, perturbant vos projets d\'enrichissement.',
          '3': 'Des nouvelles choquantes ou les idées d\'autres personnes vous obligent à reconsidérer vos opinions.',
          '4': 'Des événements inattendus dans la famille ou avec l\'immobilier ruinent complètement vos projets.',
          '5': 'Un engouement soudain ou un événement dans la vie de vos enfants va à l\'encontre de vos projets.',
          '6': 'Le chaos au travail, causé par d\'autres personnes, vous empêche de suivre votre plan.',
          '7': 'Un partenaire ou un adversaire se comporte de manière imprévisible, ce qui perturbe tous les accords.',
          '8': 'Vos plans financiers (prêts, investissements) s\'effondrent en raison de circonstances imprévues.',
          '9': 'Des événements soudains perturbent votre voyage ou interfèrent avec vos études.',
          '10': 'Une rébellion inattendue contre des supérieurs ou des règles peut nuire à votre carrière.',
          '11': 'Vos projets et vos rêves se heurtent au comportement imprévisible de vos amis.',
          '12': 'Des ennemis secrets ou des événements inattendus du passé ruinent vos projets.'
        },
        'de': {
          '1': 'Ihre persönlichen Pläne und Überzeugungen stoßen auf unerwarteten Widerstand.',
          '2': 'Plötzliche Ereignisse können zu finanziellen Verlusten führen und Ihre Pläne zur Bereicherung durchkreuzen.',
          '3': 'Schockierende Nachrichten oder die Ideen anderer zwingen Sie, Ihre Ansichten zu überdenken.',
          '4': 'Unerwartete Ereignisse in der Familie oder mit Immobilien ruinieren Ihre Pläne vollständig.',
          '5': 'Eine plötzliche Verliebtheit oder ein Ereignis im Leben Ihrer Kinder widerspricht Ihren Plänen.',
          '6': 'Chaos bei der Arbeit, verursacht durch andere, hindert Sie daran, Ihren Plan zu verfolgen.',
          '7': 'Ein Partner oder Gegner verhält sich unvorhersehbar, was alle Vereinbarungen stört.',
          '8': 'Ihre Finanzpläne (Kredite, Investitionen) scheitern aufgrund unvorhergesehener Umstände.',
          '9': 'Plötzliche Ereignisse stören Ihre Reise oder beeinträchtigen Ihr Studium.',
          '10': 'Eine unerwartete Rebellion gegen Vorgesetzte oder Regeln kann Ihrer Karriere schaden.',
          '11': 'Ihre Pläne und Träume kollidieren mit dem unvorhersehbaren Verhalten von Freunden.',
          '12': 'Geheime Feinde oder unerwartete Ereignisse aus der Vergangenheit ruinieren Ihre Pläne.'
        }
      }
    ),
    AspectInterpretation(
      id: 'MARS_CONJUNCT_NEPTUNE',
      title: {
        'ru': 'Соединение Марса и Нептуна',
        'en': 'Mars Conjunct Neptune',
        'fr': 'Mars Conjoint Neptune',
        'de': 'Mars-Konjunktion-Neptun'
      },
      descriptionGeneral: {
        'ru': 'День "туманных" действий. Энергия (Марс) растворяется в идеализме и иллюзиях (Нептун). С одной стороны, это вдохновение для творчества и помощи другим. С другой – риск самообмана, лени и неэффективности.',
        'en': 'A day of "foggy" actions. Energy (Mars) dissolves in idealism and illusions (Neptune). On one hand, it\'s inspiration for creativity and helping others. On the other, it\'s a risk of self-deception, laziness, and inefficiency.',
        'fr': 'Une journée d\'actions "brumeuses". L\'énergie (Mars) se dissout dans l\'idéalisme et les illusions (Neptune). D\'un côté, c\'est une source d\'inspiration pour la créativité et l\'aide aux autres. De l\'autre, c\'est un risque d\'auto-illusion, de paresse et d\'inefficacité.',
        'de': 'Ein Tag der "nebligen" Handlungen. Energie (Mars) löst sich in Idealismus und Illusionen (Neptun) auf. Einerseits ist es Inspiration für Kreativität und Hilfe für andere. Andererseits besteht die Gefahr von Selbsttäuschung, Faulheit und Ineffizienz.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Ваши действия могут быть нелогичными и продиктованы иллюзиями. Трудно понять, чего вы на самом деле хотите.',
          '2': 'Риск финансовых потерь из-за запутанных схем или самообмана. Деньги могут "уплывать".',
          '3': 'Путаница в общении. Вы можете быть неверно поняты или сами говорить намеками.',
          '4': 'Хаос в домашних делах. Трудно заставить себя навести порядок. Возможны протечки.',
          '5': 'Идеализация партнера. Вы готовы на жертвы ради любви, но можете обмануться.',
          '6': 'Полный упадок сил на работе. Нет желания что-либо делать. Риск интриг.',
          '7': 'Отношения с партнером очень туманны. Риск обмана или самообмана.',
          '8': 'Тайные сексуальные связи. Запутанные финансовые дела, в которых легко потерять деньги.',
          '9': 'Вы действуете, руководствуясь туманными идеалами. Риск попасть под чужое влияние.',
          '10': 'Неясные карьерные цели. Ваша репутация может пострадать из-за интриг.',
          '11': 'Вы можете быть обмануты друзьями или втянуты в сомнительные дела.',
          '12': 'Склонность к эскапизму, уходу от реальности через зависимости. Активизация тайных врагов.'
        },
        'en': {
          '1': 'Your actions may be illogical and dictated by illusions. It\'s hard to understand what you really want.',
          '2': 'Risk of financial loss due to confusing schemes or self-deception. Money can "slip away."',
          '3': 'Confusion in communication. You may be misunderstood or speak in hints yourself.',
          '4': 'Chaos in domestic affairs. It\'s hard to make yourself tidy up. Leaks are possible.',
          '5': 'Idealization of a partner. You are ready to make sacrifices for love but may be deceived.',
          '6': 'A complete lack of energy at work. No desire to do anything. Risk of intrigues.',
          '7': 'The relationship with a partner is very foggy. Risk of deception or self-deception.',
          '8': 'Secret sexual liaisons. Confusing financial affairs where it\'s easy to lose money.',
          '9': 'You act based on vague ideals. Risk of falling under someone else\'s influence.',
          '10': 'Unclear career goals. Your reputation may suffer due to intrigues.',
          '11': 'You may be deceived by friends or drawn into questionable affairs.',
          '12': 'A tendency towards escapism, fleeing reality through addictions. Activation of secret enemies.'
        },
        'fr': {
          '1': 'Vos actions peuvent être illogiques et dictées par des illusions. Difficile de savoir ce que vous voulez vraiment.',
          '2': 'Risque de perte financière due à des combines confuses ou à l\'auto-illusion. L\'argent peut "s\'envoler".',
          '3': 'Confusion dans la communication. Vous pouvez être mal compris ou parler vous-même à demi-mot.',
          '4': 'Chaos dans les affaires domestiques. Difficile de se mettre à ranger. Des fuites sont possibles.',
          '5': 'Idéalisation d\'un partenaire. Vous êtes prêt à faire des sacrifices par amour mais risquez d\'être trompé.',
          '6': 'Manque total d\'énergie au travail. Aucune envie de faire quoi que ce soit. Risque d\'intrigues.',
          '7': 'La relation avec un partenaire est très floue. Risque de tromperie ou d\'auto-illusion.',
          '8': 'Liaisons sexuelles secrètes. Affaires financières confuses où il est facile de perdre de l\'argent.',
          '9': 'Vous agissez sur la base d\'idéaux vagues. Risque de tomber sous l\'influence de quelqu\'un d\'autre.',
          '10': 'Objectifs de carrière flous. Votre réputation peut souffrir à cause d\'intrigues.',
          '11': 'Vous pourriez être trompé par des amis ou entraîné dans des affaires douteuses.',
          '12': 'Tendance à l\'évasion, à fuir la réalité par les dépendances. Activation des ennemis secrets.'
        },
        'de': {
          '1': 'Ihre Handlungen können unlogisch sein und von Illusionen diktiert werden. Es ist schwer zu verstehen, was Sie wirklich wollen.',
          '2': 'Risiko eines finanziellen Verlusts durch verwirrende Machenschaften oder Selbsttäuschung. Geld kann "entgleiten".',
          '3': 'Verwirrung in der Kommunikation. Sie könnten missverstanden werden oder selbst in Andeutungen sprechen.',
          '4': 'Chaos in häuslichen Angelegenheiten. Es ist schwer, sich zum Aufräumen zu zwingen. Lecks sind möglich.',
          '5': 'Idealisierung eines Partners. Sie sind bereit, Opfer für die Liebe zu bringen, könnten aber betrogen werden.',
          '6': 'Ein völliger Energiemangel bei der Arbeit. Keine Lust, etwas zu tun. Risiko von Intrigen.',
          '7': 'Die Beziehung zu einem Partner ist sehr neblig. Gefahr von Täuschung oder Selbsttäuschung.',
          '8': 'Geheime sexuelle Beziehungen. Verwirrende Finanzangelegenheiten, bei denen man leicht Geld verlieren kann.',
          '9': 'Sie handeln auf der Grundlage vager Ideale. Gefahr, unter den Einfluss eines anderen zu geraten.',
          '10': 'Unklare Karriereziele. Ihr Ruf könnte durch Intrigen leiden.',
          '11': 'Sie könnten von Freunden betrogen oder in fragwürdige Angelegenheiten verwickelt werden.',
          '12': 'Eine Tendenz zum Eskapismus, zur Flucht vor der Realität durch Süchte. Aktivierung geheimer Feinde.'
        }
      }
    ),
            // === НОВЫЙ БЛОК 24 ===
    AspectInterpretation(
      id: 'SATURN_SQUARE_URANUS',
      title: {
        'ru': 'Конфликт Сатурна и Урана',
        'en': 'Saturn Square Uranus',
        'fr': 'Saturne Carré Uranus',
        'de': 'Saturn-Quadrat-Uranus'
      },
      descriptionGeneral: {
        'ru': 'День острого конфликта между старым (Сатурн) и новым (Уран). Правила и структуры сталкиваются с желанием свободы и бунтарством. Вынужденные перемены, срыв планов, напряжение.',
        'en': 'A day of sharp conflict between the old (Saturn) and the new (Uranus). Rules and structures clash with the desire for freedom and rebellion. Forced changes, disrupted plans, tension.',
        'fr': 'Une journée de conflit aigu entre l\'ancien (Saturne) et le nouveau (Uranus). Les règles et les structures se heurtent au désir de liberté et de rébellion. Changements forcés, plans perturbés, tension.',
        'de': 'Ein Tag des scharfen Konflikts zwischen dem Alten (Saturn) und dem Neuen (Uranus). Regeln und Strukturen kollidieren mit dem Wunsch nach Freiheit und Rebellion. Erzwungene Veränderungen, gestörte Pläne, Spannung.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Внутренний конфликт между желанием стабильности и потребностью в переменах ломает вас изнутри.',
          '2': 'Финансовый кризис. Старые способы заработка больше не работают, а новые еще не найдены.',
          '3': 'Конфликт со старым окружением из-за ваших новых, радикальных идей.',
          '4': 'Вынужденные и болезненные перемены в доме или семье. Конфликт поколений.',
          '5': 'Отношения трещат по швам из-за конфликта между долгом и желанием свободы.',
          '6': 'Кризис на работе. Начальство требует соблюдения правил, а вы хотите все делать по-новому.',
          '7': 'Серьезный конфликт с партнером, который может привести к разрыву. Один хочет сохранить, другой – разрушить.',
          '8': 'Кризис, связанный со старыми долгами и новыми рискованными финансовыми идеями.',
          '9': 'Ваши старые убеждения рушатся, что вызывает внутренний кризис. Срыв планов.',
          '10': 'Конфликт с консервативным начальством, который может стоить вам карьеры.',
          '11': 'Разрыв со старыми друзьями из-за ваших новых целей и стремлений.',
          '12': 'Старые страхи мешают вам двигаться вперед, что создает огромное внутреннее напряжение.'
        },
        'en': {
          '1': 'An internal conflict between the desire for stability and the need for change is breaking you from the inside.',
          '2': 'Financial crisis. Old ways of earning no longer work, and new ones have not yet been found.',
          '3': 'A conflict with your old circle due to your new, radical ideas.',
          '4': 'Forced and painful changes at home or in the family. A generation gap conflict.',
          '5': 'Relationships are falling apart due to the conflict between duty and the desire for freedom.',
          '6': 'A crisis at work. Superiors demand adherence to rules, while you want to do everything in a new way.',
          '7': 'A serious conflict with a partner that could lead to a breakup. One wants to preserve, the other to destroy.',
          '8': 'A crisis related to old debts and new risky financial ideas.',
          '9': 'Your old beliefs are crumbling, causing an internal crisis. Disruption of plans.',
          '10': 'A conflict with a conservative boss that could cost you your career.',
          '11': 'A break with old friends due to your new goals and aspirations.',
          '12': 'Old fears are holding you back, creating immense internal tension.'
        },
        'fr': {
          '1': 'Un conflit interne entre le désir de stabilité et le besoin de changement vous brise de l\'intérieur.',
          '2': 'Crise financière. Les anciennes façons de gagner de l\'argent ne fonctionnent plus, et de nouvelles n\'ont pas encore été trouvées.',
          '3': 'Un conflit avec votre ancien entourage à cause de vos nouvelles idées radicales.',
          '4': 'Changements forcés et douloureux à la maison ou dans la famille. Un conflit de générations.',
          '5': 'Les relations se fissurent à cause du conflit entre le devoir et le désir de liberté.',
          '6': 'Une crise au travail. Les supérieurs exigent le respect des règles, alors que vous voulez tout faire d\'une nouvelle manière.',
          '7': 'Un conflit sérieux avec un partenaire qui pourrait mener à une rupture. L\'un veut préserver, l\'autre détruire.',
          '8': 'Une crise liée aux anciennes dettes et aux nouvelles idées financières risquées.',
          '9': 'Vos anciennes croyances s\'effondrent, provoquant une crise interne. Perturbation des plans.',
          '10': 'Un conflit avec un patron conservateur qui pourrait vous coûter votre carrière.',
          '11': 'Une rupture avec de vieux amis en raison de vos nouveaux objectifs et aspirations.',
          '12': 'Les vieilles peurs vous retiennent, créant une immense tension interne.'
        },
        'de': {
          '1': 'Ein interner Konflikt zwischen dem Wunsch nach Stabilität und dem Bedürfnis nach Veränderung zerbricht Sie von innen.',
          '2': 'Finanzkrise. Alte Verdienstmöglichkeiten funktionieren nicht mehr, und neue sind noch nicht gefunden.',
          '3': 'Ein Konflikt mit Ihrem alten Umfeld aufgrund Ihrer neuen, radikalen Ideen.',
          '4': 'Erzwungene und schmerzhafte Veränderungen zu Hause oder in der Familie. Ein Generationenkonflikt.',
          '5': 'Beziehungen zerbrechen aufgrund des Konflikts zwischen Pflicht und Freiheitswunsch.',
          '6': 'Eine Krise bei der Arbeit. Vorgesetzte fordern die Einhaltung von Regeln, während Sie alles auf eine neue Art machen wollen.',
          '7': 'Ein ernster Konflikt mit einem Partner, der zu einer Trennung führen könnte. Einer will bewahren, der andere zerstören.',
          '8': 'Eine Krise im Zusammenhang mit alten Schulden und neuen riskanten Finanzideen.',
          '9': 'Ihre alten Überzeugungen zerbröckeln und verursachen eine interne Krise. Störung der Pläne.',
          '10': 'Ein Konflikt mit einem konservativen Chef, der Sie Ihre Karriere kosten könnte.',
          '11': 'Ein Bruch mit alten Freunden aufgrund Ihrer neuen Ziele und Bestrebungen.',
          '12': 'Alte Ängste halten Sie zurück und erzeugen eine immense innere Spannung.'
        }
      }
    ),
    AspectInterpretation(
      id: 'URANUS_TRINE_PLUTO',
      title: {
        'ru': 'Гармония Урана и Плутона',
        'en': 'Uranus Trine Pluto',
        'fr': 'Uranus Trigone Pluton',
        'de': 'Uran-Trigon-Pluto'
      },
      descriptionGeneral: {
        'ru': 'Поколенческий аспект, дающий возможность для глубоких, но гармоничных революционных преобразований. Новые технологии (Уран) и воля к трансформации (Плутон) работают вместе на благо прогресса.',
        'en': 'A generational aspect that provides an opportunity for deep but harmonious revolutionary transformations. New technologies (Uranus) and the will to transform (Pluto) work together for the benefit of progress.',
        'fr': 'Un aspect générationnel qui offre une opportunité de transformations révolutionnaires profondes mais harmonieuses. Les nouvelles technologies (Uranus) et la volonté de transformer (Pluton) travaillent ensemble pour le bien du progrès.',
        'de': 'Ein generationenübergreifender Aspekt, der eine Gelegenheit für tiefe, aber harmonische revolutionäre Transformationen bietet. Neue Technologien (Uranus) und der Wille zur Transformation (Pluto) arbeiten zum Wohle des Fortschritts zusammen.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Вы легко принимаете перемены и используете их для глубокой личной трансформации.',
          '2': 'Новые технологии и оригинальные идеи помогают вам кардинально улучшить свое финансовое положение.',
          '3': 'Ваши революционные идеи легко находят понимание и поддержку, меняя сознание людей.',
          '4': 'Вы можете гармонично обновить устои своей семьи, не разрушая, а трансформируя их.',
          '5': 'Творчество и любовь становятся полем для смелых и успешных экспериментов.',
          '6': 'Вы легко внедряете новые технологии в работу, что приводит к ее глубокой трансформации.',
          '7': 'Вы можете построить свободные, но при этом глубокие и трансформирующие отношения.',
          '8': 'Вы легко справляетесь с кризисами, используя их как возможность для роста.',
          '9': 'Новые научные или духовные открытия полностью меняют ваше мировоззрение, и вы легко это принимаете.',
          '10': 'Вы можете стать лидером прогрессивных изменений в своей сфере деятельности.',
          '11': 'Вместе с друзьями-единомышленниками вы способны запустить проекты, которые меняют мир.',
          '12': 'Глубокая работа с подсознанием с помощью новых методов (например, психотехник) проходит успешно.'
        },
        'en': {
          '1': 'You easily accept changes and use them for deep personal transformation.',
          '2': 'New technologies and original ideas help you radically improve your financial situation.',
          '3': 'Your revolutionary ideas are easily understood and supported, changing people\'s consciousness.',
          '4': 'You can harmoniously update your family\'s foundations, not by destroying but by transforming them.',
          '5': 'Creativity and love become a field for bold and successful experiments.',
          '6': 'You easily implement new technologies at work, which leads to its deep transformation.',
          '7': 'You can build free, yet deep and transformative relationships.',
          '8': 'You handle crises easily, using them as an opportunity for growth.',
          '9': 'New scientific or spiritual discoveries completely change your worldview, and you easily accept it.',
          '10': 'You can become a leader of progressive changes in your field of activity.',
          '11': 'Together with like-minded friends, you are capable of launching projects that change the world.',
          '12': 'Deep work with the subconscious using new methods (e.g., psychotechniques) is successful.'
        },
        'fr': {
          '1': 'Vous acceptez facilement les changements et les utilisez pour une profonde transformation personnelle.',
          '2': 'Les nouvelles technologies et les idées originales vous aident à améliorer radicalement votre situation financière.',
          '3': 'Vos idées révolutionnaires sont facilement comprises et soutenues, changeant la conscience des gens.',
          '4': 'Vous pouvez harmonieusement mettre à jour les fondations de votre famille, non pas en les détruisant mais en les transformant.',
          '5': 'La créativité et l\'amour deviennent un champ d\'expériences audacieuses et réussies.',
          '6': 'Vous mettez facilement en œuvre de nouvelles technologies au travail, ce qui conduit à sa transformation profonde.',
          '7': 'Vous pouvez construire des relations libres, mais profondes et transformatrices.',
          '8': 'Vous gérez facilement les crises, les utilisant comme une opportunité de croissance.',
          '9': 'De nouvelles découvertes scientifiques ou spirituelles changent complètement votre vision du monde, et vous l\'acceptez facilement.',
          '10': 'Vous pouvez devenir un leader des changements progressistes dans votre domaine d\'activité.',
          '11': 'Avec des amis partageant les mêmes idées, vous êtes capable de lancer des projets qui changent le monde.',
          '12': 'Un travail profond avec le subconscient en utilisant de nouvelles méthodes (par ex., les psychotechniques) est réussi.'
        },
        'de': {
          '1': 'Sie akzeptieren leicht Veränderungen und nutzen sie zur tiefen persönlichen Transformation.',
          '2': 'Neue Technologien und originelle Ideen helfen Ihnen, Ihre finanzielle Situation radikal zu verbessern.',
          '3': 'Ihre revolutionären Ideen werden leicht verstanden und unterstützt und verändern das Bewusstsein der Menschen.',
          '4': 'Sie können die Grundlagen Ihrer Familie harmonisch erneuern, nicht indem Sie sie zerstören, sondern indem Sie sie transformieren.',
          '5': 'Kreativität und Liebe werden zu einem Feld für mutige und erfolgreiche Experimente.',
          '6': 'Sie implementieren leicht neue Technologien bei der Arbeit, was zu deren tiefer Transformation führt.',
          '7': 'Sie können freie, aber dennoch tiefe und transformative Beziehungen aufbauen.',
          '8': 'Sie bewältigen Krisen leicht und nutzen sie als Wachstumschance.',
          '9': 'Neue wissenschaftliche oder spirituelle Entdeckungen verändern Ihre Weltanschauung vollständig, und Sie akzeptieren es leicht.',
          '10': 'Sie können ein Führer des fortschrittlichen Wandels in Ihrem Tätigkeitsbereich werden.',
          '11': 'Zusammen mit gleichgesinnten Freunden sind Sie in der Lage, Projekte zu starten, die die Welt verändern.',
          '12': 'Tiefe Arbeit mit dem Unterbewusstsein unter Verwendung neuer Methoden (z. B. Psychotechniken) ist erfolgreich.'
        }
      }
    ),
    AspectInterpretation(
      id: 'JUPITER_OPPOSITION_PLUTO',
      title: {
        'ru': 'Противостояние Юпитера и Плутона',
        'en': 'Jupiter Opposition Pluto',
        'fr': 'Jupiter Opposition Pluton',
        'de': 'Jupiter-Opposition-Pluto'
      },
      descriptionGeneral: {
        'ru': 'День борьбы за власть и влияние. Ваши амбиции и желание роста (Юпитер) сталкиваются с чужой волей к тотальному контролю (Плутон). Конфликты с властью, юридические баталии, финансовые кризисы.',
        'en': 'A day of struggle for power and influence. Your ambitions and desire for growth (Jupiter) clash with someone else\'s will for total control (Pluto). Conflicts with authority, legal battles, financial crises.',
        'fr': 'Une journée de lutte pour le pouvoir et l\'influence. Vos ambitions et votre désir de croissance (Jupiter) se heurtent à la volonté de contrôle total de quelqu\'un d\'autre (Pluton). Conflits avec l\'autorité, batailles juridiques, crises financières.',
        'de': 'Ein Tag des Kampfes um Macht und Einfluss. Ihre Ambitionen und Ihr Wachstumswunsch (Jupiter) kollidieren mit dem Willen eines anderen zur totalen Kontrolle (Pluto). Konflikte mit Autoritäten, Rechtsstreitigkeiten, Finanzkrisen.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Ваши амбиции наталкиваются на жесткое сопротивление. Кто-то пытается подавить вашу волю.',
          '2': 'Борьба за крупные финансовые ресурсы. Вы можете столкнуться с давлением со стороны банков или налоговой.',
          '3': 'Жесткий идеологический спор, в котором оппонент пытается вас "уничтожить".',
          '4': 'Борьба за власть и контроль в семье. Конфликты из-за наследства.',
          '5': 'Ваши амбиции в любви сталкиваются с ревностью и желанием партнера вас контролировать.',
          '6': 'Конфликт с коллегами или начальством, который перерастает в борьбу за влияние.',
          '7': 'Открытое противостояние с могущественным конкурентом или партнером.',
          '8': 'Серьезный кризис, связанный с крупными деньгами, кредитами или налогами.',
          '9': 'Ваши убеждения сталкиваются с мощной и агрессивной оппозицией.',
          '10': 'Прямой конфликт с властными структурами. Ваша карьера и репутация под угрозой.',
          '11': 'Идеологический раскол в группе друзей. Борьба за лидерство.',
          '12': 'Вы сталкиваетесь с мощным тайным врагом, который мешает вашему росту.'
        },
        'en': {
          '1': 'Your ambitions are met with stiff resistance. Someone is trying to suppress your will.',
          '2': 'A struggle for large financial resources. You may face pressure from banks or tax authorities.',
          '3': 'A harsh ideological dispute in which the opponent tries to "destroy" you.',
          '4': 'A power struggle and control in the family. Conflicts over inheritance.',
          '5': 'Your ambitions in love clash with your partner\'s jealousy and desire to control you.',
          '6': 'A conflict with colleagues or superiors that escalates into a struggle for influence.',
          '7': 'An open confrontation with a powerful competitor or partner.',
          '8': 'A serious crisis related to large sums of money, loans, or taxes.',
          '9': 'Your beliefs are met with powerful and aggressive opposition.',
          '10': 'A direct conflict with authority structures. Your career and reputation are at risk.',
          '11': 'An ideological split in a group of friends. A struggle for leadership.',
          '12': 'You are facing a powerful secret enemy who is hindering your growth.'
        },
        'fr': {
          '1': 'Vos ambitions se heurtent à une forte résistance. Quelqu\'un essaie de réprimer votre volonté.',
          '2': 'Une lutte pour d\'importantes ressources financières. Vous pourriez subir des pressions de la part des banques ou des autorités fiscales.',
          '3': 'Un âpre débat idéologique dans lequel l\'adversaire tente de vous "détruire".',
          '4': 'Une lutte de pouvoir et de contrôle dans la famille. Conflits de succession.',
          '5': 'Vos ambitions amoureuses se heurtent à la jalousie et au désir de contrôle de votre partenaire.',
          '6': 'Un conflit avec des collègues ou des supérieurs qui dégénère en lutte d\'influence.',
          '7': 'Une confrontation ouverte avec un concurrent ou un partenaire puissant.',
          '8': 'Une crise grave liée à d\'importantes sommes d\'argent, des prêts ou des impôts.',
          '9': 'Vos croyances se heurtent à une opposition puissante et agressive.',
          '10': 'Un conflit direct avec les structures d\'autorité. Votre carrière et votre réputation sont en danger.',
          '11': 'Une scission idéologique dans un groupe d\'amis. Une lutte pour le leadership.',
          '12': 'Vous faites face à un puissant ennemi secret qui entrave votre croissance.'
        },
        'de': {
          '1': 'Ihre Ambitionen stoßen auf starken Widerstand. Jemand versucht, Ihren Willen zu unterdrücken.',
          '2': 'Ein Kampf um große finanzielle Ressourcen. Sie könnten Druck von Banken oder Steuerbehörden ausgesetzt sein.',
          '3': 'Ein harter ideologischer Streit, in dem der Gegner versucht, Sie zu "zerstören".',
          '4': 'Ein Machtkampf und Kontrolle in der Familie. Erbstreitigkeiten.',
          '5': 'Ihre Ambitionen in der Liebe kollidieren mit der Eifersucht und dem Kontrollwunsch Ihres Partners.',
          '6': 'Ein Konflikt mit Kollegen oder Vorgesetzten, der zu einem Kampf um Einfluss eskaliert.',
          '7': 'Eine offene Konfrontation mit einem mächtigen Konkurrenten oder Partner.',
          '8': 'Eine ernste Krise im Zusammenhang mit großen Geldsummen, Krediten oder Steuern.',
          '9': 'Ihre Überzeugungen stoßen auf starken und aggressiven Widerstand.',
          '10': 'Ein direkter Konflikt mit Autoritätsstrukturen. Ihre Karriere und Ihr Ruf sind in Gefahr.',
          '11': 'Eine ideologische Spaltung in einer Gruppe von Freunden. Ein Kampf um die Führung.',
          '12': 'Sie stehen einem mächtigen geheimen Feind gegenüber, der Ihr Wachstum behindert.'
        }
      }
    ),
    AspectInterpretation(
      id: 'SATURN_SEXTILE_NEPTUNE',
      title: {
        'ru': 'Шанс от Сатурна и Нептуна',
        'en': 'Saturn Sextile Neptune',
        'fr': 'Saturne Sextile Neptune',
        'de': 'Saturn-Sextil-Neptun'
      },
      descriptionGeneral: {
        'ru': 'День дает возможность "заземлить" свои мечты. Практичность (Сатурн) и вдохновение (Нептун) работают вместе. Появляется шанс воплотить свои идеалы в конкретные, реальные формы.',
        'en': 'The day provides an opportunity to "ground" your dreams. Practicality (Saturn) and inspiration (Neptune) work together. A chance arises to embody your ideals in concrete, real forms.',
        'fr': 'La journée offre l\'opportunité d\'"ancrer" vos rêves. Le pragmatisme (Saturne) et l\'inspiration (Neptune) travaillent ensemble. Une chance se présente d\'incarner vos idéaux sous des formes concrètes et réelles.',
        'de': 'Der Tag bietet die Möglichkeit, Ihre Träume zu "erden". Praktikabilität (Saturn) und Inspiration (Neptun) arbeiten zusammen. Es ergibt sich die Chance, Ihre Ideale in konkrete, reale Formen zu bringen.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Возможность через дисциплину и труд воплотить в жизнь свой идеальный образ.',
          '2': 'Шанс найти практическое применение своим творческим талантам и заработать на этом.',
          '3': 'Возможность облечь свои мечты и идеи в четкие слова и донести их до других.',
          '4': 'Шанс создать дом своей мечты, сочетая практичность и уют.',
          '5': 'Возможность построить стабильные и при этом очень романтичные и возвышенные отношения.',
          '6': 'Шанс сделать свою работу более творческой или найти практическое применение своему состраданию.',
          '7': 'Возможность построить с партнером отношения, основанные как на долге, так и на духовной близости.',
          '8': 'Интуиция помогает вам принимать мудрые и практичные финансовые решения.',
          '9': 'Шанс начать обучение, которое поможет вам реализовать ваши духовные идеалы.',
          '10': 'Возможность найти работу своей мечты, которая будет и вдохновлять, и приносить стабильный доход.',
          '11': 'Шанс вместе с друзьями начать реализацию какого-то гуманитарного или творческого проекта.',
          '12': 'Возможность через медитацию или уединение найти практические пути для реализации своих мечтаний.'
        },
        'en': {
          '1': 'An opportunity to embody your ideal image through discipline and hard work.',
          '2': 'A chance to find a practical application for your creative talents and earn from it.',
          '3': 'An opportunity to put your dreams and ideas into clear words and convey them to others.',
          '4': 'A chance to create the home of your dreams, combining practicality and coziness.',
          '5': 'An opportunity to build a stable yet very romantic and sublime relationship.',
          '6': 'A chance to make your work more creative or find a practical application for your compassion.',
          '7': 'An opportunity to build a relationship with a partner based on both duty and spiritual intimacy.',
          '8': 'Intuition helps you make wise and practical financial decisions.',
          '9': 'A chance to start studies that will help you realize your spiritual ideals.',
          '10': 'An opportunity to find the job of your dreams that will both inspire and provide a stable income.',
          '11': 'A chance to start a humanitarian or creative project together with friends.',
          '12': 'An opportunity to find practical ways to realize your dreams through meditation or solitude.'
        },
        'fr': {
          '1': 'Une opportunité d\'incarner votre image idéale par la discipline et le travail acharné.',
          '2': 'Une chance de trouver une application pratique à vos talents créatifs et d\'en tirer des revenus.',
          '3': 'Une opportunité de mettre vos rêves et vos idées en mots clairs et de les transmettre aux autres.',
          '4': 'Une chance de créer la maison de vos rêves, alliant praticité et confort.',
          '5': 'Une opportunité de construire une relation stable mais très romantique et sublime.',
          '6': 'Une chance de rendre votre travail plus créatif ou de trouver une application pratique à votre compassion.',
          '7': 'Une opportunité de construire une relation avec un partenaire basée à la fois sur le devoir et l\'intimité spirituelle.',
          '8': 'L\'intuition vous aide à prendre des décisions financières sages et pratiques.',
          '9': 'Une chance de commencer des études qui vous aideront à réaliser vos idéaux spirituels.',
          '10': 'Une opportunité de trouver le travail de vos rêves qui vous inspirera et vous fournira un revenu stable.',
          '11': 'Une chance de démarrer un projet humanitaire ou créatif avec des amis.',
          '12': 'Une opportunité de trouver des moyens pratiques de réaliser vos rêves par la méditation ou la solitude.'
        },
        'de': {
          '1': 'Eine Gelegenheit, Ihr Idealbild durch Disziplin und harte Arbeit zu verkörpern.',
          '2': 'Eine Chance, eine praktische Anwendung für Ihre kreativen Talente zu finden und damit Geld zu verdienen.',
          '3': 'Eine Gelegenheit, Ihre Träume und Ideen in klare Worte zu fassen und sie anderen zu vermitteln.',
          '4': 'Eine Chance, das Zuhause Ihrer Träume zu schaffen, das Praktikabilität und Gemütlichkeit verbindet.',
          '5': 'Eine Gelegenheit, eine stabile und doch sehr romantische und erhabene Beziehung aufzubauen.',
          '6': 'Eine Chance, Ihre Arbeit kreativer zu gestalten oder eine praktische Anwendung für Ihr Mitgefühl zu finden.',
          '7': 'Eine Gelegenheit, eine Beziehung zu einem Partner aufzubauen, die sowohl auf Pflicht als auch auf spiritueller Intimität basiert.',
          '8': 'Die Intuition hilft Ihnen, weise und praktische finanzielle Entscheidungen zu treffen.',
          '9': 'Eine Chance, ein Studium zu beginnen, das Ihnen hilft, Ihre spirituellen Ideale zu verwirklichen.',
          '10': 'Eine Gelegenheit, den Job Ihrer Träume zu finden, der sowohl inspiriert als auch ein stabiles Einkommen bietet.',
          '11': 'Eine Chance, gemeinsam mit Freunden ein humanitäres oder kreatives Projekt zu starten.',
          '12': 'Eine Gelegenheit, durch Meditation oder Einsamkeit praktische Wege zur Verwirklichung Ihrer Träume zu finden.'
        }
      }
    ),
            // === НОВЫЙ БЛОК 25 ===
    AspectInterpretation(
      id: 'SATURN_OPPOSITION_URANUS',
      title: {
        'ru': 'Противостояние Сатурна и Урана',
        'en': 'Saturn Opposition Uranus',
        'fr': 'Saturne Opposition Uranus',
        'de': 'Saturn-Opposition-Uranus'
      },
      descriptionGeneral: {
        'ru': 'День открытого конфликта между старыми правилами (Сатурн) и бунтом (Уран). Ваши структуры и планы сталкиваются с неожиданным сопротивлением и хаосом со стороны других. Вынужденные перемены.',
        'en': 'A day of open conflict between old rules (Saturn) and rebellion (Uranus). Your structures and plans clash with unexpected resistance and chaos from others. Forced changes.',
        'fr': 'Une journée de conflit ouvert entre les anciennes règles (Saturne) et la rébellion (Uranus). Vos structures et vos plans se heurtent à une résistance inattendue et au chaos des autres. Changements forcés.',
        'de': 'Ein Tag des offenen Konflikts zwischen alten Regeln (Saturn) und Rebellion (Uranus). Ihre Strukturen und Pläne kollidieren mit unerwartetem Widerstand und Chaos von anderen. Erzwungene Veränderungen.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Ваши устои и стабильность подвергаются атаке со стороны непредсказуемых людей или обстоятельств.',
          '2': 'Финансовый кризис. Старые, надежные источники дохода конфликтуют с новыми, рискованными, но необходимыми.',
          '3': 'Конфликт между вашими консервативными идеями и революционными взглядами других.',
          '4': 'Серьезный конфликт в семье между поколениями. Кто-то пытается разрушить семейные традиции.',
          '5': 'Отношения разрываются между долгом и желанием свободы. Партнер может взбунтоваться.',
          '6': 'Открытый конфликт на работе. Начальство (Сатурн) против новаторов (Уран).',
          '7': 'Партнер или оппонент открыто бунтует против ваших правил и ограничений.',
          '8': 'Старые финансовые обязательства сталкиваются с новыми рискованными предприятиями, создавая кризис.',
          '9': 'Ваши устоявшиеся взгляды подвергаются шокирующей атаке со стороны оппонентов.',
          '10': 'Бунт против начальства. Ваша карьера под угрозой из-за столкновения с системой.',
          '11': 'Разрыв со старыми друзьями, которые не принимают ваших новых, свободных взглядов.',
          '12': 'Ваши внутренние страхи (Сатурн) конфликтуют с подсознательным желанием освободиться (Уран).'
        },
        'en': {
          '1': 'Your foundations and stability are under attack from unpredictable people or circumstances.',
          '2': 'Financial crisis. Old, reliable sources of income conflict with new, risky but necessary ones.',
          '3': 'A conflict between your conservative ideas and the revolutionary views of others.',
          '4': 'A serious conflict in the family between generations. Someone is trying to destroy family traditions.',
          '5': 'A relationship is torn between duty and the desire for freedom. A partner may rebel.',
          '6': 'An open conflict at work. Management (Saturn) versus innovators (Uranus).',
          '7': 'A partner or opponent openly rebels against your rules and restrictions.',
          '8': 'Old financial obligations clash with new risky ventures, creating a crisis.',
          '9': 'Your established views are shockingly attacked by opponents.',
          '10': 'Rebellion against superiors. Your career is at risk due to a clash with the system.',
          '11': 'A break with old friends who do not accept your new, free views.',
          '12': 'Your inner fears (Saturn) conflict with a subconscious desire to break free (Uranus).'
        },
        'fr': {
          '1': 'Vos fondations et votre stabilité sont attaquées par des personnes ou des circonstances imprévisibles.',
          '2': 'Crise financière. Les anciennes sources de revenus fiables entrent en conflit avec de nouvelles, risquées mais nécessaires.',
          '3': 'Un conflit entre vos idées conservatrices et les vues révolutionnaires des autres.',
          '4': 'Un conflit grave dans la famille entre les générations. Quelqu\'un essaie de détruire les traditions familiales.',
          '5': 'Une relation est déchirée entre le devoir et le désir de liberté. Un partenaire peut se rebeller.',
          '6': 'Un conflit ouvert au travail. La direction (Saturne) contre les innovateurs (Uranus).',
          '7': 'Un partenaire ou un adversaire se rebelle ouvertement contre vos règles et restrictions.',
          '8': 'Les anciennes obligations financières se heurtent à de nouvelles entreprises risquées, créant une crise.',
          '9': 'Vos opinions bien établies sont attaquées de manière choquante par des opposants.',
          '10': 'Rébellion contre les supérieurs. Votre carrière est en danger en raison d\'un conflit avec le système.',
          '11': 'Une rupture avec de vieux amis qui n\'acceptent pas vos nouvelles vues libres.',
          '12': 'Vos peurs intérieures (Saturne) entrent en conflit avec un désir subconscient de vous libérer (Uranus).'
        },
        'de': {
          '1': 'Ihre Grundlagen und Stabilität werden von unvorhersehbaren Menschen oder Umständen angegriffen.',
          '2': 'Finanzkrise. Alte, zuverlässige Einkommensquellen stehen im Konflikt mit neuen, riskanten, aber notwendigen.',
          '3': 'Ein Konflikt zwischen Ihren konservativen Ideen und den revolutionären Ansichten anderer.',
          '4': 'Ein ernster Konflikt in der Familie zwischen den Generationen. Jemand versucht, Familientraditionen zu zerstören.',
          '5': 'Eine Beziehung ist hin- und hergerissen zwischen Pflicht und dem Wunsch nach Freiheit. Ein Partner kann rebellieren.',
          '6': 'Ein offener Konflikt bei der Arbeit. Management (Saturn) gegen Innovatoren (Uranus).',
          '7': 'Ein Partner oder Gegner rebelliert offen gegen Ihre Regeln und Einschränkungen.',
          '8': 'Alte finanzielle Verpflichtungen kollidieren mit neuen riskanten Unternehmungen und verursachen eine Krise.',
          '9': 'Ihre etablierten Ansichten werden von Gegnern schockierend angegriffen.',
          '10': 'Rebellion gegen Vorgesetzte. Ihre Karriere ist aufgrund eines Konflikts mit dem System gefährdet.',
          '11': 'Ein Bruch mit alten Freunden, die Ihre neuen, freien Ansichten nicht akzeptieren.',
          '12': 'Ihre inneren Ängste (Saturn) stehen im Konflikt mit einem unterbewussten Wunsch, sich zu befreien (Uranus).'
        }
      }
    ),
    AspectInterpretation(
      id: 'URANUS_SQUARE_NEPTUNE',
      title: {
        'ru': 'Конфликт Урана и Нептуна',
        'en': 'Uranus Square Neptune',
        'fr': 'Uranus Carré Neptune',
        'de': 'Uran-Quadrat-Neptun'
      },
      descriptionGeneral: {
        'ru': 'Поколенческий аспект, создающий хаос и неопределенность. Революционные идеи (Уран) конфликтуют с духовными идеалами и иллюзиями (Нептун). Время социальных брожений, странных идеологий и потери ориентиров.',
        'en': 'A generational aspect that creates chaos and uncertainty. Revolutionary ideas (Uranus) conflict with spiritual ideals and illusions (Neptune). A time of social unrest, strange ideologies, and loss of direction.',
        'fr': 'Un aspect générationnel qui crée le chaos et l\'incertitude. Les idées révolutionnaires (Uranus) entrent en conflit avec les idéaux spirituels et les illusions (Neptune). Une période d\'agitation sociale, d\'idéologies étranges et de perte de repères.',
        'de': 'Ein generationenübergreifender Aspekt, der Chaos und Unsicherheit schafft. Revolutionäre Ideen (Uranus) stehen im Konflikt mit spirituellen Idealen und Illusionen (Neptun). Eine Zeit sozialer Unruhen, seltsamer Ideologien und Orientierungslosigkeit.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Вы чувствуете себя потерянным. Ваши попытки быть уникальным могут быть не поняты и привести к хаосу.',
          '2': 'Финансовая нестабильность, вызванная глобальными процессами. Странные и непрактичные идеи о заработке.',
          '3': 'Путаница в информации. Трудно отличить правду от вымысла, гениальные идеи от бреда.',
          '4': 'Нестабильность в семье. Идеалистические представления о семье рушатся.',
          '5': 'Странные и запутанные романтические отношения. Погоня за иллюзорной "свободной любовью".',
          '6': 'Хаос в работе. Новые технологии могут применяться не по назначению, вызывая путаницу.',
          '7': 'Ненадежные и хаотичные партнерские отношения. Вы можете быть обмануты идеалами.',
          '8': 'Риск быть втянутым в финансовые махинации или странные оккультные группы.',
          '9': 'Кризис веры. Старые идеалы рушатся, а новые кажутся странными и нежизнеспособными.',
          '10': 'Ваша карьера может пострадать из-за социальных волнений или неясных целей.',
          '11': 'Вы можете попасть в компанию людей со странными, утопическими идеями.',
          '12': 'Активизация подсознательных страхов. Риск ухода от реальности через зависимости.'
        },
        'en': {
          '1': 'You feel lost. Your attempts to be unique may be misunderstood and lead to chaos.',
          '2': 'Financial instability caused by global processes. Strange and impractical ideas about earning money.',
          '3': 'Confusion in information. It\'s hard to distinguish truth from fiction, brilliant ideas from nonsense.',
          '4': 'Instability in the family. Idealistic notions of family are crumbling.',
          '5': 'Strange and confusing romantic relationships. The pursuit of an illusory "free love."',
          '6': 'Chaos at work. New technologies may be misused, causing confusion.',
          '7': 'Unreliable and chaotic partnerships. You may be deceived by ideals.',
          '8': 'Risk of being drawn into financial fraud or strange occult groups.',
          '9': 'A crisis of faith. Old ideals are collapsing, and new ones seem strange and unviable.',
          '10': 'Your career may suffer from social unrest or unclear goals.',
          '11': 'You may fall in with a group of people with strange, utopian ideas.',
          '12': 'Activation of subconscious fears. Risk of escaping reality through addictions.'
        },
        'fr': {
          '1': 'Vous vous sentez perdu. Vos tentatives d\'être unique peuvent être mal comprises et mener au chaos.',
          '2': 'Instabilité financière causée par des processus mondiaux. Idées étranges et peu pratiques pour gagner de l\'argent.',
          '3': 'Confusion dans l\'information. Difficile de distinguer la vérité de la fiction, les idées brillantes des absurdités.',
          '4': 'Instabilité dans la famille. Les notions idéalistes de la famille s\'effondrent.',
          '5': 'Relations amoureuses étranges et confuses. La poursuite d\'un "amour libre" illusoire.',
          '6': 'Chaos au travail. Les nouvelles technologies peuvent être mal utilisées, provoquant la confusion.',
          '7': 'Partenariats peu fiables et chaotiques. Vous pourriez être trompé par des idéaux.',
          '8': 'Risque d\'être entraîné dans une fraude financière ou des groupes occultes étranges.',
          '9': 'Une crise de foi. Les anciens idéaux s\'effondrent, et les nouveaux semblent étranges et non viables.',
          '10': 'Votre carrière peut souffrir de l\'agitation sociale ou d\'objectifs flous.',
          '11': 'Vous pourriez vous retrouver avec un groupe de personnes aux idées étranges et utopiques.',
          '12': 'Activation des peurs subconscientes. Risque d\'échapper à la réalité par les dépendances.'
        },
        'de': {
          '1': 'Sie fühlen sich verloren. Ihre Versuche, einzigartig zu sein, können missverstanden werden und zu Chaos führen.',
          '2': 'Finanzielle Instabilität durch globale Prozesse. Seltsame und unpraktische Ideen zum Geldverdienen.',
          '3': 'Verwirrung in der Information. Es ist schwer, Wahrheit von Fiktion, brillante Ideen von Unsinn zu unterscheiden.',
          '4': 'Instabilität in der Familie. Idealistische Vorstellungen von Familie zerbröckeln.',
          '5': 'Seltsame und verwirrende romantische Beziehungen. Das Streben nach einer illusorischen "freien Liebe".',
          '6': 'Chaos bei der Arbeit. Neue Technologien können missbraucht werden und Verwirrung stiften.',
          '7': 'Unzuverlässige und chaotische Partnerschaften. Sie könnten von Idealen getäuscht werden.',
          '8': 'Gefahr, in Finanzbetrug oder seltsame okkulte Gruppen hineingezogen zu werden.',
          '9': 'Eine Glaubenskrise. Alte Ideale zerfallen, und neue erscheinen seltsam und nicht lebensfähig.',
          '10': 'Ihre Karriere könnte unter sozialen Unruhen oder unklaren Zielen leiden.',
          '11': 'Sie könnten sich einer Gruppe von Menschen mit seltsamen, utopischen Ideen anschließen.',
          '12': 'Aktivierung unbewusster Ängste. Gefahr der Realitätsflucht durch Süchte.'
        }
      }
    ),
    AspectInterpretation(
      id: 'NEPTUNE_SEXTILE_PLUTO',
      title: {
        'ru': 'Шанс от Нептуна и Плутона',
        'en': 'Neptune Sextile Pluto',
        'fr': 'Neptune Sextile Pluton',
        'de': 'Neptun-Sextil-Pluto'
      },
      descriptionGeneral: {
        'ru': 'Поколенческий аспект, дающий возможность для глубокой духовной трансформации. Появляется шанс использовать интуицию и воображение для исцеления и позитивных изменений в обществе.',
        'en': 'A generational aspect that provides an opportunity for deep spiritual transformation. A chance arises to use intuition and imagination for healing and positive social change.',
        'fr': 'Un aspect générationnel qui offre une opportunité de transformation spirituelle profonde. Une chance se présente d\'utiliser l\'intuition et l\'imagination pour la guérison et un changement social positif.',
        'de': 'Ein generationenübergreifender Aspekt, der eine Gelegenheit zur tiefen spirituellen Transformation bietet. Es ergibt sich die Chance, Intuition und Vorstellungskraft für Heilung und positive soziale Veränderungen zu nutzen.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Возможность через духовные практики или творчество глубоко трансформировать свою личность.',
          '2': 'Интуиция помогает найти скрытые ресурсы и использовать их для всеобщего блага.',
          '3': 'Шанс через слова и идеи вдохновить людей на позитивные изменения.',
          '4': 'Возможность исцелить родовые травмы и создать более духовную атмосферу в семье.',
          '5': 'Шанс пережить трансформирующую любовь, основанную на духовной близости.',
          '6': 'Возможность сделать свою работу более осмысленной и помогающей другим.',
          '7': 'Шанс построить глубокие, исцеляющие и трансформирующие отношения.',
          '8': 'Возможность через психологию или эзотерику глубоко понять тайны жизни и смерти.',
          '9': 'Шанс найти духовное учение, которое приведет к глубокой трансформации.',
          '10': 'Возможность реализовать свое призвание в помогающих или творческих профессиях.',
          '11': 'Шанс объединиться с единомышленниками для реализации гуманитарных проектов.',
          '12': 'Возможность через медитацию и работу с подсознанием достичь мощного исцеления.'
        },
        'en': {
          '1': 'An opportunity to deeply transform your personality through spiritual practices or creativity.',
          '2': 'Intuition helps to find hidden resources and use them for the common good.',
          '3': 'A chance to inspire people to make positive changes through words and ideas.',
          '4': 'An opportunity to heal ancestral traumas and create a more spiritual atmosphere in the family.',
          '5': 'A chance to experience a transformative love based on spiritual intimacy.',
          '6': 'An opportunity to make your work more meaningful and helpful to others.',
          '7': 'A chance to build deep, healing, and transformative relationships.',
          '8': 'An opportunity to deeply understand the mysteries of life and death through psychology or esotericism.',
          '9': 'A chance to find a spiritual teaching that will lead to a deep transformation.',
          '10': 'An opportunity to realize your calling in helping or creative professions.',
          '11': 'A chance to unite with like-minded people to implement humanitarian projects.',
          '12': 'An opportunity to achieve powerful healing through meditation and work with the subconscious.'
        },
        'fr': {
          '1': 'Une opportunité de transformer profondément votre personnalité par des pratiques spirituelles ou la créativité.',
          '2': 'L\'intuition aide à trouver des ressources cachées et à les utiliser pour le bien commun.',
          '3': 'Une chance d\'inspirer les gens à opérer des changements positifs par les mots et les idées.',
          '4': 'Une opportunité de guérir les traumatismes ancestraux et de créer une atmosphère plus spirituelle dans la famille.',
          '5': 'Une chance de vivre un amour transformateur basé sur l\'intimité spirituelle.',
          '6': 'Une opportunité de rendre votre travail plus significatif et utile aux autres.',
          '7': 'Une chance de construire des relations profondes, curatives et transformatrices.',
          '8': 'Une opportunité de comprendre profondément les mystères de la vie et de la mort par la psychologie ou l\'ésotérisme.',
          '9': 'Une chance de trouver un enseignement spirituel qui mènera à une transformation profonde.',
          '10': 'Une opportunité de réaliser votre vocation dans des professions d\'aide ou de création.',
          '11': 'Une chance de s\'unir à des personnes partageant les mêmes idées pour mettre en œuvre des projets humanitaires.',
          '12': 'Une opportunité d\'atteindre une guérison puissante par la méditation et le travail avec le subconscient.'
        },
        'de': {
          '1': 'Eine Gelegenheit, Ihre Persönlichkeit durch spirituelle Praktiken oder Kreativität tiefgreifend zu transformieren.',
          '2': 'Die Intuition hilft, verborgene Ressourcen zu finden und sie zum Wohle der Allgemeinheit zu nutzen.',
          '3': 'Eine Chance, Menschen durch Worte und Ideen zu positiven Veränderungen zu inspirieren.',
          '4': 'Eine Gelegenheit, Ahnen-Traumata zu heilen und eine spirituellere Atmosphäre in der Familie zu schaffen.',
          '5': 'Eine Chance, eine transformative Liebe zu erleben, die auf spiritueller Intimität basiert.',
          '6': 'Eine Gelegenheit, Ihre Arbeit sinnvoller und hilfreicher für andere zu gestalten.',
          '7': 'Eine Chance, tiefe, heilende und transformative Beziehungen aufzubauen.',
          '8': 'Eine Gelegenheit, die Geheimnisse von Leben und Tod durch Psychologie oder Esoterik tief zu verstehen.',
          '9': 'Eine Chance, eine spirituelle Lehre zu finden, die zu einer tiefen Transformation führen wird.',
          '10': 'Eine Gelegenheit, Ihre Berufung in helfenden oder kreativen Berufen zu verwirklichen.',
          '11': 'Eine Chance, sich mit Gleichgesinnten zusammenzuschließen, um humanitäre Projekte umzusetzen.',
          '12': 'Eine Gelegenheit, durch Meditation und Arbeit mit dem Unterbewusstsein eine kraftvolle Heilung zu erreichen.'
        }
      }
    ),
    AspectInterpretation(
      id: 'JUPITER_CONJUNCT_PLUTO',
      title: {
        'ru': 'Соединение Юпитера и Плутона',
        'en': 'Jupiter Conjunct Pluto',
        'fr': 'Jupiter Conjoint Pluton',
        'de': 'Jupiter-Konjunktion-Pluto'
      },
      descriptionGeneral: {
        'ru': 'День огромных амбиций и стремления к власти. Желание роста (Юпитер) сливается с волей к тотальной трансформации (Плутон). Возможность для колоссального успеха, но и риск злоупотребления властью.',
        'en': 'A day of huge ambitions and a drive for power. The desire for growth (Jupiter) merges with the will for total transformation (Pluto). An opportunity for colossal success, but also a risk of power abuse.',
        'fr': 'Une journée d\'énormes ambitions et d\'une volonté de puissance. Le désir de croissance (Jupiter) fusionne avec la volonté de transformation totale (Pluton). Une opportunité de succès colossal, mais aussi un risque d\'abus de pouvoir.',
        'de': 'Ein Tag großer Ambitionen und eines Strebens nach Macht. Der Wunsch nach Wachstum (Jupiter) verschmilzt mit dem Willen zur totalen Transformation (Pluto). Eine Gelegenheit für kolossalen Erfolg, aber auch die Gefahr des Machtmissbrauchs.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Вы чувствуете в себе силу изменить свою жизнь и мир вокруг. Огромное стремление к личному росту и влиянию.',
          '2': 'Одержимость большими деньгами. Возможность как сказочно разбогатеть, так и все потерять.',
          '3': 'Ваши слова и идеи обретают огромную силу и влияние. Вы можете убедить кого угодно.',
          '4': 'Стремление к полному контролю и доминированию в семье. Масштабные проекты с недвижимостью.',
          '5': 'Всепоглощающая страсть в любви. Желание полностью обладать партнером. Большие ставки в играх.',
          '6': 'Фанатичное стремление реформировать свою работу, что может привести к успеху или конфликту.',
          '7': 'Стремление найти очень влиятельного партнера или полностью трансформировать существующие отношения.',
          '8': 'Огромные финансовые возможности через кредиты, инвестиции, наследство. Но и огромные риски.',
          '9': 'Фанатичная вера в свои идеи, стремление распространить их на весь мир.',
          '10': 'Вы стремитесь к максимальной власти и статусу в карьере. Возможность большого прорыва.',
          '11': 'Вы можете стать абсолютным лидером в группе, ведя ее к большим целям.',
          '12': 'Глубокая работа с подсознанием, которая дает вам огромную скрытую силу.'
        },
        'en': {
          '1': 'You feel the power within you to change your life and the world around you. A huge drive for personal growth and influence.',
          '2': 'An obsession with big money. An opportunity to either get fabulously rich or lose everything.',
          '3': 'Your words and ideas gain immense power and influence. You can convince anyone of anything.',
          '4': 'A drive for complete control and dominance in the family. Large-scale real estate projects.',
          '5': 'All-consuming passion in love. A desire to completely possess a partner. High-stakes gambling.',
          '6': 'A fanatical desire to reform your work, which can lead to success or conflict.',
          '7': 'A drive to find a very influential partner or completely transform an existing relationship.',
          '8': 'Huge financial opportunities through loans, investments, inheritance. But also huge risks.',
          '9': 'A fanatical belief in your ideas, a desire to spread them to the whole world.',
          '10': 'You strive for maximum power and status in your career. An opportunity for a major breakthrough.',
          '11': 'You can become the absolute leader in a group, leading it to great goals.',
          '12': 'Deep work with the subconscious that gives you immense hidden power.'
        },
        'fr': {
          '1': 'Vous sentez en vous le pouvoir de changer votre vie et le monde qui vous entoure. Une immense volonté de croissance et d\'influence personnelles.',
          '2': 'Une obsession pour l\'argent. Une opportunité de devenir fabuleusement riche ou de tout perdre.',
          '3': 'Vos paroles et vos idées acquièrent un pouvoir et une influence immenses. Vous pouvez convaincre n\'importe qui de n\'importe quoi.',
          '4': 'Une volonté de contrôle et de domination complets dans la famille. Projets immobiliers de grande envergure.',
          '5': 'Passion dévorante en amour. Un désir de posséder complètement un partenaire. Jeux à gros enjeux.',
          '6': 'Un désir fanatique de réformer votre travail, ce qui peut mener au succès ou au conflit.',
          '7': 'Une volonté de trouver un partenaire très influent ou de transformer complètement une relation existante.',
          '8': 'Énormes opportunités financières par le biais de prêts, d\'investissements, d\'héritages. Mais aussi d\'énormes risques.',
          '9': 'Une croyance fanatique en vos idées, un désir de les répandre dans le monde entier.',
          '10': 'Vous aspirez au pouvoir et au statut maximums dans votre carrière. Une opportunité de percée majeure.',
          '11': 'Vous pouvez devenir le leader absolu d\'un groupe, le menant vers de grands objectifs.',
          '12': 'Un travail profond avec le subconscient qui vous donne un immense pouvoir caché.'
        },
        'de': {
          '1': 'Sie spüren die Kraft in sich, Ihr Leben und die Welt um Sie herum zu verändern. Ein riesiger Drang nach persönlichem Wachstum und Einfluss.',
          '2': 'Eine Besessenheit von großem Geld. Eine Gelegenheit, entweder sagenhaft reich zu werden oder alles zu verlieren.',
          '3': 'Ihre Worte und Ideen gewinnen immense Kraft und Einfluss. Sie können jeden von allem überzeugen.',
          '4': 'Ein Streben nach vollständiger Kontrolle und Dominanz in der Familie. Große Immobilienprojekte.',
          '5': 'Alles verzehrende Leidenschaft in der Liebe. Ein Wunsch, einen Partner vollständig zu besitzen. Glücksspiel mit hohen Einsätzen.',
          '6': 'Ein fanatischer Wunsch, Ihre Arbeit zu reformieren, was zu Erfolg oder Konflikt führen kann.',
          '7': 'Ein Streben, einen sehr einflussreichen Partner zu finden oder eine bestehende Beziehung vollständig zu transformieren.',
          '8': 'Riesige finanzielle Möglichkeiten durch Kredite, Investitionen, Erbschaften. Aber auch riesige Risiken.',
          '9': 'Ein fanatischer Glaube an Ihre Ideen, ein Wunsch, sie in die ganze Welt zu verbreiten.',
          '10': 'Sie streben nach maximaler Macht und Status in Ihrer Karriere. Eine Gelegenheit für einen großen Durchbruch.',
          '11': 'Sie können zum absoluten Anführer in einer Gruppe werden und sie zu großen Zielen führen.',
          '12': 'Tiefe Arbeit mit dem Unterbewusstsein, die Ihnen immense verborgene Kraft verleiht.'
        }
      }
    ),
            // === НОВЫЙ БЛОК 26 (ФИНАЛЬНЫЙ) ===
    AspectInterpretation(
      id: 'JUPITER_SEXTILE_SATURN',
      title: {
        'ru': 'Шанс от Юпитера и Сатурна',
        'en': 'Jupiter Sextile Saturn',
        'fr': 'Jupiter Sextile Saturne',
        'de': 'Jupiter-Sextil-Saturn'
      },
      descriptionGeneral: {
        'ru': 'День дает возможность для планомерного и стабильного роста. Ваши амбициозные планы (Юпитер) получают практическую поддержку и структуру (Сатурн). Отлично для начала долгосрочных проектов.',
        'en': 'The day provides an opportunity for steady and stable growth. Your ambitious plans (Jupiter) receive practical support and structure (Saturn). Excellent for starting long-term projects.',
        'fr': 'La journée offre une opportunité de croissance régulière et stable. Vos plans ambitieux (Jupiter) reçoivent un soutien pratique et une structure (Saturne). Excellent pour démarrer des projets à long terme.',
        'de': 'Der Tag bietet die Möglichkeit für stetiges und stabiles Wachstum. Ihre ehrgeizigen Pläne (Jupiter) erhalten praktische Unterstützung und Struktur (Saturn). Ausgezeichnet für den Start langfristiger Projekte.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Возможность для зрелого и планомерного личностного роста. Вы производите впечатление надежного человека.',
          '2': 'Шанс заложить прочный фундамент для своего финансового будущего. Успешные, обдуманные инвестиции.',
          '3': 'Возможность получить мудрый и практичный совет, который поможет в реализации ваших планов.',
          '4': 'Шанс начать строительство или крупный ремонт, который будет успешным.',
          '5': 'Возможность перевести отношения на более серьезный и стабильный уровень.',
          '6': 'Шанс через упорный труд и планирование добиться значительных улучшений на работе.',
          '7': 'Возможность заключить надежное и долгосрочное партнерство, как в бизнесе, так и в личной жизни.',
          '8': 'Хороший шанс для решения вопросов с крупными, долгосрочными кредитами или инвестициями.',
          '9': 'Возможность начать серьезное обучение, которое принесет плоды в будущем.',
          '10': 'Шанс получить поддержку от начальства для реализации ваших долгосрочных карьерных планов.',
          '11': 'Возможность вместе с друзьями запустить серьезный и перспективный проект.',
          '12': 'Шанс через дисциплину и усердие справиться со своими внутренними страхами.'
        },
        'en': {
          '1': 'An opportunity for mature and planned personal growth. You give the impression of a reliable person.',
          '2': 'A chance to lay a solid foundation for your financial future. Successful, well-considered investments.',
          '3': 'An opportunity to get wise and practical advice that will help in realizing your plans.',
          '4': 'A chance to start construction or a major renovation that will be successful.',
          '5': 'An opportunity to take a relationship to a more serious and stable level.',
          '6': 'A chance to achieve significant improvements at work through hard work and planning.',
          '7': 'An opportunity to form a reliable and long-term partnership, both in business and in personal life.',
          '8': 'A good chance to resolve issues with large, long-term loans or investments.',
          '9': 'An opportunity to start a serious course of study that will bear fruit in the future.',
          '10': 'A chance to get support from your superiors for your long-term career plans.',
          '11': 'An opportunity to launch a serious and promising project together with friends.',
          '12': 'A chance to cope with your inner fears through discipline and diligence.'
        },
        'fr': {
          '1': 'Une opportunité de croissance personnelle mûre et planifiée. Vous donnez l\'impression d'être une personne fiable.',
          '2': 'Une chance de jeter des bases solides pour votre avenir financier. Des investissements réussis et bien réfléchis.',
          '3': 'Une opportunité d\'obtenir des conseils sages et pratiques qui vous aideront à réaliser vos projets.',
          '4': 'Une chance de commencer une construction ou une rénovation majeure qui sera réussie.',
          '5': 'Une opportunité d\'amener une relation à un niveau plus sérieux et stable.',
          '6': 'Une chance d\'obtenir des améliorations significatives au travail grâce à un travail acharné et à la planification.',
          '7': 'Une opportunité de former un partenariat fiable et à long terme, tant dans les affaires que dans la vie personnelle.',
          '8': 'Une bonne chance de résoudre les problèmes de prêts ou d\'investissements importants et à long terme.',
          '9': 'Une opportunité de commencer un cycle d\'études sérieux qui portera ses fruits à l\'avenir.',
          '10': 'Une chance d\'obtenir le soutien de vos supérieurs pour vos projets de carrière à long terme.',
          '11': 'Une opportunité de lancer un projet sérieux et prometteur avec des amis.',
          '12': 'Une chance de faire face à vos peurs intérieures par la discipline et la diligence.'
        },
        'de': {
          '1': 'Eine Gelegenheit für reifes und geplantes persönliches Wachstum. Sie machen den Eindruck einer zuverlässigen Person.',
          '2': 'Eine Chance, ein solides Fundament für Ihre finanzielle Zukunft zu legen. Erfolgreiche, gut überlegte Investitionen.',
          '3': 'Eine Gelegenheit, weisen und praktischen Rat zu erhalten, der bei der Verwirklichung Ihrer Pläne hilft.',
          '4': 'Eine Chance, mit dem Bau oder einer größeren Renovierung zu beginnen, die erfolgreich sein wird.',
          '5': 'Eine Gelegenheit, eine Beziehung auf eine ernstere und stabilere Ebene zu bringen.',
          '6': 'Eine Chance, durch harte Arbeit und Planung erhebliche Verbesserungen bei der Arbeit zu erzielen.',
          '7': 'Eine Gelegenheit, eine zuverlässige und langfristige Partnerschaft einzugehen, sowohl geschäftlich als auch privat.',
          '8': 'Eine gute Chance, Probleme mit großen, langfristigen Krediten oder Investitionen zu lösen.',
          '9': 'Eine Gelegenheit, ein ernsthaftes Studium zu beginnen, das in Zukunft Früchte tragen wird.',
          '10': 'Eine Chance, Unterstützung von Ihren Vorgesetzten für Ihre langfristigen Karrierepläne zu erhalten.',
          '11': 'Eine Gelegenheit, gemeinsam mit Freunden ein ernsthaftes und vielversprechendes Projekt zu starten.',
          '12': 'Eine Chance, durch Disziplin und Fleiß mit Ihren inneren Ängsten fertig zu werden.'
        }
      }
    ),
    AspectInterpretation(
      id: 'SATURN_CONJUNCT_NEPTUNE',
      title: {
        'ru': 'Соединение Сатурна и Нептуна',
        'en': 'Saturn Conjunct Neptune',
        'fr': 'Saturne Conjoint Neptune',
        'de': 'Saturn-Konjunktion-Neptun'
      },
      descriptionGeneral: {
        'ru': 'День столкновения мечты и реальности. Ваши идеалы (Нептун) проходят проверку на прочность (Сатурн). Возможно разочарование, но это и время для воплощения самых заветных желаний через упорный труд.',
        'en': 'A day of collision between dreams and reality. Your ideals (Neptune) are being tested for strength (Saturn). Disappointment is possible, but it is also a time to realize your most cherished desires through hard work.',
        'fr': 'Une journée de collision entre les rêves et la réalité. Vos idéaux (Neptune) sont mis à l'épreuve de leur solidité (Saturne). La déception est possible, mais c\'est aussi le moment de réaliser vos désirs les plus chers par un travail acharné.',
        'de': 'Ein Tag des Zusammenpralls von Träumen und Realität. Ihre Ideale (Neptun) werden auf ihre Stärke geprüft (Saturn). Enttäuschung ist möglich, aber es ist auch eine Zeit, um Ihre sehnlichsten Wünsche durch harte Arbeit zu verwirklichen.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Вынужденный отказ от иллюзий о себе. Время повзрослеть и трезво взглянуть на себя.',
          '2': 'Ваши мечты о богатстве сталкиваются с финансовой реальностью. Необходимо упорно трудиться.',
          '3': 'Трудно выразить свои мечты словами. Вы можете столкнуться с непониманием и критикой.',
          '4': 'Идеализированные представления о семье рушатся. Тяжелая, но необходимая работа над отношениями.',
          '5': 'Любовь проходит проверку реальностью. "Розовые очки" спадают, что может быть болезненно.',
          '6': 'Разочарование в работе. Вынужденный отказ от "работы мечты" в пользу стабильности.',
          '7': 'Партнерские отношения теряют романтический флер, на первый план выходят обязанности.',
          '8': 'Страхи и фобии обретают реальные очертания. Вынужденная работа над своими комплексами.',
          '9': 'Кризис веры. Ваши духовные идеалы сталкиваются с суровой правдой жизни.',
          '10': 'Ваши мечты о карьере проходят проверку на реалистичность. Необходимо много работать.',
          '11': 'Разочарование в друзьях или в общих идеалах.',
          '12': 'Время, когда ваши тайные страхи материализуются, заставляя вас работать над ними.'
        },
        'en': {
          '1': 'A forced rejection of illusions about yourself. Time to grow up and take a sober look at yourself.',
          '2': 'Your dreams of wealth clash with financial reality. Hard work is necessary.',
          '3': 'It\'s difficult to put your dreams into words. You may face misunderstanding and criticism.',
          '4': 'Idealized notions of family are crumbling. Difficult but necessary work on relationships.',
          '5': 'Love undergoes a reality check. The "rose-colored glasses" come off, which can be painful.',
          '6': 'Disappointment in your job. A forced rejection of a "dream job" in favor of stability.',
          '7': 'Partnerships lose their romantic flair, and duties come to the forefront.',
          '8': 'Fears and phobias take on real shape. Forced work on your complexes.',
          '9': 'A crisis of faith. Your spiritual ideals clash with the harsh truth of life.',
          '10': 'Your career dreams are tested for realism. A lot of work is required.',
          '11': 'Disappointment in friends or in shared ideals.',
          '12': 'A time when your secret fears materialize, forcing you to work on them.'
        },
        'fr': {
          '1': 'Un rejet forcé des illusions sur vous-même. Il est temps de grandir et de se regarder sobrement.',
          '2': 'Vos rêves de richesse se heurtent à la réalité financière. Un travail acharné est nécessaire.',
          '3': 'Difficile de mettre des mots sur vos rêves. Vous pourriez faire face à l\'incompréhension et à la critique.',
          '4': 'Les notions idéalisées de la famille s\'effondrent. Un travail difficile mais nécessaire sur les relations.',
          '5': 'L\'amour subit un test de réalité. Les "lunettes roses" tombent, ce qui peut être douloureux.',
          '6': 'Déception dans votre travail. Un rejet forcé d\'un "emploi de rêve" en faveur de la stabilité.',
          '7': 'Les partenariats perdent leur flair romantique, et les devoirs passent au premier plan.',
          '8': 'Les peurs et les phobies prennent une forme réelle. Travail forcé sur vos complexes.',
          '9': 'Une crise de foi. Vos idéaux spirituels se heurtent à la dure vérité de la vie.',
          '10': 'Vos rêves de carrière sont testés pour leur réalisme. Beaucoup de travail est requis.',
          '11': 'Déception envers des amis ou des idéaux partagés.',
          '12': 'Une période où vos peurs secrètes se matérialisent, vous forçant à travailler dessus.'
        },
        'de': {
          '1': 'Eine erzwungene Ablehnung von Illusionen über sich selbst. Zeit, erwachsen zu werden und sich nüchtern zu betrachten.',
          '2': 'Ihre Träume von Reichtum kollidieren mit der finanziellen Realität. Harte Arbeit ist notwendig.',
          '3': 'Es ist schwierig, Ihre Träume in Worte zu fassen. Sie könnten auf Unverständnis und Kritik stoßen.',
          '4': 'Idealisierte Vorstellungen von Familie zerbröckeln. Schwierige, aber notwendige Arbeit an Beziehungen.',
          '5': 'Die Liebe wird einem Realitätscheck unterzogen. Die "rosarote Brille" wird abgenommen, was schmerzhaft sein kann.',
          '6': 'Enttäuschung im Job. Eine erzwungene Ablehnung eines "Traumjobs" zugunsten von Stabilität.',
          '7': 'Partnerschaften verlieren ihren romantischen Flair, und Pflichten treten in den Vordergrund.',
          '8': 'Ängste und Phobien nehmen reale Gestalt an. Erzwungene Arbeit an Ihren Komplexen.',
          '9': 'Eine Glaubenskrise. Ihre spirituellen Ideale kollidieren mit der harten Wahrheit des Lebens.',
          '10': 'Ihre Karriereträume werden auf Realismus geprüft. Viel Arbeit ist erforderlich.',
          '11': 'Enttäuschung von Freunden oder von gemeinsamen Idealen.',
          '12': 'Eine Zeit, in der Ihre geheimen Ängste Gestalt annehmen und Sie zwingen, daran zu arbeiten.'
        }
      }
    ),
    AspectInterpretation(
      id: 'URANUS_OPPOSITION_PLUTO',
      title: {
        'ru': 'Противостояние Урана и Плутона',
        'en': 'Uranus Opposition Pluto',
        'fr': 'Uranus Opposition Pluton',
        'de': 'Uran-Opposition-Pluto'
      },
      descriptionGeneral: {
        'ru': 'Поколенческий аспект революционных потрясений. Желание свободы и обновления (Уран) сталкивается с мощными силами контроля и трансформации (Плутон). Время социальных кризисов и борьбы за власть.',
        'en': 'A generational aspect of revolutionary upheavals. The desire for freedom and renewal (Uranus) clashes with powerful forces of control and transformation (Pluto). A time of social crises and power struggles.',
        'fr': 'Un aspect générationnel de bouleversements révolutionnaires. Le désir de liberté et de renouveau (Uranus) se heurte à de puissantes forces de contrôle et de transformation (Pluton). Une période de crises sociales et de luttes de pouvoir.',
        'de': 'Ein generationenübergreifender Aspekt revolutionärer Umwälzungen. Der Wunsch nach Freiheit und Erneuerung (Uranus) kollidiert mit mächtigen Kräften der Kontrolle und Transformation (Pluto). Eine Zeit sozialer Krisen und Machtkämpfe.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Вы разрываетесь между желанием личной свободы и давлением мощных внешних обстоятельств.',
          '2': 'Финансовые системы подвергаются серьезным потрясениям, что напрямую влияет на ваши ресурсы.',
          '3': 'Ваши революционные идеи сталкиваются с мощной пропагандой и попытками контроля информации.',
          '4': 'Семейные устои и традиции разрушаются под давлением внешних социальных изменений.',
          '5': 'Ваше стремление к свободной любви сталкивается с общественными табу и контролем.',
          '6': 'Революционные изменения на работе, которые вы не можете контролировать.',
          '7': 'Партнерские отношения проходят проверку на прочность в условиях социального хаоса.',
          '8': 'Глобальные финансовые кризисы, которые заставляют вас полностью пересмотреть свою жизнь.',
          '9': 'Борьба между новыми идеологиями и старыми системами власти.',
          '10': 'Ваша карьера и статус могут быть разрушены в ходе социальных потрясений.',
          '11': 'Социальные группы и движения вступают в открытый конфликт с властью.',
          '12': 'Глубокий внутренний кризис, вызванный хаосом и нестабильностью в мире.'
        },
        'en': {
          '1': 'You are torn between the desire for personal freedom and the pressure of powerful external circumstances.',
          '2': 'Financial systems undergo major upheavals, which directly affects your resources.',
          '3': 'Your revolutionary ideas clash with powerful propaganda and attempts to control information.',
          '4': 'Family foundations and traditions are destroyed under the pressure of external social changes.',
          '5': 'Your pursuit of free love clashes with social taboos and control.',
          '6': 'Revolutionary changes at work that you cannot control.',
          '7': 'Partnerships are tested for strength in conditions of social chaos.',
          '8': 'Global financial crises that force you to completely reconsider your life.',
          '9': 'A struggle between new ideologies and old systems of power.',
          '10': 'Your career and status can be destroyed in the course of social upheavals.',
          '11': 'Social groups and movements enter into open conflict with the authorities.',
          '12': 'A deep internal crisis caused by chaos and instability in the world.'
        },
        'fr': {
          '1': 'Vous êtes déchiré entre le désir de liberté personnelle et la pression de puissantes circonstances extérieures.',
          '2': 'Les systèmes financiers subissent des bouleversements majeurs, ce qui affecte directement vos ressources.',
          '3': 'Vos idées révolutionnaires se heurtent à une propagande puissante et à des tentatives de contrôle de l\'information.',
          '4': 'Les fondements et les traditions familiales sont détruits sous la pression des changements sociaux externes.',
          '5': 'Votre quête de l\'amour libre se heurte aux tabous sociaux et au contrôle.',
          '6': 'Changements révolutionnaires au travail que vous ne pouvez pas contrôler.',
          '7': 'Les partenariats sont mis à l\'épreuve de leur solidité dans des conditions de chaos social.',
          '8': 'Les crises financières mondiales qui vous obligent à reconsidérer complètement votre vie.',
          '9': 'Une lutte entre les nouvelles idéologies et les anciens systèmes de pouvoir.',
          '10': 'Votre carrière et votre statut peuvent être détruits au cours des bouleversements sociaux.',
          '11': 'Les groupes et mouvements sociaux entrent en conflit ouvert avec les autorités.',
          '12': 'Une crise interne profonde causée par le chaos et l\'instabilité dans le monde.'
        },
        'de': {
          '1': 'Sie sind hin- und hergerissen zwischen dem Wunsch nach persönlicher Freiheit und dem Druck mächtiger äußerer Umstände.',
          '2': 'Finanzsysteme erleben große Umwälzungen, die sich direkt auf Ihre Ressourcen auswirken.',
          '3': 'Ihre revolutionären Ideen kollidieren mit mächtiger Propaganda und Versuchen, Informationen zu kontrollieren.',
          '4': 'Familiengrundlagen und -traditionen werden unter dem Druck äußerer sozialer Veränderungen zerstört.',
          '5': 'Ihr Streben nach freier Liebe kollidiert mit sozialen Tabus und Kontrolle.',
          '6': 'Revolutionäre Veränderungen bei der Arbeit, die Sie nicht kontrollieren können.',
          '7': 'Partnerschaften werden unter den Bedingungen des sozialen Chaos auf ihre Stärke geprüft.',
          '8': 'Globale Finanzkrisen, die Sie zwingen, Ihr Leben komplett zu überdenken.',
          '9': 'Ein Kampf zwischen neuen Ideologien und alten Machtsystemen.',
          '10': 'Ihre Karriere und Ihr Status können im Zuge sozialer Umwälzungen zerstört werden.',
          '11': 'Soziale Gruppen und Bewegungen geraten in offenen Konflikt mit den Behörden.',
          '12': 'Eine tiefe interne Krise, verursacht durch Chaos und Instabilität in der Welt.'
        }
      }
    ),
    AspectInterpretation(
      id: 'SATURN_CONJUNCT_PLUTO',
      title: {
        'ru': 'Соединение Сатурна и Плутона',
        'en': 'Saturn Conjunct Pluto',
        'fr': 'Saturne Conjoint Pluton',
        'de': 'Saturn-Konjunktion-Pluto'
      },
      descriptionGeneral: {
        'ru': 'Очень мощный и тяжелый аспект. Старые структуры (Сатурн) разрушаются до основания, чтобы на их месте возникли новые, более прочные (Плутон). Время глобальных кризисов, требующих выносливости и воли.',
        'en': 'A very powerful and heavy aspect. Old structures (Saturn) are destroyed to the ground so that new, more durable ones (Pluto) can emerge in their place. A time of global crises that require endurance and will.',
        'fr': 'Un aspect très puissant et lourd. Les anciennes structures (Saturne) sont détruites jusqu\'aux fondations pour que de nouvelles, plus durables (Pluton), puissent émerger à leur place. Une période de crises mondiales qui exigent de l\'endurance et de la volonté.',
        'de': 'Ein sehr kraftvoller und schwerer Aspekt. Alte Strukturen (Saturn) werden bis auf die Grundmauern zerstört, damit an ihrer Stelle neue, haltbarere (Pluto) entstehen können. Eine Zeit globaler Krisen, die Ausdauer und Willen erfordern.'
      },
      descriptionByHouse: {
        'ru': {
          '1': 'Глубокая личностная трансформация через серьезные испытания. Вы становитесь сильнее, но это дается тяжело.',
          '2': 'Полная перестройка финансовой системы. Старые источники дохода разрушаются, заставляя строить все с нуля.',
          '3': 'Ваше мышление и круг общения проходят через кризис и тотальную чистку.',
          '4': 'Кризис, связанный с домом, семьей, родиной. Разрушение старых семейных устоев.',
          '5': 'Отношения проходят через тяжелейшие испытания, которые либо разрушают их, либо делают нерушимыми.',
          '6': 'Полная реорганизация работы или проблемы со здоровьем, требующие огромной дисциплины.',
          '7': 'Кризис в партнерстве. Отношения либо заканчиваются, либо переходят на совершенно новый, более глубокий уровень.',
          '8': 'Глобальный финансовый кризис, который заставляет вас полностью перестроить свою жизнь.',
          '9': 'Полный крах старого мировоззрения. Вы вынуждены строить новую систему ценностей.',
          '10': 'Серьезный кризис в карьере или столкновение с государственной машиной. Разрушение старых амбиций.',
          '11': 'Ваши цели и круг друзей полностью меняются после серьезного кризиса.',
          '12': 'Вы сталкиваетесь лицом к лицу со своими самыми глубокими страхами, что требует огромной воли для их преодоления.'
        },
        'en': {
          '1': 'A deep personal transformation through serious trials. You become stronger, but it is hard-won.',
          '2': 'A complete overhaul of the financial system. Old sources of income are destroyed, forcing you to build everything from scratch.',
          '3': 'Your thinking and social circle go through a crisis and a total cleansing.',
          '4': 'A crisis related to home, family, homeland. The destruction of old family foundations.',
          '5': 'Relationships go through the toughest trials, which either destroy them or make them unbreakable.',
          '6': 'A complete reorganization of work or health problems that require immense discipline.',
          '7': 'A crisis in partnership. The relationship either ends or moves to a completely new, deeper level.',
          '8': 'A global financial crisis that forces you to completely rebuild your life.',
          '9': 'A complete collapse of your old worldview. You are forced to build a new value system.',
          '10': 'A serious crisis in your career or a clash with the state machine. The destruction of old ambitions.',
          '11': 'Your goals and circle of friends change completely after a serious crisis.',
          '12': 'You come face to face with your deepest fears, which requires immense will to overcome.'
        },
        'fr': {
          '1': 'Une transformation personnelle profonde à travers de sérieuses épreuves. Vous devenez plus fort, mais c\'est durement gagné.',
          '2': 'Une refonte complète du système financier. Les anciennes sources de revenus sont détruites, vous forçant à tout reconstruire à partir de zéro.',
          '3': 'Votre pensée et votre cercle social traversent une crise et un nettoyage total.',
          '4': 'Une crise liée à la maison, à la famille, à la patrie. La destruction des anciennes fondations familiales.',
          '5': 'Les relations traversent les épreuves les plus difficiles, qui soit les détruisent, soit les rendent incassables.',
          '6': 'Une réorganisation complète du travail ou des problèmes de santé qui nécessitent une immense discipline.',
          '7': 'Une crise dans le partenariat. La relation se termine ou passe à un niveau complètement nouveau et plus profond.',
          '8': 'Une crise financière mondiale qui vous oblige à reconstruire complètement votre vie.',
          '9': 'Un effondrement complet de votre ancienne vision du monde. Vous êtes obligé de construire un nouveau système de valeurs.',
          '10': 'Une crise grave dans votre carrière ou un affrontement avec la machine de l\'État. La destruction des anciennes ambitions.',
          '11': 'Vos objectifs et votre cercle d\'amis changent complètement après une crise grave.',
          '12': 'Vous vous retrouvez face à vos peurs les plus profondes, ce qui demande une immense volonté pour les surmonter.'
        },
        'de': {
          '1': 'Eine tiefe persönliche Transformation durch ernste Prüfungen. Sie werden stärker, aber es ist hart erkämpft.',
          '2': 'Eine vollständige Überholung des Finanzsystems. Alte Einkommensquellen werden zerstört, was Sie zwingt, alles von Grund auf neu aufzubauen.',
          '3': 'Ihr Denken und Ihr sozialer Kreis durchlaufen eine Krise und eine totale Reinigung.',
          '4': 'Eine Krise im Zusammenhang mit Zuhause, Familie, Heimat. Die Zerstörung alter Familiengrundlagen.',
          '5': 'Beziehungen durchlaufen die härtesten Prüfungen, die sie entweder zerstören oder unzerbrechlich machen.',
          '6': 'Eine vollständige Reorganisation der Arbeit oder Gesundheitsprobleme, die immense Disziplin erfordern.',
          '7': 'Eine Krise in der Partnerschaft. Die Beziehung endet entweder oder geht auf eine völlig neue, tiefere Ebene über.',
          '8': 'Eine globale Finanzkrise, die Sie zwingt, Ihr Leben komplett neu aufzubauen.',
          '9': 'Ein vollständiger Zusammenbruch Ihrer alten Weltanschauung. Sie sind gezwungen, ein neues Wertesystem aufzubauen.',
          '10': 'Eine ernste Krise in Ihrer Karriere oder ein Zusammenstoß mit der Staatsmaschinerie. Die Zerstörung alter Ambitionen.',
          '11': 'Ihre Ziele und Ihr Freundeskreis ändern sich nach einer schweren Krise komplett.',
          '12': 'Sie stehen Ihren tiefsten Ängsten von Angesicht zu Angesicht gegenüber, was einen immensen Willen zur Überwindung erfordert.'
        }
      }
    ),



























  ];

  # --- 3. ЛОГИКА ЗАГРУЗКИ В FIRESTORE ---

# Получаем ссылку на коллекцию
collection_ref = db.collection('aspect_interpretations')

# Используем WriteBatch для эффективности
batch = db.batch()
count = 0

logger.d(f'Подготовлено {len(interpretations)} документов для загрузки.')

for aspect_data in interpretations:
    # Получаем ID из наших данных
    doc_id = aspect_data['id']
    # Создаем ссылку на документ
    doc_ref = collection_ref.document(doc_id)
    
    # Готовим данные для записи (убираем 'id' из словаря)
    data_to_write = {key: value for key, value in aspect_data.items() if key != 'id'}
    
    # Добавляем операцию в "пакет"
    batch.set(doc_ref, data_to_write)
    count += 1
    logger.d(f'  -> Добавлено в пакет: {doc_id}')

# Отправляем весь пакет на сервер одним запросом
batch.commit()

logger.d(f'✅ Готово! Успешно загружено {count} интерпретаций в коллекцию "aspect_interpretations".')
}