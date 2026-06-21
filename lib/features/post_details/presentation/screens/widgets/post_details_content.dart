import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/date_helper.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/features/post_details/presentation/manager/comments_cubit/comments_cubit.dart';
import 'package:chat_app/features/post_details/presentation/screens/widgets/comment_item.dart';
import 'package:chat_app/features/social/domain/entities/social_entity.dart';
import 'package:chat_app/shared_widgets/custom_loading.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostDetailsContent extends StatelessWidget {
  final SocialEntity post;
  const PostDetailsContent({super.key, required this.post});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextWidget(
          text: post.userName,
          textStyle: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontDetails.boldFontWeight,
            color: context.color.textColor,
          ),
        ),
        SizedBox(height: 15.h),
        RichText(
          text: TextSpan(
            style: TextStyle(fontSize: FontDetails.fontSizeS, height: 1.5.h),
            children: DateHelper.buildTextSpans(post.postText, context),
          ),
        ),
        SizedBox(height: 10.h),
        CustomTextWidget(
          text:
              "${'posted'.tr()} ${DateHelper.formatTimeAgo(post.time)}",
          textStyle:
              TextStyle(fontSize: 12.sp, color: ColorsLight.mainTextColor),
        ),
        SizedBox(height: 25.h),
        BlocBuilder<CommentsCubit, CommentsState>(
          builder: (context, state) {
            if (state is CommentsLoading) {
              return const Center(child: CustomLoading());
            } else if (state is CommentsLoaded) {
              if (state.comments.isEmpty) {
                return Center(
                    child: CustomTextWidget(
                  text: "no_comments_be_the_first_to_comment".tr(),
                  textStyle: TextStyle(color: context.color.textColor),
                ));
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: state.comments.length,
                itemBuilder: (context, index) {
                  final comment = state.comments[index];
                  return CommentItem(
                    userName: comment.userName,
                    comment: comment.commentText,
                    imageUrl: comment.userImage,
                  );
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
