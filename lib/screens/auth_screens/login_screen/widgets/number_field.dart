import 'package:fleetwise_app/utils/color.dart';
import 'package:fleetwise_app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneNumberField extends StatelessWidget {
  final TextEditingController controller;

  const PhoneNumberField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      keyboardType: TextInputType.phone,
      hint: '',
      prefixIcon: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '+91',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10),
      ],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your phone number';
        } else if (value.length < 10) {
          return 'Please enter a valid 10-digit phone number';
        }
        return null;
      },
    );
  }
}
