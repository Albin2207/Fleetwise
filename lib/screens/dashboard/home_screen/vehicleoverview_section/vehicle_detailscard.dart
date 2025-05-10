import 'package:flutter/material.dart';
import 'package:fleetwise_app/utils/color.dart'; 

class VehicleCard extends StatelessWidget {
  final String vehicleNumber;
  final String status;
  final String driverName;
  final double profit;
  final double cost;
  final double earnings;
  final bool hasSosAlert;
  final String? sosTime;
  final bool hasDriver;

  const VehicleCard({
    super.key,
    required this.vehicleNumber,
    required this.status,
    this.driverName = '',
    required this.profit,
    required this.cost,
    required this.earnings,
    this.hasSosAlert = false,
    this.sosTime,
    this.hasDriver = true,
  });

  Color _getStatusColor() {
    switch (status.toUpperCase()) {
      case 'RUNNING':
        return AppColors.green;
      case 'IDLE':
        return Colors.blue;
      case 'INACTIVE':
        return AppColors.red;
      default:
        return AppColors.darkGray;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Vehicle details header
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      vehicleNumber,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        color: _getStatusColor().withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        status.toUpperCase(),
                        style: TextStyle(
                          color: _getStatusColor(),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: profit >= 0 ? AppColors.green.withOpacity(0.1) : AppColors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '₹${profit.toStringAsFixed(0)}',
                    style: TextStyle(
                      color: profit >= 0 ? AppColors.green : AppColors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Driver info
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: hasDriver 
              ? Row(
                  children: [
                    Icon(Icons.person_outline, color: AppColors.darkGray, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      driverName,
                      style: TextStyle(color: AppColors.darkGray),
                    ),
                    const Spacer(),
                    Text(
                      'Profit / Loss',
                      style: TextStyle(color: AppColors.darkGray, fontSize: 12),
                    ),
                  ],
                )
              : Text(
                  'No Driver Assigned',
                  style: TextStyle(
                    color: AppColors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          ),

          const Divider(height: 32),

          // Financial details
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                // Cost row
                Row(
                  children: [
                    const SizedBox(width: 4),
                    Text('Cost', style: TextStyle(color: AppColors.darkGray)),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: 1.0,
                          backgroundColor: Colors.grey.shade200,
                          color: Colors.grey.shade300,
                          minHeight: 8,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      '₹${cost.toStringAsFixed(0)}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Earnings row
                Row(
                  children: [
                    const SizedBox(width: 4),
                    Text('Earnings', style: TextStyle(color: AppColors.darkGray)),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: earnings / (cost > 0 ? cost : 1),
                          backgroundColor: Colors.grey.shade200,
                          color: status.toUpperCase() == 'RUNNING' ? AppColors.green : AppColors.red,
                          minHeight: 8,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      '₹${earnings.toStringAsFixed(0)}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // SOS Alert if exists
          if (hasSosAlert && sosTime != null)
            Container(
              margin: const EdgeInsets.only(top: 8.0),
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              decoration: const BoxDecoration(
                color: Color(0xFFFFF3E0),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.warning_amber_rounded, color: Colors.red, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'SOS call made at $sosTime by driver',
                    style: const TextStyle(color: Colors.red),
                  ),
                  const Spacer(),
                  const Icon(Icons.arrow_forward, color: Colors.blue, size: 16),
                ],
              ),
            ),
        ],
      ),
    );
  }
}