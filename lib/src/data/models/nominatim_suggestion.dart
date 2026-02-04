// lib/src/data/models/nominatim_suggestion.dart

// Класс для вложенного объекта "address"
class NominatimAddress {
  final String? city;
  final String? town;
  final String? village;
  final String? country;

  const NominatimAddress({
    this.city,
    this.town,
    this.village,
    this.country,
  });

  factory NominatimAddress.fromJson(Map<String, dynamic> json) {
    return NominatimAddress(
      city: json['city'] as String?,
      town: json['town'] as String?,
      village: json['village'] as String?,
      country: json['country'] as String?,
    );
  }

  // === ДОБАВЛЕН НЕДОСТАЮЩИЙ МЕТОД ===
  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'town': town,
      'village': village,
      'country': country,
    };
  }
}

// Основной класс для результата поиска
class NominatimSuggestion {
  final int placeId;
  final String latitude;
  final String longitude;
  final String displayName;
  final NominatimAddress? address;

  const NominatimSuggestion({
    required this.placeId,
    required this.latitude,
    required this.longitude,
    required this.displayName,
    this.address,
  });

  // Фабричный конструктор для создания из JSON (Map)
  factory NominatimSuggestion.fromJson(Map<String, dynamic> json) {
    return NominatimSuggestion(
      placeId: json['place_id'] as int? ?? 0,
      latitude: json['lat'] as String? ?? '0.0',
      longitude: json['lon'] as String? ?? '0.0',
      displayName: json['display_name'] as String? ?? 'Неизвестное место',
      address: json['address'] != null
          ? NominatimAddress.fromJson(json['address'] as Map<String, dynamic>)
          : null,
    );
  }

  // === МЕТОД toJson() ПЕРЕМЕЩЕН В ПРАВИЛЬНОЕ МЕСТО ===
  Map<String, dynamic> toJson() {
    return {
      'place_id': placeId,
      'lat': latitude,
      'lon': longitude,
      'display_name': displayName,
      'address': address?.toJson(),
    };
  }
}