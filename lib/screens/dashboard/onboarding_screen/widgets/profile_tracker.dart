import 'package:flutter/material.dart';

class ProfitTracker extends StatelessWidget {
  const ProfitTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        // ignore: deprecated_member_use
        color: Colors.black.withOpacity(0.6),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset('assets/Graph.png', height: 300, width: 600),
            ],
          ),
        ],
      ),
    );
  }
}
