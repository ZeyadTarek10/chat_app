import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/services/animate_do.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/features/groups/presentation/manager/groups_cubit/groups_cubit.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckBoxListTile extends StatelessWidget {
  const CheckBoxListTile({
    super.key,
    required this.contact,
    required this.imageUrl,
    required this.initial,
    required this.cubit, required this.index,
  });

  final Map<String, dynamic> contact;
  final String imageUrl;
  final String initial;
  final GroupsCubit cubit;
  final int index;

  @override
  Widget build(BuildContext context) {
    String countryCode = contact['country_code'] ?? '+20';
    String phone = contact['phone'] ?? '';
    String fullPhone = '\u202A($countryCode) $phone\u202C';
    return CustomFadeInRight(
      duration: 400,
      child: CheckboxListTile(
        value: contact['selected'],
        title: CustomTextWidget(
            text: contact['name'],
            textStyle: TextStyle(color: context.color.textColor, fontSize: FontDetails.fontSizeS, fontWeight: FontDetails.semiBoldFontWeight)),
        subtitle: CustomTextWidget(
            text: fullPhone,
            textStyle: TextStyle(color: context.color.textColor)),
        secondary: CircleAvatar(
          radius: 22.r,
          backgroundColor: context.color.circleAvatarBackgroundColor,
          child: (imageUrl.isNotEmpty)
            ? ClipOval(
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  width: 52.r,
                  height: 52.r,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Center(
                    child: CustomTextWidget(
                      text: contact['name'].isNotEmpty ? contact['name'][0].toUpperCase() : '',
                      textStyle:
                          TextStyle(color: ColorsLight.white, fontSize: 20.sp),
                    ),
                  ),
                  errorWidget: (context, url, error) => Center(
                    child: CustomTextWidget(
                      text: contact['name'].isNotEmpty ? contact['name'][0].toUpperCase() : '',
                      textStyle:
                          TextStyle(color: ColorsLight.white, fontSize: 20.sp),
                    ),
                  ),
                ),
              )
            : CustomTextWidget(
                text: contact['name'].isNotEmpty ? contact['name'][0].toUpperCase() : '',
                textStyle: TextStyle(color: ColorsLight.white, fontSize: 20.sp),
              ),
        ),
        onChanged: (val) {
          cubit.toggleContact(index, val ?? false);
        },
        activeColor: ColorsDark.blueLight1,
        checkboxShape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(5)),
      ),
    );
  }
}
