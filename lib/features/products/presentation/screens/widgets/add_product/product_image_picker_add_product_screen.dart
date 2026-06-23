import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductImagePickerAddProductScreen extends StatelessWidget {
  const ProductImagePickerAddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {},
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
              Icon(Icons.add_photo_alternate_outlined,
                  size: 40.sp, color: ColorsLight.hintColor),
              SizedBox(height: 10.h),
              CustomTextWidget(
                text: "upload_product_image".tr(),
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
