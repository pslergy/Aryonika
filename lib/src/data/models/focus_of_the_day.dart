// lib/src/data/models/astrology/focus_of_the_day.dart
import 'dart:convert';

class FocusOfTheDay {
  final String title;
  final String text;
  final String? advice;
  final String date; // Дата в формате "YYYY-MM-DD"

  const FocusOfTheDay({
    required this.title,
    required this.text,
    this.advice,
    required this.date,
  });

  // Методы для сохранения/загрузки из локального хранилища
  Map<String, dynamic> toJson() => {
    'title': title,
    'text': text,
    'advice': advice,
    'date': date,
  };

  factory FocusOfTheDay.fromJson(Map<String, dynamic> json) => FocusOfTheDay(
    title: json['title'] as String,
    text: json['text'] as String,
    advice: json['advice'] as String?,
    date: json['date'] as String,
  );
}