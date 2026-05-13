import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/features/message/domain/entities/message_entity.dart';
import 'package:chat_app/features/message/presentation/manager/message_cubit/message_cubit.dart';
import 'package:chat_app/features/message/presentation/screens/message_screen.dart';
import 'package:chat_app/features/message/presentation/screens/widgets/send_icon.dart';
import 'package:chat_app/shared_widgets/custom_text_form_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SendingMessagesContainer extends StatelessWidget {
  const SendingMessagesContainer({
    super.key,
    required this.messageCubit,
    required this.widget,
  });

  final MessageCubit messageCubit;
  final MessageScreen widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      color: context.color.mainColor,
      child: Row(
        children: [
         Container(
        decoration: BoxDecoration(
          color: ColorsDark.white.withOpacity(0.2),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: context.color.mainColor!.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
            child: IconButton(
              onPressed: () {
                context.read<MessageCubit>().toggleMenu();
              },
              icon: Icon(Icons.add,
                  color: ColorsDark.blueLight1,
                  size: FontDetails.fontSizeL),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: CustomTextFormFieldWidget(
              fillColor:  ColorsLight.mainTextColor.withOpacity(0.1),
              controller: messageCubit.controller,
              // onChange: (value) => handleSendMessage(context),
              hint: 'type_a_message'.tr(),
              hintColor: ColorsLight.mainTextColor,
              withBorders: false,
              validator: (value) {
                return null;
              },
            ),
          ),
          SizedBox(width: 12.w),
          InkWell(
            onTap: () {
              if (messageCubit.controller.text.trim().isEmpty) return;
    
              String msgId =
                  DateTime.now().millisecondsSinceEpoch.toString();
    
              final newMessage = MessageEntity(
                id: msgId,
                message: messageCubit.controller.text.trim(),
                createdAt: DateTime.now(),
                toId: widget.friendId,
                fromId: FirebaseAuth.instance.currentUser!.uid,
                type: "text",
                read: "",
              );
    
              context
                  .read<MessageCubit>()
                  .sendMessage(newMessage, widget.roomId);
    
              messageCubit.controller.clear();
              if (messageCubit.controller0.hasClients) {
                messageCubit.controller0.animateTo(0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn);
              }
            },
            child: const SendIcon(),
          ),
        ],
      ),
    );
  }
}
