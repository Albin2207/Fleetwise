import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fleetwise_app/provider/auth_provider.dart';

class WelcomeHeader extends StatelessWidget {
  const WelcomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the auth provider to access user's name
    final authProvider = Provider.of<AuthProvider>(context);
    final userName = authProvider.user?.name ?? 'User';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Centered title
          const Center(
            child: Text(
              'FleetWise',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          const SizedBox(height: 29),

          // Greeting row aligned to start (left)
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const Center(
                  child: Icon(Icons.refresh, color: Colors.white, size: 24),
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Text(
                        'Namaste ',
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                      Icon(
                        Icons.front_hand_outlined,
                        color: Colors.white70,
                        size: 14,
                      ),
                    ],
                  ),
                  Text(
                    userName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
