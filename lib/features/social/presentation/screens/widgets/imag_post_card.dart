import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImagPostCard extends StatelessWidget {
  const ImagPostCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0.r),
      child: CachedNetworkImage(
        imageUrl: 'https://i.pinimg.com/736x/c1/97/44/c19744d6034277dc442ef3a4ae5ce297.jpg',
        height: 200.h,
        width: double.infinity,
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