import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/enum/alert_enum.dart';
import 'package:chat_app/core/services/alert_service.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/features/post_details/presentation/manager/comments_cubit/comments_cubit.dart';
import 'package:chat_app/features/profile/presentation/manager/cubit/profile_cubit.dart';
import 'package:chat_app/features/social/domain/entities/social_entity.dart';
import 'package:chat_app/shared_widgets/buttons/custom_text_btn.dart';
import 'package:chat_app/shared_widgets/custom_loading.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:chat_app/shared_widgets/custom_text_form_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommentInputBottomBar extends StatelessWidget {
  final SocialEntity post;
  const CommentInputBottomBar({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final commentsCubit = context.read<CommentsCubit>();

    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final currentUser = context.read<ProfileCubit>().currentUser;

        if (currentUser == null) {
          return Container(
            color: context.color.mainColor,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: const Center(
                  child: CustomLoading(),
                ),
              ),
            ),
          );
        }

        return Container(
          color: context.color.mainColor,
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 21.5.r,
                        child: CircleAvatar(
                          radius: 20.r,
                          backgroundColor:
                              context.color.circleAvatarBackgroundColor,
                          child: (currentUser.profilePicUrl != null &&
                                  currentUser.profilePicUrl!.isNotEmpty)
                              ? ClipOval(
                                  child: CachedNetworkImage(
                                    imageUrl: currentUser.profilePicUrl!,
                                    width: 52.r,
                                    height: 52.r,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Center(
                                      child: CustomTextWidget(
                                        text: currentUser.name.isNotEmpty
                                            ? currentUser.name[0].toUpperCase()
                                            : '',
                                        textStyle: TextStyle(
                                            color: ColorsLight.white,
                                            fontSize: 20.sp),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Center(
                                      child: CustomTextWidget(
                                        text: currentUser.name.isNotEmpty
                                            ? currentUser.name[0].toUpperCase()
                                            : '',
                                        textStyle: TextStyle(
                                            color: ColorsLight.white,
                                            fontSize: 20.sp),
                                      ),
                                    ),
                                  ),
                                )
                              : CustomTextWidget(
                                  text: currentUser.name.isNotEmpty
                                      ? currentUser.name[0].toUpperCase()
                                      : '',
                                  textStyle: TextStyle(
                                      color: ColorsLight.white,
                                      fontSize: 20.sp),
                                ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: CustomTextFormFieldWidget(
                          controller: commentsCubit.commentController,
                          withBorders: true,
                          hint: "leave_a_comment".tr(),
                          hintColor: ColorsLight.mainTextColor,
                          textColor: ColorsLight.hintColor,
                          suffixIcon: Padding(
                            padding: EdgeInsets.only(right: 15.w),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomTextButtonWidget(
                                  text: "post".tr(),
                                  textStyle: TextStyle(
                                      color: ColorsDark.blueLight2,
                                      fontWeight: FontDetails.boldFontWeight,
                                      fontSize: FontDetails.fontSizeS),
                                  onPressed: () {
                                    final cubit = context.read<CommentsCubit>();

                                    if (cubit.commentController.text
                                        .trim()
                                        .isEmpty) {
                                      AlertService().showAlert(
                                          context: context,
                                          subtitle:
                                              'write_a_comment_first'.tr(),
                                          status: AlertStatus.error);
                                      return;
                                    }

                                    cubit.addComment(
                                        cubit.commentController.text,
                                        post,
                                        currentUser);
                                  },
                                ),
                              ],
                            ),
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "leave_a_comment".tr();
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
