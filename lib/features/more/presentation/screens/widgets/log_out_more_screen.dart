import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/widgets/user_dialogs.dart';
import 'package:chat_app/features/more/presentation/manager/more_cubit/more_cubit.dart';
import 'package:chat_app/features/more/presentation/screens/widgets/custom_more_tile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LogOutMoreScreen extends StatelessWidget {
  const LogOutMoreScreen({
    super.key,
    required this.cubit,
  });

  final MoreCubit cubit;

  @override
  Widget build(BuildContext context) {
    return CustomMoreTile(
      icon: Icons.logout_rounded,
      title: 'logout'.tr(),
      textColor: ColorsLight.red,
      iconColor: ColorsLight.red,
      trailing: const SizedBox(),
      onTap: () {
        CustomDialog.twoButtonDialog(
            context: context,
            textBody: 'log_out_from_app'.tr(),
            textButton1: 'yes'.tr(),
            textButton2: 'no'.tr(),
            onPressed: () {
              cubit.logout();
            },
            isLoading: false
        );
      },
    );
  }
}
