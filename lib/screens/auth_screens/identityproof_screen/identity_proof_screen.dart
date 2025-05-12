import 'dart:io';
import 'package:fleetwise_app/provider/auth_provider.dart';
import 'package:fleetwise_app/screens/auth_screens/identityproof_screen/widgets/docs_upload.dart';
import 'package:fleetwise_app/screens/auth_screens/identityproof_screen/widgets/submit_button.dart';
import 'package:fleetwise_app/screens/dashboard/home_screen/dashboardscreen.dart';
import 'package:fleetwise_app/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class IdentityProofScreen extends StatefulWidget {
  const IdentityProofScreen({super.key});

  @override
  State<IdentityProofScreen> createState() => _IdentityProofScreenState();
}

class _IdentityProofScreenState extends State<IdentityProofScreen> {
  File? _panCardImage;
  File? _aadhaarFrontImage;
  File? _aadhaarBackImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source, String type) async {
    final XFile? image = await _picker.pickImage(
      source: source,
      imageQuality: 80,
    );

    if (image != null) {
      setState(() {
        if (type == 'pan') {
          _panCardImage = File(image.path);
        } else if (type == 'aadhaar_front') {
          _aadhaarFrontImage = File(image.path);
        } else if (type == 'aadhaar_back') {
          _aadhaarBackImage = File(image.path);
        }
      });
    }
  }

  void _showPickOptions(String type) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take a photo'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera, type);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery, type);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 225, 225, 226),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress Indicator Bar
              Container(
                width: 120,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),

              // Title with Skip Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Identity & Address proof of owner',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F3351),
                    ),
                  ),
                  // Skip Button
                  TextButton(
                    onPressed: () {
                      // Navigate to Dashboard or handle skip logic
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const DashboardScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Skip',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Instructions - Using user name from AuthProvider
              Text(
                '${authProvider.user?.name ?? ''}, get started with document upload!',
                style: const TextStyle(fontSize: 14, color: Color(0xFF5A6C8A)),
              ),
              const SizedBox(height: 24),

              // PAN Card Upload Section
              DocumentUploadSection(
                title: 'PAN Card*',
                image: _panCardImage,
                onTap: () => _showPickOptions('pan'),
              ),

              const SizedBox(height: 16),

              // Aadhaar Card Front Upload Section
              DocumentUploadSection(
                title: 'Aadhaar Card Front*',
                image: _aadhaarFrontImage,
                onTap: () => _showPickOptions('aadhaar_front'),
              ),

              const SizedBox(height: 16),

              // Aadhaar Card Back Upload Section
              DocumentUploadSection(
                title: 'Aadhaar Card Back*',
                image: _aadhaarBackImage,
                onTap: () => _showPickOptions('aadhaar_back'),
              ),

              const Spacer(),

              // Custom Submit Button
              CustomSubmitButton(
                onTap: () async {
                  if (_panCardImage != null &&
                      _aadhaarFrontImage != null &&
                      _aadhaarBackImage != null) {
                    // Upload documents
                    final success = await authProvider.uploadDocuments(
                      panCard: _panCardImage!.path,
                      aadharFront: _aadhaarFrontImage!.path,
                      aadharBack: _aadhaarBackImage!.path,
                      context: context,
                    );

                    if (success && mounted) {
                      Navigator.pushReplacement(
                        // ignore: use_build_context_synchronously
                        context,
                        MaterialPageRoute(
                          builder: (_) => const DashboardScreen(),
                        ),
                      );
                    }
                  } else {
                    // Show error message
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please upload all required documents'),
                      ),
                    );
                  }
                },
                isLoading: authProvider.status == AuthStatus.loading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
