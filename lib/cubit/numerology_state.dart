// lib/cubit/numerology_state.dart
import 'package:equatable/equatable.dart';
import '../src/data/models/numerology_report.dart';

enum NumerologyStatus { initial, loading, success, error }

class NumerologyState extends Equatable {
  final NumerologyStatus status;
  final String? errorMessage;

  final PersonalNumerologyReport? personalReport; // Личная нумерология
  final NumerologyReport? compatibilityReport;   // Совместимость
  final bool isProUser;

  const NumerologyState({
    this.status = NumerologyStatus.initial,
    this.errorMessage,
    this.personalReport,
    this.compatibilityReport,
    this.isProUser = false,
  });

  NumerologyState copyWith({
    NumerologyStatus? status,
    String? errorMessage,
    PersonalNumerologyReport? personalReport,
    NumerologyReport? compatibilityReport,
    bool? isProUser,
  }) {
    return NumerologyState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      personalReport: personalReport ?? this.personalReport,
      compatibilityReport: compatibilityReport ?? this.compatibilityReport,
      isProUser: isProUser ?? this.isProUser,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, personalReport, compatibilityReport, isProUser];
}
