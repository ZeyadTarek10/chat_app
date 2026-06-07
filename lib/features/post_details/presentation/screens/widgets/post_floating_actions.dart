import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/features/post_details/presentation/screens/widgets/post_floating_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostFloatingActions extends StatelessWidget {
  const PostFloatingActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CircleAvatar(
          radius: 28.r,
          backgroundImage: const CachedNetworkImageProvider(
              'https://i.pinimg.com/736x/c1/97/44/c19744d6034277dc442ef3a4ae5ce297.jpg'),
        ),
        Row(
          children: [
            PostFloatingButton(
                icon: Icons.favorite_border,
                iconColor: context.color.textColor),
            SizedBox(width: 10.w),
            PostFloatingButton(
                icon: Icons.send_outlined, iconColor: context.color.textColor),
          ],
        ),
      ],
    );
  }
}
