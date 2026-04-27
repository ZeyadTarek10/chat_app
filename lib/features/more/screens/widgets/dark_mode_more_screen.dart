import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/features/more/screens/manager/cubit/more_cubit.dart';
import 'package:chat_app/features/more/screens/widgets/custom_more_tile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

class DarkModeMoreScreen extends StatelessWidget {
  const DarkModeMoreScreen({
    super.key,
    required this.cubit,
  });

  final MoreCubit cubit;

  @override
  Widget build(BuildContext context) {
    return CustomMoreTile(
      icon: CupertinoIcons.moon,
      title: 'dark_mode'.tr(),
      trailing: CupertinoSwitch(
        value: cubit.isDarkMode,
        activeTrackColor: AppColors.backgroundColorbuttonblue1,
        onChanged: (val) => cubit.toggleSwitch('dark_mode', val),
      ),
    );
  }
}