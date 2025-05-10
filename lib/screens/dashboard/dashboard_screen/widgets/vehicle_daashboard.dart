import 'package:fleetwise_app/screens/dashboard/dashboard_screen/widgets/overview_filtertabs.dart';
import 'package:fleetwise_app/screens/dashboard/dashboard_screen/widgets/vehicle_detailscard.dart';
import 'package:fleetwise_app/screens/dashboard/dashboard_screen/widgets/vehicleoverview_header.dart';
import 'package:fleetwise_app/utils/color.dart';
import 'package:flutter/material.dart';

class VehicleDashboardScreen extends StatefulWidget {
  const VehicleDashboardScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _VehicleDashboardScreenState createState() => _VehicleDashboardScreenState();
}

class _VehicleDashboardScreenState extends State<VehicleDashboardScreen> {
  String selectedTab = 'All';

  // This would typically come from your API/database
  final List<Map<String, dynamic>> vehiclesData = [
    {
      'vehicleNumber': 'UP 12 AK 3532',
      'status': 'IDLE',
      'driverName': 'Akash Sharma',
      'profit': 74304.0,
      'cost': 383380.0,
      'earnings': 457684.0,
      'hasSosAlert': true,
      'sosTime': '12:53 AM',
    },
    {
      'vehicleNumber': 'UP 12 AK 3248',
      'status': 'RUNNING',
      'driverName': 'Akash Sharma',
      'profit': 74304.0,
      'cost': 383380.0,
      'earnings': 457684.0,
      'hasSosAlert': false,
    },
    {
      'vehicleNumber': 'UP 12 AK 3248',
      'status': 'INACTIVE',
      'profit': 0.0,
      'cost': 0.0,
      'earnings': 0.0,
      'hasSosAlert': false,
      'hasDriver': false,
    },
  ];

  List<Map<String, dynamic>> get filteredVehicles {
    if (selectedTab == 'All') return vehiclesData;
    return vehiclesData
        .where(
          (vehicle) =>
              vehicle['status'].toString().toUpperCase() ==
              selectedTab.toUpperCase(),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGray,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const VehiclesOverviewHeader(),
            StatusFilterTabs(),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: filteredVehicles.length,
                itemBuilder: (context, index) {
                  final vehicle = filteredVehicles[index];
                  return VehicleCard(
                    vehicleNumber: vehicle['vehicleNumber'],
                    status: vehicle['status'],
                    driverName: vehicle['driverName'] ?? '',
                    profit: vehicle['profit'],
                    cost: vehicle['cost'],
                    earnings: vehicle['earnings'],
                    hasSosAlert: vehicle['hasSosAlert'] ?? false,
                    sosTime: vehicle['sosTime'],
                    hasDriver: vehicle['hasDriver'] ?? true,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
