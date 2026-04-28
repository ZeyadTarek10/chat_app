import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/features/message/presentation/screens/widgets/app_bar_message.dart';
import 'package:chat_app/features/message/presentation/screens/widgets/app_bar_message2.dart';
import 'package:chat_app/features/message/presentation/screens/widgets/attachmenu_menu.dart';
import 'package:chat_app/features/message/presentation/screens/widgets/list_view_builder_message.dart';
import 'package:chat_app/features/message/presentation/screens/widgets/send_icon.dart';
import 'package:chat_app/shared_widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final TextEditingController controller = TextEditingController();
  final ScrollController controller0 = ScrollController();
  bool isMenuOpen = false;

  List<Map<String, dynamic>> dummyMessages = [
    {
      "text": "No problem at all!\nI'll be there in about 15 minutes.",
      "time": "10:11",
      "isMe": false
    },
    {
      "text":
          "Awesome, thanks for letting me know!\nCan't wait for my delivery. 🎉",
      "time": "10:11",
      "isMe": true
    },
    {"text": "Hi!", "time": "10:10", "isMe": true},
    {
      "text":
          "This is your delivery driver from Speedy Chow. I'm just around the corner from your place. 😊",
      "time": "10:10",
      "isMe": false
    },
  ];

  @override
  void dispose() {
    controller.dispose();
    controller0.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF0F0F3),
      appBar: AppBarMessage(context),
      body: Column(
        children: [
          const AppBarMessage2(),
          Expanded(
            child: ListViewBuilderMessage(
                controller0: controller0, dummyMessages: dummyMessages),
          ),
          if (isMenuOpen) const AttachmentMenu(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            color: AppColors.white,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      isMenuOpen = !isMenuOpen;
                    });
                  },
                  icon: Icon(Icons.add,
                      color: AppColors.backgroundColorbuttonblue1,
                      size: FontDetails.fontSizeL),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: CustomTextFormFieldWidget(
                      fillColor: AppColors.mainTextColor.withOpacity(0.1),
                      controller: controller,
                      onChange: (value) => sendMessage(),
                      hint: 'Type a message',
                      hintColor: AppColors.mainTextColor,
                      withBorders: false,
                      validator: (value) {
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                InkWell(
                  onTap: sendMessage,
                  child: const SendIcon(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void sendMessage() {
    if (controller.text.isNotEmpty) {
      setState(() {
        dummyMessages.insert(0, {
          "text": controller.text,
          "time": "10:12",
          "isMe": true,
        });
      });
      controller.clear();
      controller0.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }
}

