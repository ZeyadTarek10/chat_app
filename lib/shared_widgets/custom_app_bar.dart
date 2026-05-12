import 'package:flutter/material.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

AppBar customAppBar(BuildContext context){
return AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.googlebtnColor,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_new,
                  color: AppColors.black, size: 18.sp),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      );
}