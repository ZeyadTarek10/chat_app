import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/features/message/presentation/screens/widgets/icon_options.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AttachmentMenu extends StatelessWidget {
  const AttachmentMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: ColorsDark.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: ColorsLight.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconOptions(icon: Icons.camera_alt, label: 'camera'.tr()),
              IconOptions(icon: Icons.mic, label: 'record'.tr()),
              IconOptions(icon: Icons.person, label: 'contact'.tr()),
            ],
          ),
          SizedBox(height: 24.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconOptions(icon: Icons.photo, label: 'gallery'.tr()),
              IconOptions(icon: Icons.location_on, label: 'my_location'.tr()),
              IconOptions(icon: Icons.insert_drive_file, label: 'document'.tr()),
            ],
          ),
        ],
      ),
    );
  }
}