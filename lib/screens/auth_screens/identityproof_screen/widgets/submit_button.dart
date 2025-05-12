import 'package:flutter/material.dart';

class CustomSubmitButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isLoading;

  const CustomSubmitButton({
    super.key,
    required this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          color: const Color(0xFF1F3351), // Dark blue color
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child:
            isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text(
                  'SUBMIT',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
      ),
    );
  }
}
