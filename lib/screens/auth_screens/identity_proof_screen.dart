import 'dart:io';
import 'package:fleetwise_app/provider/auth_provider.dart';
import 'package:fleetwise_app/screens/dashboard/home_screen/dashboardscreen.dart';
import 'package:fleetwise_app/utils/color.dart';
import 'package:fleetwise_app/widgets/custom_button.dart';
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          TextButton(
            onPressed: () {
              // Skip button logic
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const DashboardScreen()),
              );
            },
            child: const Text(
              'Skip',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ),
        ],
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
                'Identity & Address proof of owner',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              
              // Instructions
              const Text(
                'Ramen Ji, get started with document upload',
                style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 24),

              // PAN Card Upload Section
              _buildUploadSection(
                title: 'PAN Card*',
                image: _panCardImage,
                onTap: () => _showPickOptions('pan'),
              ),

              const SizedBox(height: 16),

              // Aadhaar Card Front Upload Section
              _buildUploadSection(
                title: 'Aadhaar Card Front*',
                image: _aadhaarFrontImage,
                onTap: () => _showPickOptions('aadhaar_front'),
              ),

              const SizedBox(height: 16),

              // Aadhaar Card Back Upload Section
              _buildUploadSection(
                title: 'Aadhaar Card Back*',
                image: _aadhaarBackImage,
                onTap: () => _showPickOptions('aadhaar_back'),
              ),

              const Spacer(),

              // Submit Button
              AppButton(
                text: 'SUBMIT',
                isLoading: authProvider.status == AuthStatus.loading,
                onPressed: () async {
                  if (_panCardImage != null &&
                      _aadhaarFrontImage != null &&
                      _aadhaarBackImage != null) {
                    // Upload documents
                    final success = await authProvider.uploadDocuments(
                      panCard: _panCardImage!.path,
                      aadharFront: _aadhaarFrontImage!.path,
                      aadharBack: _aadhaarBackImage!.path,
                    );
                    
                    if (success && mounted) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const DashboardScreen()),
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUploadSection({
    required String title,
    required File? image,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title, 
          style: const TextStyle(fontSize: 14, color: AppColors.textSecondary)
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: onTap,
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.divider),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      image != null ? 'Document uploaded' : 'Upload',
                      style: TextStyle(
                        color: image != null ? Colors.green : Colors.grey[600],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 100,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: const BorderRadius.horizontal(
                      right: Radius.circular(8),
                    ),
                  ),
                  child: Center(
                    child: image != null
                        ? const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          )
                        : const Text(
                            'Upload',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// Common UI components
class StatusBarUI extends StatelessWidget {
  const StatusBarUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          '9:27',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Row(
          children: const [
            Icon(Icons.signal_cellular_4_bar, size: 16),
            SizedBox(width: 4),
            Icon(Icons.wifi, size: 16),
            SizedBox(width: 4),
            Icon(Icons.battery_full, size: 16),
          ],
        ),
      ],
    );
  }
}


