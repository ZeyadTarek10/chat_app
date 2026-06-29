import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/enum/alert_enum.dart';
import 'package:chat_app/core/services/alert_service.dart';
import 'package:chat_app/features/products/domain/entities/product_entity.dart';
import 'package:chat_app/features/products/presentation/manager/add_cubit/product_cubit.dart';
import 'package:chat_app/features/products/presentation/screens/widgets/product_details/product_details_screen_bottom_cart_section.dart';
import 'package:chat_app/features/products/presentation/screens/widgets/product_details/product_details_screen_description_section.dart';
import 'package:chat_app/features/products/presentation/screens/widgets/product_details/product_details_screen_gallery_section.dart';
import 'package:chat_app/features/products/presentation/screens/widgets/product_details/product_details_screen_info_section.dart';
import 'package:chat_app/features/products/presentation/screens/widgets/product_details/product_details_screen_sliver_app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductEntity productEntity;
  const ProductDetailsScreen({super.key, required this.productEntity});

  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid ?? '';
    final isOwner = currentUserId == productEntity.userId;
    return BlocListener<ProductCubit, ProductState>(
      listener: (context, state) {
        if (state is ProductActionSuccess) {
          if (context.mounted) Navigator.pop(context); 
          AlertService().showAlert(
            context: context, 
            subtitle: state.message, 
            status: AlertStatus.success
          );
        } else if (state is ProductError) {
          AlertService().showAlert(
            context: context, 
            subtitle: state.message, 
            status: AlertStatus.error
          );
        }
      },
      child: Scaffold(
        backgroundColor: context.color.mainColor,
        bottomNavigationBar: isOwner
            ? const SizedBox.shrink()
            : ProductDetailsScreenBottomCartSection(
                productEntity: productEntity, currentUserId: currentUserId),
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            ProductSliverAppBar(
              productEntity: productEntity,
              isOwner: isOwner,
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  ProductInfoSection(
                    productEntity: productEntity,
                  ),
                  SizedBox(height: 20.h),
                  ProductGallerySection(productEntity: productEntity),
                  SizedBox(height: 20.h),
                  ProductDescriptionSection(
                    productEntity: productEntity,
                  ),
                  SizedBox(height: 20.h),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
