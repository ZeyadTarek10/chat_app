import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBarGroupsMessages extends StatelessWidget {
  const AppBarGroupsMessages({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.r),
          bottomRight: Radius.circular(20.r),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 50.w,
            height: 40.h,
            child: Stack(
              children: [
                Positioned(
                  right: 15,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border:
                          Border.all(color: AppColors.white, width: 2.w),
                    ),
                    child: CircleAvatar(
                      radius: 18.r,
                      backgroundImage: const NetworkImage(
                          "https://img.freepik.com/free-photo/lifestyle-beauty-fashion-people-emotions-concept-young-asian-female-office-manager-ceo-with-pleased-expression-standing-white-background-smiling-with-arms-crossed-chest_1258-59329.jpg"),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border:
                          Border.all(color: AppColors.white, width: 2.w),
                    ),
                    child: CircleAvatar(
                      radius: 18.r,
                      backgroundImage: const NetworkImage(
                          "https://upload.wikimedia.org/wikipedia/commons/thumb/2/23/Jimmy_Wales_Fundraiser_Appeal_edit.jpg/250px-Jimmy_Wales_Fundraiser_Appeal_edit.jpg"),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextWidget(
                  text: '🎮 Game 🎮',
                  textStyle: TextStyle(
                      color: AppColors.black,
                      fontWeight: FontDetails.boldFontWeight,
                      fontSize: FontDetails.fontSizeM),
                ),
                Text(
                  '3 members',
                  style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: FontDetails.fontSizeXS),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.videocam_outlined,
                color: AppColors.black, size: 26.sp),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.call_outlined,
                color: AppColors.black, size: 22.sp),
          ),
        ],
      ),
    );
  }
}
