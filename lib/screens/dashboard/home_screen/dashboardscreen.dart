import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fleetwise_app/widgets/bottom_navbar.dart';
import 'package:fleetwise_app/provider/dashboard_provider.dart';
import 'package:fleetwise_app/screens/dashboard/home_screen/profitnloss_section/gradient_container.dart';
import 'package:fleetwise_app/screens/dashboard/home_screen/profitnloss_section/header_section.dart';
import 'package:fleetwise_app/screens/dashboard/home_screen/profitnloss_section/pnl_content.dart';
import 'package:fleetwise_app/screens/dashboard/home_screen/profitnloss_section/profitnloss_section.dart';
import 'package:fleetwise_app/screens/dashboard/home_screen/profitnloss_section/tab_selector.dart';
import 'package:fleetwise_app/screens/dashboard/home_screen/vehicleoverview_section/vehicle_daashboard.dart';

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

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DashboardProvider>(context);
    final selectedTab = provider.selectedTab;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // PnL section with gradient background
              DashboardGradientContainer(
                selectedTab: selectedTab,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DashboardHeader(),
                    TabSelector(),
                    ProfitLossSection(),
                    DashboardContent(),
                  ],
                ),
              ),

              // Vehicles Overview section
              Transform.translate(
                offset: const Offset(0, -20),
                child: Container(
                  width: double.infinity,
                  color: const Color(0xFFF5F5F5),
                  height:
                      MediaQuery.of(context).size.height *
                      0.6, 
                  child: const VehicleDashboardScreen(),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
