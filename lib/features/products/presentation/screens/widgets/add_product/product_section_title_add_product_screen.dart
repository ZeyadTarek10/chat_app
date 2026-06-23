import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';

class ProductSectionTitleAddProductScreen extends StatelessWidget {
  final String title;
  const ProductSectionTitleAddProductScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return CustomTextWidget(
      text: title,
      textStyle: TextStyle(
          fontSize: FontDetails.fontSizeS,
          fontWeight: FontDetails.blackFontWeight,
          color: context.color.textColor),
    );
  }
}