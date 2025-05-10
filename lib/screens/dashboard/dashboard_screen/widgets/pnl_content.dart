import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fleetwise_app/provider/dashboard_provider.dart';

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DashboardProvider>(context);
    final selectedTab = provider.selectedTab;
    final data = _getDataForTab(selectedTab);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (selectedTab == TabSelection.monthly)
            _buildMonthlyStats(data)
          else
            _buildDailyStats(data),
        ],
      ),
    );
  }

  Widget _buildDailyStats(DashboardData data) {
    return Column(
      children: [
        // Earnings card
        StatCard(
          icon: Icons.monetization_on_outlined,
          iconColor: Colors.teal,
          title: 'Earning',
          subtitle: 'Total revenue generated',
          value: '₹${data.earnings}',
          prediction:
              data.predictedEarnings != null
                  ? 'predicted: ₹${data.predictedEarnings}'
                  : null,
        ),

        const SizedBox(height: 16),

        // Variable Cost card
        StatCard(
          icon: Icons.trending_down,
          iconColor: Colors.blue,
          title: 'Variable Cost',
          subtitle: 'Expenses & maintenance',
          value: '₹${data.variableCost}',
          prediction:
              data.predictedVariableCost != null
                  ? 'predicted: ₹${data.predictedVariableCost}'
                  : null,
        ),

        const SizedBox(height: 16),

        // Trips completed card
        StatCard(
          icon: Icons.checklist,
          iconColor: Colors.indigo,
          title: 'No. of trips completed',
          subtitle: 'Successful trips finished',
          value: '${data.tripsCompleted}',
        ),

        const SizedBox(height: 16),

        // Vehicles on road card
        StatCard(
          icon: Icons.directions_bus_outlined,
          iconColor: Colors.amber,
          title: 'Vehicles on the road',
          subtitle: 'Active fleet count',
          value: '${data.vehiclesOnRoad}',
        ),

        const SizedBox(height: 16),

        // Total distance card
        StatCard(
          icon: Icons.speed,
          iconColor: Colors.purple,
          title: 'Total distance travelled',
          subtitle: 'Kilometers covered by the fleet',
          value: '${data.totalDistance} km',
        ),
      ],
    );
  }

  Widget _buildMonthlyStats(DashboardData data) {
    return Column(
      children: [
        // Total Earning card
        StatCard(
          icon: Icons.monetization_on_outlined,
          iconColor: Colors.teal,
          title: 'Total Earning',
          subtitle: 'You have less earned',
          value: '₹${data.earnings}',
        ),

        const SizedBox(height: 16),

        // Total Cost card
        StatCard(
          icon: Icons.trending_down,
          iconColor: Colors.blue,
          title: 'Total Cost',
          subtitle: 'Track expenses to maximize profits',
          value: '₹${data.variableCost}',
        ),

        const SizedBox(height: 16),

        // Profit starting day card
        StatCard(
          icon: Icons.calendar_today,
          iconColor: Colors.amber,
          title: 'Profit starting day',
          subtitle: 'Estimated break-even date',
          value: 'PENDING',
          isValuePending: true,
        ),

        const SizedBox(height: 16),

        // Total distance driven card
        StatCard(
          icon: Icons.speed,
          iconColor: Colors.purple,
          title: 'Total distance driven',
          subtitle: 'Distance driven by 24 vehicles',
          value: '${data.totalDistance} km',
        ),
      ],
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

/// Reusable stat card widget
class StatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final String value;
  final bool isValuePending;
  final String? prediction;

  const StatCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.value,
    this.isValuePending = false,
    this.prediction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isValuePending ? Colors.orange : Colors.black,
                ),
              ),
              if (prediction != null)
                Text(
                  prediction!,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                )
              else if (!isValuePending)
                Text(
                  'approx.',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
