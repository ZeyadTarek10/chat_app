import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/core/widgets/user_dialogs.dart';
import 'package:chat_app/features/profile/presentation/manager/cubit/profile_cubit.dart';
import 'package:chat_app/shared_widgets/buttons/custom_icon_btn.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogOutProfile extends StatelessWidget {
  const LogOutProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomIconBtn(
      onPressed: () {
        CustomDialog.twoButtonDialog(
            context: context,
            textBody: 'log_out_from_app'.tr(),
            textButton1: 'yes'.tr(),
            textButton2: 'no'.tr(),
            onPressed: () {
              context.read<ProfileCubit>().logout();
            },
            isLoading: false
        );
      },
      text: 'logout'.tr(),
      icon: Icon(Icons.logout, size: FontDetails.fontSizeL),
      textStyle: TextStyle(
          fontSize: FontDetails.fontSizeS,
          fontWeight: FontDetails.mediumFontWeight),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xffFEECEB),
        foregroundColor: const Color(0xffF6695E),
        minimumSize: Size(250.w, 45.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        elevation: 0,
      ),
    );
  }
}
