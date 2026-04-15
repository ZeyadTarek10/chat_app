import 'package:flutter/material.dart';
import 'package:flutter_helper/core/utils/app_colors.dart';
import 'package:flutter_helper/shared_widgets/custom_text.dart';

class KeepMeSignIn extends StatelessWidget {
  const KeepMeSignIn({super.key, required this.value, this.onChanged});
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
            side: const BorderSide(color: Colors.grey),
          ),
        ),
        const SizedBox(width: 8),
        CustomTextWidget(
            text: 'Keep me signed in',
            textStyle: TextStyle(fontSize: 14, color: AppColors.mainTextColor)),
      ],
    );
  }
}
