import 'package:flutter/material.dart';

class ResendTimer extends StatelessWidget {
  final int seconds;

  const ResendTimer({super.key, required this.seconds});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: Text(
          "Resend in 00:${seconds.toString().padLeft(2, '0')}",
          style: const TextStyle(fontSize: 12, color: Colors.black54),
        ),
      ),
    );
  }
}
