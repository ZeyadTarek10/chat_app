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
      decoration: BoxDecoration(
        color: context.color.mainColor,
        image: const DecorationImage(
          image: AssetImage(AppImages.bG),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 4.h, bottom: 12.h),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 12.w, right: 12.w),
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
                icon: Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: const Icon(
                    CupertinoIcons.search,
                    color: ColorsLight.white,
                    size: 26,
                  ),
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
