import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/features/groups/domain/entities/groups_entity.dart';
import 'package:chat_app/features/message/presentation/screens/widgets/attachmenu_menu.dart';
import 'package:chat_app/features/message/presentation/screens/widgets/send_icon.dart';
import 'package:chat_app/features/message_groups/presentation/manager/cubit/messege_group_cubit.dart';
import 'package:chat_app/features/message_groups/presentation/screens/widgets/app_bar_groups_messages.dart';
import 'package:chat_app/features/message_groups/presentation/screens/widgets/app_bar_groups_messages2.dart';
import 'package:chat_app/features/message_groups/presentation/screens/widgets/list_view_group_message_buble.dart';
import 'package:chat_app/features/message_groups/presentation/screens/widgets/text_field_send_message.dart';
import 'package:chat_app/shared_widgets/custom_loading.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageGroupsScreen extends StatefulWidget {
  final GroupsEntity group;
  const MessageGroupsScreen({super.key, required this.group});

  @override
  State<MessageGroupsScreen> createState() => _MessageGroupsScreenState();
}

class _MessageGroupsScreenState extends State<MessageGroupsScreen> {
  late MessegeGroupCubit messegeGroupCubit;

  @override
  void initState() {
    super.initState();
    messegeGroupCubit = context.read<MessegeGroupCubit>();
  }

  @override
  void dispose() {
    super.dispose();
    messegeGroupCubit.controller.dispose();
    messegeGroupCubit.controller0.dispose();
  }

  void sendMessage() {
    if (messegeGroupCubit.controller.text.trim().isNotEmpty) {
      context.read<MessegeGroupCubit>().sendMessage(
            messegeGroupCubit.controller.text.trim(),
            widget.group.id,
          );
      messegeGroupCubit.controller.clear();

      if (messegeGroupCubit.controller0.hasClients) {
        messegeGroupCubit.controller0.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.color.chatBackgroundColor,
      appBar: AppBarGroupsMessages2(context),
      body: BlocBuilder<MessegeGroupCubit, MessegeGroupState>(
        builder: (context, state) {
          return Column(
            children: [
              AppBarGroupsMessages(group: widget.group),
              Expanded(
                  child: Stack(fit: StackFit.expand, children: [
                if (state is MessegeGroupLoaded)
                  if (state.messages.isEmpty)
                    Center(child: CustomTextWidget(text: "start_chatting".tr(), textStyle: TextStyle(color: context.color.textColor, fontWeight: FontDetails.boldFontWeight,fontSize: FontDetails.fontSizeM),))
                  else
                    ListViewGroupMessageBuble(
                      controller0: messegeGroupCubit.controller0,
                      messages: state.messages,
                      group: widget.group,
                    )
                else if (state is MessegeGroupError)
                  Center(child: CustomTextWidget(text: state.error))
                else
                  const CustomLoading(),
                if (messegeGroupCubit.isMenuOpen)
                  const Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: AttachmentMenu(),
                  ),
              ])),
              Container(
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
                          messegeGroupCubit.toggleMenu();
                        },
                        icon: Icon(Icons.add,
                            color: ColorsDark.blueLight1,
                            size: 28.sp),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: TextFieldSendMessage(
                          controller: messegeGroupCubit.controller),
                    ),
                    SizedBox(width: 12.w),
                    InkWell(onTap: sendMessage, child: const SendIcon()),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
