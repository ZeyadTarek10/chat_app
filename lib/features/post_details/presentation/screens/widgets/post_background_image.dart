import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostBackgroundImage extends StatelessWidget {
  const PostBackgroundImage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 420.h, 
      child: CachedNetworkImage(
        imageUrl: 'https://pic.i7lm.com/wp-content/uploads/2019/05/pexels-photo-338515.jpeg',
        fit: BoxFit.cover,
        placeholder: (context, url) => SizedBox(
          height: 200.h,
          child: const Center(
            child: CircularProgressIndicator(color: ColorsLight.mainTextColor,),
          ),
        ),
        errorWidget: (context, url, error) => SizedBox(
          height: 200.h,
          child: const Icon(Icons.error, size: 50),
        ),
      ),
    );
  }
}