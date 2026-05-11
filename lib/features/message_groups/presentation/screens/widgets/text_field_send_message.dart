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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: CustomTextFormFieldWidget(
        fillColor: AppColors.mainTextColor.withOpacity(0.1),
        controller: controller,
        hint: 'type_a_message'.tr(),
        validator: (String? value) {
          return null;
        },
        hintColor: AppColors.mainTextColor,
        withBorders: false,
      ),
    );
  }
}
