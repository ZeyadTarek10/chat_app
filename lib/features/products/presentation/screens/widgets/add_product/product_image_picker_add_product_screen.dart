import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductImagePickerAddProductScreen extends StatelessWidget {
  final void Function()? onTap;
  final IconData? icon;
  final String text;
  const ProductImagePickerAddProductScreen({super.key, this.onTap, this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: 160.h,
          decoration: BoxDecoration(
            color: ColorsLight.mainTextColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
                color: ColorsLight.mainTextColor.withOpacity(0.3),
                style: BorderStyle.solid),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,
                  size: 40.sp, color: ColorsLight.hintColor),
              SizedBox(height: 10.h),
              CustomTextWidget(
                text: text,
                textStyle: TextStyle(
                    color: ColorsLight.hintColor,
                    fontWeight: FontDetails.mediumFontWeight),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
