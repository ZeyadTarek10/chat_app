import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: context.color.navBarbg,
                  borderRadius: BorderRadius.circular(20.r),
                  image: const DecorationImage(
                    image: CachedNetworkImageProvider(
                        'https://i.pinimg.com/1200x/dd/f7/d5/ddf7d51ef1814d4be2800df43d8f2e45.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 15.h,
                right: 15.w,
                child: const Icon(
                  Icons.favorite_border,
                  color: ColorsLight.hintColor,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h),
        CustomTextWidget(
          text: "Nike Sportswear Club\nFleece",
          textStyle: TextStyle(
            fontWeight: FontDetails.mediumFontWeight,
            height: 1.2.h,
            fontSize: FontDetails.fontSizeXS,
            color: context.color.textColor!.withOpacity(0.8),
            overflow: TextOverflow.ellipsis,
          ),
          maxLines: 2,
        ),
        SizedBox(height: 5.h),
        CustomTextWidget(
          text: "\$99",
          textStyle: TextStyle(
            fontWeight: FontDetails.boldFontWeight,
            color: context.color.textColor,
            fontSize: FontDetails.fontSizeM,
          ),
        ),
      ],
    );
  }
}
