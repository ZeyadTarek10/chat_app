import 'package:chat_app/config/themes/app_theme.dart';
import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/features/message/domain/entities/message_entity.dart';
import 'package:chat_app/features/message/presentation/manager/message_cubit/message_cubit.dart';
import 'package:chat_app/features/sign_up/data/models/user_model.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeMessage extends StatelessWidget {
  final UserModel userModel;
  final String roomId;

  const WelcomeMessage({
    super.key,
    required this.userModel,
    required this.roomId,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          final welcomeMsg = MessageEntity(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            message: "Hello ${userModel.name}👋",
            createdAt: DateTime.now(),
            toId: userModel.uid,
            fromId: FirebaseAuth.instance.currentUser!.uid,
            type: "text",
            read: "", replyMessage: null,
          );

          context.read<MessageCubit>().sendMessage(welcomeMsg, roomId);
        },
        child: Card(
          color: ColorsDark.white.withOpacity(0.2),
          elevation: 3,
          shadowColor: context.color.textColor!.withOpacity(0.2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
          child: Padding(
            padding: EdgeInsets.all(20.r),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextWidget(text: "👋", textStyle: TextStyle(fontSize: FontDetails.fontSizeXL)),
                SizedBox(height: 10.h),
                CustomTextWidget(text:
                  "${"say_hello_to".tr()} ${userModel.name}",
                  textStyle: appTheme().textTheme.displayMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}