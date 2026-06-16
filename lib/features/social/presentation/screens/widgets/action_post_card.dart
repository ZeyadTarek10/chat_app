import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/features/chats/presentation/manager/get_chats_cubit/get_chats_cubit.dart';
import 'package:chat_app/features/groups/presentation/manager/groups_cubit/groups_cubit.dart';
import 'package:chat_app/features/post_details/presentation/manager/comments_cubit/comments_cubit.dart';
import 'package:chat_app/features/profile/presentation/manager/cubit/profile_cubit.dart';
import 'package:chat_app/features/social/domain/entities/social_entity.dart';
import 'package:chat_app/features/social/presentation/manager/social_cubit/social_cubit.dart';
import 'package:chat_app/features/social/presentation/screens/widgets/comments_bottom_sheet.dart';
import 'package:chat_app/features/social/presentation/screens/widgets/share_post_bottom_sheet.dart';
import 'package:chat_app/injection_container.dart';
import 'package:chat_app/shared_widgets/custom_buttom_sheet.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActionPostCard extends StatelessWidget {
  final SocialEntity post;
  const ActionPostCard({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    var color = context.color;
    final currentUser = context.watch<ProfileCubit>().currentUser;
    bool isLiked =
        currentUser != null && post.likedBy.contains(currentUser.uid);
    return Row(
      children: [
        IconButton(
          onPressed: () {
            context.read<SocialCubit>().toggleLikePost(post, currentUser!.uid);
          },
          icon: Icon(
            isLiked ? Icons.favorite : Icons.favorite_border_outlined,
            color: isLiked ? Colors.red : color.textColor,
          ),
        ),
        SizedBox(width: 8.w),
        CustomTextWidget(
            text: '${post.likesCount}',
            textStyle: TextStyle(color: context.color.textColor)),
        SizedBox(width: 16.w),
        IconButton(
          onPressed: () {
            final profileCubit = context.read<ProfileCubit>();
            CustomBottomSheet.showModalBottomSheetContainer(
              context: context,
              backgroundColor: context.color.mainColor,
              widget: MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) =>
                        getIt<CommentsCubit>()..fetchComments(post.id),
                  ),
                  BlocProvider.value(
                    value: profileCubit,
                  ),
                ],
                child: CommentsBottomSheet(post: post),
              ),
            );
          },
          icon: Icon(
            Icons.chat_bubble_outline,
            color: context.color.textColor,
          ),
        ),
        SizedBox(width: 8.w),
        CustomTextWidget(
            text: '${post.commentsCount ?? 0}',
            textStyle: TextStyle(color: context.color.textColor)),
        SizedBox(width: 16.w),
        IconButton(
            onPressed: () {
              context.read<SocialCubit>().clearSentUserIds();
              CustomBottomSheet.showModalBottomSheetContainer(
                context: context,
                backgroundColor: context.color.navBarbg,
                widget: MultiBlocProvider(
                  providers: [
                    BlocProvider.value(
                      value: getIt<GetChatsCubit>()..fetchChats(),
                    ),
                    BlocProvider.value(
                      value: getIt<GroupsCubit>()..fetchGroups(),
                    ),
                    BlocProvider.value(value: getIt<SocialCubit>() 
                    ),
                  ],
                  child: SharePostBottomSheet(post: post),
                ),
              );
            },
            icon: Icon(
              Icons.send_outlined,
              color: context.color.textColor,
            )),
      ],
    );
  }
}
