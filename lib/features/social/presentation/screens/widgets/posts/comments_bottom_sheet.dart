import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/features/post_details/presentation/manager/comments_cubit/comments_cubit.dart';
import 'package:chat_app/features/post_details/presentation/screens/widgets/comment_input_bottom_bar.dart';
import 'package:chat_app/features/post_details/presentation/screens/widgets/comment_item.dart';
import 'package:chat_app/features/social/domain/entities/social_entity.dart';
import 'package:chat_app/shared_widgets/custom_loading.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommentsBottomSheet extends StatelessWidget {
  final SocialEntity post;
  const CommentsBottomSheet({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.r),
              child: CustomTextWidget(
                text: "comments".tr(),
                textStyle: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontDetails.boldFontWeight,
                  color: context.color.textColor,
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<CommentsCubit, CommentsState>(
                builder: (context, state) {
                  if (state is CommentsLoading) {
                    return const Center(
                        child: CustomLoading());
                  } else if (state is CommentsError) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.all(20.w),
                        child: CustomTextWidget(
                          text: state.message,
                          textAlign: TextAlign.center,
                          textStyle: const TextStyle(color: ColorsLight.error),
                        ),
                      ),
                    );
                  } else if (state is CommentsLoaded) {
                    if (state.comments.isEmpty) {
                      return Center(
                        child: CustomTextWidget(
                          text: "no_comments_be_the_first_to_comment".tr(),
                          textStyle: TextStyle(color: context.color.textColor),
                        ),
                      );
                    }
                    return ListView.builder(
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
            ),
            CommentInputBottomBar(post: post),
          ],
        ),
      ),
    );
  }
}
