import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/features/products/presentation/manager/add_cubit/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MultiImagePickerAddProductScreen extends StatelessWidget {
  const MultiImagePickerAddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        final cubit = context.read<ProductCubit>();
        return SizedBox(
          height: 80.h,
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            children: [
              GestureDetector(
                onTap: () {
                  cubit.pickAndUploadGalleryImages();
                },
                child: Container(
                  width: 80.w,
                  height: 80.h,
                  margin: EdgeInsets.only(right: 15.w),
                  decoration: BoxDecoration(
                    color: ColorsLight.mainTextColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(15.r),
                    border: Border.all(
                        color: Colors.grey.shade300, style: BorderStyle.solid),
                  ),
                  child:
                      const Icon(Icons.add, color: ColorsLight.mainTextColor),
                ),
              ),
              ...cubit.uploudedGallaryImages.map((imageUrl) {
                return Container(
                  width: 80.w,
                  height: 80.h,
                  margin: EdgeInsets.only(right: 10.w),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15.r),
                        child: CachedNetworkImage(
                          imageUrl: imageUrl,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const Center(
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: ColorsDark.blueLight1,
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => const Center(
                            child: Icon(
                              Icons.photo_size_select_actual_outlined,
                              size: 30,
                              color: ColorsLight.mainTextColor,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 4.h,
                        right: 4.w,
                        child: GestureDetector(
                          onTap: () {
                            cubit.removeGalleryImage(imageUrl);
                          },
                          child: Container(
                            padding: EdgeInsets.all(4.r),
                            decoration: const BoxDecoration(
                              color: Colors.black54,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.close,
                              size: 14.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
              if (state is ProductGalleryImageUploading)
                Container(
                  width: 80.w,
                  height: 80.h,
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(
                    color: ColorsDark.blueLight1,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
