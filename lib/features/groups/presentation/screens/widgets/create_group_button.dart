import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/features/groups/presentation/manager/groups_cubit/groups_cubit.dart';
import 'package:chat_app/shared_widgets/buttons/custom_linear_btn.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateGroupButton extends StatelessWidget {
  const CreateGroupButton({
    super.key,
    required this.cubit,
  });

  final GroupsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: CustomLinearButton(
        onPressed: () => cubit.submitGroup(),
        height: 50.h,
        width: double.infinity.w,
        child: CustomTextWidget(
          text: 'create_group'.tr(),
          textStyle: TextStyle(
            fontSize: FontDetails.fontSizeM,
            color: AppColors.white,
            fontWeight: FontDetails.boldFontWeight,
          ),
        ),
      ),
    );
  }
}

