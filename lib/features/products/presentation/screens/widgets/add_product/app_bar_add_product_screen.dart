import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/features/products/presentation/screens/widgets/products/circle_button_app_bar_products_screen.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

PreferredSizeWidget appBarAddProductScreen(BuildContext context) {
    return AppBar(
      backgroundColor: context.color.mainColor,
      elevation: 0,
      centerTitle: true,
      leading: CircleButtonAppBarProductsScreen(
          icon: Icons.arrow_back_ios,
          onTap: () {
            GoRouter.of(context).pop();
          }),
      title: CustomTextWidget(
        text: "add_product".tr(),
        textStyle: TextStyle(
            color: context.color.textColor,
            fontWeight: FontDetails.blackFontWeight,
            fontSize: FontDetails.fontSizeL),
      ),
    );
  }