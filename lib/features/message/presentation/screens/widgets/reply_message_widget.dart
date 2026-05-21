import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/features/message/domain/entities/message_entity.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReplyMessageWidget extends StatelessWidget {
  const ReplyMessageWidget({
    super.key,
    required this.message,
    this.onCancelReply,
    required this.friendName,
  });

  final MessageEntity message;
  final VoidCallback? onCancelReply;
  final String friendName;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 4.h), 
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextWidget(
                          text: "${"replying_to".tr()} ${message.fromId == FirebaseAuth.instance.currentUser!.uid ? "you".tr() : friendName}",
                          maxLines: 1,
                          textStyle: TextStyle(
                            color: ColorsDark.blueDark,
                            fontSize: FontDetails.fontSizeXS,
                            fontWeight: FontWeight.w500,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      if (onCancelReply != null) ...[
                        GestureDetector(
                          onTap: onCancelReply,
                          child: Icon(
                            Icons.close,
                            size: FontDetails.fontSizeS,
                            color: ColorsDark.blueDark,
                          ),
                        ),
                      ]
                    ],
                  ),
                  SizedBox(height: 4.h),
                  
                  Row(
                    children: [
                      CustomTextWidget(
                        text: message.message ?? "",
                        textStyle: TextStyle(
                          color: ColorsLight.mainTextColor,
                          fontSize: FontDetails.fontSizeS,
                        ),
                        maxLines: 1,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
