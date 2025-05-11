import 'package:fleetwise_app/provider/auth_provider.dart';
import 'package:fleetwise_app/screens/auth_screens/otp_screen.dart';
import 'package:fleetwise_app/utils/color.dart';
import 'package:fleetwise_app/widgets/custom_button.dart';
import 'package:fleetwise_app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Image.asset(
                      'assets/Company Name.png',
                      width: 350,
                      height: 265,
                    ),
                  ),

                  // Login Form
                  Expanded(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'Login or register',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          AppTextField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            hint: '',
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(
                                left: 12.0,
                                right: 8.0,
                              ),
                              child: Row(
                                mainAxisSize:
                                    MainAxisSize
                                        .min, // Avoids taking full width
                                crossAxisAlignment:
                                    CrossAxisAlignment
                                        .center, 
                                children: [
                                  Text(
                                    '+91',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10),
                            ],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your phone number';
                              } else if (value.length < 10) {
                                return 'Please enter a valid 10-digit phone number';
                              }
                              return null;
                            },
                          ),
                          const Spacer(),

                          // Terms and Privacy Policy
                          const Text(
                            'by continuing, you agree to our',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                  minimumSize: Size.zero,
                                  padding: EdgeInsets.zero,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: const Text(
                                  'Term Of Use',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                              const Text(
                                ' and ',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                  minimumSize: Size.zero,
                                  padding: EdgeInsets.zero,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: const Text(
                                  'Privacy Policy',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // GET OTP Button
                          Consumer<AuthProvider>(
                            builder: (context, authProvider, _) {
                              return AppButton(
                                text: 'GET OTP',
                                isLoading:
                                    authProvider.status == AuthStatus.loading,
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    final phoneNumber =
                                        '+91${_phoneController.text.trim()}';
                                    final success = await authProvider.sendOtp(
                                      phoneNumber,
                                    );

                                    if (success && mounted) {
                                      Navigator.push(
                                        // ignore: use_build_context_synchronously
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (_) =>
                                                  const OtpVerificationScreen(),
                                        ),
                                      );
                                    }
                                  }
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Top-right design image - moved to front of stack
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
