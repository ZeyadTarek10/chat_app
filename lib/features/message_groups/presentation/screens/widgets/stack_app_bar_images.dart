import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/features/groups/domain/entities/groups_entity.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StackAppBarImages extends StatelessWidget {
  const StackAppBarImages({
    super.key,
    required this.group,
  });

  final GroupsEntity group;

  @override
  Widget build(BuildContext context) {
    final bool hasFirstImage =
        group.image.isNotEmpty && group.image[0].isNotEmpty;
    final bool hasFirstName =
        group.memberNames.isNotEmpty && group.memberNames[0].isNotEmpty;

    final bool hasSecondImage =
        group.image.length > 1 && group.image[1].isNotEmpty;
    final bool hasSecondName =
        group.memberNames.length > 1 && group.memberNames[1].isNotEmpty;

    return SizedBox(
      width: 53.w,
      height: 40.h,
      child: Stack(
        children: [
          Positioned(
            right: 15,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: ColorsDark.white, width: 2.w),
              ),
              child: CircleAvatar(
                backgroundColor: context.color.circleAvatarBackgroundColor,
                radius: 18.r,
                child: hasFirstImage
                    ? ClipOval( 
                        child: CachedNetworkImage(
                          imageUrl: group.image.first,
                          fit: BoxFit.cover,
                          width: 36.r, 
                          height: 36.r, 
                          placeholder: (context, url) => Center(
                            child: CustomTextWidget(
                              text: group.memberNames.first[0].toUpperCase(),
                              textStyle: TextStyle(
                                color: ColorsDark.white,
                                fontSize: 16.sp, 
                                fontWeight: FontDetails.boldFontWeight,
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Center(
                            child: CustomTextWidget(
                              text: group.memberNames.first[0].toUpperCase(),
                              textStyle: TextStyle(
                                color: ColorsDark.white,
                                fontSize: 16.sp,
                                fontWeight: FontDetails.boldFontWeight,
                              ),
                            ),
                          ),
                        ),
                      )
                    : (!hasFirstImage && hasFirstName)
                        ? CustomTextWidget(
                            text: group.memberNames.first[0].toUpperCase(),
                            textStyle: TextStyle(
                                color: ColorsDark.white, fontSize: 16.sp),
                          )
                        : null,
              ),
            ),
          ),
          
          Positioned(
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: ColorsDark.white, width: 2.w),
              ),
              child: CircleAvatar(
                backgroundColor: context.color.circleAvatarBackgroundColor,
                radius: 18.r,
                child: hasSecondImage
                    ? ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: group.image[1],
                          fit: BoxFit.cover,
                          width: 36.r,
                          height: 36.r,
                          placeholder: (context, url) => Center(
                            child: CustomTextWidget(
                              text: group.memberNames[1][0].toUpperCase(),
                              textStyle: TextStyle(
                                color: ColorsDark.white,
                                fontSize: 16.sp,
                                fontWeight: FontDetails.boldFontWeight,
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Center(
                            child: CustomTextWidget(
                              text: group.memberNames[1][0].toUpperCase(),
                              textStyle: TextStyle(
                                color: ColorsDark.white,
                                fontSize: 16.sp,
                                fontWeight: FontDetails.boldFontWeight,
                              ),
                            ),
                          ),
                        ),
                      )
                    : (!hasSecondImage && hasSecondName)
                        ? CustomTextWidget(
                            text: group.memberNames[1][0].toUpperCase(),
                            textStyle: TextStyle(
                                color: ColorsDark.white, fontSize: 16.sp),
                          )
                        : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}