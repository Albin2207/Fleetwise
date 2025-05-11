import 'package:fleetwise_app/provider/auth_provider.dart';
import 'package:fleetwise_app/screens/auth_screens/identity_proof_screen.dart';
import 'package:fleetwise_app/utils/color.dart';
import 'package:fleetwise_app/widgets/custom_button.dart';
import 'package:fleetwise_app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserNameScreen extends StatefulWidget {
  const UserNameScreen({super.key});

  @override
  State<UserNameScreen> createState() => _UserNameScreenState();
}

class _UserNameScreenState extends State<UserNameScreen> {
  final TextEditingController _fullNameController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 225, 225, 226),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // Header row with profile icon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Left side - Title and subtitle
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      const Text(
                        'What shall we call you?',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF223652),
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Subtitle about Aadhar Card
                      Row(
                        children: const [
                          Text(
                            'Enter full name as on your ',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          Text(
                            'Aadhar Card',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Profile icon on right
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.teal.shade300,
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/pnl_icons/image 3.png',
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              // Full Name Input Field using your custom widget
              AppTextField(
                label: "Your Full Name*",
                hint: '',
                controller: _fullNameController,
              ),

              const Spacer(),

              // Submit Button using your global AppButton
              Consumer<AuthProvider>(
                builder: (context, authProvider, _) {
                  return AppButton(
                    text: 'SUBMIT',
                    isLoading: authProvider.status == AuthStatus.loading,
                    onPressed: () async {
                      final name = _fullNameController.text.trim();
                      if (name.isNotEmpty) {
                        final success = await authProvider.setUserName(name);
                        if (success && mounted) {
                          Navigator.push(
                            // ignore: use_build_context_synchronously
                            context,
                            MaterialPageRoute(
                              builder: (_) => const IdentityProofScreen(),
                            ),
                          );
                        }
                      }
                    },
                  );
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
