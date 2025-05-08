import 'package:flutter/material.dart';

class DashboardTabBar extends StatelessWidget {
  final int selectedTabIndex;
  final Function(int) onTabChanged;

  const DashboardTabBar({
    super.key,
    required this.selectedTabIndex,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildTabButton('Yesterday', selectedTabIndex == 0, () => onTabChanged(0)),
          _buildTabButton('Today', selectedTabIndex == 1, () => onTabChanged(1)),
          _buildTabButton('Monthly', selectedTabIndex == 2, () => onTabChanged(2)),
        ],
      ),
    );
  }

  Widget _buildTabButton(String text, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.grey[800],
          borderRadius: BorderRadius.circular(22),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.white,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}