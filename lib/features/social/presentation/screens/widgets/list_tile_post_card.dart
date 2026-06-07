import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListTilePostCard extends StatelessWidget {
  const ListTilePostCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: context.color.circleAvatarBackgroundColor,
        radius: 22.r,
        child: CircleAvatar(
          radius: 20.r,
          backgroundImage: const CachedNetworkImageProvider(
              'https://i.pinimg.com/736x/c1/97/44/c19744d6034277dc442ef3a4ae5ce297.jpg'),
        ),
      ),
      title: CustomTextWidget(
          text: 'Dipprokash Sardar',
          textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: context.color.textColor)),
      subtitle: CustomTextWidget(
          text: 'Kolkata',
          textStyle: TextStyle(color: context.color.textColor)),
      trailing: IconButton(
        icon: Icon(
          Icons.more_horiz,
          color: context.color.textColor,
        ),
        onPressed: () {},
      ),
    );
  }
}
