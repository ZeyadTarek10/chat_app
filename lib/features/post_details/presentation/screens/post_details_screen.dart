import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/features/post_details/presentation/screens/widgets/comment_input_bottom_bar.dart';
import 'package:chat_app/features/post_details/presentation/screens/widgets/post_background_image.dart';
import 'package:chat_app/features/post_details/presentation/screens/widgets/post_details_content.dart';
import 'package:chat_app/features/post_details/presentation/screens/widgets/post_floating_actions.dart';
import 'package:chat_app/features/post_details/presentation/screens/widgets/post_top_actions.dart';
import 'package:chat_app/features/social/domain/entities/social_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostDetailsScreen extends StatelessWidget {
  final SocialEntity post;
  const PostDetailsScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    bool hasImage = post.postImage != null && post.postImage!.isNotEmpty;

    return Scaffold(
      backgroundColor: context.color.mainColor,
      bottomNavigationBar: CommentInputBottomBar(
        post: post,
      ),
      body: SingleChildScrollView(
        child: hasImage
            ? Stack(
                clipBehavior: Clip.none,
                children: [
                  PostBackgroundImage(imageUrl: post.postImage!),
                  PostTopActions(post: post),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 380.h),
                    padding: EdgeInsets.only(
                        top: 50.h, left: 20.w, right: 20.w, bottom: 20.h),
                    decoration: BoxDecoration(color: context.color.mainColor),
                    child: PostDetailsContent(post: post),
                  ),
                  Positioned(
                    top: 350.h,
                    left: 20.w,
                    right: 20.w,
                    child: PostFloatingActions(post: post),
                  ),
                ],
              )
            : SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PostTopActions(post: post),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 10.h),
                      child: PostFloatingActions(post: post),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: PostDetailsContent(post: post),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
