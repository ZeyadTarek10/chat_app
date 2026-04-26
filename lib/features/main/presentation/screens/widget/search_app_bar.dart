import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/features/main/presentation/manager/main_cubit/main_cubit.dart';
import 'package:chat_app/features/main/presentation/screens/widget/search_item_app_bar.dart';
import 'package:flutter/material.dart';

class SearchAppBar extends StatelessWidget {
  const SearchAppBar({
    super.key,
    required this.cubit,
  });

  final MainCubit cubit;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.mainColor, 
      elevation: 0,
      automaticallyImplyLeading: false, 
      title: const SearchItemAppBar(),
      actions: [
        IconButton(
          icon: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.close, color: AppColors.white),
                ),
          onPressed: () {
            cubit.toggleSearch(); 
          },
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}