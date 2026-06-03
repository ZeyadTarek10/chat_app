import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/features/groups/domain/entities/groups_entity.dart';
import 'package:chat_app/shared_widgets/custom_loading.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GroupMembersBottomSheet extends StatelessWidget {
  final GroupsEntity group;

  const GroupMembersBottomSheet({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomTextWidget(
          text: 'group_members'.tr(),
          textStyle: TextStyle(
            fontSize: FontDetails.fontSizeM,
            fontWeight: FontDetails.boldFontWeight,
            color: context.color.textColor,
          ),
        ),
        SizedBox(height: 16.h),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: group.memberNames.length,
          itemBuilder: (context, index) {
            String memberName = group.memberNames[index];
            String memberImage =
                index < group.image.length ? group.image[index] : "";
            String memberId = group.members[index];
            bool isAdmin = group.adminsId.contains(memberId);

            return ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                radius: 21.5.r,
                backgroundColor: ColorsDark.white,
                child: CircleAvatar(
                  radius: 20.r,
                  backgroundColor: context.color.circleAvatarBackgroundColor,
                  child: (memberImage.isNotEmpty)
                      ? ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: memberImage,
                            width: 40.r,
                            height: 40.r,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Center(
                              child: CustomLoading()
                            ),
                            errorWidget: (context, url, error) => Center(
                              child: CustomTextWidget(
                                text: memberName.isNotEmpty
                                    ? memberName[0].toUpperCase()
                                    : '',
                                textStyle: TextStyle(
                                    color: ColorsLight.white, fontSize: 18.sp),
                              ),
                            ),
                          ),
                        )
                      : CustomTextWidget(
                          text: memberName.isNotEmpty
                              ? memberName[0].toUpperCase()
                              : '',
                          textStyle: TextStyle(
                              color: ColorsLight.white, fontSize: 18.sp),
                        ),
                ),
              ),
              title: CustomTextWidget(
                text: memberName,
                textStyle: TextStyle(
                  color: context.color.textColor,
                  fontSize: FontDetails.fontSizeS,
                  fontWeight: FontDetails.boldFontWeight,
                ),
              ),
              trailing: isAdmin
                  ? Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: ColorsDark.blueLight1.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                            color: ColorsDark.blueLight1.withOpacity(0.3)),
                      ),
                      child: CustomTextWidget(
                        text: 'admin'.tr(),
                        textStyle: TextStyle(
                          color: ColorsDark.blueLight1,
                          fontSize: FontDetails.fontSizeXS,
                          fontWeight: FontDetails.semiBoldFontWeight,
                        ),
                      ),
                    )
                  : CustomTextWidget(
                      text: 'member'.tr(),
                      textStyle: TextStyle(
                        color: ColorsLight.mainTextColor,
                        fontSize: FontDetails.fontSizeXS,
                        fontWeight: FontDetails.regularFontWeight,
                      ),
                    ),
            );
          },
        ),
      ],
    );
  }
}
