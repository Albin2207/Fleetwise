import 'package:fleetwise_app/provider/auth_provider.dart';
import 'package:fleetwise_app/screens/auth_screens/identityproof_screen/identity_proof_screen.dart';
import 'package:fleetwise_app/screens/auth_screens/userdetails_screen/widgets/header_section.dart';
import 'package:fleetwise_app/screens/auth_screens/userdetails_screen/widgets/name_input_field.dart';
import 'package:fleetwise_app/widgets/custom_button.dart';
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

              // Header with title and profile icon
              const NameInputHeader(),

              const SizedBox(height: 30),

              // Full Name Input Field
              FullNameInput(controller: _fullNameController),

              const Spacer(),

              // Submit Button
              Consumer<AuthProvider>(
                builder: (context, authProvider, _) {
                  return SizedBox(
                    width: double.infinity,
                    child: AppButton(
                      text: 'SUBMIT',
                      isLoading: authProvider.status == AuthStatus.loading,
                      onPressed: () => _submitName(context, authProvider),
                    ),
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

  Future<void> _submitName(
    BuildContext context,
    AuthProvider authProvider,
  ) async {
    final name = _fullNameController.text.trim();
    if (name.isNotEmpty) {
      final success = await authProvider.setUserName(name);
      if (success && mounted) {
        Navigator.push(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (_) => const IdentityProofScreen()),
        );
      }
    }
  }
}
