import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fleetwise_app/provider/dashboard_provider.dart';
import 'package:fleetwise_app/screens/dashboard/dashboard_screen/widgets/gradient_container.dart';
import 'package:fleetwise_app/screens/dashboard/dashboard_screen/widgets/header_section.dart';
import 'package:fleetwise_app/screens/dashboard/dashboard_screen/widgets/pnl_content.dart';
import 'package:fleetwise_app/screens/dashboard/dashboard_screen/widgets/profitnloss_section.dart';
import 'package:fleetwise_app/screens/dashboard/dashboard_screen/widgets/tab_selector.dart';

import 'widgets/overview_filtertabs.dart';
import 'widgets/vehicle_detailscard.dart';
import 'widgets/vehicleoverview_header.dart';

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
      body: DashboardGradientContainer(
        selectedTab: selectedTab,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DashboardHeader(),
                TabSelector(),
                ProfitLossSection(),
                DashboardContent(),
                VehiclesOverviewHeader(),
                StatusFilterTabs(),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 1, // Change this to the actual number of vehicles
                  itemBuilder: (context, index) {
                    return VehicleCard(
                      vehicleNumber: 'UP 12 AK 3532',
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
                // Add more vehicles manually if needed
                // VehicleCard(...),
                // VehicleCard(...),
              ],
            ),
          ),
        ),
      ),
    );
  }
}