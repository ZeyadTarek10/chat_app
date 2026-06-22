import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/date_helper.dart';
import 'package:chat_app/features/profile/presentation/manager/cubit/profile_cubit.dart';
import 'package:chat_app/features/social/domain/entities/social_entity.dart';
import 'package:chat_app/features/social/presentation/screens/widgets/posts/popup_menu_button_post_card.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListTilePostCard extends StatelessWidget {
  final SocialEntity post;
  const ListTilePostCard({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    final currentUser = context.watch<ProfileCubit>().currentUser;

    final bool isMyPost = currentUser != null && currentUser.uid == post.userId;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: context.color.circleAvatarBackgroundColor,
        radius: 22.r,
        child: CircleAvatarAcout(post: post),
      ),
      title: CustomTextWidget(
          text: post.userName,
          textStyle: TextStyle(
              fontWeight: FontWeight.bold, color: context.color.textColor)),
      subtitle: CustomTextWidget(
          text: DateHelper.getShortLocation(post.location),
          textStyle: TextStyle(color: context.color.textColor)),
      trailing: isMyPost
          ? PopupMenuButtonPostCard(post: post)
          : const SizedBox.shrink(),
    );
  }
}

class CircleAvatarAcout extends StatelessWidget {
  const CircleAvatarAcout({
    super.key,
    required this.post,
  });

  final SocialEntity post;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 20.r,
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
    );
  }
}
