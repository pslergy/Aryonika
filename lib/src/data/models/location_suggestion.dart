// lib/src/data/models/location_suggestion.dart



class LocationSuggestion {
  final String displayName;
  final double latitude;
  final double longitude;

  LocationSuggestion({
    required this.displayName,
    required this.latitude,
    required this.longitude,
  });

  factory LocationSuggestion.fromNominatim(Map<String, dynamic> json) {
    final lat = double.tryParse(json['lat'] ?? '0.0') ?? 0.0;
    final lon = double.tryParse(json['lon'] ?? '0.0') ?? 0.0;

    return LocationSuggestion(
      displayName: json['display_name'] ?? 'Неизвестное место',
      latitude: lat,
      longitude: lon,
    );
  }

  // === ИСПРАВЛЕННЫЙ МЕТОД toJson ===
  // Он возвращает Map в формате, который понимает NominatimSuggestion.fromJson()
  Map<String, dynamic> toJson() {
    return {
      // NominatimSuggestion ожидает 'place_id', 'address', но они нам не критичны.
      // Мы можем передать заглушки.
      'place_id': 0,
      'address': null,

      // А вот эти поля - самые важные.
      // NominatimSuggestion ожидает их как строки. Конвертируем обратно.
      'lat': latitude.toString(),
      'lon': longitude.toString(),
      'display_name': displayName,
    };
  }
}
