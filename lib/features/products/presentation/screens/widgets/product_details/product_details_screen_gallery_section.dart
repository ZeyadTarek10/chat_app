import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductGallerySection extends StatelessWidget {
  const ProductGallerySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(4, (index) {
        return Container(
          width: 75.w,
          height: 75.h,
          decoration: BoxDecoration(
            color: ColorsLight.mainTextColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(15.r),
            image: const DecorationImage(
                      image: CachedNetworkImageProvider(
                          'https://i.pinimg.com/1200x/dd/f7/d5/ddf7d51ef1814d4be2800df43d8f2e45.jpg'))
          ),
        );
      }),
    );
  }
}