import 'package:flutter/material.dart';

class OtpHeader extends StatelessWidget {
  final String phoneNumber;

  const OtpHeader({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Verify Number',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),

            // Right side: Image
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Image.asset(
                'assets/pnl_icons/image 4.png',
                width: 40,
                height: 40,
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Text(
              'OTP sent to ',
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            Text(
              phoneNumber,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
