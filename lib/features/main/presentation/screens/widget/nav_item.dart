import 'package:chat_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class NavItem extends StatelessWidget {
  final int index;
  final IconData icon;
  final String label;
  final int currentScreen;
  final VoidCallback onTap;

  const NavItem({
    super.key,
    required this.index,
    required this.icon,
    required this.label,
    required this.currentScreen,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    bool isSelected = currentScreen == index;

    return Expanded(
      child: GestureDetector(
        // behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
          gradient:   isSelected
      ? LinearGradient(
          colors: [
            AppColors.backgroundColorbuttonblue1,
            AppColors.backgroundColorbuttonblue2,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )
      : const LinearGradient(
          colors: [
            Colors.transparent,
            Colors.transparent,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isSelected ? AppColors.white : AppColors.mainTextColor,
                size: 24,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? AppColors.white : AppColors.mainTextColor,
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
