import 'package:fleetwise_app/utils/color.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isDisabled;
  final Color? backgroundColor;
  final Color? textColor;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (isLoading || isDisabled) ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor:
            backgroundColor ?? const Color.fromARGB(255, 213, 219, 230),
        foregroundColor: textColor ?? const Color.fromARGB(255, 142, 141, 141),
        disabledBackgroundColor: AppColors.disabled,
      ),
      child:
          isLoading
              ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
              : Text(text),
    );
  }
}
