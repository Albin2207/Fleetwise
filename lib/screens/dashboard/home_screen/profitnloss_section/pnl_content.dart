import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fleetwise_app/provider/dashboard_provider.dart';

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    // Accessing the DashboardProvider to get the selected tab
    final provider = Provider.of<DashboardProvider>(context);
    final selectedTab = provider.selectedTab;

    // Fetching data based on the selected tab
    final data = _getDataForTab(selectedTab);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Showing stats based on selected tab
          if (selectedTab == TabSelection.monthly)
            _buildMonthlyStats(data) // Monthly Stats
          else
            _buildDailyStats(
              data,
              selectedTab,
            ), // Daily Stats (Yesterday/Today)
        ],
      ),
    );
  }

  // Builds the Daily Stats section with relevant data
  Widget _buildDailyStats(DashboardData data, TabSelection tab) {
    // Defining the appropriate subtitles for each tab
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
        // Earning Stat Card
        StatCard(
          image: 'assets/pnl_icons/Icon.png', 
          title: 'Earning${tab == TabSelection.yesterday ? 's' : ''}',
          subtitle: earningSubtitle,
          value: '₹${data.earnings}',
          rightSubtext:
              tab == TabSelection.yesterday
                  ? 'Predicted ₹${data.predictedEarnings}'
                  : 'Approx',
        ),
        const SizedBox(height: 10),
        // Variable Cost Stat Card
        StatCard(
          image: 'assets/pnl_icons/Icon2.png', 
          title: 'Variable Cost',
          subtitle: costSubtitle,
          value: '₹${data.variableCost}',
          rightSubtext:
              tab == TabSelection.yesterday
                  ? 'Predicted ₹${data.predictedVariableCost}'
                  : 'Approx',
        ),
        const SizedBox(height: 10),
        // Trips Completed Stat Card
        StatCard(
          image: 'assets/images/trips.png', 
          title: 'No. of Trips Completed',
          subtitle: tripsSubtitle,
          value: '${data.tripsCompleted}',
        ),
        const SizedBox(height: 10),
        // Vehicles on Road Stat Card
        StatCard(
          image: 'assets/images/vehicles.png', 
        
          title: 'Vehicles on the Road',
          subtitle: vehiclesSubtitle,
          value: tab == TabSelection.today ? '0/1' : '${data.vehiclesOnRoad}',
        ),
        const SizedBox(height: 10),
        // Distance Travelled Stat Card
        StatCard(
          image: 'assets/images/distance.png', 
          title: 'Total Distance Travelled',
          subtitle: distanceSubtitle,
          value: '${data.totalDistance} km',
        ),
      ],
    );
  }

  // Builds the Monthly Stats section
  Widget _buildMonthlyStats(DashboardData data) {
    return Column(
      children: [
        // Total Earning Stat Card
        StatCard(
          image: 'assets/images/earning.png', 
          title: 'Earning',
          subtitle: 'Total revenue generated',
          value: '₹${data.earnings}',
        ),
        const SizedBox(height: 12),
        // Total Cost Stat Card
        StatCard(
          image: 'assets/images/cost.png', 
          title: 'Variable Cost',
          subtitle: 'Expenses & maintenance',
          value: '₹${data.variableCost}',
        ),
        const SizedBox(height: 12),
        // Profit Starting Day Stat Card (Pending data)
        StatCard(
          image: 'assets/images/calendar.png', 
          title: 'Profit Starting Day',
          subtitle: 'Estimated break-even date',
          value: 'PREDICTING...',
          isValuePending: true,
          valueColor: Colors.orange,
        ),
        const SizedBox(height: 12),
        // Total Distance Driven Stat Card
        StatCard(
          image: 'assets/images/distance.png', 
          title: 'Total Distance Driven',
          subtitle: 'Distance driven by 34 vehicles',
          value: '${data.totalDistance} km',
        ),
      ],
    );
  }

  // Returns data based on the selected tab
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

// Stateless widget to display individual stats
class StatCard extends StatelessWidget {
  final String image; // Image URL for the stat card
  final String title;
  final String subtitle;
  final String value;
  final bool isValuePending;
  final Color valueColor;
  final String? rightSubtext;

  const StatCard({
    super.key,
    required this.image,
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
      height: 74,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Image container with circular background
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(
                0.15,
              ), // Color for the image container
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              image,
              width: 24,
              height: 24,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title of the stat card
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                // Subtitle of the stat card
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
              // Value of the stat card (could be pending)
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isValuePending ? valueColor : Colors.black,
                ),
              ),
              // Right subtext if provided (e.g., "Predicted" or "Approx")
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
