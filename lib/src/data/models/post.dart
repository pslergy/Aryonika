// lib/src/data/models/post.dart
import 'package:equatable/equatable.dart';

// Убираем импорт cloud_firestore

class Post extends Equatable {
  final String id;
  final String authorId;
  final String authorName;
  final String? authorAvatarUrl;
  final String text;
  final String? imageUrl;
  final double? imageWidth;
  final double? imageHeight;
  final DateTime createdAt;
  final Map<String, List<String>> reactions;
  final int commentCount;
  final int viewCount;
  final String? status; // 'pending', 'approved', 'rejected'
  final int channelId;
  final bool isEdited;

  const Post({
    required this.id,
    required this.authorId,
    required this.authorName,
    this.authorAvatarUrl,
    required this.text,
    this.imageUrl,
    this.imageWidth,
    this.imageHeight,
    required this.createdAt,
    this.reactions = const {},
    this.commentCount = 0,
    this.viewCount = 0,
    this.status,
    required this.channelId,
    this.isEdited = false
  });

  // Фабричный конструктор для парсинга JSON с сервера
  factory Post.fromJson(Map<String, dynamic> json) {
    // Безопасно парсим реакции
    final reactionsData = json['reactions'] as Map<String, dynamic>? ?? {};
    final reactions = reactionsData.map<String, List<String>>((key, value) {
      return MapEntry(key, List<String>.from(value as List));
    });

    return Post(
      id: json['id'].toString(),
      authorId: json['authorId'] ?? '',
      authorName: json['authorName'] ?? '',
      authorAvatarUrl: json['authorAvatarUrl'],
      text: json['text'] ?? '',
      imageUrl: json['imageUrl'],
      imageWidth: (json['imageWidth'] as num?)?.toDouble(),
      imageHeight: (json['imageHeight'] as num?)?.toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      reactions: reactions,
      commentCount: json['commentCount'] ?? 0,
      viewCount: json['viewCount'] ?? 0,
      status: json['status'],
      channelId: json['channelId'],
      isEdited: json['isEdited'] as bool? ?? false,
    );
  }

  Post copyWith({
    String? id,
    String? authorId,
    String? authorName,
    String? authorAvatarUrl,
    String? text,
    String? imageUrl,
    double? imageWidth,
    double? imageHeight,
    DateTime? createdAt,
    Map<String, List<String>>? reactions,
    int? commentCount,
    int? viewCount,
    String? status,
    bool? isEdited,

  }) {
    return Post(
      id: id ?? this.id,
      authorId: authorId ?? this.authorId,
      authorName: authorName ?? this.authorName,
      authorAvatarUrl: authorAvatarUrl ?? this.authorAvatarUrl,
      text: text ?? this.text,
      imageUrl: imageUrl ?? this.imageUrl,
      imageWidth: imageWidth ?? this.imageWidth,
      imageHeight: imageHeight ?? this.imageHeight,
      createdAt: createdAt ?? this.createdAt,
      reactions: reactions ?? this.reactions,
      commentCount: commentCount ?? this.commentCount,
      viewCount: viewCount ?? this.viewCount,
      status: status ?? this.status,
      channelId: channelId ?? this.channelId,
      isEdited: isEdited ?? this.isEdited,
    );
  }

  @override
  List<Object?> get props => [
    id, authorId, authorName, authorAvatarUrl, text, imageUrl,
    imageWidth, imageHeight, createdAt, reactions, commentCount, viewCount, status
  ];
}