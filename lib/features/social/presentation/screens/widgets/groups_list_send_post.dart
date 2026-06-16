import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/features/groups/domain/entities/groups_entity.dart';
import 'package:chat_app/features/groups/presentation/manager/groups_cubit/groups_cubit.dart';
import 'package:chat_app/features/message_groups/presentation/manager/cubit/messege_group_cubit.dart';
import 'package:chat_app/features/social/domain/entities/social_entity.dart';
import 'package:chat_app/features/social/presentation/manager/social_cubit/social_cubit.dart';
import 'package:chat_app/features/social/presentation/screens/widgets/post_send_button.dart';
import 'package:chat_app/injection_container.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GroupsListSendPost extends StatelessWidget {
  final SocialEntity post;
  const GroupsListSendPost({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupsCubit, GroupsState>(
      builder: (context, state) {
        if (state is GroupsLoading) {
          return const Center(
              child: CircularProgressIndicator(color: ColorsDark.blueLight1));
        }

        if (state is GroupsLoaded) {
          final groupsList = state.groups;

          if (groupsList.isEmpty) {
            return Center(
                child: CustomTextWidget(
                    text: "no_groups_found".tr(),
                    textStyle: const TextStyle(color: Colors.grey)));
          }

          return ListView.separated(
            itemCount: groupsList.length,
            separatorBuilder: (context, index) => SizedBox(height: 12.h),
            itemBuilder: (context, index) {
              final GroupsEntity group = groupsList[index];

              final String groupId = group.id;
              final String groupName = group.name;
              final String groupImage =
                  (group.image.isNotEmpty) ? group.image.first : "";

              return Row(
                children: [
                  CircleAvatar(
                    radius: 24.r,
                    backgroundColor: context.color.circleAvatarBackgroundColor,
                    backgroundImage:
                        groupImage.isNotEmpty ? NetworkImage(groupImage) : null,
                    child: groupImage.isEmpty
                        ? CustomTextWidget(
                            text: groupName.isNotEmpty
                                ? groupName[0].toUpperCase()
                                : "",
                            textStyle:
                                const TextStyle(color: ColorsLight.white),
                          )
                        : null,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: CustomTextWidget(
                      text: groupName,
                      textStyle: TextStyle(
                          fontSize: FontDetails.fontSizeS,
                          fontWeight: FontWeight.bold,
                          color: context.color.textColor),
                    ),
                  ),
                  BlocBuilder<SocialCubit, SocialState>(
                    builder: (context, state) {
                      final sentIds = context.read<SocialCubit>().sentUserIds;
                      final bool isSent = sentIds.contains(groupId);

                      return PostSendButton(
                        isSent: isSent,
                        onSend: () async {
                          context.read<SocialCubit>().markPostAsSent(groupId);

                          await getIt<MessegeGroupCubit>()
                              .sendGroupPostShareMessage(
                            groupId: groupId,
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
