// lib/cubits/admin_state.dart

import 'package:equatable/equatable.dart';


import '../repositories/package/lovequest/src/data/models/enums.dart';
import '../src/data/models/report.dart'; // Импортируем LoadingState

class AdminDashboardStats extends Equatable {
  final int totalUsers;
  final int newUsersToday;
  final int onlineNow;
  final int pendingReports;
  final int totalReferrals;

  const AdminDashboardStats({
    this.totalUsers = 0,
    this.newUsersToday = 0,
    this.onlineNow = 0,
    this.pendingReports = 0,
    this.totalReferrals = 0,
  });

  factory AdminDashboardStats.fromJson(Map<String, dynamic> json) {
    return AdminDashboardStats(
      totalUsers: json['totalUsers'] ?? 0,
      newUsersToday: json['newUsersToday'] ?? 0,
      onlineNow: json['onlineNow'] ?? 0,
      pendingReports: json['pendingReports'] ?? 0,
      totalReferrals: json['totalReferrals'] ?? 0,
    );
  }

  @override
  List<Object?> get props => [totalUsers, newUsersToday, onlineNow, pendingReports, totalReferrals];
}

class AdminState extends Equatable {
  final AdminDashboardStats stats;
  final List<Report> reports;
  final LoadingState status;
  final String? errorMessage;

  const AdminState({
    this.stats = const AdminDashboardStats(),
    this.reports = const [],
    this.status = LoadingState.initial,
    this.errorMessage,
  });

  AdminState copyWith({
    AdminDashboardStats? stats,
    List<Report>? reports,
    LoadingState? status,
    String? errorMessage,
  }) {
    return AdminState(
      stats: stats ?? this.stats,
      reports: reports ?? this.reports,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [stats, reports, status, errorMessage];
}