// File: lib/screens/dashboard/dashboard_screen/widgets/tab_selector.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fleetwise_app/provider/dashboard_provider.dart';

class TabSelector extends StatelessWidget {
  const TabSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DashboardProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 1.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildTabButton(
            context,
            'Yesterday',
            TabSelection.yesterday,
            provider.selectedTab == TabSelection.yesterday,
          ),
          const SizedBox(width: 29),
          _buildTabButton(
            context,
            'Today',
            TabSelection.today,
            provider.selectedTab == TabSelection.today,
          ),
          const SizedBox(width: 29),
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
}
