import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NavItem extends StatelessWidget {
  final int index;
  final IconData icon;
  final String label;
  final int currentScreen;
  final VoidCallback onTap;

  const NavItem({
    super.key,
    required this.index,
    required this.icon,
    required this.label,
    required this.currentScreen,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    bool isSelected = currentScreen == index;

    return Expanded(
      child: GestureDetector(
        // behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            gradient: isSelected
                ? const LinearGradient(
                    colors: [
                      ColorsDark.blueLight1,
                      ColorsDark.blueLight2,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : const LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.transparent,
                    ],
                  ),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color:
                    isSelected ? ColorsLight.white : ColorsLight.mainTextColor,
                size: 24.sp,
              ).animate(target: isSelected ? 1 : 0).scaleXY(end: 1.2),
              SizedBox(height: 4.h),
              CustomTextWidget(
                text: label,
                textStyle: TextStyle(
                  color: isSelected
                      ? ColorsLight.white
                      : ColorsLight.mainTextColor,
                  fontSize: FontDetails.fontSizeXS,
                  fontWeight: isSelected
                      ? FontDetails.semiBoldFontWeight
                      : FontDetails.mediumFontWeight,
                ),
              ).animate(target: isSelected ? 1 : 0).scaleXY(end: 1.06),
            ],
          ),
        ),
      ),
    );
  }
}
