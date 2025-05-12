import 'package:fleetwise_app/provider/auth_provider.dart';
import 'package:fleetwise_app/screens/auth_screens/login_screen/widgets/login_form.dart';
import 'package:fleetwise_app/screens/auth_screens/login_screen/widgets/logo.dart';
import 'package:fleetwise_app/screens/auth_screens/otp_screen/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 225, 225, 226),
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Main content
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // FleetWise logo
                  const CompanyLogo(),

                  // Login Form
                  Expanded(
                    child: LoginForm(
                      formKey: _formKey,
                      phoneController: _phoneController,
                      onOtpRequested: (phoneNumber) async {
                        final authProvider = context.read<AuthProvider>();
                        final success = await authProvider.sendOtp(phoneNumber);

                        if (success && mounted) {
                          Navigator.push(
                            // ignore: use_build_context_synchronously
                            context,
                            MaterialPageRoute(
                              builder: (_) => const OtpVerificationScreen(),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Top-right design image
            Positioned(
              top: 10,
              right: 0,
              child: Image.asset('assets/Vector (4).png', width: 400),
            ),
          ],
        ),
      ),
    );
  }
}
