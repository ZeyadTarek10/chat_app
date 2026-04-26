import 'package:chat_app/core/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomMoreTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? trailing; 
  final VoidCallback? onTap;
  final Color? textColor;
  final Color? iconColor;

  const CustomMoreTile({
    super.key,
    required this.icon,
    required this.title,
    this.trailing,
    this.onTap,
    this.textColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      leading: Icon(icon, color: iconColor ?? AppColors.black, size: 24),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: textColor ?? AppColors.black,
        ),
      ),
      trailing: trailing ?? Icon(CupertinoIcons.chevron_right, color: AppColors.mainTextColor, size: 20),
      onTap: onTap,
    );
  }
}