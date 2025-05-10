// File: lib/provider/dashboard_provider.dart
import 'package:flutter/foundation.dart';

enum TabSelection {
  yesterday,
  today,
  monthly,
}

class DashboardData {
  final String date;
  final String profitLoss;
  final String? predictedProfitLoss;
  final String earnings;
  final String? predictedEarnings;
  final String variableCost;
  final String? predictedVariableCost;
  final int tripsCompleted;
  final int vehiclesOnRoad;
  final int totalDistance;

  DashboardData({
    required this.date,
    required this.profitLoss,
    this.predictedProfitLoss,
    required this.earnings,
    this.predictedEarnings,
    required this.variableCost,
    this.predictedVariableCost,
    required this.tripsCompleted,
    required this.vehiclesOnRoad,
    required this.totalDistance,
  });

  // Sample data for each tab
  static DashboardData get yesterdayData => DashboardData(
        date: 'Fri, 7 Mar',
        profitLoss: '1,274',
        predictedProfitLoss: '1,523',
        earnings: '1,523',
        predictedEarnings: '1,200',
        variableCost: '249',
        predictedVariableCost: '120',
        tripsCompleted: 0,
        vehiclesOnRoad: 24,
        totalDistance: 0,
      );

  static DashboardData get todayData => DashboardData(
        date: 'Sat, 8 Mar',
        profitLoss: '1,274',
        earnings: '1,523',
        variableCost: '249',
        tripsCompleted: 0,
        vehiclesOnRoad: 0,
        totalDistance: 0,
      );

  static DashboardData get monthlyData => DashboardData(
        date: 'February',
        profitLoss: '1,332',
        earnings: '49',
        variableCost: '249',
        tripsCompleted: 0,
        vehiclesOnRoad: 34,
        totalDistance: 172,
      );
}

class DashboardProvider with ChangeNotifier {
  TabSelection _selectedTab = TabSelection.yesterday;

  TabSelection get selectedTab => _selectedTab;

  void setSelectedTab(TabSelection tab) {
    _selectedTab = tab;
    notifyListeners();
  }
  
  DashboardData get currentData {
    switch (_selectedTab) {
      case TabSelection.yesterday:
        return DashboardData.yesterdayData;
      case TabSelection.today:
        return DashboardData.todayData;
      case TabSelection.monthly:
        return DashboardData.monthlyData;
    }
  }
}