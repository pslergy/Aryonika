// lib/widgets/search/filter_panel.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovequest/cubit/app_cubit.dart';
import 'package:lovequest/cubit/app_state.dart';
import 'package:lovequest/l10n/generated/app_localizations.dart'; // Импорт
import 'package:lovequest/src/data/models/enums.dart';
import 'package:lovequest/widgets/common/glassmorphic_card.dart';
import 'package:lovequest/widgets/common/neon_glow_button.dart';
import 'package:lovequest/widgets/search/gender_toggle_button.dart';
import 'package:lovequest/widgets/search/zodiac_filter_dropdown.dart';

import '../../services/logger_service.dart'; // Исправлен путь

class FilterPanel extends StatefulWidget {
  const FilterPanel({super.key});
  @override
  State<FilterPanel> createState() => _FilterPanelState();
}

class _FilterPanelState extends State<FilterPanel> {
  late RangeValues _currentRangeValues;
  late String _tempGender;
  late ZodiacFilter _tempZodiacFilter;
  late SearchMode _tempSearchMode;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final initialState = context.watch<AppCubit>().state;
    _currentRangeValues = RangeValues(initialState.minAgeFilter.toDouble(), initialState.maxAgeFilter.toDouble());
    _tempGender = initialState.genderFilter;
    _tempZodiacFilter = initialState.zodiacFilter;
    _tempSearchMode = initialState.searchMode;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocSelector<AppCubit, AppState, SearchMode>(
      selector: (state) => state.searchMode,
      builder: (context, searchMode) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
          child: GlassmorphicCard(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Где искать ---
                  _buildSectionTitle(l10n.whereToSearch),
                  Wrap(
                    spacing: 8.0,
                    children: [
                      _GeoFilterChip(
                        label: l10n.searchNearby, // "Рядом"
                        mode: SearchMode.nearby,
                        currentMode: _tempSearchMode,
                        onSelect: (mode) => setState(() => _tempSearchMode = mode),
                      ),
                      _GeoFilterChip(
                        label: l10n.searchCity, // "Город"
                        mode: SearchMode.city,
                        currentMode: _tempSearchMode,
                        onSelect: (mode) => setState(() => _tempSearchMode = mode),
                      ),
                      _GeoFilterChip(
                        label: l10n.searchCountry, // "Страна"
                        mode: SearchMode.country,
                        currentMode: _tempSearchMode,
                        onSelect: (mode) => setState(() => _tempSearchMode = mode),
                      ),
                      _GeoFilterChip(
                        label: l10n.searchWorld, // "Весь мир"
                        mode: SearchMode.all,
                        currentMode: _tempSearchMode,
                        onSelect: (mode) => setState(() => _tempSearchMode = mode),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // --- Возраст ---
                  _buildSectionTitle('${l10n.ageLabel}: ${_currentRangeValues.start.round()} - ${_currentRangeValues.end.round()}'),
                  RangeSlider(
                    values: _currentRangeValues,
                    min: 18, max: 99, divisions: 81,
                    onChanged: (values) => setState(() => _currentRangeValues = values),
                    activeColor: Colors.pinkAccent, inactiveColor: Colors.white24,
                  ),

                  // --- Пол ---
                  _buildSectionTitle(l10n.showGenderLabel), // "Показывать"
                  Row(
                    children: [
                      GenderToggleButton(text: l10n.genderMale, icon: Icons.male, isSelected: _tempGender == 'male', onClick: () => setState(() => _tempGender = 'male')),
                      const SizedBox(width: 8),
                      GenderToggleButton(text: l10n.genderFemale, icon: Icons.female, isSelected: _tempGender == 'female', onClick: () => setState(() => _tempGender = 'female')),
                      const SizedBox(width: 8),
                      GenderToggleButton(text: l10n.genderAll, icon: Icons.transgender, isSelected: _tempGender == 'all', onClick: () => setState(() => _tempGender = 'all')),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // --- Стихии ---
                  _buildSectionTitle(l10n.zodiacFilterLabel), // "Фильтр по стихиям"
                  ZodiacFilterDropDown(
                    selectedFilter: _tempZodiacFilter,
                    onFilterSelected: (f) => setState(() => _tempZodiacFilter = f),
                  ),

                  const SizedBox(height: 24),

                  // --- Кнопки ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          context.read<AppCubit>().resetSearchFilters();
                          setState(() {
                            final s = context.read<AppCubit>().state;
                            _currentRangeValues = RangeValues(s.minAgeFilter.toDouble(), s.maxAgeFilter.toDouble());
                            _tempGender = s.genderFilter;
                            _tempZodiacFilter = s.zodiacFilter;
                          });
                        },
                        child: Text(l10n.resetFilters, style: const TextStyle(color: Colors.white70)), // "Сбросить"
                      ),
                      const SizedBox(width: 8),
                      NeonGlowButton(
                        text: l10n.applyFilters, // "Применить"
                        onPressed: () {
                          logger.d("--- UI: Кнопка 'Применить' нажата! ---");
                          context.read<AppCubit>().applyAllFilters(
                            searchMode: _tempSearchMode,
                            minAge: _currentRangeValues.start.round(),
                            maxAge: _currentRangeValues.end.round(),
                            gender: _tempGender,
                            zodiac: _tempZodiacFilter,
                          );
                        },
                      ),
                    ],
                  ),
                ].animate(interval: 50.ms).fadeIn(duration: 300.ms).slideX(begin: -0.1),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionTitle(String title) => Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
      child: Text(title, style: TextStyle(color: Colors.white.withOpacity(0.8), fontWeight: FontWeight.bold)));
}

class _GeoFilterChip extends StatelessWidget {
  final String label;
  final SearchMode mode;
  final SearchMode currentMode;
  final Function(SearchMode) onSelect;

  const _GeoFilterChip({
    required this.label,
    required this.mode,
    required this.currentMode,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = mode == currentMode;
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) {
          if (selected) {
            onSelect(mode);
          }
        },
        selectedColor: Colors.pinkAccent,
        backgroundColor: Colors.white.withOpacity(0.1),
        labelStyle: TextStyle(color: isSelected ? Colors.black : Colors.white),
      ),
    );
  }
}