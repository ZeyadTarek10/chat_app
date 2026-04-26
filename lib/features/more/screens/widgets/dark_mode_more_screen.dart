import 'package:chat_app/features/more/screens/manager/cubit/more_cubit.dart';
import 'package:chat_app/features/more/screens/widgets/custom_more_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      title: 'Dark Mode',
      trailing: CupertinoSwitch(
        value: cubit.isDarkMode,
        activeTrackColor: Colors.blue,
        onChanged: (val) => cubit.toggleSwitch('dark_mode', val),
      ),
    );
  }
}