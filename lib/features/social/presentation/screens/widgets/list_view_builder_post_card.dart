import 'package:chat_app/features/social/presentation/screens/widgets/post_card.dart';
import 'package:flutter/material.dart';

class ListViewBuilderPostCard extends StatelessWidget {
  const ListViewBuilderPostCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return const PostCard();
        },
        childCount: 5, 
      ),
    );
  }
}
