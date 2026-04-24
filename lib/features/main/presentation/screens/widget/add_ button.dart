import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/features/main/presentation/manager/main_cubit/main_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  const AddButton({
    super.key,
    required this.cubit,
  });

  final MainCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: PopupMenuButton<String>(
        icon: cubit.isMenuOpen
            ? Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.close, color: AppColors.white),
              )
            : Icon(Icons.add, color: AppColors.white, size: 28),
        offset: const Offset(0, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: AppColors.white,
        elevation: 8,
        onOpened: () => cubit.toggleMenuState(true),
        onCanceled: () => cubit.toggleMenuState(false),
        onSelected: (value) {
          cubit.toggleMenuState(false);
          if (value == 'add_friend') {
          } else if (value == 'create_group') {
          }
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          PopupMenuItem<String>(
            value: 'add_friend',
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Row(
              children: [
                Icon(CupertinoIcons.person_add, color: AppColors.mainTextColor, size: 26),
                const SizedBox(width: 16),
                Text(
                  'Add Friend',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
          ),
          PopupMenuItem<String>(
            value: 'create_group',
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Row(
              children: [
                Icon(CupertinoIcons.group, color: AppColors.mainTextColor, size: 26),
                const SizedBox(width: 16),
                Text(
                  'Create Group',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}