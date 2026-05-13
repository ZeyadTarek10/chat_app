import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:chat_app/shared_widgets/show_snack_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileData extends StatelessWidget {
  const ProfileData({super.key, required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomTextWidget(
          text: '$title :',
          textStyle: TextStyle(
              color: ColorsLight.mainTextColor,
              fontSize: FontDetails.fontSizeM,
              fontWeight: FontDetails.regularFontWeight),
        ),
        SizedBox(width: 15.w),
        CustomTextWidget(
          text: value,
          textStyle: TextStyle(
              color: context.color.textColor,
              fontSize: FontDetails.fontSizeM,
              fontWeight: FontDetails.regularFontWeight),
        ),
        const Spacer(),
        IconButton(
          icon: Icon(Icons.copy,
              size: 20.sp,
              color: context.color.textColor,
              fontWeight: FontDetails.regularFontWeight),
          onPressed: () {
            Clipboard.setData(ClipboardData(text: value)).then((_) {
              showSnackBar(context,
                  text: '$title copied_to_clipboard'.tr(),
                  color: ColorsDark.blueLight1);
            });
          },
        ),
      ],
    );
  }
}
