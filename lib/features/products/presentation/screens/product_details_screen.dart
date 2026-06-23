import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/features/products/presentation/screens/widgets/product_details/product_details_screen_bottom_cart_section.dart';
import 'package:chat_app/features/products/presentation/screens/widgets/product_details/product_details_screen_description_section.dart';
import 'package:chat_app/features/products/presentation/screens/widgets/product_details/product_details_screen_gallery_section.dart';
import 'package:chat_app/features/products/presentation/screens/widgets/product_details/product_details_screen_info_section.dart';
import 'package:chat_app/features/products/presentation/screens/widgets/product_details/product_details_screen_sliver_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.color.mainColor,
      bottomNavigationBar: const ProductDetailsScreenBottomCartSection(),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const ProductSliverAppBar(),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const ProductInfoSection(),
                SizedBox(height: 20.h),
                const ProductGallerySection(),
                SizedBox(height: 20.h),
                const ProductDescriptionSection(),
                SizedBox(height: 20.h),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}











