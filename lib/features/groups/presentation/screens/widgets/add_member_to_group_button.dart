import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddMemberToGroupButton extends StatelessWidget {
  const AddMemberToGroupButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        color: ColorsDark.addMemberButtonLightBlue,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.add, color: ColorsDark.blueLight2),
          CustomTextWidget(
              text: "add_members_to_group".tr(),
              textStyle: const TextStyle(
                  color: ColorsDark.blueLight2)),
        ],
      ),
    );
  }
}

