import 'package:chat_app/core/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchItemAppBar extends StatelessWidget {
  const SearchItemAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        autofocus: true, 
        decoration: InputDecoration(
          hintText: 'Search...',
          hintStyle: TextStyle(color: AppColors.hintColor),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          prefixIcon: Icon(CupertinoIcons.search, color: AppColors.mainTextColor, size: 20),
        ),
        onChanged: (value) {
        },
      ),
    );
  }
}