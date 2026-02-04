// lib/path/to/your/sweph.dart

import 'package:flutter/foundation.dart';

// Перечисляем все твои enums и классы данных здесь, чтобы файл был самодостаточным
enum ZodiacSystem { Tropical, Sidereal }
enum Ayanamsa { Lahiri, Raman, Krishnamurti }

class HouseData {
  final List<double> cusps;
  HouseData({required this.cusps});
}

class PlanetData {
  final double longitude;
  PlanetData({required this.longitude});
}

enum CalendarType { SE_GREG_CAL, SE_JUL_CAL }
enum Hsys { P }
enum SwephFlag { SEFLG_SPEED }
enum HeavenlyBody {
  SE_SUN,
  SE_MOON,
  SE_MERCURY,
  SE_VENUS,
  SE_MARS,
  SE_JUPITER,
  SE_SATURN,
  SE_URANUS,
  SE_NEPTUNE,
  SE_PLUTO
}
// Конец перечислений

class Sweph {
  static bool _initialized = false;
  static String _baseUrl = '';
  static ZodiacSystem zodiacSystem = ZodiacSystem.Tropical;
  static Ayanamsa ayanamsa = Ayanamsa.Lahiri;

  static Future<void> init({String ephePath = ''}) async {
    if (_initialized) return;
    _initialized = true;

    // --- 👇 ИСПРАВЛЕНИЕ ЗДЕСЬ 👇 ---
    if (kDebugMode) {
      if (kIsWeb) {
        print("[Sweph] Web mode init. ephePath ignored");
      } else {
        print("[Sweph] Mobile mode init. ephePath=$ephePath");
      }
    }
    // --- 👆 ---
  }

  static void setBaseUrl(String url) {
    _baseUrl = url;
    // --- 👇 ИСПРАВЛЕНИЕ ЗДЕСЬ 👇 ---
    if (kDebugMode) {
      print("[Sweph] Base URL set: $url");
    }
    // --- 👆 ---
  }

  static void setZodiacSystem(ZodiacSystem system, {Ayanamsa a = Ayanamsa.Lahiri}) {
    zodiacSystem = system;
    // --- 👇 ИСПРАВЛЕНИЕ ЗДЕСЬ 👇 ---
    if (kDebugMode) {
      if (system == ZodiacSystem.Sidereal) {
        ayanamsa = a;
        print("[Sweph] Sidereal zodiac selected: $ayanamsa");
      } else {
        print("[Sweph] Tropical zodiac selected");
      }
    }
    // --- 👆 ---
  }

  /// Юлианский день
  static List<double> swe_utc_to_jd(
      int year,
      int month,
      int day,
      int hour,
      int minute,
      double second,
      CalendarType calendarType) {
    int a = ((14 - month) / 12).floor();
    int y = year + 4800 - a;
    int m = month + 12 * a - 3;

    double jd = day +
        ((153 * m + 2) / 5).floor() +
        365 * y +
        (y / 4).floor() -
        (y / 100).floor() +
        (y / 400).floor() -
        32045;

    jd += (hour - 12) / 24.0 + minute / 1440.0 + second / 86400.0;
    return [jd.toDouble()];
  }

  /// Планеты с выбором тропической или сидерической позиции
  static PlanetData swe_calc_ut(double julianDay, HeavenlyBody body, SwephFlag flag) {
    final jd0 = 2451545.0;
    final d = julianDay - jd0;
    double longitude = 0.0;

    switch (body) {
      case HeavenlyBody.SE_SUN:
        longitude = (280.460 + 0.9856474 * d) % 360;
        break;
      case HeavenlyBody.SE_MOON:
        longitude = (218.32 + 13.176396 * d) % 360;
        break;
      case HeavenlyBody.SE_MERCURY:
        longitude = (252.250 + 4.092334 * d) % 360;
        break;
      case HeavenlyBody.SE_VENUS:
        longitude = (181.979 + 1.602130 * d) % 360;
        break;
      case HeavenlyBody.SE_MARS:
        longitude = (355.433 + 0.524020 * d) % 360;
        break;
      case HeavenlyBody.SE_JUPITER:
        longitude = (34.351 + 0.083091 * d) % 360;
        break;
      case HeavenlyBody.SE_SATURN:
        longitude = (50.077 + 0.033459 * d) % 360;
        break;
      case HeavenlyBody.SE_URANUS:
        longitude = (314.055 + 0.011728 * d) % 360;
        break;
      case HeavenlyBody.SE_NEPTUNE:
        longitude = (304.348 + 0.005981 * d) % 360;
        break;
      case HeavenlyBody.SE_PLUTO:
        longitude = (238.929 + 0.003968 * d) % 360;
        break;
    }

    // Применяем сидерическую коррекцию, если выбран ведический зодиак
    if (zodiacSystem == ZodiacSystem.Sidereal) {
      longitude -= _ayanamsaValue(julianDay);
      if (longitude < 0) longitude += 360;
    }

    return PlanetData(longitude: longitude);
  }

  /// Простое деление домов (360° на 12)
  static HouseData swe_houses(double julianDay, double latitude, double longitude, Hsys hsys) {
    List<double> cusps = List.generate(12, (i) => i * 30.0);
    return HouseData(cusps: cusps);
  }

  /// Простейшее приближение аянгамши
  static double _ayanamsaValue(double jd) {
    // Lahiri ayanamsa пример (можно улучшить точностью)
    // Значение в градусах на J2000
    double days = jd - 2451545.0;
    double ayan = 22.460148 + 0.0000395 * days; // приблизительно
    return ayan % 360;
  }
}