import 'package:flutter/material.dart';
import 'package:fleetwise_app/widgets/bottom_navbar.dart';
import 'package:fleetwise_app/screens/dashboard/onboarding_screen/widgets/features_section.dart';
import 'package:fleetwise_app/screens/dashboard/onboarding_screen/widgets/onboarding_buttons.dart';
import 'package:fleetwise_app/screens/dashboard/onboarding_screen/widgets/profile_tracker.dart';
import 'package:fleetwise_app/screens/dashboard/onboarding_screen/widgets/welcome_header.dart';




class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1A237E), Color(0xFF3949AB)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const WelcomeHeader(),
              const SizedBox(height: 20),
              const ProfitTracker(),
              const SizedBox(height: 20),
              const OnboardingButtons(),
              const SizedBox(height: 20),
              const FeaturesSection(),
              const Spacer(),
              const BottomNavigation(),
            ],
          ),
        ),
      ),
    );
  }
}