import 'package:chat_app/features/message/presentation/manager/message_cubit/message_cubit.dart';
import 'package:chat_app/features/message/presentation/screens/widgets/app_bar_message.dart';
import 'package:chat_app/features/message/presentation/screens/widgets/app_bar_message2.dart';
import 'package:chat_app/features/message/presentation/screens/widgets/attachmenu_menu.dart';
import 'package:chat_app/features/message/presentation/screens/widgets/list_view_builder_message.dart';
import 'package:chat_app/features/message/presentation/screens/widgets/sending_messages_container.dart';
import 'package:chat_app/features/message/presentation/screens/widgets/welcom_message.dart';
import 'package:chat_app/features/sign_up/data/models/user_model.dart';
import 'package:chat_app/shared_widgets/custom_loading.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageScreen extends StatefulWidget {
  final String roomId;
  final String friendId;
  const MessageScreen({
    super.key,
    required this.roomId,
    required this.friendId,
  });

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  late MessageCubit messageCubit;

  @override
  void initState() {
    super.initState();
    messageCubit = context.read<MessageCubit>();
  }

  @override
  void dispose() {
    super.dispose();
    messageCubit.controller.dispose();
    messageCubit.controller0.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF0F0F3),
      appBar: AppBarMessage(context),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(child: BlocBuilder<MessageCubit, MessageState>(
                  buildWhen: (previous, current) {
                    return current is MessageLoadingState ||
                        current is MessageErrorState ||
                        current is MessageLoadedState;
                  },
                  builder: (context, state) {
                    if (state is MessageLoadingState) {
                      return const CustomLoading();
                    } else if (state is MessageErrorState) {
                      return Center(child: CustomTextWidget(text: state.errMsg));
                    }
                    if (state is MessageLoadedState) {
                      final messages = state.messages;
                      final friendData = state.friendData;
                
                      return Column(
                        children: [
                          if (friendData != null)
                            AppBarMessage2(
                              userModel: friendData as UserModel,
                            ),
                          Expanded(
                            child: messages.isEmpty
                                ? WelcomeMessage(
                                    userModel: friendData as UserModel,
                                    roomId: widget.roomId,
                                  )
                                : ListViewBuilderMessages(
                                    messageCubit: messageCubit,
                                    messages: messages,
                                    widget: widget),
                          ),
                        ],
                      );
                    }
                    return const SizedBox();
                  },
                ),),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: BlocBuilder<MessageCubit, MessageState>(
                    builder: (context, state) {
                      bool isMenuOpen = context.read<MessageCubit>().isMenuOpen;

                      if (isMenuOpen) {
                        return const AttachmentMenu();
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ],
            ),
          ),
          SendingMessagesContainer(messageCubit: messageCubit, widget: widget),
        ],
      ),
    );
  }
}
