import 'package:chat_app/features/more/screens/manager/cubit/more_cubit.dart';
import 'package:chat_app/features/more/screens/widgets/custom_more_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HideChatHistoryMoreScreen extends StatelessWidget {
  const HideChatHistoryMoreScreen({
    super.key,
    required this.cubit,
  });

  final MoreCubit cubit;

  @override
  Widget build(BuildContext context) {
    return CustomMoreTile(
      icon: CupertinoIcons.eye_slash,
      title: 'Hide Chat History',
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CupertinoSwitch(
            value: cubit.isHideChatHistory,
            activeTrackColor: Colors.blue,
            onChanged: (val) => cubit.toggleSwitch('hide_chat', val),
          ),
          const SizedBox(width: 8),
          const Icon(CupertinoIcons.chevron_right,
              color: Colors.grey, size: 20),
        ],
      ),
    );
  }
}