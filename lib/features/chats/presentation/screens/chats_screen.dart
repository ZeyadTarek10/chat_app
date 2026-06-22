import 'package:chat_app/config/routes/app_routes.dart';
import 'package:chat_app/config/themes/app_theme.dart';
import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/app_images.dart';
import 'package:chat_app/core/utils/date_helper.dart';
import 'package:chat_app/features/chats/presentation/manager/get_chats_cubit/get_chats_cubit.dart';
import 'package:chat_app/features/chats/presentation/screens/widgets/chat_item.dart';
import 'package:chat_app/features/main/presentation/manager/main_cubit/main_cubit.dart';
import 'package:chat_app/shared_widgets/custom_loading.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetChatsCubit, GetChatsState>(
      builder: (context, state) {
        if (state is GetChatsLoading) {
          return const CustomLoading();
        }

        if (state is GetChatsSuccess) {
          final chats = state.chatsList;
          if (chats.isEmpty) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(AppImages.addFrind),
                CustomTextWidget(
                    text: "no_chats_yet_Add_a_friend".tr(),
                    textStyle: appTheme().textTheme.displayMedium),
              ],
            ));
          }
          final searchQuery =
              context.watch<MainCubit>().searchQuery.toLowerCase();
          final filteredChats = chats.where((chat) {
            final name =
                chat.friendName?.toLowerCase() ?? "unknown".tr().toLowerCase();
            return name.contains(searchQuery);
          }).toList();

          if (filteredChats.isEmpty) {
            return Center(
                child: Lottie.asset(AppImages.nonDataFound));
          }
          return RefreshIndicator(
            backgroundColor: context.color.navBarbg,
            color: ColorsDark.blueLight2,
            onRefresh: () async {
              await context.read<GetChatsCubit>().fetchChats();
            },
            child: ListView.builder(
              itemCount: filteredChats.length,
              padding: const EdgeInsets.only(top: 8, bottom: 20),
              itemBuilder: (context, index) {
                final chat = filteredChats[index];
                final myUid = FirebaseAuth.instance.currentUser!.uid;
                final friendId = chat.members?.firstWhere(
                      (id) => id != myUid,
                      orElse: () => "",
                    ) ??
                    "";

                return GestureDetector(
                  onTap: () {
                    GoRouter.of(context).push(
                      AppRoutes.message,
                      extra: {
                        'friendId': friendId,
                        'roomId': chat.id,
                      },
                    );
                  },
                  child: ChatsItem(
                    name: chat.friendName ?? "unknown".tr(),
                    image: chat.friendImage,
                    message: chat.lastMessage ?? '',
                    time: DateHelper.formatChatTime(chat.lastMessageTime),
                    unreadCount: chat.unreadCount ?? 0,
                  ),
                );
              },
            ),
          );
        }

        if (state is GetChatsError) {
          return Center(child: CustomTextWidget(text: state.errMsg));
        }

        return const SizedBox();
      },
    );
  }
}
