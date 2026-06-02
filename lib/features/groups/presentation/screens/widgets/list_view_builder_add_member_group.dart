import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/services/animate_do.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/features/groups/presentation/manager/groups_cubit/groups_cubit.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListViewBuilderAddMemberGroup extends StatelessWidget {
  const ListViewBuilderAddMemberGroup({
    super.key,
    required this.cubit,
  });

  final GroupsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cubit.selectedMembers.length,
      itemBuilder: (context, index) {
        var member = cubit.selectedMembers[index];
        String countryCode = member['country_code'] ?? '+20';
    String phone = member['phone'] ?? '';
    String fullPhone = '\u202A($countryCode) $phone\u202C';
        return CustomFadeInRight(
          duration: 400,
          child: ListTile(
            leading: CircleAvatar(
              radius: 22.r,
              backgroundColor: ColorsDark.backgroundColorCircleButtonblue3,
              child: (member['image'] != null && member['image']!.isNotEmpty)
                  ? ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: member['image']!,
                        width: 52.r,
                        height: 52.r,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Center(
                          child: CustomTextWidget(
                            text: member['name'].isNotEmpty
                                ? member['name'][0].toUpperCase()
                                : '',
                            textStyle: TextStyle(
                                color: ColorsLight.white, fontSize: 20.sp),
                          ),
                        ),
                        errorWidget: (context, url, error) => Center(
                          child: CustomTextWidget(
                            text: member['name'].isNotEmpty
                                ? member['name'][0].toUpperCase()
                                : '',
                            textStyle: TextStyle(
                                color: ColorsLight.white, fontSize: 20.sp),
                          ),
                        ),
                      ),
                    )
                  : CustomTextWidget(
                      text: member['name'].isNotEmpty
                          ? member['name'][0].toUpperCase()
                          : '',
                      textStyle:
                          TextStyle(color: ColorsLight.white, fontSize: 20.sp),
                    ),
            ),
            title: CustomTextWidget(
                text: member['name']!,
                textStyle: TextStyle(color: context.color.textColor, fontSize: FontDetails.fontSizeS, fontWeight: FontDetails.semiBoldFontWeight)),
            subtitle: CustomTextWidget(
                text: fullPhone,
                textStyle: TextStyle(color: context.color.textColor)),
            trailing: Container(
              height: 35.h,
              decoration: BoxDecoration(
                color: ColorsDark.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(Icons.close, color: ColorsLight.red, size: 20.sp),
                onPressed: () {
                  cubit.removeMember(index);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
