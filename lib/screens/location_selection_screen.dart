// lib/screens/location_selection_screen.dart
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lovequest/l10n/generated/app_localizations.dart'; // <-- Импорт локализации
import 'package:lovequest/src/data/models/nominatim_suggestion.dart';
import 'package:lovequest/widgets/common/animated_cosmic_background.dart';

class LocationSelectionScreen extends StatefulWidget {
  const LocationSelectionScreen({super.key});

  @override
  State<LocationSelectionScreen> createState() => _LocationSelectionScreenState();
}

class _LocationSelectionScreenState extends State<LocationSelectionScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<NominatimSuggestion> _suggestions = [];
  bool _isLoading = false;
  Timer? _debounce;

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _searchLocation(query);
    });
  }

  Future<void> _searchLocation(String query) async {
    if (query.isEmpty || query.length < 3) {
      setState(() => _suggestions = []);
      return;
    }
    setState(() => _isLoading = true);

    try {
      // Получаем текущий язык для запроса
      final lang = Localizations.localeOf(context).languageCode;

      final url = Uri.parse(
          'https://nominatim.openstreetmap.org/search?q=$query&format=json&addressdetails=1&limit=5&accept-language=$lang');

      final response = await http.get(url, headers: {
        'User-Agent': 'AryonikaApp/1.0 (com.Aryonika.app)'
      });

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final results = data.map((json) => NominatimSuggestion.fromJson(json)).toList();

        if (mounted) {
          setState(() {
            _suggestions = results;
            _isLoading = false;
          });
        }
      } else {
        throw Exception('Failed to load locations');
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
      print("Location search error: $e");
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.selectCityTitle), // "Выберите город"
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: AnimatedCosmicBackground(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: _searchController,
                  autofocus: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: l10n.searchCityHint, // "Введите название города..."
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                    prefixIcon: const Icon(Icons.search, color: Colors.white70),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: _onSearchChanged,
                ),
              ),
              if (_isLoading)
                const LinearProgressIndicator(color: Colors.purpleAccent),

              Expanded(
                child: _suggestions.isEmpty && _searchController.text.isNotEmpty && !_isLoading
                    ? Center(child: Text(l10n.nothingFound, style: const TextStyle(color: Colors.white54))) // "Ничего не найдено"
                    : ListView.builder(
                  itemCount: _suggestions.length,
                  itemBuilder: (context, index) {
                    final suggestion = _suggestions[index];
                    return ListTile(
                      leading: const Icon(Icons.location_city, color: Colors.white70),
                      title: Text(
                        suggestion.displayName,
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                          suggestion.address?.country ?? '',
                          style: const TextStyle(color: Colors.white54)
                      ),
                      onTap: () {
                        Navigator.of(context).pop(suggestion);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}