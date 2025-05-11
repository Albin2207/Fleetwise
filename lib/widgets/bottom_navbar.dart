import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [_buildNavIcon(0)],
      ),
    );
  }

  Widget _buildNavIcon(int index) {
    return Expanded(
      child: InkWell(
        onTap: () {
          // Handle navigation tap
        },
        child: SizedBox(
          child: ClipRect(
            child: Align(
              alignment: Alignment(0, 0),
              child: Image.asset(
                'assets/Navbar MFO.png',
                fit: BoxFit.cover,
                width: 400,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
