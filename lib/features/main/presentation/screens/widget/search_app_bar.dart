import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/app_images.dart';
import 'package:chat_app/features/main/presentation/manager/main_cubit/main_cubit.dart';
import 'package:chat_app/features/main/presentation/screens/widget/search_item_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchAppBar extends StatelessWidget {
  const SearchAppBar({
    super.key,
    required this.cubit,
  });

  final MainCubit cubit;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.color.mainColor,
      flexibleSpace: Image.asset(AppImages.bG, fit: BoxFit.cover,),
      elevation: 0,
      automaticallyImplyLeading: false, 
      title: Padding(
        padding: EdgeInsets.only(bottom: 8.h),
        child: const SearchItemAppBar(),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: IconButton(
            icon: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: ColorsLight.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.close, color: ColorsLight.white),
                  ),
            onPressed: () {
              cubit.toggleSearch(); 
            },
          ),
        ),
        SizedBox(width: 8.w),
      ],
    );
  }
}