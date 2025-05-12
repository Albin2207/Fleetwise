import 'package:flutter/material.dart';
import 'package:fleetwise_app/widgets/bottom_navbar.dart';
import 'package:fleetwise_app/screens/dashboard/onboarding_screen/widgets/features_section.dart';
import 'package:fleetwise_app/screens/dashboard/onboarding_screen/widgets/onboarding_buttons.dart';
import 'package:fleetwise_app/screens/dashboard/onboarding_screen/widgets/profile_tracker.dart';
import 'package:fleetwise_app/screens/dashboard/onboarding_screen/widgets/welcome_header.dart';

class GridPainter extends CustomPainter {
  final Color gridLineColor;

  GridPainter(this.gridLineColor);

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = gridLineColor
          ..strokeWidth = 1.0
          ..style = PaintingStyle.stroke;

    // Draw horizontal grid lines
    double y = 0;
    final gridSize = 24.0;

    while (y < size.height) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
      y += gridSize;
    }

    // Draw vertical grid lines
    double x = 0;
    while (x < size.width) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
      x += gridSize;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background with grid pattern
          _buildBackgroundWithGrid(),

          // Content
          SafeArea(
            child: Stack(
              children: [
                // Scrollable content
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 80),
                    child: Column(
                      children: const [
                        WelcomeHeader(),
                        SizedBox(height: 20),
                        ProfitTracker(),
                        SizedBox(height: 20),
                        OnboardingButtons(),
                        SizedBox(height: 20),
                        FeaturesSection(),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),

                // Bottom navigation bar
                const Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: BottomNavigation(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundWithGrid() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment(0, -0.7),
          colors: [Color(0xFF1A53A1), Colors.black],
          stops: [0, 1],
        ),
      ),
      child: Stack(
        children: [
          ShaderMask(
            shaderCallback: (Rect bounds) {
              return const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment(0, -0.1),
                colors: [Colors.white, Colors.transparent],
                stops: [0.4, 1.0],
              ).createShader(bounds);
            },
            blendMode: BlendMode.dstIn,
            child: CustomPaint(
              size: Size.infinite,
              painter: GridPainter(const Color(0xFF2A65B5)),
            ),
          ),
        ],
      ),
    );
  }
}
