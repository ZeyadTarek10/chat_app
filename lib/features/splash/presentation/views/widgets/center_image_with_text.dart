import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/app_images.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CenterImageWithText extends StatelessWidget {
  const CenterImageWithText({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 280.w,
        height: 280.h,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.chatRoundImg), 
            fit: BoxFit.contain, 
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20), 
            child: CustomTextWidget(
              text:  'stay_connected_stay_chatting'.tr(),
              textAlign: TextAlign.center,
              textStyle: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontDetails.semiBoldFontWeight,
                color: ColorsDark.blueDark, 
                height: 1.3.h,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
