import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StackCircleAvatar extends StatelessWidget {
  final List<String> images;
  final int totalCount;
  final String name;

  const StackCircleAvatar({
    super.key,
    required this.images,
    required this.totalCount,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    double avatarSize = 40.0;
    double overlapFactor = 15.0;

    int imagesToShow = totalCount > 3 ? 2 : images.length;

    if (images.isEmpty) {
      imagesToShow = 1;
    }

    int totalWidgets = totalCount > 3 ? imagesToShow + 1 : imagesToShow;
    double totalWidth = ((totalWidgets - 1) * overlapFactor) + avatarSize;

    return SizedBox(
      height: avatarSize,
      width: totalWidth,
      child: Stack(
        children: [
          ...List.generate(imagesToShow, (index) {
            String url = (images.isNotEmpty && index < images.length) ? images[index] : '';
            String initial = name.trim().isNotEmpty ? name.trim()[0].toUpperCase() : '';

            return Positioned(
              left: index * overlapFactor,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.white, width: 2.w),
                ),
                child: CircleAvatar(
                  radius: avatarSize / 2,
                  backgroundColor: Colors.blue[50],
                  backgroundImage: url.isNotEmpty ? NetworkImage(url) : null,
                  child: url.isEmpty
                      ? CustomTextWidget(
                          text: initial,
                          textStyle: TextStyle(
                            color: AppColors.black,
                            fontSize: 16.sp,
                            fontWeight: FontDetails.boldFontWeight,
                          ),
                        )
                      : null,
                ),
              ),
            );
          }),

          if (totalCount > 3)
            Positioned(
              left: imagesToShow * overlapFactor,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: CircleAvatar(
                  radius: avatarSize / 2,
                  backgroundColor: Colors.grey[200],
                  child: Text(
                    '+${totalCount - imagesToShow}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}