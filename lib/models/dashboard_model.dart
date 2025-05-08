// Simple data model for dashboard stats
class DashboardData {
  final int profitLoss;
  final int predictedProfitLoss;
  final int earnings;
  final int predictedEarnings;
  final int variableCost;
  final int predictedVariableCost;
  final int tripsCompleted;
  final int vehiclesOnRoad;
  final int totalDistance;
  final String date;

  DashboardData({
    required this.profitLoss,
    required this.predictedProfitLoss,
    required this.earnings,
    required this.predictedEarnings,
    required this.variableCost,
    required this.predictedVariableCost,
    required this.tripsCompleted,
    required this.vehiclesOnRoad,
    required this.totalDistance,
    required this.date,
  });

  // Sample data for the dashboard
  static DashboardData get todayData => DashboardData(
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
}