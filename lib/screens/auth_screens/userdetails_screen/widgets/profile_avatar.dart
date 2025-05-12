import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.teal.shade300,
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: Image.asset(
          'assets/pnl_icons/image 3.png',
          width: 48,
          height: 48,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
