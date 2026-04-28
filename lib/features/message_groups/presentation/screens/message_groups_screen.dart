import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/features/message/presentation/screens/widgets/app_bar_message.dart';
import 'package:chat_app/features/message/presentation/screens/widgets/attachmenu_menu.dart';
import 'package:chat_app/features/message/presentation/screens/widgets/send_icon.dart';
import 'package:chat_app/features/message_groups/presentation/screens/widgets/app_bar_groups_messages.dart';
import 'package:chat_app/features/message_groups/presentation/screens/widgets/list_view_group_message_buble.dart';
import 'package:chat_app/features/message_groups/presentation/screens/widgets/text_field_send_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageGroupsScreen extends StatefulWidget {
  const MessageGroupsScreen({super.key});

  @override
  State<MessageGroupsScreen> createState() => _MessageGroupsScreenState();
}

class _MessageGroupsScreenState extends State<MessageGroupsScreen> {
  final TextEditingController controller = TextEditingController();
  final ScrollController controller0 = ScrollController();

  bool isMenuOpen = false;

  List<Map<String, dynamic>> dummyMessages = [
    {
      "text": "Great! 😊",
      "time": "10:20",
      "isMe": true,
    },
    {
      "text": "Oh!\nThey fixed it and upgraded the security further. 🚀",
      "time": "10:14",
      "isMe": false,
      "senderName": "Edward Davidson",
      "avatar":
          "https://img.freepik.com/free-photo/handsome-confident-smiling-man-with-hands-crossed-chest_176420-18743.jpg",
    },
    {
      "text": "Does this update fix error 352 for the Engineer character?",
      "time": "10:11",
      "isMe": false,
      "senderName": "David Wayne",
      "avatar":
          "https://upload.wikimedia.org/wikipedia/commons/thumb/2/23/Jimmy_Wales_Fundraiser_Appeal_edit.jpg/250px-Jimmy_Wales_Fundraiser_Appeal_edit.jpg",
    },
    {
      "text":
          "Great, thanks for letting me know!\nI really look forward to experiencing it soon. 🎉",
      "time": "10:11",
      "isMe": true,
    },
    {
      "text": "Hi!",
      "time": "10:10",
      "isMe": true,
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
          const AppBarGroupsMessages(),
          Expanded(
            child: ListViewGroupMessageBuble(
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
                      color: AppColors.backgroundColorbuttonblue1, size: 28.sp),
                ),
                Expanded(
                  child: TextFieldSendMessage(controller: controller),
                ),
                SizedBox(width: 12.w),
                InkWell(onTap: sendMessage, child: const SendIcon()),
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



