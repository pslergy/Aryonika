import 'package:flutter/material.dart';
import 'package:lovequest/l10n/generated/app_localizations.dart';

class L10nMapper {

  // --- НУМЕРОЛОГИЯ ---
  static String getNumerologyText(BuildContext context, String key) {
    final l10n = AppLocalizations.of(context)!;

    switch (key) {
      case 'numerology_day_1': return l10n.numerology_day_1;
      case 'numerology_day_2': return l10n.numerology_day_2;
      case 'numerology_day_3': return l10n.numerology_day_3;
      case 'numerology_day_4': return l10n.numerology_day_4;
      case 'numerology_day_5': return l10n.numerology_day_5;
      case 'numerology_day_6': return l10n.numerology_day_6;
      case 'numerology_day_7': return l10n.numerology_day_7;
      case 'numerology_day_8': return l10n.numerology_day_8;
      case 'numerology_day_9': return l10n.numerology_day_9;
      default: return key; // Возвращаем ключ, если перевод не найден
    }
  }

  // --- АСТРОЛОГИЯ ---
  static String getAstrologyText(BuildContext context, String key) {
    final l10n = AppLocalizations.of(context)!;

    switch (key) {
      case 'astro_advice_listen_intuition': return l10n.astro_advice_listen_intuition;
      case 'astro_advice_act_boldly': return l10n.astro_advice_act_boldly;
      case 'astro_advice_rest_and_reflect': return l10n.astro_advice_rest_and_reflect;
      case 'astro_advice_connect_with_nature': return l10n.astro_advice_connect_with_nature;
      default: return key;
    }
  }

  // --- ИТОГОВЫЙ СОВЕТ ---
  static String getFinalAdviceText(BuildContext context, String key) {
    final l10n = AppLocalizations.of(context)!;

    switch (key) {
      case 'advice_generic_positive': return l10n.advice_generic_positive;
      default: return key;
    }
  }
}