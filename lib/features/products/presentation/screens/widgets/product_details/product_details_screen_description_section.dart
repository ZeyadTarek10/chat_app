import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/features/products/domain/entities/product_entity.dart';
import 'package:chat_app/features/products/presentation/manager/add_cubit/product_cubit.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/gestures.dart'; 

class ProductDescriptionSection extends StatelessWidget {
  final ProductEntity productEntity;
  const ProductDescriptionSection({super.key, required this.productEntity});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        final cubit = context.read<ProductCubit>();
        final bool isExpanded = cubit.isDescriptionExpanded;

        final String description = productEntity.discription ?? "";
        final bool isLongText = description.length > 100;

        final String displayText = (isLongText && !isExpanded)
            ? "${description.substring(0, 100)}... "
            : "$description ";

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextWidget(
              text: "description".tr(),
              textStyle: TextStyle(
                fontSize: FontDetails.fontSizeM,
                color: context.color.textColor,
                fontWeight: FontDetails.boldFontWeight,
              ),
            ),
            SizedBox(height: 10.h),
            RichText(
              text: TextSpan(
                style: TextStyle(
                  color: ColorsLight.mainTextColor,
                  height: 1.5.h,
                  fontSize: FontDetails.fontSizeS,
                ),
                children: [
                  TextSpan(text: displayText),
                  if (isLongText)
                    TextSpan(
                      text: isExpanded ? "read_less".tr() : "read_more".tr(),
                      style: TextStyle(
                        color: context.color.textColor,
                        fontWeight: FontDetails.boldFontWeight,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          cubit.toggleDescription();
                        },
                    ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}