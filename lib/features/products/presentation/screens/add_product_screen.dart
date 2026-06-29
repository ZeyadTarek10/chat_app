import 'package:chat_app/config/app/upload_image/presentation/screens/widgets/image_pick.dart';
import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/enum/alert_enum.dart';
import 'package:chat_app/core/services/alert_service.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/features/products/domain/entities/product_entity.dart';
import 'package:chat_app/features/products/presentation/manager/add_cubit/product_cubit.dart';
import 'package:chat_app/features/products/presentation/screens/widgets/add_product/add_product_button.dart';
import 'package:chat_app/features/products/presentation/screens/widgets/add_product/app_bar_add_product_screen.dart';
import 'package:chat_app/features/products/presentation/screens/widgets/add_product/is_product_available.dart';
import 'package:chat_app/features/products/presentation/screens/widgets/add_product/multi_image_picker_add_product_screen.dart';
import 'package:chat_app/features/products/presentation/screens/widgets/add_product/product_image_picker_add_product_screen.dart';
import 'package:chat_app/features/products/presentation/screens/widgets/add_product/product_section_title_add_product_screen.dart';
import 'package:chat_app/shared_widgets/custom_text_form_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class AddProductScreen extends StatefulWidget {
  final ProductEntity? productToEdit;
  const AddProductScreen({super.key, this.productToEdit});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  bool get isEditMode => widget.productToEdit != null;

  @override
  void initState() {
    super.initState();
    context.read<ProductCubit>().initEditData(widget.productToEdit);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.color.mainColor,
      appBar: appBarAddProductScreen(
        context,
        isEditMode ? "edit_product".tr() : "add_product".tr(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.all(20.r),
          child: BlocConsumer<ProductCubit, ProductState>(
            listener: (context, state) {
              if (state is ProductActionSuccess) {
                GoRouter.of(context).pop(context);
                AlertService().showAlert(
                    context: context,
                    subtitle: state.message,
                    status: AlertStatus.success);
              } else if (state is ProductError) {
                AlertService().showAlert(
                    context: context,
                    subtitle: state.message,
                    status: AlertStatus.error);
              }
            },
            builder: (context, state) {
              final cubit = context.read<ProductCubit>();
              // final currentUser = context.read<ProfileCubit>().currentUser;
              return Form(
                key: cubit.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 25.h),
                    ProductImagePickerAddProductScreen(
                      onTap: state is ProductMainImageUploading
                          ? null
                          : () async {
                              final image = await PickImageUtils()
                                  .pickImage(ImageSource.gallery);
                              if (image != null) {
                                cubit.uploadSelectedImage(image);
                              }
                            },
                      icon: state is ProductMainImageUploading
                          ? Icons.cloud_upload_outlined
                          : (cubit.selectedImage != null ||
                                  cubit.uploadedImageUrl != null)
                              ? Icons.check_circle
                              : Icons.image_outlined,
                      text: state is ProductMainImageUploading
                          ? "uploading".tr()
                          : (cubit.selectedImage != null ||
                                  cubit.uploadedImageUrl != null)
                              ? "image_selected".tr()
                              : "upload_product_image".tr(),
                    ),
                    SizedBox(height: 20.h),
                    ProductSectionTitleAddProductScreen(
                        title: "additional_images".tr()),
                    SizedBox(height: 8.h),
                    const MultiImagePickerAddProductScreen(),
                    SizedBox(height: 25.h),
                    IsProductAvailable(cubit: cubit),
                    SizedBox(height: 25.h),
                    ProductSectionTitleAddProductScreen(
                        title: "product_title".tr()),
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
                    ProductSectionTitleAddProductScreen(
                        title: "description".tr()),
                    SizedBox(height: 8.h),
                    CustomTextFormFieldWidget(
                      hint: "write_something_about_the_product".tr(),
                      validator: (value) => value!.isEmpty
                          ? "description_is_required".tr()
                          : null,
                      controller: cubit.descriptionController,
                      withBorders: true,
                      fillColor: ColorsLight.mainTextColor.withOpacity(0.1),
                    ),
                    SizedBox(height: 35.h),
                    AddProductButton(
                      title:
                          isEditMode ? "save_changes".tr() : "add_product".tr(),
                      onPressed: () {
                        if (cubit.formKey.currentState!.validate()) {
                          if (cubit.uploadedImageUrl == null && !isEditMode) {
                            AlertService().showAlert(
                              context: context,
                              subtitle: "please_upload_product_image".tr(),
                              status: AlertStatus.error,
                            );
                            return;
                          }

                          if (isEditMode) {
                            cubit.updateCurrentProduct(widget.productToEdit!);
                          } else {
                            cubit.createNewProduct();
                          }
                        }
                      },
                      isLoading: state is ProductLoading,
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

