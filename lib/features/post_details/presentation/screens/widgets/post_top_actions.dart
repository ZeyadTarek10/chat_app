import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/features/social/domain/entities/social_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class PostTopActions extends StatelessWidget {
  final SocialEntity post;
  const PostTopActions({super.key, required this.post});

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
                  color: context.color.mainColor!.withOpacity(0.8),
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
            // Flexible(
            //   child: Container(
            //     padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            //     decoration: BoxDecoration(
            //       color: context.color.chatBackgroundColor!.withOpacity(0.7),
            //       borderRadius: BorderRadius.circular(8.r),
            //     ),
            //     child: Expanded(
            //       child: CustomTextWidget(
            //         text: DateHelper.getShortLocation(post.location), 
            //         maxLines: 1,
            //         textStyle: TextStyle(
            //           fontSize: FontDetails.fontSizeS,
            //           fontWeight: FontDetails.semiBoldFontWeight,
            //           color: context.color.textColor,
            //           overflow: TextOverflow.ellipsis,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
