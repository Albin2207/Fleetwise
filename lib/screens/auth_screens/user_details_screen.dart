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
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Status bar area (just for UI)
              const StatusBarUI(),
              const SizedBox(height: 24),

              // Title
              const Text(
                'What shall we call you?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              // Identity type text
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
                    'Aadhaar Card',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Full Name Input Field
              AppTextField(
                label: "Your Full Name*",
                hint: 'Enter your full name',
                controller: _fullNameController,
              ),

              const Spacer(),

              // Submit Button
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

              // Keyboard UI (visual only)
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
