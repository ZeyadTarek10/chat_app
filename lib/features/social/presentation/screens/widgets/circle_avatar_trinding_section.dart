import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircleAvatarTrindingSection extends StatelessWidget {
  const CircleAvatarTrindingSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.0.w),
      child: CircleAvatar(
        radius: 37.r,
        backgroundColor: ColorsDark.blueDark,
        child: CircleAvatar(
          radius: 35.r,
          backgroundImage: const CachedNetworkImageProvider(
              'https://i.pinimg.com/736x/79/64/c5/7964c5a700f0342abbb946e883b2a4f2.jpg'),
        ),
      ),
    );
  }
}
