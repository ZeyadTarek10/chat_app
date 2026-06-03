import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:cached_network_image/cached_network_image.dart';

class StackCircleAvatar extends StatelessWidget {
  final List<String> images;      
  final List<String> memberNames; 
  final int totalCount;           

  const StackCircleAvatar({
    super.key,
    required this.images,
    required this.memberNames, 
    required this.totalCount,
  });

  @override
  Widget build(BuildContext context) {
    double avatarSize = 45.0;
    double overlapFactor = 19.0;

    int widgetsToShow = totalCount > 3 ? 3 : totalCount;
    if (widgetsToShow == 0) return const SizedBox();

    double totalWidth = ((widgetsToShow - 1) * overlapFactor) + avatarSize;

    return SizedBox(
      height: avatarSize + 5,
      width: totalWidth + 5,
      child: Stack(
        children: [
          ...List.generate(widgetsToShow, (index) {
            if (index == 2 && totalCount > 3) {
              return Positioned(
                left: index * overlapFactor,
                child: _buildAvatarBadge(avatarSize, totalCount - 2, context),
              );
            }

            String url = (images.length > index) ? images[index] : '';
            String memberName = (memberNames.length > index) ? memberNames[index] : '?';
            String initial = memberName.trim().isNotEmpty ? memberName.trim()[0].toUpperCase() : '';

            return Positioned(
              left: index * overlapFactor,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: ColorsDark.white, width: 2.w),
                ),
                child: CircleAvatar(
                  radius: avatarSize / 2,
                  backgroundColor: context.color.circleAvatarBackgroundColor,
                  child: url.isNotEmpty
                      ? ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: url,
                            width: avatarSize,
                            height: avatarSize,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Center(
                              child: CustomTextWidget(
                                text: initial,
                                textStyle: TextStyle(
                                  color: context.color.textColor,
                                  fontSize: 14.sp,
                                  fontWeight: FontDetails.boldFontWeight,
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => Center(
                              child: CustomTextWidget(
                                text: initial,
                                textStyle: TextStyle(
                                  color: ColorsDark.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontDetails.boldFontWeight,
                                ),
                              ),
                            ),
                          ),
                        )
                      : CustomTextWidget(
                          text: initial,
                          textStyle: TextStyle(
                            color: ColorsDark.white,
                            fontSize: 14.sp,
                            fontWeight: FontDetails.boldFontWeight,
                          ),
                        ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildAvatarBadge(double size, int extraCount, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: ColorsDark.white, width: 2.w),
      ),
      child: CircleAvatar(
        radius: size / 2,
        backgroundColor: context.color.popupMenu,
        child: CustomTextWidget(
          text: '+$extraCount',
          textStyle: TextStyle(
            fontSize: 12.sp,
            color: context.color.textColor,
            fontWeight: FontDetails.boldFontWeight,
          ),
        ),
      ),
    );
  }
}