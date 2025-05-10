import 'package:fleetwise_app/provider/dashboard_provider.dart';
import 'package:flutter/material.dart';

class DashboardGradientContainer extends StatelessWidget {
  final Widget child;
  final TabSelection selectedTab;

  const DashboardGradientContainer({
    super.key,
    required this.child,
    required this.selectedTab,
  });

  @override
  Widget build(BuildContext context) {
    // Choose background gradient based on selected tab
    List<Color> gradientColors;
    switch (selectedTab) {
      case TabSelection.yesterday:
        // ignore: deprecated_member_use
        gradientColors = [Colors.black, Colors.black.withOpacity(0.8)];
        break;
      case TabSelection.today:
        gradientColors = [Colors.blue.shade800, Colors.blue.shade900];
        break;
      case TabSelection.monthly:
        gradientColors = [Colors.teal.shade800, Colors.teal.shade900];
        break;
    }
    
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: gradientColors,
          stops: const [0.0, 0.3],
        ),
      ),
      child: child,
    );
  }
}