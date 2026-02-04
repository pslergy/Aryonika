// lib/src/data/models/comment.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

// Твоя умная функция для парсинга времени - она идеальна. Оставляем ее.
Timestamp _timestampFromJson(dynamic json) {
  if (json is Timestamp) {
    return json;
  }
  if (json is String) {
    // Используем tryParse, чтобы не падать, если строка некорректная
    final date = DateTime.tryParse(json);
    return date != null ? Timestamp.fromDate(date) : Timestamp.now();
  }
  if (json is Map<String, dynamic> && json.containsKey('_seconds')) {
    return Timestamp(json['_seconds'], json['_nanoseconds'] ?? 0);
  }
  return Timestamp.now();
}

class Comment extends Equatable {
  final String id;
  final String postId; // <-- 1. ДОБАВЛЕНО ПОЛЕ, КОТОРОГО НЕ ХВАТАЛО
  final String authorId;
  final String authorName;
  final String? authorAvatarUrl;
  final String text;
  final Timestamp createdAt;
  final String? replyToCommentId;
  final String? replyToAuthorName;
  final String? replyToText;
  final Map<String, List<String>> reactions;
  final bool isEdited; // <-- Добавил поле isEdited, которое присылает сервер

  const Comment({
    required this.id,
    required this.postId, // <-- 2. ДОБАВЛЕНО В КОНСТРУКТОР
    required this.authorId,
    required this.authorName,
    this.authorAvatarUrl,
    required this.text,
    required this.createdAt,
    this.replyToCommentId,
    this.replyToAuthorName,
    this.replyToText,
    this.reactions = const {},
    this.isEdited = false, // <-- Добавил в конструктор
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    // Твой безопасный парсер реакций - он отличный, оставляем.
    final rawReactions = json['reactions'] as Map<String, dynamic>? ?? {};
    final reactions = rawReactions.map(
          (key, value) => MapEntry(
        key,
        (value as List<dynamic>).map((e) => e.toString()).toList(),
      ),
    );

    return Comment(
      id: json['id'] as String? ?? '',
      postId: json['postId'] as String? ?? '', // <-- 3. ПАРСИМ postId ИЗ JSON
      authorId: json['authorId'] as String? ?? '',
      authorName: json['authorName'] as String? ?? 'Аноним',
      authorAvatarUrl: json['authorAvatarUrl'] as String?,
      text: json['text'] as String? ?? '',
      createdAt: _timestampFromJson(json['createdAt']),
      replyToCommentId: json['replyToCommentId'] as String?,
      replyToAuthorName: json['replyToAuthorName'] as String?,
      replyToText: json['replyToText'] as String?,
      reactions: reactions,
      isEdited: json['isEdited'] as bool? ?? false, // <-- Парсим isEdited
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'postId': postId, // <-- 4. ДОБАВЛЯЕМ В toJson
      'authorId': authorId,
      'authorName': authorName,
      'authorAvatarUrl': authorAvatarUrl,
      'text': text,
      'createdAt': createdAt.toDate().toIso8601String(),
      'replyToCommentId': replyToCommentId,
      'replyToAuthorName': replyToAuthorName,
      'replyToText': replyToText,
      'reactions': reactions,
      'isEdited': isEdited,
    };
  }

  Comment copyWith({
    String? id,
    String? postId, // <-- 5. ДОБАВЛЯЕМ В copyWith
    String? authorId,
    String? authorName,
    String? authorAvatarUrl,
    String? text,
    Timestamp? createdAt,
    String? replyToCommentId,
    String? replyToAuthorName,
    String? replyToText,
    Map<String, List<String>>? reactions,
    bool? isEdited,
  }) {
    return Comment(
      id: id ?? this.id,
      postId: postId ?? this.postId, // <-- 5. ДОБАВЛЯЕМ В copyWith
      authorId: authorId ?? this.authorId,
      authorName: authorName ?? this.authorName,
      authorAvatarUrl: authorAvatarUrl ?? this.authorAvatarUrl,
      text: text ?? this.text,
      createdAt: createdAt ?? this.createdAt,
      replyToCommentId: replyToCommentId ?? this.replyToCommentId,
      replyToAuthorName: replyToAuthorName ?? this.replyToAuthorName,
      replyToText: replyToText ?? this.replyToText,
      reactions: reactions ?? this.reactions,
      isEdited: isEdited ?? this.isEdited,
    );
  }

  @override
  List<Object?> get props => [
    id,
    postId, // <-- 6. ДОБАВЛЯЕМ В props ДЛЯ СРАВНЕНИЯ
    authorId,
    authorName,
    authorAvatarUrl,
    text,
    createdAt,
    replyToCommentId,
    replyToAuthorName,
    replyToText,
    reactions,
    isEdited,
  ];
}