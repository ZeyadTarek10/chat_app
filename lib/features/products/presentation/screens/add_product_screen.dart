import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/enum/alert_enum.dart';
import 'package:chat_app/core/services/alert_service.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/features/products/presentation/manager/cubit/add_product_cubit.dart';
import 'package:chat_app/features/products/presentation/screens/widgets/add_product/add_product_button.dart';
import 'package:chat_app/features/products/presentation/screens/widgets/add_product/app_bar_add_product_screen.dart';
import 'package:chat_app/features/products/presentation/screens/widgets/add_product/multi_image_picker_add_product_screen.dart';
import 'package:chat_app/features/products/presentation/screens/widgets/add_product/product_image_picker_add_product_screen.dart';
import 'package:chat_app/features/products/presentation/screens/widgets/add_product/product_section_title_add_product_screen.dart';
import 'package:chat_app/shared_widgets/custom_text_form_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddProductCubit>();
    return Scaffold(
      backgroundColor: context.color.mainColor,
      appBar: appBarAddProductScreen(context),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.all(20.r),
          child: Form(
            key: cubit.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 25.h),
                const ProductImagePickerAddProductScreen(),
                SizedBox(height: 20.h),
                ProductSectionTitleAddProductScreen(title: "additional_images".tr()),
                SizedBox(height: 8.h),
                const MultiImagePickerAddProductScreen(),
                SizedBox(height: 25.h),
                ProductSectionTitleAddProductScreen(title: "product_title".tr()),
                SizedBox(height: 8.h),
                CustomTextFormFieldWidget(
                  hint: "enter_product_name".tr(),
                  validator: (value) =>
                      value!.isEmpty ? "title_is_required".tr() : null,
                  controller: cubit.titleController,
                  withBorders: true,
                  fillColor: ColorsLight.mainTextColor.withOpacity(0.1),
                ),
                SizedBox(height: 20.h),
                ProductSectionTitleAddProductScreen(title: "type".tr()),
                SizedBox(height: 8.h),
                CustomTextFormFieldWidget(
                  hint: "e_g_mens_printed_Pullover_Hoodie".tr(),
                  validator: (value) =>
                      value!.isEmpty ? "type_is_required".tr() : null,
                  controller: cubit.subTitleController,
                  withBorders: true,
                  fillColor: ColorsLight.mainTextColor.withOpacity(0.1),
                ),
                SizedBox(height: 20.h),
                ProductSectionTitleAddProductScreen(title: "price".tr()),
                SizedBox(height: 8.h),
                CustomTextFormFieldWidget(
                  hint: "0.00",
                  validator: (value) =>
                      value!.isEmpty ? "price_is_required".tr() : null,
                  controller: cubit.priceController,
                  textInputType: TextInputType.number,
                  withBorders: true,
                  fillColor: ColorsLight.mainTextColor.withOpacity(0.1),
                ),
                SizedBox(height: 20.h),
                ProductSectionTitleAddProductScreen(title: "description".tr()),
                SizedBox(height: 8.h),
                CustomTextFormFieldWidget(
                  hint: "write_something_about_the_product".tr(),
                  validator: (value) =>
                      value!.isEmpty ? "description_is_required".tr() : null,
                  controller: cubit.descriptionController,
                  withBorders: true,
                  fillColor: ColorsLight.mainTextColor.withOpacity(0.1),
                ),
                SizedBox(height: 35.h),
                AddProductButton(
                  onPressed: () {
                    if (cubit.formKey.currentState!.validate()) {
                      AlertService().showAlert(
                          context: context,
                          subtitle: 'product_added_successfully'.tr(),
                          status: AlertStatus.success);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




