import 'package:chat_app/features/more/screens/manager/cubit/more_cubit.dart';
import 'package:chat_app/features/more/screens/widgets/custom_more_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      title: 'Mute Notification',
      trailing: CupertinoSwitch(
        value: cubit.isMuteNotification,
        activeTrackColor: Colors.blue,
        onChanged: (val) => cubit.toggleSwitch('mute_notif', val),
      ),
    );
  }
}