import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/features/social/domain/entities/social_entity.dart';
import 'package:chat_app/features/social/presentation/screens/widgets/chats_list_send_post.dart';
import 'package:chat_app/features/social/presentation/screens/widgets/groups_list_send_post.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SharePostBottomSheet extends StatelessWidget {
  final SocialEntity post;

  const SharePostBottomSheet({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Container(
        height: 600.h,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: context.color.navBarbg,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CustomTextWidget(
                text: "share_with".tr(),
                textStyle: TextStyle(
                  fontSize: FontDetails.fontSizeL,
                  fontWeight: FontWeight.bold,
                  color: context.color.textColor,
                ),
              ),
            ),
            SizedBox(height: 16.h),
            TabBar(
              labelColor: ColorsDark.blueLight1,
              unselectedLabelColor: ColorsLight.mainTextColor,
              indicatorColor: ColorsDark.blueLight1,
              tabs: [
                Tab(text: 'chats'.tr()),
                Tab(text: 'groups'.tr()),
              ],
            ),
            SizedBox(height: 12.h),
            Expanded(
              child: TabBarView(
                children: [
                  ChatsListSendPost(post: post),
                  GroupsListSendPost(post: post),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
