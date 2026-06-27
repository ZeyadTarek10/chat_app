import 'package:chat_app/config/routes/app_routes.dart';
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
import 'package:go_router/go_router.dart';

class MyProductsScreen extends StatelessWidget {
  const MyProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid ?? '';

    return Scaffold(
      backgroundColor: context.color.mainColor,
      appBar: appBarAddProductScreen(context, "my_products".tr()),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(
                child: CustomLoading());
          }

          if (state is ProductLoaded) {
            final cubit = context.read<ProductCubit>();

            final myProducts = cubit.allProducts
                .where((product) => product.userId == currentUserId)
                .toList();

            if (myProducts.isEmpty) {
              return Center(
                child: CustomTextWidget(
                  text: "no_products_added".tr(),
                  textStyle: TextStyle(
                      color: ColorsLight.hintColor,
                      fontSize: FontDetails.fontSizeM),
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
              itemCount: myProducts.length,
              itemBuilder: (context, index) {
                final product = myProducts[index];
                return GestureDetector(
                    onTap: () {
                      GoRouter.of(context).push(
                        AppRoutes.productDetails,
                        extra: {
                          'product': product,
                          'cubit': cubit,
                        },
                      );
                      context.read<ProductCubit>().resetDescription();
                    },
                    child: ProductCard(productEntity: myProducts[index]));
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
