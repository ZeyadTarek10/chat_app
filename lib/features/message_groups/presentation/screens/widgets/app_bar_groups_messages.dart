import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/features/groups/domain/entities/groups_entity.dart';
import 'package:chat_app/features/message_groups/presentation/screens/widgets/group_members_bottom_sheet.dart';
import 'package:chat_app/features/message_groups/presentation/screens/widgets/stack_app_bar_images.dart';
import 'package:chat_app/shared_widgets/custom_buttom_sheet.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBarGroupsMessages extends StatelessWidget {
  final GroupsEntity group;
  const AppBarGroupsMessages({
    super.key,
    required this.group,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: context.color.mainColor,
      ),
      child: Row(
        children: [
          InkWell(
              onTap: () {
                CustomBottomSheet.showModalBottomSheetContainer(
                  context: context,
                  backgroundColor: context.color.mainColor,
                  widget: GroupMembersBottomSheet(group: group),
                );
              },
              borderRadius: BorderRadius.circular(20.r),
              child: StackAppBarImages(group: group)),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextWidget(
                  text: group.name,
                  textStyle: TextStyle(
                      color: context.color.textColor,
                      fontWeight: FontDetails.boldFontWeight,
                      fontSize: FontDetails.fontSizeM),
                ),
                CustomTextWidget(
                  text: '${group.members.length} members',
                  textStyle: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: FontDetails.fontSizeXS),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.videocam_outlined,
                color: context.color.textColor, size: 26.sp),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.call_outlined,
                color: context.color.textColor, size: 22.sp),
          ),
        ],
      ),
    );
  }
}
