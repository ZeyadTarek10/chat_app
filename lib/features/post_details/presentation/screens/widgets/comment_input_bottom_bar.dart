import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/shared_widgets/buttons/custom_text_btn.dart';
import 'package:chat_app/shared_widgets/custom_text_form_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommentInputBottomBar extends StatelessWidget {
  const CommentInputBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.color.mainColor, 
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 21.5.r,
                    child: CircleAvatar(
                      radius: 20.r,
                      backgroundImage: const CachedNetworkImageProvider(
                          'https://i.pinimg.com/736x/79/64/c5/7964c5a700f0342abbb946e883b2a4f2.jpg'),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: CustomTextFormFieldWidget(
                      withBorders: true,
                      hint: "leave_a_comment".tr(),
                      hintColor: ColorsLight.mainTextColor,
                      textColor: ColorsLight.hintColor,
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(right: 15.w),
                        child: Column(
                          mainAxisSize: MainAxisSize.min, 
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomTextButtonWidget(
                              text: "post".tr(),
                              textStyle: TextStyle(
                                  color: ColorsDark.blueLight2,
                                  fontWeight: FontDetails.boldFontWeight,
                                  fontSize: FontDetails.fontSizeS), 
                                  onPressed: () {  },
                            ),
                          ],
                        ),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "leave_a_comment".tr();
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}