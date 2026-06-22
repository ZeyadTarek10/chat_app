import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostSendButton extends StatelessWidget {
  final bool isSent;
  final VoidCallback onSend;
  const PostSendButton({super.key, required this.isSent, required this.onSend});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isSent ? Colors.grey.shade300 : ColorsDark.blueLight1,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
      onPressed: isSent ? null : onSend,
      child: CustomTextWidget(
        text: isSent ? "sent".tr() : "send".tr(),
        textStyle: TextStyle(
          color: isSent ? Colors.black54 : ColorsDark.white,
          fontSize: FontDetails.fontSizeXS,
          fontWeight: FontDetails.boldFontWeight,
        ),
      ),
    );
  }
}
