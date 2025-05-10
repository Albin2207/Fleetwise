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

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (selectedTab == TabSelection.monthly)
            _buildMonthlyStats(data)
          else
            _buildDailyStats(data, selectedTab),
        ],
      ),
    );
  }

  Widget _buildDailyStats(DashboardData data, TabSelection tab) {
    String earningSubtitle;
    String costSubtitle;
    String tripsSubtitle;
    String vehiclesSubtitle;
    String distanceSubtitle;

    if (tab == TabSelection.yesterday) {
      earningSubtitle = 'Total revenue generated';
      costSubtitle = 'Expenses & maintenance';
      tripsSubtitle = 'Successful trips finished';
      vehiclesSubtitle = 'Active fleet count';
      distanceSubtitle = 'Kilometers covered by the fleet';
    } else {
      earningSubtitle = 'Your approx earning till now';
      costSubtitle = 'Track expenses to maximise profits';
      tripsSubtitle = 'Stay updated on progress';
      vehiclesSubtitle = 'Active vehicles right now';
      distanceSubtitle = 'Total distance travelled till now!';
    }

    return Column(
      children: [
        StatCard(
          icon: Icons.currency_rupee,
          iconColor: const Color(0xFF1EA896),
          title: 'Earning${tab == TabSelection.yesterday ? 's' : ''}',
          subtitle: earningSubtitle,
          value: '₹${data.earnings}',
          rightSubtext: tab == TabSelection.yesterday ? 'Predicted ₹${data.predictedEarnings}' : 'Approx',
        ),
        const SizedBox(height: 12),
        StatCard(
          icon: Icons.currency_exchange,
          iconColor: Colors.blue,
          title: 'Variable Cost',
          subtitle: costSubtitle,
          value: '₹${data.variableCost}',
          rightSubtext: tab == TabSelection.yesterday ? 'Predicted ₹${data.predictedVariableCost}' : 'Approx',
        ),
        const SizedBox(height: 12),
        StatCard(
          icon: Icons.assignment_turned_in_outlined,
          iconColor: Colors.indigo,
          title: 'No. of Trips Completed',
          subtitle: tripsSubtitle,
          value: '${data.tripsCompleted}',
        ),
        const SizedBox(height: 12),
        StatCard(
          icon: Icons.directions_bus_outlined,
          iconColor: const Color(0xFFFFA726),
          title: 'Vehicles on the Road',
          subtitle: vehiclesSubtitle,
          value: tab == TabSelection.today ? '0/1' : '${data.vehiclesOnRoad}',
        ),
        const SizedBox(height: 12),
        StatCard(
          icon: Icons.speed,
          iconColor: const Color(0xFFAB47BC),
          title: 'Total Distance Travelled',
          subtitle: distanceSubtitle,
          value: '${data.totalDistance} km',
        ),
      ],
    );
  }

  Widget _buildMonthlyStats(DashboardData data) {
    return Column(
      children: [
        StatCard(
          icon: Icons.currency_rupee,
          iconColor: const Color(0xFF1EA896),
          title: 'Total Earning',
          subtitle: 'Your fleet has earned',
          value: '₹${data.earnings}',
        ),
        const SizedBox(height: 12),
        StatCard(
          icon: Icons.currency_exchange,
          iconColor: Colors.blue,
          title: 'Total Cost',
          subtitle: 'Track expenses to maximise profits',
          value: '₹${data.variableCost}',
        ),
        const SizedBox(height: 12),
        StatCard(
          icon: Icons.calendar_today,
          iconColor: const Color(0xFFFFA726),
          title: 'Profit Starting Day',
          subtitle: 'Estimated break-even date',
          value: 'PREDICTING...',
          isValuePending: true,
          valueColor: Colors.orange,
        ),
        const SizedBox(height: 12),
        StatCard(
          icon: Icons.speed,
          iconColor: const Color(0xFFAB47BC),
          title: 'Total Distance Driven',
          subtitle: 'Distance driven by 34 vehicles',
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

class StatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final String value;
  final bool isValuePending;
  final Color valueColor;
  final String? rightSubtext;

  const StatCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.value,
    this.isValuePending = false,
    this.valueColor = Colors.black,
    this.rightSubtext,
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
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 12, color: Colors.grey[700]),
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
                  color: isValuePending ? valueColor : Colors.black,
                ),
              ),
              if (rightSubtext != null)
                Text(
                  rightSubtext!,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
