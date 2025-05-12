import 'package:fleetwise_app/utils/color.dart';
import 'package:flutter/material.dart';

class VehiclesOverviewHeader extends StatelessWidget {
  const VehiclesOverviewHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
      child: Row(
        children: [
          Image.asset('assets/ambulance.png', width: 24, height: 24),
          const SizedBox(width: 8),
          Text(
            'Vehicles Overview',
            style: TextStyle(
              color: AppColors.primaryBlue,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
