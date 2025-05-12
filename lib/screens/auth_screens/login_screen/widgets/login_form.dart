import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fleetwise_app/provider/auth_provider.dart';
import 'package:fleetwise_app/screens/auth_screens/login_screen/widgets/number_field.dart';
import 'package:fleetwise_app/screens/auth_screens/login_screen/widgets/policy_footer.dart';
import 'package:fleetwise_app/utils/color.dart';
import 'package:fleetwise_app/widgets/custom_button.dart';

class LoginForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController phoneController;
  final Function(String) onOtpRequested;

  const LoginForm({
    super.key,
    required this.formKey,
    required this.phoneController,
    required this.onOtpRequested,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Login or register',
            style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 8),
          PhoneNumberField(controller: phoneController),
          const Spacer(),

          // Terms and Privacy Policy
          const TermsPolicyFooter(),
          const SizedBox(height: 16),

          // GET OTP Button
          Consumer<AuthProvider>(
            builder: (context, authProvider, _) {
              return AppButton(
                text: 'GET OTP',
                isLoading: authProvider.status == AuthStatus.loading,
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    final phoneNumber = '+91${phoneController.text.trim()}';
                    onOtpRequested(phoneNumber);
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
