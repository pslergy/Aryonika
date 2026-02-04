// lib/l10n/intro_texts.dart




// Модель IntroSlide теперь намного проще: она хранит уже готовые, переведенные строки.

import '../generated/app_localizations.dart';

class IntroSlide {
  final String title;
  final String description;

  const IntroSlide({
    required this.title,
    required this.description,
  });
}

// Создаем функцию, которая будет генерировать список слайдов на основе текущего языка.
// Она принимает объект AppLocalizations (l10n), в котором лежат все наши переводы.
List<IntroSlide> getIntroSlides(AppLocalizations l10n) {
  return [
    IntroSlide(
      title: l10n.introSlide1Title,
      description: l10n.introSlide1Description,
    ),
    IntroSlide(
      title: l10n.introSlide2Title,
      description: l10n.introSlide2Description,
    ),
    IntroSlide(
      title: l10n.introSlide3Title,
      description: l10n.introSlide3Description,
    ),
  ];
}

// Старый жестко закодированный список и Map с текстами кнопок больше не нужны,
// так как все тексты теперь находятся в AppLocalizations (l10n).