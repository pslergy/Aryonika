// lib/widgets/oracle/moon_rhythm_widget.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovequest/cubit/app_cubit.dart';
import 'package:lovequest/cubit/app_state.dart';
import 'package:lovequest/src/data/models/enums.dart';

class MoonRhythmWidget extends StatelessWidget {
  const MoonRhythmWidget({super.key});

  // Хелперы для иконок
  IconData _getIconForSign(String signKey) {
    // Здесь можно использовать кастомные иконки знаков зодиака, пока используем стандартные
    switch (signKey) {
      case 'Aries': return Icons.local_fire_department_outlined;
      case 'Taurus': return Icons.pets_outlined;
      case 'Gemini': return Icons.people_alt_outlined;
      case 'Cancer': return Icons.night_shelter_outlined;
      case 'Leo': return Icons.star_outline;
      case 'Virgo': return Icons.eco_outlined;
      case 'Libra': return Icons.balance_outlined;
      case 'Scorpio': return Icons.bug_report_outlined;
      case 'Sagittarius': return Icons.arrow_forward_outlined;
      case 'Capricorn': return Icons.landscape_outlined;
      case 'Aquarius': return Icons.waves_outlined;
      case 'Pisces': return Icons.water_drop_outlined;
      default: return Icons.brightness_3_outlined;
    }
  }

  IconData _getIconForPhase(String phaseKey) {
    switch (phaseKey) {
      case 'NEW_MOON': return Icons.brightness_2_outlined;
      case 'WAXING_MOON': return Icons.arrow_circle_up_outlined;
      case 'FULL_MOON': return Icons.brightness_7_outlined;
      case 'WANING_MOON': return Icons.arrow_circle_down_outlined;
      default: return Icons.brightness_3;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      buildWhen: (p, c) => p.moonRhythmStatus != c.moonRhythmStatus,
      builder: (context, state) {
        if (state.moonRhythmStatus != LoadingState.success || state.moonRhythm == null) {
          // Пока данные грузятся или есть ошибка, ничего не показываем
          return const SizedBox.shrink();
        }

        final rhythm = state.moonRhythm!;
        final phaseColor = Colors.cyanAccent;
        final signColor = Colors.amberAccent;

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: Colors.white.withOpacity(0.1),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _RhythmItem(
                  icon: _getIconForPhase(rhythm.phase.key),
                  title: rhythm.phase.title,
                  description: rhythm.phase.description,
                  color: phaseColor,
                ),
                Container(width: 1, height: 60, color: Colors.white24),
                _RhythmItem(
                  icon: _getIconForSign(rhythm.sign.key),
                  title: rhythm.sign.title,
                  description: rhythm.sign.description,
                  color: signColor,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _RhythmItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  const _RhythmItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text(title),
              content: Text(description),
              actions: [TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text("OK"))],
            ),
          );
        },
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(color: color, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}