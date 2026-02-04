// lib/src/data/models/search_results.dart

import 'package:lovequest/src/data/models/user_profile_card.dart';

class SearchResults {
  final List<UserProfileCard> priorityResults;
  final List<UserProfileCard> otherResults;

  SearchResults({
    required this.priorityResults,
    required this.otherResults,
  });

  factory SearchResults.fromJson(Map<String, dynamic> json) {
    final priority = (json['priorityResults'] as List? ?? [])
        .map((item) => UserProfileCard.fromJson(item))
        .toList();

    final other = (json['otherResults'] as List? ?? [])
        .map((item) => UserProfileCard.fromJson(item))
        .toList();

    return SearchResults(
      priorityResults: priority,
      otherResults: other,
    );
  }
}