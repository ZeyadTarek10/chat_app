import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/validations/app_validation.dart';
import 'package:chat_app/features/products/presentation/manager/add_cubit/product_cubit.dart';
import 'package:chat_app/shared_widgets/custom_text_form_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchBarProductsScreen extends StatelessWidget {
  const SearchBarProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        decoration: BoxDecoration(
          color: ColorsLight.mainTextColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: CustomTextFormFieldWidget(
          prefixIcon: const Icon(Icons.search, color: ColorsLight.hintColor,),
          hint: "search".tr(), 
          hintColor: ColorsLight.hintColor,
          onChange: (value) {
            context.read<ProductCubit>().searchProducts(value);
          },
          validator: (String? value) => AppValidator.noValidation(),
        )
      ),
    );
  }
}
