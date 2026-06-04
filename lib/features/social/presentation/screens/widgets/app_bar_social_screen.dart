import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AppBarSocialScreen extends StatelessWidget{
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
