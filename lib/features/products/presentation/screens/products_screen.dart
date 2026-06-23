import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/features/products/presentation/screens/widgets/products/custom_app_bar_products_screen.dart';
import 'package:chat_app/features/products/presentation/screens/widgets/products/product_grid_products_screen.dart';
import 'package:chat_app/features/products/presentation/screens/widgets/products/search_bar_products_screen.dart';
import 'package:chat_app/features/products/presentation/screens/widgets/products/section_header_products_screen.dart';
import 'package:chat_app/features/products/presentation/screens/widgets/products/welcome_text_products_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.color.mainColor,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            const SliverToBoxAdapter(
              child: CustomAppBarProductsScreen(),
            ),

            const SliverToBoxAdapter(
              child: WelcomeTextProductsScreen(),
            ),

            const SliverToBoxAdapter(
              child: SearchBarProductsScreen(),
            ),

            SliverToBoxAdapter(
              child: SectionHeaderProductsScreen(
                title: "new_arrival".tr(),
                onViewAll: () {},
              ),
            ),

            const ProductGridProductsScreen(),
          ],
        ),
      ),
    );
  }
}







