// lib/temp_test.dart

import 'dart:convert';
 // Убедись, что путь верный
import 'package:lovequest/src/data/models/astrology/natal_chart.dart'; // И этот тоже
import 'package:flutter/material.dart';

import 'services/logger_service.dart';
import 'src/data/models/user_profile_card.dart'; // нужен для runApp

// ЗАПУСКАТЬ ЭТОТ ФАЙЛ НАПРЯМУЮ: dart run lib/temp_test.dart
void main() {
  runApp(MaterialApp(home: Scaffold(body: Center(child: Text("Testing...")))));
  logger.d("--- ЗАПУСК ТЕСТА ПАРСИНГА ---");

  // Твой JSON, который мы скопировали из логов
  const rawJsonString = '''
  [{"id":"1COOBXxBBZevbIAUh3cGJ65MgEl1","name":"Алексей","surname":"","bio":"","avatarUrl":"ic_zodiac_aries","gender":"male","seekingGender":"female","birthDateMillis":"417589200000","birthTime":"12:00:00","birthCity":"Канск","birthCountry":"Россия","birthLocation":"0101000020E61000003B8F8AFF3BED57407D09151C5E1A4C40","currentLocation":"0101000020E61000003B8F8AFF3BED57407D09151C5E1A4C40","city":"Канск","country":"Россия","role":"user","onesignalPlayerId":null,"referralCode":"LQ-1COOBX","hasUsedReferral":false,"hasUsedTrial":true,"trialEndsAt":"2025-09-25T13:11:42.318Z","premiumEndsAt":null,"isBanned":false,"photoCount":0,"createdAt":null,"lastOnline":"2025-09-22T13:11:43.011Z","natalChart":{"zoneId":{"id":"Asia/Krasnoyarsk"},"sunSign":"Aries","latitude":56.205997,"marsSign":"Aries","moonSign":"Virgo","longitude":95.706787,"venusSign":"Taurus","saturnSign":"Scorpio","mercurySign":"Aries","ascendantSign":"Cancer","birthDateTime":{"hour":12,"year":1983,"minute":0,"dayOfMonth":27,"monthValue":3}},"numerologyData":{"destiny":2,"birthday":9,"lifePath":6,"soulUrge":11,"personality":9},"searchKeywords":["алексей"],"bioHashtags":[],"bioKeywords":[],"sunSign":"Aries","moonSign":"Virgo","partnerOfTheDay":{"dateShown":"2025-09-22","partnerId":"AJ1YMdVxsbGGDHl9mXSu","compatibilityScore":74},"focusOfTheDay":null,"cardOfTheDay":{"date":"2025-10-15","cardId":6,"isReversed":false}},{"id":"1t3uVRQKkSZNp6GW03nANcP1FQD2","name":"Мария","surname":"","bio":"","avatarUrl":"ic_zodiac_virgo","gender":"female","seekingGender":"male","birthDateMillis":"432180000000","birthTime":"06:00:00","birthCity":"Неизвестный город","birthCountry":"Россия","birthLocation":"0101000020E6100000D9486D3D9ECD42406D8C9DF012D04B40","currentLocation":"0101000020E6100000D9486D3D9ECD42406D8C9DF012D04B40","city":"Неизвестный город","country":"Россия","role":"user","onesignalPlayerId":null,"referralCode":"LQ-1T3UVR","hasUsedReferral":false,"hasUsedTrial":true,"trialEndsAt":"2025-09-26T19:03:27.570Z","premiumEndsAt":null,"isBanned":false,"photoCount":1,"createdAt":null,"lastOnline":"2025-09-23T19:01:32.515Z","natalChart":{"zoneId":{"id":"Europe/Moscow"},"sunSign":"Virgo","latitude":55.625578,"marsSign":"Leo","moonSign":"Scorpio","longitude":37.6063916,"venusSign":"Leo","saturnSign":"Scorpio","mercurySign":"Virgo","ascendantSign":"Virgo","birthDateTime":{"hour":6,"year":1983,"minute":0,"dayOfMonth":12,"monthValue":9}},"numerologyData":{"destiny":1,"birthday":3,"lifePath":6,"soulUrge":4,"personality":6},"searchKeywords":["мария"],"bioHashtags":[],"bioKeywords":[],"sunSign":"Virgo","moonSign":"Scorpio","partnerOfTheDay":{"dateShown":"2025-09-23","partnerId":"1COOBXxBBZevbIAUh3cGJ65MgEl1","compatibilityScore":78},"focusOfTheDay":null,"cardOfTheDay":{"date":"2025-10-15","cardId":6,"isReversed":false}},{"id":"A7RuqyEn8ic9a5TPaI4LjtGUz4E3","name":"Анастасия ","surname":"","bio":"","avatarUrl":"avatar_female","gender":"female","seekingGender":"male","birthDateMillis":"917384400000","birthTime":"22:45:00","birthCity":"Красногорск","birthCountry":"Россия","birthLocation":"0101000020E610000046DC52BDEBA84240C2E9132F05E94B40","currentLocation":"0101000020E610000046DC52BDEBA84240C2E9132F05E94B40","city":"Красногорск","country":"Россия","role":"user","onesignalPlayerId":null,"referralCode":"LQ-A7RUQY","hasUsedReferral":false,"hasUsedTrial":true,"trialEndsAt":"2039-12-31T16:35:49.619Z","premiumEndsAt":null,"isBanned":false,"photoCount":1,"createdAt":null,"lastOnline":"2025-08-24T16:23:45.893Z","natalChart":{"zoneId":{"id":"Europe/Moscow"},"sunSign":"Aquarius","latitude":55.8204707,"marsSign":"Scorpio","moonSign":"Gemini","longitude":37.3196942,"venusSign":"Aquarius","saturnSign":"Aries","mercurySign":"Aquarius","ascendantSign":"Libra","birthDateTime":{"hour":22,"year":1999,"minute":45,"dayOfMonth":27,"monthValue":1}},"numerologyData":{"destiny":3,"birthday":9,"lifePath":11,"soulUrge":6,"personality":6},"searchKeywords":["анастасия"],"bioHashtags":[],"bioKeywords":["немножечко","всего"],"sunSign":"Aquarius","moonSign":"Gemini","partnerOfTheDay":{"dateShown":"2025-09-15","partnerId":"BwQAKwzqUxZ9MmihwQk4lTbfEfS2","compatibilityScore":76},"focusOfTheDay":null,"cardOfTheDay":{"date":"2025-10-15","cardId":6,"isReversed":false}},{"id":"H6p5ouDu8pVN5MpuEzEtc22R68g2","name":"Rafik","surname":"","bio":"Star","avatarUrl":null,"gender":"male","seekingGender":"female","birthDateMillis":"948776940000","birthTime":"08:09:00","birthCity":"Сан, Польша","birthCountry":"Польша","birthLocation":"0101000020E610000059F15712EA7B3640691D554D10E44840","currentLocation":"0101000020E610000059F15712EA7B3640691D554D10E44840","city":"Сан, Польша","country":"Польша","role":"user","onesignalPlayerId":null,"referralCode":"LQ-H6P5OU","hasUsedReferral":false,"hasUsedTrial":true,"trialEndsAt":"2025-10-13T13:27:54.988Z","premiumEndsAt":null,"isBanned":false,"photoCount":0,"createdAt":"2025-10-03T13:27:55.057Z","lastOnline":"2025-10-13T15:28:01.058Z","natalChart":{"sunSign":"Aquarius","marsSign":"Pisces","moonSign":"Virgo","plutoSign":"Sagittarius","venusSign":"Capricorn","houseCusps":{"1":0,"2":282.8879133412229,"3":333.81917649918904,"4":18.052957175401225,"5":46.29985913351027,"6":66.49211744011768,"7":83.96082360640236,"8":102.88791334122288,"9":153.8191764991891,"10":198.05295717540122,"11":226.29985913351027,"12":246.49211744011765,"13":263.96082360640236},"saturnSign":"Taurus","uranusSign":"Aquarius","jupiterSign":"Aries","mercurySign":"Aquarius","neptuneSign":"Aquarius","ascendantSign":"Aries","planetPositions":{"ASC":0,"SUN":304.52504420643845,"MARS":346.3211742479832,"MOON":177.77548983795074,"PLUTO":252.19822407468922,"VENUS":270.47503609732604,"SATURN":40.447234303686066,"URANUS":316.09900339869,"JUPITER":27.11583601599595,"MERCURY":310.7220486589941,"NEPTUNE":304.07503158313637}},"numerologyData":{"destiny":9,"birthday":7,"lifePath":1,"soulUrge":1,"personalDay":3,"personality":8,"personalYear":8,"personalMonth":9},"searchKeywords":["rafik","star"],"bioHashtags":[],"bioKeywords":["star"],"sunSign":"Aquarius","moonSign":"Virgo","partnerOfTheDay":null,"focusOfTheDay":{"date":"2025-10-13","text":"Сегодня вы — главный герой на сцене жизни. Вселенная направляет на вас свой софит, подсвечивая вашу уникальность и энергию. Мир замечает не то, что вы делаете, а то, кем вы являетесь в этот самый момент.","title":"Сцена Вашей Личности","advice":"Сегодня мир видит вас особенно ясно. Это день для осознания того, какое впечатление вы производите и какой след оставляете. Ваша уникальность — ваша главная сила."},"cardOfTheDay":{"date":"2025-10-15","cardId":6,"isReversed":false}}]
  ''';

  try {
    final List<dynamic> jsonList = json.decode(rawJsonString);
    logger.d("JSON успешно распарсен. Найдено ${jsonList.length} объектов.");

    // Пробуем распарсить каждого пользователя по очереди
    for (var i = 0; i < jsonList.length; i++) {
      final userJson = jsonList[i] as Map<String, dynamic>;
      logger.d("\n--- ПАРСИНГ ПОЛЬЗОВАТЕЛЯ #${i + 1} (ID: ${userJson['id']}) ---");
      try {
        UserProfileCard.fromJson(userJson);
        logger.d("✅ УСПЕХ: Пользователь #${i + 1} успешно распарсен.");
      } catch (e, s) {
        logger.d("❌ ОШИБКА: Не удалось распарсить пользователя #${i + 1}.");
        logger.d("   -> Ошибка: $e");
        logger.d("   -> Stack Trace: $s");
        break; // Останавливаемся на первой ошибке
      }
    }
  } catch (e) {
    logger.d("Критическая ошибка парсинга самого JSON: $e");
  }
}