// lib/repositories/onboarding_repository.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lovequest/services/logger_service.dart';

import '../src/data/models/nominatim_suggestion.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class OnboardingRepository {
  final _httpClient = http.Client();
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final _jsonParser = JsonDecoder();

  // Поиск локаций через Nominatim API
  Future<List<NominatimSuggestion>> searchLocations(String query) async {
    if (query.length < 3) return [];
    try {
      final encodedQuery = Uri.encodeComponent(query);
      final url = Uri.parse(
          "https://nominatim.openstreetmap.org/search?q=$encodedQuery&format=jsonv2&addressdetails=1&accept-language=ru");

      final response = await _httpClient.get(url, headers: {
        'User-Agent': 'LoveQuest Flutter App v1.0',
      });

      if (response.statusCode == 200) {
        final List<dynamic> results = _jsonParser.convert(response.body);
        return results.map((json) => NominatimSuggestion.fromJson(json)).toList();
      } else {
        throw Exception('Ошибка поиска локаций');
      }
    } catch (e) {
      logger.d("Ошибка в OnboardingRepository.searchLocations: $e");
      rethrow;
    }
  }

  // Сохранение нового профиля в Firestore
  // Сохранение НОВОГО профиля в Firestore
  Future<void> saveNewUserProfile(Map<String, dynamic> userProfileMap) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) {
      throw Exception("Пользователь не авторизован для сохранения профиля.");
    }
    try {
      // ==========================================================
      // ===          ГЛАВНОЕ ИСПРАВЛЕНИЕ ЗДЕСЬ                 ===
      // Меняем .update() на .set()
      // .set() создаст документ, если его нет. Это именно то, что нам нужно.
      await _db.collection('users').doc(userId).set(userProfileMap);
      // ==========================================================

    } catch (e) {
      logger.d("Ошибка в OnboardingRepository.saveNewUserProfile: $e");
      rethrow;
    }
  }
}