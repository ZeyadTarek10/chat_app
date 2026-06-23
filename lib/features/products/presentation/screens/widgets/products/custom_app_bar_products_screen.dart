import 'package:chat_app/config/routes/app_routes.dart';
import 'package:chat_app/features/products/presentation/screens/widgets/products/circle_button_app_bar_products_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CustomAppBarProductsScreen extends StatelessWidget {
  const CustomAppBarProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleButtonAppBarProductsScreen(
              icon: Icons.add,
              onTap: () {
                GoRouter.of(context).push(AppRoutes.addProduct);
              }),
          CircleButtonAppBarProductsScreen(
              icon: Icons.arrow_forward_ios_outlined,
              onTap: () {
                GoRouter.of(context).pop();
              }),
        ],
      ),
    );
  }
}
