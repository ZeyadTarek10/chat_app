import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/features/products/domain/entities/product_entity.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductInfoSection extends StatelessWidget {
  final ProductEntity productEntity;
  const ProductInfoSection({super.key, required this.productEntity});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextWidget(
                text: productEntity.type ?? '',
                maxLines: 2,
                textStyle: TextStyle(
                  overflow: TextOverflow.ellipsis,
                    color: ColorsLight.mainTextColor,
                    fontWeight: FontDetails.regularFontWeight,
                    fontSize: FontDetails.fontSizeXS),
              ),
              SizedBox(height: 5.h),
              CustomTextWidget(
                text: productEntity.productTitle,
                maxLines: 2,
                textStyle: TextStyle(
                  overflow: TextOverflow.ellipsis,
                    fontSize: FontDetails.fontSizeL,
                    fontWeight: FontDetails.boldFontWeight,
                    color: context.color.textColor),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CustomTextWidget(
              text: "price".tr(),
              textStyle: TextStyle(
                  color: ColorsLight.mainTextColor,
                  fontWeight: FontDetails.regularFontWeight,
                  fontSize: FontDetails.fontSizeXS),
            ),
            SizedBox(height: 5.h),
            CustomTextWidget(
              text: productEntity.price,
              textStyle: TextStyle(
                  fontSize: FontDetails.fontSizeL,
                  fontWeight: FontDetails.boldFontWeight,
                  color: context.color.textColor),
            ),
          ],
        ),
      ],
    );
  }
}
