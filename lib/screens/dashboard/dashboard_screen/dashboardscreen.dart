import 'package:fleetwise_app/provider/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DashboardProvider(),
      child: const DashboardView(),
    );
  }
}

// Dashboard View
class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DashboardProvider>(context);
    final selectedTab = provider.selectedTab;
    
    // Choose background gradient based on selected tab
    List<Color> gradientColors;
    switch (selectedTab) {
      case TabSelection.yesterday:
        gradientColors = [Colors.black, Colors.black.withOpacity(0.8)];
        break;
      case TabSelection.today:
        gradientColors = [Colors.blue.shade800, Colors.blue.shade900];
        break;
      case TabSelection.monthly:
        gradientColors = [Colors.teal.shade800, Colors.teal.shade900];
        break;
    }
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: gradientColors,
            stops: const [0.0, 0.3],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              _buildTabSelector(context),
              _buildProfitLossSection(selectedTab),
              Expanded(
                child: _buildDashboardContent(selectedTab),
              ),
              _buildVehiclesOverview(selectedTab),
              _buildBottomNavBar(),
            ],
          ),
        ),
      ),
    );
  }
  
  // Header section with user info
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: const Center(
              child: Icon(Icons.person_outline, color: Colors.white),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Namaste 🙏',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              Text(
                'Raman Ji',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  // Tab selector (Yesterday, Today, Monthly)
  Widget _buildTabSelector(BuildContext context) {
    final provider = Provider.of<DashboardProvider>(context);
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildTabButton(
            context,
            'Yesterday',
            TabSelection.yesterday,
            provider.selectedTab == TabSelection.yesterday,
          ),
          const SizedBox(width: 8),
          _buildTabButton(
            context,
            'Today',
            TabSelection.today,
            provider.selectedTab == TabSelection.today,
          ),
          const SizedBox(width: 8),
          _buildTabButton(
            context,
            'Monthly',
            TabSelection.monthly,
            provider.selectedTab == TabSelection.monthly,
          ),
        ],
      ),
    );
  }
  
  // Individual tab button
  Widget _buildTabButton(
    BuildContext context,
    String label,
    TabSelection tab,
    bool isSelected,
  ) {
    final provider = Provider.of<DashboardProvider>(context, listen: false);
    
    return GestureDetector(
      onTap: () => provider.setSelectedTab(tab),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.white24,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.white,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
  
  // Profit/Loss section
  Widget _buildProfitLossSection(TabSelection selectedTab) {
    final data = _getDataForTab(selectedTab);
    
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
                  if (selectedTab == TabSelection.monthly)
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
  
  // Dashboard content based on selected tab
  Widget _buildDashboardContent(TabSelection selectedTab) {
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
      child: ListView(
        children: [
          if (selectedTab == TabSelection.monthly)
            _buildMonthlyStats(data)
          else
            _buildDailyStats(data),
        ],
      ),
    );
  }
  
  // Daily stats (Yesterday and Today)
  Widget _buildDailyStats(DashboardData data) {
    return Column(
      children: [
        // Earnings card
        _buildStatCard(
          icon: Icons.monetization_on_outlined,
          iconColor: Colors.teal,
          title: 'Earning',
          subtitle: 'Total revenue generated',
          value: '₹${data.earnings}',
          prediction: data.predictedEarnings != null ? 'predicted: ₹${data.predictedEarnings}' : null,
        ),
        
        const SizedBox(height: 16),
        
        // Variable Cost card
        _buildStatCard(
          icon: Icons.trending_down,
          iconColor: Colors.blue,
          title: 'Variable Cost',
          subtitle: 'Expenses & maintenance',
          value: '₹${data.variableCost}',
          prediction: data.predictedVariableCost != null ? 'predicted: ₹${data.predictedVariableCost}' : null,
        ),
        
        const SizedBox(height: 16),
        
        // Trips completed card
        _buildStatCard(
          icon: Icons.checklist,
          iconColor: Colors.indigo,
          title: 'No. of trips completed',
          subtitle: 'Successful trips finished',
          value: '${data.tripsCompleted}',
          prediction: null,
        ),
        
        const SizedBox(height: 16),
        
        // Vehicles on road card
        _buildStatCard(
          icon: Icons.directions_bus_outlined,
          iconColor: Colors.amber,
          title: 'Vehicles on the road',
          subtitle: 'Active fleet count',
          value: '${data.vehiclesOnRoad}',
          prediction: null,
        ),
        
        const SizedBox(height: 16),
        
        // Total distance card
        _buildStatCard(
          icon: Icons.speed,
          iconColor: Colors.purple,
          title: 'Total distance travelled',
          subtitle: 'Kilometers covered by the fleet',
          value: '${data.totalDistance} km',
          prediction: null,
        ),
      ],
    );
  }
  
  // Monthly stats
  Widget _buildMonthlyStats(DashboardData data) {
    return Column(
      children: [
        // Total Earning card
        _buildStatCard(
          icon: Icons.monetization_on_outlined,
          iconColor: Colors.teal,
          title: 'Total Earning',
          subtitle: 'You have less earned',
          value: '₹${data.earnings}',
          prediction: null,
        ),
        
        const SizedBox(height: 16),
        
        // Total Cost card
        _buildStatCard(
          icon: Icons.trending_down,
          iconColor: Colors.blue,
          title: 'Total Cost',
          subtitle: 'Track expenses to maximize profits',
          value: '₹${data.variableCost}',
          prediction: null,
        ),
        
        const SizedBox(height: 16),
        
        // Profit starting day card
        _buildStatCard(
          icon: Icons.calendar_today,
          iconColor: Colors.amber,
          title: 'Profit starting day',
          subtitle: 'Estimated break-even date',
          value: 'PENDING',
          isValuePending: true,
          prediction: null,
        ),
        
        const SizedBox(height: 16),
        
        // Total distance driven card
        _buildStatCard(
          icon: Icons.speed,
          iconColor: Colors.purple,
          title: 'Total distance driven',
          subtitle: 'Distance driven by 24 vehicles',
          value: '${data.totalDistance} km',
          prediction: null,
        ),
      ],
    );
  }
  
  // Generic stat card widget
  Widget _buildStatCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String value,
    bool isValuePending = false,
    String? prediction,
  }) {
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
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
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
                  prediction,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                )
              else if (!isValuePending)
                Text(
                  'approx.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
  
  // Vehicles Overview section
  Widget _buildVehiclesOverview(TabSelection selectedTab) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.directions_bus, size: 16, color: Colors.black54),
              SizedBox(width: 8),
              Text(
                'Vehicles Overview',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildVehicleStatusTabs(selectedTab),
        ],
      ),
    );
  }
  
  // Vehicle status tabs
  Widget _buildVehicleStatusTabs(TabSelection selectedTab) {
    final bool isMonthly = selectedTab == TabSelection.monthly;
    
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildVehicleStatusTab('All (26)', true, Colors.indigo),
          const SizedBox(width: 8),
          if (isMonthly)
            _buildVehicleStatusTab('Excellent (02)', false, Colors.green)
          else
            _buildVehicleStatusTab('Running (02)', false, Colors.green),
          const SizedBox(width: 8),
          _buildVehicleStatusTab('Good (01)', false, Colors.blue),
          const SizedBox(width: 8),
          if (isMonthly)
            _buildVehicleStatusTab('Average (05)', false, Colors.orange)
          else
            _buildVehicleStatusTab('Idle (01)', false, Colors.orange),
          const SizedBox(width: 8),
          if (!isMonthly)
            _buildVehicleStatusTab('Inactive (05)', false, Colors.red),
        ],
      ),
    );
  }
  
  // Individual vehicle status tab
  Widget _buildVehicleStatusTab(String label, bool isSelected, Color activeColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? activeColor : Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
  
  // Bottom navigation bar
  Widget _buildBottomNavBar() {
    return Container(
      height: 60,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavBarItem(Icons.home, 'Home', true),
          _buildNavBarItem(Icons.directions_bus_outlined, 'Vehicles', false),
          _buildNavBarItem(Icons.person_outline, 'Drivers', false),
          _buildNavBarItem(Icons.account_circle_outlined, 'Account', false),
        ],
      ),
    );
  }
  
  // Individual nav bar item
  Widget _buildNavBarItem(IconData icon, String label, bool isSelected) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: isSelected ? Colors.black : Colors.grey,
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isSelected ? Colors.black : Colors.grey,
          ),
        ),
      ],
    );
  }
  
  // Helper to get data for the selected tab
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
