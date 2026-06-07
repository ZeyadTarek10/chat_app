import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/services/animate_do.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/features/social/presentation/screens/widgets/action_item_add_post_bottom_sheet.dart';
import 'package:chat_app/shared_widgets/buttons/custom_linear_btn.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:chat_app/shared_widgets/custom_text_form_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AddPostBottomSheetContent extends StatelessWidget {
  const AddPostBottomSheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: CustomTextWidget(
            text: "create_new_post".tr(),
            textStyle: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontDetails.boldFontWeight,
              color: context.color.textColor,
            ),
          ),
        ),
        SizedBox(height: 20.h),
        CustomTextFormFieldWidget(
          hint: "Whats_on_your_mind".tr(),
          maxLength: 4,
          textColor: context.color.textColor,
          fillColor: context.color.chatBackgroundColor,
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return "leave_a_comment".tr();
            }
            return null;
          },
        ),
        SizedBox(height: 15.h),
        CustomFadeInUp(
          duration: 300,
          child: Row(
            children: [
              ActionItemAddPostBottomSheet(
                  onTap: () {}, icon: Icons.image_outlined, text: "photo".tr()),
              SizedBox(width: 15.w),
              ActionItemAddPostBottomSheet(
                  onTap: () {},
                  icon: Icons.location_on_outlined,
                  text: "location".tr()),
            ],
          ),
        ),
        SizedBox(height: 25.h),
        CustomFadeInUp(
          duration: 400,
          child: CustomLinearButton(
            onPressed: () async {
              GoRouter.of(context).pop(context);
            },
            height: 50.h,
            width: double.infinity.w,
            child: CustomTextWidget(
              text: 'post'.tr(),
              textStyle: TextStyle(
                fontSize: FontDetails.fontSizeM,
                color: ColorsDark.white,
                fontWeight: FontDetails.boldFontWeight,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
