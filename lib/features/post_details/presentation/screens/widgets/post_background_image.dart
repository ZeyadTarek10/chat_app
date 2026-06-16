import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostBackgroundImage extends StatelessWidget {
  final String imageUrl;
  const PostBackgroundImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 420.h,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        placeholder: (context, url) => SizedBox(
          height: 200.h,
          child: const Center(
            child: CircularProgressIndicator(
              color: ColorsLight.mainTextColor,
            ),
          ),
        ),
        errorWidget: (context, url, error) => SizedBox(
          height: 200.h,
          child: const Icon(
            Icons.photo_size_select_actual_outlined,
            size: 50,
            color: ColorsLight.mainTextColor,
          ),
        ),
      ),
    );
  }
}
