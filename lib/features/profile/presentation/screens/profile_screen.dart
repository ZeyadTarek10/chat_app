import 'package:chat_app/config/app/upload_image/presentation/manager/cubit/upload_image_cubit.dart';
import 'package:chat_app/config/routes/app_routes.dart';
import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/enum/alert_enum.dart';
import 'package:chat_app/core/services/alert_service.dart';
import 'package:chat_app/core/services/animate_do.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/features/profile/presentation/manager/cubit/profile_cubit.dart';
import 'package:chat_app/features/profile/presentation/screens/widgets/edit_profile_button.dart';
import 'package:chat_app/features/profile/presentation/screens/widgets/edit_profile_photo.dart';
import 'package:chat_app/features/profile/presentation/screens/widgets/loading_profile.dart';
import 'package:chat_app/features/profile/presentation/screens/widgets/logout_profile.dart';
import 'package:chat_app/features/profile/presentation/screens/widgets/profile_data.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UploadImageCubit, UploadImageState>(
      listener: (context, uploadState) {
        if (uploadState is UploadImageStateSuccess) {
          final newUrl = uploadState.uploadImageEntities.photo;
          if (newUrl != null) {
            BlocProvider.of<ProfileCubit>(context).updateProfilePicture(newUrl);
          }
          AlertService().showAlert(
              context: context,
              subtitle: "the_image_has_been_uploaded_successfully".tr(),
              status: AlertStatus.success);
        } else if (uploadState is UploadImageStateError) {
          AlertService().showAlert(
              context: context,
              subtitle: uploadState.error,
              status: AlertStatus.error);
        }
      },
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is LogoutSuccess) {
            GoRouter.of(context).pushReplacement(AppRoutes.login);
            AlertService().showAlert(
              context: context,
              subtitle: "loged_out_successfuly".tr(),
              status: AlertStatus.success);
          } else if (state is ProfileError) {
            AlertService().showAlert(
                context: context,
                subtitle: state.message,
                status: AlertStatus.error);
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const LoadingProfile();
          }
          final user = BlocProvider.of<ProfileCubit>(context).currentUser;
          if (user == null) {
            return Center(
                child: CustomTextWidget(text: "user_data_not_found".tr()));
          }
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  CustomFadeInDown(
                      duration: 800, child: EditProfilePhoto(user: user)),
                  SizedBox(height: 30.h),
                  CustomFadeInDown(
                    duration: 400,
                    child: CustomTextWidget(
                      text: user.name,
                      textStyle: TextStyle(
                          color: context.color.textColor,
                          fontSize: FontDetails.fontSizeL,
                          fontWeight: FontDetails.boldFontWeight),
                    ),
                  ),
                  SizedBox(height: 15.h),
                  CustomFadeInRight(
                    duration: 400,
                    child: ProfileData(
                        title: 'phone'.tr(),
                        value:
                            '\u202A(${user.countryCode}) ${user.phone}\u202C'),
                  ),
                  CustomFadeInRight(
                      duration: 400,
                      child: ProfileData(
                          title: 'gender'.tr(), value: user.gender)),
                  CustomFadeInRight(
                      duration: 400,
                      child: ProfileData(
                          title: 'birthday'.tr(), value: user.birthday)),
                  CustomFadeInRight(
                      duration: 400,
                      child:
                          ProfileData(title: 'email'.tr(), value: user.email)),
                  SizedBox(height: 10.h),
                  CustomFadeInUp(
                      duration: 400, child: EditProfileButton(user: user)),
                  SizedBox(height: 12.h),
                  const CustomFadeInUp(duration: 800, child: LogOutProfile()),
                  SizedBox(height: 12.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
