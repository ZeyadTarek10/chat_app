import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommentItem extends StatelessWidget {
  final String userName;
  final String comment;
  final String imageUrl;

  const CommentItem({
    super.key,
    required this.userName,
    required this.comment,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 18.r,
            backgroundImage: CachedNetworkImageProvider(imageUrl),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CustomTextWidget(
                      text: userName,
                      textStyle: TextStyle(
                          fontSize: FontDetails.fontSizeS,
                          color: context.color.textColor,
                          fontWeight: FontDetails.boldFontWeight),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: CustomTextWidget(
                        text: comment,
                        maxLines: 2,
                        textStyle: TextStyle(
                          fontSize: FontDetails.fontSizeS,
                          color: context.color.textColor!.withOpacity(0.9),
                          fontWeight: FontDetails.lightFontWeight,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    CustomTextWidget(
                        text: "answer".tr(),
                        textStyle: TextStyle(
                            fontSize: FontDetails.fontSizeXS,
                            color: ColorsLight.mainTextColor)),
                    SizedBox(width: 15.w),
                    CustomTextWidget(
                        text: "like".tr(),
                        textStyle: TextStyle(
                            fontSize: FontDetails.fontSizeXS,
                            color: ColorsLight.mainTextColor)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
