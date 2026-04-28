import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/features/message/presentation/screens/widgets/icon_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AttachmentMenu extends StatelessWidget {
  const AttachmentMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconOptions(icon: Icons.camera_alt, label: 'Camera'),
              IconOptions(icon: Icons.mic, label: 'Record'),
              IconOptions(icon: Icons.person, label: 'Contact'),
            ],
          ),
          SizedBox(height: 24.h),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconOptions(icon: Icons.photo, label: 'Gallery'),
              IconOptions(icon: Icons.location_on, label: 'My Location'),
              IconOptions(icon: Icons.insert_drive_file, label: 'Document'),
            ],
          ),
        ],
      ),
    );
  }
}