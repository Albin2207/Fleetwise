import 'package:flutter/material.dart';
import 'package:fleetwise_app/utils/color.dart';

class StatusFilterTabs extends StatelessWidget {
  const StatusFilterTabs({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> tabs = [
      {'name': 'All', 'count': 26},
      {'name': 'Running', 'count': 2},
      {'name': 'Idle', 'count': 1},
      {'name': 'Inactive', 'count': 5},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 19.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children:
            tabs.map((tab) {
              final bool isSelected = tab['name'] == 'All';
              return Padding(
                padding: const EdgeInsets.only(right: 1.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 8.0,
                  ),
                  decoration: BoxDecoration(
                    color:
                        isSelected ? AppColors.primaryBlue : Colors.transparent,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    '${tab['name']} (${tab['count'].toString().padLeft(2, '0')})',
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                      fontSize: 14,
                    ),
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }
}
