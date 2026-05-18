import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/services/animate_do.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/features/groups/presentation/screens/widgets/stack_circle_avatar.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GroupsItem extends StatelessWidget {
  final String name;
  final List<String> memberNames;
  final String message;
  final String time;
  final int unreadCount;
  final List<String> image;
  final int c;

  const GroupsItem({
    super.key,
    required this.name,
    required this.message,
    required this.time,
    this.unreadCount = 0,
    required this.image, required this.c, required this.memberNames,
  });

  @override
  Widget build(BuildContext context) {
    return CustomFadeInRight(
      duration: 800,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
        leading: StackCircleAvatar(images: image, totalCount: c, memberNames: memberNames,),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CustomTextWidget(
                text: name,
                textStyle: TextStyle(
                  fontWeight: FontDetails.semiBoldFontWeight,
                  fontSize: FontDetails.fontSizeM,
                  color: context.color.textColor,
                ),
                maxLines: 1,
              ),
            ),
            SizedBox(width: 8.w),
            CustomTextWidget(
              text: time,
              textStyle: TextStyle(
                color: ColorsLight.mainTextColor,
                fontSize: FontDetails.fontSizeXS,
                fontWeight: FontDetails.mediumFontWeight,
              ),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CustomTextWidget(
                  text: message,
                  textStyle: TextStyle(
                    color: ColorsLight.mainTextColor,
                    fontSize: 13.sp,
                    fontWeight: unreadCount > 0
                        ? FontDetails.mediumFontWeight
                        : FontWeight.normal,
                  ),
                  maxLines: 1,
                ),
              ),
              SizedBox(width: 8.w),
              if (unreadCount > 0)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: ColorsDark.blueLight1,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: CustomTextWidget(
                    text: unreadCount.toString(),
                    textStyle: TextStyle(
                      color: ColorsDark.white,
                      fontSize: FontDetails.fontSizeXS,
                      fontWeight: FontDetails.boldFontWeight,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
