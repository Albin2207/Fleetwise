// File: lib/screens/dashboard/dashboard_screen/widgets/profitnloss_section.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fleetwise_app/provider/dashboard_provider.dart';

class ProfitLossSection extends StatelessWidget {
  const ProfitLossSection({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DashboardProvider>(context);
    final data = provider.currentData;
    final selectedTab = provider.selectedTab;
    
    // Choose text for different tabs
    String dateText;
    String additionalText;
    
    switch (selectedTab) {
      case TabSelection.yesterday:
        dateText = data.date;
        additionalText = 'predicted: ₹${data.predictedProfitLoss}';
        break;
      case TabSelection.today:
        dateText = data.date;
        additionalText = 'approx.';
        break;
      case TabSelection.monthly:
        dateText = 'February (ongoing)';
        additionalText = '';
        break;
    }
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Profit/Loss',
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                dateText,
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
              Row(
                children: [
                  Text(
                    '₹${data.profitLoss}',
                    style: const TextStyle(
                      color: Colors.greenAccent,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (additionalText.isNotEmpty)
                    Text(
                      ' $additionalText',
                      style: const TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}