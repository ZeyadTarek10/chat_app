import 'package:chat_app/config/routes/app_routes.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/features/profile/presentation/manager/cubit/profile_cubit.dart';
import 'package:chat_app/features/profile/presentation/screens/widgets/edit_profile_button.dart';
import 'package:chat_app/features/profile/presentation/screens/widgets/edit_profile_photo.dart';
import 'package:chat_app/features/profile/presentation/screens/widgets/loading_profile.dart';
import 'package:chat_app/features/profile/presentation/screens/widgets/logout_profile.dart';
import 'package:chat_app/features/profile/presentation/screens/widgets/profile_data.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:chat_app/shared_widgets/show_snack_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProfileCubit>(context).getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          GoRouter.of(context).pushReplacement(AppRoutes.login);
        } else if (state is ProfileError) {
          showSnackBar(context, text: state.message, color: AppColors.red);
        }
      },
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const LoadingProfile();
        }
        final user = BlocProvider.of<ProfileCubit>(context).currentUser;
        if (user == null) {
          return Center(child: CustomTextWidget(text: "user_data_not_found".tr()));
        }
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.w),
            child: Column(
              children: [
                SizedBox(
                  height: 30.h,
                ),
                EditProfilePhoto(user: user),
                SizedBox(height: 30.h),
                CustomTextWidget(
                  text: user.name,
                  textStyle: TextStyle(
                      fontSize: FontDetails.fontSizeL, fontWeight: FontDetails.boldFontWeight),
                ),
                SizedBox(height: 15.h),
                ProfileData(
                    title: 'phone'.tr(),
                    value: '(${user.countryCode}) ${user.phone}'),
                ProfileData(title: 'gender'.tr(), value: user.gender),
                ProfileData(title: 'birthday'.tr(), value: user.birthday),
                ProfileData(title: 'email'.tr(), value: user.email),
                SizedBox(height: 10.h),
                EditProfileButton(user: user),
                SizedBox(height: 12.h),
                const LogOutProfile(),
              ],
            ),
          ),
        );
      },
    );
  }
}

