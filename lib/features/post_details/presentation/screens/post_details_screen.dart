import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/features/post_details/presentation/screens/widgets/comment_input_bottom_bar.dart';
import 'package:chat_app/features/post_details/presentation/screens/widgets/post_background_image.dart';
import 'package:chat_app/features/post_details/presentation/screens/widgets/post_details_content.dart';
import 'package:chat_app/features/post_details/presentation/screens/widgets/post_floating_actions.dart';
import 'package:chat_app/features/post_details/presentation/screens/widgets/post_top_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostDetailsScreen extends StatelessWidget {
  const PostDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.color.mainColor,
      bottomNavigationBar: const CommentInputBottomBar(), 
      body: SingleChildScrollView(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            const PostBackgroundImage(),

            const PostTopActions(),

            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 380.h), 
              padding: EdgeInsets.only(top: 50.h, left: 20.w, right: 20.w, bottom: 20.h),
              decoration: BoxDecoration(
                color: context.color.mainColor,
              ),
              child: const PostDetailsContent(),
            ),

            Positioned(
              top: 350.h, 
              left: 20.w,
              right: 20.w,
              child: const PostFloatingActions(),
            ),
          ],
        ),
      ),
    );
  }
}