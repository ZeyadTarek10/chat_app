import 'package:cached_network_image/cached_network_image.dart';
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
          backgroundColor: context.color.circleAvatarBackgroundColor,
          child: (user.profilePicUrl != null && user.profilePicUrl!.isNotEmpty)
              ? ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: user.profilePicUrl!,
                    width: 52.r,
                    height: 52.r,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Center(
                      child: CustomTextWidget(
                        text: user.name.isNotEmpty
                            ? user.name[0].toUpperCase()
                            : '',
                        textStyle: TextStyle(
                            color: ColorsLight.white, fontSize: 20.sp),
                      ),
                    ),
                    errorWidget: (context, url, error) => Center(
                      child: CustomTextWidget(
                        text: user.name.isNotEmpty
                            ? user.name[0].toUpperCase()
                            : '',
                        textStyle: TextStyle(
                            color: ColorsLight.white, fontSize: 20.sp),
                      ),
                    ),
                  ),
                )
              : CustomTextWidget(
                  text: user.name.isNotEmpty ? user.name[0].toUpperCase() : '',
                  textStyle:
                      TextStyle(color: ColorsLight.white, fontSize: 20.sp),
                ),
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
                text: '\u202A(${user.countryCode}) ${user.phone}\u202C',
                textStyle: TextStyle(
                    color: ColorsLight.mainTextColor, fontSize: 13.sp),
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
                color: ColorsDark.blueLight1, size: FontDetails.fontSizeL),
          ),
        )
      ],
    );
  }
}
