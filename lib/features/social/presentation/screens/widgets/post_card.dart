import 'package:chat_app/features/social/presentation/screens/widgets/action_post_card.dart';
import 'package:chat_app/features/social/presentation/screens/widgets/imag_post_card.dart';
import 'package:chat_app/features/social/presentation/screens/widgets/list_tile_post_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ListTilePostCard(),
          const ImagPostCard(),
          SizedBox(height: 12.h),
          const ActionPostCard(),
          Divider(height: 32.h, thickness: 1),
        ],
      ),
    );
  }
}
