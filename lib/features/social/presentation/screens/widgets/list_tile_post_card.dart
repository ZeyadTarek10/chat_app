import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/utils/app_colors.dart';
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
        backgroundColor: ColorsDark.blueDark,
        radius: 22.sp,
        child: CircleAvatar(
          radius: 20.sp,
          backgroundImage: const CachedNetworkImageProvider(
              'https://i.pinimg.com/736x/58/77/e5/5877e5d5c7e1ec3d16d68212a9c5e376.jpg'),
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
        icon: const Icon(
          Icons.more_horiz,
          color: ColorsLight.mainTextColor,
        ),
        onPressed: () {},
      ),
    );
  }
}
