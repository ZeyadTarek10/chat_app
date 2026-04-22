import 'package:flutter/material.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';

class CheckBoxSignUp extends StatelessWidget {
  const CheckBoxSignUp({super.key, required this.value, this.onChanged});

  final bool value;
  final void Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 24,
          width: 24,
          child: Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF4ADE80),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            side: BorderSide(color: AppColors.mainTextColor, width: 1.5),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: CustomTextWidget(
              text: 'By Creating an Account, I accept Hiring Hub terms of Use and Privacy Policy',
              textStyle: TextStyle(fontSize: 14, color: AppColors.mainTextColor)),
        ),
      ],
    );
  }
}
