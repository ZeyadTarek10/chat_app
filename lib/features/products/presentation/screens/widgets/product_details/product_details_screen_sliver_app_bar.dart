import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/config/routes/app_routes.dart';
import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/features/products/domain/entities/product_entity.dart';
import 'package:chat_app/features/products/presentation/manager/add_cubit/product_cubit.dart';
import 'package:chat_app/features/products/presentation/screens/widgets/product_details/circle_button_app_bar_product_details_screen.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ProductSliverAppBar extends StatelessWidget {
  final ProductEntity productEntity;
  final bool isOwner;
  const ProductSliverAppBar(
      {super.key, required this.productEntity, required this.isOwner});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 400.w,
      backgroundColor: context.color.mainColor,
      elevation: 0,
      pinned: true,
      leadingWidth: 70.w,
      leading: Padding(
        padding: EdgeInsets.only(left: 20.w, top: 10.h, bottom: 10.h),
        child: CircleButton(
          icon: Icons.arrow_back,
          onTap: () => Navigator.pop(context),
        ),
      ),
      actions: [
        if (isOwner)
          Padding(
            padding: EdgeInsets.only(right: 20.w, top: 10.h, bottom: 10.h),
            child: PopupMenuButton<String>(
              offset: Offset(0, 45.h), 
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              onSelected: (value) async {
                if (value == 'edit') {
                  GoRouter.of(context)
                      .push(AppRoutes.addProduct, extra: productEntity);
                } else if (value == 'delete') {
                  await context
                      .read<ProductCubit>()
                      .deletePost(productEntity.id);
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                      value: 'edit',
                      child: CustomTextWidget(text: 'edit'.tr())),
                  PopupMenuItem(
                    value: 'delete',
                    child: CustomTextWidget(
                      text: 'delete'.tr(),
                      textStyle: const TextStyle(color: Colors.red),
                    ),
                  ),
                ];
              },
              child: Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: context.color.mainColor, 
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.more_vert,
                    color: context.color.textColor, 
                    size: 20.sp),
              ),
            ),
          ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: SafeArea(
          child: ClipRRect(
            child: Container(
              color: ColorsLight.mainTextColor.withOpacity(0.2),
              child: CachedNetworkImage(
                imageUrl: productEntity.productImage,
                fit: BoxFit.contain,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
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
          ),
        ),
      ),
    );
  }
}
