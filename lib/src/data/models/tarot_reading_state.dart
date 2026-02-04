// lib/src/data/models/tarot_reading_state.dart
import 'package:lovequest/src/data/models/tarot_card.dart';

class TarotReadingState {
  final List<TarotCard> reading; // 3 вытянутые карты
  final Set<int> flippedCardIds;  // ID перевернутых карт
  final String? summary;          // Финальное толкование
  final bool hasReceivedDailyReading;

  const TarotReadingState({
    this.reading = const [],
    this.flippedCardIds = const {},
    this.summary,
    this.hasReceivedDailyReading = false,
  });

  TarotReadingState copyWith({
    List<TarotCard>? reading,
    Set<int>? flippedCardIds,
    String? summary,
    bool? hasReceivedDailyReading,
  }) {
    return TarotReadingState(
      reading: reading ?? this.reading,
      flippedCardIds: flippedCardIds ?? this.flippedCardIds,
      summary: summary ?? this.summary,
      hasReceivedDailyReading: hasReceivedDailyReading ?? this.hasReceivedDailyReading,
    );
  }
}