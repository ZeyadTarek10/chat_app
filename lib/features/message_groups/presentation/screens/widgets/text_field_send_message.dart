import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/shared_widgets/custom_text_form_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TextFieldSendMessage extends StatelessWidget {
  const TextFieldSendMessage({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormFieldWidget(
      fillColor: context.color.textColor!.withOpacity(0.1),
      controller: controller,
      hint: 'type_a_message'.tr(),
      validator: (String? value) {
        return null;
      },
      hintColor: ColorsLight.mainTextColor,
      withBorders: false,
    );
  }
}
