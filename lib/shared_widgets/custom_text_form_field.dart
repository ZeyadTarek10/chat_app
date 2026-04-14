import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/app_colors.dart';

class CustomTextFormFieldWidget extends StatelessWidget {
  const CustomTextFormFieldWidget(
      {super.key,
      required this.hint,
      this.suffixIcon,
      this.obscureText = false,
      this.withBorders = false,
      this.readOnly = false,
      this.textInputType,
      this.textInputAction,
      this.textAlign = TextAlign.start,
      this.fillColor,
      this.labelColor,
      this.hintColor,
      this.textColor,
      this.controller,
      this.onChange,
      required this.validator,
      this.prefixIcon,
      this.onEditingComplete});

  final TextEditingController? controller;
  final String hint;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool obscureText;
  final bool withBorders;
  final TextAlign textAlign;
  final FormFieldValidator<String> validator;
  final bool readOnly;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final Color? fillColor;
  final Color? hintColor;
  final Color? labelColor;
  final Color? textColor;
  final void Function(String)? onChange;
  final void Function()? onEditingComplete;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          readOnly: readOnly,
          obscureText: obscureText,
          controller: controller,
          keyboardType: textInputType,
          textInputAction: textInputAction,
          onChanged: onChange,
          textAlign: textAlign,
          textAlignVertical: TextAlignVertical.center,
          validator: validator,
          cursorColor: AppColors.mainColor,
          onEditingComplete: onEditingComplete,
          style: TextStyle(
            color: textColor ?? AppColors.mainColor,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            hintText: hint,
            hintStyle: TextStyle(
              color: hintColor ?? AppColors.mainTextColor,
            ),
            filled: fillColor != null,
            fillColor: fillColor,
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
            border: withBorders
                ? OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.mainColor, width: 0.5.w),
                    borderRadius: BorderRadius.circular(22.r),
                  )
                : OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(22.r),
                  ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.mainColor, width: 0.5.w),
              borderRadius: BorderRadius.circular(22.r),
            ),
            errorBorder: withBorders
                ? OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.error, width: 0.5.w),
                    borderRadius: BorderRadius.circular(22.r),
                  )
                : OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(22.r),
                  ),
            focusedErrorBorder: withBorders
                ? OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.error, width: 0.5.w),
                    borderRadius: BorderRadius.circular(22.r),
                  )
                : OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(22.r),
                  ),
          ),
        )
      ],
    );
  }
}
