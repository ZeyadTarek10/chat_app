import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/features/sign_up/domain/entities/user_entity.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserResultSearchItem extends StatelessWidget {
  const UserResultSearchItem(
      {super.key, required this.user, required this.onPressed});

  final UserEntity user;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 26.r,
          backgroundColor: Colors.grey[200],
          backgroundImage:
              (user.profilePicUrl != null && user.profilePicUrl!.isNotEmpty)
                  ? NetworkImage(user.profilePicUrl!)
                  : null,
          child: (user.profilePicUrl == null || user.profilePicUrl!.isEmpty)
              ? CustomTextWidget(
                  text: user.name.isNotEmpty ? user.name[0].toUpperCase() : '',
                  textStyle: TextStyle(color: ColorsLight.black, fontSize: 20.sp),
                )
              : null,
        ),
        SizedBox(width: 15.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextWidget(
                text: user.name,
                textStyle: TextStyle(
                  color: context.color.textColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4.h),
              CustomTextWidget(
                text: user.phone,
                textStyle:
                    TextStyle(color: ColorsLight.mainTextColor, fontSize: 13.sp),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: ColorsLight.white.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: onPressed,
            icon: Icon(CupertinoIcons.person_add,
                color: ColorsDark.blueLight1,
                size: FontDetails.fontSizeL),
          ),
        )
      ],
    );
  }
}
