// lib/widgets/common/clickable_text.dart
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ClickableParsedText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign textAlign;

  // Функция обратного вызова для нажатия на хэштег
  final Function(String) onHashtagPressed;

  const ClickableParsedText({
    super.key,
    required this.text,
    this.style,
    this.textAlign = TextAlign.start,
    required this.onHashtagPressed,
  });

  @override
  Widget build(BuildContext context) {
    // Используем RichText, который дает полный контроль над стилем и жестами
    return RichText(
      textAlign: textAlign,
      text: TextSpan(
        style: style ?? DefaultTextStyle.of(context).style, // Стиль по умолчанию
        children: _buildTextSpans(context),
      ),
    );
  }

  List<TextSpan> _buildTextSpans(BuildContext context) {
    final List<TextSpan> spans = [];
    // Регулярное выражение, которое находит хэштеги и обычный текст
    final regex = RegExp(r'(#\w+|\S+)');

    text.splitMapJoin(
      regex,
      onMatch: (Match match) {
        final String word = match.group(0)!;
        if (word.startsWith('#')) {
          // Если это хэштег
          spans.add(
            TextSpan(
              text: word,
              style: const TextStyle(
                color: Colors.cyanAccent,
                fontWeight: FontWeight.bold,
              ),
              // === САМОЕ ГЛАВНОЕ: ЯВНЫЙ ОБРАБОТЧИК ЖЕСТОВ ===
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  onHashtagPressed(word.substring(1)); // Передаем тег без '#'
                },
            ),
          );
        } else {
          // Если это обычное слово
          spans.add(TextSpan(text: word));
        }
        spans.add(const TextSpan(text: ' ')); // Добавляем пробел после каждого слова
        return '';
      },
      onNonMatch: (String nonMatch) {
        // Для текста, который не попал под регулярку (например, знаки препинания)
        spans.add(TextSpan(text: nonMatch));
        return '';
      },
    );

    // Убираем лишний пробел в конце, если он есть
    if (spans.isNotEmpty) {
      return spans.sublist(0, spans.length - 1);
    }
    return spans;
  }
}