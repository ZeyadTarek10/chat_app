import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/features/products/domain/entities/product_entity.dart';
import 'package:chat_app/features/products/presentation/manager/add_cubit/product_cubit.dart';
import 'package:chat_app/features/products/presentation/screens/widgets/products/image_product_card.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity productEntity;
  const ProductCard({super.key, required this.productEntity});

  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid ?? '';
    
    final bool isFav = productEntity.favBy?.contains(currentUserId) ?? false;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Stack(
            children: [
              ImageProductCard(productEntity: productEntity),
              
              if (!productEntity.isAvailable)
                Positioned(
                  top: 15.h,
                  left: 15.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                    decoration: BoxDecoration(
                      color: ColorsLight.red,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: CustomTextWidget(
                      text: "sold_out".tr(),
                      textStyle: TextStyle(
                        color: ColorsDark.white, 
                        fontWeight: FontDetails.boldFontWeight,
                        fontSize: FontDetails.fontSizeXS,
                      ),
                    ),
                  ),
                ),
                
              Positioned(
                top: 15.h,
                right: 15.w,
                child: GestureDetector(
                  onTap: () {
                    if (currentUserId.isNotEmpty) {
                      context.read<ProductCubit>().toggleLikePost(productEntity, currentUserId);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(4.r), 
                    color: Colors.transparent,
                    child: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border, 
                      color: isFav ? Colors.red : ColorsLight.hintColor, 
                      size: 24.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 5.h),
        CustomTextWidget(
          text: productEntity.productTitle,
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
          text: productEntity.price,
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