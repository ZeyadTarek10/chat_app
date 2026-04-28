import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/features/profile/presentation/manager/cubit/profile_cubit.dart';
import 'package:chat_app/features/profile/presentation/screens/widgets/edit_profile_bottom_sheet.dart';
import 'package:chat_app/features/sign_up/domain/entities/user_entity.dart';
import 'package:chat_app/shared_widgets/buttons/custom_icon_btn.dart';
import 'package:chat_app/shared_widgets/custom_buttom_sheet.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfileButton extends StatelessWidget {
  const EditProfileButton({
    super.key,
    required this.user,
  });

  final UserEntity? user;

  @override
  Widget build(BuildContext context) {
    return CustomIconBtn(
      onPressed: () {
        CustomBottomSheet.showModalBottomSheetContainer(
          context: context,
          widget: BlocProvider.value(
            value: BlocProvider.of<ProfileCubit>(context),
            child: CreateDonorBottomSheet(currentUser: user!),
          ),
        );
      },
      text: 'edit_profile'.tr(),
      icon: Icon(Icons.edit_outlined, size: 24.sp),
      textStyle: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontDetails.mediumFontWeight),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.backgroundColorbuttonblue1,
        foregroundColor: AppColors.white,
        minimumSize: Size(double.infinity, 56.h),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r)),
        elevation: 0,
      ),
    );
  }
}

