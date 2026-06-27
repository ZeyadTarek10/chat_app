import 'package:chat_app/features/products/presentation/screens/widgets/products/circle_button_app_bar_products_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CustomAppBarProductsScreen extends StatelessWidget {
  final VoidCallback onMenuTap;
  const CustomAppBarProductsScreen({super.key, required this.onMenuTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleButtonAppBarProductsScreen(
              icon: Icons.arrow_back_ios_sharp,
              onTap: () {
                GoRouter.of(context).pop();
              }),
          CircleButtonAppBarProductsScreen(
              icon: Icons.menu_open,
              onTap: onMenuTap),
        ],
      ),
    );
  }
}
