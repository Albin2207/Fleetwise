import 'package:fleetwise_app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class FullNameInput extends StatelessWidget {
  final TextEditingController controller;

  const FullNameInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      label: "Your Full Name*",
      hint: '',
      controller: controller,
    );
  }
}
