import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';

class IconOptions extends StatelessWidget {
  const IconOptions({super.key, required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [
            AppColors.backgroundColorbuttonblue1,
            AppColors.backgroundColorbuttonblue2,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppColors.white, size: FontDetails.fontSizeL),
        ),
        const SizedBox(height: 8),
        CustomTextWidget(
          text: label,
          textStyle: TextStyle(
            color: AppColors.black,
            fontSize: FontDetails.fontSizeXS,
            fontWeight: FontDetails.mediumFontWeight,
          ),
        ),
      ],
    );
  }
}
