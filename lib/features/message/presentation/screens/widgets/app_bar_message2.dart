import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/features/sign_up/data/models/user_model.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBarMessage2 extends StatelessWidget {
  final UserModel userModel;
  // final String roomId;
  const AppBarMessage2({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    return Container(
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
            decoration: BoxDecoration(
              color: AppColors.white,
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 22.r,
                  backgroundColor: Colors.grey.shade300,
                  backgroundImage: (userModel.profilePicUrl != null && userModel.profilePicUrl!.isNotEmpty) ? NetworkImage(userModel.profilePicUrl!) : null,
        child: (userModel.profilePicUrl == null || userModel.profilePicUrl!.isEmpty)
            ? CustomTextWidget(
               text: userModel.name.isNotEmpty ? userModel.name[0].toUpperCase() : '',
                textStyle: TextStyle(color: AppColors.black, fontSize: 20.sp),
              )
            : null,          
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextWidget(
                        text: userModel.name,
                        textStyle: TextStyle(
                            color: AppColors.black,
                            fontWeight: FontDetails.boldFontWeight,
                            fontSize: 16.sp),
                      ),
                      CustomTextWidget(
                        text: '(${userModel.countryCode})${userModel.phone}',
                        textStyle: TextStyle(
                            color: Colors.grey.shade600, fontSize: FontDetails.fontSizeXS),
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
                      color:  AppColors.black, size: 22.sp),
                ),
              ],
            ),
          );
  }
}