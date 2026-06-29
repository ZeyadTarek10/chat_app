import 'package:chat_app/config/routes/app_routes.dart';
import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/features/products/presentation/screens/widgets/products/build_menu_drawar_item.dart';
import 'package:chat_app/features/products/presentation/screens/widgets/products/circle_button_app_bar_products_screen.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:awesome_drawer_bar/awesome_drawer_bar.dart';

class ProductsDrawer extends StatelessWidget {
  final AwesomeDrawerBarController drawerController;

  const ProductsDrawer({super.key, required this.drawerController});

  @override
  Widget build(BuildContext context) {
    final double drawerWidth = MediaQuery.of(context).size.width * 0.70;

    return Scaffold(
      backgroundColor: context.color.chatBackgroundColor,
      body: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: drawerWidth,
          height: double.infinity,
          decoration: BoxDecoration(
            color: context.color.mainColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 15,
                spreadRadius: 5,
              )
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                  left: 20.w, right: 10.w, top: 20.h, bottom: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: CircleButtonAppBarProductsScreen(
                        icon: Icons.close,
                        onTap: () => drawerController.close!(),
                      )
                      ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12.r),
                        decoration: BoxDecoration(
                          color: ColorsDark.blueLight1,
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        child: Icon(Icons.dashboard_customize_rounded,
                            color: Colors.white, size: 28.sp),
                      ),
                      SizedBox(width: 15.w),
                      Expanded(
                        child: CustomTextWidget(
                          text: "product_menu".tr(),
                          textStyle: TextStyle(
                            fontSize: FontDetails.fontSizeL,
                            fontWeight: FontDetails.boldFontWeight,
                            color: context.color.textColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h),
                  Divider(color: Colors.grey.shade200, thickness: 1.5),
                  SizedBox(height: 20.h),
                  BuildMenuDrawarItem(
                    icon: Icons.add_box_rounded,
                    title: "add_product".tr(),
                    iconColor: const Color(0xFF8F67E8),
                    onTap: () {
                      drawerController.close?.call();
                      GoRouter.of(context).push(AppRoutes.addProduct);
                    },
                  ),
                  BuildMenuDrawarItem(
                    icon: Icons.inventory_rounded,
                    title: "my_products".tr(),
                    iconColor: Colors.blue.shade400,
                    onTap: () {
                      drawerController.close?.call();
                      GoRouter.of(context).push(AppRoutes.myProducts);
                    },
                  ),
                  BuildMenuDrawarItem(
                    icon: Icons.favorite_rounded,
                    title: "my_favorites".tr(),
                    iconColor: Colors.red.shade400,
                    onTap: () {
                      drawerController.close!();
                      GoRouter.of(context).push(AppRoutes.favProducts);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}