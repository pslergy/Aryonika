// lib/src/data/models/astrology/transiting_aspect.dart
import 'package:equatable/equatable.dart';

import '../../../utils/astro_utils.dart';
import 'astrology/natal_chart.dart';

import 'astrology/natal_chart.dart';
     // Для AspectType

class TransitingAspect extends Equatable {
  final Planet transitingPlanet; // Транзитная планета
  final Planet natalPlanet;      // Натальная планета
  final AspectType aspectType;
  final double orb;

  const TransitingAspect({
    required this.transitingPlanet,
    required this.natalPlanet,
    required this.aspectType,
    required this.orb,
  });

  @override
  List<Object?> get props => [transitingPlanet, natalPlanet, aspectType, orb];
}