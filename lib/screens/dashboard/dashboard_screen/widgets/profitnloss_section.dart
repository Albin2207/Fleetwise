import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fleetwise_app/provider/dashboard_provider.dart';


class ProfitLossSection extends StatelessWidget {
  const ProfitLossSection({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DashboardProvider>(context);
    final data = _getDataForTab(provider.selectedTab);
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Profit/Loss',
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                data.date,
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
              Row(
                children: [
                  Text(
                    '₹${data.profitLoss}',
                    style: const TextStyle(
                      color: Colors.greenAccent,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (data.predictedProfitLoss != null)
                    Text(
                      ' predicted: ₹${data.predictedProfitLoss}',
                      style: const TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  if (provider.selectedTab == TabSelection.monthly)
                    const Text(
                      ' approx.',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  DashboardData _getDataForTab(TabSelection tab) {
    switch (tab) {
      case TabSelection.yesterday:
        return DashboardData.yesterdayData;
      case TabSelection.today:
        return DashboardData.todayData;
      case TabSelection.monthly:
        return DashboardData.monthlyData;
    }
  }
}