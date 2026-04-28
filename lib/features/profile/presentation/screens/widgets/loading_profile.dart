import 'package:chat_app/shared_widgets/loading_simmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingProfile extends StatelessWidget {
  const LoadingProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.w),
            child: Column(
              children: [
                SizedBox(
                  height: 30.h,
                ),
                LoadingShimmer(height: 120.h, width: 120.w, borderRadius: 60),
                SizedBox(height: 30.h),
                LoadingShimmer(height: 23.h, width: 200.w),
                SizedBox(height: 15.h),
                LoadingShimmer(height: 20.h, width: double.infinity.w),
                SizedBox(height: 10.h),
                 LoadingShimmer(height: 20.h, width: double.infinity.w),
                SizedBox(height: 10.h),
                 LoadingShimmer(height: 20.h, width: double.infinity.w),
                SizedBox(height: 10.h),
                 LoadingShimmer(height: 20.h, width: double.infinity.w),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        );
  }
}