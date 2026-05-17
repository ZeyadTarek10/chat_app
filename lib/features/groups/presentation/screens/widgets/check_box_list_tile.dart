import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/services/animate_do.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/features/groups/presentation/manager/groups_cubit/groups_cubit.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';

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
    return CustomFadeInRight(
      duration: 400,
      child: CheckboxListTile(
        value: contact['selected'],
        title: CustomTextWidget(
            text: contact['name'],
            textStyle: TextStyle(color: context.color.textColor)),
        subtitle: CustomTextWidget(
            text: contact['phone'],
            textStyle: TextStyle(color: context.color.textColor)),
        secondary: CircleAvatar(
          backgroundColor: ColorsDark.blueDark.withOpacity(0.5),
          backgroundImage: imageUrl.isNotEmpty ? NetworkImage(imageUrl) : null,
          child: imageUrl.isEmpty
              ? CustomTextWidget(
                  text: initial,
                  textStyle: TextStyle(
                      color: ColorsDark.white,
                      fontWeight: FontDetails.boldFontWeight))
              : null,
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
