import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AppBarSocialScreen extends StatelessWidget {
  const AppBarSocialScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      floating: true,
      snap: true,
      elevation: 0,
      title: CustomTextWidget(
        text: 'social_media'.tr(),
        textStyle: TextStyle(
          color: context.color.textColor,
          fontWeight: FontDetails.boldFontWeight,
          fontSize: FontDetails.fontSizeL,
        ),
      ),
      centerTitle: true,
      leading: Padding(
        padding: EdgeInsets.all(9.r),
        child: GestureDetector(
          onTap: () {
            GoRouter.of(context).pop(context);
          },
          child: Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: context.color.chatBackgroundColor,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              Icons.arrow_back_ios_new,
              size: FontDetails.fontSizeS,
              color: context.color.textColor,
              fontWeight: FontDetails.blackFontWeight,
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.notifications_none, color: context.color.textColor),
          onPressed: () {},
        ),
      ],
      iconTheme: IconThemeData(color: context.color.textColor),
    );
  }
}
