import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/app_images.dart';
import 'package:chat_app/features/main/presentation/manager/main_cubit/main_cubit.dart';
import 'package:chat_app/features/main/presentation/screens/widget/add_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddAppBar extends StatelessWidget {
  const AddAppBar({
    super.key,
    required this.cubit,
  });

  final MainCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.h,
      decoration: BoxDecoration(
        color: context.color.mainColor,
        image: DecorationImage(
          image: AssetImage(AppImages.bG),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(bottom: 10.h),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: SizedBox(
                  width: 104.w,
                  child: Image.asset(
                    AppImages.appLogoImgHomeDark,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  cubit.toggleSearch();
                },
                icon: const Icon(
                  CupertinoIcons.search,
                  color: ColorsLight.white,
                  size: 26,
                ),
              ),
              SizedBox(width: 8.w),
              AddButton(cubit: cubit),
              SizedBox(width: 8.w),
            ],
          ),
        ),
      ),
    );
  }
}
