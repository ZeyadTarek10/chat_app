import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/features/products/presentation/manager/add_cubit/product_cubit.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IsProductAvailable extends StatelessWidget {
  const IsProductAvailable({
    super.key,
    required this.cubit,
  });

  final ProductCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: ColorsLight.mainTextColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomTextWidget(
            text: cubit.isAvailable
                ? "product_available".tr()
                : "product_sold_out".tr(),
            textStyle: TextStyle(
              fontSize: FontDetails.fontSizeM,
              fontWeight: FontDetails.boldFontWeight,
              color:
                  cubit.isAvailable ? ColorsLight.green : ColorsLight.red,
            ),
          ),
          Switch(
            value: cubit.isAvailable,
            activeColor: ColorsLight.green,
            onChanged: (value) =>
                cubit.toggleAvailability(value),
          ),
        ],
      ),
    );
  }
}
