import 'package:fleetwise_app/widgets/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fleetwise_app/provider/dashboard_provider.dart';
import 'package:fleetwise_app/screens/dashboard/home_screen/profitnloss_section/gradient_container.dart';
import 'package:fleetwise_app/screens/dashboard/home_screen/profitnloss_section/header_section.dart';
import 'package:fleetwise_app/screens/dashboard/home_screen/profitnloss_section/pnl_content.dart';
import 'package:fleetwise_app/screens/dashboard/home_screen/profitnloss_section/profitnloss_section.dart';
import 'package:fleetwise_app/screens/dashboard/home_screen/profitnloss_section/tab_selector.dart';

import 'vehicleoverview_section/overview_filtertabs.dart';
import 'vehicleoverview_section/vehicle_detailscard.dart';
import 'vehicleoverview_section/header_section.dart';

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

              // Vehicles Overview section with cream background
              Container(
                width: double.infinity,
                color: Color(0xFFF5F5F5), // light cream/white background
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VehiclesOverviewHeader(),
                    StatusFilterTabs(),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 1, // Update with actual number
                      itemBuilder: (context, index) {
                        return VehicleCard(
                          vehicleNumber: 'UP 12 AK 3532' ,
                          status: 'IDLE',
                          driverName: 'Akash Sharma',
                          profit: 74304.0,
                          cost: 383380.0,
                          earnings: 457684.0,
                          hasSosAlert: true,
                          sosTime: '12:53 AM',
                        );
                      },
                    ),
                  ],
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
