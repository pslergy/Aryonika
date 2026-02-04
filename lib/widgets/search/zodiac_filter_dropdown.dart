// lib/widgets/search/zodiac_filter_dropdown.dart
import 'package:flutter/material.dart';
import 'package:lovequest/src/data/models/enums.dart';

class ZodiacFilterDropDown extends StatelessWidget {
  final ZodiacFilter selectedFilter;
  final ValueChanged<ZodiacFilter> onFilterSelected;

  const ZodiacFilterDropDown({
    super.key,
    required this.selectedFilter,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    // Используем DropdownButton для большего контроля над стилем
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.white24),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<ZodiacFilter>(
          value: selectedFilter,
          isExpanded: true, // Заставляет его занимать всю доступную ширину
          icon: const Icon(Icons.arrow_drop_down, color: Colors.white70),
          dropdownColor: const Color(0xFF1A1A3D), // Цвет фона выпадающего списка
          style: const TextStyle(color: Colors.white, fontSize: 16),
          onChanged: (ZodiacFilter? newValue) {
            if (newValue != null) {
              onFilterSelected(newValue);
            }
          },
          items: ZodiacFilter.values.map((ZodiacFilter filter) {
            return DropdownMenuItem<ZodiacFilter>(
              value: filter,
              // Убираем длинный текст из отображения, оставляем только название
              child: Text(filter.displayName.split(' ').first),
            );
          }).toList(),
        ),
      ),
    );
  }
}