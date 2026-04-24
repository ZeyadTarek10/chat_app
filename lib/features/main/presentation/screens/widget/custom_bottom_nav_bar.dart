import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/features/main/presentation/screens/widget/nav_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentScreen;
  final Function(int) onTabTapped;

  const CustomBottomNavBar({
    super.key,
    required this.currentScreen,
    required this.onTabTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NavItem(
              index: 0,
              icon: CupertinoIcons.chat_bubble_text_fill,
              label: 'Chats',
              currentScreen: currentScreen,
              onTap: () => onTabTapped(0),
            ),
            NavItem(
              index: 1,
              icon: CupertinoIcons.group,
              label: 'Groups',
              currentScreen: currentScreen,
              onTap: () => onTabTapped(1),
            ),
            NavItem(
              index: 2,
              icon: Icons.account_circle_outlined,
              label: 'Profile',
              currentScreen: currentScreen,
              onTap: () => onTabTapped(2),
            ),
            NavItem(
              index: 3,
              icon: Icons.menu,
              label: 'More',
              currentScreen: currentScreen,
              onTap: () => onTabTapped(3),
            ),
          ],
        ),
      ),
    );
  }
}
