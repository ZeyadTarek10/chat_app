import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/features/more/screens/manager/cubit/more_cubit.dart';
import 'package:chat_app/features/more/screens/widgets/custom_more_tile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

class MuteNtificationMoreScreen extends StatelessWidget {
  const MuteNtificationMoreScreen({
    super.key,
    required this.cubit,
  });

  final MoreCubit cubit;

  @override
  Widget build(BuildContext context) {
    return CustomMoreTile(
      icon: CupertinoIcons.volume_off,
      title: 'mute_notification'.tr(),
      trailing: CupertinoSwitch(
        value: cubit.isMuteNotification,
        activeTrackColor: AppColors.backgroundColorbuttonblue1,
        onChanged: (val) => cubit.toggleSwitch('mute_notif', val),
      ),
    );
  }
}