import 'package:chat_app/config/routes/app_routes.dart';
import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/app_images.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/features/products/domain/entities/product_entity.dart';
import 'package:chat_app/features/products/presentation/manager/add_cubit/product_cubit.dart';
import 'package:chat_app/features/products/presentation/screens/widgets/products/product_card.dart';
import 'package:chat_app/shared_widgets/custom_loading.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class ProductGridProductsScreen extends StatelessWidget {
  const ProductGridProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      sliver: BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        final cubit = context.read<ProductCubit>();
        final List<ProductEntity> displayList = cubit.isSearching 
          ? cubit.searchedProducts 
          : cubit.allProducts;

        if (state is ProductLoading) {
          return const SliverToBoxAdapter(
            child: Center(child: CustomLoading()),
          );
        }

        if (state is ProductError) {
          return SliverToBoxAdapter(
            child: Center(
                child: CustomTextWidget(
              text: state.message,
              textStyle: TextStyle(
                  color: ColorsLight.error,
                  fontSize: FontDetails.fontSizeS,
                  fontWeight: FontDetails.boldFontWeight),
            )),
          );
        }

        if (displayList.isEmpty) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 50.h),
              child: Center(
                child: Column(
                  children: [
                    Lottie.asset(AppImages.nonDataFound),
                    CustomTextWidget(
                      text: "there_are_no_products_currently".tr(),
                      textStyle: TextStyle(
                        color: context.color.textColor,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
          return SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.55,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final product = displayList[index];
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
                    child: ProductCard(productEntity: product,));
              },
              childCount: displayList.length,
            ),
          );
        },
      ),
    );
  }
}
