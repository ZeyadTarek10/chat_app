import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/features/more/screens/widgets/custom_more_tile.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LanguageMoreScreen extends StatelessWidget {
  const LanguageMoreScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomMoreTile(
      icon: Icons.text_format,
      title: 'language'.tr(),
      trailing: PopupMenuButton<Locale>(
        color: context.color.navBarbg,
        initialValue: context.locale,
        onSelected: (Locale newLocale) {
          context.setLocale(newLocale);
        },
        itemBuilder: (BuildContext context) =>
            <PopupMenuEntry<Locale>>[
         PopupMenuItem<Locale>(
            value: const Locale('en'),
            child: CustomTextWidget(text: 'English', textStyle: TextStyle(color: context.color.textColor),),
          ),
           PopupMenuItem<Locale>(
            value: const Locale('ar'),
            child: CustomTextWidget(text:'العربية', textStyle: TextStyle(color: context.color.textColor),),
          ),
        ],
        child: Container(
          padding:
              EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
          decoration: BoxDecoration(
            border: Border.all(color: ColorsLight.mainTextColor),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextWidget(
                text: context.locale.languageCode == 'ar'
                    ? 'العربية'
                    : 'English',
                textStyle:  TextStyle(
                  fontSize: FontDetails.fontSizeS,
                  fontWeight: FontDetails.boldFontWeight,
                  color: context.color.textColor
                ),
              ),
              SizedBox(width: 4.w),
            Icon(Icons.keyboard_arrow_down, size: 18.sp, color: context.color.textColor,),
            ],
          ),
        ),
      ),
    );
  }
}
