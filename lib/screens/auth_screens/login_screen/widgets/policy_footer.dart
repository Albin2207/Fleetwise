import 'package:fleetwise_app/utils/color.dart';
import 'package:flutter/material.dart';

class TermsPolicyFooter extends StatelessWidget {
  const TermsPolicyFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'by continuing, you agree to our',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                minimumSize: Size.zero,
                padding: EdgeInsets.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text(
                'Term Of Use',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            const Text(
              ' and ',
              style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                minimumSize: Size.zero,
                padding: EdgeInsets.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text(
                'Privacy Policy',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
