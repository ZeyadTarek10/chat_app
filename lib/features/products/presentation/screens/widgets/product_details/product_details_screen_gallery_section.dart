import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/features/products/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductGallerySection extends StatelessWidget {
  final ProductEntity productEntity;
  const ProductGallerySection({super.key, required this.productEntity});

  @override
  Widget build(BuildContext context) {
    if (productEntity.productGallaryImage.isEmpty) {
      return const SizedBox.shrink();
    }
    return SizedBox(
      height: 75.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: productEntity.productGallaryImage.length,
        separatorBuilder: (context, index) => SizedBox(width: 15.w),
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(15.r),
            child: Container(
              width: 75.w,
              height: 75.h,
              color: ColorsLight.mainTextColor.withOpacity(0.2),
              child: CachedNetworkImage(
                imageUrl: productEntity.productGallaryImage[index],
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
                errorWidget: (context, url, error) => SizedBox(
                  height: 200.h,
                  child: const Icon(
                    Icons.photo_size_select_actual_outlined,
                    size: 30,
                    color: ColorsLight.mainTextColor,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
