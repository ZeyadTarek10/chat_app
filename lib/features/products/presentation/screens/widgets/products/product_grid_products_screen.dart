import 'package:chat_app/config/routes/app_routes.dart';
import 'package:chat_app/features/products/presentation/screens/widgets/products/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ProductGridProductsScreen extends StatelessWidget {
  const ProductGridProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.55,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return GestureDetector(
                onTap: () {
                  GoRouter.of(context).push(AppRoutes.productDetails);
                },
                child: const ProductCard());
          },
          childCount: 4,
        ),
      ),
    );
  }
}
