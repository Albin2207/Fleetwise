import 'package:fleetwise_app/screens/auth_screens/userdetails_screen/widgets/profile_avatar.dart';
import 'package:fleetwise_app/utils/color.dart';
import 'package:flutter/material.dart';

class NameInputHeader extends StatelessWidget {
  const NameInputHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Left side - Title and subtitle
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            const Text(
              'What shall we call you?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF223652),
              ),
            ),

            const SizedBox(height: 8),

            // Subtitle about Aadhar Card
            Row(
              children: const [
                Text(
                  'Enter full name as on your ',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  'Aadhar Card',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ],
        ),

        // Profile icon on right
        ProfileAvatar(),
      ],
    );
  }
}
