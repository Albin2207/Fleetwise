import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:fleetwise_app/provider/auth_provider.dart';
import 'package:fleetwise_app/screens/auth_screens/user_details_screen.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final List<TextEditingController> _otpControllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  int _resendSeconds = 60;
  bool _isVerifying = false;

  @override
  void initState() {
    super.initState();
    _startResendTimer();

    // Set up a listener for all controllers to detect when the entire OTP is filled
    for (var i = 0; i < _otpControllers.length; i++) {
      _otpControllers[i].addListener(() {
        // Check if all fields are filled and we're not already verifying
        if (!_isVerifying && _otpValue.length == 6) {
          _verifyOtpAndProceed();
        }
      });
    }
  }

  void _startResendTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      setState(() {
        if (_resendSeconds > 0) {
          _resendSeconds--;
          _startResendTimer();
        }
      });
    });
  }

  String get _otpValue {
    return _otpControllers.map((controller) => controller.text).join();
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onOtpDigitChanged(int index, String value) {
    if (value.length == 1) {
      if (index < 5) {
        // Move to next field
        _focusNodes[index + 1].requestFocus();
      } else {
        // Last digit entered, verify OTP
        _verifyOtpAndProceed();
      }
    } else if (value.isEmpty && index > 0) {
      // Move to previous field on backspace
      _focusNodes[index - 1].requestFocus();
    }
  }

  void _verifyOtpAndProceed() async {
    final otp = _otpValue;

    // Only proceed if all 6 digits are filled
    if (otp.length == 6) {
      // Hide keyboard
      FocusManager.instance.primaryFocus?.unfocus();

      // Show a loading indicator
      setState(() {
        _isVerifying = true;
      });

      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final success = await authProvider.verifyOtp(otp);

      if (success && mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const UserNameScreen()),
        );
      } else if (mounted) {
        // Show error message
        setState(() {
          _isVerifying = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid OTP. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final phoneNumber = authProvider.phoneNumber ?? '+91 93622 53463';

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 225, 225, 226),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top section with title and rating
              Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Verify Number',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    ),

    // Right side: Image
    Padding(
      padding: const EdgeInsets.only(top: 8.0), 
      child: Image.asset(
        'assets/pnl_icons/image 4.png',
        width: 40,
        height: 40,
      ),
    ),
  ],
),
Row(
  children: [
    const Text(
      'OTP sent to ',
      style: TextStyle(fontSize: 14, color: Colors.black54),
    ),
    Text(
      phoneNumber,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
    ),
  ],
),

              const SizedBox(height: 40),

              // OTP Input Fields
              const Text(
                "Enter OTP*",
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  6,
                  (index) => SizedBox(
                    width: 50,
                    height: 50,
                    child: TextField(
                      controller: _otpControllers[index],
                      focusNode: _focusNodes[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        counterText: '',
                        hintText: '*',
                        hintStyle: const TextStyle(
                          color: Colors.black26,
                          fontSize: 20,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.black12,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.black12,
                            width: 1,
                          ),
                        ),
                      ),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onChanged: (value) => _onOtpDigitChanged(index, value),
                    ),
                  ),
                ),
              ),

              // Resend timer
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Text(
                    "Resend in 00:${_resendSeconds.toString().padLeft(2, '0')}",
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ),
              ),

              // Loading indicator when verifying
              if (_isVerifying)
                const Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                  ),
                ),

              const SizedBox(height: 30),

              // Automatic transition message (shown when OTP is being verified)
              if (_isVerifying)
                const Center(
                  child: Text(
                    "Verifying OTP...",
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ),

              const SizedBox(height: 30),

              // Link to change mobile number
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    "change your mobile number",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
