import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class NoNetWorkScreen extends StatelessWidget {
  const NoNetWorkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.color.mainColor,
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              "assets/lottie/No Internet Connection.json",
              fit: BoxFit.fitWidth,
            ),
            SizedBox(height: 12.h,),
            CustomTextWidget(
              text: "no_internet_connection".tr(),
              textStyle: TextStyle(
                  color: ColorsLight.error,
                  fontSize: FontDetails.fontSizeL,
                  fontWeight: FontDetails.boldFontWeight),
            )
          ],
        ),
      ),
    );
  }
}
