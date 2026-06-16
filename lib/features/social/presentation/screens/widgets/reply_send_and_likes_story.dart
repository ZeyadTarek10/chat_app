import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/shared_widgets/custom_text_form_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReplySendAndLikesStory extends StatelessWidget {
  const ReplySendAndLikesStory({
    super.key,
    required this.replyController,
    required this.replyFocusNode,
    required this.onSendReply,
    required this.isLikedByMe,
    required this.onLike,
  });

  final TextEditingController replyController;
  final FocusNode replyFocusNode;
  final VoidCallback onSendReply;
  final bool isLikedByMe;
  final VoidCallback onLike;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: CustomTextFormFieldWidget(
          controller: replyController,
          focusNode: replyFocusNode,
          textColor: ColorsDark.white,
          hint: "send_a_reply".tr(),
          fillColor: Colors.black45,
          suffixIcon: IconButton(
            icon: const Icon(Icons.send, color: ColorsDark.white),
            onPressed: onSendReply,
          ),
          validator: (value) => null,
        )),
        SizedBox(width: 10.w),
        IconButton(
          icon: Icon(
            isLikedByMe ? Icons.favorite : Icons.favorite_border,
            color: isLikedByMe ? ColorsLight.red : ColorsDark.white,
            size: 32.sp,
          ),
          onPressed: onLike,
        ),
      ],
    );
  }
}
