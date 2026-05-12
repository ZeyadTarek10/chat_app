import 'package:chat_app/config/routes/app_routes.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/features/main/presentation/manager/main_cubit/main_cubit.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AddButton extends StatelessWidget {
  const AddButton({
    super.key,
    required this.cubit,
  });

  final MainCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: PopupMenuButton<String>(
        icon: cubit.isMenuOpen
            ? Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.close, color: AppColors.white),
              )
            : Icon(Icons.add, color: AppColors.white, size: 28.sp),
        offset: const Offset(0, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        color: AppColors.white,
        elevation: 8,
        onOpened: () => cubit.toggleMenuState(true),
        onCanceled: () => cubit.toggleMenuState(false),
        onSelected: (value) {
          cubit.toggleMenuState(false);
          if (value == 'add_friend') {
            GoRouter.of(context).push(AppRoutes.addChats);
          } else if (value == 'create_group') {
            GoRouter.of(context).push(AppRoutes.addGroups);
          }
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          PopupMenuItem<String>(
            value: 'add_friend',
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            child: Row(
              children: [
                Icon(CupertinoIcons.person_add, color: AppColors.mainTextColor, size: 26),
                SizedBox(width: 16.w),
                CustomTextWidget(
                  text: 'add_friend'.tr(),
                  textStyle: TextStyle(
                    fontSize: FontDetails.fontSizeM,
                    fontWeight: FontDetails.semiBoldFontWeight,
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
          ),
          PopupMenuItem<String>(
            value: 'create_group',
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            child: Row(
              children: [
                Icon(CupertinoIcons.group, color: AppColors.mainTextColor, size: 26.sp),
                SizedBox(width: 16.w),
                CustomTextWidget(
                  text: 'create_group'.tr(),
                  textStyle: TextStyle(
                    fontSize: FontDetails.fontSizeM,
                    fontWeight: FontDetails.semiBoldFontWeight,
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}