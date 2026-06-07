import 'package:chat_app/config/routes/app_routes.dart';
import 'package:chat_app/features/social/presentation/screens/widgets/post_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ListViewBuilderPostCard extends StatelessWidget {
  const ListViewBuilderPostCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return GestureDetector(
              onTap: () {
                GoRouter.of(context).push(AppRoutes.postDetails);
              },
              child: const PostCard());
        },
        childCount: 5,
      ),
    );
  }
}
