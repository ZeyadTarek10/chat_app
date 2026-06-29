import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/features/products/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageProductCard extends StatelessWidget {
  const ImageProductCard({
    super.key,
    required this.productEntity,
  });

  final ProductEntity productEntity;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0.r),
      child: Container(
        color: ColorsLight.mainTextColor.withOpacity(0.2),
        child: CachedNetworkImage(
          imageUrl: productEntity.productImage,
          height: 200.h,
          width: double.infinity,
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
      ),
    );
  }
}
