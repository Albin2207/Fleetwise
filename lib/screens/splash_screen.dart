import 'package:fleetwise_app/provider/auth_provider.dart';
import 'package:fleetwise_app/screens/auth_screens/login_screen/login_screen.dart';
import 'package:fleetwise_app/screens/dashboard/home_screen/dashboardscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward();

    // Adding a longer delay to ensure the splash screen stays visible
    Future.delayed(const Duration(seconds: 3), () {
      // Proceed with the navigation after delay
      _checkAuthStatus();
    });
  }

  void _checkAuthStatus() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    // Check if the initialization is done before navigating
    if (authProvider.isInitialized) {
      if (authProvider.status == AuthStatus.authenticated &&
          authProvider.token != null) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const DashboardScreen()),
          (route) => false,
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Consumer<AuthProvider>(
            builder: (context, authProvider, child) {
              // Show splash animation while waiting for initialization
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RotationTransition(
                        turns: _rotationAnimation,
                        child: Image.asset(
                          'assets/Avaronn.png',
                          width: 80,
                          height: 80,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 80,
                              height: 80,
                              color: Colors.grey[300],
                              child: const Center(
                                child: Text('Icon not found'),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: Image.asset(
                            'assets/FleetWise.png',
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[300],
                                child: const Center(
                                  child: Text('Title not found'),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Add loading indicator during initialization
                  if (!authProvider.isInitialized)
                    const CircularProgressIndicator(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
