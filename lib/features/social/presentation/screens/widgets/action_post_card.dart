import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActionPostCard extends StatelessWidget {
  const ActionPostCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var color = context.color;
    return Row(
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.favorite_border_outlined,
              color: color.textColor),
        ),
        SizedBox(width: 8.w),
        CustomTextWidget(
            text: '7.5K',
            textStyle: TextStyle(color: context.color.textColor)),
        SizedBox(width: 16.w),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.chat_bubble_outline,
            color: context.color.textColor,
          ),
        ),
        SizedBox(width: 8.w),
        CustomTextWidget(
            text: '425',
            textStyle: TextStyle(color: context.color.textColor)),
        SizedBox(width: 16.w),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.send_outlined,
              color: context.color.textColor,
            )),
      ],
    );
  }
}