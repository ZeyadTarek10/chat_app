import 'package:chat_app/core/utils/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchItemAppBar extends StatelessWidget {
  const SearchItemAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      decoration: BoxDecoration(
        color: ColorsLight.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: TextField(
        autofocus: true, 
        decoration: InputDecoration(
          hintText: 'search'.tr(),
          hintStyle: const TextStyle(color: ColorsLight.hintColor),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          prefixIcon: Icon(CupertinoIcons.search, color: ColorsLight.mainTextColor, size: 20.sp),
        ),
        onChanged: (value) {
        },
      ),
    );
  }
}