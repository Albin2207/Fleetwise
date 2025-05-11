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

  Color _getEarningsBarColor() {
    // Based on screenshot: green bar for IDLE, red bar for RUNNING
    switch (status.toUpperCase()) {
      case 'RUNNING':
        return Colors.red;
      case 'IDLE':
        return AppColors.green;
      case 'INACTIVE':
        return AppColors.red;
      default:
        return AppColors.darkGray;
    }
  }

  String _formatCurrency(double value) {
    // Format to display with commas (e.g., 74,304)
    final valueString = value.toInt().toString();
    final buffer = StringBuffer();
    int counter = 0;

    for (int i = valueString.length - 1; i >= 0; i--) {
      counter++;
      buffer.write(valueString[i]);
      if (counter % 3 == 0 && i > 0) {
        buffer.write(',');
      }
    }

    return buffer.toString().split('').reversed.join();
  }

  @override
  Widget build(BuildContext context) {
    // For RUNNING status, we need to show less of the bar filled
    // Based on the image, for RUNNING the bar is about 20% filled
    final displayedEarningsRatio =
        status.toUpperCase() == 'RUNNING' ? 0.2 : 0.8;

    // For cost bar in IDLE, show about 60% filled, for RUNNING show about 90% filled
    final costRatio = status.toUpperCase() == 'RUNNING' ? 0.9 : 0.6;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
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
                // Vehicle number and status
                Row(
                  children: [
                    Text(
                      vehicleNumber,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Color(0xFF666666),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        // ignore: deprecated_member_use
                        color: _getStatusColor().withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
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

                // Profit display
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  decoration: BoxDecoration(
                    color:
                        profit >= 0
                            ? const Color(0xFFE8F5F0)
                            : const Color(0xFFFDEAEA),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '₹${_formatCurrency(profit)}',
                    style: TextStyle(
                      color: profit >= 0 ? AppColors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Driver info
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Driver section with asset image instead of icon
                Row(
                  children: [
                    // Replace icon with asset image for driver
                    Image.asset(
                      'assets/bottom_navigation/Driver.png', // Make sure this asset exists
                      width: 20,
                      height: 20,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      hasDriver ? driverName : 'No Driver Assigned',
                      style: TextStyle(
                        color: hasDriver ? Colors.grey.shade600 : Colors.red,
                        fontWeight:
                            hasDriver ? FontWeight.normal : FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                // Profit/Loss label
                Text(
                  'Profit / Loss',
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
                ),
              ],
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
                    SizedBox(
                      width: 75,
                      child: Text(
                        'Cost',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          // Background bar
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Container(
                              height: 24,
                              color: Colors.grey.shade200,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: (costRatio * 100).toInt(),
                                    child: Container(
                                      color: Colors.grey.shade300,
                                      // Removed the text inside the bar
                                    ),
                                  ),
                                  Expanded(
                                    flex: 100 - (costRatio * 100).toInt(),
                                    child: Container(color: Colors.transparent),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      '₹${_formatCurrency(cost)}',
                      style: const TextStyle(color: Color.fromARGB(255, 112, 109, 109), fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Earnings row
                Row(
                  children: [
                    SizedBox(
                      width: 75,
                      child: Text(
                        'Earnings',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          // Background bar
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Container(
                              height: 24, // Taller to fit text inside
                              color: Colors.grey.shade200,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex:
                                        (displayedEarningsRatio * 100).toInt(),
                                    child: Container(
                                      color: _getEarningsBarColor(),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 8.0,
                                          ),
                                          
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex:
                                        100 -
                                        (displayedEarningsRatio * 100).toInt(),
                                    child: Container(color: Colors.transparent),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      '₹${_formatCurrency(earnings)}',
                      style: const TextStyle(color: Color.fromARGB(255, 112, 109, 109), fontSize: 14),
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
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
              decoration: const BoxDecoration(
                color: Color(0xFFFFF8E1), // Light amber color
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.red.shade700,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'SOS call made at $sosTime by driver',
                    style: TextStyle(color: Colors.red.shade700, fontSize: 14),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.grey.shade700,
                    size: 18,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
