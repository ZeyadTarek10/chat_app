import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IconOptions extends StatelessWidget {
  const IconOptions({super.key, required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12.r),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [
            ColorsDark.blueLight1,
            ColorsDark.blueLight2,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: ColorsDark.white, size: FontDetails.fontSizeL),
        ),
        SizedBox(height: 8.h),
        CustomTextWidget(
          text: label,
          textStyle: TextStyle(
            color: context.color.textColor,
            fontSize: FontDetails.fontSizeXS,
            fontWeight: FontDetails.mediumFontWeight,
          ),
        ),
      ],
    );
  }
}
