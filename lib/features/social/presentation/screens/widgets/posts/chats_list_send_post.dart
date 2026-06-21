import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/features/chats/domain/entities/chats_entity.dart';
import 'package:chat_app/features/chats/presentation/manager/get_chats_cubit/get_chats_cubit.dart';
import 'package:chat_app/features/message/presentation/manager/message_cubit/message_cubit.dart';
import 'package:chat_app/features/social/domain/entities/social_entity.dart';
import 'package:chat_app/features/social/presentation/manager/social_cubit/social_cubit.dart';
import 'package:chat_app/features/social/presentation/screens/widgets/posts/post_send_button.dart';
import 'package:chat_app/injection_container.dart';
import 'package:chat_app/shared_widgets/custom_loading.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatsListSendPost extends StatelessWidget {
  final SocialEntity post;
  const ChatsListSendPost({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetChatsCubit, GetChatsState>(
      builder: (context, state) {
        if (state is GetChatsLoading) {
          return const Center(
              child: CustomLoading());
        }

        if (state is GetChatsSuccess) {
          final chatsList = state.chatsList;

          if (chatsList.isEmpty) {
            return Center(
                child: CustomTextWidget(
                    text: "no_chats_found".tr(),
                    textStyle: const TextStyle(color: ColorsLight.mainTextColor)));
          }

          return ListView.separated(
            itemCount: chatsList.length,
            separatorBuilder: (context, index) => SizedBox(height: 12.h),
            itemBuilder: (context, index) {
              final ChatsEntity chat = chatsList[index];

              final String roomId = chat.id ?? "";
              final String friendName = chat.friendName ?? "unknown".tr();
              final myUid = FirebaseAuth.instance.currentUser!.uid;
              final friendId = chat.members
                      ?.firstWhere((id) => id != myUid, orElse: () => "") ??
                  "";

              return Row(
                children: [
                  CircleAvatar(
                    radius: 24.r,
                    backgroundColor: context.color.circleAvatarBackgroundColor,
                    child: (chat.friendImage != null &&
                            chat.friendImage!.isNotEmpty)
                        ? ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: chat.friendImage!,
                              width: 52.r,
                              height: 52.r,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Center(
                                child: CustomTextWidget(
                                  text: friendName.isNotEmpty
                                      ? friendName[0].toUpperCase()
                                      : '',
                                  textStyle: TextStyle(
                                      color: ColorsLight.white,
                                      fontSize: 20.sp),
                                ),
                              ),
                              errorWidget: (context, url, error) => Center(
                                child: CustomTextWidget(
                                  text: friendName.isNotEmpty
                                      ? friendName[0].toUpperCase()
                                      : '',
                                  textStyle: TextStyle(
                                      color: ColorsLight.white,
                                      fontSize: 20.sp),
                                ),
                              ),
                            ),
                          )
                        : CustomTextWidget(
                            text: friendName.isNotEmpty
                                ? friendName[0].toUpperCase()
                                : '',
                            textStyle: TextStyle(
                                color: ColorsLight.white, fontSize: 20.sp),
                          ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: CustomTextWidget(
                      text: friendName,
                      textStyle: TextStyle(
                          fontSize: FontDetails.fontSizeS,
                          fontWeight: FontWeight.bold,
                          color: context.color.textColor),
                    ),
                  ),
                  BlocBuilder<SocialCubit, SocialState>(
                    builder: (context, sentIds) {
                      final sentIds = context.read<SocialCubit>().sentUserIds;
                      final bool isSent = sentIds.contains(friendId);

                      return PostSendButton(
                        isSent: isSent,
                        onSend: () async {
                          context.read<SocialCubit>().markPostAsSent(friendId);

                          await getIt<MessageCubit>().sendPostShareMessage(
                            roomId: roomId,
                            friendId: friendId,
                            post: post,
                          );
                        },
                      );
                    },
                  ),
                ],
              );
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
