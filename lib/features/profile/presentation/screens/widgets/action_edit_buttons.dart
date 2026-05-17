import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/features/profile/presentation/manager/cubit/profile_cubit.dart';
import 'package:chat_app/features/profile/presentation/screens/widgets/edit_profile_bottom_sheet.dart';
import 'package:chat_app/features/sign_up/data/models/user_model.dart';
import 'package:chat_app/shared_widgets/buttons/elevated_btn_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActionEditButtons extends StatelessWidget {
  const ActionEditButtons({
    super.key,
    required this.formKey,
    required this.widget,
    required this.nameController,
    required this.phoneController,
    required this.genderController,
    required this.birthdayController,
    required this.emailController,
  });

  final GlobalKey<FormState> formKey;
  final CreateBottomSheet widget;
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController genderController;
  final TextEditingController birthdayController;
  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomElevatedButtonWidget(
            style: ElevatedButton.styleFrom(
              textStyle: TextStyle(
                  color: ColorsDark.mainColor,
                  fontSize: FontDetails.fontSizeM,
                  fontWeight: FontDetails.semiBoldFontWeight),
              foregroundColor: ColorsDark.mainColor,
              backgroundColor: const Color.fromARGB(255, 168, 229, 249),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.r)),
              elevation: 0,
            ),
            onPressed: () => Navigator.pop(context),
            btnWidth: 0.w,
            btnHeight: 50.h,
            text: 'cancel'.tr(),
            textStyle: const TextStyle(color: ColorsDark.white),
          ),
        ),
        SizedBox(width: 20.w),
        Expanded(
          child: CustomElevatedButtonWidget(
            style: ElevatedButton.styleFrom(
              textStyle: TextStyle(
                  color: ColorsDark.white,
                  fontSize: FontDetails.fontSizeM,
                  fontWeight: FontDetails.semiBoldFontWeight),
              backgroundColor: ColorsDark.blueLight2,
              foregroundColor: ColorsDark.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.r)),
              elevation: 0,
            ),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                final updatedUser = UserModel(
                  uid: widget.currentUser.uid,
                  name: nameController.text,
                  phone: phoneController.text,
                  gender: genderController.text,
                  birthday: birthdayController.text,
                  email: emailController.text,
                  countryCode: widget.currentUser.countryCode,
                  profilePicUrl: widget.currentUser.profilePicUrl,
                );

                BlocProvider.of<ProfileCubit>(context)
                    .updateUserData(updatedUser);

                Navigator.pop(context);
              }
            },
            btnWidth: 0.w,
            btnHeight: 50.h,
            text: 'save'.tr(),
            textStyle: const TextStyle(color: ColorsDark.white),
          ),
        ),
      ],
    );
  }
}
