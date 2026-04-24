import 'package:chat_app/features/more/screens/manager/cubit/more_cubit.dart';
import 'package:chat_app/features/more/screens/widgets/custom_more_tile.dart';
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
      icon: Icons.logout,
      title: 'Logout',
      textColor: Colors.redAccent,
      iconColor: Colors.redAccent,
      trailing: const SizedBox(),
      onTap: () {
        cubit.logout();
      },
    );
  }
}