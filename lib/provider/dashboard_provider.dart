import 'package:flutter/material.dart';

// Dashboard State Provider
class DashboardProvider extends ChangeNotifier {
  TabSelection _selectedTab = TabSelection.today;
  
  TabSelection get selectedTab => _selectedTab;
  
  void setSelectedTab(TabSelection tab) {
    _selectedTab = tab;
    notifyListeners();
  }
}

// Tab Selection Enum
enum TabSelection { yesterday, today, monthly }

// Dashboard Data Models
class DashboardData {
  final int profitLoss;
  final int? predictedProfitLoss;
  final int earnings;
  final int? predictedEarnings;
  final int variableCost;
  final int? predictedVariableCost;
  final int tripsCompleted;
  final int vehiclesOnRoad;
  final int totalDistance;
  final String date;

  DashboardData({
    required this.profitLoss,
    this.predictedProfitLoss,
    required this.earnings,
    this.predictedEarnings,
    required this.variableCost,
    this.predictedVariableCost,
    required this.tripsCompleted,
    required this.vehiclesOnRoad,
    required this.totalDistance,
    required this.date,
  });

  // Sample data for different tabs
  static DashboardData get todayData => DashboardData(
    profitLoss: 1274,
    predictedProfitLoss: 1523,
    earnings: 1523,
    predictedEarnings: 1200,
    variableCost: 249,
    predictedVariableCost: 120,
    tripsCompleted: 0,
    vehiclesOnRoad: 1, // 0/1 in the screenshot
    totalDistance: 0,
    date: 'Sat, 8 Mar',
  );
  
  static DashboardData get yesterdayData => DashboardData(
    profitLoss: 1274,
    predictedProfitLoss: 1523,
    earnings: 1523,
    predictedEarnings: 1200,
    variableCost: 249,
    predictedVariableCost: 120,
    tripsCompleted: 0,
    vehiclesOnRoad: 24,
    totalDistance: 0,
    date: 'Fri, 7 Mar',
  );
  
  static DashboardData get monthlyData => DashboardData(
    profitLoss: 1332,
    predictedProfitLoss: null,
    earnings: 49,
    predictedEarnings: null,
    variableCost: 249,
    predictedVariableCost: null,
    tripsCompleted: 0, // This field is not shown in monthly view
    vehiclesOnRoad: 0, // Not shown in the same way
    totalDistance: 172,
    date: 'February (ongoing)',
  );
}