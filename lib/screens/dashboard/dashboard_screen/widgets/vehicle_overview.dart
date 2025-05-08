import 'package:flutter/material.dart';

class VehiclesOverviewSection extends StatelessWidget {
  const VehiclesOverviewSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      width: double.infinity,
      child: Row(
        children: [
          Image.asset(
            'assets/icons/vehicles_overview_icon.png',
            width: 24,
            height: 24,
            color: Colors.blue,
          ),
          const SizedBox(width: 12),
          const Text(
            'Vehicles Overview',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}