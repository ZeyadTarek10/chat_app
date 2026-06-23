import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MultiImagePickerAddProductScreen extends StatelessWidget {
  const MultiImagePickerAddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        children: [
          GestureDetector(
            onTap: () {},
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
              child: const Icon(Icons.add, color: ColorsLight.mainTextColor),
            ),
          ),
          ...List.generate(3, (index) {
            return Container(
              width: 80.w,
              height: 80.h,
              margin: EdgeInsets.only(right: 10.w),
              decoration: BoxDecoration(
                  color: ColorsLight.mainTextColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15.r),
                  image: const DecorationImage(
                      image: CachedNetworkImageProvider(
                          'https://i.pinimg.com/1200x/dd/f7/d5/ddf7d51ef1814d4be2800df43d8f2e45.jpg'))),
            );
          }),
        ],
      ),
    );
  }
}
