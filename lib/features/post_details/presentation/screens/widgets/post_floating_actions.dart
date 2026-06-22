import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/features/chats/presentation/manager/get_chats_cubit/get_chats_cubit.dart';
import 'package:chat_app/features/groups/presentation/manager/groups_cubit/groups_cubit.dart';
import 'package:chat_app/features/post_details/presentation/screens/widgets/post_floating_button.dart';
import 'package:chat_app/features/profile/presentation/manager/cubit/profile_cubit.dart';
import 'package:chat_app/features/social/domain/entities/social_entity.dart';
import 'package:chat_app/features/social/presentation/manager/social_cubit/social_cubit.dart';
import 'package:chat_app/features/social/presentation/screens/widgets/posts/share_post_bottom_sheet.dart';
import 'package:chat_app/injection_container.dart';
import 'package:chat_app/shared_widgets/custom_buttom_sheet.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostFloatingActions extends StatelessWidget {
  final SocialEntity post;
  const PostFloatingActions({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final currentUser = context.watch<ProfileCubit>().currentUser;
    return BlocBuilder<SocialCubit, SocialState>(
      builder: (context, state) {
        SocialEntity currentPost = post;
        if (state is SocialLoaded) {
          final index = state.posts.indexWhere((p) => p.id == post.id);
          if (index != -1) {
            currentPost = state.posts[index];
          }
        }
        bool isLiked = currentUser != null &&
            currentPost.likedBy.contains(currentUser.uid);
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CircleAvatar(
              radius: 28.r,
              backgroundColor: context.color.circleAvatarBackgroundColor,
              child: (post.userImage != null && post.userImage!.isNotEmpty)
                  ? ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: post.userImage!,
                        width: 52.r,
                        height: 52.r,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Center(
                          child: CustomTextWidget(
                            text: post.userName.isNotEmpty
                                ? post.userName[0].toUpperCase()
                                : '',
                            textStyle: TextStyle(
                                color: ColorsLight.white, fontSize: 20.sp),
                          ),
                        ),
                        errorWidget: (context, url, error) => Center(
                          child: CustomTextWidget(
                            text: post.userName.isNotEmpty
                                ? post.userName[0].toUpperCase()
                                : '',
                            textStyle: TextStyle(
                                color: ColorsLight.white, fontSize: 20.sp),
                          ),
                        ),
                      ),
                    )
                  : CustomTextWidget(
                      text: post.userName.isNotEmpty
                          ? post.userName[0].toUpperCase()
                          : '',
                      textStyle:
                          TextStyle(color: ColorsLight.white, fontSize: 20.sp),
                    ),
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    if (currentUser != null) {
                      context
                          .read<SocialCubit>()
                          .toggleLikePost(currentPost, currentUser.uid);
                    }
                  },
                  child: PostFloatingButton(
                      icon: isLiked ? Icons.favorite : Icons.favorite_border,
                      iconColor:
                          isLiked ? Colors.red : context.color.textColor),
                ),
                SizedBox(width: 10.w),
                GestureDetector(
                  onTap: () {
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
                          BlocProvider.value(value: getIt<SocialCubit>()),
                        ],
                        child: SharePostBottomSheet(post: post),
                      ),
                    );
                  },
                  child: PostFloatingButton(
                      icon: Icons.send_outlined,
                      iconColor: context.color.textColor),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
