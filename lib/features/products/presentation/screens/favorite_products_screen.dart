import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/features/products/presentation/manager/add_cubit/product_cubit.dart';
import 'package:chat_app/features/products/presentation/screens/widgets/add_product/app_bar_add_product_screen.dart';
import 'package:chat_app/features/products/presentation/screens/widgets/products/product_card.dart';
import 'package:chat_app/shared_widgets/custom_loading.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoriteProductsScreen extends StatelessWidget {
  const FavoriteProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid ?? '';

    return Scaffold(
      backgroundColor: context.color.mainColor,
      appBar: appBarAddProductScreen(context, "my_favorites".tr()),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CustomLoading());
          }

          if (state is ProductLoaded) {
            final cubit = context.read<ProductCubit>();

            final favProducts = cubit.allProducts
                .where((product) => product.favBy?.contains(currentUserId) ?? false)
                .toList();

            if (favProducts.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.favorite_border, size: 50.sp, color: ColorsLight.hintColor),
                    SizedBox(height: 10.h),
                    CustomTextWidget(
                      text: "no_favorite_products".tr(),
                      textStyle: TextStyle(color: ColorsLight.hintColor, fontSize: FontDetails.fontSizeM),
                    ),
                  ],
                ),
              );
            }

            return GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              physics: const BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                crossAxisSpacing: 15.w,
                mainAxisSpacing: 15.h,
              ),
              itemCount: favProducts.length,
              itemBuilder: (context, index) {
                return ProductCard(productEntity: favProducts[index]);
              },
            );
          }

          if (state is ProductError) {
            return Center(child: CustomTextWidget(text: state.message));
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}