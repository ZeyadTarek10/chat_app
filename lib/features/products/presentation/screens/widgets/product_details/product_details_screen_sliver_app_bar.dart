import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/features/products/presentation/screens/widgets/product_details/circle_button_app_bar_product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductSliverAppBar extends StatelessWidget {
  const ProductSliverAppBar({super.key});

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
      flexibleSpace: FlexibleSpaceBar(
        background: SafeArea(
          child: CachedNetworkImage(
            imageUrl:
                'https://i.pinimg.com/1200x/dd/f7/d5/ddf7d51ef1814d4be2800df43d8f2e45.jpg',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}