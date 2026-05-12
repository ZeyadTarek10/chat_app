import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/features/groups/domain/entities/groups_entity.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StackAppBarImages extends StatelessWidget {
  const StackAppBarImages({
    super.key,
    required this.group,
  });

  final GroupsEntity group;

  @override
  Widget build(BuildContext context) {
    final bool hasFirstImage = group.image.isNotEmpty && group.image[0].isNotEmpty;
    final bool hasFirstName = group.memberNames.isNotEmpty && group.memberNames[0].isNotEmpty;

    final bool hasSecondImage = group.image.length > 1 && group.image[1].isNotEmpty;
    final bool hasSecondName = group.memberNames.length > 1 && group.memberNames[1].isNotEmpty;

    return SizedBox(
      width: 50.w,
      height: 40.h,
      child: Stack(
        children: [
          Positioned(
            right: 15,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.white, width: 2.w),
              ),
              child: CircleAvatar(
                backgroundColor: AppColors.backgroundColorCircleButtonblue3,
                radius: 18.r,
                backgroundImage: hasFirstImage ? NetworkImage(group.image.first) : null,
                child: (!hasFirstImage && hasFirstName)
                    ? CustomTextWidget(
                        text: group.memberNames.first[0].toUpperCase(), 
                        textStyle: TextStyle(
                            color: AppColors.white, fontSize: 20.sp),
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
                border: Border.all(color: AppColors.white, width: 2.w),
              ),
              child: CircleAvatar(
                backgroundColor: AppColors.backgroundColorCircleButtonblue3,
                radius: 18.r,
                backgroundImage: hasSecondImage ? NetworkImage(group.image[1]) : null,
                child: (!hasSecondImage && hasSecondName)
                    ? CustomTextWidget(
                        text: group.memberNames[1][0].toUpperCase(), 
                        textStyle: TextStyle(
                            color: AppColors.white, fontSize: 20.sp),
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