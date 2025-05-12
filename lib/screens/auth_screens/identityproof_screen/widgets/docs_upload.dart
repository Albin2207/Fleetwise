import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fleetwise_app/utils/color.dart';

class DocumentUploadSection extends StatelessWidget {
  final String title;
  final File? image;
  final VoidCallback onTap;

  const DocumentUploadSection({
    super.key,
    required this.title,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF5A6C8A),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                // ignore: deprecated_member_use
                color: Colors.black.withOpacity(0.05),
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            children: [
              // Left part - status indicator
              Expanded(
                child: Container(
                  height: 56,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    image != null
                        ? 'Document uploaded'
                        : 'Tap to select document',
                    style: TextStyle(
                      color: image != null ? Colors.green : Colors.grey[600],
                    ),
                  ),
                ),
              ),
              // Upload button part
              GestureDetector(
                onTap: onTap,
                child: Container(
                  height: 56,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.horizontal(
                      right: Radius.circular(8),
                    ),
                    border: Border.all(color: Colors.grey[200]!, width: 1),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Upload',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
