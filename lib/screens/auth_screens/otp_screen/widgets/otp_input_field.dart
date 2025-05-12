import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpInputField extends StatelessWidget {
  final List<TextEditingController> controllers;
  final List<FocusNode> focusNodes;
  final Function(int, String) onDigitChanged;

  const OtpInputField({
    super.key,
    required this.controllers,
    required this.focusNodes,
    required this.onDigitChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        6,
        (index) => SizedBox(
          width: 50,
          height: 50,
          child: TextField(
            controller: controllers[index],
            focusNode: focusNodes[index],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              counterText: '',
              hintText: '*',
              hintStyle: const TextStyle(color: Colors.black26, fontSize: 20),
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.black12, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.black12, width: 1),
              ),
            ),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            onChanged: (value) => onDigitChanged(index, value),
          ),
        ),
      ),
    );
  }
}
