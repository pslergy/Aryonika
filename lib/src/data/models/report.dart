// lib/models/report.dart

import 'package:equatable/equatable.dart';

class Report extends Equatable {
  final String id;
  final String reporterId;
  final String reportedUserId;
  final String reason;
  final String details;
  final String status;
  final DateTime createdAt;

  const Report({
    required this.id,
    required this.reporterId,
    required this.reportedUserId,
    required this.reason,
    required this.details,
    required this.status,
    required this.createdAt,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json['id'],
      reporterId: json['reporterId'],
      reportedUserId: json['reportedUserId'],
      reason: json['reason'],
      details: json['details'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  @override
  List<Object?> get props => [id, reporterId, reportedUserId, reason, details, status, createdAt];
}