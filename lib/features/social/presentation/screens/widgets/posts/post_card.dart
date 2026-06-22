import 'package:chat_app/core/utils/date_helper.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/features/social/domain/entities/social_entity.dart';
import 'package:chat_app/features/social/presentation/screens/widgets/posts/action_post_card.dart';
import 'package:chat_app/features/social/presentation/screens/widgets/posts/imag_post_card.dart';
import 'package:chat_app/features/social/presentation/screens/widgets/posts/list_tile_post_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostCard extends StatelessWidget {
  final SocialEntity post;
  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTilePostCard(post: post),
          if (post.postText.isNotEmpty)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: RichText(
                text: TextSpan(
                  style:
                      TextStyle(fontSize: FontDetails.fontSizeS, height: 1.5),
                  children: DateHelper.buildTextSpans(post.postText, context),
                ),
              ),
            ),
          if (post.postImage != null && post.postImage!.isNotEmpty) ...[
            SizedBox(height: 8.h),
            ImagePostCard(imageUrl: post.postImage!),
          ],
          SizedBox(height: 12.h),
          ActionPostCard(post: post),
          Divider(height: 32.h, thickness: 1),
        ],
      ),
    );
  }
}
