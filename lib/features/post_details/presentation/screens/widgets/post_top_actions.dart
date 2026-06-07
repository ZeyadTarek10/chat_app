import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class PostTopActions extends StatelessWidget {
  const PostTopActions({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                GoRouter.of(context).pop(context);
              },
              child: Container(
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  color: context.color.mainColor,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  size: 16.sp,
                  color: context.color.textColor,
                  fontWeight: FontDetails.blackFontWeight,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: context.color.mainColor!.withOpacity(0.7),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(2.r),
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://i.pinimg.com/originals/e2/4c/af/e24caf13f6a603d4ed30fbca131bbc26.jpg',
                      width: 20.w,
                      height: 14.h,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => SizedBox(
                        height: 14.h,
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: ColorsLight.mainTextColor,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => SizedBox(
                        height: 14.h,
                        child: const Icon(Icons.error, size: 14),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  CustomTextWidget(
                    text: "Paris, France",
                    textStyle: TextStyle(
                      fontSize: FontDetails.fontSizeS,
                      fontWeight: FontDetails.semiBoldFontWeight,
                      color: context.color.textColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
